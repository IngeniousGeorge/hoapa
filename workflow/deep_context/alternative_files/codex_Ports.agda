{-# OPTIONS --cubical --guardedness #-}

-- Codex draft: finite-port bookkeeping for cyclic operads.
--
-- This file is intentionally separate from the operation syntax. The hard
-- part of cyclic-operad associativity is not the existence of composition;
-- it is tracking how ports are reindexed after gluing. Keeping these
-- conventions here makes later associativity and rotation/compose
-- equivariance work visible instead of hiding it inside path constructors.
--
-- Convention:
--   Operation arity n has suc n ports.
--   Port n = Fin (suc n).
--
-- Composition is only defined for positive arities in the raw syntax:
--   suc left  composed with  suc right  has arity  suc (left + right).
--
-- This is the usual cyclic-operad count:
--   (suc (suc left) ports) + (suc (suc right) ports) - 2 glued ports
--     = suc (suc (left + right)) ports.
--
-- The actual reindexing functions are not implemented here yet. They are
-- the load-bearing combinatorial work needed by the associative layer.

module Concurrency.Operads.codex_Ports where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Fin using (Fin ; fzero ; fone)
open import Cubical.Data.Fin.Arithmetic
  using (_+ₘ_ ; -ₘ_ ; +ₘ-assoc ; +ₘ-lUnit ; +ₘ-rUnit ; +ₘ-rCancel ; +ₘ-lCancel)
open import Cubical.Data.Nat using (ℕ ; suc ; _+_ ; +-assoc)

------------------------------------------------------------------------
-- Port indices
------------------------------------------------------------------------

Port : ℕ → Type₀
Port arity = Fin (suc arity)

first-port : {arity : ℕ} → Port arity
first-port = fzero

second-port : {arity : ℕ} → Port (suc arity)
second-port = fone

rotate-port-index : {arity : ℕ} → Port arity → Port arity → Port arity
rotate-port-index = _+ₘ_

inverse-port-index : {arity : ℕ} → Port arity → Port arity
inverse-port-index = -ₘ_

------------------------------------------------------------------------
-- Positive-arity composition convention
------------------------------------------------------------------------

composed-arity : ℕ → ℕ → ℕ
composed-arity left right = suc (left + right)

-- The two nested sequential composites have propositionally equal arity:
--   ((a composed b) composed c) and (a composed (b composed c)).
sequential-composed-arity :
  (left right third : ℕ)
  → composed-arity (left + right) third
  ≡ composed-arity left (right + third)
sequential-composed-arity left right third =
  cong suc (sym (+-assoc left right third))

-- Parallel associativity uses a different port split: c is substituted
-- into a port coming from the left input rather than into the right input.
-- The natural-number equality is routine but not the point of this file;
-- the real work is the associated port reindexing. We leave the equality
-- postulated so the later associativity statement can name the intended
-- shape without committing the reindexing implementation prematurely.
postulate
  parallel-composed-arity :
    (left right third : ℕ)
    → composed-arity (left + right) third
    ≡ composed-arity (left + third) right

------------------------------------------------------------------------
-- Reindexing placeholders
------------------------------------------------------------------------

-- These are not functions yet because the split depends on which port of a
-- composite is selected. They are named here as the frontier for the next
-- implementation pass.
postulate
  SequentialReindexing : (left right third : ℕ) → Type₀
  ParallelReindexing   : (left right third : ℕ) → Type₀

