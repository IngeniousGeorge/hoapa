# Inventory — workflow/ + memory/

Flat catalog of every file in `workflow/` (including the `memory/` symlink target). For each: type, lines, one-line role, and the principal landmarks worth knowing about. The other three files in this folder build on this catalog:

- `reference_graph.md` — which file points to which (the edges between rows here)
- `code_connections.md` — which Agda file/line realises or mentions a workflow concept
- `duplication_audit.md` — where the same information lives in N>1 places, and where doc disagrees with repo state

---

## 1. `workflow/` (root)

Loaded on the focused path. Together these are the minimum a fresh agent reads.

| File | Lines | Role | Landmarks |
|---|---:|---|---|
| `README.md` | 29 | Onboarding map. Defines the **focused path** (`status.md` only) and the **architecture path** (the architecture-path files at `workflow/` root). | "Focused path" §, "Architecture path" § (Backbone + Reference), "Memory" §. |
| `status.md` | 154 | The living document. Single source of truth for state, decisions, blockers, completed work, and the live discussion of the next step. | Conjecture Arc / B-side / Semantic Background / Analytic Development / Decisions Log — Relevant (12 rows, latest 2026-05-14) / Open Questions / **Current Task** / **Next step** / "Unlocking ♯" / Blockers / Completed (13 items) / Decisions Log — Archived / Discussion of the next step. |
| `memory/` | — | Symlink → `~/.claude/projects/-home-ig-Code-doc2cog/memory/`. Cross-conversation agent memory. | Catalogued separately in §3 below. |

---

## 2. Architecture-path files (`workflow/` root)

Loaded only when `status.md` is insufficient. Seven files; two reading orders depending on need (backbone vs reference; see `README.md:14-25`).

| File | Lines | Role | Landmarks |
|---|---:|---|---|
| `motivation.md` | 25 | Philosophical seed. Hand-wavy proto-conjecture; flagged as "the math we are building is a subsystem of this broader picture." | Three claims [A], [B1], [B2]; the four-bullet codependency block; footnote on actor model. |
| `arc.md` | 83 | The conjecture reformulated in cohesive vocabulary (`Allow ⊣ Mediate ⊣ Require`). Structural backbone. Each section carries a `→ T*n*` anchor to `targets.md`. | §§1 Preamble · 2 Three per-domain claims · 3 Structural claim →T1 · 4 What the triple says →T1+T6 · 5 Sites and folders →T2+T4+T5 · 6 Math fragment →T3 · 7 Interpretation →T6 · 8 What is left for discovery. |
| `targets.md` | 141 | T1–T7 propositions decomposing the arc. Each target back-anchors to an `arc.md` section. Decisive on what the proof checker should engage with. | T1 adjoint triple · T2 cohesion on icosahedral S² · T3 Lawvere asymmetry · T4 partition match · T5 protocol as operational cohesion · T6 two-sided "above" · T7 fracture/de Rham → arc-level separation · "Not targets" caveat · Dependency sketch. |
| `conversation.md` | 58 | **Negative anchoring** — corrections-against-default-LLM-mis-readings, not historical chat. | Four rejected defaults (modal HoTT vs HoTT / site is S¹ / concurrency decorative / synthetic alone enough). Seven instigator-prompt sections: 3 roles / Goal & first step / Precisions / On 3 marked points / On the structural conjecture / Synthetic structure / "Useful prompts" after-clear. |
| `rug.md` | 41 | "Under the rug" — postulate budget, imported soundness, the differential-cohesion gap. Consult before extending postulates or evaluating "is this really proved?". | §"Regarding fracture" (5 bullets + Verdict) · §"Beyond fracture: the differential-cohesion gap" (depth ladder + what a differential upgrade would cost + three-track placement of differential in AnalyticTest). |
| `related_structures.md` | 49 | Adjacent frameworks. Locator, not target. | Connes (NCG + modular flow + thermal-time + Changeux) · Bennequin / Belfiore / Laforgue (topos for cognition, Huawei line) · template · candidate: Friston. |
| `naming.md` | 5 | Vocabulary table for the three modalities. Pure reference. | Five-column table: Name / Symbol / Intuition / Keeps / Forgets for flat ♭, sharp ♯, shape ʃ. |

---

## 3. `workflow/memory/` (Claude Code auto-memory)

