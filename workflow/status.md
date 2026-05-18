---
tags: [focus:cross-site, kind:state, level:scoping]
---

# Project Status

The arc is articulated in `arc.md` (the cohesive reformulation, with the `Allow ⊣ Mediate ⊣ Require` triple) and decomposed into propositions T1–T7 plus T_recursion in `targets.md`. Philosophical seed in `motivation.md`. Brainstorming archive: `deep_context/arc/`.

Bandwidth is on the Concurrency side, after a cycle of reframes that has converged: actor-causal + Caires-Pfenning hybrid (substrate) augmented by an operadic interaction-algebra layer (`O_1`), with the modular envelope `MO_1` as long-horizon target. The ModalHoTT side is paused at the de Rham named-coefficient rung with a defined return plan (S¹ + cyclic bar construction) coordinated with the B-side commitment.

## Concurrency  <!-- tags: focus:concurrency, level:scoping -->

### Where we landed

The Concurrency-side has converged after a cycle of reframes: icosahedral (A_5 / S²-equivariant) → actor-causal + Caires-Pfenning hybrid (per `deep_context/arc/concurrency_anchor.md`) → operadic interaction-algebra layer named on top of the hybrid (per `deep_context/arc/attachement_in_arc.md`). The current commitment treats the hybrid as substrate and the operadic layer as augmentation, not replacement. The B-side has *cycled*, not drifted: each reframe added structure rather than discarding the previous one.

The interaction algebra is `O_1` — the cyclic operad with one binary generator and a cyclic involution. Three structural matches with actor/session content land cleanly: one binary operation = actor's single interaction primitive (Hewitt-style); cyclic involution = session-type duality `S ↔ S^⊥` = 1=2 perspective swap; three cyclic ports = sender / receiver / channel = trinion. The free cyclic operad on this data is small and finitely presented — Agda-reachable directly.

`MO_1` (the modular envelope of `O_1`, closure under self-gluing at marked points, raises genus to produce operations at every `(g, n)`) is the long-horizon target. `O_1` is staged toward it but does not commit to it. Eventual landing: evaluation at `(0, 3)` — the universal trinion, the 3-pointed sphere where dessins / Belyi / Esquisse machinery live.

Philosophical lean: `Ass_cyc` (planar cyclic associative, ribbon-graph world) over `Com_cyc` (fully symmetric, bare M̄_{g,n}). Justification: actor send/receive is intrinsically ordered, session composition is non-commutative, dessins live in the ribbon-decorated world. Pending ratification before `O_1` Agda starts.

The cross-site picture: on the modal side, `Bℤ → S¹ → S²` goes *sideways then up* (presentation switch via `ʃ`, then suspension `Σ`). On the concurrency side, `O_1 → MO_1 → S²`-with-3-marks goes *up then sideways* (modular envelope, then evaluation). Both sides land at the same `S²`; the asymmetry between "up-then-sideways" on B and "sideways-then-up" on A mirrors T3's Lawvere asymmetry (B fluid, A rigid). The speculative identity — modal-side η-iteration ≡ concurrency-side genus-raising — sits at the *intermediate* level (S¹ ↔ `MO_1`) and is only statable once both sides develop dimension-raising machinery (cyclic bar construction at S¹ on A; modular envelope of `O_1` on B). It is downstream evidence, not motivating.

Held loose for the long horizon: a Pask-style "implementation in the human world" — collective scientific inquiry as `_Algebras` evaluated at conversation-typed concepts. Separate track, not absorbed into `O_1` scope.

### Module inventory (level-2)

Three sub-inventories, with provenance.

#### Hybrid substrate (from `deep_context/arc/concurrency_anchor.md`, scoped earlier in `status.md`'s pre-restructure "Discussion of the next step")  <!-- tags: kind:reference -->

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

#### Modular-operad version (from `deep_context/arc/attachement_in_arc.md`)  <!-- tags: kind:reference -->

Level 1: `_Operad`, `_Algebras`, `_Moduli`, `_Topos`. This is the long-horizon shape once `MO_1` is reached; included here as the eventual destination, not a current commitment.

##### `_Operad`  <!-- concept:operad -->

Cyclic operad and modular envelope.

