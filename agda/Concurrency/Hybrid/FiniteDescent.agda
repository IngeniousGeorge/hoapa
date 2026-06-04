{-# OPTIONS --cubical --guardedness #-}

-- Descent / gluing over the finite-frame subsite, for finite-frame
-- presheaves. The finite-site analogue of `Concurrency/Hybrid/Descent.agda`.
--
-- Milestone 3 (definitions). The records here state, for a
-- `FiniteFramePresheaf`:
--
--   * `MatchingFamily` — a family of local sections over the patches of
--     a `FiniteCover`, compatible on overlaps. Overlap compatibility is
--     restriction-agreement along the two pullback projections `pb-π₁` /
--     `pb-π₂`, exactly as in `Descent.agda`; here the overlap object is
--     the carried `overlap-frame i j` (the actual pullback
--     `patch i ×_F patch j` with its chosen enumeration).
--   * `HasAmalgamation` — the existence half: every matching family
--     amalgamates to a global section restricting to each part.
--   * `IsSeparated` — the uniqueness half: a section is determined by
--     its restrictions to the cover.
--   * `IsSheaf` — both.
--
-- Probe-form (an arbitrary probe `X`, per `Descent.agda`'s rationale):
-- the thin `StarAutonomous` has no terminal "global section" object, so
-- matching families are families of `Hom X (value (patch i))`. Unlike
-- the constant-presheaf situation, the event-product presheaf will
-- inhabit the *full* sheaf condition (separated + amalgamating) on this
-- finite site, including over the empty cover of the empty frame, where
-- `value` is the empty product `⊤ₚ` (terminal). So these are plain
-- universally-quantified properties, not restricted to inhabited covers.
--
-- Scope guardrails: generic over any `StarAutonomous` `V` and any
-- `FiniteFramePresheaf` over it; no session syntax, no operad imports.
-- The witness that inhabits these records (the event-product presheaf)
-- lives in `Concurrency/Hybrid/EventProductSheaf.agda`.

module Concurrency.Hybrid.FiniteDescent where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Sigma using (Σ-syntax ; _,_ ; fst ; snd)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorPullback using (pb-π₁ ; pb-π₂)
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Sites.FiniteCover using (FiniteCover)
open import Concurrency.Algebras.StarAutonomous using (StarAutonomous)
open import Concurrency.Hybrid.EventProductPresheaf using (FiniteFramePresheaf)

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓV ℓH : Level} (V : StarAutonomous ℓV ℓH) where

  open StarAutonomous V

  module _ {ℓE ℓR ℓI : Level} (P : FiniteFramePresheaf AB V {ℓE} {ℓR}) where

    open FiniteFramePresheaf P

    --------------------------------------------------------------------
    -- MatchingFamily over a FiniteCover.
    --------------------------------------------------------------------

    record MatchingFamily {F : FiniteFrame AB ℓE ℓR}
                          (c : FiniteCover AB ℓI F) (X : Ob)
         : Type (ℓ-max ℓI ℓH) where
      open FiniteCover c
      field
        part :
          (i : Index) → Hom X (value (patch i))
        compatible :
          (i j : Index)
          → restrict (patch i) (overlap-frame i j) (pb-π₁ AB (embed i) (embed j))
              ∘ part i
            ≡ restrict (patch j) (overlap-frame i j) (pb-π₂ AB (embed i) (embed j))
              ∘ part j

    --------------------------------------------------------------------
    -- HasAmalgamation: existence of a global section.
    --------------------------------------------------------------------

    record HasAmalgamation
         : Type (ℓ-suc (ℓ-max ℓA
                         (ℓ-max ℓE
                           (ℓ-max ℓR
                             (ℓ-max ℓI (ℓ-max ℓV ℓH)))))) where
      field
        amalgamate :
          {F : FiniteFrame AB ℓE ℓR}
          (c : FiniteCover AB ℓI F)
          {X : Ob}
          (m : MatchingFamily c X)
          → Σ[ s ∈ Hom X (value F) ]
              ((i : FiniteCover.Index c)
                → restrict F (FiniteCover.patch c i) (FiniteCover.embed c i) ∘ s
                  ≡ MatchingFamily.part m i)

    --------------------------------------------------------------------
    -- IsSeparated: uniqueness of a global section.
    --------------------------------------------------------------------

    record IsSeparated
         : Type (ℓ-suc (ℓ-max ℓA
                         (ℓ-max ℓE
                           (ℓ-max ℓR
                             (ℓ-max ℓI (ℓ-max ℓV ℓH)))))) where
      field
        cover-jointly-monic :
          {F : FiniteFrame AB ℓE ℓR}
          (c : FiniteCover AB ℓI F)
          {X : Ob}
          (x y : Hom X (value F))
          → ((i : FiniteCover.Index c)
              → restrict F (FiniteCover.patch c i) (FiniteCover.embed c i) ∘ x
                ≡ restrict F (FiniteCover.patch c i) (FiniteCover.embed c i) ∘ y)
          → x ≡ y

    --------------------------------------------------------------------
    -- IsSheaf: separated + amalgamating.
    --------------------------------------------------------------------

    record IsSheaf
         : Type (ℓ-suc (ℓ-max ℓA
                         (ℓ-max ℓE
                           (ℓ-max ℓR
                             (ℓ-max ℓI (ℓ-max ℓV ℓH)))))) where
      field
        separated    : IsSeparated
        amalgamating : HasAmalgamation
