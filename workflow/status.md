---
tags: [focus:cross-site, kind:state, level:scoping]
---

# Project Status

The arc is articulated in `arc.md` (now pair-first: `Allow ⊣ Require` with the five arc/09 anchors) and decomposed into propositions T1–T7 plus T_recursion in `targets.md`. Philosophical seed in `motivation.md`. Brainstorming archive: `deep_context/arc/`.

Bandwidth is on the Concurrency side, after a cycle of reframes that has converged: actor-causal + Caires-Pfenning hybrid (substrate) augmented by an operadic interaction-algebra layer (`O_1`), with the modular envelope `MO_1` as long-horizon target. The ModalHoTT side is paused at the de Rham named-coefficient rung with a defined return plan (S¹ + cyclic bar construction) coordinated with the B-side commitment.

## Concurrency  <!-- tags: focus:concurrency, level:scoping -->

### Where we landed

The Concurrency-side has converged after a cycle of reframes: icosahedral (A_5 / S²-equivariant) → actor-causal + Caires-Pfenning hybrid (per `deep_context/arc/02_concurrency_anchor.md`) → operadic interaction-algebra layer named on top of the hybrid (per `deep_context/arc/03_attachement_in_arc.md`). The current commitment treats the hybrid as substrate and the operadic layer as augmentation, not replacement. The B-side has *cycled*, not drifted: each reframe added structure rather than discarding the previous one.

The interaction algebra is `O_1` — the cyclic operad with one binary generator and a cyclic action. Three structural matches with actor/session content land cleanly: one binary operation = actor's single interaction primitive (Hewitt-style); the derived boundary-swap theorem = session-type duality `S ↔ S^⊥` = 1=2 perspective swap; three cyclic ports = sender / receiver / channel = trinion. The free cyclic operad on this data is small and finitely presented — Agda-reachable directly.

The first concrete typed-content instance is now shipped: `Concurrency/Algebras/Sessions.agda` instantiates the `O_1` algebra layer with multiplicative session syntax. It contains both R8 faces in Agda: syntactic `dual-involutive` and categorical / operadic `boundary-swap-at-gen`. The bridge between those faces is explicitly deferred to richer session-categorical structure; v1 records the two faces without overclaiming their identity.

The actor-causal locality leg is now shipped: `Concurrency/Sites/{ActorBase,ActorCausal}.agda` makes R6 concrete with opaque unityped actors, Lamport-style event causality, local frames, strict-reflecting frame embeddings, basis covers, and a Bool-based non-trivial cover witness. Promotion of a completed conversation into an actor-like node is deliberately not a `FrameHom`; it is reserved as a future morphism class for the `MO_1` / conversation-of-conversations stage.

Hybrid v1 shipped the first adapter layer (`Presheaf.agda`, `SessionPresheaf.agda`): generic frame presheaves, zero-postulate separatedness, and constant session-valued witnesses. The fast-track descent layer has now landed on the finite-frame subsite: `FiniteProducts.agda`, `FiniteFrame.agda`, `FiniteCover.agda`, `TinyFiniteCover.agda`, `EventProductPresheaf.agda`, `FiniteDescent.agda`, `EventProductSheaf.agda`, `SessionEventProductSheaf.agda`, and `TinyEventProductExample.agda` give full finite-site event-product descent, including the Sessions constant-slot instantiation and the first concrete two-point finite-cover validation. This is not the event-dependent session target and not the all-frame sheaf category; it is the first non-degenerate finite sheaf witness.

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

- `_Sheaf._Presheaf` — shipped in two layers: `FramePresheaf` over arbitrary actor-local frames, and `FiniteFramePresheaf` over enumerated finite frames. `SessionPresheaf` is the original constant-frame adapter; `SessionEventProductSheaf` is the finite, frame-varying, constant-slot Sessions witness.
- `_Sheaf._Separatedness` — shipped as property records. The original `IsSeparatedPresheaf` remains generic over basis covers; the finite event-product witness proves separatedness over `FiniteCover`s.
- `_Sheaf._Descent` — landed for the finite event-product presheaf: matching families, overlap compatibility, amalgamation, and separatedness over finite covers. General `_Topos._SheafCategory` construction is still pending.

The first value category `V` is `Sessions-Cat Payload`; later versions may replace or lift this to richer session categories or presheaves valued in `OperadAlgebra`.

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

- `_Algebras._Sessions` now supplies the first value category `V` of the hybrid's `_Sheaf`: `SessionPresheaf = FramePresheaf AB (Sessions-Cat Payload)`.
- `_Site` supplies the actor-causal frame category over which `_Algebras._Sessions` varies as values. The finite descent layer takes `ActorBase`, `FiniteFrame`, and `FiniteCover`; pullback overlaps are supplied by `ActorPullback.agda`, while sheaf-category/R4 work should stay generic over finite sheaves.
- `boundary-swap-structural` supplies the categorical / operadic R8 face that cross-cuts the existing `_Algebra._SyntacticCategory`; the bridge to syntactic session duality is deferred (R8).

This is the commitment frontier for `O_1`: enough operadic structure to name the interaction algebra of the hybrid; no commitments beyond cyclic-operad-without-modular-envelope.

