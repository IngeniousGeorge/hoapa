{-# OPTIONS --cubical --guardedness #-}

-- Rotation-specific port bookkeeping for cyclic operads.
--
-- PortGluing.agda owns the delete / split / rebracketing combinatorics
-- of operadic substitution. This sibling owns the rotation-side
-- combinatorics: ports and reindexing data whose purpose is to state
-- how cyclic rotation interacts with substitution.
--
-- Current contents are intentionally small. `boundary-rot` is the
-- boundary rotation used by the derived boundary-swap theorem:
-- under the linear-sum convention for composite ports, the composite
-- boundary starts with a's surviving ports and then b's surviving
-- ports, so rotating by `suc l` moves the boundary start from the
-- a-block to the b-block.
--
-- The `port-before-survivor` helper is the rotation-side reindexing
-- used by the full cyclic-equivariance constructors in
-- CyclicAssociative.agda.

module Concurrency.Operads.PortRotation where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Fin                using (Fin ; injectSuc)
open import Cubical.Data.Nat                using (ℕ ; suc ; _+_ ; +-suc)
open import Cubical.Data.Nat.Order          using (_<_)
open import Cubical.Data.Nat.Order.Inductive using (<→<ᵗ)
open import Cubical.Data.Nat.Properties     using (+-comm)

open import Concurrency.Operads.Ports

------------------------------------------------------------------------
-- Boundary rotation
------------------------------------------------------------------------

-- The composite cyclic order under the linear-sum convention starts
-- with a's (suc l) surviving ports, then b's (suc r) surviving ports.
-- Rotating the composite by `suc l` positions moves the cyclic start
-- past a's contribution, effecting the operand swap a ↔ b.
--
-- This is the boundary-swap rotation. It is not, by itself, full
-- cyclic equivariance; CyclicAssociative.agda derives boundary-swap
-- from the b-block seam case of the full cyclic-equivariance primitive.

private
  -- suc l < suc (suc (l + r))  ≡  Σ[ k ∈ ℕ ] k + suc (suc l) ≡ suc (suc (l + r))
  -- Witness with k = r and the +-suc / +-comm chain.
  suc-l-bound : ∀ l r → suc l < suc (suc (l + r))
  suc-l-bound l r = r ,
      ( r + suc (suc l)   ≡⟨ +-suc r (suc l) ⟩
        suc (r + suc l)   ≡⟨ cong suc (+-suc r l) ⟩
        suc (suc (r + l)) ≡⟨ cong (λ z → suc (suc z)) (+-comm r l) ⟩
        suc (suc (l + r)) ∎ )

boundary-rot : (l r : ℕ) → Port (suc (l + r))
boundary-rot l r = suc l , <→<ᵗ (suc-l-bound l r)

------------------------------------------------------------------------
-- Local rotation origins
------------------------------------------------------------------------

-- In a cyclic port list, selecting survivor k as the new first visible
-- port is equivalent to gluing at the port immediately before it.
port-before-survivor : {n : ℕ} → Port (suc n) → Fin (suc n) → Port (suc n)
port-before-survivor i k = i +ₘ injectSuc k

port-before-survivor-zero :
  {n : ℕ} (i : Port (suc n)) → port-before-survivor i fzero ≡ i
port-before-survivor-zero i = +ₘ-rUnit i
