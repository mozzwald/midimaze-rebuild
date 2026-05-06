# FujiNet Porting Notes

This document records constraints and future insertion points for adding a
FujiNet transport to MIDI Maze. It should be driven by the current gameplay
research plan in `ref/GAMEPLAY_FUJINET_RESEARCH_PLAN.md`.

Do not treat anything here as an implementation decision until the supporting
gameplay path is documented with exact bank/routine/slot references.

## Current Status

- [x] Gameplay-loop FujiNet service insertion points identified.
- [x] Transport setup analogue selected.
- [x] Incoming byte semantics documented.
- [x] Human/remote/bot boundary documented.
- [x] Bank-call extension strategy documented.
- [x] Command semantics documented.
- [x] RAM/code-space risk table completed.
- [ ] Implementation boundary defined.

## Gameplay-Loop Insertion Points

The strongest future FujiNet service analogue is bank-call slot `$13`, currently
`BANK4_NET_COMMAND_SERVICE_ENTRY`. Bank 12 calls it before bank 0 gameplay
updates in the live service slice at `L9A2D`, and also calls it in pre-live,
resync, and hold/sync wait loops. A FujiNet replacement or wrapper here would
preserve the current high-level polling shape.

Candidate insertion points:

| Candidate | Location | Fit | Risks |
|---|---|---|---|
| Slot `$13` wrapper/replacement | bank 4 `$8000`, called from bank 12 `L9A2D` and wait loops | Best semantic match for RX/TX service, command recognition, and pending-command latching. | Hot path. Must preserve `NET_ERROR_CODE`, `PENDING_NET_COMMAND`, `OUTGOING_NET_COMMAND`, `PLAYER_INPUT_STATUS`, and `L3EB9` semantics. Slot `$13` is temporarily redirected during hold/sync. |
| Bank 12 pre-slot hook | immediately before `L9A2D` calls slot `$13` | Clear orchestration point if only a tiny shim is needed. | Bank 12 space is valuable, and this would miss other slot `$13` wait-loop calls unless duplicated. |
| Bank 12 post-slot hook | between slot `$13` and slot `$22` in `L9A2D` | Could translate freshly received bytes before non-human gameplay updates. | Only safe after the incoming byte path and `PLAYER_INPUT_STATUS` lifecycle are fully mapped. |
| Slot `$22` bank 0 update | `BANK0_GAMEPLAY_UPDATE_ENTRY` | Useful for bot scheduling documentation. | Poor transport hook. It updates non-human gameplay actors and should not own FujiNet RX/TX service. |

Current boundary: do not implement FujiNet inside slot `$22`. Treat slot `$13`
as the transport service candidate, but defer design until Phase G4 proves how
incoming bytes become `PLAYER_INPUT_STATUS`.

## FujiNet Setup Analogue

The closest current design analogue is MIDI-MATE's callback-vector model, not
the modem command strings. MIDI-MATE installs a full `NET_CALL_VECTOR_0..6`
family for direct byte transport and then joins the shared `L863D` handshake.
That shape is a good fit for a future FujiNet transport because bank 12 already
abstracts setup and gameplay byte operations through the vector table.

The SX212/Atari 850 path is still useful as a reference if FujiNet is exposed
through a CIO-style device. It shows how bank 12 loads/configures a handler,
uses CIO status/error returns, and still converges at `L83B2`/`L863D`. The AT
command strings themselves are not a good FujiNet analogue.

First-pass boundary for a FujiNet setup path:

| Decision area | Current best analogue | Notes |
|---|---|---|
| Byte RX/TX interface | MIDI-MATE vector family | Implement a complete vector set rather than patching individual reads/writes. |
| Shared game setup | `L863D` | Reuse the existing handshake if FujiNet can preserve `$A0/$A1`, pending command, timeout, and player-index semantics. |
| CIO/device initialization | SX212/850 path | Relevant only if FujiNet requires an `N:`/device handler open/status flow. |
| Timeout/error handling | Existing `NET_TIMEOUT_TICKS`, `NET_ERROR_CODE`, `$C7` timeout convention | Preserve visible setup error behavior until a new error table is intentionally designed. |

