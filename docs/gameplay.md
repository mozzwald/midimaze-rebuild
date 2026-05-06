# MIDI Maze Gameplay Notes

This document collects gameplay control-flow findings from
`ref/GAMEPLAY_FUJINET_RESEARCH_PLAN.md`.

Keep this file focused on how the current game works: mode selection, setup
paths, main gameplay loop, player data flow, state arrays, bot/human handling,
commands, and maze buffers. Future FujiNet design notes belong in
`docs/fujinet-porting.md`.

## Current Status

- [x] Mode selection and setup state mapped.
- [x] Main gameplay loop mapped.
- [x] Transport-specific setup paths mapped.
- [x] Incoming player data path mapped.
- [x] Player state arrays deep-mapped.
- [x] Human versus bot split mapped.
- [x] Gameplay bank-call extension points mapped.
- [x] Network command/control bytes mapped.
- [ ] Maze load path mapped.

## Mode Selection And Setup State

`SETUP_LINK_MODE` at `$3F07` is the setup path selector used after the
transport menu. It is not the same as the menu selection value: the SOLO and
MIDI-MATE entries both store `LINK_MODE_DIRECT_OR_LOCAL = $00` and are
distinguished by which setup entry installs the callback vectors.

### Transport Menu Dispatch

Bank 12 calls bank-call slot `$15` at `MODE_SELECTION_DISPATCH`. Slot `$15`
displays the transport menu in bank 4 and returns a 1-based menu selection in
`A`. Bank 12 stores that in `L00A6`, decrements it through a chain, and jumps
to the selected setup entry.

| Menu return | Menu text | Bank 12 entry | Stored `SETUP_LINK_MODE` | Meaning |
|---:|---|---|---:|---|
| `1` | `SOLO` | `SETUP_SOLO_ENTRY` | `LINK_MODE_DIRECT_OR_LOCAL` / `$00` | Local/solo setup. Uses fixed-bank callback vectors and does not load an OS `R:` handler. |
| `2` | `MIDI-MATE` | `SETUP_MIDIMATE_ENTRY` | `LINK_MODE_DIRECT_OR_LOCAL` / `$00` | Direct MIDI/POKEY setup. Installs callback vectors from the fixed-bank `LBE04-LBE11` vector bytes. |
| `3` | `XM301` | `SETUP_XM301_ENTRY` | `LINK_MODE_XM301` / `$01` | Loads the bank 5 payload with `Y=0`, installs `R:`-style callbacks, then sends modem escape/setup bytes before shared setup. |
| `4` | `SX212` | `SETUP_SX212_ENTRY` | `LINK_MODE_SX212` / `$02` | Loads the bank 5 alternate payload with `Y=1`, then uses the shared `R:`/AT-command setup path. |
| `5` | `R1:(850)` | `SETUP_ATARI_850_ENTRY` | `LINK_MODE_ATARI_850` / `$03` | Uses the shared `R:` setup path with an extra CIO command before normal initialization, matching the Atari 850 handler path. |

The visible menu text bytes in bank 4 are, in order: `SOLO`, `MIDI-MATE`,
`XM301`, `SX212`, and `R1:(850)`.

### Writes To `SETUP_LINK_MODE`

| Location | Value | Role |
|---|---:|---|
| `BANK12_BOOT_MENU_ENTRY` startup initialization | `$00` | Clears setup state before entering the menu. |
| `SETUP_SOLO_ENTRY` | `LINK_MODE_DIRECT_OR_LOCAL` / `$00` | Installs fixed-bank local/direct callback vectors and short timeout. |
| `SETUP_MIDIMATE_ENTRY` | `LINK_MODE_DIRECT_OR_LOCAL` / `$00` | Installs custom MIDI/POKEY callback vectors from fixed-bank vector bytes. |
| `SETUP_XM301_ENTRY` | `LINK_MODE_XM301` / `$01` | Selects XM301 modem setup and later XM301-specific command path. |
| `SETUP_SX212_ENTRY` | `LINK_MODE_SX212` / `$02` | Selects SX212 setup and shared `R:` handler path. |
| `SETUP_ATARI_850_ENTRY` | `LINK_MODE_ATARI_850` / `$03` | Selects Atari 850 setup and shared `R:` handler path. |

### Reads And Branches On `SETUP_LINK_MODE`

| Location | Test | Effect |
|---|---|---|
| `RESET_TO_MENU` | zero/nonzero, then `LINK_MODE_XM301` compare | Nonzero modes can resume setup if `SETUP_RESUME_FLAG` is set. XM301 has a special `L3EF0 == $88` path before re-entering setup. |
| `SETUP_SX212_ENTRY`/`SETUP_ATARI_850_ENTRY` shared path | compare with `LINK_MODE_SX212` | SX212 loads the bank 5 alternate payload with `Y=1`; Atari 850 skips that specific load because it has its own pre-initialization branch. |
| Shared `R:` setup path | compare with `LINK_MODE_ATARI_850` | Atari 850 performs an extra CIO command `$22` with `ICAX1=$C0` before normal CIO command `$26`. |
| Setup connection/status path | compare with `LINK_MODE_XM301` | XM301 sends a short escape/`G` command path; other non-direct modem paths send `ATS0=1`-style bytes before carrier wait. |
| Dial/answer command formatter `L8481` | `>= LINK_MODE_SX212` | SX212/850 emit `ATDT` or `ATDP` plus number text through `LB147`; direct/XM301 use the older escape-command formatting path. |
| Carrier wait helper `L8530` | `>= LINK_MODE_SX212` | SX212/850 poll CIO/DVSTAT bit `$08`; direct/XM301 use the simpler `LB113`/negative status path. |
| Shared setup entry `L863D` | zero/nonzero | Direct/local modes skip the `$A0/$A1` ring probe and jump to the direct setup branch; modem/850 modes perform the probe through `NET_SERVICE_WAIT_POLL`. |
| Gameplay parameter completion `L9815` | zero/nonzero | Direct/local modes skip the final ring checksum exchange; modem/850 modes exchange/check `L993B` checksum bytes before entering the final setup path. |
| Bank 4 slot `$24` entry `L977B` | zero/nonzero | Direct/local mode waits for status/display latches before continuing the bank 4 service path; nonzero modes skip that wait. |

### Mode Notes

- `LINK_MODE_DIRECT_OR_LOCAL = $00` is intentionally broad. The later code
  treats SOLO and MIDI-MATE the same for many branches, but their entry
  routines install different callback vectors.
- `LINK_MODE_XM301 = $01` is the only mode with the XM301-specific branch in
  the connection/status path.
- `LINK_MODE_SX212 = $02` and `LINK_MODE_ATARI_850 = $03` share the `R:`
  handler setup family and use AT-style command strings.
- `LINK_MODE_ATARI_850 = $03` is distinguished from SX212 by the extra CIO
  command before shared initialization.

## Main Gameplay Loop And Bank Ownership

Bank 12 owns the live gameplay orchestration. It does not do all gameplay work
itself; instead it repoints volatile bank-call slots, polls transport state, and
dispatches bank-owned service routines.

### Live Service Slice

