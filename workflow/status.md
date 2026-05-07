# Project Status

## Current Task

**Fracture theorem** — `agda/ModalHoTT/Modalities/Fracture.agda` (synthetic) + `agda/analytic/Modalities/Fracture.agda` (analytic test suite).

**Target: separation result via de Rham / local-global cohomology.** Exhibit something naturally stateable in cohesive HoTT that is not stateable in plain HoTT — specifically, the synthetic de Rham theorem (differential forms as maps ʃX → ♭ℝ; de Rham cohomology equals cohomology with flat coefficients). You cannot even define "locally constant" or "differential form" synthetically without ♭ and ʃ. This is the most direct formalization of the foundation-vs-praxis distinction.

The fracture theorem is the geometric backbone of the separation result: it is what makes ♭ and ʃ interact in a non-trivial way, and it grounds the local/global distinction that de Rham theory formalizes.


### Fracture theorem: what it says

For any type A, there is a canonical pullback square:

```
♭A ————→ A
 |              |
 ↓              ↓
♭(♯A) ——→ ♯A
```

- Top: `flat-counit : FlatModality A → A`
- Right: `sharp-unit : A → SharpModality A`
- Left: `flat-map sharp-unit : FlatModality A → FlatModality (SharpModality A)` (from Properties.agda)
- Bottom: `flat-counit {A = SharpModality A} : FlatModality (SharpModality A) → SharpModality A`

The square commutes by naturality of `flat-counit`. The fracture theorem is the claim that it is in fact a **pullback** — i.e., that `FlatModality A` is equivalent to the pullback type:

```
Σ[ a ∈ A ] Σ[ u ∈ FlatModality (SharpModality A) ] sharp-unit a ≡ flat-counit u
```

All four maps are available from existing files. The only new postulate is that this specific square is a pullback.

### Synthetic plan (Fracture.agda)

One postulate: `FractureSquare : (A : Type ℓ) → FlatModality A ≃ <pullback type>`.

Commutativity of the square — needed to even state the pullback correctly — should be derivable from `flat-sharp-counit-compat` in Adjunctions.agda plus flat functoriality. Attempt to prove it; postulate if blocked.

### Analytic plan (analytic/Modalities/Fracture.agda)

Verify the fracture equivalence for `ℤ` — discrete type; ♭ℤ ≃ ℤ and ♯ℤ ≃ ℤ; pullback should collapse cleanly. Concrete definitions of ♭ and ♯ for ℤ are now in `Analytic.ModalHoTT.Modalities.Cohesion` (all trivial — identity maps).

S¹ excluded: site is Bℤ with ℤ foregrounded; including S¹ would reintroduce the topological viewpoint we deliberately set aside.

## Semantic Background

**The site is Bℤ — the delooping of ℤ.** This is the intended semantic model justifying the cohesion axioms. It does not appear as an Agda object; it lives here as documentation. Bℤ ≃ S¹ as ∞-groupoids, but we foreground the group structure of ℤ because: the intrinsic covering structure comes from subgroup inclusions nℤ ↪ ℤ; the comonad story connects cleanly to ℤ-actions; and Lawvere's fixed-point theorem is most natural in the algebraic/discrete setting ℤ provides.

## Analytic Development

`agda/analytic/` mirrors the synthetic structure but contains no postulates. Its purpose is to **demonstrate non-vacuity**: show that the synthetic postulates are consistent and that ♭ draws a real distinction between types. It is not a full verification of the postulates in an external model — that requires genuine cohesive type theory (see Decisions Log, 2026-05-07: crisp contexts).

The centrepiece result is `¬-IsFlatModal-delooping` in Cohesion.agda: machine-checked proof that Bℤ is not flat-modal. This is the strongest claim the analytic folder can make without cohesive type theory infrastructure.

For the adjunctions, only ℤ instances are verifiable in plain cubical Agda (all modalities are identity; adjunctions are reflexivity). The type-level adjunction for non-discrete types is out of scope here; see Adjunctions.agda for the diagnosis and the intended future path.

