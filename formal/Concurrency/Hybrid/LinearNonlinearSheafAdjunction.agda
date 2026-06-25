{-# OPTIONS --cubical --guardedness #-}

-- The sheaf-level linear–nonlinear adjunction — the bridge's Tier 4,
-- assembled conditionally on a sheafification reflector.
--
-- `LinearNonlinearSheafAdapter.agda` lifts the value-level Benton
-- adjunction `F ⊣ G : Cart ⇄ V` to the *presheaf* categories
-- (`liftF ⊣ liftG`) and proves that the right adjoint preserves the sheaf
-- condition (`G-preserves-sheaf`). What was owed was the left-adjoint
-- sheaf-level functor, since `liftF` is not known to land in sheaves (see
-- `FiniteSheafification.agda` for why this is structural, not a gap to be
-- closed by trying harder). This module discharges that, *given* a
-- V-side sheafification reflector:
--
--   R = liftG, restricted to sheaves           (Tier 2 makes it land in Sh_Cart)
--   L = sheafify ∘ liftF ∘ ι                    (the reflector lands it in Sh_V)
--   L ⊣ R                                        (the sheaf-level bridge adjunction)
--
-- The construction is almost entirely definitional — the rising-sea
-- payoff of building the generic environment first:
--
--   * `R` is `MapFullSubcategory liftG G-preserves-sheaf`: the restriction
--     of `liftG` to the sheaf full subcategory, with `ι_Cart ∘ R ≡
--     liftG ∘ ι_V` holding definitionally.
--   * The presheaf-level adjunction `(sheafify ∘ liftF) ⊣ (liftG ∘ ι_V)`
--     is the library composite `Compose.LF⊣GR (liftF⊣liftG) reflector`.
--   * Restricting the left adjoint's domain to `Sh_Cart` along the
--     (identity-on-homs) full-subcategory inclusion is then pure
--     `fst`-reindexing: full-subcategory homs *are* parent homs, so the
--     adjunction iso and both naturality squares transport with no work.
--
-- Conditional, honestly: the whole module is parameterised by a
-- `FiniteSheafification` instance, whose *construction* (the finite-site
-- plus-construction) stays deferred. No postulates; the only owed object
-- is the reflector the caller supplies.
--
-- Scope guardrails: generic over an abstract cartesian `Cart` and
-- `V : StarAutonomous`; endpoints are the project's own finite sheaf
-- categories. No Cart-side reflector (not needed), no plus-construction,
-- no cross-site `Allow ⊣ Require` functors.

module Concurrency.Hybrid.LinearNonlinearSheafAdjunction where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Sigma using (_,_ ; fst ; snd)

open import Cubical.Categories.Category.Base using (Category)
open import Cubical.Categories.Functor.Base using (Functor ; _∘F_)
open import Cubical.Categories.Adjoint using (module NaturalBijection ; module Compose)
open import Cubical.Categories.Instances.FullSubcategory
  using (FullInclusion ; MapFullSubcategory)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Algebras.StarAutonomous using (StarAutonomous)
open import Concurrency.Algebras.StarAutonomousCategory using (StarAutonomous→Category)
open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)
open import Concurrency.Hybrid.FiniteDescent using (IsSheaf)
open import Concurrency.Hybrid.FiniteSheafCategory
  using (FiniteFramePresheafCategory ; FiniteSheafCategory)
open import Concurrency.Hybrid.LinearNonlinear using (LNLAdjunction)
open import Concurrency.Hybrid.FiniteSheafification using (FiniteSheafification)

import Concurrency.Hybrid.LinearNonlinearSheafAdapter as Ad

open NaturalBijection using (_⊣_)

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓc ℓc' ℓv ℓv' : Level}
         (Cart : Category ℓc ℓc') (cartProd : HasFiniteProducts Cart)
         (V : StarAutonomous ℓv ℓv')
         (lnl : LNLAdjunction Cart cartProd V)
         {ℓE ℓR ℓI : Level}
         (shf : FiniteSheafification AB (StarAutonomous→Category V) {ℓE} {ℓR} ℓI)
         where

  private
    Vcat = StarAutonomous→Category V

    PshC = FiniteFramePresheafCategory AB Cart {ℓE} {ℓR}
    ShC  = FiniteSheafCategory AB Cart {ℓE} {ℓR} ℓI
    ShV  = FiniteSheafCategory AB Vcat {ℓE} {ℓR} ℓI

    -- The presheaf-level lifts and the right-adjoint sheaf preservation,
    -- from the adapter.
    liftF       = Ad.liftF AB Cart cartProd V lnl {ℓE} {ℓR}
    liftG       = Ad.liftG AB Cart cartProd V lnl {ℓE} {ℓR}
    liftF⊣liftG = Ad.liftF⊣liftG AB Cart cartProd V lnl {ℓE} {ℓR}
    Gps         = Ad.G-preserves-sheaf AB Cart cartProd V lnl {ℓE} {ℓR} ℓI

    -- The Cart-side sheaf inclusion (full subcategory inclusion).
    ιC : Functor ShC (FiniteFramePresheafCategory AB Cart {ℓE} {ℓR})
    ιC = FullInclusion PshC (λ P → IsSheaf AB Cart {ℓE} {ℓR} {ℓI} P)

    sheafify  = fst shf
    reflector = snd shf

  ----------------------------------------------------------------------
  -- The right functor: liftG restricted to sheaves (Tier 2).
  ----------------------------------------------------------------------

  Rsheaf : Functor ShV ShC
  Rsheaf = MapFullSubcategory
             PshV-cat (λ P → IsSheaf AB Vcat {ℓE} {ℓR} {ℓI} P)
             PshC     (λ P → IsSheaf AB Cart {ℓE} {ℓR} {ℓI} P)
             liftG Gps
    where PshV-cat = FiniteFramePresheafCategory AB Vcat {ℓE} {ℓR}

  ----------------------------------------------------------------------
  -- The left functor: sheafify ∘ liftF ∘ ι (the reflector lands it in Sh_V).
  ----------------------------------------------------------------------

  Lsheaf : Functor ShC ShV
  Lsheaf = sheafify ∘F liftF ∘F ιC

  ----------------------------------------------------------------------
  -- The sheaf-level bridge adjunction `L ⊣ R`.
  --
  -- The presheaf-level composite `(sheafify ∘ liftF) ⊣ (liftG ∘ ι_V)`,
  -- restricted along `ι_Cart` by `fst`-reindexing (definitional, because
  -- full-subcategory homs are parent homs).
  ----------------------------------------------------------------------

  private
    compAdj = Compose.LF⊣GR liftF⊣liftG reflector

  Lsheaf⊣Rsheaf : Lsheaf ⊣ Rsheaf
  Lsheaf⊣Rsheaf = record
    { adjIso    = λ {S} {T}      → _⊣_.adjIso    compAdj {fst S} {T}
    ; adjNatInD = λ {S} {T} {T'} → _⊣_.adjNatInD compAdj {fst S} {T} {T'}
    ; adjNatInC = λ {S'} {S} {T} → _⊣_.adjNatInC compAdj {fst S'} {fst S} {T}
    }
