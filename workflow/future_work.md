# Future Work

All aspects of the code that will need to be completed or corrected if we want to present it.

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
2. Hybrid integration: actor-causal base and sheaf valuation clarify how session values sit over actor-local frames.
3. Richer session category: add proof terms or an equivalent categorical semantics, cut as composition, cut-elimination/equality, closed structure/evaluation, and enough tensor/braiding coherence to manipulate long tensor strings.
4. Canonical `O_1` action: define `SessionO1Action` rather than assume it. `shift` should come from coherent cyclic permutation of tensor factors; `plug` should come from closed/evaluation/cut structure composing two morphisms into the dualizing object.
5. Only then push hard on `MO_1`: extend the canonical `O_1` action toward self-gluing / conversation-promotion / modular closure.

Practical trigger: when the session target can state and use an evaluation/cut map of the form `eval : Hom ((A ⊸ B) ⊗ A) B` (or the equivalent polycategorical/sequent form) and can coherently rotate tensor factors, the deferred derivation of `gen`, `plug`, and `shift` should return to the top of the B-side queue.

## Regarding the actor-causal site

`Concurrency/Sites/{ActorBase,ActorCausal}.agda` v1 landed the R6 locality leg: opaque unityped actors, Lamport-style event causality, actor-local frames, strict-reflecting `FrameHom`, basis-form covers, `sieve-of`, generic identity / transitivity cover constructions, and a Bool-based non-trivial witness (`TinyAB`, `TinyCausal`, `PointFrame`, `embed-point false` / `embed-point true`, `two-point-cover`). This is enough for R1 to become the next active bridge.

Pieces deferred:

- **Stability without postulate.** `stability-cover-postulate` is the sole actor-site postulate gap. A generic construction needs either pullbacks of `FrameHom`s in the frame category or the future sieve presentation where stability is stated by pulling back covering sieves. Worked concrete sites should replace the postulate with a proof when their topology is known.

- **E2 sieve / Grothendieck topology presentation.** `Cover` is basis-form because it matches implementation-facing local observations and finite witnesses. The semantic endpoint is the generated sieve topology. Future work should add a `Sieve` / covering-sieve record, define the topology generated by basis covers through `sieve-of`, and prove that basis-sheaves and generated-sieve-sheaves agree.

- **Promotion morphism class.** Strict `FrameHom` reflection deliberately prevents quotienting or reifying a sub-conversation as a single event / actor. The conversation-as-actor move belongs to a future promotion morphism class, coordinated with `MO_1` and the program-verification / conversation-of-conversations track.

- **Richer concrete site witnesses.** The Bool tiny-site exercises non-trivial covers but still discharges site stability by the postulate. A future v2 witness should compute pullback stability explicitly against `embed-point false` and `embed-point true`, or against a slightly richer finite causal frame.

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
