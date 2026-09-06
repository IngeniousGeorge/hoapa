# Future Work

All aspects of the code that will need to be completed or corrected if we want to present it.

## Reader's note

This file documents three kinds of future work, in three styles:

- *Punchlist style.* The "Regarding X" sections (fracture, T_recursion iteration, Sessions, actor-causal site, Hybrid v1, Beyond fracture) catalogue deferred pieces *inside material that has already shipped*. They are item-by-item, code-grained, and read as ongoing maintenance / extension lists.
- *Architectural style.* The "Concurrency-side layers of complexity (planned)" section catalogues *committed-but-unshipped* layers. It is prose-heavy, structured around a Function / Math anchor / Trigger / Open questions / Agda slot rhythm, and is calibrated to be readable by both future Claude/Codex agents picking up the project and humans being shown the work.
- *Candidate-investigation style.* The provenance, no-leak theorem ladder, Reality, and logical-presentation sections record structures whose absence or possible role has become visible but whose exact mathematical ownership is not settled. They state the motivating gap, nearest established mathematics, anti-overclaim discipline, falsifying tests, and decision gates. They do not alter the committed cascade or reserve implementation modules.

All three styles are honest about status. Punchlist items extend shipped material; architectural items are committed but unshipped; candidate investigations may be promoted, revised, split, or rejected after their naturality tests.

For the seed-level commitments these entries extend, see `motivation.md`. For the propositional decomposition (T1–T_recursion) they realize, see `arc.md` and `targets.md`. The implementation track — a real protocol kernel, a real verification runtime, LLM-tooling integration — is a separate concern tracked canonically in `workflow/status_implementation.md`; this file keeps only cross-references and future-work implications.

Status snapshot, 2026-09-06: the point-generated R4 theorem is banked; runtime contract loop 1, 2S per-conversation locality, coverage and order comparison, 2S Tier A raw actor-renaming invariance, and the 3R recorder are closed and green. Tier A landed at `5670658`; both authoritative fixtures are in the corpus and replay green through the recorder. No next lane has been selected. The nearest 2S continuation is change of actor base and realized-frame equivalence; 1C and 3R retain independent choices recorded in the status files. Active next steps live in `workflow/status_formal.md` and `workflow/status_implementation.md`.

## Regarding fracture

- flat-intro is unconditionally postulated — should be crisp-context-only. The codebase already flags this (Cohesion.agda comment, memory note). In our intended analytic interpretation it's
known to be too strong: ¬-IsFlatModal-delooping directly contradicts having flat-intro : Bℤ → ♭(Bℤ) with ♭(Bℤ) = ℤ. So the synthetic axiomatization commits to more than the analytic model
can deliver. Not a contradiction in synthetic-land (synthetic land never names ♭(Bℤ) concretely), but a documented over-approximation.
- The hom-set adjunctions are postulated at type level. Diagnostically known to fail at (Bℤ, Bℤ) in the analytic model: (Bℤ → Bℤ) ≃ Bℤ × ℤ but (Bℤ → ♯Bℤ) is forced to ℤ once ♯ is identified
naively. Same over-approximation pattern.
- fracture itself. In real-cohesive HoTT it is a theorem (♯ is lex → ♭ preserves finite limits → fracture). We shortcut to the conclusion without taking on ♯-lex as a separate axiom. So
fracture is a consequence of axioms we haven't formalized but which are known to hold in the published model.
- ♯/ʃ idempotency and map-laws postulated rather than derived; same gap (no dependent ♯/ʃ-induction in Agda).

  *Resolution path.* Postulate `shape-ind` and `sharp-ind` in the same shape as the existing `flat-ind`, then derive the idempotency theorems and the four map-laws on top. Stable extension of the existing pattern, not scaffolding-to-be-replaced — the principles survive intact as primitives in any future Agda implementation that supports ♯/ʃ natively, and the derivations on top stay identical. Cost: 2–4 new postulates (induction principles + β-rules) drawn from Wellen / Myers / Shulman, no new model-level commitments. Character: quality improvement (postulates → theorems), not arc-shaping; narrow background maintenance.

  *Architectural alternative.* Migrating the synthetic axiomatization from Wellen-style independent postulates to Rijke–Shulman–Spitters-style "subuniverse of modal types" with uniform induction would subsume this work — but would also restructure the existing `flat-ind`-based derivations. A category-shaped change, not piecewise; separate future call.

- Analytic test is weak. ℤ collapses everything to identity, so the analytic file doesn't exercise the postulate — it confirms non-vacuity in the degenerate case only. The case that would
test the postulate (Bℤ) is exactly what we cannot reach analytically. So fracture has been verified where it is trivial and asserted where it is interesting.

### Verdict

Fracture is trustworthy as a *postulate-relative theorem in an axiomatization known to be sound in real-cohesive HoTT* (Shulman 2018, Wellen, Myers). It is **not** trustworthy as a *plain HoTT* theorem; it is not even a derivation from the cohesion postulates we've stated — it is an added axiom we justify by citation. The analytic verification confirms the postulate's non-emptiness, not its non-trivial content. The biggest single risk lever in the chain is `flat-intro`, not `fracture`. Internal coherence is what Agda checks (no type errors, well-formed dependencies); soundness in any external model is an imported assumption.

A useful frame: we are building a *consistent axiomatic stance* and naming the geometric objects it commits to. The proof-checker confirms internal coherence; soundness comes from citation, not from our own work.

## Regarding T_recursion iteration

`formal/ModalHoTT/Modalities/Iteration.agda` lands the endofunctor-and-unit scaffold for T_recursion on the modal side: iteration `T^n`, iterated unit `η^_n`, operadic associator `η^-coherent` (derived from a postulated `η-naturality`), and the developing-network type `ND A` as the sequential colimit of `A → TA → T²A → …`. Despite the module's historical generic-adjunction wording, its interface does not yet bundle a counit, multiplication, or triangle identities. `formal/ModalHoTT/Modalities/IterationCohesion.agda` provides the checked collapsing control at ʃ ⊣ ♭: `η-equiv-at-T : T A ≃ T(T A)`, with `η-equiv-fst` identifying its forward map as the iteration structure map. This control constrains the search space for T3; it is evidence neither for nor against the cross-site conjecture.

Pieces deferred:

- **Dual on the concurrency side.** A symmetric module would iterate the *counit* of the comonad `L ∘ R` on the target side, taking the *limit* of a decreasing tower `… → M²B → MB → B`. Not written yet because: until the cross-site adjunction `Allow ⊣ Require` is stated and `ND` has non-trivial content, the dual is a duplicate of an empty scaffold. The 1=2 identity is conjecturally the equivalence between the modal colimit `ND A` and the concurrency limit `ND_B (L A)` via the adjunction — stateable only once both halves exist. Revisit only after the modal-context category `M` and the cross-site functors have been constructed or responsibly postulated behind their existing gates.

- **Cyclic-operad involution.** The 1=2 perspective-swap "cared-for = caregiver" would be a path constructor (or separate HIT) on top of `SeqColim`, encoding that the iteration is cyclic / self-dual on each level. Deferred for the same reason as the dual: adding the involution to a scaffold that hasn't yet produced non-trivial iteration content is premature.

- **`η-naturality` postulate.** Load-bearing for `η^-coherent`. Same shape and same resolution path as `shape-flat-natural-B` in `Properties.agda` — becomes a theorem once adjunction-naturality is recorded (status_formal.md Open Questions). Not new scope; folds into the existing naturality gap.

- **Full sequential-colimit convergence.** Applying `η-equiv-at-T` at each later iterate shows by induction that all structure maps after stage one are equivalences. The mathematical conclusion `ND A ≃ T A` is therefore known; what remains is formalization, not an open mathematical question. It requires a "convergent sequence has colimit at the convergence point" lemma against cubical's `Sequence` / `SeqColim` infrastructure (`Cubical.Data.Sequence.converges`). This is straightforward but heavier than the checked step lemma and should return only if a downstream use forces it (for example, a comparison with the dual on the concurrency side).

## Regarding Sessions and the canonical O_1 action

`Concurrency/Algebras/Sessions.agda` v1 landed with the `O_1` action (`gen`, `plug`, `shift`) packaged as explicit data rather than derived from the current categorical structure. This is the right current shape. The present `StarAutonomous` signature is intentionally thin: it has tensor, unit, braiding, duality, and local iso laws, but not the closed/evaluation structure or coherence needed to construct interaction composition canonically.

What shipped: a `SessionO1Action` record containing `gen-morph`, `plug-morph`, `shift-morph`, and the six laws mirroring `O`'s path constructors. `Sessions.agda` constructs `Valuation` and `OperadAlgebra` from that action, defines `session-interp` by HIT recursion, and names both R8 faces: syntactic `dual-involutive` and categorical / operadic `boundary-swap-at-gen`. This is better than loose postulates and does not pretend the action is intrinsic to session syntax alone.

The eventual quality target is stronger: replace the action assumption with a canonical definition from categorical/session structure. That should come back as a priority when the project reaches a richer session-category phase, after enough hybrid integration clarifies what the value-category morphisms mean operationally, but before serious `MO_1` / modular-envelope work.

Expected ladder:

1. **Done:** split the Sessions layer. `SessionSyntax.agda` now owns the
   postulate-free object grammar, `SessionMorphismSyntax.agda` owns the
   set-truncated morphism HIT, and `Sessions.agda` packages the remaining
   explicit `SessionO1Action` assumption.
2. **Done:** build the Sessions-to-target realization. `SessionObjectModel.agda`
   defines `J0`, `J0-dual`, `J1`, and the underlying Cubical functor; the
   `Chu(SET,Bool)` instance lives in `SessionChuModel.agda`.
3. **Done at finite-descent, finite sheaf-category, point-generated R4, and
   Chu-coefficient level:** Hybrid integration now has arbitrary-frame
   `FramePresheaf` / `SessionPresheaf`, zero-postulate separatedness,
   category-generic finite products, finite frames/covers, category-generic
   finite event-product descent, the constant-slot Sessions sheaf, proof-level
   tiny finite-cover validation, the V-valued finite sheaf/value category, and
   the framework-at-`SET` finite sheaf category with a concrete Set
   event-product object. The finite Coverage/library comparison has landed,
   and R4 now has the Benton/LNL presheaf bridge, right-adjoint sheaf
   preservation, a finite-sheafification interface, a conditional full
   finite-site sheaf-level adjunction, the point-generated supported reflector,
   the point-generated supported bridge `Lpoint ⊣ Rpoint`, and a concrete
   `Chu(SET,Bool)` coefficient witness.
4. Richer session category: add proof terms or an equivalent categorical
   semantics, cut as composition, cut-elimination/equality, closed
   structure/evaluation, and enough tensor/braiding coherence to manipulate
   long tensor strings.
5. Canonical `O_1` action: define `SessionO1Action` rather than assume it.
   `shift` should come from coherent cyclic permutation of tensor factors;
   `plug` should come from closed/evaluation/cut structure composing two
   morphisms into the dualizing object.
6. Only then push hard on `MO_1`: extend the canonical `O_1` action toward
   self-gluing / conversation-promotion / modular closure.

Practical trigger: when the session target can state and use an evaluation/cut map of the form `eval : Hom ((A ⊸ B) ⊗ A) B` (or the equivalent polycategorical/sequent form) and can coherently rotate tensor factors, the deferred derivation of `gen`, `plug`, and `shift` should return to the top of the concurrency queue.

## Regarding the actor-causal site

`Concurrency/Sites/{ActorBase,ActorCausal}.agda` v1 landed the R6 locality leg: opaque unityped actors, Lamport-style event causality, actor-local frames, strict-reflecting `FrameHom`, basis-form covers, `sieve-of`, generic identity / transitivity cover constructions, and constructive tiny frame/cover witnesses. `TinyActorBase.agda` now owns the postulate-free two-actor base, and `TinyActorCausalSite.agda` assembles the bundled tiny site using `ActorPullback.agda`'s constructed stability path. The actor-causal site no longer contains a real project postulate.

Pieces deferred:

- **Full-site pullback / stability presentation.** `ActorPullback.agda` gives the generic pullback frame construction and `stability-cover-pullback`, and the bundled tiny site now uses that constructed path. What remains deferred is not a legacy fallback but the broader presentation work: decide when the non-finite actor-causal site needs a full generated-sieve Grothendieck topology rather than the current basis-form `Cover` plus `sieve-of` bridge.

- **E2 sieve / Grothendieck topology presentation.** On the finite subsite, the library-site presentation has landed: `FiniteBasisCover` strips finite covers to base-stable covering-family data, `FiniteFrameCoverage` gives a Cubical `Coverage` over `FiniteFrameCategory`, and `SetSheafComparison` proves the SET sheaf-condition agreement. For the full non-finite actor-causal site, `Cover` remains basis-form and `sieve-of` remains the bridge artifact; add a full generated-sieve topology only when a later construction needs the non-finite site.

- **Promotion morphism class.** Strict `FrameHom` reflection deliberately prevents quotienting or reifying a sub-conversation as a single event / actor. The conversation-as-actor move belongs to a future promotion morphism class, coordinated with `MO_1` and the program-verification / conversation-of-conversations track.

- **Richer concrete site witnesses.** The bundled Bool tiny-site is now postulate-free. Future witnesses should add genuinely richer actor/event/causality shapes, not merely re-prove the two-point case.

## Regarding Hybrid finite descent, finite sheaf categories, and next sheaf steps

`Concurrency/Hybrid/{Presheaf,SessionPresheaf}.agda` remains the arbitrary-frame adapter layer: generic restriction along `FrameHom`, zero-postulate separatedness as a property, and constant Sessions witnesses. The fast-track finite layer is now separate, stronger, and category-generic:

- `Concurrency/Algebras/CategoryApplicative.agda` gives the applicative-law view of any Cubical `Category`; `StarAutonomousCategory.agda` remains the adapter from the thin session value-category signature to Cubical `Category`.
- `Concurrency/Algebras/FiniteProducts.agda` is now finite products over an arbitrary Cubical `Category`; `SetFiniteProducts.agda` instantiates it at `SET`.
- `Concurrency/Sites/FiniteFrame.agda`, `FiniteFrameCategory.agda`, and `FiniteCover.agda` define the finite-frame subsite as a Cubical `Category` and finite covers with carried overlap enumerations.
- `Concurrency/Sites/FramePullbackUniversal.agda` and `FiniteFramePullback.agda` provide the pullback universal property and finite closure under pullback with a chosen enumeration.
- `Concurrency/Sites/FiniteBasisCover.agda` and `FiniteFrameCoverage.agda` define lean finite basis covers, complete them back to `FiniteCover` when descent needs overlap enums, adapt them to Cubical `Cover`, and construct the Cubical `Coverage` over `FiniteFrameCategory`.
- `Concurrency/Hybrid/FinitePresheaf.agda`, `FiniteDescent.agda`, `FiniteFramePresheafFunctor.agda`, and `FiniteSheafCategory.agda` define the category-generic finite presheaf/descent/sheaf-category framework.
- `Concurrency/Hybrid/EventProductPresheaf.agda`, `EventProductSheaf.agda`, and `EventProductSheafObject.agda` define the category-generic constant-slot event-product witness and package it as a sheaf-category object.
- `Concurrency/Hybrid/SessionEventProductSheaf.agda` and `TinyEventProductExample.agda` instantiate the witness on the V-valued/session side through `StarAutonomous→Category`; `TinyFiniteCover.agda` validates the carried-overlap interface on the concrete two-point cover.
- `Concurrency/Hybrid/SetFiniteSheafCategory.agda` and `SetEventProductSheaf.agda` instantiate the same framework at `SET`, giving the canonical framework-at-`SET` R4 endpoint and a concrete Set-valued event-product object.
- `Concurrency/Hybrid/SetSheafComparison.agda` proves the C6 agreement: project SET `IsSheaf` and Cubical library `isSheaf` for `FiniteFrameCoverage` imply each other, with the pullback-UP content isolated from the SET pointwise well-pointedness step.

This is a real finite sheaf landing, but it is deliberately scoped:

- It is one finite descent/sheaf construction instantiated at both `StarAutonomous→Category V` and `SET`; it is not two unrelated descent notions.
- It now makes the framework-at-`SET` side concrete and compares it with the Cubical library `Sheaf` condition for the finite coverage.
- It is constant-slot Sessions and constant-slot Set event products: arity varies by event count, but every event carries the same slot `P₀`.
- It does not claim event-dependent session content.
- It does not claim additive coproduct universal properties.
- It does not by itself claim a full Set-valued locality topos/internal logic or a generic full finite actor-causal reflector. The inhabited bridge currently available is the separate supported point-generated/event-discrete R4 theorem.
- It accepts the `UnsupportedIndexedMatch` warnings in finite-product / finite-enumeration helpers only under the constant-slot / proof-level API discipline.

Validation outcome: the concrete tiny finite cover over the existing `TinyFrame` / `PointFrame` two-point cover has landed, and the Set-valued endpoint now has a concrete event-product object. The carried-overlap `FiniteCover` interface is inhabitable on a non-trivial cover without structural revision, transport machinery, or new postulates.

### Computing witness policy

The target for the tiny finite cover example is proof-level, not definitional, computation:

- Required: propositional restriction/amalgamation equations and separatedness on the concrete cover.
- Optional bonus: definitional or `refl` computation where it falls out naturally from the concrete `Bool` / `Unit` enumerations.
- Do not engineer the example around definitional normalization unless the resulting lemma is reusable beyond the tiny cover.
- Failure to obtain definitional computation is not a weakness of the framework; the finite descent stack is intentionally stated through product universal properties (`bigβ`, `bigη`, `terminal-unique`) and propositional equality.

The global framework should not depend on tiny-cover normalization. R4 and `Allow ⊣ Require` should consume sheaf/category interfaces and proof-level laws; the library comparison is now available as legitimacy for the Set endpoint, not as a replacement for the project endpoint.

Outcome: Option A landed. The witness proves propositional restriction/amalgamation equations and separatedness on the concrete cover. Option B, a definitional or `refl` computing witness, remains a future opportunistic enhancement only if a later example exposes reusable normalization lemmas; it is not required for the framework.

### Event-dependent session slots

Event-dependent slots remain future work, not a blocker for R4 or the adjunction. The current witness works because all projections land in the fixed codomain `P₀`; reindexing along event enumerations is therefore a `cong` in a fixed `Hom` type. A dependent value

```text
value F = bigProduct (event-count F) (slot F)
```

would make projection codomains index-dependent and turn the current `UnsupportedIndexedMatch` warning into a load-bearing transport problem. That cost is intrinsic and does not grow just because we defer it.

The one real deferral risk is lock-in. Guard against it by building all layers between here and future R4 uses generically over:

```text
FiniteFramePresheaf
IsSheaf
```

not over `event-product-presheaf`, `session-event-product-presheaf`, or any lemma that assumes all projections land in `P₀`. Any constant-slot-only lemma belongs inside the constant-slot witness files.

When resumed, event-dependent slots should live in a new module, likely `Concurrency/Hybrid/DisplayedSessionEventSheaf.agda`, leaving `SessionEventProductSheaf.agda` as the clean constant-slot base case. Expected work: define displayed slot families over finite frames, add restriction coherence along finite-frame morphisms, build the dependent event-product presheaf, and reprove functoriality/descent with explicit transports.

### Next sheaf steps

1. R4 tiers 1/1.5/2 have landed: `ChangeOfBase.agda` gives value-functorial finite-presheaf change of base; `LinearNonlinear.agda` states the interface-first Benton/LNL value adapter; `LinearNonlinearSheafAdapter.agda` proves the presheaf-level lifted adjunction and right-adjoint sheaf preservation.
2. Tier 3 still has the generic full-site reflector interface in `FiniteSheafification.agda`, but the constructed route is now the point-generated/event-discrete supported site. `SupportedPointProduct.agda`, `SupportedPointification.agda`, `SupportedPointDescent.agda`, `PointifyIsSheaf.agda`, `PointSheafCategory.agda`, `PointSheafification.agda`, and `PointSheafAdjunction.agda` build the point-generated reflector and prove `a ⊣ ι`.
3. Brick 4 has landed the W3-style point-generated R4 bridge wiring: `PointLinearNonlinearAdjunction.agda` consumes `PointSheafAdjunction.a⊣ι` and assembles `Lpoint ⊣ Rpoint` over point-sheaf categories. This remains scoped to the event-discrete supported site and remains relative to `lnl : LNLAdjunction` plus `vProd : HasFiniteProducts (StarAutonomous→Category V)`.
4. Keep `SetFiniteSheafCategory` as the canonical cartesian endpoint for R4; use `SetSheafComparison` as the proof that this endpoint agrees with the Cubical library presentation at `SET`.
5. Current near-term status after Brick 4: the point-generated R4 theorem, Chu coefficient witness, and Sessions-to-Chu realization are banked. Optional exposition or instantiation checks remain useful, but the active bandwidth has moved to the 2S/3R boundary. Deferred beyond that are normalized-pullback / stability for a full Cubical `Coverage` presentation of the point-generated topology, the full actor-causal finite sheafification reflector, event-dependent session slots, and the modal-context category `M` with cross-site `Allow ⊣ Require`.

## Chu construction

Chu is now live, but still scoped. Benton/LNL remains the right R4 bridge shape because R4 relates cartesian Set-valued locality sheaves to V-valued linear/session sheaves. Chu entered as a concrete value category `V`, not as a replacement for the bridge: `Chu(SET,Bool)` now supplies a postulate-free coefficient model for the point-generated R4 theorem, and Phase 1 builds a Sessions-to-Chu realization over postulate-free session syntax.

**What has landed.** `Concurrency/Algebras/Chu.agda`, `ChuFiniteProducts.agda`, and `ChuMonoidal.agda` construct `Chu(SET,k)` as a category with finite products and the project's thin `StarAutonomous` structure. `Concurrency/Hybrid/ChuLinearNonlinear.agda`, `ChuPointVProd.agda`, and `ChuPointExample.agda` instantiate the point-generated R4 hypotheses at `k = Bool`. The actor-site cleanup split `TinyActorBase.agda` and `TinyActorCausalSite.agda`, so the final `Chu-nonvacuity` witness has no project postulate in its transitive import closure.

**Sessions realization.** `SessionSyntax.agda` and `SessionMorphismSyntax.agda` extract the postulate-free object and morphism syntax. `SessionObjectModel.agda` defines `J0`, `J0-dual`, `J1`, and the underlying Cubical functor into any `SessionObjectModel`; `SessionChuModel.agda` instantiates that interface at `Chu(SET,Bool)`. This turns the syntactic duality face into a semantic isomorphism theorem, not a transported Sessions postulate. `Sessions.agda` now reuses the morphism HIT for its structural categorical/product laws; its remaining postulate is the operadic `session-O1-action`.

**What Chu still buys later.** A Chu object `(A⁺, A⁻, r : A⁺ × A⁻ → k)` makes extension/intension, point/state, process/context reversal, and duality intrinsic. That is now both implemented as value-category infrastructure and still a future guide for formal concept analysis, Barwise-Seligman-style information flow, the cobordism / cup-cap dictionary attached to Care, and the Reality/Documentation boundary.

To check before using rhetorically: in the concrete LNL instance, the exponential `!A = F(G A)` appears to rebuild a copyable Chu object from the point carrier and replace the original state carrier `A⁻`; if verified, this is a useful explanation of how the copyable reflection forgets resource/context constraints.

**Remaining Chu phases.**

- Phase 2: concrete send/receive and payload semantics. The current payload map is parametric/nonconstant; it is not operational communication semantics.
- Phase 3: O1-in-Chu, if earned. Removing `session-O1-action` requires real structure for `gen`, `plug`, `shift`, and their laws, likely closed/evaluation/cut or coherent tensor-rotation data. Do not discharge it by adding aliases or moving the postulate sideways.
- Phase 4: Reality-boundary admission/erasure. Chu's point/state/evaluation shape is the natural formal carrier for Documentation as protocol observables over Reality, but Reality itself must not become an internal sort.

**Agda slot.** The value-category construction lives under `Concurrency/Algebras/Chu*.agda`; the point-generated R4 instantiation lives under `Concurrency/Hybrid/Chu*.agda`; the Sessions realization lives under `Concurrency/Algebras/Session*.agda`. A later Reality/Documentation boundary should start as an interface over existing Chu objects and trace/audit data, not as a core `Reality` type.

## Beyond fracture: the differential-cohesion gap

The de Rham target splits three ways once examined — the **de Rham depth ladder**, three levels distinguished by what each adds:

- **structural**: `ʃX → B` for arbitrary flat-modal `B`. Costless; just instantiates the ʃ ⊣ ♭ adjunction.
- **named-coefficient**: postulate `ℝ` as a cohesive type, then instantiate structural at `B := ♭ℝ`. Tautological as a "de Rham theorem" — de Rham cohomology is *defined* to be flat-ℝ cohomology, so the theorem reduces to its definition. Rhetorical packaging.
- **differential**: actual differential forms = `ℑX → ♭ℝ` (or via a refined hypercohomology construction), where `ℑ` is the **infinitesimal shape modality** — part of **differential cohesion**, a *separate* refinement of plain cohesion adding three new modalities, the triple `ℜ ⊣ ℑ ⊣ &` (reduction ⊣ infinitesimal shape ⊣ infinitesimal flat). Plain ♭/ʃ/♯ cannot see "differential" in the classical sense; that is exactly the gap differential cohesion was invented to fill.

Current plan goes structural → named-coefficient, aiming at differential. The named-coefficient result will look like the de Rham theorem in name but is tautologous. The *content-bearing* de Rham theorem — differential forms compute the same cohomology that flat-ℝ coefficients compute — requires the differential refinement. This is a *future* concern, not a current one: nothing in the structural / named-coefficient path will be wrong, but it will not have delivered what "de Rham theorem" normally means.

What an upgrade to the differential level would need:

- Three new modality postulates: `ℜ` (reduction) ⊣ `ℑ` (infinitesimal shape) ⊣ `&` (infinitesimal flat), with units/counits/induction principles, mirroring what Cohesion.agda + Adjunctions.agda already do for plain cohesion.
- A redefinition of differential forms in the cohesive setting as `ℑX → ♭ℝ` (or refined).
- The de Rham theorem proper: `(ℑX → ♭ℝ) ≃ (ʃX → ♭ℝ)` (or similar) — a statement that *is* content-bearing.

Scope: a separate phase, comparable in size to the entire plain-cohesion phase we have just finished.

**Under the three-track strategy:** the differential rung is deferred to `formal/AnalyticTest/` (see folder README); structural and named-coefficient remain on synthetic + `Analytic/`. The "future work" framing above is updated accordingly — differential is deferred to a specific track, not indefinitely.

## Discussion of the next step when the bandwidth was still on the modal side

Envisioned next step: a short NamedCoefficient.agda, ~50 lines.

One postulate — ℝ : Type. That's all. IsFlatModal (♭ℝ) is automatic via flat-modality-idempotent; no extra postulate needed.

Contents:

postulate ℝ : Type

deRham           : Type ℓ → Type _
deRham X = ShapeModality X → FlatModality ℝ

flatℝCohomology  : Type ℓ → Type _
flatℝCohomology X = X → FlatModality ℝ

deRham-theorem     : (X : Type ℓ) → deRham X ≃ flatℝCohomology X
deRham-theorem-pin : (X : Type ℓ) → equivFun (deRham-theorem X) ≡ λ f → f ∘ shape-unit

Both bodies are one-liners — flat-coefficients-factor (flat-modality-idempotent) and flat-coefficients-factor-pin (flat-modality-idempotent).

Header framing. Tautological as a "de Rham theorem" — de Rham cohomology is defined as flat-ℝ cohomology in this setting. The separation content sits in the statement (mentions ʃ and ♭,
neither stateable in plain HoTT). The content-bearing de Rham theorem is parked in AnalyticTest under the differential rung.

Three design calls I'd flag for you:

1. Bare ℝ : Type vs. bundled record. I lean bare. Nothing in this rung uses any property of ℝ beyond existence — ring/order/truncation structure would be over-commitment we don't exercise.
Upgrade when differential cohesion forces it.
2. No degree index. I'd avoid H⁰_dR notation. Structural-pinned is degree 0 only; higher degrees need K(ℝ, n) infrastructure we don't have. Leaving the degree implicit is more honest.
3. Analytic mirror — skip or keep the pattern? Genuine call:
- Skip (my lean): the analytic FlatCoefficients.agda already verifies the equivalence at arbitrary B on ℤ and Bℤ; named-coefficient is rhetorical packaging with no new analytic content.
Postulating ℝ analytically would also break the no-postulates rule. Flag the gap with a header line in the synthetic file.
- Keep parameterized: mirror file restates the equivalence at arbitrary B, comment notes "synthetic specializes at B := ♭ℝ." Preserves pattern; minimal new code.
- Use ℤ as ℝ-stand-in: concrete, but reuses our shape-modal test type — degenerate and a bit dishonest about what's being verified.

The mirror skip is the most consequential — it breaks the "every synthetic file has an analytic mirror" rhythm. Reasoned but worth your call.

