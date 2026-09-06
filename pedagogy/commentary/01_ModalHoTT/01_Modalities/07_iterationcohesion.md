# IterationCohesion.agda - the A-side iteration sanity check

## Where this file sits

`formal/ModalHoTT/Modalities/IterationCohesion.agda` specializes the generic scaffold from `Iteration.agda` to the A-side adjunction `ʃ ⊣ ♭`.

The result is intentionally not the final `T_recursion` theorem. It is a sanity check: if we instantiate the generic tower with the already-existing cohesion modalities, does the machinery compose, and does the iteration collapse in the expected trivial A-side way?

The answer is yes, postulate-relative to the `Discrete.agda` bridge. The induced `T` is:

```text
T A = ♭(ʃ A)
```

The first step after `T A`:

```text
T A -> T(T A)
```

is shown to be an equivalence. The file does not prove that the full sequential colimit `ND A` is equivalent to `T A`; that would require a separate convergence lemma for sequential colimits.

## Chunk 1 - header and imports

```agda
{-# OPTIONS --cubical --guardedness #-}

-- Sanity check: instantiate the generic Iteration module with the A-side
-- ʃ ⊣ ♭ adjunction.
```

The header is careful about scope. This file checks the "Iteration-alone layer" for `workflow/targets.md`. It is not the cross-site case where iteration would carry new Concurrency-side content.

The imports show all ingredients:

```agda
open import ModalHoTT.Modalities.Cohesion
open import ModalHoTT.Modalities.Adjunctions
open import ModalHoTT.Modalities.Properties
open import ModalHoTT.Modalities.Discrete
open import ModalHoTT.Modalities.Iteration
```

`Cohesion` gives `ʃ` and `♭`. `Properties` gives `shape-map` and `flat-map`. `Adjunctions` gives idempotency. `Discrete` gives the flat/shape bridge. `Iteration` gives the generic scaffold.

## Chunk 2 - specialize Iteration to ʃ ⊣ ♭

```agda
module ʃ⊣♭ {ℓ : Level} where
  open Iteration {ℓ = ℓ} {ℓ' = ℓ}
    ShapeModality FlatModality
    shape-map flat-map
    (λ a → flat-intro (shape-unit a))
    public
```

This module instantiates the parameters from `Iteration.agda`:

```text
L     = ShapeModality
R     = FlatModality
L-map = shape-map
R-map = flat-map
η     = flat-intro ∘ shape-unit
```

The unit is the composite:

```agda
A -> ʃA -> ♭(ʃA)
```

That is the unit of the `ʃ ⊣ ♭` adjunction, pinned in `Adjunctions.agda` by `shape-flat-adj-unit-eq`.

Opening the instantiated module `public` exports names like `ʃ⊣♭.T`, `ʃ⊣♭.T-map`, and `ʃ⊣♭.η^`.

## Chunk 3 - computational sanity

```agda
T-as-flat-shape : (A : Type ℓ) → ʃ⊣♭.T A ≡ FlatModality (ShapeModality A)
T-as-flat-shape A = refl

η^1-is-unit : {A : Type ℓ} (a : A) → (ʃ⊣♭.η^ 1) a ≡ flat-intro (shape-unit a)
η^1-is-unit a = refl
```

These are definitional checks.

`T-as-flat-shape` says the instantiated `T` reduces to `♭(ʃ A)`. The proof is `refl`, meaning Agda sees both sides as the same expression after unfolding definitions.

`η^1-is-unit` says the first iterated unit is the expected adjunction unit. Again, the proof is `refl`.

These are small, but useful. They confirm the generic scaffold is not merely abstractly instantiable; it computes to the names the rest of the ModalHoTT track already uses.

## Chunk 4 - flat-intro is an equivalence on flat-modal types

```agda
flat-intro-equiv : {A : Type ℓ} → IsFlatModal A → isEquiv (flat-intro {A = A})
flat-intro-equiv {A = A} AfM = isoToIsEquiv theIso
  where
    e : FlatModality A ≃ A
    e = (flat-counit , AfM)

    flat-counit-inj : {x y : FlatModality A}
                    → flat-counit x ≡ flat-counit y → x ≡ y
    flat-counit-inj {x = x} {y = y} p =
      sym (retEq e x) ∙ cong (invEq e) p ∙ retEq e y

    leftInv : (u : FlatModality A) → flat-intro (flat-counit u) ≡ u
    leftInv u = flat-counit-inj (flat-counit-intro (flat-counit u))

    theIso : Iso A (FlatModality A)
    theIso = iso flat-intro flat-counit leftInv flat-counit-intro
```

