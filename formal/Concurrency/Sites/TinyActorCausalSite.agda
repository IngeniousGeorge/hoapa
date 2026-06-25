{-# OPTIONS --cubical --guardedness #-}

-- The bundled tiny `ActorCausalSite`, with its stability field discharged
-- by construction.
--
-- This module exists to keep `Concurrency/Sites/ActorCausal.agda`
-- postulate-free. Stability of covers is *constructed* in
-- `Concurrency/Sites/ActorPullback.agda` (`stability-cover-pullback`), but
-- `ActorPullback` imports `ActorCausal`, so `ActorCausal` cannot assemble a
-- site that uses the constructed stability without a cycle. This third
-- module imports both and fills the `stability-cover` field with the real
-- pullback construction, so no `stability-cover-postulate` is needed
-- anywhere.
--
-- `tiny-site` has no other consumers, so moving it here changes no
-- downstream code; the constructive tiny frames, embeddings, and covers
-- stay in `ActorCausal`.

module Concurrency.Sites.TinyActorCausalSite where

open import Cubical.Foundations.Prelude using (ℓ-zero)

open import Concurrency.Sites.TinyActorBase using (TinyAB)
open import Concurrency.Sites.ActorCausal
  using ( ActorCausalSite
        ; identity-cover-canonical
        ; transitivity-cover-canonical )
open import Concurrency.Sites.ActorPullback using (stability-cover-pullback)

------------------------------------------------------------------------
-- The bundled ActorCausalSite, with constructed (not postulated)
-- stability.
------------------------------------------------------------------------

tiny-site : ActorCausalSite TinyAB ℓ-zero ℓ-zero ℓ-zero
tiny-site = record
  { identity-cover     = identity-cover-canonical     TinyAB ℓ-zero
  ; transitivity-cover = transitivity-cover-canonical TinyAB
  ; stability-cover    = stability-cover-pullback      TinyAB
  }

------------------------------------------------------------------------
-- Sanity check: the full site typechecks.
------------------------------------------------------------------------

private
  _ : ActorCausalSite TinyAB ℓ-zero ℓ-zero ℓ-zero
  _ = tiny-site
