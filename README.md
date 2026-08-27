# MoonsweeperC64

Moonsweeper for the Commodore 64 (Imagic, 1984, by Daniel Filiberti / A.C.T),
rebuilt from the original S-C Macro Assembler source into **64tass** format.

> **Disclaimer:** This source code is published strictly for historical
> preservation, education, and research purposes. If you are the rightful
> copyright holder of this code and object to its archival, please contact me
> and it will be removed immediately.

## Overview

The source in this repo is converted to 64tass syntax and checked against the
original S-C Macro Assembler listing (`moonsweeperOriginal.lst`). All 14,262
bytes of the original game code are preserved in full — the port only **adds**
recovered sprite data (the S-C source had none) and a small block of code that
loads those extra sprites into the VIC bank. `tools/verify.py` confirms every
original byte is intact (no deletions).

> **New to 6502 assembly?** Start with
> **[`HOW_IT_WORKS.md`](HOW_IT_WORKS.md)** — a guided tour of how the game
> actually works on the C64 (memory map, game flow, every subsystem), with
> hands-on experiments to try.

- `MOONSWPR.ASM` — entry point (BASIC stub `10 SYS <COLD_START>` + includes)
- `MOONMACR.ASM` — macros (ADD, SUB, BUILD, INC16, PRINT_MACRO)
- `MOONEQU.ASM` — equates + zero-page variable layout (`* = $0860`)
- `MOONCOD1..5.ASM` — game code
- `MOONIRQ.ASM` — interrupt routines
- `MOON.SHAPES.1`, `MOON.SHAPES.2` — character/sprite shape data
- `sc-original/` — untouched copy of the raw S-C source files
- `tools/convert_sc.py` — the S-C → 64tass converter used for the port
- `tools/verify.py` — byte-for-byte checker against `moonsweeperOriginal.lst`
- `SC_TO_64TASS.md` — the conversion playbook (incl. Moonsweeper-specific notes)
- `HOW_IT_WORKS.md` — **a guided tour of the game for people learning 6502
  assembly**: the C64 memory map, the game flow, every subsystem (ship,
  gauges, galaxy screen, collisions, sound, the raster IRQ), and hands-on
  experiments to try

## Build

Use the VS Code task **Build with 64tass** (`Ctrl+Shift+B`) or run:

```
64tass MOONSWPR.ASM -o MOONSWPR.prg -L listing.txt --line-numbers --verbose-list --vice-labels -l labels.txt
```

(64tass 1.60.3243 at `C:\Users\styck\tools\64tass\...`)

## Run

Use the VS Code task **Run in VICE** (builds then autostarts `MOONSWPR.prg`),
or run VICE with `-autostart MOONSWPR.prg`.

## Verify the port

```
python tools\verify.py
```

Builds `MOONSWPR.prg` and checks it against the original S-C listing. Because
the port adds recovered sprite data and a small amount of extra sprite-loading
code, `verify.py` reports how many original bytes match exactly and the bytes
the port inserts. It confirms the original game code is fully preserved —
**nothing from the original is deleted**; all differences are insertions (the
recovered-sprite loading code) and the downstream address-operand adjustments
they cause.