### Structuring relations  <!-- tags: kind:reference -->

Named, like modules. R1–R6 are from the hybrid substrate's level-2 scoping; R7–R8 are added for the operadic layer at the `O_1` commitment level; R9–R11 are deferred to the `MO_1` stage.

**Live now.**

- **R1 — Valuation.** v1 landed in `Concurrency/Hybrid/{Presheaf,SessionPresheaf}.agda`: `FramePresheaf` is the generic functorial assignment `_Site._Category^op → V`, and `SessionPresheaf` instantiates `V = Sessions-Cat Payload`. Full finite-site event-product sheaf valuation has landed; the remaining R1/R2 work is category-level packaging and broader sheaf infrastructure.
- **R2 — Indexing.** `_Sheaf` lives over `_Site`: presheaf + descent against `_Site._Topology`. The finite event-product sheaf layer is shipped. The remaining load-bearing step is assembling sheaves generically into `_Topos._SheafCategory`, not proving the constant-slot witness again.
- **R3 — Generation.** `_Topos = Sh(_Site._Category, _Site._Topology)`. No freedom; the topos is generated from site + sheaves.
- **R4 — Interpretation.** `_Topos._InternalLogic ↔ _Algebra._Connectives` / `_Algebras._Sessions`. Topos logic is cartesian by default; the algebra is linear. Compatibility (or its principled absence) is its own piece of work.
- **R5 — Embedding.** `_Topos._GeometricMorphisms → cubical sets`. The mathematical form of "both sides share an ambient `(∞,1)`-topos."
- **R6 — Parametrization (Causality).** Causality → `_Site`. Landed in `Concurrency/Sites/{ActorBase,ActorCausal}.agda`: Lamport partial-order events, actor-local frames, strict-reflecting frame embeddings, basis covers, and a Bool-based non-trivial cover witness. `ActorPullback.agda` supplies pullback overlaps and a pullback-stability construction downstream; `ActorCausal.agda` still keeps its legacy in-file stability fallback for the bundled tiny site.
- **R7 — Algebra-over-Operad.** `_Algebras` evaluates `_Operad`. Landed as `StarAutonomous` + `Valuation` + structural `OperadAlgebra`, and concretely instantiated by `Sessions.agda` for the typed-content layer. Closely interacts with R1 (the value category for both must agree).
- **R8 — Involution-Duality.** `Sessions.agda` now contains both faces: syntactic `dual-involutive` and categorical / operadic `boundary-swap-at-gen` (a specialization of `boundary-swap-structural`). The bridge between them remains a deferred project claim, not a computational reduction.

**Most load-bearing now:** finite-site event-product descent, its constant-slot Sessions instantiation, and the concrete tiny finite-cover validation have landed. The next hinge is building `_Topos._SheafCategory` generically over `FiniteFramePresheaf` / `IsSheaf`, followed by R4 (cartesian topos-internal logic vs linear/session values). The cross-site adjunction waits on sheaf-category/R4 maturity, not on event-dependent slots.

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

Hybrid now has two strata. The original adapter implements arbitrary-frame presheaf/restriction and separatedness. The fast-track finite layer implements full event-product descent over `FiniteCover`s, with a constant-slot Sessions instantiation: arity varies by frame event count, but every event carries the same fixed session slot `P₀`. Event-dependent session content is deferred; it is not a blocker for `_Topos._SheafCategory`, R4, or the cross-site `Allow ⊣ Require` statement if those layers stay generic over `FiniteFramePresheaf` / `IsSheaf`.

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
| 2026-05-20 | Actor-site identity and transitivity covers are generic; stability named as the v1 gap | `identity-cover-canonical` and `transitivity-cover-canonical` are constructed. `stability-cover-postulate` was named and flagged; `ActorPullback.agda` later supplies the generic pullback-stability construction while `ActorCausal.agda` keeps the legacy fallback to avoid an import cycle. |
| 2026-05-20 | Actor-site tiny witness upgraded to non-trivial Bool cover | `TinyAB` uses `Fin 2`; `TinyCausal` uses `Bool` events with `false ≤ true`; `PointFrame` embeds by `embed-point false` / `embed-point true`; `two-point-cover` exercises non-trivial index, patch, embedding, and event-lift data |
| 2026-05-20 | Hybrid v1 shipped as adapter layer | `Concurrency/Hybrid/Presheaf.agda` provides generic `FramePresheaf`, zero-postulate `IsSeparatedPresheaf`, and `const-presheaf`; `SessionPresheaf.agda` specializes to `Sessions-Cat Payload` and exposes both `const-𝟙ₛ-presheaf` and `const-⊥ₛ-presheaf`. This implements Adapter 1 (restriction) and names future adapter slots without faking descent or a unit/dualizing conversion |
| 2026-05-21 | Reflexive Protocol Layer named; not implemented | Π = category of protocol versions; protocol edits = morphisms in Π. Promotion (Adapter 5) sharpened with operational role: closed meta-conversation reaching consensus → Π-morphism. Consensus framed as future colimit / coherent amalgamation in a patch-theoretic fragment category, with Pijul as primary implementation-facing candidate; precise categorical shape held open. `Concurrency/Hybrid/Reflexive.agda` reserved as future home. `MO_1` elevated to active roadmap without displacing the sheaf-category / R4 path as the next technical step. Layer is new formal content, compatible with and anticipated by current scaffolds but not already implicit in them |
| 2026-06-04 | Finite event-product descent landed | Added finite additive products, finite frames/covers with carried overlap enumerations, generic finite event-product presheaf, and full finite-site descent (`IsSheaf`) over `FiniteCover`s. The result is non-degenerate by arity: `value F = P₀ ^ event-count(F)`, including empty-frame normalization by the terminal additive product. |
| 2026-06-04 | Sessions constant-slot instantiation landed | `Sessions.agda` gained additive product syntax and laws; `SessionEventProductSheaf.agda` instantiates the generic finite witness at `Sessions-Cat Payload`. This is constant-slot B2(a), not event-dependent session content and not additive coproduct universal properties. |
| 2026-06-04 | Tiny finite cover witness landed | `TinyFiniteCover.agda` and `TinyEventProductExample.agda` exercise the finite descent stack on the existing `TinyFrame` / `PointFrame` two-point cover. The proof-level target landed; definitional computation remains only an optional future bonus. |