16 files: an index + 15 individual memories. Frontmatter `type` is one of `user`, `feedback`, `project`, `reference`. Naming follows the type only partially (see `duplication_audit.md`).

### 3.1 Index

| File | Lines | Role |
|---|---:|---|
| `MEMORY.md` | 17 | One-line-per-memory index loaded into every conversation. No frontmatter. Capped near ~200 lines by harness. |

### 3.2 User memory (1)

| File | Lines | Topic |
|---|---:|---|
| `user_profile.md` | 14 | ig's role, domain expertise (HoTT + concurrency), tools, references, intellectual style, collaboration preferences. |

### 3.3 Project memory (4)

| File | Lines | Topic |
|---|---:|---|
| `negative_anchoring.md` | 16 | Why `conversation.md` exists; treat anti-default scaffolding as load-bearing. |
| `math_is_subsystem.md` | 11 | The Agda track is part of `motivation.md`'s broader picture, not its totality. |
| `b_side_site_icosahedral.md` | 11 | B-side site = A₅-equivariant icosahedrally stratified S² (12 vertices ↔ 3 golden rectangles). Sharper than the older "3-pointed sphere" language still surviving in `arc.md:50`. |
| `analytic_strategy.md` | 30 | Purpose/scope of `agda/Analytic/`: demonstrate non-vacuity, not verify postulates; crisp contexts as future path; library-contribution downstream goal. |

### 3.4 Feedback memory (8)

| File | Lines | Topic |
|---|---:|---|
| `feedback_memory_not_workflow.md` | 11 | Workflow is source of truth; memory holds patterns + pointers, never copies. |
| `feedback_propose_first.md` | 15 | Alignment precedes all code — applies to every Write/Edit, including scaffolding. |
| `feedback_precision_on_cubical.md` | 14 | Distinguish synthetic (no HITs/interval in definitions) from "no cubical dependency"; proofs still use shallow cubical infra. |
| `feedback_status_informal.md` | 11 | Don't tidy informal text from `status.md`; the informal layer is intentional. |
| `feedback_postulates_over_records.md` | 11 | Flat postulates over record wrappers; conceptual point goes in a comment. |
| `feedback_analytic_folder_structure.md` | 11 | Mirror synthetic folder structure; no new subdirectories (e.g. `Types/`) without discussion. |
| `feedback_independent_legs_then_bridge.md` | 11 | Develop A and B independently before T1; bridge-first stubs are cheating. |
| `feedback_flag_workarounds.md` | 11 | When using `{X = X}` or other inference-helper idioms, name them as hints and offer cleaner alternatives. |
| `decisions_log_split.md` | 13 | (Feedback type, no `feedback_` prefix — see audit.) `status.md`'s Decisions Log splits Relevant/Archived; default for decision-log-style records. |

### 3.5 Reference memory (1)

| File | Lines | Topic |
|---|---:|---|
| `de_rham_depth_ladder.md` | 15 | Three-level vocabulary structural / named-coefficient / differential; why "depth" not "content". Points at `rug.md`, `status.md`, and the FlatCoefficients header as canonical sources. |

---

## 4. `CLAUDE.md` (project root)

Not in `workflow/` but loaded into every conversation. Cross-references most of the above.

| File | Lines | Role |
|---|---:|---|
| `CLAUDE.md` | 55 | Project Goal · Current Phase · Roles · Workflow Conventions (6 rules) · Directory Layout · Agda Notes. References `workflow/README.md`, `workflow/status.md`, `workflow/conversation.md`, `workflow/rug.md`. |

---

## 5. Size profile (visual)

```
status.md           ████████████████████████████████████████████████ 154
targets.md          ████████████████████████████████████████████     141
arc.md              ███████████████████████████                       83
conversation.md     ███████████████████                               58
CLAUDE.md           ██████████████████                                55
related_structures  ████████████████                                  49
rug.md              █████████████                                     41
analytic_strategy   ██████████                                        30
README.md           █████████                                         29
motivation.md       ████████                                          25
MEMORY.md           █████                                             17
negative_anchoring  █████                                             16
de_rham_ladder      █████                                             15
propose_first       █████                                             15
user_profile        ████                                              14
precision_cubical   ████                                              14
decisions_log_split ████                                              13
8× short feedback   ███                                               11 each
naming.md           █                                                  5
```

Centre of mass is `status.md` + `targets.md` + `arc.md` (~378 lines / 60% of workflow). Everything else is short and reference-like.
