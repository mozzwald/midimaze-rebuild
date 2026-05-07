# AGENTS.md

## Project goal

This repository is for turning the MIDI Maze Atari 8-bit cartridge disassembly into a source tree that can be reassembled into a working, bootable game ROM.

The primary goal is **behavioral and binary correctness first**, cleanup second. Do not rewrite or “improve” game logic unless explicitly asked. The first major milestone is a ROM that assembles, boots in an emulator, and matches the original ROM as closely as possible.

## Source material

Important files likely present in this workspace; `ref` dir will contain relavant reference documents:

- `MIDIMaze_complete_ROM_Disassembly.asm` — main full ROM disassembly.
- `MIDI Maze-Original.rom` — original ROM image; use this as the binary comparison target.
- `MIDI_Maze_MIDI_SIO_Handler_Analysis_Annotated.pdf` — analysis of the game’s custom MIDI/SIO serial handler.
- `Altirra Hardware Reference Manual.md` — hardware reference for Atari 8-bit behavior, POKEY serial, interrupts, cartridges, and banking.

If file names differ, locate the closest equivalent before making changes.

## Working style

Make small, testable changes. Prefer mechanical conversion over interpretation.

## Readability and renaming roadmap

The persistent readability plan is `ref/READABILITY_RENAME_PLAN.md`.

When doing any work whose purpose is to make the disassembly more human
readable:

1. Read `ref/READABILITY_RENAME_PLAN.md` before editing source.
2. Pick the first unchecked item that has enough evidence to complete safely.
3. Keep the edit narrow: comments first, then names only when behavior is
   proven by call sites, tables, cross-references, or emulator traces.
4. Run `make compare` after each rename/comment batch.
5. Update `ref/READABILITY_RENAME_PLAN.md` by checking completed items and
   adding notes when new evidence changes the plan.
6. Update `docs/symbols.md` and `include/*.inc` when a name becomes stable
   enough to reuse across banks.

Do not rename broad sets of labels simply for aesthetics. Human-readable names
must improve understanding while preserving byte-exact output.

## Gameplay and FujiNet research roadmap

The persistent gameplay/FujiNet research plan is
`ref/GAMEPLAY_FUJINET_RESEARCH_PLAN.md`.

When doing work whose purpose is to understand gameplay, networking, transport
setup, player data flow, maze loading, or future FujiNet integration:

1. Read `ref/GAMEPLAY_FUJINET_RESEARCH_PLAN.md` before editing source.
2. Work phase by phase, starting with the first unchecked item with enough
   evidence to complete safely.
3. Prefer `docs/gameplay.md`, `docs/fujinet-porting.md`, and bank-local
   comments for flow documentation.
4. Promote names into `include/*.inc` only after cross-bank behavior is proven.
5. Do not implement FujiNet behavior during research phases unless explicitly
   asked; define insertion points and constraints first.
6. Run `make compare` after source comments/names.
7. Commit each completed gameplay/FujiNet research phase with a brief
   descriptive message.

For each change:

1. Assemble the ROM.
2. Compare output bytes against the original ROM.
3. Run the ROM in an Atari emulator if it assembles.
4. Record what changed and why.

Do not perform broad refactors while the ROM is not yet rebuildable. Keep labels, addresses, and byte layouts stable until the ROM can be reproduced.

## Non-negotiable constraints

- Preserve exact byte layout unless a change is intentional and documented.
- Preserve all `.byte` data exactly unless proven to be code or structured data.
- Do not rename large sets of labels during early rebuild work.
- Do not convert unknown bytes into instructions just because a disassembler guessed code nearby.
- Do not replace undocumented opcodes unless explicitly directed. The Atari 8-bit uses NMOS 6502 behavior; undocumented opcodes may be intentional or may be data misidentified as code.
- Do not “fix” suspicious code until the ROM builds and a byte comparison proves what changed.
- Do not assume a label is RAM, ROM, code, or data solely from its generated name.

## Expected assembler strategy

Use a real 6502 assembler suitable for Atari 8-bit cartridge work. MADS is preferred if the source syntax is already close to Atari-style assembly. ca65 is acceptable if the source is intentionally converted.

When converting syntax:

- Preserve address origins and bank boundaries.
- Preserve CPU target as NMOS 6502 unless told otherwise.
- Preserve raw byte sequences around uncertain areas.
- Add assembler directives only when they help reproduce the original layout.
- Avoid introducing linker abstractions until a flat binary can be reproduced.

## ROM layout and banking