## Blockers  <!-- tags: kind:state -->

(Previous Open Questions archived to `deep_context/archived_blockers/2026-05-17.md`. Deferred items migrated to `future_work.md`.)

Concurrency: none active. First B-side operad, algebra signatures, concrete typed-content `Sessions.agda` instance, actor-causal site v1, Hybrid v1 restriction, finite products, finite covers, finite event-product descent, the constant-slot Sessions sheaf, and the concrete tiny finite-cover witness have shipped. Next substantive work is `_Topos._SheafCategory`, then R4 compatibility and the eventual cross-site adjunction.
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

Shipped to `agda/Concurrency/Sites/`:

| File | Role | Line count |
|------|------|-----------:|
| `ActorBase.agda` | Opaque unityped `ActorBase` carrier plus Lamport `CausalOrder`; derives `Concurrent` and `≤-bidir-equal` | ~160 |
| `ActorCausal.agda` | Actor-local frames, strict-reflecting `FrameHom`, frame category laws, basis `Cover`, `sieve-of`, generic identity / transitivity covers, `ActorCausalSite`, legacy `stability-cover-postulate`, and Bool-based non-trivial tiny witness | ~790 |
| `ActorPullback.agda` | Pullback/overlap frames for pairs of `FrameHom`s, projections `pb-π₁` / `pb-π₂`, pullback square, and pullback-stability construction | ~315 |
| `FiniteFrame.agda` | Finite-frame subsite object: `LocalFrame` plus chosen event count and `Event ≃ Fin event-count` enumeration | ~60 |
| `FiniteCover.agda` | Finite covers with finite patches and carried finite enumerations of every actual pullback overlap | ~90 |
| `TinyFiniteCover.agda` | Concrete finite lift of the existing Bool two-point cover, including `Bool≃Fin2`, `Unit≃Fin1`, and four-case overlap enumeration | ~190 |

The actor site deliberately does not import `Sessions.agda` or operad files. Its job is locality: actor membership, event incidence, causal sub-view embeddings, and local-frame covers. Typed content, `O_1` operations, and conversation-promotion stay out of the carrier.

`FrameHom` is strict: causality is preserved and reflected, making it a sub-view embedding rather than an arbitrary monotone map. This preserves the future distinction between embedding a local view and promoting a completed conversation into an actor-like node.

`Cover` is basis-form (E1), but `sieve-of` is exposed as the bridge artifact for the future sieve / Grothendieck-topology presentation (E2). The identity and transitivity cover axioms have generic constructions; `stability-cover-postulate` is now a legacy in-file fallback; `ActorPullback.agda` supplies the generic pullback-stability construction downstream.

The G3 witness is non-trivial: `TinyAB` has two actors (`Fin 2`), `TinyCausal` has two Bool events with `false ≤ true`, `PointFrame` embeds into `TinyFrame` via `embed-point false` and `embed-point true`, and `two-point-cover` covers `TinyFrame` by the two event-patches.

### Hybrid

Shipped to `agda/Concurrency/Hybrid/`:

| File | Role | Line count |
|------|------|-----------:|
| `Presheaf.agda` | Generic arbitrary-frame adapter chassis: `FramePresheaf`, zero-postulate `IsSeparatedPresheaf`, and `const-presheaf` | ~250 |
| `SessionPresheaf.agda` | Arbitrary-frame Sessions specialization and constant witnesses `const-𝟙ₛ-presheaf` / `const-⊥ₛ-presheaf` | ~135 |
| `EventProductPresheaf.agda` | Finite-frame event-product presheaf: `value F = P₀ ^ event-count(F)`, restrictions by additive projections | ~220 |
| `FiniteDescent.agda` | Generic finite-cover matching families, amalgamation, separatedness, and `IsSheaf` records over `FiniteFramePresheaf` | ~125 |
| `EventProductSheaf.agda` | Generic proof that the event-product presheaf is a full finite-site sheaf over `FiniteCover`s | ~275 |
| `SessionEventProductSheaf.agda` | Constant-slot Sessions instantiation of the generic finite event-product sheaf | ~100 |
| `TinyEventProductExample.agda` | End-to-end concrete finite descent example: tiny matching families, amalgamation, separatedness, and Sessions specialization | ~170 |

