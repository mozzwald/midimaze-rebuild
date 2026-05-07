# MIDI Maze FujiNet-Only Server-Coordinated Multiplayer Plan

**Repository target:** `mozzwald/midimaze-rebuild`  
**Document purpose:** Provide a practical implementation plan for converting the current multi-transport MIDI Maze rebuild into a FujiNet-only build using a server-coordinated gameplay model that fits the existing game architecture with the least invasive changes.

---

## 1. Executive Summary

The recommended first FujiNet-only architecture is **server-coordinated deterministic input**, not fully server-authoritative position snapshots.

In this model:

```text
Atari client sends local input/status intent
        ↓
Server collects inputs from real players and generates bot inputs
        ↓
Server sends compact per-actor input/status bytes for each game tick
        ↓
Atari writes those bytes into PLAYER_INPUT_STATUS
        ↓
Existing MIDI Maze gameplay code updates movement, collision, projectiles, scores, and rendering
```

This approach deliberately keeps the existing `PLAYER_INPUT_STATUS → player update → player arrays → rendering` pipeline intact. The server coordinates the session, controls rooms/maps/bots, paces the game, and can periodically validate/correct state, but it does not initially replace the client-side movement/projectile/scoring simulation.

This should produce the best balance of:

- Smooth gameplay.
- Minimal ROM surgery.
- Least risk of breaking the working movement/projectile/renderer path.
- A clear upgrade path toward stronger server authority later if divergence becomes a problem.

### Implementation Boundary Decision

Use this split for the first FujiNet-only implementation:

```text
Setup/device/lobby path:
  Use FujiNet primitives behind NET_CALL_VECTOR_0..6 where that keeps existing
  bank12 setup code useful.

Live gameplay path:
  Replace or wrap bank4 slot $13 with a FujiNet-specific live service once its
  side effects are traced.
```

The reason is practical: the server-coordinated tick model is message-oriented,
while the original `NET_CALL_VECTOR_0..6` contract is byte-stream-oriented. It
is possible to hide message framing behind the vector callbacks, but that still
requires a FujiNet driver to convert server packets back into the original
ordered byte stream. For live gameplay, a FujiNet-specific slot `$13` service
is cleaner because it can receive `SERVER_TICK_INPUTS` and write
`PLAYER_INPUT_STATUS` directly while preserving the bank12 expectations around
`NET_ERROR_CODE`, `PENDING_NET_COMMAND`, `OUTGOING_NET_COMMAND`, and `L3EB9`.

Do not implement the live slot `$13` replacement until Phase 0 proves the
current slot `$13` side effects and the active movement consumer path.

---

## 2. Design Goals

### 2.1 Primary Goals

1. Convert the ROM into a **FujiNet-only** build.
2. Remove or bypass legacy transport choices:
   - Solo menu path, unless retained as a debug option.
   - MIDI-MATE hardware path.
   - XM301.
   - SX212.
   - Atari 850.
3. Use FujiNet NetStream or a minimal custom FujiNet stream layer as the only transport.
4. Preserve as much of the existing gameplay engine as possible.
5. Let the server manage:
   - Room list.
   - Player join/leave.
   - Player names.
   - Actor slot assignment.
   - Map selection and setup data.
   - Bot input decisions.
   - Tick pacing.
   - Match restart.
   - Divergence checking/correction.
6. Keep gameplay smooth by using:
   - Local immediate input.
   - Server tick packets.
   - Small jitter buffer for remote/server actors.
   - Repeat-last-input fallback.
   - Optional periodic correction snapshots.

### 2.2 Non-Goals for the First Playable Version

Do **not** start by replacing the entire gameplay engine.

Specifically, avoid replacing these early:

```text
PLAYER_X/Y/FACING ownership
projectile simulation
hit detection
score updates
bank13 movement/projectile path
bank14 rendering
bank0/bank1 gameplay helper paths unless intentionally disabling local bots
```

Do **not** make the first version a fully server-authoritative state-snapshot client unless the input-coordinated model proves unworkable.

---

## 3. Current Game Architecture to Fit

The existing game is already structured around a compact live input/status byte.

The key bridge is:

```text
PLAYER_INPUT_STATUS[player]
```

This byte is written by live transport exchange for human players and by bot code for non-human players. The movement/projectile code then consumes it and writes the final player state arrays.

The useful current model is:

```text
Transport/bot code produces PLAYER_INPUT_STATUS
        ↓
Player update consumes PLAYER_INPUT_STATUS
        ↓
Player state arrays are updated
        ↓
Renderer and status/UI consume player state arrays
```

Relevant current state arrays include:

```text
PLAYER_X_LO / PLAYER_X_HI
PLAYER_Y_LO / PLAYER_Y_HI
PLAYER_FACING_ANGLE
PLAYER_STATE
PLAYER_STATE_TIMER
PLAYER_HIT_FLAG
PLAYER_HIT_BY_INDEX
PLAYER_FIRE_TIMER
PROJECTILE_X/Y_LO/HI
PROJECTILE_ACTIVE_TIMER
PROJECTILE_DX/DY_LO/HI
PLAYER_SCORE_COUNTERS
TEAM_SCORE_COUNTERS
PLAYER_TEAM_INDEX
PLAYER_INPUT_STATUS
```

The existing docs identify `PLAYER_INPUT_STATUS` as the bridge from transport/bot input into shared movement code. That is exactly the seam the FujiNet-only client/server model should use first.

---

## 4. Recommended Gameplay Authority Model

### 4.1 Authority Split

Use a **hybrid server-coordinated deterministic simulation**.

#### Server authoritative for:

```text
lobby and room list
username/session identity
player admission / full-room rejection
actor slot assignment
map choice
setup payload
game options
server bot decisions
global tick numbers
match start
match end
match restart
optional periodic divergence checks
optional correction snapshots
```

#### Client authoritative/local for:

```text
immediate local input reading
normal movement simulation
normal collision simulation
normal projectile simulation
normal scoring path
rendering
audio/UI effects
```

#### Hybrid correction authority:

```text
server periodically compares or requests checksums
server sends correction snapshots only when needed
client applies correction carefully
```

This is not a pure trust model. It is a practical model that fits an 8-bit game with limited code/RAM budget. The server is the session coordinator and referee, while clients keep using the original deterministic gameplay engine.

---

## 5. Server-Coordinated Tick Model

### 5.1 Tick Stream Concept

The server runs a fixed tick stream. Recommended initial targets:

```text
20 Hz server tick = simple, lower bandwidth
30 Hz server tick = smoother, still reasonable
```

The Atari game loop may run more often than server packets arrive. The client should keep using the latest appropriate input byte for each actor until a newer tick arrives.

### 5.2 Client Sends

Each client repeatedly sends its latest local input intent:

```text
CLIENT_INPUT {
    message_type
    protocol_version
    client_sequence
    client_frame_counter_or_tick_hint
    local_actor_slot
    input_status_byte
    optional_companion_or_action_flags
}
```

The first version can be smaller:

```text
type
seq
input_status_byte
```

But it should be designed so sequence numbers can be added without redesigning the protocol.

### 5.3 Server Broadcasts

The server sends a per-tick frame:

```text
SERVER_TICK_INPUTS {
    message_type
    server_tick
    ack_client_sequence
    actor_count
    repeated actor input records:
        actor_slot
        input_status_byte
        optional flags
}
```

The first test version can be:

```text
server_tick
slot0_input
slot1_input
```

for one real player and one server bot.

### 5.4 Client Applies

The FujiNet live service receives a tick packet and writes actor input bytes into `PLAYER_INPUT_STATUS`.

Recommended first playable mapping:

```text
slot 0 = real Atari player
slot 1 = server-controlled bot treated as a network actor
HUMAN_PLAYER_COUNT = 2
TOTAL_PLAYER_COUNT = 2
local bot counts = 0
```

Then the existing player update path moves both actors.

---

## 6. Why Server-Controlled Bots Should Initially Be Human-Range Actors

The current game separates humans and bots by index range:

```text
human actors: 0 .. HUMAN_PLAYER_COUNT-1
bot actors:   HUMAN_PLAYER_COUNT .. TOTAL_PLAYER_COUNT-1
```

The existing transport service only exchanges human slots. The local bot update path owns the bot range.

For FujiNet-only server bots, the least invasive approach is:

```text
Treat server bots as server-controlled human-range actor slots.
Do not use the local bot range for server bots in the first implementation.
```

Example first test room:

```text
LOCAL_PLAYER_INDEX = 0
HUMAN_PLAYER_COUNT = 2
TOTAL_PLAYER_COUNT = 2
slot 0 = real player
slot 1 = server bot
BOT_COUNT_TARGET = 0
BOT_COUNT_DRONE = 0
BOT_COUNT_NINJA = 0
BOT_COUNT_NASTY = 0
PLAYER_BOT_TYPE for active slots = no local bot behavior
```

The server sends input/status for slot 1. The normal movement/projectile path handles it as if it were a remote human.

This avoids having bank0 local bot AI fight the server bot.

For ROM-facing purposes, server bots are just human-range network actors with
server-owned names. Example display names:

```text
Clyde Bot
Mazer Bot
Drone Bot
Nasty Bot
```

The first implementation should allow server bots to win. That keeps match
logic simple: victory is based on the existing score/win condition for any
active actor slot. Later versions can add server-side room options such as
"bots cannot win" if that becomes desirable.

Server bots must use fair visibility rules. They should not see through maze
walls, should not know a hidden player's exact current position, and should not
use server-only omniscience for targeting. A server bot may:

```text
- detect a player currently visible in its forward view/raycast
- remember the last seen player position for a short time
- move toward the last seen position
- search or patrol when no player is visible or remembered
- fire only when line-of-sight/facing checks make the shot plausible
```

This keeps server bots challenging without making them cheat. The server can
use the full maze data to run line-of-sight tests, but only to answer what the
bot could plausibly see from its current position and facing.

---

## 7. Smoothness Strategy

### 7.1 Local Player

For responsiveness, the local player should use local input immediately.

Recommended first version:

```text
1. Read joystick/fire.
2. Write local input to PLAYER_INPUT_STATUS[LOCAL_PLAYER_INDEX] immediately.
3. Send the same input byte to the server.
4. When server tick arrives, use server input only for non-local actors.
```

This gives responsive local control.

Later, if you need stricter coordination:

```text
- server tick includes authoritative echo of local input
- client compares with local input history
- client corrects only if server rejected/changed input
```

### 7.2 Remote Players and Server Bots

For remote/server actors:

```text
- use server tick input packets
- keep a 1-3 tick jitter buffer if RAM allows
- if a tick is missing, repeat the last known input byte
- ignore older tick packets
```

This avoids visible stutter caused by transient packet timing.

### 7.3 Avoid Direct Position Smoothing in First Version

Do not smooth `PLAYER_X/Y` in the first version unless divergence/correction snapshots are implemented.

The goal is to let the existing movement path produce positions from input bytes. That means smoothness comes from steady input delivery, not manual position interpolation.

---

## 8. Divergence Detection and Correction

Because clients simulate movement/projectiles locally, they can diverge if:

```text
a packet is missed
a tick is processed differently
a client uses a different setup/map/game option
a projectile/hit outcome differs
```

The initial mitigation strategy is:

```text
- server controls setup/map/options
- server broadcasts tick numbers
- clients repeat last input for missing actor ticks
- clients periodically report compact state telemetry
- periodic checksums detect divergence
- correction snapshots repair divergence
```

### 8.0 Server State Tracking Model

The first server does not need to be fully authoritative, but it needs enough
state visibility to detect obvious divergence and make better bot decisions.
Add compact client state telemetry alongside or near input traffic:

```text
CLIENT_INPUT_OR_STATE {
    client_sequence
    local_actor_slot
    input_status_byte
    player_x_hi
    player_x_lo
    player_y_hi
    player_y_lo
    facing_angle
    state_flags
}
```

For the first playable version, the server should treat these state bytes as
telemetry, not as immediate truth. The server can use them to:

```text
- maintain an approximate room state
- drive simple server bot decisions
- detect large client divergence
- decide when to request a checksum or correction
```

Authority should be explicit when divergence occurs. Recommended first policy:

```text
1. The server chooses a canonical source for correction:
   - single-player/server-bot room: the real Atari client is canonical until
     server-side simulation exists.
   - multiplayer room: prefer server-side deterministic simulation when
     implemented; before that, use a designated room host only for diagnostics.
2. The server sends a correction/resync packet when state is clearly out of
   range, stale, or inconsistent with the chosen canonical source.
3. The Atari client applies the correction through the same state arrays used
   by setup/resync, not by ad hoc writes in the middle of movement code.
```

Do not use client-reported `PLAYER_X/Y/FACING` to override other clients every
tick. That would make the most jittery or wrong client authoritative. Use state
telemetry first for bot planning and divergence detection; promote it to
authority only after a clear server-side rule exists.

### 8.1 Checksum Packet

Every 1-2 seconds:

```text
SERVER_CHECK_REQUEST {
    server_tick
    checksum_region_id
}
```

Client replies:

```text
CLIENT_CHECK_REPLY {
    server_tick
    checksum
}
```

Candidate checksum coverage:

```text
seed bytes
PLAYER_X/Y/FACING
PLAYER_STATE
PLAYER_STATE_TIMER
PLAYER_HIT_FLAG
PLAYER_FIRE_TIMER
PROJECTILE_X/Y
PROJECTILE_ACTIVE_TIMER
PLAYER_SCORE_COUNTERS
```

Use existing setup/checksum coverage as the guide. Do not invent a checksum range without mapping which bytes are stable and shared across clients.

### 8.2 Correction Snapshot

If a client diverges:

```text
SERVER_CORRECTION_SNAPSHOT {
    server_tick
    actor_count
    repeated:
        actor_slot
        PLAYER_X_LO/HI
        PLAYER_Y_LO/HI
        PLAYER_FACING_ANGLE
        PLAYER_STATE
        PLAYER_STATE_TIMER
        PLAYER_FIRE_TIMER
        PROJECTILE_X/Y_LO/HI
        PROJECTILE_ACTIVE_TIMER
        PROJECTILE_DX/DY_LO/HI
        PLAYER_SCORE_COUNTERS
}
```

Apply corrections carefully:

```text
- if player is dead, respawning, or score changed: snap immediately
- if position difference is small: optional gentle correction later
- first implementation: snap all corrected fields for simplicity
```

Do not add correction smoothing until the basic correction mechanism is proven.

---

## 9. FujiNet-Only Transport Design

### 9.1 Transport Boundary

Since FujiNet replaces all transports, there are two possible levels of replacement:

#### Option A: Replace only NET_CALL_VECTOR_0..6

This is closest to the current architecture.

```text
FujiNet code implements:
NET_CALL_VECTOR_0 = read ordered byte / message byte
NET_CALL_VECTOR_1 = write ordered byte / message byte
NET_CALL_VECTOR_2 = byte-ready predicate
NET_CALL_VECTOR_3 = open/init session
NET_CALL_VECTOR_4 = close session
NET_CALL_VECTOR_5 = hold/sync helper
NET_CALL_VECTOR_6 = resume/reopen helper
```

Then existing setup and bank4 live service may continue to work with minimal changes.

#### Option B: Replace bank4 slot $13 with a FujiNet-only service

This is more direct for the server-coordinated tick model.

```text
new FujiNet slot $13 service:
    poll NetStream
    read local input
    send CLIENT_INPUT
    receive SERVER_TICK_INPUTS
    write PLAYER_INPUT_STATUS for actor slots
    handle server commands/events
    preserve expected NET_ERROR_CODE / PENDING_NET_COMMAND behavior if bank12 still checks it
```

Because slot `$13` is called from live, pre-live, resync, and hold/sync wait paths, this option requires careful preservation of the surrounding bank12 expectations.

### 9.2 Recommended Implementation Boundary

For FujiNet-only, use a staged version of A and B:

```text
1. Implement FujiNet setup/device primitives behind NET_CALL_VECTOR_0..6 where
   doing so lets bank12 reuse existing setup, wait, error, and close paths.
2. Preserve the original byte-stream contract only while using the original
   bank4 slot $13 service.
3. For server-coordinated live gameplay, replace or wrap bank4 slot $13 with a
   FujiNet-specific service that reads server tick packets and writes
   PLAYER_INPUT_STATUS.
4. Keep bank12's live expectations intact:
   - clear L3EB9 before returning unless deliberately requesting another poll
   - preserve NET_ERROR_CODE behavior
   - preserve PENDING_NET_COMMAND / OUTGOING_NET_COMMAND compatibility or
     intentionally replace their consumers
```

