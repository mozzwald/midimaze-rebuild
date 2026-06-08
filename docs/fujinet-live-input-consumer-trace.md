# FujiNet Live Input Consumer Trace

This document records Phase 0A findings for the path from live input bytes to
player movement. The goal is to prove what a FujiNet live service may write,
and what existing gameplay code consumes, before replacing or wrapping bank 4
slot `$13`.

## Trace Setup

- ROM: `build/midimaze.rom`
- Original compare target: `ref/MIDI Maze-Original.rom`
- Emulator command:

```sh
SDL_VIDEODRIVER=dummy atari800-ai -ai -xl -ntsc -nosound -cart-type 14 -cart /home/ahlegna/.mozzwald/midimaze-rebuild/build/midimaze.rom
```

The first non-dummy launch failed with `System reports no display resolutions
available`. The dummy video driver allowed the AI socket to run headlessly.
Screenshots failed under the dummy driver, but `screen_ascii`, `cpu`,
`joystick`, `consol`, `peek`, and `poke` worked.

The local `breakpoint` command is documented as unavailable in this build, so
this trace used frame-by-frame polling and static byte inspection.

## Live/Setup Navigation Observed

The reliable solo test sequence is joystick-only:

1. From the title/menu screen, press joystick FIRE once. SOLO is the default
   selection.
2. On the game options screen, press joystick FIRE again. PLAY is the default
   selection.
3. The solo game starts in the maze.

Earlier console-key testing reached setup/status paths but did not reliably
enter the live solo loop. Joystick FIRE is the correct path for this trace.

After the first joystick FIRE, the setup/options state showed:

| Address | Name | Observed value | Meaning |
|---:|---|---:|---|
| `$3968` | `LOCAL_PLAYER_INDEX` | `$00` | local player slot 0 |
| `$396B` | `HUMAN_PLAYER_COUNT` | `$01` | one human player |
| `$396E` | `TOTAL_PLAYER_COUNT` | `$01` | one active player |
| `$396F` | `MAZE_SIZE_INDEX` | `$07` | selected maze size |

After the second joystick FIRE, live solo maze state showed:

| Address | Name | Observed value |
|---:|---|---:|
| `$3A72` | `PLAYER_STATE[0]` | `$03` |
| `$39B2/$39D2` | `PLAYER_X_LO/HI[0]` | `$80/$05` |
| `$39F2/$3A12` | `PLAYER_Y_LO/HI[0]` | `$80/$01` |
| `$3A32` | `PLAYER_FACING_ANGLE[0]` | `$00` |

This state did enter the live movement loop. No RAM pokes were needed for the
successful trace.

## Producer Path Proven

Bank 4 slot `$13`, `BANK4_NET_COMMAND_SERVICE_ENTRY`, packs joystick/fire state
into `PLAYER_INPUT_STATUS[LOCAL_PLAYER_INDEX]`.

Relevant source:

```text
src/banks/bank04.asm:L811F-L814B
```

Decoded behavior:

```text
LDX LOCAL_PLAYER_INDEX
LDA #$FF
STA $2B00,X
LDA #$00
STA L0080
LDA STICK0
EOR #$0F
LDX STRIG0
BNE no_fire
ORA #$10
...
ORA L0080
LDX LOCAL_PLAYER_INDEX
STA PLAYER_INPUT_STATUS,X
```

Runtime observations after SOLO setup:

| Socket input | `PLAYER_INPUT_STATUS[0]` |
|---|---:|
| center, no fire | `$00` |
| up | `$01` |
| right | `$08` |
| fire | `$10` |
| up + fire | `$11` |

This proves the current bank 4 service can produce the same byte shape that a
FujiNet live service would need to produce for local/server-provided actor
inputs.

## Consumer Runtime Proven

The joystick-only SOLO/PLAY sequence reached a live loop where
`PLAYER_INPUT_STATUS[0]` drives `L00C7` and the player state arrays.

