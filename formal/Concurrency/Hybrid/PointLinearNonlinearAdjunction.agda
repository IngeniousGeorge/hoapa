{-# OPTIONS --cubical --guardedness #-}

-- Brick 4: the point-generated sheaf-level linear–nonlinear adjunction.
--
-- The point-route parallel of `LinearNonlinearSheafAdjunction.agda`, but
-- with the conditional `FiniteSheafification` hypothesis discharged by the
-- *constructed* point-generated reflector `PointSheafAdjunction.a⊣ι`
-- (Brick 3). What was owed in the full-site Tier 4 — a left-adjoint
-- sheaf-level functor, since `liftF` is not known to land in sheaves — is
-- here supplied by the reflector that Brick 3 built, so the bridge over the
-- supported / event-discrete site is unconditional in the reflector. It
-- stays relative to the value-level Benton adjunction `lnl`:
--
--   Rpoint = supportedLiftG, restricted to point sheaves   (Tier 2)
--   Lpoint = a ∘ supportedLiftF ∘ ιP                        (reflector lands it)
--   Lpoint ⊣ Rpoint                                          (the bridge)
--
-- recovering the linear exponential `!` as `Lpoint ∘ Rpoint` at the
-- point-sheaf level. The assembly is the full-site move verbatim:
--
--   * `Rpoint` is `MapFullSubcategory supportedLiftG G-preserves-point-local`,
--     the restriction of `supportedLiftG` to the point-sheaf full
--     subcategory.
--   * The supported-presheaf-level adjunction `(a ∘ supportedLiftF) ⊣
--     (supportedLiftG ∘ ιP_V)` is the library composite
--     `Compose.LF⊣GR supportedLiftF⊣supportedLiftG a⊣ι`.
--   * Restricting the left adjoint's domain to point-`Cart`-sheaves along
--     the (identity-on-homs) full-subcategory inclusion `ιP_Cart` is pure
--     `fst`-reindexing.
--
-- The linear side needs `V` to carry finite products (`vProd`) — the
-- point reflector and `PointLocal` live over the comparison cone into the
-- finite point product in the value category. This is the linear-side
-- counterpart of `cartProd`; it is a bare module parameter, not added to
-- `LNLAdjunction`.
--
-- Scope guardrails: supported point-generated / event-discrete site only —
-- no full `Coverage`, no stability upgrade, no cross-site `Allow ⊣ Require`.
-- The bridge stays relative to `lnl`; no concrete Sessions Benton
-- adjunction is claimed. SET / Sessions instantiation is out of scope for
-- this pass (the success criterion is the generic bridge typechecking).

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

    -- The supported presheaf-level lifts, the supported-level adjunction,
    -- and the right-adjoint point-sheaf preservation, from the adapter.
    supportedLiftF       = Ad.supportedLiftF AB Cart cartProd V vProd lnl
    supportedLiftG       = Ad.supportedLiftG AB Cart cartProd V vProd lnl
    supportedLiftF⊣supportedLiftG = Ad.supportedLiftF⊣supportedLiftG AB Cart cartProd V vProd lnl
    Gps                  = Ad.G-preserves-point-local AB Cart cartProd V vProd lnl

    -- The Cart-side point-sheaf inclusion (full subcategory inclusion).
    ιC : Functor PtShC SPshC
    ιC = ιP AB Cart cartProd

    -- The V-side reflector `a ⊣ ι` (Brick 3), the left side of the bridge.
    aV   = a AB Vcat vProd
    ιV   = ιP AB Vcat vProd
    a⊣ιV = a⊣ι AB Vcat vProd

  ----------------------------------------------------------------------
  -- The right functor: supportedLiftG restricted to point sheaves (Tier 2).
  ----------------------------------------------------------------------

  Rpoint : Functor PtShV PtShC
  Rpoint = MapFullSubcategory
             SPshV (λ P → PointLocal AB Vcat vProd P)
             SPshC (λ P → PointLocal AB Cart cartProd P)
             supportedLiftG Gps

  ----------------------------------------------------------------------
  -- The left functor: a ∘ supportedLiftF ∘ ιP (the reflector lands it).
  ----------------------------------------------------------------------

  Lpoint : Functor PtShC PtShV
  Lpoint = aV ∘F supportedLiftF ∘F ιC

  ----------------------------------------------------------------------
  -- The bridge adjunction `Lpoint ⊣ Rpoint`.
  --
  -- The supported-presheaf-level composite `(a ∘ supportedLiftF) ⊣
  -- (supportedLiftG ∘ ιP_V)`, restricted along `ιP_Cart` by
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
