# Prehistory — archived, not load-bearing

**This folder is kept for historical purposes only. Nothing in it should be taken seriously as mathematics or as a source for current work.**

It records an early, pre-Hoapa line of thought in which twelve philosophical concepts were assigned to the twelve vertices of an icosahedron and given a dynamics (USE / TARGET / ALIGN at graph distances 1 / 2 / 3, two hexagonal "self" and "environment" flows, three transversal quartets, a gauge-analysis layer, and a transfer-operator computation). The line of thought is **not** considered to have succeeded, and it does not inform `workflow/arc/16_*.md` or any live workflow file.

Its only durable descendant is the *form* of the icosahedron, not its content: the A5 representation theory and the dessin/Belyi framing used in arc/16 stand on their own and do not depend on anything here. See `workflow/related_structures.md` § *A5 / icosahedral symmetry* for the current, gated status.

## Verified errors, so they are not inherited

A machine audit of the combinatorial claims (2026-09-03) found the structural core sound but three stated claims false. They are recorded here only so that a future reader does not pick them up:

- **"Each half forms a 6-cycle with all cross-edges connecting the two sets."** False. The two hexagonal flows are genuine 6-cycles, but each half induces 9 edges, and 18 of the 30 edges are intra-half.
- **"No edge connects two vertices within the same quartet; all 30 edges run between quartets, 10 per pair."** False. Each quartet contains exactly 2 edges (its golden rectangle's short sides): 6 intra-quartet, 24 inter, 8 per pair.
- **"Emergence / Becoming / Encounter is *the* golden-rectangle decomposition."** False. There are exactly 5 partitions into three *mutually orthogonal* golden rectangles (the P1–P5 list elsewhere in the folder is correct). Each of the three named quartets is individually a golden rectangle, but they are drawn from three different orthogonal partitions, so the triple is not one of the 5. Its stabiliser in A5 has order 6, where all five canonical partitions have order 12.

What did check out: the graph is the icosahedral graph; `D₁(anti V) = D₂(V)`; the 1+2+2 transition pattern; exactly 2 intermediaries per distance-2 pair; the sum rule `θ₁ + θ₂ = θ₃`; and the Stage-1 transfer operator reproduces exactly (`s* = 0.975992`, uniform Gibbs measure on all 60 states, 17 chiral pairs). The Stage-2 specification was never run; as written it fails its own §3.4 sanity check (spectral radius 1.1406 rather than 1.0, from double-counting at the metabolic vertices), and with that fixed its differentiation predictions do not hold.

The negative result is the useful part: the icosahedron's vertex-transitivity forces the uniformity that the framework hoped to see broken.
