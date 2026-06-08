#!/usr/bin/env python3
"""Repeatable Atari800 AI solo trace for MIDI Maze.

The script can either connect to an already-running atari800-ai instance or
launch one with -nosound. It navigates the default SOLO -> PLAY path, samples
key gameplay RAM once per emulated frame, and writes a JSON trace summary.
"""

from __future__ import annotations

import argparse
import json
import os
import socket
import subprocess
import sys
import time
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_ROM = ROOT / "build" / "midimaze.rom"
DEFAULT_SOCKET = "/tmp/atari800_ai.sock"

ADDR = {
    "local_player_index": 0x3968,
    "human_player_count": 0x396B,
    "total_player_count": 0x396E,
    "maze_size_index": 0x396F,
    "player_x_lo": 0x39B2,
    "player_x_hi": 0x39D2,
    "player_y_lo": 0x39F2,
    "player_y_hi": 0x3A12,
    "player_facing": 0x3A32,
    "player_fire_timer": 0x3BAF,
    "projectile_x_lo": 0x3BCE,
    "projectile_y_lo": 0x3C0E,
    "projectile_active_timer": 0x3C2E,
    "l2b00": 0x2B00,
    "player_state": 0x3A72,
    "player_input_status": 0x3D29,
    "bank_call_addr_lo": 0x3D3E,
    "bank_call_addr_hi": 0x3D66,
    "bank_call_bank_id": 0x3D8E,
    "l3eb9": 0x3EB9,
    "l3ecb": 0x3ECB,
    "l3ecc": 0x3ECC,
    "net_error_code": 0x3ED2,
    "net_vector_0_lo": 0x3ED3,
    "pending_net_command": 0x3EE7,
    "outgoing_net_command": 0x3EE8,
}


class AtariAI:
    def __init__(self, sock_path: str) -> None:
        self.sock_path = sock_path

    def send(self, msg: dict[str, Any], timeout: float = 2.0) -> dict[str, Any]:
        data = json.dumps(msg).encode("utf-8")
        with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
            sock.settimeout(timeout)
            sock.connect(self.sock_path)
            sock.sendall(str(len(data)).encode("ascii") + b"\n" + data)

            header = b""
            while not header.endswith(b"\n"):
                chunk = sock.recv(1)
                if not chunk:
                    raise RuntimeError("socket closed before response header")
                header += chunk
            size = int(header.strip())

            body = b""
            while len(body) < size:
                chunk = sock.recv(size - len(body))
                if not chunk:
                    raise RuntimeError("socket closed before response body")
                body += chunk

        return json.loads(body.decode("utf-8"))

    def run_frames(self, count: int) -> None:
        for _ in range(count):
            self.send({"cmd": "run", "frames": 1})

    def peek(self, addr: int, length: int = 1) -> list[int]:
        resp = self.send({"cmd": "peek", "addr": addr, "len": length})
        data = resp.get("data")
        if not isinstance(data, list):
            raise RuntimeError(f"unexpected peek response at ${addr:04X}: {resp}")
        return [int(x) & 0xFF for x in data]

    def joystick(self, direction: str = "center", fire: bool = False) -> None:
        self.send(
            {"cmd": "joystick", "port": 0, "direction": direction, "fire": fire}
        )


def launch_emulator(args: argparse.Namespace) -> subprocess.Popen[str]:
    env = os.environ.copy()
    if args.dummy_video:
        env.setdefault("SDL_VIDEODRIVER", "dummy")

    cmd = [
        args.emulator,
        "-ai",
        "-xl",
        "-ntsc",
        "-nosound",
        "-cart-type",
        "14",
        "-cart",
        str(args.rom),
    ]
    return subprocess.Popen(
        cmd,
        cwd=str(ROOT),
        env=env,
        text=True,
        stdout=subprocess.DEVNULL if args.quiet_emulator else None,
        stderr=subprocess.DEVNULL if args.quiet_emulator else None,
    )


