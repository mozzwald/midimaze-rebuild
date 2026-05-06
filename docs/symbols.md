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

## Maze Buffer

The final maze buffer is in RAM at `$3000-$37FF`.

| Name | Address/value | Role |
|---|---:|---|
| `MAZE_CELL_WALL_BASE` | `$3000` | Base of the wall/cell byte plane. Fixed-bank cell helpers address cells as base + row*$40 + column. |
| `MAZE_CELL_OCCUPANCY_OFFSET` | `$20` | Offset from a wall byte to the matching occupancy/list-head byte for the same cell. |
| `MAZE_CELL_ROW_STRIDE` | `$40` | Byte stride between rows in the final maze buffer. |

Bank 6 slot `$23` initializes this buffer from packed built-in maze data, and
bank 12 setup/resync paths can transfer either compact cell bytes or an
expanded final buffer. `MAZE_SIZE_INDEX` bounds active rows/columns.

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
| `$03` | `$0D` | `$8185` | `BANK13_PLAYER_MAZE_UPDATE_ENTRY` | registered player/maze update entry; no active caller proven yet |
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
| `$13` | `$04` | `$8000` | `BANK4_NET_COMMAND_SERVICE_ENTRY` | `bank12:L9A2D` live service, pre-live/resync/hold wait loops |
| `$14` | `$04` | `$8003` | `BANK4_SLOT14_SERVICE_ENTRY` | `bank12:L879E`, `bank12:L94FC` |
| `$15` | `$04` | `$8006` | `BANK4_SLOT15_SERVICE_ENTRY` | `bank12:MODE_SELECTION_DISPATCH` |
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
| `$20` | `$05` | `$8000` | `BANK5_PAYLOAD_LOADER_ENTRY` | `bank12:SETUP_XM301_ENTRY`, `bank12:SETUP_R_HANDLER_SHARED` |
| `$21` | `$02` | `$8000` | `BANK2_SETUP_FINALIZE_ENTRY` | setup/roster finalization paths in bank 12 |
| `$22` | `$00` | `$8000` | `BANK0_GAMEPLAY_UPDATE_ENTRY` | `bank12:L9A2D` gameplay loop |
| `$23` | `$06` | `$8000` | `BANK6_MAZE_DATA_INIT_ENTRY` | initial table entry; no active call site proven yet |
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

G7 extension note:

- No bank-call slot is currently documented as safe to repurpose. Slots with no
  proven active caller remain initialized table entries, not free space. Future
  FujiNet work should prefer the transport callback vector family or a tightly
  compatible slot `$13` wrapper over adding/reusing a bank-call slot.

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
| `NET_SERVICE_WAIT_POLL` | `$AF87` | `L00B3` clock, `NET_TIMEOUT_TICKS`, callback vectors | Clears `NET_ERROR_CODE` on timeout; otherwise preserves callback status | Polls bank-call slot `$0D` while waiting on `NET_CALL_VECTOR_2`, then calls `NET_CALL_VECTOR_0`. |
| `NET_VECTOR_WAIT_POLL` | `$AFAE` | same timeout/vector state | Sets `NET_ERROR_CODE = $C7` on timeout; returns `NET_ERROR_CODE` in `Y` after callback | Similar wait loop, but polls slot `$0D` only while vector 2 is not ready. |
| `NET_CALL_VECTOR_0`..`NET_CALL_VECTOR_6` | `$AFDA-$AFEC` | vector words at `$3ED3/$3ED5/$3ED7/$3ED9/$3EDB/$3EDD/$3EDF` | Whatever the selected callback returns | Bank 12 patches these vector words for setup/gameplay modes. |
| `WAIT_FOR_RTC_TICK` | `$AFEF` | `RTCLOK+2` | returns after `RTCLOK+2` changes | Frame pacing helper; does not touch `NET_ERROR_CODE`. |
| `PACK_DIRECTION_TO_STATUS_BITS` | `$AFF6` | `A` direction/status byte, scratch `L0080`, table `DIRECTION_STATUS_BITS_A` | `A` = input with bits 5/6 replaced from rotated direction bits | Used when packing player/status direction bytes. |
| `ROTATE_DIRECTION_TO_STATUS_BITS` | `$B00B` | `A` direction/status byte, scratch `L0080`, table `DIRECTION_STATUS_BITS_B` | `A` = input with alternate bits 5/6 encoding | Companion direction/status packing helper. |
| `PLAYER_RECORD_OFFSET_TABLE` | `$B0AE` | `X` player index at callers | table read only | Offsets into packed per-player records used by bank 4 and bank 12 roster/status paths. |
| `PLAYER_RECORD_LENGTH_TABLE` | `$B0BE` | table read only | table read only | Small size/length lookup adjacent to the offset table. |
| `CLEAR_STATUS_LINE_BUFFERS` | `$B0C7` | none | clears `$72C0-$72CF` and `$72D0-$72DF`; `A=0`, `X=$FF` | Used before writing status/error/menu message buffers. |
| `MARK_STATUS_LINE_DIRTY` | `$B0D5` | `$72C0-$72DF` | sets bit 7 across the 32-byte status line region; `X=$FF` | Marks status/message bytes for display update. |

