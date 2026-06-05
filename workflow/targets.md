# Targets

Concrete propositions we want to state precisely, and (where applicable) verify in Agda. Distinct from the philosophical seed (`motivation.md`), its cohesive reformulation (`arc.md`), and the analogies (`related_structures.md`). These are what the proof checker should eventually engage with.

Each target: claim, what's needed to state it cleanly, what's needed to verify it. Targets carry an arc-anchor pointing back to the corresponding section in `arc.md`.

---

## T1. Adjoint formulation of requires-allows

*Arc anchor: `arc.md` §3, §4.*

**Claim.** The "requires-allows" coupling between ModalHoTT (M) (perspectives / modal structural contexts) and Concurrency (K) (actor-causal communities with session-typed values) is currently targeted as an adjoint pair `Allow ⊣ Require`. The pair carries the arc/09 anchors: Complexity = `Allow` / left adjoint `L : M → K`; Evolution = `Require` / right adjoint `R : K → M`; Praxis = unit `η : id_M ⇒ R ∘ L`; Anthropic = counit `ε : L ∘ R ⇒ id_K` read through non-invertibility; Care = the orthogonal order-2 involution `_^⊥`.

**To state cleanly.**
- Pair is the default. Record an escape clause for later extra structure: middle `Mediate`, ambidextrous adjunction, or quadruple only if the mathematics earns it.
- Name the slots in arc vocabulary, distinct from `ʃ ♭ ♯` which already have geometric meaning.
- Identify the concrete categories/topoi the functors connect: modal structural contexts on the A side and the finite sheaf/topos layer on the B side.

**To verify.**
- Define or postulate the pair-shaped `Allow` and `Require` functors, unit, counit, and triangle identities; then instantiate the generic iteration scaffold.
- Exhibit a non-trivial instance: cohesive Bℤ example where the adjunction has content (not all identity).

### Progress

ModalHoTT-side adjunctions are formalised synthetically as hom-set equivalences with named transposes in `agda/ModalHoTT/Modalities/Adjunctions.agda` (♭ ⊣ ♯ and ʃ ⊣ ♭); `flat-modality-idempotent` is a theorem, while `sharp-modality-idempotent` and `shape-modality-idempotent` are postulated. The cross-site `Allow ⊣ Require` pair is not yet stated. The B side has now matured past raw presheaf scoping: finite event-product descent, the constant-slot Sessions instantiation, the concrete tiny finite-cover validation, the V-valued finite sheaf/value category, and the framework-at-`SET` finite sheaf category/object have landed as one category-generic construction. The finite Coverage bridge and library sheaf comparison have landed. Remaining gates are R4 Tier 3 (the left-adjoint sheaf-preservation / sheafification problem), the resulting sheaf-level R4 adjunction, the A-side category of modal contexts, and then the actual `Allow` / `Require` functors.

T_recursion (below) is downstream of T1: once `Allow ⊣ Require` is stated, its unit instantiates the generic-adjunction iteration scaffold in `agda/ModalHoTT/Modalities/Iteration.agda`. The naturality piece flagged in "To state cleanly" is load-bearing for T_recursion's `η^-coherent` lemma — bridged currently by a postulated `η-naturality` on the generic-adjunction interface.

---

## T2. Cohesion on the Concurrency site

*Arc anchor: `arc.md` §5.*

*To restate.* Original claim (cohesion on A_5-equivariant icosahedral S²) retired with the icosahedral framing. The reformulated question — whether cohesion lifts to the Concurrency topos (actor-causal + session-type-values hybrid) — needs restatement against the new construction. See `deep_context/arc/02_concurrency_anchor.md` and the Concurrency status in `status.md`. Original archived.

---

## T3. Lawvere fixed-point asymmetry between ModalHoTT and Concurrency

*Arc anchor: `arc.md` §6.*

**Claim.** The two sides of the adjunction sit at opposite Lawvere poles. The A-side (ModalHoTT) is fixed-point-rich: the cohesive modalities ʃ, ♭, ♯ are idempotent, each picking out a sub-class of fixed-point types (the modal types of `Modalities/Cohesion.agda`). The B-side (Concurrency) is fixed-point-poor by locality: the actor-causal site has no global frame, and consequently no globally fixed-point endomap on the resulting topos. The asymmetry is structural — it is what makes the cross-site adjunction `Allow ⊣ Require` non-trivial, and in particular what gives T_recursion's iteration content rather than collapse: if both sides were fixed-point-rich, `Require ∘ Allow` would be idempotent and the iteration would collapse after one step.