- `_Operad._Generators` — single binary operation, planar (if Ass_cyc), 3 ports total via cyclic structure.
- `_Operad._Composition` — operadic substitution along ports.
- `_Operad._Involution` — cyclic 3-port rotation. The 1=2 perspective-swap lives here; the predicted intertwining with ℤ's `-1` action on Bℤ via the cross-site adjunction is at this slot.
- `_Operad._ModularEnvelope` — closure under self-gluing of marked points; sub-decomposition:
  - `_Operad._ModularEnvelope._GenusGrading` — the `(g, n)` filtration.
  - `_Operad._ModularEnvelope._SelfGlue` — the loop-creating composition that raises genus.
  - `_Operad._ModularEnvelope._Stability` — stability condition (no contractible components after gluing).

##### `_Algebras`  <!-- concept:algebras -->

Algebras over `M(Ass_cyc)`. Interpretive but with a four-part natural shape.

- `_Algebras._Sessions` — session-typed channels; the cyclic involution acts as `S ↔ S^⊥`. Linear logic's connectives appear as the operations.
- `_Algebras._Actors` — actor structures as algebras; unityped at the carrier level.
- `_Algebras._CutElimination` — Caires-Pfenning normalization as the algebra's term-rewriting structure; where termination / progress / no-deadlock theorems would land.
- `_Algebras._Free` — universal "protocol on no data."

Duality cross-cuts; here structurally identical to `_Operad._Involution`.

##### `_Moduli`  <!-- concept:moduli -->

Geometric realization of `_Operad._ModularEnvelope`. Forced once Ass_cyc is committed: ribbon-decorated stable-curve moduli.

- `_Moduli._Stratification` — `(g, n)` stratification.
- `_Moduli._RibbonGraphs` — Penner / Kontsevich combinatorial cell decomposition.
- `_Moduli._Dessins` — dessins inside the `(g=0, n=3)` neighborhood; the icosahedral A_5 example re-enters as one specific dessin (degree 60, monodromy A_5), not as an anchor.
- `_Moduli._GTAction` — Grothendieck-Teichmüller group acting on the tower (Drinfeld).

##### `_Topos`  <!-- concept:topos -->

Sheaves on `_Moduli`. Same four-part shape as the substrate version; topos-side structure is largely invariant under change of base.

- `_Topos._SheafCategory`.
- `_Topos._InternalLogic` — accommodates `_Algebras._Sessions`'s linear structure; `_Operad._Involution` supplies the duality the linear side needs.
- `_Topos._GeometricMorphisms` — embedding into cubical-set ambient; the cross-site adjunction with ModalHoTT lives here.
- `_Topos._InfinityLift` — same caveat as substrate.

#### `O_1` commitment (this session's proposal)  <!-- tags: kind:decision -->

Near-term Agda-bound subset that brings the operadic layer to the hybrid substrate without committing to `MO_1` machinery. The hybrid continues as substrate; the operadic layer named here is *additional structure on the hybrid*.

##### `_Operad` — `O_1` only  <!-- concept:operad -->

- `_Operad._Generators` — one binary operation. Planar if Ass_cyc (philosophical lean), symmetric if Com_cyc.
- `_Operad._Composition` — operadic substitution along ports; planar order under Ass_cyc.
- `_Operad._Involution` — cyclic 3-rotation.

`_Operad._ModularEnvelope` and everything downstream (`_Moduli`, `_Topos` updates from operadic side, `_Moduli._GTAction`) deferred to `MO_1` stage.

##### `_Algebras` — over `O_1` only  <!-- concept:algebras -->

- `_Algebras._Free` — universal cyclic-operad algebra on no data.
- `_Algebras._Sessions` — session-typed channels; `_Operad._Involution` instantiates as `S ↔ S^⊥`.
- `_Algebras._Actors` — actor carriers, unityped.

`_Algebras._CutElimination` deferred — full Caires-Pfenning dynamics is post-`MO_1`.

##### Integration with hybrid  <!-- concept:integration -->

