---
tags: [focus:cross-site, kind:state, level:scoping]
---

# Project Status

The arc is articulated in `arc.md` (the cohesive reformulation, with the `Allow ⊣ Mediate ⊣ Require` triple) and decomposed into propositions T1–T7 plus T_recursion in `targets.md`. Philosophical seed in `motivation.md`. Brainstorming archive: `deep_context/arc/`.

Bandwidth is on the Concurrency side, after a cycle of reframes that has converged: actor-causal + Caires-Pfenning hybrid (substrate) augmented by an operadic interaction-algebra layer (`O_1`), with the modular envelope `MO_1` as long-horizon target. The ModalHoTT side is paused at the de Rham named-coefficient rung with a defined return plan (S¹ + cyclic bar construction) coordinated with the B-side commitment.

## Concurrency  <!-- tags: focus:concurrency, level:scoping -->

### Where we landed

The Concurrency-side has converged after a cycle of reframes: icosahedral (A_5 / S²-equivariant) → actor-causal + Caires-Pfenning hybrid (per `deep_context/arc/02_concurrency_anchor.md`) → operadic interaction-algebra layer named on top of the hybrid (per `deep_context/arc/03_attachement_in_arc.md`). The current commitment treats the hybrid as substrate and the operadic layer as augmentation, not replacement. The B-side has *cycled*, not drifted: each reframe added structure rather than discarding the previous one.

The interaction algebra is `O_1` — the cyclic operad with one binary generator and a cyclic action. Three structural matches with actor/session content land cleanly: one binary operation = actor's single interaction primitive (Hewitt-style); the derived boundary-swap theorem = session-type duality `S ↔ S^⊥` = 1=2 perspective swap; three cyclic ports = sender / receiver / channel = trinion. The free cyclic operad on this data is small and finitely presented — Agda-reachable directly.

The first concrete typed-content instance is now shipped: `Concurrency/Algebras/Sessions.agda` instantiates the `O_1` algebra layer with multiplicative session syntax. It contains both R8 faces in Agda: syntactic `dual-involutive` and categorical / operadic `boundary-swap-at-gen`. The bridge between those faces is explicitly deferred to richer session-categorical structure; v1 records the two faces without overclaiming their identity.

The actor-causal locality leg is now shipped: `Concurrency/Sites/{ActorBase,ActorCausal}.agda` makes R6 concrete with opaque unityped actors, Lamport-style event causality, local frames, strict-reflecting frame embeddings, basis covers, and a Bool-based non-trivial cover witness. Promotion of a completed conversation into an actor-like node is deliberately not a `FrameHom`; it is reserved as a future morphism class for the `MO_1` / conversation-of-conversations stage.

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

- `_Sheaf._Presheaf` — assignment of a value-object to each site-object, functorial.
- `_Sheaf._Descent` — gluing condition for covers from `_Site._Topology`.

Open: the value category `V` (Set, Cat, `_Algebra._SyntacticCategory` itself?). Tracked as its own item via R1.

##### `_Topos`  <!-- concept:topos -->

Canonical first three pieces, plus a cohesion-adapted fourth.

- `_Topos._SheafCategory` — `Sh(_Site._Category, _Site._Topology)` as an object.
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
- `_Algebras._Sessions` — shipped v1 in `Sessions.agda`: multiplicative session syntax, structural duality, thin categorical `Hom`, explicit `SessionO1Action`, `session-interp`, `Sessions-Val`, `Sessions-Alg`, and `boundary-swap-at-gen`.
- `_Algebras._Actors` — held as the future algebraic/operadic reading of actor structures. The current actor-locality commitment lives under `_Site`, not under `_Algebras`.

`_Algebras._CutElimination` deferred — full Caires-Pfenning dynamics is post-`MO_1`.

##### Integration with hybrid  <!-- concept:integration -->

- `_Algebras._Sessions` evaluates into the value category `V` of the hybrid's `_Sheaf` (R1).
- `_Site` supplies the actor-causal base over which `_Algebras._Sessions` will vary as values (R1).
- `boundary-swap-structural` supplies the categorical / operadic R8 face that cross-cuts the existing `_Algebra._SyntacticCategory`; the bridge to syntactic session duality is deferred (R8).

