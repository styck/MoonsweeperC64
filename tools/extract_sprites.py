#!/usr/bin/env python3
"""Extract the sprite shapes the game references from the tape's memory.

Each sprite pointer value V maps to bank address $4000 + V*64. The tape
game has these shapes loaded; our S-C source does not.
"""
from pathlib import Path

tape = Path("tools/dump_tape_ol/ram.bin").read_bytes()[2:]
out = Path("tools/tape_sprites")
out.mkdir(exist_ok=True)

# (name, [pointer values])
GROUPS = [
    ("ship",           list(range(0x33, 0x38))),
    ("shot",           [0x6B, 0x72, 0x73, 0x7B]),
    ("saucer_pic",     list(range(0xA2, 0xAA))),
    ("saucer_drop",    [0x47, 0x48, 0x49]),
    ("saucer_explode", [0x3B, 0x3C, 0x3D, 0x3E]),
    ("mother",         [0x00, 0x01, 0x02]),
    ("mother_explode", [0xC8, 0xC6]),
    ("orbit_star",     [0x89]),
    ("orbit_planet",   [0x91]),
    ("orbit_satellite",[0x99]),
    ("orbit_comet",    [0xA1]),
    ("orbit_explode",  list(range(0xC5, 0xCA))),
    ("hud_bankdial",   [0xBD]),
    ("hud_radarman",   [0xD3]),
    ("hud_radarship",  [0xD4]),
    ("hud_c6",         [0xC6]),
]

all_blocks = {}
for name, ptrs in GROUPS:
    for p in ptrs:
        addr = 0x4000 + p * 64
        blk = tape[addr:addr + 64]
        all_blocks[p] = blk
        (out / f"{name}_{p:02X}.bin").write_bytes(blk)
        nz = sum(1 for x in blk if x)
        print(f"{name:14s} ptr${p:02X} @${addr:04X}  nz={nz:2d}/64  "
              f"first8={blk[:8].hex()}")

# velocity/fuel dial needles: ptrs $AD..$B4, $BD..$C4
dial = {}
for p in list(range(0xAD, 0xB5)) + list(range(0xBD, 0xC5)):
    addr = 0x4000 + p * 64
    blk = tape[addr:addr + 64]
    dial[p] = blk
    (out / f"dial_{p:02X}.bin").write_bytes(blk)
print(f"dial needles: {len(dial)} blocks ($AD-$B4, $BD-$C4) extracted")

# save a combined map for codegen
import json
mapdata = {f"{k:02X}": [f"{x}" for x in v] for k, v in all_blocks.items()}
Path("tools/tape_sprites/blocks.json").write_text(
    json.dumps(mapdata, indent=0))
print("wrote tools/tape_sprites/blocks.json and per-block .bin files")
