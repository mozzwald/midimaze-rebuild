# MIDI Maze Gameplay Notes

This document collects gameplay control-flow findings from
`ref/GAMEPLAY_FUJINET_RESEARCH_PLAN.md`.

Keep this file focused on how the current game works: mode selection, setup
paths, main gameplay loop, player data flow, state arrays, bot/human handling,
commands, and maze buffers. Future FujiNet design notes belong in
`docs/fujinet-porting.md`.

## Current Status

- [x] Mode selection and setup state mapped.
- [ ] Main gameplay loop mapped.
- [ ] Transport-specific setup paths mapped.
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
