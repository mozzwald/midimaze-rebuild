# MIDI Maze Gameplay And FujiNet Research Plan

This is the persistent plan for documenting the gameplay paths deeply enough to
support a future FujiNet transport. The goal is still understanding first:
comments, symbols, tables, and trace notes before behavior changes.

## Ground Rules

- Preserve byte-exact output until a later plan explicitly begins FujiNet code
  changes.
- Treat every source edit as documentation or naming unless a phase explicitly
  says otherwise.
- Run `make compare` after each source rename/comment batch.
- Commit each completed phase with a brief descriptive message.
- Prefer bank-local comments first; promote names into `include/*.inc` only
  when a variable/routine is clearly shared across banks.
- Keep transport behavior separate from gameplay behavior in the docs. MIDI,
  modem, 850, solo/local, and future FujiNet paths should be easy to compare.
- Record unknowns explicitly. Do not invent semantic names for labels whose
  role is only guessed.

## Primary Artifacts

- `docs/gameplay.md`: gameplay loop, player update, input/status, maze, and
  state-array documentation.
- `docs/fujinet-porting.md`: constraints and future insertion points for a
  FujiNet transport.
- `docs/symbols.md`: stable symbol index. Use this for promoted names, not for
  long-form flow notes.
- `include/game_ram.inc`: shared RAM names only after roles are proven.
- Bank-local source comments: nearest useful explanation for routines and data.

## Progress Log

- [x] Create the gameplay/FujiNet research plan and add agent guidance.
- [x] Complete Phase G1 mode selection map for SOLO, MIDI-MATE, XM301,
  SX212, and Atari 850 setup paths.

## Phase G1: Mode Selection And Setup State

Goal: map mode selection values and where setup mode is stored/read.

- [x] Identify every write to `SETUP_LINK_MODE`.
- [x] Identify every read/branch on `SETUP_LINK_MODE`.
- [x] Map confirmed mode values:
  - [x] solo/local
  - [x] MIDIMATE
  - [x] XM301/SX212 modem
  - [x] Atari 850 interface
- [x] Document the menu/status text or input path that selects each mode.
- [x] Document mode-dependent setup branches in bank 12.
- [x] Add stable constants to `include/game_ram.inc` only when each value is
  proven.

Verification gate:

- [x] `docs/gameplay.md` contains a mode-selection table with value, source
  location, branch targets, and transport meaning.
- [x] `make compare` exact if source comments/names changed.

## Phase G2: Main Gameplay Loop And Bank Ownership

Goal: define the live gameplay frame/control loop and its bank-call structure.

- [ ] Identify the primary bank 12 live gameplay loop entry and re-entry paths.
- [ ] Identify where bank-call slot `$13` is called during live gameplay.
- [ ] Identify where bank 13 player movement/collision/projectile update is
  called.
- [ ] Identify where bank 0 local/bot/gameplay update is called.
- [ ] Document loop order: input, transport service, player update, bot update,
  drawing/status, command dispatch, exit conditions.
- [ ] Document volatile bank-call slot patching relevant to gameplay.

Verification gate:

- [ ] `docs/gameplay.md` has a main gameplay loop call graph with bank, slot,
  routine, inputs, outputs, and exit paths.
- [ ] `docs/fujinet-porting.md` lists the gameplay-loop insertion points that
  are safe candidates for future FujiNet service calls.
- [ ] `make compare` exact if source comments/names changed.

## Phase G3: Transport-Specific Setup Paths

Goal: split setup flow by transport while preserving the shared post-setup path.

- [ ] Document MIDIMATE initialization and its jump into shared setup.
- [ ] Document modem initialization for XM301/SX212-style paths.
- [ ] Document Atari 850 initialization and status/probe behavior.
- [ ] Document solo/local initialization.
- [ ] Identify the shared code after transport setup converges.
- [ ] Document which vectors/callbacks are patched per transport.
- [ ] Document error paths and `NET_ERROR_CODE` values per transport.

Verification gate:

- [ ] `docs/gameplay.md` has a transport setup table with entry routine,
  callbacks, setup mode, success target, and failure target.
- [ ] `docs/fujinet-porting.md` has a first-pass "FujiNet setup analogue"
  section listing which existing transport path is closest.
- [ ] `make compare` exact if source comments/names changed.

## Phase G4: Incoming Player Data Path

Goal: trace remote input/status bytes from transport read to gameplay consume.

- [ ] Identify where raw bytes are read from MIDI/transport during gameplay.
- [ ] Identify where command/control bytes are separated from player data.
- [ ] Identify where remote player bytes are stored.
- [ ] Identify all writes to `PLAYER_INPUT_STATUS`.
- [ ] Identify all consumers of `PLAYER_INPUT_STATUS`.
- [ ] Document local player input packing versus remote input unpacking.
- [ ] Document timing/latency assumptions, including ring-buffer polling and
  frame boundaries.

Verification gate:

- [ ] `docs/gameplay.md` has an incoming player data flow from transport read
  to `PLAYER_INPUT_STATUS` consumer.
- [ ] `docs/fujinet-porting.md` lists the minimum semantics a FujiNet RX path
  must preserve.
- [ ] `make compare` exact if source comments/names changed.

## Phase G5: Player State Arrays Deep Map

Goal: document each gameplay state array beyond setup payload order.

- [ ] Map position arrays: `PLAYER_X_LO/HI`, `PLAYER_Y_LO/HI`.
- [ ] Map facing/turning arrays: `PLAYER_FACING_ANGLE`, `PLAYER_TURN_RATE`.
- [ ] Map alive/dead/state arrays: `PLAYER_STATE`,
  `PLAYER_STATE_TIMER`, `PLAYER_HIT_FLAG`, `PLAYER_HIT_BY_INDEX`.