This is the commitment frontier for `O_1`: enough operadic structure to name the interaction algebra of the hybrid; no commitments beyond cyclic-operad-without-modular-envelope.

### Structuring relations  <!-- tags: kind:reference -->

Named, like modules. R1–R6 are from the hybrid substrate's level-2 scoping; R7–R8 are added for the operadic layer at the `O_1` commitment level; R9–R11 are deferred to the `MO_1` stage.

**Live now.**

- **R1 — Valuation.** `_Sheaf` takes values in `V`; `V` drawn from `_Algebra._SyntacticCategory` (substrate) or `_Algebras._Sessions` (operadic). The sheaf functor `F: _Site._Category^op → V`. Most urgent technical hinge.
- **R2 — Indexing.** `_Sheaf` lives over `_Site`: presheaf + descent against `_Site._Topology`. Descent is the load-bearing half.
- **R3 — Generation.** `_Topos = Sh(_Site._Category, _Site._Topology)`. No freedom; the topos is generated from site + sheaves.
- **R4 — Interpretation.** `_Topos._InternalLogic ↔ _Algebra._Connectives` / `_Algebras._Sessions`. Topos logic is cartesian by default; the algebra is linear. Compatibility (or its principled absence) is its own piece of work.
- **R5 — Embedding.** `_Topos._GeometricMorphisms → cubical sets`. The mathematical form of "both sides share an ambient `(∞,1)`-topos."
- **R6 — Parametrization (Causality).** Causality → `_Site`. Landed in `Concurrency/Sites/{ActorBase,ActorCausal}.agda`: Lamport partial-order events, actor-local frames, strict-reflecting frame embeddings, basis covers, and a Bool-based non-trivial cover witness. The remaining quality gap is `stability-cover-postulate`, not the R6 interface itself.
- **R7 — Algebra-over-Operad.** `_Algebras` evaluates `_Operad`. Landed as `StarAutonomous` + `Valuation` + structural `OperadAlgebra`, and concretely instantiated by `Sessions.agda` for the typed-content layer. Closely interacts with R1 (the value category for both must agree).
- **R8 — Involution-Duality.** `Sessions.agda` now contains both faces: syntactic `dual-involutive` and categorical / operadic `boundary-swap-at-gen` (a specialization of `boundary-swap-structural`). The bridge between them remains a deferred project claim, not a computational reduction.

**Most load-bearing now:** hybrid integration. R6 is concrete enough for R1 to become statable: the next technical hinge is the value category / sheaf valuation explaining how shipped session values sit over actor-local frames. R4 (cartesian-vs-linear interpretation) remains the conceptual compatibility question.

**Deferred (live at `MO_1` stage).**

- **R9 — Modular Envelopment.** `_Operad._ModularEnvelope` as closure of `_Operad` under self-gluing. Left adjoint to forgetful (cyclic operad ← modular operad). Universal — no freedom in the step itself.
- **R10 — Moduli Realization.** `_Moduli` as geometric realization of `_Operad._ModularEnvelope`. Theorem-driven (Getzler-Kapranov for Com_cyc → M̄; Kontsevich / Penner for Ass_cyc → ribbon-decorated M̄). Forces the Ass_cyc decision to have a literal moduli consequence.
- **R11 — Arithmetic Action.** `Gal(Q̄/Q) ⊃ GT` acts on `_Moduli._GTAction`, lifting through R10 to operadic automorphisms of `_Operad._ModularEnvelope`, then through R7 to symmetries of `_Algebras`. The operadic version of "external symmetry parametrizing structure at multiple levels."

## ModalHoTT  <!-- tags: focus:modalhott, level:scoping -->

Paused at the de Rham named-coefficient rung. Synthetic-side fracture (`Modalities/Fracture.agda`) and structural pinning (`Cohomology/FlatCoefficients.agda`) have landed; the analytic mirror (`agda/Analytic/`) is bounded by `♯(Bℤ)` undefined. Postulate budget catalogued in `future_work.md`.