The primary live service slice is bank 12 `L9A2D`. The slot `$11` patch at
`L93F8` and `L9504` writes target `$9A15` in the current bank, one byte before
`L9A16`, so the exact entry includes a preserved byte boundary before the
visible `PLA` at `L9A16`.

| Order | Bank/slot | Location | Role |
|---:|---|---|---|
| 1 | bank 12 | `L9A16-L9A28` | Converts console hold/sync state into `OUTGOING_NET_COMMAND = CMD_HOLD_SYNC` (`$82`) when needed. |
| 2 | slot `$13`, bank 4 | `BANK4_NET_COMMAND_SERVICE_ENTRY` | Services outgoing command state and incoming transport/command state. Called at `L9A2D`. |
| 3 | bank 12 | `L9A2D-L9A5B` | Exits on `NET_ERROR_CODE`, dispatches pending commands through `NET_COMMAND_DISPATCH`, and spins while `L3EB9` remains nonzero. |
| 4 | slot `$22`, bank 0 | `BANK0_GAMEPLAY_UPDATE_ENTRY` | Updates non-human/local gameplay actors from `HUMAN_PLAYER_COUNT` up to `TOTAL_PLAYER_COUNT`. |
| 5 | bank 12 | `L9A2D-L9A58` | Decrements `L3F0C`; most iterations return through `BANK_RETURN`, and every `$15` ticks jump to `SETUP_CHECKSUM_EXCHANGE`. |

This is a service slice rather than a simple infinite frame loop: clean
iterations return through `BANK_RETURN`, while busy transport state can loop
inside `L9A2D` until `L3EB9` clears.

### Entry And Re-Entry Paths

| Location | Role |
|---|---|
| `L93F8` | Patches slot `$11` to bank 12 `$9A15`, slot `$1B` to bank 4 `$8018`, and slot `$13` to bank 4 `$8000`; calls slot `$1B`, then enters the `L9430` command loop. |
| `L9430` | Calls slot `$17`, checks `NET_ERROR_CODE` and `PENDING_NET_COMMAND`, dispatches commands, and handles resync/clear/roster command transitions. |
| `L9504` | Alternate entry with the same slot `$11/$1B/$13` patching, plus an `LB224` call before slot `$1B`; enters the `L953F` command loop. |
| `L953F` | Calls slot `$1E`, checks network status and pending commands, and uses `L9576` as its resync wait loop. |
| `L9857` | Final gameplay setup path before live control. It clears/draws state through slots `$04`, `$21`, and `$10`, initializes score mirrors, then enters the master/non-master pre-live wait paths at `L98CB` or `L9926`. |
| `L98CB`, `L9909`, `L9926` | Pre-live command wait paths. They poll slot `$0D` and slot `$13`, update `OUTGOING_NET_COMMAND`, and wait for `PENDING_NET_COMMAND`. |
| `L9A81`, `L9A99`, `L9AC2`, `L9ADF`, `L9B17` | Hold/sync/pause-style wait paths that repeatedly poll slot `$0D` and slot `$13` until console or pending-command state changes. |

### Bank Ownership

| Owner | Routine/slot | Gameplay responsibility |
|---|---|---|
| bank 12 | `L9A2D`, `NET_COMMAND_DISPATCH`, resync/hold paths | High-level live control, command dispatch, periodic checksum/resync entry, and volatile slot patching. |
| bank 4 | slot `$13` `BANK4_NET_COMMAND_SERVICE_ENTRY` | Transport-facing command service during setup, pre-live waits, live gameplay, and pause/resync waits. |
| bank 0 | slot `$22` `BANK0_GAMEPLAY_UPDATE_ENTRY` | Non-human/bot gameplay update. It starts at `HUMAN_PLAYER_COUNT`, stores the current slot in `L40CB`, dispatches on `PLAYER_BOT_TYPE,X`, and stops at `TOTAL_PLAYER_COUNT`. |
| bank 1 | direct trampoline targets from bank 0 via `$AF41` | Movement, collision, targeting, and state helper routines used by bank 0. Bank 0 calls these with `A=bank`, `X=target high`, `Y=target low`. |
| bank 13 | slot `$03` `BANK13_PLAYER_MAZE_UPDATE_ENTRY` | Registered player/maze/projectile update entry. No direct slot `$03` caller has been found in active source yet; the call path remains an explicit trace target for the player-state phases. |

### Slot `$13` Live Call Sites

Slot `$13` is the best current marker for gameplay transport servicing. It is
called in the live service slice at `L9A2D`, in resync wait loops `L9467` and
`L9576`, in pre-live waits `L98CB`, `L9909`, and `L9926`, and in hold/sync
waits `L9A81`, `L9A99`, `L9AC2`, `L9ADF`, and `L9B17`.

`L95D0` temporarily redirects slot `$13` to `BANK_RETURN` (`$AF36`) during the
hold/sync master path, then `L9613` restores it to bank 4 `$8000`. Any future
transport hook must account for this volatility.

## Transport-Specific Setup Paths

Bank 12 owns the setup path selection and callback-vector installation. The
transport-specific entries differ mostly in which `NET_CALL_VECTOR_0..6`
callbacks they install and which device/probe work they perform before joining
the shared setup handshake.

### Transport Setup Table

| Transport | Entry | `SETUP_LINK_MODE` | Callback set | Setup work before convergence | Success target | Failure target |
|---|---|---:|---|---|---|---|
| SOLO | `SETUP_SOLO_ENTRY` | `LINK_MODE_DIRECT_OR_LOCAL` / `$00` | Fixed-bank local ring callbacks at `$AF51/$AF5A/$AF5D/$AF62/$AF6C` | Clears `AUDCTL`, installs short timeout `$02`, no OS `R:` load. | `L863D` | `L86B4` after shared handshake errors |
| MIDI-MATE | `SETUP_MIDIMATE_ENTRY` | `LINK_MODE_DIRECT_OR_LOCAL` / `$00` | Fixed-bank MIDI/POKEY callbacks copied from the jump table bytes at `$BE04-$BE11`: RX read `$BEE9`, TX send `$BEC7`, RX count `$BEF7`, install `$BEFD`, remove `$BF67`/`$BF6D` path | Installs timeout `$06`; `L863D` calls vector 3, which targets `MIDI_INSTALL` for this path. | `L863D` | `L86B4` after shared handshake errors |
| XM301 | `SETUP_XM301_ENTRY` | `LINK_MODE_XM301` / `$01` | `R:`/CIO-style callbacks: close `$B135`, put byte `$B147`, status/readiness `$B131`, no-op `$AF5A`, and XM301-specific command helpers near `$B1AE/$B1C6` | Restores `MEMLO`, calls slot `$20` with `Y=0` to load bank 5 payload, calls `LB15B`/`LB0E5`, sends escape/setup bytes through `LB147`, then enters the common modem probe path. | `L83B2`, then `L863D` after probe/carrier success | `L8288`, `L83EA`, or `L845D` |
| SX212 | `SETUP_SX212_ENTRY` | `LINK_MODE_SX212` / `$02` | Shared `R:`/CIO callback family: close `$B135`, put byte `$B147`, readiness `$B125`, open/init `$B193`, helpers `$B15B/$B1A5` | Restores `MEMLO`, calls slot `$20` with `Y=1`, initializes `R:`, sends `+++`, waits, sends `ATH`, calls slot `$18`, then enters common modem probe. | `L83B2`, then `L863D` after probe/carrier success | `L8367`, `L83EA`, or `L845D` |
| Atari 850 | `SETUP_ATARI_850_ENTRY` | `LINK_MODE_ATARI_850` / `$03` | Same shared `R:`/CIO callback family as SX212 | Skips the bank 5 payload load, runs the extra CIO command `$22` with `ICAX1=$C0`, then runs the common CIO command `$26`, `+++`, `ATH`, slot `$18`, and probe path. | `L83B2`, then `L863D` after probe/carrier success | `L8364`, `L8367`, `L83EA`, or `L845D` |

