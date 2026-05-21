# Valuation.agda — weak interpretations of `O_1`

## Where This File Sits

`agda/Concurrency/Algebras/Valuation.agda` defines the first interpretation layer. Given a star-autonomous target category `T`, a valuation assigns each operation of `O_1` a morphism in `T`.

This is intentionally weaker than an algebra. A valuation knows how to interpret operations, but it does not yet say that interpreting substitution is the same as a categorical plugging operation, or that interpreting rotation is the same as a categorical shift.

## Chunk 1 — preamble and imports

```agda
{-# OPTIONS --cubical --guardedness #-}

-- Valuations of the cyclic associative operad O_1 in a *-autonomous target.
--
-- A `Valuation T` is a HIT-respecting interpretation of `O n` into
-- morphisms of T:
--
--   ⟦_⟧ : O n → Hom (ports Carrier n) ⊥-par
```

The shape of `⟦_⟧` is the whole file. It says: for every operation of arity `n`, produce a morphism out of the tensor product of one carrier per port, landing in the dualizing object.

```agda
module Concurrency.Algebras.Valuation where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Nat              using (ℕ ; zero ; suc)

open import Concurrency.Operads.Ports
open import Concurrency.Operads.CyclicAssociative using ( O )
open import Concurrency.Algebras.StarAutonomous
```

The import from `CyclicAssociative` is only `O`: this file interprets the completed operad, not the raw syntax.

## Chunk 2 — module parameter and opened target

```agda
module _ {ℓ ℓ' : Level} (T : StarAutonomous ℓ ℓ') where
  open StarAutonomous T
```

The whole file is parameterized by a target category `T`. Opening `StarAutonomous T` brings the target's names into scope: `Ob`, `Hom`, `_⊗_`, `⊥-par`, and so on.

So from here on, all objects and morphisms are objects and morphisms of this chosen target.

## Chunk 3 — iterated tensor of ports

```agda
ports : Ob → ℕ → Ob
ports X zero    = X
ports X (suc n) = X ⊗ ports X n
```

`ports X n` is the tensor product of `suc n` copies of `X`, one for each cyclic port of an `n`-ary operation.

For small arities:

```text
ports X 0 = X
ports X 1 = X ⊗ X
ports X 2 = X ⊗ (X ⊗ X)
```

So the binary generator at arity 2 is interpreted as a morphism whose input object has three tensor factors. That matches the three-port convention from the operads intro.

The tensor is right-associated by definition. Later coherence upgrades may make different associations interchangeable, but this file chooses one concrete iteration.

## Chunk 4 — the Valuation record

```agda
record Valuation : Type (ℓ-max ℓ ℓ') where
  field
    Carrier : Ob

    self-dual         : Hom Carrier (Carrier ^⊥)
    self-dual-inv     : Hom (Carrier ^⊥) Carrier
    self-dual-iso-l   : self-dual-inv ∘ self-dual ≡ id
    self-dual-iso-r   : self-dual ∘ self-dual-inv ≡ id
```

A valuation first chooses a carrier object in the target category.

It also chooses a self-duality isomorphism for that carrier. In the Sessions instance, this is where the session-duality face enters at the carrier level: the chosen carrier is `end`, which is self-dual.

The fields are again explicit morphism, inverse morphism, and two inverse laws.

## Chunk 5 — interpretation

```agda
    ⟦_⟧ : {n : ℕ} → O n → Hom (ports Carrier n) ⊥-par
```

This is the actual valuation.

For every operation `a : O n`, `⟦ a ⟧` is a morphism:

```agda
Hom (ports Carrier n) ⊥-par
```

The input is one tensor factor per port. The output is the dualizing object of the star-autonomous target.

Because `O` is a higher inductive type with laws built in, a function out of `O` must respect all the path constructors. At this valuation level, that respect is automatic from the HIT recursor: applying `cong ⟦_⟧` to a path constructor gives the corresponding equality of interpretations.

But the file deliberately does not name those congruence facts. At the valuation layer they are tautological. The interesting structure begins only when we add `plug` and `shift`, which is the next file's job.

## Closing

`Valuation.agda` gives the weak interpretation layer:

- choose a carrier object;
- choose a self-duality witness for it;
- interpret each `O n` operation as a morphism from the iterated carrier tensor to `⊥-par`.

This is enough to say "the syntax has meanings." It is not enough to say "the meanings compose in the intended categorical way." That stronger claim is `OperadAlgebra.agda`.
