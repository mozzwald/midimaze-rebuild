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
- [ ] Incoming player data path mapped.
- [ ] Player state arrays deep-mapped.
- [ ] Human versus bot split mapped.
- [ ] Network command/control bytes mapped.
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
| bank 0 | slot `$22` `BANK0_GAMEPLAY_UPDATE_ENTRY` | Non-human/bot gameplay update. It starts at `HUMAN_PLAYER_COUNT`, stores the current slot in `L40CB`, dispatches on `L3F16,X`, and stops at `TOTAL_PLAYER_COUNT`. |
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
