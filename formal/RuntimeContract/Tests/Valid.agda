{-# OPTIONS --cubical --safe --guardedness #-}

-- Hand-authored conformance assertions: valid fixtures must be accepted.
-- The generated raw terms are data only; the polarity lives here.
--
-- This module carries exactly one verdict per fixture: whether `valid?`
-- accepts it, the verdict the corpus directory layout encodes. Optional
-- properties of the same fixtures (actor coverage, causal saturation) are
-- asserted in their own focused test modules, not here.
--
--   * `tinyTrace`         — one conversation, two events.
--   * `crossConversation` — two conversations, four events, with the c0
--     events related only through an event of c1. The assertion here
--     establishes acceptance only; the run supplies the motivating case for
--     the forthcoming order-comparison test, which is where it is exercised.
--   * `uncoveredActor`    — a declared actor who joins no conversation.
--     Well-formed by design: actor coverage is deliberately not a `valid?`
--     clause, and its own verdict is asserted in its own test module.

module RuntimeContract.Tests.Valid where

open import Cubical.Data.Bool using (true)
open import Cubical.Foundations.Prelude using (_≡_; refl)
open import RuntimeContract.Trace using (valid?)
open import RuntimeContract.Generated.Raw.Valid.TinyTrace
  using () renaming (term to tinyTrace)
open import RuntimeContract.Generated.Raw.Valid.CrossConversation
  using () renaming (term to crossConversation)
open import RuntimeContract.Generated.Raw.Valid.UncoveredActor
  using () renaming (term to uncoveredActor)

_ : valid? tinyTrace ≡ true
_ = refl

_ : valid? crossConversation ≡ true
_ = refl

_ : valid? uncoveredActor ≡ true
_ = refl
