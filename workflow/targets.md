# Targets

Concrete propositions we want to state precisely, and (where applicable) verify in Agda. Distinct from the philosophical seed (`motivation.md`), its cohesive reformulation (`arc.md`), and the analogies (`related_structures.md`). These are what the proof checker should eventually engage with.

Each target: claim, what's needed to state it cleanly, what's needed to verify it. Targets carry an arc-anchor pointing back to the corresponding section in `arc.md`.

---

## T1. Adjoint formulation of requires-allows

*Arc anchor: `arc.md` §3, §4.*

**Claim.** The "requires-allows" coupling between ModalHoTT (A) (perspectives) and Concurrency (B) (data-agents) is an adjunction of modalities — minimally a pair `Allow ⊣ Require`, ideally a full triple `Allow ⊣ Mediate ⊣ Require` modeled on cohesion's `ʃ ⊣ ♭ ⊣ ♯`. The four bullets of `motivation.md:13-17` are recovered as unit, counit, and the two triangle identities.

**To state cleanly.**
- Decide pair vs. triple; commit a default and an escape clause.
- Name the slots in arc vocabulary, distinct from `ʃ ♭ ♯` which already have geometric meaning.
- Identify the topos/topoi the modalities live on (ambient ∞-topos containing both cohesive sub-presentations).

**To verify.**
- Postulate the adjunction(s) in Agda; check unit/counit/triangle identities derive.
- Exhibit a non-trivial instance: cohesive Bℤ example where the adjunction has content (not all identity).

### Progress

ModalHoTT-side adjunctions are formalised synthetically as hom-set equivalences with named transposes in `agda/ModalHoTT/Modalities/Adjunctions.agda` (♭ ⊣ ♯ and ʃ ⊣ ♭); `flat-modality-idempotent` is a theorem, while `sharp-modality-idempotent` and `shape-modality-idempotent` are postulated (blocked on dependent induction for ♯ and ʃ — see Open Questions in `status.md`). The cross-site `Allow ⊣ Mediate ⊣ Require` triple between ModalHoTT and Concurrency is not yet stated — pending the Concurrency side maturing past scoping.

---

## T2. Cohesion on the Concurrency site

*Arc anchor: `arc.md` §5.*

*To restate next session.* Original claim (cohesion on A_5-equivariant icosahedral S²) retired with the icosahedral framing. The reformulated question — whether cohesion lifts to the Concurrency topos (actor-causal + session-type-values hybrid) — needs restatement against the new construction. See `deep_context/concurrency_anchor.md` and `status.md` "Discussion of the next step". Original archived.

---

## T3. Lawvere fixed-point asymmetry between ModalHoTT and Concurrency

*Arc anchor: `arc.md` §6.*

*To restate next session.* Core intuition (cohesive modalities are fixed-point-rich; the Concurrency side is fixed-point-poor by locality) is durable; the specific anchor (A_5 simple-and-transitive on 12 vertices) is retired with the icosahedral framing. Reformulate against the actor-causal site's no-global-frame property. Original archived.

---

## T4. Hidden partition match between ModalHoTT and Concurrency

*Arc anchor: `arc.md` §5.*

*To restate next session.* The original modal-partition claim (`♯/♭/ʃ ↔ unityped agents / typed data / protocol shape`) is partially answered by the hybrid construction in `deep_context/concurrency_anchor.md`: the ActorBase/SessionValues split is **definitional** (base topology vs sheaf values, with modularity = sheaf gluing). The protocol-shape (`ʃ`) slot still needs work. Original archived.

---

## T5. Protocol as the operational reading of cohesion

*Arc anchor: `arc.md` §5.*

*To restate next session.* Depends on T2 and T4; the original A_5-symmetry anchor is retired. Reformulate "protocol as operational reading" against the actor-causal + session-type-values hybrid. Original archived.

---

## T6. Two-sided "above" via the adjunction

*Arc anchor: `arc.md` §4, §7.*

**Claim.** ModalHoTT (A) above Concurrency (B) via the left adjoint Allow (generative direction); Concurrency (B) above ModalHoTT (A) via the right adjoint Require (reflective direction). The two "aboves" are dual, mutually constitutive, and the adjunction structure of T1 *is* this two-sided above-relation.

**To state cleanly.**
- This is largely a consequence of T1 once the adjunction is committed; worth stating separately because it is the *philosophical content* the adjunction carries.
- Phrase in arc.md §4 as the philosophical reading of unit / counit.

**To verify.**
- No separate mechanical verification beyond T1.
- Check that neither side collapses into the other (the adjunction is not an equivalence).

---

## T7. Bridge: fracture / de Rham → arc-level separation

*Arc anchor: `arc.md` §6 (the math fragment that fracture/de Rham instantiates).*

**Claim.** The fracture theorem (status.md current task) and the de Rham separation result (status.md arc target) witness ModalHoTT alone — that cohesion is necessary for stating things plain HoTT cannot state. They are pieces of T1's "Allow direction" (perspectives unfold into structure), specifically on the ModalHoTT-side.

