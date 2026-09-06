---
id: no-privileged-actor--fails-without--equality-pattern-blindness
type: fails-without
source: no-privileged-actor
target: equality-pattern-blindness
---

Remove blindness and the anti-privilege theorem loses its floor. No-privileged-actor says acceptance depends on the typed record and its obligations, never on who submitted them — but "never on who" has to be cashed out as something a machine can check, and the cash value is that the acceptance check cannot tell two participants apart by their labels. Without that, status could re-enter through the identifier itself: a checker that treated actor 0 differently from actor 7 would satisfy every other stated constraint while quietly ranking participants by an accident of enumeration. Blindness closes that door for the raw layer. It leaves open the corresponding question for every observer the protocol may later grow, which is why this is a floor and not the theorem.
