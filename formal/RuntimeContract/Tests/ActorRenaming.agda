{-# OPTIONS --cubical --safe --guardedness #-}

-- Concrete witnesses for actor relabeling, against the authoritative
-- corpus fixture `fixtures/valid/cross_conversation.json` (actors
-- a0,a1,a2 ↦ dense 0,1,2).
--
-- These are DEGENERACY CONTROLS, not leak falsifiers. They rule out the
-- reading in which `renameActors` is secretly the identity, and they
-- exercise each of the module's three hypothesis strata at a real run.
-- A gate-6 leak falsifier would need identity-sensitive content,
-- provenance, ranking, or an observation beyond `valid?`; none exists
-- yet, because `valid?` has no actor-identity-sensitive clause by
-- construction.
--
-- The three strata, each witnessed:
--
--   * arbitrary map     — REJECTED. Two collapsing maps turn the valid
--     fixture invalid, which is why injectivity is load-bearing rather
--     than decorative.
--   * embedding         — ACCEPTED under `suc`, a non-surjective
--     embedding. This is the evidence that validator naturality genuinely
--     extends outside the core, and that leaving the dense coordinate
--     slice changes nothing.
--   * permutation       — ACCEPTED under a transposition, with the actor
--     list demonstrably moved.
--
-- The acceptance assertions are routed THROUGH the theorems rather than
-- through `refl`, so they are unmet obligations until the theorems are
-- proved, and they check that the theorems compute at a real fixture.
-- The rejection assertions must be computational: they are precisely
-- claims about the ABSENCE of a theorem for arbitrary maps.

module RuntimeContract.Tests.ActorRenaming where

open import Cubical.Foundations.Prelude using (_≡_; refl)
open import Cubical.Data.Nat using (ℕ; zero; suc)
open import Cubical.Data.Nat.Properties using (snotz; injSuc)
open import Cubical.Data.Bool using (Bool; true; false)
open import Cubical.Data.List using (List; []; _∷_)
open import Cubical.Relation.Nullary using (¬_)

open import RuntimeContract.Trace
  using ( ActorId; RawTrace; RawRun; valid?; WellFormed
        ; distinctB; allB; convOK; eventOK; convIdsOf )
open RawTrace
open RawRun
open import RuntimeContract.ActorRenaming
open import RuntimeContract.Generated.Raw.Valid.CrossConversation
  using () renaming (term to crossConversation)

-- ----------------------------------------------------------------------
-- Arrows used as witnesses.
-- ----------------------------------------------------------------------

-- A non-surjective embedding: shifts every actor coordinate up by one,
-- leaving the dense first-appearance slice.
sucActorEmbedding : ActorEmbedding ActorId ActorId
sucActorEmbedding = actorEmbedding suc (λ m n p → injSuc p)

-- Non-surjectivity, proved rather than asserted: actor 0 has no preimage.
-- This is what makes `suc` checked evidence that validator naturality
-- extends strictly outside the core, rather than an interpretive remark.
sucIsNotSurjective : (a : ActorId) → ¬ (suc a ≡ zero)
sucIsNotSurjective a = snotz

-- The transposition of actors 0 and 1: an element of the core.
swap01 : ActorId → ActorId
swap01 zero                = suc zero
swap01 (suc zero)          = zero
swap01 (suc (suc n))       = suc (suc n)

swap01-involutive : (a : ActorId) → swap01 (swap01 a) ≡ a
swap01-involutive zero          = refl
swap01-involutive (suc zero)    = refl
swap01-involutive (suc (suc n)) = refl

swap01Permutation : ActorPermutation ActorId
swap01Permutation =
  actorIsomorphism swap01 swap01 swap01-involutive swap01-involutive

-- ----------------------------------------------------------------------
-- Arbitrary maps: why injectivity is load-bearing.
-- ----------------------------------------------------------------------

-- Collapses all three declared actors onto one. Several conjuncts fail.
collapseAllToZero : ActorId → ActorId
collapseAllToZero _ = zero

-- The sharper counterexample. c0 = {a0,a1} and c1 = {a1,a2}, so sending
-- 2 ↦ 0 while fixing 0 and 1 fails trace-actor distinctness while leaving
-- every conversation-membership and touch clause satisfied. It names the
-- clause injectivity protects. The remaining conjuncts (format code,
-- sibling/conversation/event ID distinctness, backward parents) are
-- untouched by ANY renaming, which the arbitrary-map lemmas of
-- `ActorRenaming` establish generically rather than at this fixture.
collapseTwoToZero : ActorId → ActorId
collapseTwoToZero zero                      = zero
collapseTwoToZero (suc zero)                = suc zero
collapseTwoToZero (suc (suc zero))          = zero
collapseTwoToZero (suc (suc (suc n)))       = suc (suc (suc n))

_ : valid? (renameActors collapseAllToZero crossConversation) ≡ false
_ = refl

_ : valid? (renameActors collapseTwoToZero crossConversation) ≡ false
_ = refl

-- Focused checks backing the comment above: exactly which clause moved.
private
  collapsedTrace : RawTrace
  collapsedTrace = trace (renameActors collapseTwoToZero crossConversation)

_ : distinctB (traceActors collapsedTrace) ≡ false
_ = refl

_ : allB (convOK (traceActors collapsedTrace)) (traceConvs collapsedTrace) ≡ true
_ = refl

_ : allB (eventOK (convIdsOf (traceConvs collapsedTrace)) (traceConvs collapsedTrace))
         (traceEvents collapsedTrace)
    ≡ true
_ = refl

-- ----------------------------------------------------------------------
-- Non-vacuity: the action actually moves the actor list.
-- ----------------------------------------------------------------------

_ : traceActors (trace (renameActors swap01 crossConversation))
    ≡ (suc zero ∷ zero ∷ suc (suc zero) ∷ [])
_ = refl

-- ----------------------------------------------------------------------
-- Embedding stratum: accepted outside the core and outside the dense
-- slice. Routed through the theorem.
-- ----------------------------------------------------------------------

_ : valid? (renameActors (embeddingMap sucActorEmbedding) crossConversation)
    ≡ true
_ = validator-invariant-under-actor-embedding sucActorEmbedding crossConversation

-- ----------------------------------------------------------------------
-- Permutation stratum: accepted under the transposition, and the
-- transport API delivers an actual proof rather than a path of types.
-- ----------------------------------------------------------------------

_ : valid? (renameActors (isomorphismTo swap01Permutation) crossConversation)
    ≡ true
_ = validator-invariant-under-actor-embedding
      (isomorphismToEmbedding swap01Permutation) crossConversation

_ : WellFormed (renameActors (isomorphismTo swap01Permutation) crossConversation)
_ = wellFormed-transport-along-permutation swap01Permutation crossConversation refl