The iteration scaffold for T_recursion is in place: `agda/ModalHoTT/Modalities/Iteration.agda` (generic-adjunction `T`, `T-map`, `T^_`, `η^_`, postulated `η-naturality`, derived `η^-coherent`, `T-sequence`, `ND`) and the A-side sanity check `agda/ModalHoTT/Modalities/IterationCohesion.agda` (ʃ ⊣ ♭ instantiation; first-level collapse `η-equiv-at-T : T A ≃ T(T A)` via the `Discrete.agda` bridge). This is **iteration-by-collapse** — completed and statable at the toy level. It is *not* the material that the cross-site identity will eventually need extending; that is a different construction (cyclic bar) at a different input (`S¹`).

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

The interaction algebra layered on top is `O_1` (cyclic operad with one binary generator + cyclic action) — see "Where we landed." The hybrid is what `O_1`'s algebras live over.

Analytic-side mirror is future work; whether the `agda/Analytic/` pattern from ModalHoTT transfers depends on the Concurrency-side base implementation.

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
| 2026-05-19 | `Sessions.agda` v1 landed with explicit `SessionO1Action` | Keeps `Hom` to the 13 categorical constructors, packages `gen` / `plug` / `shift` plus six operadic laws as chosen action data, defines `session-interp` by HIT recursion, closes `Sessions-Val` and `Sessions-Alg`, and names both R8 faces (`dual-involutive`, `boundary-swap-at-gen`). Canonical derivation of the action from richer session-categorical structure is deferred |
| 2026-05-20 | Actor-causal site split into `Concurrency/Sites/ActorBase.agda` and `Concurrency/Sites/ActorCausal.agda` | `ActorBase` owns the opaque unityped carrier and Lamport `CausalOrder`; `ActorCausal` owns `LocalFrame`, `FrameHom`, covers, topology fields, and witnesses. Keeps primitive locality separate from site structure while avoiding over-splitting |
| 2026-05-20 | Actor carrier is opaque and unityped | The verified communication kernel cannot distinguish humans, LLMs, or future promoted conversations. Actor-origin metadata belongs outside the kernel; no roles, payloads, sessions, or message syntax appear in the actor site |
| 2026-05-20 | `FrameHom` uses strict causality reflection | A frame morphism is a sub-view embedding: causality is preserved and reflected. Promotion of a completed conversation into an actor-like node is therefore a future quotient/reification morphism class, not a `FrameHom` |
| 2026-05-20 | Actor-site covers use basis form, with `sieve-of` exposed for the E2 transition | Basis covers match implementation-facing local observations and concrete finite witnesses. The semantic endpoint remains the generated sieve / Grothendieck-topology presentation; prove equivalence later rather than starting Actors v1 at the sieve level |
| 2026-05-20 | Actor-site identity and transitivity covers are generic; stability is the only v1 postulate gap | `identity-cover-canonical` and `transitivity-cover-canonical` are constructed. `stability-cover-postulate` is named and flagged because generic pullback-stability needs frame pullbacks or the future sieve presentation |
| 2026-05-20 | Actor-site tiny witness upgraded to non-trivial Bool cover | `TinyAB` uses `Fin 2`; `TinyCausal` uses `Bool` events with `false ≤ true`; `PointFrame` embeds by `embed-point false` / `embed-point true`; `two-point-cover` exercises non-trivial index, patch, embedding, and event-lift data |

## Blockers  <!-- tags: kind:state -->

(Previous Open Questions archived to `deep_context/archived_blockers/2026-05-17.md`. Deferred items migrated to `future_work.md`.)

Concurrency: none active. First B-side operad, algebra signatures, concrete typed-content `Sessions.agda` instance, and actor-causal site v1 have shipped; next substantive work is the hybrid sheaf/value bridge (R1) over `ActorCausalSite`.
ModalHoTT: none active (paused).

## Current B-side state  <!-- tags: kind:state -->

Older session-end snapshots and rot-comp planning are archived under `workflow/deep_context/`. This section is the compact current state.

### Operads

Shipped to `agda/Concurrency/Operads/` (all five files typecheck under `--cubical --guardedness`):

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

Shipped to `agda/Concurrency/Algebras/` (all files typecheck through `Sessions.agda`):

