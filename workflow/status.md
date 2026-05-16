# Project Status

The arc is articulated in `arc.md` (the cohesive reformulation, with the `Allow ⊣ Mediate ⊣ Require` triple) and decomposed into propositions T1–T7 in `targets.md`. Philosophical seed in `motivation.md`.

Bandwidth has shifted from the ModalHoTT side (the formal-foundation leg) to the Concurrency side (the community-of-agents leg, dual conjecture). ModalHoTT work is on pause at the de Rham named-coefficient rung; Concurrency work is in the scoping phase after a major reframe — canonical source `deep_context/concurrency_anchor.md`, live level-2 inventory in "Discussion of the next step" below.

## Concurrency

Post-reframe scoping. The operational anchor is an actor-causal site (GR-inspired Hewitt locality) carrying Caires–Pfenning session-type values via a sheaf, all inside cubical sets — see `deep_context/concurrency_anchor.md`. Level-2 module inventory (`_Site`, `_Algebra`, `_Sheaf`, `_Topos`) and structuring relations R1–R6 sit in "Discussion of the next step" below. No Agda yet; `agda/Concurrency/` is empty.

## ModalHoTT

On pause at the de Rham named-coefficient rung. Synthetic-side fracture and structural pinning have landed; analytic mirror is bounded by `♯(Bℤ)` undefined (see T7 Progress in `targets.md` for the file-level state). Postulate budget catalogued in `rug.md`. When bandwidth returns: postulate a cohesive ℝ and instantiate the structural equivalence at `B := ♭ℝ`.

## Semantic Background — ModalHoTT (Bℤ)

**The site is Bℤ — the delooping of ℤ.** This is the intended semantic model justifying the cohesion axioms. It does not appear as an Agda object; it lives here as documentation. Bℤ ≃ S¹ as ∞-groupoids, but we foreground the group structure of ℤ because: the intrinsic covering structure comes from subgroup inclusions nℤ ↪ ℤ; the comonad story connects cleanly to ℤ-actions; and Lawvere's fixed-point theorem is most natural in the algebraic/discrete setting ℤ provides.

## Semantic Background — Concurrency

The site is the actor-causal + session-type-values hybrid (see `deep_context/concurrency_anchor.md`). A self-contained restatement parallel to the Bℤ paragraph above is future work — not blocked, not drafted.

## Analytic Development — ModalHoTT

`agda/Analytic/` mirrors the synthetic structure but contains no postulates. Its purpose is to **demonstrate non-vacuity**: show that the synthetic postulates are consistent and that ♭ draws a real distinction between types. It is not a full verification of the postulates in an external model — that requires genuine cohesive type theory (crisp contexts; see archived Decisions Log).

The centrepiece result is `¬-IsFlatModal-delooping` in `Analytic/ModalHoTT/Modalities/Cohesion.agda`: machine-checked proof that Bℤ is not flat-modal. This is the strongest claim the analytic folder can make without cohesive type theory infrastructure.

For the adjunctions, only ℤ instances are verifiable in plain cubical Agda (all modalities are identity; adjunctions are reflexivity). The type-level adjunction for non-discrete types is out of scope here; see `Adjunctions.agda` for the diagnosis and the intended future path.

A further split is reserved: `agda/AnalyticTest/` (currently README only) is the third track, for what the mirror cannot carry — a concrete computable model where the cohesion modalities have non-trivial content (candidate: ℤ-Sets / presheaves on Bℤ, externally). It activates once the synthetic-side postulate signature stabilises; differential-cohesion content is also deferred there. See `AnalyticTest/README.md`.

**Library contribution goal (downstream):** Postulate-free, general results from the analytic folder are candidates for contribution to the cubical Agda library, which has no cohesion module. Write for the test suite first; if results come out clean and general, contribute. Do not let this target slow development.

## Analytic Development — Concurrency

Future work. Whether the mirror / test-suite pattern from the ModalHoTT side transfers depends on the Concurrency-side base implementation.

## Decisions Log — ModalHoTT

Lightweight subset — the load-bearing methodological choices. Full merged table (Relevant + Archived, 21 rows) preserved under `/workflow/status.md:Decisions Log` in `deep_context/archived_post_concurrency_anchor_2026-05-16.md`.

