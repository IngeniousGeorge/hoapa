---
id: equality-pattern-blindness
label: "equality-pattern blindness (the checker sees sameness, never names)"
kind: concept
tags: [conjecture, implementation]
sources:
  - "formal/RuntimeContract/ActorRenaming.agda"
  - "workflow/targets.md (T_boundary, Tier A)"
---

The proved fragment of [no-leak]: the runtime's acceptance check consults an actor identifier in exactly one way — by asking whether two of them are the same — and therefore cannot distinguish participants by their labels. Formally, relabelling every actor by any map that keeps distinct actors distinct leaves the checker's verdict unchanged, for every record including malformed ones, so a relabelling can neither rescue a bad record nor spoil a good one. Non-merging is not a stylistic hypothesis but the exact condition: a map collapsing an undeclared identifier onto a declared one launders a rejected record into acceptance, and that single failure is what the injectivity requirement rules out. We take the name from what the result actually says rather than from the tier label it carries in `workflow/targets.md`. Its value is not surprise — the checker was built with no identity-sensitive clause, so the theorem was nearly true by construction — but standing obligation: a future clause that reads who someone is would make it fail.
