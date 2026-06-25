{-# OPTIONS --cubical --guardedness #-}

-- Non-vacuity: the event-product sheaf as a concrete object of the
-- finite sheaf category, for any value category `C` with finite products.
--
-- This is witness-specific, so it is kept *out* of the generic
-- `FiniteSheafCategory` framework (which is parameterized over an
-- arbitrary Cubical `Category` and must not depend on `HasFiniteProducts`
-- or any concrete witness). Here we exhibit the event-product sheaf as an
-- honest object (plus its identity morphism), showing the sheaf category
-- is non-vacuous. Being generic over `C`, it serves both legs: at
-- `C := StarAutonomous→Category V` it is the V-valued (linear) sanity
-- object, and at `C := SET` the Set-valued one.
--
-- Keeping this separate is what lets the Set-valued skeleton
-- (`SetFiniteSheafCategory.agda`) import `FiniteSheafCategory` without
-- transitively pulling in the finite-product witness machinery.
--
-- Scope guardrails: non-vacuity witness only; no Coverage, no bridge adapter.

module Concurrency.Hybrid.EventProductSheafObject where

open import Cubical.Foundations.Prelude
open import Cubical.Categories.Category.Base using (Category)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)
open import Concurrency.Hybrid.EventProductPresheaf using (event-product-presheaf)
open import Concurrency.Hybrid.EventProductSheaf using (event-product-sheaf)
open import Concurrency.Hybrid.FiniteSheafCategory using (FiniteSheafCategory)

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓV ℓH : Level} (C : Category ℓV ℓH)
         (FP : HasFiniteProducts C) (P₀ : Category.ob C)
         {ℓE ℓR ℓI : Level} where

  event-product-object : Category.ob (FiniteSheafCategory AB C {ℓE} {ℓR} ℓI)
  event-product-object =
    event-product-presheaf AB C FP P₀ , event-product-sheaf AB C FP P₀

  event-product-object-id :
    Category.Hom[_,_] (FiniteSheafCategory AB C {ℓE} {ℓR} ℓI)
      event-product-object event-product-object
  event-product-object-id =
    Category.id (FiniteSheafCategory AB C {ℓE} {ℓR} ℓI) {event-product-object}