## Network State Map

These names cover the Phase 3 map of setup/network state around
`$3CE6-$3D39`, `$3ECF-$3EEB`, and `$3F07-$3F13`. Names were promoted only where
there are cross-bank references, repeated setup payload order, or direct use by
the fixed-bank helpers.

| Name | Address | Evidence / role |
|---|---:|---|
| `L2B00` | `$2B00` | Bank 4 per-player companion byte buffer for high-bit `PLAYER_INPUT_STATUS` markers. `$FF` means no command; negative companion bytes can become `PENDING_NET_COMMAND`; `$08`/`$0D` drive trail/status handling. Still generated in source until a stable shared name is promoted. |
| `SETUP_TEAM_PLAY_FLAG` | `$3CE6` | Setup payload scalar; toggles team-style handling in banks 0, 1, 4, 12, and 13. When nonzero, bank 13 compares player teams and updates `TEAM_SCORE_COUNTERS`. |
| `SETUP_TEAM_OPTION_FLAG` | `$3CE7` | Setup payload scalar sent after `SETUP_TEAM_PLAY_FLAG`; displayed in bank 4 and used by bank 13 in the team-play branch. |
| `SETUP_SYNC_TOGGLE_FLAG` | `$3CE8` | Toggled by MIDI/net byte `$7F` in bank 4 and reset during setup/gameplay parameter exchange. Exact UI meaning still needs emulator confirmation. |
| `PLAYER_FIRE_COOLDOWN` | `$3D19` | First byte of the per-player gameplay parameter relay; default `$0A`; copied to all players before setup exchange. |
| `PLAYER_RELOAD_TIMER` | `$3D09` | Second gameplay parameter byte; default `$64`; used by bank 13 to reload `PLAYER_STATE_TIMER`. |
| `PLAYER_PROJECTILE_LIFE` | `$3CF9` | Third gameplay parameter byte; default `$32`; used when player state decrements to zero. |
| `PLAYER_WEAPON_MODE` | `$3CE9` | Fourth gameplay parameter byte; default `$02`; controls player state transitions in bank 13. |
| `PLAYER_INPUT_STATUS` | `$3D29` | Per-player live input/status byte written by bank 4 network service and bank 0 local/control logic. Bank 4 uses the sign bit to mark a companion command/control byte in `$2B00+player`; bank 13 slot `$03` copies the selected player's byte into `L00C7` for movement/fire handling. |
| `TEAM_SCORE_COUNTERS` | `$3D39` | Four-byte team/status counter array. Bank 13 increments it on team-play events and display code compares it against `L3DB7`. |
| `NET_TIMEOUT_DEADLINE` | `$3ECF` | Deadline byte computed as `L00B3 + NET_TIMEOUT_TICKS` by bank 4 and fixed-bank wait helpers. |
| `NET_TIMEOUT_TICKS` | `$3ED0` | Timeout duration selected by bank 12 when patching network callback modes. |
| `NET_INPUT_TRAIL_INDEX` | `$3ED1` | Bank 4 index into the `$7362/$7363` input/status trail shown while MIDI bytes are processed. |
| `NET_ERROR_CODE` | `$3ED2` | Status/error code consumed by `PRINT_STATUS_MESSAGE`. |
| `NET_VECTOR_0_LO/HI` ... `NET_VECTOR_6_LO/HI` | `$3ED3-$3EE0` | Seven callback vector words used by fixed-bank `NET_CALL_VECTOR_0` through `NET_CALL_VECTOR_6`; bank 12 patches these for setup, gameplay, and resync modes. |
| `PENDING_NET_COMMAND` | `$3EE7` | Extended command received by bank 4 and dispatched by bank 12. |
| `OUTGOING_NET_COMMAND` | `$3EE8` | Extended command queued by bank 12 for bank 4 injection into the command stream. |
| `SETUP_REFRESH_DEADLINE` | `$3EEB` | Set to `L00B3 + $64` after setup/menu refresh points in banks 12 and 15. No active reads are confirmed yet. |
| `BOT_COUNT_TARGET`, `BOT_COUNT_DRONE`, `BOT_COUNT_NINJA`, `BOT_COUNT_NASTY` | `$3EED-$3EEF`, `$3F13` | Setup bot counts; Nasty and Ninja share one packed protocol byte during resync. |
| `PLAYER_BOT_TYPE` | `$3F16` | Per-player bot dispatch type filled by bank 1 from the four bot counts. `$FF` means human/inactive; `$00-$03` dispatch to the four bank 0 bot behavior paths. |
| `SETUP_LINK_MODE` | `$3F07` | Setup path selector with values `LINK_MODE_DIRECT_OR_LOCAL`, `LINK_MODE_XM301`, `LINK_MODE_SX212`, and `LINK_MODE_ATARI_850`; controls which callback vector set bank 12 installs. |
| `SETUP_LAST_SLOT1F_RESULT` | `$3F08` | Result byte returned from bank-call slot `$1F` during setup probing. |
| `SETUP_RESUME_FLAG` | `$3F09` | Resume/re-entry flag checked with `SETUP_LINK_MODE` before returning to setup flow. |
| `SETUP_HOLD_SYNC_FLAG` | `$3F0A` | Set by bank 4 on command byte `$1B`; checked by bank 12 hold/sync loops. |
| `STARTUP_KEYBOARD_MODE_FLAG` | `$3F0D` | Set from startup keyboard state in bank 12 and used by banks 13/14 display code. |
| `SAVED_MEMLO_LO`, `SAVED_MEMLO_HI` | `$3F0F-$3F10` | Saved OS `MEMLO` bytes restored before selected setup/load paths. |
| `SETUP_CHECKSUM_RETRY_COUNT` | `$3F12` | Retry counter for `SETUP_CHECKSUM_EXCHANGE`; after three failures it reports `ERR_CANT_SYNC`. |