This keeps the setup path flexible while giving the live game a clean FujiNet-specific service.

Do not feed framed `SERVER_TICK_INPUTS` packets directly into
`NET_CALL_VECTOR_0` unless a driver layer converts them into the original
one-byte-at-a-time ring format. The vector callbacks are byte-level; the
server tick protocol is message-level.

### 9.3 NetStream

Use FujiNet NetStream for TCP-like streaming if it fits RAM/code budget.

If the existing NetStream handler is too large or too CIO-heavy:

```text
- use it as a reference
- implement only the minimal ordered stream operations MIDI Maze needs
```

Required operations:

```text
open/connect
nonblocking byte/message ready
read bytes
write bytes
close
error/status
```

Do not bring in a handler wholesale until RAM/code placement is proven.

---

## 10. What Existing Parts Should Be Reused

### 10.1 Reuse

Reuse these unless a later phase proves they must change:

```text
bank12 high-level setup/gameplay orchestration
bank12 live service loop shape
NET_ERROR_CODE and visible error handling
PLAYER_INPUT_STATUS as the live input API
player state arrays
maze buffer at $3000
bank13 player movement/projectile/scoring path
bank14 renderer
score/status display paths
existing setup parameter arrays
existing setup payload/checksum ideas
bank-call tables and dispatch mechanism
```

### 10.2 Reuse With Caution

```text
bank4 slot $13
bank4 command/status parser
high-bit companion-byte semantics
PENDING_NET_COMMAND / OUTGOING_NET_COMMAND
L3EB9 / L3ECB / L3ECC live state machine
NET_CALL_VECTOR_0..6 wrappers
```

These are useful but hot/volatile. They can be wrapped or replaced, but only after the exact side effects are understood.

### 10.3 Do Not Reuse for FujiNet Persistent State

```text
$0600 scratch
OS FP registers
zero-page scratch
$40CA-$41DF AI scratch
```

Only use these as tightly-scoped temporary scratch after local proof.

---

## 11. What Can Be Overwritten or Reclaimed After Verification

Because this is FujiNet-only, legacy transport code is reclaimable. However, do not overwrite until each range is verified with traces/build checks.

### 11.1 Highest-Value Reclaim Candidates

```text
transport menu text and dispatch clutter
XM301 setup path
SX212 setup path
Atari 850 setup path
modem AT-command strings
bank5 R: handler payload
MIDI-MATE POKEY setup and serial ISR code, if not needed for FujiNet
legacy transport-specific error/status paths
```

### 11.2 Candidate Code Banks

Potential candidates:

```text
banks 3 and 7:
    appear to be mostly/all fill in current source tree
    good candidates for bulk FujiNet code after trace proof

bank 5:
    likely contains R:/modem payload code
    reclaimable if XM301/SX212/850 are removed and no loader path needs it

bank 12:
    setup/orchestration bank
    use only for small FujiNet entry stubs and dispatch glue

bank 15:
    fixed bank
    avoid except for tiny trampolines if absolutely necessary
```

### 11.3 RAM Reuse Candidates

Only after FujiNet-only removal proves the original MIDI/transport path is inactive:

```text
$2D00 MIDI_RX_BUFFER
$2E00 MIDI_TX_BUFFER
$2F00 direct helper RX ring
$0082-$0086 MIDI/POKEY RX/TX indexes
```

Do **not** reuse these until:

```text
- original MIDI vectors are removed/restored
- POKEY serial IRQs are disabled
- no NET vector points at original MIDI helpers
- no setup/live path can call old fixed-bank MIDI helpers
```

### 11.4 Do Not Reclaim

Do not reclaim:

```text
$2B00-$2B0F companion bytes, unless replacing all companion semantics
$3000-$37FF maze buffer
$3968-$3D39 setup/player state
$3D3E-$3DB4 bank-call tables
$3ECF-$3F16 network/setup/bot/player parameter state
$3F26-$41DF live AI/path scratch unless local bots are fully removed and traces prove unused
$72C0-$737F status/message buffers
```

Even in FujiNet-only mode, many of these are part of gameplay or UI state.

---

## 12. Server Protocol Sketch

This protocol is intentionally high-level. Keep wire encoding compact and 6502-friendly.

### 12.1 Session Setup

```text
CLIENT_HELLO
    protocol_version
    client_capabilities
    username

SERVER_HELLO
    accepted/rejected
    protocol_version
    server_message
```

### 12.2 Room List

```text
CLIENT_ROOM_LIST_REQUEST

SERVER_ROOM_LIST_RESPONSE
    room_count
    repeated:
        room_id
        current_players
        max_players
        room_name
```

### 12.3 Join Room

```text
CLIENT_JOIN_ROOM
    room_id
    username

SERVER_JOIN_ROOM_RESPONSE
    accepted/rejected
    reason
    assigned_actor_slot
    real_player_mask
    server_bot_mask
    max_actors
    game_options
```

### 12.4 Map/Setup

```text
SERVER_SETUP_BEGIN
    map_name
    maze_size_index
    actor_count
    local_actor_slot
    human_player_count
    total_player_count
    game_options

SERVER_MAZE_DATA
    encoding_type
    data_length
    maze bytes

SERVER_SETUP_COMPLETE
    setup_checksum
```

Recommended first maze path:

```text
Use HUDSON as known test map.
Server sends whichever representation can be applied to the existing setup/maze buffer with the least code.
Prefer compact existing cell format if it maps cleanly.
Otherwise send expanded $3000 wall-plane data.
```

### 12.5 Live Input

