# Symbol Notes

This file records names that are stable enough to use while keeping the
byte-exact rebuild as the source of truth.

## Shared Includes

- `include/atari_os.inc`: Atari OS zero-page variables, vectors, shadow
  registers, IOCB fields, and OS entry points.
- `include/hardware.inc`: GTIA, POKEY, PIA, and ANTIC hardware registers.
- `include/cartridge.inc`: cartridge control addresses.
- `include/game_ram.inc`: confirmed game-private RAM structures used across
  banks.

These include symbols are intended to be reused across banks. Game-private
`Lxxxx` labels remain local until their role is proven by cross-references or
emulator traces.

## Cartridge Banking

- `CART_BANK_SELECT = $D500`: cartridge control region used to select banks.
- `BANK_CALL_INDEXED = $AF1D`: fixed-bank trampoline. `X` indexes tables at
  `BANK_CALL_ADDR_LO`, `BANK_CALL_ADDR_HI`, and `BANK_CALL_BANK_ID`; the
  current bank is saved in `L008C`, then `CART_BANK_SELECT` is updated and
  execution jumps indirectly.
- `BANK_RETURN = $AF36`: common return path for banked routines. Restores the
  saved bank before returning to the caller.
- `BANK_CALL_ADDR_LO = $3D3E`, `BANK_CALL_ADDR_HI = $3D66`,
  `BANK_CALL_BANK_ID = $3D8E`: bank-call target and bank tables.

## MIDI/POKEY Serial Path

These labels are in fixed bank 15.

- `MIDI_RX_ISR = $BE9D`: serial input interrupt handler. Reads `SERIN` into
  the receive ring at `MIDI_RX_BUFFER`.
- `MIDI_TX_ISR = $BEAD`: serial output interrupt handler. Writes queued bytes
  from `MIDI_TX_BUFFER` to `SEROUT`.
- `MIDI_SEND_BYTE = $BEC7`: sends one byte immediately if TX is idle, otherwise
  queues it.
- `MIDI_READ_BYTE_BLOCKING = $BEE9`: waits for a received byte and returns it.
- `MIDI_RX_COUNT = $BEF7`: returns receive ring occupancy using natural 8-bit
  wraparound.
- `MIDI_INSTALL = $BEFD`: installs custom serial vectors and programs POKEY for
  direct serial I/O.
- `MIDI_REMOVE = $BF6D`: restores saved serial vectors and disables the custom
  serial interrupt path.
- `MIDI_RX_BUFFER = $2D00`, `MIDI_TX_BUFFER = $2E00`: serial ring buffers.

Observed zero-page usage in this path:

- `L0082`: RX write index into `MIDI_RX_BUFFER`.
- `L0083`: RX read index from `MIDI_RX_BUFFER`.
- `L0084`: TX read index from `MIDI_TX_BUFFER`.
- `L0085`: TX write index into `MIDI_TX_BUFFER`.
- `L0086`: TX active flag.

These `L00xx` names are still left as generated labels in source because they
may be reused as scratch storage outside the MIDI path.

## Raw Bytes

Undocumented opcode forms that MADS warned about, or that are safer as data for
now, are emitted as `.byte` with the original disassembly in the comment. Do
not convert them back to instructions unless `make compare` remains exact and
the region has been proven executable.