- `_Algebras._Sessions` evaluates into the value category `V` of the hybrid's `_Sheaf` (R1).
- `_Algebras._Actors` instantiates over the hybrid's `_Site._Category` (actor-causal site).
- `_Operad._Involution ↔` session-type duality cross-cuts the existing `_Algebra._SyntacticCategory` (R8).

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
- **R7 — Algebra-over-Operad.** `_Algebras` evaluates `_Operad`. The target category determines whether `_Algebras._Sessions` has the right shape to host session-type duality. Closely interacts with R1 (the value category for both must agree).
- **R8 — Involution-Duality.** `_Operad._Involution ↔` session-type duality at `_Algebras._Sessions`. Forces the involution structure to intertwine with linear-logic negation across the operadic and substrate layers.

**Most load-bearing now:** R1 (Valuation) and R4 (Interpretation). R1 because nothing type-checks without `V`; R4 because the cartesian-vs-linear gap is the conceptual hinge. R7 inherits R1's urgency on the operadic side.

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

The substrate is the actor-causal + session-type-values hybrid: a Grothendieck site of actor-causal frames (GR-inspired actor model, Lamport partial-order proposal at `_Site._Category`), with Caires-Pfenning session-type structures as the natural values (sheaves) on it (canonical source: `deep_context/arc/concurrency_anchor.md`). Separation of concerns is structural (modularity = sheaf-gluing); typed data lives in the values, unityped agents in the base topology.

The interaction algebra layered on top is `O_1` (cyclic operad with one binary generator + cyclic involution) — see "Where we landed." The hybrid is what `O_1`'s algebras live over.

Analytic-side mirror is future work; whether the `agda/Analytic/` pattern from ModalHoTT transfers depends on the Concurrency-side base implementation.

## Decisions Log  <!-- tags: kind:decision -->