### Shared Convergence

`L83B2` is the common modem/850 probe branch. It calls slot `$1F` to determine
whether this machine should start a dial/answer path or wait for incoming setup
state. From there:

- `L83C3` calls `NET_CALL_VECTOR_3`, formats dial/answer bytes with `L8481`,
  waits, checks carrier with `L8530`, and jumps to `L863D` on success.
- `L83F0` displays a wait/status message. XM301 uses the escape/`G` path at
  `L8463`; SX212/850 send `ATS0=1`-style bytes before carrier wait. Both paths
  jump to `L863D` after `L8530` reports carrier.

`L863D` is the shared setup handshake for direct/local and modem/850 paths. It
patches volatile bank-call slot `$11` to bank 12 `$9007`, redirects slots `$1B`
and `$13` to `BANK_RETURN`, calls `NET_CALL_VECTOR_3`, clears setup scratch,
and then splits only on `SETUP_LINK_MODE`:

- Direct/local modes jump to `L86DE`, run a short `NET_SERVICE_WAIT_POLL`,
  send `$00`, and branch to either the master path at `L86F5` or slave path
  `L8B81`.
- Nonzero modem/850 modes run the `$A0/$A1` probe. The local player index is
  set from `SETUP_LAST_SLOT1F_RESULT`; player 0 enters `L86F5`, while nonzero
  players enter `L8B81`.

### Callback Roles

The seven vector words at `$3ED3-$3EE0` are called through fixed-bank wrappers
`NET_CALL_VECTOR_0..6`.

| Vector | Observed setup role |
|---:|---|
| 0 | Receive/read byte or status-producing poll, depending on transport. |
| 1 | Transmit/write one byte. |
| 2 | Readiness/byte-available predicate used by `NET_SERVICE_WAIT_POLL` and `NET_VECTOR_WAIT_POLL`. |
| 3 | Transport open/init/reset hook before shared setup work. |
| 4 | Transport close/remove hook in some paths. |
| 5 | Hold/sync or transport-specific helper used during resync/control paths. |
| 6 | Resume/reopen or companion helper used after hold/sync/control paths. |

The exact vector semantics are transport-dependent; this is why future
transport work should install a complete vector family instead of replacing
individual call sites piecemeal.

### Error Paths

Most setup failures store a status byte in `NET_ERROR_CODE`, print it through
`PRINT_STATUS_MESSAGE`, and return to `RESET_TO_MENU`. CIO-backed helpers store
the OS/CIO status in `NET_ERROR_CODE` when `CIOV` returns negative. The fixed
wait helper `NET_VECTOR_WAIT_POLL` writes `$C7` on timeout. Some setup branches
treat `$C7` as retryable, especially while waiting for carrier/probe bytes; if
the retry is not allowed, the same value is displayed as the setup error.

`ERR_TOO_MANY_MACHINES` is set in the shared player-count exchange when the
remote count is `$11` or greater. Checksum errors later use `ERR_CHECKSUM`, but
those belong to the gameplay-parameter/checksum paths after transport setup.

## Incoming Player Data Path

Bank 4 slot `$13` is the live input/status transport service. Bank 12 calls it
from the `L9A2D` service slice before bank 0 gameplay updates, and bank 12
spins while bank 4's `L3EB9` state is nonzero. That means one visible gameplay
slice does not advance to slot `$22` until the current human-player status
exchange has either completed or errored.

### Receive And Separation Flow

| Step | Location | Data | Effect |
|---:|---|---|---|
| 1 | bank 4 `L8080` | `L3EB9` | Selects the exchange state: `0` starts a new local packet, `1` waits for a remote first byte, greater than `1` waits for a remote auxiliary/control byte. |
| 2 | bank 4 `L80A1` | `MIDI_RX_HAS_BYTE` / `MIDI_RX_READ_BLOCKING` | Polls the generic incoming byte ring before packing local joystick state. Recognized local bytes include `$9B`, `$7E`, `$7F`, and `$1B`. |
| 3 | bank 4 `L8115-L814B` | local byte plus `STICK0`/`STRIG0` | Stores the raw/control byte for the local slot in `$2B00 + LOCAL_PLAYER_INDEX`, combines its high-bit marker with packed local joystick bits, and writes `PLAYER_INPUT_STATUS[LOCAL_PLAYER_INDEX]`. |
| 4 | bank 4 `L815B-L8170` | `NET_CALL_VECTOR_1` | Sends the local `PLAYER_INPUT_STATUS` byte. If the byte is negative/high-bit set, sends the companion raw/control byte from `$2B00`. |
| 5 | bank 4 `L8188-L81C3` | `NET_CALL_VECTOR_2`, then `NET_CALL_VECTOR_0` | Waits for and reads each remote first byte. The byte is stored in `PLAYER_INPUT_STATUS,X`, walking remote player indexes backward through the human-player ring. |
| 6 | bank 4 `L81E4-L820D` | `NET_CALL_VECTOR_0` | If a remote first byte is negative/high-bit set, reads the companion byte and stores it in `$2B00,X`. |
| 7 | bank 4 `L821E-L82C7` | `PLAYER_INPUT_STATUS` plus `$2B00` | Clears `L3EB9`, scans human slots, turns high-bit companion command bytes into `PENDING_NET_COMMAND`, and updates the on-screen input/status trail buffers. |

The transport-specific raw read/write functions are behind the callback vector
family during the ring exchange: `NET_CALL_VECTOR_0` reads a byte,
`NET_CALL_VECTOR_1` writes a byte, and `NET_CALL_VECTOR_2` reports whether a
byte is ready. The pre-pack local-byte poll at `L80A1` uses the fixed helper
names `MIDI_RX_HAS_BYTE` and `MIDI_RX_READ_BLOCKING`.

### Command Versus Player Status

`PLAYER_INPUT_STATUS` is both the per-player live input byte and the first-byte
marker for extended command/control bytes. Bank 4 treats the sign bit as the
split:

- Non-negative first byte: ordinary player status. Bank 4 clears that player's
  `$2B00` companion byte to `$FF` and forwards the status around the ring.
- Negative first byte: command/control marker. Bank 4 expects a companion byte,
  stores it in `$2B00,X`, and later scans it at `L821E`.
