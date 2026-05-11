# Project Status

## Conjecture Arc

The arc is articulated in `workflow/arc.md` (the cohesive reformulation, with the `Allow ⊣ Mediate ⊣ Require` triple) and decomposed into concrete propositions T1–T7 in `workflow/targets.md`. The work tracked here is the A-side, ModalHoTT branch: the fracture theorem and the de Rham separation result are T7 — the bridge from local ModalHoTT machinery to the arc-level claim that cohesion is necessary for stating things plain HoTT cannot. The philosophical seed is in `workflow/motivation.md`.

## B-side (Concurrency)

`agda/Concurrency/` holds a brand-new stub (`ThreePointedStruct`). The substantive scope — site choice on the icosahedrally stratified S², partition match with the A-side modalities, and the protocol-as-operational-cohesion reading — lives in `targets.md` (T2, T4, T5). Currently dormant; not gated by the A-side, just awaiting bandwidth.

## Semantic Background

**The site is Bℤ — the delooping of ℤ.** This is the intended semantic model justifying the cohesion axioms. It does not appear as an Agda object; it lives here as documentation. Bℤ ≃ S¹ as ∞-groupoids, but we foreground the group structure of ℤ because: the intrinsic covering structure comes from subgroup inclusions nℤ ↪ ℤ; the comonad story connects cleanly to ℤ-actions; and Lawvere's fixed-point theorem is most natural in the algebraic/discrete setting ℤ provides.

## Analytic Development

`agda/analytic/` mirrors the synthetic structure but contains no postulates. Its purpose is to **demonstrate non-vacuity**: show that the synthetic postulates are consistent and that ♭ draws a real distinction between types. It is not a full verification of the postulates in an external model — that requires genuine cohesive type theory (see *Decisions Log — Relevant*: crisp contexts).

The centrepiece result is `¬-IsFlatModal-delooping` in Cohesion.agda: machine-checked proof that Bℤ is not flat-modal. This is the strongest claim the analytic folder can make without cohesive type theory infrastructure.

For the adjunctions, only ℤ instances are verifiable in plain cubical Agda (all modalities are identity; adjunctions are reflexivity). The type-level adjunction for non-discrete types is out of scope here; see Adjunctions.agda for the diagnosis and the intended future path.

**Library contribution goal (downstream):** Postulate-free, general results from the analytic folder are candidates for contribution to the cubical Agda library, which has no cohesion module. Write for the test suite first; if results come out clean and general, contribute. Do not let this target slow development.

## Decisions Log — Relevant

Live decisions still shaping current work. See *Decisions Log — Archived* at the bottom for settled implementations and pruned dead-ends.

| Date       | Decision | Rationale |
|------------|----------|-----------|
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

## Open Questions

- [ ] Dependent induction for ♯ and ʃ (fiberwise modality conditions needed); would unlock deriving IsSharpModal (♯A), IsShapeModal (ʃA), and all four postulated map laws in Properties.agda as theorems.
- [ ] Naturality of the adjunction bijections (currently postulated as bare equivalences; naturality belongs in Properties.agda or a separate Naturality.agda).
- [ ] `shape-map-id`, `shape-map-comp`, `sharp-map-id`, `sharp-map-comp` postulated in Properties.agda; same blocker as above.
- [ ] Missing bridge: `IsShapeModal` and `IsFlatModal` are defined independently but should pick out the same class of types (the discrete types) in any cohesive model. The identification `IsShapeModal A ↔ IsFlatModal A` is not yet stated. It underlies the coherence of `shape-rec` (which requires `IsShapeModal`) and `shape-flat-transpose` (the full adjunction, no modal condition) — without it, future derivations that cross between the two may need an ad hoc postulate.
- [ ] Missing monad/comonad structure: comultiplication δ : ♭A → ♭(♭A), multiplication μ : ʃ(ʃA) → ʃA, and the corresponding structure for ♯. These follow from idempotency by abstract nonsense and are trivial in the idempotent case, but are currently unnamed. Defer until something concretely needs them.
- [ ] `agda/Analytic/toy/` branch — a thorough construction of the synthetic structure using more pinpointed instances for the higher structures we work with. Alternative to the current ℤ-only analytic track; would broaden what gets verified without requiring full crisp-context support. Deferred. (Note migrated from `conversation.md`.)

## Current Task

**Fracture theorem** — `agda/ModalHoTT/Modalities/Fracture.agda` (synthetic) + `agda/Analytic/ModalHoTT/Modalities/Fracture.agda` (analytic test suite).

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

### Analytic plan (Analytic/ModalHoTT/Modalities/Fracture.agda)