(Previous ModalHoTT-side decisions archived to `deep_context/archived_decision_logs/2026-05-17.md`.)

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-05-17 | Operadic interaction-algebra layer named on top of hybrid (augmentation, not replacement) | Names what `concurrency_anchor.md` was reaching for; preserves the hybrid scoping intact |
| 2026-05-17 | `O_1` (cyclic operad with one binary op + cyclic involution) as the current commitment | Smallest operadic structure that names the actor/session interaction; finitely presented, Agda-reachable |
| 2026-05-17 | `MO_1` (modular envelope) as long-horizon target, not current commitment | Staged rather than committed-and-collapsed; allows incremental validation of the operadic framing |
| 2026-05-17 | Philosophical lean: `Ass_cyc` over `Com_cyc` | Actor send/receive is ordered, session composition non-commutative, dessins live in ribbon-decorated world. Pending ratification before `O_1` Agda starts |
| 2026-05-17 | A-side return plan: lift `Bℤ → S¹`, switch η-iteration → cyclic bar | Cross-site identity (`S¹ ↔ MO_1`) is only statable when both sides have dimension-raising machinery; cyclic bar pairs with `Ass_cyc` |
| 2026-05-17 | Differential cohesion rung elevated to load-bearing for the cross-site bridge | `M̄`'s natural infinitesimal structure needs an A-side infinitesimal layer to talk to; see `targets.md` T3 refinement |
| 2026-05-17 | `Ass_cyc` ratified (was philosophical lean; now committed) | Actor send/receive is ordered, session composition non-commutative, dessins live in ribbon-decorated world, 1=2 reads as cyclic-of-three not symmetric. Closes plain-bar option on A; commits `MO_1` to ribbon-decorated `M̄` |
| 2026-05-17 | R7 target = parameterized `*`-autonomous record (polycategory co-equal, flagged in header) | Minimum that hosts session-type duality natively; doesn't pre-empt `(∞,1)`-enrichment or cohesion. Implementation in future `Concurrency/Algebras/StarAutonomous.agda` |
| 2026-05-17 | Concurrency-side three-file staging: `Ports.agda` → `RawCyclicOperad.agda` → `CyclicAssociative.agda` | File names earn their semantics. Port arithmetic is the combinatorial substrate (not utility); raw cyclic operad ships without associativity; the named file carries associativity + equivariance. Codex framing |
| 2026-05-17 | Cyclic action named `rot` / `rotate-equiv`, never `involution` | Cyclic rotation has order `n+1`, not order 2; session duality is the involutive structure (order 2) and lives on the algebra side. Discipline enforced at naming time |
| 2026-05-18 | `compₒ` arity convention switched from `O (m + n ∸ 1)` to positive-only `O (suc (l + r))` (inputs `O (suc l)`, `O (suc r)`) | The port-gluing iso `Port (m + n ∸ 1) ≃ (Port m ─ {i}) ⊎ (Port n ─ {j})` is non-total at `m = n = 0` (`Fin 1 ≄ ∅ ⊎ ∅`). Positive-only inputs make the iso total without preconditions; no expressiveness loss (generator set has no nullary ops, reachable arities unchanged) |
| 2026-05-18 | Port-gluing convention: cyclic-equivariant β (`delete-port i k = i +ₘ fsuc k`), not linear punch-in α | β anchors the renumbering to the deleted port, making per-operand cyclic action commute with delete-and-renumber by construction. α uses `<` order on `Fin`, breaking cyclic equivariance and forcing `rot-compₒ` to absorb the discrepancy. Cost: punch lemmas written from scratch rather than reused from stdlib |
| 2026-05-18 | Glue API: equivalence + derived functions, no record wrapper | `port-gluing-equiv : (i j) → Port (suc (l+r)) ≃ Fin (suc l) ⊎ Fin (suc r)` exposed; `port-glue = equivFun`, `port-split = invEq` derived. Matches `feedback_postulates_over_records` (record wrappers reserved for parameter signatures, not gap-filling) |
| 2026-05-18 | `CyclicAssociative.agda` shape: HIT-by-copy of `RawCyclicOperad`'s constructors, plus three new path constructors for the laws | The cyclic *associative* operad's laws are part of the type, not theorems added after the fact. `RawCyclicOperad.agda` becomes the "without-laws" reference; downstream files import `CyclicAssociative.O`. Quotient alternative ruled out (every function would have to respect the quotient — heavier to use) |
| 2026-05-18 | `rot-compₒ` formulated as the **boundary-rotation operand-swap** form: `rot (boundary-rot l r) (compₒ i j a b) ≡ compₒ j i b a` (PathP over `+-comm l r`) | Cleanest possible RHS — no port reindexing at all. Makes the "1=2 perspective swap" (R8) literal at the boundary case: rotating past `a`'s contribution *is* the operand swap. **Caveat (per Codex):** this is **not** the standard MSS unit-rotation form, and the prior framing "general `rot k` derives by `rot-compose` induction" was an overclaim. `rot-compose` composes rotations of the same operation; it does not decompose a composite's rotation into operand-rotations. Whether boundary-swap is the whole cyclic compatibility for this presentation (alternative-presentation reading) or an incomplete case of full cyclic equivariance (incomplete-stand-in reading) is the open question flagged in "Discussion of the next step" |
| 2026-05-18 | Full port bookkeeping (gluing iso + reindexing families for laws) lives in new sibling `Concurrency/Operads/PortGluing.agda` | `Ports.agda` stays minimal (Port type, cyclic-group arithmetic); `PortGluing.agda` owns the heavier combinatorics. Sibling file, not subdirectory (`feedback_analytic_folder_structure`) |

## Blockers  <!-- tags: kind:state -->

(Previous Open Questions archived to `deep_context/archived_blockers/2026-05-17.md`. Deferred items migrated to `future_work.md`.)

Concurrency: none active. First B-side artifacts shipped; `PortGluing.agda` + `CyclicAssociative.agda` in progress this session (see "Discussion of the next step" → "State at session start (2026-05-18)").
ModalHoTT: none active (paused).

## Assessment of the situation - Claude  <!-- tags: kind:state -->

(Prior session-end snapshot, design-call resolutions, and now-superseded planning archived to `deep_context/archived_status_2026-05-18.md`.)

### State at session end (2026-05-18)

What's shipped to `agda/Concurrency/Operads/` (all four files type-check clean under `--cubical --guardedness`):

| File | Role | Line count |
|------|------|-----------:|
| `Ports.agda` | Minimal port type + cyclic-group arithmetic re-exports | ~60 |
| `RawCyclicOperad.agda` | Positive-only `compₒ` HIT without laws; reference / pedagogy stepping-stone | ~165 |
| `PortGluing.agda` | β `delete-port`, `port-gluing-equiv` via library `Fin+≅Fin⊎Fin`, reindexing functions (`a-port-after-inner-glue`, `b-port-after-inner-glue`, `boundary-rot`) | ~140 |
| `CyclicAssociative.agda` | HIT-by-copy + three path constructors: `compₒ-assoc-seq`, `compₒ-assoc-par`, `rot-compₒ` | ~180 |

