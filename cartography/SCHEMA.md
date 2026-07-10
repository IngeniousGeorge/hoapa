# Hoapa framework graph — schema & conventions

## What this is
A knowledge graph of the Hoapa framework — the conjecture, its formalization, and
the codebase-as-practice, held as **one object seen under three perspectives**.
Stored as a *document graph*: one Markdown file per node, one per edge, one per
region. It is designed to grow organically, one file at a time, so that parallel
sessions never collide on the same record.

## Perspectives, not partitions
`conjecture`, `implementation`, `practice` are **tags** — a perspectival cover in
the sense of Abramsky's sheaf-theoretic contextuality — not folders. A node may
carry several. The whole graph is one object; the question "is the machinery
harmonious?" becomes "do the local (tagged) sections glue into a global section,
or is there an obstruction?"

## Positions are readings, not properties
A structural role a node holds — most sharply, a **position inside a shape** (below)
— is a **reading cast from that shape's viewpoint**, never a claim about the
node-in-itself. "Hegel at the left pole" means "read through the philosophy
pendulum, this figure sits at left", not "Hegel = left pole" simpliciter; the
node's own body may carry complexity the shape deliberately forgets. This is the
same no-outside-view / contextuality commitment as *perspectives, not partitions*,
applied one level up. Mechanically it is enforced by scoping: a position field is
only meaningful **paired** with the `shape` it belongs to, and reading-nodes are
namespaced to their shape (`philosophy-hegel`, `science-peirce`) so the same figure
can be read differently by two shapes without contradiction.

## Technology
Authoring format: Markdown + YAML frontmatter (prose-first, git-friendly,
tool-agnostic). Each edge file is a reified triple `source —type→ target` plus a
prose gloss, so the store projects directly to RDF or a labelled property graph.
Intended exploration/query layer: the Elixir ecosystem (`libgraph`, `RDF.ex`),
per T. Hammond, *Exploring Graphs with Elixir* — to be built once the graph has
enough mass to be worth querying.

## Layout
- `nodes/<id>.md`
- `edges/<source>--<type>--<target>.md`
- `regions/<id>.md`

## Node schema (frontmatter)
- `id` — kebab-case, domain-descriptive, stable (edges reference it).
- `label` — a short human-readable name (quoted).
- `kind` — one of: `concept`, `meta`, `singleton`, `region`, `constraint`, `operator`,
  `shape`, `position`.
- `tags` — subset of `{conjecture, implementation, practice}`.
- `region` — optional; the region this node belongs to.
- `shape` — optional; the owning shape id — for a template member this is the template
  shape, for an instance reading-node it is the instance shape.
- `position` — optional; for a member of an instance shape, the template position it
  fills (only meaningful paired with `shape`).
- `from` / `to` — optional; on an invariant-relation `operator` node in a template
  shape, the two position ids it connects.
- `paired` — optional (`true`); on an invariant-relation `operator`, marks it symmetric
  (`from`/`to` name the two sides, order not load-bearing). Realised by a single
  `realizes` edge carrying `paired: true`, read as symmetric — mirroring the `(paired)`
  edge-types. Directed-only tooling must treat such edges as undirected.
- `sources` — list: authors/works, external links, and internal file pointers.

Body: **one paragraph** defining the concept — explicit about the source, about any
modification we make to the original, and pointing to a file/section for a fuller
account. Reference other nodes by their id in `[square-brackets]`; a bracket reference
may name a node not yet written (a dangling ref, like a dangling edge — it marks work
to come) or, occasionally, an edge-type from the vocabulary below.

## Edge schema (frontmatter)
- `id` — `<source>--<type>--<target>`.
- `type` — from the vocabulary below.
- `source`, `target` — node (or region) ids.
- `relation` — optional; on a `realizes` edge, the template invariant-relation
  (`operator`) id it realises.

Body: **one solid paragraph**. The framework's usefulness and its "how/why" should
surface mostly here, in the edges, rather than in the node definitions.

## Edge-type vocabulary
Directed unless marked *(paired)*. We do not systematize every pair; we record only
load-bearing edges, each under the type most natural to it.

