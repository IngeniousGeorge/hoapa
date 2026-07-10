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
- `kind` — one of: `concept`, `meta`, `singleton`, `region`, `constraint`, `operator`.
- `tags` — subset of `{conjecture, implementation, practice}`.
- `region` — optional; the region this node belongs to.
- `sources` — list: authors/works, external links, and internal file pointers.

Body: **one paragraph** defining the concept — explicit about the source, about any
modification we make to the original, and pointing to a file/section for a fuller
account. Reference other nodes by their id in `[square-brackets]`.

## Edge schema (frontmatter)
- `id` — `<source>--<type>--<target>`.
- `type` — from the vocabulary below.
- `source`, `target` — node (or region) ids.

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

## Regions (semi-autonomous)
A region is a node (`kind: region`) with a `members:` list. An edge incident to the
region — with the region as its source or its target — **distributes to every
member** on that side (mutualised). An edge to (or from) an individual member is
**individualised** (an addition or override). Edges between two members are
**internal**.

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