Open design question for later phases: whether FujiNet should use
`LINK_MODE_DIRECT_OR_LOCAL` with a distinct entry label like MIDI-MATE, or a new
nonzero mode value so modem-style checksum/probe branches remain available.

## Incoming Byte Semantics

A FujiNet RX/TX path must preserve bank 4 slot `$13` semantics, not just deliver
bytes. The critical behavior is the two-stage player status exchange:

| Required semantic | Current location | FujiNet implication |
|---|---|---|
| Byte-ready predicate | `NET_CALL_VECTOR_2` used by bank 4 `L8188`/`L81E4` | Must be cheap and nonblocking; returning not-ready keeps bank 12 in the slot `$13` service loop. |
| Read one byte | `NET_CALL_VECTOR_0` | Must return the received byte in `A` and preserve the current `NET_ERROR_CODE` convention. |
| Write one byte | `NET_CALL_VECTOR_1` | Must send both ordinary status bytes and high-bit marker/companion pairs in order. |
| High-bit first byte | bank 4 `L81A3-L81C3` | Means a companion byte follows for that player. Do not reinterpret it as only signed data. |
| Companion byte storage | `$2B00 + player index` | Required for pending commands and input/status trail behavior. |
| Pending command latch | `PENDING_NET_COMMAND` at bank 4 `L821E-L82C7` | Negative companion bytes other than `$FF` become commands consumed by bank 12. |
| Exchange pacing | `L3EB9`, `L3ECB`, `L3ECC`, `NET_TIMEOUT_DEADLINE` | FujiNet must fit the existing state machine or replace all dependent checks, including bank 12's `L3EB9` spin. |
| Timeout | `NET_ERROR_CODE = $C7` | Preserve until a new user-visible error strategy is intentionally designed. |

Do not bypass `PLAYER_INPUT_STATUS`. Bank 13 movement consumes it through the
slot `$03` byte entry, which copies `PLAYER_INPUT_STATUS[player]` into `L00C7`
before applying move/turn/fire bits.

## Human/Bot Boundary

FujiNet transport work should affect human slots, not bot scheduling. The
current game treats indexes `0..HUMAN_PLAYER_COUNT-1` as human ring members and
indexes `HUMAN_PLAYER_COUNT..TOTAL_PLAYER_COUNT-1` as local bot/non-human
actors. Bank 4 slot `$13` exchanges and parses only the human range; bank 0
slot `$22` updates only the bot range.

Future FujiNet RX/TX should therefore preserve these boundaries:

| Range | FujiNet responsibility | Do not change yet |
|---|---|---|
| `LOCAL_PLAYER_INDEX` within the human range | Pack/send this machine's live status and command companion bytes. | Do not make the local player index overlap a bot slot. |
| Other indexes below `HUMAN_PLAYER_COUNT` | Receive/store remote human status bytes in `PLAYER_INPUT_STATUS`. | Do not parse bot slots as network peers. |
| `HUMAN_PLAYER_COUNT..TOTAL_PLAYER_COUNT-1` | No live network exchange; bots are reproduced from shared setup counts. | Do not move bot AI into the transport service or send per-frame bot packets. |

The shared setup/resync path must still distribute the bot counts
(`BOT_COUNT_TARGET`, `BOT_COUNT_DRONE`, `BOT_COUNT_NINJA`,
`BOT_COUNT_NASTY`) because those counts determine `TOTAL_PLAYER_COUNT` and
`PLAYER_BOT_TYPE`. Per-frame FujiNet transport should stop at
`HUMAN_PLAYER_COUNT`, matching bank 4's existing exchange loop.

## Bank-Call Extension Strategy

The bank-call table is not a pool of free hooks. The fixed bank initializes 37
entries from bank 15 `LB03F` into `BANK_CALL_ADDR_LO`, `BANK_CALL_ADDR_HI`, and
`BANK_CALL_BANK_ID`, and bank 12 repatches selected slots at runtime. Future
FujiNet work should treat slot behavior as part of the protocol, not just as
an address lookup.

Recommended future pattern:

1. Keep bank 12 orchestration intact. Preserve the order in `L9A2D`: slot
   `$13`, command/error checks, `L3EB9` spin, then slot `$22`.
