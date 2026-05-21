# OperadAlgebra.agda — plug, shift, and structural boundary-swap

## Where This File Sits

`agda/Concurrency/Algebras/OperadAlgebra.agda` strengthens `Valuation.agda`. A valuation can interpret operations. An operad algebra says those interpretations factor through categorical operations corresponding to operadic substitution and cyclic rotation.

The two new operations are:

- `plug`, target-side composition of interpretations;
- `shift`, target-side cyclic rotation of an interpretation.

The file then derives the structural form of boundary-swap, the categorical / operadic R8 face.

## Chunk 1 — preamble and imports

```agda
{-# OPTIONS --cubical --guardedness #-}

-- Algebras of the cyclic associative operad O_1 in a *-autonomous target.
--
-- An `OperadAlgebra T` extends a `Valuation T` with the structural
-- commitments that make it a genuine operad-over-algebra rather than a
-- "any consistent interpretation":
```

The header is careful about staging. At this step, `plug` and `shift` are fields of the algebra record. They are not derived generically from `StarAutonomous`.

That derivation is deferred because the target signature does not yet include enough closed/evaluation structure and coherence.

```agda
open import Concurrency.Operads.CyclicAssociative
  using ( O ; compₒ ; rot ; boundary-swap )
open import Concurrency.Operads.PortRotation
  using ( boundary-rot )
open import Concurrency.Algebras.Valuation
  using ( Valuation ; ports )
```

This file imports the completed operad, especially `boundary-swap`, and the valuation machinery it extends.

## Chunk 2 — module and record

```agda
module _ {ℓ ℓ' : Level} (T : StarAutonomous ℓ ℓ') where
  open StarAutonomous T

  record OperadAlgebra : Type (ℓ-max ℓ ℓ') where
    field
      valuation : Valuation T

    open Valuation valuation public
```

An `OperadAlgebra` starts by containing a `Valuation T`. Opening it publicly makes the valuation's fields available as fields of the algebra: `Carrier`, `self-dual`, and `⟦_⟧`.

The algebra is therefore not a separate interpretation. It is a valuation plus extra structure explaining how the valuation behaves on substitution and rotation.

## Chunk 3 — plug and shift

```agda
    field
      plug :
          {l r : ℕ}
          (i : Port (suc l)) (j : Port (suc r))
        → Hom (ports T Carrier (suc l)) ⊥-par
        → Hom (ports T Carrier (suc r)) ⊥-par
        → Hom (ports T Carrier (suc (l + r))) ⊥-par

      shift :
          {n : ℕ} (i : Port n)
        → Hom (ports T Carrier n) ⊥-par
        → Hom (ports T Carrier n) ⊥-par
```

`plug` is the categorical operation corresponding to `compₒ`. Given interpretations of two operands and the ports being glued, it produces the interpretation-shaped morphism for the composite arity.

`shift` is the categorical operation corresponding to `rot`. Given a rotation amount and an interpretation, it returns the rotated interpretation.

At this stage these are auxiliary handles. They are constrained only by the axioms below, on interpretations coming from `⟦_⟧`. The file does not say that `plug` and `shift` satisfy standalone algebraic laws on arbitrary morphisms.

## Chunk 4 — structural axioms

```agda
      interp-compₒ :
          {l r : ℕ}
          (i : Port (suc l)) (j : Port (suc r))
          (a : O (suc l)) (b : O (suc r))
        → ⟦ compₒ i j a b ⟧ ≡ plug i j ⟦ a ⟧ ⟦ b ⟧

      interp-rot :
          {n : ℕ} (i : Port n) (a : O n)
        → ⟦ rot i a ⟧ ≡ shift i ⟦ a ⟧
```

These two fields pin the valuation to the structural operations.

`interp-compₒ` says: interpreting an operadic substitution is the same as plugging the interpretations.

`interp-rot` says: interpreting an operadic rotation is the same as shifting the interpretation.

This is the exact point where a weak valuation becomes an operad algebra.

## Chunk 5 — structural boundary-swap statement

```agda
boundary-swap-structural :
    {l r : ℕ}
    (i : Port (suc l)) (j : Port (suc r))
    (a : O (suc l)) (b : O (suc r))
  → PathP (λ ι → Hom (ports T Carrier (suc (+-comm l r ι))) ⊥-par)
      (shift (boundary-rot l r) (plug i j ⟦ a ⟧ ⟦ b ⟧))
      (plug j i ⟦ b ⟧ ⟦ a ⟧)
```

This is the derived theorem.

The left endpoint says:

```text
plug a and b, then boundary-shift the result
```

The right endpoint says:

```text
plug b and a, with ports swapped
```

The path lives over `+-comm l r`, because swapping operands also swaps the order of the arity sum.

This is the categorical version of the operadic `boundary-swap` theorem. It is the R8-relevant identity that `Sessions.agda` later specializes at the binary generator.

## Chunk 6 — proof structure

```agda
boundary-swap-structural {l} {r} i j a b =
    pre ◁ congP (λ _ → ⟦_⟧) (boundary-swap i j a b) ▷ interp-compₒ j i b a
  where
    pre :
        shift (boundary-rot l r) (plug i j ⟦ a ⟧ ⟦ b ⟧)
          ≡ ⟦ rot (boundary-rot l r) (compₒ i j a b) ⟧
    pre =
        cong (shift (boundary-rot l r)) (sym (interp-compₒ i j a b))
      ∙ sym (interp-rot (boundary-rot l r) (compₒ i j a b))
```

The proof is a three-step bridge:

1. Use the structural axioms backward to turn `shift (plug ...)` into the interpretation of `rot (compₒ ...)`.
2. Apply the operad theorem `boundary-swap` through the interpretation function `⟦_⟧`.
3. Use `interp-compₒ` forward to turn the interpretation of the swapped composite into `plug j i ⟦ b ⟧ ⟦ a ⟧`.

The notation `◁` and `▷` are path-composition helpers for paths whose type varies. We do not need to make them a new concept here; the proof is just "precompose a path, apply the interpreted operad theorem, postcompose another path."

## Closing

`OperadAlgebra.agda` adds the structural layer above valuation:

- `plug` mirrors operadic substitution;
- `shift` mirrors cyclic rotation;
- `interp-compₒ` and `interp-rot` state that interpretation factors through them;
- `boundary-swap-structural` lifts operadic boundary-swap into the target category.

The next file, `Sessions.agda`, builds the first concrete instance of this interface.
