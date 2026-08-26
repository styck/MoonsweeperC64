#!/usr/bin/env python3
"""Extract sprite shapes from the tape and generate MOONSPRT.ASM.

Sources:
  - RAM dump (tools/dump_tape_ol/ram.bin) for the core sprites (ship, shot,
    saucer, mother, orbit objects, explosions) - real shapes verified by
    rendering.
  - Gauge needles (VELOCITY/FUEL dials, ptrs $B5-$C4): the tape stores the
    velocity needles at $6D40-$7000 (ptr $B5-$C0) and the fuel needles at
    $7080-$7140 (ptr $C2-$C4); these were extracted from the tape load image
    (tools/tape_decoded.bin) and the RAM dump (ram.bin), and verified
    byte-for-byte against the user's VICE snapshot of the orbit screen.
  - Radar blips are reconstructed (not present in the tape's static data).
"""
from pathlib import Path

RAM = Path("tools/dump_tape_ol/ram.bin").read_bytes()[2:]
BLOB = Path("tools/tape_decoded.bin").read_bytes()


def ram_block(addr):
    return RAM[addr:addr + 64]


def blob_block(addr):
    # tape_decoded.bin is the load image at memory base $0699
    off = addr - 0x699
    return BLOB[off:off + 64]


def dial_block(ptr):
    """Return the REAL gauge needle shape for sprite pointer $B5-$C4.

    - $B5-$C0 : velocity needles, stored in the tape load image at $6D40-$7000
    - $C1     : unused (empty)
    - $C2-$C4 : fuel needles, initialized by the game at $7080-$7140
                (captured from the RAM dump and verified in the snapshot)
    """
    mem = 0x4000 + ptr * 64
    if 0xB5 <= ptr <= 0xC0:
        return blob_block(mem)
    if ptr == 0xC1:
        return bytes(64)
    if 0xC2 <= ptr <= 0xC4:
        return ram_block(mem)
    raise ValueError(f"ptr ${ptr:02X} out of needle range")


GROUPS = [
    ("SHIP", list(range(0x33, 0x38))),
    ("SHOT", [0x6B, 0x72, 0x73, 0x7B]),
    ("SAUCER_DROP", [0x47, 0x48, 0x49]),
    ("SAUCER_EXPLODE", [0x3B, 0x3C, 0x3D, 0x3E]),
    ("MOTHER", [0x00, 0x01, 0x02]),
    ("MOTHER_EXPLODE", [0xC8, 0xC6]),
    ("ORBIT_STAR", [0x89]),
    ("ORBIT_PLANET", [0x91]),
    ("ORBIT_SATELLITE", [0x99]),
    ("ORBIT_COMET", [0xA1]),
    ("ORBIT_EXPLODE", list(range(0xC5, 0xCA))),
    ("DIAL", list(range(0xB5, 0xC5))),
    ("RADAR_MAN", [0xD3]),
    ("RADAR_SHIP", [0xD4]),
]


def make_radar_man():
    g = [["."] * 24 for _ in range(21)]
    for c in range(9, 15):
        g[10][c] = "#"
    for r in range(8, 14):
        g[r][12] = "#"
    return grid_to_bytes(g)


def make_radar_ship():
    g = [["."] * 24 for _ in range(21)]
    for r, c in [(12, 9), (11, 10), (10, 11), (9, 12), (10, 13), (11, 14),
                 (12, 15), (13, 14), (14, 13), (15, 12), (14, 11), (13, 10)]:
        if 0 <= r < 21 and 0 <= c < 24:
            g[r][c] = "#"
    return grid_to_bytes(g)


def grid_to_bytes(g):
    out = bytearray()
    for r in range(21):
        for i in range(3):
            byte = 0
            for bit in range(8):
                if g[r][i * 8 + bit] == "#":
                    byte |= 1 << (7 - bit)
            out.append(byte)
    # sprite blocks are 64-byte slots; the VIC uses 63 bytes, the 64th
    # byte is padding (must be present so the copy loop stays aligned)
    out.append(0)
    return bytes(out)


blocks = []
seen = set()
for gname, ptrs in GROUPS:
    for p in ptrs:
        addr = 0x4000 + p * 64
        if addr in seen:
            continue
        seen.add(addr)
        if gname == "DIAL":
            data = dial_block(p)
            src = "tape needle"
        elif gname == "RADAR_MAN":
            data = make_radar_man()
            src = "reconstructed blip"
        elif gname == "RADAR_SHIP":
            data = make_radar_ship()
            src = "reconstructed blip"
        else:
            data = ram_block(addr)
            src = "tape"
        blocks.append((gname, p, addr, data, src))