```text
CLIENT_INPUT
    client_sequence
    local_actor_slot
    input_status_byte

SERVER_TICK_INPUTS
    server_tick
    ack_client_sequence
    actor_count
    repeated:
        actor_slot
        input_status_byte
```

### 12.6 Match Events

```text
SERVER_MATCH_EVENT
    event_type
    actor_slot
    extra

event_type:
    match_start
    player_killed
    player_respawned
    player_won
    match_restart
    return_to_lobby
```

For first version, avoid separate hit/death events if the existing gameplay path handles scoring. Add match events only when needed for restart/winner control.

### 12.7 Correction

```text
SERVER_CHECK_REQUEST
CLIENT_CHECK_REPLY
SERVER_CORRECTION_SNAPSHOT
```

Correction is not required for the first “move around with one bot” test, but should be in the planned protocol.

---

## 13. Match Rules

### 13.1 Server Bots

```text
- Server bots hunt real players.
- Server bots may hunt other bots if that is simplest for the first match
  logic, but prefer hunting real players when choosing targets.
- Server bots may use the maze layout for collision and line-of-sight checks,
  but must not see through walls or target players they could not plausibly see.
- Server bots may follow a remembered last-seen position for a short timeout.
- Server bots are eligible winners in the first implementation.
- Server bots are represented as human-range network actors and can have names
  such as "Clyde Bot".
```

### 13.2 Winning

Initial rule:

```text
Any active actor, including a server bot, wins when reaching the configured kill limit.
```

For least ROM change:

```text
- let the existing scoring code increment scores normally
- server sends match restart when any active actor reaches the kill limit
```

If visual bot wins are undesirable later, add a room option or a FujiNet-only
server rule to exclude server bots from victory. Do not complicate the first
version with that distinction.

### 13.3 Restart

When a real player wins:

```text
server sends SERVER_MATCH_EVENT = player_won
server sends match_restart after a delay or acknowledgement
same room, same settings, same map unless server chooses otherwise
clients reset/reload setup state
```

## FujiNet Timeout, Stall, Disconnect, and Resume Model

The original MIDI Maze networking model assumes a local MIDI serial ring. Because that ring is local and timing is predictable, the original game uses short timeout behavior to detect missing data or stalled communication. This is not appropriate for FujiNet internet play. Normal internet latency, Wi-Fi jitter, packet buffering, or temporary server/client delays could trigger those original timeouts and cause unnecessary errors.

For FujiNet-only mode, the original transport timeout behavior should be bypassed, relaxed, or replaced. Timeout authority should move primarily to the server.

### Design Goal

FujiNet gameplay should tolerate short network stalls without breaking the match.

A stalled player should appear to stop moving rather than cause an error or halt the game. If the client resumes communication soon enough, that player should continue in the same match. If the client is silent for too long, the server should mark them disconnected and remove or deactivate them.

### Connection States

The server should track each connected player with a simple connection state:

```text
ACTIVE
  The server is receiving input from the client regularly.

STALLED
  The server has not received input recently, but the player is still considered part of the match.

DISCONNECTED
  The server has not heard from the client for long enough that the player should be removed or deactivated.

REJOINING
  A previously stalled/disconnected client has contacted the server again and needs to be resynchronized.
```

### Recommended Timing Windows

Initial recommended values:

```text
0.0s - 0.5s since last input:
  Player remains ACTIVE.
  Server uses the latest received input.

0.5s - 3.0s since last input:
  Player is treated as temporarily stalled.
  Server broadcasts neutral input for that actor.
  The actor remains visible and alive unless normal gameplay kills them.

3.0s - 10.0s since last input:
  Player is marked STALLED or INACTIVE.
  Server continues broadcasting the actor as stopped, or marks them visually inactive if the client supports it.

10.0s+ since last input:
  Player is treated as DISCONNECTED.
  Server removes the actor from active play or marks the slot empty.
  Server broadcasts a player-left/disconnect event.
```

These values should be tunable on the server. The exact numbers can be adjusted after real-world testing, but the important rule is that short stalls should not cause immediate game errors.

### Server Behavior During a Short Stall

When the server stops hearing from a client, it should not keep replaying movement forever. If the last input was “move forward,” replaying that input indefinitely could cause the player to drift, collide, fire unexpectedly, or diverge across clients.

Instead, after a short grace period, the server should force that actor to neutral input:

```text
movement = none
turning  = none
fire     = off
```

In other words:

```text
use last known valid state
broadcast neutral input
```

This causes the stalled player to appear as if they stopped in place.

### Client Behavior During Missing Server Frames

The Atari client should not treat a short lack of incoming data as a fatal error.

For FujiNet mode, the client should behave as follows:

```text
If no server frame is ready:
  continue the local frame
  keep using the most recent valid server actor input/state
  after a short local grace window, neutralize remote actor input locally
  avoid triggering the original MIDI-ring timeout error

If no server data arrives for a longer client-side timeout:
  show reconnecting / connection lost state
  wait for server resync or return to lobby/menu
```

A real client-side fatal error should be reserved for conditions such as:

```text
- NetStream cannot be opened
- server connection closes
- server explicitly rejects or disconnects the client
- no server packets arrive for a long timeout window
```

The original local-ring byte timeout should not be allowed to kill FujiNet gameplay during normal internet jitter.

Client-side neutralization is a fallback for the case where the Atari stops
receiving server frames before the server can explicitly send neutral input.
It should use the same neutral `PLAYER_INPUT_STATUS` byte the server would
broadcast for stalled actors. Local player input can continue to be read and
sent while the client is trying to reconnect, but remote/server actors should
not keep walking forever on stale "move forward" bytes.

### Resume Behavior