**Library contribution goal (downstream):** Postulate-free, general results from the analytic folder are candidates for contribution to the cubical Agda library, which has no cohesion module. Write for the test suite first; if results come out clean and general, contribute. Do not let this target slow development.

## Decisions Log

| Date       | Decision | Rationale |
|------------|----------|-----------|
| 2026-05-06 | Synthetic/axiomatic approach | Site is semantic background only; modalities are postulated axioms, following Wellen/Myers/Shulman |
| 2026-05-06 | Site is Bℤ (semantic only, not an Agda type) | Delooping of ℤ foregrounds algebraic structure; intrinsic covering; cleaner for comonad story |
| 2026-05-06 | Cubical Agda | Actively maintained; HITs first-class; univalence built-in |
| 2026-05-06 | Long names over math notation in identifiers | e.g. `ThreePointedStruct`, `FlatModality` |
| 2026-05-06 | Concurrency stub named `ThreePointedStruct` | Name is structure-agnostic in case we switch from circle to sphere |
| 2026-05-06 | Shape/sharp use non-dependent recursion in Cohesion.agda | Dependent induction requires fiberwise modality conditions; deferred |
| 2026-05-06 | `flat-intro` postulated unconditionally | Agda lacks crisp-context support; noted in comment as a deviation from mathematical intent |
| 2026-05-06 | Drop `--safe` flag | `--safe` forbids `postulate`; axiomatic approach is inherently outside Agda's safe fragment |
| 2026-05-07 | Adjunctions stated as hom-set equivalences (`≃`), named operations defined from them | Hom-set form is the direct usable data; named operations are one-liner definitions, not extra postulates |
| 2026-05-07 | Added `flat-counit-intro` to Cohesion.agda | Missing β-rule for ♭ (holds definitionally in crisp-context HoTT); needed to derive IsFlatModal (♭A) |
| 2026-05-07 | IsFlatModal (♭A) proved as theorem; IsSharpModal (♯A) and IsShapeModal (ʃA) postulated | ♭ has dependent induction (flat-ind); ♯ and ʃ idempotency derivation blocked on their dependent induction principles |
| 2026-05-07 | flat functoriality laws proved; ʃ/♯ map laws postulated | flat-ind gives full dependent elimination; ʃ/♯ laws blocked on same gap as idempotency |
| 2026-05-07 | Two-track development: agda/ (synthetic) + agda/analytic/ (analytic) | Postulates bypass Agda; analytic folder is where the proof checker verifies claims; acts as test suite and potential library contribution source |
| 2026-05-07 | Fracture theorem as next conjecture-directed file | Separation result is the arc target; fracture is the geometric backbone; all maps already available from existing files |
| 2026-05-07 | Arc target fixed: separation result via de Rham / local-global cohomology | Most direct formalization of "cohesion is needed for praxis"; something naturally stateable in cohesive HoTT that is not in plain HoTT |
| 2026-05-07 | Analytic folder scoped to ℤ only; S¹ excluded | Site is Bℤ with ℤ foregrounded; S¹ would reintroduce the topological viewpoint deliberately set aside |
| 2026-05-07 | Two diagnostic findings from analytic Cohesion.agda | (1) flat-intro exists for ℤ (already discrete) but not for S¹ — confirms synthetic postulate is crisp-context over-approximation; (2) modal conditions on shape-rec/sharp-rec are vacuous for discrete types |
| 2026-05-07 | Analytic folder purpose reframed | Not "verify postulates in a model" but "demonstrate non-vacuity"; key result is ¬IsFlatModal-delooping; ℤ instances provide consistency sanity-check |
| 2026-05-07 | Type-level adjunction for (Bℤ, Bℤ) fails | (Bℤ → Bℤ) ≃ Bℤ × ℤ (free loop space); (Bℤ → ℤ) ≃ ℤ; Bℤ × ℤ ≇ ℤ. Our ♭(Bℤ) = ℤ is not the correct ♭ for any model where the adjunction holds at the type level. In Sh(Bℤ), the correct ♭(Bℤ) = Map(Bℤ, Bℤ) ≃ Bℤ × ℤ, and the adjunction holds there by currying |
| 2026-05-07 | π₀ coincidence for (Bℤ, Bℤ) rejected | ‖Bℤ → Bℤ‖₀ ≃ ℤ ≃ ‖Bℤ → ℤ‖₀ is two separate computations sharing a common target, not a manifestation of the adjunction; no natural transpose connects the two sides |
| 2026-05-07 | Crisp contexts are the intended analytic validation path | The adjunction is built into the modal rules in crisp cohesive type theory (Shulman 2018, Myers); marked as future work. Agda --cohesion covers ♭ partially; ʃ and ♯ not supported maturely anywhere |
| 2026-05-07 | ℤ-spaces dismissed as analytic model | PhD-scale infrastructure cost; misaligned with analytic folder's role and with the crisp-context design goal |
| 2026-05-07 | free-loop-space obstruction to be a named lemma in analytic Adjunctions.agda | (Bℤ → Bℤ) ≃ Bℤ × ℤ records where and why the adjunction breaks; uses loop-space-equiv; belongs in the file as an explicit obstruction witness |
| 2026-05-07 | flat-map for Bℤ maps not derivable via the synthetic route analytically | Synthetic derivation uses flat-ind + flat-intro ∘ f; flat-intro does not exist for Bℤ (same obstruction as ¬-IsFlatModal-delooping). A winding-number construction exists but does not mirror the synthetic side. Decision on whether to include it in analytic Properties.agda deferred to next session |
| 2026-05-07 | Crisp contexts would unblock Bℤ flat-map in analytic Properties.agda | In crisp type theory, flat-intro is valid for crisp variables; flat-ind + flat-intro ∘ f goes through for crisp f : Bℤ → Bℤ by the same derivation as the synthetic side. Shape-map for Bℤ remains trivial (ʃBℤ = Bℤ); sharp-map remains deferred |

