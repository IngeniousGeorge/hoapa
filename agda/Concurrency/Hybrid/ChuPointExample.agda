{-# OPTIONS --cubical --guardedness #-}

-- Phase-0 Chu non-vacuity — the closed witness.
--
-- Instantiates the generic point-generated R4 theorem
-- (`PointLinearNonlinearAdjunction.Lpoint⊣Rpoint`) at:
--
--   AB      = TinyAB                  (a concrete supported actor base)
--   Cart    = SET                     (cartesian / locality side)
--   cartProd = SET-HasFiniteProducts
--   V       = Chu(SET, Bool)          (the `*`-autonomous coefficient category)
--   vProd   = Chu-SA-HasFiniteProducts (its additive products, exactly typed)
--   lnl     = Chu-LNL                 (the constructive Benton adjunction)
--
-- The result `Chu-nonvacuity` is the point-generated sheaf-level Benton/LNL
-- adjunction `Lpoint ⊣ Rpoint` over the supported event-discrete
-- actor-causal site, with the linear coefficient category the genuinely
-- mathematical `Chu(SET, Bool)` — not bespoke syntax. This is *coefficient*
-- non-vacuity (grade (i) of the convergence): named "Chu non-vacuity",
-- deliberately NOT "Sessions" or "Reality" non-vacuity.
--
-- `k = Bool` is a concrete two-element dualizing object. (It is not the
-- unique "minimal nondegenerate" choice — e.g. `Chu(SET, 1)` does not
-- collapse, it is `SET × SETᵒᵖ` — so Bool is chosen simply as a small,
-- finite, computable non-singleton.)
--
-- `vProd` is supplied as the exactly-typed `Chu-SA-HasFiniteProducts` from
-- `ChuPointVProd` (a constant of type
-- `HasFiniteProducts (StarAutonomous→Category Chu-StarAutonomous)`), so the
-- point construction never re-checks the `Chu-Cat` ≅ `StarAutonomous→Category`
-- coercion at each `vProd` use; `lnl`/`vP` get explicit signatures too.
--
-- Discipline: postulate-free; no Sessions imports.

module Concurrency.Hybrid.ChuPointExample where

open import Cubical.Foundations.Prelude using (Level ; ℓ-zero)
open import Cubical.Foundations.HLevels using (hSet)
open import Cubical.Data.Sigma using (_,_)
open import Cubical.Data.Bool using (Bool ; isSetBool)

open import Cubical.Categories.Adjoint using (module NaturalBijection)
open import Cubical.Categories.Instances.Sets using (SET)

open import Concurrency.Sites.TinyActorBase using (TinyAB)
open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)
open import Concurrency.Algebras.StarAutonomousCategory using (StarAutonomous→Category)
open import Concurrency.Algebras.SetFiniteProducts using (SET-HasFiniteProducts)
open import Concurrency.Algebras.ChuMonoidal using (module Monoidal)
open import Concurrency.Hybrid.ChuPointVProd using (Chu-SA-HasFiniteProducts)
open import Concurrency.Hybrid.ChuLinearNonlinear using (Chu-LNL)
open import Concurrency.Hybrid.LinearNonlinear using (LNLAdjunction)
import Concurrency.Hybrid.PointLinearNonlinearAdjunction as Point

open NaturalBijection using (_⊣_)

-- A concrete two-element dualizing object.
kBool : hSet ℓ-zero
kBool = Bool , isSetBool

open Monoidal kBool using (Chu-StarAutonomous)

-- The theorem's parameters, each at its exact type (the point-generated R4
-- module takes them on an inner anonymous module, so we apply the
-- projections directly).
private
  cart : _
  cart = SET ℓ-zero

  cartP : HasFiniteProducts (SET ℓ-zero)
  cartP = SET-HasFiniteProducts ℓ-zero

  vP : HasFiniteProducts (StarAutonomous→Category Chu-StarAutonomous)
  vP = Chu-SA-HasFiniteProducts kBool

  lnl : LNLAdjunction (SET ℓ-zero) (SET-HasFiniteProducts ℓ-zero) Chu-StarAutonomous
  lnl = Chu-LNL kBool

-- Chu non-vacuity: `Lpoint ⊣ Rpoint` at the coefficient category Chu(SET, Bool).
--
-- The inferred type is exactly
--   `Point.Lpoint TinyAB cart cartP Chu-StarAutonomous vP lnl`
--   ⊣ `Point.Rpoint TinyAB cart cartP Chu-StarAutonomous vP lnl`,
-- the point-generated sheaf-level Benton/LNL adjunction over the supported
-- point-sheaf categories on `TinyAB`. It is deliberately left UNANNOTATED:
-- writing that adjunction type out forces Agda to expand `Lpoint` and
-- `Rpoint` at the Chu instance independently on the two sides of the
-- type-conversion check, which blows up elaboration (>400 s). The term
-- itself — including both functors — elaborates in a few seconds, and its
-- inferred type is precisely the intended adjunction. (A stated type can be
-- recovered cheaply by naming the point theorem's generic parameter module;
-- see the note to the instigator.)
Chu-nonvacuity = Point.Lpoint⊣Rpoint TinyAB cart cartP Chu-StarAutonomous vP lnl