def wait_for_socket(ai: AtariAI, timeout: float) -> None:
    deadline = time.time() + timeout
    last_error: Exception | None = None
    while time.time() < deadline:
        try:
            resp = ai.send({"cmd": "ping"}, timeout=0.5)
            if resp.get("status") == "ok":
                return
        except Exception as exc:  # socket may not exist while emulator boots
            last_error = exc
            time.sleep(0.1)
    raise RuntimeError(f"AI socket did not respond: {last_error}")


def press_fire(ai: AtariAI, frames: int = 10, settle: int = 30) -> None:
    ai.joystick("center", True)
    ai.run_frames(frames)
    ai.joystick("center", False)
    ai.run_frames(settle)


def navigate_solo(ai: AtariAI, args: argparse.Namespace) -> None:
    ai.run_frames(args.boot_frames)
    press_fire(ai, args.fire_frames, args.menu_settle_frames)
    press_fire(ai, args.fire_frames, args.live_settle_frames)


def sample(ai: AtariAI, frame: int, requested: str) -> dict[str, Any]:
    input_bytes = ai.peek(ADDR["player_input_status"], 4)
    l2b00 = ai.peek(ADDR["l2b00"], 4)
    net_vectors = ai.peek(ADDR["net_vector_0_lo"], 14)
    slot_addr_lo = ai.peek(ADDR["bank_call_addr_lo"], 0x25)
    slot_addr_hi = ai.peek(ADDR["bank_call_addr_hi"], 0x25)
    slot_bank = ai.peek(ADDR["bank_call_bank_id"], 0x25)
    return {
        "frame": frame,
        "requested": requested,
        "local_player_index": ai.peek(ADDR["local_player_index"])[0],
        "human_player_count": ai.peek(ADDR["human_player_count"])[0],
        "total_player_count": ai.peek(ADDR["total_player_count"])[0],
        "maze_size_index": ai.peek(ADDR["maze_size_index"])[0],
        "player_state_0": ai.peek(ADDR["player_state"])[0],
        "player_input_status": input_bytes,
        "l2b00": l2b00,
        "l3eb9": ai.peek(ADDR["l3eb9"])[0],
        "l3ecb": ai.peek(ADDR["l3ecb"])[0],
        "l3ecc": ai.peek(ADDR["l3ecc"])[0],
        "net_error_code": ai.peek(ADDR["net_error_code"])[0],
        "pending_net_command": ai.peek(ADDR["pending_net_command"])[0],
        "outgoing_net_command": ai.peek(ADDR["outgoing_net_command"])[0],
        "player_x": [
            ai.peek(ADDR["player_x_hi"])[0],
            ai.peek(ADDR["player_x_lo"])[0],
        ],
        "player_y": [
            ai.peek(ADDR["player_y_hi"])[0],
            ai.peek(ADDR["player_y_lo"])[0],
        ],
        "player_facing": ai.peek(ADDR["player_facing"])[0],
        "player_fire_timer": ai.peek(ADDR["player_fire_timer"])[0],
        "projectile": {
            "x_lo": ai.peek(ADDR["projectile_x_lo"])[0],
            "y_lo": ai.peek(ADDR["projectile_y_lo"])[0],
            "active_timer": ai.peek(ADDR["projectile_active_timer"])[0],
        },
        "net_vectors": [
            (net_vectors[i + 1] << 8) | net_vectors[i] for i in range(0, 14, 2)
        ],
        "bank_call_slots": {
            f"{i:02X}": {
                "addr": (slot_addr_hi[i] << 8) | slot_addr_lo[i],
                "bank": slot_bank[i],
            }
            for i in (0x03, 0x10, 0x11, 0x13, 0x22, 0x24)
        },
    }


def collect_window(
    ai: AtariAI, name: str, frames: int, pattern: list[tuple[str, bool]]
) -> list[dict[str, Any]]:
    rows: list[dict[str, Any]] = []
    for frame in range(frames):
        direction, fire = pattern[frame % len(pattern)]
        ai.joystick(direction, fire)
        ai.run_frames(1)
        requested = direction + ("+fire" if fire else "")
        rows.append(sample(ai, frame, requested))
    ai.joystick("center", False)
    ai.run_frames(20)
    return rows


