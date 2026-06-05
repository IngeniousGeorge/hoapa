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
-- Spike note (variable-slot sheafification reflector). For the spike,
-- `ActorIn := F.ActorIn` (so `point-embed`/`point-hom`'s `actor-pres` is
-- `φ`'s directly). This choice is irrelevant to presheaf *functoriality*
-- (which never inspects `ActorIn`); the cover-facing refinement
-- `ActorIn := F.touches e` (Codex's incidence point, for `actor-covered`
-- of the point cover) is deferred to the point-cover step, where it is
-- what makes point patches active and where the `ℓA`-vs-`ℓR` level
-- question is resolved.
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
  ------------------------------------------------------------------

  module _ {ℓE ℓR : Level} (F : LocalFrame AB ℓE ℓR) where
    private module Fm = LocalFrame F

    -- The trivial causal order on a single (`Unit*`) event.
    point-causal : CausalOrder ℓE ℓR
    point-causal = record
      { Event     = Unit*
      ; Event-set = isSetUnit*
      ; _≤_       = λ _ _ → Unit*
      ; ≤-refl    = λ _ → tt*
      ; ≤-trans   = λ _ _ → tt*
      ; ≤-antisym = λ {a} {b} _ _ → isPropUnit* a b
      ; ≤-isProp  = λ {_} {_} → isPropUnit*
      }

    point-frame : Fm.Event → LocalFrame AB ℓE ℓR
    point-frame e = record
      { causal           = point-causal
      ; ActorIn          = Fm.ActorIn
      ; ActorIn-isProp   = Fm.ActorIn-isProp
      ; touches          = λ _ a → Fm.touches e a
      ; touches-isProp   = λ _ a → Fm.touches-isProp e a
      ; touches-in-frame = λ {_} {a} t → Fm.touches-in-frame t
      }

    -- The sub-view embedding `point-frame e ↪ F`.
    point-embed : (e : Fm.Event) → FrameHom AB (point-frame e) F
    point-embed e = record
      { actor-pres   = λ x → x
      ; event-map    = λ _ → e
      ; touches-pres = λ t → t
      ; causal-pres  = λ _ → Fm.≤-refl e
      ; causal-refl  = λ _ → tt*
      }

  ------------------------------------------------------------------
  -- The point-to-point morphism induced by a frame morphism.
  ------------------------------------------------------------------

  module _ {ℓE₁ ℓR₁ ℓE₂ ℓR₂ : Level}
           (G : LocalFrame AB ℓE₁ ℓR₁) (F : LocalFrame AB ℓE₂ ℓR₂)
           (φ : FrameHom AB G F) where
    private
      module Gm = LocalFrame G
      module Fm = LocalFrame F
      module φm = FrameHom φ

    -- Lands at `event-map φ d` exactly: no enumeration round-trip.
    point-hom : (d : Gm.Event)
              → FrameHom AB (point-frame G d) (point-frame F (φm.event-map d))
    point-hom d = record
      { actor-pres   = φm.actor-pres
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
