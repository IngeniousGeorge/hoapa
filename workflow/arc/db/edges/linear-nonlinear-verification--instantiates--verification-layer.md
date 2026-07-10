---
id: linear-nonlinear-verification--instantiates--verification-layer
type: instantiates
source: linear-nonlinear-verification
target: verification-layer
---

The bang-as-verification adapter is the modal, resource-sensitive form the verification layer takes inside the concurrency leg: the comonad ! = GF is exactly the operation "make this linear trace into a checked, freely-reusable value", which is the discharge the layer performs, now typed so that reuse is licensed rather than assumed. So [linear-nonlinear-verification] is a concrete instance of [verification-layer], specialised to a linear substrate where copying must be earned through verification.
