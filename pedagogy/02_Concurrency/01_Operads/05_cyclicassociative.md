# CyclicAssociative.agda — the cyclic associative operad `O_1`

## Where This File Sits

`agda/Concurrency/Operads/CyclicAssociative.agda` is the destination of the operads folder. The earlier files prepared the pieces:

- `Ports.agda`: finite cyclic ports;
- `RawCyclicOperad.agda`: generator, substitution, and rotation without the full laws;
- `PortGluing.agda`: delete/split/reindexing helpers;
- `PortRotation.agda`: rotation-side helpers.

This file finally defines `O_1`: the cyclic associative operad with one binary generator. It does so by copying the raw HIT and adding the law constructors that make substitution associative and rotation compatible with substitution.

The architectural decision is important: the laws are part of the type. They are not bolted on afterward as external theorems about a raw syntax. That makes every function out of this `O` respect the laws by HIT recursion.

## Chunk 1 — preamble and imports

```agda
{-# OPTIONS --cubical --guardedness #-}

-- The cyclic associative operad on one binary generator.
--
-- This file presents O_1: a cyclic operad with one binary generator,
-- the cyclic-group action on its ports, and the cyclic-operad laws
-- (sequential associativity, parallel associativity, cyclic
-- equivariance).
```

The file presents the actual object downstream Concurrency code imports. `RawCyclicOperad.agda` remains useful as a pedagogical "before the laws" version, but this is the operative syntax.

```agda
module Concurrency.Operads.CyclicAssociative where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Isomorphism using (iso ; isoToEquiv)
open import Cubical.Foundations.Equiv       using (_≃_ ; equivFun)
open import Cubical.Data.Fin.Properties     using (Fin-fst-≡)
open import Cubical.Data.Nat                using (ℕ ; suc ; _+_)
open import Cubical.Data.Nat.Properties     using (+-assoc ; +-comm ; +-zero)
open import Cubical.Data.Sum                using (inl ; inr)

open import Concurrency.Operads.Ports
open import Concurrency.Operads.PortGluing
  using ( delete-port
        ; port-glue
        ; b-port-after-inner-glue ; a-port-after-inner-glue
        )
open import Concurrency.Operads.PortRotation
  using ( boundary-rot
        ; port-before-survivor ; port-before-survivor-zero
        )
```

The imports show exactly which helper facts the laws need. The associativity laws use `delete-port`, `port-glue`, and the after-inner-glue functions. The cyclic-equivariance laws use `boundary-rot` and `port-before-survivor`.

`Fin-fst-≡` appears later in the boundary-swap derivation. It proves equality between finite indices by proving equality of their underlying natural-number part.

## Chunk 2 — arity rebracketing

```agda
parallel-arity-eq : (l r p : ℕ) → (l + r) + p ≡ (l + p) + r
parallel-arity-eq l r p =
    (l + r) + p   ≡⟨ sym (+-assoc l r p)       ⟩
    l + (r + p)   ≡⟨ cong (l +_) (+-comm r p)  ⟩
    l + (p + r)   ≡⟨ +-assoc l p r             ⟩
    (l + p) + r   ∎
```

Some laws compare operations whose arities are propositionally equal but not definitionally the same expression.

Sequential associativity only needs the standard associativity path:

```agda
(l + r) + p ≡ l + (r + p)
```

Parallel associativity needs a reordering:

```agda
(l + r) + p ≡ (l + p) + r
```

That is what `parallel-arity-eq` proves: reassociate, commute `r` and `p`, reassociate back.

The comment says this lemma is exposed because downstream algebra files must refer to the exact same path when interpreting the HIT law. This is one of those Agda details where "same theorem shape" is not enough; the recursor wants the path term it is matching.

## Chunk 3 — the copied HIT plus new laws

```agda
data O : ℕ → Type where
  gen         : O 2

  compₒ       : {l r : ℕ}
              → Port (suc l) → Port (suc r)
              → O (suc l) → O (suc r)
              → O (suc (l + r))

  rot         : {n : ℕ} → Port n → O n → O n

  rot-zero    : {n : ℕ} (a : O n)
              → rot fzero a ≡ a

  rot-compose : {n : ℕ} (i j : Port n) (a : O n)
              → rot i (rot j a) ≡ rot (i +ₘ j) a
```

The first part is the raw syntax copied over: one binary generator, substitution, rotation, and the rotation group laws.

Why copy instead of importing the raw `O` and quotienting it by extra laws? Because functions out of quotient-style syntax would constantly have to prove they respect the quotient. With HIT-by-copy, the laws are constructors of the object itself; a function out of `O` handles them in its recursion clauses.

