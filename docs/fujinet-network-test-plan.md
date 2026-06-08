# FujiNet Research: Network Test Plan

This is the handoff plan for the first real network-play trace. Solo testing
has proven the local input producer/consumer path, slot `$13` solo side effects,
service cadence, callback-vector call sites, and candidate bank status for
solo. It has not proven the remote-human exchange.

## What I Need From You

For the next phase, I need a reproducible way to reach a live network game with
at least two human slots.

Minimum useful setup:

- Two Atari800 AI instances, both launched with `-nosound`, each with a usable
  AI socket or equivalent control channel.
- The exact commands or wrapper script needed to connect the two game instances
  through the original transport path you want tested first.
- A short manual recipe for navigating both instances through mode selection,
  player setup, and start-game if it cannot be fully scripted.
- Confirmation of which transport mode is being tested: MIDI-MATE, modem/850,
  or a FujiNet prototype later.
- Permission to poll memory heavily while the instances run. The current tools
  connect to the AI socket once per sample and read small RAM ranges.

Nice-to-have setup:

- A way to distinguish machine A from machine B in screenshots or logs.
- A known-good original-network play recipe, even if it requires you to perform
  the first connection manually.
- Any emulator/network bridge logs that show raw bytes or connection state.
- If there is a future FujiNet prototype, its host/port/session settings and
  expected room/lobby behavior.

## What I Will Test First

The first network trace should stay observational. I am not looking to change
the ROM yet.

### Setup Handshake

Trace both machines from mode selection through live play:

- installed `NET_VECTOR_0..6` values,
- `LOCAL_PLAYER_INDEX`,
- `HUMAN_PLAYER_COUNT`,
- `TOTAL_PLAYER_COUNT`,
- `NET_ERROR_CODE`,
- setup command bytes `$80`, `$83`, `$84`, `$86`, and any `$87` use,
- final maze/setup agreement, especially `$3000-$37FF` and key setup scalars.

Expected outcome: both machines reach live play with different local player
indexes, matching human counts, and compatible maze/setup state.

### Live Slot `$13` Exchange

During live play, poll these on both machines:

- `PLAYER_INPUT_STATUS[0..HUMAN_PLAYER_COUNT-1]` at `$3D29`,
- companion bytes `$2B00+player`,
- `L3EB9`, `L3ECB`, `L3ECC`,
- `NET_ERROR_CODE`,
- `PENDING_NET_COMMAND`,
- `OUTGOING_NET_COMMAND`,
- selected bank `L008C` and hot bank-call slots.

Expected outcome: with more than one human player, slot `$13` should enter
remote receive phases that solo never proves. I expect to see `L3EB9` nonzero
at least transiently, `L3ECC` counting down remaining human bytes, and remote
input bytes landing in the correct `PLAYER_INPUT_STATUS` slots.

### Remote Movement

Drive joystick input on one machine and observe the other:

- held UP should appear as `$01` for that remote player,
- held RIGHT should appear as `$08`,
- FIRE should appear as `$10`,
- combined UP+FIRE should appear as `$11`,
- the remote player's position/facing/projectile state should update through
  the normal bank 13 consumer path.

Expected outcome: remote movement is represented by the same packed status byte
format already proven in solo. The receiving machine should not require a new
gameplay path.

### Command And Companion Bytes

Trigger or poke controlled command cases only after the basic live exchange is
stable:

- `$80` start/hold-related companion behavior,
- `$81` clear score/state,
- `$82` hold/sync,
- `$84` resync,
- `$86` roster exchange,
- `$FF` no-command companion behavior,
- `$08` and `$0D` status-trail companion behavior if naturally reachable.

Expected outcome: high-bit first bytes use `$2B00+player` as the companion
store, and negative companions other than `$FF` become `PENDING_NET_COMMAND` on
receivers.

### Timeout/Error Behavior

If the setup allows it, deliberately pause or disconnect one peer after a
baseline trace:

- watch `NET_ERROR_CODE`,
- confirm whether `$C7` is used for timeout,
- record whether gameplay blocks, repeats stale input, or exits to a visible
  error path.

Expected outcome: the original transport's timeout behavior becomes clear
enough to decide whether FujiNet should preserve blocking ring semantics or
translate late server ticks into repeated last-known input.

## Evidence To Capture

For each test run, I want:

- the emulator launch commands,
- mode/setup steps,
- JSON memory traces from both machines,
- one or two screenshots only if useful for confirming state,
- any raw transport logs available from the bridge or FujiNet layer,
- `make compare` before and after if source comments/tools changed.

Generated traces should stay under `build/` unless we deliberately curate a
small excerpt for documentation.

## Success Criteria

The first network phase is successful if we can answer these without changing
game behavior:

- Does original network live play block the main loop while waiting for peer
  input, or does it continue with older input?
- What exact `L3EB9/L3ECB/L3ECC` sequence occurs with two human players?
- Do remote input bytes map directly to `PLAYER_INPUT_STATUS` in ring/player
  order?
- Are high-bit companion commands latched exactly as the static bank 4 trace
  suggests?
- Which callback vectors are hot during setup, live play, hold/sync, and
  resync?
- Do banks 3 or 7 appear in any network setup/live bank-selection path?

Only after those answers are captured should the first FujiNet code phase pick
a bank, install vectors, or wrap slot `$13`.
