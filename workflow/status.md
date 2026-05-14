# Project Status

## Conjecture Arc

The arc is articulated in `workflow/arc.md` (the cohesive reformulation, with the `Allow ⊣ Mediate ⊣ Require` triple) and decomposed into concrete propositions T1–T7 in `workflow/targets.md`. The work tracked here is the A-side, ModalHoTT branch: the fracture theorem and the de Rham separation result are T7 — the bridge from local ModalHoTT machinery to the arc-level claim that cohesion is necessary for stating things plain HoTT cannot. The philosophical seed is in `workflow/motivation.md`.

## B-side (Concurrency)

`agda/Concurrency/` holds a brand-new stub (`ThreePointedStruct`). The substantive scope — site choice on the icosahedrally stratified S², partition match with the A-side modalities, and the protocol-as-operational-cohesion reading — lives in `targets.md` (T2, T4, T5). Currently dormant; not gated by the A-side, just awaiting bandwidth.

## Semantic Background

**The site is Bℤ — the delooping of ℤ.** This is the intended semantic model justifying the cohesion axioms. It does not appear as an Agda object; it lives here as documentation. Bℤ ≃ S¹ as ∞-groupoids, but we foreground the group structure of ℤ because: the intrinsic covering structure comes from subgroup inclusions nℤ ↪ ℤ; the comonad story connects cleanly to ℤ-actions; and Lawvere's fixed-point theorem is most natural in the algebraic/discrete setting ℤ provides.

## Analytic Development

`agda/Analytic/` mirrors the synthetic structure but contains no postulates. Its purpose is to **demonstrate non-vacuity**: show that the synthetic postulates are consistent and that ♭ draws a real distinction between types. It is not a full verification of the postulates in an external model — that requires genuine cohesive type theory (see *Decisions Log — Relevant*: crisp contexts).

A third track, `agda/AnalyticTest/`, is reserved for a separated concern that `Analytic/` cannot carry. It is currently empty; see `AnalyticTest/README.md`.

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
| 2026-05-14 | Pinning route is naturality in B, not the IsFlatModal ↔ IsShapeModal bridge | Bridge alone is not enough to derive the pinning equation (would still need ʃ-uniqueness or adjunction-naturality); naturality is the precise piece. One new postulate `shape-flat-natural-B`; four-step derivation chain. Discrete.agda drafted as a deferred reserve, not load-bearing. |

## Open Questions

- [ ] Dependent induction for ♯ and ʃ (fiberwise modality conditions needed); would unlock deriving IsSharpModal (♯A), IsShapeModal (ʃA), and all four postulated map laws in Properties.agda as theorems.
- [ ] Naturality of the adjunction bijections in A; naturality of `flat-sharp-transpose` (♭ ⊣ ♯) in either variable. (Naturality of `shape-flat-transpose` in B is now postulated as `shape-flat-natural-B` in Properties.agda — load-bearing for the structural-pinning derivation.)
- [ ] `shape-map-id`, `shape-map-comp`, `sharp-map-id`, `sharp-map-comp` postulated in Properties.agda; same blocker as above.
- [ ] Missing bridge: `IsShapeModal` and `IsFlatModal` are defined independently but should pick out the same class of types (the discrete types) in any cohesive model. Drafted in `Discrete.agda` (both directions postulated) but **held in reserve / not imported**. The intended pinning route turned out to need adjunction naturality instead; the bridge remains independently motivated and will matter for ♯-side work.
- [ ] Missing monad/comonad structure: comultiplication δ : ♭A → ♭(♭A), multiplication μ : ʃ(ʃA) → ʃA, and the corresponding structure for ♯. These follow from idempotency by abstract nonsense and are trivial in the idempotent case, but are currently unnamed. Defer until something concretely needs them.
- [ ] `agda/Analytic/toy/` branch — a thorough construction of the synthetic structure using more pinpointed instances for the higher structures we work with. Alternative to the current ℤ-only analytic track; would broaden what gets verified without requiring full crisp-context support. Deferred. (Note migrated from `conversation.md`.)
- [ ] ♯ as a lex modality (preserves finite limits) — would turn `fracture` from a postulate into a theorem; deferred along with crisp contexts since the analytic side of ♯ is blocked anyway.
- [ ] Naturality of the fracture equivalence in A — currently postulated as a bare `isEquiv` on the canonical map; naturality in A is what would let fracture commute with constructions on diagrams (e.g. differential cohomology pullbacks). Same shape as the existing adjunction-naturality entry; defer until a downstream use forces it.

## Current Task

**Post-pinning: named-coefficient rung of the de Rham depth ladder.** Pinning has landed (`flat-coefficients-factor-pin` in synthetic FlatCoefficients.agda, via `shape-flat-natural-B`). The arc target remains exhibiting something stateable in cohesive HoTT but not in plain HoTT. Next step on the synthetic side: postulate a cohesive type ℝ and instantiate the structural equivalence at B := ♭ℝ. See *Discussion of the next step*.

