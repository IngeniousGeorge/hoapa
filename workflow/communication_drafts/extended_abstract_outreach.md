# Extended abstract outreach — retained drafts and discussion

**Relocated 2026-10-09** from `workflow/future_work.md` at `6551018`.
These are historical draft messages and their review, not approved outgoing
correspondence or current project-state claims. No message is sent by this move.
Reconcile any future use with the live workflows and the instigator's intent.

## Emails for extended abstract

2. Email Plan

  I’d write 3 core emails, with a possible 4th if we have a very specific target.

  Audience A: Formalization / Cubical Agda / proof assistant people

  Angle:
  “This is a modest theorem, but a checked integration of Chu, Benton LNL, finite sheaf/descent, and cubical Agda infrastructure.”

  Topics:

  - postulate-free Chu coefficient model;
  - Benton LNL interface;
  - event-local sheafification;
  - why Cubical Agda matters.

  Ask:
  “Does this look like reusable formalization infrastructure, and is there a natural venue/community for it?”

  Response strategy:
  Make the ask concrete: not “is Hoapa interesting?” but “is this formalization package legible/useful?”

  Audience B: Categorical logic / linear logic / LNL people

  Angle:
  “We have a small checked Benton-style sheaf lift, with a concrete Chu coefficient instance.”

  Topics:

  - LNL adjunction lifted to event-local sheaves;
  - Set ↔ Chu(Set,Bool);
  - resource-sensitive coefficients vs cartesian locality;
  - limitations explicitly stated.

  Ask:
  “Is the formulation mathematically honest, and are the hypotheses the right ones?”

  Topics:

  - actor-causal site;
  - site/fiber separation;
  - event-local descent;
  - path toward richer causal descent and operational session semantics.

  Ask:
  “Does this site/fiber framing look like a useful categorical model of interaction, and what next theorem would make it compelling?”

  Response strategy:
  Aim for strategic feedback, not acceptance. They care about payoff.

  Optional Audience D: HoTT / foundations / modal type theory

  Angle:
  “This is the first operational fragment of a larger modal/cohesive architecture.”

  - the theorem as the K side;
  - eventual M ↔ K adjunction;
  - cubical/funext relevance;
  - future mode-theoretic presentation.

  Ask:
  “Is the foundational Outlook coherent, or does it overstate what the checked theorem supports?”

  Response strategy:
  This email should be the most cautious. It risks sounding grand unless the modest theorem is foregrounded first.

  General Email Dynamics

  Each email should be short:

  - one sentence of context;
  - one paragraph stating the theorem;
  - one paragraph saying why we’re contacting them specifically;
  - one concrete question;
  - links to PDF, repo, and theorem entry file.

  The key tactic is to ask for a bounded judgment, not general approval. People answer specific questions; they ignore “what do you think of my framework?”

  • The plan is basically sound, but it needs one correction and one sharpening.

  First correction: the excerpt has a structural omission. Audience C is missing its header. The block beginning with:

  > actor-causal site; site/fiber separation; event-local descent...

  is clearly Audience C: Applied category theory / categorical concurrency. That needs to be restored, otherwise the plan jumps from B directly into topics without an angle.

  Second correction: for emails, I would now use site/coefficient separation, not site/fiber separation, because we deliberately chose that vocabulary in the abstract. “Fiber” is
  mathematically suggestive, but it is not introduced.

  The general strategy is right: each audience gets a bounded ask, not a plea for validation. That is the most important thing. The recipient should know exactly what kind of reply
  would help.

  My assessment by audience:

  A. Formalization / Cubical Agda
  Strongest near-term email. This is where the work has the clearest concrete value. The ask should be about reusable infrastructure, proof style, and whether the Cubical Agda
  packaging is legible. This is likely the best first batch.

  B. Categorical Logic / Linear Logic / LNL
  Useful, but should be humble. A specialist may find the theorem unsurprising, so the email should explicitly say “modest checked fragment” and ask whether the statement/hypotheses
  are clean. Do not lead with novelty here.

  C. ACT / Categorical Concurrency
  Potentially the most conceptually aligned, but also the most demanding. They will care less that the assembly typechecks and more whether the actor-causal site and site/coefficient
  separation pay off. The right ask is exactly: what next theorem would make this compelling?

  D. HoTT / Foundations / Modal Type Theory
  Highest risk, highest ceiling. The Outlook may interest them, but it can sound overextended. This should probably go only to people likely to tolerate speculative architecture, and
  the email must foreground the checked theorem before mentioning M ↔ K.

  One adjustment: I would not include all three links in every email if it makes the message look bulky. Use:

  - PDF attached;
  - repo link;
  - one “entry module” link only if the audience is formalization or technically likely to click code.

  Suggested send order:

  1. Formalization people first.
  2. Categorical logic/LNL second.
  3. ACT/concurrency third, after seeing if the first replies surface issues.
  4. HoTT/foundations last, and selectively.

  The exchange is good overall. It gives us a disciplined outreach strategy: different audiences, different value proposition, one bounded question each.
