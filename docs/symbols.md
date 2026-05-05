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

## Bank-Call Slot Table

`BANK_CALL_INDEXED` uses `X` as a slot index. The fixed bank initializes 37
packed entries at `LB03F` in `src/banks/bank15.asm`; each entry is:

```text
bank select byte, target low byte, target high byte
```

At call time the selected bank byte is written to `CART_BANK_SELECT`, then the
trampoline jumps through the target address. Targets in `$A000-$BFFF` remain in
the fixed bank; targets in `$8000-$9FFF` execute in the selected switchable
bank. Rows marked with an unlabeled address are byte-accurate but still need
semantic naming.

| Slot | Initial bank select | Initial target | Initial source target | Observed call sites |
|---:|---:|---:|---|---|
| `$00` | `$00` | `$B511` | `FIXED_DRAW_FIELD_7380_FILL_ENTRY` | `bank14:L8015` |
| `$01` | `$00` | `$B579` | `FIXED_FRAME_DISPLAY_SERVICE_ENTRY` | `bank14:L8061`, `bank14:L9D91`, `bank14:L9D9E`, `bank15:LB3A6` |
| `$02` | `$0D` | `$8000` | `BANK13_PLAYER_PLACEMENT_SETUP_ENTRY` | - |
| `$03` | `$0D` | `$8185` | `BANK13_PLAYER_MAZE_UPDATE_ENTRY` | - |
| `$04` | `$0E` | `$8000` | `BANK14_DRAW_STATE_CLEAR_ENTRY` | `bank12:L888B`, `bank12:L8C94`, `bank12:L9857` |
| `$05` | `$0E` | `$8011` | `BANK14_DISPLAY_SCRATCH_CLEAR_ENTRY` | - |
| `$06` | `$0E` | `$81FB` | `BANK14_SLOT06_DRAW_SERVICE_ENTRY` | - |
| `$07` | `$0E` | `$9C00` | `BANK14_SLOT07_STATUS_CLEAR_ENTRY` | - |
| `$08` | `$0D` | `$9090` | `BANK13_LOCAL_STATUS_GLYPH_UPDATE_ENTRY` | `bank13:L81D0`, `bank13:L87D4` |
| `$09` | `$0E` | `$9C9B` | `BANK14_SLOT09_STATUS_CLEAR_ENTRY` | - |
| `$0A` | `$0D` | `$8E00` | `BANK13_STATUS_TEMPLATE_COPY_ENTRY` | `bank15:LB3A6` |
| `$0B` | `$0D` | `$9900` | `BANK13_SLOT0B_STATUS_CLEAR_ENTRY` | - |
| `$0C` | `$0D` | `$8E96` | `BANK13_STATUS_TEMPLATE_REFRESH_ENTRY` | `bank12:L8180`, `bank12:L880C`, `bank12:L8B81` |
| `$0D` | `$0D` | `$8EC0` | `BANK13_ROSTER_STATUS_SERVICE_ENTRY` | frequent setup polling paths |
| `$0E` | `$0D` | `$91F6` | `BANK13_SLOT0E_STATUS_SERVICE_ENTRY` | - |
| `$0F` | `$0D` | `$9115` | `BANK13_SLOT0F_DISPLAY_UPDATE_ENTRY` | `bank12:L9EA0` |
| `$10` | `$0D` | `$8900` | `BANK13_SETUP_PLACEMENT_DISPATCH_ENTRY` | `bank12:L888B`, `bank12:L8C94`, `bank12:L9857` |
| `$11` | `$0C` | `$0000` | volatile slot patched before use | patched by bank 12 |
| `$12` | `$0C` | `$8000` | `BANK12_BOOT_MENU_ENTRY` | `bank15:CART_STRT` |
| `$13` | `$04` | `$8000` | `BANK4_NET_COMMAND_SERVICE_ENTRY` | frequent net command send/service paths |
| `$14` | `$04` | `$8003` | `BANK4_SLOT14_SERVICE_ENTRY` | `bank12:L879E`, `bank12:L94FC` |
| `$15` | `$04` | `$8006` | `BANK4_SLOT15_SERVICE_ENTRY` | `bank12:L81B5` |
| `$16` | `$04` | `$8009` | `BANK4_SLOT16_SERVICE_ENTRY` | `bank12:L87EE` |
| `$17` | `$04` | `$800C` | `BANK4_SLOT17_SERVICE_ENTRY` | `bank12:L9430` |
| `$18` | `$04` | `$800F` | `BANK4_SLOT18_SERVICE_ENTRY` | `bank12:L8392` |
| `$19` | `$04` | `$8012` | `BANK4_SLOT19_SERVICE_ENTRY` | `bank12:L8989`, `bank12:L94BF` |
| `$1A` | `$04` | `$8015` | `BANK4_SLOT1A_SERVICE_ENTRY` | `bank12:L8F57` |
| `$1B` | `$04` | `$8018` | `BANK4_NET_STATE_RESET_ENTRY` | `bank12:L93F8`, `bank12:L9504` |
| `$1C` | `$04` | `$801B` | `BANK4_SLOT1C_SERVICE_ENTRY` | setup/resync branch paths in bank 12 |
| `$1D` | `$04` | `$801E` | `BANK4_SLOT1D_SERVICE_ENTRY` | `bank12:L8998`, `bank12:L94D3` |
| `$1E` | `$04` | `$8021` | `BANK4_SLOT1E_SERVICE_ENTRY` | `bank12:L953F` |
| `$1F` | `$04` | `$8024` | `BANK4_SLOT1F_SERVICE_ENTRY` | `bank12:L83B2`, `bank12:L83C3` |
| `$20` | `$05` | `$8000` | bank 5 `$8000` | `bank12:L81E2`, `bank12:L829E` |
| `$21` | `$02` | `$8000` | bank 2 `$8000` | setup/roster finalization paths in bank 12 |
| `$22` | `$00` | `$8000` | bank 0 `$8000` | `bank12:L9A2D` |
| `$23` | `$06` | `$8000` | bank 6 `$8000` | - |
| `$24` | `$04` | `$8027` | `BANK4_SLOT24_SERVICE_ENTRY` | `bank12:L891F`, `bank12:L95F2` |

