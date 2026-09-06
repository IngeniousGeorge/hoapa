---
id: equality-pattern-blindness--fails-without--actor-coordinates-as-gauge-choice
type: fails-without
source: equality-pattern-blindness
target: actor-coordinates-as-gauge-choice
---

The support runs both ways, and this direction is the surprising one. Blindness depends on the contract having declined to treat participant numbering as content: the serialization tool numbers actors densely from zero by first appearance, and it would have been natural to make the checker insist on that as a tidiness condition. Had it done so, the theorem would be false — transposing two participants sends the list `[0,1]` to `[5,1]`, which is not dense, so even a plain shuffle would flip the verdict. The absent clause is therefore load-bearing rather than merely absent, which is why the two records support each other without either being the other's inverse: the coordinate reading needs the theorem to be legitimate, and the theorem needs the coordinate commitment to be true.