- Negative companion byte other than `$FF`: latched as `PENDING_NET_COMMAND`.
- Companion byte `$FF`: no pending command for that player.
- Companion byte `$08`: decrements the per-player trail countdown in `L3EBB,X`
  before display/trail handling.
- Companion byte `$0D`: shifts `$7300/$7320/$7340` trail buffers and emits a
  status-line style record for that player.

Local special byte handling before the status byte is packed:

| Byte | Location | Meaning |
|---:|---|---|
| `$9B` | `L80A1-L80C5` | Clears the input trail display area, resets `NET_INPUT_TRAIL_INDEX`, then uses `$0D` as the local companion byte. |
| `$7E` | `L80C5-L80E1` | Deletes/backs up one trail position and uses `$08` as the local companion byte. |
| `$7F` | `L80E1-L80F0` | Toggles `SETUP_SYNC_TOGGLE_FLAG`; no companion byte is sent for this poll. |
| `$1B` | `L80F0-L80FC` | Sets `SETUP_HOLD_SYNC_FLAG`; no companion byte is sent for this poll. |
| other | `L80FC-L8110` | Packs the byte for trail display with `PACK_DIRECTION_TO_STATUS_BITS` and uses the original byte as the local companion byte. |

### Writers And Consumers

Confirmed writers of `PLAYER_INPUT_STATUS`:

| Writer | Role |
|---|---|
| bank 4 `L814B` | Writes local player input/status each slot `$13` service pass. |
| bank 4 `L81A3` | Writes each remote player's first status/control byte as it is received. |
| bank 0 gameplay update routines | Writes bot/non-human status bytes from local AI/control state during slot `$22`; representative paths are `L82E6`, timer replay at `L89A8`, reset at `L8A07`, and projectile/fire paths near `L8F14`. |
| bank 12 `$904C/$906A/$9080` byte-level path | Additional setup/control status exchange bytes touch `PLAYER_INPUT_STATUS`; the source is still mixed byte-form in this region. |

Confirmed consumers of `PLAYER_INPUT_STATUS`:

| Consumer | Role |
|---|---|
| bank 4 `L815B-L8170` | Reads the local slot value after packing to decide whether a companion byte must be sent. |
| bank 4 `L821E-L82C7` | Scans all human slots after a completed exchange to separate ordinary status from pending command/control bytes and update trail buffers. |
| bank 13 slot `$03` byte entry at `$8185` | Byte-level decode is `LDX L00AC; LDA PLAYER_INPUT_STATUS,X; STA L00C7`. The visible movement/projectile code then consumes `L00C7` bits for turn, move, and fire. |

### Bit Use In Movement

Bank 13's visible movement code consumes the copied status byte in `L00C7`:

| Bit mask | Bank 13 location | Observed effect |
|---:|---|---|
| `$01` | `L8285-L82AE` | Forward movement vector setup. |
| `$02` | `L82AE-L82DF` | Reverse movement vector setup. |
| `$04` | `L81FD-L8227` | Turn one direction by `PLAYER_TURN_RATE`. |
| `$08` | `L8227-L8235` | Turn the other direction by `PLAYER_TURN_RATE`. |
| `$10` | `L8235-L8273` | Fire/projectile creation if `PLAYER_FIRE_TIMER` allows it. |

### Timing And Latency

`L3EB9`, `L3ECB`, and `L3ECC` are the live exchange state variables in bank 4:

- `L3EB9` is the phase/state. `0` starts a fresh exchange; `1` means waiting
  for a remote first byte; values above `1` mean waiting for a companion byte.
- `L3ECB` tracks the current player index during the ring walk.
- `L3ECC` counts remaining human-player status bytes in the current exchange.
- `NET_TIMEOUT_DEADLINE` is set to `L00B3 + NET_TIMEOUT_TICKS` when the
  exchange begins and is refreshed as bytes arrive.
- On timeout, bank 4 stores `$C7` in `NET_ERROR_CODE`.

Bank 12 checks `L3EB9` immediately after slot `$13`; if it is nonzero, `L9A2D`
calls slot `$13` again instead of running slot `$22`. This gives the transport
service priority over bot/non-human updates while a human-player status ring is
mid-exchange.

## Player State Arrays Deep Map

Most live player state is stored as parallel per-player arrays. The common
stride is `$10`, so indexed player-slot access uses `array,X` directly for up
to 16 players. Position and projectile arrays are interleaved by address, but
the setup payload sends them in logical player-state order.

### Ownership Summary

| Group | Arrays | Primary writers | Primary readers | Gameplay meaning |
|---|---|---|---|---|
| Position and facing | `PLAYER_X_LO/HI`, `PLAYER_Y_LO/HI`, `PLAYER_FACING_ANGLE` | bank 13 slot `$03` movement path around `L842B`; bank 13 placement setup; bank 12 setup/resync receive; bank 0 bot-facing helpers update facing in AI paths | bank 13 movement and collision; bank 1 AI/collision helpers; bank 14 renderer; bank 12 checksum/relay | Authoritative player coordinates and heading. Low bytes are subcell/fractional position; high bytes are maze-cell position. |
| Movement tuning | `PLAYER_TURN_RATE`, `PLAYER_MOVE_SPEED_FLAG` | bank 12 defaults and `GAMEPLAY_PARAM_RELAY`; setup UI/service paths | bank 13 movement; bank 4 setup UI; bank 12 gameplay-parameter checksum/relay | Per-player turn amount and movement-speed option used when input bits are applied. |
| State and hit handling | `PLAYER_STATE`, `PLAYER_STATE_TIMER`, `PLAYER_HIT_FLAG`, `PLAYER_HIT_BY_INDEX` | bank 13 placement and hit/state transitions; bank 12 setup/resync receive | bank 13 update/collision; bank 0 and bank 1 AI checks; bank 14 renderer | Runtime state byte, state countdown, hit flash/event flag, and last hitter/player index. A zero `PLAYER_STATE` skips the visible movement branch but still allows projectile/timer handling. |
| Firing and projectile | `PLAYER_FIRE_TIMER`, `PROJECTILE_X/Y_LO/HI`, `PROJECTILE_ACTIVE_TIMER`, `PROJECTILE_DX/DY_LO/HI`, `L3A42`, `PLAYER_PROJECTILE_LIFE`, `PLAYER_PROJECTILE_SPEED_FLAG`, `PLAYER_WEAPON_MODE` | bank 13 fire/create/update/hit paths; bank 12 setup defaults, projectile clear, gameplay-parameter relay, and setup/resync receive | bank 13 projectile update/collision; bank 12 checksum/relay; bank 4 setup UI for option bytes | Fire cooldown, projectile coordinates, active/lifetime counter, projectile velocity, projectile angle snapshot, and option bytes controlling projectile/state behavior. |
| Score and teams | `PLAYER_SCORE_COUNTERS`, `TEAM_SCORE_COUNTERS`, `PLAYER_TEAM_INDEX`, `SETUP_TEAM_OPTION_FLAG` | bank 13 scoring; bank 12 setup/reset/roster relay and command clear paths | bank 13 scoring/status display; bank 4 roster/setup UI; bank 12 checksum/status paths | Per-player score/frags, four team score counters, and team assignment/options used by team-play scoring. |
| Live input | `PLAYER_INPUT_STATUS`, `$2B00` companion bytes | bank 4 live human exchange; bank 0 bot update; bank 12 byte-level setup/control exchange | bank 4 command parser/status trail; bank 13 slot `$03` byte entry | Packed movement/fire/status byte and optional high-bit companion command byte. This is the bridge from transport/bot input into the shared movement code. |

