#!/usr/bin/env python3
"""Compare a rebuilt MIDI Maze ROM or bank against the original image."""

from __future__ import annotations

import argparse
from pathlib import Path


BANK_SIZE = 0x2000
DEFAULT_ORIGINAL = Path("ref/MIDI Maze-Original.rom")


def mapped_addr(bank: int, offset: int) -> int:
    base = 0xA000 if bank == 15 else 0x8000
    return base + offset


def describe_offset(offset: int) -> str:
    bank = offset // BANK_SIZE
    bank_offset = offset % BANK_SIZE
    return f"bank {bank:02d}, bank offset ${bank_offset:04X}, CPU ${mapped_addr(bank, bank_offset):04X}"


def compare_bytes(actual: bytes, expected: bytes, base_offset: int) -> tuple[int | None, int]:
    first_diff: int | None = None
    diff_count = 0
    common_len = min(len(actual), len(expected))

    for i in range(common_len):
        if actual[i] != expected[i]:
            if first_diff is None:
                first_diff = i
            diff_count += 1

    if len(actual) != len(expected):
        if first_diff is None:
            first_diff = common_len
        diff_count += abs(len(actual) - len(expected))

    if first_diff is None:
        return None, diff_count
    return base_offset + first_diff, diff_count


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("actual", type=Path, help="rebuilt ROM or bank binary")
    parser.add_argument(
        "--original",
        type=Path,
        default=DEFAULT_ORIGINAL,
        help=f"original ROM path, default: {DEFAULT_ORIGINAL}",
    )
    parser.add_argument(
        "--bank",
        type=int,
        choices=range(16),
        metavar="0-15",
        help="compare actual file against one 8 KiB bank from the original ROM",
    )
    args = parser.parse_args()

    actual = args.actual.read_bytes()
    original = args.original.read_bytes()

    if args.bank is None:
        expected = original
        base_offset = 0
        expected_desc = "full ROM"
    else:
        base_offset = args.bank * BANK_SIZE
        expected = original[base_offset : base_offset + BANK_SIZE]
        expected_desc = f"bank {args.bank:02d}"

    first_diff, diff_count = compare_bytes(actual, expected, base_offset)

    print(f"Actual:   {args.actual} ({len(actual)} bytes)")
    print(f"Expected: {args.original} {expected_desc} ({len(expected)} bytes)")

    if first_diff is None:
        print("Result:   exact match")
        return 0

    actual_index = first_diff - base_offset
    actual_byte = actual[actual_index] if actual_index < len(actual) else None
    expected_byte = expected[actual_index] if actual_index < len(expected) else None
    actual_text = "--" if actual_byte is None else f"${actual_byte:02X}"
    expected_text = "--" if expected_byte is None else f"${expected_byte:02X}"

    print("Result:   differs")
    print(f"First:    file offset ${first_diff:05X} ({describe_offset(first_diff)})")
    print(f"Bytes:    actual {actual_text}, expected {expected_text}")
    print(f"Count:    {diff_count} differing byte positions, including size delta")
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
