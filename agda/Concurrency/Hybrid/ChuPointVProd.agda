{-# OPTIONS --cubical --guardedness #-}

-- Exactly-typed `vProd` adapter for the Chu point example.
--
-- `Chu-HasFiniteProducts` is built over `Chu-Cat`; the point theorem wants
-- `HasFiniteProducts (StarAutonomous→Category Chu-StarAutonomous)`. Those
-- categories are definitionally equal (`Chu-Cat` agrees with the adapter up
-- to η and `~~i`), so this coercion type-checks — in ~3 s here. It is given
-- as a single exactly-typed constant so the example consumes `vProd` at the
-- required type rather than re-deriving the coercion. (Note: providing this
-- exact type was *not* on its own what made the example tractable — the
-- dominant cost there was a separate type-annotation conversion; see
-- `ChuPointExample`.)

module Concurrency.Hybrid.ChuPointVProd where

open import Cubical.Foundations.Prelude using (Level)
open import Cubical.Foundations.HLevels using (hSet)

open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)
open import Concurrency.Algebras.StarAutonomousCategory using (StarAutonomous→Category)
open import Concurrency.Algebras.ChuMonoidal using (module Monoidal)
open import Concurrency.Algebras.ChuFiniteProducts using (Chu-HasFiniteProducts)

module _ {ℓ : Level} (k : hSet ℓ) where

  open Monoidal k using (Chu-StarAutonomous)

  Chu-SA-HasFiniteProducts
    : HasFiniteProducts (StarAutonomous→Category Chu-StarAutonomous)
  Chu-SA-HasFiniteProducts = Chu-HasFiniteProducts k
