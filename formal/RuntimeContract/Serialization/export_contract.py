#!/usr/bin/env python3
"""Export the formal serialization contract to the runtime as a vendored artifact.

Wipes and recreates runtime/apps/hoapa_contract/priv/runtime_contract/, copies
schema.json and the fixture corpus, and writes manifest.json carrying a per-file
sha256 of every exported SOURCE artifact (schema + fixtures) -- never the
manifest itself.

Formal-owned, stdlib only, deterministic. The runtime consumes only the
vendored copy; it never reads back into /formal. Cross-leg freshness is a
top-level `make` / git gate; internal integrity (priv matches its manifest) is
a runtime test that recomputes these per-file hashes.
"""
from __future__ import annotations

import hashlib
import json
import shutil
from pathlib import Path

HERE = Path(__file__).resolve().parent          # .../formal/RuntimeContract/Serialization
REPO = HERE.parents[2]                           # repo root
PRIV = REPO / "runtime" / "apps" / "hoapa_contract" / "priv" / "runtime_contract"

CONTRACT_VERSION = "hoapa.trace/0"
MANIFEST_NAME = "manifest.json"


def sha256_file(p: Path) -> str:
    return hashlib.sha256(p.read_bytes()).hexdigest()


def main() -> None:
    src_schema = HERE / "schema.json"
    src_fixtures = HERE / "fixtures"

    # Clear-before-export: deleted fixtures must not leave stale vendored files.
    if PRIV.exists():
        shutil.rmtree(PRIV)
    PRIV.mkdir(parents=True)

    shutil.copy2(src_schema, PRIV / "schema.json")
    shutil.copytree(src_fixtures, PRIV / "fixtures")

    # Per-file hashes over the exported source artifacts only (exclude manifest).
    files = {}
    for p in sorted(PRIV.rglob("*")):
        if p.is_file() and p.name != MANIFEST_NAME:
            files[p.relative_to(PRIV).as_posix()] = sha256_file(p)

    manifest = {"contractVersion": CONTRACT_VERSION, "files": files}
    (PRIV / MANIFEST_NAME).write_text(
        json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )

    print(f"exported -> {PRIV}")
    for rel in files:
        print(f"  {rel}")
    print(f"  manifest: {len(files)} source artifacts, contractVersion {CONTRACT_VERSION}")


if __name__ == "__main__":
    main()
