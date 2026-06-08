# FujiNet Research: Candidate Bank Audit

This note records the solo/static audit for possible FujiNet code-space banks.
It does not claim a bank is free for implementation yet; it only separates
byte-level emptiness from the additional runtime proof needed before reuse.

## Bank 3 And Bank 7 Contents

The active sources for banks 3 and 7 are intentionally collapsed fill banks:

```asm
; Bank 03: switchable 8KB cartridge bank, mapped at $8000-$9FFF.
; orig bank is entirely $FF fill.
    org $8000
:8192 .byte $ff
```

Bank 7 has the same form. The built bank binaries have the same SHA256:

```text
bank03.bin  7d2c7ac4888bfd75cd5f56e8d61f69595121183afc81556c876732fd3782c62f
bank07.bin  7d2c7ac4888bfd75cd5f56e8d61f69595121183afc81556c876732fd3782c62f
```

This confirms both banks currently emit identical 8 KiB `$FF` images. It does
not, by itself, prove they are safe to repurpose.

## Solo Bank-Selection Trace Tool

`tools/bank_trace.py` polls the currently selected bank byte `L008C` and a small
set of hot bank-call table slots while running the default solo path. It can
launch Atari800 AI itself:

```sh
python3 tools/bank_trace.py --launch --out build/bank_trace_solo.json
```

The launcher uses `atari800-ai -ai -xl -ntsc -nosound -cart-type 14` and the
built ROM by default. The output JSON is generated test evidence and belongs in
`build/`, not source control.

The default trace phases are:

- boot/menu frames before input,
- joystick FIRE navigation through default SOLO and PLAY,
- live idle,
- live held UP,
- live held FIRE.

It records only state transitions, so the output is small enough to inspect
while still catching bank-call table changes.

## Default Solo Trace Result

The default solo bank trace run on this workspace wrote
`build/bank_trace_solo.json` and reported:

```text
transitions=388
current_banks_seen=[0, 4, 12, 13, 14]
candidate_hits=0
```

The hot slots sampled in that trace used these bank IDs:

| Slot | Banks seen | Meaning |
|---:|---|---|
| `$03` | `0, 13` | zero during early boot/table setup, then bank 13 player update consumer |
| `$10` | `0, 13` | zero during early boot/table setup, then bank 13 player dispatch |
| `$11` | `0, 12` | zero during early boot/table setup, then volatile bank 12 continuation |
| `$13` | `0, 4` | zero during early boot/table setup, then bank 4 live network service |
| `$1B` | `0, 4` | bank 4 reset/status-related slot after setup |
| `$1C` | `0, 4` | bank 4 command/status-related slot after setup |
| `$22` | `0` | bank 0 bot/non-human update slot in the sampled solo path |
| `$24` | `0, 4` | bank 4 wait/hold-related slot after setup |

No sampled current-bank state or hot bank-call slot used bank `$03` or bank
`$07`. This strengthens the candidate-bank case for solo boot/menu/live play,
but it still does not prove those banks are unused in MIDI-MATE/network setup,
hold/sync, resync, or error/status paths.

## Bank-Call Table Evidence

The primary bank-call trampoline is fixed-bank `BANK_CALL_INDEXED` at `$AF1D`
in `src/banks/bank15.asm`:

```asm
BANK_CALL_INDEXED:
    LDA BANK_CALL_ADDR_LO,X
    STA L0087
    LDA BANK_CALL_ADDR_HI,X
    STA L0088
    LDA BANK_CALL_BANK_ID,X
    TAX
    LDA L008C
    PHA
    STX L008C
    STX CART_BANK_SELECT
    JMP (L0087)
```

This means any candidate bank can become executable only through an existing
bank-call slot, a direct trampoline, or a direct write to `CART_BANK_SELECT`.
There is no evidence that a bank is selected simply because it exists in the
ROM image.

Current static search findings:

- `BANK_CALL_BANK_ID` writes are concentrated in the normal dispatch-table
  initialization and bank 12 volatile slot patches.
- Bank 12 copies `L008C` into slot `$11` in three places, so slot `$11` follows
  the current bank selected by the surrounding setup/live orchestration.
- No static source reference was found that explicitly selects bank `$03` or
  bank `$07` as a bank-call target.
- Direct `CART_BANK_SELECT` writes found by source search are in fixed-bank
  drawing/trampoline code, not explicit bank 3 or bank 7 setup paths.

The runtime solo trace also sampled the important bank-call slots after entering
live play:

| Slot | Address | Bank | Role |
|---:|---:|---:|---|
| `$03` | `$8185` | `$0D` | bank 13 player update consumer |
| `$10` | `$8900` | `$0D` | bank 13 setup/live player dispatch |
| `$11` | `$9A15` | `$0C` | volatile bank 12 service continuation in live solo |
| `$13` | `$8000` | `$04` | bank 4 live network/status service |
| `$22` | `$8000` | `$00` | bank 0 bot/non-human update |

No sampled solo state used bank 3 or bank 7 in these hot slots.

## Why The Banks Are Still Candidate-Only

Banks 3 and 7 are attractive for FujiNet code because they are all `$FF` in the
current rebuild and are not obvious live-game bank-call targets. They are still
candidate-only for these reasons:

- The cartridge banking scheme may depend on the physical bank count and bank
  order even if a bank contains fill.
- A direct bank-select path could exist in byte-coded or data-adjacent source
  that is not obvious from label search.
- Setup paths other than SOLO were not runtime-tested in this audit.
- Hold/sync, resync, score display, and error-display paths were not runtime
  sampled for bank 3/7 selection.
- The fixed-bank alternate trampoline at `$AF41` can switch banks without using
  `BANK_CALL_INDEXED`; direct-call evidence still needs a wider trace.

## FujiNet Placement Guidance

For a first code-bearing FujiNet experiment, banks 3 or 7 are still the best
candidate homes, but only after a small runtime bank-selection logger proves
they are not selected by existing behavior. Prefer bank 7 if we want to keep
bank 3 untouched as an extra safety reserve; prefer bank 3 only if later traces
show bank 7 has hidden compatibility meaning.

Before writing FujiNet code into either candidate bank, prove:

- `make compare` is exact before the experiment.
- Existing boot/menu/SOLO/PLAY does not select the candidate bank.
- Existing MIDI-MATE or network setup, once available, does not select the
  candidate bank.
- Hold/sync and resync do not select the candidate bank.
- The selected FujiNet entry trampoline preserves `L008C`, stack balance,
  `CART_BANK_SELECT`, and the bank-call return path.

Until that proof exists, the implementation boundary remains: treat banks 3 and
7 as candidate code-space, not free code-space.