Key observations:

| Probe | Input byte | Consumer evidence | State change |
|---|---:|---|---|
| forward/up | `$01` | `L00AC=$00`, `L00C7=$01` on movement frames | `PLAYER_X_LO[0]` changed from `$80` to `$60`, then `$41`; `PLAYER_X_HI[0]` stayed `$05`. |
| right | `$08` | `L00AC=$00`, `L00C7` carried prior/current input during sampled frames | `PLAYER_FACING_ANGLE[0]` changed from `$00` to `$08`, then continued rotating in `$08` steps. |
| fire | `$10` | `L00AC=$00`, fire branch reached on sampled frames | `PLAYER_FIRE_TIMER[0]` loaded/decremented; projectile position bytes changed from zero. |
| up + fire | `$11` | `L00AC=$00`, `L00C7=$11` observed on sampled frames | `PLAYER_Y_LO/HI[0]` advanced, `PLAYER_FIRE_TIMER[0]` loaded, and `PROJECTILE_ACTIVE_TIMER[0]` became `$0A`. |

Representative live samples:

```text
Initial live:
  PLAYER_INPUT_STATUS[0] = $00
  PLAYER_STATE[0]        = $03
  PLAYER_X_LO/HI[0]      = $80/$05
  PLAYER_Y_LO/HI[0]      = $80/$01
  PLAYER_FACING_ANGLE[0] = $00

Forward/up, frame 1:
  PLAYER_INPUT_STATUS[0] = $01
  L00AC                  = $00
  L00C7                  = $01
  PLAYER_X_LO/HI[0]      = $60/$05
  PLAYER_Y_LO/HI[0]      = $80/$01

Forward/up, later:
  PLAYER_INPUT_STATUS[0] = $01
  L00AC                  = $00
  L00C7                  = $01
  PLAYER_X_LO/HI[0]      = $41/$05
  PLAYER_Y_LO/HI[0]      = $80/$01

Right turn:
  PLAYER_INPUT_STATUS[0] = $08
  L00AC                  = $00
  PLAYER_FACING_ANGLE[0] = $08

Up + fire:
  PLAYER_INPUT_STATUS[0]     = $11
  L00AC                      = $00
  L00C7                      = $11
  PLAYER_FIRE_TIMER[0]       = $09
  PROJECTILE_ACTIVE_TIMER[0] = $0A
```

`L00C7` is also used as scratch by other routines, so it does not continuously
hold the input byte when sampled outside the exact movement window. The
important evidence is that on movement/fire frames it matches the current
`PLAYER_INPUT_STATUS[L00AC]`, and the expected state arrays change immediately
afterward.

## Consumer Entry Identified

Bank 13 slot `$03`, `BANK13_PLAYER_MAZE_UPDATE_ENTRY`, starts at `$8185`.
The source preserves the first byte as data because the surrounding region is
mixed code/data, but the emitted bytes decode as:

```text
$8185: A6 AC       LDX L00AC
$8187: BD 29 3D    LDA PLAYER_INPUT_STATUS,X
$818A: 85 C7       STA L00C7
```

`L00C7` is then tested by the movement/fire logic:

| Address | Test | Meaning |
|---:|---|---|
| `$8212` | `L00C7 & $04` | turn one direction |
| `$8227` | `L00C7 & $08` | turn opposite direction |
| `$8235` | `L00C7 & $10` | fire/projectile setup |
| `$8287` | `L00C7 & $01` | forward movement vector |
| `$82AE` | `L00C7 & $02` | reverse movement vector |

The routine stages current position/facing into zero-page work bytes, updates
projectile state on fire, computes movement deltas from facing, and writes back
through the player state arrays after collision/maze checks.

## Active Caller Identified

A binary scan of assembled bank 13 found the previously missing slot `$03`
caller:

```text
bank13 offset $0AEF, mapped address $8AEF:
A2 03 20 1D AF    LDX #$03 ; JSR BANK_CALL_INDEXED
```

