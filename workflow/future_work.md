# Future Work

All aspects of the code that will need to be completed or corrected if we want to present it.

## Reader's note

This file documents two kinds of future work, in two styles:

- *Punchlist style.* The "Regarding X" sections (fracture, T_recursion iteration, Sessions, actor-causal site, Hybrid v1, Beyond fracture) catalogue deferred pieces *inside material that has already shipped*. They are item-by-item, code-grained, and read as ongoing maintenance / extension lists.
- *Architectural style.* The "Concurrency-side layers of complexity (planned)" section catalogues *committed-but-unshipped* layers. It is prose-heavy, structured around a Function / Math anchor / Trigger / Open questions / Agda slot rhythm, and is calibrated to be readable by both future Claude/Codex agents picking up the project and humans being shown the work.

Both styles are honest commitments. Neither category is implemented yet (in the punchlist style: not yet; in the architectural style: not yet *and* requires the punchlist items to be cleared first).

For the seed-level commitments these entries extend, see `motivation.md`. For the propositional decomposition (T1–T_recursion) they realize, see `arc.md` and `targets.md`. The implementation track — a real protocol kernel, a real verification runtime, LLM-tooling integration — is a separate concern, to be opened after several of the architectural layers below have landed at v1, and is not catalogued in this file.

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

`agda/ModalHoTT/Modalities/Iteration.agda` lands the iteration scaffold for T_recursion on the A-side: generic-adjunction-parameterized monad iteration `T^n`, iterated unit `η^_n`, operadic associator `η^-coherent` (derived from a postulated `η-naturality`), and the developing-network type `ND A` as the sequential colimit of `A → TA → T²A → …`. `agda/ModalHoTT/Modalities/IterationCohesion.agda` provides the A-side sanity check at ʃ ⊣ ♭, including the first-level collapse `η-equiv-at-T : T A ≃ T(T A)` derived via the `Discrete.agda` bridge.

Pieces deferred:

- **B-side dual.** A symmetric module would iterate the *counit* of the comonad `L ∘ R` on the target side, taking the *limit* of a decreasing tower `… → M²B → MB → B`. Not written yet because: until the cross-site adjunction `Allow ⊣ Require` is stated and `ND` has non-trivial content, the dual is a duplicate of an empty scaffold. The 1=2 identity is conjecturally the equivalence between the A-side colimit `ND A` and the B-side limit `ND_B (L A)` via the adjunction — stateable only once both halves exist. Revisit when Concurrency-side scoping commits enough that `Allow ⊣ Require` can be postulated.

- **Cyclic-operad involution.** The 1=2 perspective-swap "cared-for = caregiver" would be a path constructor (or separate HIT) on top of `SeqColim`, encoding that the iteration is cyclic / self-dual on each level. Deferred for the same reason as the dual: adding the involution to a scaffold that hasn't yet produced non-trivial iteration content is premature.

- **`η-naturality` postulate.** Load-bearing for `η^-coherent`. Same shape and same resolution path as `shape-flat-natural-B` in `Properties.agda` — becomes a theorem once adjunction-naturality is recorded (status.md Open Questions). Not new scope; folds into the existing naturality gap.

