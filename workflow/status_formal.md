---
tags: [focus:cross-site, kind:state, level:scoping]
---

# Formal Status

The arc is articulated in `arc.md` (now pair-first: `Allow ⊣ Require` with the five arc/09 anchors) and decomposed into propositions T1–T7 plus T_recursion in `targets.md`. Philosophical seed in `motivation.md`. Brainstorming archive: `deep_context/arc/`.

Bandwidth is on Concurrency, after a cycle of reframes that has converged: actor-causal + Caires-Pfenning hybrid (substrate) augmented by an operadic interaction-algebra layer (`O_1`), with the modular envelope `MO_1` as long-horizon target. ModalHoTT is paused at the de Rham named-coefficient rung with a defined return plan (S¹ + cyclic bar construction) coordinated with the concurrency commitment.

## Concurrency  <!-- tags: focus:concurrency, level:scoping -->

### Where we landed

The Concurrency work has converged after a cycle of reframes: icosahedral (A_5 / S²-equivariant) → actor-causal + Caires-Pfenning hybrid (per `deep_context/arc/02_concurrency_anchor.md`) → operadic interaction-algebra layer named on top of the hybrid (per `deep_context/arc/03_attachement_in_arc.md`). The current commitment treats the hybrid as substrate and the operadic layer as augmentation, not replacement. The concurrency line has *cycled*, not drifted: each reframe added structure rather than discarding the previous one.

The interaction algebra is `O_1` — the cyclic operad with one binary generator and a cyclic action. Three structural matches with actor/session content land cleanly: one binary operation = actor's single interaction primitive (Hewitt-style); the derived boundary-swap theorem = session-type duality `S ↔ S^⊥` = 1=2 perspective swap; three cyclic ports = sender / receiver / channel = trinion. The free cyclic operad on this data is small and finitely presented — Agda-reachable directly.

The first concrete typed-content instance is now shipped and partially de-postulated. `Concurrency/Algebras/SessionSyntax.agda` carries the postulate-free object grammar, including syntactic `dual-involutive`; `SessionMorphismSyntax.agda` carries a set-truncated morphism HIT with the 17 structural/additive formers and 21 laws as path constructors; `Sessions.agda` reuses those layers to instantiate the `O_1` algebra interface and derive the categorical / operadic `boundary-swap-at-gen`. The latter is checked relative to the chosen `session-O1-action`, the only remaining Sessions postulate. The bridge between the two R8 faces is explicitly deferred to richer session-categorical structure.

The actor-causal locality leg is now shipped: `Concurrency/Sites/{ActorBase,ActorCausal}.agda` makes R6 concrete with opaque unityped actors, Lamport-style event causality, local frames, strict-reflecting frame embeddings, basis covers, and a Bool-based non-trivial cover witness. Promotion of a completed conversation into an actor-like node is deliberately not a `FrameHom`; it is reserved as a future morphism class for the `MO_1` / conversation-of-conversations stage.