If a stalled client contacts the server again before the disconnect window expires, the server should allow that player to resume.

Resume flow:

```text
1. Client sends input or reconnect/resume packet with session token.
2. Server verifies that the room and player slot are still valid.
3. Server sends a RESYNC packet to that client.
4. Client applies the current authoritative room/game state.
5. Server marks the player ACTIVE again.
6. Server resumes broadcasting that player's live input to the other clients.
```

The client should not be forced back to the lobby unless the server has already removed the player from the room or the match has ended.

### Rejoin After Full Disconnect

If the client contacts the server after the disconnect timeout has expired, the server may either:

```text
Option A:
  reject resume and require the client to rejoin from the room list.

Option B:
  allow rejoin into the same room if the slot is still available.

Option C:
  reserve the slot for a longer grace period but mark the actor inactive.
```

For the first implementation, Option A is simplest:

```text
After full disconnect, require normal room rejoin.
```

Later versions can support slot reservation or mid-match rejoin.

### Interaction With Server-Coordinated Input

This timeout model fits the server-coordinated input design.

The server is already responsible for sending actor input frames:

```text
actor_id
input_status_byte
server_tick
optional flags
```

When a player stalls, the server simply sends:

```text
actor_id = stalled player's slot
input_status_byte = neutral input
flags = STALLED, if supported
```

The clients do not need to independently decide whether another client has timed out. They only consume the server's actor input stream.

### Optional Visual Indication

The first version does not need a special stalled-player visual state. A stalled player can simply stop moving.

Later, the server may send an actor flag:

```text
ACTOR_FLAG_STALLED
ACTOR_FLAG_DISCONNECTED
```

The client could use this to:

```text
- dim the player
- suppress firing
- show a status icon
- remove the actor from the scoreboard
```

This is optional polish and should not block the first FujiNet implementation.

### Important Rule

For FujiNet-only mode:

```text
The server decides whether a player is active, stalled, resumed, or disconnected.
The Atari client should not use the original local MIDI-ring timeout as a fatal gameplay error.
```

The Atari should continue running smoothly using the latest valid server-provided input/state until the server sends a resync, disconnect, or match-control event.

---

## 14. Implementation Plan

## Phase 0 — Pre-Conversion Documentation and Verification

**Goal:** Gather the remaining proof needed before code conversion.

### Tasks

1. Confirm exact active path that consumes `PLAYER_INPUT_STATUS`.
2. Confirm whether bank13 slot `$03` is the live movement consumer or if the call path is indirect/hidden.
3. Trace slot `$13` side effects:
   - `NET_ERROR_CODE`
   - `PENDING_NET_COMMAND`
   - `OUTGOING_NET_COMMAND`
   - `PLAYER_INPUT_STATUS`
   - `L3EB9`
   - `L3ECB`
   - `L3ECC`
4. Trace exact active live call order from bank12 during real gameplay.
5. Confirm which legacy transport code ranges are safe to remove in FujiNet-only.
6. Confirm candidate bank availability:
   - bank 3
   - bank 7
   - bank 5 after transport removal
7. Confirm RAM reuse candidates:
   - `$2D00-$2FFF`
   - `$0082-$0086`
   - any bank5 handler RAM
8. Confirm best maze injection format:
   - compact cell bytes
   - expanded `$3000` wall-plane
9. Produce an explicit “do not touch” map for gameplay-critical RAM/code.

### Movement Path Proof Plan

Use `atari800-ai` to prove the active path from `PLAYER_INPUT_STATUS` to
movement before replacing slot `$13`.

Trace setup:

```text
1. Boot the byte-exact ROM in atari800-ai.
2. Reach a simple live game state.
3. Set breakpoints/watchpoints on:
   - bank12 L9A2D live service slice
   - bank4 BANK4_NET_COMMAND_SERVICE_ENTRY
   - PLAYER_INPUT_STATUS writes
   - bank13 slot $03 byte entry at $8185
   - PLAYER_X_LO/HI and PLAYER_Y_LO/HI writes for the local slot
4. Drive joystick directions and fire through the AI socket.
5. Record the call path and bank state whenever movement or fire changes.
```

Proof criteria:

```text
- a joystick change writes PLAYER_INPUT_STATUS[LOCAL_PLAYER_INDEX]
- the active movement path reads the same byte
- movement/fire bits reach L00C7 or the equivalent decoded input byte
- PLAYER_X/Y/FACING or projectile state changes after that read
- the caller of bank13 slot $03, or any indirect byte-level equivalent, is
  identified well enough to hook around safely
```

Deliverable: `docs/fujinet-live-input-consumer-trace.md`.

### Game Service Cadence Measurement Plan

Use `atari800-ai` to measure how often the existing game services transport,
bot update, and movement relative to Atari frames. Do this before choosing the
server tick rate.

Trace setup:

```text
1. Add debugger breakpoints or lightweight trace counters for:
   - bank12 L9A2D
   - slot $13 bank4 service entry
   - slot $22 bank0 gameplay update
   - active movement consumer path
   - checksum/resync path entered every $15 ticks
2. Run fixed frame windows:
   - 300 emulator frames idle in live play
   - 300 frames holding forward
   - 300 frames firing
   - 300 frames with a remote/server actor if available
3. Record call counts per 60 frames and average spacing between calls.
4. Repeat once with bots disabled and once with local bots enabled if current
   setup makes that possible.
```

Proof criteria:

```text
- measured slot $13 calls per second
- measured movement updates per second
- measured slot $22 calls per second
- confirmation whether one server tick should map to every slot $13 service,
  every Nth slot $13 service, or the movement consumer cadence
```

Deliverable: `docs/fujinet-game-service-cadence.md`.

