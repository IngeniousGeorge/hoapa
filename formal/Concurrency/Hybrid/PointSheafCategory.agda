{-# OPTIONS --cubical --guardedness #-}

-- The category of point sheaves over the supported subsite.
--
-- The full subcategory of `SupportedPresheafCategory` on the point-sheaf
-- objects. As settled in discussion, the defining predicate is
-- `PointLocal` (not `IsPointSheaf`): the two are equivalent on objects (the
-- `SupportedPointDescent.point-sheaf⟺local` biconditional), but `PointLocal`
-- is the *product-facing* form the reflector adjunction needs, and its
-- propositionality is nearly free — it is a Π of `isIso` data, and `isIso`
-- of a fixed morphism is a proposition because the value category has
-- hom-sets (`isPropIsIso`). No descent proof-irrelevance is re-created.
--
-- Unlike `SupportedPresheafCategory`, this needs `HasFiniteProducts C`,
-- because `PointLocal` is stated via the comparison cone into the point
-- product (`SupportedPointDescent` Scope 2).
--
-- This is the codomain of the point-generated reflector `a ⊣ ι`; the
-- inclusion `ιP` (mirroring `FiniteSheafification`'s `FullInclusion`
-- pattern) is the right adjoint's target / left adjoint's source.
--
-- Scope guardrails: generic over any Cubical `Category C` with finite
-- products; no reflector functor or adjunction here (those are
-- `PointSheafification.agda`).

module Concurrency.Hybrid.PointSheafCategory where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.HLevels using (isPropΠ)

open import Cubical.Categories.Category.Base using (Category ; isPropIsIso)
open import Cubical.Categories.Functor.Base using (Functor)
open import Cubical.Categories.Instances.FullSubcategory
  using (FullSubcategory ; FullInclusion)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)
open import Concurrency.Hybrid.SupportedPresheafCategory
  using (SupportedPresheaf ; SupportedPresheafCategory)
open import Concurrency.Hybrid.SupportedPointDescent using (PointLocal)

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓV ℓH : Level} (C : Category ℓV ℓH) (FP : HasFiniteProducts C) where

  private
    SPsh = SupportedPresheafCategory AB C

    PLocal : SupportedPresheaf AB C → Type (ℓ-max (ℓ-suc ℓA) ℓH)
    PLocal Pp = PointLocal AB C FP Pp

  -- `PointLocal` is a proposition.
  isPropPointLocal : (Pp : SupportedPresheaf AB C) → isProp (PLocal Pp)
  isPropPointLocal Pp = isPropΠ (λ SF → isPropIsIso {C = C} _)

  -- The category of point sheaves: the full subcategory on `PointLocal`.
  PointSheafCategory : Category _ _
  PointSheafCategory = FullSubcategory SPsh PLocal

  -- The inclusion of point sheaves into supported presheaves.
  ιP : Functor PointSheafCategory SPsh
  ιP = FullInclusion SPsh PLocal
