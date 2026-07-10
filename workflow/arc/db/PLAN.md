# Next-pass plan — pendulum / shape integration

Settled design, ready to build **after the upcoming compaction**. Written to disk and
committed so it cannot be lost when context is compacted. Build Phase 0 before any
pendulum content, then 1 → 4.

## Locked decisions
1. **No `figure` kind.** Two grouping kinds only: `region` (unstructured set, unchanged)
   and `shape` (structured grouping). `pendulum` is a `shape`; `philosophy` and `math`
   are `shape`s that `instantiates → pendulum`. Template-vs-instance is carried by the
   `instantiates` edge, not by a separate kind. Conceptually `region` = the *trivial*
   shape (no positions, no invariant relations), so existing regions are upgradeable to
   shapes with no disruption.
2. **Equilibrium of the logic pendulum = `workilibrium-logic`** (coined term: work +
   equilibrium; gloss hard, double-quote as an image). *Work is primary*; its twin
   anchors are **"return to equilibrium"** (context side) and **"optimality of care"**
   (multiplicity side); trace / inheritance are *consequences*, not the definition. Do
   NOT reduce it to "inheritance" — inheritance-as-telos is degenerate (a parent
   optimising for the bequest is a bad parent).
3. **Logic-pendulum anchor = "the immanent context"** (the milieu that must account for
   itself, no outside judge) — fill-in / generic anchor for now. Poles fall out: left =
   "demand for form" (internal / formal logic), right = "demand for novelty" (genetic
   logic). Closure: workilibrium returns the milieu to a cared-for equilibrium, which
   *is* the next anchor (the `recontextualization` edge = the framework's core recursion).
4. **Promote AND thoroughly rewrite** `metaphysics-neighbour-diagram` → `philosophy`
   shape and `logic-neighbour-diagram` → the logic shape (retire the old unstructured
   "bags"; do not keep both).

## Perspectivalism principle (add PROMINENTLY to SCHEMA.md)
Every position a node holds inside a shape is a **reading cast from that shape's
viewpoint**, never a claim about the node-in-itself; a node's local body may carry
complexity the global shape deliberately forgets. Core commitment: contextuality / no
outside view. (This is the standing answer to "but Hegel isn't *only* the left pole.")

## Point 1 — localized complications
The Hegel node carries the *Science of Logic* "genesis-of-categories" note; the Deleuze
node carries the *Logique du Sens* "sense-surface" note — **body prose only, no edges**.
The rest of the graph sees Hegel/Deleuze only through their invariant (pole) properties.

## Phase 0 — schema foundation (do first)
- Add the perspectivalism principle (above).
- Define kind **`shape`**: a *template* shape declares its slots by having, as members,
  its **positions** (`kind: position` or `concept`) and its **invariant relations**
  (`kind: operator`); membership via frontmatter (the "set" — only "belongs to shape").
  An *instance* shape carries `shape: <template-id>` (+ an `instantiates` edge to it);
  its member nodes each carry `position: <position-id>`; its internal edges each carry an
  `instantiates: <invariant-relation-id>` frontmatter field.
- `region` unchanged (= trivial shape; upgradeable — e.g. `anchors` likely has a latent
  shape).

## Phase 1 — the `pendulum` shape
`pendulum` (kind `shape`). Positions (4): **anchor** (immanence), **left-pole**
(intelligibility / internal logic / law), **right-pole** (creativity / genetic logic /
problem), **equilibrium** (trace-practice / return-to-balance-with-care). Invariant
relations (6, `kind: operator`): **formalization** (anchor→left), **problematization**
(anchor→right), **poles-polemic** (left↔right), **verification** (left→equilibrium),
**stabilization** (right→equilibrium), **recontextualization** (equilibrium→anchor,
spawns the next pendulum). Body: describe the six edges + the equilibrium-is-orthogonal
insight.

## Phase 2 — two full instances
- `philosophy` (shape → pendulum): Spinoza (anchor), Hegel (left), Deleuze (right),
  Peirce (equilibrium). 4 position-tagged author nodes + 6 instance edges (each
  `instantiates` an invariant relation) + 4 author→position `instantiates` edges.
  Hegel/Deleuze carry the localized complications (Point 1). This is the promote+rewrite
  target of `metaphysics-neighbour-diagram`.
- `math` (shape → pendulum): Riemann (anchor), Lawvere (left), Lautman (right),
  Grothendieck (equilibrium). Same structure.

## Phase 3 — two WIP seeds (single nodes each)
- `workilibrium-logic` (substantial): equilibrium firm (= our framework, the
  equilibrium × care dyad, work primary); anchor "immanent context" tentative; poles =
  form-demand / novelty-demand. The logic shape's equilibrium; promote+rewrite target of
  `logic-neighbour-diagram`.
- `science-pendulum` (tentative / blurry): Bacon-Galileo / Newton-Einstein / Darwin /
  Peirce, explicitly provisional.

## Phase 4 — wiring + reconcile with existing graph
- `philosophy`, `math`, logic, `science-pendulum` all `instantiates → pendulum`.
- Cross-link `workilibrium-logic` ↔ existing `logic-as-contextual-transformation`,
  `recursive-context-articulation`, `anchor-care` (care pole), `noether-conservation` /
  `no-leak` (return-to-equilibrium pole).
- Retire the two neighbour-diagram bags once promoted.

## Source
Pendulum material: `workflow/arc/15_metaphysics_and_logic.md`, lines ~7592–9402.
