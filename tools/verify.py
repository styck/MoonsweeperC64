#!/usr/bin/env python3
"""Byte-for-byte verification of the Moonsweeper 64tass port.

Parses moonsweeperOriginal.lst (S-C listing with emitted bytes), builds the
converted source with 64tass, and compares every byte from $0860 onward.
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TASS = r"C:\Users\styck\tools\64tass\64tass-1.60.3243\64tass.exe"
LISTING = ROOT / "moonsweeperOriginal.lst"
MAIN = ROOT / "MOONSWPR.ASM"
PRG = ROOT / "MOONSWPR.prg"

# Data lines are wrapped 3 bytes per physical listing line; continuation
# lines have an address + bytes but no source text or line number.
# Macro-expansion lines carry a line number of "0000>" (with a '>').
CODE_LINE = re.compile(
    r"^([0-9A-F]{4})-((?: [0-9A-F]{2})+)(?:\s+(\d+)(?:>|\s+)(.*))?$"
)

START_ADDR = 0x0860
STUB_LEN = 12  # BASIC stub at $0801..$080C


def parse_listing():
    """Return list of (addr, [bytes]) for every emitting line."""
    entries = []
    for raw in LISTING.read_text(encoding="utf-8", errors="replace").splitlines():
        m = CODE_LINE.match(raw)
        if not m:
            continue
        addr = int(m.group(1), 16)
        data = [int(b, 16) for b in m.group(2).split()]
        src = m.group(4).strip() if m.group(4) else ""
        entries.append((addr, data, src))
    return entries


def expected_stream(entries):
    """Flatten listing bytes into a contiguous expected byte array from
    START_ADDR, reporting any gaps/overlaps."""
    byaddr = {}
    order = []
    for addr, data, _ in entries:
        for i, b in enumerate(data):
            a = addr + i
            if a in byaddr:
                print(f"  OVERLAP at ${a:04X}: was ${byaddr[a]:02X}, now ${b:02X}")
            byaddr[a] = b
            order.append(a)
    if not order:
        raise SystemExit("no code lines found in listing")
    lo = min(order)
    hi = max(order)
    if lo != START_ADDR:
        print(f"  NOTE: listing starts at ${lo:04X}, expected ${START_ADDR:04X}")
    gaps = []
    prev = None
    for a in sorted(order):
        if prev is not None and a != prev + 1:
            gaps.append((prev + 1, a - 1))
        prev = a
    for g in gaps:
        print(f"  GAP in listing: ${g[0]:04X}..${g[1]:04X} ({g[1]-g[0]+1} bytes)")
    return bytes(byaddr[a] for a in range(lo, hi + 1)), lo


def build():
    subprocess.run(
        [TASS, str(MAIN), "-o", str(PRG), "-L", str(ROOT / "listing.txt"),
         "--line-numbers", "--verbose-list", "--vice-labels",
         "-l", str(ROOT / "labels.txt")],
        cwd=str(ROOT), check=True,
    )


def read_prg():
    data = PRG.read_bytes()
    load = data[0] | (data[1] << 8)
    print(f"  PRG load address: ${load:04X}, size {len(data)} bytes")
    # Skip the 2-byte header and everything up to START_ADDR. 64tass pads
    # the stub->code gap ($080D..$085F) with zero bytes, so skipping by
    # address keeps the comparison aligned with the original listing.
    skip = 2 + (START_ADDR - load)
    return data[skip:], load


def main():
    print("Parsing original listing...")
    entries = parse_listing()
    expected, lo = expected_stream(entries)
    print(f"  Expected program: ${lo:04X}..${lo+len(expected)-1:04X} "
          f"({len(expected)} bytes)")

    print("Building with 64tass...")
    build()

    print("Reading built PRG...")
    actual, _ = read_prg()

    if len(actual) != len(expected):
        print(f"  LENGTH MISMATCH: expected {len(expected)}, got {len(actual)}")
    n = min(len(actual), len(expected))
    mismatches = [i for i in range(n) if actual[i] != expected[i]]
    if mismatches and len(actual) == len(expected):
        # find contiguous mismatch regions, print first few
        regions = []
        start = prev = mismatches[0]
        for i in mismatches[1:]:
            if i != prev + 1:
                regions.append((start, prev))
                start = i
            prev = i
        regions.append((start, prev))
        print(f"  {len(mismatches)} mismatching bytes in "
              f"{len(regions)} region(s):")
        for r in regions[:10]:
            a = r[0]
            print(f"    ${START_ADDR+a:04X}: expected ${expected[a]:02X}, "
                  f"got ${actual[a]:02X} ({len(expected[a:a+r[1]+1])} bytes)")
        print("  FAIL: bytes differ from the original listing.")
        return 1

    if len(actual) != len(expected):
        print("  FAIL: program length differs.")
        return 1

    print(f"  MATCH: all {len(actual)} bytes from ${START_ADDR:04X} match "
          f"the original listing byte-for-byte.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
