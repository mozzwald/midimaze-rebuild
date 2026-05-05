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
- `include/fixed_bank.inc`: resident fixed-bank service entry points called
  from switchable banks.

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

## Network Setup And Gameplay Protocol

These names are based on the reverse-engineering notes in `ref/` and matched
against bank 12 control flow. The protocol uses raw serial bytes carried by the
bank 15 MIDI/POKEY transport.

- `LOCAL_PLAYER_INDEX = $3968`: local station/player index. Player 0 appears
  to drive master transmit paths.
- `PRNG_SEED_LOW = $3969`, `PRNG_SEED_HIGH = $396A`: shared random seed bytes.
- `HUMAN_PLAYER_COUNT = $396B`, `TOTAL_PLAYER_COUNT = $396E`: human count and
  final human+bot roster count after clamping.
- `MAZE_SIZE_INDEX = $396F`: selects maze-size-dependent player limit.
- `BOT_COUNT_TARGET = $3EED`, `BOT_COUNT_DRONE = $3EEE`,
  `BOT_COUNT_NINJA = $3EEF`, `BOT_COUNT_NASTY = $3F13`: setup bot counts.
  Nasty and Ninja are packed into one byte on the wire during resync.
- `NET_ERROR_CODE = $3ED2`: status/error code consumed by
  `PRINT_STATUS_MESSAGE`.
- `PENDING_NET_COMMAND = $3EE7`: extended command byte received from the ring.
- `OUTGOING_NET_COMMAND = $3EE8`: extended command byte to inject into the
  ring.

Named bank 12 protocol routines:

- `MASTER_SEND_SETUP_PAYLOAD`: sends marker `$83` and setup payload as the
  master/resync transmitter.
- `SLAVE_RECEIVE_SETUP_PAYLOAD`: waits for marker `$83` and receives setup
  payload as a slave/resync receiver.
- `NET_COMMAND_DISPATCH`: handles confirmed extended commands `$81`, `$82`,
  `$84`, and `$86`.
- `RESYNC_COMMAND`, `RESYNC_MASTER_TX`, `RESYNC_SLAVE_RX`: command `$84`
  resynchronization paths.
- `GAMEPLAY_PARAM_RELAY`: relays the 7-byte per-player gameplay parameter
  block before live play.
- `SETUP_CHECKSUM_EXCHANGE`: ring-wide setup checksum exchange; after three
  failures it reports "Can't sync".

## Raw Bytes

Undocumented opcode forms that MADS warned about, or that are safer as data for
now, are emitted as `.byte` with the original disassembly in the comment. Do
not convert them back to instructions unless `make compare` remains exact and
the region has been proven executable.
