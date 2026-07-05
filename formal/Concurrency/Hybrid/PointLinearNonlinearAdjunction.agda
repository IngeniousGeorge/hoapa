{-# OPTIONS --cubical --guardedness #-}

-- The sheaf-level linear/non-linear adjunction  L ⊣ R — the theorem of
-- the extended abstract.
--
-- Over the actor-causal site with its single-event (point) topology, a
-- Benton linear/non-linear adjunction  F ⊣ G : Cart ⇄ V  between
-- coefficient categories is lifted to an adjunction between
-- cartesian-valued and linear-valued event-local sheaves:
--
--   R = supportedLiftG, restricted to event-local sheaves;
--   L = a ∘ supportedLiftF ∘ ι;
--   L ⊣ R.
--
-- The right adjoint restricts because `G` preserves event-local sheaves
-- (the preservation lemma from the adapter). The left adjoint is made to
-- land in sheaves by post-composing the lifted `F` with the sheafification
-- reflector  a ⊣ ι  of `PointSheafAdjunction`. The induced comonad
-- `L ∘ R` is the sheaf-level linear exponential `!`.
--
-- Assembly:
--   * `R` (`Rpoint`) restricts `supportedLiftG` to the event-local-sheaf
--     full subcategory (`MapFullSubcategory` with the preservation lemma).
--   * The presheaf-level composite `(a ∘ supportedLiftF) ⊣
--     (supportedLiftG ∘ ι)` is the library composite
--     `Compose.LF⊣GR supportedLiftF⊣supportedLiftG a⊣ι`.
--   * Restricting the left adjoint's domain to cartesian event-local
--     sheaves along the full-subcategory inclusion is definitional, since
--     full-subcategory homs are the parent presheaf morphisms.
--
-- The linear side carries finite products (`vProd`) for the same reason
-- as in the adapter: the event-local sheaf condition is phrased through
-- finite products of single-event values. It is a bare module parameter,
-- not part of `LNLAdjunction`.
--
-- Scope: the single-event topology only — no general Grothendieck
-- coverage, no cross-site `Allow ⊣ Require` adjunction. The result is
-- generic in `F ⊣ G`; it does not exhibit a concrete session-type model.

module Concurrency.Hybrid.PointLinearNonlinearAdjunction where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Sigma using (_,_ ; fst ; snd)

open import Cubical.Categories.Category.Base using (Category)
open import Cubical.Categories.Functor.Base using (Functor ; _∘F_)
open import Cubical.Categories.Adjoint using (module NaturalBijection ; module Compose)
open import Cubical.Categories.Instances.FullSubcategory using (MapFullSubcategory)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Algebras.StarAutonomous using (StarAutonomous)
open import Concurrency.Algebras.StarAutonomousCategory using (StarAutonomous→Category)
open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)
open import Concurrency.Hybrid.SupportedPresheafCategory using (SupportedPresheafCategory)
open import Concurrency.Hybrid.SupportedPointDescent using (PointLocal)
open import Concurrency.Hybrid.PointSheafCategory using (PointSheafCategory ; ιP)
open import Concurrency.Hybrid.PointSheafification using (a)
open import Concurrency.Hybrid.PointSheafAdjunction using (a⊣ι)
open import Concurrency.Hybrid.LinearNonlinear using (LNLAdjunction)

import Concurrency.Hybrid.SupportedLinearNonlinearSheafAdapter as Ad

open NaturalBijection using (_⊣_)

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓc ℓc' ℓv ℓv' : Level}
         (Cart : Category ℓc ℓc') (cartProd : HasFiniteProducts Cart)
         (V : StarAutonomous ℓv ℓv')
         (vProd : HasFiniteProducts (StarAutonomous→Category V))
         (lnl : LNLAdjunction Cart cartProd V)
         where

  private
    Vcat = StarAutonomous→Category V

    SPshC = SupportedPresheafCategory AB Cart
    SPshV = SupportedPresheafCategory AB Vcat
    PtShC = PointSheafCategory AB Cart cartProd
    PtShV = PointSheafCategory AB Vcat vProd

    -- The presheaf-level lifts, their adjunction, and the right-adjoint
    -- event-local-sheaf preservation, all from the adapter.
    supportedLiftF       = Ad.supportedLiftF AB Cart cartProd V vProd lnl
    supportedLiftG       = Ad.supportedLiftG AB Cart cartProd V vProd lnl
    supportedLiftF⊣supportedLiftG = Ad.supportedLiftF⊣supportedLiftG AB Cart cartProd V vProd lnl
    Gps                  = Ad.G-preserves-point-local AB Cart cartProd V vProd lnl

    -- The cartesian-side inclusion of event-local sheaves into presheaves.
    ιC : Functor PtShC SPshC
    ιC = ιP AB Cart cartProd

    -- The linear-side sheafification reflector `a ⊣ ι`, the left of the pair.
    aV   = a AB Vcat vProd
    ιV   = ιP AB Vcat vProd
    a⊣ιV = a⊣ι AB Vcat vProd

  ----------------------------------------------------------------------
  -- The right functor: supportedLiftG restricted to event-local sheaves.
  ----------------------------------------------------------------------

  Rpoint : Functor PtShV PtShC
  Rpoint = MapFullSubcategory
             SPshV (λ P → PointLocal AB Vcat vProd P)
             SPshC (λ P → PointLocal AB Cart cartProd P)
             supportedLiftG Gps

  ----------------------------------------------------------------------
  -- The left functor: a ∘ supportedLiftF ∘ ι (sheafification lands it in sheaves).
  ----------------------------------------------------------------------

  Lpoint : Functor PtShC PtShV
  Lpoint = aV ∘F supportedLiftF ∘F ιC

  ----------------------------------------------------------------------
  -- The adjunction `Lpoint ⊣ Rpoint`.
  --
  -- The presheaf-level composite `(a ∘ supportedLiftF) ⊣
  -- (supportedLiftG ∘ ι)`, restricted along the cartesian-side inclusion by
  -- `fst`-reindexing (definitional, full-subcategory homs are parent homs).
  ----------------------------------------------------------------------

  private
    compAdj = Compose.LF⊣GR supportedLiftF⊣supportedLiftG a⊣ιV

  Lpoint⊣Rpoint : Lpoint ⊣ Rpoint
  Lpoint⊣Rpoint = record
    { adjIso    = λ {S} {T}      → _⊣_.adjIso    compAdj {fst S} {T}
    ; adjNatInD = λ {S} {T} {T'} → _⊣_.adjNatInD compAdj {fst S} {T} {T'}
    ; adjNatInC = λ {S'} {S} {T} → _⊣_.adjNatInC compAdj {fst S'} {fst S} {T}
    }
