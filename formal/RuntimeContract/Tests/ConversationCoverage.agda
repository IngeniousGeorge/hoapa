{-# OPTIONS --cubical --safe --guardedness #-}

-- Hand-authored assertions for a property that is NOT well-formedness.
--
-- `Tests/Valid.agda` carries the one verdict the corpus directory layout
-- encodes: whether `valid?` accepts a fixture. Actor coverage is an optional
-- strengthening, so its verdicts live here rather than being folded into that
-- module or, worse, into the wire fixtures as metadata.
--
-- The pair below is the executable form of the claim that `valid?` does not
-- entail actor coverage: both runs are accepted by `valid?`, and exactly one
-- of them is covered. If a coverage clause were ever folded into `valid?`,
-- `uncoveredActor` would stop being a valid fixture and this module would go
-- red — which is the point of admitting it to the corpus.

module RuntimeContract.Tests.ConversationCoverage where

open import Cubical.Data.Bool using (true; false)
open import Cubical.Foundations.Prelude using (_≡_; refl)
open import RuntimeContract.ConversationActorCoverage
  using (actorsCoveredByConversations?)
open import RuntimeContract.Generated.Raw.Valid.CrossConversation
  using () renaming (term to crossConversation)
open import RuntimeContract.Generated.Raw.Valid.UncoveredActor
  using () renaming (term to uncoveredActor)

-- Every actor of the four-event run joins a conversation.
_ : actorsCoveredByConversations? crossConversation ≡ true
_ = refl

-- `a1` is declared and joins none.
_ : actorsCoveredByConversations? uncoveredActor ≡ false
_ = refl