The disassembly appears to represent a banked Atari cartridge ROM. Some banks are mapped into an 8KB cartridge window, with code shown as assembled at addresses such as `$8000-$9FFF`.

Treat bank boundaries as critical. Do not allow the assembler or linker to move code/data across banks. Each bank should assemble to its exact original size and then be concatenated or packed into the expected ROM image format.

For each bank, verify:

- origin address,
- file offset,
- expected bank size,
- reset/cart vectors,
- bank-switch trigger addresses or registers,
- final byte count.

If a routine crosses a bank boundary in the disassembly, assume the disassembly is wrong until proven otherwise.

## Binary comparison workflow

Create repeatable build scripts. A useful minimum target set:

```sh
make clean
make
make compare
make run
```

`make compare` should compare the built ROM against `MIDI Maze.rom` and show:

- first differing offset,
- total differing byte count,
- output size vs original size,
- optional per-bank comparison.

Useful commands:

```sh
cmp -l build/midimaze.rom "MIDI Maze.rom" | head
sha256sum build/midimaze.rom "MIDI Maze.rom"
xxd -g1 -c16 build/midimaze.rom | less
```

When bytes differ, inspect the source around the corresponding bank offset before making assumptions.

## Emulator test workflow

This section covers runtime usage of the Atari800 AI interface:
- AI command socket (`/tmp/atari800_ai.sock`)

### 1. Run With AI Enabled

Launch Atari800 with `-ai`, for example:

```bash
atari800-ai -xl -ntsc -ai -cart-type 14 -cart </path/to/cart.rom>
```

For this project, the known-good command is:

```bash
atari800-ai -ai -xl -ntsc -cart-type 14 -cart /home/mozzwald/fujicode/midimaze-source/build/midimaze.rom
```

### 2. AI JSON Socket Protocol

Socket path:
- `/tmp/atari800_ai.sock`

Message format (length-prefixed JSON):

```text
Client -> Server: <json_length>\n<json_command>
Server -> Client: <json_length>\n<json_response>
```

Important: this local `atari800-ai` build expects the JSON command name in the
`cmd` field, not `command`. For example, use `{"cmd":"ping"}`, not
`{"command":"ping"}`.

Example Python helper:

```python
import socket, json

def send_command(msg, timeout=2):
    s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    s.settimeout(timeout)
    s.connect('/tmp/atari800_ai.sock')
    data = json.dumps(msg).encode('utf-8')
    s.sendall(str(len(data)).encode('ascii') + b'\n' + data)

    header = b''
    while not header.endswith(b'\n'):
        header += s.recv(1)
    n = int(header.strip())

    body = b''
    while len(body) < n:
        body += s.recv(n - len(body))
    s.close()
    return json.loads(body.decode('utf-8'))

print(send_command({"cmd": "ping"}))
```

When advancing time from scripts, call `{"cmd":"run","frames":1}` in a loop.
This local build has been observed returning `frames_run: 1` even when a larger
frame count is requested.

### 3. Core AI Commands

Use `{"cmd":"<command>", ...}` for all commands below.

#### Control Commands

| Command | Parameters | Description |
|---------|------------|-------------|
| `ping` | - | Test connection; returns `{status:"ok", msg:"pong"}` |
| `load` | `path` | Load a program file (.xex, .atr, etc.) |
| `run` | `frames` | Advance emulation. In this build, loop single-frame calls for reliable scripted timing. |
| `step` | - | Not reliable in this local build; observed to timeout/hang. Do not depend on it. |
| `pause` | - | Pause emulation; observed working. |
| `reset` | - | Reset the Atari |

#### Input Commands

| Command | Parameters | Description |
|---------|------------|-------------|
| `joystick` | `port`, `direction`, `fire` | Set joystick state |
| `key` | `keycode` | Press a key |
| `key_release` | `keycode` | Release a key |
| `paddle` | `port`, `value` | Set paddle position (0-227) |
| `consol` | `start`, `select`, `option` | Set console keys |

**Joystick Directions:** `center`, `up`, `down`, `left`, `right`, `ul`, `ur`, `ll`, `lr`

#### Screen Commands

| Command | Parameters | Description |
|---------|------------|-------------|
| `screenshot` | `path` | Save screenshot as PNG |
| `screen_ascii` | - | Get 40x24 ASCII representation |
| `screen_raw` | - | Get raw screen memory |
#### Memory Commands

| Command | Parameters | Description |
|---------|------------|-------------|
| `peek` | `addr`, `len` | Read memory bytes |
| `poke` | `addr`, `value` | Write memory byte |
| `dump` | `addr`, `len`, `path` | Dump memory to file |