| File | Role | Line count |
|------|------|-----------:|
| `StarAutonomous.agda` | Thin target-category signature: 1-category, tensor/unit, braiding, involutive duality; derives `⅋`, `⊥-par`, `⊸` | ~145 |
| `Valuation.agda` | Weak HIT valuation: `O n → Hom (ports Carrier n) ⊥-par`, with carrier self-duality | ~85 |
| `OperadAlgebra.agda` | Structural Step-2 algebra: valuation plus `plug`, `shift`, `interp-compₒ`, `interp-rot`; derives `boundary-swap-structural` | ~135 |
| `Sessions.agda` | Multiplicative session syntax, proved `dual-involutive`, inductive structural `Hom`, explicit `SessionO1Action`, `session-interp`, `Sessions-Val`, `Sessions-Alg`, and `boundary-swap-at-gen` | ~470 |

`Valuation` is intentionally weaker than `OperadAlgebra`. The latter is the R7 interface to use downstream: it says operadic substitution factors through categorical `plug`, cyclic action factors through `shift`, and the derived `boundary-swap-structural` is the R8-relevant identity. `Sessions.agda` proves that this interface is inhabitable by the typed-content layer, while keeping the canonical derivation of `SessionO1Action` for future richer session-category work.

### Sites

Shipped to `agda/Concurrency/Sites/` (both files typecheck under `--cubical --guardedness`):

| File | Role | Line count |
|------|------|-----------:|
| `ActorBase.agda` | Opaque unityped `ActorBase` carrier plus Lamport `CausalOrder`; derives `Concurrent` and `≤-bidir-equal` | ~160 |
| `ActorCausal.agda` | Actor-local frames, strict-reflecting `FrameHom`, frame category laws, basis `Cover`, `sieve-of`, generic identity / transitivity covers, `ActorCausalSite`, `stability-cover-postulate`, and Bool-based non-trivial tiny witness | ~790 |

The actor site deliberately does not import `Sessions.agda` or operad files. Its job is locality: actor membership, event incidence, causal sub-view embeddings, and local-frame covers. Typed content, `O_1` operations, and conversation-promotion stay out of the carrier.

`FrameHom` is strict: causality is preserved and reflected, making it a sub-view embedding rather than an arbitrary monotone map. This preserves the future distinction between embedding a local view and promoting a completed conversation into an actor-like node.

`Cover` is basis-form (E1), but `sieve-of` is exposed as the bridge artifact for the future sieve / Grothendieck-topology presentation (E2). The identity and transitivity cover axioms have generic constructions; `stability-cover-postulate` is the sole current actor-site postulate gap.

The G3 witness is non-trivial: `TinyAB` has two actors (`Fin 2`), `TinyCausal` has two Bool events with `false ≤ true`, `PointFrame` embeds into `TinyFrame` via `embed-point false` and `embed-point true`, and `two-point-cover` covers `TinyFrame` by the two event-patches.

### Next file

The hybrid bridge: a session-valued presheaf / sheaf layer over `ActorCausalSite`. The goal is not the cross-site adjunction yet; it is R1, making precise how the shipped session values sit over actor-local frames.

### After actor-causal site v1

1. **Hybrid integration** — sheaf valuation (R1): place the shipped session values over the actor-causal site. Known shape, now the active next step.
2. **R4 compatibility** — clarify how cartesian internal logic of the topos talks to the linear/session value layer.
3. **A-side return plan** (lift `Bℤ → S¹`, switch η-iteration → cyclic bar) — on hold until the B-side reaches a point where the cross-site adjunction `Allow ⊣ Require` is statable.

### Held-loose long-horizon items (no near-term action)

- **Pask-style human-implementation layer** — conversation-as-operadic-composition. Speculative until `MO_1` makes "conversation creates conversation" a literal operadic operation. Held in motivation only.
- **Pedagogy companions** — `pedagogy/Concurrency/` mirrors for the operad and algebra files. Not started; lives in the pedagogy track (memory `pedagogy_project`).

## Historical note

The detailed rot-compₒ discussion that led to the 2026-05-18 cyclic-equivariance repair is archived. The durable outcome is recorded above: full cyclic equivariance is primitive, `boundary-swap` is derived, and the algebra layer uses `boundary-swap-structural` rather than treating binary session duality as the whole cyclic story.