- `presupposes` (A→B): A cannot stand until B stands. The dependency backbone.
- `forced-by` (A→B): A exists to resolve a tension in B; the derivation/necessity edge.
- `fails-without` (A→B): remove B and A breaks (not always the inverse of presupposes).
- `adjoint-to` *(paired)*: a co-arising adjoint pairing; a load-bearing cycle.
- `dual-to` *(paired)*: related by a perspective-flip / dualising object.
- `enriches` (A→B): A adds structure, in the enriched-category sense, over B.
- `saturates` / `liberates` (A→B): Lautman's two movements — A completes B; A releases a mobile form from B.
- `discharges-into` (A→B): the borrow–work–return relation; A returns its dependency to B, carrying a conserved accounting.
- `bounds` (A→B): A limits what B can do (an impossibility or obstruction result).
- `must-not-glue-to` *(paired)*: a fenced-off, seductive-but-wrong identification.
- `translates-to` (A→B): content crosses contexts only via an explicit structure-preserving translation.
- `glues-with` *(paired)* / `descends-to` (A→B): local records composing globally under compatibility; descent and its obstruction.
- `instantiates` (A→B): A is a concrete realisation of the more abstract B.
- `fixed-point-of` (A→B): A is stabilised as a fixed point of an operation on B (bootstrap/self-reference).
- `realizes` (A→B): a **shape-internal** edge; A→B in an instance shape realises one of the
  shape template's invariant relations, named in the edge's `relation:` field (which points
  at the corresponding `operator` node). See *Shapes* below.

## Regions (semi-autonomous)
A region is a node (`kind: region`) with a `members:` list. An edge incident to the
region — with the region as its source or its target — **distributes to every
member** on that side (mutualised). An edge to (or from) an individual member is
**individualised** (an addition or override). Edges between two members are
**internal**.

## Shapes (structured regions)
A **shape** (`kind: shape`) is a region that carries internal structure: named
**positions** and named **invariant relations** between them. A plain `region` is
the *trivial* shape — no positions, no invariant relations — so every region is
upgradeable to a shape with no disruption (the `anchors` region, for instance, has
a latent shape we have not yet drawn).

A shape is used in two modes:

- **Template.** A template shape's `members:` are its slots: `position` nodes (the
  places) and `operator` nodes (the invariant relations). The template stays
  edge-free — a pure set — because each invariant-relation `operator` node already
  carries `from:` / `to:` position ids that encode the skeleton. Example: the
  `pendulum` shape has four positions and six invariant-relation operators.
- **Instance.** An instance shape carries `shape: <template-id>` and an
  `instantiates → <template>` edge. Its member reading-nodes are **namespaced to the
  instance** (`philosophy-hegel`) and each carries the paired fields
  `shape: <instance-id>` and `position: <template-position-id>` — never a bare global
  position (see *Positions are readings, not properties*). Its internal edges use
  edge-type `realizes` with a `relation: <template-operator-id>` field, so each
  concrete edge is tied back to the invariant relation it realises.

This keeps the invariant relations reified once (as `operator` nodes, with a
definitional home) while letting every instance edge stay machine-linkable to them,
and keeps the global edge-type vocabulary free of shape-specific relation names.

## Shapes vs forcing-colimits
A shape gives a domain *reading structure* (positions and invariant relations); it
does not, by itself, argue that a concept is *right*. That derivational claim is
carried separately by a **forcing-colimit** node — a diagram of established
neighbouring positions whose shared shape (colimit, "dépassement") *forces* one of
our concepts — recorded as a `forced-by` edge from the concept into that node. The
two must not be collapsed. A shape instance may be the *structured realization* of a
forcing-colimit, but promoting the colimit into a shape would silently downgrade
`forced-by` from "forced as the colimit of established positions" to "related to the
new home of the content". So when a shape realizes a colimit, **keep the colimit node
(it carries the forcing) and link the shape to it as its realization**; never
retarget the `forced-by` onto the shape. If only the *equilibrium* of a pendulum is
drawn (a seed), the `forced-by` edge stays at the colimit / whole-shape level, not on
the equilibrium node alone.

## Naming discipline
- Inherited concepts → their recognised domain name, disambiguated where polysemous
  ("A₅" → "the alternating group A₅ / icosahedral symmetry"; "E₈" → "the E₈ lattice").
- Genuinely novel central objects → described structurally; a project name
  (e.g. Allow / Require) may appear, but only ever carrying "meat" (a structural
  gloss), never as a bare token.
- Project index-jargon (numbered theses, internal codewords) → **not** used as
  identifiers; translate them to descriptions.
- Plain-English images → in "double quotes", flagged as images.
- No project-internal jargon anywhere a newcomer could not decode it.

## Growth convention
When a pair of agents (human + agent, or agent + agent) finishes a working session,
they add nodes and edges for the topics they touched, following this schema. Prefer
many small precise records over few large ones. A dangling edge — one whose target
is not yet a node — is allowed: it marks a node worth writing later, not an error.
