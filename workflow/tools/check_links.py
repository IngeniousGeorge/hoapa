#!/usr/bin/env python3
"""workflow/tools/check_links.py — gate internal markdown links on both renderers.

Why both: the project publishes to Codeberg (Forgejo) and is read on GitHub, and
the two derive heading anchors differently. GitHub deletes punctuation; Forgejo
collapses each run of non-word characters into one hyphen. So "Reader's note" is
`#readers-note` on one and `#reader-s-note` on the other, and ` — ` yields two
hyphens on GitHub but one on Forgejo. A fragment written against one renderer
silently fails on the other. This gate requires every internal link to resolve
under BOTH rule sets, which is strictly stronger than either one and so stays
correct even if one of the two models drifts.

A heading is portable whenever each non-word character is a hyphen between word
characters, or punctuation followed by exactly one space, or trailing. That is a
sufficient rule, not a characterization — this checker is the authority. In
practice: use `:` or `,` rather than a spaced em dash, write name compounds with
ASCII hyphens (Grothendieck-Riemann-Roch), and keep apostrophes and slashes out
of headings you intend to link.

Both renderers also pass a literal `<a id="...">` through verbatim, prefixing it
with `user-content-` exactly as they do a heading (verified against the live
Codeberg render, 2026-10-09). An old anchor spelling can therefore be kept alive
with a one-line relocation pointer instead of a heading rename, which is what
`future_work.md`'s "Relocated investigations" section does.

One job, so that it can be a gate: a `#fragment` must resolve under the GitHub
rules AND under the Forgejo rules. That is the only failing condition.

Two further problems are reported as warnings and do not fail, because they live
almost entirely in draft copies, exported markdown, and the frozen modal
snapshot, none of which this gate can repair: a target that does not exist, and
an absolute path, which resolves on one machine and nowhere else. A gate that
fails on a missing draft image gets switched off, and then the fragments stop
being checked too.

Anchors a file offers = ATX heading slugs + setext heading slugs + every literal
`<a id="...">` value. Duplicate slugs take `-1`, `-2`, … on both renderers; the
dedup is computed separately per rule set because the collisions differ.

Setext detection is heuristic and deliberately generous, since an extra anchor
can only suppress a false alarm, never hide a real break. Headings inside fenced
code are excluded, because they render as text and genuinely carry no anchor.

Build-time tool, stdlib only, not shipped.

Usage:
    workflow/tools/check_links.py              # whole repo, from any directory
    workflow/tools/check_links.py workflow     # one subtree
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]

MARKDOWN_SUFFIXES = {".md", ".markdown"}
SKIPPED_DIRECTORIES = {".git", "_build", "deps", "node_modules", "build"}
EXTERNAL_SCHEME = re.compile(r"^[a-z][a-z0-9+.-]*:", re.IGNORECASE)

FENCE = re.compile(r"^\s{0,3}(`{3,}|~{3,})")
ATX_HEADING = re.compile(r"^\s{0,3}#{1,6}\s+(.*?)\s*#*\s*$")
SETEXT_RULE = re.compile(r"^\s{0,3}(=+|-{2,})\s*$")
SETEXT_EXCLUDED_PREFIX = ("#", "-", "*", "+", ">", "|", "`", "~", "=")
MANUAL_ANCHOR = re.compile(r"""<a\s[^>]*\bid\s*=\s*["']([^"']+)["']""", re.IGNORECASE)
INLINE_CODE = re.compile(r"`[^`\n]*`")
INLINE_LINK = re.compile(r"\]\(\s*(<[^>\n]*>|[^()\s]*)(?:\s+(?:\"[^\"\n]*\"|'[^'\n]*'))?\s*\)")
REFERENCE_LINK = re.compile(r"\]\[([^\]\n]*)\]")
REFERENCE_DEFINITION = re.compile(r"^\s{0,3}\[([^\]\n]+)\]:\s*(\S+)")


def slug_github(heading: str) -> str:
    """GitHub's rule: drop punctuation, then map each remaining space to a hyphen."""
    text = heading.replace("`", "").strip().lower()
    text = re.sub(r"[^\w\s-]", "", text, flags=re.UNICODE)
    return text.replace(" ", "-")


def slug_forgejo(heading: str) -> str:
    """Forgejo's rule: collapse each run of non-word characters into one hyphen."""
    text = heading.replace("`", "").lower()
    return re.sub(r"[^\w]+", "-", text, flags=re.UNICODE).strip("-")


def heading_texts(lines: list[str]) -> list[str]:
    """Headings outside fenced code, ATX plus conservatively detected setext."""
    found: list[str] = []
    open_fence: str | None = None
    for index, line in enumerate(lines):
        fence = FENCE.match(line)
        if fence:
            marker = fence.group(1)[0]
            if open_fence is None:
                open_fence = marker
            elif open_fence == marker:
                open_fence = None
            continue
        if open_fence is not None:
            continue
        atx = ATX_HEADING.match(line)
        if atx:
            found.append(atx.group(1))
            continue
        if index and SETEXT_RULE.match(line):
            previous = lines[index - 1]
            stripped = previous.strip()
            if stripped and not stripped.startswith(SETEXT_EXCLUDED_PREFIX):
                found.append(stripped)
    return found