Verify the fracture equivalence for `ℤ` — discrete type; ♭ℤ ≃ ℤ and ♯ℤ ≃ ℤ; pullback should collapse cleanly. Concrete definitions of ♭ and ♯ for ℤ are now in `Analytic.ModalHoTT.Modalities.Cohesion` (all trivial — identity maps).

S¹ excluded: site is Bℤ with ℤ foregrounded; including S¹ would reintroduce the topological viewpoint we deliberately set aside.

## Next step

**`agda/ModalHoTT/Modalities/Fracture.agda`** (synthetic) + **`agda/Analytic/ModalHoTT/Modalities/Fracture.agda`** (analytic). Synthetic: one postulate stating the fracture square is a pullback; commutativity attempted from `flat-sharp-counit-compat` + flat functoriality, postulated if blocked. Analytic: verify the fracture equivalence for ℤ — discrete, so the pullback collapses cleanly. Bℤ excluded analytically: needs `♯(Bℤ)`, which is undefined (see Cohesion.agda).

## Unlocking ♯ — what it costs and what it buys

The de Rham / separation arc (T7) ultimately routes through the ♯ modality, currently the weakest leg of the three. This section anticipates what the horizon beyond fracture requires.

### What would unlock ♯

**Synthetic side:** the blocker is dependent elimination for ♯ (also in Open Questions above). With `♯-ind`, `IsSharpModal (♯A)` becomes a theorem rather than a postulate, and `sharp-map-id` / `sharp-map-comp` follow. Same structural gap as for ʃ; same resolution: a proof assistant that implements ♯ as a genuine modal type former with dependent recursion.

**Analytic side for Bℤ:** the blocker is deeper — no concrete cubical Agda construction for `♯(Bℤ)` is known. In Shulman's real-cohesive HoTT, ♯ is tied to the interval ℝ; `♯X` is X with all points connected by real-valued paths ("maximally cohesive"). For Bℤ in that model, `♯(Bℤ)` is likely contractible (ℝ-connectedness collapses everything). But contractibility of `♯(Bℤ)` is *inconsistent* with the fracture theorem holding for Bℤ with our `♭(Bℤ) = ℤ` — the pullback would then give `ℤ ≃ Bℤ`, which is false. So either our `♭(Bℤ) = ℤ` is wrong in that model (already known), or the real-cohesive model is the wrong intuition for our Bℤ site.

The clean unlock for the analytic side is the same as for the adjunction: crisp type theory implementing ♯ as a proper modality, where `♯(Bℤ)` would be computable from the rules rather than requiring a concrete cubical construction.

### What it buys

**Immediately:** the fracture theorem for Bℤ *analytically*. The pullback uses `♯A`; without `♯(Bℤ)`, analytic Fracture.agda is bounded to ℤ. ♯ is the prerequisite for verifying the fracture theorem on the most interesting type we have.

**The ♭ ⊣ ♯ adjunction as a pair with ʃ ⊣ ♭:** we currently have the "global" half of cohesion (ʃ sees the shape, ♭ sees the discrete skeleton). ♯ completes the "local" half — the codiscrete reflection, the type seen from the ambient connected world rather than from the discrete skeleton. Having both adjoints of ♭ gives the full local-global interplay, which is the geometric content of the fracture theorem.

**New directions opened by ♯:**

- **Differential cohomology.** Canonical construction in cohesive HoTT: the pullback `H^n(X,ℤ) ×_{H^n(X,ℝ)} Ω^n(X)` — flat integral classes, real forms, and the comparison. Both ♭ (integral, discrete) and ♯ (real, ambient) appear. First genuinely new object that requires all three modalities and is not statable in plain HoTT.
- **The Poincaré lemma synthetically.** De Rham cohomology equals cohomology with flat coefficients. Statement uses ʃ and ♭; proof uses ♯ to mediate. Most direct formalization of the separation result — something that cannot even be *stated* without all three modalities.
- **The creativity / provability axis of the conjecture.** ♭ encodes the formal, discrete, provable side; ♯ encodes the ambient, connected, everywhere-related side. The `♭ ⊣ ♯` adjunction is the mathematical expression of the tension between these. Lawvere's fixed-point theorem applied to the ♭-comonad and ♯-monad gives a precise handle on the fixed-point / no-fixed-point distinction the conjecture draws on.

In short: **♯ is the door to the de Rham story, which is the door to the separation result.**

## Blockers

None currently. Note: cubical library uses infective flags (`--guardedness`); every file must mirror them in its OPTIONS pragma.

## Completed