Hybrid v1 shipped the first adapter layer (`Presheaf.agda`, `SessionPresheaf.agda`): generic frame presheaves, zero-postulate separatedness, and constant session-valued witnesses. The fast-track finite layer has now landed on the finite-frame subsite: `FiniteFrame.agda`, `FiniteCover.agda`, `TinyFiniteCover.agda`, and the `Hybrid/` finite-descent files give full finite-site event-product descent, including the Sessions constant-slot instantiation and the first concrete two-point finite-cover validation. The value-axis refactor has also landed: `CategoryApplicative.agda`, `FinitePresheaf.agda`, `FiniteDescent.agda`, `FiniteFramePresheafFunctor.agda`, and `FiniteSheafCategory.agda` now run over Cubical `Category`, with `StarAutonomousCategory.agda` feeding the V-valued/session side and `SetFiniteSheafCategory.agda` feeding the `SET` side. `FiniteProducts.agda` is likewise category-generic; `SetFiniteProducts.agda` and `SetEventProductSheaf.agda` provide a concrete Set-valued event-product object. Strategy D has now landed on the finite site: lean finite basis covers, a Cubical `Coverage` over `FiniteFrameCategory`, and a SET comparison theorem between the project `IsSheaf` record and the Cubical library `isSheaf`. R4 has advanced through the Benton/LNL finite-sheaf bridge: `ChangeOfBase.agda`, `LinearNonlinear.agda`, and `LinearNonlinearSheafAdapter.agda` give presheaf-level change of base, the lifted adjunction `liftF ⊣ liftG`, and right-adjoint (`G`) sheaf preservation; `FiniteSheafification.agda` states the finite-site reflector interface, and `LinearNonlinearSheafAdjunction.agda` assembles the sheaf-level adjunction conditionally on a V-side reflector. This is still not event-dependent session content and does not construct the generic full finite actor-causal reflector. The live R4 route has now constructed the point-generated sheafification over the supported subsite. `EventPoint.agda`, `EnumeratedProduct.agda`, and `Pointification.agda` land the variable-slot pointification spike; `EventSupported.agda`, `PointOverlap.agda`, and `PointCover.agda` supply the supported point-cover geometry; `SupportedFiniteFrameCategory.agda`, `SupportedPresheafCategory.agda`, and `RestrictToSupported.agda` package the supported subsite; `SupportedPointProduct.agda` gives the abstract slot-indexed point-product API; `SupportedPointification.agda` and `SupportedPointDescent.agda` give pointification and the point-sheaf/point-local comparison; `PointifyIsSheaf.agda`, `PointSheafCategory.agda`, `PointSheafification.agda`, and `PointSheafAdjunction.agda` prove that pointification lands in point sheaves and assemble the reflector adjunction `a ⊣ ι`. Brick 4 now wires this into the point-generated sheaf bridge: `SupportedChangeOfBase.agda`, `SupportedLinearNonlinearSheafAdapter.agda`, and `PointLinearNonlinearAdjunction.agda` construct the supported presheaf lifts, prove `G` preserves point sheaves, and assemble `Lpoint ⊣ Rpoint`. The theorem is relative to a value-level `lnl : LNLAdjunction` and a finite-products hypothesis `vProd` on `StarAutonomous→Category V`.

`MO_1` (the modular envelope of `O_1`, closure under self-gluing at marked points, raises genus to produce operations at every `(g, n)`) is the long-horizon target. `O_1` is staged toward it but does not commit to it. Its `(0, 3)` arity is the universal trinion. In stable-curve moduli the corresponding three-pointed genus-zero curve is rigid: its moduli space is a point. Dessins / Belyi data do not live in that point as extra moduli; they enter as varying finite covers of the three-pointed projective line, ramified only over the marked values. The rigidity is nevertheless essential, since it is what permits those values to be normalized to `{0, 1, ∞}`. Evaluation at `(0, 3)` and passage to Belyi covers are therefore related steps, not the same step.

Committed operadic flavor: `Ass_cyc` (planar cyclic associative, ribbon-graph world) over `Com_cyc` (fully symmetric, bare M̄_{g,n}). Justification: actor send/receive is intrinsically ordered, session composition is non-commutative, dessins live in the ribbon-decorated world.

The earlier cross-site slogan that both roads land at "the same `S²`" is retired as stated. On the modal side, `Bℤ → S¹ → S²` proposes a presentation switch via `ʃ` followed by suspension `Σ`, but currently records only a bare homotopy type at that stage. On the concurrency / Esquisse side, `(0, 3)` supplies a rigid marked base while the dessin is additional finite-cover, branch, and monodromy data over it. A comparison would therefore have to say whether it forgets, reconstructs, or transports the three marks and the cover data; no such comparison has been constructed. The branch-data question is open. The proposed intermediate meeting `S¹ ↔ MO_1` and the proposed identification of modal η-iteration with concurrency genus-raising are separate speculations, only statable once both lines develop the relevant dimension-raising machinery (cyclic bar construction at S¹ for the modal line; modular envelope of `O_1` for the concurrency line). Neither presently supplies evidence for T1 or T3.

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
- `_Moduli._Dessins` — finite covers over the rigid genus-zero, three-marked base, rather than extra points of its moduli space. The icosahedral A_5 example re-enters as one specific dessin (degree 60, monodromy A_5), not as an anchor. It consequently has two compatible statuses: a far-end C-side moduli / cover object, and a possible C-facing input to a future cross-site mediator. No mediator has yet been constructed.
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
- **R8 — Involution-Duality.** `SessionSyntax.agda` proves the syntactic face `dual-involutive`. `Sessions.agda` derives the categorical / operadic face `boundary-swap-at-gen` (a specialization of `boundary-swap-structural`) relative to the postulated `session-O1-action`. The bridge between them remains a deferred project claim, not a computational reduction.

