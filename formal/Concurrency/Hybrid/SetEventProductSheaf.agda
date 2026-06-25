{-# OPTIONS --cubical --guardedness #-}

-- The event-product sheaf at the Set value category: leg 2's concrete
-- witness, the cartesian counterpart of `SessionEventProductSheaf.agda`.
--
-- This is the first concrete inhabitant of the Set-valued finite sheaf
-- category `Sh-fin-Set` (`SetFiniteSheafCategory.agda`). It is *not* a new
-- construction: it feeds the *same* generic event-product witness that
-- leg 1 uses (`EventProductPresheaf` / `EventProductSheaf`, generic over
-- any Cubical `Category` with `HasFiniteProducts`) the Set value category
--
--   * `C  := SET ℓ`                  (the library category of sets)
--   * `FP := SET-HasFiniteProducts`  (its cartesian products)
--   * `P₀ : hSet ℓ`                  (one fixed set as the per-event slot)
--
-- and obtains a full finite-site descent inhabitant whose values are
-- sets and vary over actor-local frames (`value F = P₀ ^ event-count F`),
-- plus its packaging as an object of `Sh-fin-Set`. That leg 1 (linear,
-- session-valued) and leg 2 (cartesian, set-valued) are the *same* witness
-- at two value categories is the concrete payoff of the value-category
-- refactor: it is exactly the symmetry the linear–nonlinear adapter will bridge.
--
-- Scope guardrails: constant-slot only (every event carries the same
-- fixed `P₀`); no Coverage bridge, no comparison with the library's
-- element-based `isSheaf`, no bridge adapter.

module Concurrency.Hybrid.SetEventProductSheaf where

open import Cubical.Foundations.Prelude
open import Cubical.Categories.Category.Base using (Category)
open import Cubical.Categories.Instances.Sets using (SET)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Algebras.SetFiniteProducts using (SET-HasFiniteProducts)
open import Concurrency.Hybrid.FinitePresheaf using (FiniteFramePresheaf)
open import Concurrency.Hybrid.EventProductPresheaf using (event-product-presheaf)
open import Concurrency.Hybrid.FiniteDescent using (IsSheaf)
open import Concurrency.Hybrid.EventProductSheaf using (event-product-sheaf)
open import Concurrency.Hybrid.EventProductSheafObject using (event-product-object)
open import Concurrency.Hybrid.SetFiniteSheafCategory using (Sh-fin-Set)

module _ {ℓA : Level} (AB : ActorBase ℓA) (ℓ : Level)
         {ℓE ℓR : Level} (P₀ : Category.ob (SET ℓ)) where

  ----------------------------------------------------------------------
  -- The frame-varying set-valued presheaf: value F = P₀ ^ (events F).
  ----------------------------------------------------------------------

  set-event-product-presheaf : FiniteFramePresheaf AB (SET ℓ) {ℓE} {ℓR}
  set-event-product-presheaf =
    event-product-presheaf AB (SET ℓ) (SET-HasFiniteProducts ℓ) P₀

  ----------------------------------------------------------------------
  -- The descent inhabitant at the Set target.
  ----------------------------------------------------------------------

  set-event-product-sheaf :
      {ℓI : Level}
    → IsSheaf AB (SET ℓ) {ℓE} {ℓR} {ℓI} set-event-product-presheaf
  set-event-product-sheaf =
    event-product-sheaf AB (SET ℓ) (SET-HasFiniteProducts ℓ) P₀

  ----------------------------------------------------------------------
  -- Packaged as a concrete object of the Set-valued sheaf category.
  ----------------------------------------------------------------------

  set-event-product-object :
      {ℓI : Level}
    → Category.ob (Sh-fin-Set AB ℓ {ℓE} {ℓR} ℓI)
  set-event-product-object =
    event-product-object AB (SET ℓ) (SET-HasFiniteProducts ℓ) P₀
