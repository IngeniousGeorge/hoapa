{-# OPTIONS --cubical --guardedness #-}

-- Hybrid layer (Adapter 2): descent / gluing over actor-causal covers.
--
-- This file is the *existence half* of the sheaf condition, the
-- companion to the *uniqueness half* (`IsSeparatedPresheaf`) shipped in
-- `Concurrency/Hybrid/Presheaf.agda`. Together they say a presheaf is a
-- sheaf: local sections that agree on overlaps glue to a unique global
-- section.
--
--   Hybrid v1 (`Presheaf.agda`)  — Adapter 1 (restriction) + separated
--                                  (uniqueness of amalgamations).
--   This file                    — Adapter 2 (descent): matching
--                                  families, overlap compatibility,
--                                  amalgamation (existence).
--
-- Probe-form, not equalizer-form (consensus 2026-06-02). The target
-- `StarAutonomous` is deliberately thin: it has `⊗ / 𝟙 / ⊥-par / dual /
-- braid` but *no products, equalizers, or additives*. So the classical
-- equalizer-form sheaf condition
--
--     value F → ∏ value Gᵢ ⇉ ∏ value (Gᵢ ×_F Gⱼ)
--
-- is not even statable here without enriching the value category (which
-- would also pre-empt the cartesian-vs-linear bridge question). Instead we
-- use the *probe form*: a matching family is a family of morphisms
-- `Hom X (value (patch i))` out of an arbitrary probe `X`, compatible on
-- overlaps, amalgamating to a unique `Hom X (value F)`. This is the
-- exact mirror of `IsSeparatedPresheaf`, which already quantifies over
-- an arbitrary probe `X` and per-patch restrictions; the two halves
-- compose cleanly into `IsSheafPresheaf`.
--
-- Overlaps come from `Concurrency/Sites/ActorPullback.agda`. The overlap
-- of two patches `patch i`, `patch j` of a cover of `F` is their
-- pullback `patch i ×_F patch j = frame-pullback (embed c i) (embed c j)`,
-- with projections `pb-π₁`, `pb-π₂`. Compatibility of a matching family
-- is restriction-agreement along those two projections. This file
-- consumes only the pullback *cone* (object + the two projections); the
-- pullback's universal property is not needed to state descent.
--
-- Property records, not postulates (consensus 2026-06-02). Amalgamation
-- does not hold for arbitrary presheaves, so `HasAmalgamation` is a
-- *property record* discharged per-presheaf — exactly as
-- `IsSeparatedPresheaf` is — never a global postulate. This file ships
-- the *definitions* of the descent data and the sheaf property; it does
-- not assert that any particular presheaf glues. No `postulate` appears
-- here, and no fake gluing is smuggled in.
--
-- Scope guardrails (inherited from the Hybrid chassis):
--   * Generic over any `StarAutonomous` target `V`; no session syntax,
--     no operad imports (`gen`, `plug`, `shift` are Adapter 4).
--   * No payloads / roles / promotion on actors.
--   * Uses the basis-form `Cover` and the actor-frame pullback; the
--     bundled `ActorCausalSite` (identity / transitivity / stability of
--     covers) is not yet consumed at the definitional level, but the
--     pullback-based `stability-cover-pullback` from `ActorPullback`
--     stands ready when a worked sheaf needs it.

module Concurrency.Hybrid.Descent where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Sigma
  using ( Σ-syntax ; _,_ ; fst ; snd )

open import Concurrency.Sites.ActorBase
  using ( ActorBase )
open import Concurrency.Sites.ActorCausal
  using ( LocalFrame ; FrameHom ; Cover )
open import Concurrency.Sites.ActorPullback
  using ( frame-pullback ; pb-π₁ ; pb-π₂ )
open import Concurrency.Algebras.StarAutonomous
  using ( StarAutonomous )
open import Concurrency.Hybrid.Presheaf
  using ( FramePresheaf ; IsSeparatedPresheaf )

------------------------------------------------------------------------
-- Module parameterization.
--
-- Mirrors `Presheaf.agda`: a fixed `ActorBase` AB and a fixed
-- `StarAutonomous` target `V`. The frame-category levels `ℓE, ℓR` and
-- the cover-index level `ℓI` parameterize the inner module, alongside
-- the presheaf `P` whose descent we are talking about.
------------------------------------------------------------------------

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓV ℓH : Level} (V : StarAutonomous ℓV ℓH) where

  open StarAutonomous V

  module _ {ℓE ℓR ℓI : Level} (P : FramePresheaf AB V {ℓE} {ℓR}) where

    open FramePresheaf P

    --------------------------------------------------------------------
    -- MatchingFamily: a compatible family of local sections.
    --
    -- For a cover `c` of `F` and a probe object `X`:
    --
    --   * `part i`     — a local section over `patch i`, as a morphism
    --                    `Hom X (value (patch i))`.
    --   * `compatible` — for every pair of indices, the two local
    --                    sections agree after restriction to the
    --                    overlap `patch i ×_F patch j`. Restriction is
    --                    contravariant, so `pb-π₁ : overlap ↪ patch i`
    --                    induces `restrict (pb-π₁) : Hom (value (patch
    --                    i)) (value overlap)`.
    --------------------------------------------------------------------

    record MatchingFamily {F : LocalFrame AB ℓE ℓR}
                          (c : Cover AB ℓI F) (X : Ob)
         : Type (ℓ-max ℓI ℓH) where
      field
        part :
          (i : Cover.Index c) → Hom X (value (Cover.patch c i))
        compatible :
          (i j : Cover.Index c)
          → restrict (pb-π₁ AB (Cover.embed c i) (Cover.embed c j))
              ∘ part i
            ≡ restrict (pb-π₂ AB (Cover.embed c i) (Cover.embed c j))
              ∘ part j

    --------------------------------------------------------------------
    -- HasAmalgamation: the existence half of descent.
    --
    -- A property record (not a postulate): a presheaf *has
    -- amalgamation* when every matching family, over every cover and
    -- every probe, admits a global section restricting to each local
    -- part. Uniqueness of that section is the separately-shipped
    -- `IsSeparatedPresheaf`.
    --------------------------------------------------------------------

    record HasAmalgamation
         : Type (ℓ-suc (ℓ-max ℓA
                         (ℓ-max ℓE
                           (ℓ-max ℓR
                             (ℓ-max ℓI (ℓ-max ℓV ℓH)))))) where
      field
        amalgamate :
          {F : LocalFrame AB ℓE ℓR}
          (c : Cover AB ℓI F)
          {X : Ob}
          (m : MatchingFamily c X)
          → Σ[ s ∈ Hom X (value F) ]
              ((i : Cover.Index c)
                → restrict (Cover.embed c i) ∘ s
                  ≡ MatchingFamily.part m i)

    --------------------------------------------------------------------
    -- IsSheafPresheaf: separated + amalgamating.
    --
    -- The full sheaf condition. `separated` is the uniqueness half from
    -- `Presheaf.agda`; `amalgamating` is the existence half above. A
    -- presheaf satisfying both glues compatible local content into a
    -- unique global section over every cover.
    --------------------------------------------------------------------

    record IsSheafPresheaf
         : Type (ℓ-suc (ℓ-max ℓA
                         (ℓ-max ℓE
                           (ℓ-max ℓR
                             (ℓ-max ℓI (ℓ-max ℓV ℓH)))))) where
      field
        separated    : IsSeparatedPresheaf AB V {ℓE} {ℓR} {ℓI} P
        amalgamating : HasAmalgamation