2. Add FujiNet behind the same byte-service contract used by bank 4 slot `$13`
   and/or the `NET_CALL_VECTOR_0..6` family.
3. If slot `$13` must be wrapped, restore all volatile slot patch behavior:
   setup can point `$13` at `BANK_RETURN`, gameplay restores it to bank 4
   `$8000`, and hold/sync can suppress it temporarily.
4. Do not repurpose slot `$22`; it is the bot update slot.
5. Do not claim an initially uncalled slot as free until emulator traces prove
   it is unreachable in setup, gameplay, pause/hold, score display, and maze
   flows.

Risk table:

| Candidate | Use for FujiNet? | Reason |
|---|---|---|
| `NET_CALL_VECTOR_0..6` replacement | Preferred first design target | Existing setup and live code already call these for read/write/ready/open/close/helper operations. It avoids changing the bank-call dispatch table shape. |
| Slot `$13` wrapper | Plausible but higher risk | Correct semantic location for live RX/TX and command parsing, but it is hot and volatile. Any wrapper must preserve bank 4 state-machine semantics exactly. |
| New bank-call slot | Only after a trace-backed free-slot audit | There is no proven free slot yet. Adding one also costs RAM table entries and bank-local code space. |
| Bank 12 inline hook | Use only for tiny glue | Bank 12 is orchestration-heavy and already patches volatile slots. Inline hooks risk missing non-`L9A2D` wait-loop calls to slot `$13`. |
| Slot `$22` hook | No | This would mix transport with bot scheduling and break the human/bot boundary. |
| Slot `$03` hook | No for transport | This is a player update consumer path, not the transport producer. Its active caller still needs trace proof. |

The safest FujiNet direction is a transport-vector implementation plus a thin
slot `$13` compatibility path only if the original bank 4 state machine cannot
be reused directly. Any later implementation phase should include a trace plan
for slot `$13` patching and `L3EB9` state transitions before changing code.

## Command Semantics To Preserve

FujiNet must preserve the original distinction between direct setup markers and
live high-bit companion commands.

| Value | Name | FujiNet requirement |
|---:|---|---|
| `$80` | `CMD_INIT_RING` | Preserve as the pre-live/start companion and raw hold/sync acknowledge behavior. Do not treat it as ordinary movement input. |
| `$81` | `CMD_CLEAR_STATE` | Deliver as a negative companion command so remote `PENDING_NET_COMMAND` dispatch clears score/state mirrors. |
| `$82` | `CMD_HOLD_SYNC` | Preserve hold/pause/sync behavior, including wait loops that temporarily redirect slot `$13`. |
| `$83` | `MARKER_SETUP_PAYLOAD` | Preserve as a direct setup/resync marker byte, not as a `PLAYER_INPUT_STATUS` companion. |
| `$84` | `CMD_RESYNC` | Preserve resync command semantics. Player 0 transmits setup state; other stations receive and apply it. |
| `$86` | `CMD_ROSTER_EXCHANGE` | Preserve roster exchange dispatch. |
| `$87` | `CMD_START_GAME` | Reserved/unverified in current source. Do not assign new FujiNet behavior without first tracing active use. |

Transport rule: ordinary first bytes can be non-negative movement/status. A
negative first byte means a companion byte follows for the same player. Negative
companions other than `$FF` are command bytes and must become
`PENDING_NET_COMMAND` on receivers. `$08` and `$0D` companions are local/status
trail controls, not pending commands.

## Maze Transfer Boundary

FujiNet setup must preserve maze agreement before live play. The original setup
path synchronizes `MAZE_SIZE_INDEX`, maze cell data, seeds, bot counts, team
state, and gameplay parameters before placement/live update begins.

Current maze-transfer forms:

| Form | Current path | FujiNet implication |
|---|---|---|
| Compact cell bytes | bank 12 `MASTER_SEND_SETUP_PAYLOAD` / `SLAVE_RECEIVE_SETUP_PAYLOAD` compact path | Can be represented as `MAZE_SIZE_INDEX * MAZE_SIZE_INDEX` bytes if using the same cell encoding. |
| Expanded final buffer | bank 12 expanded path around `$3000` | Must preserve paired wall-bit clearing semantics and the `$3000` wall plane layout. |