Architectural decisions ratified this session are in `## Decisions Log` (rows dated 2026-05-18). Conventions established this session live in the source-file headers, not duplicated here.

### Open question — resolve before any algebras work

`rot-compₒ` is implemented as the **boundary-rotation operand-swap** form:

```
rot (boundary-rot l r) (compₒ i j a b) ≡ compₒ j i b a    -- PathP over +-comm l r
```

The prior framing — that the standard unit-rotation Markl–Shnider–Stasheff form derives from this by `rot-compose` induction — was an overclaim. `rot-compose` composes rotations of the *same* operation; it does not decompose a composite's rotation into operand-rotations. The interaction is non-trivial because of arity-PathP transport.

Two readings of the present law:

- **(I) Alternative-presentation reading.** Boundary-swap is the whole cyclic compatibility law in the arbitrary-port-gluing presentation. Document it as such; no further constructors needed.
- **(II) Incomplete-stand-in reading.** Boundary-swap is one case of full cyclic equivariance; the general statement needs additional constructors or derived lemmas.

Either is mathematically respectable, but algebra-side commitments depend on which. `Concurrency/Algebras/Sessions.agda` (R8) maps the cyclic action to session-type duality `S ↔ S^⊥`: if the operad only commits to boundary-swap, the algebra only commits to "swap arguments dualizes both"; if full cyclic equivariance, the algebra commits to a richer compatibility.

**To resolve.** Mathematical check (likely with Codex, against Markl–Shnider–Stasheff §5.2 or Getzler–Kapranov): is (I) or (II) the right reading? If (I), document and move on. If (II), enumerate what's missing and add to `CyclicAssociative.agda`.

This question is a **soft block** for `OperadAlgebra.agda` and `Sessions.agda`, not for `StarAutonomous.agda` (the next file — parameter signature only, written either way).

### Next file

`Concurrency/Algebras/StarAutonomous.agda` — R7's target-category parameter record. `*`-autonomous structure with polycategorical co-equal flagged in header. Encode as a record (parameter signature, not gap-filling postulate; correct per `feedback_postulates_over_records`). Estimated 50–100 lines.

### After Sessions.agda

1. **`Concurrency/Algebras/OperadAlgebra.agda`** — algebras over the cyclic associative operad, parameterized over a `StarAutonomous` target. Where the rot-compₒ question above starts to bite.
2. **`Concurrency/Algebras/Sessions.agda`** — instantiate the target as Caires–Pfenning's session-type syntactic category; R8 (Involution-Duality) lands here.
3. **Hybrid integration** — actor-causal site (R6) and sheaf valuation (R1) follow once `_Algebras._Sessions` has the right shape. Known shape, well-mapped, not started.
4. **A-side return plan** (lift `Bℤ → S¹`, switch η-iteration → cyclic bar) — on hold until the B-side reaches a point where the cross-site adjunction `Allow ⊣ Require` is statable. Downstream of `OperadAlgebra.agda` at the earliest.

### Held-loose long-horizon items (no near-term action)

- **Pask-style human-implementation layer** — conversation-as-operadic-composition. Speculative until `MO_1` makes "conversation creates conversation" a literal operadic operation. Held in motivation only.
- **Pedagogy companions** — `pedagogy/Concurrency/Operads/` mirrors for the four files just shipped. Not started; lives in the pedagogy track (memory `pedagogy_project`).

## Discussion of the next step

### Claude

● My recommendation: resolve the rot-compₒ question first, then StarAutonomous.agda.

The status.md plan says "StarAutonomous is next; rot-compₒ is a soft block on the algebras, not on the parameter record." That's true — they're independent. But I'd flip the order anyway.