- **Full sequential-colimit convergence.** `IterationCohesion.agda` proves the first-level collapse `T A ≃ T(T A)`. Lifting this to `ND A ≃ T A` (the colimit's value, not just the step) requires a "convergent sequence has colimit at the convergence point" lemma against cubical's `Sequence` / `SeqColim` infrastructure (`Cubical.Data.Sequence.converges`). Straightforward but heavier than the step lemma; left as a follow-up if a downstream use forces it (e.g. when stating the 1=2 identity via the B-side dual).

## Regarding Sessions and the canonical O_1 action

`Concurrency/Algebras/Sessions.agda` v1 landed with the `O_1` action (`gen`, `plug`, `shift`) packaged as explicit data rather than derived from the current categorical structure. This is the right current shape. The present `StarAutonomous` signature is intentionally thin: it has tensor, unit, braiding, duality, and local iso laws, but not the closed/evaluation structure or coherence needed to construct interaction composition canonically.

What shipped: a `SessionO1Action` record containing `gen-morph`, `plug-morph`, `shift-morph`, and the six laws mirroring `O`'s path constructors. `Sessions.agda` constructs `Valuation` and `OperadAlgebra` from that action, defines `session-interp` by HIT recursion, and names both R8 faces: syntactic `dual-involutive` and categorical / operadic `boundary-swap-at-gen`. This is better than loose postulates and does not pretend the action is intrinsic to session syntax alone.

The eventual quality target is stronger: replace the action assumption with a canonical definition from categorical/session structure. That should come back as a priority when the project reaches a richer session-category phase, after enough hybrid integration clarifies what the value-category morphisms mean operationally, but before serious `MO_1` / modular-envelope work.

Expected ladder:

1. **Done:** `Sessions.agda` v1: minimal session syntax, inductive structural `Hom`, and an explicit `SessionO1Action` assumption.
2. **Done at finite-descent and finite sheaf-category level:** Hybrid integration now has arbitrary-frame `FramePresheaf` / `SessionPresheaf`, zero-postulate separatedness, category-generic finite products, finite frames/covers, category-generic finite event-product descent, the constant-slot Sessions sheaf, proof-level tiny finite-cover validation, the V-valued finite sheaf/value category, and the framework-at-`SET` finite sheaf category with a concrete Set event-product object. The finite Coverage/library comparison has landed, and R4 now has the Benton/LNL presheaf bridge, right-adjoint sheaf preservation, a finite-sheafification interface, a conditional sheaf-level adjunction, and the point-generated supported reflector; event-dependent slots and the generic full finite actor-causal reflector remain pending.
3. Richer session category: add proof terms or an equivalent categorical semantics, cut as composition, cut-elimination/equality, closed structure/evaluation, and enough tensor/braiding coherence to manipulate long tensor strings.
4. Canonical `O_1` action: define `SessionO1Action` rather than assume it. `shift` should come from coherent cyclic permutation of tensor factors; `plug` should come from closed/evaluation/cut structure composing two morphisms into the dualizing object.
5. Only then push hard on `MO_1`: extend the canonical `O_1` action toward self-gluing / conversation-promotion / modular closure.

Practical trigger: when the session target can state and use an evaluation/cut map of the form `eval : Hom ((A ⊸ B) ⊗ A) B` (or the equivalent polycategorical/sequent form) and can coherently rotate tensor factors, the deferred derivation of `gen`, `plug`, and `shift` should return to the top of the B-side queue.

## Regarding the actor-causal site

`Concurrency/Sites/{ActorBase,ActorCausal}.agda` v1 landed the R6 locality leg: opaque unityped actors, Lamport-style event causality, actor-local frames, strict-reflecting `FrameHom`, basis-form covers, `sieve-of`, generic identity / transitivity cover constructions, and a Bool-based non-trivial witness (`TinyAB`, `TinyCausal`, `PointFrame`, `embed-point false` / `embed-point true`, `two-point-cover`). This was enough for Hybrid v1's restriction adapter to land.

Pieces deferred:

- **Stability without legacy fallback.** `ActorPullback.agda` now gives the generic pullback frame construction and `stability-cover-pullback`. `ActorCausal.agda` still keeps `stability-cover-postulate` as an in-file fallback for the bundled `tiny-site`, because moving the bundled site to the pullback proof would create an import cycle. Future concrete site modules should import `ActorPullback` and use the constructed stability path rather than adding new postulates.

- **E2 sieve / Grothendieck topology presentation.** On the finite subsite, the library-site presentation has landed: `FiniteBasisCover` strips finite covers to base-stable covering-family data, `FiniteFrameCoverage` gives a Cubical `Coverage` over `FiniteFrameCategory`, and `SetSheafComparison` proves the SET sheaf-condition agreement. For the full non-finite actor-causal site, `Cover` remains basis-form and `sieve-of` remains the bridge artifact; add a full generated-sieve topology only when a later construction needs the non-finite site.

- **Promotion morphism class.** Strict `FrameHom` reflection deliberately prevents quotienting or reifying a sub-conversation as a single event / actor. The conversation-as-actor move belongs to a future promotion morphism class, coordinated with `MO_1` and the program-verification / conversation-of-conversations track.

- **Richer concrete site witnesses.** The bundled Bool tiny-site still discharges `ActorCausalSite` stability by the legacy postulate. The Strategy D finite coverage path does not depend on that fallback: it derives finite pullback patches and Cubical pullback stability directly. A future v2 witness may still route the bundled tiny site through constructed stability if the import-cycle issue is resolved.

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
- It does not by itself claim a full Set-valued locality topos/internal logic or an inhabited R4 bridge.
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
5. Deferred beyond Brick 4: exposition, SET/Sessions or other instantiation checks, `vProd` for the intended V, normalized-pullback / stability for a full Cubical `Coverage` presentation of the point-generated topology, the full actor-causal finite sheafification reflector, event-dependent session slots, and the A-side modal-context category with cross-site `Allow ⊣ Require`.

## Chu construction

Chu is deferred, not rejected. Benton/LNL is the right R4 choice because R4 is a relationship between already-existing B-side endpoints: cartesian Set-valued locality sheaves and V-valued linear/session sheaves. Chu answers a different question: what the linear value category might be internally, and how process/context duality should be built into its objects.

**Why not now.** Opening Chu during R4 would relocate the work from bridging `Sh_fin(site,Set)` and `Sh_fin(site,V)` to redesigning or comparing the value category `V` itself. That would force early choices of a dualizing object `k`, a comparison between `Sessions-Cat` and `Chu(Set,k)`, or a replacement of the current session value category. It would also make no-leak harder to state, because Chu objects carry both point and state components. R4 needs the forgetful/cartesian-to-linear axis first; Chu lives on the Care / process-context-duality axis.

**What Chu buys later.** A Chu object `(A⁺, A⁻, r : A⁺ × A⁻ → k)` makes extension/intension, point/state, process/context reversal, and duality intrinsic. This is a natural home for formal concept analysis, Barwise-Seligman-style information flow, and the cobordism / cup-cap dictionary attached to the Care involution. It is also a strong candidate for the deeper shape of the value category once the content layer Λ and information-cohomological pairing become active.

**Likely entry points.**

- As a candidate value-category instance once the Benton/R4 reflector construction stabilizes.
- As a comparison target for `Sessions-Cat` when the project asks what the session value category really is, rather than how to bridge it to Set-valued locality.
- Inside the Bulk/Content layer Λ, where extension/intension and incidence are the subject rather than auxiliary structure.
- In the field-theoretic / cobordism dictionary, where process/context reversal and dualizing objects are load-bearing.

**Agda slot.** Do not create a Chu module during R4. When triggered, likely homes are `Concurrency/Algebras/Chu.agda` for the value-category construction, or `Concurrency/Content/Chu.agda` if the first use is content/FCA rather than session semantics.

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

**Under the three-track strategy:** the differential rung is deferred to `agda/AnalyticTest/` (see folder README); structural and named-coefficient remain on synthetic + `Analytic/`. The "future work" framing above is updated accordingly — differential is deferred to a specific track, not indefinitely.

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
- Pivot to the B-side / Concurrency stub.
- Open AnalyticTest if signature stability has settled.

## Concurrency-side layers of complexity (planned)

The Concurrency side, at the time of writing, has shipped the actor-causal site, pullback overlaps, the cyclic operad `O_1` and its `*`-autonomous algebra interface, the Sessions instance, the Hybrid v1 presheaf/restriction adapter, finite-site event-product descent with constant-slot Sessions and Set instances, the concrete tiny finite-cover validation, finite sheaf categories at both `StarAutonomous→Category V` and `SET`, the finite Coverage/SET library sheaf comparison, and the R4 Benton/LNL finite-sheaf bridge through conditional Tier 4: presheaf-level change of base, presheaf-level adjunction, right-adjoint sheaf preservation, a finite-sheafification reflector interface, and the sheaf-level adjunction conditional on a V-side reflector. The point-generated reflector route has also landed over the supported subsite: event-supported frames, incident point frames, event-supported point overlaps, the canonical point cover, `IsPointSheaf P ↔ PointLocal P`, abstract point products, pointification as a point sheaf, the point-sheaf category, the reflector functor, and the adjunction `a ⊣ ι`. The live frontier is exposition and optional instantiation of the point-generated R4 theorem. Several additional layers are committed in design but not yet in code. This section is the catalogue of those layers, with for each: what it does for the protocol's use in the human world (possibly with LLMs as participants), what mathematical structure it commits to (or, where the choice is open, what the candidates are), and what currently shipped scaffolds it presupposes.

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

### Implementation track — Elixir runtime, Agda trace kernel, Pijul-shaped persistence

This section distills the separate `workflow/elixir.md` transcript into future-work form. The transcript remains untouched for archiving; this is the durable plan.

The implementation should not wait for the full cross-site `Allow ⊣ Require`, `MO_1`, Reflexive Π, or Bulk Λ layers. Waiting for all long-horizon mathematics would stall the runtime behind work whose first implementation can already produce useful trace data. But the implementation also should not pretend to be verified before Agda has a small trace-checker-facing kernel.

**Minimum Agda trace kernel before meaningful Elixir work.** Open a `Concurrency/Protocol/` layer only when we are ready to specify finite traces directly:

- `Trace.agda` — finite raw traces: actor ids, event ids, causal parents, local frame membership, session action, payload/document hash.
- `SessionStep.agda` — enough syntax-level send/receive/dual endpoint checking to validate runtime messages.
- `Restriction.agda` — trace projection to local views, aligned with `FrameHom`, with functorial laws.
- `Auditability.agda` — no-leak and unityped-actor invariants for traces: session roles, payloads, and content must not refine actor identity.
- `Certificate.agda` — a small validation/certificate interface so an external checker can accept or reject runtime traces.

The first concrete target is a tiny trace example over the existing two-point finite cover. This keeps the implementation grounded in already-shipped finite-site machinery without requiring event-dependent session slots or the cross-site adjunction.

**Runtime split.** Elixir should own actors, supervision, message routing, durable event logs, and operator-facing runtime behavior. Agda should own the specification of well-formed traces and the laws the checker validates. A checker should sit between them: Elixir emits traces or certificates; the checker accepts or rejects them according to the Agda-pinned predicates. Do not try to extract the whole application from Agda.

**Pijul stance.** Build the Elixir system as Pijul-compatible / Pijul-shaped, not as a hard Pijul extension or fork at first. Pijul matches the arc because patches with dependencies, commuting independent changes, conflicts as first-class data, and partial clones line up with actor-causal/descent structure: local views, dependency structure, gluing obstructions, and coherent repair events. But Pijul is a VCS over file/change structure, while the kernel needs typed protocol traces. Semantic validity remains the checker’s job, not the VCS’s job.

Practical architecture:

1. Elixir runtime: actors, supervision, message routing, durable event log.
2. Agda specification: trace validity, restriction, session compatibility, auditability/no-leak.
3. Checker: validates traces or certificates emitted by Elixir.
4. Pijul-shaped patch layer: stores document/protocol changes, dependencies, conflicts, resolutions, and partial views when that representation fits.
5. Later libpijul/Rust integration only after the trace schema and patch-theoretic fragment category are honest enough; do not over-couple the first runtime to Pijul internals.

**Trigger.** Start the implementation track once the trace schema and first Agda well-formedness predicate are stable. It can proceed in parallel with remaining R4 work, but it must not claim verification beyond the trace predicates Agda actually states.

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

**Trigger / dependencies.** All four previous layers at v1 (Π for intra-protocol edits to translate; Λ for the content surface; field-theoretic dynamics for the comparison data correlators supply). `MO_1` for the GT-action. The R11 structuring relation (arithmetic action), currently deferred in `status.md` to the `MO_1` stage, is reclassified by this layer from "late-stage decoration" to "structural backbone of inter-protocol coherence" — without R11 the ecosystem of protocols is a discrete pile of unrelated structures, with it the ecosystem has a single canonical group of automorphisms relating all the translations.

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

The framework presumes a minimum modal complexity: not "any" modality, but the cohesive triple `ʃ ⊣ ♭ ⊣ ♯` with its specific non-collapse axioms (`♭` preserves products, pieces have points, the modal types form a non-trivial subuniverse), and eventually differential cohesion `ℜ ⊣ ℑ ⊣ &`. Below cohesion, the modal side is too thin for "complexity develops" to be a non-trivial claim — three modalities that collapse to one give no Lawvere asymmetry, no developing network, no genuine multi-level adjoint reasoning. Below differential cohesion, the modal side's field-theoretic output is restricted to synthetic cohomology and the central conjecture cannot land in its strongest form. In the Manin reading, complexity is generative recursion supported by multi-level adjoint reasoning; cohesion is the minimum modal structure that supports it. The mapping is sharp: separation-of-concerns on the concurrency side is the discipline that keeps content and actor-carrier as distinct mathematical objects, and cohesion on the modal side is the discipline that keeps spatial and discrete as distinct modal layers; both are the generative geometry of their respective side, neither is decoration. The framework-makes-sense floor is cohesion; the central-conjecture-can-land floor is differential cohesion. This reframing sharpens the existing `Beyond fracture` entry: differential cohesion graduates from "elevated to load-bearing for the cross-site bridge" to "the substance of A's field-theoretic output." No new construction work; non-removability of the existing commitments becomes part of the central claim rather than a working assumption.

This reframing is presented first in the appendix because the next reframing (the symmetric formulation, B) presupposes both cohesion and differential cohesion as floors; and the third (recursive co-evolution, C) presupposes both of those.

#### B. Symmetric formulation: the modal side outputs a field theory

The five layers above are concurrency-side. A complementary observation on the modal side closes a symmetry that is structurally exact and sharpens the central conjecture. Read this way, reframing B is the cross-side closure of the five-layer catalogue: the five layers describe the B-side outputs in detail, and reframing B states that A has the symmetric output structure (a field theory), with the cross-site adjunction `Allow ⊣ Require` as the current precise statement of the symmetry. The reframing is therefore the natural closing claim of the layered architecture, not a sibling addition to it.

*Notation update (2026-06-04): this file used `Allow ⊣ Mediate ⊣ Require` as older shorthand. The live structural target is now pair-first: `Allow ⊣ Require`, with Mediate, ambidextrousness, or a quadruple held only as future extra structure if earned. Where this section assigns `Mediate` a concrete role (e.g. the evaluation map of the (co)homology pairing in Layer 5), read it as a candidate extension of the pair, not as a settled commitment.*

The modal side, once differential cohesion lands (the `ℜ ⊣ ℑ ⊣ &` triple, currently in `Beyond fracture` above), is a synthetic field-theory construction kit in the sense Schreiber's program has developed for over a decade: smooth ∞-stacks as moduli of field configurations, Lagrangian field theory as variational calculus on jet ∞-stacks, BV/BRST quantisation as a derived construction on the moduli of solutions, twisted differential cohomology as the natural target for observables. The cyclic bar construction at S¹ (the deferred A-side work in `T_recursion iteration`) is the moduli-extraction step. So the symmetric statement is: *B has field-theory-shaped dynamics whose stabilized output is an internal type theory* (the five layers); *A has type-theory-shaped foundations whose internal semantics is field-theory-shaped*. The cross-site adjunction `Allow ⊣ Require`, with a possible future `Mediate` extension, is the precise statement that the field theory the modal side outputs and the type theory the concurrency side outputs are mutually adjoint readings of the same cohesive ∞-topos. This requires the existing A-side build-out (differential cohesion, cyclic bar) plus the concurrency-side layers above. The reframing does not change the immediate next steps; it sharpens the destination.

#### C. Recursive co-evolution: iterated cross-site adjunction

The five layers, taken together, support a reading larger than any of them individually: a sequence `(M_0, C_0) → (M_1, C_1) → (M_2, C_2) → …` where each (modal context, concurrency protocol) pair runs in its modal context and, through its activity — the field-theoretic output on the modal side, the reflexive-layer's protocol-edit machinery and the bulk-type-theory layer's content production on the concurrency side — refines the ambient enough that a new modal context `M_{n+1}` emerges, in which new protocols `C_{n+1}` become statable that were not statable in `M_n`. The sequential colimit (or, in a richer formulation, a 2-categorical colimit accounting for the adjoint maps between stages) is the stable evolution object. Convergence (with `Require ∘ Allow` acting as identity on the colimit) is one possible outcome; non-convergence is also informative, indicating that the iteration produces genuinely new structure at every stage — the Lawvere asymmetry on which T3 depends is what prevents trivial convergence. This admits recognizable counterparts in cosmology (vacuum-selection inflation), biology (niche-construction plus the major-evolutionary-transitions framework), the history of social institutions, and the development of mathematical practice itself; the project's claim is that those readings share a *formal categorical content*, not merely a slogan. The framing is *a formal frame for context-system co-evolution with recognizable interdisciplinary readings*, deliberately not *a generalized theory of evolution*: the precedent of cybernetics, general systems theory, and Wolfram's NKS is the cautionary tale this language is calibrated against (see `related_structures.md` § *Universal-theory precedents — the cybernetics-era pattern* for the precedent map), and the project's distinctive position is that the mathematics is being built first and the interdisciplinary readings come second, rather than the reverse. Mathematically, this is the long-horizon form of `T_recursion` lifted from a single adjunction to the iterated cross-site adjunction; the existing iteration scaffold in `Iteration.agda` is the baby version, the same machinery applied to a single pair of modalities.

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

### B-side category and R4

The finite sheaf framework now has both endpoints: `Sh_fin(site,V)` via `StarAutonomous→Category V` and `Sh_fin(site,Set)` via Cubical `SET`, each with a concrete constant-slot event-product object. The finite site-axis legitimacy work has also landed: `FiniteFrameCoverage` supplies the Cubical coverage, and `SetSheafComparison` proves the framework-at-`SET` sheaf condition agrees with the library condition. The R4 treatment has landed interface-first through conditional Tier 4: `ChangeOfBase.agda`, `LinearNonlinear.agda`, and `LinearNonlinearSheafAdapter.agda` prove presheaf-level Benton change of base, the presheaf-level lifted adjunction, and right-adjoint sheaf preservation; `FiniteSheafification.agda` names the finite-site reflector; `LinearNonlinearSheafAdjunction.agda` proves the sheaf-level adjunction conditional on a V-side reflector.

This keeps the two B-side poles separate: Set-valued locality sheaves carry cartesian/internal-logic structure; V-valued sheaves carry linear/session content. R4 is the named adapter between them, not a collapse and not the cross-site `Allow ⊣ Require` adjunction. The framework-at-`SET` category remains the canonical R4 endpoint; the library comparison is its legitimacy theorem, not a replacement endpoint.

Immediate inside this leg: write the theorem exposition and decide whether to add a concrete instantiation witness. Deferred beyond that: the normalized-pullback / stability layer needed for a full Cubical `Coverage` presentation of the point-generated topology, the full actor-causal finite sheafification reflector, enriching `Sh_fin(site,V)` with inherited linear / star-autonomous structure, constructing the free/forgetful Set-to-session adjunction rather than assuming it, proving full topos/internal-logic structure for the Set endpoint, and extending from the finite common site to the full actor-causal Set-valued topos.

### A-side category options

The A-side analogue of the actor/content divide is the cohesive split between discrete/formal structure and cohesive/spatial structure. The cohesive adjoints are the A-side adapter system. Options for `M` remain:

1. Native modal-HoTT category: types or modal types with functions. Cheapest, closest to current Agda, but weak as final architecture.
2. Semantic `Sh(Bℤ,Set)` / ℤ-action style category. Concrete, but risks overfitting the analytic Bℤ model.
3. Cohesive package: cartesian/discrete core plus cohesive total context plus the cohesion bridge. Preferred target, staged as an interface.
4. Category of modal contexts / cohesive topoi. Natural long-term, too heavy now.

Current lean: package A as cartesian/discrete core + cohesive context + cohesion adapter, mirroring B as Set-valued locality + V-valued linear content + R4 adapter. Do not hard-wire the exact flat/sharp/shape to typed/unityped/protocol slot assignment yet; T4 still needs a conscious settlement.

### Cross-site adjunction threshold

A stated `Allow ⊣ Require` interface alone is scaffolding. It becomes mathematically interesting when the functors are constructed from the ingredients and accompanied by a non-trivial example or theorem. First target the structured-package comparison, with a cartesian shadow and later enrichment-compatibility laws. The first compelling theorems would be non-collapse, nontrivial iteration of `Require ∘ Allow`, separation preservation/detection, R4 compatibility, or a concrete finite actor-causal example that crosses the adjunction and returns with controlled loss.