- [ ] Map projectile arrays: projectile position, velocity, active timer, fire
  timer, projectile life/speed flags, weapon mode.
- [ ] Map score/kills arrays: `PLAYER_SCORE_COUNTERS`,
  `TEAM_SCORE_COUNTERS`.
- [ ] Identify player name/slot metadata and any roster/status tables.
- [ ] Document which bank owns writes and which bank owns reads for each array.

Verification gate:

- [ ] `docs/gameplay.md` has an array table with address, stride, owner bank,
  writer routines, reader routines, and gameplay meaning.
- [ ] Stable names promoted only where evidence is cross-bank strong.
- [ ] `make compare` exact if source comments/names changed.

## Phase G6: Human Versus Bot Split

Goal: define the player index ranges and how bot/human update differs.

- [ ] Document `HUMAN_PLAYER_COUNT`.
- [ ] Document `TOTAL_PLAYER_COUNT`.
- [ ] Document `LOCAL_PLAYER_INDEX`.
- [ ] Identify where bot counts are converted into active player slots.
- [ ] Identify where bots are updated.
- [ ] Identify where human players are skipped, included, or treated as remote.
- [ ] Document how local, remote, and bot players feed the same state arrays.

Verification gate:

- [ ] `docs/gameplay.md` has a human/remote/bot player-index model.
- [ ] `docs/fujinet-porting.md` describes whether FujiNet changes should
  affect only human remote slots or also bot scheduling.
- [ ] `make compare` exact if source comments/names changed.

## Phase G7: Bank-Call System For Gameplay Extension

Goal: document bank-call mechanics specifically for future gameplay transport
changes.

- [ ] Document dispatch table locations and initialization source.
- [ ] Document how bank 12 calls bank 4, bank 13, and bank 0 during gameplay.
- [ ] Document volatile slot usage and patch sites.
- [ ] Identify bank-call slots that are gameplay-critical and must not be
  repurposed.
- [ ] Identify any unused or safely redirectable slots only if proven.
- [ ] Define a safe future pattern for FujiNet-specific bank calls without
  breaking current bank layout.

Verification gate:

- [ ] `docs/fujinet-porting.md` has a bank-call extension strategy with risks.
- [ ] `docs/symbols.md` is updated if new stable slot names are promoted.
- [ ] `make compare` exact if source comments/names changed.

## Phase G8: Network Commands And Control Bytes

Goal: define setup/gameplay command bytes and high-bit behavior.

- [ ] Document command values already named in `include/game_ram.inc`.
- [ ] Identify pending command variable lifecycle through
  `PENDING_NET_COMMAND`.
- [ ] Identify outgoing command lifecycle through `OUTGOING_NET_COMMAND`.
- [ ] Document high-bit/negative byte behavior in the transport parser.
- [ ] Split setup-only commands from live gameplay commands.
- [ ] Document command dispatch routines and expected acknowledgements.

Verification gate:

- [ ] `docs/gameplay.md` has command tables for setup and gameplay.
- [ ] `docs/fujinet-porting.md` lists command semantics FujiNet must preserve.
- [ ] `make compare` exact if source comments/names changed.

## Phase G9: Map And Maze Load Path

Goal: understand how maze data reaches the gameplay buffer.

- [ ] Identify where built-in mazes are selected.
- [ ] Identify where external/custom maze data is loaded or copied.
- [ ] Document the final maze buffer layout used by gameplay.
- [ ] Identify wall/cell encoding, player spawn placement, and maze-size
  limits.
- [ ] Document which banks read/write maze buffers during gameplay.

Verification gate:

- [ ] `docs/gameplay.md` has a maze-load flow and final buffer layout.
- [ ] Source comments identify maze buffer readers/writers where proven.
- [ ] `make compare` exact if source comments/names changed.

## Phase G10: RAM Pressure And Scratch Audit

Goal: identify realistic memory space for future FujiNet buffers and code
hooks.

- [ ] Map unused or low-risk RAM ranges.
- [ ] Map temporary buffers and their lifetime.
- [ ] Audit zero-page scratch candidates and current live ranges.
- [ ] Document existing RX/TX buffers and whether they are reusable.
- [ ] Identify bank-local versus fixed-bank code space pressure.
- [ ] Record emulator-trace checks needed before claiming RAM is free.

Verification gate:

- [ ] `docs/fujinet-porting.md` has a RAM/code-space risk table.
- [ ] No RAM range is marked free without evidence and a validation method.
- [ ] `make compare` exact if source comments/names changed.

## Phase G11: FujiNet Design Boundary

Goal: convert the gameplay documentation into a concrete future implementation
boundary, without implementing it yet.

- [ ] Define the minimal FujiNet transport interface the original gameplay can
  call.
- [ ] Identify which existing transport callbacks can be adapted.
- [ ] Identify which bank should contain FujiNet-specific code, based on code
  space and call frequency.
- [ ] Identify required packet format compatibility or translation from the
  original MIDI ring bytes.
- [ ] List emulator or hardware tests needed before code changes begin.

Verification gate:

- [ ] `docs/fujinet-porting.md` contains an implementation-ready design outline.
- [ ] Any proposed code hooks reference exact bank/routine/slot locations.
- [ ] No behavior change is committed as part of this research phase.

## How To Use This Plan

At the start of each gameplay/FujiNet session:

1. Read this file.
2. Pick the first unchecked phase or item with enough evidence to proceed.
3. Gather references with `rg` and bank-local source reads.
4. Prefer docs and comments before renames.
5. Run `make compare` after source edits.
6. Update this file and the relevant docs.
7. Commit completed phases.
