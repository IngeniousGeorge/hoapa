{-# OPTIONS --cubical --guardedness #-}

-- Valuations of the cyclic associative operad O_1 in a *-autonomous target.
--
-- A `Valuation T` is a HIT-respecting interpretation of `O n` into
-- morphisms of T:
--
--   ⟦_⟧ : O n → Hom (ports Carrier n) ⊥-par
--
-- on a chosen self-dual carrier (`Carrier ≃ Carrier ^⊥`). The codomain
-- is the *-autonomous dualizing object `⊥-par = 𝟙 ^⊥`, not `𝟙`; the
-- two coincide only in compact-closed targets, and Caires–Pfenning's
-- syntactic category (the planned R8 instance) is *-autonomous but not
-- compact closed.
--
-- A Valuation is strictly weaker than an operad algebra: well-definedness
-- of `⟦_⟧` on the HIT forces respect for every path constructor by
-- `cong ⟦_⟧`, but this gives no structural commitment that `⟦compₒ⟧`
-- factors through categorical plugging or that `⟦rot⟧` factors through
-- a cyclic shift of tensor factors. That structural content lives in
-- `Concurrency.Algebras.OperadAlgebra`, which contains a Valuation as
-- a sub-record and adds the categorical fields.
--
-- This file exists to factor the two layers cleanly:
--   * Valuation: "any consistent interpretation that respects the HIT."
--   * OperadAlgebra: "an interpretation whose action matches the
--     intended categorical operations." (Built on top of Valuation.)
--
-- Pattern: the project's `RawCyclicOperad.agda` / `CyclicAssociative.agda`
-- precedent — weak structure in one file, strong in another.

module Concurrency.Algebras.Valuation where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Nat              using (ℕ ; zero ; suc)

open import Concurrency.Operads.Ports
open import Concurrency.Operads.CyclicAssociative using ( O )
open import Concurrency.Algebras.StarAutonomous

module _ {ℓ ℓ' : Level} (T : StarAutonomous ℓ ℓ') where
  open StarAutonomous T

  ----------------------------------------------------------------
  -- Iterated tensor.
  --
  -- `ports X n` is the tensor product of `(suc n)` copies of `X`. An
  -- n-ary cyclic-operad operation has `(suc n)` cyclically arranged
  -- ports; its valuation has `(suc n)` tensor factors of the carrier
  -- on the input side.
  ----------------------------------------------------------------

  ports : Ob → ℕ → Ob
  ports X zero    = X
  ports X (suc n) = X ⊗ ports X n

  ----------------------------------------------------------------
  -- Valuation.
  ----------------------------------------------------------------

  record Valuation : Type (ℓ-max ℓ ℓ') where
    field
      Carrier : Ob

      -- Chosen self-duality. R8's session-type duality `S ↔ S^⊥`
      -- instantiates this in Sessions.agda.
      self-dual         : Hom Carrier (Carrier ^⊥)
      self-dual-inv     : Hom (Carrier ^⊥) Carrier
      self-dual-iso-l   : self-dual-inv ∘ self-dual ≡ id
      self-dual-iso-r   : self-dual ∘ self-dual-inv ≡ id

      -- Interpretation: a homomorphism on the HIT
      -- `Concurrency.Operads.CyclicAssociative.O`. Codomain is
      -- `⊥-par`, the *-autonomous dualizing object. Well-definedness
      -- on the HIT forces respect for every path constructor
      -- (rot-zero, rot-compose, compₒ-assoc-seq, compₒ-assoc-par,
      -- rot-compₒ-a-block, rot-compₒ-b-block, trunc); each is
      -- recovered as `cong ⟦_⟧ <constructor>`. No separate
      -- compatibility field is needed at this layer.
      --
      -- These cong-lifts are not named as lemmas here: at the
      -- valuation level they are tautological. The structurally
      -- interesting consequence of `boundary-swap` — relating
      -- categorical `plug` and `shift` — is named as
      -- `boundary-swap-structural` in `OperadAlgebra.agda`.
      ⟦_⟧ : {n : ℕ} → O n → Hom (ports Carrier n) ⊥-par