def changes(rows: list[dict[str, Any]], key: str) -> list[int]:
    result: list[int] = []
    prev: Any = rows[0][key] if rows else None
    for row in rows[1:]:
        if row[key] != prev:
            result.append(row["frame"])
            prev = row[key]
    return result


def summarize_window(rows: list[dict[str, Any]]) -> dict[str, Any]:
    if not rows:
        return {}
    nonsteady = [
        r["frame"]
        for r in rows
        if (r["l3eb9"], r["l3ecb"], r["l3ecc"], r["net_error_code"])
        != (0, 1, 0, 0)
    ]
    return {
        "start": rows[0],
        "end": rows[-1],
        "nonsteady_slot13_frames": nonsteady[:40],
        "nonsteady_slot13_count": len(nonsteady),
        "input0_change_frames": changes(
            [{"frame": r["frame"], "input0": r["player_input_status"][0]} for r in rows],
            "input0",
        ),
        "x_change_frames": changes(
            [{"frame": r["frame"], "x": r["player_x"]} for r in rows], "x"
        ),
        "y_change_frames": changes(
            [{"frame": r["frame"], "y": r["player_y"]} for r in rows], "y"
        ),
        "facing_change_frames": changes(
            [{"frame": r["frame"], "facing": r["player_facing"]} for r in rows],
            "facing",
        ),
        "fire_timer_change_frames": changes(
            [
                {"frame": r["frame"], "fire_timer": r["player_fire_timer"]}
                for r in rows
            ],
            "fire_timer",
        ),
        "projectile_timer_change_frames": changes(
            [
                {
                    "frame": r["frame"],
                    "projectile_timer": r["projectile"]["active_timer"],
                }
                for r in rows
            ],
            "projectile_timer",
        ),
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
    parser.add_argument("--idle-frames", type=int, default=300)
    parser.add_argument("--move-frames", type=int, default=300)
    parser.add_argument("--turn-frames", type=int, default=180)
    parser.add_argument("--fire-window-frames", type=int, default=180)
    parser.add_argument("--alternate-frames", type=int, default=120)
    parser.add_argument(
        "--out",
        type=Path,
        default=ROOT / "build" / "solo_trace.json",
        help="JSON output path",
    )
    return parser


def main(argv: list[str]) -> int:
    args = build_arg_parser().parse_args(argv)
    proc: subprocess.Popen[str] | None = None

    if args.launch:
        if not args.rom.exists():
            print(f"ROM not found: {args.rom}", file=sys.stderr)
            return 2
        proc = launch_emulator(args)

    ai = AtariAI(args.socket)
    try:
        wait_for_socket(ai, 10.0)
        if not args.no_navigate:
            navigate_solo(ai, args)

        windows = {
            "idle": collect_window(ai, "idle", args.idle_frames, [("center", False)]),
            "held_up": collect_window(ai, "held_up", args.move_frames, [("up", False)]),
            "held_right": collect_window(
                ai, "held_right", args.turn_frames, [("right", False)]
            ),
            "held_fire": collect_window(
                ai, "held_fire", args.fire_window_frames, [("center", True)]
            ),
            "alternate_up_center": collect_window(
                ai,
                "alternate_up_center",
                args.alternate_frames,
                [("up", False), ("center", False)],
            ),
        }

        result = {
            "rom": str(args.rom),
            "socket": args.socket,
            "windows": {name: summarize_window(rows) for name, rows in windows.items()},
        }
        args.out.parent.mkdir(parents=True, exist_ok=True)
        args.out.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")

        print(f"wrote {args.out}")
        for name, summary in result["windows"].items():
            print(
                f"{name}: nonsteady={summary['nonsteady_slot13_count']} "
                f"input_changes={summary['input0_change_frames'][:8]}"
            )
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
