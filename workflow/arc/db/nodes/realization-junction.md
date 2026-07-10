---
id: realization-junction
label: "the realization junction (Realization.agda)"
kind: singleton
tags: [implementation]
sources:
  - "workflow/arc/12_correspondence_math_runtime.md"
  - "codebase: RuntimeContract/Realization.agda"
---

The point in the codebase where the two legs physically meet: a three-tier construction in which an audit table serves as a specification (tier 0), a generic Agda module instantiates the substrate carriers (tier 1), and theorems are transported across the boundary (tier 2). It is where [cross-site-adjunction] stops being a diagram and becomes running, type-checked code, and where renaming-invariance appears as univalence at the runtime boundary — the positive core of "no-leak". See `workflow/arc/12_correspondence_math_runtime.md` and the `RuntimeContract/Realization.agda` module.