### Array Table

| Array(s) | Address / stride | Owner bank | Writer routines | Reader routines | Gameplay meaning |
|---|---:|---|---|---|---|
| `PLAYER_X_LO`, `PLAYER_X_HI` | `$39B2`, `$39D2` / `$10` | bank 13 | bank 13 placement/update; bank 12 `SLAVE_RECEIVE_SETUP_PAYLOAD`; bank 12 setup/resync relay | bank 13 movement/collision/projectile hit tests; bank 0/bank 1 bot helpers; bank 14 renderer; bank 12 checksum/relay | Player X position, split into low subcell and high maze-cell bytes. |
| `PLAYER_Y_LO`, `PLAYER_Y_HI` | `$39F2`, `$3A12` / `$10` | bank 13 | bank 13 placement/update; bank 12 `SLAVE_RECEIVE_SETUP_PAYLOAD`; bank 12 setup/resync relay | bank 13 movement/collision/projectile hit tests; bank 0/bank 1 bot helpers; bank 14 renderer; bank 12 checksum/relay | Player Y position, split into low subcell and high maze-cell bytes. |
| `PLAYER_FACING_ANGLE` | `$3A32` / `$10` | bank 13, with bot steering assist in bank 0 | bank 13 turn/update paths; bank 13 placement; bank 0 bot facing alignment; bank 12 setup/resync receive | bank 13 movement and projectile creation; bank 0/bank 1 AI helpers; bank 14 renderer; bank 12 checksum/relay | Player heading angle. Bank 13 applies human/remote input turns using `PLAYER_TURN_RATE`; bot code can also force headings while preparing AI input. |
| `PLAYER_TURN_RATE` | `$3B62` / `$10` | bank 12 setup parameters | bank 12 default fill at the bot/default setup path; `GAMEPLAY_PARAM_RELAY`; setup UI paths | bank 13 turn handling; bank 4 setup UI; bank 12 gameplay-parameter checksum/relay | Per-player angular step used by input bits `$04` and `$08`. Default observed value is `$08`. |
| `PLAYER_MOVE_SPEED_FLAG` | `$3B42` / `$10` | bank 12 setup parameters | bank 12 default fill; `GAMEPLAY_PARAM_RELAY`; setup UI paths | bank 13 movement vector setup; bank 4 setup UI; bank 12 gameplay-parameter checksum/relay | Movement speed option flag. It affects the movement-vector path rather than being part of the setup-state checksum. |
| `PLAYER_STATE` | `$3A72` / `$10` | bank 13 | bank 13 placement clears/sets it; bank 13 hit/state transitions; bank 12 setup/resync receive | bank 13 movement/collision; bank 0/bank 1 target checks; bank 12 checksum/relay | Per-player live/state byte. Nonzero enters the visible movement branch; zero bypasses movement while projectile and timer work can still run. |
| `PLAYER_STATE_TIMER` | `$3AA2` / `$10` | bank 13 | bank 13 state countdown and hit paths; bank 12 setup/resync receive | bank 13 state update; bank 12 checksum/relay | Countdown paired with `PLAYER_STATE`; hit paths reload it from gameplay parameters. |
| `PLAYER_HIT_FLAG` | `$3A92` / `$10` | bank 13 | bank 13 projectile hit path; bank 12 setup/resync receive | bank 14 renderer/status effects; bank 12 checksum/relay | Hit/event flag set when a projectile registers against a player. |
| `PLAYER_HIT_BY_INDEX` | `$3AD2` / `$10` | bank 13 | bank 13 projectile hit path | collision/status paths still under review | Last player index associated with the hit event. It is not part of the bank 12 setup payload. |
| `PLAYER_FIRE_TIMER` | `$3AB2` / `$10` | bank 13 | bank 13 fire cooldown decrement/create paths; bank 12 setup/resync receive | bank 13 fire gate; bank 12 checksum/relay | Per-player fire cooldown countdown. Firing copies `PLAYER_FIRE_COOLDOWN` into this timer. |
| `PLAYER_FIRE_COOLDOWN` | `$3D19` / `$10` | bank 12 setup parameters | bank 12 default fill; `GAMEPLAY_PARAM_RELAY`; setup UI paths | bank 13 fire path; bank 4 setup UI; bank 12 gameplay-parameter checksum/relay | Reload value used after a projectile is fired. Default observed value is `$0A`. |
| `PLAYER_RELOAD_TIMER` | `$3D09` / `$10` | bank 12 setup parameters | bank 12 default fill; `GAMEPLAY_PARAM_RELAY`; setup UI paths | bank 13 hit/state path; bank 4 setup UI; bank 12 gameplay-parameter checksum/relay | State timer reload value used when a player is hit. Default observed value is `$64`. |
| `PLAYER_PROJECTILE_LIFE` | `$3CF9` / `$10` | bank 12 setup parameters | bank 12 default fill; `GAMEPLAY_PARAM_RELAY`; setup UI paths | bank 13 state/projectile path; bank 4 setup UI; bank 12 gameplay-parameter checksum/relay | Duration/value copied into state/projectile logic after specific state transitions. Default observed value is `$32`. |
| `PLAYER_WEAPON_MODE` | `$3CE9` / `$10` | bank 12 setup parameters | bank 12 default fill; `GAMEPLAY_PARAM_RELAY`; setup UI paths | bank 13 fire/state path; bank 4 setup UI; bank 12 gameplay-parameter checksum/relay | Per-player weapon/mode option. Default observed value is `$02`. |
| `PLAYER_PROJECTILE_SPEED_FLAG` | `$3B52` / `$10` | bank 12 setup parameters | bank 12 default fill; `GAMEPLAY_PARAM_RELAY`; setup UI paths | bank 13 projectile vector setup; bank 4 setup UI; bank 12 gameplay-parameter checksum/relay | Projectile speed option flag. |
| `PROJECTILE_X_LO`, `PROJECTILE_X_HI` | `$39C2`, `$39E2` / `$10` | bank 13 | bank 13 fire/create and projectile update; bank 12 projectile clear; bank 12 setup/resync receive | bank 13 projectile movement/collision; bank 12 checksum/relay | Projectile X position, split into low subcell and high maze-cell bytes. |
| `PROJECTILE_Y_LO`, `PROJECTILE_Y_HI` | `$3A02`, `$3A22` / `$10` | bank 13 | bank 13 fire/create and projectile update; bank 12 projectile clear; bank 12 setup/resync receive | bank 13 projectile movement/collision; bank 12 checksum/relay | Projectile Y position, split into low subcell and high maze-cell bytes. |
| `PROJECTILE_ACTIVE_TIMER` | `$3A82` / `$10` | bank 13 | bank 13 fire/create, wall-hit, and player-hit paths; bank 12 projectile clear; bank 12 setup/resync receive | bank 13 projectile update; bank 0 AI checks; bank 12 checksum/relay | Projectile active/lifetime counter. Zero means no active projectile for that player slot. |
| `PROJECTILE_DX_LO`, `PROJECTILE_DX_HI` | `$3B02`, `$3B12` / `$10` | bank 13 | bank 13 projectile vector setup near `L85B0`; bank 12 setup/resync receive | bank 13 projectile movement | Projectile X velocity, split into low and high/sign bytes. These bytes are relayed after the checksum-covered base state. |
| `PROJECTILE_DY_LO`, `PROJECTILE_DY_HI` | `$3B22`, `$3B32` / `$10` | bank 13 | bank 13 projectile vector setup near `L85B0`; bank 12 setup/resync receive | bank 13 projectile movement | Projectile Y velocity, split into low and high/sign bytes. |
| `L3A42` | `$3A42` / `$10` | bank 13 | bank 13 fire/create stores the projectile angle snapshot | bank 13 projectile vector/update paths | Generated label retained. It appears to hold projectile angle/facing at fire time, but needs more trace evidence before promotion. |
| `PLAYER_SCORE_COUNTERS` | `$3AC2` / `$10` | bank 13 scoring | bank 13 scoring; bank 12 setup/reset/command clear; bank 12 setup/resync receive | bank 13 score display/status; bank 12 checksum/relay; bank 4 roster/status UI | Per-player score/frags counter. Score 10 is the observed win threshold in the bank 13 scoring path. |
| `TEAM_SCORE_COUNTERS` | `$3D39` / 4 bytes | bank 13 scoring | bank 13 team-play scoring; bank 12 setup/reset/command clear | bank 13 team score display; bank 12 setup/status paths | Four team score counters used when team play is enabled. |
| `PLAYER_TEAM_INDEX` | `$3AF2` / `$10` | bank 12 setup/roster | bank 12 setup/team assignment and relay | bank 13 team-play scoring; bank 0 target exclusion; bank 4 roster/status UI; bank 12 gameplay-parameter checksum | Per-player team number or assignment metadata. |
| `MAZE_CELL_PLAYER_NEXT` | `$3A52` / `$10` | fixed maze-cell helpers | placement and maze occupancy helper paths | maze occupancy/collision helper paths | Per-player next pointer for maze-cell occupancy lists. It is not transmitted in the setup payload. |
| `PLAYER_INPUT_STATUS` | `$3D29` / `$10` | bank 4 live exchange, bank 0 bot update | bank 4 local/remote input exchange; bank 0 non-human update; bank 12 setup/control byte paths | bank 4 command/status parser; bank 13 slot `$03` byte entry | Packed movement/fire/status byte consumed by bank 13 after being copied to `L00C7`. |

