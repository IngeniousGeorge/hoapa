{-# OPTIONS --cubical --guardedness #-}

-- Leg 2 skeleton: the Set-valued finite locality sheaf category
-- `Sh_fin(site, Set)`, obtained by instantiating the generic finite
-- sheaf-category framework at the library category `SET`.
--
-- What this is, and is not. This file is *deliberately skeletal*. It
-- exhibits that the same generic construction that produces the V-valued
-- linear sheaf category (`FiniteSheafCategory` at `StarAutonomous→
-- Category V`) also produces a Set-valued cartesian sheaf category when
-- fed the library's `SET` — i.e. legs 1 and 2 are *one* construction at
-- two value categories, which is what keeps the eventual linear–nonlinear sheaf bridge a
-- clean cartesian-vs-linear bridge rather than a presentation gap. It
-- builds:
--
--   * `Sh-fin-Set-presheaves` — the category of finite-frame presheaves
--     valued in `SET`;
--   * `Sh-fin-Set` — its full subcategory of finite sheaves.
--
-- A concrete inhabitant of this category — the Set event-product sheaf —
-- is provided in `SetEventProductSheaf.agda` (`set-event-product-object`),
-- via the value-category-generic finite-product machinery
-- (`SetFiniteProducts.agda`). This file itself stays the framework
-- instantiation; the witness lives next door, mirroring leg 1
-- (`FiniteSheafCategory` framework / `EventProductSheafObject` witness).
--
-- It does **not** yet: bridge `FiniteCover` to a Cubical `Coverage`
-- (the E2 step), or prove agreement between this hand-rolled descent
-- notion and the library's element-based `isSheaf`. Per the workflow
-- decision, *this* category — the framework instantiated at `SET` — is
-- the canonical linear–nonlinear bridge endpoint on the locality side; the library
-- Coverage/Sheaf comparison is parallel legitimacy, decoupled from the bridge
-- timing.
--
-- Scope guardrails: no Coverage bridge, no comparison theorem, no bridge adapter.

module Concurrency.Hybrid.SetFiniteSheafCategory where

open import Cubical.Foundations.Prelude
open import Cubical.Categories.Category.Base using (Category)
open import Cubical.Categories.Instances.Sets using (SET)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Hybrid.FiniteSheafCategory
  using (FiniteFramePresheafCategory ; FiniteSheafCategory)

module _ {ℓA : Level} (AB : ActorBase ℓA) (ℓ : Level) {ℓE ℓR : Level} where

  -- Finite-frame presheaves valued in sets.
  Sh-fin-Set-presheaves : Category _ _
  Sh-fin-Set-presheaves = FiniteFramePresheafCategory AB (SET ℓ) {ℓE} {ℓR}

  -- The Set-valued finite sheaf category — the canonical linear–nonlinear bridge endpoint on
  -- the locality side.
  Sh-fin-Set : (ℓI : Level) → Category _ _
  Sh-fin-Set ℓI = FiniteSheafCategory AB (SET ℓ) {ℓE} {ℓR} ℓI
