# Iteration.agda - the generic T-recursion scaffold

## Where this file sits

`formal/ModalHoTT/Modalities/Iteration.agda` is generic infrastructure. It is not specific to the three cohesion modalities. It abstracts the following pattern:

```text
L ⊣ R gives T = R ∘ L
A -> T A -> T² A -> T³ A -> ...
```

Then it names the sequential colimit of that tower as `ND A`, the "developing network" candidate from the workflow notes.

The intended future instance is the cross-site adjunction between the ModalHoTT side and the Concurrency side, often described in the workflow as `Allow ⊣ Require`. That adjunction is not yet in Agda. So this file does not prove the final recursion theorem. It provides the reusable scaffold that a future cross-site adjunction can instantiate.

For now, the A-side adjunction `ʃ ⊣ ♭` instantiates the scaffold in `IterationCohesion.agda` as a sanity check.

> **References**
> - [nLab: monad](https://ncatlab.org/nlab/show/monad)
> - [nLab: sequential colimit](https://ncatlab.org/nlab/show/sequential+colimit)
> - [nLab: adjunction](https://ncatlab.org/nlab/show/adjunction)

## Chunk 1 - header and imports

```agda
{-# OPTIONS --cubical --guardedness #-}

-- Iterated unit of a generic adjunction; the "developing network" as a
-- sequential colimit. Infrastructure for T_recursion (workflow/targets.md).
```

The header identifies this file as `T_recursion` infrastructure. It is deliberately one layer more abstract than the existing cohesion files.

The source imports only basic cubical tools, natural numbers, sequences, and sequential colimits:

```agda
module ModalHoTT.Modalities.Iteration where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Nat using (ℕ ; zero ; suc)
open import Cubical.Data.Sequence using (Sequence)
open import Cubical.HITs.SequentialColimit using (SeqColim)
```

There are no imports from `ModalHoTT.Modalities.Cohesion`. That is the point: the file is parameterized over an arbitrary adjunction-like package.

## Chunk 2 - the parameterized module

```agda
module Iteration
  {ℓ ℓ' : Level}
  (L     : Type ℓ → Type ℓ')
  (R     : Type ℓ' → Type ℓ)
  (L-map : ∀ {A B : Type ℓ}  → (A → B) → L A → L B)
  (R-map : ∀ {X Y : Type ℓ'} → (X → Y) → R X → R Y)
  (η     : ∀ {A : Type ℓ} → A → R (L A))
  where
```

This module asks for exactly the structure needed to build the tower.

`L` and `R` are type operations going back and forth between two universes. `L-map` and `R-map` say they act on functions. The unit:

```agda
η : A → R (L A)
```

is the step that sends an object into one round of the composite.

The file does **not** ask for a full adjunction record. It does not require counits, triangle identities, or all naturality laws. That keeps the scaffold small, but it also explains why one naturality law has to be postulated later in the module.

## Chunk 3 - the induced T

```agda
T : Type ℓ → Type ℓ
T A = R (L A)

T-map : ∀ {A B : Type ℓ} → (A → B) → T A → T B
T-map f = R-map (L-map f)
```

`T` is the composite `R ∘ L`.

If `L ⊣ R` were packaged as an adjunction, `T` would be the induced monad on the source side. This file does not name or prove all monad laws. It only needs the operation `T`, its action on maps, and the unit `η`.

`T-map` lifts a function `f : A -> B` by first applying `L-map`, then `R-map`.

## Chunk 4 - n-fold iteration

```agda
T^_ : ℕ → Type ℓ → Type ℓ
(T^ zero)    A = A
(T^ (suc n)) A = T ((T^ n) A)
```

`T^ n A` means "apply `T` to `A`, `n` times."

The first few cases are:

```text
T^ 0 A = A
T^ 1 A = T A
T^ 2 A = T (T A)
```

This is ordinary recursion on natural numbers. The mixfix name `T^_` lets the code read close to the mathematical notation.

## Chunk 5 - iterated unit

```agda
η^_ : (n : ℕ) {A : Type ℓ} → A → (T^ n) A
(η^ zero)    a = a
(η^ (suc n)) a = η ((η^ n) a)
```

`η^ n` sends an `A`-point into the `n`th stage of the tower.

The zero stage does nothing. The successor stage first builds the previous stage, then applies `η` at that stage.

The source comment calls this the "from the inside" form:

```text
a -> η^n a -> η (η^n a)
```

There is another possible-looking form: apply `η` first, then map `η^ n` through `T`. The next chunks show those two views agree, assuming naturality of `η`.

## Chunk 6 - eta naturality

```agda
postulate
  η-naturality : {A B : Type ℓ} (f : A → B) (a : A)
               → T-map f (η a) ≡ η (f a)
```

This is the one postulate inside the generic module.

In a genuine adjunction, `η` is a natural transformation, so this law is part of the adjunction package. But this file did not ask for a full adjunction package; it asked only for `L`, `R`, their map operations, and the unit function. Since naturality is not bundled in the parameters, it is postulated here.

This is the same kind of gap as `shape-flat-natural-B` in `Properties.agda`: not a mysterious theorem about one example, but missing naturality data from a deliberately thin interface.

## Chunk 7 - coherence of the iterated unit

```agda
η^-coherent : (n : ℕ) {A : Type ℓ} (a : A)
            → (η^ (suc n)) a ≡ T-map (η^ n) (η a)
η^-coherent n a = sym (η-naturality (η^ n) a)
```

This theorem says the two ways to reach the next stage agree:

```text
inside first:  a -> η^n a -> η (η^n a)
outside first: a -> η a -> T-map (η^n) (η a)
```

The proof is exactly naturality of `η`, reversed by `sym`.

The source calls this the "operadic associator for the iteration," not because operads are imported here, but because it is the associativity-shaped fact needed when iterated development is later connected to the Concurrency side.

## Chunk 8 - the sequence and its colimit

```agda
T-sequence : Type ℓ → Sequence ℓ
Sequence.obj (T-sequence A) n = (T^ n) A
Sequence.map (T-sequence A) x = η x

ND : Type ℓ → Type ℓ
ND A = SeqColim (T-sequence A)
```

`T-sequence A` is the tower:

```text
A -> T A -> T² A -> T³ A -> ...
```

At stage `n`, the object is `T^ n A`. The map to the next stage is `η`, used at that stage's type.

`ND A` is the sequential colimit of this tower. It is the type obtained by freely moving along the sequence and identifying each stage with its image in the next. In the project vocabulary, this is the developing network generated by recursively applying the adjunction's unit.

The file does not prove that `ND A` has any special closed form. That depends on the chosen adjunction. In the A-side sanity check, the first iterate collapses; in the future cross-site case, the hope is that the colimit carries real content.

## Closing

`Iteration.agda` installs:

- the generic composite `T = R ∘ L`;
- its map action `T-map`;
- iterates `T^ n`;
- iterated units `η^ n`;
- the naturality postulate for the thin interface;
- the coherence theorem `η^-coherent`;
- the sequence `A -> T A -> T² A -> ...`;
- the sequential colimit `ND A`.

The next file specializes this scaffold to `ʃ ⊣ ♭` and checks that the A-side example collapses in the expected way.