### Deliverables

```text
docs/fujinet-only-reclaim-map.md
docs/fujinet-live-input-consumer-trace.md
docs/fujinet-slot13-side-effects.md
docs/fujinet-maze-injection-choice.md
docs/fujinet-code-ram-placement.md
docs/fujinet-game-service-cadence.md
```

### Tests

```text
make compare
emulator trace: boot → setup → live play
watch PLAYER_INPUT_STATUS writes/reads
watch candidate reclaim ranges
```

---

## Phase 1 — FujiNet-Only Branch Skeleton

**Goal:** Make the build conceptually FujiNet-only without removing old code yet.

### Tasks

1. Add a FujiNet-only build flag or branch marker.
2. Keep the byte-exact original build as a separate Makefile target.
3. Add a FujiNet build target that may intentionally differ from the original.
4. Make transport selection deterministic:
   - direct boot to FujiNet setup stub, or
   - menu shows only FujiNet.
5. Keep legacy code physically present for now.
6. Add debug screen/status output confirming FujiNet path.

Recommended build split:

```text
make              builds the current byte-exact original target
make compare      compares the original target against ref/MIDI Maze-Original.rom
make fujinet      builds the FujiNet-only ROM
make run          runs the original target unless FUJINET=1 is specified
make run-fujinet  runs the FujiNet-only ROM
```

The original target remains the regression guard. The FujiNet target can change
menu flow, setup behavior, bank contents, and checksums intentionally, but every
intentional difference should be documented.

### Tests

```text
original ROM builds
make compare remains exact for the original target
FujiNet ROM builds
FujiNet differences are documented instead of treated as compare failures
FujiNet selection reaches stub
legacy accidental menu entries are inaccessible
```

---

## Phase 2 — FujiNet Device Setup

**Goal:** Talk to FujiNet and establish a server stream before touching gameplay.

### Tasks

1. Mount required disks through FujiNet.
2. Load username from AppKey:
   - creator ID: `$3022`
   - app ID: `$02`
   - key ID: `$01`
3. If username missing:
   - prompt user
   - save username to AppKey
4. Enable NetStream mode.
5. Connect to test server.
6. Exchange `CLIENT_HELLO` / `SERVER_HELLO`.

AppKey reference:

```text
https://github.com/FujiNetWIFI/fujinet-firmware/wiki/SIO-Command-%24DC-Open-App-Key
```

The FujiNet wiki documents SIO command `$DC` as "Open App Key" for FujiNet
device `$70`. It takes a six-byte open buffer:

```text
2 bytes creator ID
1 byte app ID
1 byte key ID
1 byte open mode: 0 = read, 1 = write
1 byte reserved: 0
```

The same page lists creator ID `0x3022` for `@mozzwald`. Before implementation,
verify the final app/key IDs for MIDI Maze and whether username should use the
shared lobby player-name key or a MIDI Maze-specific key.

### Tests

```text
first run prompts for username
second run loads saved username
server sees connection
Atari displays server hello/debug text
clean failure if server unavailable
```

---

## Phase 3 — Lobby and Room List

**Goal:** Prove room flow without gameplay.

### Tasks

1. Request room list.
2. Display:
   - room name
   - active players
   - max players
3. Select a room.
4. Reject full room cleanly.
5. Join accepted room.

### Tests

```text
room list appears
1/8 style counts display
full rooms reject
join response assigns actor slot
disconnect returns to lobby/error screen
```

---

## Phase 4 — Server-Controlled Setup and HUDSON Map

**Goal:** Server owns setup/map but gameplay still not live.

### Tasks

1. Server sends HUDSON test map.
2. Client loads maze into existing buffers.
3. Server sends:
   - `LOCAL_PLAYER_INDEX`
   - `HUMAN_PLAYER_COUNT`
   - `TOTAL_PLAYER_COUNT`
   - player start positions/facing
   - game options
   - bot counts set to zero for server-bot-as-human-slot model
4. Verify existing render/setup code can display the maze.

### Tests

```text
HUDSON loads
maze buffer matches expected bytes
player slot 0 visible
server bot slot 1 visible or initialized
no local bots spawned
setup checksum stable if used
```

---

## Phase 5 — First Live Server-Coordinated Gameplay

**Goal:** One real Atari player vs one server bot.

### Tasks

1. Set:
   - `LOCAL_PLAYER_INDEX = 0`
   - `HUMAN_PLAYER_COUNT = 2`
   - `TOTAL_PLAYER_COUNT = 2`
   - bot counts = 0
2. Client reads local joystick/fire.
3. Client writes local input to `PLAYER_INPUT_STATUS[0]`.
4. Client sends local input plus compact local state telemetry to server.
5. Server bot chooses input for slot 1.
6. Server broadcasts tick input for slot 1.
7. Client writes bot input to `PLAYER_INPUT_STATUS[1]`.
8. Existing gameplay path updates both players.

For the first server bot, keep AI simple enough that it can run from telemetry:

```text
- raycast from the bot's current cell/facing through the maze
- target the player only if the raycast has line of sight
- remember the last seen player cell for a short timeout
- turn toward the last seen cell while memory is valid
- move forward when roughly aligned and not blocked by walls
- fire only when line of sight and facing make the shot plausible
- patrol/search when no player is visible or remembered
- stop or turn when repeated telemetry suggests it is stuck
```

Do not port the original bank0/bank1 AI to the server for the first test.
Server-side deterministic simulation can come later if simple telemetry-driven
bot input is not good enough.

### Tests

```text
local player moves smoothly
server bot moves through maze
server bot can hunt player
projectiles/fire still work if enabled
no bank0 local bot AI touches slot 1
server receives player position/facing telemetry
disconnect/error handled
```