Still-generated bytes in this range:

- `L3EE1`, `L3EE3-L3EE6`, `L3EE9`, and `L3EEA` remain generated labels. They
  are either write-only in active code, tied to a local display helper, or not
  yet semantically strong enough for a shared name.

## Player And Roster Arrays

These names cover the Phase 4 player/setup fields. The setup payload order is
the order used by `MASTER_SEND_SETUP_PAYLOAD` and
`SLAVE_RECEIVE_SETUP_PAYLOAD` in bank 12. Gameplay parameter order is the
7-byte ring relay at `GAMEPLAY_PARAM_RELAY`.

| Name | Address | Stride | Payload order | Role / evidence |
|---|---:|---:|---|---|
| `LOCAL_PLAYER_INDEX` | `$3968` | scalar | setup scalar | Local station/player index; player 0 drives master transmit paths. |
| `PRNG_SEED_LOW`, `PRNG_SEED_HIGH` | `$3969-$396A` | scalar | setup scalar | Shared maze/random seed bytes sent before the per-player arrays. |
| `HUMAN_PLAYER_COUNT` | `$396B` | scalar | setup scalar | Human roster count used to bound setup and gameplay parameter exchange. |
| `TOTAL_PLAYER_COUNT` | `$396E` | scalar | setup scalar | Human+bot player count after setup clamping. |
| `MAZE_SIZE_INDEX` | `$396F` | scalar | setup scalar | Maze-size selector used when clamping supported players. |
| `MAZE_LINK_PLAYER_INDEX` | `$3971` | scalar | not on wire | Scratch player index consumed by fixed-bank maze-cell linked-list helpers. |
| `PLAYER_X_LO` | `$39B2` | `$10` | setup player byte 1 | Player X low/subcell byte. |
| `PLAYER_X_HI` | `$39D2` | `$10` | setup player byte 2 | Player X high/maze-cell byte. |
| `PLAYER_Y_LO` | `$39F2` | `$10` | setup player byte 3 | Player Y low/subcell byte. |
| `PLAYER_Y_HI` | `$3A12` | `$10` | setup player byte 4 | Player Y high/maze-cell byte. |
| `PLAYER_FACING_ANGLE` | `$3A32` | `$10` | setup player byte 5 | Player facing/heading angle used by movement and projectile setup. |
| `PLAYER_STATE` | `$3A72` | `$10` | setup player byte 6 | Player live/state byte checked by movement, collision, and setup paths. |
| `PLAYER_HIT_FLAG` | `$3A92` | `$10` | setup player byte 7 | Hit/collision flag relayed in setup state. |
| `PLAYER_STATE_TIMER` | `$3AA2` | `$10` | setup player byte 8 | State/reload countdown used by player update logic. |
| `PLAYER_FIRE_TIMER` | `$3AB2` | `$10` | setup player byte 9 | Per-player fire cooldown timer. |
| `PLAYER_SCORE_COUNTERS` | `$3AC2` | `$10` | setup player byte 10 | Per-player score/frags counter used outside team scoring. |
| `PROJECTILE_X_LO` | `$39C2` | `$10` | setup player byte 11 | Projectile X low/subcell byte. |
| `PROJECTILE_X_HI` | `$39E2` | `$10` | setup player byte 12 | Projectile X high/maze-cell byte. |
| `PROJECTILE_Y_LO` | `$3A02` | `$10` | setup player byte 13 | Projectile Y low/subcell byte. |
| `PROJECTILE_Y_HI` | `$3A22` | `$10` | setup player byte 14 | Projectile Y high/maze-cell byte. |
| `PROJECTILE_ACTIVE_TIMER` | `$3A82` | `$10` | setup player byte 15 | Projectile active/lifetime countdown. |
| `PROJECTILE_DX_LO` | `$3B02` | `$10` | setup player byte 16 | Projectile X velocity low byte. |
| `PROJECTILE_DX_HI` | `$3B12` | `$10` | setup player byte 17 | Projectile X velocity high/sign byte. |
| `PROJECTILE_DY_LO` | `$3B22` | `$10` | setup player byte 18 | Projectile Y velocity low byte. |
| `PROJECTILE_DY_HI` | `$3B32` | `$10` | setup player byte 19 | Projectile Y velocity high/sign byte. |
| `MAZE_CELL_PLAYER_NEXT` | `$3A52` | `$10` | not on wire | Per-player next pointer for the maze-cell occupancy linked list. |
| `PLAYER_HIT_BY_INDEX` | `$3AD2` | `$10` | not on setup payload | Player index associated with the current hit/collision event. |
| `PLAYER_TEAM_INDEX` | `$3AF2` | `$10` | setup/team assignment | Team number initialized from player index and used by team-play scoring. |
| `PLAYER_BOT_TYPE` | `$3F16` | `$10` | bot setup | Bot dispatch type for slots at or above `HUMAN_PLAYER_COUNT`; human/inactive slots use `$FF`. |
| `PLAYER_FIRE_COOLDOWN` | `$3D19` | `$10` | gameplay param 1 | Default `$0A`; first byte of the pre-game gameplay parameter relay. |
| `PLAYER_RELOAD_TIMER` | `$3D09` | `$10` | gameplay param 2 | Default `$64`; copied into state timers by gameplay update code. |
| `PLAYER_PROJECTILE_LIFE` | `$3CF9` | `$10` | gameplay param 3 | Default `$32`; projectile/player state duration. |
| `PLAYER_WEAPON_MODE` | `$3CE9` | `$10` | gameplay param 4 | Default `$02`; controls firing/state transition mode. |
| `PLAYER_MOVE_SPEED_FLAG` | `$3B42` | `$10` | gameplay param 5 | Default `$00`; movement speed option relayed before live play. |
| `PLAYER_PROJECTILE_SPEED_FLAG` | `$3B52` | `$10` | gameplay param 6 | Default `$00`; projectile speed option relayed before live play. |
| `PLAYER_TURN_RATE` | `$3B62` | `$10` | gameplay param 7 | Default `$08`; turning rate option relayed before live play. |
| `PLAYER_INPUT_STATUS` | `$3D29` | `$10` | live status | Network/local input byte written during gameplay status exchange. |
| `TEAM_SCORE_COUNTERS` | `$3D39` | 4 bytes | team score state | Team score counters incremented on team-play events. |