This caller is inside bank 13 slot `$10`,
`BANK13_SETUP_PLACEMENT_DISPATCH_ENTRY`, which is still byte-form in source.
The surrounding bytes decode as:

```text
$8ACA: AD 6D 39    LDA L396D
$8ACD: D0 03       BNE $8AD2
$8ACF: 4C 1D 8B    JMP $8B1D
$8AD2: A2 11       LDX #$11
$8AD4: 20 1D AF    JSR BANK_CALL_INDEXED
$8AD7: AD D2 3E    LDA NET_ERROR_CODE
$8ADA: F0 03       BEQ $8ADF
$8ADC: 4C 36 AF    JMP BANK_RETURN
$8ADF: AE 6E 39    LDX TOTAL_PLAYER_COUNT
$8AE2: A9 00       LDA #$00
$8AE4: 9D 91 3A    STA PLAYER_HIT_BY_INDEX,X
$8AE7: CA          DEX
$8AE8: D0 FA       BNE $8AE4
$8AEA: AD 3D 3D    LDA L3D3D
$8AED: 85 AC       STA L00AC
$8AEF: A2 03       LDX #$03
$8AF1: 20 1D AF    JSR BANK_CALL_INDEXED
$8AF4: D0 05       BNE $8AFB
$8AF6: A9 03       LDA #$03
$8AF8: 4C 36 AF    JMP BANK_RETURN
$8AFB: A6 AC       LDX L00AC
$8AFD: D0 03       BNE $8B02
$8AFF: AE 6E 39    LDX TOTAL_PLAYER_COUNT
$8B02: CA          DEX
$8B03: 86 AC       STX L00AC
$8B05: EC 3D 3D    CPX L3D3D
$8B08: D0 E0       BNE $8AEA
$8B0A: EE 3D 3D    INC L3D3D
$8B0D: AD 3D 3D    LDA L3D3D
$8B10: CD 6E 39    CMP TOTAL_PLAYER_COUNT
$8B13: D0 05       BNE $8B1A
$8B15: A9 00       LDA #$00
$8B17: 8D 3D 3D    STA L3D3D
```

This makes the active design clearer:

1. Bank 13 slot `$10` calls volatile slot `$11`.
2. In the gameplay setup/live configuration, slot `$11` is patched by bank 12
   to the bank 12 service continuation at `$9A15`.
3. Bank 13 slot `$10` then selects a player index from `L3D3D`, stores it in
   `L00AC`, and calls slot `$03`.
4. Slot `$03` copies `PLAYER_INPUT_STATUS[L00AC]` to `L00C7` and performs the
   movement/projectile update for that player.

Runtime slot table after maze placement matched the expected live patch:

| Slot | Address table | Bank table |
|---:|---|---:|
| `$03` | `$8185` | `$0D` |
| `$10` | `$8900` | `$0D` |
| `$11` | `$9A15` | `$0C` |
| `$13` | `$8000` | `$04` |
| `$22` | `$8000` | `$00` |

## Remaining Network Trace Work

The local live input consumer path is proven for solo play. This is enough to
support the first FujiNet design rule: a FujiNet live service can drive local
gameplay by writing the same packed status bytes into `PLAYER_INPUT_STATUS`
before bank 13 slot `$10` runs.

Network-specific behavior still needs a later multi-peer or instrumented trace:

- remote human `PLAYER_INPUT_STATUS[X]` writes through bank 4 slot `$13`
- high-bit first bytes and `$2B00,X` companion bytes
- `PENDING_NET_COMMAND` and `OUTGOING_NET_COMMAND`
- `L3EB9`, `L3ECB`, and `L3ECC` exchange pacing with more than one human slot
- timeout/error behavior through `NET_ERROR_CODE`

Those require a real or emulated network setup. Solo play proves the consumer
contract, but not the original multi-node ring exchange.
