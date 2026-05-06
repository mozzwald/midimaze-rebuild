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
- [ ] Bank-call extension strategy documented.
- [ ] Command semantics documented.
- [ ] RAM/code-space risk table completed.
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