Future FujiNet packets should either carry the same compact cell bytes used by
`LAD00`/fixed helper addressing, or carry enough information to rebuild the
exact `$3000` wall plane. Do not derive maze state independently on each peer
unless `PRNG_SEED_LOW/HIGH`, `MAZE_SIZE_INDEX`, bot counts, and all setup
options are proven to produce byte-identical `$3000` buffers.

## RAM And Code-Space Risk Audit

No RAM range is currently marked free for FujiNet. The ranges below are either
active game state, live transport state, bank-call state, display state, or
candidate-only space that still needs emulator traces before use.

### RAM ranges

| Range | Current role/evidence | Reuse risk | Validation required before reuse |
|---|---|---|---|
| `$0080-$00D3` | Shared zero-page scratch, pointers, bank-call state, timeout state, MIDI indexes, and per-bank temporary values. | High. Live code, setup code, bank-call trampoline, and interrupt paths overlap this area. | Per-routine liveness traces across boot, setup, live play, pause/hold, resync, and interrupt entry/exit. |
| `$0082-$0086` | Fixed-bank MIDI/POKEY RX/TX indexes and TX-active flag for `MIDI_RX_BUFFER`/`MIDI_TX_BUFFER`. | Do not reuse while MIDI is installed. | Prove `MIDI_REMOVE` ran, serial vectors were restored, POKEY IRQs are disabled, and no callback still reads these indexes. |
| `$00B1-$00B3` | `$2F00` direct RX-ring indexes plus timeout/tick state used by setup/live waits. | High. Called through fixed helpers and bank 12 wait logic. | Trace all callers of `MIDI_RX_READ_BLOCKING`, `MIDI_RX_HAS_BYTE`, and timeout comparisons. |
| `$2B00-$2B0F` | Bank 4 per-player companion bytes for high-bit `PLAYER_INPUT_STATUS` markers. | Do not reuse. This is part of live command semantics. | Only reusable if the entire high-bit companion path is replaced and all bank 4 consumers are retargeted. |
| `$2D00-$2EFF` | `MIDI_RX_BUFFER` and `MIDI_TX_BUFFER`, 256 bytes each, drained/fed by fixed-bank serial ISRs and send/read helpers. | Do not reuse for unrelated FujiNet state. | Prove custom MIDI ISR path is inactive and every vector/caller has been replaced or wrapped safely. |
| `$2F00-$2FFF` | Direct helper RX ring used by fixed-bank blocking/nonblocking read helpers with `L00B1/L00B2`. | Do not reuse while original transport helpers remain callable. | Trace that no setup/live path can call the fixed helpers. |
| `$3000-$37FF` | Final maze buffer: wall/cell plane and occupancy/list-head data used by banks 0, 1, 6, 12, 13, and 14. | Do not reuse. | None planned; FujiNet setup must preserve this layout. |
| `$3968-$3D39` | Setup scalars, player counts, seeds, maze index, and dense per-player state arrays. | Do not reuse. | None planned; these are live gameplay contract state. |
| `$3D3E-$3DB4` | Bank-call address/bank tables. | Do not reuse. | Only modify through a bank-call design that preserves slot semantics and volatile patch sites. |
| `$3DB6-$3E??` | Display/status/score/vector-save state, including saved serial vectors around `$3DF8-$3DFB`. | High. Some labels remain generated, but cross-bank reads/writes exist. | Label-specific traces before changing any byte in this range. |
| `$3ECF-$3F16` | Network/setup/player parameter state, command state, bot counts, and bot type table. | Do not reuse. | None planned; required by setup, command dispatch, and bot roster creation. |
| `$3F26-$41DF` | Bank 0/1 bot AI, targeting, path, and transient work arrays. | High during live play. | Live gameplay traces with bots enabled and disabled before treating any subrange as temporary. |
| `$72C0-$737F` | Status/message line buffers, input/status trail/history, and bank 4 network/status buffers. | Do not reuse. | Trace setup menu, live status, hold/sync, and error display paths before touching. |
| `$7380+` | Display field/state region populated by fixed-bank display helpers. | High. | Display update traces and screen-memory ownership map. |

