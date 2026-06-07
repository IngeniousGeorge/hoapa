{-# OPTIONS --cubical --guardedness #-}

-- Event-supported overlaps of event points.
--
-- The overlap of two event points `pt_d`, `pt_e` of a frame `F`. The raw
-- pullback `ActorPullback.frame-pullback (point-embed d) (point-embed e)`
-- would give the *wrong* geometry: its events are `d ≡ e` (event-empty
-- off-diagonal) but its actors are the intersection `touches d × touches
-- e`, which can be inhabited even when there is no shared event (Codex's
-- flag). That actor-nonemptiness is exactly what would keep off-diagonal
-- descent clauses from being vacuous.
--
-- So we build the *event-supported* overlap directly: the same event type
-- `d ≡ e`, but with an event-generated actor predicate
--
--   ActorIn a  :=  ∥ Σ[ p ∈ (d ≡ e) ] touches F d a ∥₁
--
-- which is `∥ Σ (events) touches ∥`, hence empty exactly when the event
-- type is. The key event-only facts this file names:
--
--   * `overlap-event` : the event type *is* `d ≡ e`;
--   * `overlap-actor-forces-event` : an actor of the overlap forces a
--     shared event;
--   * `overlap-no-shared-event-no-actor` : its contrapositive — an
--     event-empty overlap is actor-empty (off-diagonal ⇒ the empty
--     frame). This is the fact Brick 2's off-diagonal descent vacuity
--     will cite.
--
-- The two projections `po-π₁ : overlap ↪ pt_d`, `po-π₂ : overlap ↪ pt_e`
-- are genuine sub-views; `po-π₂` transports incidence along the carried
-- event-equality `p : d ≡ e`. Finiteness (a chosen `event-count`/`enum`
-- via deciding `d ≡ e`) is added where `F` is finite, in `PointCover`.
--
-- Event level fixed to `ℓ-zero` (the point-reflector route; `d ≡ e` is
-- then a `Type₀`), relation/actor level `ℓA` (incident `point-frame`s).
--
-- Scope guardrails: pure site / locality machinery; no value / content /
-- operad imports.

module Concurrency.Sites.PointOverlap where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Sigma using (Σ-syntax ; _,_ ; fst ; snd)
open import Cubical.Data.Unit using (Unit* ; tt* ; isSetUnit* ; isPropUnit*)
open import Cubical.HITs.PropositionalTruncation
  using (∥_∥₁ ; ∣_∣₁ ; isPropPropTrunc) renaming (rec to ∥rec∥)
open import Cubical.Relation.Nullary using (¬_)

open import Concurrency.Sites.ActorBase using (ActorBase ; CausalOrder)
open import Concurrency.Sites.ActorCausal using (LocalFrame ; FrameHom)
open import Concurrency.Sites.EventPoint using (point-frame)

module _ {ℓA : Level} (AB : ActorBase ℓA) where
  open ActorBase AB

  module _ (F : LocalFrame AB ℓ-zero ℓA) where
    private module Fm = LocalFrame F

    ----------------------------------------------------------------
    -- The event-supported overlap frame.
    ----------------------------------------------------------------

    point-overlap : (d e : Fm.Event) → LocalFrame AB ℓ-zero ℓA
    point-overlap d e = record
      { causal = record
          { Event     = d ≡ e
          ; Event-set = isProp→isSet (Fm.Event-set d e)
          ; _≤_       = λ _ _ → Unit*
          ; ≤-refl    = λ _ → tt*
          ; ≤-trans   = λ _ _ → tt*
          ; ≤-antisym = λ {p} {q} _ _ → Fm.Event-set d e p q
          ; ≤-isProp  = λ {_} {_} → isPropUnit*
          }
      ; ActorIn        = λ a → ∥ Σ[ p ∈ (d ≡ e) ] Fm.touches d a ∥₁
      ; ActorIn-isProp = λ a → isPropPropTrunc
      ; touches        = λ _ a → Fm.touches d a
      ; touches-isProp = λ _ a → Fm.touches-isProp d a
      ; touches-in-frame = λ {p} {a} t → ∣ p , t ∣₁
      }

    ----------------------------------------------------------------
    -- Event-only facts.
    ----------------------------------------------------------------

    -- The event type is exactly the path space `d ≡ e`.
    overlap-event : (d e : Fm.Event)
                  → LocalFrame.Event (point-overlap d e) ≡ (d ≡ e)
    overlap-event d e = refl

    -- An actor of the overlap forces a shared event: event-empty
    -- overlaps are actor-empty (off-diagonal ⇒ the empty frame).
    overlap-actor-forces-event :
        (d e : Fm.Event) {a : Actor}
      → LocalFrame.ActorIn (point-overlap d e) a → ∥ d ≡ e ∥₁
    overlap-actor-forces-event d e =
      ∥rec∥ isPropPropTrunc (λ { (p , _) → ∣ p ∣₁ })

    -- Contrapositive: no shared event ⇒ no actor. The off-diagonal
    -- overlap is the empty frame (Brick 2 reads descent vacuity off this).
    overlap-no-shared-event-no-actor :
        (d e : Fm.Event) {a : Actor}
      → ¬ ∥ d ≡ e ∥₁ → ¬ LocalFrame.ActorIn (point-overlap d e) a
    overlap-no-shared-event-no-actor d e ¬p ai =
      ¬p (overlap-actor-forces-event d e ai)

    ----------------------------------------------------------------
    -- The two projections into the event points.
    ----------------------------------------------------------------

    -- `po-π₁ : overlap ↪ pt_d`. `actor-pres` reads `touches d` off the
    -- event-generated actor by truncation recursion.
    po-π₁ : (d e : Fm.Event)
          → FrameHom AB (point-overlap d e) (point-frame AB F d)
    po-π₁ d e = record
      { actor-pres   = ∥rec∥ (Fm.touches-isProp d _) (λ { (_ , t) → t })
      ; event-map    = λ _ → tt*
      ; touches-pres = λ t → t
      ; causal-pres  = λ _ → tt*
      ; causal-refl  = λ _ → tt*
      }

    -- `po-π₂ : overlap ↪ pt_e`. Incidence transports along the carried
    -- event-equality `p : d ≡ e`.
    po-π₂ : (d e : Fm.Event)
          → FrameHom AB (point-overlap d e) (point-frame AB F e)
    po-π₂ d e = record
      { actor-pres   = ∥rec∥ (Fm.touches-isProp e _)
                              (λ { (p , t) → subst (λ z → Fm.touches z _) p t })
      ; event-map    = λ _ → tt*
      ; touches-pres = λ {p} t → subst (λ z → Fm.touches z _) p t
      ; causal-pres  = λ _ → tt*
      ; causal-refl  = λ _ → tt*
      }
