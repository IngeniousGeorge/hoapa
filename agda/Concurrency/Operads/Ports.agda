{-# OPTIONS --cubical --guardedness #-}

-- Port arithmetic for cyclic operads.
--
-- An n-ary operadic operation has n+1 cyclic ports (the "trinion"
-- shape for the binary generator: 3 ports total, n+1 = 2+1 = 3).
-- This file owns the combinatorial substrate: the Port type and the
-- cyclic-group arithmetic re-exported from Cubical.Data.Fin.Arithmetic.
--
-- Intentionally minimal. RawCyclicOperad.agda only needs Port,
-- modular addition, and the cyclic inverse (with cancellation laws)
-- to derive the rotate equivalence. Heavier port arithmetic — the
-- β delete-and-renumber, the port-gluing equivalence, and the
-- reindexing families used by CyclicAssociative.agda's laws — lives
-- in the sibling file Concurrency/Operads/PortGluing.agda
-- (decision 2026-05-18).

module Concurrency.Operads.Ports where

open import Cubical.Foundations.Prelude using (Type ; _≡_) public
open import Cubical.Data.Nat       using (ℕ ; suc)           public
open import Cubical.Data.Fin       using (Fin ; fzero ; fsuc) public
open import Cubical.Data.Fin.Arithmetic
  using (_+ₘ_ ; -ₘ_ ; _-ₘ_
        ; +ₘ-assoc ; +ₘ-comm
        ; +ₘ-lUnit ; +ₘ-rUnit
        ; +ₘ-lCancel ; +ₘ-rCancel) public

------------------------------------------------------------------------
-- Port type
--
-- An n-ary operation has n+1 cyclic ports, indexed by Fin (suc n).
-- The cyclic group ℤ/(n+1) acts on Port n via _+ₘ_.
------------------------------------------------------------------------

Port : ℕ → Type
Port n = Fin (suc n)

------------------------------------------------------------------------
-- Cyclic inverse
--
-- The cyclic-group inverse of a port. Aliased from the modular
-- additive inverse -ₘ_ for readability in operadic vocabulary at the
-- call site. The two cancellation laws below are what RawCyclicOperad
-- uses to discharge that the cyclic action `rot` is an equivalence;
-- they re-export the library's +ₘ-lCancel / +ₘ-rCancel under names
-- that read locally.
------------------------------------------------------------------------

port-inv : {n : ℕ} → Port n → Port n
port-inv x = -ₘ x

port-inv-left : {n : ℕ} (i : Port n) → port-inv i +ₘ i ≡ fzero
port-inv-left i = +ₘ-lCancel i

port-inv-right : {n : ℕ} (i : Port n) → i +ₘ port-inv i ≡ fzero
port-inv-right i = +ₘ-rCancel i
