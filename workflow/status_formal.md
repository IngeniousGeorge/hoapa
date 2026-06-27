---
tags: [focus:cross-site, kind:state, level:scoping]
---

# Formal Status

The arc is articulated in `arc.md` (now pair-first: `Allow ⊣ Require` with the five arc/09 anchors) and decomposed into propositions T1–T7 plus T_recursion in `targets.md`. Philosophical seed in `motivation.md`. Brainstorming archive: `deep_context/arc/`.

Bandwidth is on the Concurrency side, after a cycle of reframes that has converged: actor-causal + Caires-Pfenning hybrid (substrate) augmented by an operadic interaction-algebra layer (`O_1`), with the modular envelope `MO_1` as long-horizon target. The ModalHoTT side is paused at the de Rham named-coefficient rung with a defined return plan (S¹ + cyclic bar construction) coordinated with the B-side commitment.

## Concurrency  <!-- tags: focus:concurrency, level:scoping -->

### Where we landed

The Concurrency-side has converged after a cycle of reframes: icosahedral (A_5 / S²-equivariant) → actor-causal + Caires-Pfenning hybrid (per `deep_context/arc/02_concurrency_anchor.md`) → operadic interaction-algebra layer named on top of the hybrid (per `deep_context/arc/03_attachement_in_arc.md`). The current commitment treats the hybrid as substrate and the operadic layer as augmentation, not replacement. The B-side has *cycled*, not drifted: each reframe added structure rather than discarding the previous one.

The interaction algebra is `O_1` — the cyclic operad with one binary generator and a cyclic action. Three structural matches with actor/session content land cleanly: one binary operation = actor's single interaction primitive (Hewitt-style); the derived boundary-swap theorem = session-type duality `S ↔ S^⊥` = 1=2 perspective swap; three cyclic ports = sender / receiver / channel = trinion. The free cyclic operad on this data is small and finitely presented — Agda-reachable directly.

The first concrete typed-content instance is now shipped and partially de-postulated. `Concurrency/Algebras/SessionSyntax.agda` carries the postulate-free object grammar; `SessionMorphismSyntax.agda` carries a set-truncated morphism HIT with the 17 structural/additive formers and 21 laws as path constructors; `Sessions.agda` reuses those layers to instantiate the `O_1` algebra interface. It contains both R8 faces in Agda: syntactic `dual-involutive` and categorical / operadic `boundary-swap-at-gen`. The bridge between those faces is explicitly deferred to richer session-categorical structure; the only remaining Sessions postulate is the chosen `session-O1-action`.

The actor-causal locality leg is now shipped: `Concurrency/Sites/{ActorBase,ActorCausal}.agda` makes R6 concrete with opaque unityped actors, Lamport-style event causality, local frames, strict-reflecting frame embeddings, basis covers, and a Bool-based non-trivial cover witness. Promotion of a completed conversation into an actor-like node is deliberately not a `FrameHom`; it is reserved as a future morphism class for the `MO_1` / conversation-of-conversations stage.

Hybrid v1 shipped the first adapter layer (`Presheaf.agda`, `SessionPresheaf.agda`): generic frame presheaves, zero-postulate separatedness, and constant session-valued witnesses. The fast-track finite layer has now landed on the finite-frame subsite: `FiniteFrame.agda`, `FiniteCover.agda`, `TinyFiniteCover.agda`, and the `Hybrid/` finite-descent files give full finite-site event-product descent, including the Sessions constant-slot instantiation and the first concrete two-point finite-cover validation. The value-axis refactor has also landed: `CategoryApplicative.agda`, `FinitePresheaf.agda`, `FiniteDescent.agda`, `FiniteFramePresheafFunctor.agda`, and `FiniteSheafCategory.agda` now run over Cubical `Category`, with `StarAutonomousCategory.agda` feeding the V-valued/session side and `SetFiniteSheafCategory.agda` feeding the `SET` side. `FiniteProducts.agda` is likewise category-generic; `SetFiniteProducts.agda` and `SetEventProductSheaf.agda` provide a concrete Set-valued event-product object. Strategy D has now landed on the finite site: lean finite basis covers, a Cubical `Coverage` over `FiniteFrameCategory`, and a SET comparison theorem between the project `IsSheaf` record and the Cubical library `isSheaf`. R4 has advanced through the Benton/LNL finite-sheaf bridge: `ChangeOfBase.agda`, `LinearNonlinear.agda`, and `LinearNonlinearSheafAdapter.agda` give presheaf-level change of base, the lifted adjunction `liftF ⊣ liftG`, and right-adjoint (`G`) sheaf preservation; `FiniteSheafification.agda` states the finite-site reflector interface, and `LinearNonlinearSheafAdjunction.agda` assembles the sheaf-level adjunction conditionally on a V-side reflector. This is still not event-dependent session content and does not construct the generic full finite actor-causal reflector. The live R4 route has now constructed the point-generated sheafification over the supported subsite. `EventPoint.agda`, `EnumeratedProduct.agda`, and `Pointification.agda` land the variable-slot pointification spike; `EventSupported.agda`, `PointOverlap.agda`, and `PointCover.agda` supply the supported point-cover geometry; `SupportedFiniteFrameCategory.agda`, `SupportedPresheafCategory.agda`, and `RestrictToSupported.agda` package the supported subsite; `SupportedPointProduct.agda` gives the abstract slot-indexed point-product API; `SupportedPointification.agda` and `SupportedPointDescent.agda` give pointification and the point-sheaf/point-local comparison; `PointifyIsSheaf.agda`, `PointSheafCategory.agda`, `PointSheafification.agda`, and `PointSheafAdjunction.agda` prove that pointification lands in point sheaves and assemble the reflector adjunction `a ⊣ ι`. Brick 4 now wires this into the point-generated sheaf bridge: `SupportedChangeOfBase.agda`, `SupportedLinearNonlinearSheafAdapter.agda`, and `PointLinearNonlinearAdjunction.agda` construct the supported presheaf lifts, prove `G` preserves point sheaves, and assemble `Lpoint ⊣ Rpoint`. The theorem is relative to a value-level `lnl : LNLAdjunction` and a finite-products hypothesis `vProd` on `StarAutonomous→Category V`.

`MO_1` (the modular envelope of `O_1`, closure under self-gluing at marked points, raises genus to produce operations at every `(g, n)`) is the long-horizon target. `O_1` is staged toward it but does not commit to it. Eventual landing: evaluation at `(0, 3)` — the universal trinion, the 3-pointed sphere where dessins / Belyi / Esquisse machinery live.

Committed operadic flavor: `Ass_cyc` (planar cyclic associative, ribbon-graph world) over `Com_cyc` (fully symmetric, bare M̄_{g,n}). Justification: actor send/receive is intrinsically ordered, session composition is non-commutative, dessins live in the ribbon-decorated world.

The cross-site picture: on the modal side, `Bℤ → S¹ → S²` goes *sideways then up* (presentation switch via `ʃ`, then suspension `Σ`). On the concurrency side, `O_1 → MO_1 → S²`-with-3-marks goes *up then sideways* (modular envelope, then evaluation). Both sides land at the same `S²`; the asymmetry between "up-then-sideways" on B and "sideways-then-up" on A mirrors T3's Lawvere asymmetry (B fluid, A rigid). The speculative identity — modal-side η-iteration ≡ concurrency-side genus-raising — sits at the *intermediate* level (S¹ ↔ `MO_1`) and is only statable once both sides develop dimension-raising machinery (cyclic bar construction at S¹ on A; modular envelope of `O_1` on B). It is downstream evidence, not motivating.

Held loose for the long horizon: a Pask-style "implementation in the human world" — collective scientific inquiry as `_Algebras` evaluated at conversation-typed concepts. Separate track, not absorbed into `O_1` scope.

### Module inventory (level-2)

Three sub-inventories, with provenance.

#### Hybrid substrate (from `deep_context/arc/02_concurrency_anchor.md`)  <!-- tags: kind:reference -->

Level 1: `_Site`, `_Algebra`, `_Sheaf`, `_Topos`. Causality is not top-level — it parametrizes `_Site` (R6).

##### `_Site`  <!-- concept:site -->

Canonical decomposition (a Grothendieck site *is* a small category + a topology).

- `_Site._ActorBase` — shipped in `Concurrency/Sites/ActorBase.agda`: opaque `ActorBase` carrier plus Lamport `CausalOrder`; no roles, payloads, session syntax, or actor-origin tags in the verified kernel.
- `_Site._Category` — shipped in `Concurrency/Sites/ActorCausal.agda`: `LocalFrame` objects and strict-reflecting `FrameHom` morphisms. A `FrameHom` is a sub-view embedding, not a quotient; conversation-promotion is deferred as a separate future morphism class.
- `_Site._Topology` — shipped in `Concurrency/Sites/ActorCausal.agda`: basis-form `Cover`, generated-sieve bridge `sieve-of`, generic identity / transitivity cover constructions, and `ActorCausalSite` with stability named as a field.

##### `_Algebra`  <!-- concept:algebra -->

Interpretive but with a natural three-part shape — a logical theory plus its categorical packaging.

- `_Algebra._Connectives` — type constructors (⊗, ⅋, &, ⊕, !, ?, ⊸, units).
- `_Algebra._Proofs` — sequent rules and proof terms; cut-elimination = communication semantics lives here.
- `_Algebra._SyntacticCategory` — the categorical form (star-autonomous / polycategory); the piece that talks to `_Sheaf`.

Duality (`A ↔ A^⊥`) cross-cuts all three.

##### `_Sheaf`  <!-- concept:sheaf -->

Canonical decomposition (a sheaf is a presheaf satisfying descent).

- `_Sheaf._Presheaf` — shipped in two layers: `FramePresheaf` over arbitrary actor-local frames, and category-generic `FiniteFramePresheaf` over enumerated finite frames. `SessionPresheaf` is the original constant-frame adapter; `SessionEventProductSheaf` and `SetEventProductSheaf` are the finite, frame-varying, constant-slot witnesses on the V-valued/session and Set-valued/cartesian sides.
- `_Sheaf._Separatedness` — shipped as property records. The original `IsSeparatedPresheaf` remains generic over basis covers; the finite event-product witness proves separatedness over `FiniteCover`s.
- `_Sheaf._Descent` — landed for the finite event-product presheaf: matching families, overlap compatibility, amalgamation, and separatedness over finite covers. The framework is now category-generic and packaged as `FiniteSheafCategory`; it is instantiated at both `StarAutonomous→Category V` and `SET`. The finite Cubical `Coverage` bridge and SET library `Sheaf` comparison have landed through `FiniteBasisCover`, `FiniteFrameCoverage`, and `SetSheafComparison`. R4 now has presheaf-level Benton/LNL change of base, right-adjoint sheaf preservation, a finite-sheafification reflector interface, and a conditional sheaf-level adjunction. The full finite actor-causal reflector construction remains pending. The point-generated route has now built the supported-subsite reflector: abstract point products, pointification, point-sheaf locality, the point-sheaf category, reflector functor, and `a ⊣ ι` adjunction. The point-generated R4 bridge is now wired: supported change-of-base, right-adjoint point-sheaf preservation, and the sheaf-level adjunction `Lpoint ⊣ Rpoint` have landed.

The first value category `V` is `Sessions-Cat Payload`; later versions may replace or lift this to richer session categories or presheaves valued in `OperadAlgebra`.