- [x] Project scaffold and workflow files
- [x] `agda/ModalHoTT/Modalities/Cohesion.agda` — three cohesion modalities postulated as axioms (operators, units/counits, induction principles, modal-type definitions); includes `flat-counit-intro` β-rule
- [x] `agda/ModalHoTT/Modalities/Adjunctions.agda` — ♭ ⊣ ♯ and ʃ ⊣ ♭ as hom-set equivalences with coherence conditions; named transpose operations; IsFlatModal (♭A) proved, ♯/ʃ idempotency postulated
- [x] `agda/ModalHoTT/Modalities/Properties.agda` — flat-map/shape-map/sharp-map; flat functoriality laws (map-id, map-comp) proved; ʃ/♯ laws postulated
- [x] `agda/Analytic/ModalHoTT/Modalities/Cohesion.agda` — full 3×2 grid: ♭/ʃ/♯ instances for ℤ (all trivial); ♭/ʃ/♯ instances for Bℤ (♭: non-trivial, Bℤ is NOT flat-modal, machine-checked; ʃ: trivial, Bℤ is already a pure homotopy type; ♯: deferred, comment only — no cubical construction for codiscrete reflection of Bℤ). DeloopingOfIntegers HIT, deck transformations, universal cover, and Ω(Bℤ) ≃ ℤ are all defined in this file (not a separate Types/ file).
- [x] `agda/Analytic/ModalHoTT/Modalities/Adjunctions.agda` — ℤ adjunctions as `idEquiv` (both `♭ ⊣ ♯` and `ʃ ⊣ ♭`); for Bℤ, the diagnostic lemma `maps-into-integers : (DeloopingOfIntegers → ℤ) ≃ ℤ` (any map Bℤ → ℤ is constant, forced by `isSetℤ`) — companion to the free-loop-space obstruction `(Bℤ → Bℤ) ≃ Bℤ × ℤ`. Documents: why the type-level adjunction fails for (Bℤ, Bℤ); why `♭(Bℤ) = ℤ` is not the correct ♭ for any model where the adjunction holds; crisp contexts as the intended future path. No postulates.
- [x] `agda/Analytic/ModalHoTT/Modalities/Properties.agda` — flat/shape/sharp map and id/comp laws for ℤ (all `refl`); shape-map for Bℤ trivial (`ʃBℤ = Bℤ`); flat-map for Bℤ documented as blocked (mirrors `¬-IsFlatModal-delooping`); sharp-map for Bℤ deferred (`♯(Bℤ)` undefined). No postulates.

## Decisions Log — Archived

Settled implementation notes, one-time choices, and dead-end pruning. Kept so the same ground is not re-litigated; not load-bearing for current work.

| Date       | Decision | Rationale |
|------------|----------|-----------|
| 2026-05-06 | Concurrency stub named `ThreePointedStruct` | Name is structure-agnostic in case we switch from circle to sphere |
| 2026-05-07 | Added `flat-counit-intro` to Cohesion.agda | Missing β-rule for ♭ (holds definitionally in crisp-context HoTT); needed to derive IsFlatModal (♭A) |
| 2026-05-07 | Fracture theorem as next conjecture-directed file | Separation result is the arc target; fracture is the geometric backbone; all maps already available from existing files. (Now the Current Task above.) |
| 2026-05-07 | Two diagnostic findings from analytic Cohesion.agda | (1) flat-intro exists for ℤ (already discrete) but not for S¹ — confirms synthetic postulate is crisp-context over-approximation; (2) modal conditions on shape-rec/sharp-rec are vacuous for discrete types |
| 2026-05-07 | π₀ coincidence for (Bℤ, Bℤ) rejected | ‖Bℤ → Bℤ‖₀ ≃ ℤ ≃ ‖Bℤ → ℤ‖₀ is two separate computations sharing a common target, not a manifestation of the adjunction; no natural transpose connects the two sides |
| 2026-05-07 | ℤ-spaces dismissed as analytic model | PhD-scale infrastructure cost; misaligned with analytic folder's role and with the crisp-context design goal |
| 2026-05-07 | free-loop-space obstruction to be a named lemma in analytic Adjunctions.agda | (Bℤ → Bℤ) ≃ Bℤ × ℤ records where and why the adjunction breaks; uses loop-space-equiv; belongs in the file as an explicit obstruction witness. Implemented |
| 2026-05-11 | `(Bℤ → ℤ) ≃ ℤ` recorded as a named lemma in analytic Adjunctions.agda | Companion to the free-loop-space obstruction: right side of the would-be (Bℤ, Bℤ) adjunction is just ℤ, while the left side (Bℤ → Bℤ) ≃ Bℤ × ℤ; together they pinpoint where the adjunction fails. Proof uses `isSetℤ` to force the loop on `translation-step` to refl, so every map Bℤ → ℤ is constant. Implemented |