The arbitrary-frame Hybrid v1 files remain the adapter-layer scaffold. The finite layer adds the first full sheaf inhabitant but does not yet assemble the sheaf category. The original restriction adapter shape is:

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

Verification record: `agda -l cubical -i agda agda/Concurrency/Sites/TinyFiniteCover.agda` and `agda -l cubical -i agda agda/Concurrency/Hybrid/TinyEventProductExample.agda` both exit 0. The site file has four unique `UnsupportedIndexedMatch` warning sites from `FinData.Fin` enumeration helpers; the hybrid check also inherits the existing `FiniteProducts.agda` warnings. These warnings are inert under the proof-level API discipline.

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
- **`MO_1` / modular envelope** elevated from "held loose" to active roadmap as the natural home for self-gluing / conversation-of-conversations. This does *not* displace the sheaf-category / R4 path as the next technical step — `MO_1` becomes the natural next slot once the Hybrid sheaf-category/R4 bridge is stable enough to support modular-envelope work; the cross-site adjunction and bar-construction comparison remain downstream.
- **B-side dual of T_recursion iteration** (deferred per `future_work.md` "until `ND` has non-trivial content") becomes statable once the reflexive layer gives `ND` operational meaning.

**Where it goes in the Agda tree.** `Concurrency/Hybrid/Reflexive.agda` reserved as the future module slot. Kept inside the Hybrid layer because the protocol-version structure reads as one more adapter (between the current Hybrid instance and the next), and because the project avoids premature folder proliferation. If the file later grows into a genuinely higher-order protocol calculus, it can be split out to `Concurrency/Meta/` at that point.

**Trigger for opening `Hybrid/Reflexive.agda` v0.** Two conditions, both required: (a) sheaf-category / R4 stable enough that the Hybrid chassis is no longer moving, and (b) the fragment-category candidate (Pijul or alternative) honest enough to state in Agda.

### Next frontier

1. **`_Topos._SheafCategory`** — assemble finite-frame sheaves generically over `FiniteFramePresheaf` plus `IsSheaf`; do not specialize this layer to the constant-slot witness.
2. **R4 compatibility** — clarify how cartesian internal logic of the topos talks to the linear/session value layer.
3. **Cross-site `Allow ⊣ Require`** — define the actual functors, unit, counit, and triangle identities; then instantiate the generic iteration scaffold.
4. **A-side return plan** (lift `Bℤ → S¹`, switch η-iteration → cyclic bar) — on hold until the cross-site adjunction is statable.

### Held-loose long-horizon items (no near-term action)

- **Pask-style human-implementation layer** — conversation-as-operadic-composition. Speculative until `MO_1` makes "conversation creates conversation" a literal operadic operation. Held in motivation only.
- **Pedagogy track** — current for the synthetic ModalHoTT and Concurrency Agda trees as of 2026-05-21. `pedagogy/01_ModalHoTT/` now has a top-level intro, companions for all current synthetic `ModalHoTT/Modalities` files, and `02_Cohomology/01_flatcoefficients.md`; `pedagogy/02_Concurrency/` mirrors all current `agda/Concurrency/` folders. Analytic pedagogy remains intentionally out of scope unless explicitly requested.

## Historical note

The detailed rot-compₒ discussion that led to the 2026-05-18 cyclic-equivariance repair is archived. The durable outcome is recorded above: full cyclic equivariance is primitive, `boundary-swap` is derived, and the algebra layer uses `boundary-swap-structural` rather than treating binary session duality as the whole cyclic story.

## Next step

### Claude