def anchors_for(path: Path) -> tuple[set[str], set[str]]:
    """Anchors this file offers, as (github, forgejo). Manual ids land in both."""
    text = path.read_text(encoding="utf-8", errors="replace")
    lines = text.splitlines()
    manual = set(MANUAL_ANCHOR.findall(text))
    offered: list[set[str]] = []
    for slugify in (slug_github, slug_forgejo):
        seen: dict[str, int] = {}
        anchors = set(manual)
        for heading in heading_texts(lines):
            slug = slugify(heading)
            if slug in seen:
                seen[slug] += 1
                slug = f"{slug}-{seen[slug]}"
            else:
                seen[slug] = 0
            anchors.add(slug)
        offered.append(anchors)
    return offered[0], offered[1]


def reference_definitions(lines: list[str]) -> dict[str, str]:
    definitions: dict[str, str] = {}
    for line in lines:
        match = REFERENCE_DEFINITION.match(line)
        if match:
            definitions[match.group(1).strip().lower()] = match.group(2)
    return definitions


def link_targets(path: Path) -> list[tuple[int, str]]:
    """Every link target in the file, as (line number, raw target)."""
    lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
    definitions = reference_definitions(lines)
    targets: list[tuple[int, str]] = []
    open_fence: str | None = None
    for number, line in enumerate(lines, start=1):
        fence = FENCE.match(line)
        if fence:
            marker = fence.group(1)[0]
            if open_fence is None:
                open_fence = marker
            elif open_fence == marker:
                open_fence = None
            continue
        if open_fence is not None:
            continue
        if REFERENCE_DEFINITION.match(line):
            continue
        prose = INLINE_CODE.sub("", line)
        for match in INLINE_LINK.finditer(prose):
            targets.append((number, match.group(1).strip("<>").strip()))
        for match in REFERENCE_LINK.finditer(prose):
            label = match.group(1).strip().lower()
            if label in definitions:
                targets.append((number, definitions[label]))
    return targets


def markdown_files(root: Path) -> list[Path]:
    files = [
        candidate
        for candidate in root.rglob("*")
        if candidate.suffix.lower() in MARKDOWN_SUFFIXES
        and candidate.is_file()
        and not SKIPPED_DIRECTORIES.intersection(candidate.relative_to(root).parts)
    ]
    return sorted(files)


def check(root: Path) -> tuple[list[tuple[Path, int, str, str]], list[tuple[Path, int, str, str]]]:
    """Return (failures, warnings), each as (file, line, target, reason) items."""
    cache: dict[Path, tuple[set[str], set[str]]] = {}
    failures: list[tuple[Path, int, str, str]] = []
    warnings: list[tuple[Path, int, str, str]] = []
    for path in markdown_files(root):
        for number, target in link_targets(path):
            if not target or target.startswith("#"):
                resolved, fragment = path, target[1:]
            else:
                if EXTERNAL_SCHEME.match(target) or target.startswith("//"):
                    continue
                location, _, fragment = target.partition("#")
                if location.startswith("/"):
                    warnings.append(
                        (path, number, target, "absolute path; resolves on this machine only")
                    )
                    continue
                resolved = (path.parent / location).resolve()
            if not resolved.exists():
                warnings.append((path, number, target, "target does not exist"))
                continue
            if not fragment or resolved.suffix.lower() not in MARKDOWN_SUFFIXES:
                continue
            if resolved not in cache:
                cache[resolved] = anchors_for(resolved)
            github, forgejo = cache[resolved]
            missing = [
                name
                for name, anchors in (("GitHub", github), ("Forgejo/Codeberg", forgejo))
                if fragment not in anchors
            ]
            if missing:
                failures.append((path, number, target, "no anchor on " + " and ".join(missing)))
    return failures, warnings


def report(root: Path, items: list[tuple[Path, int, str, str]]) -> None:
    current: Path | None = None
    for path, number, target, reason in items:
        if path != current:
            print(f"\n{path.relative_to(root)}")
            current = path
        print(f"  :{number}  {target}\n          {reason}")


def main(argv: list[str]) -> int:
    root = (Path(argv[1]).resolve() if len(argv) > 1 else REPO_ROOT)
    if not root.is_dir():
        print(f"check_links: not a directory: {root}", file=sys.stderr)
        return 2
    failures, warnings = check(root)
    if warnings:
        print(f"docs-links warnings ({len(warnings)}) — not gated:")
        report(root, warnings)
        print()
    if failures:
        print("docs-links failures — fragment does not resolve on one or both renderers:")
        report(root, failures)
        print(f"\ndocs-links FAILED: {len(failures)} fragment(s) do not resolve")
        return 1
    print("docs-links OK: every internal fragment resolves on both renderers")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
