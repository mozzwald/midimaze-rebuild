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
- [x] Complete Phase G2 main gameplay loop and bank ownership map. Slot `$13`
  is the primary transport service hook; slot `$22` owns bank 0 non-human
  gameplay updates; slot `$03` remains a registered bank 13 update entry with
  no active caller proven in source yet.
- [x] Complete Phase G3 transport-specific setup path map. SOLO and MIDI-MATE
  install direct callback vectors and enter `L863D`; XM301, SX212, and Atari
  850 perform device/modem setup through the `R:`/CIO family before converging
  through `L83B2` and `L863D`.
- [x] Complete Phase G4 incoming player data path map. Bank 4 slot `$13`
  owns the live status exchange, writes human `PLAYER_INPUT_STATUS` bytes,
  stores companion command bytes in `$2B00`, and bank 13 consumes status through
  the slot `$03` byte entry copy into `L00C7`.
- [x] Complete Phase G5 player state arrays deep map. `docs/gameplay.md` now
  records per-array addresses, stride, owner/writer banks, reader banks,
  gameplay meaning, checksum coverage, and roster/status metadata trace
  targets.
- [x] Complete Phase G6 human versus bot split. Human slots are
  `0..HUMAN_PLAYER_COUNT-1`; bot slots are
  `HUMAN_PLAYER_COUNT..TOTAL_PLAYER_COUNT-1`; bank 1 fills
  `PLAYER_BOT_TYPE`, bank 4 exchanges only human input/status, and bank 0
  updates only bot slots.
- [x] Complete Phase G7 bank-call system for gameplay extension. The docs now
  identify the fixed dispatch tables, volatile bank 12 patch sites, critical
  gameplay slots, lack of proven free slots, and the preferred FujiNet pattern:
  transport vectors first, slot `$13` wrapper only with compatibility.

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

- [x] Identify the primary bank 12 live gameplay loop entry and re-entry paths.
- [x] Identify where bank-call slot `$13` is called during live gameplay.
- [x] Identify where bank 13 player movement/collision/projectile update is
  called.
- [x] Identify where bank 0 local/bot/gameplay update is called.
- [x] Document loop order: input, transport service, player update, bot update,
  drawing/status, command dispatch, exit conditions.
- [x] Document volatile bank-call slot patching relevant to gameplay.

Verification gate:

- [x] `docs/gameplay.md` has a main gameplay loop call graph with bank, slot,
  routine, inputs, outputs, and exit paths.
- [x] `docs/fujinet-porting.md` lists the gameplay-loop insertion points that
  are safe candidates for future FujiNet service calls.
- [x] `make compare` exact if source comments/names changed.

## Phase G3: Transport-Specific Setup Paths

Goal: split setup flow by transport while preserving the shared post-setup path.

- [x] Document MIDIMATE initialization and its jump into shared setup.
- [x] Document modem initialization for XM301/SX212-style paths.
- [x] Document Atari 850 initialization and status/probe behavior.
- [x] Document solo/local initialization.
- [x] Identify the shared code after transport setup converges.
- [x] Document which vectors/callbacks are patched per transport.
- [x] Document error paths and `NET_ERROR_CODE` values per transport.

Verification gate:

- [x] `docs/gameplay.md` has a transport setup table with entry routine,
  callbacks, setup mode, success target, and failure target.
- [x] `docs/fujinet-porting.md` has a first-pass "FujiNet setup analogue"
  section listing which existing transport path is closest.
- [x] `make compare` exact if source comments/names changed.

## Phase G4: Incoming Player Data Path

Goal: trace remote input/status bytes from transport read to gameplay consume.

- [x] Identify where raw bytes are read from MIDI/transport during gameplay.
- [x] Identify where command/control bytes are separated from player data.
- [x] Identify where remote player bytes are stored.
- [x] Identify all writes to `PLAYER_INPUT_STATUS`.
- [x] Identify all consumers of `PLAYER_INPUT_STATUS`.
- [x] Document local player input packing versus remote input unpacking.
- [x] Document timing/latency assumptions, including ring-buffer polling and
  frame boundaries.

Verification gate:

- [x] `docs/gameplay.md` has an incoming player data flow from transport read
  to `PLAYER_INPUT_STATUS` consumer.
- [x] `docs/fujinet-porting.md` lists the minimum semantics a FujiNet RX path
  must preserve.
- [x] `make compare` exact if source comments/names changed.

## Phase G5: Player State Arrays Deep Map

Goal: document each gameplay state array beyond setup payload order.

- [x] Map position arrays: `PLAYER_X_LO/HI`, `PLAYER_Y_LO/HI`.
- [x] Map facing/turning arrays: `PLAYER_FACING_ANGLE`, `PLAYER_TURN_RATE`.
- [x] Map alive/dead/state arrays: `PLAYER_STATE`,
  `PLAYER_STATE_TIMER`, `PLAYER_HIT_FLAG`, `PLAYER_HIT_BY_INDEX`.
- [x] Map projectile arrays: projectile position, velocity, active timer, fire
  timer, projectile life/speed flags, weapon mode.
- [x] Map score/kills arrays: `PLAYER_SCORE_COUNTERS`,
  `TEAM_SCORE_COUNTERS`.
- [x] Identify player name/slot metadata and any roster/status tables.
- [x] Document which bank owns writes and which bank owns reads for each array.

Verification gate:

- [x] `docs/gameplay.md` has an array table with address, stride, owner bank,
  writer routines, reader routines, and gameplay meaning.
- [x] Stable names promoted only where evidence is cross-bank strong.
- [x] `make compare` exact if source comments/names changed.

## Phase G6: Human Versus Bot Split

Goal: define the player index ranges and how bot/human update differs.

- [x] Document `HUMAN_PLAYER_COUNT`.
- [x] Document `TOTAL_PLAYER_COUNT`.
- [x] Document `LOCAL_PLAYER_INDEX`.
- [x] Identify where bot counts are converted into active player slots.
- [x] Identify where bots are updated.
- [x] Identify where human players are skipped, included, or treated as remote.
- [x] Document how local, remote, and bot players feed the same state arrays.

Verification gate:

- [x] `docs/gameplay.md` has a human/remote/bot player-index model.
- [x] `docs/fujinet-porting.md` describes whether FujiNet changes should
  affect only human remote slots or also bot scheduling.
- [x] `make compare` exact if source comments/names changed.

## Phase G7: Bank-Call System For Gameplay Extension

Goal: document bank-call mechanics specifically for future gameplay transport
changes.

- [x] Document dispatch table locations and initialization source.
- [x] Document how bank 12 calls bank 4, bank 13, and bank 0 during gameplay.
- [x] Document volatile slot usage and patch sites.
- [x] Identify bank-call slots that are gameplay-critical and must not be
  repurposed.
- [x] Identify any unused or safely redirectable slots only if proven.
- [x] Define a safe future pattern for FujiNet-specific bank calls without
  breaking current bank layout.

Verification gate:

- [x] `docs/fujinet-porting.md` has a bank-call extension strategy with risks.
- [x] `docs/symbols.md` is updated if new stable slot names are promoted.
- [x] `make compare` exact if source comments/names changed.

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
