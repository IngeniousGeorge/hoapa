{-# OPTIONS --cubical --guardedness #-}

-- The finite-site sheafification reflector — interface, interface-first.
--
-- This is the left-adjoint gate of the linear–nonlinear sheaf bridge. The
-- bridge lifts a value-level Benton adjunction `F ⊣ G : Cart ⇄ V` to the
-- finite sheaf categories. The right adjoint `G` preserves the sheaf
-- condition (proved in `LinearNonlinearSheafAdapter.G-preserves-sheaf`),
-- because the probe-form descent is limit-shaped and right adjoints
-- preserve limits. The left adjoint `F` is the problem:
--
--   * preservation of descent by `F` is NOT available from the LNL
--     interface, and is not expected generically — descent is
--     limit-shaped, `F` is a left adjoint (so it preserves colimits, not
--     limits), and the LNL `mon-bin` comparison carries the cartesian
--     product `&` to the linear tensor `⊗`, i.e. to the *wrong* monoidal
--     product for descent. (`mon-bin : F (A & B) ≅ F A ⊗ F B`.)
--
-- The Grothendieckian / rising-sea response is not to push on a `F`-
-- preservation proof the structure does not give, but to enlarge the
-- ambient by adjoining the correct universal object: a sheafification
-- reflector `a ⊣ ι` left adjoint to the inclusion of sheaves into
-- presheaves. The sheaf-level left functor is then `a ∘ liftF ∘ ι`, and
-- the sheaf-level bridge adjunction follows formally
-- (`LinearNonlinearSheafAdjunction.agda`).
--
-- *Interface-first, deliberately.* This module states the reflector as a
-- thin record/Σ, in the same discipline as `StarAutonomous` and
-- `LNLAdjunction`: the two pieces of data (the reflector functor and the
-- adjunction with the inclusion) and nothing else. The *construction* of
-- the reflector — the finite-site plus-construction — is deferred: it
-- needs colimits in the value category `C` that the current value-category
-- interfaces do not assume. A non-vacuity witness inhabiting this record
-- is a planned follow-up, not in this file.
--
-- Scope guardrails: generic over any Cubical `Category` value category
-- `C`; only a V-side instance is consumed downstream. No plus-construction,
-- no Cart-side reflector (the bridge does not need it), no arbitrary sites,
-- no library-sheaf bridge.

module Concurrency.Hybrid.FiniteSheafification where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Sigma using (Σ-syntax ; _,_ ; fst ; snd)

open import Cubical.Categories.Category.Base using (Category)
open import Cubical.Categories.Functor.Base using (Functor)
open import Cubical.Categories.Adjoint using (module NaturalBijection)
open import Cubical.Categories.Instances.FullSubcategory using (FullInclusion)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Hybrid.FiniteDescent using (IsSheaf)
open import Concurrency.Hybrid.FiniteSheafCategory
  using (FiniteFramePresheafCategory ; FiniteSheafCategory)

open NaturalBijection using (_⊣_)

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓV ℓH : Level} (C : Category ℓV ℓH)
         {ℓE ℓR : Level} (ℓI : Level) where

  private
    -- Presheaves and sheaves over the finite-frame site, valued in `C`.
    PshC = FiniteFramePresheafCategory AB C {ℓE} {ℓR}
    ShC  = FiniteSheafCategory AB C {ℓE} {ℓR} ℓI

    -- The inclusion of sheaves into presheaves (full subcategory inclusion).
    ιC : Functor ShC PshC
    ιC = FullInclusion PshC (λ P → IsSheaf AB C {ℓE} {ℓR} {ℓI} P)

  ----------------------------------------------------------------------
  -- The reflector interface: a left adjoint to the inclusion.
  --
  --   sheafify : Psh → Sh
  --   reflector : sheafify ⊣ ι
  --
  -- Two pieces of data, nothing else. Construction deferred.
  ----------------------------------------------------------------------

  FiniteSheafification : Type _
  FiniteSheafification = Σ[ a ∈ Functor PshC ShC ] (a ⊣ ιC)

  -- Named accessors for the two components.
  sheafify : FiniteSheafification → Functor PshC ShC
  sheafify = fst

  reflector : (s : FiniteSheafification) → sheafify s ⊣ ιC
  reflector = snd
