# MIDI Maze Readability And Renaming Plan

This is the persistent plan for turning the byte-exact MIDI Maze rebuild into
human-readable source. Keep this document updated as work progresses. Check off
items only after `make compare` still reports an exact ROM match.

## Ground Rules

- Binary correctness stays mandatory. Every phase must end with `make compare`.
- Prefer comments before renames when a role is not fully proven.
- Rename only stable labels whose behavior is established by call sites,
  cross-bank tables, data references, or emulator traces.
- Keep ambiguous code/data regions as `.byte` until proven executable.
- Keep generated `Lxxxx` names where they are just addresses with unknown role.
- When promoting a RAM address to a shared name, add it to `include/game_ram.inc`
  only after cross-bank meaning is clear.
- When naming a routine, document its observed inputs, outputs, clobbers, and
  relevant bank-call slot if known.
- After each Phase if successful, commit changes with a brief yet descriptive message

## Progress Log

- [x] Establish byte-exact rebuild with MADS.
- [x] Split active sources into `src/banks`.
- [x] Add shared include files for Atari OS, hardware, cartridge, fixed-bank
  services, and confirmed game RAM.
- [x] Preserve pure fill/data banks as explicit bytes where the disassembly was
  misleading.
- [x] Name fixed-bank bank-call trampoline and return path:
  `BANK_CALL_INDEXED`, `BANK_RETURN`.
- [x] Name fixed-bank MIDI/POKEY serial handlers and helper routines.
- [x] Name confirmed network/setup RAM addresses in `include/game_ram.inc`.
- [x] Propagate confirmed shared names through bank sources.
- [x] Document initial `BANK_CALL_INDEXED` slot table in `docs/symbols.md`.

## Phase 1: Bank-Call Entry Points

Goal: make cross-bank control flow understandable before deep routine renames.

- [x] Name bank 4 entry stubs targeted by slots `$13-$1F` and `$24`.
  - Targets: `$8000`, `$8003`, `$8006`, `$8009`, `$800C`, `$800F`, `$8012`,
    `$8015`, `$8018`, `$801B`, `$801E`, `$8021`, `$8024`, `$8027`.
  - For each target, document observed call sites and command/state variables
    touched.
  - Update `docs/symbols.md` bank-call table with new names.
- [x] Name bank 13 service routines targeted by slots `$08`, `$0A-$10`.
  - Targets: `$8900`, `$8E00`, `$8E96`, `$8EC0`, `$9090`, `$9115`, `$91F6`,
    plus any adjacent landing labels proved by control flow.
  - Determine whether each service is setup, roster, input, drawing, or network
    command related.
- [x] Name bank 14 services targeted by slots `$04-$07`, `$09`.
  - Start with `$8000`, `$8011`, `$81FB`, `$9C00`, `$9C9B`.
  - Identify whether these are setup/menu/drawing helpers.
- [x] Name fixed-bank targets for slots `$00`, `$01`.
  - Targets: `$B511`, `$B579`.
  - Document whether these are display initialization, PMG setup, or frame
    service routines.
- [x] Name slot `$12` target in bank 12 and document why `CART_STRT` enters it
  before installing MIDI.
- [x] Document all volatile slot patches with source labels, patched target,
  selected bank, and reason.
  - Known volatile slots: `$11`, `$13`, `$1B`.

Verification gate:

- [x] `make compare` exact after Phase 1.
- [x] `docs/symbols.md` bank-call table contains names rather than raw addresses
  for all confirmed slot targets.

## Phase 2: Fixed-Bank Helper Naming

Goal: make resident services in bank 15 readable and safe to call from named
banked code.

- [x] Comment and name helper routines around `$AF76-$B03F`.
  - Former generated labels of interest: `LAF76`, `LAF82`, `LAF87`, `LAFAE`,
    `LAFDA`, `LAFDD`, `LAFE0`, `LAFE3`, `LAFE9`, `LAFEC`, `LAFEF`, `LAFF6`,
    `LB0AE`, `LB0C7`, `LB0D5`.
- [x] For each helper, document:
  - Inputs in `A`, `X`, `Y`, and zero page.
  - Return value and flags.
  - Error behavior through `NET_ERROR_CODE`.
  - Whether it calls through vectors or bank-call slots.
- [x] Promote confirmed helper names into `include/fixed_bank.inc`.
- [x] Replace generated helper labels in all banks with the shared names.
- [x] Update `docs/symbols.md` with fixed-bank helper notes.

Verification gate:

- [x] `make compare` exact after Phase 2.
- [x] No old fixed-bank helper labels remain in active code except in comments
  preserving historical context.

## Phase 3: Network And Setup State Map

Goal: replace the dense `$3Exx/$3Fxx` generated labels with documented state
names where proven.

- [x] Map `$3ECF-$3EEB` network/setup state.
  - Determine timeout counters, callback vectors, command bytes, and status
    fields.
- [x] Map `$3F07-$3F13` setup flags and bot/player fields.
- [x] Map `$3CE6-$3D39` setup/roster buffers.
- [x] Confirm and name vector storage used by `NET_CALL_VECTOR_0`,
  `NET_CALL_VECTOR_1`, `NET_CALL_VECTOR_2`, and related fixed-bank indirect
  jumps.
