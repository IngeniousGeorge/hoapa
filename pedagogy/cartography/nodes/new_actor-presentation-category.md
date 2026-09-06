---
id: actor-presentation-category
label: "the category of actor presentations and non-merging relabellings"
kind: concept
tags: [conjecture, implementation]
sources:
  - "formal/RuntimeContract/ActorRenaming.agda (one-object instance)"
---

The setting in which [equality-pattern-blindness] stops being a theorem with a hypothesis and becomes a property of the arrows: objects are choices of participant-name carrier, arrows are the relabellings that preserve and reflect sameness of names, and the reversible arrows form the sub-groupoid that carries [actor-coordinates-as-gauge-choice]. Read this way, the record-shaped data is a construction varying over the base, the checker is a map out of it that respects that variation, and the three separately-stated strata of the Agda file — laws holding for any map, invariance holding for non-merging maps, an action holding for reversible ones — are one statement read at three levels of the base. The mathematical neighbourhood is the study of names and name-swapping (nominal sets, and functors on finite sets and injections), which are related but distinct houses and should not be conflated. Only the one-object shadow exists in code: names are fixed to the natural numbers, and identity and composition of arrows are present without their associativity and unit laws, so this is arrow vocabulary rather than a constructed category.