Why settle rot-compₒ first. It's the only real unknown in the operad layer. If boundary-swap turns out to be (II) the incomplete-stand-in reading, we'll need to add constructors to
CyclicAssociative.agda. Writing StarAutonomous → OperadAlgebra → Sessions first and only then discovering the operad is missing constructors means redoing algebra commitments. Cost of settling now:
maybe 1–3 Codex rounds + small edits to CyclicAssociative.agda. Cost of settling later: potential refactor across 3 files. The asymmetry favors front-loading.

How. Two complementary moves:
- Math (with Codex): work through MSS §5.2 / Getzler-Kapranov §2 specifically on cyclic-operad presentations without a distinguished output port. The question is whether boundary-rotation
operand-swap generates the full cyclic-equivariance content via the existing constructors (rot-compose, the assoc laws, the operand-swap) — or whether non-boundary rotations of composites carry
genuinely new content.
- Code probe: try to prove a small witness — e.g., rot (fsuc fzero) (compₒ fzero fzero gen gen) in some canonical form, derived from the existing constructors. If the boundary-swap form is
computationally sufficient, this should be derivable. If we get stuck, that's evidence for (II).

Probably an hour of work end-to-end. Outcome: either documentation update only (if I), or 1–2 new path constructors (if II).

Then StarAutonomous.agda. Once rot-compₒ is settled, the parameter record is well-scoped: *-autonomous structure + monoidal unit + duality (_^⊥) + the Sessions.agda-side flag that R8 will
instantiate against the cyclic action. ~50–100 lines, mostly record fields.

Explicitly NOT recommended for next session:
- Pedagogy companions — no math riding on them.
- A-side cross-site work (cyclic bar construction) — still downstream of OperadAlgebra.agda.
- Witness-only work on the existing files beyond what's needed to probe rot-compₒ.

One smaller thing worth flagging. The R7 decision ("*-autonomous as parameter record") was ratified before we'd looked at how Caires-Pfenning actually presents its syntactic category. When we get
to Sessions.agda (likely 2 sessions out), we may discover that polycategorical fits better than *-autonomous. The decision is "parameter shape committed, concrete target deferred," which gives us
room — but it's worth keeping in mind that the record fields might need adjustment when concretization happens.

### Codex

• I agree with Claude’s ordering: settle rot-compₒ before StarAutonomous.agda.

But I would improve the proposed next session in one way: don’t rely too much on the “small witness” probe. For gen ∘ gen, the boundary rotation is especially degenerate because both operands are
gen; the swap may collapse to something uninformative. Also, in a HIT with set truncation, there is no real canonical-normal-form computation unless you build an eliminator/model that exposes one.

A better probe is:

1. State the desired unit-rotation law as a type, without adding it as a constructor.
2. Try to prove it from the current constructors.
3. If that proof needs a new axiom exactly where expected, add the missing constructor rather than forcing it.

The key question should be phrased like this:

> Does boundary-rotation operand-swap plus rot-compose imply the usual adjacent/unit cyclic equivariance for arbitrary composites, or does it only identify the composite after rotating past the
> whole left block?

My suspicion: boundary-swap is elegant but probably not enough by itself. rot-compose lets you combine rotations once you already know how rotation acts; it does not explain how a one-step rotation
crosses or stays inside the left/right surviving-port blocks. So I would expect at least one additional “rotation inside a block” compatibility law, or a unit-rotation cyclic axiom from which
boundary-swap becomes derived.

So next session should probably be:

- Clean docs first: remove stale “unit-rotation” claims if the implementation currently uses boundary rotation.
- Formalize the target unit-rotation/adjacent-rotation law as a commented type or private attempted lemma.
- Decide whether to replace rot-compₒ, add to it, or explicitly document boundary-swap as the chosen presentation.
- Only then move to StarAutonomous.agda.

On StarAutonomous.agda, I agree with the caution. Keep it thin and parameteric. Don’t overcommit to full Caires-Pfenning syntax yet. A minimal multiplicative star-autonomous record is enough for
the next layer; polycategory should stay named as the serious alternative, not quietly forgotten.

So my recommendation matches Claude’s direction, but with a sharper warning: the code probe should be a law-shape probe, not a gen ∘ gen example. The latter may pass or fail for the wrong reasons.

### Claude

● Convergence