Still-generated player/setup labels:

- `L396C`, `L396D`, and `L3970` remain generated because their setup-flow
  roles are visible but not yet semantically strong enough for stable shared
  names.
- `L3A42` and `L3AE2` remain generated pending more evidence from projectile
  and collision/update paths.

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
- `PLAYER_BOT_TYPE = $3F16`: per-player bot dispatch type. Bank 1 writes
  `$00-$03` after the human range based on the bot counts, and bank 0 slot
  `$22` dispatches those values during gameplay.
- `NET_ERROR_CODE = $3ED2`: status/error code consumed by
  `PRINT_STATUS_MESSAGE`.
- `PENDING_NET_COMMAND = $3EE7`: extended command byte received from the ring.
- `OUTGOING_NET_COMMAND = $3EE8`: extended command byte to inject into the
  ring.

Named command/control bytes:

| Name | Value | Role |
|---|---:|---|
| `CMD_INIT_RING` | `$80` | Pre-live/start companion and raw hold/sync acknowledge byte. |
| `CMD_CLEAR_STATE` | `$81` | Clears transient score/state mirrors through `NET_COMMAND_DISPATCH`. |
| `CMD_HOLD_SYNC` | `$82` | Hold/pause/sync command. |
| `MARKER_SETUP_PAYLOAD` | `$83` | Direct setup/resync payload marker for `MASTER_SEND_SETUP_PAYLOAD` / `SLAVE_RECEIVE_SETUP_PAYLOAD`. |
| `CMD_RESYNC` | `$84` | Resynchronizes setup/gameplay state. |
| `CMD_ROSTER_EXCHANGE` | `$86` | Starts roster/status exchange through bank 12 `L8F57`. |
| `CMD_START_GAME` | `$87` | Named but not actively referenced in current source; reserved/unverified. |

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