---

## Phase 6 — Multi-Player Server-Coordinated Input

**Goal:** Multiple real players, still using input coordination.

### Tasks

1. Server assigns slots for multiple clients.
2. Each client sends only local input.
3. Server broadcasts all actor inputs.
4. Each client applies:
   - immediate local input for its own slot
   - server tick input for all other slots
5. Add simple tick discard:
   - ignore older server ticks
   - repeat last input if no new tick

### Tests

```text
two real clients see each other move
local input remains responsive
remote movement is acceptable with repeat-last fallback
room full rejection works
join/leave behavior is safe or disabled during active match
```

---

## Phase 7 — Periodic Checksum and Correction

**Goal:** Detect and repair divergence.

### Tasks

1. Define checksum range.
2. Define the first canonical authority policy:
   - Phase 5 single-client/server-bot: the real client is canonical for its
     local simulated state, while the server is canonical for room/session/tick
     state.
   - Later multiplayer: prefer server-side deterministic simulation; until
     that exists, use checksums for diagnostics and only apply corrections from
     an explicitly selected canonical source.
3. Client computes checksum every N server ticks or on request.
4. Server compares client checksums and state telemetry.
5. Add correction snapshot packet.
6. Client applies correction snapshot through documented setup/resync-safe
   state writes.

### Tests

```text
normal gameplay checksums match
intentional packet loss causes divergence detection
correction restores play
score/death correction works
```

Do not use the original `CMD_RESYNC` blindly as the FujiNet correction
mechanism until its existing side effects are traced. It may be a useful user
visible command path, but FujiNet correction should have an explicit packet and
an explicit list of state arrays to write.

---

## Phase 8 — Match End and Restart

**Goal:** Server controls winner eligibility and restart.

### Tasks

1. Server tracks real-player slots.
2. Server ignores bot slots for win eligibility.
3. Detect real player reaching kill limit:
   - either by client score report/checksum
   - or by server-side event tracking if added
4. Server sends match end/restart command.
5. Client resets same room/settings.

### Tests

```text
real player can win
server bot cannot win
match restarts with same settings
scores reset correctly
players remain in room
```

---

## Phase 9 — Reclaim Legacy Code and RAM

**Goal:** Remove old transport code after the FujiNet-only path is stable.

### Tasks

1. Remove/hide old menu text and dispatch.
2. Remove XM301/SX212/850 setup paths.
3. Reclaim bank5 if proven unused.
4. Reclaim MIDI-MATE POKEY setup/ISR code if proven unused.
5. Reclaim `$2D00-$2FFF` only after old MIDI helpers are unreachable.
6. Move FujiNet code into proven bank space.

### Tests

```text
build succeeds
FujiNet mode still works
watchpoints prove reclaimed RAM not touched by old paths
no unexpected bank switches into reclaimed code
long-run gameplay test
```

---

## Phase 10 — Optional Stronger Server Authority

Only do this if Phase 5-8 show unacceptable divergence or cheating risk.

### Options

1. Server-authoritative correction snapshots more often.
2. Server validates inputs against maze/wall rules.
3. Server simulates full state and sends snapshots.
4. Client switches to interpolation/smoothing of `PLAYER_X/Y`.

### Warning

This phase is a real gameplay rewrite. It will require preventing the old input-driven simulation from fighting server-written player arrays.

---

## 15. First Codex Prompt for This Direction

```text
You are working in the midimaze-rebuild repo.

We are switching to a FujiNet-only branch, but we are not implementing FujiNet yet.

Read:
- docs/gameplay.md
- docs/fujinet-porting.md
- include/game_ram.inc

Create the Phase 0 verification docs needed for a FujiNet-only server-coordinated port.

Important design direction:
- FujiNet will replace all legacy transports.
- The first gameplay model should be server-coordinated input, not fully server-authoritative snapshots.
- Preserve PLAYER_INPUT_STATUS as the live input API.
- Preserve the existing movement/projectile/scoring/rendering path as much as possible.
- Server bots should initially be represented as human-range network actors, not local bot slots.

Deliverables:
1. docs/fujinet-only-reclaim-map.md
2. docs/fujinet-live-input-consumer-trace.md
3. docs/fujinet-slot13-side-effects.md
4. docs/fujinet-maze-injection-choice.md
5. docs/fujinet-code-ram-placement.md

For each candidate reclaim area, document:
- bank/range/address
- current purpose
- why it becomes unnecessary in FujiNet-only
- whether it is safe now, safe later, or unsafe
- exact trace/build proof required before overwriting

For the live gameplay path, document:
- exact routines that write PLAYER_INPUT_STATUS
- exact routines that consume PLAYER_INPUT_STATUS
- whether bank13 slot $03 is active in live movement or whether the caller remains indirect/unknown
- what slot $13 must preserve if replaced by a FujiNet-only live service

Do not implement FujiNet code yet.
Do not remove legacy code yet.
Do not refactor gameplay.
Documentation and trace planning only.
Run make compare if any comments/source files are touched.
```

---

## 16. Bottom-Line Recommendation

Use this progression:

```text
FujiNet-only setup/lobby/map
        ↓
server-coordinated input ticks
        ↓
existing gameplay engine
        ↓
checksum/correction if needed
        ↓
legacy transport reclaim
        ↓
only later consider full server-authoritative state
```

This design fits the game instead of forcing the game to fit a modern network model. It preserves the highest-risk, hardest-to-rewrite pieces — movement, collision, projectile, scoring, rendering — while replacing the transport/session parts that FujiNet actually needs to own.