1. Ordering: rot-compₒ first, then StarAutonomous.agda. Both agree, same reasoning.
2. StarAutonomous.agda shape: thin parametric record, polycategory named as the serious alternative — Codex sharpens to "minimal multiplicative star-autonomous" (⊗, ⅋, units, duality), not
multiplicative-additive. I accept; the additive part is downstream content and can be added later if Sessions.agda needs it.
3. The question is real and needs resolution before any algebras code.

Tensions to resolve next session

1. Probe method — I withdraw mine, Codex's is right.

1. I suggested concrete-witness probes (rot (fsuc fzero) (compₒ fzero fzero gen gen)). Codex correctly points out this is doubly wrong: (a) gen ∘ gen is symmetric, so the swap collapses to
something uninformative; (b) HITs with set-truncation have no canonical-normal-form computation, so even non-degenerate concrete instances wouldn't give us a clean answer.

1. Codex's protocol — state the unit-rotation law as a type, try to prove it from the current constructors, watch where the proof gets stuck — is the right tool. The stuck-point IS the diagnostic:
if it's stuck at something rot-compose can't bridge, that's evidence the law needs to be added (or replace boundary-swap).

1. No remaining tension here — fully ceded to Codex.
2. Codex's prediction vs. my agnosticism.

2. I framed (I) alternative-presentation and (II) incomplete-stand-in as both mathematically respectable, no thumb on the scale. Codex puts the thumb on (II): expects boundary-swap is NOT
sufficient, and predicts the missing piece is either a "rotation-stays-in-a-block" compatibility law or a unit-rotation axiom from which boundary-swap derives.

2. Codex's reasoning matches my own when I tried to derive unit-rotation: rot (fsuc fzero) = rot (boundary-rot l r +ₘ -(l, _)) gives a circular reduction (rot of a rot of a composite) rather than a
closed-form decomposition into operand rotations. The PathP transport over +-comm is the obstruction.

2. This is a real prediction to test, not a settled fact. Worth recording: Codex bets (II), I'm agnostic, the next session's attempted-proof probe will likely settle it. If (II) lands, we choose
between three resolution paths (replace boundary-swap with unit-rotation as primitive and derive the swap; add unit-rotation as a sibling constructor; or — least likely if (II) is right — accept
boundary-swap as the chosen presentation with a documented gap).
3. What "settling" looks like.

3. Codex gives a sharper workflow than I did:
- Stale "unit-rotation" claims cleaned from docs. ✓ (This session.)
- Formalize the target unit-rotation / adjacent-rotation law as a commented type or private attempted lemma in CyclicAssociative.agda.
- Run the attempt; observe stuck-point.
- Decide between: replace rot-compₒ with unit-rotation (boundary-swap becomes derived), add unit-rotation alongside as a sibling constructor, or accept boundary-swap as the chosen presentation.

No tension on workflow, but worth recording it explicitly in the next-step section so the next-session agent has the protocol clear from the start.

### Codex

• That convergence looks right.

My concluding recommendation is:

1. Treat rot-compₒ as the only remaining operad-layer uncertainty.
2. Do not write algebra files until that uncertainty is resolved.
3. In the next session, formalize the desired adjacent/unit-rotation law as a target type and attempt the derivation from current constructors.
4. If it gets stuck in the predicted way, prefer replacing boundary-swap with the unit/adjacent cyclic axiom as primitive, then derive boundary-swap later.

My bias is against keeping both laws as primitive unless necessary. Two primitive cyclic-compatibility constructors risk over-presenting the operad: you may silently impose a stronger quotient than
intended. The cleaner mathematical shape is usually:

one primitive cyclic equivariance axiom
boundary-swap derived from it
generic rotation compatibility derived from rot-compose

Boundary-swap is beautiful as a theorem. I am less confident it is enough as the axiom.

For StarAutonomous.agda, the right next shape is minimal multiplicative star-autonomous: tensor, par, units, duality, and the duality/tensor-par interaction. No additives, no exponentials, no
session syntax yet. Also keep the polycategory alternative named in the header, because that may become the more natural home once Caires-Pfenning is concretized.

So the next-session heading should basically be:

> Resolve cyclic equivariance presentation before R7 algebras.

That is the responsible checkpoint. The project is now past “scaffolding”; this is the point where a wrong operad presentation would propagate.