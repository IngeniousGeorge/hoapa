---
id: equality-pattern-blindness--instantiates--no-leak
type: instantiates
source: equality-pattern-blindness
target: no-leak
---

The first piece of no-leak that stopped being a promise. No-leak is stated as renaming-invariance at the runtime boundary — equivalent participants are equal, so unityping becomes a theorem rather than a stipulation — and blindness is that claim carried out at exactly one observer, the acceptance check, and at the raw serializable layer rather than the realized structure. The instantiation is genuine but narrow, and both halves matter: what has been shown is that the checker's verdict survives any non-merging relabelling of every record, malformed ones included; what has not been shown is anything about the mathematical object a record determines, or about any observer other than the checker. Reading it as more than that would turn a statement about a decision procedure into a claim about privacy, which it is not.
