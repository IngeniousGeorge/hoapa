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

- `_Site._Category` — objects (actor groupings / frames / configurations), morphisms (causal extensions / refinements).
- `_Site._Topology` — which families count as covers (local-frame coverings).

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
- `_Algebras._Actors` — actor carriers, unityped.

`_Algebras._CutElimination` deferred — full Caires-Pfenning dynamics is post-`MO_1`.

##### Integration with hybrid  <!-- concept:integration -->

- `_Algebras._Sessions` evaluates into the value category `V` of the hybrid's `_Sheaf` (R1).
- `_Algebras._Actors` instantiates over the hybrid's `_Site._Category` (actor-causal site).
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
- **R6 — Parametrization (Causality).** Causality → `_Site`. Constrains `_Site._Category`'s morphisms (causal extensions) and `_Site._Topology`'s covers (local-frame coverings). Lamport partial-order is the proposed commitment.
- **R7 — Algebra-over-Operad.** `_Algebras` evaluates `_Operad`. Landed as `StarAutonomous` + `Valuation` + structural `OperadAlgebra`, and concretely instantiated by `Sessions.agda` for the typed-content layer. Closely interacts with R1 (the value category for both must agree).
- **R8 — Involution-Duality.** `Sessions.agda` now contains both faces: syntactic `dual-involutive` and categorical / operadic `boundary-swap-at-gen` (a specialization of `boundary-swap-structural`). The bridge between them remains a deferred project claim, not a computational reduction.

**Most load-bearing now:** the actor-causal side and hybrid integration. R6 (actor-causal site) needs an Agda module at comparable maturity to `Sessions.agda`; R1 (value category / sheaf valuation) then has to explain how session values sit over actor-local frames. R4 (cartesian-vs-linear interpretation) remains the conceptual compatibility question.

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

The substrate is the actor-causal + session-type-values hybrid: a Grothendieck site of actor-causal frames (GR-inspired actor model, Lamport partial-order proposal at `_Site._Category`), with Caires-Pfenning session-type structures as the natural values (sheaves) on it (canonical source: `deep_context/arc/02_concurrency_anchor.md`). Separation of concerns is structural (modularity = sheaf-gluing); typed data lives in the values, unityped agents in the base topology.

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

## Blockers  <!-- tags: kind:state -->

(Previous Open Questions archived to `deep_context/archived_blockers/2026-05-17.md`. Deferred items migrated to `future_work.md`.)

Concurrency: none active. First B-side operad, algebra signatures, and concrete typed-content `Sessions.agda` instance shipped; next substantive work is an actor-causal module at comparable maturity, then the hybrid sheaf/value bridge.
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

### Next file

An actor-causal module at comparable maturity to `Sessions.agda`. The goal is not `MO_1` yet; it is the base side of the hybrid: actor identity / locality / causal extension / local-frame covers, with typed content kept out of the carrier. This should make R6 concrete enough that R1 can ask how the shipped session values sit over actor-local frames.

### After Sessions.agda

1. **Actor-causal module** — make R6 concrete: actor-local frames, causal morphisms, and cover families. Known shape, not started.
2. **Hybrid integration** — sheaf valuation (R1): place the shipped session values over the actor-causal site. Known shape, well-mapped, not started.
3. **A-side return plan** (lift `Bℤ → S¹`, switch η-iteration → cyclic bar) — on hold until the B-side reaches a point where the cross-site adjunction `Allow ⊣ Require` is statable.

### Held-loose long-horizon items (no near-term action)

- **Pask-style human-implementation layer** — conversation-as-operadic-composition. Speculative until `MO_1` makes "conversation creates conversation" a literal operadic operation. Held in motivation only.
- **Pedagogy companions** — `pedagogy/Concurrency/` mirrors for the operad and algebra files. Not started; lives in the pedagogy track (memory `pedagogy_project`).

## Historical note

The detailed rot-compₒ discussion that led to the 2026-05-18 cyclic-equivariance repair is archived. The durable outcome is recorded above: full cyclic equivariance is primitive, `boundary-swap` is derived, and the algebra layer uses `boundary-swap-structural` rather than treating binary session duality as the whole cyclic story.

## Discussion of the next step

### Codex

Closing note on `Sessions.agda`: shipped.

The B-side now has its first serious typed-content instance. What matters most is not just that `Sessions.agda` typechecks, but that the architecture is clearer:

- `SessionType`, structural duality, and `dual-involutive` give the syntactic R8 face.
- `Hom` keeps only the 13 categorical constructors.
- The `O_1` interaction data is correctly separated into `SessionO1Action`, rather than being forced into `Hom`.
- `session-interp` is defined by HIT recursion on `O`.
- `Sessions-Val` and `Sessions-Alg` close the records cleanly, with `interp-compₒ` and `interp-rot` by `refl`.
- `boundary-swap-at-gen` gives the categorical / operadic R8 face.
- The canonical derivation of the `O_1` action from richer categorical structure is explicitly deferred, not forgotten.