**To state cleanly.**
- Locate fracture and de Rham within T1's adjunction structure: which unit/counit/triangle do they instance?
- Distinguish what they witness (cohesion's necessity for ModalHoTT) from what they don't (the requires-allows coupling with Concurrency).

**To verify.**
- Already partially scoped in status.md. The bridge work is articulating, not proving — the proofs are status.md's job.

### Progress

The fracture theorem and the de Rham structural / named-coefficient / differential ladder (see `rug.md` "Beyond fracture") are anchored here.

**Completed — synthetic side (`agda/ModalHoTT/`).**

- `Modalities/Cohesion.agda` — three cohesion modalities postulated as axioms (operators, units/counits, induction principles, modal-type definitions); includes `flat-counit-intro` β-rule.
- `Modalities/Adjunctions.agda` — ♭ ⊣ ♯ and ʃ ⊣ ♭ as hom-set equivalences with coherence; named transpose operations; `IsFlatModal (♭A)` proved; ♯/ʃ idempotency postulated.
- `Modalities/Properties.agda` — flat / shape / sharp map; flat functoriality laws proved; ʃ/♯ map laws postulated; `flat-counit-natural` derived; `shape-flat-natural-B` postulated (load-bearing for the structural pinning).
- `Modalities/Fracture.agda` — synthetic fracture; `FracturePullback` as inline Σ Σ ≡; `fracture-square-commutes` derived; `flat-to-pullback` canonical map; one postulate `fracture : isEquiv (flat-to-pullback A)` framed as the ♯-lex shortcut.
- `Modalities/Discrete.agda` — bridge `IsFlatModal A ↔ IsShapeModal A` drafted (both directions postulated); **not imported anywhere**, held in reserve.
- `Cohomology/FlatCoefficients.agda` — structural rung of the de Rham depth ladder; `flat-coefficients-factor-pin` proves the canonical equivalence pins to `λ f → f ∘ shape-unit` via a four-step chain.

**Completed — analytic side (`agda/Analytic/ModalHoTT/`).**

- `Modalities/Cohesion.agda` — full 3×2 grid of ♭/ʃ/♯ instances for ℤ (all trivial) and Bℤ. Centrepiece: `¬-IsFlatModal-delooping` (machine-checked proof that Bℤ is not flat-modal). DeloopingOfIntegers HIT, deck transformations, universal cover, and `Ω(Bℤ) ≃ ℤ` all live in this file.
- `Modalities/Adjunctions.agda` — ℤ adjunctions as `idEquiv`; for Bℤ, the diagnostic lemma `maps-into-integers : (DeloopingOfIntegers → ℤ) ≃ ℤ` (companion to the free-loop-space obstruction `(Bℤ → Bℤ) ≃ Bℤ × ℤ`). Documents the type-level adjunction failure at (Bℤ, Bℤ); no postulates.
- `Modalities/Properties.agda` — flat / shape / sharp map and id/comp laws for ℤ (all `refl`); shape-map for Bℤ trivial; flat-map for Bℤ documented as blocked; sharp-map for Bℤ deferred (♯(Bℤ) undefined). No postulates.
- `Modalities/Fracture.agda` — analytic ℤ; pullback collapses definitionally to `Σ ℤ singl`; canonical map sends `n` to `(n, n, refl)`; `isEquiv` via `isoToEquiv` on `fst` as inverse. No postulates. Bℤ excluded (♯(Bℤ) undefined).
- `Cohomology/FlatCoefficients.agda` — analytic mirror at the structural rung.

**Paused next step.** Postulate a cohesive type ℝ and instantiate the structural equivalence at `B := ♭ℝ` — the named-coefficient rung. Open design call: postulate ℝ as a bare type plus `IsFlatModal ♭ℝ`, or as a single bundled record. Tautological as a "de Rham theorem" (see `rug.md`); the content-bearing differential level is deferred to `agda/AnalyticTest/`.

### Unlocking ♯ — what it costs and what it buys

The de Rham / separation arc ultimately routes through the ♯ modality, currently the weakest leg of the three. This subsection anticipates what the horizon beyond fracture requires.

**What would unlock ♯.**

*Synthetic side:* the blocker is dependent elimination for ♯ (also in Open Questions). With `♯-ind`, `IsSharpModal (♯A)` becomes a theorem rather than a postulate, and `sharp-map-id` / `sharp-map-comp` follow. Same structural gap as for ʃ; same resolution — a proof assistant that implements ♯ as a genuine modal type former with dependent recursion.

*Analytic side for Bℤ:* the blocker is deeper — no concrete cubical Agda construction for `♯(Bℤ)` is known. In Shulman's real-cohesive HoTT, ♯ is tied to the interval ℝ; `♯X` is X with all points connected by real-valued paths ("maximally cohesive"). For Bℤ in that model, `♯(Bℤ)` is likely contractible (ℝ-connectedness collapses everything). But contractibility of `♯(Bℤ)` is *inconsistent* with the fracture theorem holding for Bℤ with our `♭(Bℤ) = ℤ` — the pullback would then give `ℤ ≃ Bℤ`, which is false. So either our `♭(Bℤ) = ℤ` is wrong in that model (already known), or the real-cohesive model is the wrong intuition for our Bℤ site.

The clean unlock for the analytic side is the same as for the adjunction: crisp type theory implementing ♯ as a proper modality, where `♯(Bℤ)` would be computable from the rules rather than requiring a concrete cubical construction.

**What it buys.**

*Immediately:* the fracture theorem for Bℤ *analytically*. The pullback uses `♯A`; without `♯(Bℤ)`, analytic `Fracture.agda` is bounded to ℤ. ♯ is the prerequisite for verifying the fracture theorem on the most interesting type we have.

*The ♭ ⊣ ♯ adjunction as a pair with ʃ ⊣ ♭:* we currently have the "global" half of cohesion (ʃ sees the shape, ♭ sees the discrete skeleton). ♯ completes the "local" half — the codiscrete reflection, the type seen from the ambient connected world rather than from the discrete skeleton. Having both adjoints of ♭ gives the full local-global interplay, which is the geometric content of the fracture theorem.

*New directions opened by ♯.*

- **Differential cohomology.** Canonical construction in cohesive HoTT: the pullback `H^n(X,ℤ) ×_{H^n(X,ℝ)} Ω^n(X)` — flat integral classes, real forms, and the comparison. Both ♭ (integral, discrete) and ♯ (real, ambient) appear. First genuinely new object that requires all three modalities and is not statable in plain HoTT.
- **The Poincaré lemma synthetically.** De Rham cohomology equals cohomology with flat coefficients. Statement uses ʃ and ♭; proof uses ♯ to mediate. Most direct formalization of the separation result — something that cannot even be *stated* without all three modalities.
- **The creativity / provability axis of the conjecture.** ♭ encodes the formal, discrete, provable side; ♯ encodes the ambient, connected, everywhere-related side. The `♭ ⊣ ♯` adjunction is the mathematical expression of the tension between these. Lawvere's fixed-point theorem applied to the ♭-comonad and ♯-monad gives a precise handle on the fixed-point / no-fixed-point distinction the conjecture draws on.

In short: **♯ is the door to the de Rham story, which is the door to the separation result.**

---

## Not targets (orientation only)

- *Grothendieck mapping (PS / Esquisse / RS).* Useful tether and sanity check. Not what we're proving. If subsequent work starts orienting toward "recovering Esquisse-style results," push back.
- *Connes / Bennequin-Laforgue resemblances.* In `related_structures.md`. Locator, not target.
- *"World understanding and world creation."* In `arc.md §7`, held loose. Will sharpen if and only if discovery forces it.
- *The dual community-organization theorem* (concurrency-as-optimal-info-transfer). Co-equal in the long-term arc but out of scope for the current formalization phase.

---

## Dependency sketch

*To restate next session, in tandem with T2–T5.* T1 remains foundational; T6 and T7 remain downstream of T1. The site question for the Concurrency side has migrated from T2 to `deep_context/concurrency_anchor.md` (level-2 inventory in `status.md` "Discussion of the next step"). Original archived.

---

## Appendix — flow leading to the Concurrency-side operational anchor

The T1–T7 above are abstract-mathematical: they ask how cohesive modalities behave on each side and how the two sides relate. Working through whether T2 or T4 should be Concurrency-side starting points surfaced that neither anchors Concurrency *locally*. T2 imports ModalHoTT's frame onto Concurrency by making it carry "a site for cohesion." T4 fixes the modal partition (♭ / ♯ / ʃ ↔ typed data / unityped agents / interaction shape) before Concurrency's own primitives are committed to. Both let the ModalHoTT-side dictate Concurrency's shape; the dependency runs in the wrong direction.

The fix is structural: ModalHoTT has an anchor *beneath* its modal mathematics — Bℤ as a mathematical object on its own terms, with motivation.md's perspectivalism as the philosophical layer beneath that. The modal vocabulary speaks *about* Bℤ; it doesn't constitute it. Concurrency currently has no such under-layer. The proposal is to add one: an **operational anchor** — an operational concurrent system formalized in concurrency's native language (candidate families: Honda–Yoshida–Carbone multiparty session types, asynchronous π-calculus with session types, Caires–Pfenning propositions-as-sessions) — as a mathematical object on its own terms. The modal/cohesive questions (T2, T4, T5) then become questions *about* this system, not constructions designed to mimic ModalHoTT.

The mirror with ModalHoTT: motivation.md is the philosophical layer beneath the modal math on ModalHoTT (perspectivalism — same object under different probes); the operational anchor is the operational layer beneath the modal math on Concurrency (agents having conversations and producing typed data). Both layers sit *under* the abstract-mathematical targets, not within them. The Concurrency-side operational anchor is a proposed new target upstream of T2, T4, T5 — not a refinement of any of them.