### Setup And Checksum Coverage

Bank 12 `MASTER_SEND_SETUP_PAYLOAD` sends, and
`SLAVE_RECEIVE_SETUP_PAYLOAD` receives, the following per-player state after
the seed bytes: player position, facing, state, hit flag, state timer, fire
timer, score, projectile position, projectile active timer, and projectile
velocity. The order matches the payload-order table in `docs/symbols.md`.

Bank 12 `L99D6` computes the setup-state checksum over the seed bytes and the
position/state/projectile base arrays through `PROJECTILE_ACTIVE_TIMER`; it
does not include projectile velocity bytes. Bank 12 `L9958` separately checks
the gameplay parameter block: `PLAYER_TEAM_INDEX`, `SETUP_TEAM_OPTION_FLAG`,
`PLAYER_FIRE_COOLDOWN`, `PLAYER_RELOAD_TIMER`, `PLAYER_PROJECTILE_LIFE`,
`PLAYER_WEAPON_MODE`, `PLAYER_MOVE_SPEED_FLAG`,
`PLAYER_PROJECTILE_SPEED_FLAG`, and `PLAYER_TURN_RATE`.

### Roster And Slot Metadata

No separate free-form player-name buffer is proven yet. The visible roster
labels are generated from `STATUS_PLAYER_LABEL_TEMPLATE` into `L3DFC` and then
sent or displayed by bank 12 and bank 4 roster/status paths. `PLAYER_TEAM_INDEX`
is the clearest per-slot metadata array. `L3DB7` appears to be a score display
cache, and `L3DC7` is used as a setup/reset score mirror, but both remain
generated labels until their lifetimes are mapped more tightly.

`L3A42`, `L3AE2`, `L396C`, `L396D`, and `L3970` also remain generated. The
first two are associated with projectile/hit state, while the latter three are
setup/control scalars visible in bank 13 placement and game-over style paths.
They are documented here as trace targets rather than promoted names.

## Human Versus Bot Split

The roster is a single contiguous player-index space. Human players always
occupy the low indexes `0..HUMAN_PLAYER_COUNT-1`. Bot/non-human players occupy
the following indexes `HUMAN_PLAYER_COUNT..TOTAL_PLAYER_COUNT-1`. All of them
feed the same `PLAYER_INPUT_STATUS` and player-state arrays before bank 13
movement/projectile logic consumes the slot.

### Count And Index Variables

| Variable | Address | Writer/owner | Meaning |
|---|---:|---|---|
| `LOCAL_PLAYER_INDEX` | `$3968` | bank 12 setup/probe paths | This machine's human player slot. Player 0 is the setup/resync master and drives several transmit paths. |
| `HUMAN_PLAYER_COUNT` | `$396B` | bank 12 setup, roster exchange, resync | Number of human stations/slots in the ring. Bank 4 live transport exchange scans only this range. |
| `TOTAL_PLAYER_COUNT` | `$396E` | bank 12 `CLAMP_TOTAL_PLAYER_COUNT` | Total active roster after adding bots and clamping to the maze-size-dependent player limit. Bank 0 and display/status paths stop here. |
| `BOT_COUNT_TARGET` | `$3EED` | bank 12 setup/resync | Count of bot type `$00` slots. |
| `BOT_COUNT_DRONE` | `$3EEE` | bank 12 setup/resync | Count of bot type `$01` slots. |
| `BOT_COUNT_NINJA` | `$3EEF` | bank 12 setup/resync | Count of bot type `$02` slots. During resync, it is packed in the low nibble with Nasty in the high nibble. |
| `BOT_COUNT_NASTY` | `$3F13` | bank 12 setup/resync | Count of bot type `$03` slots. |
| `PLAYER_BOT_TYPE` | `$3F16` / `$10` | bank 1 setup helper | Per-player bot dispatch type. Human slots remain `$FF`; bot slots are `$00-$03`. |

`CLAMP_TOTAL_PLAYER_COUNT` sums
`HUMAN_PLAYER_COUNT + BOT_COUNT_TARGET + BOT_COUNT_DRONE + BOT_COUNT_NINJA +
BOT_COUNT_NASTY`, compares that sum with the current maze-size player limit,
and stores the result in `TOTAL_PLAYER_COUNT`. If the requested sum is too
large, it clears all four bot counts and falls back to
`TOTAL_PLAYER_COUNT = HUMAN_PLAYER_COUNT`.

### Slot Ranges

