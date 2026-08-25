#!/usr/bin/env python3
"""Convert S-C Macro Assembler (Apple II) source to 64tass for Moonsweeper.

Implements the playbook in SC_TO_64TASS.md. The output is verified
byte-for-byte against moonsweeperOriginal.lst by tools/verify.py.
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

# --- 6502 mnemonics (zero-operand set and full set) ---
ZERO_OP = {
    "BRK", "CLC", "CLD", "CLI", "CLV", "DEX", "DEY", "INX", "INY", "NOP",
    "PHA", "PHP", "PLA", "PLP", "RTI", "RTS", "SEC", "SED", "SEI",
    "TAX", "TAY", "TSX", "TXA", "TXS", "TYA",
}
MNEMONICS = ZERO_OP | {
    "ADC", "AND", "ASL", "BCC", "BCS", "BEQ", "BIT", "BMI", "BNE", "BPL",
    "BVC", "BVS", "CMP", "CPX", "CPY", "DEC", "EOR", "INC", "JMP", "JSR",
    "LDA", "LDX", "LDY", "LSR", "ORA", "ROL", "ROR", "SBC", "STA", "STX",
    "STY",
}

# S-C directives we know how to convert
DIRECTIVES = {
    "EQ", "OR", "DA", "HS", "AS", "BS", "DUMMY", "ED", "MA", "EM", "IN",
    "TI", "TF", "LIS", "EN",
}

# Include-name -> converted filename
INCLUDE_MAP = {
    "MOON.MACROS": "MOONMACR.ASM",
    "MOON.EQUATES": "MOONEQU.ASM",
    "MOON.CODE.1": "MOONCOD1.ASM",
    "MOON.CODE.2": "MOONCOD2.ASM",
    "MOON.CODE.3": "MOONCOD3.ASM",
    "MOON.CODE.4": "MOONCOD4.ASM",
    "MOON.CODE.5": "MOONCOD5.ASM",
    "MOON.IRQ": "MOONIRQ.ASM",
    "MOON.SHAPES.1": "MOON.SHAPES.1",
    "MOON.SHAPES.2": "MOON.SHAPES.2",
}

# Macro renames needed because the S-C name collides with a 64tass
# mnemonic or another symbol (same decisions as the ChopperHunt port).
MACRO_RENAMES = {"INC": "INC16", "PRINT": "PRINT_MACRO"}

# Shift/rotate mnemonics that can be either accumulator-mode (no operand)
# or take a memory operand.
SHIFT_ROTATE = {"ASL", "LSR", "ROL", "ROR"}

# Labels defined anywhere in the project (used to tell an ASL operand
# apart from a following comment word).
KNOWN_LABELS = set()

HEX_BYTES = re.compile(r"^([0-9A-Fa-f]+)(.*)$", re.S)
IDENT = re.compile(r"[A-Za-z_][A-Za-z0-9_.]*")
LINENO = re.compile(r"^\s*\d+\s+")


def fix_ident(m):
    """Convert S-C label with internal periods to underscores.
    Tokens starting with '.' (cheap locals like .1, directives like .HS)
    are left untouched."""
    tok = m.group(0)
    if tok.startswith("."):
        return tok
    return tok.replace(".", "_")


def fix_labels(text):
    """Convert internal periods in S-C identifiers to underscores."""
    return IDENT.sub(fix_ident, text)


def fix_locals_macro(text):
    """Inside a macro: convert S-C ':N' locals to 64tass anonymous '+'
    labels. Cheap locals ('.N') do not work inside macro expansion in
    64tass 1.60 (they parse as numbers); anonymous + forward refs are
    the documented, robust mechanism."""
    return re.sub(r":(\d+)", r"+", text)


def fix_locals_main(text):
    """In main code: convert S-C '.N'/' :N' locals to 64tass '_N' locals.
    Only period-or-colon followed by a digit is a local label (directives
    like .HS start with a letter, so they are untouched)."""
    text = re.sub(r":(\d+)", r"_\1", text)
    text = re.sub(r"\.(\d+)", r"_\1", text)
    return text


def locals_of(text, in_macro):
    """Pick the correct local-label conversion for the current scope."""
    return fix_locals_macro(text) if in_macro else fix_locals_main(text)


def convert_line(line, warnings, in_macro=False):
    """Convert one physical source line (line number already not stripped)."""
    # Strip S-C line number
    m = LINENO.match(line)
    if m:
        line = line[m.end():]
    stripped = line.lstrip()
    indent = line[: len(line) - len(stripped)]

    # Whole-line comment
    if stripped.startswith("*"):
        return indent + ";" + stripped[1:]

    # Blank
    if not stripped:
        return ""

    # Cheap label / macro label definition line, e.g. ":1" or ".1" alone
    tokens = stripped.split()

    # Determine label, op, operand tokens
    label = None
    rest = tokens
    first = tokens[0]
    if len(tokens) > 1:
        # If first token is a known op -> no label; else it is a label
        if first in MNEMONICS or first in DIRECTIVES or first == "*" or (
            first.startswith(".") and first[1:] in DIRECTIVES
        ) or first.startswith(">"):
            pass  # no label (">FOO" is a macro invocation)
        else:
            label = first
            rest = tokens[1:]
    else:
        # Single token: could be a label-only line (":1", ".1", "LABEL")
        if first not in MNEMONICS and not (
            first.startswith(".") and first[1:] in DIRECTIVES
        ):
            label = first
            rest = []

    op = rest[0] if rest else None
    operands = rest[1:] if rest else []

    # ---------- label-only line (":1", ".1", "SUBROUTINE") ----------
    if op is None and label is not None:
        lab = locals_of(fix_labels(label), in_macro)
        return (indent + lab).rstrip()

    # ---------- macro invocation (>NAME args) ----------
    if op and op.startswith(">"):
        name = op[1:]
        newname = MACRO_RENAMES.get(name, name)
        lab = locals_of(fix_labels(label), in_macro) if label else ""
        argtext = locals_of(fix_labels(operands[0]), in_macro) if operands else ""
        cmt = comment_of(operands[1:])
        if lab and argtext:
            lead = f"{lab} {newname} {argtext}"
        elif lab:
            lead = f"{lab} {newname}"
        elif argtext:
            lead = f"{indent}{newname} {argtext}"
        else:
            lead = f"{indent}{newname}"
        return (lead + cmt).rstrip()

    # ---------- directive handling ----------
    if op in DIRECTIVES or (op and op.startswith(".") and op[1:] in DIRECTIVES):
        return convert_directive(label, op, operands, indent, warnings, in_macro)

    # ---------- mnemonic handling ----------
    if op in MNEMONICS:
        return convert_mnemonic(label, op, operands, indent, warnings, in_macro)

    # Unknown construct
    warnings.append("UNKNOWN LINE: %r" % stripped)
    return indent + stripped


def convert_directive(label, op, operands, indent, warnings, in_macro=False):
    opname = op[1:] if op.startswith(".") else op
    lab = locals_of(fix_labels(label), in_macro) if label else ""

    # Delete/comment-only directives
    if opname in ("TI", "TF", "LIS", "EN"):
        return indent + ";" + (label + " " if label else "") + op + (
            " " + " ".join(operands) if operands else ""
        )

    if opname == "EQ":
        if len(operands) < 1:
            warnings.append("EQ without value: %s" % op)
            return indent + stripped_safe(label, op, operands)
        val = fix_labels(operands[0])
        cmt = comment_of(operands[1:])
        return f"{lab} = {val}{cmt}".rstrip()

    if opname == "OR":
        # .OR $0860  ->  * = $0860
        if len(operands) < 1:
            warnings.append("OR without addr")
            return indent + stripped_safe(label, op, operands)
        val = fix_labels(operands[0])
        cmt = comment_of(operands[1:])
        return f"{indent}* = {val}{cmt}".rstrip()

    if opname == "BS":
        if len(operands) < 1:
            warnings.append("BS without size")
            return indent + stripped_safe(label, op, operands)
        size = fix_labels(operands[0])
        cmt = comment_of(operands[1:])
        return f"{lab} .fill {size}{cmt}".rstrip()

    if opname == "DUMMY":
        addr = fix_labels(operands[0]) if operands else ""
        cmt = comment_of(operands[1:])
        return f"{indent}.virtual {addr}{cmt}".rstrip()

    if opname == "ED":
        cmt = comment_of(operands)
        return f"{indent}.endv{cmt}".rstrip()

    if opname == "EM":
        cmt = comment_of(operands)
        return f"{indent}.endm{cmt}".rstrip()

    if opname == "MA":
        if len(operands) < 1:
            warnings.append("MA without name")
            return indent + stripped_safe(label, op, operands)
        name = operands[0]
        newname = MACRO_RENAMES.get(name, name)
        cmt = comment_of(operands[1:])
        return f"{newname} .macro{cmt}".rstrip()

    if opname == "HS":
        if len(operands) < 1:
            warnings.append("HS without data")
            return indent + stripped_safe(label, op, operands)
        hexstr, rest = HEX_BYTES.match(operands[0]).groups()
        if len(hexstr) % 2 != 0:
            warnings.append("odd HS length: %s" % operands[0])
        bytes_list = ", ".join("$" + hexstr[i : i + 2].upper()
                               for i in range(0, len(hexstr), 2))
        cmt = comment_of(operands[1:] + (rest.split() if rest else []))
        lead = f"{lab} .byte {bytes_list}" if lab else f"{indent}.byte {bytes_list}"
        return (lead + cmt).rstrip()

    if opname == "DA":
        if len(operands) < 1:
            warnings.append("DA without data")
            return indent + stripped_safe(label, op, operands)
        # Operand may be a single comma-list token
        items = operands[0].split(",")
        converted = []
        for it in items:
            it = it.strip()
            if it.startswith("#"):
                converted.append(fix_labels(it[1:]))
            elif it.startswith("/"):
                converted.append(">" + fix_labels(it[1:]))
            elif it.startswith("<"):
                converted.append("<" + fix_labels(it[1:]))
            else:
                # bare label -> 16-bit address (.word)
                converted.append(fix_labels(it))
        is_word = not any(i.startswith("#") or i.startswith((">", "<"))
                          for i in items)
        # .DA# prefix (decimal bytes) if op is "DA#" -> handled below
        if opname == "DA" and op == "DA#":
            is_word = False
        if is_word:
            lead = f"{lab} .word {', '.join(converted)}" if lab else \
                   f"{indent}.word {', '.join(converted)}"
        else:
            lead = f"{lab} .byte {', '.join(converted)}" if lab else \
                   f"{indent}.byte {', '.join(converted)}"
        cmt = comment_of(operands[1:])
        return (lead + cmt).rstrip()

    if opname == "AS":
        # .AS "text"  -> .text "text" ; also support .AS -"text"
        arg = operands[0] if operands else ""
        arg = arg.lstrip("-")
        # Convert macro params inside the string if any
        arg = re.sub(r"\](\d)", r"\\\1", arg)
        cmt = comment_of(operands[1:])
        lead = f"{lab} .text {arg}" if lab else f"{indent}.text {arg}"
        return (lead + cmt).rstrip()

    if opname == "IN":
        if len(operands) < 1:
            warnings.append("IN without file")
            return indent + stripped_safe(label, op, operands)
        fname = operands[0].split(",")[0]
        target = INCLUDE_MAP.get(fname, fname)
        cmt = comment_of(operands[1:])
        return f"{indent}.include \"{target}\"{cmt}".rstrip()

    warnings.append("UNHANDLED DIRECTIVE: %s" % op)
    return indent + stripped_safe(label, op, operands)


def operand_looks_like_label(token):
    """True if token is a defined label or a literal (so it is an operand,
    not a comment word)."""
    base = token.split("+")[0].split(",")[0].split("-")[0].strip("(")
    return base in KNOWN_LABELS or base.startswith(("$", "#", "("))


def convert_mnemonic(label, op, operands, indent, warnings, in_macro=False):
    lab = locals_of(fix_labels(label), in_macro) if label else ""
    opcode = op
    # Implied-mode mnemonics: every following token is a comment.
    if op in ZERO_OP:
        cmt = comment_of(operands)
        lead = f"{lab} {opcode}" if lab else f"{indent}{opcode}"
        return (lead + cmt).rstrip()
    # Shift/rotate: accumulator mode unless a real operand follows.
    if op in SHIFT_ROTATE:
        if operands and operand_looks_like_label(operands[0]):
            operand = operands[0]
            operand = locals_of(operand, in_macro)
            operand = fix_labels(operand)
            cmt = comment_of(operands[1:])
            lead = f"{lab} {opcode} {operand}" if lab else f"{indent}{opcode} {operand}"
            return (lead + cmt).rstrip()
        cmt = comment_of(operands)
        lead = f"{lab} {opcode}" if lab else f"{indent}{opcode}"
        return (lead + cmt).rstrip()
    if not operands:
        warnings.append("mnemonic %s with no operand: %s" % (op, label or ""))
        lead = f"{lab} {opcode}" if lab else f"{indent}{opcode}"
        return lead.rstrip()
    operand = operands[0]
    # Macro-param, local-label & high/low-byte conversions in the operand.
    # In S-C, "/expr" as an instruction operand means the immediate high
    # byte: LDA /COLD.START -> LDA #>COLD.START  (listing shows A9 08).
    # And "#label" (16-bit address) means the immediate low byte:
    # LDA #COLD.START -> LDA #<COLD.START (64tass rejects LDA #$0860).
    operand = re.sub(r"\](\d)", r"\\\1", operand)
    if operand.startswith("/"):
        operand = "#>" + operand[1:]
    elif re.match(r"^#([A-Za-z_\\])", operand):
        operand = "#<" + operand[1:]
    operand = locals_of(operand, in_macro)
    operand = fix_labels(operand)
    cmt = comment_of(operands[1:])
    lead = f"{lab} {opcode} {operand}" if lab else f"{indent}{opcode} {operand}"
    return (lead + cmt).rstrip()


def comment_of(tokens):
    """Join remaining tokens as an S-C comment field."""
    if not tokens:
        return ""
    return " ; " + " ".join(tokens)


def stripped_safe(label, op, operands):
    parts = []
    if label:
        parts.append(label)
    parts.append(op)
    parts.extend(operands)
    return " ".join(parts)


def convert_file(path):
    text = path.read_text(encoding="utf-8", errors="replace")
    # Strip Ctrl-Z (0x1A) S-C end-of-file markers
    text = text.replace("\x1a", "").replace("\u001a", "")
    raws = text.splitlines()

    # Merge a .DUMMY block's following ".OR $addr" into ".DUMMY $addr"
    # (64tass wants the virtual address on the .virtual line).
    def no_lineno(raw):
        m = LINENO.match(raw)
        return raw[m.end():] if m else raw

    for i, raw in enumerate(raws):
        s = no_lineno(raw).lstrip()
        if re.match(r"^\.DUMMY\b", s, re.I):
            for j in range(i + 1, len(raws)):
                sj = no_lineno(raws[j]).lstrip()
                m2 = re.match(r"^\.OR\s+(\S+)", sj, re.I)
                if m2:
                    raws[i] = (raw[: len(raw) - len(s)] +
                               ".DUMMY " + m2.group(1))
                    raws[j] = ""
                    break
                if sj and not sj.startswith("*"):
                    break  # not an .OR; leave .DUMMY bare

    # Determine which lines are inside a .MA/.EM macro body.
    in_macro = [False] * len(raws)
    depth = 0
    for i, raw in enumerate(raws):
        s = no_lineno(raw).lstrip()
        if s.startswith(".MA") or s.startswith(".ma"):
            depth += 1
        elif s.startswith(".EM") or s.startswith(".em"):
            depth = max(0, depth - 1)
        in_macro[i] = depth > 0
    warnings = []
    out = []
    for i, raw in enumerate(raws):
        # Preserve leading whitespace handling per line
        out.append(convert_line(raw, warnings, in_macro[i]))
    return "\n".join(out) + "\n", warnings


def collect_labels(targets):
    """Gather every defined label in the project so that ASL/LSR/ROL/ROR
    operand-vs-comment disambiguation works."""
    for name in targets:
        src = ROOT / name
        if not src.exists():
            continue
        for raw in src.read_text(encoding="utf-8", errors="replace").splitlines():
            raw = raw.replace("\x1a", "").replace("\u001a", "")
            m = LINENO.match(raw)
            if m:
                raw = raw[m.end():]
            stripped = raw.lstrip()
            if not stripped or stripped.startswith("*"):
                continue
            tokens = stripped.split()
            first = tokens[0]
            if len(tokens) > 1:
                if first in MNEMONICS or first in DIRECTIVES or first == "*" or (
                    first.startswith(".") and first[1:] in DIRECTIVES
                ) or first.startswith(">"):
                    continue
                # first is a label definition
                if not first.startswith((".", ":")):
                    KNOWN_LABELS.add(first)
            else:
                if not first.startswith((".", ":")) and first not in MNEMONICS:
                    KNOWN_LABELS.add(first)


def main():
    targets = sys.argv[1:] or [
        "MOONMACR.ASM", "MOONEQU.ASM", "MOONCOD1.ASM", "MOONCOD2.ASM",
        "MOONCOD3.ASM", "MOONCOD4.ASM", "MOONCOD5.ASM", "MOONIRQ.ASM",
        "MOON.SHAPES.1", "MOON.SHAPES.2",
    ]
    collect_labels(targets)
    outdir = ROOT / "converted"
    outdir.mkdir(exist_ok=True)
    for name in targets:
        src = ROOT / name
        if not src.exists():
            print(f"MISSING: {name}")
            continue
        outtext, warnings = convert_file(src)
        (outdir / name).write_text(outtext, encoding="utf-8")
        print(f"=== {name}: {len(outtext.splitlines())} lines")
        for w in warnings:
            print("   WARN:", w)


if __name__ == "__main__":
    main()
