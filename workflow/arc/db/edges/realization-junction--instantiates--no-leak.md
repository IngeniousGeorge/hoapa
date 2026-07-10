---
id: realization-junction--instantiates--no-leak
type: instantiates
source: realization-junction
target: no-leak
---

The junction is where no-leak stops being a promise and becomes a checked property: renaming-invariance at the runtime boundary is univalence there, so the code literally cannot observe an actor except through its typed contributions. This is the concrete realisation of the abstract guarantee — the point at which the `implementation` perspective discharges what the `conjecture` perspective asserts — and it is the same place [cross-site-adjunction] is made to run, so no-leak and the adjunction are established at one spot rather than two.
