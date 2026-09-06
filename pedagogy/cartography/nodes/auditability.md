---
id: auditability
label: "auditability theorem"
kind: concept
tags: [conjecture, implementation]
region: protocol-theorems
sources:
  - "workflow/arc/15_metaphysics_and_logic.md"
---

Auditability: for every state transition of the system there exists an audit certificate explaining why that transition was allowed, so every accepted change can be replayed and independently checked. It is the "no opaque decision path" guarantee — the theorem that closes off hidden bureaucracy by making the reason for every move part of the public record. A member of the [protocol-theorems] region, it is what turns the trace from a log into something a stranger can re-derive rather than take on faith.
