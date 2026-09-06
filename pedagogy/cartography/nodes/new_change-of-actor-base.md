---
id: change-of-actor-base
label: "change of actor base (comparing structures over different name carriers)"
kind: concept
tags: [implementation]
sources:
  - "formal/Concurrency/Sites/ActorCausal.agda"
  - "formal/RuntimeContract/Realization/CausalFromParents.agda"
---

The missing infrastructure that the next rung of [no-leak] runs into, and a concrete instance of a general discipline: a comparison between two structures is only statable once their carriers are allowed to differ. Interpreting a record into the actor-causal substrate builds a participant carrier out of that record's own declared participants, so relabelling the record yields a carrier of a genuinely different type; but the substrate fixes one carrier for all its structures and gives its morphisms no participant component at all, quantifying over the same participant on both sides. The comparison therefore cannot currently be written down — not merely hard, but inexpressible. This is the concrete difficulty that earns [actor-presentation-category] rather than a generality reached for in advance, and the intended repair is a relative morphism sitting over a map of carriers, leaving the existing morphism as its special case at the identity so that landed results stay untouched.
