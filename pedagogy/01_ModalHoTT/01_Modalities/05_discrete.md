# Discrete.agda - the flat/shape bridge

## Where this file sits

`formal/ModalHoTT/Modalities/Discrete.agda` is a small bridge file. It is not part of the main path from functoriality to fracture. It records a cohesive fact that becomes useful for iteration: flat-modal types and shape-modal types pick out the same class of "discrete" types.

In symbols, it postulates two conversions:

```text
IsFlatModal A  -> IsShapeModal A
IsShapeModal A -> IsFlatModal A
```

Both are theorems in the intended cohesive setting. Both are blocked in the current synthetic Agda interface for reasons we have already seen: missing dependent shape induction, and the missing crisp eta direction for flat.

The file is used by `IterationCohesion.agda`. It lets the project show that `T A = ♭(ʃ A)` is not only flat-modal but also shape-modal, which is the key input for the first-level collapse of the A-side iteration sanity check.

## Chunk 1 - header status

```agda
{-# OPTIONS --cubical --guardedness #-}

-- Status: IMPORTED by `Modalities/IterationCohesion.agda` (2026-05-16).
--
-- The bridge was originally queued to support pinning the structural
-- de Rham map in Cohomology/FlatCoefficients.agda. On working through
-- the pinning derivation, naturality of `shape-flat-transpose` in B
-- turned out to be the load-bearing piece, not the bridge.
```

The header is unusually historical because this file was held in reserve. The project first expected the flat/shape bridge to be needed for the flat-coefficient cohomology pin. It turned out that the actual load-bearing ingredient there was `shape-flat-natural-B` from `Properties.agda`.

So `Discrete.agda` is not used by `FlatCoefficients.agda`. Its current use is iteration.

That distinction matters because it keeps the postulate budget honest. The structural cohomology result does not depend on these two bridge postulates. The A-side iteration collapse does.

There is one stale-looking note later in the Agda header saying the file is used by `Cohomology/FlatCoefficients.agda`. The current source imports and the project manual disagree with that note: `FlatCoefficients.agda` imports `Properties`, not `Discrete`, and its pin uses `shape-flat-natural-B`. So the companion follows the live dependency rather than the stale line.

## Chunk 2 - what "discrete" means here

```agda
-- Coincidence of the discrete and shape-modal type classes.
--
-- In any cohesive ∞-topos, the types fixed by the flat modality
-- (♭A ≃ A) and the types fixed by the shape modality (A ≃ ʃA)
-- pick out the same class — the "discrete" types.
```

The word "discrete" is doing cohesive work here.

`IsFlatModal A` says:

```agda
flat-counit : ♭A → A
```

is an equivalence. So `A` is already flat; applying `♭` changes nothing.

`IsShapeModal A` says:

```agda
shape-unit : A → ʃA
```

is an equivalence. So `A` is already pure shape; applying `ʃ` changes nothing.

In a cohesive setting, these are two ways of recognizing the discrete objects. The current file postulates the conversion between the two recognizers.

> **References**
> - [nLab: cohesive infinity-topos](https://ncatlab.org/nlab/show/cohesive+%28infinity%2C1%29-topos)
> - [nLab: discrete object](https://ncatlab.org/nlab/show/discrete+object)
> - [Shulman, *Brouwer's fixed-point theorem in real-cohesive HoTT*, 2018 (arXiv)](https://arxiv.org/abs/1509.07584)

## Chunk 3 - imports and variables

```agda
module ModalHoTT.Modalities.Discrete where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv

open import ModalHoTT.Modalities.Cohesion

private
  variable
    ℓ : Level
```

Only `Cohesion` is imported from the project. The bridge talks directly about the predicates defined there:

```agda
IsFlatModal
IsShapeModal
```

It does not need the adjunction transpose operations or functoriality laws.

`Cubical.Foundations.Equiv` is present because those predicates unfold to `isEquiv` statements.

## Chunk 4 - flat-modal implies shape-modal

```agda
postulate
  flat-modal-to-shape-modal : {A : Type ℓ} → IsFlatModal A → IsShapeModal A
```

This direction says: if `A` is fixed by flat, then `A` is fixed by shape.

The blocker is dependent shape induction. Intuitively, shape should have a universal property saying maps out of `ʃA` are controlled by maps out of `A` into shape-modal targets. The existing `shape-rec` gives only a non-dependent recursion principle. It is enough to define some functions, but not enough to prove the uniqueness and path-valued facts needed to show `shape-unit` is an equivalence under the flat-modal assumption.

So the file records the intended cohesive theorem directly.

## Chunk 5 - shape-modal implies flat-modal

```agda
  shape-modal-to-flat-modal : {A : Type ℓ} → IsShapeModal A → IsFlatModal A
```

This direction says: if `A` is fixed by shape, then `A` is fixed by flat.

The blocker is different. To prove `IsFlatModal A`, we need `flat-counit : ♭A -> A` to be an equivalence. We already have one roundtrip:

```agda
flat-counit (flat-intro a) ≡ a
```

from `flat-counit-intro` (01_§8). The missing direction would say:

```text
flat-intro (flat-counit u) = u
```

for `u : ♭A`.

In real-cohesive HoTT, this is a crisp eta rule. In the current Agda encoding, `flat-intro` is already an over-strong crisp-context shortcut, but this eta direction is not available as a general theorem. The file therefore postulates the conversion.

## Closing

`Discrete.agda` adds exactly two postulates and no definitions:

- `flat-modal-to-shape-modal`;
- `shape-modal-to-flat-modal`.

They are not used by the fracture proof and not used by the flat-coefficient cohomology pin. They are used by `IterationCohesion.agda` to show that the A-side iteration of `ʃ ⊣ ♭` collapses after the first step.

Read this file as bridge infrastructure: small, sharp, and explicitly postulate-relative.