The next real build target is an Actors / actor-causal module at comparable maturity to `Sessions.agda`, then the hybrid bridge between actor substrate and session-valued content. Do not jump to `MO_1` yet.

### Claude

● Closing statement — Sessions.agda landing

What happened this session. The B-side acquired its first serious typed-content instance. After a sequence of design forks (postulated Hom → inductive Hom → operadic
primitives as constructors → bundled SessionO1Action) the file landed in five staged passes, all typechecking under --cubical --guardedness. Each fork was real, not
ceremony — the universe-level constraint forced widening Hom; the Sessions-Cat = record { ... } reduction friction forced copatterns; the ports Sessions-Cat end n ≠
portsₛ end n friction forced choosing between subst gymnastics, refactoring shipped files, or relocating the operadic primitives. Path 3 (relocation, bundled into
SessionO1Action) preserved the v1 plan with interp-compₒ and interp-rot holding by refl.

Architectural picture now visible:

- Syntactic R8 face: dual-involutive : (S ^⊥ₛ) ^⊥ₛ ≡ S, proved by seven-case recursion. No postulates.
- Categorical / operadic R8 face: boundary-swap-at-gen, a concrete PathP between specific Hom terms, obtained as OperadAlgebra.boundary-swap-structural Sessions-Alg {l =
1} {r = 1} fzero fzero gen gen.
- The bridge between them: the project's actual R8 claim. Deliberately not materialized in code, because forcing it through abstract Hom would be the framework dictating
to the math. Both faces sit in the file as distinct Agda objects; the bridge becomes provable when richer categorical structure makes it expressible.
- The operadic action is honest: SessionO1Action is a chosen action on the session Hom family at the chosen arity layer, not recursor boilerplate. Its eventual derivation
from richer categorical structure (closed structure / evaluation / cut / coherent tensor rotation) is named explicitly as the next algebra-layer task, before serious
MO_1 work.
- The "conversation of conversations" slot is protected: the file's narrowness (one level only, no actor identity in carrier, no proof-term calculus) is what keeps MO_1
self-gluing (operadic side) and actor-causal cellular coarsening (locality side) reachable as future moves.

Friction discovered worth recording for the workflow:

1. Valuation.ports defined inside a parameterized module produces a function identity that doesn't unify with any locally-defined iteration for variable n. This is what
drove Path 3. The Valuation / OperadAlgebra interface design assumed instances would compute iteration from the record's _⊗_ field — Sessions is the first instance, and
it exposed that this assumption forces either record-interface refactor or pragmatic relocation. We chose relocation; the refactor is queued under "richer categorical
structure for the algebra layer."
2. The ports-injectivity blocking propagated as inference issues at shift-zero-h (where fzero doesn't pin shift-morph's arity through ports). Resolved with {n = n} hints,
flagged per feedback_flag_workarounds.
3. parallel-arity-eq had to be exposed (removing private from CyclicAssociative.agda) so the operadic-law PathP types could refer to it literally rather than
reconstructing.

Where to go next. I agree with Codex's read: do not jump to MO_1. Two natural fronts, ordered by readiness:

Track 1 — Actors / actor-causal site (R6). The B-side's locality leg. Bring it to comparable maturity to Sessions.agda: a small Agda module presenting the actor-causal
site as a Grothendieck site, with Lamport partial-order causality at _Site._Category (per the 2026-05-17 commitment) and local-frame coverings at _Site._Topology. This is
the structural home for unityped agents, currently sitting in the level-2 inventory but not yet in Agda. Comparable in scope to Sessions.agda but on the locality side
rather than the content side.

Track 2 — Hybrid bridge. Once both Sessions (content) and Actors (locality) exist as Agda modules, R1 (sheaf valuation: V drawn from Sessions's syntactic category) and R6
(parametrization: causality into Actors) can compose. The sheaf-of-session-values picture from concurrency_anchor.md becomes formalizable. This is where "separation of
concerns is structural (modularity = sheaf-gluing)" stops being an architectural claim and becomes an Agda object.

Not next:
- MO_1 / modular envelope. Premature — the hybrid bridge hasn't been built yet. The categorical-structure work that SessionO1Action's deferred derivation needs (closed
structure / evaluation / cut) is closer to ready than MO_1 is.
- A-side return (Bℤ → S¹, cyclic bar construction). Still gated on the B-side reaching statability of the cross-site adjunction Allow ⊣ Require, which needs the hybrid
bridge to exist.
- The richer-categorical-structure derivation of SessionO1Action from StarAutonomous. Sits at the algebra layer, queued, but Sessions.agda doesn't block on it — the
postulated bundled action is honest.

My order of preference: Actors first, then hybrid bridge. The reason is symmetry: Sessions is the content leg of the B-side; Actors is the locality leg. Building both to
the same maturity before bridging is what makes the eventual cross-site adjunction with the A-side honest rather than asymmetric.

The pedagogy companions for the operad and algebra files (pedagogy_project.md) remain queued — held loose, not next.

Sessions.agda is shipped. The next session opens on the Actors / actor-causal site module.
