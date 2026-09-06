# Algebras intro — interpreting `O_1`

The operads folder built syntax for interaction shape. The algebras folder explains how that shape is interpreted in a target category.

The rough ladder is:

1. `StarAutonomous.agda` says what kind of target category is allowed.
2. `Valuation.agda` says how operations of `O_1` can be assigned morphisms in that target.
3. `OperadAlgebra.agda` strengthens valuation by adding categorical operations corresponding to operadic substitution and rotation.
4. `Sessions.agda` gives the first concrete typed-content instance: multiplicative session syntax.

This folder is where the Concurrency side starts to connect the abstract cyclic shape to typed information flow.

## The Target: A Thin Star-Autonomous Signature

The target category is packaged by a record called `StarAutonomous`.

The phrase comes from linear logic. A star-autonomous category is a symmetric monoidal category with a dualizing operation. It is the categorical home where tensor (`⊗`), par (`⅋`), linear implication (`⊸`), and duality (`_^⊥`) naturally live.

> **References**
> - [nLab: star-autonomous category](https://ncatlab.org/nlab/show/star-autonomous+category) — categorical semantics of classical linear logic.
> - [nLab: linear logic](https://ncatlab.org/nlab/show/linear+logic)

The project deliberately uses a *thin* signature here. It records enough structure for the current algebra interface:

- objects and morphisms;
- identity and composition;
- tensor and unit;
- braiding;
- involutive duality;
- derived par and linear implication.

It does not record every coherence law of a full star-autonomous category. Pentagon, hexagon, triangle, naturality, and the universal property of linear implication are left out until a downstream proof actually needs them.

This is not pretending the missing laws are false or irrelevant. It is a staged formalization. The record carries the operations the current files use; future richer session-categorical work will add the laws needed to derive `plug` and `shift` rather than assume them.

## Valuation vs Algebra

The folder separates two layers that are easy to blur.

A `Valuation` is a weak interpretation:

```agda
⟦_⟧ : O n → Hom (ports Carrier n) ⊥-par
```

It assigns each `n`-ary operation a morphism in the target category. The input object is an iterated tensor of the carrier, one copy per port. The output object is the dualizing object `⊥-par`.

The codomain is not the tensor unit `𝟙`. That matters. In a compact closed category the two can collapse, but the intended session-type setting is star-autonomous, not compact closed. The dualizing object is the correct target for the current R7 algebra layer.

An `OperadAlgebra` is stronger. It says the interpretation of operadic substitution factors through a target-side operation called `plug`, and the interpretation of cyclic rotation factors through a target-side operation called `shift`.

So:

- `Valuation`: "every operation has a consistent interpretation."
- `OperadAlgebra`: "that interpretation respects the intended categorical operations."

## The R8 Face

The operads folder derived:

```agda
boundary-swap
```

as a theorem of cyclic equivariance. The algebra layer lifts that theorem to a target-category identity:

```agda
boundary-swap-structural
```

This is the categorical / operadic face of R8: boundary-rotation of a plugged composite equals the operand-swapped plug, over the arity commutation.

The Sessions file also proves:

```agda
dual-involutive : (S : SessionType) → (S ^⊥ₛ) ^⊥ₛ ≡ S
```

That is the syntactic face of R8: session duality is involutive.

The bridge between those two faces is deliberately not proven in this folder. The files place both faces into Agda, but do not identify them. That bridge needs richer session-categorical structure: proof terms, cut/evaluation, and coherent tensor rotation.

## Sessions Are A First Instance, Not The Final Calculus

`Sessions.agda` is not a full Caires-Pfenning propositions-as-sessions development. It does not contain proof terms, cut elimination, additives, exponentials, recursive sessions, or a real operational semantics.

It gives a multiplicative session syntax, a structural duality operation, an inductive `Hom`, postulated categorical laws, and a chosen `O_1` action packaged as `SessionO1Action`.

That chosen action is the honest current compromise. The project has enough structure to say "Sessions instantiate the algebra interface," but not yet enough to derive the action canonically from cut/evaluation. The file says that out loud rather than hiding it.

## Reading Order

Read this folder in order:

1. `00_algebras_intro.md` — this file.
2. `01_starautonomous.md` — the target-category signature.
3. `02_valuation.md` — weak interpretations of `O_1`.
4. `03_operadalgebra.md` — structural plug/shift algebra and boundary-swap.
5. `04_sessions.md` — the concrete multiplicative session instance.

The companion files assume this intro. They will not re-explain star-autonomous categories or the valuation/algebra split each time.
