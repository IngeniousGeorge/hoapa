# Duplication audit

Two kinds of finding:

1. **Overlap** — the same fact lives in N>1 places. Often legitimate (canonical home + memory pointer + Agda header); flagged here so it is visible and so the right "canonical" copy can be confirmed.
2. **Divergence** — repo state has moved on from a doc that still claims something. These are bugs in the documentation and worth fixing.

Severity tags:
- 🟥 **Divergence** — doc says X, repo says ¬X
- 🟧 **Drift risk** — same fact in N places, *one of them* is the canonical home, the others should remain pointers (and currently are, mostly)
- 🟨 **Naming/format inconsistency** — cosmetic
- 🟦 **Legitimate redundancy** — repeated by design; flagged only so future cleanup doesn't mistake it for drift

---

## 1. 🟥 Divergences (doc claims, repo disagrees)

### 1.1 Concurrency stub claimed but folder is empty

| Doc says | Source |
|---|---|
| "agda/Concurrency/ holds a brand-new stub (`ThreePointedStruct`)" | `workflow/status.md:9` |
| "Concurrency/ B-side stub (dormant; ThreePointedStruct only)" | `CLAUDE.md:46` |
| Decisions Log: "Concurrency stub named `ThreePointedStruct`" / `2026-05-06` | `workflow/status.md:123` |
| "agda/Concurrency/  — candidate site (3-pointed sphere or related), develops B1+B2 separation." | `workflow/only_read_if_asked_to/arc.md:50` |

| Repo says |
|---|
| `agda/Concurrency/` and `agda/Analytic/Concurrency/` both exist but are **empty** (verified by `ls`). No `ThreePointedStruct.agda` file. |

**Recommendation.** Either (a) drop the "stub" framing from `status.md:9`, `CLAUDE.md:46`, and the Decisions Log row, and replace with "B-side directories scaffolded; no file yet"; or (b) create the stub file the doc claims exists. Pick whichever matches intent — but the current state is "doc says yes, repo says no."

### 1.2 "3-pointed sphere" terminology survives in `arc.md` after explicit rejection

| Doc says | Source |
|---|---|
| "candidate site (3-pointed sphere or related)" | `arc.md:50` |
| "Whether 3-pointed-sphere is the right Concurrency site or only a candidate." | `arc.md:81` |
| "The 3 marked points are the entryway to a complementary conjecture/theorem" | `conversation.md:36` (instigator prompt — historical; preserved) |

| But other docs say |
|---|
| Memory `b_side_site_icosahedral.md:7`: "The B-side (concurrency) site is the A_5-equivariant icosahedrally stratified S²" — and the negative-anchoring memory explicitly says "Don't refer to the B-side site as '3-pointed sphere' or 'S¹'" (`b_side_site_icosahedral.md:11`). |
| `targets.md:28-40` (T2): "the icosahedrally stratified S² (12 vertices, 30 edges, 20 faces, with the three orthogonal golden-rectangle sub-structure)" |

**Recommendation.** `arc.md:50` and `:81` should be updated to "icosahedrally stratified S² (T2)" with a back-anchor. `conversation.md:36` is an instigator prompt and should stay as-is (its job is historical anchoring); but a note "(later sharpened to icosahedral S²; see T2)" would help.

---

## 2. 🟧 Drift risk — facts that live in 3+ places

### 2.1 De Rham depth ladder (structural / named-coefficient / differential)

| Location | Lines | Role |
|---|---|---|
| `rug.md:24-42` "Beyond fracture: the differential-cohesion gap" | 18 lines | **Canonical taxonomy** |
| `memory/de_rham_depth_ladder.md` | 15 lines | Names + "depth not content" rationale + pointer back to the three sources |
| `agda/ModalHoTT/Cohomology/FlatCoefficients.agda:5-27` (header) | 23 lines | Same three-level taxonomy, restated in code-comment form |
| `workflow/status.md:65-70, :135-148` | mixed | Current task / live status |
| `CLAUDE.md:5-9` | 4 lines | Pointer to status.md + rug.md |

**Verdict.** The memory file correctly states `rug.md` is canonical and points there. But the Agda header restates the taxonomy in full (23 lines) rather than pointing at `rug.md`. If `rug.md` is edited, that header will silently drift.

**Recommendation.** Either (a) trim the Agda header to a one-line cite of `rug.md` "Beyond fracture", or (b) accept the redundancy on the grounds that the Agda file should remain self-explanatory to a reader without the workflow folder.