| Range | Filled by | Live update path | Notes |
|---|---|---|---|
| `0..HUMAN_PLAYER_COUNT-1` | bank 12 setup/ring negotiation | bank 4 slot `$13` writes `PLAYER_INPUT_STATUS` for local and remote human slots | `LOCAL_PLAYER_INDEX` identifies the one slot that reads `STICK0`/`STRIG0`; the other human slots are received from transport. |
| `HUMAN_PLAYER_COUNT..TOTAL_PLAYER_COUNT-1` | bank 1 bot-type setup from the four bot counts | bank 0 slot `$22` writes bot `PLAYER_INPUT_STATUS` and some facing/control state | These slots do not participate in the bank 4 live human status exchange. |
| `TOTAL_PLAYER_COUNT..15` | setup/reset scratch only | no live roster update | Arrays may still be initialized or cleared, but live loops generally stop before these indexes. |

### Bot Type Assignment

Bank 1 initializes bot runtime arrays, stores `$FF` in `PLAYER_BOT_TYPE` for
the initialized roster, then fills bot slots starting at `HUMAN_PLAYER_COUNT`:

| `PLAYER_BOT_TYPE` value | Count source | Bank 0 dispatch target | Meaning |
|---:|---|---|---|
| `$FF` | human or inactive slot | skipped by bank 0 dispatcher | Not a bot-controlled slot. |
| `$00` | `BOT_COUNT_TARGET` | `L80A4` | Target-style bot. |
| `$01` | `BOT_COUNT_DRONE` | `L80F2` | Drone bot. |
| `$02` | `BOT_COUNT_NINJA` | `L819C` | Ninja bot. |
| `$03` | `BOT_COUNT_NASTY` | `L81EC` | Nasty bot. |

Bank 0 slot `$22` starts at `HUMAN_PLAYER_COUNT`, copies the current slot to
`L40CB`, checks `PLAYER_BOT_TYPE,X`, and dispatches only bot types `$00-$03`.
It increments `L40CB` until it reaches `TOTAL_PLAYER_COUNT`, then returns
through `BANK_RETURN`.

### Human Local And Remote Handling

Bank 4 slot `$13` uses `HUMAN_PLAYER_COUNT` as the live exchange length. It
packs the local joystick/status byte into
`PLAYER_INPUT_STATUS[LOCAL_PLAYER_INDEX]`, sends it, and then walks the human
ring backward to receive the other human slots. The completion scan at `L821E`
also stops at `HUMAN_PLAYER_COUNT`, so bot slots are never parsed as incoming
human command/status bytes.

This gives all active players the same final movement interface:

| Player kind | Source of `PLAYER_INPUT_STATUS` | Movement consumer |
|---|---|---|
| Local human | bank 4 reads `STICK0`, `STRIG0`, and local command bytes | bank 13 slot `$03` copies the selected slot byte to `L00C7`. |
| Remote human | bank 4 receives bytes through `NET_CALL_VECTOR_0/2` and stores them by human slot | bank 13 slot `$03` uses the same `L00C7` movement/fire decode. |
| Bot | bank 0 AI paths write `PLAYER_INPUT_STATUS` and steering/facing state for slots at or above `HUMAN_PLAYER_COUNT` | bank 13 slot `$03` uses the same movement/fire decode once that bot slot is selected. |

The important FujiNet implication is that network transport should produce
valid human-slot status bytes only. Bot scheduling is local gameplay state
derived from shared setup counts and should stay behind the
`HUMAN_PLAYER_COUNT..TOTAL_PLAYER_COUNT-1` boundary.

## Gameplay Bank-Call Map

The game uses the fixed-bank `BANK_CALL_INDEXED` trampoline at `$AF1D` for
cross-bank service calls. `X` is the slot index. The target address and bank are
read from `BANK_CALL_ADDR_LO` (`$3D3E`), `BANK_CALL_ADDR_HI` (`$3D66`), and
`BANK_CALL_BANK_ID` (`$3D8E`). The fixed bank initializes 37 slots from the
packed table at bank 15 `LB03F`; bank 12 then repoints selected volatile slots
during setup and gameplay.

### Gameplay-Critical Calls

| Slot | Normal target | Gameplay role | Extension risk |
|---:|---|---|---|
| `$13` | bank 4 `BANK4_NET_COMMAND_SERVICE_ENTRY` | Main transport/command service. Bank 12 calls it in `L9A2D`, pre-live waits, resync waits, and hold/sync loops. | Best future FujiNet service hook, but hot and volatile. It must preserve `L3EB9`, `NET_ERROR_CODE`, `PENDING_NET_COMMAND`, `OUTGOING_NET_COMMAND`, and `PLAYER_INPUT_STATUS`. |
| `$22` | bank 0 `BANK0_GAMEPLAY_UPDATE_ENTRY` | Bot/non-human gameplay update after slot `$13` has completed the current human exchange. | Do not use as a transport hook; it owns local bot scheduling. |
| `$0D` | bank 13 `BANK13_ROSTER_STATUS_SERVICE_ENTRY` | High-frequency status/roster/display polling in setup, pre-live, hold/sync, and live-adjacent waits. | Avoid transport work here. It is display/status service, not byte transport. |
| `$03` | bank 13 `BANK13_PLAYER_MAZE_UPDATE_ENTRY` | Registered player/maze/projectile update entry. It consumes `PLAYER_INPUT_STATUS` for the selected slot when called. | No active bank 12 caller is proven yet; keep as a trace target, not an insertion point. |
| `$11` | volatile | Patched by bank 12 to current-bank setup/gameplay loop entries. | Not reusable. It is a bank-local continuation slot and depends on `BANK_CALL_BANK_ID[$11] = L008C`. |
| `$1B` | bank 4 `BANK4_NET_STATE_RESET_ENTRY` or `BANK_RETURN` | Reset/prepare bank 4 network state before setup/gameplay loops. | Volatile. Future hooks must tolerate it being patched to `BANK_RETURN` during setup. |
| `$24` | bank 4 `BANK4_SLOT24_SERVICE_ENTRY` | Hold/sync helper path used while slot `$13` can be redirected. | Not a general hook; tied to hold/sync recovery. |

### Bank 12 Gameplay Patching

Bank 12 owns the gameplay bank-call shape:

| Patch site | Slot changes | Purpose |
|---|---|---|
| `L863D` | `$11 -> current bank $9007`; `$1B -> BANK_RETURN`; `$13 -> BANK_RETURN` | Shared setup convergence. It disables the bank 4 network slots until the setup path is ready to restore them. |
| `L93F8` | `$11 -> current bank $9A15`; `$1B -> bank 4 $8018`; `$13 -> bank 4 $8000` | Main setup/gameplay command-loop entry. Restores bank 4 network service and reset slots. |
| `L9504` | same as `L93F8` | Alternate command-loop entry after `LB224`. |
| `L95D0` / `L9613` | `$13 -> BANK_RETURN`, then `$13 -> bank 4 $8000` | Hold/sync master path temporarily suppresses normal slot `$13` service while callback-vector helpers run. |