● Recommendation: build _Topos._SheafCategory — the category of finite-frame sheaves over V

  Why this, and why now

  The foundational adjunction of arc/09 is Allow ⊣ Require between M (modal contexts) and K (concurrent communities), with the five anchors being the data of that one adjunction. arc/09's own
  resolution is explicit that we have the shape (grounded generically in Iteration.agda) but not the instance — and the instance "waits on the concurrency side maturing past descent."

  The precise thing that's missing is K as a category. Require : K → M has to land somewhere and Allow : M → K has to map into something; right now the B-side has a site, a value category, and an
  inhabited sheaf — but no category whose objects are sheaves. Until that exists, Allow ⊣ Require cannot even be stated in Agda, let alone inhabited. Every roadmap note (status.md, session_03,
  arc/09) names _Topos._SheafCategory as exactly this gating prerequisite — it's the object R4 and the cross-site geometric morphism both sit on top of.

  It's the right step under the "don't rush / don't weaken" constraint specifically because:

  - On the critical path, not a detour. It's the named prerequisite, not an optional deepening. (Contrast event-dependent slots, which we agreed to defer — they strengthen values, off the adjunction
  path.)
  - De-risked. The tiny example just gave us a concrete sheaf, so the category has at least one honest object and an identity morphism from day one — no vacuity worry.
  - Doesn't overclaim. A 1-category of sheaves, honestly constructed, makes no adjunction claim. It builds the slot; it doesn't pretend to fill it. (Building the 1-categorical shadow before any
  ∞-lift matches the project's stated "1-cat first" discipline.)
  - Preserves the T3 asymmetry that the adjunction's non-degeneracy depends on. arc/09's closing point: the adjunction is non-trivial because B is fixed-point-poor (no global frame). That locality
  lives in the actor-causal site, which this step doesn't touch — and building over the finite site (the mature part) rather than faking the full site keeps it honest.
  - It's the non-redundant move. Re-stating the abstract adjunction record would just duplicate Iteration.agda's generic L ⊣ R. The genuinely new content arc/09 is waiting for is a real category in
  the K-slot. That's this.

  How I'd go about it (brief)

  Generic over any StarAutonomous V, four bounded pieces:

  1. FiniteFramePresheafHom P Q — a natural transformation: α : (F) → Hom (value P F) (value Q F) with the naturality square against restrict (mind the contravariance: restrict_Q φ ∘ α F ≡ α G ∘ 
  restrict_P φ). Plus identity and composition.
  2. FiniteFramePresheafCat V — assemble objects + these morphisms + unit/associativity laws into a category.
  3. FiniteSheafCat V — the full subcategory on objects carrying IsSheaf (the sheaf condition is a property, so morphisms are unchanged; objects become Σ[ P ] IsSheaf … P).
  4. Sanity object — the identity on event-product-sheaf / the tiny witness, confirming the category is concretely inhabited.

  One design flag worth settling first (I'd want your/Codex's call): bespoke thin Category-style record (matching the StarAutonomous house style, no isSet Hom obligation) vs. importing
  Cubical.Categories.Category (more reusable, but forces hom-sets to be sets — which would push an isSetHom requirement back onto StarAutonomous). My lean is the bespoke thin record now, adopting the
  library Category only when the geometric-morphism machinery actually needs it — keeps the dependency surface small and avoids retrofitting hLevels onto the value-category interface prematurely.

  Honest runway (so we're deliberate, not rushing)

  This is step 1 of ~3 to the adjunction, and I want to be clear the adjunction is not the next deliverable:

  - Step 1 (this): the sheaf category. Bounded, generic, on the path.
  - Step 2: R4 — the real hinge. How the cartesian internal logic of the topos talks to the linear session/value layer. This is genuine conceptual research (subobject classifier? a linear-non-linear
  / Benton adjunction, flagged in arc/03 §E?), and it's where rushing would weaken things. It only becomes statable once step 1 exists.
  - Step 3: state Allow ⊣ Require between M and K, grounded in Iteration.agda's five-anchor shape; inhabiting it is T1.

  So the sheaf category is the move that makes the next questions askable without committing to answers we haven't earned — which is exactly the posture arc/09 asks for. I'd stop at step 1, surface
  whatever R4 tension the category exposes, and let that shape step 2 rather than pre-deciding it.

  I haven't written anything — this is the assessment for you and Codex to weigh before I touch code.

✻ Churned for 2m 6s

❯ 1. Is the question of what this category should be completely transparent in our context, or do we have options to consider?                                                                         
                                                                                                                                                                                                       
  2. It seems to me step 2 is crucial. What do you think are the most decisive decisions we have to make at this level?                                                                                
  
● Both questions turn out to be more coupled than my step-1 framing let on — and that coupling is the useful finding. Let me take them in turn.

  1. The category is not transparent — there are three real forks, and the deepest is R4 in disguise

  Fork A — over which site (minor, tractable). We have finite-frame sheaves inhabited; the all-frames Descent.agda condition is stated but un-inhabited. So Sh(finite-frame site) is the honest,
  populated choice; Sh(actor-causal site) is the real long-term target. Lower stakes — build finite now, extend later. Non-weakening either way.

  Fork B — what enrichment (real). A morphism of sheaves is a natural family of V-morphisms commuting with restrict — that part is forced. But there's a genuine choice in how much of V's structure K 
  inherits:
  - bare 1-category (homs = sets of natural V-families), or
  - K itself *-autonomous via Day convolution — [C^op, V] inherits a linear/closed structure when V is *-autonomous, so K becomes a linear category and the eventual Allow ⊣ Require could be a
  monoidal/linear adjunction that preserves session duality.
  
  The bare option is cheaper but risks under-building: it forgets that V is linear, which is the entire point of the session side. The Day-convolution option keeps the duality but is a much larger
  lift and commits early.

  Fork C — the deep one: V-valued vs Set-valued, i.e. which category is _Topos._SheafCategory. This is where transparency breaks down. The inventory name _Topos presumes a Set-valued sheaf topos
  (Grothendieck topos, with Ω and cartesian internal logic). But everything we've built is V-valued (FiniteFramePresheaf is valued in StarAutonomous, not Set). These are two different categories:
  - Sh(site, Set) — a genuine topos: Ω, cartesian logic, but it sees only the locality structure (actors/events), not the session content;
  - Sh(site, V) — the linear category of session-typed sheaves we've actually been building: carries the content, has the dualizing object ⊥, but is not a topos and has no Ω.

  So "build the sheaf category" silently presupposes a choice between the cartesian locality-topos and the linear content-category — and that choice is exactly R4. The honest consequence: step 1
  should not pretend to build "the" sheaf category. It should build the V-valued linear category (the mature continuation — Fork B's Day-convolution version is the principled target,
  thin-1-categorical the pragmatic start) and explicitly name the Set-valued locality topos as the other pole that R4 must bridge. That surfaces the tension cleanly instead of burying it in an
  encoding decision.

  So: not transparent. The site and enrichment are real-but-bounded choices; the cartesian-vs-linear object is genuinely undecided and is R4 wearing a category costume.

  2. R4's decisive decisions

  Given the above, R4 isn't "a compatibility lemma" — it's where the framework's character is set. The decisive calls, in rough order of stakes:

  D1 — Is the bridge the Benton linear/non-linear adjunction? arc/03 §E and arc/06 already name this as the canonical resolution: a cartesian-closed category (the locality topos,
  _Topos._InternalLogic) and a *-autonomous category (the session values, _Algebras._Sessions) linked by a monoidal adjunction F ⊣ G whose comonad ! = F∘G is the linear exponential. Committing to
  Benton makes R4 constructible. The live alternatives to weigh against it: a Chu/Dialectica construction (process/context duality — but arc/02 set Chu aside), a Seely-style linear category with the
  topos as its cartesian core, or going fully linear and dropping the cartesian topos (which abandons Ω and weakens the "topos" claim). My read: Benton is the leading candidate and the one the prior
  design already gestured at — but it should be a conscious commitment, not a default.

  D2 — Scope: is R4 B-internal, or does the modal side already enter? R4 as written is within B (cartesian locality vs linear content). The cross-site Allow ⊣ Require is A↔B. The decisive discipline
  call: keep R4 B-internal and hold A out until step 3. Because the Benton adjunction is itself an Allow ⊣ Require-shaped object (left adjoint generative, right adjoint forgetful) — and arc/09's
  conservation-law warning is precisely about not conflating same-shaped adjunctions at different altitudes. Deciding whether the B-internal LNL bridge is the cross-site adjunction's internal shadow,
  or a genuinely distinct adjunction, is the highest-stakes conceptual decision in the whole program. It should be made deliberately; accidentally identifying them would be the kind of overclaim
  that weakens everything.

  D3 — Does R4 force building the ! exponential, or can it be an assumed interface? Sessions.agda deliberately stops at multiplicative + additive (no exponentials, no cut). Benton's ! needs the
  comonad. So R4 either forces a real exponential extension of Sessions, or — mirroring exactly how we handled SessionO1Action and StarAutonomous — we name the LNL adjunction as an assumed record 
  interface, derive what's needed, and defer the canonical construction. The non-rushing move is the latter: state R4 at the interface level, keep the heavy exponential/cut construction as a flagged
  later milestone.

  D4 — How much cartesian topos (Ω) do we actually build? Ω lives on the cartesian/locality side. The minimal R4 may need only the cartesian-closed structure of the locality topos, not a full
  subobject classifier. Decision: how much of Sh(site, Set) to construct vs. assume — and whether Ω is load-bearing for the adjunction or deferrable.

  The throughline: R4 is the point where "the modal side is cartesian-rigid, the concurrency side is linear-fluid" stops being a slogan and becomes a construction — and that very rigidity/fluidity
  split is the T3 asymmetry the adjunction's non-degeneracy depends on. So R4 done right is what protects the framework from collapsing into an equivalence; D2 (resisting premature identification) is
  where rushing would do the most damage.

  If this is right, it sharpens step 1: build the V-valued linear sheaf category as the honest continuation, and let the named gap to the cartesian locality-topos be the precise statement of R4 — so
  the category we build and the bridge we owe are two clearly separated objects, not one blurred one.

✻ Crunched for 1m 48s

❯ It seems to me with Fork C we're back at the moment when the tension between the unityped actors and the typed sessions forced us, happily so, to think of the module in the middle (forgot its      
  name) as an "adapter layer", which would let the actors "be themselves", the sessions "be themselves", and yet the two would work harmoniously because of the work done by the adapter (there was a  
  list of them with nice properties, I thought this was a very satisfying architecture). Can't we get to another "best of both world" situation here also, with a both Sh(site, Set) and Sh(site, V)   
  coexisting locally and an adapter for them at the global level?                                                                                                                                      
  Wouldn't that be the best setting to build R4 from?                                                                                                                                                  
  
● Yes — and I think you've just named the right move, not merely an analogy. The module you're remembering is the Hybrid adapter layer (Concurrency/Hybrid/), and the precedent is exact: the 𝟙ₛ vs ⊥ₛ
  question (tensor unit vs dualizing object). Codex's resolution there was "don't pretend there's a canonical conversion — expose both, name any bridge explicitly as a UnitDualizingBridge with laws,
  no hidden cast." Fork C is that same decision one level up: Set-topos vs V-linear are two legitimate structures; don't collapse one into the other, keep both, bridge them with a named adapter. So
  this isn't a new idea you're importing — it's the framework being consistent with its own deepest architectural commitment (motivation.md's cascade: every trade-off resolved by giving each concern
  its own categorical home plus a precise interface).

  Why it's the best setting for R4

  It preserves both halves instead of sacrificing one. "Pick a category" forced a loss: cartesian gives you Ω and internal logic but forgets session content; linear keeps duality but has no Ω. The
  adapter keeps both — Ω lives on Sh(site,Set) (the locality/internal-logic side), session duality lives on Sh(site,V) (the content side), and neither is bent to fit the other. That's the literal
  "best of both worlds," and it's the same shape as "unityped actors stay unityped, typed sessions stay typed, the adapter does the reconciling."

  R4 stops being a new kind of object — it becomes the next adapter in the list. Alongside the restriction adapter, the cover/descent adapter, the separatedness/auditability adapter, the (deferred)
  unit/dualizing bridge — R4 is a Cartesian↔Linear adapter: a named functor (likely an adjunction) Sh(site,Set) ⇄ Sh(site,V) with explicit laws, "no hidden cast." That continuity is itself evidence
  it's right.

  The strongest endorsement: it converges with the canonical math. A change-of-base along a free/forgetful pair F ⊣ G : Set ⇄ V lifts (by postcomposition over the fixed site) to an adjunction F_* ⊣ 
  G_* between the two sheaf categories, with !_* = F_* ∘ G_* the lifted linear exponential. That is precisely Benton's linear/non-linear adjunction — the thing arc/03 §E and arc/06 already flagged as
  the canonical cartesian↔linear bridge. So two independent lines — the project's adapter discipline and the standard LNL math — point at the same object. When the house style and the textbook
  answer coincide, that's the signal to commit.

  And it enforces exactly the separation I was most worried about (D2). The adapter is B-internal — both sides over the same actor-causal site. By localizing the cartesian/linear reconciliation as a
  named B-internal adapter, it keeps it cleanly distinct from the cross-site Allow ⊣ Require (A↔B), instead of risking the conflation arc/09's conservation law warned against. The adapter framing
  doesn't just dissolve Fork C — it protects the cross-site adjunction from being accidentally identified with its B-internal shadow.

  One refinement to your framing

  I'd recast "coexist locally, adapter globally" slightly: what's local and shared is the site (the actor-causal locality is common to both). What differs is the values — Set vs V. Both sheaf
  categories are global objects; the adapter is change-of-value-category over the fixed site. So the picture is two parallel sheaf categories on one shared locality base, bridged by the LNL adapter —
  which is exactly how the Hybrid already works (one actor-causal base, session values layered on top).

  What this sharpens into decisive, answerable decisions

  1. Name the adapter's functors — is it the Benton F ⊣ G, and does it exist? The construction obligation is concrete: a forgetful Sessions-Cat → Set and a free Set → Sessions-Cat ("underlying data
  of a session type" / "free session on a set of atoms"). Plausible, not yet built. This is the real load-bearing content of R4.
  2. Assume-then-derive, or construct? Mirror the SessionO1Action / StarAutonomous discipline: first state the adapter as an assumed LNLAdjunction record interface, derive R4 and ! from it, defer the
  canonical construction (which forces the exponential layer Sessions deliberately skipped). That's the non-rushing path.
  3. How much of the Set-side locality topos to actually build (Ω, cartesian-closed structure) vs. assume — the minimal R4 may need only the cartesian-closed core, not full Ω.

  So the revised step plan would be: build Sh(site, V) (the linear continuation), and the parallel Sh(site, Set) locality topos, then R4 = the named Cartesian↔Linear Hybrid adapter (Benton-shaped,
  interface-first). That's more total surface than "pick one," but every piece is honest, each side stays itself, and the hard work concentrates exactly where it should — in the adapter. I think
  you've found the setting.

  ❯ So if we do "build Sh(site, V) (the linear continuation), and the parallel Sh(site, Set) locality topos, then R4 = the named Cartesian↔Linear Hybrid adapter (Benton-shaped,                         
    interface-first)", does that force our hand for forks A and B?                                                                                                                                     
                                                                                                                                                                                                       
  Would we be in a position to state the adjunction after the two sites and R4 have landed?                                                                                                            
  
