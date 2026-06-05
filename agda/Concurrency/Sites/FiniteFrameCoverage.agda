{-# OPTIONS --cubical --guardedness #-}

-- C9: the finite-frame subsite as a genuine Cubical `Coverage`.
--
-- This equips `FiniteFrameCategory` with a Grothendieck coverage whose
-- covering families are the `FiniteBasisCover`s (finite covering families;
-- no carried overlap enumerations — see `FiniteBasisCover.agda`). The
-- coverage's covers are mapped into library `Cover`s by `basis→Cover`.
--
-- The one real obligation, `pullbackStability`, is *not* fresh proof work:
-- it is a re-expression of `ActorPullback.stability-cover-pullback` into
-- the library's sieve-refinement shape. Given a cover `cov` of `c` and any
-- `f : d ↪ c`, the pulled-back cover of `d` intersects each patch with `d`
-- (`pullback-basis-cover`, the finite analogue of
-- `ActorPullback.pullback-cover`, landing finite patches via
-- `FiniteFramePullback.finite-frame-pullback`). The required refinement is
-- then exactly the pullback square: for patch `j`, the new patch arrow
-- composed with `f` factors through the old patch arrow `embed cov j` via
-- the other projection `pb-π₁`, and the factorization equation is
-- `sym (pb-square …)`.
--
-- The `_⋆_` / `_∘ᶠ_` flip (Codex's flagged friction). `FiniteFrameCategory`
-- composes diagrammatically (`g ⋆ f = f ∘ᶠ g`), so the library's
-- `generatedSieve` clause `patchArr cov' j ⋆ f ≡ h ⋆ patchArr cov j`
-- unfolds to `f ∘ᶠ pb-π₂ ≡ embed cov j ∘ᶠ pb-π₁`. `pb-square` proves the
-- mirror image, so the witness is its `sym`. The library `patchArr` of an
-- adapted cover reduces definitionally to `embed`, which is what makes the
-- equation land without transport.
--
-- This retires the standing E2 obligation (the semantic endpoint of a
-- topology is the generated sieve, not the basis) for the finite site,
-- and gives a postulate-free pullback-stability story — no dependency on
-- the legacy `stability-cover-postulate`.
--
-- Scope guardrails: pure site machinery; no value / content / operad
-- imports. This is the topology, not descent — overlap enumerations stay
-- on the `FiniteCover` / descent side.

module Concurrency.Sites.FiniteFrameCoverage where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Sigma using (_,_ ; fst ; snd)
open import Cubical.HITs.PropositionalTruncation using (∣_∣₁)

open import Cubical.Categories.Site.Coverage using (Coverage)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal using (LocalFrame ; FrameHom)
open import Concurrency.Sites.ActorPullback using (pb-π₁ ; pb-π₂ ; pb-square)
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Sites.FiniteFrameCategory using (FiniteFrameCategory)
open import Concurrency.Sites.FiniteFramePullback using (finite-frame-pullback)
open import Concurrency.Sites.FiniteBasisCover using (FiniteBasisCover ; basis→Cover)

module _ {ℓA : Level} (AB : ActorBase ℓA) where
  open ActorBase AB

  module _ {ℓE ℓR ℓI : Level} where

    --------------------------------------------------------------------
    -- The pulled-back basis cover of d along f : d ↪ c.
    -- Finite analogue of `ActorPullback.pullback-cover`.
    --------------------------------------------------------------------

    pullback-basis-cover :
        {c d : FiniteFrame AB ℓE ℓR}
        (cov : FiniteBasisCover AB ℓI c)
        (f : FrameHom AB (FiniteFrame.frame d) (FiniteFrame.frame c))
      → FiniteBasisCover AB ℓI d
    pullback-basis-cover {c} {d} cov f = record
      { Index = FiniteBasisCover.Index cov
      ; patch = λ i → finite-frame-pullback AB
                        (FiniteBasisCover.patch cov i) d c
                        (FiniteBasisCover.embed cov i) f
      ; embed = λ i → pb-π₂ AB (FiniteBasisCover.embed cov i) f
      ; actor-covered = λ {a} aD →
          let aC = FrameHom.actor-pres f aD
              ci = FiniteBasisCover.actor-covered cov aC
          in fst ci , (snd ci , aD)
      ; event-covered = λ e →
          let fe = FrameHom.event-map f e
              ce = FiniteBasisCover.event-covered cov fe
          in fst ce , ((fst (snd ce) , e , snd (snd ce)) , refl)
      }

    --------------------------------------------------------------------
    -- The coverage. `pullbackStability` re-expresses
    -- `stability-cover-pullback` in sieve-refinement form.
    --------------------------------------------------------------------

    FiniteFrameCoverage :
      Coverage (FiniteFrameCategory AB ℓE ℓR)
        (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE (ℓ-max ℓR ℓI)))) ℓI
    FiniteFrameCoverage = record
      { covers = λ c → FiniteBasisCover AB ℓI c , basis→Cover AB c
      ; pullbackStability = λ {c} cov {d} f →
          ∣ pullback-basis-cover {c} {d} cov f
          , (λ j → ∣ j
                   , pb-π₁ AB (FiniteBasisCover.embed cov j) f
                   , sym (pb-square AB (FiniteBasisCover.embed cov j) f)
                   ∣₁)
          ∣₁
      }