##### `_Topos`  <!-- concept:topos -->

Canonical first three pieces, plus a cohesion-adapted fourth.

- `_Topos._SheafCategory` — `Sh(_Site._Category, _Site._Topology)` as an object. Current status: finite sheaf categories over both V-valued/session and Set-valued/cartesian value categories have landed in the hand-rolled finite framework, with concrete event-product objects on both sides. The Set side is now compared to Cubical `Coverage` / library `Sheaf` for the finite coverage. No internal-logic/topos theorem is claimed yet.
- `_Topos._InternalLogic` — subobject classifier Ω, internal language, predicates.
- `_Topos._GeometricMorphisms` — relations to other topoi (notably: embedding into cubical sets, shared substrate with ModalHoTT).
- `_Topos._InfinityLift` — the 1-topos → ∞-topos move.

#### Modular-operad version (from `deep_context/arc/03_attachement_in_arc.md`)  <!-- tags: kind:reference -->

Level 1: `_Operad`, `_Algebras`, `_Moduli`, `_Topos`. This is the long-horizon shape once `MO_1` is reached; included here as the eventual destination, not a current commitment.

##### `_Operad`  <!-- concept:operad -->

Cyclic operad and modular envelope.

- `_Operad._Generators` — single binary operation, planar (if Ass_cyc), 3 ports total via cyclic structure.
- `_Operad._Composition` — operadic substitution along ports.
- `_Operad._CyclicAction` — cyclic port rotation. The 1=2 perspective-swap is the derived boundary-swap face of this action; the predicted intertwining with ℤ's `-1` action on Bℤ via the cross-site adjunction is at this slot.
- `_Operad._ModularEnvelope` — closure under self-gluing of marked points; sub-decomposition:
  - `_Operad._ModularEnvelope._GenusGrading` — the `(g, n)` filtration.
  - `_Operad._ModularEnvelope._SelfGlue` — the loop-creating composition that raises genus.
  - `_Operad._ModularEnvelope._Stability` — stability condition (no contractible components after gluing).

##### `_Algebras`  <!-- concept:algebras -->

Algebras over `M(Ass_cyc)`. Interpretive but with a four-part natural shape.

- `_Algebras._Sessions` — session-typed channels; the structural boundary-swap identity acts as `S ↔ S^⊥`. Linear logic's connectives appear as the operations.
- `_Algebras._Actors` — actor structures as algebras; unityped at the carrier level.
- `_Algebras._CutElimination` — Caires-Pfenning normalization as the algebra's term-rewriting structure; where termination / progress / no-deadlock theorems would land.
- `_Algebras._Free` — universal "protocol on no data."

Duality cross-cuts; here it is read from `_Operad._CyclicAction` via the derived boundary-swap face, not from a primitive involution.

##### `_Moduli`  <!-- concept:moduli -->

Geometric realization of `_Operad._ModularEnvelope`. Forced once Ass_cyc is committed: ribbon-decorated stable-curve moduli.

- `_Moduli._Stratification` — `(g, n)` stratification.
- `_Moduli._RibbonGraphs` — Penner / Kontsevich combinatorial cell decomposition.
- `_Moduli._Dessins` — dessins inside the `(g=0, n=3)` neighborhood; the icosahedral A_5 example re-enters as one specific dessin (degree 60, monodromy A_5), not as an anchor.
- `_Moduli._GTAction` — Grothendieck-Teichmüller group acting on the tower (Drinfeld).

##### `_Topos`  <!-- concept:topos -->

Sheaves on `_Moduli`. Same four-part shape as the substrate version; topos-side structure is largely invariant under change of base.

- `_Topos._SheafCategory`.
- `_Topos._InternalLogic` — accommodates `_Algebras._Sessions`'s linear structure; cyclic equivariance supplies the boundary-swap theorem the linear side reads as duality.
- `_Topos._GeometricMorphisms` — embedding into cubical-set ambient; the cross-site adjunction with ModalHoTT lives here.
- `_Topos._InfinityLift` — same caveat as substrate.

#### `O_1` commitment (this session's proposal)  <!-- tags: kind:decision -->

Near-term Agda-bound subset that brings the operadic layer to the hybrid substrate without committing to `MO_1` machinery. The hybrid continues as substrate; the operadic layer named here is *additional structure on the hybrid*.

##### `_Operad` — `O_1` only  <!-- concept:operad -->

- `_Operad._Generators` — one binary operation. Planar if Ass_cyc (philosophical lean), symmetric if Com_cyc.
- `_Operad._Composition` — operadic substitution along ports; planar order under Ass_cyc.
- `_Operad._CyclicAction` — cyclic rotation on ports; the arity-2/session-duality face is derived as boundary-swap.

`_Operad._ModularEnvelope` and everything downstream (`_Moduli`, `_Topos` updates from operadic side, `_Moduli._GTAction`) deferred to `MO_1` stage.

##### `_Algebras` — over `O_1` only  <!-- concept:algebras -->

- `_Algebras._Free` — universal cyclic-operad algebra on no data.
- `_Algebras._Valuation` — weak HIT interpretations of `O_1` into the dualizing object of a target category.
- `_Algebras._OperadAlgebra` — structural algebra layer: valuations plus `plug` / `shift` operations and axioms connecting them to `compₒ` / `rot`.
- `_Algebras._Sessions` — shipped in three layers: `SessionSyntax.agda` for the postulate-free grammar, `SessionMorphismSyntax.agda` for the set-truncated morphism HIT, and `Sessions.agda` for the remaining `O_1` action instance (`SessionO1Action`, `session-interp`, `Sessions-Val`, `Sessions-Alg`, and `boundary-swap-at-gen`).
- `_Algebras._Actors` — held as the future algebraic/operadic reading of actor structures. The current actor-locality commitment lives under `_Site`, not under `_Algebras`.

`_Algebras._CutElimination` deferred — full Caires-Pfenning dynamics is post-`MO_1`.

##### Integration with hybrid  <!-- concept:integration -->

- `_Algebras._Sessions` now supplies the first value category `V` of the hybrid's `_Sheaf`: `SessionPresheaf = FramePresheaf AB (Sessions-Cat Payload)`.
- `_Site` supplies the actor-causal frame category over which `_Algebras._Sessions` varies as values. The finite descent layer takes `ActorBase`, `FiniteFrame`, and `FiniteCover`; pullback overlaps are supplied by `ActorPullback.agda`. The Set-valued finite endpoint now exists in the same generic framework and is compared to the Cubical library sheaf condition for `FiniteFrameCoverage`; R4 work should continue to consume finite sheaf/category interfaces rather than the constant-slot witnesses directly.
- `boundary-swap-structural` supplies the categorical / operadic R8 face that cross-cuts the existing `_Algebra._SyntacticCategory`; the bridge to syntactic session duality is deferred (R8).

This is the commitment frontier for `O_1`: enough operadic structure to name the interaction algebra of the hybrid; no commitments beyond cyclic-operad-without-modular-envelope.

### Structuring relations  <!-- tags: kind:reference -->

Named, like modules. R1–R6 are from the hybrid substrate's level-2 scoping; R7–R8 are added for the operadic layer at the `O_1` commitment level; R9–R11 are deferred to the `MO_1` stage.

**Live now.**

- **R1 — Valuation.** v1 landed in `Concurrency/Hybrid/{Presheaf,SessionPresheaf}.agda`: `FramePresheaf` is the generic functorial assignment `_Site._Category^op → V`, and `SessionPresheaf` instantiates `V = Sessions-Cat Payload`. Full finite-site event-product sheaf valuation has landed in a category-generic framework, with concrete instances at `StarAutonomous→Category V` and `SET`.
- **R2 — Indexing.** `_Sheaf` lives over `_Site`: presheaf + descent against `_Site._Topology`. The finite event-product sheaf layer, its V-valued category packaging, its Set-valued category/object endpoint, and the finite Cubical `Coverage` / library `Sheaf` comparison are shipped. R4 should keep consuming the finite sheaf/category interfaces; remaining full-site reflector or bridge work should not duplicate the constant-slot witness or collapse the Set and V endpoints.
- **R3 — Generation.** `_Topos = Sh(_Site._Category, _Site._Topology)`. No freedom; the topos is generated from site + sheaves.
- **R4 — Interpretation.** `_Topos._InternalLogic ↔ _Algebra._Connectives` / `_Algebras._Sessions`. Topos logic is cartesian by default; the algebra is linear. The current formal shape is interface-first Benton/LNL change of base between `Cart` and `StarAutonomous→Category V`: presheaf-level `liftF`, `liftG`, and `liftF ⊣ liftG` are proved, the right adjoint `G` preserves finite sheaves, `FiniteSheafification` names the left reflector interface, and `LinearNonlinearSheafAdjunction` gives the sheaf-level adjunction conditional on that reflector. The point-generated reflector is now constructed over the supported subsite: `PointifyIsSheaf`, `PointSheafification`, and `PointSheafAdjunction` give pointification as a point sheaf, the reflector functor, and `a ⊣ ι`. The point-generated sheaf bridge is now wired by `PointLinearNonlinearAdjunction.Lpoint⊣Rpoint`.
- **R5 — Embedding.** `_Topos._GeometricMorphisms → cubical sets`. The mathematical form of "both sides share an ambient `(∞,1)`-topos."
- **R6 — Parametrization (Causality).** Causality → `_Site`. Landed in `Concurrency/Sites/{ActorBase,ActorCausal}.agda`: Lamport partial-order events, actor-local frames, strict-reflecting frame embeddings, basis covers, and constructive tiny frame/cover witnesses. `ActorPullback.agda` supplies pullback overlaps and a pullback-stability construction. The old in-file stability fallback has been removed from `ActorCausal.agda`; `TinyActorBase.agda` owns the tiny base, and `TinyActorCausalSite.agda` assembles the bundled tiny site using the constructed stability path.
- **R7 — Algebra-over-Operad.** `_Algebras` evaluates `_Operad`. Landed as `StarAutonomous` + `Valuation` + structural `OperadAlgebra`, and concretely instantiated by `Sessions.agda` for the typed-content layer. Closely interacts with R1 (the value category for both must agree).
- **R8 — Involution-Duality.** `Sessions.agda` now contains both faces: syntactic `dual-involutive` and categorical / operadic `boundary-swap-at-gen` (a specialization of `boundary-swap-structural`). The bridge between them remains a deferred project claim, not a computational reduction.

**Most load-bearing now:** finite-site event-product descent, its constant-slot Sessions instantiation, the concrete tiny finite-cover validation, the V-valued finite sheaf/value category, the Set-valued finite sheaf category/object, the finite Cubical `Coverage` / SET library `Sheaf` comparison, and the point-generated R4 bridge have landed. Phase 0 then instantiated the bridge at `Chu(SET,Bool)` and removed the actor-site postulate from the witness import closure. Phase 1 built the Sessions-to-Chu object/morphism realization over the postulate-free syntax. R4 is therefore concrete in the point-generated coefficient-nonvacuity sense, while the cross-site adjunction still waits on an A-side category of modal contexts.

**Deferred (live at `MO_1` stage).**