### 2.2 Fracture postulate framing

| Location | Lines | Role |
|---|---|---|
| `rug.md:5-22` "Regarding fracture" + Verdict | 18 lines | Postulate budget analysis |
| `agda/ModalHoTT/Modalities/Fracture.agda:18-36` (header) | 19 lines | Same content: ♯-lex shortcut, crisp-context register, Bℤ-asymmetry |
| `status.md:112-113` (Completed) | 2 lines | Summary |
| `targets.md:110-122` (T7) | 12 lines | Claim/state-cleanly/verify |

**Verdict.** Fracture is talked about everywhere it should be, but no single home owns "the explanation of why this is a postulate." `rug.md` and the Agda header overlap heavily (both list flat-intro register, ♯-lex, analytic asymmetry). Less overlap than the depth ladder; still worth a single-source decision.

### 2.3 Analytic-folder purpose ("demonstrate non-vacuity, not verify postulates")

| Location | Role |
|---|---|
| `status.md:15-25` Analytic Development | Live framing |
| `memory/analytic_strategy.md` | Restates with `Why / How to apply` |
| `status.md:46` Decisions Log row 2026-05-07 | One-liner of same |
| `agda/Analytic/ModalHoTT/Modalities/Adjunctions.agda:5-91` header | 86-line restatement of the same scope decision, in code-comment form |
| `agda/AnalyticTest/README.md:1-19` | Companion: what the analytic mirror *can't* carry, AnalyticTest covers |

**Verdict.** This is the most-restated single concept in the project. Probably warranted given how often a fresh reader needs it, but each restatement is independent prose — drift is likely.

**Recommendation.** Either consolidate to one canonical paragraph and cite from the others, or keep four parallel versions and accept the maintenance cost. Memory note `feedback_memory_not_workflow.md` says memory should hold *pointers* not *copies*; `memory/analytic_strategy.md` (30 lines) currently has copies of workflow content — it sits closest to violating that rule.

### 2.4 "Site is Bℤ" / "Bℤ ≃ S¹ but algebra is load-bearing"

| Location | Role |
|---|---|
| `motivation.md` | (implicit — proto-conjecture is site-agnostic) |
| `conversation.md:30, 34` | Instigator prompts that converge on Bℤ |
| `conversation.md:10` (negative-anchoring preamble) | Rejects "site is S¹" |
| `status.md:13` | "**The site is Bℤ — the delooping of ℤ.**" |
| `CLAUDE.md:5-7` Project Goal | Restates |
| `agda/ModalHoTT/Modalities/Cohesion.agda:4-8` (header) | Restates |
| Decisions Log `status.md:34` 2026-05-06 | One-liner |

**Verdict.** 🟦 Legitimate. This is the load-bearing background commitment; a reader landing on any of these files should see it without chasing pointers.

---

## 3. 🟨 Naming / format inconsistencies in `memory/`

### 3.1 Inconsistent prefix on feedback files

Eight memory entries have `feedback_` prefix:

```
feedback_memory_not_workflow.md
feedback_propose_first.md
feedback_precision_on_cubical.md
feedback_status_informal.md
feedback_postulates_over_records.md
feedback_analytic_folder_structure.md
feedback_independent_legs_then_bridge.md
feedback_flag_workarounds.md
```

One entry has frontmatter `type: feedback` but no prefix:

```
decisions_log_split.md          # type: feedback
```

By symmetry: project files use no prefix (`negative_anchoring.md`, `math_is_subsystem.md`, `b_side_site_icosahedral.md`, `analytic_strategy.md`); the reference file uses no prefix (`de_rham_depth_ladder.md`); the user file uses no prefix (`user_profile.md`).

