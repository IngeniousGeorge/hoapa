{-# OPTIONS --cubical --guardedness #-}

-- A concrete, end-to-end worked example of finite-site descent on the
-- tiny two-event actor frame: the first time the generic event-product
-- sheaf is *run against a concrete, non-trivial cover with real pullback
-- overlaps*.
--
-- Everything in the finite-descent stack was generic until now (see the
-- header of `Sites/TinyFiniteCover.agda`). This file feeds the concrete
-- `TinyFiniteCover` through the generic `event-product-sheaf`, exhibiting:
--
--   * `tiny-matching` — a concrete `MatchingFamily` over the two-point
--     cover, for an *arbitrary* probe `X` and *arbitrary* local parts.
--     Its `compatible` proof is the instructive payload: the two patches
--     glue under *no* cross-constraint, and seeing why is the point.
--       - On the diagonal overlap (one shared event) the two projections
--         `pb-π₁`, `pb-π₂` have the same event-map (both land in
--         `PointFrame`'s single `Unit` event), so they induce the same
--         restriction — compatibility holds by `FrameHom≡` + `isPropUnit`.
--       - The off-diagonal overlap is *empty*, so its value is the empty
--         product `⊤ₚ` (terminal): any two maps into it agree by
--         `terminal-unique`. The disjoint points impose no constraint.
--     This is "two disjoint local observations assemble into one joint
--     record" made concrete — the pullback overlaps from `ActorPullback`
--     finally doing real work.
--
--   * `tiny-amalgamate` — `amalgamate` applied to that matching family:
--     two independent local parts glue into a section of the 2-ary
--     product `value TinyFrameF`, restricting back to each part.
--
--   * `tiny-separated` — `cover-jointly-monic` specialized to the cover:
--     a global section is determined by its two patch-restrictions.
--
-- Witness strength (Option A, agreed in the design discussion): the
-- restriction / amalgamation equations are met *propositionally*, via the
-- proofs the sheaf records return — not by definitional reduction. The
-- product API's `UnsupportedIndexedMatch` warnings make refl-level
-- reduction-under-transport unavailable, so a proof-level witness is the
-- robust target; this file does not require anything to compute by `refl`.
--
-- Generic first, then a one-line Sessions specialization, per the
-- value-category-agnostic discipline of the finite-descent stack: the
-- generic module is parametric in `(C : Category , HasFiniteProducts C ,
-- P₀)`; the closing module instantiates it at `StarAutonomous→Category
-- (Sessions-Cat Payload)`.
--
-- Scope guardrails: no new postulates; no mutation of any shipped file;
-- no event-dependent slots and no sheaf-category / topos structure (the
-- deferred next steps).

module Concurrency.Hybrid.TinyEventProductExample where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Bool using (Bool ; false ; true)
open import Cubical.Data.Unit using (isPropUnit)
open import Cubical.Data.Sigma using (Σ-syntax ; fst ; snd)

open import Concurrency.Sites.ActorCausal using (TinyAB ; embed-point)
open import Concurrency.Sites.ActorPullback using (pb-π₁ ; pb-π₂ ; FrameHom≡)
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Sites.FiniteCover using (FiniteCover)
open import Concurrency.Sites.TinyFiniteCover
  using (TinyFrameF ; PointFrameF ; TinyFiniteCover)
open import Cubical.Categories.Category.Base using (Category)
open import Concurrency.Algebras.StarAutonomous using (StarAutonomous)
open import Concurrency.Algebras.StarAutonomousCategory using (StarAutonomous→Category)
open import Concurrency.Algebras.CategoryApplicative using (module ApplicativeView)
open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)
open import Concurrency.Hybrid.FinitePresheaf using (FiniteFramePresheaf)
open import Concurrency.Hybrid.EventProductPresheaf using (event-product-presheaf)
open import Concurrency.Hybrid.FiniteDescent
  using (MatchingFamily ; HasAmalgamation ; IsSeparated ; IsSheaf)
open import Concurrency.Hybrid.EventProductSheaf using (event-product-sheaf)
open import Concurrency.Algebras.Sessions
  using (Sessions-Cat ; Sessions-HasFiniteProducts)

------------------------------------------------------------------------
-- Generic over any Cubical `Category` with finite products and a slot P₀.
------------------------------------------------------------------------

module _ {ℓV ℓH : Level} (C : Category ℓV ℓH)
         (FP : HasFiniteProducts C)
         (P₀ : Category.ob C) where

  open ApplicativeView C
  open HasFiniteProducts FP

  private
    P : FiniteFramePresheaf TinyAB C {ℓ-zero} {ℓ-zero}
    P = event-product-presheaf TinyAB C FP P₀

  open FiniteFramePresheaf P
  open FiniteCover TinyFiniteCover using (patch ; embed ; overlap-frame)

  -- The event-product sheaf, at the tiny site.
  tiny-sheaf : IsSheaf TinyAB C {ℓ-zero} {ℓ-zero} {ℓ-zero} P
  tiny-sheaf = event-product-sheaf TinyAB C FP P₀

  ----------------------------------------------------------------------
  -- A concrete matching family over the two-point cover.
  ----------------------------------------------------------------------

  tiny-matching :
    {X : Ob} (p : (i : Bool) → Hom X (value PointFrameF))
    → MatchingFamily TinyAB C P TinyFiniteCover X
  tiny-matching {X} p = record { part = p ; compatible = compat }
    where
      -- Diagonal: pb-π₁ and pb-π₂ have equal event-maps (both the single
      -- `Unit` event of `PointFrame`), hence equal restrictions.
      compat-diag :
        (i : Bool)
        → restrict (patch i) (overlap-frame i i) (pb-π₁ TinyAB (embed i) (embed i)) ∘ p i
          ≡ restrict (patch i) (overlap-frame i i) (pb-π₂ TinyAB (embed i) (embed i)) ∘ p i
      compat-diag i =
        cong (λ φ → restrict (patch i) (overlap-frame i i) φ ∘ p i)
             (FrameHom≡ TinyAB
                (pb-π₁ TinyAB (embed i) (embed i))
                (pb-π₂ TinyAB (embed i) (embed i))
                (funExt (λ e → isPropUnit (fst e) (fst (snd e)))))

      -- Off-diagonal: the overlap value is `⊤ₚ` (terminal), so both
      -- composites agree by uniqueness.
      compat :
        (i j : Bool)
        → restrict (patch i) (overlap-frame i j) (pb-π₁ TinyAB (embed i) (embed j)) ∘ p i
          ≡ restrict (patch j) (overlap-frame i j) (pb-π₂ TinyAB (embed i) (embed j)) ∘ p j
      compat false false = compat-diag false
      compat true  true  = compat-diag true
      compat false true  = terminal-unique _ ∙ sym (terminal-unique _)
      compat true  false = terminal-unique _ ∙ sym (terminal-unique _)

  ----------------------------------------------------------------------
  -- The two end-to-end sanity witnesses.
  ----------------------------------------------------------------------

  -- Amalgamation: two independent local parts glue into a section of the
  -- 2-ary product, restricting back to each part.
  tiny-amalgamate :
    {X : Ob} (p : (i : Bool) → Hom X (value PointFrameF))
    → Σ[ s ∈ Hom X (value TinyFrameF) ]
        ((i : Bool) → restrict TinyFrameF PointFrameF (embed-point i) ∘ s ≡ p i)
  tiny-amalgamate {X} p =
    HasAmalgamation.amalgamate (IsSheaf.amalgamating tiny-sheaf)
      TinyFiniteCover (tiny-matching p)

  -- Separatedness: a global section is determined by its two patch
  -- restrictions.
  tiny-separated :
    {X : Ob} (x y : Hom X (value TinyFrameF))
    → ((i : Bool) → restrict TinyFrameF PointFrameF (embed-point i) ∘ x
                  ≡ restrict TinyFrameF PointFrameF (embed-point i) ∘ y)
    → x ≡ y
  tiny-separated x y h =
    IsSeparated.cover-jointly-monic (IsSheaf.separated tiny-sheaf)
      TinyFiniteCover x y h

------------------------------------------------------------------------
-- Sessions specialization (one-liner): the same witnesses at the session
-- value category `Sessions-Cat Payload`, slot `P₀` a parameter.
------------------------------------------------------------------------

module _ {ℓv ℓ' : Level} (Payload : Type ℓv)
         (P₀ : StarAutonomous.Ob (Sessions-Cat {ℓv} {ℓ'} Payload)) where

  private
    Vs : StarAutonomous ℓv (ℓ-max ℓv ℓ')
    Vs = Sessions-Cat {ℓv} {ℓ'} Payload

    -- Its underlying category, fed to the generic tiny witnesses.
    Ĉs = StarAutonomous→Category Vs

  session-tiny-sheaf      = tiny-sheaf      Ĉs (Sessions-HasFiniteProducts Payload) P₀
  session-tiny-amalgamate = tiny-amalgamate Ĉs (Sessions-HasFiniteProducts Payload) P₀
  session-tiny-separated  = tiny-separated  Ĉs (Sessions-HasFiniteProducts Payload) P₀
