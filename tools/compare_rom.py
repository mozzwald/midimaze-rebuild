#!/usr/bin/env python3
"""Compare a rebuilt MIDI Maze ROM or bank against the original image."""

from __future__ import annotations

import argparse
import hashlib
import re
from pathlib import Path


BANK_SIZE = 0x2000
DEFAULT_ORIGINAL = Path("ref/MIDI Maze-Original.rom")
DEFAULT_LISTINGS = Path("build")
DEFAULT_BANK_SOURCE_DIR = Path("src/banks")
OPCODES = {
    "ADC",
    "AND",
    "ASL",
    "BCC",
    "BCS",
    "BEQ",
    "BIT",
    "BMI",
    "BNE",
    "BPL",
    "BRK",
    "BVC",
    "BVS",
    "CLC",
    "CLD",
    "CLI",
    "CLV",
    "CMP",
    "CPX",
    "CPY",
    "DEC",
    "DEX",
    "DEY",
    "EOR",
    "INC",
    "INX",
    "INY",
    "JMP",
    "JSR",
    "LDA",
    "LDX",
    "LDY",
    "LSR",
    "NOP",
    "ORA",
    "PHA",
    "PHP",
    "PLA",
    "PLP",
    "ROL",
    "ROR",
    "RTI",
    "RTS",
    "SBC",
    "SEC",
    "SED",
    "SEI",
    "STA",
    "STX",
    "STY",
    "TAX",
    "TAY",
    "TSX",
    "TXA",
    "TXS",
    "TYA",
}
LISTING_LINE_RE = re.compile(
    r"^\s*(?P<source_line>\d+)\s+(?P<addr>[0-9A-F]{4})\s+"
    r"(?P<bytes>(?:[0-9A-F]{2}\s*){1,3})(?P<text>.*)$"
)


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


def label_from_listing_text(text: str) -> str | None:
    stripped = text.strip()
    if not stripped or stripped.startswith(";") or stripped.startswith("."):
        return None

    token = stripped.split()[0].rstrip(":")
    if token.upper() in OPCODES:
        return None
    if not re.match(r"^[A-Za-z_][A-Za-z0-9_]*$", token):
        return None
    return token


def listing_context(listings_dir: Path, source_dir: Path, bank: int, cpu_addr: int) -> str | None:
    listing = listings_dir / f"bank{bank:02d}.lst"
    if not listing.exists():
        return None

    nearest: tuple[int, int, str] | None = None
    nearest_label: tuple[int, str] | None = None

    for line in listing.read_text(errors="replace").splitlines():
        match = LISTING_LINE_RE.match(line)
        if not match:
            continue

        addr = int(match.group("addr"), 16)
        if addr > cpu_addr:
            break

        source_line = int(match.group("source_line"))
        text = match.group("text").strip()
        nearest = (addr, source_line, text)

        label = label_from_listing_text(match.group("text"))
        if label is not None:
            nearest_label = (addr, label)

    if nearest is None:
        return None

    addr, source_line, text = nearest
    context = f"{source_dir / f'bank{bank:02d}.asm'}:{source_line}, listing CPU ${addr:04X}"
    if nearest_label is not None:
        label_addr, label = nearest_label
        context += f", nearest label {label} (${label_addr:04X})"
    if text:
        context += f" | {text}"
    return context


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
    parser.add_argument(
        "--listings",
        type=Path,
        default=DEFAULT_LISTINGS,
        help=(
            "directory containing MADS bankXX.lst files for source context, "
            f"default: {DEFAULT_LISTINGS}"
        ),
    )
    parser.add_argument(
        "--source-dir",
        type=Path,
        default=DEFAULT_BANK_SOURCE_DIR,
        help=f"bank source directory for listing context, default: {DEFAULT_BANK_SOURCE_DIR}",
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
    print(f"SHA256:   actual   {hashlib.sha256(actual).hexdigest()}")
    print(f"SHA256:   expected {hashlib.sha256(expected).hexdigest()}")

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

    diff_bank = first_diff // BANK_SIZE
    bank_offset = first_diff % BANK_SIZE
    source_context = listing_context(
        args.listings,
        args.source_dir,
        diff_bank,
        mapped_addr(diff_bank, bank_offset),
    )
    if source_context is not None:
        print(f"Source:   {source_context}")
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
