# FlatCoefficients.agda - structural flat-coefficient cohomology

## Where this file sits

`formal/ModalHoTT/Cohomology/FlatCoefficients.agda` is the first cohomology-side companion in the synthetic ModalHoTT track. It is not in `Modalities/` because it is no longer just building the modal machinery. It uses that machinery to state a structural cohomology fact.

The file defines:

```agda
FlatCohomology A B = ShapeModality A → B
```

Then it proves that if `B` is flat-modal, this type is equivalent to the ordinary function type:

```agda
A → B
```

This is the structural rung of the de Rham ladder. It uses the existing `ʃ ⊣ ♭` adjunction and the flat-modal hypothesis on coefficients. It does not define differential forms, it does not introduce `ℝ`, and it does not prove the classical de Rham theorem.

The key honesty point: the equivalence is meaningful because it is only statable in cohesive HoTT, but it is not yet content-bearing differential geometry. It is modal algebra.

> **References**
> - [nLab: de Rham cohomology](https://ncatlab.org/nlab/show/de+Rham+cohomology)
> - [nLab: differential cohomology](https://ncatlab.org/nlab/show/differential+cohomology)
> - [Schreiber, *Differential cohomology in a cohesive ∞-topos* (arXiv)](https://arxiv.org/abs/1310.7930)
> - [nLab: cohesive homotopy type theory](https://ncatlab.org/nlab/show/cohesive+homotopy+type+theory)

## Chunk 1 - header and the de Rham ladder

```agda
{-# OPTIONS --cubical --guardedness #-}

-- Flat-coefficient cohomology — the structural level of the de Rham depth ladder.
--
-- The "de Rham depth" ladder names three levels of the de Rham / separation
-- arc:
--
--   structural        — only the existing ʃ ⊣ ♭ adjunction; no new postulates.
--                       The separation result is real but carries no geometric
--                       content beyond modal algebra. *This file.*
--
--   named-coefficient — adds a postulated cohesive type ℝ and instantiates
--                       at ♭ℝ.
--
--   differential      — adds the differential-cohesion modalities ...
```

The header is the file's guardrail. It prevents the reader from mistaking this for the final de Rham theorem.

The ladder has three rungs:

1. structural: the current file;
2. named-coefficient: a future file could name a cohesive `ℝ` and instantiate at `♭ℝ`;
3. differential: a future phase would add differential cohesion and actual differential forms.

The current file lives entirely on rung 1. That is still useful: the statement mentions `ʃ` and flat-modal coefficients, so it is not plain HoTT. But it is not yet about forms computing cohomology.

## Chunk 2 - imports and variables

```agda
module ModalHoTT.Cohomology.FlatCoefficients where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv
open import Cubical.Foundations.Function
open import Cubical.Foundations.Isomorphism

open import ModalHoTT.Modalities.Cohesion
open import ModalHoTT.Modalities.Adjunctions
open import ModalHoTT.Modalities.Properties

private
  variable
    ℓ ℓ' : Level
```

The modal imports tell the story.

`Cohesion` supplies `ShapeModality`, `FlatModality`, `shape-unit`, `flat-counit`, and `IsFlatModal`.

`Adjunctions` supplies the `ʃ ⊣ ♭` transpose:

```agda
shape-flat-transpose
```

and its unit calibration:

```agda
shape-flat-adj-unit-eq
```

`Properties` supplies `flat-map`, `flat-counit-natural`, and the load-bearing naturality postulate `shape-flat-natural-B`.

## Chunk 3 - flat cohomology

```agda
FlatCohomology : Type ℓ → Type ℓ' → Type (ℓ-max ℓ ℓ')
FlatCohomology A B = ShapeModality A → B
```

This is the file's basic definition.

`FlatCohomology A B` means `B`-valued data on the shape of `A`. Instead of mapping directly out of `A`, we map out of `ʃA`.

The name "cohomology" is structural at this stage. There are no cochains, no differential, and no forms. The definition marks the cohesive pattern that later de Rham work is supposed to refine.

## Chunk 4 - the structural equivalence

```agda
flat-coefficients-factor : {A : Type ℓ} {B : Type ℓ'}
  → IsFlatModal B
  → FlatCohomology A B ≃ (A → B)
flat-coefficients-factor {A = A} {B = B} Bm =
  compEquiv shape-flat-transpose postcompose-counit
  where
    counit-equiv : FlatModality B ≃ B
    counit-equiv = flat-counit , Bm

    postcompose-counit : (A → FlatModality B) ≃ (A → B)
    postcompose-counit = isoToEquiv (iso
      (λ f → flat-counit ∘ f)
      (λ g → invEq counit-equiv ∘ g)
      (λ g → funExt (λ a → secEq counit-equiv (g a)))
      (λ f → funExt (λ a → retEq counit-equiv (f a))))
```

The theorem says: when `B` is flat-modal, maps `ʃA -> B` are equivalent to maps `A -> B`.

The proof has two stages.

First, the adjunction `ʃ ⊣ ♭` gives:

```agda
(ʃA → B) ≃ (A → ♭B)
```

Second, because `B` is flat-modal, `flat-counit : ♭B -> B` is an equivalence. Postcomposing functions `A -> ♭B` with this counit gives an equivalence:

```agda
(A → ♭B) ≃ (A → B)
```

`compEquiv` composes the two equivalences.

There are no new postulates in this construction. It uses the adjunction equivalence already postulated in `Adjunctions.agda` and the flat-modal hypothesis supplied by the caller.

## Chunk 5 - why the pin is needed

```agda
-- Pinning: the equivalence is precomposition with shape-unit.
--
-- The forward map of `flat-coefficients-factor` is built as
-- `flat-counit ∘ shape-to-flat`. We show pointwise that this agrees
-- with the canonical map f ↦ f ∘ shape-unit.
```

The equivalence in chunk 4 is abstractly correct, but the file wants more. It wants to show that its forward direction is the obvious map:

```agda
λ f -> f ∘ shape-unit
```

In words: given data on `ʃA`, restrict it back along the shape unit `A -> ʃA`.

This pin matters because "there exists an equivalence" is weaker than "the canonical comparison map is an equivalence." For the de Rham arc, the canonical comparison is the one that carries meaning.

## Chunk 6 - the pin proof

```agda
flat-coefficients-factor-pin : {A : Type ℓ} {B : Type ℓ'}
  (Bm : IsFlatModal B)
  → equivFun (flat-coefficients-factor {A = A} Bm) ≡ λ f → f ∘ shape-unit
flat-coefficients-factor-pin {A = A} {B = B} Bm = funExt λ f → funExt λ a →
    cong (λ h → flat-counit (h a)) (shape-flat-natural-B f (λ u → u))
  ∙ cong (λ h → flat-counit (flat-map f (h a))) shape-flat-adj-unit-eq
  ∙ flat-counit-natural f (flat-intro (shape-unit a))
  ∙ cong f (flat-counit-intro (shape-unit a))
```

This proof compares two functions by function extensionality:

```agda
funExt λ f → funExt λ a → ...
```

So it fixes:

- `f : ʃA -> B`;
- `a : A`;

and proves the two sides agree at `f` and `a`.

The path has four steps:

1. Use `shape-flat-natural-B` to rewrite `shape-to-flat f` in terms of `flat-map f` applied to the transpose of the identity on `ʃA`.
2. Use `shape-flat-adj-unit-eq` to identify that transpose of the identity with `flat-intro ∘ shape-unit`.
3. Use `flat-counit-natural f` to move `flat-counit` past `flat-map f`.
4. Use `flat-counit-intro` to reduce `flat-counit (flat-intro (shape-unit a))` to `shape-unit a`.

The final result is:

```agda
f (shape-unit a)
```

which is exactly `(f ∘ shape-unit) a`.

The only postulate used here that was not already part of the adjunction construction is `shape-flat-natural-B`. That is why `Properties.agda` called it load-bearing.

## Closing

`FlatCoefficients.agda` contributes:

- `FlatCohomology A B = ʃA -> B`;
- `flat-coefficients-factor`, the structural equivalence for flat-modal `B`;
- `flat-coefficients-factor-pin`, showing the forward map is precomposition with `shape-unit`.

The result is the structural rung of the de Rham ladder. It is a real cohesive statement, because it depends on `ʃ` and flat-modal coefficients. It is not the named-coefficient or differential theorem. Those require future files and, for the differential rung, substantially more modal structure.