print(f"total blocks: {len(blocks)}")
for name, p, addr, data, src in blocks:
    nz = sum(1 for x in data if x)
    print(f"  {name:16s} ptr=${p:02X} dest=${addr:04X} nz={nz:2d} src={src}")


def byte_lines(data, per_line=8):
    out = []
    for i in range(0, len(data), per_line):
        out.append("    .byte " + ", ".join(f"${x:02X}" for x in data[i:i + per_line]))
    return "\n".join(out)


lines = []
lines.append(";------------------------------------------------------------------")
lines.append("; FILE>MOONSPRT.ASM")
lines.append(";")
lines.append("; Sprite shape data for the C64 Moonsweeper port.")
lines.append(";")
lines.append("; The S-C source we converted contains only sprite POINTERS but no")
lines.append("; shape data.  The core sprites (ship, shot, saucer, mother, orbit")
lines.append("; objects and explosions) below are copied VERBATIM from the")
lines.append("; released tape game (MOONSWE1.T64) memory image.")
lines.append(";")
lines.append("; The gauge needles (VELOCITY/FUEL dials, ptrs $B5-$C4) are also")
lines.append("; real tape data: $B5-$C0 come from the tape load image ($6D40-$7000)")
lines.append("; and $C2-$C4 from the runtime RAM dump ($7080-$7140) - verified")
lines.append("; byte-for-byte against a VICE snapshot of the orbit screen.  Only")
lines.append("; the radar blips ($D3/$D4) are reconstructed (not in the tape).")
lines.append(";")
lines.append("; Blocks are stored compactly and copied to their VIC-bank")
lines.append("; destinations by INIT_SPRITES (called from INIT_HARDWARE).")
lines.append(";------------------------------------------------------------------")
lines.append("")
lines.append("; The table sits at $7240 (just above the orbit-explosion sprites);")
lines.append("; it must stay below $8000 where INIT_HARDWARE stores the restart")
lines.append("; vector.  The radar blocks at the end of the table overlap the")
lines.append("; table region, but they are the LAST blocks copied, so the overlap")
lines.append("; only clobbers already-consumed source bytes.")
lines.append("* = $7240")
lines.append("")
lines.append(";--------------------------------")
lines.append("; COMPACT SPRITE SHAPE DATA (64 bytes per block)")
lines.append(";--------------------------------")

for i, (name, p, addr, data, src) in enumerate(blocks):
    lines.append(f"SPR_{name}_{p:02X}  ; ptr ${p:02X} -> ${addr:04X}  [{src}]")
    lines.append(byte_lines(data))
    if i < len(blocks) - 1:
        lines.append("")

lines.append("")
lines.append(";--------------------------------")
lines.append("; DESTINATION TABLE (one word per block, same order)")
lines.append(";--------------------------------")
lines.append("SPRITE_DEST_TABLE")
for name, p, addr, data, src in blocks:
    lines.append(f"    .word ${addr:04X}  ; {name} ptr ${p:02X}")
lines.append(f"SPRITE_BLOCK_COUNT = {len(blocks)}")
lines.append("")
lines.append(";--------------------------------")
lines.append("; COPY SPRITES FROM TABLE TO VIC BANK")
lines.append("; Uses zero-page $FB-$FE as pointers.")
lines.append(";--------------------------------")
lines.append("INIT_SPRITES")
lines.append("    LDA #<SPR_SHIP_33")
lines.append("    STA $FB")
lines.append("    LDA #>SPR_SHIP_33")
lines.append("    STA $FC")
lines.append("    LDX #$00")
lines.append("_1 LDA SPRITE_DEST_TABLE,X")
lines.append("    STA $FD")
lines.append("    LDA SPRITE_DEST_TABLE+1,X")
lines.append("    STA $FE")
lines.append("    LDY #$00")
lines.append("_2 LDA ($FB),Y")
lines.append("    STA ($FD),Y")
lines.append("    INY")
lines.append("    CPY #64")
lines.append("    BNE _2")
lines.append("    LDA $FB")
lines.append("    CLC")
lines.append("    ADC #64")
lines.append("    STA $FB")
lines.append("    BCC _3")
lines.append("    INC $FC")
lines.append("_3 INX")
lines.append("    INX")
lines.append("    CPX #<SPRITE_BLOCK_COUNT*2")
lines.append("    BNE _1")
lines.append("    RTS")
lines.append("")

Path("MOONSPRT.ASM").write_text("\n".join(lines), encoding="ascii")
print("wrote MOONSPRT.ASM")