Known volatile slot patches:

- Slot `$11`: `bank12:L863D` patches this to `$9007` in the current bank
  (`BANK_CALL_BANK_ID[$11] = L008C`) for setup flow. `bank12:L93F8` and
  `bank12:L9504` patch it to `$9A15` in the current bank for gameplay/resync
  loops.
- Slot `$13`: `bank12:L863D` patches this to `BANK_RETURN` (`$AF36`).
  `bank12:L93F8` and `bank12:L9504` restore it to bank 4 `$8000`
  (`BANK4_NET_COMMAND_SERVICE_ENTRY`). `bank12:L95D0` temporarily redirects it
  between `BANK_RETURN` and bank 4 `$8000` while waiting on
  `NET_ERROR_CODE`.
- Slot `$1B`: `bank12:L863D` patches this to `BANK_RETURN`. `bank12:L93F8`
  and `bank12:L9504` restore it to bank 4 `$8018`
  (`BANK4_NET_STATE_RESET_ENTRY`) before the setup/gameplay loop calls it.

Several targets remain intentionally byte-form in source because adjacent
regions mix executable landing pads with data. Their labels document confirmed
bank-call entries without converting uncertain bytes into instructions.

Phase 1 entry notes:

- Bank 4 slots `$13-$1F` and `$24` are now explicit packed `JMP` stubs at
  `$8000-$8029`. Slot `$13` services net commands through
  `PENDING_NET_COMMAND`, `OUTGOING_NET_COMMAND`, `NET_ERROR_CODE`,
  `LOCAL_PLAYER_INDEX`, `HUMAN_PLAYER_COUNT`, and the `$2B00/$3D29`
  command/status buffers. Slot `$1B` clears the bank 4 network state around
  `$7360/$7370`, `L3EB9-L3ECE`, `PENDING_NET_COMMAND`, and
  `OUTGOING_NET_COMMAND`. The remaining bank 4 slots are named by slot until
  their command-specific roles are proven.
- Bank 13 slots `$08` and `$0A-$10` are display/status/setup services. The
  named entries cover player placement setup, status template copies, local
  status glyph updates, roster/status polling, and status clear/update landing
  pads.