**Most load-bearing now:** finite-site event-product descent, its constant-slot Sessions instantiation, the concrete tiny finite-cover validation, the V-valued finite sheaf/value category, the Set-valued finite sheaf category/object, the finite Cubical `Coverage` / SET library `Sheaf` comparison, and the point-generated R4 bridge have landed. Phase 0 then instantiated the bridge at `Chu(SET,Bool)` and removed the actor-site postulate from the witness import closure. Phase 1 built the Sessions-to-Chu object/morphism realization over the postulate-free syntax. R4 is therefore concrete in the point-generated coefficient-nonvacuity sense, while the cross-site adjunction still waits on the modal-context category `M`.

**Deferred (live at `MO_1` stage).**

- **R9 — Modular Envelopment.** `_Operad._ModularEnvelope` as closure of `_Operad` under self-gluing. Left adjoint to forgetful (cyclic operad ← modular operad). Universal — no freedom in the step itself.
- **R10 — Moduli Realization.** `_Moduli` as geometric realization of `_Operad._ModularEnvelope`. Theorem-driven (Getzler-Kapranov for Com_cyc → M̄; Kontsevich / Penner for Ass_cyc → ribbon-decorated M̄). Forces the Ass_cyc decision to have a literal moduli consequence.
- **R11 — Arithmetic Action.** In the project notation, the absolute Galois group maps faithfully as `G_ℚ ↪ GT`; surjectivity (equivalently, equality with the relevant profinite Grothendieck–Teichmüller group) is open. The `GT` action belongs on the profinite Teichmüller / dessin tower; any lift through R10 to operadic automorphisms of `_Operad._ModularEnvelope`, and then through R7 to symmetries of `_Algebras`, remains a proposed long-horizon construction. This is the operadic version of "external symmetry parametrizing structure at multiple levels," not a completed relation in the current formalization.

## ModalHoTT  <!-- tags: focus:modalhott, level:scoping -->

Paused at the de Rham named-coefficient rung. Synthetic-side fracture (`Modalities/Fracture.agda`) and structural pinning (`Cohomology/FlatCoefficients.agda`) have landed; the analytic mirror (`formal/Analytic/`) is bounded by `♯(Bℤ)` undefined. Postulate budget catalogued in `future_work.md`.

The endofunctor-and-unit scaffold for T_recursion is in place: `formal/ModalHoTT/Modalities/Iteration.agda` defines `T`, `T-map`, `T^_`, `η^_`, postulated `η-naturality`, derived `η^-coherent`, `T-sequence`, and `ND`, but does not yet bundle a full adjunction or monad. The checked collapsing control `formal/ModalHoTT/Modalities/IterationCohesion.agda` instantiates it at ʃ ⊣ ♭: `η-equiv-at-T : T A ≃ T(T A)` together with `η-equiv-fst`, which identifies the forward equivalence with the iteration structure map. Reapplication shows mathematically that every map after stage one is an equivalence. The standard colimit conclusion `ND A ≃ T A` is known but not yet formalized. This control constrains where the cross-site non-collapse witness is not; it is evidence neither for nor against the conjecture. The cyclic-bar construction at `S¹` is a separate proposed return path, not an extension of this collapsing computation.

### Plan when bandwidth returns

