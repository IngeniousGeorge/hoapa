{-# OPTIONS --cubical --guardedness #-}

-- Finite actor-local frames: the subsite the event-product descent
-- witness lives over.
--
-- Milestone 2 of the value-category enrichment program (see
-- `Concurrency/Algebras/FiniteProducts.agda` for milestone 1 and the
-- design rationale). The event-indexed session/product presheaf folds a
-- finite product over a frame's events; that fold needs a *chosen*,
-- non-truncated enumeration of the events — not bare
-- `isFinSet (Event) = Σ n ∥ Event ≃ Fin n ∥₁`, whose enumeration is
-- truncated and cannot drive a fold (Codex's amendment). A `FiniteFrame`
-- packages exactly that chosen data:
--
--   * `frame`       — the underlying `LocalFrame` (all the actor-causal
--                     locality structure, unchanged);
--   * `event-count` — a natural number;
--   * `enum`        — a chosen equivalence `Event frame ≃ Fin
--                     event-count` (`FinData.Fin`, the inductive Fin
--                     used by the product API).
--
-- This is the honest meaning of "the finite-frame subsite": objects are
-- frames *equipped with* a chosen enumeration. A morphism of finite
-- frames is just a `FrameHom` between the underlying frames — finiteness
-- and the enumeration are extra structure on objects, not a constraint
-- on morphisms — so no separate `FiniteFrameHom` record is introduced;
-- downstream code uses `FrameHom AB (frame G) (frame F)` directly.
--
-- Why a record (not bare `Σ`). Packaging makes the subsite an explicit,
-- named object (Codex's recommendation over "require `isFinSet` where
-- needed") and gives the enumeration a stable accessor for the
-- reindexing maps the presheaf's `restrict` builds.
--
-- Scope guardrails (inherited from the actor site):
--   * No value / content / operad imports. Pure locality + a finiteness
--     witness.
--   * `enum` constrains the event level: `Event frame ≃ Fin n` forces
--     `Event` to be small (equivalent to a `Type₀`). That is exactly
--     right for finite frames; the tiny site's `Event = Bool` already
--     satisfies it.

module Concurrency.Sites.FiniteFrame where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv using (_≃_)
open import Cubical.Data.Nat using (ℕ)
open import Cubical.Data.FinData using (Fin)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal using (LocalFrame)

module _ {ℓA : Level} (AB : ActorBase ℓA) where

  record FiniteFrame (ℓE ℓR : Level)
       : Type (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE ℓR))) where
    field
      frame       : LocalFrame AB ℓE ℓR
      event-count : ℕ
      enum        : LocalFrame.Event frame ≃ Fin event-count