- Bank 14 slots `$04-$07` and `$09` are drawing/status helpers. Slot `$04`
  clears per-player draw/update state; slots `$05-$07` and `$09` clear or
  prepare display/status scratch regions and call fixed-bank drawing helpers.
- Fixed-bank slots `$00` and `$01` are display/frame services. Slot `$00`
  fills the `$7380` field region with pattern bytes; slot `$01` continues the
  frame/display service path and returns through `BANK_RETURN`.
- Bank 12 slot `$12` is `BANK12_BOOT_MENU_ENTRY`, called by `CART_STRT` before
  `MIDI_INSTALL` so the cartridge can run boot/menu initialization before the
  custom MIDI/SIO interrupt vectors are installed.

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

## Fixed-Bank Helpers

These labels are resident in bank 15 and exported through
`include/fixed_bank.inc` for switchable banks. They replace generated helper
names from the original disassembly.

| Name | Address | Inputs and scratch | Return / flags | Notes |
|---|---:|---|---|---|
| `MIDI_RX_READ_BLOCKING` | `$AF76` | `L00B1` RX write index, `L00B2` RX read index, `$2F00` RX ring | `A` = byte read; `L00B2` increments; waits until data is present | Direct custom MIDI/POKEY ring helper. |
| `MIDI_RX_HAS_BYTE` | `$AF82` | `L00B1`, `L00B2` | Z set when empty, Z clear when unread bytes exist | Non-blocking RX poll used before `MIDI_RX_READ_BLOCKING`. |
| `NET_SERVICE_WAIT_POLL` | `$AF87` | `L00B3` clock, `L3ED0` timeout ticks, callback vectors | Clears `NET_ERROR_CODE` on timeout; otherwise preserves callback status | Polls bank-call slot `$0D` while waiting on `NET_CALL_VECTOR_2`, then calls `NET_CALL_VECTOR_0`. |
| `NET_VECTOR_WAIT_POLL` | `$AFAE` | same timeout/vector state | Sets `NET_ERROR_CODE = $C7` on timeout; returns `NET_ERROR_CODE` in `Y` after callback | Similar wait loop, but polls slot `$0D` only while vector 2 is not ready. |
| `NET_CALL_VECTOR_0`..`NET_CALL_VECTOR_6` | `$AFDA-$AFEC` | vector words at `$3ED3/$3ED5/$3ED7/$3ED9/$3EDB/$3EDD/$3EDF` | Whatever the selected callback returns | Bank 12 patches these vector words for setup/gameplay modes. |
| `WAIT_FOR_RTC_TICK` | `$AFEF` | `RTCLOK+2` | returns after `RTCLOK+2` changes | Frame pacing helper; does not touch `NET_ERROR_CODE`. |
| `PACK_DIRECTION_TO_STATUS_BITS` | `$AFF6` | `A` direction/status byte, scratch `L0080`, table `DIRECTION_STATUS_BITS_A` | `A` = input with bits 5/6 replaced from rotated direction bits | Used when packing player/status direction bytes. |
| `ROTATE_DIRECTION_TO_STATUS_BITS` | `$B00B` | `A` direction/status byte, scratch `L0080`, table `DIRECTION_STATUS_BITS_B` | `A` = input with alternate bits 5/6 encoding | Companion direction/status packing helper. |
| `PLAYER_RECORD_OFFSET_TABLE` | `$B0AE` | `X` player index at callers | table read only | Offsets into packed per-player records used by bank 4 and bank 12 roster/status paths. |
| `PLAYER_RECORD_LENGTH_TABLE` | `$B0BE` | table read only | table read only | Small size/length lookup adjacent to the offset table. |
| `CLEAR_STATUS_LINE_BUFFERS` | `$B0C7` | none | clears `$72C0-$72CF` and `$72D0-$72DF`; `A=0`, `X=$FF` | Used before writing status/error/menu message buffers. |
| `MARK_STATUS_LINE_DIRTY` | `$B0D5` | `$72C0-$72DF` | sets bit 7 across the 32-byte status line region; `X=$FF` | Marks status/message bytes for display update. |

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