## Discussion of the next step

### Claude

● Recommendation: hybrid bridge — SessionPresheaf over ActorCausalSite

A presheaf in the actor-causal site, valued in Sessions's syntactic category. R1 (sheaf valuation) made concrete.

Why this is the right next step

1. It's what status.md "After Sessions.agda" item 2 was waiting on. Item 1 (Actors at maturity to Sessions) just landed. The "hybrid bridge — place the shipped session values over the actor-causal
site" item moves to active.
2. Both legs are now at honest comparable maturity. Sessions has the content-side R8 faces; Actors has the locality-side site axioms and a non-trivial cover. Bridging two equally-developed legs is
symmetric; bridging now rather than later locks in that symmetry rather than letting one side outgrow the other.
3. R1 is the structural separation-of-concerns hinge. The motivation file's claim — B1 (typed data) and B2 (unityped agents) follow separation of concerns — is currently a structural assertion in
concurrency_anchor.md, not an Agda artifact. The bridge is what turns it into an artifact: B1 lives in the values (presheaf assignment to frames), B2 lives in the base topology (the site itself),
and modularity is the (eventual) sheaf-gluing condition. Without the bridge, the central claim of the hybrid is unverified.
4. It's the structural gate for the cross-site adjunction. Allow ⊣ Require lives between the A-side cohesive ∞-topos and the B-side topos formed by sheaves on the actor-causal site (per arc/02).
The bridge is the constructive form of that topos's value structure. The A-side return plan (Bℤ → S¹, bar construction) is gated on the cross-site adjunction being statable, which is gated on the
topos having content, which is what the bridge supplies.
5. arc/05's verified-protocol-kernel framing depends on it. "Conversations produce typed documents" reads structurally as "frames bear session values"; "actor identity never leaks into the session
carrier" reads as "the presheaf factors through the base site's locality, not through anything that mentions session types in the actor base." Both become checkable claims once the bridge exists.

What v1 ships

A single file Concurrency/Hybrid/SessionPresheaf.agda, on the order of 400-500 lines, containing:

- SessionPresheaf record. A contravariant assignment: P-on-frame : LocalFrame → SessionType, P-on-hom : (F ↪ G) → Hom (P-on-frame G) (P-on-frame F), plus functoriality fields P-id and P-comp. Same
field-and-postulate-laws shape as StarAutonomous and Sessions-Cat.
- const-presheaf. The trivial inhabitability witness: assigns 𝟙ₛ (or ⊥ₛ — design call below) to every frame, id-h to every FrameHom. Functoriality holds definitionally.
- A non-trivial witness over tiny-site. A presheaf that assigns one session type to PointFrame and a different session type to TinyFrame, with P-on-hom (embed-point b) being a non-identity Hom —
exercising the contravariance of the bridge against the G3 site's embed-point false and embed-point true.
- Header reservation for v2. The sheaf condition (descent over covers) is stated in prose only at v1; the categorical structure Sessions-Cat needs to host matching families (intersections,
pullback-flavored data) is exactly the StarAutonomous extension that SessionO1Action's canonical-derivation slot is waiting on. The two deferred items now share a single trigger.

Design calls

Q1. Subdirectory for the bridge.

- What's at stake: where the file lives and what category of artifact it signals.
- Option Q1a — Concurrency/Hybrid/SessionPresheaf.agda. Buys: matches the concurrency_anchor.md "hybrid" vocabulary; the directory makes "bridge from one leg to another" explicit. Costs: introduces
a new subdirectory pattern (so far we have Operads/, Algebras/, Sites/ — all mathematical-kind names; Hybrid/ is relational).
- Option Q1b — Concurrency/Sites/SessionSheaf.agda. Buys: keeps it under Sites (the bridge gives the site its values). Costs: "Sites" becomes ambiguous between "the actor-causal site itself" and
"things-over-the-site"; also the file is the presheaf, not yet the sheaf, so the filename is forward-leaning.
- Option Q1c — Concurrency/Sheaves/Sessions.agda. Buys: "Sheaves" as a categorical-kind name fits the existing pattern. Costs: same as Q1b on the not-yet-sheaf naming.
- Lean: Q1a. The Hybrid/ subdirectory honestly names the architectural move (cross-leg bridge) and reserves room for a future Hybrid/<Actors-over-Sessions>.agda or Hybrid/Compatibility.agda if
other bridges land.

