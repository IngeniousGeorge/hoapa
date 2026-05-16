# Archived 2026-05-16 — workflow/ cleanup after the Concurrency-side reframe

Stale or superseded content cut out of `workflow/` during the 2026-05-16 cleanup. Nothing here is deleted — moved here so that a fresh agent reading `workflow/` sees only what is current, and can still recover historical context if needed.

The reframe behind this cleanup: the Concurrency-side site moved from "A_5-equivariant icosahedral S²" (a cohesion-first commitment) to an **operational under-layer** — an actor-causal site (GR-inspired actor model) as base topology, with Caires–Pfenning session-type structures as the values on a sheaf over it, all sitting inside cubical sets. The canonical source for this reframe is `workflow/deep_context/concurrency_anchor.md`.

## How to use this file

- Each archived section title is the *original location* of the content, in the form `/path/to/file:Section:Subsection`.
- Read top-to-bottom for a tour of what the project used to look like; jump to a specific section to find what was at one place.
- Content within each section is preserved verbatim. Edit only to add cross-references back to live files where they exist.

## Instructions (verbatim, 2026-05-16)

> Please have a look at the readme in workflow and follow the architecture path, and then everything else in the workflow folder. There is a lot of work to do in order to restructure this folder (which is the context for the agents, the "planet on which they land after each new context clearance"). There has been a major change to our plan lately, since our focus/bandwidth has switched from the ModalHoTT side to the Concurrency side (note: those two sides correspond to two folder names in the Agda code; in the workflow folder they're sometimes called A and B, which makes it extremely confusing on many occasions — one thing to add to your ToDo today is to replace all mentions of A and B with ModalHoTT and Concurrency). We were already behind in terms of restructuring, and then the Concurrency side saw a major rehaul, so a lot of the structure needs to be reshaped but also the content. As you go through your reading of those files (including memories, and any other file you're curious about), please populate a todo list of everything that will need updated. The plan is to not delete anything but to move it to a file `archived_20260516.md` in `/only_read_if_asked_to`, which we will rename to `/project_deep_memory`. Our main concern here is the new agent coming into this project and what they need to know to be efficient. We want to strike a balance between being honest with the fact that the project is dynamic, and it's ok if there is a little bit of "the original plan was B but now we're doing B'", because it can be useful to see how it evolves, it gives some historical perspective, but we don't want to have too much of it either, such that the agent might be confused as to what is the actual plan at time T. We also want the folder & file structure to be transparent, natural and to follow/invent smart conventions, which is probably not the case at the moment. Most of the work will be moving things to the archive file (where sections titles will be the location of the information in the current structure: `/path/to/file:section:subsection`, and a reminder of the folder-file structure as of now at the top of the file). In the cases where something new needs to be put in the place of stale information, we won't put anything today but a note to do it in the next session (the information is there in some key files, the end of `status` and `b_anchor`, but it also needs refining and rethinking, so we'll do it in subsequent session). This session is about trimming and cleaning up.
>
> Our workflow today will be very stepwise: you propose a numbered batch of changes/moves, we discuss them, you apply. Never apply before discussing.
>
> I'll let you read the files and then you tell me what you think.

## Refinements after the agent's first read

These adjustments narrowed the original instructions once the agent had read the folder:

- **`deep_context/` is out of scope today.** The folder (renamed today from `only_read_if_asked_to/`) is the project's *evolution journal* — long-form conversations, divergent agent plans, dropped ideas. Not part of standard onboarding; consulted occasionally. Its existing files (`agent_plan_2026-05-13.md`, `arc_discussion_log-2026-05-08.md`, `ideas.md`) stay as-is. **This archive file lives there as a sibling.**
- **`b_anchor.md` → `concurrency_anchor.md`**, as part of the A → ModalHoTT / B → Concurrency rename. If other concepts are referred to by bare numbers or letters, flag them for renaming. (Flagged today: `B1 / B2` for "typed data" / "unityped agents"; T1–T7, R1–R6, and `_Site / _Algebra / _Sheaf / _Topos` already carry descriptive names.)
- **`structure/` is mostly archive material.** Its five files (`inventory.md`, `reference_graph.md`, `code_connections.md`, `duplication_audit.md`, `proposal.md`) were generated to plan this very restructure; once we have done the restructure they become snapshots. **Most of `structure/` → archive.** What survives in onboarding goes into a new short file `workflow/structure.md` that briefly explains the workflow folder (what `status`, `rug`, `arc`, ... are; why `deep_context/` and `memory/` exist). It draws on the audit files as a major source of inspiration but is not their replacement — onboarding-friendly, not bible.
- **Batch 2 (the original "archive whole files" batch) is effectively dropped.** The `deep_context/` files stay where they are. The `structure/` archiving is absorbed into the work around `structure.md`.
- **Batch 3 (status.md) is the priority today.** Status is the key file; it needs to be optimized. Specific guidance from the instigator:
  - The `Discussion of the next step` section is liked — it gives useful continuity between sessions. Keep.
  - The `Current Task + Next step` pattern is unproductive: the "current step" is necessarily stale by the time anyone reads it. Drop the pattern.
  - Finished work should find a different home — most naturally in `targets.md`, where each target gets a subsection journaling progress toward it.
  - Every section of `status.md` is open for discussion.