| Date       | Decision | Rationale |
|------------|----------|-----------|
| 2026-05-06 | Synthetic/axiomatic approach | Site is semantic background; modalities postulated, following Wellen/Myers/Shulman |
| 2026-05-06 | Site is Bℤ (semantic only, not an Agda type) | Delooping of ℤ foregrounds algebraic structure; intrinsic covering; cleaner for the comonad story |
| 2026-05-06 | Cubical Agda | Actively maintained; HITs first-class; univalence built-in |
| 2026-05-06 | Drop `--safe` flag | `--safe` forbids `postulate`; axiomatic approach is inherently outside Agda's safe fragment |
| 2026-05-07 | Two-track development: synthetic (`agda/ModalHoTT/`) + analytic (`agda/Analytic/`) | Postulates bypass Agda; analytic is where the proof checker verifies; test suite + potential library contribution |
| 2026-05-07 | Arc target fixed: separation result via de Rham / local-global cohomology | Most direct formalization of "cohesion is needed for praxis"; something naturally stateable in cohesive HoTT, not in plain HoTT |
| 2026-05-07 | Crisp contexts are the intended analytic validation path | Adjunction is built into the modal rules in crisp cohesive type theory (Shulman 2018, Myers); marked as future work |

## Open Questions — ModalHoTT

- [ ] Dependent induction for ♯ and ʃ (fiberwise modality conditions needed); would unlock deriving `IsSharpModal (♯A)`, `IsShapeModal (ʃA)`, and all four postulated map laws in `Properties.agda` as theorems.
- [ ] Naturality of the adjunction bijections in A; naturality of `flat-sharp-transpose` (♭ ⊣ ♯) in either variable. (Naturality of `shape-flat-transpose` in B is now postulated as `shape-flat-natural-B` in `Properties.agda` — load-bearing for the structural-pinning derivation.)
- [ ] `shape-map-id`, `shape-map-comp`, `sharp-map-id`, `sharp-map-comp` postulated in `Properties.agda`; same blocker as above.
- [ ] Missing bridge: `IsShapeModal` and `IsFlatModal` are defined independently but should pick out the same class of types (the discrete types) in any cohesive model. Drafted in `Discrete.agda` (both directions postulated) but **held in reserve / not imported**. The intended pinning route turned out to need adjunction naturality instead; the bridge remains independently motivated and will matter for ♯-side work.
- [ ] Missing monad/comonad structure: comultiplication δ : ♭A → ♭(♭A), multiplication μ : ʃ(ʃA) → ʃA, and the corresponding structure for ♯. These follow from idempotency by abstract nonsense and are trivial in the idempotent case, but are currently unnamed. Defer until something concretely needs them.
- [ ] `agda/Analytic/toy/` branch — a thorough construction of the synthetic structure using more pinpointed instances for the higher structures we work with. Alternative to the current ℤ-only analytic track; would broaden what gets verified without requiring full crisp-context support. Deferred.
- [ ] ♯ as a lex modality (preserves finite limits) — would turn `fracture` from a postulate into a theorem; deferred along with crisp contexts since the analytic side of ♯ is blocked anyway.
- [ ] Naturality of the fracture equivalence in A — currently postulated as a bare `isEquiv` on the canonical map; naturality in A is what would let fracture commute with constructions on diagrams (e.g. differential cohomology pullbacks). Same shape as the existing adjunction-naturality entry; defer until a downstream use forces it.

## Open Questions — Concurrency

Live scoping is in "Discussion of the next step" below. Discrete open questions will land here once Concurrency-side files exist.

## Blockers

None currently. Note: cubical library uses infective flags (`--guardedness`); every file must mirror them in its OPTIONS pragma.

## Discussion of the next step

*Live scoping doc for the Concurrency side. The level-2 inventory and structuring relations below carry forward between sessions; the "Final comment" at the end is the current sub-decision queue. Will eventually migrate into a proper Concurrency arc/targets restatement once the work has stabilised.*

### Concurrency-side module inventory (level-2 zoom)

