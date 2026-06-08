# FujiNet Research: Network Vector Call Sites

This note tightens the `NET_CALL_VECTOR_0..6` contract before any FujiNet
implementation work. It is static evidence from the current source plus the
solo runtime traces in the adjacent FujiNet docs.

## Fixed-Bank Wrappers

The callable wrapper addresses are exported in `include/fixed_bank.inc`:

| Wrapper | Address | Current meaning from call sites |
|---|---:|---|
| `NET_VECTOR_WAIT_POLL` | `$AFAE` | Wait/poll until a byte is available or timeout/error; returns received byte in `A` on success and uses `NET_ERROR_CODE` on failure. |
| `NET_CALL_VECTOR_0` | `$AFDA` | Read one byte from the active transport. |
| `NET_CALL_VECTOR_1` | `$AFDD` | Write one byte to the active transport. |
| `NET_CALL_VECTOR_2` | `$AFE0` | Cheap byte-ready predicate. |
| `NET_CALL_VECTOR_3` | `$AFE3` | Open/init/reset active transport session. |
| `NET_CALL_VECTOR_4` | `$AFE6` | Close/remove active transport session. No direct call site was found in the current source search; it is still installed by each vector table. |
| `NET_CALL_VECTOR_5` | `$AFE9` | Hold/sync helper before slot `$13` is suppressed. |
| `NET_CALL_VECTOR_6` | `$AFEC` | Resume/reopen helper after hold/sync. |

The RAM vector table is `NET_VECTOR_0_LO/HI` through `NET_VECTOR_6_LO/HI` at
`$3ED3-$3EE0`.

## Vector Installers

Bank 12 installs a full vector family for every transport-like setup path:

| Path | Source | Notes |
|---|---|---|
| `SETUP_XM301_ENTRY` | `src/banks/bank12.asm:L318-L347` | Installs R:/modem callbacks, timeout `$0A`, then performs XM301 setup before shared setup. |
| `SETUP_R_HANDLER_SHARED` | `src/banks/bank12.asm:L398-L425` | Shared SX212/Atari 850 R: callbacks, timeout `$0A`. |
| `SETUP_SOLO_ENTRY` | `src/banks/bank12.asm:L727-L760` | Installs fixed-bank/local callbacks at `$AF62/$AF6C/$AF5D/$AF51/$AF5A`, timeout `$02`, then jumps to `L863D`. |
| `SETUP_MIDIMATE_ENTRY` | `src/banks/bank12.asm:L763-L794` | Installs custom MIDI/POKEY callbacks from `LBE04`-style vector bytes, timeout `$06`, then falls into `L863D`. |

FujiNet should follow this shape: install all seven vector entries before
joining shared setup, even if some entries are no-ops for the first version.

## Shared Setup Calls

`L863D` is the main shared setup entry. It patches volatile bank-call slots,
calls `NET_CALL_VECTOR_3`, clears transport state, and then enters the setup
handshake.

Important setup use:

| Region | Calls | Role |
|---|---|---|
| `L83B2-L83EA` | `NET_CALL_VECTOR_3` | Opens a non-master transport path before carrier/wait/setup work. |
| `L83F0-L845D` | `NET_CALL_VECTOR_3` plus transport writes through helper `LB147` | Modem-style secondary open/status path. |
| `L863D-L86D3` | `NET_CALL_VECTOR_3`, `NET_CALL_VECTOR_1`, `NET_VECTOR_WAIT_POLL` | Shared `$A0/$A1` handshake and local-player index assignment. |
| `L86DE-L86F5` | `NET_SERVICE_WAIT_POLL`, `NET_CALL_VECTOR_1`, `NET_VECTOR_WAIT_POLL` | Direct/local branch of setup startup. |

`NET_CALL_VECTOR_3` must leave the vector state and error byte compatible with
these checks. A nonzero return is treated as setup failure and displayed through
the existing error path.

## Setup And Resync Byte Stream

Bank 12 uses `NET_CALL_VECTOR_1` and `NET_VECTOR_WAIT_POLL` heavily during setup
and resync. The pattern is usually "write a byte, wait for the byte that has
circulated or for the next peer byte, then compare/store it".

Key regions:

| Region | Role |
|---|---|
| `L8707-L877E` | Master setup machine count/player count/start command exchange. |
| `L87FB-L88FC` | Setup menu command exchange and master setup payload send. |
| `L89A7-L89F5` | Roster exchange command `$86` path. |
| `MASTER_SEND_SETUP_PAYLOAD` `L8A99-L8B4F` | Sends marker `$83`, options, maze data, team data, and expects ring echo/check bytes. |
| `L8BB9-L8D0B` | Slave command loop; uses `NET_CALL_VECTOR_2` as a ready predicate, `NET_CALL_VECTOR_0` for command bytes, and `NET_CALL_VECTOR_1` to forward/ack bytes. |
| `SLAVE_RECEIVE_SETUP_PAYLOAD` `L8D4E-L8F56` | Receives setup payload, forwards each byte, and rebuilds `$3000-$37FF` maze state. |
| `L8F57-L9006` | Per-player record/status trail exchange; mixes `NET_CALL_VECTOR_1`, `NET_CALL_VECTOR_0`, and `NET_VECTOR_WAIT_POLL`. |
| `SETUP_CHECKSUM_EXCHANGE` `L9B4B-L9BA5` | Ring-wide checksum retry/ack exchange. |
| `L9BA5+` | Master post-checksum state relay: seeds and per-player state arrays. |

FujiNet can add its own outer packet framing, but the bytes delivered through
these wrappers must still match the original ordered stream unless this entire
setup state machine is replaced.

## Live And Hold Calls

Live gameplay still relies on the same vector family:

| Region | Calls | Role |
|---|---|---|
| Bank 4 slot `$13` around `L8188/L81E4` | `NET_CALL_VECTOR_2`, `NET_CALL_VECTOR_0`, `NET_CALL_VECTOR_1` | Live human status exchange: send local status, poll/read remote first bytes and companion bytes, then complete into `PLAYER_INPUT_STATUS` and `$2B00`. |
| Bank 12 hold/sync `L95D0-L963C` | `NET_CALL_VECTOR_5`, `NET_CALL_VECTOR_6`, `NET_CALL_VECTOR_1`, `NET_VECTOR_WAIT_POLL` | Master hold/sync temporarily redirects slot `$13` to `BANK_RETURN`, invokes helper 5/6, then restores slot `$13` to bank 4 `$8000`. |
| Bank 12 hold/sync `L963D-L9651` | `NET_CALL_VECTOR_0`, `NET_CALL_VECTOR_1` | Non-master hold path waits for command `$80` and acks it. |
| Bank 12 live/status paths around `L9B4B-L9Dxx` | `NET_CALL_VECTOR_1`, `NET_VECTOR_WAIT_POLL` | Resync/checksum and post-checksum state exchange. |

The hold/sync paths are the clearest evidence that FujiNet should not only
implement read/write/ready. Helpers 5 and 6 need at least compatible no-op
semantics in the first design, and slot `$13` volatile patching must remain
valid.

## Current Solo Runtime Evidence

In the solo trace, the installed vector table was the fixed-bank/local family:

```text
NET_VECTOR_0 = $AF62
NET_VECTOR_1 = $AF6C
NET_VECTOR_2 = $AF5D
NET_VECTOR_3 = $AF51
NET_VECTOR_4 = $AF5A
NET_VECTOR_5 = $AF5A
NET_VECTOR_6 = $AF5A
```

Solo live play completed slot `$13` every sampled frame and did not exercise
remote receive waits. That means solo can verify vector installation, local
setup entry, and the live input consumer, but it cannot verify remote timing for
`NET_CALL_VECTOR_0/2` or timeout behavior.

## FujiNet Contract From Call Sites

For a first implementation, define FujiNet callbacks this way:

| Callback | Required behavior |
|---|---|
| Vector 0 read | Return exactly one ordered game byte in `A`; return nonzero/error convention compatible with existing callers. |
| Vector 1 write | Accept one ordered game byte from `A`; preserve byte order including command/status companion pairs. |
| Vector 2 ready | Be nonblocking and cheap; return ready status compatible with bank 4 and bank 12 predicate loops. |
| Vector 3 open | Initialize or join the FujiNet session and leave `NET_ERROR_CODE=0` on success. |
| Vector 4 close | Tear down/idle the FujiNet session without disturbing OS/IRQ state used by other transports. |
| Vector 5 hold | Quiesce or mark hold/sync state before slot `$13` is suppressed. |
| Vector 6 resume | Resume live transport state after hold/sync and before slot `$13` is restored. |

Open uncertainty: exact register preservation of each installed callback still
needs either instruction-level tracing or a carefully instrumented ROM. For now,
the safe assumption is to preserve `X`, `Y`, stack balance, decimal mode, and
all zero-page scratch not already used by the current call site.
