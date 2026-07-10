#!/usr/bin/env python3
"""Export the Hoapa cartography graph to Kumu import CSVs.

Reads the document graph in ``cartography/`` (``nodes/``, ``shapes/``, ``edges/``)
and writes ``elements.csv`` and ``connections.csv`` beside this script, ready to
import into Kumu (https://kumu.io). Hoapa ids are used as Kumu ids so that
re-imports update rather than duplicate.

Run:  python3 workflow/tools/cartography/export_kumu.py
"""
import csv
import re
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
REPO = SCRIPT_DIR.parents[2]           # workflow/tools/cartography -> repo root
DATA = REPO / "cartography"            # the live graph
OUT = SCRIPT_DIR                       # CSVs land next to this script

# Connection types Kumu will see as clean lowercase selectors. This is the full
# Hoapa edge vocabulary plus the synthetic `contains`; unknown types are still
# exported verbatim (we never silently drop an edge's real type).
KNOWN_CONNECTION_TYPES = {
    "presupposes", "forced-by", "fails-without", "adjoint-to", "dual-to",
    "enriches", "saturates", "liberates", "discharges-into", "bounds",
    "must-not-glue-to", "translates-to", "glues-with", "descends-to",
    "instantiates", "fixed-point-of", "realizes", "contains",
}


def parse(path):
    """Return (frontmatter dict, body str). Handles scalars, inline [a, b]
    lists, and block '- item' lists."""
    text = path.read_text()
    d, body = {}, text
    if text.startswith("---"):
        parts = text.split("---", 2)
        fmtext, body = parts[1], (parts[2] if len(parts) > 2 else "")
        lines = fmtext.splitlines()
        i = 0
        while i < len(lines):
            line = lines[i]
            if not line.strip():
                i += 1
                continue
            m = re.match(r"^(\w[\w-]*):\s*(.*)$", line)
            if not m:
                i += 1
                continue
            key, val = m.group(1), m.group(2).strip()
            if val == "":
                items, j = [], i + 1
                while j < len(lines) and re.match(r"^\s+-\s+", lines[j]):
                    items.append(re.sub(r"^\s+-\s+", "", lines[j]).strip().strip('"'))
                    j += 1
                d[key] = items if items else ""
                i = j if items else i + 1
                continue
            if val.startswith("[") and val.endswith("]"):
                inner = val[1:-1].strip()
                d[key] = [x.strip().strip('"') for x in inner.split(",")] if inner else []
            else:
                d[key] = val.strip('"')
            i += 1
    return d, body


def desc(body):
    return re.sub(r"\s+", " ", body).strip()


def uniq(seq):
    out = []
    for x in seq:
        if x and x not in out:
            out.append(x)
    return out


def as_list(v):
    if isinstance(v, list):
        return v
    return [v] if v else []


def tags_cell(d):
    """Pipe-separated tags, enriched with kind + shape + position so Kumu
    selectors can filter on any of them."""
    parts = as_list(d.get("tags")) + [d.get("kind", "")]
    if d.get("shape"):
        parts.append(d["shape"])
    if d.get("position"):
        parts.append(d["position"])
    return "|".join(uniq(parts))


def main():
    node_files = sorted((DATA / "nodes").glob("*.md"))
    shape_files = sorted((DATA / "shapes").glob("*.md"))
    edge_files = sorted((DATA / "edges").glob("*.md"))

    elements, element_ids = [], set()
    for p in node_files + shape_files:
        d, b = parse(p)
        element_ids.add(d["id"])
        elements.append([
            d["id"], d.get("label", ""), d.get("kind", ""), desc(b), tags_cell(d),
            d.get("kind", ""), d.get("shape", ""), d.get("position", ""),
            str(p.relative_to(DATA)),
        ])

    conns = []
    for p in edge_files:                     # real edges
        d, b = parse(p)
        t = d.get("type", "")
        paired = "true" if str(d.get("paired", "")).lower() == "true" else ""
        conns.append([
            d["id"], d["source"], d["target"], t, t, desc(b),
            "|".join(uniq([t] + (["paired"] if paired else []))),
            d.get("relation", ""), paired, str(p.relative_to(DATA)), "",
        ])
    synthetic = 0
    for p in shape_files:                    # synthetic membership edges
        d, _ = parse(p)
        for m in as_list(d.get("members")):
            synthetic += 1
            conns.append([
                f"{d['id']}--contains--{m}", d["id"], m, "contains", "contains",
                f"membership: {d['id']} contains {m}", "contains|synthetic",
                "", "", "", "true",
            ])

    OUT.mkdir(parents=True, exist_ok=True)
    with (OUT / "elements.csv").open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["ID", "Label", "Type", "Description", "Tags", "Kind", "Shape", "Position", "File"])
        w.writerows(elements)
    with (OUT / "connections.csv").open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["ID", "From", "To", "Type", "Label", "Description", "Tags", "Relation", "Paired", "File", "Synthetic"])
        w.writerows(conns)

    bad = [c[0] for c in conns if c[1] not in element_ids or c[2] not in element_ids]
    unknown = sorted({c[3] for c in conns} - KNOWN_CONNECTION_TYPES)
    print(f"elements: {len(elements)}  connections: {len(conns)} "
          f"(real: {len(conns) - synthetic}, synthetic contains: {synthetic})")
    print("endpoint check:", "OK" if not bad else f"BROKEN: {bad}")
    if unknown:
        print("unknown connection types exported verbatim:", unknown)


if __name__ == "__main__":
    main()