## Folder/file structure as of 2026-05-16 (post-Batch-1 snapshot)

```
workflow/
├── README.md                              onboarding map
├── status.md                              live state (under restructure — Batch 3)
├── motivation.md                          philosophical seed
├── arc.md                                 conjecture in cohesive vocabulary
├── targets.md                             T1–T7 propositions
├── conversation.md                        negative anchoring (corrections-against-defaults)
├── rug.md                                 postulate budget; differential-cohesion gap
├── related_structures.md                  adjacent frameworks
├── naming.md                              ♭/♯/ʃ + Allow/Mediate/Require vocabulary
├── deep_context/                          evolution journal (renamed from only_read_if_asked_to/)
│   ├── archived_post_concurrency_anchor_2026-05-16.md   ← this file
│   ├── concurrency_anchor.md                            load-bearing Concurrency-side reframe (renamed from b_anchor.md)
│   ├── plan_for_load_bearing_first_2026-05-13.md        divergent priority plan (probe T2/T1 before A-side); project rejected
│   ├── arc_discussion_log-2026-05-08.md                 session log from when arc.md was being formed
│   ├── misc_ideas_2026-05-07.md                         older locally-constant-sheaves exchange (renamed from ideas.md)
│   └── workflow_structure_audit_2026-05-15/             pre-restructure audit files (stale; moved here from workflow/structure/)
└── memory/                                symlink → ~/.claude/projects/-home-ig-Code-doc2cog/memory/
```

---

# Archived sections

Each section title below is the *original location* of the content in the pre-cleanup tree.

---

## /workflow/status.md:B-side (Concurrency)

(Three-line stub describing the Concurrency side as dormant, with stale references to the icosahedral framing and to T2/T4/T5 as the substantive scope. Superseded by the Concurrency-side reframe — see `deep_context/concurrency_anchor.md` and `status.md` "Discussion of the next step" for the live picture.)

> `agda/Concurrency/` holds a brand-new stub (`ThreePointedStruct`). The substantive scope — site choice on the icosahedrally stratified S², partition match with the A-side modalities, and the protocol-as-operational-cohesion reading — lives in `targets.md` (T2, T4, T5). Currently dormant; not gated by the A-side, just awaiting bandwidth.

(Note: `agda/Concurrency/` is in fact empty on disk — the `ThreePointedStruct` file the paragraph claims existed never did. The duplication audit flagged this in `workflow/structure/duplication_audit.md` §1.1.)

---

## /workflow/status.md:Current Task + Next step