## Chunk 4 — sequential associativity

```agda
  compₒ-assoc-seq :
      {l r p : ℕ}
      (i : Port (suc l)) (j : Port (suc r)) (k' : Port (suc p))
      (y : Fin (suc r))
      (a : O (suc l)) (b : O (suc r)) (c : O (suc p))
    → PathP (λ ι → O (suc (sym (+-assoc l r p) ι)))
        (compₒ (port-glue {l} {r} (inr y)) k'
               (compₒ i j a b) c)
        (compₒ i (port-glue {r} {p} (inl (b-port-after-inner-glue {r} y)))
               a (compₒ (delete-port j y) k' b c))
```

Sequential associativity covers the case where we first form `a ∘ b`, then glue `c` onto a port of the composite that came from `b`.

The left endpoint says:

```text
(a glued to b) glued to c
```

where the outer port is `port-glue (inr y)`, meaning the chosen composite port lies in the right-side, `b`-survivor block.

The right endpoint says:

```text
a glued to (b glued to c)
```

The inner gluing in `b ∘ c` uses `delete-port j y`: the original `b` port corresponding to survivor `y` after deleting `j`. Then the outer gluing uses `b-port-after-inner-glue y`, which names where the old inner gluing port of `b` lands after rebracketing.

The endpoints live over arities that are equal by associativity of addition. That is why the result is a `PathP`, a path whose type varies along the arity equality.

## Chunk 5 — parallel associativity

```agda
  compₒ-assoc-par :
      {l r p : ℕ}
      (i : Port (suc l)) (j : Port (suc r)) (k' : Port (suc p))
      (x : Fin (suc l))
      (a : O (suc l)) (b : O (suc r)) (c : O (suc p))
    → PathP (λ ι → O (suc (parallel-arity-eq l r p ι)))
        (compₒ (port-glue {l} {r} (inl x)) k'
               (compₒ i j a b) c)
        (compₒ (port-glue {l} {p} (inl (a-port-after-inner-glue {l} x))) j
               (compₒ (delete-port i x) k' a c) b)
```

Parallel associativity is the symmetric situation: the outer gluing port of `(a ∘ b) ∘ c` came from `a`, not from `b`.

So the rebracketed form is:

```text
(a glued to c) glued to b
```

This is why the arity equality is not plain associativity; it moves `p` next to `l`:

```text
(l + r) + p = (l + p) + r
```

The helper `a-port-after-inner-glue x` plays the same role as the `b` helper in the sequential law.

## Chunk 6 — cyclic equivariance, a-block

```agda
  rot-compₒ-a-block :
      {l r : ℕ}
      (i : Port (suc l)) (j : Port (suc r))
      (x : Fin (suc l))
      (a : O (suc l)) (b : O (suc r))
    → rot (port-glue {l} {r} (inl x)) (compₒ i j a b)
        ≡ compₒ (port-before-survivor i x) j a b
```

This is the first half of full cyclic equivariance.

We rotate the composite so that the new first visible port lies in the `a` block: `port-glue (inl x)`. In that case the operand order stays the same. The only change is local: the gluing port on `a` moves to the port immediately before the chosen survivor.

That local movement is exactly:

```agda
port-before-survivor i x
```

So the law says: rotating the composite to an `a`-survivor is the same as presenting the same composite with the adjusted `a` gluing port.

## Chunk 7 — cyclic equivariance, b-block

```agda
  rot-compₒ-b-block :
      {l r : ℕ}
      (i : Port (suc l)) (j : Port (suc r))
      (y : Fin (suc r))
      (a : O (suc l)) (b : O (suc r))
    → PathP (λ ι → O (suc (+-comm l r ι)))
        (rot (port-glue {l} {r} (inr y)) (compₒ i j a b))
        (compₒ (port-before-survivor j y) i b a)
```

This is the second half. Now the new first visible port lies in the `b` block.

Crossing from the `a` block into the `b` block crosses the operand boundary. The presentation swaps operands:

```text
a glued to b
```

becomes:

```text
b glued to a
```

The arity changes from `suc (l + r)` to `suc (r + l)`, so the equality again lives in `PathP`, now over `+-comm l r`.

The seam case `y = fzero` is the one that will become the boundary-swap theorem. Boundary-swap used to be the tempting primitive law, but this file makes the stronger and more correct choice: full cyclic equivariance is primitive; boundary-swap is derived.

## Chunk 8 — truncation and law-target aliases

```agda
  trunc       : {n : ℕ} (x y : O n) (p q : x ≡ y) → p ≡ q

rot-compₒ-a-block-target : ...
rot-compₒ-b-block-target : ...
rot-compₒ-seam-target : ...
```