## Next step

Draft `agda/ModalHoTT/Cohomology/NamedCoefficient.agda` (or similar) — postulate a cohesive type ℝ and apply `flat-coefficients-factor-pin` at B := ♭ℝ. Open design question: postulate ℝ as a bare type plus `IsFlatModal ♭ℝ`, or as a single bundled record. Propose before writing.

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
- [x] `flat-counit-natural` added to `Properties.agda` (synthetic + analytic ℤ mirror) — derived theorem from `flat-ind` + `flat-counit-intro`, no new postulates; supplies the commutativity of the fracture square as a special case at `f = sharp-unit`.
- [x] `agda/ModalHoTT/Modalities/Fracture.agda` — synthetic; `FracturePullback` as inline Σ Σ ≡; `fracture-square-commutes` derived from `flat-counit-natural`; `flat-to-pullback` canonical map; single postulate `fracture : isEquiv (flat-to-pullback A)` framed as ♯-lex shortcut; derived `fracture-equiv`. Header notes synthetic/analytic asymmetry at Bℤ (♯(Bℤ) undefined analytically, so the postulate's Bℤ instance is a synthetic-only commitment).
- [x] `agda/Analytic/ModalHoTT/Modalities/Fracture.agda` — analytic ℤ; pullback collapses definitionally to `Σ ℤ singl`; canonical map sends `n` to `(n, n, refl)`; `isEquiv` via `isoToEquiv` of an `Iso` with `fst` as inverse, section lifted from `isContrSingl n .snd`. No postulates. Bℤ excluded (♯(Bℤ) undefined).
- [x] `agda/ModalHoTT/Cohomology/FlatCoefficients.agda` pinning — `flat-coefficients-factor-pin` proves `equivFun (flat-coefficients-factor Bm) ≡ λ f → f ∘ shape-unit`. Derived from one new postulate (`shape-flat-natural-B` in Properties.agda — naturality of `shape-flat-transpose` in B) plus three existing primitives (`shape-flat-adj-unit-eq`, `flat-counit-natural`, `flat-counit-intro`). Four-step pointwise chain. Type-checks.
- [x] `agda/ModalHoTT/Modalities/Discrete.agda` drafted (bridge `IsFlatModal A ↔ IsShapeModal A`, both directions postulated) but **deferred — not imported anywhere**. Header carries a status note. Held in reserve: independently motivated (resolves several Open Questions, will matter for ♯-side work) but the naturality-based pinning route made it non-load-bearing for the current task.

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
| 2026-05-12 | Fracture postulated as `isEquiv (flat-to-pullback A)`, not bare `≃` | Pins the specific mediating map (workflow rule 4); a bare ≃ would let any equivalence count |
| 2026-05-12 | Fracture pullback type defined inline as Σ Σ ≡, not via a stdlib pullback type | Three lines; no import burden; the unfolded form is what the analytic ℤ proof needs (`isContrSingl` on the inner Σ) |
| 2026-05-12 | ♯-lex framed in synthetic Fracture.agda header (and Open Questions) as the meta-axiom that would derive `fracture` | Documents that `fracture` is a theorem in real-cohesive HoTT, not a deeper independent claim; same register as the `flat-intro` crisp-context note in Cohesion.agda |

## Discussion of the next step

The clearest live next step on the synthetic side: pin the structural map in FlatCoefficients.agda (the file added in commit 91d468e).

Why:
- That file, per the pre-rewrite "Discussion of the next step" in status.md, currently presents the structural rung as a bare equivalence. For a separation result, "the canonical map is the
equivalence" matters more than "an equivalence exists." Without pinning, the file states the right shape but doesn't yet say what we want it to say.
- Pinning needs one of two Open Questions: (i) the IsFlatModal ↔ IsShapeModal bridge, or (ii) naturality of the adjunction bijections. (i) is the smaller move — a short addition to Cohesion
or Adjunctions, plausibly one direction derivable + one direction postulated.
- High leverage: the bridge appears in multiple Open Questions; pinning it once unblocks future ♯-side work cleanly.
- Stays in the structural rung — doesn't pre-commit to named-coefficient yet.

After that, the natural sequence on the synthetic side is: structural-pinned → named-coefficient (postulate ℝ, instantiate at ♭ℝ) → the synthetic-side "de Rham" packaging is complete (in the
depth-ladder's narrow sense; differential remains parked in AnalyticTest).

Two other live options I'd flag, less preferred:

- Move directly to named-coefficient. Skip the pinning; let the structural file stay bare. The named-coefficient result then inherits the bare-equivalence weakness — same shape one rung up.
Faster but produces a structurally weaker arc.
- Background maintenance instead of de Rham progression. Address dependent induction for ♯/ʃ (Open Question), which would unblock deriving idempotency and the four map laws as theorems.
Reduces postulate density. Independent of de Rham. Useful but not on the depth-ladder trajectory.