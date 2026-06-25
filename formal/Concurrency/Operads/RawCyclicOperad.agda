{-# OPTIONS --cubical --guardedness #-}

-- The raw cyclic operad on one binary generator.
--
-- "Raw" = the syntactic and cyclic-action layer of the cyclic
-- associative operad. The associativity laws (sequential and parallel)
-- and the compatibility of the cyclic action with substitution
-- (rotate-comp equivariance) both require port-reindexing machinery
-- and live in Concurrency/Operads/CyclicAssociative.agda. This file
-- presents the generator, substitution, cyclic action, and the
-- cyclic action's group laws — the structure that doesn't yet
-- involve port-reindexing.
--
-- Semantic background: the smallest cyclic operad capable of naming
-- the actor/session interaction primitive. One binary operation
-- (`gen`); planar / cyclic-associative (not fully symmetric); a
-- ℤ/(n+1) cyclic action on the n+1 ports of each n-ary operation.
-- R8 in workflow/status.md ties the cyclic rotation at arity 2 to
-- session-type duality, but session duality is a *separate*
-- involutive equivalence on the algebra side — not encoded here.
--
-- Naming discipline (load-bearing): the cyclic action is `rot` (the
-- constructor) / `rotate` (the derived equivalence), NOT
-- `involution`. Cyclic rotation has order n+1, not order 2. Session
-- duality is the involutive structure (order 2) and lives on the
-- algebra side.
--
-- Operations are set-truncated via a `trunc` path constructor per
-- arity (cubical HIT idiom). ∞-enrichment is a later upgrade.

module Concurrency.Operads.RawCyclicOperad where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Isomorphism using (Iso ; iso ; isoToEquiv)
open import Cubical.Foundations.Equiv       using (_≃_ ; equivFun)
open import Cubical.Data.Nat                using (ℕ ; suc ; _+_)

open import Concurrency.Operads.Ports

------------------------------------------------------------------------
-- Arity / port convention
--
-- An n-ary operation has n+1 cyclic ports. Substitution
-- `compₒ i j a b` glues port i of a (suc l)-ary op `a` to port j of
-- a (suc r)-ary op `b`, leaving (suc l + 1) + (suc r + 1) - 2 =
-- l + r + 2 ports remaining, hence arity suc (l + r).
--
-- Inputs are positive-arity (≥ 1): under the current generator set
-- (one binary `gen`), no nullary ops are reachable, and the positive
-- restriction makes the port-gluing iso
--   Port (suc (l + r)) ≃ Fin (suc l) ⊎ Fin (suc r)
-- total. (See PortGluing.agda; decision 2026-05-18.) The earlier
-- monus-based signature `O (m + n ∸ 1)` had Port 0 = Fin 1 vs
-- Fin 0 ⊎ Fin 0 = ∅ at m = n = 0, which the positive-only form
-- avoids cleanly. Reachable arities are unchanged (`gen : O 2`,
-- `compₒ gen gen : O 3`, etc.).
--
-- The port-reindexing that names the surviving ports of the
-- composite is not introduced at this layer; it enters with the
-- associativity / equivariance laws in CyclicAssociative.agda
-- (combinatorial substrate in PortGluing.agda).
------------------------------------------------------------------------

------------------------------------------------------------------------
-- The HIT
--
-- O n : type of n-ary operations of the raw cyclic operad on one
-- binary generator.
--
-- Constructors:
--   gen          binary generator at arity 2 (3 cyclic ports total).
--   compₒ        operadic substitution at positive arities. Subscript
--                `o` avoids the clash with cubical Agda's `comp` (Kan
--                composition primitive); the operation here is
--                operadic substitution at marked ports, unrelated to
--                Kan composition. Composes a (suc l)-ary and a
--                (suc r)-ary op into a suc (l + r)-ary op.
--   rot          cyclic-group action per arity, as a function-shaped
--                constructor (so the equivalence package can be
--                derived outside the data declaration).
--   rot-zero     the group identity acts as the identity.
--   rot-compose  rot composes additively in the port index (i.e.
--                under the modular group operation _+ₘ_ on Port n).
--   trunc        set-truncation per arity (cubical HIT idiom).
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

  trunc       : {n : ℕ} (x y : O n) (p q : x ≡ y) → p ≡ q

------------------------------------------------------------------------
-- The cyclic action as an equivalence
--
-- For each port index `i`, the function `rot i : O n → O n` is an
-- equivalence with inverse `rot (port-inv i)`. The proofs collapse
-- via `rot-compose` and the cancellation laws from Ports.agda:
--
--   rot (port-inv i) ∘ rot i ≡ rot (port-inv i +ₘ i)  [rot-compose]
--                            ≡ rot fzero              [port-inv-left]
--                            ≡ id                     [rot-zero]
--
-- and dually for the other side via port-inv-right.
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

-- Convenience: the cyclic action as a plain function. (Equal to the
-- constructor `rot` definitionally; named here to read the public
-- API as "rotate by this port offset" while keeping `rot` as the
-- HIT-level identifier the path constructors refer to.)
rotate : {n : ℕ} → Port n → O n → O n
rotate i = equivFun (rotate-equiv i)

------------------------------------------------------------------------
-- Sanity checks
--
-- Concrete inhabitants confirming the constructors are usable.
-- Not theorems — type-level witnesses only.
------------------------------------------------------------------------

private
  -- The binary generator lives at arity 2.
  _ : O 2
  _ = gen

  -- Rotating the binary generator at each of its three cyclic ports
  -- produces three (not necessarily distinct, but well-typed) arity-2
  -- operations.
  _ : O 2
  _ = rot fzero gen

  _ : O 2
  _ = rot (fsuc fzero) gen

  _ : O 2
  _ = rot (fsuc (fsuc fzero)) gen

  -- Substituting the generator into itself at the first port of each
  -- gives a 3-ary operation (gen : O 2 = O (suc 1); compₒ {1} {1}
  -- gives O (suc (1 + 1)) = O 3).
  _ : O 3
  _ = compₒ fzero fzero gen gen