#### CPU/Chip State Commands

| Command | Parameters | Description |
|---------|------------|-------------|
| `cpu` | - | Get CPU registers (A, X, Y, PC, SP, flags) |
| `cpu_set` | `reg`, `value` | Set CPU register |
| `antic` | - | Get ANTIC chip state |
| `gtia` | - | Get GTIA chip state (colors, triggers, PMG) |
| `pokey` | - | Get POKEY chip state (audio, keyboard) |
| `pia` | - | Get PIA chip state (ports, interrupts) |
| `breakpoint` | `addr`, `enabled` | Set/clear breakpoint |

#### Disk Commands

| Command | Parameters | Description |
|---------|------------|-------------|
| `disk_insert` | `drive`, `path` | Insert disk image |
| `disk_eject` | `drive` | Eject disk |
| `disk_status` | - | Get disk drive status |

#### State Commands

| Command | Parameters | Description |
|---------|------------|-------------|
| `save_state` | `path` | Save emulator state |
| `load_state` | `path` | Load emulator state |

#### Debug Commands

| Command | Parameters | Description |
|---------|------------|-------------|
| `debug_enable` | `port` | Enable debug port at $D7xx |
| `debug_read` | - | Read data from debug port |

### 4. Verified Local Behavior And Caveats

Observed working commands in this workspace:

- `ping`, `cpu`
- `run` with single-frame loop usage
- `screen_ascii`, `screenshot`
- `joystick`, `key`, `key_release`, `consol`
- `peek`, `poke`, `dump`
- `pause`, `reset`
- `debug_enable`, `debug_read`

Observed caveats:

- `breakpoint` is not implemented in this local build; it returns
  `Unknown command`.
- `step` timed out during testing. Avoid it in automated workflows.
- `dump` accepted `addr`, `len`, and `path`, but reported `bytes: 65536` for a
  16-byte request during one test. Prefer `peek` for small memory probes.
- `joystick` correctly updates `STICK0` (`$0278`) and `STRIG0` (`$0284`) during
  live gameplay. In live solo testing, `PLAYER_INPUT_STATUS[0]` at `$3D29`
  changed from `$00` to `$01` for forward/up and to `$18` for right+fire.
- The AI socket supports memory polling well enough for Phase 0 trace work, but
  not breakpoint-driven tracing. Use polling loops, screenshots, memory
  snapshots, or instrumented debug-port code for detailed traces.

### 5. Useful Smoke-Test Snippet

This snippet verifies the socket, takes a screenshot, moves the live player, and
peeks key gameplay RAM. Start or navigate to a live solo game first.

```python
import socket, json

SOCK = "/tmp/atari800_ai.sock"

def send(msg, timeout=2):
    s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    s.settimeout(timeout)
    s.connect(SOCK)
    data = json.dumps(msg).encode("utf-8")
    s.sendall(str(len(data)).encode("ascii") + b"\n" + data)

    header = b""
    while not header.endswith(b"\n"):
        header += s.recv(1)
    n = int(header.strip())

    body = b""
    while len(body) < n:
        body += s.recv(n - len(body))
    s.close()
    return json.loads(body.decode("utf-8"))

def run_frames(n):
    for _ in range(n):
        send({"cmd": "run", "frames": 1})

print(send({"cmd": "ping"}))
print(send({"cmd": "screenshot", "path": "/tmp/midimaze_live.png"}))
print(send({"cmd": "peek", "addr": 0x3D29, "len": 4}))  # PLAYER_INPUT_STATUS

send({"cmd": "joystick", "port": 0, "direction": "up", "fire": False})
run_frames(60)
print(send({"cmd": "peek", "addr": 0x3D29, "len": 4}))
print(send({"cmd": "peek", "addr": 0x39B2, "len": 4}))  # PLAYER_X_LO
print(send({"cmd": "peek", "addr": 0x39F2, "len": 4}))  # PLAYER_Y_LO
send({"cmd": "joystick", "port": 0, "direction": "center", "fire": False})
```

## MIDI/SIO handler warnings

MIDI Maze does not appear to use normal Atari OS CIO/SIO transfer routines for game MIDI traffic. It programs POKEY serial hardware directly and hooks OS serial interrupt vectors.

Important behavior to preserve:

- POKEY serial data uses `SERIN/SEROUT` at `$D20D`.
- The game hooks OS serial vectors such as `VSERIN` and `VSEROR`.
- Receive and transmit are interrupt-driven.
- Ring buffers appear to use natural 8-bit wraparound.
- TX may write directly to `SEROUT` when idle, then use an ISR to drain queued bytes.
- The handler programs POKEY timer/audio registers to approximate MIDI baud timing.

Do not replace this with OS SIO calls. Do not “simplify” the interrupt path. Do not move ISR code or buffer variables unless the exact addresses are preserved or the game code is fully updated.

## Hardware register handling

Atari hardware registers are often write-only, read-only, mirrored, or have side effects. Be careful with any code touching:

- POKEY: `$D200-$D20F`
- PIA: `$D300-$D303`
- ANTIC: `$D400-$D40F`
- GTIA: `$D000-$D01F`
- OS vectors and shadow registers: `$0200-$03FF`

Do not replace reads/writes with shadow register access unless the original code did so.

## Interrupt safety

Preserve interrupt prologues/epilogues exactly.

For ISR code:

- Preserve register save/restore behavior.
- Preserve `RTI`, not `RTS`.
- Preserve stack balance.
- Preserve decimal flag handling if present.
- Preserve `SEI`/`CLI` critical sections.
- Do not call high-level runtime routines from an ISR.

If an ISR starts with unusual sequences such as saving `Y` through `A`, assume it is intentional unless byte comparison proves otherwise.

## Labels and documentation

Generated labels like `L8000`, `LBEFD`, or `L0082` are allowed. During the rebuild phase, stability matters more than readability.

When a label is confidently identified, add a comment first. Rename only after the ROM is buildable and tests are in place.

Preferred comment style:

```asm
; L0082 appears to be RX write index for MIDI/POKEY serial ring buffer.
L0082 = $0082
```

Avoid speculative names in executable changes. If uncertain, use comments like `; likely`, `; appears to`, or `; TODO verify`.

## Handling code vs data ambiguity

Disassemblies often misclassify data as code and code as data.

Rules:

- If bytes are not reached by known control flow, leave them as `.byte` until verified.
- If an apparent illegal opcode appears in a suspicious region, check whether the region is actually data.
- If converting `.byte` to instructions changes output bytes, stop and restore the bytes.
- Use emulator traces, cross references, and bank-aware address mapping to prove code paths.

## Build artifacts

Keep generated files out of source control where possible:

- `build/`
- `dist/`
- `.lst`
- `.map`
- temporary binary dumps
- emulator state files

Commit build scripts and comparison tools. Do not commit generated ROMs unless explicitly requested.

## Suggested repo structure

A practical structure is:

```text
.
├── AGENTS.md
├── Makefile
├── README.md
├── original/
│   └── MIDI Maze.rom
├── src/
│   ├── banks/
│   │   ├── bank00.asm
│   │   ├── bank01.asm
│   │   └── ...
│   ├── include/
│   │   ├── hardware.inc
│   │   ├── os.inc
│   │   └── cartridge.inc
│   └── midimaze.asm
├── tools/
│   ├── compare_rom.py
│   └── split_rom.py
└── build/
```

Do not reorganize into this structure all at once if it makes the current source harder to compare. Do it incrementally.

## First milestone checklist

- [ ] Identify ROM size and cartridge banking type.
- [ ] Split original ROM into banks if needed.
- [ ] Create a build script that assembles one bank at a time.
- [ ] Assemble all banks to flat binary chunks.
- [ ] Recombine banks into a ROM image matching original size.
- [ ] Get byte comparison to either exact match or a documented list of differences.
- [ ] Boot in emulator using the same cartridge type as the original.
- [ ] Document emulator configuration.

## Good Codex tasks for this repo

Good tasks:

- “Create a Makefile that assembles the current source and compares it to the original ROM.”
- “Split this monolithic disassembly into bank files without changing generated bytes.”
- “Convert only assembler syntax errors needed for MADS/ca65, preserving output bytes.”
- “Add a compare script that maps differing file offsets back to bank/address.”
- “Identify cartridge vectors and banking scheme from the ROM.”

Bad tasks:

- “Clean up the whole disassembly.”
- “Rename all labels to meaningful names.”
- “Rewrite the MIDI handler in C.”
- “Optimize the game loop.”
- “Modernize the source.”

## Definition of done

A change is done only when:

1. The source assembles.
2. The output size is correct.
3. Differences from the original ROM are known and explained.
4. The ROM boots or the reason it does not boot is documented.
5. The change is small enough to review.

Binary accuracy beats aesthetics.