`trunc` keeps each `O n` set-level, as in the raw file.

The three `...-target` definitions after the HIT do not add new structure. They expose the types of the cyclic-equivariance laws as ordinary named types. That matters for later algebra files: instead of re-expanding a long `PathP` with port arithmetic every time, they can refer to the target shape by name or mirror it cleanly.

## Chunk 9 — boundary rotation is the b-seam

```agda
boundary-rot-is-b-seam :
    {l r : ℕ}
  → port-glue {l} {r} (inr fzero) ≡ boundary-rot l r
boundary-rot-is-b-seam {l} {r} =
  Fin-fst-≡ {n = suc (suc (l + r))} (cong suc (+-zero l))
```

This proves that the first right-side survivor, `port-glue (inr fzero)`, is the boundary rotation `boundary-rot l r`.

Conceptually this is obvious from the linear-sum convention: the right block starts immediately after the `suc l` left survivors. Agda needs the finite-index proof. `Fin-fst-≡` reduces equality of finite indices to equality of their underlying natural numbers.

## Chunk 10 — deriving boundary-swap from the seam

```agda
boundary-swap-from-seam :
    {l r : ℕ}
    (i : Port (suc l)) (j : Port (suc r))
    (a : O (suc l)) (b : O (suc r))
  → rot-compₒ-seam-target i j a b
  → PathP (λ ι → O (suc (+-comm l r ι)))
      (rot (boundary-rot l r) (compₒ i j a b))
      (compₒ j i b a)
```

This function turns the b-block seam case into the familiar boundary-swap statement.

It uses two bookkeeping lemmas:

- `port-glue (inr fzero) = boundary-rot l r`;
- `port-before-survivor j fzero = j`.

The implementation uses `subst` twice to rewrite the seam statement into the desired endpoint shape. No new operadic law is being added here. It is a transport exercise: same theorem, better-known formulation.

```agda
boundary-swap :
    {l r : ℕ}
    (i : Port (suc l)) (j : Port (suc r))
    (a : O (suc l)) (b : O (suc r))
  → PathP (λ ι → O (suc (+-comm l r ι)))
      (rot (boundary-rot l r) (compₒ i j a b))
      (compₒ j i b a)
boundary-swap i j a b =
  boundary-swap-from-seam i j a b
    (rot-compₒ-b-block i j fzero a b)
```

`boundary-swap` is the theorem the algebra layer will use. It says: rotate a composite across the boundary between operands, and you get the operand-swapped composite, over the arity commutation path.

This is the local operadic face that later connects to session duality. The file is careful not to call rotation itself an involution.

## Chunk 11 — rotation is still an equivalence

```agda
rotate-equiv : {n : ℕ} → Port n → O n ≃ O n
rotate-equiv {n} i = isoToEquiv (iso (rot i) (rot (port-inv i)) right-inv left-inv)
  where
    right-inv : (a : O n) → rot i (rot (port-inv i) a) ≡ a
    ...

    left-inv : (a : O n) → rot (port-inv i) (rot i a) ≡ a
    ...

rotate : {n : ℕ} → Port n → O n → O n
rotate i = equivFun (rotate-equiv i)
```

This is the same proof pattern as in `RawCyclicOperad.agda`: rotation by `i` is inverted by rotation by `port-inv i`.

The new law constructors do not change the group-action proof. The proof still uses only `rot-compose`, the port inverse cancellation laws, and `rot-zero`.

`rotate` is again the public function extracted from the equivalence.

## Chunk 12 — sanity checks

```agda
private
  _ : O 2
  _ = gen

  _ : O 3
  _ = compₒ fzero fzero gen gen

  _ : O 2
  _ = rot fzero gen

  _ : O 2
  _ = rot (fsuc fzero) gen

  _ : O 2
  _ = rot (fsuc (fsuc fzero)) gen
```

The sanity checks mirror the raw file: `gen` is binary, composing `gen` with itself produces an arity-3 operation, and rotating `gen` at each of its three ports is well-typed.

They are not theorems. They are small inhabitability checks that the constructors are usable with the intended arities.

## Closing

`CyclicAssociative.agda` completes the operads folder's first object:

- the raw syntax is copied into a new HIT;
- sequential and parallel associativity are added as path constructors;
- full cyclic equivariance is added in a-block and b-block forms;
- boundary-swap is derived from the b-block seam;
- rotation remains an equivalence.

Downstream code should import this `O`, not the raw one. The raw file is still useful for understanding the construction before the law burden appears, but `CyclicAssociative.agda` is the actual `O_1` artifact used by the algebra layer.