**To state cleanly.**
- Fix the precise sense of "fixed-point-poor" on the actor-causal site (no global-frame morphism; or: every globally A-equivariant endomap is the identity; or: a specific failure form of Lawvere's fixed-point theorem). Depends on the Concurrency-side scoping for `_Site._Category`.
- State the implication direction: that the asymmetry is *necessary* for T_recursion's iteration to be non-trivial.

**To verify.**
- A-side fixed-point richness is already in `Modalities/Adjunctions.agda` (`flat-modality-idempotent` proved; `sharp-modality-idempotent` and `shape-modality-idempotent` postulated).
- B-side non-fixed-point claim becomes statable once `_Site._Category` is committed.
- Non-collapse of T_recursion would be the derived corollary: `Iteration.T^_ n A` not equivalent to `Iteration.T A` for some `n > 1` and some `A`.

### Refinement: differential cohesion sharpens the asymmetry

If the differential rung lands on the A side (`ℜ ⊣ ℑ ⊣ &`), the binary fixed-point / no-fixed-point distinction refines into three flavors. `ℑ` (infinitesimal shape) is distinct from `ʃ` (homotopy shape); the asymmetry now has *provable* / *smooth-creative* / *wild-creative*, not two. This is one of the ways differential cohesion becomes load-bearing for the cross-site bridge in the new outlook (see `future_work.md` "Beyond fracture" and `status.md` ModalHoTT plan).

---

The original formulation — A_5 simple-and-transitive on the 12 icosahedral vertices, with equivariant fixed-point absence enforced at the symmetry level — is preserved in `deep_context/archived_post_concurrency_anchor_2026-05-16.md`. It is retired *as a specific anchor* (with the icosahedral framing), not as a line of thought: the structural content (asymmetry as the engine of non-trivial iteration) survives the move to the actor-causal site, and is what the rewrite above names.

---

## T4. Hidden partition match between ModalHoTT and Concurrency

*Arc anchor: `arc.md` §5.*

*To restate.* The original modal-partition claim (`♯/♭/ʃ ↔ unityped agents / typed data / protocol shape`) is partially answered by the hybrid construction in `deep_context/arc/02_concurrency_anchor.md`: the ActorBase/SessionValues split is **definitional** (base topology vs sheaf values, with modularity = sheaf gluing). Hybrid v1 made the presheaf/restriction half checkable in Agda; the fast-track finite layer has now landed full finite-site event-product gluing. The remaining distinction is general sheaf/topos structure, not the constant-slot descent proof itself. The protocol-shape (`ʃ`) slot still needs work. Original archived.

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

The fracture theorem and the de Rham structural / named-coefficient / differential ladder (see `future_work.md` "Beyond fracture") are anchored here.

---

## T_recursion. Iterable adjunction and the developing network

*Arc anchor: `arc.md` §6.*

**Claim.** The unit η : id → Require ∘ Allow of T1's adjunction is iterable with coherent self-composition, and the iteration carries a cyclic / modular-operad structure whose involution is the perspective-swap "cared-for = caregiver" (the 1=2 identity). The colimit of the iteration tower (in the ambient ∞-topos) is the mathematical object the arc's "math fragment" §6 names as the developing infinite network. T_recursion makes the static adjunction of T1 into a generative process: it names the mechanism by which praxis (developmental aspect, `motivation.md`) is realised on top of the adjoint structure. T3's asymmetry is what makes the iteration non-trivial; the present target is what the asymmetry *does*.

**To state cleanly.**
- Pick the operad flavour: cyclic operad (minimum — carries the 1=2 involution), modular operad (richer — adds genus-grading, making the Esquisse-side mapping literal rather than analogical), or dendroidal ∞-operad (most native to the cubical-set ambient).
- Decide where the operad lives: on `_Site._Category` directly, on the sheaf-of-session-values, or on the ambient ∞-topos. The finite descent layer now supplies concrete V-valued/session and Set-valued/cartesian sheaf endpoints. The durable placement decision should now follow R4 — likely on the structured sheaf package, with composition eventually coming from cut-elimination on the Caires–Pfenning side.
- Name the involution explicitly: at the session-type level this is `S ↔ S^⊥` (linear-logic duality); at the philosophical level this is the 1=2 perspective swap.
- State the colimit's homotopy invariant: an analogue of the Grothendieck–Teichmüller-tower homotopy type, scaled to whatever finite combinatorial data the Concurrency site commits to.

**To verify.**
- *Iteration-alone layer (cheaper, Agda-reachable now).* The scaffold in `agda/ModalHoTT/Modalities/Iteration.agda` provides `T`, `T-map`, `T^_`, `η^_`, `η^-coherent` (derived from a postulated `η-naturality`), and the developing-network type `ND : Type → Type` as a sequential colimit. Specializing to the A-side ʃ ⊣ ♭ should collapse `ND` to `♭(ʃ A)` by idempotency; at `A := Bℤ` this should yield `ND Bℤ ≃ ℤ` via the analytic-side computation in `Analytic/.../Cohesion.agda`. This is the cheapest non-trivial content from the scaffold.
- *Operad / hybrid layer (partial — syntax, algebra signatures, Sessions v1, actor site v1, and Hybrid v1 shipped).* The cyclic associative operad `O_1` syntax is in Agda (`Concurrency/Operads/CyclicAssociative.agda`: generator, substitution, cyclic action, sequential + parallel associativity, full cyclic equivariance via `rot-compₒ-a-block` / `rot-compₒ-b-block`, and derived `boundary-swap`; port bookkeeping split across `PortGluing.agda` and `PortRotation.agda`). The algebra interface is also in place (`Concurrency/Algebras/{StarAutonomous,Valuation,OperadAlgebra}.agda`): thin `*`-autonomous target signature, weak HIT valuation into `⊥-par`, and structural Step-2 operad algebra with `plug`, `shift`, and `boundary-swap-structural`. `Concurrency/Algebras/Sessions.agda` instantiates this interface with multiplicative session syntax, an inductive structural `Hom`, a bundled `SessionO1Action`, `session-interp`, `Sessions-Val`, and `Sessions-Alg`. `Concurrency/Sites/{ActorBase,ActorCausal}.agda` supplies the actor-causal base: opaque unityped actors, Lamport event causality, local frames, strict-reflecting `FrameHom`, basis covers, `sieve-of`, `ActorCausalSite`, and a Bool-based non-trivial cover witness. `Concurrency/Hybrid/{Presheaf,SessionPresheaf}.agda` supplies the original arbitrary-frame adapter layer. The fast-track finite layer adds category-generic finite products, finite frames/covers, `FinitePresheaf`, `EventProductPresheaf`, `FiniteDescent`, `EventProductSheaf`, `EventProductSheafObject`, `FiniteFramePresheafFunctor`, `FiniteSheafCategory`, `SessionEventProductSheaf`, `SetFiniteSheafCategory`, `SetEventProductSheaf`, `TinyEventProductExample`, `FramePullbackUniversal`, `FiniteFramePullback`, `FiniteBasisCover`, `FiniteFrameCoverage`, and `SetSheafComparison`: full finite-site event-product descent, constant-slot Sessions and Set instantiations, proof-level concrete validation on the two-point cover, finite sheaf categories at both `StarAutonomous→Category V` and `SET`, Cubical `Coverage` for the finite site, and the SET library sheaf comparison. R8 is present with both faces in Agda: syntactic `dual-involutive` and categorical / operadic `boundary-swap-at-gen`; the bridge between them is deliberately deferred to richer session-categorical structure. R4 is partially landed (presheaf change-of-base, presheaf-level Benton adjunction, and right-adjoint sheaf preservation); still pending are the left-adjoint sheaf-preservation / sheafification leg, the sheaf-level R4 adjunction, the A-side category of modal contexts, and then the cross-site adjunction `Allow ⊣ Require`, which instantiates the iteration module against this operadic/session layer.

### Philosophical anti-drift invariant: do not let R8 consume R∞

The modal side gives the ambient Grothendieckian horizon: cohesion, covers, shape, fundamental groups, and descent. Its Agda role is mostly to record and discipline literature-backed commitments, not to pretend that the modal cathedral is being rebuilt from scratch.

The concurrency side gives the active finite combinatorics: ports, cyclic order, gluing, rotation, associativity, and eventually modular closure. This is not a retreat from dessins/Belyi maps; it is where the dessin-facing material becomes manipulable. Dessins are finite ribboned combinatorics that remember arithmetic geometry, so the B-side productivity is a feature if it keeps climbing back toward covers, Belyi, and Galois.

The failure mode is stopping at session-flavored cyclic operads. `O_1` is not the destination: `MO_1` / the modular envelope is the real dessin-facing object. Session duality is a necessary local face of the cyclic structure, but the Grothendieckian target needs the whole cyclic / ribbon / modular apparatus.

### Progress

The iteration scaffold is in place: `agda/ModalHoTT/Modalities/Iteration.agda` defines the generic-adjunction `Iteration` module (`T`, `T-map`, `T^_`, `η^_`, `η-naturality` postulate, `η^-coherent` derived, `T-sequence`, `ND`). A-side sanity check `agda/ModalHoTT/Modalities/IterationCohesion.agda` instantiates with ʃ ⊣ ♭: refl-level `T-as-flat-shape` and `η^1-is-unit`, plus the first-level collapse `η-equiv-at-T : T A ≃ T(T A)` derived via the `Discrete.agda` bridge (`T A` is flat-modal definitionally and shape-modal by the bridge, so the next iterate-step is an equivalence). Cross-site adjunction not yet stated (waits on Concurrency-side scoping). Deferred items (B-side dual, cyclic-involution layer, full sequential-colimit convergence `ND A ≃ T A`) flagged in `future_work.md` "Regarding T_recursion iteration."

B-side operadic syntax shipped 2026-05-18 (`Concurrency/Operads/CyclicAssociative.agda`: `O_1` as a cyclic associative HIT with `compₒ-assoc-seq`, `compₒ-assoc-par`, full cyclic equivariance via `rot-compₒ-a-block` / `rot-compₒ-b-block`, and derived `boundary-swap`; `PortRotation.agda` owns rotation-side port bookkeeping). The first algebra layer shipped 2026-05-19: `StarAutonomous.agda` is a thin target signature, `Valuation.agda` names weak HIT interpretations into `⊥-par`, and `OperadAlgebra.agda` adds `plug`/`shift` structural fields plus `boundary-swap-structural`. `Sessions.agda` supplies the first concrete typed-content instance: the syntactic R8 face `dual-involutive`, the categorical / operadic R8 face `boundary-swap-at-gen`, and the explicit `SessionO1Action` assumption whose canonical derivation is deferred. The actor-causal site shipped 2026-05-20 in `Concurrency/Sites/{ActorBase,ActorCausal}.agda`: opaque unityped actors, Lamport causal orders, local frames, strict-reflecting `FrameHom`, basis covers with `sieve-of`, generic identity / transitivity covers, `stability-cover-postulate`, and the Bool-based `two-point-cover` witness. Hybrid v1 shipped the same day in `Concurrency/Hybrid/{Presheaf,SessionPresheaf}.agda`: the generic restriction adapter, safe separatedness property, Sessions specialization, and constant `𝟙ₛ` / `⊥ₛ` witnesses. The 2026-06-04 finite layer adds category-generic finite products, finite frames/covers, event-product descent, constant-slot Sessions and Set sheaves, the proof-level tiny finite-cover example, and finite sheaf categories at both `StarAutonomous→Category V` and `SET`. The 2026-06-05 Strategy D landing adds finite pullback infrastructure, lean finite basis covers, Cubical `FiniteFrameCoverage`, and the SET library sheaf comparison. The active missing work is no longer descent, finite sheaf-category packaging, site-axis legitimacy, or presheaf-level R4 as such, but R4 Tier 3, the sheaf-level R4 adjunction, the A-side category of modal contexts, and the cross-site adjunction.

### Relation to other targets

- **Downstream of T1** (the adjunction itself).
- **T3 is the asymmetry-engine** — the Lawvere asymmetry is what makes the iteration content rather than collapse.
- **Distinct from T6** ("two-sided above") — T6 is the snapshot of mutual constitution; T_recursion is its dynamics.
- **Esquisse pointer.** T_recursion is the natural target for the Grothendieck-Esquisse mapping the arc discussion log named: the modular-operad form of the moduli-tower recursion, surviving the retirement of the A_5 / icosahedral example. See `deep_context/arc/01_arc_discussion_log-2026-05-08.md` Turn 21.

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

**Paused next step.** Postulate a cohesive type ℝ and instantiate the structural equivalence at `B := ♭ℝ` — the named-coefficient rung. Open design call: postulate ℝ as a bare type plus `IsFlatModal ♭ℝ`, or as a single bundled record. Tautological as a "de Rham theorem" (see `future_work.md`); the content-bearing differential level is deferred to `agda/AnalyticTest/`.

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

*To restate, in tandem with T2–T5.* T1 remains foundational; T6 and T7 remain downstream of T1. The site question for the Concurrency side has migrated from T2 to `deep_context/arc/02_concurrency_anchor.md` and the level-2 inventory in `status.md`. Original archived.

---

## Appendix — flow leading to the Concurrency-side operational anchor

The T1–T7 above are abstract-mathematical: they ask how cohesive modalities behave on each side and how the two sides relate. Working through whether T2 or T4 should be Concurrency-side starting points surfaced that neither anchors Concurrency *locally*. T2 imports ModalHoTT's frame onto Concurrency by making it carry "a site for cohesion." T4 fixes the modal partition (♭ / ♯ / ʃ ↔ typed data / unityped agents / interaction shape) before Concurrency's own primitives are committed to. Both let the ModalHoTT-side dictate Concurrency's shape; the dependency runs in the wrong direction.

The fix is structural: ModalHoTT has an anchor *beneath* its modal mathematics — Bℤ as a mathematical object on its own terms, with motivation.md's perspectivalism as the philosophical layer beneath that. The modal vocabulary speaks *about* Bℤ; it doesn't constitute it. Concurrency currently has no such under-layer. The proposal is to add one: an **operational anchor** — an operational concurrent system formalized in concurrency's native language (candidate families: Honda–Yoshida–Carbone multiparty session types, asynchronous π-calculus with session types, Caires–Pfenning propositions-as-sessions) — as a mathematical object on its own terms. The modal/cohesive questions (T2, T4, T5) then become questions *about* this system, not constructions designed to mimic ModalHoTT.

The mirror with ModalHoTT: motivation.md is the philosophical layer beneath the modal math on ModalHoTT (perspectivalism — same object under different probes); the operational anchor is the operational layer beneath the modal math on Concurrency (agents having conversations and producing typed data). Both layers sit *under* the abstract-mathematical targets, not within them. The Concurrency-side operational anchor is a proposed new target upstream of T2, T4, T5 — not a refinement of any of them.

## Appendix — adjunction shape layer and Sketch of a Program

This appendix records the current target-level view of the possible `Allow ⊣ Require` adjunction and how the conversation got here.

The starting practical problem was a verifiable program for human / LLM communication protocols: conversations should not only produce text, but produce checkable traces, typed artifacts, and commitments that can be inspected by another agent or by a proof assistant. That forced the Concurrency side to become more than an analogy. It needed an operational substrate: actors as local loci of action, sessions as typed content, and a way for local interactions to compose without erasing locality.

The first stable split was therefore the actor/session hybrid. Typed content belongs in the values; unityped agents and locality belong in the base. This gave a modal echo of the hidden partition:

- `discrete_modal` corresponds to formal, typed, documentable content.
- `codiscrete_modal` corresponds to the ambient actor-local locus where action can happen.
- `homotopy_shape_modal` is the remaining slot: the shape of admissible transformations.

The third slot is the important one for the adjunction. It is not payload and it is not actor identity. It is the grammar of paths: which transitions are allowed, which loops matter, which reorderings are equivalent, which diagrams commute, and which local interactions can glue into a coherent global execution. On the Concurrency side this appears as interaction / conversation shape. On the Modal side it appears as homotopy shape. This is the common invariant on which `Allow` and `Require` are expected to meet.

The `O_1` work made that third slot concrete. The cyclic associative operad supplies ports, gluing, cyclic rotation, and the derived `boundary-swap` theorem. The Sessions instance then shows how this shape layer acts on typed content: `session-interp` interprets `O_1`, `Sessions-Alg` supplies `plug` and `shift`, `dual-involutive` gives the syntactic R8 face, and `boundary-swap-at-gen` gives the categorical / operadic R8 face. This does not prove the adjunction, but it gives the B-side a first checkable shape layer.

Sketch of a Program enters here as the deep theory of such shape data. Dessins, Belyi maps, monodromy, path lifting, and Grothendieck-Teichmuller symmetries are not being used as decorative resemblances. They are the long-horizon mathematics of finite combinatorial shapes that remember homotopy, covering, and arithmetic structure. In this framing, `O_1` is the small local operadic beginning, `MO_1` is the modular / self-gluing escalation, and dessins are the finite arithmetic avatars of the same homotopy-shape slot.

So the current target is:

```text
modal constraints / theories
  -- Require / Allow --
concurrent operational realizations
```

with the mediating comparison forced to pass through:

```text
homotopy_shape_modal
  ↔ interaction / conversation shape
  ↔ operads, modular envelopes, dessins, monodromy
```

This is why the adjunction should not be stated as a bare correspondence between HoTT types and session types. That bridge is one face of the story, but the likely load-bearing object is the shape layer that lets theories require forms of witnessing and lets practices allow forms of realization. The actor-causal module preserves this partition at the locality layer; the next test is whether the hybrid sheaf valuation preserves it while placing session values over actor-local frames.

The working comparison table is:

| HoTT / Modal Side | Session / Concurrency Side | Sketch / Esquisse Mediator |
|---|---|---|
| Type as space: a type behaves like a homotopy space. | Session type as protocol shape: a type describes possible interaction behavior. | Dessin as finite combinatorial shape encoding a covering. |
| Term of a type: a point / inhabitant. | Process endpoint / participant state: an inhabitant of a protocol position. | A vertex / edge / local branch of a dessin. |
| Identity type / path: equality as path. | Protocol equivalence / trace equivalence: two interactions count as same behavior. | Homotopy / combinatorial equivalence of covers or graphs. |
| Dependent type: fibers vary over a base. | Session indexed by context / state: protocol obligations vary with conversation state. | Family of covers over a moduli base. |
| Function type: maps between spaces. | Channel / session transformer: turns one protocol state into another. | Morphism of covers / functor between combinatorial structures. |
| Product / sum types: structured combination / alternatives. | Tensor / par / choice-like connectives: parallel or dual interaction structure. | Gluing / branching of covers. |
| Univalence: equivalent structures can be identified. | Protocol isomorphism: behaviorally equivalent protocols can be treated as same. | Isomorphic dessins / equivalent covers. |
| Higher inductive types: generate spaces by points, paths, higher paths. | Generated protocols: generate interactions from primitives plus equations. | Dessins generated by finite permutation / combinatorial data. |
| Modalities: discrete, codiscrete, homotopy-shape views of a type. | Separated layers: typed content, actor-local substrate, conversation shape. | Different projections of the same cover / moduli data. |
| Covers / descent: local data glues into global structure. | Session consistency: local conversations / documents glue into a coherent global state. | Central Esquisse theme: finite covers of the 3-pointed sphere. |
| Fundamental group / loops: e.g. Bℤ, S¹. | Cyclic interaction / dual endpoints: rotation, reversal, session duality. | Monodromy permutations around punctures. |
| Suspension / bar construction: dimension-raising from S¹ toward S². | Modular envelope: composition / self-gluing raises complexity or genus. | Teichmüller / moduli tower. |
| Fixed points / Lawvere: closure, self-reference, modal stabilization. | Open interaction: protocols can keep generating new conversations. | GT / moduli tower as recursive, nontrivial self-organization. |
| Proof object: verified inhabitant. | Trace / document certificate: verified protocol history. | Arithmetic / combinatorial certificate of a cover. |
