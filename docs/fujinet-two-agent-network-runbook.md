# FujiNet Research: Two-Agent Network Runbook

This runbook is for the first two-machine network trace. The relay server is
treated as a packet forwarder only; the game protocol bytes remain MIDI Maze's
own setup/live packet stream.

## Known Manual Setup Flow

Current observed setup process:

1. Each Atari instance loads a special Atari client app.
2. The client app lets users create or join a game on a relay server.
3. When both players have joined the relay game, the client app resets the
   Atari so the cartridge game can run.
4. In MIDI Maze, each player selects `MIDI-MATE`.
5. The last player to select `MIDI-MATE` becomes the master machine.
6. The master can change game settings, map, or names, but can also press FIRE
   through defaults.
7. Each player can change their name, but can also press FIRE to enter.
8. When all players have pressed FIRE, live gameplay begins.

Because master selection depends on timing/order, setup-packet traces require
more coordination than live movement traces.

## Recommended First Run: Live Movement Only

For the first network session, prefer a movement-only trace.

User responsibilities:

- Start both computers and get both machines fully into a live two-player game.
- Tell Agent 1 which computer/player it controls.
- Tell Agent 2 which computer/player it controls.
- Announce: `LIVE STARTED - BEGIN TRACE`.

Agent responsibilities:

- Do not navigate menus.
- Start memory tracing only after the user announces live play.
- Record local player index, human count, input/status arrays, slot `$13` state,
  command bytes, selected bank, and hot bank-call slots.
- Drive only the local joystick when instructed.

Why this should be first:

- It avoids master-selection race coordination.
- It directly tests the largest solo gap: remote live input exchange.
- It lets us verify that both agents can collect comparable traces before
  tracing setup.

## Second Run: Setup Packet Trace

After movement-only tracing works, run a coordinated setup trace.

Goal:

- Capture setup vector installation, master/slave assignment, setup command
  bytes, maze/state transfer, and transition into live play.

Coordination requirement:

- Decide in advance which machine should become master.
- The intended slave selects `MIDI-MATE` first.
- The intended master selects `MIDI-MATE` last.
- Both agents start tracing before `MIDI-MATE` selection if possible.

Expected master evidence:

- `LOCAL_PLAYER_INDEX` should become `$00` on the master.
- The master should drive setup payload and map/game option state.
- The slave should receive/forward setup commands and payload bytes.

If this ordering fails, keep the trace anyway. The observed local indexes and
master/slave behavior are still useful.

## Agent 1 Instructions

Agent 1 owns machine A only.

Before tracing:

- Confirm repo commit or source state with the user.
- Confirm Atari800 AI socket path for machine A.
- Confirm whether the user will do all menu navigation.
- Do not use sound; any emulator launch must include `-nosound`.

For movement-only:

```sh
python3 tools/network_watch.py --role machine-a --out build/network_trace_machine_a.json
```

If `tools/network_watch.py` does not exist yet, use a temporary script derived
from `tools/solo_trace.py` with `--no-navigate` behavior. Do not press FIRE or
change setup screens unless the user asks.

Movement script after `LIVE STARTED - BEGIN TRACE`:

1. idle for 5 seconds,
2. on user command, hold UP for 5 seconds,
3. center for 2 seconds,
4. on user command, hold RIGHT for 5 seconds,
5. center for 2 seconds,
6. on user command, hold FIRE for 5 seconds,
7. center and keep tracing until user says stop.

Save the trace under `build/` and report local player index, human count,
candidate bank hits, and any nonzero `NET_ERROR_CODE`.

## Agent 2 Instructions

Agent 2 owns machine B only.

Use the same tracing fields and movement script as Agent 1, but do not move at
the same time unless the user explicitly requests simultaneous movement.

Primary observation during Agent 1 movement:

- Watch which `PLAYER_INPUT_STATUS[X]` changes on machine B.
- Watch which player position/facing changes on machine B.
- Confirm whether Agent 1's held UP/RIGHT/FIRE appears as `$01/$08/$10` in the
  expected remote player slot.

When Agent 2 moves, Agent 1 should observe the reciprocal remote input.

## User Checkpoint Phrases

Use simple checkpoint phrases so both agents can act without direct agent-to-
agent coordination:

- `BOTH CLIENTS JOINED RELAY`
- `CARTRIDGE RESET COMPLETE`
- `TRACE SETUP NOW`
- `MACHINE A SELECT MIDI-MATE NOW`
- `MACHINE B SELECT MIDI-MATE NOW`
- `LIVE STARTED - BEGIN TRACE`
- `MACHINE A HOLD UP`
- `MACHINE A CENTER`
- `MACHINE B HOLD UP`
- `MACHINE B CENTER`
- `MACHINE A HOLD RIGHT`
- `MACHINE B HOLD RIGHT`
- `MACHINE A HOLD FIRE`
- `MACHINE B HOLD FIRE`
- `STOP TRACE`

For setup traces, say explicitly which machine should become master before
either agent presses or observes `MIDI-MATE` selection.

## Fields To Trace

Each agent should capture at least:

- `LOCAL_PLAYER_INDEX` `$3968`
- `HUMAN_PLAYER_COUNT` `$396B`
- `TOTAL_PLAYER_COUNT` `$396E`
- `MAZE_SIZE_INDEX` `$396F`
- `PLAYER_INPUT_STATUS[0..15]` `$3D29`
- `$2B00-$2B0F` companion bytes
- `PLAYER_X/Y`, facing, state, fire timers, projectile timers
- `L3EB9`, `L3ECB`, `L3ECC`
- `NET_ERROR_CODE`
- `PENDING_NET_COMMAND`
- `OUTGOING_NET_COMMAND`
- selected bank `L008C`
- hot bank-call slots `$03`, `$10`, `$11`, `$13`, `$1B`, `$1C`, `$22`, `$24`
- `NET_VECTOR_0..6`

For setup traces, also capture `$3000-$37FF` maze buffer snapshots after live
play begins so the two machines can be compared.

## Expected Outcomes

Movement-only run:

- Both machines report `HUMAN_PLAYER_COUNT >= 2`.
- The two machines have different `LOCAL_PLAYER_INDEX` values.
- Local joystick input appears in the local player's
  `PLAYER_INPUT_STATUS` slot.
- Remote joystick input appears in another human player's
  `PLAYER_INPUT_STATUS` slot.
- Remote position/facing/projectile arrays update through the normal gameplay
  path.
- `NET_ERROR_CODE` remains `$00`.

Setup-packet run:

- Master/slave assignment can be inferred from `LOCAL_PLAYER_INDEX`.
- Setup commands and setup payload movement are visible through callback-vector
  side effects and state changes.
- Both machines agree on player counts and final maze/setup state.
- Banks `$03` and `$07` are not selected during setup/live unless proven
  otherwise by trace.

## If Something Goes Wrong

If the game fails before live play:

- Save both traces anyway.
- Record the last checkpoint phrase reached.
- Record visible error text, if any.
- Record `NET_ERROR_CODE` from both machines.
- Do not retry with changed timing until the failed trace is saved.

If master assignment is wrong:

- Continue the run if live play starts.
- Mark which machine actually became master based on `LOCAL_PLAYER_INDEX`.
- Use the trace to refine the next setup-packet run.

If only one agent can control a joystick:

- Run one-way movement first. That is still enough to prove remote input
  storage and movement on the receiving machine.
