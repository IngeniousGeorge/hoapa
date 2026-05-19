{-# OPTIONS --cubical --guardedness #-}

-- Port-gluing combinatorial substrate for the cyclic associative operad.
--
-- This file owns the heavier port arithmetic that CyclicAssociative.agda
-- needs to state its laws:
--   * delete-and-renumber (β convention), parameterizing surviving ports
--     by the deleted port;
--   * the port-gluing equivalence
--       Port (suc (l + r)) ≃ Fin (suc l) ⊎ Fin (suc r),
--     which classifies the composite's ports as coming from `a` or `b`;
--   * reindexing families that compute the gluing-port location after
--     re-bracketing (sequential / parallel associativity).
--
-- Rotation-specific reindexing, including the boundary rotation used by
-- cyclic equivariance / boundary-swap, lives in the sibling file
-- Concurrency/Operads/PortRotation.agda.
--
-- β convention (decision 2026-05-18): delete-port i k = i +ₘ fsuc k.
-- This anchors the renumbering of surviving ports to the deleted port
-- itself (not to fzero), making per-operand cyclic action commute with
-- delete-and-renumber by construction. The alternative (linear punch-in,
-- using < order on Fin) would force rot-compₒ to absorb the discrepancy
-- between the linear order and the cyclic action.
--
-- The port-gluing equivalence itself uses the linear-sum convention
-- from the cubical library (Fin+≅Fin⊎Fin): composite-index k is in the
-- inl branch (a-side) iff k < suc l. The cyclic content of the operad
-- lives in delete-port and in the reindexing functions, not in the
-- sum-iso's bijection.

module Concurrency.Operads.PortGluing where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv       using (_≃_ ; equivFun ; invEq ; compEquiv)
open import Cubical.Foundations.Isomorphism using (isoToEquiv)
open import Cubical.Foundations.Univalence  using (pathToEquiv)
open import Cubical.Data.Nat                using (ℕ ; suc ; _+_ ; +-suc)
open import Cubical.Data.Nat.Properties     using (snotz)
open import Cubical.Data.Fin                using (Fin ; fzero ; fsuc ; predFin)
open import Cubical.Data.Fin.Properties     using (Fin+≅Fin⊎Fin)
open import Cubical.Data.Sum                using (_⊎_ ; inl ; inr)
open import Cubical.Relation.Nullary        using (¬_)

open import Concurrency.Operads.Ports

------------------------------------------------------------------------
-- β delete-and-renumber
------------------------------------------------------------------------

-- `delete-port i k` is the surviving port at renumbered-index `k` of
-- an operation of arity (suc n) after deletion of port `i`. Under β,
-- the surviving port at renumbered-index 0 is the port immediately
-- after `i` in cyclic order (i +ₘ fone); renumbered-index 1 is the
-- next one (i +ₘ ftwo); and so on. Cyclic-equivariant: under the
-- per-operand cyclic action, delete-port commutes with the rotation
-- (rot k ∘ delete-port i = delete-port (i +ₘ k) up to reindexing).
delete-port : {n : ℕ} → Port (suc n) → Fin (suc n) → Port (suc n)
delete-port i k = i +ₘ fsuc k

------------------------------------------------------------------------
-- β sanity checks
--
-- Two small internal checks of the β convention:
--   (1) delete-port i k is never the deleted port i (the puncture is
--       total: every k : Fin (suc n) picks a *surviving* port).
--   (2) delete-port commutes with per-operand cyclic rotation: the
--       conceptual content of the β convention. This is what β buys
--       over the linear-α convention.
------------------------------------------------------------------------

delete-port-not-deleted : {n : ℕ} (i : Port (suc n)) (k : Fin (suc n))
                        → ¬ (delete-port i k ≡ i)
delete-port-not-deleted {n} i k path = snotz (cong fst fsuc-eq-fzero)
  where
    fsuc-eq-fzero : fsuc k ≡ fzero
    fsuc-eq-fzero =
        fsuc k                       ≡⟨ sym (+ₘ-lUnit (fsuc k))            ⟩
        fzero +ₘ fsuc k              ≡⟨ cong (_+ₘ fsuc k) (sym (+ₘ-lCancel i)) ⟩
        ((-ₘ i) +ₘ i) +ₘ fsuc k      ≡⟨ +ₘ-assoc (-ₘ i) i (fsuc k)         ⟩
        (-ₘ i) +ₘ (i +ₘ fsuc k)      ≡⟨ cong ((-ₘ i) +ₘ_) path             ⟩
        (-ₘ i) +ₘ i                  ≡⟨ +ₘ-lCancel i                       ⟩
        fzero                        ∎

delete-port-equivariant : {n : ℕ} (i k : Port (suc n)) (j : Fin (suc n))
                        → delete-port (i +ₘ k) j ≡ i +ₘ delete-port k j
delete-port-equivariant i k j = +ₘ-assoc i k (fsuc j)

------------------------------------------------------------------------
-- Port-gluing equivalence
--
-- The composite compₒ i j a b : O (suc (l + r)) has its
-- (suc (suc (l + r))) ports split into l+1 from a (surviving ports of
-- a under deletion of i) and r+1 from b (surviving ports of b under
-- deletion of j). The bijection between composite-port-indices and
-- the sum Fin (suc l) ⊎ Fin (suc r) is the library
-- Fin+≅Fin⊎Fin (suc l) (suc r) after an arity cast through +-suc.
--
-- Convention: composite-index k is in the inl branch (a-side) iff
-- k < suc l. This is the linear partition; the cyclic content lives
-- in delete-port and in the reindexing functions below.
------------------------------------------------------------------------

private
  arity-cast : ∀ l r → Fin (suc (suc (l + r))) ≡ Fin (suc l + suc r)
  arity-cast l r = cong Fin (sym (cong suc (+-suc l r)))

port-gluing-equiv : {l r : ℕ}
                  → Port (suc (l + r)) ≃ Fin (suc l) ⊎ Fin (suc r)
port-gluing-equiv {l} {r} =
  compEquiv (pathToEquiv (arity-cast l r))
            (isoToEquiv (Fin+≅Fin⊎Fin (suc l) (suc r)))

port-glue : {l r : ℕ} → Fin (suc l) ⊎ Fin (suc r) → Port (suc (l + r))
port-glue = invEq port-gluing-equiv

port-split : {l r : ℕ} → Port (suc (l + r)) → Fin (suc l) ⊎ Fin (suc r)
port-split = equivFun port-gluing-equiv

------------------------------------------------------------------------
-- Reindexing for sequential / parallel associativity
--
-- Setup (sequential): outer gluing port came from b at surviving-index
-- y, so the original composition is
--   compₒ (port-glue (inr y)) k' (compₒ i j a b) c.
-- Re-bracket: b ∘ c first, gluing at b-port `delete-port j y`. Then
-- a ∘ (b ∘ c), gluing a-port `i` to the port of (b ∘ c) that "used to
-- be" b-port `j`. Under β, the surviving-index of `j` in the new
-- composite is independent of `j` (the j cancels):
--   fsuc q ≡ -ₘ fsuc y in Fin (suc (suc r)),
-- which means q = (r ∸ y) in Fin (suc r). Concretely:
--   q = predFin r (-ₘ fsuc y).
-- The parallel case is symmetric, with l in place of r and x in
-- place of y.
------------------------------------------------------------------------

-- The new index of b's former inner-glue port in the (b ∘ c) composite,
-- as a Fin (suc r). Used in compₒ-assoc-seq.
b-port-after-inner-glue : {r : ℕ} → Fin (suc r) → Fin (suc r)
b-port-after-inner-glue {r} y = predFin r (-ₘ fsuc y)

-- The new index of a's former inner-glue port in the (a ∘ c) composite,
-- as a Fin (suc l). Used in compₒ-assoc-par. Same shape as the b case.
a-port-after-inner-glue : {l : ℕ} → Fin (suc l) → Fin (suc l)
a-port-after-inner-glue {l} x = predFin l (-ₘ fsuc x)
