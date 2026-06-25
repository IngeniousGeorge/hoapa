{-# OPTIONS --cubical --guardedness #-}

-- The universal property of the actor-frame pullback `frame-pullback`.
--
-- `Concurrency/Sites/ActorPullback.agda` shipped the pullback *cone* —
-- the object `frame-pullback f g`, the two projections `pb-π₁` / `pb-π₂`,
-- and the commuting square `pb-square` — and explicitly deferred the
-- universal property ("v1 ships the cone ... the full universal property
-- is a clean follow-on if a later construction needs the pullback to be
-- characterized up to iso"). This file is that follow-on.
--
-- Why now (the relative point of view, and C6). The library sheaf
-- condition (`Cubical.Categories.Site.Sheaf.isCompatibleFamily`)
-- quantifies a matching family's compatibility over *every* cone into a
-- pair of patches, whereas the project's finite descent
-- (`Concurrency/Hybrid/FiniteDescent.agda`) checks compatibility on the
-- *chosen* overlap frame via `pb-π₁` / `pb-π₂`. Those two notions
-- coincide exactly when every cone factors uniquely through the overlap —
-- i.e. exactly when the overlap is the genuine fibre product. So the
-- universal property is precisely the structure that turns "compatible on
-- the overlap" into "compatible on all cones"; it is the local
-- infrastructure the Set-valued sheaf comparison floats on, not an
-- ornament. The overlap *is* `patch i ×_F patch j`, a relative object
-- over `F`; characterizing it by its universal property (rather than by a
-- carried enumeration) is the relative point of view repaying a corner
-- the fast-track cut.
--
-- What is built. For a cospan `f : A ↪ C`, `g : B ↪ C` and any cone
-- `(D, p : D ↪ A, q : D ↪ B)` commuting over `C` (`f ∘ᶠ p ≡ g ∘ᶠ q`):
--
--   * `mediating`     — the mediating `FrameHom D ↪ frame-pullback f g`;
--   * `mediating-π₁`  — `pb-π₁ ∘ᶠ mediating ≡ p`;
--   * `mediating-π₂`  — `pb-π₂ ∘ᶠ mediating ≡ q`;
--   * `mediating-unique` — any morphism through the cone equals it.
--
-- Together these are the 1-categorical universal property of the
-- pullback. The mediating event map is `e ↦ (p e , q e , comm-at-e)`,
-- the obvious section of the fibre product; the projection equations hold
-- by `refl` (the projections are the first / second-of-second component);
-- uniqueness is component-wise via `ActorPullback.FrameHom≡`, with the
-- fibre-witness component discharged by `Event-set` (events form a set).
--
-- No finiteness is used or needed: the cone lives at arbitrary frame
-- levels and the mediating morphism maps *into* the (possibly infinite)
-- pullback. Finiteness of the pullback of two finite frames is a separate
-- concern, handled in `Concurrency/Sites/FiniteFramePullback.agda`.
--
-- Scope guardrails (inherited from the actor site): no value / content /
-- operad imports; events stay opaque; `FrameHom`s remain strict sub-view
-- embeddings, and the mediating morphism of two sub-views is a sub-view.

module Concurrency.Sites.FramePullbackUniversal where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Sigma using (Σ-syntax ; _,_ ; fst ; snd ; ΣPathP)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal using (LocalFrame ; FrameHom ; _∘ᶠ_)
open import Concurrency.Sites.ActorPullback
  using (frame-pullback ; pb-π₁ ; pb-π₂ ; FrameHom≡)

module _ {ℓA : Level} (AB : ActorBase ℓA) where
  open ActorBase AB

  module _ {ℓE ℓR : Level}
           {A B C : LocalFrame AB ℓE ℓR}
           (f : FrameHom AB A C) (g : FrameHom AB B C) where

    private
      module MA = LocalFrame A
      module MB = LocalFrame B
      module MC = LocalFrame C
      module Mf = FrameHom f
      module Mg = FrameHom g

    --------------------------------------------------------------------
    -- The universal property, for an arbitrary commuting cone.
    --------------------------------------------------------------------

    module _ {ℓEd ℓRd : Level} {D : LocalFrame AB ℓEd ℓRd}
             (p : FrameHom AB D A) (q : FrameHom AB D B)
             (comm : _∘ᶠ_ AB f p ≡ _∘ᶠ_ AB g q) where

      private
        module Mp = FrameHom p
        module Mq = FrameHom q

        -- The fibre-product witness at each event, read off the
        -- commuting square: f (p e) ≡ g (q e) in C.
        comm-at : (e : LocalFrame.Event D)
                → Mf.event-map (Mp.event-map e) ≡ Mg.event-map (Mq.event-map e)
        comm-at e = λ i → FrameHom.event-map (comm i) e

      ------------------------------------------------------------------
      -- The mediating morphism D ↪ frame-pullback f g.
      ------------------------------------------------------------------

      mediating : FrameHom AB D (frame-pullback AB f g)
      mediating = record
        { actor-pres   = λ aD → Mp.actor-pres aD , Mq.actor-pres aD
        ; event-map    = λ e → Mp.event-map e , Mq.event-map e , comm-at e
        ; touches-pres = λ t → Mp.touches-pres t , Mq.touches-pres t
        ; causal-pres  = λ le → Mp.causal-pres le
        ; causal-refl  = λ le → Mp.causal-refl le
        }

      ------------------------------------------------------------------
      -- The two projection equations. Both hold by `refl`: the
      -- projections recover the components the mediating map packs.
      ------------------------------------------------------------------

      mediating-π₁ : _∘ᶠ_ AB (pb-π₁ AB f g) mediating ≡ p
      mediating-π₁ =
        FrameHom≡ AB (_∘ᶠ_ AB (pb-π₁ AB f g) mediating) p refl

      mediating-π₂ : _∘ᶠ_ AB (pb-π₂ AB f g) mediating ≡ q
      mediating-π₂ =
        FrameHom≡ AB (_∘ᶠ_ AB (pb-π₂ AB f g) mediating) q refl

      ------------------------------------------------------------------
      -- Uniqueness: any cone morphism agreeing on both projections is
      -- the mediating one. Component-wise via `FrameHom≡`; the
      -- fibre-witness component is a path in the set `MC.Event`, so it
      -- is discharged by `isProp→PathP` over `Event-set`.
      ------------------------------------------------------------------

      mediating-unique :
          (m : FrameHom AB D (frame-pullback AB f g))
        → _∘ᶠ_ AB (pb-π₁ AB f g) m ≡ p
        → _∘ᶠ_ AB (pb-π₂ AB f g) m ≡ q
        → m ≡ mediating
      mediating-unique m m-π₁ m-π₂ =
        FrameHom≡ AB m mediating
          (funExt (λ e →
            ΣPathP
              ( (λ i → FrameHom.event-map (m-π₁ i) e)
              , ΣPathP
                  ( (λ i → FrameHom.event-map (m-π₂ i) e)
                  , isProp→PathP (λ _ → MC.Event-set _ _) _ _ ) )))