### Temporary buffers

| Buffer | Observed use | Reuse guidance |
|---|---|---|
| `$0600` | Local scratch used by banks 0/1 for `MIDI_TX_BUFFER` save/restore helpers and by bank 4 setup/UI paths. | Treat as routine-local scratch only. Do not store persistent FujiNet state here. |
| `$3EB9-$3ECC` | Bank 4 live exchange state and command/status pacing variables. | Preserve; FujiNet must either feed these semantics or replace all dependent checks. |
| `$40CA-$41DF` | Bank 0/1 AI/path/target scratch. | Not safe during live play, especially when bots are present. |
| OS FP registers `FR0`, `FR1`, `FR2`, `FRE` | Used as scratch by math, placement, and drawing paths. | Do not use across calls or interrupts; only consider as tightly scoped temporary scratch after local proof. |

### RX/TX buffers

| Buffer | Owner | Reusable? | Notes |
|---|---|---|---|
| `MIDI_RX_BUFFER` `$2D00` | Fixed-bank MIDI RX ISR and blocking read helpers. | No, unless replacing and disabling the original MIDI transport path. | Interrupt-driven ring with natural 8-bit wrap. |
| `MIDI_TX_BUFFER` `$2E00` | Fixed-bank send helper and TX ISR; also saved/restored by bank 0/1 helpers. | No, unless replacing and disabling the original MIDI transport path. | Send helper writes directly to `SEROUT` when idle and queues otherwise. |
| `$2F00` | Fixed-bank direct RX helper ring. | No, while `MIDI_RX_READ_BLOCKING`/`MIDI_RX_HAS_BYTE` remain callable. | Separate from `MIDI_RX_BUFFER`; indexed by `L00B1/L00B2`. |
| `$2B00-$2B0F` | Bank 4 companion byte buffer. | No. | This is command/control state, not a general RX buffer. |

### Code-space pressure

Every bank currently assembles to an 8 KiB bank image, so code-space
availability is a bank-selection and trace problem, not just a byte-count
problem.

| Area | Current assessment | FujiNet guidance |
|---|---|---|
| Bank 15 fixed bank | Resident bank-call trampoline, fixed helpers, cartridge start/init, display helpers, and MIDI/POKEY ISRs. | Avoid new code here except tiny proven trampolines. Any change has high boot and interrupt risk. |
| Bank 12 | Main setup/gameplay orchestration and volatile bank-call patching. | Avoid inline FujiNet code; prefer existing vectors or a narrow wrapper. |
| Bank 4 | Current live network command/status service and setup command handlers. | Semantically closest transport bank, but hot and stateful. Changes must preserve slot `$13` behavior. |
| Banks 0/1/13/14 | Gameplay, bot AI, player update, math, drawing, and tables. | Poor transport homes; avoid mixing FujiNet service with gameplay/drawing state. |
| Banks 2/5 | Stubs plus preserved data/payload/fill regions. | Candidate-only after loader/payload traces. Do not treat fill as free. |
| Banks 3/7 | Appear to be all `$FF` fill in the current source tree. | Candidate-only. Need cartridge banking, dispatch, boot, and compatibility traces before assigning meaning. |
| Banks 8-11 | Packed graphics/data emitted verbatim. | Not candidates. |

### Trace checks before claiming free space

Before any RAM or bank region can be promoted from candidate-only to reusable,
run emulator traces that cover boot, mode selection, each transport setup path,
live play with and without bots, hold/sync, resync, score/status display, and
error paths. Candidate RAM needs read/write watchpoints over the full range.
Candidate bank code space needs bank-select traces, bank-call slot traces, and
proof that adding or switching into the bank does not disturb the existing
dispatch table or cartridge layout.

For MIDI-buffer reuse specifically, also trace serial vector restoration,
`POKMSK`/IRQ state, and `SERIN`/`SEROUT` activity after `MIDI_REMOVE`. Do not
reuse `$2D00-$2FFF` based only on a non-MIDI setup mode; the fixed helpers and
interrupt vectors must be proven inactive.