## Open Questions

- [ ] Dependent induction for ♯ and ʃ (fiberwise modality conditions needed); would unlock deriving IsSharpModal (♯A), IsShapeModal (ʃA), and all four postulated map laws in Properties.agda as theorems.
- [ ] Naturality of the adjunction bijections (currently postulated as bare equivalences; naturality belongs in Properties.agda or a separate Naturality.agda).
- [ ] `shape-map-id`, `shape-map-comp`, `sharp-map-id`, `sharp-map-comp` postulated in Properties.agda; same blocker as above.
- [ ] Missing bridge: `IsShapeModal` and `IsFlatModal` are defined independently but should pick out the same class of types (the discrete types) in any cohesive model. The identification `IsShapeModal A ↔ IsFlatModal A` is not yet stated. It underlies the coherence of `shape-rec` (which requires `IsShapeModal`) and `shape-flat-transpose` (the full adjunction, no modal condition) — without it, future derivations that cross between the two may need an ad hoc postulate.
- [ ] Missing monad/comonad structure: comultiplication δ : ♭A → ♭(♭A), multiplication μ : ʃ(ʃA) → ʃA, and the corresponding structure for ♯. These follow from idempotency by abstract nonsense and are trivial in the idempotent case, but are currently unnamed. Defer until something concretely needs them.

## Conjecture Arc

The current development is building infrastructure; it has not yet stated the conjecture in Agda. That statement needs to be fixed before further derived results can be prioritized sensibly.

**The conjecture (informal):** modal HoTT is the appropriate setting for mathematical *praxis*, while HoTT is the appropriate *foundation*. In Agda, this requires a concrete formal claim.

## Blockers

None currently. Note: cubical library uses infective flags (`--guardedness`); every file must mirror them in its OPTIONS pragma.

## Completed

