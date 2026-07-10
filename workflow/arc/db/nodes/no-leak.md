---
id: no-leak
label: "no-leak (unityping realised as a theorem)"
kind: concept
tags: [conjecture, implementation]
sources:
  - "workflow/arc/12_correspondence_math_runtime.md"
  - "workflow/arc/10_provenance_audit_layer.md"
---

The framework's structural privacy guarantee, and the positive content behind the phrase "audit artifacts, never actors": the claim that the identity of an inquirer cannot leak across the runtime boundary, because that boundary is renaming-invariant. Formalised, renaming-invariance is univalence at the runtime boundary — equivalent actors are equal — which turns "unityping" from a stipulation into a theorem: no observation can distinguish two inquirers except through their typed contributions. We take it from `workflow/arc/12_correspondence_math_runtime.md` (its correspondence/realization discussion), with the provenance side in `workflow/arc/10_provenance_audit_layer.md`. "No-leak" is our plain-English image for the against-the-grain property that the trace records what was done without exposing who — by construction rather than by policy.