What lands after this round. The synthetic side of the de Rham arc is complete at the structural / named-coefficient depth (per the ladder's narrow sense). Open paths from there:
- Background maintenance on ♯/ʃ dependent induction (would unblock several theorems-currently-postulates).
- Pivot to the Concurrency stub.
- Open AnalyticTest if signature stability has settled.

## Concurrency-side layers of complexity (planned)

The Concurrency side, at the time of writing, has shipped the actor-causal site, pullback overlaps, the cyclic operad `O_1` and its `*`-autonomous algebra interface, the Sessions instance, the Hybrid v1 presheaf/restriction adapter, finite-site event-product descent with constant-slot Sessions and Set instances, the concrete tiny finite-cover validation, finite sheaf categories at both `StarAutonomous→Category V` and `SET`, the finite Coverage/SET library sheaf comparison, and the R4 Benton/LNL finite-sheaf bridge through conditional Tier 4: presheaf-level change of base, presheaf-level adjunction, right-adjoint sheaf preservation, a finite-sheafification reflector interface, and the sheaf-level adjunction conditional on a V-side reflector. The point-generated reflector route has also landed over the supported subsite: event-supported frames, incident point frames, event-supported point overlaps, the canonical point cover, `IsPointSheaf P ↔ PointLocal P`, abstract point products, pointification as a point sheaf, the point-sheaf category, the reflector functor, and the adjunction `a ⊣ ι`. `PointLinearNonlinearAdjunction.agda` now consumes that reflector and assembles the point-generated sheaf-level Benton/LNL bridge `Lpoint ⊣ Rpoint`, relative to `lnl` and `vProd`. The point-generated R4 theorem is banked rather than the live frontier. At the 2S/3R boundary, global and per-conversation realization, conditional coverage, causal-saturation comparison, and raw actor-renaming invariance have landed; the 3R event log records exact contract evidence and replays the expanded corpus. Several additional layers are committed in design but not yet in code. This section is the catalogue of those layers, with for each: what it does for the protocol's use in the human world (possibly with LLMs as participants), what mathematical structure it commits to (or, where the choice is open, what the candidates are), and what currently shipped scaffolds it presupposes.

A unifying disciplinary commitment behind all the layers below: **praxis is part of the theory**. The protocol's use by a community of equal-standing participants is constitutive of the framework, not an applied addendum to an underlying mathematics. This is what distinguishes the framework's combination from each of the historical precedents catalogued in `related_structures.md` — at least one of (mathematical depth, theory-of-community, runnable protocol, self-validation through use, recursive co-evolution structure) was missing in each of them.

The five layers below are listed in build-dependence order: each presupposes its predecessor, either as substrate or as the object it operates on. The dependency chain in compact form: Hybrid finite descent plus V-valued and Set-valued finite sheaf endpoints plus finite Coverage/library comparison plus conditional R4 sheaf bridge plus point-generated reflector adjunction plus point-generated R4 bridge → later full actor-causal reflector enrichment / full `Coverage` upgrade → **Layer 1 (Π)** → **Layer 2 (Λ)** → **Layer 3** (field-theoretic dynamics on Λ) → **Layer 4** (Federation, requiring all four previous). **Layer 5** (information-cohomological complexity) reads off Layer 2 content topos and is independent of Layers 3–4 in code, though it composes cleanly with Layer 3 action functional.

They are all "Committed" — held as planned future content of the framework, with the existing scaffolds already designed to receive them, but with no Agda content shipped yet. A separate appendix at the end gathers three *reframings* — sharper readings of structure the framework already commits to. The reframings are of a different nature from the layers; they affect what to aim for, not what to additionally construct.

| Layer | Properties |
|---|---|
| **1. Reflexive Protocol Layer (Π)** | **Function:** the protocol can revise its own rules; meta-conversations propose edits and ratify them by consensus, with non-retroactivity preserved by `FrameHom`'s strict causality reflection. <br> **Math anchor:** protocol-version category Π with a patch-theoretic fragment category whose coherent amalgamation models consensus; Pijul as primary implementation-facing candidate. <br> **Status:** Committed. |
| **2. Bulk Type Theory / Content Layer (Λ)** | **Function:** the protocol generates its own internal language of concepts from the messages actors exchange, progressively replacing seed languages like English with its own evolving vocabulary. The "what" tag on every message, parallel to the session-type "how" tag. <br> **Math anchor:** concept category Λ (likely 2- or (∞,1)-categorical), with messages valued in `Sessions-Cat × Λ` and conversations generating diagrams in Λ whose consensus is amalgamation. <br> **Status:** Committed. |
| **3. Field-theoretic dynamics on the content layer** | **Function:** the language matures along the pristine-symmetry → chaos → restructuring → stable-cycles trajectory: the protocol begins in a perfectly symmetric designed state, breaks symmetry under the perturbation of actor conversations, passes through a fluctuation-heavy proposal storm, and converges to a stable mature language. Gives the implementation an action functional (objective), distance functions (metrics on concepts and on protocol versions), and empirical observables (correlators of concept co-occurrence). <br> **Math anchor:** factorization algebra over the actor-causal site valued in Λ, with content operad `O_C`; Wilsonian RG flow driven by reflexive-layer insertions; initial high-symmetry state as contractible Λ; mature language as IR fixed point. <br> **Status:** Committed. |
| **4. Federation — bicategory of protocols (Yoneda + anabelian)** | **Function:** every protocol instance treats itself as one-among-many from inception, exposing typed translation interfaces, partial clones, and conflict-as-data; no protocol can position itself as the exclusive authority over inquiry, so the authoritarian arrangement the framework was built to dissolve cannot reappear at the protocol's own meta-level. <br> **Math anchor:** 2-category of protocols with Hoapa-respecting geometric morphisms; Yoneda makes "one among many" constitutive; meta-topos M is itself Hoapa-structured with canonical GT-action inherited from `MO_1`, anabelian in the relevant sense. <br> **Status:** Committed. |
| **5. Information-cohomological complexity** | **Function:** receiver-relative reading of complexity that structurally justifies unityping (differences live in receiver state, not in actor types); supplies the protocol with a measurable optimization objective (reduce expected description cost across actors) and a practical proxy (language-model perplexity). <br> **Math anchor:** information cohomology in the Baudot–Bennequin–Vigneaux line; Shannon entropy as 1-cocycle, mutual information as 2-cocycle; the (co)homology pairing whose homological dual is what the bulk layer constructs. <br> **Status:** Committed. |

### What is intentionally *not* in this catalogue

To set honest expectations and prevent scope-creep:

- *Implementation-track infrastructure.* The actual protocol kernel as running software, the verification runtime, the persistence / cryptographic / consensus backend, and the LLM-tooling integration shape are not part of the five mathematical layers below. They are tracked separately in the implementation-track section that follows this scope note.
- *UI / UX decisions.* What a participant's interface to the protocol looks like; how messages are composed; how meta-conversations are surfaced.
- *Specific Lagrangian weights of Layer 3.* Each term is a normative commitment about what makes a language "good" and will need explicit calibration; the calibration itself is implementation-and-deployment work, not framework work.
- *Specific seed-language choices for Layer 2.* Lawvere theory vs categorial grammar vs dependent-type theory — the architectural commitment is that one or more of these is used; which is decided per-deployment.
- *The choice of metric on concepts.* Wasserstein-style, information-geometric, embedding-based — multiple may coexist for different sub-tasks; the framework does not pre-commit.
- *Below-kernel infrastructure.* Networking, distribution, storage, retry semantics. The framework's kernel is type- and category-theoretic; the infrastructure that runs the kernel is engineering work the kernel does not constrain except by interface.

These exclusions are not deficiencies. They are the right scope for a workflow document calibrated to the mathematical-content track of the project.

### Implementation track — runtime, checker boundary, and protocol contract

The durable implementation-track plan lives in `workflow/status_implementation.md`. That file replaces the old top-level `workflow/elixir.md` transcript, which has been archived under `workflow/deep_context/`.

The first rising-sea gate has been crossed narrowly. The project did not open a broad `Concurrency/Protocol/` layer; it opened `/formal/RuntimeContract/Trace.agda` plus the smallest serialization/runtime boundary that the existing substrate forced. Loop 1 is closed and green: the v0 contract now has a formal predicate, a fixture corpus, generated Agda raw terms, a vendored runtime artifact, and an Elixir `hoapa_contract` codec suite. The runtime-to-substrate bridge derives rank and causal order in `BackwardRank.agda` and `CausalFromParents.agda`, then realizes each present conversation and its strict embedding in `ConversationLocality.agda`.

This means the contract/export/runtime-codec harness is no longer future work. The 3R construction seam and event-log pass 1 have landed: an unnamed `Hoapa.Core.EventLog` records caller-supplied contract values without checking or normalization, exports a `Run`, reproduces the accepted tiny run from literal calls, and replays every schema-decodable corpus fixture by exact struct equality. It is still a recorder, not protocol behavior or an event originator. The live implementation queue belongs in `workflow/status_implementation.md`; `hoapa_checker` remains deferred until a behavioral originator—currently the actor-kernel candidate—produces events to validate one-by-one. A fidelity sampler or authored scenario originator does not meet that gate.

The implementation still should not wait for the full cross-site `Allow ⊣ Require`, `MO_1`, Reflexive Π, or Bulk Λ layers. It also should not claim verification beyond the finite trace/run predicates Agda actually states. Elixir owns runtime behavior; Agda owns the specification of well-formed traces and boundary laws; the top-level checker boundary currently orchestrates formal and runtime tests, with compact certificates and richer audit/provenance semantics deferred.

See `workflow/status_implementation.md` for the substrate-readiness audit, runtime split, naming guardrails, verification commands, and next contract decisions.

### 1. Reflexive Protocol Layer (Π)

A protocol that cannot revise itself either freezes prematurely or forces the engineers around it to do the revising by hand, outside the protocol's own verified machinery; either way the discipline the rest of the framework imposes is lost at the meta-level, because the act of changing the rules now happens in a place the verification does not reach. The Reflexive layer is the formal home of protocol self-modification. Periodic meta-conversations are spawned to inspect the current protocol, propose edits, and — when they reach consensus — commit those edits as the protocol under which subsequent conversations operate. Past events stay under the rules in force at their occurrence. The whole mechanism happens *inside* the framework's actor-causal / session / hybrid machinery rather than alongside it, which is what makes "the protocol changed itself" a verifiable event rather than an administrative fact.

**Function in the human-world implementation.** Regular-interval self-scan as a built-in protocol primitive: a meta-conversation is spawned automatically, with a typed role for inspecting the current rules. Meta-conversations can spawn sub-conversations (proposal exploration, dialogue with neighbors, drafting); the resulting bundle of edit-proposals forms a structured object whose amalgamation is the new protocol version. Inconsistent proposals — a bundle with no coherent amalgamation — give the framework an honest formal counterpart of "the protocol cannot be coherently edited from here." A protocol that is genuinely stuck reports itself as stuck, rather than being silently kept running by ad-hoc workarounds in the surrounding engineering. Non-retroactivity is automatic: conversations started under protocol v1 cannot be rewritten under v2, because `FrameHom`'s strict causality reflection in `ActorCausal.agda` makes retroactive event manipulation structurally impossible.

**Mathematical structure.** The protocol-version category Π. Objects are protocol versions (each one a Hybrid configuration: site, session target, presheaf chassis, content category, etc.). Morphisms are protocol edits. Whether Π is a 1-category or carries 2-categorical structure (edits compose up to coherent equivalence) depends on the chosen fragment formalism. A forgetful functor `Π → HybridStructure` recovers the current framework configuration at each version. A *patch-theoretic fragment category* hosts edit proposals; consensus is the existence of coherent amalgamation in that category. Pijul is the primary implementation-facing candidate: patches as first-class events, dependencies as causal-order data, commutation of independent changes, conflicts as explicit gluing obstructions, resolutions as typed repair events, partial clones as local views. The precise categorical encoding — 1-category, double category, event structure, adhesive category, partial-commutation presentation — is held open until the candidate is examined honestly. A temporal site combining the actor-causal site with version-indexing is the natural object for ordinary conversations to live over; morphisms in it split into intra-version `FrameHom` and inter-version protocol-edit lifts.

**Trigger / dependencies.** Two required, both load-bearing: (a) descent and the cartesian-vs-linear R4 question stable enough that the Hybrid chassis is no longer moving under a new layer; (b) the fragment-category candidate honest enough to state in Agda — minimum, a chosen object class for edit proposals, a chosen morphism class, and a stated compatibility condition for which coherent amalgamation is meaningful. The Reflexive layer pulls forward two other items already on the books: the Promotion morphism class from the Hybrid adapter list (Adapter 5) acquires its operational duty as the bridge from closed meta-conversation to Π-morphism; `MO_1` / the modular envelope graduates from long-horizon to active roadmap as the natural home for the self-gluing involved in conversation-of-conversations.

**Open questions / deferred pieces.** Whether Π is 1- or 2-categorical (depends on fragment-category choice). The precise functor `Π → HybridStructure` and its variance. Pijul's categorical encoding. The implementation of consensus in practice — how a meta-conversation actually arrives at the coherent amalgamation beyond the mathematical statement that it exists. Whether the framework wants a single Π for all edits or a stratified family (rule-level edits vs vocabulary-level edits vs interface-level edits) — the latter starts to be needed once the federation layer enters.

**Agda tree slot.** `Concurrency/Hybrid/Reflexive.agda`, reserved 2026-05-21. The choice of `Hybrid/` over a sibling `Concurrency/Meta/` subtree reflects the project's preference against premature folder proliferation and the Hybrid layer's recent reframing as the adapter layer; if Reflexive grows into a genuinely higher-order protocol calculus, it can be split out at that point.

*Originating design conversation:* `deep_context/arc/07_self-modifying_protocol.md`.

### 2. Bulk Type Theory / Content Layer (Λ)

A message currently carries only a session-type tag — its "how" (request, response, send, receive, endpoint discipline). The Bulk layer adds a "what" tag: the concept the message is about. As actors exchange messages, refine their meanings, contest mis-uses, and stabilize working definitions, the protocol builds up its own internal type theory of concepts. Seed languages — natural-language English, formal mathematics, ad hoc shared vocabulary — are embedded as initial presentations and get progressively replaced by the protocol's own evolving language; the reflexive layer's meta-conversations include those that work specifically on making this language more transparent, easier to use, and free of inherited biases. The bulk layer is, in a precise sense, the protocol's true output: what gets produced is not the messages but the universe of concepts the messages build.

**Function in the human-world implementation.** Every message tagged with both a session-type and a concept-tag. The pair `(SessionType × ContentTag)` is the operative carrier. The current language Λ is queryable: concepts can be looked up, related, refined, contested, deprecated. New concepts are introduced by typed events; refinements are recorded as morphisms; consensus across conversation-networks promotes local edits to global ones. Biases inherited from seed languages appear as homotopical obstructions — paths the seed language assumes the community's actual usage does not coherently support — and can be surfaced for repair by reflexive-layer meta-conversations of the bias-correction kind. The implementation is meaningfully a *language-generation engine*, not just a verified message-passing kernel.

**Mathematical structure.** The concept category Λ. Objects are concepts; 1-morphisms are concept-relations (subsumption, specialization, paraphrase, refinement, contradiction-witness); higher morphisms are coherences and obstructions. Likely a 2-category or (∞,1)-category to host the homotopy structure of refinements honestly. The tagging structure on values: in the simplest reading, `SessionPresheaf` is generalized from `Sessions-Cat` values to `Sessions-Cat × Λ` values (parallel layers, with the how/what split preserved). A fibred or full Grothendieck construction over Λ is the natural alternative if content needs to vary contextually with concepts; the design call is parallel-vs-refining. Seed inclusion: external languages enter as initial presented theories embedded into Λ. Three presentation candidates with different operational consequences — Lawvere theory for the cleanest categorical model, categorial grammar (Lambek) for natural-language bridges, dependent type theory for the eventual self-hosted version — likely all three end up needed. A language-generation functor / monad packages how conversation data refines Λ; meta-conversations of the reflexive kind act on Λ via this functor.

**Trigger / dependencies.** Hybrid finite descent plus the finite Set/V endpoints, the finite Coverage comparison, and R4: the bulk layer compatible-local-content reading uses the sheaf-descent half of the Hybrid layer, not just the presheaf/restriction half. The Reflexive layer Π: language edits and protocol edits interact, and some content-layer edits will be sequenced through meta-conversations. Sessions-Cat stays untouched at the `*`-autonomous level; the bulk layer sits above it as additional structure on the values, not as a refinement of session syntax.

**Open questions / deferred pieces.** Parallel content category vs refinement of Sessions (lean: parallel). Set-truncated vs homotopy-typed (lean: ship set-truncated as first witness, target homotopy-typed). Seed-language choice (Lawvere / categorial grammar / dependent type theory). Whether Λ has its own operad `O_C` whose generators are concept-formation operations (define, refine, identify, split, contradict), and if so whether `O_C` is structurally similar to `O_1` (cyclic, ribbon, planar) or genuinely different (commutative, branching, tree-like). The interaction with the actor-causal site: which concepts are local to which frames, how the cover structure interacts with the indexing.

**Agda tree slot.** `Concurrency/Content/` as a new sibling to `Sites/`, `Algebras/`, `Operads/`, `Hybrid/`, or `Concurrency/Hybrid/Content.agda` inside the adapter list. Mathematically the bulk layer is distinct enough from the adapter layer that its own subtree is defensible; the project's folder-proliferation discipline pushes toward the Hybrid location. Decision deferred until the layer's actual code shape is closer.

*Originating design conversation:* `deep_context/arc/08_bulk_type_theory_layer.md` (placeholder file; design captured in workflow conversation logs).

### 3. Field-theoretic dynamics on the content layer

Once Λ exists, its actual content does not appear ex nihilo. The protocol starts in its most pristine state — designed with perfect symmetry, before any of the perturbation provoked by the actors' conversations. That high-symmetry state exists only briefly; under the perturbation of actor activity it is replaced by a fluctuation-heavy proposal storm — randomly distributed actors proposing things across the network, most ending in the system's trash bin — and only after sustained work converges into a mature, stabilized, efficient language that mirrors the actors' context faithfully at an abstract level. This pristine-symmetry → chaos → restructuring → stable-cycles trajectory is not a metaphor for cosmological symmetry-breaking; mathematically it is the same phenomenon. The content layer behaves as a *factorization algebra* over the actor-causal site (Costello–Gwilliam framework), and its evolution is *renormalization group flow*, driven by the insertions that the reflexive-layer meta-conversations supply. This subsection commits the framework to that field-theoretic register and names what it brings to the implementation: an action functional the protocol can optimize, distance functions on concepts and on protocol-versions, and a class of empirical observables (correlators) that turn the protocol's qualitative behavior into measurable data.

**Function in the human-world implementation.** An *action functional* gives the implementation an objective. Candidate Lagrangian terms: description length of the current language (penalizes redundancy, rewards compression), coherence cost of the concept category (penalizes unresolved obstructions), communication overhead (penalizes round-trips needed to disambiguate), drift from observed usage (penalizes divergence between the formal language and how actors empirically use it — the bias-correction term, expressed as a Lagrangian component). RG flow is gradient flow of this action on the space of language states; the meta-conversations from the reflexive layer are the discrete-time correction events, proposing changes that reduce the action substantially in one step and ratifying them by consensus. *Metrics* give the system clustering power and drift detection: distance between concepts (candidate-synonym detection, candidate-refinement detection, clustering of related concepts), distance between protocol versions (whether a proposed edit is a small adjustment or a paradigm shift, computing the trajectory of the protocol in version-space). Crucially, *no* metric on actors — that would break unityping. *Correlators* are the protocol's natural observables: two-point and higher patterns of concept co-occurrence across actor-causal regions, across conversations, across protocol versions. Critical exponents — how correlators scale near a phase transition — are the empirically testable signature of *universality*: two communities of inquiry running protocols in the same universality class should agree on critical exponents.

**Mathematical structure.** A factorization algebra on the actor-causal site, valued in (likely homotopy-typed) Λ. Open sets are `LocalFrame`s; the assignment of a chain complex (or higher category) to each open subset is the content layer's local content; factorization maps encode how disjoint-region content composes. The operad governing the factorization is `O_C`, a content-side operad whose generators are concept-composition operations. Whether `O_C` is structurally similar to `O_1` (cyclic associative, three-port, ribbon-decorated) or genuinely different (commutative, tree-like, branching) is a real open question that the framework should not pre-decide. Wilsonian RG flow on the moduli of factorization algebras, deformed by reflexive-layer insertions; mature language = IR fixed point; universality classes = communities-of-inquiry that flow to the same fixed point regardless of seed language. The symmetry-breaking content is HoTT-native: the initial high-symmetry state is the contractible / one-concept Λ (all concepts identified); each consensus event that records a stable distinction between concepts is a higher coherence saying "the presumed equivalence does not compose."

**Trigger / dependencies.** Λ must be statable (Layer 2 first). The reflexive layer Π provides the operators that get inserted into the flow (Layer 1 first). `MO_1` becomes load-bearing: factorization algebras with the geometry the content layer needs land naturally over modular-operad infrastructure, and the cobordism / TFT dictionary from `deep_context/arc/06_*` is the operations-side of the same connection this layer frames as the framework-side. The two dictionaries — boundary / process duality (06) and scale dynamics / RG (this layer) — are unified at the level of locally constant factorization algebras over the cobordism category and the cobordism hypothesis's full-dualizability condition.

**Open questions / deferred pieces.** The specific shape of `O_C` (genuinely open). The specific Lagrangian terms and their relative weights — every term is a normative commitment about what makes a language "good," to be entered with eyes open; this is also the place where the project's values become explicit and editable, which is a feature, not a bug. Whether universality classes exist and are testable in practice. The action functional should remain in the analytic / heuristic layer rather than the trusted kernel: kernel claims (typing, provenance, non-retroactivity, descent, no-leak, valid promotion) should not silently depend on numerical field-theoretic quantities even when those quantities are guiding the implementation's decisions.

**Agda tree slot.** Co-located with Λ. The trusted-kernel verification work (typing, descent, provenance) stays in the existing Hybrid / Sessions / Sites tree; the field-theoretic-flavored dynamics layer is an analytic companion to that, not a refinement of it.

*Originating design conversation:* `deep_context/arc/06_the_hybrid_as_a_door_to_field_theories.md` (cobordism / field-theory dictionary); RG-flow / factorization-algebra reading captured in workflow conversation logs.

### 4. Federation — bicategory of protocols (Yoneda + anabelian)

A single protocol that succeeded at every previous layer would, if left in isolation, still end up positioned as the sole legitimate framework for inquiry — claiming exclusive authority over its domain, requiring others to conform, treating dissent as malfunction. That is precisely the authoritarian arrangement (in science, in the rest of the institutional world) the framework was built to dissolve at the level of individual conversations; reproducing it at the level of protocols would be the project succeeding mathematically while losing the social claim that motivated it. This failure mode at the protocol level is structurally exact to the *one true mathematics* failure mode that the modal-HoTT-as-praxis claim refuses at the foundational level: both involve an authoritative regime claiming jurisdiction over a domain that is intrinsically plural. The same disciplinary move applies at both levels. The federation layer is the structural counter-move: every protocol instance is designed to treat itself as one-among-many from inception, exposing typed translation interfaces to neighboring protocols as part of its own definition, not as a costly afterthought. Mathematically, this is the Yoneda lemma read as a discipline: a protocol *is* its system of translations to other protocols; anything that fails to expose translation interfaces is Yoneda-equivalent to no protocol at all. The "one among many" property thereby becomes constitutive rather than appended. The Sketch-of-a-Program-mathematics that has been the hidden long-horizon spine of the concurrency side (dessins, Belyi maps, the modular envelope, the GT action) acquires here its operational job: it is the symmetry that makes translations between protocols coherent across the ecosystem.

**Function in the human-world implementation.** A neighbor-registry as a typed channel rather than a database: discovery and admission of new neighbors happen via typed exchange, with no privileged admitting authority. A translation API exposed per concept: each concept in Λ carries typed (partial, possibly multi-valued) translation signatures to known neighbors; missing translations are first-class data, not bugs. Provenance on every term: every concept, every protocol-edit, every consensus decision tracks origin protocol(s) and influencing neighbors at the type level, unforgeable. Partial clones, not full mirrors: cited concepts retain their provenance and dependencies on the origin protocol's structure; nothing is silently absorbed. Conflict as first-class data: when two neighbors hold incompatible positions on a shared concept, the incompatibility is recorded explicitly as a conflict morphism in both protocols' internal structure rather than flattened into "one of them is wrong." Edit-locality: the reflexive layer's protocol-edits do not propagate across protocols; a meta-conversation in protocol P that edits P does not edit Q, and if Q wants the analogous edit, that is Q's own meta-conversation. There is no operational state of "an isolated Hoapa instance" — running the protocol means running it as one-among-many from the first event.

**Mathematical structure.** A (2- or (∞,2)-)category of protocols. Objects: protocols, each one a Hoapa-structure (cohesive ∞-topos + actor-causal site + sessions + hybrid + reflexive Π + bulk Λ + field-theoretic dynamics). 1-morphisms: Hoapa-respecting geometric morphisms between the underlying toposes — translations that preserve actor-causal locality, content category, and reflexive-layer structure. 2-morphisms: comparisons between translation functors with coherent composition. Yoneda gives `P ≃ Hom(–, P)` in the (2-)presheaf topos over the category of protocols; this is the formal content of "one among many." The presheaf topos `M` over the category of protocols is the *meta-topos*; it inherits cohesion, factorization-algebra structure, and the rest of the Hoapa-structure from the protocols, making it itself a Hoapa-structure at one level up. The construction therefore iterates — ecosystems of ecosystems, etc. — with no privileged top altitude. A canonical Grothendieck–Teichmüller-group action on M, inherited from each protocol's `MO_1`: translations are GT-equivariant, and the recovery of a protocol from its translation surface is GT-equivariant. In the strong target form, M is *anabelian* in the relevant sense: protocols are recoverable from their Yoneda data equipped with GT-action; two protocols are equivalent iff they sit in the same GT-orbit. Dessins-like combinatorial presentations of individual protocols are the analog of dessins ↔ Belyi pairs. A sibling `Π*` for inter-protocol relations completes the picture: intra-protocol edits in Π compose with inter-protocol translations in Π* in a larger 2-categorical structure. Goguen / Burstall institutions are a useful published precedent for the morphisms-of-internal-languages level.

**Trigger / dependencies.** All four previous layers at v1 (Π for intra-protocol edits to translate; Λ for the content surface; field-theoretic dynamics for the comparison data correlators supply). `MO_1` for the GT-action. The R11 structuring relation (arithmetic action), currently deferred in `status_formal.md` to the `MO_1` stage, is reclassified by this layer from "late-stage decoration" to "structural backbone of inter-protocol coherence" — without R11 the ecosystem of protocols is a discrete pile of unrelated structures, with it the ecosystem has a single canonical group of automorphisms relating all the translations.

**Open questions / deferred pieces.** The precise sense in which M is anabelian (anabelian theorems are genuinely hard; even Mochizuki's dimension-one proof is technical and contested in parts; we promise the structural commitment and the roadmap, not the theorem). Whether Π and Π* unify or persist as parallel structures. Whether a future Mediate-style federation reading unifies with the structural / content / cross-leg readings, or stays as a distinct altitude. The project's discipline of self-application here is structural rather than rhetorical: Hoapa itself is one protocol among many — one attempt at a framework, currently being built by one small community-of-inquiry — and must expose typed translation interfaces to adjacent communities (HoTT/UF, factorization-algebra theorists, AI alignment groups, Pask-descended conversation theorists, autopoiesis-influenced researchers, the Bennequin / Belfiore / Laforgue topos-for-cognition line) rather than claiming to resolve them.

**Agda tree slot.** `Concurrency/Federation/{Protocol,Translation,MetaTopos}.agda`, reserved as future home. Opens far downstream of R4 / `MO_1`.

*Originating design conversations:* `deep_context/arc/06_the_hybrid_as_a_door_to_field_theories.md` (cobordism dictionary, Sketch-of-a-Program connection); federation discipline and Yoneda + anabelian / GT-action reading captured in workflow conversation logs.

### 5. Information-cohomological complexity

The complexity of a message is not intrinsic to the message; it is what the receiver experiences given their familiarity with the language in which the message is expressed. This receiver-relative reading flattens any presumed hierarchy of "complex" versus "simple" actors and is what structurally justifies the framework's commitment to unityped actors: an actor's apparent sophistication is a function of their internal reference frame, not of any actor-level type distinction. The mathematical incarnation is *information cohomology* in the Baudot–Bennequin–Vigneaux line. Shannon entropy is the (essentially unique up to scalar) 1-cocycle on a simplicial structure built from a category of observables, satisfying the chain rule; mutual information is the corresponding 2-cocycle; conditional entropy is the relativized version. This layer reads off the cohomological invariants from the content topos that the bulk layer builds, gives the protocol a *measurable* optimization objective (reduce expected receiver-relative description cost across the actor population), and supplies a practical proxy (language-model perplexity) that runs today against contemporary infrastructure.

**Function in the human-world implementation.** The protocol's monitoring layer exposes information-cohomological invariants as first-class outputs: per-actor perplexity over the current language, mutual information between concept clusters, conditional entropy of new messages given history, per-cover information decay (which concepts are local, which global). Meta-conversations from the reflexive layer can read these invariants and argue language edits accordingly, turning "we should improve the explanation of concept C" from a vague critique into a measurable target. The optimization objective is the principled target: minimize expected receiver-relative complexity across the actor population while preserving semantic fidelity. The cohomological invariant is the mathematically clean object; relative description cost `K(message ‖ receiver's expectation)` is the same content in coding-theoretic register; language-model perplexity is the empirically computable proxy. This is the place where information theory, MDL / rate-distortion, and information-bottleneck arguments enter the framework as the disciplined scoring of the implementation's decisions. It is also the framework's structural refutation of "scale fixes this": the minimum needed for the framework to function is categorical (cohesion, separation of concerns, sheaf descent, the cross-site adjoint pair, factorization algebra), not parameter-count. A single agent of any scale cannot supply that structure; a community of agents organized by a Hoapa-style protocol can.

**Mathematical structure.** Information cohomology on the category of observables built from the content topos. Reference frame: receiver state, formalized as a probability measure or sheaf section over Λ. The cohomology class `H(message | receiver)` is the cohomological invariant; relative entropy is the operative quantity. The deeper structural reading: the (co)homology pairing `H_*(Content topos) ⊗ H^*(Content topos) → k` evaluates the community's homological construction (what gets built — chains, cycles, accumulated language) against the entropy cocycle that measures it. The strong target claim is that the cross-site adjunction `Allow ⊣ Require` is, at the deepest layer, this (co)homology pairing: Allow tests the concurrency-side chain against modal-side cocycles, and Require demands that the chain be measurable by the cocycle. A future `Mediate` would be the actual evaluation map if extra adjoint structure is earned. The modal triple `ʃ ⊣ ♭ ⊣ ♯` admits an information-theoretic reading as a triple of *receivers*: `♭(A)` is the receiver who sees only the underlying-set structure (high relative complexity for richer content), `ʃ(A)` is the receiver who sees the homotopy structure but not the discrete points, `♯(A)` is the receiver who sees every point separately but no connecting structure. (This is where the cohesion-as-threshold reframing in the appendix below acquires an information-theoretic face — see reframing A.) The cohesive adjunctions become change-of-frame transformations; cohomological pull-backs and push-forwards are the principled operations between modal perspectives. Bennequin's information cohomology program lives natively in topos theory; adopting its framing is recognition that the mathematics this layer needs has already been written by adjacent neighbors (and is why their entry in `related_structures.md` warrants sharpening).

**Trigger / dependencies.** The bulk layer Λ first (the content topos must exist as the substrate of the cohomology). The reflexive layer Π (so the cohomological invariants have someone to read them and act on them). Does not strictly require the field-theoretic dynamics layer to land in code, but the two compose cleanly: the entropy term enters as a Lagrangian component of that layer's action functional.

**Open questions / deferred pieces.** The strong claim "cross-site adjunction = (co)homology pairing" is a target-shape, not a theorem; if proved, it would be the central theorem of the project. The framework's analog of the P-versus-NP question — *is there a universal reference frame providing an intrinsic complexity floor independent of receiver?* — is genuinely open; the framework can ask it but does not need to settle it to function operationally. The choice of metric (Wasserstein-style, information-geometric, embedding-based) is a real design question with no unique right answer; multiple metrics may need to coexist for different sub-tasks. The Manin–Marcolli line on Homotopy Theoretic and Categorical Models of Neural Information Networks is plausibly the same threshold-and-no-go phenomenon, viewed from the agent's internal-structure side rather than the framework's external-structure side; verifying the precise alignment is homework before any claim of agreement gets recorded.

**Agda tree slot.** Undecided; probably co-located with Λ. The invariants are read off the content topos rather than introduced as new structure, so a separate folder is not warranted at v1.

*Originating design conversation:* workflow conversation logs (information cohomology / receiver-relative complexity / (co)homology pairing); no dedicated arc file yet. The Manin–Marcolli alignment question is open homework.

### Appendix — cross-cutting reframings (different in nature from the layers above)

The five layers above each name a new piece of formal content the framework commits to host. The three items below are different: they are *reframings* — sharper readings of structure the framework already commits to. They are listed here so the catalogue carries them visibly, without giving the impression that they are additional construction work. Each affects what to aim for, not what to additionally build.

#### A. Cohesion (and differential cohesion) as complexity threshold

The framework presumes a minimum modal complexity: not "any" modality, but the cohesive triple `ʃ ⊣ ♭ ⊣ ♯` with its specific separation and modal-subuniverse assumptions (`♭` preserves products, pieces have points, the modal types form a non-trivial subuniverse), and eventually differential cohesion `ℜ ⊣ ℑ ⊣ &`. These assumptions do not assert cross-site non-collapse. Below cohesion, the modal side is too thin for "complexity develops" to be a non-trivial claim: three modalities that collapse to one remove the motivating multi-level contrast. Distinct modalities still do not prove the Lawvere explanation, T3, or a developing network; those require the cross-site witnesses specified in `targets.md` §T3. Below differential cohesion, the modal side's field-theoretic output is restricted to synthetic cohomology and the central conjecture cannot land in its strongest form. In the Manin reading, complexity is generative recursion supported by multi-level adjoint reasoning; cohesion is the minimum modal structure in which that reading can be posed. The mapping is sharp: separation-of-concerns on the concurrency side is the discipline that keeps content and actor-carrier as distinct mathematical objects, and cohesion on the modal side is the discipline that keeps spatial and discrete as distinct modal layers; both are the generative geometry of their respective sides, neither is decoration. The framework-makes-sense floor is cohesion; the central-conjecture-can-land floor is differential cohesion. This reframing sharpens the existing `Beyond fracture` entry: differential cohesion graduates from "elevated to load-bearing for the cross-site bridge" to "the substance of the modal field-theoretic output." No new construction work; non-removability of the existing commitments becomes part of the central claim rather than a working assumption.

This reframing is presented first in the appendix because the next reframing (the symmetric formulation, B) presupposes both cohesion and differential cohesion as floors; and the third (recursive co-evolution, C) presupposes both of those.

#### B. Symmetric formulation: the modal side outputs a field theory

The five layers above belong to the concurrency side. A complementary observation on the modal side closes a symmetry that is structurally exact and sharpens the central conjecture. Read this way, reframing B is the cross-site closure of the five-layer catalogue: the five layers describe the concurrency outputs in detail, and this reframing states that the modal side has the symmetric output structure (a field theory), with the cross-site adjunction `Allow ⊣ Require` as the current precise statement of the symmetry. The reframing is therefore the natural closing claim of the layered architecture, not a sibling addition to it.

*Notation update (2026-06-04): this file used `Allow ⊣ Mediate ⊣ Require` as older shorthand. The live structural target is now pair-first: `Allow ⊣ Require`, with Mediate, ambidextrousness, or a quadruple held only as future extra structure if earned. Where this section assigns `Mediate` a concrete role (e.g. the evaluation map of the (co)homology pairing in Layer 5), read it as a candidate extension of the pair, not as a settled commitment.*

The modal side, once differential cohesion lands (the `ℜ ⊣ ℑ ⊣ &` triple, currently in `Beyond fracture` above), is a synthetic field-theory construction kit in the sense Schreiber's program has developed for over a decade: smooth ∞-stacks as moduli of field configurations, Lagrangian field theory as variational calculus on jet ∞-stacks, BV/BRST quantisation as a derived construction on the moduli of solutions, twisted differential cohomology as the natural target for observables. The cyclic bar construction at S¹ (the deferred modal work in `T_recursion iteration`) is the moduli-extraction step. So the symmetric statement is: *the concurrency side has field-theory-shaped dynamics whose stabilized output is an internal type theory* (the five layers); *the modal side has type-theory-shaped foundations whose internal semantics is field-theory-shaped*. The cross-site adjunction `Allow ⊣ Require`, with a possible future `Mediate` extension, is the precise statement that the field theory the modal side outputs and the type theory the concurrency side outputs are mutually adjoint readings of the same cohesive ∞-topos. This requires the existing modal build-out (differential cohesion, cyclic bar) plus the concurrency layers above. The reframing does not change the immediate next steps; it sharpens the destination.

#### C. Recursive co-evolution: iterated cross-site adjunction

The five layers, taken together, support a reading larger than any of them individually: a sequence `(M_0, C_0) → (M_1, C_1) → (M_2, C_2) → …` where each (modal context, concurrency protocol) pair runs in its modal context and, through its activity — the field-theoretic output on the modal side, the reflexive-layer's protocol-edit machinery and the bulk-type-theory layer's content production on the concurrency side — refines the ambient enough that a new modal context `M_{n+1}` emerges, in which new protocols `C_{n+1}` become statable that were not statable in `M_n`. The sequential colimit (or, in a richer formulation, a 2-categorical colimit accounting for the adjoint maps between stages) is the candidate stable evolution object. Convergence (with `Require ∘ Allow` acting as identity on the colimit) is one possible outcome; persistent production of genuinely new structure is the stronger possibility targeted by T_recursion. The proposed Lawvere asymmetry motivates that outcome but does not prevent convergence by itself: non-stabilization must be witnessed at rung 3 of `targets.md` §T3. This admits recognizable counterparts in cosmology (vacuum-selection inflation), biology (niche-construction plus the major-evolutionary-transitions framework), the history of social institutions, and the development of mathematical practice itself; the project's claim is that those readings may share a *formal categorical content*, not merely a slogan. The framing is *a candidate formal frame for context-system co-evolution with recognizable interdisciplinary readings*, deliberately not *a generalized theory of evolution*: the precedent of cybernetics, general systems theory, and Wolfram's NKS is the cautionary tale this language is calibrated against (see `related_structures.md` § *Universal-theory precedents — the cybernetics-era pattern* for the precedent map), and the project's distinctive position is that the mathematics is being built first and the interdisciplinary readings come second, rather than the reverse. Mathematically, this is the long-horizon form of `T_recursion` lifted from a single adjunction to the iterated cross-site adjunction; the existing iteration scaffold in `Iteration.agda` is the control-scale precursor, not evidence that the long-horizon object exists.

### Glossary

Brief definitions of recurring terms in the layers / reframings section above, for readers without category-theory or cohesive-HoTT background:

- **`MO_1`** — the *modular envelope* of the cyclic operad `O_1`; closure under self-gluing of marked points, producing operations at every `(genus, arity)` configuration.
- **Π** — the *protocol-version category* from Layer 1; objects are protocol versions, morphisms are protocol edits.
- **Λ** — the *concept category* from Layer 2; objects are concepts, morphisms are concept-relations (subsumption, refinement, contradiction-witness).
- **`O_C`** — the (conjectural) *content operad* from Layer 3, governing how concepts compose; sibling to `O_1` on the content side.
- **`Ass_cyc`** — the *planar cyclic associative* operad; the ribbon-graph world, as opposed to the fully symmetric `Com_cyc`.
- **Factorization algebra** — a sheaf-like structure on a topological / causal space, with disjoint-union composition controlled by an operad; the modern categorical framework for QFT (Costello–Gwilliam).
- **Anabelian** — a property of geometric objects that are recoverable from their fundamental groups equipped with arithmetic action; in our context, applied to the meta-topos of protocols and its GT-action.
- **GT** — the *Grothendieck–Teichmüller group*, the profinite group acting on the tower of moduli of curves and (in our framework) on the meta-topos of protocols.
- **`*`-autonomous category** — a symmetric monoidal category with a dualizing object; the categorical semantics of multiplicative linear logic / session-type duality.
- **Information cohomology** — Baudot–Bennequin–Vigneaux framework: Shannon entropy as a 1-cocycle on a category of observables; mutual information as a 2-cocycle; conditional information as the relativized version.
- **RG flow** — *renormalization group flow*; in physics, the dynamics on the space of theories produced by coarse-graining; in this framework, the dynamics on the space of language states produced by consensus.
- **Meta-topos** — the (2-)presheaf topos over the category of protocols (Layer 4); itself a Hoapa-structure at one level up, which is what makes the federation construction iterate.

For broader project-wide terms (cohesion, modal adjoint pair, actor-causal site, sheaf descent, etc.), see `motivation.md` and `arc.md`.

## Future steps

### Concurrency category and R4

The finite sheaf framework now has both endpoints: `Sh_fin(site,V)` via `StarAutonomous→Category V` and `Sh_fin(site,Set)` via Cubical `SET`, each with a concrete constant-slot event-product object. The finite site-axis legitimacy work has also landed: `FiniteFrameCoverage` supplies the Cubical coverage, and `SetSheafComparison` proves the framework-at-`SET` sheaf condition agrees with the library condition. The R4 treatment has landed interface-first through conditional Tier 4: `ChangeOfBase.agda`, `LinearNonlinear.agda`, and `LinearNonlinearSheafAdapter.agda` prove presheaf-level Benton change of base, the presheaf-level lifted adjunction, and right-adjoint sheaf preservation; `FiniteSheafification.agda` names the finite-site reflector; `LinearNonlinearSheafAdjunction.agda` proves the sheaf-level adjunction conditional on a V-side reflector. The supported point-generated route removes that reflector hypothesis for the event-discrete site: `PointSheafAdjunction.agda` constructs `a ⊣ ι`, and `PointLinearNonlinearAdjunction.agda` assembles `Lpoint ⊣ Rpoint`, still relative to the value-level `lnl` and `vProd`.

This keeps the two concurrency poles separate: Set-valued locality sheaves carry cartesian/internal-logic structure; V-valued sheaves carry linear/session content. R4 is the named adapter between them, not a collapse and not the cross-site `Allow ⊣ Require` adjunction. The framework-at-`SET` category remains the canonical R4 endpoint; the library comparison is its legitimacy theorem, not a replacement endpoint.

Immediate inside this leg: write the theorem exposition and decide whether to add a concrete instantiation witness. Deferred beyond that: the normalized-pullback / stability layer needed for a full Cubical `Coverage` presentation of the point-generated topology, the full actor-causal finite sheafification reflector, enriching `Sh_fin(site,V)` with inherited linear / star-autonomous structure, constructing the free/forgetful Set-to-session adjunction rather than assuming it, proving full topos/internal-logic structure for the Set endpoint, and extending from the finite common site to the full actor-causal Set-valued topos.

### Modal-context category options

The modal analogue of the actor/content divide is the cohesive split between discrete/formal structure and cohesive/spatial structure. The cohesive adjoints form the modal adapter system. Options for `M` remain:

1. Native modal-HoTT category: types or modal types with functions. Cheapest, closest to current Agda, but weak as final architecture.
2. Semantic `Sh(Bℤ,Set)` / ℤ-action style category. Concrete, but risks overfitting the analytic Bℤ model.
3. Cohesive package: cartesian/discrete core plus cohesive total context plus the cohesion bridge. Preferred target, staged as an interface.
4. Category of modal contexts / cohesive topoi. Natural long-term, too heavy now.

Current lean: package `M` as cartesian/discrete core + cohesive context + cohesion adapter, mirroring `K` as Set-valued locality + V-valued linear content + R4 adapter. Do not hard-wire the exact flat/sharp/shape to typed/unityped/protocol slot assignment yet; T4 still needs a conscious settlement.

### Cross-site adjunction threshold

A stated `Allow ⊣ Require` interface alone is scaffolding. It becomes mathematically interesting when the functors are constructed from the ingredients and accompanied by a non-trivial example or theorem. First target the structured-package comparison, with a cartesian shadow and later enrichment-compatibility laws. The first compelling theorems would be non-collapse, nontrivial iteration of `Require ∘ Allow`, separation preservation/detection, R4 compatibility, or a concrete finite actor-causal example that crosses the adjunction and returns with controlled loss.


## Candidate addition under evaluation: provenance, accountable artifacts, and reversible import

**Status and scope.** This section records a newly identified possibility, not a change to the committed five-layer catalogue above. It does not renumber those layers, alter their dependency order, change the current R4 frontier, reserve an Agda module, or commit the project to a new mathematical construction. It is deliberately self-contained because adopting the proposal could reorganize the cascade, patch-theoretic ownership, the implementation trace schema, and the relationship between Reflexive Π and Federation. Until that evaluation is complete, every structure and workflow below is a candidate.

### Problem and motivating use

The motivating use is not retrospective attribution for its own sake. It is the cost of repeated work in a network of protocols. Suppose protocol `P` has developed an artifact or concept and protocol `Q` needs substantially the same result. Without disciplined import, both derive it independently and then spend further conversations constructing and maintaining a bridge. A better path may be for `P` to do the derivational work once, for `Q` to adopt an explicitly cited and typed realization, and for `Q` to spend only the local conversation needed to translate or bridge it. Provenance does not itself eliminate conversations; it can make non-repetition acceptable by preserving what is needed to inspect, update, detach, or retract an import.

The import is neither an unmarked copy nor an assertion that `Q` independently established the result. It should retain the source protocol, source artifact and version, derivational grounds, translation used by `Q`, explicit adoption decision, and local changes depending on it. Authority remains separated: `P` is authoritative for the source artifact and history; `Q` is authoritative for adoption, local interpretation, overlays, and forks. This is a *partial mirror by citation*, not silent absorption.

The candidate trade-off is:

> **clean, reusable artifact versus reconstructable, accountable artifact.**

A protocol needs stable interfaces so it can use results without replaying their construction. It also needs enough account of origin, derivation, interpretation, and change to know what a result depends on and what happens if those grounds move. The candidate follows the framework's recurrent strategy: keep the live artifact separate from its account; divide the account into derivational and temporal faces; and state laws relating both faces to the artifact. Working names are *Accounted Artifact*, *Audit*, and *Accountability and Provenance*. “Audit” here concerns artifacts, derivations, and changes, not the typing or ranking of actors.

### Human-world import lifecycle

A candidate import record would contain:

1. a stable source-protocol identifier;
2. a stable artifact identifier and source-version identifier;
3. a derivational account over event/document/artifact tokens;
4. the typed translation or migration used locally;
5. `Q`'s acceptance decision and applicable trust policy;
6. the local materialization change introducing the imported view; and
7. references from local bridges and overlays to that change.

It should support distinct operations:

- *adopt*: create a local cited realization;
- *update*: import a newer version and reconcile downstream changes;
- *retract*: invalidate or remove a realization whose grounds no longer support it;
- *detach*: preserve the snapshot while ceasing to follow its source;
- *fork*: retain ancestry while transferring future authority locally;
- *rebase*: replay a local bridge and overlays over a newer realization; and
- *supersede*: retain the old account while making a newer artifact current.

Local edits should normally be overlays, bridges, or forks rather than mutations of the imported source. Provenance cannot promise that withdrawal is cheap: a heavily reused artifact may have a large downstream cone, and semantic repair may require conversations. The honest promise is narrower: compute and expose the structural dependency cone, preserve unrelated work, and let the protocol choose a repair policy. This localizes structural impact; it does not predict the full human cost.

### Two faces and their interface

**External / derivational face: provenance.** This records why an artifact is supported across protocol boundaries: which sources were used, which alternatives support it, and which grounds were required jointly. It supports citation, dependency analysis, trust filtering, and counterfactual questions such as whether support survives withdrawal of token `x`.

**Internal / temporal face: accountable change.** This records how local protocol state changed: which import, edit, bridge, resolution, or supersession introduced the current state; which changes depend on earlier changes; which independent changes commute; and which combinations conflict. It supports versioning, non-retroactivity, compensation or local undo, and preservation of unrelated changes.

**Materialization interface.** The dependency graphs are not the same. A semantic derivation may depend on an artifact without shared textual context, while a VCS change may depend on file context without expressing semantic justification. An import must carry or reference its derivational account, and its local materialization change must expose a checked relation to it. Provenance supplies grounds; accountable change supplies local transition and conflict handling; materialization makes them one capability.

The central law must not identify provenance deletion with patch removal. The target is conditional commutation:

```text
materialize(recompute(provenance[x := 0]))
  ≃
incrementally-retract(materialize(provenance), import-change x)
```

The equivalence is observational, not syntactic, and is meaningful only after artifact, account, materialization, observation, and repair policy are typed. Side conditions govern overlays, alternative derivations, accepted versions, and unresolved conflicts. This interface law is the proposed content that could make the two faces one layer.

Supporting obligations include:

- **Origin preservation.** Materialization retains source artifact/version and translation.
- **Dependency adequacy.** If a source token can affect a local artifact, its import change lies in the local dependency closure. Conservative adequacy may precede completeness.
- **Materialization soundness.** The local artifact denotes the recorded translation applied to the recorded source version.
- **Locality.** Retraction or update preserves changes outside the affected cone.
- **Non-retroactivity.** Withdrawal creates a new invalidation, supersession, compensation, or conflict event; it does not rewrite what earlier participants saw.
- **Alternative-support preservation.** Removing one derivation preserves an artifact still supported by another accepted derivation.
- **No-leak erasure.** Erasing actor-identifying runtime information preserves what the trusted checker needs.
- **Authority separation.** A source update does not silently enact local adoption or repair decisions.

These laws are stronger than storing a dependency list and weaker than universal reversible computation. They are the candidate meaning of “editable and reversible import.”


### Positive semiring provenance

For a set `X` of source tokens, the standard positive provenance object is the free commutative semiring `ℕ[X]`. Addition represents alternative derivations; multiplication represents joint use; coefficients retain multiplicity. Evaluation produces an expression or, more practically, a shared circuit/DAG. A semiring homomorphism out of the free object specializes the same account to Boolean support, counting, costs, access conditions, trust values, or other coefficient systems when their laws apply. The value is “record once, interpret in multiple ways,” not a claim that every desired measurement is a semiring homomorphism.

Withdrawing an input from a positive derivation does not require monus: assign its token `0` and reevaluate. That computes which justifications survive. It does not edit the importing protocol or decide how downstream artifacts should be repaired. Monus or other extra structure becomes relevant when the derivation/query language itself contains difference, negation, or other nonmonotone operations. The Badia–Kolaitis–Noguera work on Codd's theorem over semirings and the developing Badia–Noguera–Petreni–Portone–Tannen negative-information line therefore belong to a later extension, not the minimum reversible-import story.

Circuits or shared DAGs should be preferred initially to expanded polynomials: expanded expressions can grow prohibitively, while circuits preserve sharing and admit multiple evaluations. Stable tokens are required, but hashes are only one implementation. Logical artifact identities plus explicit versions may be preferable where content changes without changing conceptual identity.

### Descent and Applied Category Theory

The phrase *accounted descent* is a candidate description, not a theorem. Existing Hybrid descent says when compatible local sections glue. A provenance refinement could annotate sections and derivations so a glued artifact retains an account of which local material supports it. This does not mean the existing proof discarded provenance, nor that a semiring annotation automatically forms a sheaf. Compatibility between restriction, gluing, and provenance evaluation must be stated.

Relevant categorical constructions cover different parts:

- A category of elements, displayed category, or Grothendieck construction can organize tokens and transport. It does not supply the additive/multiplicative algebra of alternative and joint derivations. Variance is open: covariant transport suggests an opfibration, contravariant restriction a fibration, and the full import situation may require a bifibration or profunctor.
- Spivak-style functorial data migration supplies typed schema translation through `Σ ⊣ Δ ⊣ Π` and is a candidate for import/migration. The adjunctions do not automatically retain a persistent audit record, and a left Kan extension is not generally reversible.
- Quantale-valued relations can be enriched matrices/profunctors. This is useful for suitable complete idempotent specializations, including Boolean, tropical, and some many-valued cases. It does not contain universal `ℕ[X]` provenance without changing or completing the coefficients.
- Set-valued profunctors are proof-relevant relations, and a categorified derivation theory may connect to HoTT. `ℕ[X]` is at most a decategorified shadow: labeled monomials retain more than counts, but not full witness objects or higher identifications.
- Functorial aggregation combines values over fibers. Its commutative-monoid operation resembles provenance addition algebraically but has a different semantic role. It may aggregate import costs later; it is not the provenance construction.
- Lenses and optics may express update or repair propagation. They do not record derivational grounds.

The conservative posture is positive semiring provenance first; an indexed/categorical transport layer once variance is known; functorial data migration for typed imports; and enriched or categorified refinements only when a theorem requires them. No commitment should yet be made to semimodule-valued sheaves or R4 enrichment: the needed `*`-autonomous, finite-product, and change-of-base interfaces have not been established.

### Accountable change and the Pijul boundary

Agda should specify an abstract accountable-change interface before the project commits to a version-control implementation. Candidate ingredients are artifact states, typed changes, dependencies, composition/application, partial commutation, conflict and resolution data, materialization, and an observation relation. The minimum interface should not assume every real change is invertible. Compensation, unrecording from selected history, and adding a change that marks older material dead are distinct operations.

Mimram–Di Giusto's categorical theory of patches and Homotopical Patch Theory are formal resources: the former studies merge through pushouts and finite-colimit completion; the latter presents Darcs-style invertible patches through higher inductive types. Neither is a verified description of Pijul's append-only graph, alive/dead edges, contextual dependencies, or `unrecord` behavior. Pijul remains a strong implementation candidate because it provides stable change identities, explicit dependencies, partial clones, commutation of independent changes, and conflicts as stored data. The relationship should be refinement, not identification:

```text
Agda:    abstract accountable-change laws
Pijul:   concrete storage and change semantics
checker: evidence that emitted operations refine the abstract interface
```

This creates an open ownership question. If the candidate becomes a layer, it could own the accountable artifact/change substrate, with Reflexive Π consuming it for self-modification, promotion, and consensus. Alternatively, patch infrastructure could remain under Π and provenance remain cross-cutting. The materialization laws must earn an independent rung before existing ownership changes.

### No-leak and security boundaries

Standard provenance records people, institutions, agents, attribution, and responsibility; W3C PROV explicitly supports them. Hoapa's unityped/no-leak commitment therefore runs against the default grain of provenance systems and must be present from v1. Trusted tokens should identify events, documents, artifacts, protocol versions, translations, and derivation steps, not refine actor identity. Runtime infrastructure may need actor identifiers, but an erasure or pseudonymization theorem must show that the trusted account and certificate do not depend on them.

The following guarantees remain separate:

```text
stable identity       is not necessarily content addressing
content addressing    gives tamper evidence, not authorship
signatures             attest control of keys, not semantic correctness
provenance             records derivation, not authorization
trust policy           governs adoption, not mathematical validity
```

Hashes may align with Pijul changes and typed documents but are not mandatory. Signatures, capabilities, revocation distribution, and key management belong at the security/infrastructure boundary. The mathematical layer should expose attachment points without deriving authenticity from provenance.

### Language, documentation, and orchestration

Provenance is language-agnostic. Existing systems range from relational query rewriting and provenance circuits in PostgreSQL/C/C++ to RDF/OWL interchange. The transferable requirements are structured accounts, stable identifiers, explicit versions and translations, deterministic evaluation, and checkable certificates, not a particular language or universal writer-monad encoding.

A possible Hoapa split is:

- Agda specifies circuits, erasure, accountable-change laws, materialization, and conditional coherence.
- Elixir emits runtime events, import/adoption decisions, and provenance references as structured metadata.
- A checker validates finite accounts/certificates against Agda-pinned predicates.
- Pijul-shaped persistence stores local changes, dependencies, conflicts, resolutions, and partial views where its representation fits.
- Typed documentation supplies artifact/version identities, typed references, canonical serialization where feasible, and explicit translation signatures.
- The conversation-of-conversations orchestrator records which artifacts, proposals, and sub-conversations influenced each output.

Provenance does not select the documentation or orchestration language. It constrains their interfaces: outputs must cite typed inputs and transformations without parsing informal prose, and orchestrated results must not become originless flattened summaries. Elixir can meet this if its schema is typed and checked; no new orchestration language follows automatically.


### Possible cascade effect if adopted

The strongest candidate placement is between Hybrid and Reflexive:

```text
Hybrid finite descent
  → candidate Accounted Artifact / Audit layer
  → Reflexive Π
  → Bulk Λ
  → field-theoretic dynamics
  → Federation

Information cohomology continues to read from the content side.
```

The generative argument would be: Hybrid produces coherent global artifacts, but usable abstraction hides origin and transformation history; Audit separates the artifact from its derivational and temporal accounts; Π can then revise a protocol over accountable changes without rewriting the past. The candidate would be localized in construction and cross-cutting in consumption.

Potential downstream effects:

- **Reflexive Π:** consumes accountable changes, dependencies, non-retroactivity, and conflicts; adds reflexive proposal, promotion, and consensus.
- **Bulk Λ:** carries concept lineage and distinguishes inherited concepts, overlays, and forks.
- **Field dynamics:** may use accounts as observables or costs, but numerical dynamics must not determine trusted provenance validity.
- **Federation:** receives the main payoff: typed cited imports, partial mirrors, origin preservation, local adoption authority, and update/retraction behavior.
- **Information cohomology:** may measure an account but is not subsumed by provenance; entropy is not generally a homomorphic specialization of `ℕ[X]`.

This could permit a narrow Federation import vertical slice before the full anabelian/meta-topos layer: two protocols, one typed translation, one cited artifact, and one update/retraction scenario. It would test import, not claim full Federation. Conversely, the candidate may remain a cross-cutting kernel facility or Federation feature. It earns layer status only if the trade-off is generated by Hybrid, the two-face separation is necessary, and the materialization laws add formal content not already owned by Π.

No current layer numbering or dependency claim changes while this remains open.

### Staged investigation and possible build order

The live R4 exposition and optional intended-value instantiation remain first. The candidate creates no immediate code obligation.

**v1: positive derivational account.** Define finite stable tokens, positive provenance circuits/expressions, commutative-semiring evaluation, support, restriction/gluing compatibility, and no-leak erasure. Prove the homomorphism/evaluation law and alternative-support behavior. No monus, Pijul coupling, quantale enrichment, or reversible-local-state claim.

**v2: accountable change and materialized import.** Specify the abstract change interface and typed import/materialization record. Prove origin preservation, materialization soundness, and conservative dependency adequacy. Define adoption, overlay, detach, and fork.

**v3: update and retraction coherence.** Add source succession/invalidation, incremental impact, local preservation, compensation/conflict policies, and the conditional recompute-versus-incremental theorem. Only here would “reversible import” be justified.

**v4: nonmonotone derivations and advanced specializations.** Add monus/difference or a better negative-information construction if needed. Separately evaluate quantale-enriched profunctors, many-valued specializations, categorified witnesses, and any R4 enrichment. These extensions are independent.

A small falsifying example should drive all stages. Protocol `P` produces artifact `a` from tokens `x` and `y`, with alternative and jointly required derivations. Protocol `Q` imports `a` through a typed translation, adds one dependent bridge and one unrelated artifact, and then observes `P` withdraw `x` or publish a successor. The example must show which support survives, which changes are affected, which remain unchanged, what history remains, and what no-leak reveals. The existing two-point finite cover is a natural test if the descent connection proves real.

### Decision gates and next discussions

Before integration into the stable catalogue:

1. **Capability:** Is accountable import a kernel capability or a Federation/runtime feature?
2. **Layer:** Is clean artifact versus reconstructable account a generated cascade trade-off?
3. **Ownership:** Should a candidate Audit layer own accountable change, or should Π retain it?
4. **Categorical carrier:** What indexes tokens and translations, with what variance, and where does the circuit live?
5. **Equivalence:** What observation makes recomputation and incremental retraction comparable?
6. **No-leak:** Which identifiers survive into trusted certificates, and what erasure theorem is required?
7. **Implementation:** Can Pijul operations refine the abstract interface without entering the kernel?
8. **Economics:** In the finite example, does accountable reuse reduce conversations or verification work?

The next discussions should first settle capability, layer, and ownership; then compare categorical carriers against the finite example; then specify the Pijul/checker refinement boundary; and finally decide whether to promote, retain cross-cutting, or reject the candidate. Promotion would require explicit later edits to the cascade, Π, Federation, implementation schema, and compact motivation table. Until then, this section is the sole roadmap for the idea.

### Candidate implementation slots, not reservations

If the proposal survives:

```text
formal/RuntimeContract/Audit/Provenance.agda
formal/RuntimeContract/Audit/AccountableChange.agda
formal/RuntimeContract/Audit/Materialization.agda
formal/RuntimeContract/Audit/NoLeak.agda
formal/RuntimeContract/Certificate.agda
```

These are illustrative. The future `RuntimeContract/Audit` area would cover trace no-leak and accountable provenance if the candidate survives; integration would decide whether to rename, split, or keep the broader Audit capability separate from compact certificates. No file is reserved here.

### Research anchors and cautions

- Green–Karvounarakis–Tannen, *Provenance Semirings* (2007): free-semiring/K-relation foundation.
- Grädel–Tannen, *Provenance Analysis and Semiring Semantics for First-Order Logic* (2024/2025): first-order extension and homomorphism/evaluation.
- Green–Ives–Tannen, *Update Exchange with Mappings and Provenance*, and ORCHESTRA: closest precedent for autonomous-peer import/update, not the sole origin of provenance.
- Badia–Kolaitis–Noguera, *Codd's Theorem for Databases over Semirings* (2025): monus/support/domain-independence, relevant for nonmonotone queries.
- The Badia–Noguera–Petreni–Portone–Tannen negative-information work should be monitored when public; it should not be reconstructed from seminar metadata.
- Spivak, *Functorial Data Migration*: typed migration, not automatically semiring how-provenance or persistent lineage.
- Garner–Spivak–Fairbanks, *Functorial Aggregation*: aggregation over fibers and its naturality problem, not provenance addition.
- Fujii, *Enriched Categories and Tropical Mathematics*: quantale enrichment and tropical/many-valued specializations, not a quantale presentation of `ℕ[X]`.
- Mimram–Di Giusto, *A Categorical Theory of Patches*, and Angiuli–Morehouse–Licata–Harper, *Homotopical Patch Theory*: formal patch resources, not established Pijul models.
- Pijul's graph/change semantics: implementation evidence for stable changes, dependencies, partial clones, and conflict-as-data; semantic validity remains outside the VCS.
- W3C PROV: an interchange vocabulary and a reminder that standard provenance includes agents and attribution, where Hoapa requires an explicit no-leak divergence.


## Candidate under evaluation: no-leak theorem ladder and humanness-as-refusal

**Status and scope.** This section records the 2S runtime-to-substrate theorem ladder exposed by the arc/13 continuation. Tier A is now implemented and promoted into `targets.md`'s progress record; the higher tiers remain a candidate investigation. This is not a new cascade layer or a new arc file. The detailed conversational synthesis lives in `workflow/arc/13_catalysts_and_care.md`; this section extracts the remaining future-work consequences and the definitions earned by Tier A.

The motivating formulation is:

> The system protects humanness by refusing to formalize it.

The formal reading must stay negative and boundary-shaped. The kernel should not recognize a `Human` predicate, an expert caste, a designer actor type, or a ranking of participants. It should instead prove that trusted protocol observations are insensitive to actor identity except through permitted participation structure. The proof-near core is therefore no-leak / actor-renaming invariance.

### What is already grounded

The substrate already carries the syntactic floor of the claim:

- `Concurrency/Sites/ActorBase.agda` gives an opaque, unityped actor carrier with no constructors, no origin tags, no roles, no message syntax, no fresh-name operation, and no decidable equality in the kernel.
- `RuntimeContract/Trace.agda` uses dense natural-number coordinates at the serializable boundary, while deliberately excluding person identity, network identity, runtime handles, semantic payload bodies, and identity-refining fields.
- `RuntimeContract/Realization/TinyTrace.agda` gives one concrete trace-to-frame witness, explicitly labelled as a witness rather than the generic bridge.
- `RuntimeContract/Realization/BackwardRank.agda` proves that a causal-parent edge strictly decreases first-occurrence rank under `backwardOK`; global event-ID distinctness is not load-bearing for that order lemma.
- `RuntimeContract/Realization/CausalFromParents.agda` gives the first generic bridge checkpoint: any well-formed raw run determines a causal order and one global actor-causal `LocalFrame`.
- `RuntimeContract/Realization/ConversationLocality.agda` realizes each present conversation as a `LocalFrame` and supplies its strict `FrameHom` into the global frame.
- `RuntimeContract/ActorRenaming.agda` gives the substrate-free Tier A theorem in three strata: functoriality under arbitrary actor maps, exact raw-validator equality under total injective actor endomaps, and the invertible permutation/gauge specialization with `WellFormed` transport and reflection.
- `Hybrid/ChangeOfBase.agda` contains the structural half of no-leak as frame-noninterference under change of base.

These results establish the raw boundary discipline, not the full observation-level theorem. Realized-frame equivalence and trusted observations remain absent.

### The theorem ladder

**Tier A: raw actor-renaming invariance — landed at `5670658`.** `renameActors` changes exactly `traceActors`, `convActors`, and `evTouches`. The result separates three natural hypothesis levels:

```text
arbitrary total maps:       renameActors respects identity and composition
total injective endomaps:   valid? (renameActors rho r) ≡ valid? r
invertible relabelings:     WellFormed is invariant under the permutation action
```

The Boolean theorem holds for every raw run, malformed included; forward and reflected `WellFormed` transports are exported by name. Injectivity is the exact boundary because actor equality is all the validator observes: a collapsing map can merge an undeclared actor into a declared one or destroy actor distinctness and thereby change the verdict. The permutation statement satisfies the recorded bijective target, but its invariance is inherited from the stronger embedding theorem; its additional content is the inverse action.

The proof is direct through Boolean equality, membership, subset, distinctness, conversation lookup, and the validator clauses. It does not use the formerly proposed inverse-renaming route. A list-local bijection is not a sufficient hypothesis for exact Boolean equality over all raw runs, because malformed runs may mention undeclared actor identifiers outside the declared list. That notion remains potentially useful at Tier B, whose input is already `WellFormed`.

This is a standing obligation more than a surprising discovery: `valid?` has no actor-identity-sensitive clause. The tests therefore supply degeneracy controls—a moving transposition, a non-surjective `suc` embedding, and rejected collapsing maps—not a leak falsifier. A future clause that reads a particular actor identity will turn the generic theorem red.

Do not silently broaden this to all identifiers. Event IDs, conversation IDs, content tags, provenance tokens, run IDs, and protocol IDs have their own alpha-equivalence or stability questions. The humanness/no-leak theorem concerns the actor-identity channel.

**Tier B: realized-object actor-renaming invariance.** The generic realization checkpoints have landed:

```text
WellFormed r -> global LocalFrame r
WellFormed r -> each present conversation has a LocalFrame and global FrameHom
```

`CausalFromParents.agda` derives the causal order from backward parent edges and packages one global actor-causal frame over realized actor/event carriers. `ConversationLocality.agda` realizes each raw conversation as a local frame, constructs its `FrameHom` into the global frame, and proves the required incidence condition. The remaining Tier B work is to prove that actor relabeling induces an isomorphism/equivalence of those realized frames. This is the substantive reading of "actor identity is gauge": relabeling changes the presentation, not the mathematical object seen by the trusted protocol.

Tier A exposed a genuine expressibility gap. `CausalFromParents.agda` builds the run-specific carrier

```text
RActor r w = Σ[ a ∈ ℕ ] ((a ∈? traceActors (trace r)) ≡ true),
```

so a run and its relabeling live over different actor types. But `ActorCausal.agda` fixes one `ActorBase` for all frames and `FrameHom` has no actor map: actor preservation quantifies over the same actor on both sides. Tier B is therefore not merely unproved in the current interface; its relative statement is not yet expressible.

### Earned direction: change of actor base

The proportionate next infrastructure, if 2S is selected, is the multi-object category of actor-name presentations with equality-reflecting embeddings, together with its core groupoid of invertible relabelings. The exact ambient choice remains open: finite sets and injections, species-style finite presentations, and nominal/finite-support semantics are neighboring settings, not synonyms. The serializable `ActorId = ℕ` contract should remain the current coordinate presentation rather than being rewritten prematurely.

The formal sequence should be:

1. package the actor-presentation objects and prove the category laws for the already generic `ActorEmbedding A B` arrows, adding decidable equality/equality reflection at the object boundary where the generic validator needs it;
2. add a relative `FrameHomOver` (illustrative name) over an `ActorBaseHom AB₁ AB₂`, leaving the banked fixed-base `FrameHom` unchanged and recovering it over the identity;
3. make global and conversation realization equivariant under change of actor base, then state Tier B over the core groupoid;
4. only later investigate conversation-local actor coordinates over the conversation cover. Actors shared across conversations are gluing data that force transition renamings and overlap coherence; whether this organizes as descent is the open question.

This category is earned by an existing consumer: without it Tier B cannot be stated without bespoke transport plumbing. It is not yet constructed. Tier A deliberately supplies only generic arrow vocabulary—embeddings and isomorphisms with identity, composition, and inversion—and the one-object `ActorId = ℕ` action. No category laws, varying-name `RawRun` functor, `FrameHomOver`, or action groupoid have landed.

The dense first-appearance convention may be read as a gauge choice because `valid?` deliberately has no density clause and the `suc` witness leaves that slice without changing acceptance. A global section selecting exactly one representative per orbit, or constancy of canonicalization on orbits, has not been proved; density-as-gauge-fixing remains an interpretation, not a result.

The banked proof fact is that the order/antisymmetry rung uses the `backwardOK` scan, not global event-ID distinctness. Distinct event IDs still matter for faithful event-record realization.

**Tier C: univalent equality capstone.** Once Tier B has a well-packaged structure and equivalence notion, optionally upgrade frame isomorphism/equivalence to equality using SIP/univalence for the realized structure. This is mathematically attractive, but it should not block the more useful Tier B theorem.

**Tier D: full humanness-as-refusal theorem schema.** The slogan-complete version would say that documentation is the universal actor-renaming-invariant observation of contribution-structure, and that the four protections below assemble into an optimal boundary discipline. This is research-scale and partly blocked on unshipped layers: trusted documentation observations, provenance/audit semantics, content-layer `Λ`, and a formal account of protocol-visible information.

### Four protections and their current status

| Protection | Formal reading | Current status | Guardrail |
|---|---|---|---|
| not ranked | actors remain unityped, unordered, and not internally classified | grounded by omission in `ActorBase` | not yet a theorem that no ranking observation is definable |
| not exposed | trusted observations are invariant under actor relabeling | raw-validator Tier A banked; realized and observational tiers open | actor-renaming, not all-ID erasure; acceptance is not every observation |
| not consumed | actor/catalyst carrier is preserved across contribution | candidate invariant | no runtime actor-token conservation theorem yet |
| not copied | no natural diagonal copies the actor-carrier into documentation | process-theoretic analogy/candidate | no quantum claim unless modeled |

Exposure/no-leak is the first protection under formal development: its raw Tier A is banked, while its realized and observational statements remain open. The other protections are useful theorem-shapes, but they should not be pulled into Tier B unless a runtime artifact forces them.

### Relationship to provenance, contextuality, and Reality

This ladder shares a boundary with the provenance and Reality candidates.

- Provenance should record events, artifacts, versions, translations, derivation steps, and materialization changes, not trusted actor essence. A future provenance/no-leak theorem should show that erasing or relabeling actor identity preserves the trusted account.
- Contextuality is a possible sheaf-theoretic bridge: local provenance support may fail to glue into a global account without adding forbidden hidden structure. That obstruction should be recorded as protocol information, not repaired by exposing actor identity.
- Reality remains the constitutive exterior. The incubator or runtime may know messy facts, but the trusted kernel should only receive boundary evidence and invariant contribution-structure.

The physics language stays interpretive: actor labels as gauge data is a useful reading of no-leak; it is not a claim that Hoapa has constructed a gauge field theory, Ward identities, or a QFT model.

### Candidate implementation slots, not reservations

The first slot has now been earned; later names remain illustrative:

```text
formal/RuntimeContract/ActorRenaming.agda                 # landed Tier A
formal/RuntimeContract/Realization/ActorBaseChange.agda   # illustrative Tier B
formal/RuntimeContract/NoLeak.agda
formal/RuntimeContract/Audit/NoLeak.agda
```

The earlier candidates `ConversationFrames.agda` and `FrameHoms.agda` are superseded by the landed `RuntimeContract/Realization/ConversationLocality.agda`; encountering the old names in archived planning should lead there. The Tier B filename and `FrameHomOver` name are not reservations. Audit-level no-leak should wait until audit/provenance semantics stop being opaque tokens.

### Decision gates

Resolved before Tier A: per-conversation locality came before renaming, and it landed directly as `LocalFrame`s plus `FrameHom`s in `ConversationLocality.agda`, without a new packaged `RealizedFrame`.

1. **Resolved for Tier A:** the raw theorem uses total injective endomaps of `ActorId = ℕ`, a fourth option not listed in the original gate. Its permutation specialization satisfies the bijective target. List-local bijectivity alone is insufficient for Boolean equality over every raw run, though it remains live for well-formed Tier B inputs.
2. **Resolved for Tier A:** exact equality of Booleans, with the `WellFormed` path and both transports as corollaries. The universal quotient reading remains Tier D.
3. **Open:** what is the first trusted observation map, if any, beyond `valid?` itself?
4. **Standing order:** build Tier B as realized-frame isomorphism/equivalence first; defer SIP/univalent equality to Tier C.
5. **Open:** which provenance identifiers survive no-leak, and which are actor-identity channels to erase?
6. **Negative Tier A answer:** no identity-sensitive falsifier exists inside `valid?` because the predicate contains no such clause. The retained tests are degeneracy controls. This gate becomes answerable only when Tier D has a trusted observation beyond `valid?`.

Within the no-leak ladder, the recommended order is now Tier B change of actor base and realized-frame equivalence, optional Tier C SIP/univalence, and only later provenance/audit no-leak or an optimality/quotient formulation. This is a mathematical dependency order, not a selection of the next project lane.


## Candidate under evaluation: Reality and the protocol's constitutive exterior

**Status and scope.** Like provenance, this is a **candidate under evaluation**, recorded because the concept is **present by its absence**: it does real work throughout the project but has never been named. It changes nothing in the live cascade — no renumbering, no new Agda module reserved. Crucially it is **not a cascade layer**. It sits at the *foundational floor* (the instigator's level "−1"), below the existing foundational separations (`actor-vs-content` in K, `spatial-vs-discrete` in M, `context-vs-system` at the cross-site adjunction); it adds one more, `reality-vs-protocol`. The originating discussion is preserved as a transcript in `arc/11_reality.md`. The separate logical-presentation / mode-theory track will eventually have to account for Reality; it is logged here as the present-by-absence gap, not folded into that track.

### The absence/presence

Reality (`R`) is the framework's **constitutive exterior**, and it is present in three asymmetric ways:

- **Negatively, in the kernel** — almost every "the kernel must *not* do X" is an unnamed invocation of the `R|P` boundary: unityping / no-leak; the decision that actor-origin metadata lives *outside* the kernel; and the presentation's buffer / availability-only / non-enactment prose ("chart the world, not inhabit and certainly not control it").
- **Positively, in the motivation** — the GR-inspired locality that motivates the Lamport-causal site, and the runtime↔reality boundary in the implementation-track plan. Elixir currently records caller-supplied contract evidence; a future runtime originator will produce behavior, and only then does a separate checker validate those events one-by-one.
- **Absent as a theorem in the formal middle** — workflow and `targets.md` now name the boundary, and Chu supplies a live point/state/evaluation carrier, but no Agda module yet formalizes Reality admission, erasure, or no-enactment.

Load-bearing fact: the kernel's identity *is* the boundary it maintains against Reality. Naming `R` is therefore mostly a *re-reading* — collecting the scattered refusals under one interface — not a new construction.

### The identity filter

There is **one barrier on the identity channel, two-way**, and the *contribution* channel passes freely through it. *What an actor is* (origin, status, identity) is filtered out at the `R|P` boundary; *what an actor brings* is not.

- **Outward** (no-leak): documentation never encodes who an actor is.
- **Inward** (anti-distortion): who an actor is never biases how their contribution is received — this is the original 2019 insight (hide the experts so the reasoning stands on its own legs), and the same anti-essentialism as receiver-relative complexity (Layer 5).

### Reality's positive role

Reality is not only a boundary; it is the **site where perspectives are formed**. Agents *explore* Reality and shape their own perspectives there (exploration in the attachment-theory sense: exploring from a secure base). The Protocol is then where formed perspectives *meet and glue* into useful, sheaf-theoretically-conglomerated perspectives — *add-but-separate*: it adds coherence that did not exist without invading (non-enactment). The **buffer** (work / greeting / opening statement) acquires its purpose here: it is the entry gate through which a Reality-formed perspective crosses into the Protocol to be glued. The Documentation is the glued output, which feeds the caring algorithm, which returns secure bases to Reality — closing the loop. See the bootstrap-of-the-care-loop appendix in `motivation.md` for the tie to the initial/free model.

### How to deal with it

The discipline is the **open-system interface**, **not an internal sort.** Formalizing the interior of the exterior is the category error the openness principle forbids (and would re-import the totalization the framework refuses). Reality's entire formal footprint is the interface: the operations that cross the boundary (request, demand, buffered entry, availability-only *pull*) and the negative constraints that do not (no actor identity; no enactment). In CBPV form: `P → Request(R)` exists, `P → Effect(R)` does not — an external handler, outside the theory, turns a request into real work.

This yields a unification worth stating once: **openness at the top** (no total context, no topos of all toposes — Lawvere) and **non-enactment at the bottom** (no protocol encloses or controls Reality) are the *same* refusal-to-totalize, stated at two ends of the construction.

- **Re-reading (now, low cost):** collect the existing kernel-refusals under one named `R|P` interface; state the top/bottom openness unification.
- **Genuinely new (later, if earned):** the effect/capability discipline that makes non-enactment a *type-safety theorem* ("no well-typed protocol term has an unmediated reality-changing effect"); the buffered-entry model; the documented-demands ledger. All live at the runtime↔checker boundary (implementation track), and should be **co-designed with the Audit/provenance candidate** — the demands ledger and the no-leak erasure are shared between the two (provenance records *derivational* exterior dependence; Reality records *material/causal* exterior dependence).

### Bulk/boundary duality (mention only; transcript in arc/11)

A duality reading was explored: Reality and Documentation as two points of view related by a dualizing object — better named **Isbell/Gelfand duality** (space ↔ observables; Connes for the noncommutative/perspectival face) than holography, with a **Chu** realization `(Reality, Documentation, ⟨−,−⟩ : · → k)`. Chu is now implemented as value-category infrastructure and as the Sessions realization target, which makes this reading technically credible as an interface shape. It is still **non-reflexive** — the double-dual (Reality → observations → reconstruction) does not invert, and that non-invertibility *is* openness / the Anthropic anchor — so it is *not* a holographic equivalence. Full transcript in `arc/11_reality.md`. The current code supports the boundary/evaluation pattern; it does not yet prove a Reality-boundary theorem. Held as a conjecture, not a result; in particular, whether its dualizing object `k` coincides with the session dualizing object `⊥ₛ` is **open** and must be written as a conjecture, never asserted.

### Discipline / what this does not claim

- **Teleology quarantine.** `raison-d'être` (R→P) and `care-toward-reality` (P→R) stay as *motivation / prose*, not formal arrows — the same discipline `arc/09` used to keep Care as structure, not purpose.
- **No holographic equivalence** is claimed; the mirror is lossy by design.
- Reality is **not** added as an internal sort.

### Decision gates (before any promotion)

1. Foundational-floor reframing only, or does it earn the new constructions (effect-discipline, buffer, demands ledger)?
2. The "bulk" disambiguation: nested holographies (Reality | Documentation, then Λ | session) vs. renaming, since `arc/08` already calls the content layer `Λ` the "Bulk."
3. Does the no-enactment effect-discipline become a stated safety theorem on the implementation track, and is it co-designed with Audit/provenance?
4. Does the `k = ⊥ₛ` question resolve, or stay a permanent open conjecture?

## Lautman as theorem-shaper: analytic adequacy, synthetic invariance, and their compatibility

**Status and scope.** This is a cross-cutting theorem-shaping note, not a new cascade layer, a new formal dependency, or a reservation of Agda modules. Lautman's two decompositions do not supply Hoapa with theorems or a proof method. They supply a diagnostic matrix for converting philosophical interpretations into explicit mathematical obligations. The substantial comparison is recorded in `related_structures.md`; this section records only its future-work consequences and points back to the existing 2S, no-leak, provenance, Reality, and logical-presentation tracks.

The basic test has three questions:

1. **Analytic adequacy:** has the formal decomposition retained enough of this particular work-process to individuate it for the declared purpose?
2. **Synthetic invariance:** is the result stable under legitimate changes of the common basis, cover, actor presentation, or context?
3. **Compatibility:** do process-specific articulation and contextual recomposition commute coherently?

The third question is the most important. Separate analytic and synthetic constructions can each be mathematically sound while failing to constitute one architecture. Lautman's value as a theorem-shaper is to keep asking for the comparison law between them.

### The theorem-shaping protocol

For every Lautman-inspired candidate, record:

1. the mathematical being being decomposed — raw run, realized frame, operational process, trace, artifact, sheaf, or context;
2. its ambient domain — actor namespace, causal frame, protocol version, site, cover, slice, universe, or coefficient category;
3. the analytic decomposition map and its intended codomain;
4. the synthetic presentation that supplies the common mode of articulation;
5. the permitted changes of presentation;
6. the equality, equivalence, or trusted-observation notion against which invariance is measured;
7. what must be preserved;
8. what must deliberately be forgotten or hidden;
9. the naturality, descent, or comparison square that must commute; and
10. a small falsifier showing how the interpretation could fail.

This protocol is stricter than matching philosophical nouns to existing constructions. Until the entries above are specified, "analytic," "synthetic," "basis independence," and "replay" remain readings rather than theorem statements.

### Family A — analytic adequacy of process-to-trace articulation

The candidate shape is:

```text
W ↦ τ(W)
```

where `W` is an actual work-process and `τ(W)` is its typed trace or stabilized artifact. Adequacy must be relative to a declared family of trusted observations. Full faithfulness is neither required nor desirable: no-leak, privacy, and the constitutive exterior require the trace to forget actor identity and other protected dimensions.

Possible obligations include:

- **causal adequacy:** the trace records the parent/order structure required by the protocol's account of the process;
- **dependency and provenance adequacy:** assumptions, artifacts, open obligations, versions, and derivational dependencies needed for later checking remain identifiable;
- **concurrency invariance:** harmless reordering of independent events does not alter the trusted process represented by the trace;
- **purpose-relative sufficiency:** the trace contains enough information for a stated operation such as audit, checking, translation, resumption, or replay;
- **selective noninterference:** changing protected actor identity does not change trusted documentary content.

This family should consume the existing 2S runtime-to-substrate ladder rather than duplicate it. `BackwardRank.agda` and `CausalFromParents.agda` provide the global realization floor, while `ConversationLocality.agda` supplies per-conversation frames and strict embeddings. Event/actor coverage and cross-conversation causal saturation are banked, as is raw actor-renaming invariance. Realized change of actor base and frame equivalence remain next within the no-leak ladder. Provenance and purpose-relative replay adequacy come later, once the relevant artifact and observation interfaces exist.

### Family B — synthetic invariance under change of presentation

Lautman's basis example suggests a family of "no privileged presentation" targets. None follows from descent alone:

- **refinement invariance:** for an explicitly defined refinement `V → U`, descent objects over the two covers are equivalent under stated topology/cofinality hypotheses;
- **equivariance:** legitimate actor, event, frame, or site automorphisms act naturally and leave the reconstructed trusted object invariant up to the chosen equivalence;
- **no chosen basepoint:** a construction does not depend on a distinguished agent, event, chart, point, or global section unless one is part of the input;
- **conservative reindexing:** change of perspective transports the relevant judgments and evidence without silently strengthening, replacing, or erasing them;
- **presentation independence:** different admissible covers or coordinate systems reconstruct equivalent contextual objects.

The raw actor-renaming theorem is now the first proved member of this family: exact validator invariance under total injective actor relabeling, with the permutation specialization. Its realized change-of-base analogue is still open. Refinement invariance and general cover independence are later targets: the existing finite and supported point-generated results establish scoped descent and sheafification, not a general basis-independence theorem.

### Family C — compatibility of analytic and synthetic decomposition

This is the principal cross-layer family:

- **trace/reindexing naturality:** reindexing a process and then forming its trace agrees, up to the declared equivalence, with forming the trace and reindexing the artifact;
- **local analytic descent:** compatible process-specific decompositions on local frames glue to a global decomposition without inventing hidden actor or causal data;
- **operational/contextual Beck–Chevalley or Frobenius laws:** contextual base change commutes coherently with the relevant operational phase change where the required adjoints exist;
- **process-to-artifact stabilization:** a completed artifact satisfies an appropriate universal property relative to the work and observations it is intended to stabilize;
- **decompose/recompose adequacy:** reconstructing from analytic pieces preserves exactly the trusted content declared by the observational interface, neither less nor more.

These targets overlap deliberately with the logical-presentation track's stability-under-reindexing, Beck–Chevalley/Frobenius, descent, and process-to-artifact targets. The Lautmanian reading does not add a second list; it explains why those compatibility theorems, rather than a bare declaration of modes or layers, are likely to carry the framework-specific mathematical content.

### Family D — recursive replay, only after adequacy

The conversation in `workflow/arc/15_metaphysics_and_logic.md` proposed a possible `Doc : Op → Ct`, `Aff : Ct → Op`, and `Doc ⊣ Aff` reading with replayability and contextual-adequacy transformations. This family stays downstream of A–C.

Before an adjunction is proposed as a theorem, the project must:

1. define the categories `Op` and `Ct` at the required level;
2. construct `Doc` and `Aff` as functors;
3. choose the observational equivalence relative to which documentation is replay-sufficient;
4. show that replay respects no-leak and does not claim total reconstruction of Reality;
5. state and test the hom-equivalence, unit, counit, naturality, and triangle laws; and
6. verify that the proposed direction matches the implemented semantics rather than the desired prose.

Failure of an adjunction would not invalidate the analytic/synthetic reading. The correct interface may instead be a fibration, factorization, capability boundary, profunctor, or noninterference relation. `Doc ⊣ Aff` remains distinct from the conjectural cross-site `Allow ⊣ Require`, the checked point-generated reflector `a ⊣ ι`, and the checked point-generated LNL bridge `Lpoint ⊣ Rpoint`.

### Status and sequence

- **Banked ingredients:** actor-causal frames and strict-reflecting `FrameHom`; category-generic finite descent; the supported point-generated reflector; the point-generated LNL bridge; global and per-conversation realization from well-formed runs; and exact recorder-fidelity replay in 3R.
- **Nearest targets already on the roadmap:** raw actor-renaming invariance is banked at `5670658`; realized change of actor base and frame equivariance/isomorphism remain next within that ladder. (The 2S coverage/causal-saturation package and its cross-conversation fixture landed at `4a072fd`.)
- **Later compatibility targets:** purpose-relative trace adequacy, provenance preservation, reindexing/refinement laws, and local-to-global trace formation.
- **Research-scale candidates:** a universal process-to-artifact property, replay/resumption semantics, and any `Doc`/`Aff` adjunction.

This classification does not reorder the live roadmap. It gives the existing targets a common theorem-shaping lens and a test for when a philosophical interpretation has acquired mathematical content.

### Guardrails and falsifiers

- A sheaf condition can hold while a construction still uses a privileged point, enumeration, actor, or cover; descent is not the full no-privileged-viewpoint theorem.
- A refinement statement such as `Desc_U(F) ≃ Desc_V(F)` is not valid without a precise refinement map and sufficient hypotheses.
- The cover/basis analogy fails if change of cover changes trusted global content in a way not explained by the chosen equivalence.
- Analytic adequacy fails if a trace loses causal or provenance information required for its declared use; it also fails by overreach if it reconstructs or exposes information the boundary promised to forget.
- Compatibility fails if local traces are individually valid but their gluing invents hidden dependencies, or if trace formation is not natural under perspective change.
- Replay fails if two observationally equivalent traces afford materially different trusted continuations, or if replay requires access to protected exterior data.
- Hilbertian theory/metatheory remains a useful second-order parallel, not an identification of metatheory with Lautman's Dialectic.

### Decision gates

1. What is the first declared observational equivalence for traces: checker acceptance, causal-frame isomorphism, audit equivalence, or another relation?
2. Which target should first instantiate the synthetic family beyond actor renaming: no chosen basepoint, cover refinement, or reindexing conservativity?
3. Can the landed per-conversation realization and cross-conversation witness state a first trace/reindexing naturality square without waiting for provenance or Bulk `Λ`?
4. Which data must analytic adequacy preserve, and which identity channels must it provably forget?
5. Is process-to-artifact stabilization a universal construction in the current LNL/CBPV candidate, or does it require a different mathematical kind?
6. What concrete counterexample would distinguish genuine basis independence from invariance built in by a trivial presentation?
7. Only after A–C have nontrivial witnesses: do `Doc` and `Aff` exist as functors, and is an adjunction still the right relation?


## Arc/16 consolidation: mediator and care theorem-shapers

**Status and scope.** The substantive outcome of `workflow/arc/16_grothendieck_givesthemathsfor_simondonindividuation_via_lautamaniandecomposition.md` is corrective and consolidating. It adds no new support for `Allow ⊣ Require`, does not move the `MO_1` gate, and does not unpause ModalHoTT. It sharpens three obligations: the non-collapse ladder in `targets.md` §T3, the distinction between the `(0, 3)` arity and Belyi cover data, and the checked `η-equiv-at-T` control instance. This section records only the research directions exposed by those corrections.

### A specific space-valued mediator candidate

An adjunction already determines a profunctor representable on both sides, so merely asking for a two-sided representable `P` would restate T1. The content-bearing route is the reverse: construct independently from admissible interaction-, cover-, and dessin-shaped realizations a specific space- / ∞-groupoid-valued profunctor

```text
P_shape : Mᵒᵖ × K → Spaces,
```

and only then ask whether there are coherent equivalences

```text
Map_K(Allow(M), K₀) ≃ P_shape(M, K₀) ≃ Map_M(M, Require(K₀)).
```

Space-valuedness is essential: a Set-valued mediator would truncate the homotopy-shape information it is meant to carry. Before this becomes a target, the project must define M and K at the required level, define `P_shape` on objects and morphisms independently of `Allow` and `Require`, and state its homotopy coherence. Until then, the "mediator column" in `targets.md` is an interpretive locator rather than a third constructed category.

The branch-data gate comes first. The modal route currently suggests a bare `S²`; the Esquisse route uses a rigid three-marked projective line together with varying ramified covers. A cyclic bar construction supplies cyclic structure or an `S¹`-action, but does not by itself supply marked branch values or ramification. The research question is therefore whether the M side can acquire and preserve three-point branch / orbifold data, or whether the proposed meeting point must move.

The regular degree-60 A5 dessin is a gated finite test element for such a `P_shape`, after that branch structure exists. Its first test is structural—whether both presentations preserve compatible branch cycles and monodromy—and only secondarily whether the resulting group is A5. Failure to recover A5 from a bare suspension chain would show only that the branch data were absent. A single dessin may falsify a candidate component or compatibility law; it cannot construct an adjunction, verify naturality or triangle identities, or model the iteration. Its static finite symmetry supplies none of T_recursion's transition maps.

### Care-compatible episode morphisms

The checked Care anchor remains the involution `(–)⊥`. Arc/16 suggests a downstream semantic class of morphisms on which that involution would act coherently. A plausible technical home is a distinguished class of Kleisli arrows `M_t → T(M_{t+1})`, composed through the multiplication of the eventual cross-site monad. Such arrows can express successive actual episodes through changing contexts, whereas the existing `η`-orbit iterates one seed. This is a candidate complement to the current sequential-colimit construction, not a replacement or a settled refinement.

To earn the name *care-compatible*, the class would at minimum need a stated observational semantics, closure laws, compatibility with `(–)⊥`, and proofs that its replay preserves exactly the declared carriers, plurality, and future admissibility. The identity/no-ranking part depends explicitly on the unproved 2S no-leak theorem family; it is not scheduled independently of that work. Construction also requires the full adjunction/monad interface absent from the current `Iteration` scaffold, plus whatever cocompleteness and coherence hypotheses relate a changing-context Kleisli chain to a sequential colimit.

### Comparison-strength and iteration warnings

The faithful map `G_ℚ ↪ GT` is not a known proper inclusion: surjectivity remains open. It therefore supplies no precedent for counit non-invertibility, monad non-idempotence, or persistent iteration. Its useful lesson is methodological: faithfulness or monicity must not be confused with fullness, surjectivity, or equivalence. Structurally, the Esquisse-side theorem-shaper for recursion is the moduli tower, not any single dessin and not the unresolved gap between `G_ℚ` and `GT`.


## Candidate logical-presentation track: mode theory and indexed context

**Status and scope.** This section records the candidate research program for giving the **whole Hoapa framework** a mathematical-logical presentation. It is independent of the presentation's `R/P/A/D` conceptual diagram and of the Reality and provenance repairs above. Those concepts may eventually require types, effects, interfaces, or modalities in a Hoapa logic, but they do not determine that logic's modes in advance. This track is not a cascade layer, does not change T1–T_recursion, and reserves no Agda module. Its first task is discovery: identify the framework's genuine judgmental regimes and transformations before choosing an encoding.

The current candidate is **mode theory** in the broad line from adjoint logic through the Licata–Shulman–Riley fibrational framework, Multimodal Dependent Type Theory (MTT), and Multimodal Adjoint Type Theory (MATT). These frameworks can generate a type theory from a small presentation of modes, modalities, and transformations, and supply general metatheory such as cut admissibility, normalization, consistency, or canonicity under their respective hypotheses. This makes mode theory a credible presentation language. It does **not** establish that any current Hoapa noun is a mode, that any philosophical reciprocity is an adjunction, or that one existing multimodal calculus already contains all of Hoapa.

### Intended role

The target is a logical grammar whose models can include:

- the cohesive modal side;
- the actor-causal, sheaf, session, and operadic concurrency side;
- the concurrency-internal cartesian↔linear R4 bridge;
- eventually, the cross-site `Allow ⊣ Require` pair and its iteration;
- later extensions such as protocol versions, content, federation, provenance, and the Reality boundary, only after each earns a logical form.

The logical presentation should expose which structures are primitive, which are derived, and which are properties of models. A higher cohesive realization and a lower logical shadow may later be related by explicit interpretations or reducts, but neither is fixed at this stage. In particular, the higher theory is not obtained by "undoing truncation" of a lower one, and the syntax's initial model would establish freeness or least commitment relative to chosen rules, not social or engineering optimality.

### Three structures that must remain distinct

#### 1. Contextual indexing: telescopes, slices, and descent

Dependent type theory supplies the most natural current candidate for **context as point of view**. A telescope `Γ` is an iterated context extension; in categorical semantics, types in that context live over `Γ`, and in a topos or ∞-topos `ℰ` they are read in the slice `ℰ/Γ`. A substitution `f : Δ → Γ` induces base change `f* : ℰ/Γ → ℰ/Δ`, with the familiar dependent adjoints `Σ_f ⊣ f* ⊣ Π_f` when they exist.

This gives a disciplined interpretation of one logical grammar varying over contexts and suggests an indexed family such as:

```text
Γ ↦ Hoapa-structures internal to ℰ/Γ
```

It does not yet give the project's full recursion. Ordinary extension from `Γ` to `Γ.A` makes a new type-theoretic context, but it does not by itself show that a completed covering, protocol, or documentation generates a new world of inquiry. Likewise, slices do not supply a Grothendieck topology, descent, or a network of distinct topoi without additional data. These are separate naturality obligations.

#### 2. Operational phasing: CBPV and LNL

Call-by-push-value (CBPV) supplies a candidate distinction between **stable values** and **effectful computations**, connected by an adjunction `F ⊣ U`. Benton linear/non-linear logic supplies a related cartesian↔linear adjunction, with the linear exponential obtained from its composite. The relationship is close but not identity: CBPV emphasizes evaluation and effects, while LNL emphasizes cartesian and linear resource disciplines.

The checked point-generated R4 theorem is the grounded Hoapa fragment on this axis:

```text
Lpoint ⊣ Rpoint
```

over cartesian locality and linear/session-valued point sheaves, relative to the value-level LNL and finite-product hypotheses. This has the outer categorical shape needed for an LNL/CBPV investigation, but it is not yet a CBPV calculus, an operational semantics, or a process→artifact construction.

A promising interpretation is that a live conversation or document-producing activity is a computation, while a completed, citable artifact is a value. This is a **candidate phase distinction**, not a result. The current Agda constructs linear session-valued sheaves and cartesian locality sheaves; it does not construct the claimed stabilized artifact phase. Before adoption, the track must identify the extra structure that makes completion, persistence, copying, citation, and provenance coherent with R4.

#### 3. Framework-level modes and modalities

A Hoapa mode must denote a genuine **regime of judgment**, not merely a component, stakeholder, or sort. For every candidate mode `m`, the project must be able to state:

```text
Γ ⊢_m A
```

and explain what propositions/types `A` mean, what hypotheses may occur in `Γ`, which structural rules apply, and which category or higher category interprets the judgments. A mode morphism must act on judgments/types; a 2-cell must compare such actions. If an adjunction is claimed, its natural hom-equivalence, unit, counit, and triangles must be exhibited in a model.

This test deliberately does not preselect `R`, `Ag`, `P`, `D`, ModalHoTT, Concurrency, or the cascade layers as modes. Some may become modes; others may instead be effects, models, sorts, predicates, audits, factorization laws, or external interfaces. Reality in particular remains the constitutive exterior described in the preceding section, not an internal mode by default.

### Piecewise naturality protocol

Every proposed import into the logical presentation must be recorded in six parts:

1. **Intrinsic claim.** State the Hoapa claim without imported technical vocabulary.
2. **Mathematical kind.** Classify the required object: judgmental mode, modality, adjunction, effect, capability, factorization, descent condition, audit, transition, or model property.
3. **Nearest established structure.** Name the existing theory that appears to carry it.
4. **Exact gain.** State only what that theory supplies without further Hoapa assumptions.
5. **Missing obligations.** List the functors, equations, coherence, model, or theorem still required.
6. **Falsifier.** Give a small example or incompatibility that would show the proposed identification is wrong.

For a candidate mode, add a **mode-legitimacy table** with judgment form, context discipline, structural rules, semantic category, and at least one non-syntactic model. For a candidate edge, record whether it is a modality, effect/computation, audit/relation, or factorization law; only the first class belongs automatically in a mode theory. Mediation and descent must never be conflated: factorization through an interface and unique gluing of compatible local data are different laws.

### Grounded relationships, candidates, and rejected shortcuts

**Grounded or literature-backed:**

- mode theories can present interacting modal and substructural logics and can support reusable metatheory;
- dependent contexts have slice/base-change semantics, with `Σ_f ⊣ f* ⊣ Π_f` under the usual hypotheses;
- CBPV separates values from computations and factors effects through `F ⊣ U`;
- LNL separates cartesian and linear regimes;
- point-generated R4 is a machine-checked sheaf-level LNL adjunction under its stated hypotheses;
- cohesive modalities are geometric/modal structure and must not be identified with operational roles without a theorem.

**Candidates to test:**

- a fixed Hoapa logical grammar interpreted in every contextual slice;
- compatibility of that grammar with reindexing, covers, and descent;
- an R4-supported CBPV interpretation of protocol execution;
- a constructed transition from live linear processes to stable artifacts;
- an indexed or fibred mode theory combining contextual and operational structure;
- a later derivation or concrete model of `Allow ⊣ Require` from independently justified ingredients.

**Rejected as present conclusions:**

- `R/P/A/D` are already the four modes of Hoapa;
- every reciprocal conceptual relation is an adjunction;
- the contextual and operational structures are proved independent or orthogonal;
- the CBPV value/computation distinction already solves the session/document distinction;
- context extension `Γ.A` already is evolutionary context generation;
- mediation already is sheaf descent;
- R4 already is the cross-site adjunction;
- the cross-site adjunction simply reads off from a mode diagram;
- initiality or a free adjoint proves optimality;
- one can reconstruct the higher framework uniquely from a lower logical reduct.

### Candidate architecture, held loose

The current least-committal shape is a context-indexed family of models of a not-yet-fixed Hoapa grammar:

```text
Γ ↦ Mod_Hoapa(ℰ/Γ)
```

with reindexing along context maps and, where a topology is present, descent along covers. Within each fiber there may be an operational value/computation or cartesian/linear adjunction. Cohesion may structure the ambient contextual geometry. None of these placements is yet an equality of structures.

The central compatibility questions are likely Beck–Chevalley- or Frobenius-shaped: does contextual reindexing commute coherently with the operational adjunction, and do the resulting structures descend? These questions are more informative than selecting a large fixed mode graph in advance because they test whether the two candidate dimensions genuinely form one logical system.

### Staged investigation

1. **Claim inventory.** Extract the framework's actual judgmental distinctions and transformations from `motivation.md`, `arc.md`, `targets.md`, the Agda interfaces, and the candidate-hole sections. Do not translate them yet.
2. **Legitimacy pass.** Apply the mode/edge tests and the six-part naturality protocol. Produce the smallest candidate grammar and record rejected identifications.
3. **Toy semantics.** Construct a finite Set-valued or presheaf-valued model. The first goal is consistency and intelligibility, not coverage of the cascade.
4. **R4↔CBPV test.** State exactly which extra action, enrichment, term, or effect data turns the point-generated LNL adjunction into a CBPV-like model, and construct or reject the process→artifact phase.
5. **Context-indexing test.** Reindex the toy/R4 structure along a small family of context maps; formulate the relevant Beck–Chevalley/Frobenius comparisons; then test descent on a finite cover.
6. **Framework choice.** Only after the toy models decide whether LSR-style adjoint logic, MTT, MATT, linear dependent type theory, dependent CBPV, an indexed combination, or a custom calculus is the natural host. The existing Cubical Agda development and external tools such as multimodal proof assistants are implementation options, not selection criteria.
7. **Higher/lower comparison.** Once syntax and at least two semantics exist, define any reduct/interpretation explicitly and state what it forgets. Investigate an initial syntactic model and free/forgetful constructions without reading them as optimality results.
8. **Cross-site instance.** Attempt `Allow ⊣ Require` only after the modal-context semantics, structured concurrency semantics, and their compatibility laws have independent definitions.

### Possible theorem targets

- soundness and normalization inherited from a host framework after an adequate encoding theorem;
- adequacy of the toy model for the chosen Hoapa judgments;
- stability of the operational adjunction under contextual reindexing;
- Beck–Chevalley/Frobenius laws relating context change and operational phase change;
- descent of Hoapa-model structure over a cover;
- a universal property for process→artifact stabilization;
- a preservation theorem for a later higher→lower reduct;
- a concrete non-collapse or non-trivial-iteration witness for the cross-site instance.

The first Hoapa-specific mathematical value is most likely to lie in one of the compatibility theorems, not in the bare declaration of modes. Novelty should be claimed only after comparison with multimodal, linear dependent, effectful, and indexed type theories.

### Relationship to the candidate holes

Reality and provenance remain independent candidate repairs. They should be consumed by the logical-presentation track only after their mathematical kinds are clear. Reality may contribute an external effect/capability boundary; provenance may contribute an audit, indexed history, or transition structure. Neither should fix the mode graph or dominate the logical presentation of the whole framework. Conversely, the mode-theory track must eventually explain how such interfaces attach if they are promoted, rather than treating their prose as primitive modalities.

### Decision gates

1. What are the first genuine Hoapa judgments, and which differences between them require distinct modes rather than distinct types or effects?
2. Is the contextual organization one ambient `ℰ` with slices, a network of topoi, or a staged combination?
3. Does R4 admit the extra structure required for a CBPV interpretation, and what exactly is a stabilized artifact?
4. Do contextual reindexing and the operational adjunction satisfy coherent comparison laws?
5. Which host framework expresses the smallest validated grammar without forcing unsupported structure?
6. Which model beyond syntax demonstrates that the presentation is not merely a restatement of its rules?
7. What precise property would make the eventual logical presentation foundational for Hoapa: initiality, classifying semantics, conservativity, theorem transport, or another universal property?

### Research anchors

- Licata–Shulman, *Adjoint Logic with a 2-Category of Modes*.
- Licata–Shulman–Riley, *A Fibrational Framework for Substructural and Modal Logics*.
- Gratzer–Kavvos–Nuyts–Birkedal, *Multimodal Dependent Type Theory*.
- Shulman, *Semantics of Multimodal Adjoint Type Theory*.
- Levy, *Call-By-Push-Value* and *Adjunction Models for Call-By-Push-Value with Stacks*.
- Benton, *A Mixed Linear and Non-Linear Logic: Proofs, Terms and Models*.
- Vákár, *A Framework for Dependent Types and Effects*.
- Vákár, *Syntax and Semantics of Linear Dependent Types*.

### Discussion of "truncate everything"

#### Claude

❯ Now, I want to briefly discuss, on a philosophical level, how the framework can use the analogy between unityping of actors and the distinguishability of elements of a set         
  introduced by the axiom of choice. A target I have in the back of my head is to be able to "truncate everything in the framework" into a purely set theoretical setting, killing a  
  large part of the structure, and crucially, what makes it implementable, but still be able to say something meaningful at this level and in this language. Truncation itself I      
  think would be our main tool, but in some places we're probably going to have to be more subtle, and in the end construct a sort of Yoneda-like functor that retains something of   
  the rich structure in the low structure, that truncation would have simply ignored.                                                                                                 
  First, do you see this as a. interesting? b. feasible? c. possibily of some help for our conjecture? (since set theory is actually what most everyday-mathematicians want their     
  math to be grounded upon, I think we should be able to have a meaningful portal from the rich & collective setting to the low & individual setting)                                 
  
● Short verdict: a. yes, genuinely; b. feasible, but only if you're precise about what "truncate" and "set-theoretic" mean; c. yes, but as a measuring/demonstration instrument for 
  the conjecture, not as a proof of it. Let me give you the substance, including two places where I'd push on the framing.

  The framing needs sharpening in two spots

  1. "Truncation" is not one operation. What you're calling truncation is really a family of collapses along independent axes of richness, and only some are h-truncations:

  - homotopical (h-levels): 0-truncation ‖-‖₀, a genuine modality in cubical, kills higher paths;
  - cohesive/modal (the modal side): passing to discrete objects trivializes shape/flat;
  - locality (the sheaf side): global sections Γ, or evaluation at a point, collapses descent;
  - linear (the coefficient side): the Benton right adjoint G, which is exactly the "take the points" map — in Chu, G(A)=A⁺, discarding the state-carrier A⁻. That's the transcript's
  !-erases-A⁻ observation, read as a truncation.

  Treating these as one tool is where it would go wrong. They're distinct forgetful/reflective functors, and the interesting content is which invariants survive each.

  2. "Purely set-theoretic" has to mean Set-valued, not bare sets. This is the crux, and it's exactly your Yoneda instinct made honest. You cannot retain rich structure in bare-set
  objects — that's what "the higher structure is nontrivial" means. But you can retain all of it in Set-valued functors: Yoneda embeds any category faithfully into [C^op, Set]; the
  nerve stores an ∞-category in simplicial sets; a symmetry-carrying set is a functor BG → Set. So the portal doesn't land in Set, it lands in presheaves / relational structures over
  Set — ordinary mathematics, which is what everyday mathematicians actually mean by "grounded in sets," not a single bare set. With that reading your goal is achievable; with the
  bare-set reading it's provably lossy, and the loss is the whole point.

  Why it's more feasible than it looks: two portals are already built

  The mature name for "truncate but keep an invariant" is decategorification (Baez–Dolan) — groupoid cardinality retaining what π₀ forgets is the prototype. And the framework already
  contains two decategorification-style portals:

  - The SET endpoint of the finite sheaf construction (you already instantiate the generic descent at coefficients = Set): the collective descent has a set-level shadow already.
  - Chu(Set, Bool) is itself the portal for the linear axis. It is pure set-theoretic data — two sets and a Bool-valued pairing, i.e. a relation — that nonetheless carries
  ⋆-autonomous structure. So the one axis where naive truncation must fail (linear structure can't live in cartesian Set objects) is precisely the one where the framework already
  encodes the structure in set-level relational data. That's your Yoneda-like retention, concretely, and it's checked.

  The genuinely beautiful part: the actor axis carries the conjecture's content

  Here the AC analogy pays off exactly. Truncating to a classical, choice-holding Set setting is distinguishing the actors — Booleanization gives decidable equality, which
  individuates them. So the passage rich→low is literally collective → individual: the uniform, unityped, no-privileged-viewpoint community collapses into a set of atomized,
  choosable elements. And what breaks in that collapse is precisely the "no privileged points of view" / actor-renaming-invariance theorem.

  That tells you what a faithful portal on this axis must retain: not the set of actors, but the relabeling symmetry acting on it — a G-set, a functor BG → Set, a presheaf on a
  delooping. Which is exactly the homotopical richness bare-set truncation throws away, and it points straight at the modal side's Bℤ site: deloopings are the canonical retention of
  the symmetry that sets forget. So the renaming-invariance theorem is not just a nice property; it is the obstruction that measures the collective→individual collapse. The portal's
  failure to be faithful on the actor axis is the theorem.

  For the conjecture

  It helps in two honest ways, neither of which is "it proves T1":

  - It makes the foundation/praxis split measurable. The kernel of the portal — what truncation kills — is exactly the praxis surplus: implementability, concurrency, the collective.
  Foundation-adequacy = the statements survive to the set-level target; praxis-adequacy = the doing lives only upstairs. The portal turns the Grothendieck/Hersh thesis into a
  comparison you can point at, rather than a slogan. That is strong, and it's aimed precisely at the set-minded reader you want to reach.
  - It's structurally on-brand. rich⊣low and collective⊣individual are themselves adjunction-shaped, orthogonal to Allow ⊣ Require, and fit the framework's "every separation is an
  adjunction" motif.

  The caution: "truncate everything" can trivialize into "of course Set can host the statements," so the value is never the truncated object; it is the kernel and the
  non-faithfulness. The creative act is choosing the retention invariant (which is not canonical — Yoneda retains everything but only into presheaves). Pick the wrong one and you get
  a tautology; pick the right one (equivariance for actors, Chu for linearity, nerve for the homotopy) and you get a shadow theorem that says something.

  Want me to try stating the portal as an actual functor — domain, codomain, and the one invariance it's required to preserve — and see whether it survives contact, the way the
  outside instance offered to pressure-test the negative? That would tell us fast whether "meaningful shadow" or "tautology."

#### Codex

• This is a strong answer. I agree with most of it, with a few corrections to keep it from becoming too smooth.

  The best part is the warning that “truncation” is not one operation. That is exactly right. In this framework we have at least:

  - homotopy truncation;
  - forgetting cohesive/modal structure;
  - taking global sections or points of sheaves;
  - forgetting linear structure through an adjoint;
  - decategorifying operational traces;
  - replacing equivariant/community structure by bare sets.

  Those are different functors with different kernels. The interesting mathematics is not “we truncate everything,” but “which invariants survive which forgetful move?”

  I also strongly agree with the “Set-valued, not bare sets” correction. A meaningful low-level portal should not usually land in an unstructured set. It should land in ordinary set-
  based mathematics: presheaves, relations, graphs, G-sets, simplicial sets, Chu spaces, structures over Set. That is still “set-theoretic” in the everyday mathematical sense, but it
  can retain shape, symmetry, incidence, duality, and observables. Bare-set truncation is mostly useful as a failure mode.

  Where I’d be more cautious:

  1. “Booleanization gives decidable equality, which individuates actors.”
     This is philosophically useful, but technically it depends on where the actors live. In our current theorem, actor-uniformity is site-level/naturality/equivariance, not
     undecidable equality inside a topos. Classical Set can distinguish elements, yes, but the more relevant loss is not just decidable equality. It is forgetting actor-renaming
     symmetry and no-leak constraints.

  2. “The portal’s failure to be faithful on the actor axis is the theorem.”
     This is promising, but not yet a theorem. The honest theorem shape is something like actor-renaming invariance / no-leak: relabeling actors changes presentation, not trusted
     observable content. Then a bare-set portal fails exactly because it remembers actor identity too strongly or forgets equivariance too aggressively, depending on the direction.

  3. “Every separation is an adjunction.”
     Useful slogan, dangerous as a rule. Some separations are adjunctions, some are fibrations, some are quotient/forgetful maps, some are noninterference constraints, some are just
     interface boundaries. We should keep the adjunction motif, but not force it.

  What I think is genuinely valuable here:

  - It gives a good name to a future track: set-level shadows or ordinary-mathematics shadows.
  - It clarifies that the goal is not to reduce Hoapa to Set, but to build controlled reducts into set-based structures.
  - It says the real information lies in the kernel: what the reduct forgets, what it preserves, and what obstruction appears when you try to recover the upstairs structure.
  - It links well to the next formal target: actor-renaming/no-leak as the first “shadow theorem.”

  My suggested formulation of the direction:

  > Build a family of named reducts from the rich Hoapa structures to set-based structures. Each reduct must state what it preserves, what it forgets, and which non-faithfulness or
  > obstruction measures the lost praxis structure.

  I would not yet try to make one grand Yoneda-like functor for the whole framework. Start with three portals:

  1. Actor portal: from actor-causal contexts to equivariant set-based structures, preserving relabeling invariance.
  2. Linear portal: from Chu/LNL coefficients to relational set-based data, preserving duality enough to witness the linear shadow.
  3. Sheaf portal: from event-local sheaves to Set-valued sheaves or global sections, measuring what descent loses.

  Then later ask whether they assemble into one doctrine-level reduct.

  So: yes, interesting; yes, feasible in pieces; yes, useful for the conjecture as a measuring instrument. But it should be developed as a family of carefully named reducts, not as
  “truncate everything” in one stroke.

## Emails for extended abstract

2. Email Plan

  I’d write 3 core emails, with a possible 4th if we have a very specific target.

  Audience A: Formalization / Cubical Agda / proof assistant people

  Angle:
  “This is a modest theorem, but a checked integration of Chu, Benton LNL, finite sheaf/descent, and cubical Agda infrastructure.”

  Topics:

  - postulate-free Chu coefficient model;
  - Benton LNL interface;
  - event-local sheafification;
  - why Cubical Agda matters.

  Ask:
  “Does this look like reusable formalization infrastructure, and is there a natural venue/community for it?”

  Response strategy:
  Make the ask concrete: not “is Hoapa interesting?” but “is this formalization package legible/useful?”

  Audience B: Categorical logic / linear logic / LNL people

  Angle:
  “We have a small checked Benton-style sheaf lift, with a concrete Chu coefficient instance.”

  Topics:

  - LNL adjunction lifted to event-local sheaves;
  - Set ↔ Chu(Set,Bool);
  - resource-sensitive coefficients vs cartesian locality;
  - limitations explicitly stated.

  Ask:
  “Is the formulation mathematically honest, and are the hypotheses the right ones?”

  Topics:

  - actor-causal site;
  - site/fiber separation;
  - event-local descent;
  - path toward richer causal descent and operational session semantics.

  Ask:
  “Does this site/fiber framing look like a useful categorical model of interaction, and what next theorem would make it compelling?”

  Response strategy:
  Aim for strategic feedback, not acceptance. They care about payoff.

  Optional Audience D: HoTT / foundations / modal type theory

  Angle:
  “This is the first operational fragment of a larger modal/cohesive architecture.”

  - the theorem as the K side;
  - eventual M ↔ K adjunction;
  - cubical/funext relevance;
  - future mode-theoretic presentation.

  Ask:
  “Is the foundational Outlook coherent, or does it overstate what the checked theorem supports?”

  Response strategy:
  This email should be the most cautious. It risks sounding grand unless the modest theorem is foregrounded first.

  General Email Dynamics

  Each email should be short:

  - one sentence of context;
  - one paragraph stating the theorem;
  - one paragraph saying why we’re contacting them specifically;
  - one concrete question;
  - links to PDF, repo, and theorem entry file.

  The key tactic is to ask for a bounded judgment, not general approval. People answer specific questions; they ignore “what do you think of my framework?”

  • The plan is basically sound, but it needs one correction and one sharpening.

  First correction: the excerpt has a structural omission. Audience C is missing its header. The block beginning with:

  > actor-causal site; site/fiber separation; event-local descent...

  is clearly Audience C: Applied category theory / categorical concurrency. That needs to be restored, otherwise the plan jumps from B directly into topics without an angle.

  Second correction: for emails, I would now use site/coefficient separation, not site/fiber separation, because we deliberately chose that vocabulary in the abstract. “Fiber” is
  mathematically suggestive, but it is not introduced.

  The general strategy is right: each audience gets a bounded ask, not a plea for validation. That is the most important thing. The recipient should know exactly what kind of reply
  would help.

  My assessment by audience:

  A. Formalization / Cubical Agda
  Strongest near-term email. This is where the work has the clearest concrete value. The ask should be about reusable infrastructure, proof style, and whether the Cubical Agda
  packaging is legible. This is likely the best first batch.

  B. Categorical Logic / Linear Logic / LNL
  Useful, but should be humble. A specialist may find the theorem unsurprising, so the email should explicitly say “modest checked fragment” and ask whether the statement/hypotheses
  are clean. Do not lead with novelty here.

  C. ACT / Categorical Concurrency
  Potentially the most conceptually aligned, but also the most demanding. They will care less that the assembly typechecks and more whether the actor-causal site and site/coefficient
  separation pay off. The right ask is exactly: what next theorem would make this compelling?

  D. HoTT / Foundations / Modal Type Theory
  Highest risk, highest ceiling. The Outlook may interest them, but it can sound overextended. This should probably go only to people likely to tolerate speculative architecture, and
  the email must foreground the checked theorem before mentioning M ↔ K.

  One adjustment: I would not include all three links in every email if it makes the message look bulky. Use:

  - PDF attached;
  - repo link;
  - one “entry module” link only if the audience is formalization or technically likely to click code.

  Suggested send order:

  1. Formalization people first.
  2. Categorical logic/LNL second.
  3. ACT/concurrency third, after seeing if the first replies surface issues.
  4. HoTT/foundations last, and selectively.

  The exchange is good overall. It gives us a disciplined outreach strategy: different audiences, different value proposition, one bounded question each.
