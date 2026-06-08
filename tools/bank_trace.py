#!/usr/bin/env python3
"""Poll bank-selection state during solo MIDI Maze execution.

This complements solo_trace.py by focusing on L008C and bank-call table slots.
It is intended to prove which banks are selected during boot/menu/solo/live
scenarios before treating fill banks as FujiNet code-space candidates.
"""

from __future__ import annotations

import argparse
import json
import subprocess
import sys
from pathlib import Path
from typing import Any

from solo_trace import (
    ADDR,
    AtariAI,
    DEFAULT_ROM,
    DEFAULT_SOCKET,
    launch_emulator,
    navigate_solo,
    wait_for_socket,
)


ROOT = Path(__file__).resolve().parents[1]
CANDIDATE_BANKS = {0x03, 0x07}


def read_bank_state(ai: AtariAI, frame: int, phase: str) -> dict[str, Any]:
    slot_addr_lo = ai.peek(ADDR["bank_call_addr_lo"], 0x25)
    slot_addr_hi = ai.peek(ADDR["bank_call_addr_hi"], 0x25)
    slot_bank = ai.peek(ADDR["bank_call_bank_id"], 0x25)
    return {
        "frame": frame,
        "phase": phase,
        "current_bank_l008c": ai.peek(0x008C)[0],
        "net_error_code": ai.peek(ADDR["net_error_code"])[0],
        "l3eb9": ai.peek(ADDR["l3eb9"])[0],
        "player_input0": ai.peek(ADDR["player_input_status"])[0],
        "hot_slots": {
            f"{i:02X}": {
                "addr": (slot_addr_hi[i] << 8) | slot_addr_lo[i],
                "bank": slot_bank[i],
            }
            for i in (0x03, 0x10, 0x11, 0x13, 0x1B, 0x1C, 0x22, 0x24)
        },
    }


def record_if_changed(
    rows: list[dict[str, Any]], state: dict[str, Any], last: dict[str, Any] | None
) -> dict[str, Any]:
    comparable = {
        "current_bank_l008c": state["current_bank_l008c"],
        "net_error_code": state["net_error_code"],
        "l3eb9": state["l3eb9"],
        "hot_slots": state["hot_slots"],
    }
    if last != comparable:
        rows.append(state)
    return comparable


def run_phase(
    ai: AtariAI,
    rows: list[dict[str, Any]],
    phase: str,
    frames: int,
    direction: str = "center",
    fire: bool = False,
    start_frame: int = 0,
    last: dict[str, Any] | None = None,
) -> tuple[int, dict[str, Any] | None]:
    frame = start_frame
    for _ in range(frames):
        ai.joystick(direction, fire)
        ai.run_frames(1)
        state = read_bank_state(ai, frame, phase)
        last = record_if_changed(rows, state, last)
        frame += 1
    return frame, last


def summarize(rows: list[dict[str, Any]]) -> dict[str, Any]:
    current_banks = sorted({row["current_bank_l008c"] for row in rows})
    slot_banks: dict[str, list[int]] = {}
    for row in rows:
        for slot, info in row["hot_slots"].items():
            slot_banks.setdefault(slot, [])
            slot_banks[slot].append(info["bank"])
    slot_banks = {slot: sorted(set(vals)) for slot, vals in slot_banks.items()}

    candidate_hits = []
    for row in rows:
        if row["current_bank_l008c"] in CANDIDATE_BANKS:
            candidate_hits.append(
                {
                    "frame": row["frame"],
                    "phase": row["phase"],
                    "kind": "current_bank_l008c",
                    "bank": row["current_bank_l008c"],
                }
            )
        for slot, info in row["hot_slots"].items():
            if info["bank"] in CANDIDATE_BANKS:
                candidate_hits.append(
                    {
                        "frame": row["frame"],
                        "phase": row["phase"],
                        "kind": f"slot_{slot}",
                        "bank": info["bank"],
                        "addr": info["addr"],
                    }
                )

    return {
        "transition_count": len(rows),
        "current_banks_seen": current_banks,
        "hot_slot_banks_seen": slot_banks,
        "candidate_hits": candidate_hits,
    }


def build_arg_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--rom", type=Path, default=DEFAULT_ROM)
    parser.add_argument("--socket", default=DEFAULT_SOCKET)
    parser.add_argument("--launch", action="store_true")
    parser.add_argument("--emulator", default="atari800-ai")
    parser.add_argument("--dummy-video", action=argparse.BooleanOptionalAction, default=True)
    parser.add_argument("--quiet-emulator", action=argparse.BooleanOptionalAction, default=True)
    parser.add_argument("--no-navigate", action="store_true")
    parser.add_argument("--boot-frames", type=int, default=180)
    parser.add_argument("--fire-frames", type=int, default=10)
    parser.add_argument("--menu-settle-frames", type=int, default=90)
    parser.add_argument("--live-settle-frames", type=int, default=180)
    parser.add_argument("--menu-frames", type=int, default=120)
    parser.add_argument("--live-idle-frames", type=int, default=240)
    parser.add_argument("--live-up-frames", type=int, default=180)
    parser.add_argument("--live-fire-frames", type=int, default=120)
    parser.add_argument(
        "--out",
        type=Path,
        default=ROOT / "build" / "bank_trace_solo.json",
        help="JSON output path",
    )
    return parser


def main(argv: list[str]) -> int:
    args = build_arg_parser().parse_args(argv)
    proc: subprocess.Popen[str] | None = None
    rows: list[dict[str, Any]] = []
    last: dict[str, Any] | None = None
    frame = 0

    if args.launch:
        if not args.rom.exists():
            print(f"ROM not found: {args.rom}", file=sys.stderr)
            return 2
        proc = launch_emulator(args)

    ai = AtariAI(args.socket)
    try:
        wait_for_socket(ai, 10.0)
        frame, last = run_phase(
            ai, rows, "boot_menu", args.boot_frames, start_frame=frame, last=last
        )
        if not args.no_navigate:
            navigate_solo(ai, args)
            rows.append(read_bank_state(ai, frame, "after_solo_play_navigation"))
            last = None
            frame += 1
        frame, last = run_phase(
            ai, rows, "live_idle", args.live_idle_frames, start_frame=frame, last=last
        )
        frame, last = run_phase(
            ai,
            rows,
            "live_up",
            args.live_up_frames,
            direction="up",
            start_frame=frame,
            last=last,
        )
        frame, last = run_phase(
            ai,
            rows,
            "live_fire",
            args.live_fire_frames,
            fire=True,
            start_frame=frame,
            last=last,
        )
        ai.joystick("center", False)

        result = {
            "rom": str(args.rom),
            "socket": args.socket,
            "candidate_banks": sorted(CANDIDATE_BANKS),
            "summary": summarize(rows),
            "transitions": rows,
        }
        args.out.parent.mkdir(parents=True, exist_ok=True)
        args.out.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")

        summary = result["summary"]
        print(f"wrote {args.out}")
        print(f"transitions={summary['transition_count']}")
        print(f"current_banks_seen={summary['current_banks_seen']}")
        print(f"candidate_hits={len(summary['candidate_hits'])}")
        return 0
    finally:
        if proc is not None:
            proc.terminate()
            try:
                proc.wait(timeout=3)
            except subprocess.TimeoutExpired:
                proc.kill()
                proc.wait(timeout=3)


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