This helper proves that if `A` is flat-modal, then:

```agda
flat-intro : A -> ♭A
```

is an equivalence.

The assumption `IsFlatModal A` says `flat-counit : ♭A -> A` is an equivalence. We already have:

```agda
flat-counit (flat-intro a) ≡ a
```

from `flat-counit-intro`. The missing roundtrip is:

```agda
flat-intro (flat-counit u) ≡ u
```

The proof gets it by using injectivity of `flat-counit`, which follows because `flat-counit` is an equivalence under the assumption `AfM`. Then it packages `flat-intro` and `flat-counit` as an `Iso`.

This is a local theorem, not a new postulate.

## Chunk 5 - T A is flat-modal and shape-modal

```agda
T-is-flat-modal : (A : Type ℓ) → IsFlatModal (ʃ⊣♭.T A)
T-is-flat-modal A = flat-modality-idempotent

T-is-shape-modal : (A : Type ℓ) → IsShapeModal (ʃ⊣♭.T A)
T-is-shape-modal A = flat-modal-to-shape-modal (T-is-flat-modal A)
```

Since `T A` is definitionally `♭(ʃ A)`, it is flat-modal by `flat-modality-idempotent` from `Adjunctions.agda`.

Then the file uses `flat-modal-to-shape-modal` from `Discrete.agda` to turn that into shape-modality. This is the first point where the discrete bridge is load-bearing.

Status matters:

- flat-modal status of `T A` is proved from earlier flat induction machinery;
- shape-modal status of `T A` uses a postulated bridge.

## Chunk 6 - the first iterate step is an equivalence

```agda
η-equiv-at-T : (A : Type ℓ) → ʃ⊣♭.T A ≃ ʃ⊣♭.T (ʃ⊣♭.T A)
η-equiv-at-T A =
  compEquiv (shape-unit , T-is-shape-modal A)
            (flat-intro , flat-intro-equiv
                            (shape-modal-to-flat-modal
                               (shape-modality-idempotent {A = ʃ⊣♭.T A})))
```

The map from `T A` to `T(T A)` is:

```text
T A --shape-unit--> ʃ(T A) --flat-intro--> ♭(ʃ(T A))
```

The first factor is an equivalence because `T A` is shape-modal, proved in chunk 5.

The second factor is an equivalence because `ʃ(T A)` is shape-modal by `shape-modality-idempotent`, then flat-modal by `shape-modal-to-flat-modal`, and finally `flat-intro-equiv` applies.

`compEquiv` composes those two equivalences. This is the first-level collapse: once the tower has reached `T A`, the next structure map is already an equivalence.

## Chunk 7 - pinning the forward map

```agda
η-equiv-fst : (A : Type ℓ) (b : ʃ⊣♭.T A)
            → η-equiv-at-T A .fst b ≡ flat-intro (shape-unit b)
η-equiv-fst A b = refl
```

This pin says the equivalence built in chunk 6 has the expected forward function.

The forward map of the composed equivalence is exactly:

```agda
λ b -> flat-intro (shape-unit b)
```

That is the structure map of the instantiated iteration sequence at `T A`. The proof is `refl`, so this is not an extra axiom; it is a definitional check that the equivalence is the one we meant.

## Closing

`IterationCohesion.agda` proves:

- the generic `T` specializes to `♭ ∘ ʃ`;
- the first iterated unit specializes to `flat-intro ∘ shape-unit`;
- `flat-intro` is an equivalence on flat-modal types;
- `T A` is flat-modal;
- `T A` is shape-modal using the `Discrete.agda` bridge;
- the step `T A -> T(T A)` is an equivalence;
- the forward map of that equivalence is the actual iteration structure map.

It does not prove `ND A ≃ T A`. It gives the key first-level ingredient for such a result. The future cross-site recursion theorem remains outside the current Agda tree.