Q2. Presheaf-only vs. sheaf-too at v1.

- What's at stake: how much of the descent picture lands at v1 vs. is deferred.
- Option Q2a — Presheaf only. Buys: honest; ships exactly what current Sessions-Cat supports; clean deferral story. Costs: the separation-of-concerns claim is only half-stated — the topology side
is there, the descent side isn't.
- Option Q2b — Presheaf + separated-presheaf property (uniqueness without existence). Buys: records the "at most one global section per matching family" half of the sheaf condition. Costs: still
needs intersection-of-patches morphisms to state compatibility, which Sessions-Cat doesn't supply cleanly without enrichment.
- Option Q2c — Full sheaf, postulates filling the categorical gaps. Buys: full structural commitment at v1. Costs: heavy postulate budget; many will be re-derived in v2 once Sessions-Cat is
enriched, so the postulate work is throwaway.
- Lean: Q2a. The bridge HALF that current ingredients support, with the descent half explicitly waiting on the same StarAutonomous extension that SessionO1Action's canonical derivation needs. Two
deferred items, one trigger.

Q3. The target object of the trivial presheaf.

- What's at stake: whether const-presheaf returns 𝟙ₛ (tensor unit) or ⊥ₛ (dualizing object / par unit) at every frame.
- Option Q3a — 𝟙ₛ. Buys: matches "no content yet" reading (tensor unit = empty product); standard for terminal-object presheaves in cartesian topoi. Costs: in *-autonomous (linear) settings, 𝟙ₛ is
the multiplicative unit, not the terminal object — there's no canonical "everything maps to 𝟙ₛ."
- Option Q3b — ⊥ₛ. Buys: matches the Valuation/OperadAlgebra codomain (R7 already commits to ⊥-par as the natural session-valued target); presheaves into the dualizing object are the natural shape
downstream operadic algebras want to compose with. Costs: less standard outside linear-logic settings.
- Lean: Q3b. The R7 commitment in Valuation.agda already pins ⊥-par as the canonical codomain; the bridge inherits that.

Q4. Non-trivial v1 witness.

- What's at stake: how concrete v1's non-degenerate inhabitant is.
- Option Q4a — Constant presheaf only (I1-class). Buys: minimum. Costs: doesn't exercise P-on-hom non-trivially; same critique we just fixed for tiny-site.
- Option Q4b — A two-value presheaf over tiny-site: assigns 𝟙ₛ to PointFrame, some other type (e.g., 𝟙ₛ ⊗ 𝟙ₛ) to TinyFrame, with P-on-hom (embed-point b) being one of the unitor morphisms. Buys:
exercises every field non-trivially; demonstrates that the contravariance of the bridge against a non-identity FrameHom (the G3 work) actually shows up. Costs: 60-100 lines of additional witness
code.
- Option Q4c — Two "shadow" presheaves: an actor-only shadow that returns 𝟙ₛ everywhere (projects away content) and a content-only example. Buys: makes B1/B2 separation visible as an Agda artifact
(the two shadows witness that the two legs can be looked at independently). Costs: needs frame-internal data the records don't currently expose for the content shadow.
- Lean: Q4b. The two-shadow story (Q4c) is appealing but properly belongs at the sheaf level, where the descent picture makes "what each shadow forgets" precise. At the presheaf level, Q4b is
honest non-triviality.

Q5. Functoriality laws.

- What's at stake: whether the laws are stated-and-postulated (Sessions's pattern) or stated-and-discharged-per-instance.
- Option Q5a — Stated as fields, each instance discharges them. Buys: matches Sessions's pattern; the const-presheaf discharges by refl (id and composition are both identity), the non-trivial
witness discharges them by short proofs. Costs: every future instance writes the discharges.
- Option Q5b — Stated as fields, postulated globally for any inhabitant. Buys: less ceremony. Costs: hides actual mathematical content; instances could violate without notice.
- Lean: Q5a.

Q6. Whether to expose Codex-side "transition data" for v2.