Level 1: `_Site`, `_Algebra`, `_Sheaf`, `_Topos`. (Causality was previously listed as a fifth module; demoted — see comments.)

#### `_Site`

Canonical decomposition — math forces it: a Grothendieck site *is* a small category + a topology.

- `_Site._Category` — objects (actor-groupings / frames / configurations), morphisms (causal extensions / refinements).
- `_Site._Topology` — which families count as covers (local-frame coverings).

Interpretive piece: what fills `_Site._Category`'s objects and morphisms — the Lamport / event-structure / Lorentzian sub-decision (deferred per `concurrency_anchor.md`).

#### `_Algebra`

Interpretive but with a natural three-part shape — a logical theory plus its categorical packaging.

- `_Algebra._Connectives` — the type constructors (⊗, ⅋, &, ⊕, !, ?, ⊸, units).
- `_Algebra._Proofs` — sequent rules and proof terms; cut-elimination = communication semantics lives here.
- `_Algebra._SyntacticCategory` — the categorical form (star-autonomous / polycategory); the piece that talks to `_Sheaf`.

Duality (A ↔ A^⊥) cross-cuts all three — a symmetry on the whole, not its own sub-module.

#### `_Sheaf`

Canonical decomposition (a sheaf is a presheaf satisfying descent), plus one open question.

- `_Sheaf._Presheaf` — assignment of a value-object to each site-object, with functoriality on morphisms.
- `_Sheaf._Descent` — the gluing condition for covers from `_Site._Topology`.

Open, math-side: the **value category V**. Set, Cat, `_Algebra._SyntacticCategory` itself? "Sheaf of session-types" needs V to be at least a 2-category or richer (flagged in `concurrency_anchor.md`). Tracked as its own item, not hidden inside `_Sheaf._Presheaf`.

#### `_Topos`

Canonical first three pieces, plus a cohesion-adapted fourth.

- `_Topos._SheafCategory` — Sh(`_Site._Category`, `_Site._Topology`) as an object.
- `_Topos._InternalLogic` — subobject classifier Ω, internal language, predicates.
- `_Topos._GeometricMorphisms` — relations to other topoi (in particular: the embedding into cubical sets, the shared substrate with ModalHoTT).
- `_Topos._InfinityLift` — the 1-topos → ∞-topos move. Not in the classical decomposition; needed because the ModalHoTT-side cohesion lives in an ∞-topos.

`_Topos._InfinityLift` is where the "Winskel is 1-categorical, we want ∞-categorical" caveat from `concurrency_anchor.md` actually lives.

### Comments

- **What this zoom-in surfaced.** Two cleanups to the level-1 inventory:
  - **Causality demoted.** Previously listed as a fifth module, it isn't really top-level — it's the parameter that fixes both `_Site._Category`'s morphisms (what counts as a causal extension) and `_Site._Topology`'s covers (what counts as local). Re-tagged as "the choice that determines `_Site`."
  - **Value category for `_Sheaf` promoted to a tracked item.** It's the technical hinge between `_Algebra` and `_Sheaf`, and likely where the hybrid proves harder than the conceptual sketch suggested.

- **Canonical vs interpretive.** `_Site` and `_Sheaf` decompose canonically; `_Algebra` and `_Topos` are partly interpretive (which connectives, which topos features foregrounded). Worth flagging because the canonical pieces are where math will push back if we get it wrong; the interpretive pieces are where the project's framing actively shapes the construction.

- **Is causality a modality on `_Site`?** Yes, in two distinct senses worth keeping separate:
  - **Meta-modality on building `_Site`** — a reflective operation carving "sites with causal structure" out of an ambient of unstructured small-category-plus-topology pairs. Idempotent, picks out a sub-class — modal in shape, one level *up* from the cohesive modalities ♭/♯/ʃ which act on types inside the topos.
  - **Modalities induced on `_Topos`** — once `_Site` is fixed with causality, the resulting topos's internal logic carries modal operators like "causally-before X" or "concurrent with X" on Concurrency-types. These are at the right level — comparable to ♭/♯/ʃ — and may be where part of T4's modal partition actually originates on the Concurrency side.

  The two pull in different directions for what we want Concurrency to give us.

