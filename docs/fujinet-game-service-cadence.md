# FujiNet Research: Solo Game Service Cadence

This note records a solo runtime trace for estimating the live-game service
cadence that a future FujiNet transport would need to respect. It does not
prove the multi-peer network wait path; solo mode bypasses remote receive work
and keeps the bank 4 slot `$13` state in its completed form at sampled frame
boundaries.

## Setup

ROM under test:

```sh
build/midimaze.rom
```

Emulator command:

```sh
SDL_VIDEODRIVER=dummy atari800-ai -ai -xl -ntsc -nosound -cart-type 14 -cart /home/ahlegna/.mozzwald/midimaze-rebuild/build/midimaze.rom
```

The test used the Atari800 AI socket at `/tmp/atari800_ai.sock`, entered solo
mode with joystick FIRE on the default SOLO menu item, then joystick FIRE on
the default PLAY menu item.

The socket build used here does not provide working breakpoints or reliable CPU
single-stepping, so the trace is frame-polled. Each sample ran exactly one
emulator frame and then read gameplay RAM.

## Watched State

The poll script watched:

- `PLAYER_INPUT_STATUS[0]` at `$3D29`
- `L2B00[0]`
- bank 4 slot `$13` state bytes `L3EB9`, `L3ECB`, and `L3ECC`
- `NET_ERROR_CODE`, `PENDING_NET_COMMAND`, and `OUTGOING_NET_COMMAND`
- local player position and facing arrays
- local fire/projectile timers and projectile position

The initial live state for this run was:

```text
LOCAL_PLAYER_INDEX-equivalent slot: 0
PLAYER_INPUT_STATUS[0]: $00
L2B00[0]: $FF
L3EB9/L3ECB/L3ECC: $00/$01/$00
NET_ERROR_CODE/PENDING_NET_COMMAND/OUTGOING_NET_COMMAND: $00/$00/$00
PLAYER_X_LO/HI[0]: $80/$05
PLAYER_Y_LO/HI[0]: $80/$02
PLAYER_FACING_ANGLE[0]: $40
PLAYER_FIRE_TIMER[0]: $00
PROJECTILE_ACTIVE_TIMER[0]: $00
```

## Results

Across all sampled solo windows, slot `$13` was always observed in the completed
state at frame boundaries:

```text
L2B00[0] = $FF
L3EB9    = $00
L3ECB    = $01
L3ECC    = $00
NET/PENDING/OUT command bytes = $00
```

No sampled frame caught an in-progress packet state. This matches the static
bank 4 trace: solo has one human player, so slot `$13` packs local joystick
input, decrements the remaining-human counter to zero, and reaches the
completion scan without waiting for remote bytes.

### Idle

In a 300-frame idle window:

- `PLAYER_INPUT_STATUS[0]` stayed `$00`.
- Position, facing, fire timers, projectile timers, and command bytes did not
  change.
- No non-completed slot `$13` state was sampled.

### Held Up

In a 300-frame window with joystick UP held:

- `PLAYER_INPUT_STATUS[0]` changed from `$00` to `$01` at sampled frame 2.
- `PLAYER_Y_LO[0]` changed on 26 sampled frames.
- Most `PLAYER_Y_LO[0]` change intervals were 4 or 5 frames.
- `PLAYER_Y_HI[0]` changed on sampled frames 15, 49, and 78.
- The final sampled position was `X=$0580`, `Y=$05BF`.
- Slot `$13` state remained completed in every sampled frame.

This shows that stable held movement reaches `PLAYER_INPUT_STATUS` quickly, but
the movement state arrays are not meaningfully updated every video frame.

### Held Right

In a 180-frame window with joystick RIGHT held:

- `PLAYER_INPUT_STATUS[0]` changed from `$00` to `$08` at sampled frame 3.
- `PLAYER_FACING_ANGLE[0]` changed on 45 sampled frames.
- Most facing-change intervals were 3 or 4 frames.
- The final sampled facing byte was `$A8`.
- Slot `$13` state remained completed in every sampled frame.

Turning appears to update somewhat faster than forward movement, but still not
at every NTSC video frame.

### Held Fire

In a 180-frame window with joystick FIRE held:

- `PLAYER_INPUT_STATUS[0]` was already `$10` in the first sampled frame.
- `PLAYER_FIRE_TIMER[0]` changed on 36 sampled frames.
- Most fire-timer intervals were 5 frames, with observed range 4 to 6 frames.
- `PROJECTILE_ACTIVE_TIMER[0]` changed in repeating bursts, with sampled
  changes at frames 1, 11, 50, 61, 100, 111, 150, and 161.
- Projectile position changes clustered around those active-timer bursts.
- Slot `$13` state remained completed in every sampled frame.

The exact projectile cadence should not be overinterpreted from solo frame
polling, but the trace confirms that a held fire bit is preserved through the
live input/status path and that projectile side effects occur in gameplay-time
bursts rather than every frame.

### Alternating Up And Center Every Frame

In a 120-frame window where the joystick alternated UP and CENTER every sampled
frame:

- `PLAYER_INPUT_STATUS[0]` changed only 13 times.
- 66 sampled frames did not match the just-requested joystick state.
- Position changed only on a subset of the frames that exposed UP.
- Slot `$13` state still remained completed in every sampled frame.

This is the most important cadence result for a future server-driven model:
the game should not be treated as if it consumes a new authoritative input byte
every video frame. Very short input pulses can be missed or held across sampled
frames by the existing service/update cadence.

## FujiNet Implications

For a first server-coordinated FujiNet design, a 20 Hz authoritative server tick
is a reasonable initial target. It is close to the observed 3-to-5-frame update
cadence for turning, movement, and fire timers, while avoiding a false
requirement that the server supply one fresh packet per NTSC video frame.

A 30 Hz tick may also be practical if the client repeats the most recent server
state between ticks, but the solo trace does not show enough useful gameplay
state change to justify requiring 60 Hz network traffic.

The client-side live hook should be prepared to:

- keep the latest known input/status byte available between server ticks,
- tolerate slot `$13` being called more often than new network data arrives,
- leave `PLAYER_INPUT_STATUS` stable when no newer server frame is available,
- avoid treating one-frame joystick pulses as guaranteed network-visible input.

## Remaining Network Trace

Solo mode cannot prove the remote-human path. A later multi-peer trace still
needs to measure:

- how long `L3EB9` stays nonzero while waiting for remote bytes,
- whether `L3ECC` decrements once per received peer byte under live network
  play,
- timeout/error behavior through `NET_ERROR_CODE`,
- command propagation through `$2B00`, `PENDING_NET_COMMAND`, and
  `OUTGOING_NET_COMMAND`,
- whether multi-peer gameplay blocks the main loop or repeats old input when a
  peer packet is late.

Until that trace exists, the 20 Hz server tick should be treated as a design
starting point, not a proven compatibility limit.
