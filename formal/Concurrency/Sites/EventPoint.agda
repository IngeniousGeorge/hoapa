{-# OPTIONS --cubical --guardedness #-}

-- Event-point sub-frames of an arbitrary actor-local frame.
--
-- The general form of `ActorCausal.agda`'s Tiny-specific
-- `PointCausal` / `PointFrame` / `embed-point`: for *any* frame `F` and
-- *any* event `e` of `F`, the single-event sub-frame `point-frame F e`
-- and its embedding `point-embed e : point-frame F e ↪ F`. Plus the
-- induced point-to-point morphism `point-hom φ d : point-frame G d ↪
-- point-frame F (event-map φ d)` for a frame morphism `φ : G ↪ F`.
--
-- Two facts make this legal and clean (verified in the scoping
-- discussion):
--
--   * `LocalFrame` has *no* causal-downward-closure constraint — a
--     single event is a legal frame, no need to carry its predecessors.
--   * `point-hom φ d` lands at `event-map φ d` *exactly* (no enumeration
--     round-trip), so all five `FrameHom` fields discharge from `φ`'s own
--     fields with no transport: `actor-pres`/`touches-pres` are `φ`'s,
--     the event map is the unique `Unit* → Unit*`, and the causal fields
--     are trivial (the point order is the single `Unit*`-loop).
--
-- Incidence (landed). A point frame `point-frame e` carries the
-- *event-supported* actor predicate `ActorIn := λ a → F.touches e a`:
-- its actors are exactly those `e` touches, not all of `F`'s actors.
-- This is the cover-facing refinement (Codex's incidence point) that
-- makes `point-frame e` an event-generated frame and makes the point
-- cover's `actor-covered` provable from supportedness. It also turns the
-- morphism `actor-pres` fields into *derived* data: `point-embed`'s is
-- `F.touches-in-frame`, and `point-hom`'s is `φ.touches-pres` (the
-- support helper of `EventSupported.agda`) — never an independent
-- `actor-pres`.
--
-- This is the inhabitant-level edit anticipated by the pointification
-- spike note; it does not touch the `LocalFrame` / `FrameHom` records.
-- Functoriality of the reflector is `ActorIn`-agnostic, so the green
-- `Pointification.agda` survives, narrowed only at the relation level.
--
-- Level. Incident `ActorIn := touches e : Actor → Type ℓR` must inhabit
-- `LocalFrame.ActorIn : Actor → Type ℓA`, so this route fixes `ℓR = ℓA`
-- (the relation/incidence level equals the actor level). The event level
-- `ℓE` is independent and is `ℓ-zero` on the point-reflector route by the
-- `EnumeratedProduct` wrapper, not by anything here.
--
-- Scope guardrails: pure site / locality machinery; no value / content /
-- operad imports.

module Concurrency.Sites.EventPoint where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Unit using (Unit* ; tt* ; isSetUnit* ; isPropUnit*)

open import Concurrency.Sites.ActorBase using (ActorBase ; CausalOrder)
open import Concurrency.Sites.ActorCausal using (LocalFrame ; FrameHom)

module _ {ℓA : Level} (AB : ActorBase ℓA) where

  ------------------------------------------------------------------
  -- The single-event sub-frame at an event of a frame.
  --
  -- `ℓR = ℓA` so the incident `ActorIn := touches e` is well-typed.
  ------------------------------------------------------------------

  module _ {ℓE : Level} (F : LocalFrame AB ℓE ℓA) where
    private module Fm = LocalFrame F

    -- The trivial causal order on a single (`Unit*`) event.
    point-causal : CausalOrder ℓE ℓA
    point-causal = record
      { Event     = Unit*
      ; Event-set = isSetUnit*
      ; _≤_       = λ _ _ → Unit*
      ; ≤-refl    = λ _ → tt*
      ; ≤-trans   = λ _ _ → tt*
      ; ≤-antisym = λ {a} {b} _ _ → isPropUnit* a b
      ; ≤-isProp  = λ {_} {_} → isPropUnit*
      }

    -- Event-supported: the point's actors are exactly `touches e`.
    point-frame : Fm.Event → LocalFrame AB ℓE ℓA
    point-frame e = record
      { causal           = point-causal
      ; ActorIn          = λ a → Fm.touches e a
      ; ActorIn-isProp   = λ a → Fm.touches-isProp e a
      ; touches          = λ _ a → Fm.touches e a
      ; touches-isProp   = λ _ a → Fm.touches-isProp e a
      ; touches-in-frame = λ {_} {a} t → t
      }

    -- The sub-view embedding `point-frame e ↪ F`. Its `actor-pres` is the
    -- support map `touches e a → F.ActorIn a`, i.e. `F.touches-in-frame`.
    point-embed : (e : Fm.Event) → FrameHom AB (point-frame e) F
    point-embed e = record
      { actor-pres   = λ t → Fm.touches-in-frame t
      ; event-map    = λ _ → e
      ; touches-pres = λ t → t
      ; causal-pres  = λ _ → Fm.≤-refl e
      ; causal-refl  = λ _ → tt*
      }

  ------------------------------------------------------------------
  -- The point-to-point morphism induced by a frame morphism.
  ------------------------------------------------------------------

  module _ {ℓE₁ ℓE₂ : Level}
           (G : LocalFrame AB ℓE₁ ℓA) (F : LocalFrame AB ℓE₂ ℓA)
           (φ : FrameHom AB G F) where
    private
      module Gm = LocalFrame G
      module Fm = LocalFrame F
      module φm = FrameHom φ

    -- Lands at `event-map φ d` exactly: no enumeration round-trip. With
    -- incident actors, `actor-pres` is the support map `φ.touches-pres`.
    point-hom : (d : Gm.Event)
              → FrameHom AB (point-frame G d) (point-frame F (φm.event-map d))
    point-hom d = record
      { actor-pres   = φm.touches-pres
      ; event-map    = λ _ → tt*
      ; touches-pres = φm.touches-pres
      ; causal-pres  = λ _ → tt*
      ; causal-refl  = λ _ → tt*
      }

    -- A version landing at a propositionally-equal target event, with the
    -- equation absorbed by `subst`. Used where the Fin-product index
    -- forces `event-map φ d` through an enumeration round-trip.
    point-hom-to : (d : Gm.Event) (e : Fm.Event) (q : φm.event-map d ≡ e)
                 → FrameHom AB (point-frame G d) (point-frame F e)
    point-hom-to d e q =
      subst (λ e' → FrameHom AB (point-frame G d) (point-frame F e')) q (point-hom d)
