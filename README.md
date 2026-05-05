# MIDI Maze Source Rebuild

This repository rebuilds the Atari 8-bit MIDI Maze cartridge ROM from a
banked 6502 disassembly. The current priority is byte-exact reproducibility:
readability improvements are welcome only when `make compare` still matches the
original ROM.

## Current Status

- The ROM builds with MADS.
- `build/midimaze.rom` compares byte-exact against
  `ref/MIDI Maze-Original.rom`.
- The full original all-banks disassembly is preserved for reference at
  `ref/MIDI_Maze_disassembly_all_banks.asm`.
- Split bank sources are the active rebuild source.

Expected full-ROM SHA-256:

```text
a774ed5004e074cc8c5a62a7f4cf17b9952e221a39bafb75282c9b7540351ff8
```

## Requirements

- `mads` in `PATH`
- `python3`
- Optional: `atari800-ai` for emulator runs

## Common Commands

```sh
make clean
make
make compare
make listing
make run
```

Useful targets:

- `make`: assembles all 16 banks and concatenates `build/midimaze.rom`.
- `make compare`: compares the rebuilt ROM to the original, prints sizes,
  SHA-256 values, first differing byte, and listing/source context when
  listings exist.
- `make compare-bankNN`: compares one generated 8KB bank, for example
  `make compare-bank15`.
- `make listing`: emits MADS listings as `build/bankNN.lst`.
- `make run`: starts `atari800-ai` with the rebuilt ROM.

Generated files live under `build/` and are ignored by git.

## Source Layout

- `src/banks/bank00.asm` through `src/banks/bank14.asm`: switchable 8KB banks mapped at
  `$8000-$9FFF`.
- `src/banks/bank15.asm`: fixed 8KB bank mapped at `$A000-$BFFF`.
- `include/atari_os.inc`: Atari OS variables, vectors, shadows, IOCB fields,
  and entry points.
- `include/hardware.inc`: GTIA, POKEY, PIA, and ANTIC register names.
- `include/cartridge.inc`: cartridge control symbols.
- `include/game_ram.inc`: confirmed game-private RAM structures.
- `include/fixed_bank.inc`: resident fixed-bank service entry points used by
  switchable banks.
- `tools/compare_rom.py`: byte comparison helper with bank/address mapping.
- `docs/symbols.md`: notes for confirmed names and provisional labels.
- `ref/`: original ROM, frozen full disassembly, and hardware/reference notes.

## Readability Rules

Keep changes mechanical and byte-verifiable.

- Run `make compare` after each source cleanup.
- Leave generated `Lxxxx` labels alone until their role is proven.
- Prefer comments before renames.
- Keep ambiguous code/data regions as `.byte`.
- Preserve undocumented opcode bytes as `.byte` unless execution and exact
  output are proven.
- Do not move code or data across bank boundaries.

## Known Fixed-Bank Services

Some labels in `src/banks/bank15.asm` have been named because their role is clear:

- `BANK_CALL_INDEXED`: fixed-bank trampoline for calling routines in selected
  switchable banks.
- `BANK_RETURN`: common return path that restores the previous bank.
- `MIDI_INSTALL`, `MIDI_REMOVE`: install/remove custom MIDI/POKEY serial hooks.
- `MIDI_RX_ISR`, `MIDI_TX_ISR`: serial receive/transmit interrupt handlers.
- `MIDI_SEND_BYTE`, `MIDI_READ_BYTE_BLOCKING`, `MIDI_RX_COUNT`: MIDI ring-buffer
  helpers.

See `docs/symbols.md` for current symbol notes.
