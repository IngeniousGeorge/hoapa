{-# OPTIONS --cubical --guardedness #-}

-- The concrete two-actor `ActorBase` used by the tiny finite-cover witness
-- and the Chu coefficient example.
--
-- `TinyAB` was originally defined inside `Concurrency/Sites/ActorCausal.agda`,
-- but that module also carries the legacy `stability-cover-postulate`
-- in-file fallback. Anything importing `TinyAB` from there therefore pulls a
-- postulate into its transitive closure, even though `TinyAB` itself is
-- constructive. This sibling module isolates the constructive base so that
-- the Chu non-vacuity witness (`Concurrency/Hybrid/ChuPointExample.agda`)
-- has a genuinely postulate-free import closure.
--
-- It imports only `Concurrency.Sites.ActorBase` (postulate-free) and `Fin`,
-- so there is no import cycle with `ActorCausal`, which re-imports `TinyAB`
-- from here.

module Concurrency.Sites.TinyActorBase where

open import Cubical.Foundations.Prelude    using (ℓ-zero)
open import Cubical.Data.Fin               using (Fin)
open import Cubical.Data.Fin.Properties    using (isSetFin)

open import Concurrency.Sites.ActorBase    using (ActorBase)

------------------------------------------------------------------------
-- TinyAB: actor base with `Actor = Fin 2`. Two actors, opaque.
------------------------------------------------------------------------

TinyAB : ActorBase ℓ-zero
TinyAB = record
  { Actor     = Fin 2
  ; Actor-set = isSetFin {k = 2}
  }