● Mostly yes on the forks, and a clean "not quite, but close — and here's exactly what's still missing" on the adjunction.

  Does it force Forks A and B?

  Fork B (enrichment): yes, it settles it — in the good direction. Benton's linear side must be monoidal-closed / *-autonomous (otherwise "F strong monoidal," "! a monoidal comonad" don't even
  typecheck). So committing to a Benton-shaped adapter kills the bare-1-category option and forces Sh(site,V) to carry its inherited *-autonomous structure (pointwise Day convolution). That's the
  outcome we wanted anyway — it's what preserves session duality (Care) on the V side. The one softening: interface-first lets us assume "K is *-autonomous" as a record field and defer constructing
  the Day-convolution structure, exactly as StarAutonomous/SessionO1Action are assumed-then-derived. So Fork B is decided in target, staged in build — no longer an open choice.

  Fork A (which site): softly forced, with a real residual tension worth keeping visible. The adapter is change-of-base over a fixed site, so it wants one shared site for both legs. But the two legs
  don't naturally agree on the site:
  - Sh(site,V) is honestly inhabited only over the finite-frame subsite (the bigProduct fold needs chosen finite enumerations — the whole FiniteFrame rationale);
  - Sh(site,Set) would prefer the full actor-causal site (Set has all limits, no finiteness crutch — and that's where _Topos._InternalLogic's Ω naturally lives).

  The clean v1 resolves this by building both over the finite subsite (shared base ⟹ clean adapter), with the full-site Set-topos named as the extension. So Fork A is pulled toward
  finite-common-site, not iron-forced — you could instead do an asymmetric-site comparison (a geometric morphism over C_fin ↪ C), at higher cost and a blurrier Benton picture. I'd flag this as a
  genuine, declared tension rather than pretend the finite choice is forced: Set wants the full site, the adapter wants a shared site, V is finite-only — three pulls that v1 reconciles by picking the
  finite common base.

  Net: the plan collapses the fork space — B decided, A narrowed to one choice with a flagged tension. That's a good sign (fewer arbitrary parameters = fewer places to accidentally weaken the
  framework).

  Would we then be in a position to state the adjunction?

  To state the target — yes, largely. To construct it — no, one well-defined major step short. Be precise about the gap, because this is exactly where overclaiming would bite.

  After the two sheaf categories + R4 land, we'd have K as a properly-structured B-side category (linear, with its cartesian shadow + R4 adapter as its internal logic). That clears the gate arc/09
  named — "the concurrency side matured past descent." With K concrete, we could write the cross-site adjunction's target signature: a record naming Allow/Require/η/ε/triangles + the Care involution,
  with the K-slot filled and the five anchors named at the cross-site level. That is the "state cleanly" half of T1 (targets.md), and it would be a real milestone.

  But stating the concrete Allow ⊣ Require needs two things this plan doesn't touch:

  1. M as a category. The modal side has the pieces — cohesion modalities, the generic Iteration.agda adjunction scaffold — but "the category of modal contexts" is not built as an Agda object. The
  adjunction's domain/codomain M is still missing. (targets.md's "identify the topoi the modalities live on" is precisely this, still open.)
  2. The cross-functors Allow : M → K and Require : K → M. These are the genuinely new cross-site content — and the hardest conceptual work (what are Allow and Require, concretely?). R4 builds K's
  internal structure; it does not build these. This is the D2 discipline again: the B-internal Benton adapter must stay distinct from the cross-site adjunction — they're the same shape at different
  altitudes, and conflating them is the conservation-law trap arc/09 warns against.

  Once those two land, instantiating Iteration.agda's five-anchor shape (η, ε, triangles) is comparatively mechanical — the scaffold is already generic.

  So the honest sequence is three legs, not two: (1) the two B-sheaf-categories + R4 [the proposed work — clears the B gate, makes K ready and lets us state the target with K filled]; (2) M as a
  category + the concrete Allow/Require cross-functors [the new A-side + cross-site content]; (3) instantiate the adjunction data and check the triangles [inhabit T1]. The proposed work gets us to
  the end of leg 1 — which is genuinely the gating one, and which lets us write the adjunction's interface honestly — but I'd resist any framing where "two sites + R4 ⟹ the adjunction." We'd be
  positioned to state it with the B-slot concrete and M abstract; constructing it is leg 2's job, and that's where the real cross-site mathematics still has to be done.

  ### Codex

 • I think the above conversation is basically right, and it improves the earlier “just build the sheaf category” plan in an important way.

  The key correction is Fork C: there is no single obvious _Topos._SheafCategory here. We have two legitimate layers:

  - Sh(site, Set): cartesian/locality/internal-logic side.
  - Sh(site, V): linear/session/content side.

  Trying to make either one absorb the other would weaken the framework. The adapter framing is exactly the right architectural move: keep both, then make R4 the explicit cartesian-to-linear bridge.
  That matches the existing Hybrid discipline: no hidden cast, no collapsed concerns, named adapter with laws.

  I would add three cautions.

  First, call the V-valued side a linear sheaf/value category, not a topos. The word “topos” should remain reserved for the Set-valued/cartesian side unless we explicitly prove or assume the relevant
  structure.

  Second, be careful with “Day convolution.” The immediate inherited structure is more plausibly pointwise or interface-assumed; Day convolution needs extra monoidal structure on the site and is not
  free just because V is StarAutonomous. So I’d phrase Fork B as: target a StarAutonomous / LNL-compatible structure on Sh(site,V), but stage it as an interface first.

  Third, Fork A should indeed be finite-common-site for v1. The finite site is where the V-valued witness exists. The full actor-causal Set-topos can be named as the long-term locality topos, but
  mixing finite V with full-site Set immediately would introduce a second comparison problem before R4 is even clean.

  So my refined next step would be:

  1. Build/package Sh_fin(site,V) as the linear value sheaf category.
  2. In parallel, define a minimal Sh_fin(site,Set) / cartesian locality sheaf interface, probably not a full proved topos yet.
  3. Then state R4 as a Benton-shaped LNL adapter interface between them.

  And yes: after that, we would be much better positioned to state the cross-site adjunction, but not to construct it yet. We would have made the B-side category K honest. Still missing would be M as
  an Agda category of modal contexts and the actual cross-functors Allow : M → K, Require : K → M.