- **R9 — Modular Envelopment.** `_Operad._ModularEnvelope` as closure of `_Operad` under self-gluing. Left adjoint to forgetful (cyclic operad ← modular operad). Universal — no freedom in the step itself.
- **R10 — Moduli Realization.** `_Moduli` as geometric realization of `_Operad._ModularEnvelope`. Theorem-driven (Getzler-Kapranov for Com_cyc → M̄; Kontsevich / Penner for Ass_cyc → ribbon-decorated M̄). Forces the Ass_cyc decision to have a literal moduli consequence.
- **R11 — Arithmetic Action.** `Gal(Q̄/Q) ⊃ GT` acts on `_Moduli._GTAction`, lifting through R10 to operadic automorphisms of `_Operad._ModularEnvelope`, then through R7 to symmetries of `_Algebras`. The operadic version of "external symmetry parametrizing structure at multiple levels."

## ModalHoTT  <!-- tags: focus:modalhott, level:scoping -->

Paused at the de Rham named-coefficient rung. Synthetic-side fracture (`Modalities/Fracture.agda`) and structural pinning (`Cohomology/FlatCoefficients.agda`) have landed; the analytic mirror (`formal/Analytic/`) is bounded by `♯(Bℤ)` undefined. Postulate budget catalogued in `future_work.md`.

The iteration scaffold for T_recursion is in place: `formal/ModalHoTT/Modalities/Iteration.agda` (generic-adjunction `T`, `T-map`, `T^_`, `η^_`, postulated `η-naturality`, derived `η^-coherent`, `T-sequence`, `ND`) and the A-side sanity check `formal/ModalHoTT/Modalities/IterationCohesion.agda` (ʃ ⊣ ♭ instantiation; first-level collapse `η-equiv-at-T : T A ≃ T(T A)` via the `Discrete.agda` bridge). This is **iteration-by-collapse** — completed and statable at the toy level. It is *not* the material that the cross-site identity will eventually need extending; that is a different construction (cyclic bar) at a different input (`S¹`).

### Plan when bandwidth returns

Two-piece program:

1. **Lift input from `Bℤ` to `S¹`.** The iteration scaffold is parameterized over types; switching the chosen specialization to `S¹` is a presentation move (using `Bℤ ≃ S¹` as ∞-groupoids), not a new construction.
2. **Switch construction from η-iteration to cyclic bar construction.** New file `BarConstruction.agda` — substantial cubical-HIT work. The cyclic flavor (Connes' cyclic category, Loday / Getzler-Jones lineage) is chosen to match the `Ass_cyc` lean on the B side: the involution structure must intertwine across sides. Plain (non-cyclic) bar pairs with `Com_cyc`; cyclic bar pairs with `Ass_cyc`.

This unlocks the speculative cross-site identity at the intermediate level (`S¹ ↔ MO_1`). The identity is downstream evidence, not a motivator — building both sides honestly is what determines whether the identity is real.

**Differential cohesion in the new outlook.** Elevated from "rhetorical packaging beyond the named-coefficient tautology" to **load-bearing for the cross-site bridge**. The differential rung (`ℜ ⊣ ℑ ⊣ &`) gives the A side an infinitesimal layer to talk to `MO_1`'s natural infinitesimal structure (formal smoothness, tangent complex on `M̄`). See `future_work.md` "Beyond fracture" — same cost as before, sharply elevated priority. The Lawvere asymmetry refinement entered in `targets.md` §T3 is one of the structural consequences.

## Semantic Background

### ModalHoTT (Bℤ)  <!-- concept:bz -->

The site is `Bℤ` — the delooping of ℤ. Intended semantic model justifying the cohesion axioms; does not appear as an Agda object. `Bℤ ≃ S¹` as ∞-groupoids, but we foreground the group structure of ℤ because: the intrinsic covering structure comes from subgroup inclusions `nℤ ↪ ℤ`; the comonad story connects cleanly to ℤ-actions; Lawvere's fixed-point theorem is most natural in the algebraic / discrete setting ℤ provides.

When bandwidth returns to the A side, the iteration's input type lifts from `Bℤ` to `S¹` (using the `Bℤ ≃ S¹` identification as a presentation switch). The *site* remains `Bℤ`; what shifts is the input that the cyclic bar construction operates on.

### Concurrency  <!-- concept:hybrid -->

The substrate is the actor-causal + session-type-values hybrid: a Grothendieck site of actor-causal frames (GR-inspired actor model, Lamport partial-order at `_Site._Category`, shipped in `Concurrency/Sites/{ActorBase,ActorCausal}.agda`), with Caires-Pfenning session-type structures as the natural values (sheaves) on it (canonical source: `deep_context/arc/02_concurrency_anchor.md`). Separation of concerns is structural (modularity = sheaf-gluing); typed data lives in the values, unityped agents in the base topology.

Hybrid now has two strata. The original adapter implements arbitrary-frame presheaf/restriction and separatedness. The fast-track finite layer implements full event-product descent over `FiniteCover`s in a category-generic framework, with constant-slot instantiations at both the Sessions value category and `SET`: arity varies by frame event count, but every event carries the same fixed slot `P₀`. It also packages finite sheaves into Cubical `Category`-based sheaf categories. Event-dependent session content is deferred; it is not a blocker for R4 or the cross-site `Allow ⊣ Require` statement if those layers stay generic over `FiniteFramePresheaf` / `IsSheaf`.

The interaction algebra layered on top is `O_1` (cyclic operad with one binary generator + cyclic action) — see "Where we landed." The hybrid is what `O_1`'s algebras live over.

Analytic-side mirror is future work; whether the `formal/Analytic/` pattern from ModalHoTT transfers depends on the Concurrency-side base implementation.

## Decisions Log  <!-- tags: kind:decision -->

(Previous ModalHoTT-side decisions archived to `deep_context/archived_decision_logs/2026-05-17.md`.)

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-05-17 | Operadic interaction-algebra layer named on top of hybrid (augmentation, not replacement) | Names what `concurrency_anchor.md` was reaching for; preserves the hybrid scoping intact |
| 2026-05-17 | `O_1` (cyclic operad with one binary op + cyclic action) as the current commitment | Smallest operadic structure that names the actor/session interaction; finitely presented, Agda-reachable |
| 2026-05-17 | `MO_1` (modular envelope) as long-horizon target, not current commitment | Staged rather than committed-and-collapsed; allows incremental validation of the operadic framing |
| 2026-05-17 | Philosophical lean: `Ass_cyc` over `Com_cyc` | Actor send/receive is ordered, session composition non-commutative, dessins live in ribbon-decorated world. Pending ratification before `O_1` Agda starts |
| 2026-05-17 | A-side return plan: lift `Bℤ → S¹`, switch η-iteration → cyclic bar | Cross-site identity (`S¹ ↔ MO_1`) is only statable when both sides have dimension-raising machinery; cyclic bar pairs with `Ass_cyc` |
| 2026-05-17 | Differential cohesion rung elevated to load-bearing for the cross-site bridge | `M̄`'s natural infinitesimal structure needs an A-side infinitesimal layer to talk to; see `targets.md` T3 refinement |
| 2026-05-17 | `Ass_cyc` ratified (was philosophical lean; now committed) | Actor send/receive is ordered, session composition non-commutative, dessins live in ribbon-decorated world, 1=2 reads as cyclic-of-three not symmetric. Closes plain-bar option on A; commits `MO_1` to ribbon-decorated `M̄` |
| 2026-05-17 | R7 target = parameterized `*`-autonomous record (polycategory co-equal, flagged in header) | Minimum that hosts session-type duality natively; doesn't pre-empt `(∞,1)`-enrichment or cohesion. Implemented as the thin signature `Concurrency/Algebras/StarAutonomous.agda`; concrete session target was deferred at this point and later landed in `Sessions.agda` |
| 2026-05-17 | Concurrency-side three-file staging: `Ports.agda` → `RawCyclicOperad.agda` → `CyclicAssociative.agda` | File names earn their semantics. Port arithmetic is the combinatorial substrate (not utility); raw cyclic operad ships without associativity; the named file carries associativity + equivariance. Codex framing |
| 2026-05-17 | Cyclic action named `rot` / `rotate-equiv`, never `involution` | Cyclic rotation has order `n+1`, not order 2; session duality is the involutive structure (order 2) and lives on the algebra side. Discipline enforced at naming time |
| 2026-05-18 | `compₒ` arity convention switched from `O (m + n ∸ 1)` to positive-only `O (suc (l + r))` (inputs `O (suc l)`, `O (suc r)`) | The port-gluing iso `Port (m + n ∸ 1) ≃ (Port m ─ {i}) ⊎ (Port n ─ {j})` is non-total at `m = n = 0` (`Fin 1 ≄ ∅ ⊎ ∅`). Positive-only inputs make the iso total without preconditions; no expressiveness loss (generator set has no nullary ops, reachable arities unchanged) |
| 2026-05-18 | Port-gluing convention: cyclic-equivariant β (`delete-port i k = i +ₘ fsuc k`), not linear punch-in α | β anchors the renumbering to the deleted port, making per-operand cyclic action commute with delete-and-renumber by construction. α uses `<` order on `Fin`, breaking cyclic equivariance and forcing `rot-compₒ` to absorb the discrepancy. Cost: punch lemmas written from scratch rather than reused from stdlib |
| 2026-05-18 | Glue API: equivalence + derived functions, no record wrapper | `port-gluing-equiv : (i j) → Port (suc (l+r)) ≃ Fin (suc l) ⊎ Fin (suc r)` exposed; `port-glue = equivFun`, `port-split = invEq` derived. Matches `feedback_postulates_over_records` (record wrappers reserved for parameter signatures, not gap-filling) |
| 2026-05-18 | `CyclicAssociative.agda` shape: HIT-by-copy of `RawCyclicOperad`'s constructors, plus four law constructors | The cyclic *associative* operad's laws are part of the type, not theorems added after the fact. `RawCyclicOperad.agda` becomes the "without-laws" reference; downstream files import `CyclicAssociative.O`. Quotient alternative ruled out (every function would have to respect the quotient — heavier to use) |
| 2026-05-18 | `rot-compₒ` boundary-swap primitive replaced by full cyclic equivariance: `rot-compₒ-a-block` and `rot-compₒ-b-block`; `boundary-swap` derived | Boundary-swap remains the literal 1=2 perspective-swap theorem for R8, but it now sits at the right logical level. The primitive content is the per-block arbitrary-port translation of cyclic equivariance: rotations landing in `a`'s surviving block preserve operand order; rotations landing in `b`'s surviving block swap operands over `+-comm`. The bridge uses the b-block seam `fzero`, `port-before-survivor-zero`, and `boundary-rot-is-b-seam` |
| 2026-05-18 | Port bookkeeping split between `Concurrency/Operads/PortGluing.agda` and `Concurrency/Operads/PortRotation.agda` | `Ports.agda` stays minimal (Port type, cyclic-group arithmetic); `PortGluing.agda` owns delete / split / associativity reindexing, while `PortRotation.agda` owns boundary rotation and rotation-side helpers. Sibling files, not subdirectories (`feedback_analytic_folder_structure`) |
| 2026-05-19 | `StarAutonomous.agda` landed as a thin target signature, not a full coherence package | Records the operations needed by the algebra layer: underlying 1-category, tensor/unit, symmetric braiding, contravariant involutive duality; derives `⅋`, `⊥-par`, and `⊸`. Omits pentagon/hexagon/triangle, naturality, and the universal property of `⊸`; add fields only when proofs need them |
| 2026-05-19 | Algebra layer split into `Valuation.agda` and structural `OperadAlgebra.agda` | `Valuation` is the weak HIT interpretation `O n → Hom (ports Carrier n) ⊥-par`; codomain is the dualizing object, not tensor unit `𝟙`. `OperadAlgebra` adds `plug`, `shift`, and axioms `⟦ compₒ ... ⟧ = plug ...`, `⟦ rot ... ⟧ = shift ...`, then derives `boundary-swap-structural`. Generic derivation of `plug`/`shift` from arbitrary `StarAutonomous` is deferred |
| 2026-05-19 | `Sessions.agda` v1 landed with explicit `SessionO1Action` | Initially kept `Hom` as structural syntax and packaged `gen` / `plug` / `shift` plus six operadic laws as chosen action data. Later Phase 1 work moved the object grammar to `SessionSyntax.agda`, replaced structural `Hom` laws by the `SessionMorphismSyntax.agda` HIT, and left `session-O1-action` as the single remaining Sessions postulate. |
| 2026-05-20 | Actor-causal site split into `Concurrency/Sites/ActorBase.agda` and `Concurrency/Sites/ActorCausal.agda` | `ActorBase` owns the opaque unityped carrier and Lamport `CausalOrder`; `ActorCausal` owns `LocalFrame`, `FrameHom`, covers, topology fields, and witnesses. Keeps primitive locality separate from site structure while avoiding over-splitting |
| 2026-05-20 | Actor carrier is opaque and unityped | The verified communication kernel cannot distinguish humans, LLMs, or future promoted conversations. Actor-origin metadata belongs outside the kernel; no roles, payloads, sessions, or message syntax appear in the actor site |
| 2026-05-20 | `FrameHom` uses strict causality reflection | A frame morphism is a sub-view embedding: causality is preserved and reflected. Promotion of a completed conversation into an actor-like node is therefore a future quotient/reification morphism class, not a `FrameHom` |
| 2026-05-20 | Actor-site covers use basis form, with `sieve-of` exposed for the E2 transition | Basis covers match implementation-facing local observations and concrete finite witnesses. The semantic endpoint remains the generated sieve / Grothendieck-topology presentation; prove equivalence later rather than starting Actors v1 at the sieve level |
| 2026-05-20 | Actor-site identity and transitivity covers are generic; stability later discharged | `identity-cover-canonical` and `transitivity-cover-canonical` are constructed. `ActorPullback.agda` supplies the generic pullback-stability construction. The old `stability-cover-postulate` has been removed from `ActorCausal.agda`; the bundled tiny site now lives in `TinyActorCausalSite.agda` and uses constructed stability. |
| 2026-05-20 | Actor-site tiny witness upgraded to non-trivial Bool cover | `TinyAB` uses `Fin 2`; `TinyCausal` uses `Bool` events with `false ≤ true`; `PointFrame` embeds by `embed-point false` / `embed-point true`; `two-point-cover` exercises non-trivial index, patch, embedding, and event-lift data |
| 2026-05-20 | Hybrid v1 shipped as adapter layer | `Concurrency/Hybrid/Presheaf.agda` provides generic `FramePresheaf`, zero-postulate `IsSeparatedPresheaf`, and `const-presheaf`; `SessionPresheaf.agda` specializes to `Sessions-Cat Payload` and exposes both `const-𝟙ₛ-presheaf` and `const-⊥ₛ-presheaf`. This implements Adapter 1 (restriction) and names future adapter slots without faking descent or a unit/dualizing conversion |
| 2026-05-21 | Reflexive Protocol Layer named; not implemented | Π = category of protocol versions; protocol edits = morphisms in Π. Promotion (Adapter 5) sharpened with operational role: closed meta-conversation reaching consensus → Π-morphism. Consensus framed as future colimit / coherent amalgamation in a patch-theoretic fragment category, with Pijul as primary implementation-facing candidate; precise categorical shape held open. `Concurrency/Hybrid/Reflexive.agda` reserved as future home. `MO_1` elevated to active roadmap without displacing the B-side R4 path as the next technical step. Layer is new formal content, compatible with and anticipated by current scaffolds but not already implicit in them |
| 2026-06-04 | Finite event-product descent landed | Added finite additive products, finite frames/covers with carried overlap enumerations, generic finite event-product presheaf, and full finite-site descent (`IsSheaf`) over `FiniteCover`s. The result is non-degenerate by arity: `value F = P₀ ^ event-count(F)`, including empty-frame normalization by the terminal additive product. |
| 2026-06-04 | Sessions constant-slot instantiation landed | `Sessions.agda` gained additive product syntax and laws; `SessionEventProductSheaf.agda` instantiates the generic finite witness at `Sessions-Cat Payload`. This is constant-slot B2(a), not event-dependent session content and not additive coproduct universal properties. |
| 2026-06-04 | Tiny finite cover witness landed | `TinyFiniteCover.agda` and `TinyEventProductExample.agda` exercise the finite descent stack on the existing `TinyFrame` / `PointFrame` two-point cover. The proof-level target landed; definitional computation remains only an optional future bonus. |
| 2026-06-04 | V-valued finite sheaf/value category landed | `StarAutonomousCategory.agda`, `FiniteFrameCategory.agda`, `FiniteFramePresheafFunctor.agda`, and `FiniteSheafCategory.agda` package the finite V-valued sheaf layer using Cubical `Category`, bridge existing `FiniteFramePresheaf` records to library functors without re-expressing descent, prove `IsSheaf` is propositional, and exhibit the event-product sheaf as a concrete object. |
| 2026-06-04 | Finite sheaf framework generalized over Cubical `Category` | `CategoryApplicative.agda` and `FinitePresheaf.agda` split out the plain-category core. `FiniteDescent.agda`, `FiniteSheafCategory.agda`, and `FiniteFramePresheafFunctor.agda` now run over any Cubical `Category`, with the V side recovered through `StarAutonomous→Category V`. |
| 2026-06-04 | Set-valued finite sheaf side inhabited | `FiniteProducts.agda` was generalized over `Category`; `SetFiniteProducts.agda`, `SetFiniteSheafCategory.agda`, `SetEventProductSheaf.agda`, and generic `EventProductSheafObject.agda` instantiate the same event-product construction at `SET`. This landed the concrete framework-at-SET object that Strategy D later compares to the library sheaf condition. |
| 2026-06-05 | Strategy D landed: finite Coverage plus SET sheaf comparison | `FramePullbackUniversal.agda`, `FiniteFramePullback.agda`, `FiniteBasisCover.agda`, `FiniteFrameCoverage.agda`, and `SetSheafComparison.agda` complete C8→C9→C6 for the finite site. The sequence is postulate-free; it uses a lean basis cover for the topology, derives finite pullback patches, proves Cubical `Coverage` pullback stability, and compares project `IsSheaf` with library `isSheaf` at the actual `FiniteFrameCoverage`. |
| 2026-06-05 | Benton/LNL chosen for R4; Chu reserved for coefficient/value semantics | R4 is the B-internal cartesian↔linear / forgetful-axis bridge between `Sh_fin(site,Set)` and `Sh_fin(site,V)`, so Benton is the native relationship shape. Chu was not the bridge shape itself; it later entered as a concrete `V`, yielding the `Chu(SET,Bool)` point-generated non-vacuity witness and then the Sessions-to-Chu realization. |
| 2026-06-05 | R4 Tier 3 interface and conditional Tier 4 landed | `ChangeOfBase.agda`, `LinearNonlinear.agda`, and `LinearNonlinearSheafAdapter.agda` land the Benton/LNL presheaf bridge: presheaf change-of-base, `liftF ⊣ liftG`, and right-adjoint sheaf preservation `G-preserves-sheaf`. `FiniteSheafification.agda` names the finite-site reflector `a ⊣ ι`; `LinearNonlinearSheafAdjunction.agda` gives the sheaf-level adjunction conditionally on a V-side reflector. The full-site reflector remains pending, but the pointification spike has landed: `EventPoint.agda`, `EnumeratedProduct.agda`, and `Pointification.agda` construct the variable-slot functorial core of `a(P)(F) = ∏_e P(pt_e)`. The then-open R4 gate after the spike was point-cover geometry and the point-descent/locality route; the 2026-06-06 entries below record those pieces landing and leave `a ⊣ ι` plus point-generated bridge wiring as the live follow-up. |
| 2026-06-05 | Pointification spike landed for R4 reflector route | `EventPoint.agda` generalizes event-point subframes and point-to-point morphisms; `EnumeratedProduct.agda` isolates variable finite-product transport behind `projE`/`tupleE`/`βE`/`ηE`/`extE`; `Pointification.agda` constructs the functorial core `a(P)(F) = ∏_e P(pt_e)` for arbitrary value category `C` with finite products over finite frames at event level `ℓ-zero` and incidence level `ℓA`. This retires the variable-slot transport risk for the point-generated reflector route. Remaining work at that stage was point-cover geometry and the point-descent/locality comparison; the 2026-06-06 entries below record those pieces landing and left `a ⊣ ι` plus point-generated R4 bridge wiring as the then-live follow-up; the 2026-06-07 row records the reflector landing. |
| 2026-06-06 | Point-cover geometry scaffold landed for point-generated R4 | `EventSupported.agda`, `PointOverlap.agda`, and `PointCover.agda` implement the Option-2 geometry: event-supported wrappers, incident/event-supported point overlaps, finite event-discrete point covers, and canonical point cover data. This deliberately avoids `FiniteCover` raw actor-intersection overlaps. |
| 2026-06-06 | Point-descent/locality biconditional landed | `PointDescent.agda` mirrors `FiniteDescent` with product-free descent over the canonical point cover, then in a finite-products scope defines `PointLocal`, proves zero-event subterminality, `local→sheaf`, and `sheaf→local`. This lands `IsPointSheaf P ↔ PointLocal P` for the point-generated site. At that checkpoint the remaining work was `pointify` as a point sheaf, `a ⊣ ι`, and W3 bridge wiring; the 2026-06-07 row records the reflector landing. |
| 2026-06-07 | Point-generated reflector constructed | The supported-subsite route now has the abstract slot-indexed point-product API (`SupportedPointProduct.agda`), rebuilt pointification (`SupportedPointification.agda`), pointification-is-point-sheaf (`PointifyIsSheaf.agda`), the point-sheaf full subcategory and inclusion (`PointSheafCategory.agda`), the reflector functor (`PointSheafification.agda`), and the unit, hom-set bijection, naturality fields, and assembled adjunction `a ⊣ ι` (`PointSheafAdjunction.agda`). The full finite actor-causal reflector remains a later enrichment; the live next step is W3 wiring of this point-generated reflector into the R4 bridge, still relative to value-level `lnl : LNLAdjunction`. |
| 2026-06-07 | Point-generated R4 bridge landed | `SupportedChangeOfBase.agda` lifts value-category functors over `SupportedPresheafCategory`; `SupportedLinearNonlinearSheafAdapter.agda` constructs `supportedLiftF`, `supportedLiftG`, `supportedLiftF⊣supportedLiftG`, and proves `G` preserves point sheaves; `PointLinearNonlinearAdjunction.agda` assembles the point-sheaf Benton/LNL adjunction `Lpoint⊣Rpoint`. The result is generic and reflector-unconditional over the supported point-generated site, while remaining relative to `lnl : LNLAdjunction` and `vProd : HasFiniteProducts (StarAutonomous→Category V)`. |
| 2026-06-23 | Chu coefficient instance and Sessions realization landed | `Chu.agda`, `ChuFiniteProducts.agda`, `ChuMonoidal.agda`, `ChuLinearNonlinear.agda`, `ChuPointVProd.agda`, and `ChuPointExample.agda` instantiate the point-generated R4 hypotheses at `Chu(SET,Bool)`. `SessionSyntax.agda`, `SessionMorphismSyntax.agda`, `SessionObjectModel.agda`, and `SessionChuModel.agda` then give the postulate-free object/morphism Sessions-to-Chu realization (`J0`, `J0-dual`, `J1`, and the underlying Cubical functor). `Sessions.agda` now relies on the morphism HIT for its categorical laws; only `session-O1-action` remains postulated. |

## Blockers  <!-- tags: kind:state -->

(Previous Open Questions archived to `deep_context/archived_blockers/2026-05-17.md`. Deferred items migrated to `future_work.md`.)

Concurrency: none active. First B-side operad, algebra signatures, concrete typed-content `Sessions.agda` instance, actor-causal site v1, Hybrid v1 restriction, finite products, finite covers, finite event-product descent, the constant-slot Sessions sheaf, the concrete tiny finite-cover witness, both V-valued and Set-valued finite sheaf endpoints, the finite C8/C9 Coverage bridge, the C6 SET library comparison, the point-generated R4 bridge, the `Chu(SET,Bool)` coefficient witness, and the Sessions-to-Chu object/morphism realization have shipped. The next substantive choice is no longer a mechanical R4 continuation: either pursue O1-in-Chu / `session-O1-action` by adding earned categorical structure, or open the Reality/Documentation/Chu boundary track. The A-side category of modal contexts and eventual cross-site adjunction remain downstream.
ModalHoTT: none active (paused).

## Current B-side state  <!-- tags: kind:state -->

Older session-end snapshots and rot-comp planning are archived under `workflow/deep_context/`. This section is the compact current state.

### Operads

Shipped to `formal/Concurrency/Operads/` (all five files typecheck under `--cubical --guardedness`):

| File | Role | Line count |
|------|------|-----------:|
| `Ports.agda` | Minimal port type + cyclic-group arithmetic re-exports | ~60 |
| `RawCyclicOperad.agda` | Positive-only `compₒ` HIT without laws; reference / pedagogy stepping-stone | ~180 |
| `PortGluing.agda` | β `delete-port`, `port-gluing-equiv` via library `Fin+≅Fin⊎Fin`, associativity reindexing functions (`a-port-after-inner-glue`, `b-port-after-inner-glue`) | ~145 |
| `PortRotation.agda` | Boundary rotation (`boundary-rot`) plus rotation-side helpers (`port-before-survivor`, seam zero lemma) | ~70 |
| `CyclicAssociative.agda` | HIT-by-copy + four law constructors: `compₒ-assoc-seq`, `compₒ-assoc-par`, `rot-compₒ-a-block`, `rot-compₒ-b-block`; derives `boundary-swap` | ~310 |

### Cyclic equivariance

The old boundary-swap primitive was replaced by full cyclic equivariance in the arbitrary-port presentation:

- `rot-compₒ-a-block`: rotation whose new first composite port lies in `a`'s surviving block;
- `rot-compₒ-b-block`: rotation whose new first composite port lies in `b`'s surviving block, with operand order swapped over `+-comm`.

The former boundary-rotation operand-swap law is now derived:

```agda
boundary-swap :
  PathP (λ ι → O (suc (+-comm l r ι)))
    (rot (boundary-rot l r) (compₒ i j a b))
    (compₒ j i b a)
```

The bridge uses the b-block seam `y = fzero`, plus two Fin bookkeeping lemmas:

- `port-before-survivor j fzero = j`;
- `port-glue (inr fzero) = boundary-rot l r`.

R8 should now refer to `boundary-swap` as the arity-2 / 1=2 theorem induced by cyclic equivariance, not as primitive operad data. The previous `rot-compₒ` open question is no longer a block on algebras.

### Algebras

Shipped to `formal/Concurrency/Algebras/`:

| File | Role | Line count |
|------|------|-----------:|
| `StarAutonomous.agda` | Thin target-category signature: 1-category, tensor/unit, braiding, involutive duality; derives `⅋`, `⊥-par`, `⊸` | ~145 |
| `StarAutonomousCategory.agda` | Adapter from the thin `StarAutonomous` signature to Cubical `Category`, isolating the `⋆` / `∘` convention flip | ~60 |
| `CategoryApplicative.agda` | Applicative-law view of any Cubical `Category`, paired with `StarAutonomousCategory` for convention management | ~75 |
| `FiniteProducts.agda` | Terminal object plus binary products over an arbitrary Cubical `Category`; read additively on the session side and cartesianly at `SET` | ~240 |
| `SetFiniteProducts.agda` | Concrete finite-products instance for Cubical `SET` | ~50 |
| `Valuation.agda` | Weak HIT valuation: `O n → Hom (ports Carrier n) ⊥-par`, with carrier self-duality | ~85 |
| `OperadAlgebra.agda` | Structural Step-2 algebra: valuation plus `plug`, `shift`, `interp-compₒ`, `interp-rot`; derives `boundary-swap-structural` | ~135 |
| `SessionSyntax.agda` | Postulate-free session object grammar, structural duality `_^⊥ₛ`, and proved `dual-involutive` | ~80 |
| `SessionMorphismSyntax.agda` | Set-truncated session morphism HIT: 17 formers, 21 structural/additive laws as path constructors, and hom-set truncation | ~110 |
| `Sessions.agda` | Reuses the syntax/HIT layers to package `Sessions-Cat`, finite products, explicit `SessionO1Action`, `session-interp`, `Sessions-Val`, `Sessions-Alg`, and `boundary-swap-at-gen`; only `session-O1-action` remains postulated | ~400 |
| `SessionObjectModel.agda` | Generic Sessions-to-target interpretation: iso calculus, `SessionObjectModel`, `J0`, `J0-dual`, `J1`, and underlying Cubical functor | ~380 |
| `SessionChuModel.agda` | Concrete `Chu(SET,Bool)` Sessions model with self-dual `end`, nonconstant payload map, and J0/J1 sanity witnesses | ~100 |

`Valuation` is intentionally weaker than `OperadAlgebra`. The latter is the R7 interface to use downstream: it says operadic substitution factors through categorical `plug`, cyclic action factors through `shift`, and the derived `boundary-swap-structural` is the R8-relevant identity. `Sessions.agda` proves that this interface is inhabitable by the typed-content layer, while keeping the canonical derivation of `SessionO1Action` for future richer session-category work. `FiniteProducts.agda` is no longer StarAutonomous-specific; it is the shared finite-product interface used by both the session and Set event-product witnesses.

### Sites

Shipped to `formal/Concurrency/Sites/`:

| File | Role | Line count |
|------|------|-----------:|
| `ActorBase.agda` | Opaque unityped `ActorBase` carrier plus Lamport `CausalOrder`; derives `Concurrent` and `≤-bidir-equal` | ~160 |
| `ActorCausal.agda` | Actor-local frames, strict-reflecting `FrameHom`, frame category laws, basis `Cover`, `sieve-of`, generic identity / transitivity covers, `ActorCausalSite`, and constructive tiny frame/cover witnesses; no project postulates | ~760 |
| `ActorPullback.agda` | Pullback/overlap frames for pairs of `FrameHom`s, projections `pb-π₁` / `pb-π₂`, pullback square, and pullback-stability construction | ~315 |
| `TinyActorBase.agda` | Postulate-free two-actor base `TinyAB` shared by examples | ~30 |
| `TinyActorCausalSite.agda` | Bundled tiny actor-causal site assembled from `TinyAB`, `ActorCausal`, and constructed pullback stability | ~40 |
| `FiniteFrame.agda` | Finite-frame subsite object: `LocalFrame` plus chosen event count and `Event ≃ Fin event-count` enumeration | ~60 |
| `FiniteFrameCategory.agda` | Finite-frame subsite as a Cubical `Category`; `isSetHom` follows from event-map into a set and prop-valued frame-hom laws | ~120 |
| `SupportedFiniteFrameCategory.agda` | Supported finite-frame subsite as a Cubical `Category`, reusing finite-frame morphisms and restricting objects by chosen event support | 73 |
| `FiniteCover.agda` | Finite covers with finite patches and carried finite enumerations of every actual pullback overlap | ~90 |
| `TinyFiniteCover.agda` | Concrete finite lift of the existing Bool two-point cover, including `Bool≃Fin2`, `Unit≃Fin1`, and four-case overlap enumeration | ~190 |
| `FramePullbackUniversal.agda` | Universal property of `frame-pullback`: mediating morphism, projection laws, and uniqueness; supplies the all-cones bridge used by C6 | ~140 |
| `FiniteFramePullback.agda` | Pullback of finite frames is finite with a chosen untruncated enumeration; derives finite pullback patches for the finite coverage | ~125 |
| `FiniteBasisCover.agda` | Lean finite covering-family basis, forgets/completes `FiniteCover`, and adapts to Cubical `Cover` | ~130 |
| `FiniteFrameCoverage.agda` | Cubical `Coverage` over `FiniteFrameCategory`; pullback stability by finite pullback and `pb-square` | ~105 |
| `EventPoint.agda` | Incident event-point subframes (`ActorIn := touches e`), point embeddings, and induced point-to-point morphisms; narrows the point route to incidence level `ℓA` | 131 |
| `EventSupported.agda` | Event-supported frame predicate, chosen support for covers, support-derived actor preservation, P-free point-shape helpers, and support proofs for incident point frames | 171 |
| `PointOverlap.agda` | Event-supported point overlaps replacing raw actor-intersection pullbacks; off-diagonal overlaps become actor-empty through support | 133 |
| `PointCover.agda` | Parallel canonical point-cover interface over finite event-discrete frames with event-supported overlaps, projections, and supported-point packaging | 203 |

The actor site deliberately does not import `Sessions.agda` or operad files. Its job is locality: actor membership, event incidence, causal sub-view embeddings, and local-frame covers. Typed content, `O_1` operations, and conversation-promotion stay out of the carrier.

`FrameHom` is strict: causality is preserved and reflected, making it a sub-view embedding rather than an arbitrary monotone map. This preserves the future distinction between embedding a local view and promoting a completed conversation into an actor-like node.

`Cover` is basis-form (E1), and `sieve-of` remains the bridge artifact for a full actor-site sieve/Grothendieck-topology presentation. On the finite subsite, E2 has landed as `FiniteFrameCoverage`: pullback stability is constructed from finite pullbacks and `pb-square`. The identity and transitivity cover axioms have generic constructions; the former actor-site stability postulate has been eliminated, and the bundled tiny site uses `ActorPullback.agda`'s constructed stability.

The G3 witness is non-trivial: `TinyAB` has two actors (`Fin 2`), `TinyCausal` has two Bool events with `false ≤ true`, `PointFrame` embeds into `TinyFrame` via `embed-point false` and `embed-point true`, and `two-point-cover` covers `TinyFrame` by the two event-patches.

### Hybrid

Shipped to `formal/Concurrency/Hybrid/`:

| File | Role | Line count |
|------|------|-----------:|
| `Presheaf.agda` | Generic arbitrary-frame adapter chassis: `FramePresheaf`, zero-postulate `IsSeparatedPresheaf`, and `const-presheaf` | ~250 |
| `SessionPresheaf.agda` | Arbitrary-frame Sessions specialization and constant witnesses `const-𝟙ₛ-presheaf` / `const-⊥ₛ-presheaf` | ~135 |
| `FinitePresheaf.agda` | Category-generic finite-frame presheaf record (`value`, `restrict`, identity, composition) | ~60 |
| `EventProductPresheaf.agda` | Category-generic finite-frame event-product presheaf from `HasFiniteProducts C`: `value F = P₀ ^ event-count(F)` | ~200 |
| `EnumeratedProduct.agda` | Variable finite-product wrapper over an enumerated index type; isolates `projE`/`tupleE`/`βE`/`ηE`/`extE` transport for pointification | 124 |
| `FiniteDescent.agda` | Category-generic finite-cover matching families, amalgamation, separatedness, and `IsSheaf` records over `FiniteFramePresheaf` | ~125 |
| `EventProductSheaf.agda` | Category-generic proof that the event-product presheaf is a full finite-site sheaf over `FiniteCover`s | ~275 |
| `EventProductSheafObject.agda` | Generic packaging of the event-product sheaf as an object of `FiniteSheafCategory` | ~45 |
| `FiniteFramePresheafFunctor.agda` | Bridge from `FiniteFramePresheaf` records to Cubical functors over `FiniteFrameCategory ^op`; descent files are not re-expressed | ~65 |
| `FiniteSheafCategory.agda` | Cubical `Category` of finite presheaves, `isPropIsSheaf`, and full subcategory of finite sheaves over an arbitrary target `Category` | ~215 |
| `SetFiniteSheafCategory.agda` | Framework-at-`SET` endpoint: finite Set-valued sheaf category over the shared finite site | ~55 |
| `SetEventProductSheaf.agda` | Concrete Set-valued event-product presheaf, sheaf proof, and object of `Sh-fin-Set` | ~70 |
| `SessionEventProductSheaf.agda` | Constant-slot Sessions instantiation of the generic finite event-product sheaf via `StarAutonomous→Category` | ~100 |
| `TinyEventProductExample.agda` | End-to-end concrete finite descent example: tiny matching families, amalgamation, separatedness, and Sessions specialization | ~175 |
| `SetSheafComparison.agda` | C6: project SET `IsSheaf` iff Cubical library `isSheaf` for `FiniteFrameCoverage`; split into pullback-UP content and SET pointwise well-pointedness | ~295 |
| `ChangeOfBase.agda` | Generic value-functorial change of base on finite presheaf categories; structural frame-noninterference lemma | ~115 |
| `LinearNonlinear.agda` | Interface-first Benton/LNL value adapter: `F ⊣ G`, strong-monoidal comparisons for `F`, `!` named as `F∘G`, no mix map | ~125 |
| `LinearNonlinearSheafAdapter.agda` | R4 / Benton-LNL assembly: presheaf lifts, presheaf-level `liftF ⊣ liftG`, `G` sheaf preservation, and explicit `F-PreservesSheaf` obligation type | ~240 |
| `Pointification.agda` | Point-product presheaf `a(P)(F) = ∏_e P(pt_e)` for arbitrary `C` with finite products over `ℓ-zero` events / `ℓA` incidence; proves functoriality | 219 |
| `SupportedPresheafCategory.agda` | Category-generic presheaves over the supported finite-frame subsite, with natural transformations and composition laws | 142 |
| `RestrictToSupported.agda` | Restriction functor from finite-frame presheaves to supported finite-frame presheaves | 88 |
| `SupportedPointProduct.agda` | Abstract slot-indexed point-product API; keeps `pointProduct SF slot` opaque so Agda does not reconstruct frames from `sfCount`/`sfEnum` | 97 |
| `SupportedPointification.agda` | Pointification over the supported subsite, rebuilt on the abstract point-product API; exposes point projections, unit, unwrap, and projection naturality | 244 |
| `SupportedPointDescent.agda` | Supported point-cover descent, `PointLocal`, point-sheaf/point-local comparison, and point-family matching for the adjunction | 417 |
| `PointifyIsSheaf.agda` | Proof that supported pointification is point-local / a point sheaf | 155 |
| `PointSheafCategory.agda` | Full subcategory of supported point sheaves and the inclusion functor `ιP` | 61 |
| `PointSheafification.agda` | Reflector functor `a : SupportedPresheafCategory → PointSheafCategory` | 190 |
| `PointSheafAdjunction.agda` | Unit, hom-set bijection, naturality fields, and assembled point-generated reflector adjunction `a ⊣ ι` | 368 |
| `SupportedChangeOfBase.agda` | Supported-subsite change-of-base engine for value-category functors | 96 |
| `SupportedLinearNonlinearSheafAdapter.agda` | Supported Benton/LNL lifts, supported presheaf-level adjunction, and `G` preservation of point sheaves | 193 |
| `PointLinearNonlinearAdjunction.agda` | Point-generated sheaf-level Benton/LNL adjunction `Lpoint ⊣ Rpoint`, using `a ⊣ ι` | 133 |
| `PointDescent.agda` | Product-free point-cover descent, `PointLocal`, zero-event subterminality, and `IsPointSheaf P ↔ PointLocal P` over finite products | 426 |
| `FiniteSheafification.agda` | Generic finite-site sheafification reflector interface `a ⊣ ι` over a value category | ~90 |
| `LinearNonlinearSheafAdjunction.agda` | Conditional sheaf-level Benton/LNL adjunction from `liftF ⊣ liftG`, `G` sheaf preservation, and a V-side finite sheafification reflector | ~130 |

The arbitrary-frame Hybrid v1 files remain the adapter-layer scaffold. The finite layer adds full sheaf inhabitants and now assembles both the V-valued/session finite sheaf category and the framework-at-`SET` finite sheaf category. It now bridges the finite site to Cubical `Coverage` and proves agreement with the library `Sheaf` condition at `SET`. R4 is stated and proved conditionally as a Benton/LNL finite-sheaf bridge: presheaf-level change-of-base and the presheaf-level adjunction are complete, the right adjoint preserves finite sheaves, the left side is mediated by the `FiniteSheafification` reflector interface, and the sheaf-level adjunction is assembled from those ingredients. The point-generated supported route now constructs the parallel reflector adjunction `a ⊣ ι` and wires it into the sheaf-level Benton/LNL bridge `Lpoint ⊣ Rpoint`, using the abstract `SupportedPointProduct` API as a load-bearing elaboration boundary. It still does not construct the full Set-valued locality topos/internal logic or the generic full finite actor-causal sheafification reflector. The original restriction adapter shape is:

```agda
FrameHom AB G F → Hom (value F) (value G)
```

and the auditability/separatedness property:

```agda
cover-jointly-monic :
  (c : Cover AB ℓI F) →
  (x y : Hom X (value F)) →
  ((i : Cover.Index c) → restrict (Cover.embed c i) ∘ x ≡ restrict (Cover.embed c i) ∘ y) →
  x ≡ y
```

Design constraints held: no payloads or roles on actors, no promotion, no hidden `𝟙ₛ ↔ ⊥ₛ` conversion, and no mutation of the arbitrary-frame adapter to fake descent. The finite descent layer is explicit: it uses `FiniteFrame`, `FiniteCover`, additive products, and proof-level product universal properties. The Sessions landing is constant-slot only; event-dependent slots remain future work.

The tiny finite-cover example validates the carried-overlap interface on a concrete non-trivial cover: diagonal overlaps are contractible, off-diagonal overlaps are empty, arbitrary local parts glue proof-level into a global 2-ary event product, and separatedness is exercised through `cover-jointly-monic`. No structural `FiniteCover` revision, transport machinery, or new postulate was needed.

Verification record: the finite-site stack, both endpoints, the Strategy D bridge, the supported point-generated reflector stack, and the point-generated R4 bridge typecheck green, including `TinyFiniteCover`, `FramePullbackUniversal`, `FiniteFramePullback`, `FiniteBasisCover`, `FiniteFrameCoverage`, `SetSheafComparison`, `CategoryApplicative`, `FiniteProducts`, `SetFiniteProducts`, `StarAutonomousCategory`, `FiniteFrameCategory`, `FinitePresheaf`, `FiniteDescent`, `EventProductPresheaf`, `EventProductSheaf`, `EventProductSheafObject`, `FiniteFramePresheafFunctor`, `FiniteSheafCategory`, `SetFiniteSheafCategory`, `SetEventProductSheaf`, `SessionEventProductSheaf`, `TinyEventProductExample`, `Presheaf`, `SessionPresheaf`, `PointSheafAdjunction`, `PointLinearNonlinearAdjunction`, and `Sessions`. The only warnings are inherited `UnsupportedIndexedMatch` sites from finite-product / finite-enumeration helpers; they remain inert under the proof-level API discipline.

### Reflexive Protocol Layer  <!-- tags: kind:reference -->

Named here as a future commitment; no Agda content yet. Canonical source: `deep_context/arc/07_self-modifying_protocol.md`.

The framework treats some conversations as *meta-conversations*: special conversations whose role is to inspect and (on consensus) modify the protocol itself. The operational picture has four pieces, all of which translate to mathematics already named by the static framework but not yet formalised at this layer:

1. **Protocol-version category Π.** Protocols themselves form objects of a small category Π; a protocol edit is a morphism in Π. The reflexive layer lives over Π by a forgetful functor that recovers the current Hybrid structure at each version.
2. **Non-retroactivity.** Past events live under the protocol active at the time of their occurrence; protocol edits affect future events only. This is already enforced at the locality leg: `FrameHom`'s strict causality reflection in `ActorCausal.agda` makes retroactive rewriting structurally impossible, which is why promotion was deliberately excluded from `FrameHom` and reserved as a separate morphism class.
3. **Promotion as bridge (Adapter 5, sharpened).** A closed meta-conversation that has reached consensus *promotes* into a Π-morphism. This is the concrete operational duty of the Promotion adapter named in `Hybrid/Presheaf.agda`'s header: not just "conversation becomes actor," but "consensus of a meta-conversation becomes a protocol edit."
4. **Consensus as future colimit / coherent amalgamation.** Edit proposals from inside a meta-conversation form a diagram; consensus is intended to become colimit / existence of coherent amalgamation in a future patch-theoretic fragment category. **Pijul is the primary implementation-facing candidate**; the precise categorical shape (category, double category, event structure, adhesive category, partial-commutation presentation) is held open until the candidate is examined honestly. Inconsistent proposals — a diagram with no colimit / no coherent amalgamation — give the framework an honest formal counterpart of "the protocol cannot be coherently edited from here."

**Why this is new formal content, not already-present.** The current Agda scaffolds were *designed to receive* the reflexive layer: `ActorCausal` blocks promotion as `FrameHom`; `Sessions` explicitly defers conversation-of-conversations to `MO_1`; `Hybrid/Presheaf` names Promotion as Adapter 5. None of these contain protocol versions, edit morphisms, or version-indexing. The reflexive layer is compatible with and anticipated by the scaffolds, but it is not already implicit in them.

**Self-scanning as eventual operational interpretation.** "Regular-interval meta-conversations" map naturally onto modal iteration on the A-side, but the formalised iteration in `ModalHoTT/Modalities/Iteration.agda` + `IterationCohesion.agda` lands only the first-level collapse — not the dimension-raising cyclic bar construction required for the cross-site recursion. Self-scanning is the operational interpretation of that *future* recursion, not of the current scaffold.

**Roadmap impact.**

- **Promotion (Adapter 5)** gets a concrete job description; header sharpened in `Hybrid/Presheaf.agda`.
- **`MO_1` / modular envelope** elevated from "held loose" to active roadmap as the natural home for self-gluing / conversation-of-conversations. This does *not* displace the immediate exposition / instantiation track for the point-generated R4 theorem — `MO_1` becomes the natural next slot only after the Hybrid site-axis, the point-generated bridge, and the intended instantiation story are stable enough to support modular-envelope work; the cross-site adjunction and bar-construction comparison remain downstream.
- **B-side dual of T_recursion iteration** (deferred per `future_work.md` "until `ND` has non-trivial content") becomes statable once the reflexive layer gives `ND` operational meaning.

**Where it goes in the Agda tree.** `Concurrency/Hybrid/Reflexive.agda` reserved as the future module slot. Kept inside the Hybrid layer because the protocol-version structure reads as one more adapter (between the current Hybrid instance and the next), and because the project avoids premature folder proliferation. If the file later grows into a genuinely higher-order protocol calculus, it can be split out to `Concurrency/Meta/` at that point.

**Trigger for opening `Hybrid/Reflexive.agda` v0.** Two conditions, both required: (a) the point-generated R4 bridge and its exposition / instantiation boundary are stable enough that the Hybrid chassis is no longer moving, and (b) the fragment-category candidate (Pijul or alternative) honest enough to state in Agda.

### Next frontier

1. **Exposition of the point-generated R4 theorem** — polish the extended abstract / point-generated theorem note. State the supported event-discrete site, the point reflector `a ⊣ ι`, the value-level LNL hypothesis, the resulting `Lpoint ⊣ Rpoint`, and the exact limitations. Avoid making the theorem sound full-site, session-specific, or cross-site.
2. **Optional instantiation checks** — decide whether to add concrete SET/Sessions-facing examples, especially `vProd` for the intended linear value category and any lightweight examples that make the theorem non-vacuous without overcommitting to full session semantics.
3. **Full actor-causal reflector enrichment** — later, decide whether to extend the point-generated construction to richer covers where causality and actor incidence become descent content. This is where colimit/exactness questions may return.
4. **Cross-site `Allow ⊣ Require`** — define the A-side category of modal contexts, then the actual functors, unit, counit, and triangle identities; instantiate the generic iteration scaffold only after the B-internal adapter is stable enough to serve as the operational side.
5. **A-side return plan** (lift `Bℤ → S¹`, switch η-iteration → cyclic bar) — on hold until the cross-site adjunction is statable.

### Held-loose long-horizon items (no near-term action)

- **Pask-style human-implementation layer** — conversation-as-operadic-composition. Speculative until `MO_1` makes "conversation creates conversation" a literal operadic operation. Held in motivation only.
- **Pedagogy track** — current for the synthetic ModalHoTT and Concurrency Agda trees as of 2026-05-21. `pedagogy/01_ModalHoTT/` now has a top-level intro, companions for all current synthetic `ModalHoTT/Modalities` files, and `02_Cohomology/01_flatcoefficients.md`; `pedagogy/02_Concurrency/` mirrors all current `formal/Concurrency/` folders. Analytic pedagogy remains intentionally out of scope unless explicitly requested.

## Historical note

The detailed rot-compₒ discussion that led to the 2026-05-18 cyclic-equivariance repair is archived. The durable outcome is recorded above: full cyclic equivariance is primitive, `boundary-swap` is derived, and the algebra layer uses `boundary-swap-structural` rather than treating binary session duality as the whole cyclic story.

## Next step

● Caught up on both tracks now. Here's the coordinated read.

  The implementation work reshaped the formal landscape

  When the crossroad was framed (in status_formal), there were three formal options: O1-in-Chu, Reality/Documentation, full reflector. The implementation track has since added a fourth, and it 
  sits between the two legs: the Realization / junction theorem — WellFormed RawTrace → LocalFrame, plus renaming and valid-reordering invariance. TinyTrace.agda is currently a concrete witness of
  this; the generic version is deferred-by-design.

  So the formal side now splits into two sub-tracks, and it's worth being explicit about which is which:

  - Verification-layer formal work (the junction): Realization + invariance. This is the Agda that makes the runtime contract mean something in the actor-causal substrate. It belongs to the
  "implementation + its verification layer" leg of the bandwidth split you wanted.
  - Pure-conjecture formal work (the crossroad): O1-in-Chu, Reality/Documentation/Chu, full reflector — eventually cross-site Allow ⊣ Require. This is "this side" — the side we worked this
  session.

  My recommendation, in priority order

  1. Next formal step: prove renaming / valid-reordering invariance of raw traces (the forced half of the junction). This is the single highest-leverage Agda artifact right now, and crucially it's
  rising-sea-forced: the v0 contract already claims it informally ("causal parents point backward by list position, independent of the numeric ID"). Right now that's an unbacked claim. A theorem
  closes the honest gap Claude-impl named — that the two legs agree today only because they share a hand-authored fixture corpus, not because of a theorem. And it's not busywork on the conjecture:
  renaming invariance is exactly the unityped-actors commitment made precise ("meaningless IDs ⇒ isomorphic model"), which is core to the whole arc. Hold the generic RawTrace → LocalFrame bridge
  until a second trace shape forces it (per the file's own rising-sea note).

  2. Then, on the pure-conjecture side: Reality/Documentation/Chu over O1-in-Chu. Among the three crossroad options, Reality/Documentation is the one that coordinates with where implementation is 
  heading: the implementation track's deferred Boundary / Audit / Certificate files and its B-status "no-leak / Reality boundary / erasure" vocabulary are exactly what the
  Reality/Documentation/Chu formal slice would give meaning to. Doing it next means the two tracks converge on a shared boundary notion rather than drifting. O1-in-Chu stays the named deep target,
  but it's a self-contained research problem (needs earned closed/eval/cut structure) that doesn't coordinate with the implementation — so it's the wrong thing to spend the "convergence" window
  on. The full reflector is later.

  Rising-sea caveat on #2: don't open a heavy Reality/Boundary module until the implementation's boundary vocabulary forces it. The implementation track itself says Boundary/Audit should "earn
  their own files." So #2 is the direction for the conjecture bandwidth, but the forced next move is #1.

  One-liner

  The next formal step is the renaming-invariance / junction theorem — it's forced, it's high-credence, it backs a claim the contract already makes, and it's the unityping commitment made precise;
  with Reality/Documentation/Chu as the conjecture-side direction after it, chosen specifically because it converges with the implementation's coming audit/boundary layer rather than diverging
  from it.

  This is a recommendation for you and Codex to weigh — I've written nothing. Want me to draft the precise Agda statement of the renaming/reordering-invariance theorem (signature only, against
  RuntimeContract/Trace.agda and the substrate) for review before any code?

✻ Crunched for 1m 44s · 4 shells still running

❯ Can you please read /arc/12_corresp* and tell me if it changes something to your recomendations for the next steps, in either direction?                                                          

● I'll read that arc file.

● Bash(cd /home/ig/Code/hoapa/workflow/deep_context/arc 2>/dev/null && ls -la 12_corresp* 2>/dev/null || find /home/ig/Code/hoapa/workflow -ipath '*arc*12_corresp*' |…)
  ⎿  -rw-rw-r-- 1 ig ig 16553 Jun 25 15:53 /home/ig/Code/hoapa/workflow/arc/12_correspondence_math_runtime.md

  Read 1 file (ctrl+o to expand)

● Yes — arc/12 changes my recommendation, in a specific and useful direction. It's the most relevant document for this question, because it's about exactly the junction I was circling. Here's the
  honest update.

  What it changes

  1. It elevates the generic Realization theorem from "defer until forced" to "the next formal step" — by reframing what "forced" means. My prior recommendation leaned on the implementation
  track's rising-sea rule ("don't prove generic RawTrace → LocalFrame until a second trace shape forces it") and so I said: do cheap renaming invariance now, defer the generic bridge. arc/12
  argues the forcing here isn't a second trace shape at all — it's credence: until Realization exists, "the runtime emits evidence that realizes an actor-causal object in the very topos the 
  conjecture is about" is prose, not a theorem. For the conjecture side specifically, that is the forcing. arc/12 calls this "the most important question in the whole implementation track" and
  "the credence mechanism" separating hoapa from the slogan-level universal theories related_structures.md warns about. That's a stronger argument than my rising-sea deferral, and I'm updating
  toward it.

  2. It splits "renaming invariance" into two levels, and the valuable one needs Realization first. I had treated renaming invariance as the cheap, forced next step. arc/12 shows that's only half
  true:
  - The predicate-level version — WellFormed(σ·t) ↔ WellFormed(t) for an ID bijection σ — is cheap, substrate-free, provable at Trace.agda now. Backs the contract's claim, but it's the modest
  version.
  - The version arc/12 is excited about is univalent renaming invariance of the realized object: a renaming is an equivalence of presentations, so the realized substrate objects are equal, not 
  merely iso. That one needs the generic Realization to even state — and it's the one carrying the three big payoffs: it's the runtime-boundary instance of univalence, it's unityping-as-a-theorem
  ("any actor renamed to any other, object unchanged"), and it's the positive core of the deferred no-leak theorem.
  
  So my "cheap forced renaming invariance is next" was understated: the prize requires Realization.

  3. It unifies my two recommendations. I'd given (1) the junction and (2) "Reality/Documentation/Chu on the conjecture side" as separate. arc/12 makes them the same line: renaming invariance is
  "a genuine piece of the deferred semantic no-leak theorem," and no-leak is the Reality/Documentation boundary's core. So the junction + renaming invariance is the first concrete rung of the
  no-leak/Reality direction I recommended — not a detour from it. And arc/12 notes Realization is structurally "J for traces" — the same syntax → interpretation → semantics shape as SessionSyntax 
  → SessionObjectModel → Chu (J0/J1), so it reuses machinery we just built.

  What it confirms

  The junction over O1-in-Chu (O1-in-Chu stays the self-contained deep target, not the coordinating move), and renaming invariance as the conceptual prize.

  Caveats it adds (from Codex, worth heeding)

  - Realization is real proof work, not "near-mechanical": building CausalOrder from parent edges needs reflexive-transitive closure + antisymmetry + propositionality; LocalFrame needs
  ActorIn/touches/touches-in-frame packaging.
  - It must be parameterized by a session-tag environment (raw sessionTag : ℕ → real SessionType); content/provenance stay opaque.
  - Phrase the payoff narrowly first: "this well-formed trace realizes a finite actor-causal frame/object," not "lives in the full topos" — the sheaf/R4 transport comes only once the realized
  object satisfies the finite-site hypotheses.
  - Tier-0 correspondence (the audit table) is prose-backed traceability, not proof; the proof starts at Realization. (So don't let the abstract or status say "provably mirrors" yet.)

  The one tension to surface

  arc/12 (credence argument: build the junction next) sits against the implementation track's explicit "defer generic realization until forced" + Codex-impl's "do not implement generic realization
  in the loop-1 session." These aren't contradictory once you separate bandwidth: the implementation bandwidth should still close loop 1 + first emission (Codex/Claude-impl converge there); the
  conjecture bandwidth — "this side," what you asked about — should go to the Realization junction, because that's where arc/12's credence argument applies.

  Revised recommendation

  Next formal step (conjecture side): the generic Realization theorem — WellFormed RawTrace → finite actor-causal object of ActorCausalSite, tag-environment-parameterized, content/provenance
  opaque — capped by univalent renaming/valid-reordering invariance. That single result is the junction where the two legs meet, it's the first provable rung of the no-leak/Reality direction, and
  it converts "the protocol is an instance of the mathematics" from analogy to theorem. O1-in-Chu and the full reflector stay later; the cheap predicate-level renaming lemma is an optional
  warm-up, not the target.

  Net: arc/12 didn't reverse me, but it moved the generic Realization from "defer" to "do next," and showed my #1 and #2 are one thing. Want me to draft the precise Agda statement (signature + the
  tag-environment parameter + the narrow payoff type), holed, against Trace.agda and ActorCausal/FiniteFrame, for you and Codex to review before any proof work?

✻ Brewed for 1m 53s · 4 shells still running

※ recap: Goal: ship the Chu-upgraded extended abstract and pick the next formal step. The abstract is reviewed and near-done; I recommend the generic Realization junction theorem (with renaming 
  invariance) next. Next action: on your go, I draft its Agda signature for review.

❯ Do you agree with that:                                                                                                                                                                           
                                                                                                                                                                                                    
  {                                                                                                                                                                                                 
  • I agree with Claude’s update in direction, with two important brakes.                                                                                                                           
                                                                                                                                                                                                    
    Arc/12 does change the next step: the immediate formal priority is now the runtime-to-substrate junction, not O1-in-Chu and not a fresh Reality/Documentation module. Trace.agda already names  
    this correctly: raw traces are decidable presentations, substrate-free, with RuntimeContract/Realization.agda as the deferred bridge (formal/RuntimeContract/Trace.agda:20). And TinyTrace.agda 
    already proves the first concrete witness, while explicitly saying it is not the generic bridge because it reuses TinyCausal instead of deriving causality from causalParents (formal/          
    RuntimeContract/Realization/TinyTrace.agda:19).                                                                                                                                                 
                                                                                                                                                                                                    
    My amendment: do not make the next sprint “full generic Realization plus univalent renaming equality” in one bite. The rising-sea version is:                                                   
                                                                                                                                                                                                    
    1. Mark loop 1 as actually green in workflow. I ran make test; generation/freshness, Agda, TinyTrace.agda, and Elixir tests all pass.                                                           
    2. Open the generic realization track, but first prove the machinery it needs: Boolean predicate reflection, finite carriers from validated IDs, parent-edge reachability/closure, and a        
       CausalOrder generated from backward parents.                                                                                                                                                 
                                                                                                                                                                                                    
    3. Then prove WellFormed r -> RealizedFrame r or equivalent, narrowly: “this trace presents a finite actor-causal object.” Not “the runtime lives in the full topos” yet.                       
    4. Then prove invariance in stages: predicate-level renaming/reordering first if cheap; realized-object equivalence next; univalent equality only after the packaging makes that natural.       
                                                                                                                                                                                                    
    I also think Claude slightly overstates the session-tag environment as part of the minimal bridge. It is needed for a richer realized contract, but LocalFrame itself does not contain session  
    tags. The first bridge can be actor-causal only; session assignment can be a separate layer over realized conversations.                                                                        
                                                                                                                                                                                                    
    So my next-step recommendation is:                                                                                                                                                              
                                                                                                                                                                                                    
    - Verification/implementation direction: generic Realization is next, staged as above. This is the real meeting point of the implementation and formal legs.                                    
    - Pure conjecture direction: Reality/Documentation/Chu remains the better next conceptual direction after that, because Realization and renaming invariance are already the first               
  no-leak/boundary                                                                                                                                                                                  
      rung.                                                                                                                                                                                         
                                                                                                                                                                                                    
    - Do not prioritize O1-in-Chu now: it remains the serious postulate-elimination target, but it does not coordinate with the runtime bridge as directly.                                         
    - Do not prioritize full reflector enrichment now: useful later, but the trace-to-frame bridge is more forced.                                                                                  
                                                                                                                                                                                                    
    One workflow note: workflow/arc/12_correspondence_math_runtime.md is currently untracked, and status_implementation.md still has some stale “loop 1 open” prose despite the tests passing.      
                                                                                                                                                                                                    
  ─ Worked for 8m 26s                                                                                                                                                                               
  ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────                  
                                                                                                                                                                                                    
                                                                                                                                                                                                    
  › Wouldn't it be more accurate to state that we have actually 3 directions:                                                                                                                       
    A. Pure implementation (Elixir, Rust)                                                                                                                                                           
    B. Runtime-to-substrate junction (Agda that looks at E/R)                                                                                                                                       
    C. Pure conjecture chasing (Agda)                                                                                                                                                               
    ?                                                                                                                                                                                               
                                                                                                                                                                                                    
    And I would organize sessions C-B-A, where A echoes/uses B, and C is sort of indepencently developing.                                                                                          
                                                                                                                                                                                                    
                                                                                                                                                                                                    
  • Yes. That is more accurate.                                                                                                                                                                     
                                                                                                                                                                                                    
    The real split is three lanes:                                                                                                                                                                  
                                                                                                                                                                                                    
    - A. Pure implementation: Elixir/Rust/runtime engineering. Event log, codecs, stubs, persistence, checker invocation, later UI.                                                                 
    - B. Runtime-to-substrate junction: Agda interpretation layer. It consumes runtime-shaped evidence and proves it realizes actor-causal substrate objects. This is not pure implementation and   
  not                                                                                                                                                                                               
      pure conjecture; it is the hinge.                                                                                                                                                             
                                                                                                                                                                                                    
    - C. Pure conjecture chasing: Agda/math development not directly forced by current runtime artifacts: Reality/Documentation/Chu, O1-in-Chu, full reflector enrichment, later cross-site work.   
                                                                                                                                                                                                    
    I also like C-B-A as a session rhythm, with one caveat: B should remain the discipline point. C can develop independently, but A should not chase C directly. A should echo B, because B is     
  where                                                                                                                                                                                             
    “what the runtime emits” becomes “what the mathematics recognizes.”                                                                                                                             
                                                                                                                                                                                                    
    So the dependency graph is:                                                                                                                                                                     
                                                                                                                                                                                                    
    C develops future formal vocabulary and possible targets.                                                                                                                                       
    B only imports from C once a stable theorem/interface is actually useful.                                                                                                                       
    A implements against B’s current contract and produces evidence B can validate.                                                                                                                 
                                                                                                                                                                                                    
    That keeps rising-sea intact. C raises distant formal land; B raises the verified shoreline; A builds on the part of the shore that is already exposed.                                         
                                                                                                                                                                                                    
    For the next cycle, I would frame it as:                                                                                                                                                        
                                                                                                                                                                                                    
    1. C session: choose and bound the conjecture direction, probably Reality/Documentation/Chu, without opening a big boundary module prematurely.                                                 
    2. B session: start generic Realization in staged form, beginning with causal-order-from-parents and WellFormed -> finite actor-causal object.                                                  
    3. A session: extend runtime only where it gives B better evidence: more fixtures, emitted traces, checker boundary, maybe a second trace shape.                                                
                                                                                                                                                                                                    
    That is cleaner than “implementation vs formal.” B deserves its own name.                                                                                                                       
  }                                                                                                                                                                                                 
                                                                                                                                                                                                    
  ?                                                                                                                                                                                                 

● Yes — I agree, and two of Codex's corrections are genuine improvements to what I said, not just hedges. Let me be specific about where I concede and the one place I'd refine.

  Where Codex corrects me, and I concede

  The staging brake is right; my "draft the whole thing" was too big a bite. "Full generic Realization + univalent renaming equality in one sprint" is exactly the over-reach rising-sea is meant to
  prevent. Codex's order is correct:
  1. machinery first — finite carriers from validated IDs, parent-edge reachability/closure, and CausalOrder from backward parents;
  2. then WellFormed r → RealizedFrame r narrowly ("presents a finite actor-causal object"); 
  3. then invariance in stages — predicate-level renaming/reordering first, realized-object equivalence next, univalent equality last, once the packaging makes it natural.

  And the load-bearing rung is unambiguous: deriving _≤_ from backward parents means reflexive-transitive closure, antisymmetry from the backward-by-position acyclicity, and prop-truncating
  reachability to satisfy ≤-isProp. That single lemma is most of the "real proof work" Codex flagged; everything else (Fin n carriers are sets, RealizedFrame packaging) hangs off it. So univalent
  equality as the capstone, not the opening move — agreed.

  The session-tag environment: Codex is right, I over-included it. I checked LocalFrame's fields — causal, ActorIn, touches, touches-in-frame — there is no session content in it. So the minimal
  bridge (WellFormed → finite actor-causal frame) needs no tag environment at all; session assignment is a strictly later layer over realized conversations. That actually makes the first bridge
  leaner (one fewer parameter), which is more rising-sea, not less. The tag environment only re-enters when we extend the bridge past locality into session content. I withdraw it from the minimal
  target.

  Where I strongly endorse the reframe

  Naming B as its own lane is better than my "two formal sub-tracks." The junction is neither pure implementation nor pure conjecture — it's the hinge, and it's the discipline point where "what
  the runtime emits" becomes "what the mathematics recognizes." That's the credence mechanism, so it deserves its own name. The dependency DAG is exactly right: A → B (A implements against B's
  current contract and produces evidence B validates), B ⇠ C only when a C-result becomes a stable, useful interface, and C runs free. "A echoes B, never chases C directly" is the precise
  anti-drift rule — it's what stops the implementation outrunning the mathematics, which is the failure mode related_structures.md catalogues.

  My one refinement

  Distinguish the lane DAG (hard) from the C-B-A rhythm (soft). The DAG is a real constraint. "C-B-A every cycle, C first" is a default cadence, not a dependency — and for the immediate next cycle
  I'd weight it toward B, because B (staged Realization, starting at CausalOrder-from-parents) is the forced, highest-credence move right now, while C (bounding Reality/Documentation/Chu) is "the
  better conceptual direction after Realization" by Codex's own analysis. So I wouldn't read C-B-A as "always open a C session first"; I'd read the three lanes as ordered by distance from exposed
  shore, and right now B is the shoreline to build. C can precede or run in parallel, but it shouldn't delay B. (This is consistent with Codex — its priority list says generic Realization is next
  and Reality/Documentation comes after — just making the rhythm-vs-DAG distinction explicit so we don't rigidify "C first.")

  The two workflow-hygiene items Codex raised (arc/12 untracked; status_implementation.md still says "loop 1 open" though make test passes) are real and are his files to fix — agreed they should
  be cleaned so the gates report only meaningful drift.

  Net: I agree with the three-lane model and the staged B-first plan, with the session-tag environment dropped from the minimal bridge and "univalent equality" demoted to the capstone. If you
  want, my next concrete contribution is to draft — signature/holes only, for you and Codex to review — the first rung: CausalOrder derived from a WellFormed trace's backward parents (the closure
  + order-laws lemma), since that's the forced bottom of the B staging and everything else depends on it.