- What's at stake: should the v1 file expose a derived matching-family type (parallel to sieve-of for the E1→E2 transition) that v2 will use to state descent?
- Option Q6a — Just the presheaf; defer matching-family entirely. Buys: simpler. Costs: v2 starts from scratch on the descent machinery.
- Option Q6b — Expose a derived matching-family : (P : SessionPresheaf) (c : Cover F) → Type. Buys: same role as sieve-of — the bridge artifact between v1 and v2 lives in the v1 file. Costs: needs
to use Sessions-Cat's morphisms, and at v1 the compatibility condition has to be honest about which intersection-data is unavailable.
- Lean: Q6b, in the same spirit as sieve-of. Even if the compatibility condition is partial at v1 (postulating the intersection witnesses with a flag), having the type live in v1 anchors v2.

Q7. Should the bridge be parameterized over Payload?

- What's at stake: Sessions takes a Payload parameter; the bridge inherits the question.
- Option Q7a — Parameterized over Payload, like Sessions. Buys: maximum flexibility; matches Sessions's signature. Costs: one more implicit parameter at every use site.
- Option Q7b — Fix Payload = Unit at v1. Buys: simpler signatures. Costs: binds an arbitrary choice; later instances either re-instantiate or live with the choice.
- Lean: Q7a.

What's explicitly NOT in v1

- Sheaf condition (descent, matching families with full compatibility on intersections). Deferred — same trigger as SessionO1Action's canonical derivation: the StarAutonomous extension with closed
structure / evaluation / cut. When that lands, both the sheaf condition and the canonical action become statable, and the bridge gets a v2.
- Sheaves of O_1-algebras over the site. A second-level bridge: instead of presheaves valued in SessionType, presheaves valued in OperadAlgebra Sessions-Cat. This is where the operadic interaction
algebra and the site-with-values picture fuse. Properly a v3 artifact.
- Actor-causal stability witness. Still postulated in ActorCausal.agda. The bridge doesn't unblock it; concrete stability for tiny-site (the smallest tractable witness) is a separate, smaller piece
of work.
- Promotion morphism. Still header-prose in ActorCausal.agda. Properly an MO_1 / arc/05 artifact.
- A-side return. Still gated on the cross-site adjunction being statable, which is gated on the sheaf condition, not just the presheaf.
- MO_1 / modular envelope. Premature.
- Pedagogy companions. Held loose.

What v2 of the bridge looks like (for context, not for now)