- [x] Promote cross-bank state names into `include/game_ram.inc`.
- [x] Replace generated labels with names only after the state role is clear.
- [x] Add a `Network State Map` section to `docs/symbols.md`.

Verification gate:

- [x] `make compare` exact after Phase 3.
- [x] `docs/symbols.md` describes each newly named state byte/range and the
  evidence used.

## Phase 4: Player, Roster, And Gameplay Arrays

Goal: make per-player and per-roster arrays readable.

- [x] Identify `$3968-$3971` core player/setup scalar fields.
  - Promoted the proven scalars and `MAZE_LINK_PLAYER_INDEX`; left `L396C`,
    `L396D`, and `L3970` generated until their setup-flow roles are stronger.
- [x] Map the `$39B2-$3B62` arrays, especially the repeating `$10`-spaced
  player/roster fields.
- [x] Map `$3A02`, `$3A12`, `$3A22`, `$3A32`, `$3A52`, `$3A72`, `$3A82`,
  `$3A92`, `$3AA2`, `$3AB2`, `$3AC2`, `$3AF2`, `$3B02`, `$3B12`, `$3B22`,
  `$3B32`, `$3B42`, `$3B52`, `$3B62`.
- [x] Cross-check these arrays against setup payload order and gameplay
  parameter relay code in bank 12.
- [x] Add array names to `include/game_ram.inc` when stable.
- [x] Update protocol comments in bank 12 to use the array names.

Verification gate:

- [x] `make compare` exact after Phase 4.
- [x] A table in `docs/symbols.md` maps each named player/roster array to its
  address, stride, observed payload order, and role.

## Phase 5: UI, Message, And Menu Labels

Goal: make user-facing strings, status messages, and menu code readable.

- [x] Name `PRINT_STATUS_MESSAGE` message table entries.
- [x] Name known status/error message data, including "Can't sync", "too many",
  "machines", "timeout", and related setup/network messages.
- [x] Name menu/input routines that write `NET_ERROR_CODE` or dispatch setup
  options.
- [x] Name display-list, screen buffer, PMG, and color setup routines where
  confirmed.
- [x] Keep text/data bytes intact. Convert byte runs into named tables only if
  `make compare` remains exact.
  - Promoted the confirmed status-line buffers and message tables. Broader
    display/PMG internals remain for the bank-by-bank Phase 6 pass.

Verification gate:

- [x] `make compare` exact after Phase 5.
- [x] User-facing messages have named labels or adjacent comments.

## Phase 6: Bank-By-Bank Routine Naming

Goal: finish routine-level readability without inventing behavior.

Work bank by bank. For each bank:

- [ ] Add a bank-local map comment listing code/data ranges.
- [ ] Name every proven routine entry point.
- [ ] Add one-line comments for remaining generated labels that are referenced
  but not renamed.
- [ ] Mark likely data blocks and tables.
- [ ] Update cross-bank docs if any routine is called through a bank-call slot
  or fixed-bank helper.

Bank checklist:

- [ ] Bank 00 documented and named.
- [ ] Bank 01 documented and named.
- [ ] Bank 02 documented and named.
- [ ] Bank 03 documented as fill/data.
- [ ] Bank 04 documented and named.
- [ ] Bank 05 documented and named.
- [ ] Bank 06 documented and named.
- [ ] Bank 07 documented as fill/data.
- [ ] Bank 08 documented as packed data.
- [ ] Bank 09 documented as packed data.
- [ ] Bank 10 documented as packed data.
- [ ] Bank 11 documented as packed data.
- [ ] Bank 12 documented and named.
- [ ] Bank 13 documented and named.
- [ ] Bank 14 documented and named.
- [ ] Bank 15 documented and named.

Verification gate:

- [ ] `make compare` exact after every bank.
- [ ] Every bank has a clear top-level map and no unexplained high-traffic
  routine labels.

## Phase 7: Final Human-Readable Pass

Goal: make the whole source tree navigable for future work.

- [ ] Remove redundant generated aliases that have stable shared names.
- [ ] Normalize comment style and terminology across banks.
- [ ] Ensure all shared symbols are defined once in `include/*.inc`.
- [ ] Ensure `docs/symbols.md` is an index, not the only place critical meaning
  exists.
- [ ] Add README guidance for naming/commenting workflow.
- [ ] Run `make clean compare listing`.
- [ ] Optionally run `make run` with `atari800-ai` and record emulator status.

Final definition of done:

- [ ] All executable entry points have human-readable names or documented reason
  for retaining `Lxxxx`.
- [ ] All shared RAM and hardware/OS addresses have stable names where proven.
- [ ] All known tables/data blocks have labels or comments.
- [ ] The ROM remains byte-exact.
- [ ] The source can be navigated from README, `docs/symbols.md`, this plan,
  and bank-local map comments.

## How To Use This Plan

At the start of each readability session:

1. Read this file.
2. Pick the first unchecked item with enough evidence to proceed.
3. Make the smallest useful rename/comment batch.
4. Run `make compare`.
5. Update this file by checking completed items and adding evidence notes.
6. Update `docs/symbols.md` or includes when new names become stable.