(The "named-coefficient rung" task and its concrete next step. Migrated here because the Current Task + Next step pattern was found to be unproductive — the current task is necessarily stale by the time the next agent reads it. The substantive content has been folded into `status.md`'s ModalHoTT pause-note and into T7 Progress in `targets.md`.)

### Current Task (verbatim)

> **Post-pinning: named-coefficient rung of the de Rham depth ladder.** Pinning has landed (`flat-coefficients-factor-pin` in synthetic `FlatCoefficients.agda`, via `shape-flat-natural-B`). The arc target remains exhibiting something stateable in cohesive HoTT but not in plain HoTT. Next step on the synthetic side: postulate a cohesive type ℝ and instantiate the structural equivalence at B := ♭ℝ. See *Discussion of the next step*.

### Next step (verbatim)

> Draft `agda/ModalHoTT/Cohomology/NamedCoefficient.agda` (or similar) — postulate a cohesive type ℝ and apply `flat-coefficients-factor-pin` at B := ♭ℝ. Open design question: postulate ℝ as a bare type plus `IsFlatModal ♭ℝ`, or as a single bundled record. Propose before writing.

---

## /workflow/status.md:Decisions Log (full merged — Archived prepended to Relevant)

The full 21-row Decisions Log as it stood before today's split. Order: the 9 rows from "Decisions Log — Archived" (settled implementation notes / one-time choices / dead-end pruning), followed by the 12 rows from "Decisions Log — Relevant" (live decisions still shaping current work at the time of archival). The lightweight ModalHoTT-relevant subset (6 rows) lives in `status.md` under "Decisions Log — ModalHoTT".

| Date       | Decision | Rationale |
|------------|----------|-----------|
| 2026-05-06 | Concurrency stub named `ThreePointedStruct` | Name is structure-agnostic in case we switch from circle to sphere |
| 2026-05-07 | Added `flat-counit-intro` to Cohesion.agda | Missing β-rule for ♭ (holds definitionally in crisp-context HoTT); needed to derive IsFlatModal (♭A) |
| 2026-05-07 | Fracture theorem as next conjecture-directed file | Separation result is the arc target; fracture is the geometric backbone; all maps already available from existing files |
| 2026-05-07 | Two diagnostic findings from analytic Cohesion.agda | (1) flat-intro exists for ℤ but not for S¹ — confirms synthetic postulate is crisp-context over-approximation; (2) modal conditions on shape-rec/sharp-rec are vacuous for discrete types |
| 2026-05-07 | π₀ coincidence for (Bℤ, Bℤ) rejected | ‖Bℤ → Bℤ‖₀ ≃ ℤ ≃ ‖Bℤ → ℤ‖₀ is two separate computations sharing a common target, not a manifestation of the adjunction; no natural transpose connects the two sides |
| 2026-05-07 | ℤ-spaces dismissed as analytic model | PhD-scale infrastructure cost; misaligned with analytic folder's role and with the crisp-context design goal |
| 2026-05-07 | free-loop-space obstruction to be a named lemma in analytic Adjunctions.agda | (Bℤ → Bℤ) ≃ Bℤ × ℤ records where and why the adjunction breaks; uses loop-space-equiv; belongs in the file as an explicit obstruction witness |
| 2026-05-11 | `(Bℤ → ℤ) ≃ ℤ` recorded as a named lemma in analytic Adjunctions.agda | Companion to the free-loop-space obstruction; left side (Bℤ → Bℤ) ≃ Bℤ × ℤ, right side ℤ; pinpoints where the adjunction fails. Proof uses `isSetℤ` to force the loop on `translation-step` to refl |
| 2026-05-12 | Fracture postulated as `isEquiv (flat-to-pullback A)`, not bare `≃` | Pins the specific mediating map (workflow rule 4); a bare ≃ would let any equivalence count |
| 2026-05-12 | Fracture pullback type defined inline as Σ Σ ≡, not via a stdlib pullback type | Three lines; no import burden; the unfolded form is what the analytic ℤ proof needs (`isContrSingl` on the inner Σ) |
| 2026-05-12 | ♯-lex framed in synthetic Fracture.agda header (and Open Questions) as the meta-axiom that would derive `fracture` | Documents that `fracture` is a theorem in real-cohesive HoTT, not a deeper independent claim |
| 2026-05-06 | Synthetic/axiomatic approach | Site is semantic background only; modalities are postulated axioms, following Wellen/Myers/Shulman |
| 2026-05-06 | Site is Bℤ (semantic only, not an Agda type) | Delooping of ℤ foregrounds algebraic structure; intrinsic covering; cleaner for comonad story |
| 2026-05-06 | Cubical Agda | Actively maintained; HITs first-class; univalence built-in |
| 2026-05-06 | Long names over math notation in identifiers | e.g. `ThreePointedStruct`, `FlatModality` |
| 2026-05-06 | Shape/sharp use non-dependent recursion in Cohesion.agda | Dependent induction requires fiberwise modality conditions; deferred |
| 2026-05-06 | `flat-intro` postulated unconditionally | Agda lacks crisp-context support; noted in comment as a deviation from mathematical intent |
| 2026-05-06 | Drop `--safe` flag | `--safe` forbids `postulate`; axiomatic approach is inherently outside Agda's safe fragment |
| 2026-05-07 | Adjunctions stated as hom-set equivalences (`≃`), named operations defined from them | Hom-set form is the direct usable data; named operations are one-liner definitions, not extra postulates |
| 2026-05-07 | IsFlatModal (♭A) proved as theorem; IsSharpModal (♯A) and IsShapeModal (ʃA) postulated | ♭ has dependent induction (flat-ind); ♯ and ʃ idempotency derivation blocked on their dependent induction principles |
| 2026-05-07 | flat functoriality laws proved; ʃ/♯ map laws postulated | flat-ind gives full dependent elimination; ʃ/♯ laws blocked on same gap as idempotency |
| 2026-05-07 | Two-track development: agda/ (synthetic) + agda/analytic/ (analytic) | Postulates bypass Agda; analytic folder is where the proof checker verifies claims; acts as test suite and potential library contribution source |
| 2026-05-07 | Arc target fixed: separation result via de Rham / local-global cohomology | Most direct formalization of "cohesion is needed for praxis"; something naturally stateable in cohesive HoTT that is not in plain HoTT |
| 2026-05-07 | Analytic folder scoped to ℤ only; S¹ excluded | Site is Bℤ with ℤ foregrounded; S¹ would reintroduce the topological viewpoint deliberately set aside |
| 2026-05-07 | Analytic folder purpose reframed | Not "verify postulates in a model" but "demonstrate non-vacuity"; key result is ¬IsFlatModal-delooping; ℤ instances provide consistency sanity-check |
| 2026-05-07 | Type-level adjunction for (Bℤ, Bℤ) fails | (Bℤ → Bℤ) ≃ Bℤ × ℤ (free loop space); (Bℤ → ℤ) ≃ ℤ; Bℤ × ℤ ≇ ℤ. Our ♭(Bℤ) = ℤ is not the correct ♭ for any model where the adjunction holds at the type level. In Sh(Bℤ), the correct ♭(Bℤ) = Map(Bℤ, Bℤ) ≃ Bℤ × ℤ, and the adjunction holds there by currying |
| 2026-05-07 | Crisp contexts are the intended analytic validation path | The adjunction is built into the modal rules in crisp cohesive type theory (Shulman 2018, Myers); marked as future work. Agda --cohesion covers ♭ partially; ʃ and ♯ not supported maturely anywhere |
| 2026-05-07 | flat-map for Bℤ maps not derivable via the synthetic route analytically | Synthetic derivation uses flat-ind + flat-intro ∘ f; flat-intro does not exist for Bℤ (same obstruction as ¬-IsFlatModal-delooping). A winding-number construction exists but does not mirror the synthetic side |
| 2026-05-07 | Crisp contexts would unblock Bℤ flat-map in analytic Properties.agda | In crisp type theory, flat-intro is valid for crisp variables; flat-ind + flat-intro ∘ f goes through for crisp f : Bℤ → Bℤ by the same derivation as the synthetic side. Shape-map for Bℤ remains trivial (ʃBℤ = Bℤ); sharp-map remains deferred |
| 2026-05-14 | Pinning route is naturality in B, not the IsFlatModal ↔ IsShapeModal bridge | Bridge alone is not enough to derive the pinning equation (would still need ʃ-uniqueness or adjunction-naturality); naturality is the precise piece. One new postulate `shape-flat-natural-B`; four-step derivation chain. Discrete.agda drafted as a deferred reserve, not load-bearing. |

---

## /workflow/status.md:Completed (meta items)

The Agda-file Completed items have migrated to per-target Progress subsections in `targets.md`. One meta item remained:

- [x] Project scaffold and workflow files

---

## /workflow/arc.md:§5 Sites and folders (stale Concurrency bullet + trailing placeholder)

Original §5 header: `## 5. Sites and folders  → T2 (icosahedral site), T4 (partition match), T5 (protocol)`. The "icosahedral site" label on T2 is retired by the Concurrency-side reframe.

Stale bullet (original `agda/Concurrency/` line):

> - `agda/Concurrency/`  — candidate site (3-pointed sphere or related), develops SessionValues+ActorBase separation.

Replaced in `arc.md` with a pointer to `deep_context/concurrency_anchor.md`. The "3-pointed sphere or related" framing predates the under-layer reframe; the current commitment is an actor-causal site carrying Caires–Pfenning session-type values via sheaf, inside cubical sets.

Stale trailing sentence (placeholder TODO from when `arc.md` was first drafted, never filled in):

> Brief note on what kind of relation that functor must be.

Replaced with a single deferred-to-next-session note in `arc.md`.

---

## /workflow/arc.md:§8 What is left for discovery (3-pointed-sphere bullet)

Stale bullet:

> - Whether 3-pointed-sphere is the right Concurrency site or only a candidate.

Answered (no) by the Concurrency-side reframe in `deep_context/concurrency_anchor.md`. Replaced in `arc.md` with a pointer to `status.md` "Discussion of the next step" for the new level-2 sub-decisions (`_Site._Category` model, value category V, ∞-lift timing).

---

## /workflow/targets.md:T2 (Cohesion on A_5-equivariant icosahedral S²)

Full original target, retired with the icosahedral framing. Replaced in `targets.md` with a one-paragraph placeholder pointing at `concurrency_anchor.md` and `status.md` "Discussion of the next step".

> ## T2. Cohesion on A_5-equivariant icosahedral S²
>
> *Arc anchor: `arc.md` §5.*
>
> **Claim.** The ∞-topos of A_5-equivariant sheaves on the icosahedrally stratified S² (12 vertices, 30 edges, 20 faces, with the three orthogonal golden-rectangle sub-structure) carries a cohesive structure with explicit modalities `ʃ_G, ♭_G, ♯_G`.
>
> **To state cleanly.**
> - Pin down the site: A_5-orbit category of S², or the icosahedral cell complex with A_5 action.
> - Settle "3 inscribed golden rectangles" vs. "3 inscribed golden triangles" — the 12-vertex match wants rectangles.
> - Specify what the modalities should pick out (typed data via `♭_G`, unityped substrate via `♯_G`, interaction shape via `ʃ_G`).
>
> **To verify.**
> - Either: prove cohesion lifts (positive theorem, possibly stated for general finite G with A_5/icosahedron as worked case).
> - Or: identify the obstruction (negative result with explicit cause).
> - Either outcome is publishable in cohesive HoTT / equivariant ∞-topos theory.

---

## /workflow/targets.md:T3 (Lawvere fixed-point asymmetry between A and B)

Full original target. Replaced in `targets.md` with a placeholder; core intuition is durable, A_5-specific math anchor is retired.

> ## T3. Lawvere fixed-point asymmetry between A and B
>
> *Arc anchor: `arc.md` §6.*
>
> **Claim.** The A side is fixed-point-rich (idempotency `♭♭ ≃ ♭`, `ʃʃ ≃ ʃ`, `♯♯ ≃ ♯` — modal types are fixed points of their modalities). The B side is fixed-point-poor (A_5 simple and transitive on 12 vertices forces the A_5-fixed sub-object to be empty, blocking equivariant self-reference). The `Allow ⊣ Require` adjunction (T1) transports between these poles: Allow turns closed perspectival fixed-points into open A_5-orbited operation; Require reflects open operation into closed perspective.
>
> **To state cleanly.**
> - State the fixed-point property of A precisely: "every cohesive modality is idempotent; modal types are fixed-point sets of the modality acting on the topos."
> - State the no-fixed-point property of B precisely: equivariant endomaps on objects with empty A_5-fixed part have no equivariant fixed points; Lawvere applied contrapositively blocks self-referential closure.
> - Specify what "transport between poles" means in terms of unit/counit data of the adjunction.
>
> **To verify.**
> - Mechanically: idempotency proofs already exist on the synthetic side for `♭`; needed for `ʃ` and `♯` (currently postulated, see status.md open questions).
> - Compute A_5-equivariant fixed points on the 12-vertex set and on derived objects.
> - Show the adjunction's left and right images sit on opposite Lawvere poles.

---

## /workflow/targets.md:T4 (Hidden partition of A matches partition of B)

Full original target. Replaced in `targets.md` with a placeholder noting the ActorBase/SessionValues split is now structurally definitional in the hybrid; the protocol-shape slot still needs work.

> ## T4. Hidden partition of A matches partition of B
>
> *Arc anchor: `arc.md` §5.*
>
> **Claim.** The cohesive partition `ʃ / ♭ / ♯` of A mirrors a 3-fold partition of B: typed data ↔ `♭`, unityped agents ↔ `♯`, interaction shape (protocol topology) ↔ `ʃ`. The match is not coincidental — it is the same partition viewed on two sites linked by the T1 adjunction.
>
> **To state cleanly.**
> - Identify the third slot on the B side (channel / protocol / address space candidate); decide if it exists or if the partition is genuinely 2-fold on B with `ʃ` having no operational partner.
> - Specify "match" precisely: a functor between the two cohesive sites carrying each modality on one side to the corresponding modality on the other.
>
> **To verify.**
> - Construct the functor (likely a geometric morphism) between the ModalHoTT site (Bℤ) and the Concurrency site (icosahedral S²).
> - Check it intertwines the three modalities.

---

## /workflow/targets.md:T5 (Protocol as the operational reading of cohesion)

Full original target. Replaced in `targets.md` with a placeholder; depends on T2 and T4 (both archived); A_5-symmetry anchor retired.

> ## T5. Protocol as the operational reading of cohesion
>
> *Arc anchor: `arc.md` §5.*
>
> **Claim.** The "engineering protocol" — single way to interact, generating intricate structure with A_5 symmetry — is the operational form of the cohesive modalities on the Concurrency site. Not a new modality layered on top of cohesion, but cohesion read operationally rather than geometrically.
>
> **To state cleanly.**
> - Make "operational reading" precise: a translation from the cohesive modal data (objects, modalities, modal types) to the protocol's machinery (operations, participants, message types).
> - Specify the universal property: the protocol is the free/cofree object satisfying "single mode of interaction" within the cohesive structure.
>
> **To verify.**
> - Depends on T2 (cohesion on icosahedral S²) and T4 (partition match).
> - Once both hold: exhibit the operational translation as a theorem.

---

## /workflow/targets.md:Dependency sketch

Full original sketch. Replaced in `targets.md` with a placeholder noting T1 is still foundational and the site question for the Concurrency side has migrated to `concurrency_anchor.md`.

> ## Dependency sketch
>
> - T1 is foundational; T2, T3, T4, T5, T6, T7 all depend on it.
> - T2 is the load-bearing site question for B.
> - T3, T4, T5, T6 depend on T1 + T2 in various combinations.
> - T7 depends on T1 and on status.md's current work.
>
> T1 and T2 are the two primary targets. The rest are downstream.

---

## /CLAUDE.md:Directory Layout

Removed in Batch 7 — file inventories duplicate `ls` output and require constant re-maintenance every time anything moves. The actual folder/file structure is now the source of truth; consult it via `ls workflow/` and `ls workflow/deep_context/`.

> ## Directory Layout
>
> **Start with `workflow/README.md`** — onboarding map. It defines two reading paths: a **focused** path (read `status.md` and stop) for active tasks, and an **architecture** path (the files in `workflow/`) for orientation, reframing, or big-picture decisions. The architecture-path files are *not* loaded by default; consult them when `status.md` proves insufficient or when explicitly directed.
>
> ```
> agda/
>   ModalHoTT/           Synthetic (axiomatic) track — modalities postulated
>   Analytic/ModalHoTT/  Analytic (verification) track — demonstrates non-vacuity
>   AnalyticTest/        Reserved third track; see AnalyticTest/README.md
>   Concurrency/         B-side stub (dormant; ThreePointedStruct only)
> workflow/              Project management; read README.md first
>   README.md            Onboarding map (two reading paths)
>   status.md            Focused-path file: current state, live decisions, blockers
>   memory/              Symlink to Claude auto-memory for this project
>   motivation.md          Philosophical seed (the math is a subsystem of this)
>   arc.md                 Cohesive reformulation (Allow ⊣ Mediate ⊣ Require)
>   targets.md             T1–T7: concrete propositions decomposing the arc
>   conversation.md        Negative anchoring — defaults the project rejects
>   rug.md                 What's under the rug: shortcut postulates, gaps, horizons
>   related_structures.md  Adjacent frameworks (Connes, Bennequin/Belfiore/Laforgue)
>   naming.md              Modality vocabulary (♭/♯/ʃ)
>   only_read_if_asked_to/ Session-scoped working files (agent plans, discussion logs, anchor notes, ideas); not loaded by default
> ```

## memory/project_workflow_cleanup_2026-05-16.md (full file, archived 2026-05-16)

The cleanup-tracking memory entry, archived here in full once the cleanup it documented was completed.

```markdown
---
name: workflow-cleanup-2026-05-16
description: "Multi-batch workflow/ restructure in progress 2026-05-16. Batches 1, 3, 4, 5, 6, 7 done; batches 8 (A/B → ModalHoTT/Concurrency rename pass), 9 (memory propagation), 10 (README) pending. Post-cleanup: real Concurrency-side restatement work (T2–T5)."
metadata:
  node_type: memory
  type: project
  originSessionId: 7095595f-923a-49bd-8e20-a16c8f93be1e
---

A `workflow/` folder cleanup is in progress as of 2026-05-16, prompted by the bandwidth shift from ModalHoTT to Concurrency and the Concurrency-side reframe (icosahedral S² retired → actor-causal + Caires–Pfenning session-type values via sheaf, all inside cubical sets).

## What's done — Batches 1, 3, 4, 5, 6, 7

**Folder/file renames:**
- `workflow/only_read_if_asked_to/` → `workflow/deep_context/` (evolution journal, not standard onboarding)
- `workflow/deep_context/b_anchor.md` → `concurrency_anchor.md` (load-bearing Concurrency-side reframe)
- `workflow/deep_context/agent_plan_2026-05-13.md` → `plan_for_load_bearing_first_2026-05-13.md`
- `workflow/deep_context/ideas.md` → `misc_ideas_2026-05-07.md`
- `workflow/structure/` → `workflow/deep_context/workflow_structure_audit_2026-05-15/` (pre-restructure audit; stale, kept as historical artifact)

**Archive infrastructure:** `workflow/deep_context/archived_post_concurrency_anchor_2026-05-16.md` collects all cut content. Section titles take the form `/path/to/file:Section:Subsection`. Folder snapshot at top.

**Surgery applied:**
- **`status.md`** (~170 lines, was ~260): Concurrency / ModalHoTT subsections; "Current Task + Next step" pattern removed; full Decisions Log archived; lightweight 7-row ModalHoTT-relevant table kept; Completed migrated to `targets.md` T7 Progress; "Discussion of the next step" kept as live Concurrency scoping doc.
- **`targets.md`** (~163 lines): T2/T3/T4/T5 and Dependency sketch replaced with "to restate next session" placeholders pointing at `concurrency_anchor.md` and `status.md` "Discussion of the next step". T1 and T7 got Progress subsections. T7 absorbed the "Unlocking ♯" essay.
- **`arc.md`**: §5 header anchor stripped of "icosahedral site"; Concurrency bullet now points at `concurrency_anchor.md`; §8 "3-pointed-sphere" bullet replaced with pointer to status.md Discussion.
- **`rug.md`**: only the `of`→`or` typo on line 3. Instigator explicitly kept the "Discussion of the next step when the bandwidth was still on the modal side" section as a deliberate ModalHoTT-history breadcrumb (similar logic to the lightweight Decisions Log in status.md).
- **`CLAUDE.md`**: Current Phase rewritten (3 lines, bandwidth-shift framing); Directory Layout section *removed* (file inventories duplicate `ls`; archived).

**Concept renames (partial — full pass is Batch 8):**
- B1 / B2 → SessionValues / ActorBase across `motivation.md`, `arc.md`, `memory/b_side_site_icosahedral.md`.

## Batch 8 — broader A / B → ModalHoTT / Concurrency rename

**Approach: surgical, not wholesale. Propose per file before editing.** Some A/B uses are structural per-claim labels in math formulas (A = cohesion side; B = data-agents side); some are folder-side (`agda/ModalHoTT/`, `agda/Concurrency/`). The folder-side ones should become ModalHoTT/Concurrency; the structural ones may or may not, depending on whether prose or formula reads better with descriptive names. **Don't rewrite swathes — flag each occurrence and ask.**

Files with remaining A/B usage (`grep -n '\bA\b\|\bB\b\|A-side\|B-side' workflow/*.md` is the starting point):

- **`arc.md`**: §3 "between A (perspectives) and B = (SessionValues separated from ActorBase) (data-agents)"; §5 bullets `agda/ModalHoTT/ — site Bℤ, develops A.` and `agda/Analytic/ — analytic mirror for A; documents non-vacuity.`
- **`targets.md`**: T1 claim ("between A (perspectives) and B (data-agents)"); T6 claim ("A above B ... B above A"); T7 claim ("witness `A` alone"); Appendix title "flow leading to the B-side operational anchor" + body.
- **`naming.md`**: section header "cross-site adjoints between A and B".
- **`motivation.md`**: minimal — the math formula uses `A`, `SessionValues`, `ActorBase`. Decide whether to keep A as math-formula-label or rename for consistency.
- **`conversation.md`**: instigator quotes use "A side"/"B side". **Preserve as historical text** — that's the file's job (negative anchoring as historical record).
- **`CLAUDE.md`**: Convention 6 example `ThreePointedStruct` (the file never existed on disk) — swap to a real long-name example like `DeloopingOfIntegers` or `FlatModality`.
- **`status.md`**: a few residual `A` references in Open Questions (e.g., "Naturality of the adjunction bijections in A"). These are technically the per-claim label; possibly leave.

## Batch 9 — memory propagation

- **`memory/MEMORY.md`** index: a few entries use "A-side" / "B-side" — sweep.
- **`memory/b_side_site_icosahedral.md`** → rename to `project_concurrency_under_layer_reframe.md` (or similar). Content already captures the under-layer reframe; just the filename is stale.
- **`memory/feedback_independent_legs_then_bridge.md`**: uses "A and B" — sweep.
- **`memory/decisions_log_split.md`**: feedback-type without `feedback_` prefix; minor naming inconsistency flagged in the now-archived `duplication_audit.md`. Rename for prefix consistency, or leave.
- Other memory files: check `negative_anchoring.md` (mentions rejected defaults "modal HoTT vs HoTT" / "concurrency leg decorative" — fine, those are the rejections); `feedback_analytic_folder_structure.md` references `agda/ModalHoTT/` mirror — fine.
- Update `MEMORY.md` to point at the new entry (this file: `project_workflow_cleanup_2026-05-16.md`).

## Batch 10 — README.md

- Reflect new folder name `deep_context/` (currently mentions only `only_read_if_asked_to/` via outdated path).
- Typo fix: `"you my ask the instigator"` → `"you may ask"` (line 7).
- Slim/clarify the "Structure of context path" subsection title — currently confusing.

## What should be done after the cleanup

The real Concurrency-side work. Cleanup is preparation; this is the substance:

1. **Restate T2, T3, T4, T5** against the actor-causal + session-type-values hybrid. The placeholders in `targets.md` point at `deep_context/concurrency_anchor.md` and `status.md` "Discussion of the next step"; both need refining first, then fold durable content into proper target statements.

2. **Decide `_Site._Category`.** Proposal in `status.md` Discussion: Lamport partial-order (low cost; monotonic-enrichment toward event-structures; Lorentzian as long-horizon regulative principle). Escape clause if a Concurrency-side claim needs event-structures as primitive.

3. **Decide V — value category for `_Sheaf`.** R1's hinge per `status.md` Discussion. Set / Cat / `_Algebra._SyntacticCategory` itself. Status flags this as the most urgent unresolved decision after `_Site._Category`.

4. **Then first Agda file** on the Concurrency side. Likely `agda/Concurrency/_Site.agda` (Lamport partial-order as Grothendieck site). `agda/Concurrency/` is currently empty.

## Workflow conventions reinforced this session

- **Stepwise: propose → discuss → apply.** Never apply before discussing. Already covered in `feedback_propose_first` memory; reinforced here.
- **Don't duplicate `ls`.** File inventories / structure docs that mirror the actual folder become a maintenance treadmill. Cut. The folder is the source of truth.
- **Placeholders + notes-for-next-session > writing new content during cleanup.** New content is for after the dust settles.
- **Some ModalHoTT context stays visible.** Lightweight Decisions Log in `status.md`; the ModalHoTT-history section in `rug.md`. The Concurrency-focused agent still needs orientation about what landed on ModalHoTT and why.
- **Established naming**: A → ModalHoTT, B → Concurrency, B1 → SessionValues (typed data / session types), B2 → ActorBase (unityped agents / actor model).

## Pointers (load-bearing files)

- **`workflow/deep_context/concurrency_anchor.md`** — canonical Concurrency-side reframe. **Required reading** for any Concurrency work.
- **`workflow/deep_context/archived_post_concurrency_anchor_2026-05-16.md`** — everything cut from workflow/ on 2026-05-16. Section titles = original locations.
- **`workflow/status.md`** "Discussion of the next step" — live Concurrency scoping (level-2 module inventory `_Site / _Algebra / _Sheaf / _Topos`, structuring relations R1–R6, Lamport proposal for `_Site._Category`, V as the next-most-urgent decision).
- **`workflow/targets.md`** — T1 and T7 carry current Progress subsections. T2/T3/T4/T5 are placeholders pending restatement.

See related: [[b-side-under-layer-reframe-icosahedral-retired]] (the project memory entry that this cleanup operationalised), [[de_rham_depth_ladder]] (still load-bearing for ModalHoTT-side context), [[feedback_propose_first]] (the stepwise convention that shaped this session).
```
