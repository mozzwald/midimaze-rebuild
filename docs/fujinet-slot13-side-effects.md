# FujiNet Slot 13 Side Effects

This document records Phase 0B findings for bank 4 slot `$13`,
`BANK4_NET_COMMAND_SERVICE_ENTRY`. The goal is to define what a future
FujiNet live service must preserve if it replaces or wraps the original live
transport service.

## Trace Setup

- ROM: `build/midimaze.rom`
- Emulator command:

```sh
SDL_VIDEODRIVER=dummy atari800-ai -ai -xl -ntsc -nosound -cart-type 14 -cart /home/ahlegna/.mozzwald/midimaze-rebuild/build/midimaze.rom
```

Solo navigation used joystick input:

1. Press joystick FIRE once from the title/menu screen to select default SOLO.
2. Press joystick FIRE once on the options screen to select default PLAY.
3. Sample memory during the live solo maze.

The local `breakpoint` command is unavailable in this emulator build, so
runtime evidence is frame-polled. Transient state that is set and cleared
within one frame is documented from source unless it was visible in polling.

## Slot 13 Entry Points

Bank 4 slot `$13` is a `JMP L8080` stub at `$8000`.

Relevant ranges:

| Range | Role |
|---:|---|
| `$8048-$807F` | slot `$1B` state reset; clears bank 4 network/display state |
| `$8080-$8185` | local packet start, local special-byte handling, local input pack/send |
| `$8188-$81DE` | remote first-byte receive path |
| `$81E4-$820D` | remote companion-byte receive path |
| `$821E-$82C7` | completed exchange scan; clears phase state and latches commands |

The key state bytes are:

| Address | Name | Role |
|---:|---|---|
| `$2B00+X` | `L2B00,X` | per-player companion byte for high-bit status bytes |
| `$3D29+X` | `PLAYER_INPUT_STATUS,X` | movement/fire/status byte consumed by bank 13 |
| `$3EB9` | `L3EB9` | exchange phase: `0` new/local, `1` remote first byte, `>1` companion byte |
| `$3ECB` | `L3ECB` | current player/ring index during exchange/scan |
| `$3ECC` | `L3ECC` | remaining human-player bytes in current exchange |
| `$3ED2` | `NET_ERROR_CODE` | error/status observed by bank 12 |
| `$3EE7` | `PENDING_NET_COMMAND` | command latched from remote companion bytes |
| `$3EE8` | `OUTGOING_NET_COMMAND` | command queued by bank 12 for next local packet |
| `$3CE8` | `SETUP_SYNC_TOGGLE_FLAG` | toggled by local special byte `$7F` |
| `$3F0A` | `SETUP_HOLD_SYNC_FLAG` | set by local special byte `$1B` |

## Observed Solo Steady State

After entering live solo:

```text
LOCAL_PLAYER_INDEX = $00
HUMAN_PLAYER_COUNT = $01
TOTAL_PLAYER_COUNT = $01
L2B00[0]           = $FF
PLAYER_INPUT[0]    = $00 when idle
L3EB9              = $00
L3ECB              = $01 after completed scan
L3ECC              = $00
NET_ERROR_CODE     = $00
PENDING_COMMAND    = $00
OUTGOING_COMMAND   = $00
```

In solo, ordinary local input completes in one slot `$13` service because
`HUMAN_PLAYER_COUNT` is one. The code sets `L3ECC=1`, writes the local player
status, decrements `L3ECC` to zero, and jumps directly to `L821E`. The
completion scan clears `L3EB9` and `L3ECB`, scans player 0, then leaves
`L3ECB=HUMAN_PLAYER_COUNT` (`$01`) before returning.

Frame-polled examples:

| Input | `L2B00[0]` | `PLAYER_INPUT_STATUS[0]` | `L3EB9` | `L3ECB` | `L3ECC` | Command/error result |
|---|---:|---:|---:|---:|---:|---|
| idle | `$FF` | `$00` | `$00` | `$01` | `$00` | no pending command, no error |
| up | `$FF` | `$01` | `$00` | `$01` | `$00` | no pending command, no error |
| fire | `$FF` | `$10` | `$00` | `$01` | `$00` | no pending command, no error |

Movement/fire effects from bank 13 were observed in the same live session, but
those are documented in `docs/fujinet-live-input-consumer-trace.md`.

## Ordinary Local Input Path

When `L3EB9=0` and `OUTGOING_NET_COMMAND=0`, slot `$13` starts a local packet:

```text
L808E: LDA HUMAN_PLAYER_COUNT
       STA L3ECC
       LDA OUTGOING_NET_COMMAND
       BEQ L80A1
```

If no local special byte is pending in the fixed helper ring, the path at
`L811F` sets the companion byte to `$FF`, clears the high-bit marker, reads
`STICK0`/`STRIG0`, and stores the packed byte:

```text
L811F: LDX LOCAL_PLAYER_INDEX
       LDA #$FF
       STA L2B00,X
       LDA #$00
L8129: STA L0080
       LDA STICK0
       EOR #$0F
       LDX STRIG0
       BNE L8137
       ORA #$10
...
L814B: ORA L0080
       LDX LOCAL_PLAYER_INDEX
       STA PLAYER_INPUT_STATUS,X
       DEC L3ECC
       BNE L815B
       JMP L821E
```

In solo, `DEC L3ECC` reaches zero immediately and avoids the remote send/wait
path. That is why `L3EB9` remains zero in the frame-polled live solo trace.

## Completed Exchange Scan

`L821E` is the completion point that bank 12 depends on. It clears phase state
then scans each human slot:

```text
L821E: LDX #$00
       STX L3EB9
       STX L3ECB
L8226: LDA PLAYER_INPUT_STATUS,X
       BMI L822E
       JMP L82B9
...
L82B9: INC L3ECB
       LDX L3ECB
       CPX HUMAN_PLAYER_COUNT
       BCS L82C7
       JMP L8226
L82C7: JSR L802A
       JMP BANK_RETURN
```

For ordinary non-negative input bytes, the scan only advances `L3ECB` and
returns. For solo this leaves `L3ECB=$01`.

For high-bit status bytes, the scan checks `L2B00,X`:

| Companion value | Effect |
|---:|---|
| negative and not `$FF` | stored in `PENDING_NET_COMMAND` |
| `$FF` | no command |
| `$08` | input/status trail countdown handling |
| `$0D` | input/status trail buffer shift/display handling |
| other non-negative | packed into per-player trail buffers |

This scan is one of the key compatibility points for a FujiNet replacement.

## Outgoing Command Path

If `OUTGOING_NET_COMMAND` is nonzero when slot `$13` starts a fresh exchange,
bank 4 consumes it before packing joystick state:

```text
L808E: LDA HUMAN_PLAYER_COUNT
       STA L3ECC
       LDA OUTGOING_NET_COMMAND
       BEQ L80A1
       LDX #$00
       STX OUTGOING_NET_COMMAND
       JMP L8115

L8115: LDX LOCAL_PLAYER_INDEX
       STA L2B00,X
       LDA #$80
       BNE L8129
```

Result:

- `OUTGOING_NET_COMMAND` is cleared.
- The command byte is stored in `L2B00[LOCAL_PLAYER_INDEX]`.
- The outgoing/current local `PLAYER_INPUT_STATUS` byte is forced high with
  `$80`, while still ORing in current joystick/fire bits.

In a multi-human exchange, the high-bit first byte and companion byte are sent
through `NET_CALL_VECTOR_1`. Remote peers receive them through the first-byte
and companion paths, then latch the companion into `PENDING_NET_COMMAND`.

In solo, this command path is too transient to prove cleanly with frame-level
polling: bank 4 can consume `OUTGOING_NET_COMMAND` and bank 12 can react before
the next frame sample. The source path above is the authority for the exact
side effects. A future instruction-level trace or temporary instrumentation can
capture the short-lived `L2B00=$80/$82` and high-bit `PLAYER_INPUT_STATUS`.

## Remote Receive Path

Remote receive behavior was not runtime-proven in solo because
`HUMAN_PLAYER_COUNT=1` bypasses the remote wait path. The source contract is:

1. When more human bytes remain, `L815B-L8170` sends the local first byte and,
   if negative, its companion byte, then sets:

```text
L3ECB = LOCAL_PLAYER_INDEX
L3EB9 = L3EB9 + 1
NET_TIMEOUT_DEADLINE = L00B3 + NET_TIMEOUT_TICKS
```

2. `L8188-L81C3` waits for a remote first byte through `NET_CALL_VECTOR_2/0`,
   stores it in `PLAYER_INPUT_STATUS,X`, and either clears `L2B00,X` to `$FF`
   or advances to companion phase for high-bit bytes.
3. `L81E4-L820D` waits for the companion byte and stores it in `L2B00,X`.
4. `L821E-L82C7` clears `L3EB9`, scans all human slots, and latches commands.

If a remote byte is not ready before the timeout deadline, `L81D2-L81DE` sets
`NET_ERROR_CODE=$C7`.

## FujiNet Replacement Contract

A FujiNet live slot `$13` replacement or wrapper must preserve these externally
visible effects before returning to bank 12:

- Write current local/server-provided human input bytes into
  `PLAYER_INPUT_STATUS[0..HUMAN_PLAYER_COUNT-1]`.
- Keep `PLAYER_INPUT_STATUS` in the original bit format:
  - bit `$01`: forward
  - bit `$02`: reverse
  - bit `$04`: turn one direction
  - bit `$08`: turn the other direction
  - bit `$10`: fire
  - bit `$80`: companion byte follows
- Maintain or deliberately replace the `$2B00+player` companion-byte contract.
- Clear `L3EB9` before returning when the current exchange/tick is complete.
- Leave `L3ECB` and `L3ECC` in a state compatible with bank 12's `L3EB9` spin.
  The solo completed state is `L3EB9=0`, `L3ECB=HUMAN_PLAYER_COUNT`,
  `L3ECC=0`.
- Preserve `NET_ERROR_CODE=0` on success and the existing timeout/error
  convention if using the original bank 12 error paths.
- Consume `OUTGOING_NET_COMMAND` only when the replacement intentionally
  handles that command, and preserve command semantics for `$80`, `$81`,
  `$82`, `$84`, and `$86`.
- Set `PENDING_NET_COMMAND` only for command bytes that bank 12 should dispatch.
- Do not touch bot slots at or above `HUMAN_PLAYER_COUNT`; bank 0 slot `$22`
  owns those.

For the first FujiNet server-coordinated implementation, the minimum safe
behavior is:

```text
poll FujiNet/server
read local joystick/fire
write PLAYER_INPUT_STATUS[LOCAL_PLAYER_INDEX]
write server-provided remote/server-bot human-slot bytes below HUMAN_PLAYER_COUNT
clear/settle L3EB9 so bank12 can continue to bank13/bank0 updates
surface only real command/error conditions through PENDING_NET_COMMAND and NET_ERROR_CODE
```

## Remaining Network Trace Work

Solo proves the local side effects and the single-human completed state. A
later network trace is still needed for:

- `L3EB9=1` remote first-byte wait behavior
- companion-byte phase for high-bit remote status
- real `NET_CALL_VECTOR_0/1/2` timing and return values
- timeout path to `NET_ERROR_CODE=$C7`
- command propagation from one station's `OUTGOING_NET_COMMAND` to another
  station's `PENDING_NET_COMMAND`
