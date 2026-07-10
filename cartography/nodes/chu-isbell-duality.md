---
id: chu-isbell-duality
label: "bulk/boundary as Isbell–Gelfand duality (Chu construction)"
kind: concept
tags: [conjecture, implementation]
sources:
  - "workflow/arc/11_reality.md"
  - "Isbell / Gelfand duality; Connes, noncommutative geometry; Chu construction"
  - "codebase: Chu.agda, SessionChuModel.agda"
---

The resolution of the framework's bulk/boundary problem as a duality: Isbell / Gelfand duality — with the Connes noncommutative face — between a space and its algebra of functions, realised concretely as a Chu construction with "reality-points" on one side, "documentation-states" on the other, paired by a lossy evaluation into a dualising object k. This is explicitly *not* a holographic identification of bulk with boundary; it is a duality *with loss*, which is exactly why documentation can chart reality without enclosing it. Taken from `workflow/arc/11_reality.md`, where it also carries the open conjecture that the outer dualising object k might coincide with an inner session-orthogonality; the codebase holds it as the Chu and session-Chu models.
