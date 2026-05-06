# FujiNet Porting Notes

This document records constraints and future insertion points for adding a
FujiNet transport to MIDI Maze. It should be driven by the current gameplay
research plan in `ref/GAMEPLAY_FUJINET_RESEARCH_PLAN.md`.

Do not treat anything here as an implementation decision until the supporting
gameplay path is documented with exact bank/routine/slot references.

## Current Status

- [x] Gameplay-loop FujiNet service insertion points identified.
- [ ] Transport setup analogue selected.
- [ ] Incoming byte semantics documented.
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