## UI And Status Messages

Phase 5 named the status/error message path without changing the original text
bytes. Message bodies in bank 12 are Atari screen-code bytes terminated by
`$FF`; `PRINT_STATUS_MESSAGE` copies them into the status line and marks the
line dirty through the fixed-bank helpers.

Shared status line RAM:

| Name | Address | Role |
|---|---:|---|
| `STATUS_LINE_BUFFER` | `$72C0` | First 16-byte status/message line buffer; dirty bits are set across `$72C0-$72DF`. |
| `STATUS_ERROR_PREFIX` | `$72C1` | Destination for the six-byte `ERROR:` prefix. |
| `STATUS_MESSAGE_TEXT` | `$72C8` | Destination for the selected message body or numeric error code digits. |
| `STATUS_LINE_BUFFER_2` | `$72D0` | Second 16-byte status/message line buffer cleared with `$72C0`. |

`NET_ERROR_CODE` mappings used by `PRINT_STATUS_MESSAGE`:

| Name | Value | Message label |
|---|---:|---|
| `ERR_GAME_TERMINATED` | `$02` | `STATUS_MSG_GAME_TERMINATED` |
| `ERR_MAZE_TOO_SMALL` | `$03` | `STATUS_MSG_MAZE_TOO_SMALL` |
| `ERR_NETWORK` | `$04` | `STATUS_MSG_NETWORK_BOOBOO` |
| `ERR_TOO_MANY_MACHINES` | `$05` | `STATUS_MSG_TOO_MANY_MACHINES` |
| `ERR_NO_DRONES_ALLOWED` | `$06` | `STATUS_MSG_NO_DRONES_ALLOWED` |
| `ERR_CHECKSUM` | `$07` | `STATUS_MSG_CHECKSUM_BOOBOO` |
| `ERR_DEVICE_NOT_RESPONDING` | `$08` | `STATUS_MSG_DEVICE_NOT_RESPONDING` |
| `ERR_NO_SUCH_DEVICE` | `$09` | `STATUS_MSG_NO_SUCH_DEVICE` |
| `ERR_CANT_SYNC` | `$0A` | `STATUS_MSG_CANT_SYNC` |
| `ERR_TIMEOUT` | `$C7` | `STATUS_MSG_TIMEOUT` |

Additional UI/status text labels named in bank 12:

| Label | Observed text / role |
|---|---|
| `STATUS_MSG_CARRIER_DETECTED` | "Carrier detected" after serial carrier detection. |
| `STATUS_MSG_THIS_IS_MASTER_MACHINE` | Master setup status line. |
| `STATUS_MSG_THIS_IS_SLAVE_MACHINE` | Slave setup status line. |
| `STATUS_MSG_PAUSE_TITLE` | Pause title copied during hold/pause flow. |
| `STATUS_MSG_PAUSE_INSTRUCTIONS` | Pause instructions copied during hold/pause flow. |
| `STATUS_MSG_PLEASE_HOLD` | Hold/sync wait message for command `$82`. |
| `STATUS_PLAYER_LABEL_TEMPLATE` | Player label template used to build the roster/status text table at `$3DFC`. |

## Raw Bytes

Undocumented opcode forms that MADS warned about, or that are safer as data for
now, are emitted as `.byte` with the original disassembly in the comment. Do
not convert them back to instructions unless `make compare` remains exact and
the region has been proven executable.
