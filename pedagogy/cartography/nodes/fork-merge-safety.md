---
id: fork-merge-safety
label: "fork/merge safety theorem"
kind: concept
tags: [conjecture, implementation]
region: protocol-theorems
sources:
  - "workflow/arc/15_metaphysics_and_logic.md"
---

Fork/merge safety: if two inquiry branches agree on their overlap and their obligations are compatible, then their merge is well-typed and preserves the results each branch verified. It is what lets a community disagree productively — compatible divergences recombine without corrupting the trace — and categorically it is where pushouts, colimits, descent, and sheaf-like gluing enter. As a member of the [protocol-theorems] region it therefore presupposes the [esquisse-trace-mathematics], the toolkit that supplies exactly that gluing discipline.