Two-piece program:

1. **Lift input from `Bℤ` to `S¹`.** The iteration scaffold is parameterized over types; switching the chosen specialization to `S¹` is a presentation move (using `Bℤ ≃ S¹` as ∞-groupoids), not a new construction.
2. **Switch construction from η-iteration to cyclic bar construction.** New file `BarConstruction.agda` — substantial cubical-HIT work. The cyclic flavor (Connes' cyclic category, Loday / Getzler-Jones lineage) is chosen to match the `Ass_cyc` lean on the concurrency side: the involution structure must intertwine across sides. Plain (non-cyclic) bar pairs with `Com_cyc`; cyclic bar pairs with `Ass_cyc`.

This unlocks the speculative cross-site identity at the intermediate level (`S¹ ↔ MO_1`). The identity is downstream evidence, not a motivator — building both sides honestly is what determines whether the identity is real.

**Differential cohesion in the new outlook.** Elevated from "rhetorical packaging beyond the named-coefficient tautology" to **load-bearing for the cross-site bridge**. The differential rung (`ℜ ⊣ ℑ ⊣ &`) gives the modal side an infinitesimal layer to talk to `MO_1`'s natural infinitesimal structure (formal smoothness, tangent complex on `M̄`). See `future_work.md` "Beyond fracture" — same cost as before, sharply elevated priority. The Lawvere asymmetry refinement entered in `targets.md` §T3 is one of the structural consequences.

## Semantic Background

### ModalHoTT (Bℤ)  <!-- concept:bz -->

The site is `Bℤ` — the delooping of ℤ. Intended semantic model justifying the cohesion axioms; does not appear as an Agda object. `Bℤ ≃ S¹` as ∞-groupoids, but we foreground the group structure of ℤ because: the intrinsic covering structure comes from subgroup inclusions `nℤ ↪ ℤ`; the comonad story connects cleanly to ℤ-actions; Lawvere's fixed-point theorem is most natural in the algebraic / discrete setting ℤ provides.

When bandwidth returns to the modal side, the iteration's input type lifts from `Bℤ` to `S¹` (using the `Bℤ ≃ S¹` identification as a presentation switch). The *site* remains `Bℤ`; what shifts is the input that the cyclic bar construction operates on.

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
| 2026-05-17 | Modal return plan: lift `Bℤ → S¹`, switch η-iteration → cyclic bar | Cross-site identity (`S¹ ↔ MO_1`) is only statable when both sides have dimension-raising machinery; cyclic bar pairs with `Ass_cyc` |
| 2026-05-17 | Differential cohesion rung elevated to load-bearing for the cross-site bridge | `M̄`'s natural infinitesimal structure needs a modal infinitesimal layer to talk to; see `targets.md` T3 refinement |
| 2026-05-17 | `Ass_cyc` ratified (was philosophical lean; now committed) | Actor send/receive is ordered, session composition non-commutative, dessins live in ribbon-decorated world, 1=2 reads as cyclic-of-three not symmetric. Closes the plain-bar option on the modal line; commits `MO_1` to ribbon-decorated `M̄` |
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
| 2026-05-21 | Reflexive Protocol Layer named; not implemented | Π = category of protocol versions; protocol edits = morphisms in Π. Promotion (Adapter 5) sharpened with operational role: closed meta-conversation reaching consensus → Π-morphism. Consensus framed as future colimit / coherent amalgamation in a patch-theoretic fragment category, with Pijul as primary implementation-facing candidate; precise categorical shape held open. `Concurrency/Hybrid/Reflexive.agda` reserved as future home. `MO_1` elevated to active roadmap without displacing the concurrency R4 path as the next technical step. Layer is new formal content, compatible with and anticipated by current scaffolds but not already implicit in them |
| 2026-06-04 | Finite event-product descent landed | Added finite additive products, finite frames/covers with carried overlap enumerations, generic finite event-product presheaf, and full finite-site descent (`IsSheaf`) over `FiniteCover`s. The result is non-degenerate by arity: `value F = P₀ ^ event-count(F)`, including empty-frame normalization by the terminal additive product. |
| 2026-06-04 | Sessions constant-slot instantiation landed | `Sessions.agda` gained additive product syntax and laws; `SessionEventProductSheaf.agda` instantiates the generic finite witness at `Sessions-Cat Payload`. This is constant-slot B2(a), not event-dependent session content and not additive coproduct universal properties. |
| 2026-06-04 | Tiny finite cover witness landed | `TinyFiniteCover.agda` and `TinyEventProductExample.agda` exercise the finite descent stack on the existing `TinyFrame` / `PointFrame` two-point cover. The proof-level target landed; definitional computation remains only an optional future bonus. |
| 2026-06-04 | V-valued finite sheaf/value category landed | `StarAutonomousCategory.agda`, `FiniteFrameCategory.agda`, `FiniteFramePresheafFunctor.agda`, and `FiniteSheafCategory.agda` package the finite V-valued sheaf layer using Cubical `Category`, bridge existing `FiniteFramePresheaf` records to library functors without re-expressing descent, prove `IsSheaf` is propositional, and exhibit the event-product sheaf as a concrete object. |
| 2026-06-04 | Finite sheaf framework generalized over Cubical `Category` | `CategoryApplicative.agda` and `FinitePresheaf.agda` split out the plain-category core. `FiniteDescent.agda`, `FiniteSheafCategory.agda`, and `FiniteFramePresheafFunctor.agda` now run over any Cubical `Category`, with the V side recovered through `StarAutonomous→Category V`. |
| 2026-06-04 | Set-valued finite sheaf side inhabited | `FiniteProducts.agda` was generalized over `Category`; `SetFiniteProducts.agda`, `SetFiniteSheafCategory.agda`, `SetEventProductSheaf.agda`, and generic `EventProductSheafObject.agda` instantiate the same event-product construction at `SET`. This landed the concrete framework-at-SET object that Strategy D later compares to the library sheaf condition. |
| 2026-06-05 | Strategy D landed: finite Coverage plus SET sheaf comparison | `FramePullbackUniversal.agda`, `FiniteFramePullback.agda`, `FiniteBasisCover.agda`, `FiniteFrameCoverage.agda`, and `SetSheafComparison.agda` complete C8→C9→C6 for the finite site. The sequence is postulate-free; it uses a lean basis cover for the topology, derives finite pullback patches, proves Cubical `Coverage` pullback stability, and compares project `IsSheaf` with library `isSheaf` at the actual `FiniteFrameCoverage`. |
| 2026-06-05 | Benton/LNL chosen for R4; Chu reserved for coefficient/value semantics | R4 is the concurrency-internal cartesian↔linear / forgetful-axis bridge between `Sh_fin(site,Set)` and `Sh_fin(site,V)`, so Benton is the native relationship shape. Chu was not the bridge shape itself; it later entered as a concrete `V`, yielding the `Chu(SET,Bool)` point-generated non-vacuity witness and then the Sessions-to-Chu realization. |
| 2026-06-05 | R4 Tier 3 interface and conditional Tier 4 landed | `ChangeOfBase.agda`, `LinearNonlinear.agda`, and `LinearNonlinearSheafAdapter.agda` land the Benton/LNL presheaf bridge: presheaf change-of-base, `liftF ⊣ liftG`, and right-adjoint sheaf preservation `G-preserves-sheaf`. `FiniteSheafification.agda` names the finite-site reflector `a ⊣ ι`; `LinearNonlinearSheafAdjunction.agda` gives the sheaf-level adjunction conditionally on a V-side reflector. The full-site reflector remains pending, but the pointification spike has landed: `EventPoint.agda`, `EnumeratedProduct.agda`, and `Pointification.agda` construct the variable-slot functorial core of `a(P)(F) = ∏_e P(pt_e)`. The then-open R4 gate after the spike was point-cover geometry and the point-descent/locality route; the 2026-06-06 entries below record those pieces landing and leave `a ⊣ ι` plus point-generated bridge wiring as the live follow-up. |
| 2026-06-05 | Pointification spike landed for R4 reflector route | `EventPoint.agda` generalizes event-point subframes and point-to-point morphisms; `EnumeratedProduct.agda` isolates variable finite-product transport behind `projE`/`tupleE`/`βE`/`ηE`/`extE`; `Pointification.agda` constructs the functorial core `a(P)(F) = ∏_e P(pt_e)` for arbitrary value category `C` with finite products over finite frames at event level `ℓ-zero` and incidence level `ℓA`. This retires the variable-slot transport risk for the point-generated reflector route. Remaining work at that stage was point-cover geometry and the point-descent/locality comparison; the 2026-06-06 entries below record those pieces landing and left `a ⊣ ι` plus point-generated R4 bridge wiring as the then-live follow-up; the 2026-06-07 row records the reflector landing. |
| 2026-06-06 | Point-cover geometry scaffold landed for point-generated R4 | `EventSupported.agda`, `PointOverlap.agda`, and `PointCover.agda` implement the Option-2 geometry: event-supported wrappers, incident/event-supported point overlaps, finite event-discrete point covers, and canonical point cover data. This deliberately avoids `FiniteCover` raw actor-intersection overlaps. |
| 2026-06-06 | Point-descent/locality biconditional landed | `PointDescent.agda` mirrors `FiniteDescent` with product-free descent over the canonical point cover, then in a finite-products scope defines `PointLocal`, proves zero-event subterminality, `local→sheaf`, and `sheaf→local`. This lands `IsPointSheaf P ↔ PointLocal P` for the point-generated site. At that checkpoint the remaining work was `pointify` as a point sheaf, `a ⊣ ι`, and W3 bridge wiring; the 2026-06-07 row records the reflector landing. |
| 2026-06-07 | Point-generated reflector constructed | The supported-subsite route now has the abstract slot-indexed point-product API (`SupportedPointProduct.agda`), rebuilt pointification (`SupportedPointification.agda`), pointification-is-point-sheaf (`PointifyIsSheaf.agda`), the point-sheaf full subcategory and inclusion (`PointSheafCategory.agda`), the reflector functor (`PointSheafification.agda`), and the unit, hom-set bijection, naturality fields, and assembled adjunction `a ⊣ ι` (`PointSheafAdjunction.agda`). The full finite actor-causal reflector remains a later enrichment; the live next step is W3 wiring of this point-generated reflector into the R4 bridge, still relative to value-level `lnl : LNLAdjunction`. |
| 2026-06-07 | Point-generated R4 bridge landed | `SupportedChangeOfBase.agda` lifts value-category functors over `SupportedPresheafCategory`; `SupportedLinearNonlinearSheafAdapter.agda` constructs `supportedLiftF`, `supportedLiftG`, `supportedLiftF⊣supportedLiftG`, and proves `G` preserves point sheaves; `PointLinearNonlinearAdjunction.agda` assembles the point-sheaf Benton/LNL adjunction `Lpoint⊣Rpoint`. The result is generic and reflector-unconditional over the supported point-generated site, while remaining relative to `lnl : LNLAdjunction` and `vProd : HasFiniteProducts (StarAutonomous→Category V)`. |
| 2026-06-23 | Chu coefficient instance and Sessions realization landed | `Chu.agda`, `ChuFiniteProducts.agda`, `ChuMonoidal.agda`, `ChuLinearNonlinear.agda`, `ChuPointVProd.agda`, and `ChuPointExample.agda` instantiate the point-generated R4 hypotheses at `Chu(SET,Bool)`. `SessionSyntax.agda`, `SessionMorphismSyntax.agda`, `SessionObjectModel.agda`, and `SessionChuModel.agda` then give the postulate-free object/morphism Sessions-to-Chu realization (`J0`, `J0-dual`, `J1`, and the underlying Cubical functor). `Sessions.agda` now relies on the morphism HIT for its categorical laws; only `session-O1-action` remains postulated. |
| 2026-09-04 | Conversation frames carry the global causal order restricted, not an intra-conversation order | `FrameHom` demands strict causality reflection, so an order regenerated from intra-conversation parent edges alone would have no embedding whenever two events of one conversation are related only through a cross-conversation causal path. Under restriction, preservation and reflection are both the identity, and the relationship is recorded as the definitional equation `local-order-is-global-restriction`. Consequence, deliberately accepted: a conversation is a local view of one global causal structure, not an independently generated causal system |
| 2026-09-04 | `TraceLookup.agda` is the sole downstream proof-consumer module depending on the positional nesting of `valid?` and `eventOK` | The projection tower reaching a named conjunct was duplicating into each realization module, making every consumer silently fragile against reordering a validator clause. Concentrating it behind named lemmas (`wellFormed-eventsOK`, `wellFormed-backwardOK`, `eventOK-touches`) means such a reordering breaks one module rather than weakening several. The validator definitions themselves necessarily still encode their own clause order |

## Blockers  <!-- tags: kind:state -->

(Previous Open Questions archived to `deep_context/archived_blockers/2026-05-17.md`. Deferred items migrated to `future_work.md`.)

Concurrency: none active. The first concurrency operad, algebra signatures, concrete typed-content `Sessions.agda` instance, actor-causal site v1, Hybrid v1 restriction, finite products, finite covers, finite event-product descent, the constant-slot Sessions sheaf, the concrete tiny finite-cover witness, both V-valued and Set-valued finite sheaf endpoints, the finite C8/C9 Coverage bridge, the C6 SET library comparison, the point-generated R4 bridge, the `Chu(SET,Bool)` coefficient witness, and the Sessions-to-Chu object/morphism realization have shipped. The next substantive choice is no longer a mechanical R4 continuation: either pursue O1-in-Chu / `session-O1-action` by adding earned categorical structure, or open the Reality/Documentation/Chu boundary track. The modal-context category `M` and eventual cross-site adjunction remain downstream.
ModalHoTT: none active (paused).

## Current Concurrency state  <!-- tags: kind:state -->

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

**Self-scanning as eventual operational interpretation.** "Regular-interval meta-conversations" map naturally onto modal iteration, but the formalised iteration in `ModalHoTT/Modalities/Iteration.agda` + `IterationCohesion.agda` lands only the first-level collapse — not the dimension-raising cyclic bar construction required for the cross-site recursion. Self-scanning is the operational interpretation of that *future* recursion, not of the current scaffold.

**Roadmap impact.**

- **Promotion (Adapter 5)** gets a concrete job description; header sharpened in `Hybrid/Presheaf.agda`.
- **`MO_1` / modular envelope** elevated from "held loose" to active roadmap as the natural home for self-gluing / conversation-of-conversations. This does *not* displace the immediate exposition / instantiation track for the point-generated R4 theorem — `MO_1` becomes the natural next slot only after the Hybrid site-axis, the point-generated bridge, and the intended instantiation story are stable enough to support modular-envelope work; the cross-site adjunction and bar-construction comparison remain downstream.
- **Dual of T_recursion iteration on the concurrency side** (deferred per `future_work.md` "until `ND` has non-trivial content") becomes statable once the reflexive layer gives `ND` operational meaning.

**Where it goes in the Agda tree.** `Concurrency/Hybrid/Reflexive.agda` reserved as the future module slot. Kept inside the Hybrid layer because the protocol-version structure reads as one more adapter (between the current Hybrid instance and the next), and because the project avoids premature folder proliferation. If the file later grows into a genuinely higher-order protocol calculus, it can be split out to `Concurrency/Meta/` at that point.

**Trigger for opening `Hybrid/Reflexive.agda` v0.** Two conditions, both required: (a) the point-generated R4 bridge and its exposition / instantiation boundary are stable enough that the Hybrid chassis is no longer moving, and (b) the fragment-category candidate (Pijul or alternative) honest enough to state in Agda.

### Next frontier

The immediate formal frontier is no longer the point-generated R4 bridge itself. That theorem, its Chu coefficient witness, and the Sessions-to-Chu object/morphism realization are landed. The active split uses the number+letter lane convention:

- **3R - runtime:** Elixir/Rust runtime work, and where immediate bandwidth now sits. The tiny-run construction seam is banked: `hoapa_contract` can reconstruct the Agda-accepted tiny run from structs and keep it corpus-locked by decoded-struct equality. The 2S locality package the next runtime expansion was waiting for has landed, so the minimal `hoapa_core` event-log/export path is the immediate step. Broader OTP, Pijul, Phoenix, and checker-app work remain later.
- **2S - runtime-to-substrate:** Agda that interprets runtime-shaped evidence into the actor-causal substrate. Two generic rungs have landed. `BackwardRank.agda` proves parent edges decrease first-occurrence rank under `backwardOK`, and `CausalFromParents.agda` derives a `CausalOrder` and one global `LocalFrame` for any well-formed run; `TraceLookup.agda` carries the shared lookup and validator-peeling lemmas both consume. `ConversationLocality.agda` then supplies per-conversation locality: every conversation present in a well-formed run becomes its own `LocalFrame`, with a `FrameHom` into the global realized frame and the local order fixed as the restriction of the global derived order. The next 2S theorem is actor-renaming/no-leak. Session-tag assignment is unlocked but deferred: it is a decorating layer over the realized frames rather than a field on `LocalFrame`, so it should carry its own transport lemma instead of being folded into the core renaming theorem.
- **1C - pure conjecture:** O1-in-Chu / `session-O1-action`, Reality/Documentation/Chu, full reflector enrichment, later cross-site `Allow ⊣ Require`, and the modal cyclic-bar return. These remain real directions, but they should not displace the current 2S/3R handoff.

Important scope notes:

- The Realization rungs stay narrow, and the abstraction boundary between them is deliberate. `CausalFromParents.agda` alone still constructs only the global frame; `ConversationLocality.agda` supplies the downstream per-conversation frames and embeddings. Neither proves session assignment, full finite-site sheaf transport, or renaming/no-leak.
- The conversation frames are not packaged as a `Cover` of the global frame. `WellFormed` gives event-to-conversation resolution, so event coverage would follow, but actor coverage is not derivable from it — a run may declare an actor who participates in no conversation. Particular runs may still satisfy both conditions; what is unavailable is the uniform statement, and no `Cover` value was constructed.
- The rank/antisymmetry proof uses `backwardOK`, not event-ID distinctness. Distinct event IDs remain part of faithful trace realization.
- `TinyTrace.agda` remains a concrete fixture witness. `CausalFromParents.agda` is the generic analogue that closes the order-reuse gap by deriving the causal order from raw parents.

### Held-loose long-horizon items (no near-term action)

- **Full actor-causal reflector enrichment** — later, decide whether to extend the point-generated construction to richer covers where causality and actor incidence become descent content.
- **Cross-site `Allow ⊣ Require`** — define the modal-context category `M`, then the actual functors, unit, counit, and triangle identities; instantiate the generic iteration scaffold only after the concurrency-internal adapter and runtime junction are stable enough to serve as the operational side.
- **Modal return plan** — lift `Bℤ -> S¹`, switch eta-iteration to cyclic bar, and coordinate with the concurrency modular-envelope direction only when both sides have earned the needed structure.
- **Pask-style human-implementation layer** — conversation-as-operadic-composition. Speculative until `MO_1` makes conversation creates conversation a literal operadic operation. Held in motivation only.
- **Pedagogy track** — current for the synthetic ModalHoTT and Concurrency Agda trees as of 2026-05-21. Analytic pedagogy remains intentionally out of scope unless explicitly requested.

## Historical note

The detailed rot-compₒ discussion that led to the 2026-05-18 cyclic-equivariance repair is archived. The durable outcome remains: full cyclic equivariance is primitive, `boundary-swap` is derived, and the algebra layer uses `boundary-swap-structural` rather than treating binary session duality as the whole cyclic story.
