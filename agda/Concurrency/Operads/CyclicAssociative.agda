{-# OPTIONS --cubical --guardedness #-}

-- The cyclic associative operad on one binary generator.
--
-- This file presents O_1: a cyclic operad with one binary generator,
-- the cyclic-group action on its ports, and the cyclic-operad laws
-- (sequential associativity, parallel associativity, cyclic
-- equivariance). The earlier file Concurrency/Operads/RawCyclicOperad.agda
-- presented the same HIT without the law constructors, as a
-- "without-laws" reference; downstream concurrency-side code imports
-- from here, not from RawCyclicOperad.
--
-- Architectural decision 2026-05-18: HIT-by-copy. The cyclic associative
-- operad's laws are part of its type, not theorems added after the
-- fact. Concretely, this HIT re-declares the generator / composition /
-- rotation / cancellation / truncation constructors of
-- RawCyclicOperad.O and adds four new path constructors for the laws.
-- The quotient alternative would force every function out of O to
-- respect the quotient — heavier to use.
--
-- Naming discipline:
--   * Cyclic action is `rot` (HIT constructor) / `rotate` (derived
--     function). Never `involution` — cyclic rotation has order n+1,
--     not order 2; session-type duality is the involutive structure
--     and lives on the algebra side (R8 in workflow/status.md).
--   * `compₒ` (subscript-o U+2092) for operadic substitution, to
--     dodge cubical's `comp` Kan-composition primitive.
--   * Positive-arity inputs: compₒ requires both operands of arity
--     ≥ 1 (decision 2026-05-18; see RawCyclicOperad.agda header).
--
-- The law constructors:
--
--   compₒ-assoc-seq — sequential associativity. When the outer gluing
--     port came from b at surviving-index y, re-bracketing produces
--     b ∘ c first (at b-port delete-port j y), then a ∘ (b ∘ c) at
--     a-port i to the port of (b ∘ c) that "used to be" b-port j.
--     Under β, the latter port has the closed form
--     port-glue (inl (b-port-after-inner-glue y)).
--
--   compₒ-assoc-par — parallel associativity. Symmetric: outer port
--     came from a at surviving-index x, re-bracketing produces a ∘ c
--     first, then (a ∘ c) ∘ b.
--
--   rot-compₒ-a-block / rot-compₒ-b-block — cyclic equivariance in the
--     arbitrary-port presentation. A rotation of a composite is classified
--     by whether the new first visible port lies in a's surviving block or
--     b's surviving block. The b-block seam specializes to the former
--     boundary-rotation operand-swap law, now derived below as
--     `boundary-swap`.
--
--     Ass_cyc / planarity makes the boundary-swap theorem natural, but
--     does not make boundary-swap alone a complete cyclic axiom. Full
--     cyclic equivariance is the primitive content here.

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

------------------------------------------------------------------------
-- Arity-equality lemmas for the law PathPs
------------------------------------------------------------------------

private
  -- Parallel-associative arity rebracketing:
  -- (l + r) + p ≡ (l + p) + r, via assoc / comm / assoc.
  parallel-arity-eq : (l r p : ℕ) → (l + r) + p ≡ (l + p) + r
  parallel-arity-eq l r p =
      (l + r) + p   ≡⟨ sym (+-assoc l r p)       ⟩
      l + (r + p)   ≡⟨ cong (l +_) (+-comm r p)  ⟩
      l + (p + r)   ≡⟨ +-assoc l p r             ⟩
      (l + p) + r   ∎

------------------------------------------------------------------------
-- The HIT
------------------------------------------------------------------------

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

  -- Sequential associativity.
  compₒ-assoc-seq :
      {l r p : ℕ}
      (i : Port (suc l)) (j : Port (suc r)) (k' : Port (suc p))
      (y : Fin (suc r))     -- surviving-index in b after deletion of j
      (a : O (suc l)) (b : O (suc r)) (c : O (suc p))
    → PathP (λ ι → O (suc (sym (+-assoc l r p) ι)))
        (compₒ (port-glue {l} {r} (inr y)) k'
               (compₒ i j a b) c)
        (compₒ i (port-glue {r} {p} (inl (b-port-after-inner-glue {r} y)))
               a (compₒ (delete-port j y) k' b c))

  -- Parallel associativity.
  compₒ-assoc-par :
      {l r p : ℕ}
      (i : Port (suc l)) (j : Port (suc r)) (k' : Port (suc p))
      (x : Fin (suc l))     -- surviving-index in a after deletion of i
      (a : O (suc l)) (b : O (suc r)) (c : O (suc p))
    → PathP (λ ι → O (suc (parallel-arity-eq l r p ι)))
        (compₒ (port-glue {l} {r} (inl x)) k'
               (compₒ i j a b) c)
        (compₒ (port-glue {l} {p} (inl (a-port-after-inner-glue {l} x))) j
               (compₒ (delete-port i x) k' a c) b)

  -- Cyclic equivariance, a-block case.
  --
  -- Rotating a composite to a port in a's surviving block preserves the
  -- operand order. In the arbitrary-port presentation, the same composite
  -- is presented by moving a's local gluing port to the port immediately
  -- before the chosen survivor.
  rot-compₒ-a-block :
      {l r : ℕ}
      (i : Port (suc l)) (j : Port (suc r))
      (x : Fin (suc l))
      (a : O (suc l)) (b : O (suc r))
    → rot (port-glue {l} {r} (inl x)) (compₒ i j a b)
        ≡ compₒ (port-before-survivor i x) j a b

  -- Cyclic equivariance, b-block case.
  --
  -- Rotating a composite to a port in b's surviving block crosses the
  -- operand boundary, so the presentation swaps operands and lives over
  -- the commuted arity. The seam case y = fzero is the boundary-swap
  -- theorem below.
  rot-compₒ-b-block :
      {l r : ℕ}
      (i : Port (suc l)) (j : Port (suc r))
      (y : Fin (suc r))
      (a : O (suc l)) (b : O (suc r))
    → PathP (λ ι → O (suc (+-comm l r ι)))
        (rot (port-glue {l} {r} (inr y)) (compₒ i j a b))
        (compₒ (port-before-survivor j y) i b a)

  trunc       : {n : ℕ} (x y : O n) (p q : x ≡ y) → p ≡ q

------------------------------------------------------------------------
-- Full cyclic-equivariance law shapes
------------------------------------------------------------------------

-- These aliases expose the two constructor shapes as ordinary types.
-- They are useful documentation for the quotient data above and give
-- later algebra files named targets to reference without re-expanding
-- the port arithmetic.

-- Rotation whose new first composite port lies in a's surviving block.
-- The same composite can be presented by moving a's local gluing port to
-- the port immediately before that survivor.
rot-compₒ-a-block-target :
    {l r : ℕ}
    (i : Port (suc l)) (j : Port (suc r))
    (x : Fin (suc l))
    (a : O (suc l)) (b : O (suc r))
  → Type
rot-compₒ-a-block-target {l} {r} i j x a b =
  rot (port-glue {l} {r} (inl x)) (compₒ i j a b)
    ≡ compₒ (port-before-survivor i x) j a b

-- Rotation whose new first composite port lies in b's surviving block.
-- The presentation crosses the operand boundary, so the endpoints live
-- over the commuted arity.
rot-compₒ-b-block-target :
    {l r : ℕ}
    (i : Port (suc l)) (j : Port (suc r))
    (y : Fin (suc r))
    (a : O (suc l)) (b : O (suc r))
  → Type
rot-compₒ-b-block-target {l} {r} i j y a b =
  PathP (λ ι → O (suc (+-comm l r ι)))
    (rot (port-glue {l} {r} (inr y)) (compₒ i j a b))
    (compₒ (port-before-survivor j y) i b a)

-- The seam case is the first b-survivor. This is the bridge to the
-- derived boundary-swap statement, using two Fin bookkeeping lemmas:
--   port-glue (inr fzero)       = boundary-rot l r
--   port-before-survivor j fzero = j
rot-compₒ-seam-target :
    {l r : ℕ}
    (i : Port (suc l)) (j : Port (suc r))
    (a : O (suc l)) (b : O (suc r))
  → Type
rot-compₒ-seam-target i j a b =
  rot-compₒ-b-block-target i j fzero a b

boundary-rot-is-b-seam :
    {l r : ℕ}
  → port-glue {l} {r} (inr fzero) ≡ boundary-rot l r
boundary-rot-is-b-seam {l} {r} =
  Fin-fst-≡ {n = suc (suc (l + r))} (cong suc (+-zero l))

boundary-swap-from-seam :
    {l r : ℕ}
    (i : Port (suc l)) (j : Port (suc r))
    (a : O (suc l)) (b : O (suc r))
  → rot-compₒ-seam-target i j a b
  → PathP (λ ι → O (suc (+-comm l r ι)))
      (rot (boundary-rot l r) (compₒ i j a b))
      (compₒ j i b a)
boundary-swap-from-seam {l} {r} i j a b seam =
  subst
    (λ p →
      PathP (λ ι → O (suc (+-comm l r ι)))
        (rot p (compₒ i j a b))
        (compₒ j i b a))
    boundary-rot-is-b-seam
    (subst
      (λ q →
        PathP (λ ι → O (suc (+-comm l r ι)))
          (rot (port-glue {l} {r} (inr fzero)) (compₒ i j a b))
          (compₒ q i b a))
      (port-before-survivor-zero j)
      seam)

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

------------------------------------------------------------------------
-- Cyclic action as an equivalence
--
-- Same derivation as in RawCyclicOperad.agda. `rot i` is invertible
-- with inverse `rot (port-inv i)`, discharged by `rot-compose` plus
-- the cancellation laws from Ports.agda.
------------------------------------------------------------------------

rotate-equiv : {n : ℕ} → Port n → O n ≃ O n
rotate-equiv {n} i = isoToEquiv (iso (rot i) (rot (port-inv i)) right-inv left-inv)
  where
    right-inv : (a : O n) → rot i (rot (port-inv i) a) ≡ a
    right-inv a =
        rot i (rot (port-inv i) a)
      ≡⟨ rot-compose i (port-inv i) a ⟩
        rot (i +ₘ port-inv i) a
      ≡⟨ cong (λ z → rot z a) (port-inv-right i) ⟩
        rot fzero a
      ≡⟨ rot-zero a ⟩
        a ∎

    left-inv : (a : O n) → rot (port-inv i) (rot i a) ≡ a
    left-inv a =
        rot (port-inv i) (rot i a)
      ≡⟨ rot-compose (port-inv i) i a ⟩
        rot (port-inv i +ₘ i) a
      ≡⟨ cong (λ z → rot z a) (port-inv-left i) ⟩
        rot fzero a
      ≡⟨ rot-zero a ⟩
        a ∎

rotate : {n : ℕ} → Port n → O n → O n
rotate i = equivFun (rotate-equiv i)

------------------------------------------------------------------------
-- Sanity checks
------------------------------------------------------------------------

private
  _ : O 2
  _ = gen

  _ : O 3
  _ = compₒ fzero fzero gen gen

  -- Rotating gen at each of its three ports yields three well-typed
  -- arity-2 operations. (Not theorems — type-level witnesses only.)
  _ : O 2
  _ = rot fzero gen

  _ : O 2
  _ = rot (fsuc fzero) gen

  _ : O 2
  _ = rot (fsuc (fsuc fzero)) gen