The live service slice at `L9A2D` calls slot `$13`, checks error and pending
command state, spins while `L3EB9` is nonzero, and only then calls slot `$22`.
This order is the core transport/gameplay contract: complete or advance the
human-byte exchange before local bot updates run.

No currently documented slot is safe to repurpose as unused. Some initial table
entries have no proven active caller yet, but their targets are still part of
the cartridge's initialized bank-call table and may be reachable through mixed
byte-form paths or future trace findings.

## Network Commands And Control Bytes

There are two related byte paths:

- Live command/control bytes are usually carried as a high-bit
  `PLAYER_INPUT_STATUS` marker plus a companion byte in `$2B00 + player`.
- Setup payload markers such as `MARKER_SETUP_PAYLOAD` are sent directly
  through `NET_CALL_VECTOR_1` and checked through `NET_VECTOR_WAIT_POLL`, not
  through the bank 4 live `PLAYER_INPUT_STATUS` parser.

### Command Values

| Name | Value | Path | Current meaning |
|---|---:|---|---|
| `CMD_INIT_RING` | `$80` | live high-bit companion / direct hold ack | Pre-live/start or ring-init companion. Bank 12 stores it in `OUTGOING_NET_COMMAND` at `L9923`; bank 4 injects it into the next slot `$13` exchange. Hold/sync code also uses raw `$80` as an acknowledge byte. |
| `CMD_CLEAR_STATE` | `$81` | live high-bit companion | Clear transient score/state mirrors. Sent from bank 12 setup command loop and dispatched by `NET_COMMAND_DISPATCH` to clear `L3DC7`, `PLAYER_SCORE_COUNTERS`, and `TEAM_SCORE_COUNTERS`. |
| `CMD_HOLD_SYNC` | `$82` | live high-bit companion | Hold/pause/sync command. Queued by console/hold paths and handled by `NET_COMMAND_DISPATCH` through the `L95CB` hold/sync flow. |
| `MARKER_SETUP_PAYLOAD` | `$83` | setup/resync direct marker | Marks the start of `MASTER_SEND_SETUP_PAYLOAD` / `SLAVE_RECEIVE_SETUP_PAYLOAD`. It is echoed/verified before setup payload bytes are exchanged. |
| `CMD_RESYNC` | `$84` | live high-bit companion | Resync command. Queued by setup/live console paths and dispatched to `RESYNC_COMMAND`, where player 0 transmits setup state and other stations receive it. |
| `CMD_ROSTER_EXCHANGE` | `$86` | live high-bit companion | Roster exchange command. Queued by bank 12 command loops and dispatched to `L8F57`. |
| `CMD_START_GAME` | `$87` | not actively referenced | Named in `include/game_ram.inc`, but no active source reference is currently proven. Treat as reserved/unverified until a trace or hidden byte path proves usage. |

### Pending Command Lifecycle

`PENDING_NET_COMMAND` is the received-command latch at `$3EE7`.

| Step | Location | Effect |
|---:|---|---|
| 1 | bank 4 `L821E-L82C7` | After a completed human exchange, bank 4 scans `PLAYER_INPUT_STATUS` for negative/high-bit first bytes. If the companion byte in `$2B00,X` is negative and not `$FF`, it stores that companion in `PENDING_NET_COMMAND`. |
| 2 | bank 12 command loops `L9430`, `L953F`, `L9A2D`, hold/wait paths | Bank 12 treats nonzero `PENDING_NET_COMMAND` as a reason to dispatch, pause, resync, or exit the current wait loop. |
| 3 | `NET_COMMAND_DISPATCH` | Clears `PENDING_NET_COMMAND` before comparing it with known commands. `$81`, `$82`, `$84`, and `$86` have confirmed dispatch paths. |
| 4 | wait/hold paths | Several loops clear `PENDING_NET_COMMAND` after consuming an expected command, especially while waiting for `$84` resync or termination conditions. |

### Outgoing Command Lifecycle

`OUTGOING_NET_COMMAND` is the queued-command byte at `$3EE8`.

| Step | Location | Effect |
|---:|---|---|
| 1 | bank 12 setup/live paths | Bank 12 stores command bytes such as `$80`, `$81`, `$82`, `$84`, or `$86` into `OUTGOING_NET_COMMAND` when local console/menu state requests a network action. |
| 2 | bank 4 slot `$13` at `L808E-L8115` | If `OUTGOING_NET_COMMAND` is nonzero at the start of an exchange, bank 4 clears the latch, stores the command byte into `$2B00 + LOCAL_PLAYER_INDEX`, and forces the local first byte high with `$80`. |
| 3 | bank 4 `L815B-L8170` | The high-bit first byte is sent through `NET_CALL_VECTOR_1`; because it is negative, the companion command byte is sent immediately after it. |
| 4 | remote bank 4 parser | Remote machines receive the high-bit first byte, read the companion byte, and later latch the negative companion into `PENDING_NET_COMMAND`. |

### High-Bit Behavior

Bank 4 distinguishes ordinary input from command/control by signedness:

| Byte | Test | Meaning |
|---|---|---|
| First `PLAYER_INPUT_STATUS` byte non-negative | `BPL` at bank 4 receive/scan paths | Ordinary movement/fire/status byte. `$2B00,X` is set to `$FF`. |
| First `PLAYER_INPUT_STATUS` byte negative | `BMI` at bank 4 receive/scan paths | Companion byte follows and is stored in `$2B00,X`. |
| Companion byte negative and not `$FF` | bank 4 `L822E-L8246` | Latched into `PENDING_NET_COMMAND`. |
| Companion byte `$FF` | bank 4 `L822E-L8246` | No command for that player. |
| Companion byte `$08` or `$0D` | bank 4 `L8246-L829F` | Local/status trail editing/display control, not a pending network command. |

Keyboard/control bytes read locally before packet packing are separate from
the named network commands: `$9B` clears the input trail and maps to companion
`$0D`; `$7E` backs up the trail and maps to companion `$08`; `$7F` toggles
`SETUP_SYNC_TOGGLE_FLAG`; `$1B` sets `SETUP_HOLD_SYNC_FLAG`.

### Setup Versus Live Commands

| Category | Values | Carrier | Notes |
|---|---|---|---|
| Setup payload marker | `$83` | direct `NET_CALL_VECTOR_1` / `NET_VECTOR_WAIT_POLL` | Used by `MASTER_SEND_SETUP_PAYLOAD` and `SLAVE_RECEIVE_SETUP_PAYLOAD`; failure reports `ERR_NETWORK`. |
| Setup/menu control commands | `$81`, `$82`, `$84`, `$86` | high-bit companion through bank 4 slot `$13` | Bank 12 command loops before live play queue these in `OUTGOING_NET_COMMAND` and wait for `PENDING_NET_COMMAND`. |
| Pre-live start/init | `$80` | high-bit companion through slot `$13`; raw ack in hold/sync | Used when leaving pre-live waits and as a raw hold/sync acknowledge byte. |
| Live gameplay commands | `$82`, `$84` primarily | high-bit companion through slot `$13` | Live service and hold/pause loops use these for hold/sync and resync/continue behavior. Other pending commands can terminate or return to menu depending on the wait path. |