- [x] Project scaffold and workflow files
- [x] `agda/ModalHoTT/Modalities/Cohesion.agda` — three cohesion modalities postulated as axioms (operators, units/counits, induction principles, modal-type definitions); includes `flat-counit-intro` β-rule
- [x] `agda/ModalHoTT/Modalities/Adjunctions.agda` — ♭ ⊣ ♯ and ʃ ⊣ ♭ as hom-set equivalences with coherence conditions; named transpose operations; IsFlatModal (♭A) proved, ♯/ʃ idempotency postulated
- [x] `agda/ModalHoTT/Modalities/Properties.agda` — flat-map/shape-map/sharp-map; flat functoriality laws (map-id, map-comp) proved; ʃ/♯ laws postulated
- [x] `agda/Analytic/ModalHoTT/Modalities/Cohesion.agda` — full 3×2 grid: ♭/ʃ/♯ instances for ℤ (all trivial); ♭/ʃ/♯ instances for Bℤ (♭: non-trivial, Bℤ is NOT flat-modal, machine-checked; ʃ: trivial, Bℤ is already a pure homotopy type; ♯: deferred, comment only — no cubical construction for codiscrete reflection of Bℤ). DeloopingOfIntegers HIT, deck transformations, universal cover, and Ω(Bℤ) ≃ ℤ are all defined in this file (not a separate Types/ file).
- [x] `agda/Analytic/ModalHoTT/Modalities/Adjunctions.agda` — comments only; trivial code (ℤ instances) to be added. Documents: why type-level adjunction fails for (Bℤ, Bℤ); the free-loop-space obstruction (Bℤ → Bℤ) ≃ Bℤ × ℤ; why ♭(Bℤ) = ℤ is not the correct ♭ for any model where the adjunction holds; crisp contexts as the intended future path.

## Next step

Continue analytic development in parallel with synthetic:

1. **`agda/Analytic/ModalHoTT/Modalities/Adjunctions.agda`** — comments written; add trivial code. For ℤ: both adjunctions are `idEquiv`, no content. For Bℤ: type-level adjunction is out of scope (see Decisions Log); add the free-loop-space obstruction lemma `(Bℤ → Bℤ) ≃ Bℤ × ℤ` as a named result using `loop-space-equiv`. ♭ ⊣ ♯ for Bℤ: comment only (♯Bℤ deferred).

2. **`agda/Analytic/ModalHoTT/Modalities/Properties.agda`** — analytic functoriality for ℤ; flat-map, shape-map, sharp-map and their laws (all provable without postulates).

Notes (to be removed after completion): 

    For ℤ: entirely trivial. All three modalities are identity, so every map law reduces to refl. The file is a completeness check, not mathematics. Worth writing for structural parity with the 
    synthetic folder, but no interesting content.
                                                                                                                                                                                                
    For Bℤ: there's a subtlety that's actually diagnostic. The synthetic flat-map is derived as flat-ind (λ _ → ♭B) (flat-intro ∘ f). That derivation requires flat-intro. But flat-intro does not
    exist analytically for Bℤ — that is precisely what ¬-IsFlatModal-delooping expresses. So the synthetic route to flat-map is blocked in the analytic model for Bℤ, not just for the laws but
    for the definition itself.                                                                                                                                                                    
                    
    You could define an analytic flat-map for f : Bℤ → Bℤ via the winding number: extract n = winding-number (ap f translation-step) and produce (· + n) : ℤ → ℤ. The functoriality laws then hold
    (winding numbers compose). But this construction doesn't mirror the synthetic one — it's a separate thing using loop-space-equiv, not a translation of flat-ind + flat-intro. The mirroring
    breaks exactly where flat-intro breaks.                                                                                                                                                       
                    
    For shape-map on Bℤ: trivial, since ʃBℤ = Bℤ, so shape-map f = f and the laws are immediate. For sharp-map: deferred, same as everywhere else.                                                

    My take: the file is worth writing and worth keeping short. The ℤ content goes in without fuss. For Bℤ I'd include a comment flagging the flat-map breakdown — it's the same family of        
    observation as ¬-IsFlatModal-delooping and reinforces the same point: our analytic ♭(Bℤ) = ℤ is geometrically motivated but sits outside the synthetic machinery. Skip the winding-number
    construction; it would be a detour into something that doesn't mirror the synthetic side and belongs in a different file if at all.  

3. **`agda/ModalHoTT/Modalities/Fracture.agda`** (synthetic) + **`agda/Analytic/ModalHoTT/Modalities/Fracture.agda`** (analytic) — after the analytic infrastructure is in place.