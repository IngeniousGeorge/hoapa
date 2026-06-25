{-# OPTIONS --cubical --guardedness #-}

-- Finite frames are closed under pullback: the actor-frame pullback
-- `frame-pullback` of two finite frames over a finite frame is again a
-- finite frame, with a *chosen* enumeration.
--
-- Why this is the delicate module (Codex's caveat). A `FiniteFrame`
-- (`Concurrency/Sites/FiniteFrame.agda`) is not merely a frame that
-- happens to be finite; it carries a *chosen, untruncated* enumeration
-- `enum : Event ≃ FinData.Fin event-count`. So it is not enough to show
-- `isFinSet (PBEvent)` — that gives `Σ n ∥ PBEvent ≃ Fin n ∥₁`, whose
-- equivalence is truncated and cannot serve as `enum`. We must produce
-- `isFinOrd`-style data: an actual equivalence to a `FinData.Fin k`.
--
-- The construction, all from the existing finite-set library (no new
-- finite-subset machinery is built here). The pullback's events are
--
--   PBEvent = Σ[ a ∈ A.Event ] Σ[ b ∈ B.Event ] (f a ≡ g b)
--
-- (the fibre product of the two event maps, definitionally
-- `LocalFrame.Event (frame-pullback f g)`). Re-associate it to the
-- grouped form `Σ[ ab ∈ A.Event × B.Event ] (f (ab .fst) ≡ g (ab .snd))`
-- via `Σ-assoc-Iso`. There:
--
--   * `A.Event × B.Event` is a finite ordinal — `isFinOrd×` of the two
--     frames' chosen enumerations (bridged `FinData → SumFin`);
--   * the fibre `f (ab .fst) ≡ g (ab .snd)` is a *decidable* proposition,
--     because the codomain frame `C` is finite, hence has decidable event
--     equality — supplied directly by `isDecProp≡'` from `isFinOrd
--     C.Event`. (This is exactly "events are discrete because they are
--     enumerated"; no extra `Discrete` hypothesis is assumed — it is free
--     from the finite enumeration data the frames already carry.)
--
-- Then `isFinOrdSub` enumerates the decidable subset (it rides
-- `SumFin.SumFinSub≃`, the untruncated decidable-subset equivalence),
-- yielding `isFinOrd Grouped`; `EquivPresIsFinOrd` transports it back
-- along the re-association to `isFinOrd PBEvent`; and the chosen `enum`
-- is its `SumFin`-valued equivalence composed with the
-- `SumFin ≃ FinData.Fin` bridge.
--
-- This is the finiteness fact `Concurrency/Sites/FiniteFrameCoverage.agda`
-- needs so that `pullbackStability` can land its refining-cover patches
-- as genuine objects of `FiniteFrameCategory`. The *universal property*
-- of the same pullback is the separate, finiteness-free
-- `Concurrency/Sites/FramePullbackUniversal.agda`.
--
-- Scope guardrails (inherited from the actor site): no value / content /
-- operad imports; events stay opaque; the underlying object is the
-- `ActorPullback` sub-view pullback, unchanged — this file only equips it
-- with a chosen finite enumeration.

module Concurrency.Sites.FiniteFramePullback where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv using (_≃_ ; compEquiv ; invEquiv)
open import Cubical.Foundations.Isomorphism using (isoToEquiv)
open import Cubical.Data.Sigma using (_×_ ; _,_ ; fst ; snd ; Σ-assoc-Iso)
open import Cubical.Data.SumFin.Properties using (FinData≃SumFin)
open import Cubical.Data.FinSet.Base using (isFinOrd)
open import Cubical.Data.FinSet.Properties using (EquivPresIsFinOrd)
open import Cubical.Data.FinSet.Constructors using (isFinOrd×)
open import Cubical.Data.FinSet.DecidablePredicate using (isFinOrdSub ; isDecProp≡')

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal using (LocalFrame ; FrameHom)
open import Concurrency.Sites.ActorPullback using (frame-pullback)
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)

module _ {ℓA : Level} (AB : ActorBase ℓA) where
  open ActorBase AB

  module _ {ℓE ℓR : Level} (FA FB FC : FiniteFrame AB ℓE ℓR)
           (f : FrameHom AB (FiniteFrame.frame FA) (FiniteFrame.frame FC))
           (g : FrameHom AB (FiniteFrame.frame FB) (FiniteFrame.frame FC)) where

    private
      module MA = LocalFrame (FiniteFrame.frame FA)
      module MB = LocalFrame (FiniteFrame.frame FB)
      module MC = LocalFrame (FiniteFrame.frame FC)
      module Mf = FrameHom f
      module Mg = FrameHom g

      -- A finite frame's chosen enumeration, bridged FinData → SumFin so
      -- it lands in the `isFinOrd` form the finite-set library expects.
      isFinOrd-Event :
          (F : FiniteFrame AB ℓE ℓR)
        → isFinOrd (LocalFrame.Event (FiniteFrame.frame F))
      isFinOrd-Event F =
        FiniteFrame.event-count F , compEquiv (FiniteFrame.enum F) FinData≃SumFin

      -- The events of the pullback, definitionally the fibre product.
      PBEvent : Type ℓE
      PBEvent = LocalFrame.Event (frame-pullback AB f g)

      -- Grouped form: the same set, with the two event components paired.
      Grouped : Type ℓE
      Grouped =
        Σ[ ab ∈ (MA.Event × MB.Event) ]
          (Mf.event-map (fst ab) ≡ Mg.event-map (snd ab))

      -- Grouped is a finite ordinal: a decidable subset (fibre product)
      -- of the finite ordinal `A.Event × B.Event`.
      isFinOrd-Grouped : isFinOrd Grouped
      isFinOrd-Grouped =
        isFinOrdSub (MA.Event × MB.Event)
          (isFinOrd× MA.Event (isFinOrd-Event FA)
                     MB.Event (isFinOrd-Event FB))
          (λ ab → Mf.event-map (fst ab) ≡ Mg.event-map (snd ab))
          (λ ab → isDecProp≡' MC.Event (isFinOrd-Event FC)
                    (Mf.event-map (fst ab)) (Mg.event-map (snd ab)))

      -- Transport the enumeration back along Σ-re-association.
      isFinOrd-PBEvent : isFinOrd PBEvent
      isFinOrd-PBEvent =
        EquivPresIsFinOrd (isoToEquiv Σ-assoc-Iso) isFinOrd-Grouped

    --------------------------------------------------------------------
    -- The pullback of finite frames, with its chosen enumeration.
    --------------------------------------------------------------------

    finite-frame-pullback : FiniteFrame AB ℓE ℓR
    finite-frame-pullback = record
      { frame       = frame-pullback AB f g
      ; event-count = fst isFinOrd-PBEvent
      ; enum        = compEquiv (snd isFinOrd-PBEvent) (invEquiv FinData≃SumFin)
      }
