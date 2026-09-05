{-# OPTIONS --cubical --guardedness #-}

-- Coverage of the global frame by its conversation frames.
--
-- `ConversationLocality.agda` realizes each conversation present in a
-- well-formed run as a `LocalFrame` and embeds it into the global frame of
-- `CausalFromParents.agda`. What it deliberately does NOT do is package that
-- family as a `Cover`, because `Cover` carries two coverage obligations and
-- `WellFormed` supplies only one of them:
--
--   * `event-covered` is UNIFORM. `eventOK`'s first conjunct forces every
--     event's conversation to be present in the run, so every global event
--     lies in some conversation frame. That is `conversation-event-covered`
--     below, and it takes no hypothesis beyond `WellFormed`.
--
--   * `actor-covered` is NOT DERIVABLE. `convOK` requires each conversation's
--     actors to be among the global actors; nothing requires the converse. A
--     run declaring an actor in `traceActors` who joins no conversation is
--     well-formed — `fixtures/valid/uncovered_actor.json` is exactly such a
--     run, admitted to the corpus so that this gap is executable rather than
--     asserted in prose.
--
-- The asymmetry is a fact about `valid?`, not a missing proof, and it is the
-- reason the runtime registers actors independently of conversation
-- membership: narrowing `valid?` to force coverage would have retired
-- registered-but-inactive actors as legal evidence.
--
-- So coverage enters as a HYPOTHESIS rather than a clause. This module names
-- that hypothesis (`ConversationActorCoverage`), proves the raw Boolean
-- `actorsCoveredByConversations?` equivalent to it in both directions, and
-- builds the `Cover` conditional on it. Restricting the objects would have
-- been the cheaper move; making the covering family conditional keeps every
-- well-formed run an object and puts the condition where it belongs.
--
-- Not `--safe`: the actor-causal substrate carries the infective
-- `--guardedness` flag. This module is nonetheless postulate- and hole-free.

module RuntimeContract.Realization.ConversationCover where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Nat using (ℕ)
open import Cubical.Data.Bool using (Bool; true)
open import Cubical.Data.List using (List)
open import Cubical.Data.Sigma using (Σ-syntax; _×_; _,_; fst; snd)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal using (Cover)

open import RuntimeContract.Trace
open import RuntimeContract.ConversationActorCoverage
  using (actorsCoveredByConversations?; anyB; anyB-found; anyB-intro;
         allB-mem; allB-fromMembers)
open import RuntimeContract.TraceLookup
  using (firstEvent; eqℕ-refl; allB-firstEvent;
         wellFormed-eventsOK; eventOK-conversation)
open import RuntimeContract.Realization.CausalFromParents
  using (REvent; RActor; realizeActorBase; realizeFrame)
open import RuntimeContract.Realization.ConversationLocality
  using (RConversation; InConversation; ConversationEvent; ConversationActorIn;
         conversationFrame; conversationEmbed)

open RawEvent
open RawTrace
open RawRun

------------------------------------------------------------------------
-- Event coverage, for a fixed well-formed run.
------------------------------------------------------------------------

module _ (r : RawRun) (w : WellFormed r) where

  private
    t : RawTrace
    t = trace r

    es : List RawEvent
    es = traceEvents t

    convs : List RawConversation
    convs = traceConvs t

    cids : List ConvId
    cids = convIdsOf convs

    AB : ActorBase ℓ-zero
    AB = realizeActorBase r w

  --------------------------------------------------------------------
  -- Every global event is the image of an event of some conversation
  -- frame — `Cover.event-covered` for the conversation family, in the
  -- explicit basis form (chosen index, chosen pre-image, witnessing path).
  --
  -- The witness is not "some" conversation found by search: it is the
  -- event's OWN conversation, read off its raw record. That is what makes
  -- the path component `refl` — the pre-image is the event itself, carrying
  -- a membership refinement rather than being transported anywhere.
  --
  -- The chain:
  --
  --   w                                 (the run is well-formed)
  --   ⇒ every event satisfies `eventOK` (wellFormed-eventsOK)
  --   ⇒ THIS event satisfies `eventOK`  (allB-firstEvent, using the
  --                                      presence proof carried by REvent)
  --   ⇒ its conversation is present     (eventOK-conversation)
  --
  -- and the refinement `InConversation` is then discharged by `eqℕ-refl`:
  -- the event is in the conversation its own record names.
  --------------------------------------------------------------------

  conversation-event-covered :
      (e : REvent r w)
    → Σ[ c ∈ RConversation r w ]
        Σ[ x ∈ ConversationEvent r w c ] (fst x ≡ e)
  conversation-event-covered e = ownConversation , (e , inOwnConversation) , refl
    where
      e₀ : RawEvent
      e₀ = firstEvent (fst e) es

      eOK : eventOK cids convs e₀ ≡ true
      eOK = allB-firstEvent (eventOK cids convs) es (fst e)
                            (snd e) (wellFormed-eventsOK r w)

      ownConversation : RConversation r w
      ownConversation = evConv e₀ , eventOK-conversation cids convs e₀ eOK

      inOwnConversation : InConversation r w ownConversation e
      inOwnConversation = eqℕ-refl (evConv e₀)

  --------------------------------------------------------------------
  -- Actor coverage: the obligation `WellFormed` does not supply.
  --------------------------------------------------------------------

  ConversationActorCoverage : Type
  ConversationActorCoverage =
    (a : RActor r w) → Σ[ c ∈ RConversation r w ] ConversationActorIn r w c a

  private
    -- the per-actor test, named once so both directions read the same
    joinsSome : ℕ → Bool
    joinsSome x = anyB (λ c → x ∈? lookupConvActors c convs) cids

  --------------------------------------------------------------------
  -- The raw Boolean DECIDES the realized property: both directions, so a
  -- `false` verdict rules the hypothesis OUT rather than merely failing to
  -- supply it. Soundness alone would make the Boolean a sufficient
  -- certificate and would leave the negative fixture proving nothing beyond
  -- its own computation.
  --
  -- STATED EXACTLY. A `false` verdict says `ConversationActorCoverage` is
  -- uninhabited, hence that `conversation-cover` is unavailable for that
  -- run. It does NOT say the global frame has no cover — every frame has its
  -- identity cover — and it does not characterize every `Cover` record whose
  -- index, patches and embeddings happen to agree with the canonical family.
  -- The claim is about this hypothesis and this construction.
  --
  -- Neither direction needs conversation-ID distinctness: the Boolean
  -- quantifies over the same conversation IDs the realized statement does,
  -- and tests through the same `lookupConvActors`.
  --------------------------------------------------------------------

  coverage-sound :
    actorsCoveredByConversations? r ≡ true → ConversationActorCoverage
  coverage-sound h a =
    (fst found , fst (snd found)) , snd (snd found)
    where
      perActor : joinsSome (fst a) ≡ true
      perActor = allB-mem joinsSome (traceActors t) (fst a) h (snd a)

      found : Σ[ c ∈ ConvId ]
                (((c ∈? cids) ≡ true) × ((fst a ∈? lookupConvActors c convs) ≡ true))
      found = anyB-found (λ c → fst a ∈? lookupConvActors c convs) cids perActor

  coverage-complete :
    ConversationActorCoverage → actorsCoveredByConversations? r ≡ true
  coverage-complete cov = allB-fromMembers joinsSome (traceActors t) perActor
    where
      perActor : (x : ℕ) → (x ∈? traceActors t) ≡ true → joinsSome x ≡ true
      perActor x xIn =
        anyB-intro (λ c → x ∈? lookupConvActors c convs) cids
                   (fst chosen) (snd chosen) inChosen
        where
          -- the membership proof is exactly what `RActor` asks for
          chosen : RConversation r w
          chosen = fst (cov (x , xIn))
          inChosen : ConversationActorIn r w chosen (x , xIn)
          inChosen = snd (cov (x , xIn))

  --------------------------------------------------------------------
  -- The conditional `Cover`.
  --
  -- `actor-covered` IS the hypothesis, applied; `event-covered` is the
  -- unconditional lemma above. That asymmetry — one field assumed, one
  -- proved — is the whole content of this module, and it is why the family
  -- is not packaged as a `Cover` in `ConversationLocality.agda`.
  --
  -- `actor-covered` discards its `ActorIn` argument because the global
  -- frame's is `Unit`: `RActor` is already the subtype of actors present in
  -- the trace, so there is no further membership to consume.
  --------------------------------------------------------------------

  conversation-cover :
    ConversationActorCoverage → Cover AB ℓ-zero (realizeFrame r w)
  conversation-cover cov = record
    { Index         = RConversation r w
    ; patch         = conversationFrame r w
    ; embed         = conversationEmbed r w
    ; actor-covered = λ {a} _ → cov a
    ; event-covered = conversation-event-covered
    }