### Structuring relations (level-2 zoom)

Complement to the inventory: six relations that constrain how the modules can be filled in. Useful as a checklist when any single-module decision threatens to ripple.

- **R1 — Valuation.** `_Sheaf` takes values in V; V drawn from `_Algebra._SyntacticCategory`. The sheaf functor F: `_Site._Category`^op → V. Choosing V is the technical hinge between `_Algebra` and `_Sheaf`.
- **R2 — Indexing.** `_Sheaf` lives over `_Site`: presheaf + descent against `_Site._Topology`. Both pieces of `_Site` feed in; descent is the load-bearing half.
- **R3 — Generation.** `_Topos` = Sh(`_Site._Category`, `_Site._Topology`). No freedom in this step; the topos is generated from site + sheaves.
- **R4 — Interpretation.** `_Topos._InternalLogic` ↔ `_Algebra._Connectives`. Topos logic is cartesian by default; `_Algebra` is linear. The compatibility (or its principled absence) is its own piece of work — not automatic from the construction.
- **R5 — Embedding.** `_Topos._GeometricMorphisms` → cubical sets. Concurrency's topos sits inside the shared substrate; the mathematical form of "ModalHoTT and Concurrency share an ambient" (per `concurrency_anchor.md`).
- **R6 — Parametrization.** Causality → `_Site`. Constrains both `_Site._Category` (which morphisms count as causal) and `_Site._Topology` (which families count as local-frame covers).

**Most load-bearing:** R1 (Valuation) and R4 (Interpretation). R1 is the *technical* hinge — it determines whether the construction even type-checks. R4 is the *conceptual* hinge — it determines whether the topos's logic and the algebra's logic agree. A decision at any level-2 question will propagate through at least one of these two.

### Final comment

`_Site._Category` — proposal. Three options from `concurrency_anchor.md`:

| Option | Cost | Payoff |
|---|---|---|
| Lamport partial-order | low — direct in cubical Agda | gives covers as downsets; standard categorical form |
| Event-structures (Winskel-adjacent) | medium — more scaffolding | unlocks Winskel's open-map / presheaf-topos work directly |
| Lorentzian / sheaf-on-causal-manifold | high — needs manifold infrastructure we don't have | most GR-faithful |

Commit to **Lamport partial-order**, with event-structures held as the first refinement target, and Lorentzian as a long-horizon regulative principle (the shape the construction aspires to without committing to). Reasoning:

- Lamport is the simplest commitment that already produces a Grothendieck topology with the right covering structure — covers are families of downsets whose union is a downset.
- It's a degenerate case of event-structures, so refining later doesn't throw work away — it's monotonic enrichment.
- Formalizable in cubical Agda with no external libraries beyond what we already use.
- The "perspectives-at-scales" covering structure (the topology-first check from `concurrency_anchor.md`) lands cleanly: actor-subgroups → downsets covering the global view.

Escape clause: if at any point a Concurrency-side claim needs the concurrency-structure of event-structures (concurrent events as a primitive, not derived from "incomparable in the order"), we promote.

Other crucial same-level questions, in priority order:

1. **V — the value category for `_Sheaf`** (R1's hinge). Set? Cat? `_Algebra._SyntacticCategory` itself? Pins down R1 and constrains the next three. Most urgent — `_Sheaf` doesn't even type-check until V is chosen.
2. **`_Topos._InfinityLift` timing.** 1-categorical first then lift, or ∞-native from the start? Affects all of `_Topos._*`. The ModalHoTT side commits to ∞ via cubical sets, so 1-cat-first means a future lift step.
3. **`_Algebra._Connectives` scope.** Full Caires–Pfenning (multiplicative + additive + exponential), or multiplicative-only first? Downstream of V — but worth flagging now because connective scope determines what session-type structures we can express.
4. **`_Algebra._SyntacticCategory` form.** Star-autonomous / polycategory / multicategory? Also downstream of V.

(1) is the one to press on next, immediately after `_Site._Category` lands. (2) is structural-conceptual — worth a deliberate decision soon but doesn't block (1). (3) and (4) fall out once V is committed.

## Workflow update - current status