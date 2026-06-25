{-# OPTIONS --cubical --guardedness #-}

-- Covers of the finite-frame subsite, carrying chosen finite enumeration
-- data for patches *and* for overlaps.
--
-- Milestone 3 prerequisite (decision recorded in the workflow
-- discussion; Codex concurring). Descent compatibility lives on the
-- overlaps of patches, and the overlap of two patches `patch i`,
-- `patch j` over `F` is their pullback `frame-pullback (embed i)
-- (embed j)`. The event-product presheaf folds a finite product over a
-- frame's events, so to state compatibility we need a *chosen finite
-- enumeration of the overlap*, just as `FiniteFrame` carries one for
-- ordinary frames.
--
-- The empty-cover decision, revisited. The two ways to obtain overlap
-- enumerations were: (1) *carry* them as cover data, or (2) require
-- decidable event-equality and *compute* the pullback enumeration. We
-- take (1): carrying the overlap enumeration is local and reversible,
-- whereas making decidable event-equality a site-wide requirement turns
-- a proof-engineering need into a base-site axiom. So a `FiniteCover`
-- carries, per ordered pair of patches `(i , j)`, an `overlap-count` and
-- an `overlap-enum` for the *actual* pullback frame
-- `frame-pullback (embed i) (embed j)`. The derived `overlap-frame i j`
-- is then a genuine `FiniteFrame` whose underlying frame *is* that
-- pullback — no propositional frame-equality, no transport — and whose
-- projections are the `pb-π₁` / `pb-π₂` of `ActorPullback`.
--
-- Coverage (`actor-covered`, `event-covered`) is stated on the
-- underlying frame of `F`, mirroring `Cover` in `ActorCausal.agda`;
-- patches and overlaps are `FiniteFrame`s, and the embeddings are
-- `FrameHom`s between underlying frames. This is the finite analogue of
-- `Cover`, not a wrapper around it — restating coverage directly in
-- terms of finite patches avoids a propositional `patch-frame` equality.
--
-- Scope guardrails: pure site machinery; no value / content / operad
-- imports.

module Concurrency.Sites.FiniteCover where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv using (_≃_)
open import Cubical.Data.Nat using (ℕ)
open import Cubical.Data.FinData using (Fin)
open import Cubical.Data.Sigma using (Σ-syntax)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal using (LocalFrame ; FrameHom)
open import Concurrency.Sites.ActorPullback using (frame-pullback ; pb-π₁ ; pb-π₂)
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)

module _ {ℓA : Level} (AB : ActorBase ℓA) where
  open ActorBase AB

  record FiniteCover {ℓE ℓR : Level} (ℓI : Level)
                     (F : FiniteFrame AB ℓE ℓR)
       : Type (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE (ℓ-max ℓR ℓI)))) where
    open LocalFrame (FiniteFrame.frame F)
    field
      Index : Type ℓI
      patch : Index → FiniteFrame AB ℓE ℓR
      embed : (i : Index)
            → FrameHom AB (FiniteFrame.frame (patch i)) (FiniteFrame.frame F)

      -- Coverage on the underlying frame of F.
      actor-covered : {a : Actor} → ActorIn a
                    → Σ[ i ∈ Index ] LocalFrame.ActorIn (FiniteFrame.frame (patch i)) a
      event-covered : (e : Event)
                    → Σ[ i ∈ Index ]
                        Σ[ ẽ ∈ LocalFrame.Event (FiniteFrame.frame (patch i)) ]
                          FrameHom.event-map (embed i) ẽ ≡ e

      -- Carried finite enumeration of every overlap (= patch pullback).
      overlap-count : Index → Index → ℕ
      overlap-enum  : (i j : Index)
                    → LocalFrame.Event (frame-pullback AB (embed i) (embed j))
                      ≃ Fin (overlap-count i j)

    -- The overlap as a finite frame: the actual pullback
    -- `patch i ×_F patch j`, equipped with the carried enumeration. Its
    -- projections into the patches are `pb-π₁` / `pb-π₂`.
    overlap-frame : (i j : Index) → FiniteFrame AB ℓE ℓR
    overlap-frame i j = record
      { frame       = frame-pullback AB (embed i) (embed j)
      ; event-count = overlap-count i j
      ; enum        = overlap-enum i j
      }
