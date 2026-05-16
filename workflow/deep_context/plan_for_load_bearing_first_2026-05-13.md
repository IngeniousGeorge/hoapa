# Agent plan — 2026-05-13

*Point-in-time snapshot of one Claude agent's preferred priority ordering for the project, written at the user's request after a critical-engagement turn. Archived alongside `log-2026-05-08.md`. **Not the project's plan** — the project has chosen the narrow-arc-as-beachhead path (option (c)) for reasons that include non-mathematical interdisciplinary considerations the agent does not fully share. Consult this document when re-evaluating priorities, not before. Assumes the reader has read `log-2026-05-08.md` and the then-current `status.md`.*

## What this document is

A divergence record. The project's current trajectory (narrow arc on Bℤ — fracture, de Rham, A-side internal) is locally well-justified and has the user's reasons behind it. This document proposes a different ordering, motivated by what the agent reads as the project's load-bearing risks. Two ways to use it: (a) sanity-check against the current trajectory after a milestone; (b) priority-list when the project is between phases and choosing what to do next.

## The instinct in one paragraph

The grand arc, per the 2026-05-08 log, claims the project is a finite, completable, modal-HoTT-encoded toy model of Grothendieck's program. Two pieces do the lifting: the cohesion-on-equivariant-icosahedron theorem (T2) and the adjoint triple Allow ⊣ Mediate ⊣ Require (T1). Neither is on the Agda runway. Both are at the "articulated but not formalized" stage. The current trajectory invests in A-side machinery (fracture, de Rham) that exists regardless of whether T1 and T2 hold. This plan inverts that — probe the load-bearing pieces first, build A-side machinery in support of them rather than ahead of them.

## Phase I — Probe T2

T2 is the strongest stand-alone math claim per the log: equivariant cohesion on A_5-stratified S² with explicit modal readings. If it doesn't go through (positively or with a clean obstruction), the grand arc collapses to the narrow arc. The cheapest probe of "is the grand arc reachable" is to ask whether T2 is reachable. This is B-side work — consistent with the independent-legs principle, but inverting the project's current sequencing (A-near-complete-before-B-staked).

Steps:
1. Pin the site precisely. The log left "A_5-orbit category of S²" vs "icosahedral cell complex with A_5 action" ambiguous. These are different topoi. Pick one and document why.
2. Compute the cohesive structure (if any) on the chosen site. For finite G acting cellularly, Sh_G(X) is known machinery — Disc/Codisc/global-sections triple, equivariant ʃ. The question is whether the *cohesion-flavored* triple ʃ_G ⊣ ♭_G ⊣ ♯_G has content.
3. First Agda work: encode the A_5-action on the 12-vertex set; verify transitivity, compute fixed-point sets, confirm the Lawvere-asymmetry posture (no global A_5-fixed point on 12 vertices). Small finite groups acting on finite sets compute cleanly in cubical Agda — cheap.
4. Cohesion theorem: state ʃ_G ⊣ ♭_G ⊣ ♯_G on this site and check whether (i) they exist, (ii) they're non-trivial, (iii) the readings line up with the log's "typed data / unityped agents / interaction shape" partition.

Outcomes worth landing:
- **Positive.** T2 lands. The grand-arc claim has its load-bearing math piece. The project's self-conception is earned, not just mapped.
- **Negative with clean obstruction.** Possibly more interesting than positive — a "cohesion does not lift to A_5-equivariant icosahedral S² because of X" result is publishable in cohesive HoTT and tells the project what the next move is.
- **Stuck.** The obstruction itself becomes the math fragment.

In all three, Phase I produces a real result. Compare to the narrow-arc de Rham work where a tautologous named-coefficient is one of the planned destinations.

## Phase II — T1 as a proposition

The log gave T1 rich content but stopped at sketches. Phase II converts T1 into something stateable, before formalization. Not Agda — workflow text.

Steps:
1. Decide pair vs triple. Log defaults to triple, fall back to pair if middle slot is empty. Commit, in arc_now.md.
2. Decide the ambient topos. "Containing both cohesive sub-presentations" is metaphorical; the math version is a specific construction — pasting topos, comma category, geometric morphism between sites, sheaf topos on a coproduct site. Pick one.
3. State T1 as a definite proposition: "In the topos T (defined as ...), the adjoint triple Allow ⊣ Mediate ⊣ Require exists, with the four unit/counit/triangle readings given by ...."

This is what makes Phase V (T1 in Agda) tractable later. Until T1 is a proposition with a definite ambient topos, "implementing T1" has no shape.