So the inconsistency is just `decisions_log_split.md` — it is feedback but is named like a project/reference entry. Either rename to `feedback_decisions_log_split.md` or accept (the prefix convention isn't strictly enforced).

### 3.2 `originSessionId` frontmatter inconsistency

Some memory files carry `originSessionId: <uuid>`:
- `user_profile.md`, `feedback_memory_not_workflow.md`, `negative_anchoring.md`, `math_is_subsystem.md`, `b_side_site_icosahedral.md`, `decisions_log_split.md`, `feedback_propose_first.md`, `feedback_precision_on_cubical.md`, `feedback_status_informal.md`, `feedback_postulates_over_records.md`, `analytic_strategy.md`, `feedback_analytic_folder_structure.md`, `de_rham_depth_ladder.md`, `feedback_independent_legs_then_bridge.md`, `feedback_flag_workarounds.md`

Looking back at frontmatter contents, all 15 individual memories carry it (the field appears in every file I read). So this is consistent — no issue.

### 3.3 `MEMORY.md` index ordering not topical

The 15 lines of `MEMORY.md` are in insertion order, not grouped by type. With only 15 entries this is fine; if it grows past ~25 entries, grouping by type (`user / project / feedback / reference`) would help.

### 3.4 Typo in `workflow/README.md:7`

`"you my ask the instigator"` — `my` should be `may`.

---

## 4. 🟦 Legitimate redundancy worth noting

These overlaps are *probably* intentional but are flagged so future cleanup recognises them.

| Concept | Lives in | Why redundancy is OK |
|---|---|---|
| Cohesion modality vocabulary (♭/♯/ʃ) | `naming.md` table + `arc.md` §2-4 + Agda section headers in `Cohesion.agda` | Each audience needs it: `naming.md` for quick lookup; `arc.md` to ground the structural claim; Agda comments so a reader of the file doesn't need the workflow folder. |
| Two-track strategy (synthetic + analytic) | `status.md:15-25` + Decisions Log row `:43` + `CLAUDE.md:44-46` Directory Layout + `agda/Analytic/.../Adjunctions.agda` header | Same — multiple entry points; each is shorter than a full restatement of analytic-strategy. |
| `flat-intro` is a crisp-context shortcut | `Cohesion.agda:36-38` + `rug.md:7-9` + `Analytic/.../Cohesion.agda:140` (and `:16-20` header) + memory implicit | Three "voices": the postulate itself flags it; rug catalogues it; the analytic counter-example concretises it. |
| ♯(Bℤ) deferred | `Analytic/.../Cohesion.agda:272-281` (commentary block) + Adjunctions/Fracture/Properties analytic headers all referring to it + `status.md` "Unlocking ♯" §72-96 | One concept, one canonical block (`Analytic/.../Cohesion.agda:272-281`), several short cross-refs. Healthy. |

---

## 5. Workflow rules vs observed practice

| Rule | Source | Status |
|---|---|---|
| Propose before implementing | `CLAUDE.md:35` + `memory/feedback_propose_first.md` | Honoured this session via `AskUserQuestion` before writing this folder. |
| Long names over notation | `CLAUDE.md:31` + Decisions Log `status.md:36` | Honoured throughout Agda — no Unicode-only identifiers. |
| One file per concept | `CLAUDE.md:24` | Honoured — `Cohesion.agda` / `Adjunctions.agda` / `Properties.agda` / `Fracture.agda` / `Discrete.agda` / `FlatCoefficients.agda` each carry one concept. Analytic mirror with one exception: `Analytic/.../Cohesion.agda` (281 lines) folds the `DeloopingOfIntegers` HIT + deck transformations + universal cover + Ω(Bℤ) ≃ ℤ into a single file — but per `memory/feedback_analytic_folder_structure.md`, this is by *explicit* instigator decision, not an accident. |
| No silent imports | `CLAUDE.md:25` | Cubical-only; no surprises. |
| Mathematical fidelity first | `CLAUDE.md:27` | The `flat-intro` crisp-context flag, the `Discrete.agda` deferral, the `shape-flat-natural-B` postulate all explicitly mark over-approximations rather than silently accepting them. |
| Track blockers in `status.md` | `CLAUDE.md:33` | Honoured — `status.md` "Blockers" § (currently empty), "Open Questions" §, "Decisions Log" both halves. |

---

## 6. Summary

- **2 hard divergences** (Concurrency stub claimed but absent; "3-pointed sphere" survives in `arc.md` after sharpening to icosahedral S²).
- **4 multi-home concepts** with drift risk (de Rham ladder, fracture framing, analytic-folder purpose, "site is Bℤ"). The first three are the candidates for canonicalisation; "site is Bℤ" is fine as background.
- **1 naming inconsistency** (`decisions_log_split.md` lacks `feedback_` prefix despite being feedback).
- **1 typo** (`README.md:7`).
- Rule compliance is high; the load-bearing convention "propose before implementing" is enforced via permission mode and observed in practice.
