---
id: actor-coordinates-as-gauge-choice
label: "actor numbering as a choice of coordinates"
kind: concept
tags: [conjecture, implementation]
sources:
  - "formal/RuntimeContract/Trace.agda (dense first-appearance numbering)"
  - "formal/RuntimeContract/ActorRenaming.agda"
---

The reading under which the numbers a record assigns to its participants are presentation data rather than content: the assignments form a family related by relabelling, one is picked by convention, and nothing the checker can see depends on which. The serialization tool numbers actors densely by order of first appearance, and this is exactly a gauge fixing — a canonical representative chosen from a family of equivalent presentations. The load-bearing evidence is an absence: the checker has no clause requiring dense numbering, and it could not have one, since transposing two actors sends the list `[0,1]` to `[5,1]` and would break invariance even for reversible relabellings. So the missing clause is a precondition of [equality-pattern-blindness], not an oversight. The physics vocabulary is borrowed only for the redundancy-of-presentation part: there is no connection, no curvature, and — the one that bites — no local gauge group, since the relabelling here is one global choice per record rather than one per region. `workflow/bias_correction.md` rules out the stronger reading explicitly. That canonicalisation picks exactly one representative per orbit is plausible and unproved.