## Phase III — Reduce postulate density on the synthetic side

Independent of T1/T2. The synthetic-side budget is heavy enough to be doing work the proof checker should: flat-intro unconditional, ♭/♯/ʃ idempotency postulated, four map laws postulated, fracture postulated as ♯-lex shortcut, hom-set adjunctions postulated at type level, naturality postulated. Each is honestly flagged in rug.md; the aggregate weight is what concerns the agent.

Steps:
1. Dependent induction for ♯ and ʃ (currently in Open Questions). Either via switching to a proof assistant with proper modal type support (cohesive Agda's --cohesion flag, Rocq, or similar), or finding a cubical Agda workaround. The latter is unlikely; the former is a tooling decision.
2. Once dependent induction lands: derive ♯/ʃ idempotency, the four map laws — currently postulated.
3. Articulate IsFlatModal ↔ IsShapeModal bridge (Open Questions).
4. Reduce flat-intro from unconditional to crisp-only, if the tool supports crisp contexts.

Outcome: synthetic-side certifies more, postulates less. The "soundness imported by citation" footprint shrinks. Phase V (T1 in Agda) inherits a lighter postulate stack.

## Phase IV — Narrow-arc work (current trajectory)

This is what the project is doing now. Under this ordering, it comes after Phase I produces a yes/no on T2 and Phase II produces a stateable T1.

Steps roughly as currently planned: structural rung of de Rham with pinning (resolves the Open-Questions naturality-or-bridge gap), named-coefficient as documentation, differential deferred to AnalyticTest. The reason this moves to Phase IV in this plan: until T1 and T2 are probed, the narrow-arc work might be optimizing a path that becomes peripheral. If T2 lands and produces an equivariant-cohesion theorem, the de Rham separation on Bℤ is no longer the central result it currently feels like — it becomes an A-side warm-up to a B-side theorem.

## Phase V — T1 in Agda

The bridge. Requires Phases I, II, and IV completed.

Steps: construct the ambient topos (from Phase II's choice); define Allow / Mediate / Require as functors / modalities on it; derive the unit/counit/triangle data; T3 (Lawvere asymmetry), T4 (partition match), T5 (protocol-as-operational-cohesion), T6 (two-sided above) cascade.

## Decision triggers

- **After Phase I:** if T2 holds, Phase II → V is the rest of the runway. If T2 fails cleanly, the project rewrites status.md and possibly arc_now.md — the obstruction becomes the result.
- **After Phase II:** if T1's ambient topos has a definite construction, Phase V is tractable. If not (the construction is itself a research question), Phase V becomes its own multi-step phase.
- **After Phase III:** not a trigger for the next phase, but reduces background risk under any future modality extension (e.g., differential cohesion's ℜ ⊣ ℑ ⊣ &, if it comes up later).

## What this plan is worried it misses

1. **The non-mathematical interdisciplinary frame.** The user has explicitly said the math is a fragment of a broader interdisciplinary structure. This plan optimizes for the mathematical subsystem in isolation. If the project's value is genuinely interdisciplinary — and the user has said it is — then "test the mathematical conjecture first" may be the wrong objective function. The mathematical conjecture is meant to be a piece of a larger argument, and the larger argument may need infrastructure this plan deprioritizes.

2. **(c) is defensible.** Pursuing A as a beachhead while B awaits bandwidth is a defensible tactic. The risk this plan named — that A-side momentum produces results disconnected from the grand arc — is real but not certain. If A-side machinery turns out to transfer cleanly to the B-side site later, the cost of building A first is just time, not direction. The plan bets on a stronger "wrong leg" claim than the evidence strictly supports.

3. **The user's creative-process tactic.** The user explicitly described withholding 20% of expectations as a mechanism for eliciting creative friction from agents. This plan presupposes "full alignment with the project's stated aims is good" — which is precisely what the user said is not their working assumption. So this plan would, if adopted, eliminate a creative-friction surface the user values.

4. **Tool-availability assumption in Phase III.** "Switch to a proof assistant with proper modal type support" is non-trivial and may not have a clean migration path. Cubical Agda's investment in this project is substantial; deprecating it without a clear replacement would cost more than the postulate-density gain would buy.

## What this plan is not

- Not a critique of the current direction. The current direction has reasons the agent does not have full access to.
- Not a recommendation to switch tactics. The user has chosen (c) and has substantive reasons for it.
- Not a comprehensive plan. It treats the math as the project. The user has said the math is a subsystem.

It is one agent's priority ordering, archived for later reference, in case its instincts about load-bearing risk turn out to be calibrated.