When the StarAutonomous extension with closed structure / evaluation / cut lands (the trigger named in future_work.md's "Regarding Sessions and the canonical O_1 action" ladder, item 3):

- IsSheaf record using the v1 matching-family type, now with full compatibility-on-intersections.
- The constant presheaf upgraded to a trivial sheaf.
- A genuine actor-only / session-only shadow pair making B1/B2 separation a theorem rather than an architectural claim.
- The cross-site adjunction Allow ⊣ Require becomes statable: Allow takes A-side modal data to sheaves on the actor-causal site; Require reflects back.
- A-side return (bar construction at S¹) unblocked.

Plan if my leans are accepted

A single file Concurrency/Hybrid/SessionPresheaf.agda, ~400-500 lines, structured as:
1. Header with discipline guardrails (no operad-level imports, etc.) and explicit v2 deferral note.
2. Imports (Sessions, ActorBase, ActorCausal).
3. Module parameterized over (AB, S, Payload) where S is an ActorCausalSite over AB.
4. SessionPresheaf record with five fields (Q5a).
5. const-presheaf returning ⊥ₛ everywhere (Q3b).
6. The two-value witness over tiny-site (Q4b), exercising embed-point false and embed-point true non-trivially.
7. Derived matching-family type (Q6b), with partial compatibility data flagged in a comment as the v2 transition slot.
8. Sanity checks.

### Codex

• The next step should be the hybrid bridge R1:

> define a session-valued presheaf, and eventually sheaf, over the actor-causal site.

This is the first place where the project’s structural claim stops being just architecture. We now have the two separated legs:

- locality/base: Concurrency/Sites/{ActorBase,ActorCausal}.agda
- typed content/value: Concurrency/Algebras/Sessions.agda

The bridge must show how typed session values vary over actor-local causal frames without putting session information into actors themselves.

Why This Is Next

The project’s B-side claim is:

> typed data lives in the value layer; unityped agents live in the base; separation of concerns is structural.

Right now we have the two sides separately. R1 is where this becomes one mathematical object:

Actor-causal site  C
Session value category V
Presheaf           Cᵒᵖ → V
Sheaf condition    descent over local-frame covers

That is the first real approach to the “separation of concerns” structural claim. It is also prerequisite for everything downstream: R4, the cross-site adjunction, and eventually the ModalHoTT/
Concurrency comparison.

What To Build First

I would not jump straight to the full sheaf theorem. Build it in layers.

Recommended new directory:

agda/Concurrency/Sheaves/

Recommended first files:

agda/Concurrency/Sheaves/Presheaf.agda
agda/Concurrency/Sheaves/SessionValuation.agda

Presheaf.agda should be generic over a StarAutonomous target. SessionValuation.agda should specialize it to Sessions-Cat.

Layer 1: Generic Frame Presheaf

Define a contravariant functor from actor-local frames into a target category:

FramePresheaf :
ActorCausalSite AB ℓE ℓR ℓI →
StarAutonomous ℓV ℓH →
Type _

Fields:

value :
LocalFrame AB ℓE ℓR → Ob

restrict :
(φ : G ↪ F) → Hom (value F) (value G)

restrict-id :
restrict (frame-id F) ≡ id

restrict-comp :
restrict (ψ ∘ᶠ φ) ≡ restrict φ ∘ restrict ψ

This is the core R1 object. It says: a larger frame has typed content, and every sub-view gets a restricted typed content.

The variance matters. Since FrameHom G F means “G embeds into F as a sub-view,” restriction goes:

value F → value G

Layer 2: Session-Valued Presheaf

Specialize the generic presheaf to Sessions-Cat Payload.

This should produce something like:

SessionPresheaf :
ActorCausalSite AB ℓE ℓR ℓI →
(Payload : Type ℓP) →
Type _

Internally:

SessionPresheaf site Payload =
FramePresheaf site (Sessions-Cat Payload)

The key design goal: the bridge imports both ActorCausal and Sessions, but still never modifies either. That proves the separation architecturally: values sit over frames; they are not inside
actors.

Layer 3: Minimal Witness

Ship a tiny witness, but keep it honest.

A good first witness is a constant presheaf over tiny-site:

value F = end
restrict φ = id-h

This is degenerate mathematically, but valuable as a plumbing check. It proves the bridge typechecks end-to-end:

ActorCausalSite → Sessions-Cat → FramePresheaf

A nonconstant witness can come later.

Layer 4: Descent Interface, Not Full Descent Yet

After presheaf, add a named placeholder/interface for sheaf descent, but do not overclaim.

The full sheaf condition needs careful matching-family machinery over covers, overlaps, and eventually the E2 sieve presentation. We should not fake that.

For v1, define a record such as:

BasisDescentData P

or just leave a clearly named future section:

-- Future:
-- MatchingFamily
-- compatible local sections
-- amalgamation
-- uniqueness

If implemented now, sections can be represented as:

Section F = Hom 𝟙 (value F)

But compatibility over overlaps will be awkward until pullbacks/sieves are better developed. So I’d make the descent target visible, not force it in the first bridge file.

What This Step Should Not Do

Do not:

- define messages;
- add payloads to actors;
- distinguish human / LLM / conversation actors;
- define promotion;
- use gen, plug, or shift directly;
- force the cross-site adjunction;
- solve R4 in the same file;
- switch to MO_1.

The bridge is already important enough.

Success Criterion

This step succeeds if we can point to an Agda object saying:

session values vary contravariantly over actor-local causal frames

with:

- actor carrier still opaque;
- sessions still in the value category;
- restrictions along FrameHom;
- identity and composition laws;
- a concrete constant-session witness over tiny-site.

That would be the first checked form of the B-side structural separation. After that, the next hard question becomes sheaf descent: when do compatible local session values glue to a global session
value over a frame?

My recommendation: ask Claude to build generic presheaves first, then the Sessions specialization, then a tiny constant witness. Treat full sheaf descent as the next sub-step, not the first one.
