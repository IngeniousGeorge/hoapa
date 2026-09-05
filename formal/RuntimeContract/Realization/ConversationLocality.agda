{-# OPTIONS --cubical --guardedness #-}

-- Per-conversation locality: the second rung of the runtime-to-substrate
-- junction.
--
-- `Realization/CausalFromParents.agda` realizes a well-formed raw run as ONE
-- global `LocalFrame` holding every present actor (`ActorIn ≡ Unit`).
-- Conversations are validated by `valid?` there, but do not shape the
-- realized object. This module adds the missing per-conversation views
-- without changing the global frame: every conversation present in the run
-- becomes its own `LocalFrame`, and each embeds into the global frame as a
-- strict causal sub-view (`FrameHom`).
--
-- Structure:
--   * `RConversation` — the conversations actually present in the run. The
--     API is indexed by this rather than by a bare `ConvId` so that callers
--     cannot ask for the frame of an absent conversation, and so that future
--     session-tag assignment has a conversation index to hang on.
--   * `conversationFrame` — the sub-frame: events refined to those whose
--     conversation is `c`, actors refined to that conversation's actor list,
--     incidence inherited from the global frame.
--   * `conversationEmbed` — the `FrameHom` into `CausalFromParents`'s global
--     frame.
--
-- THE SEMANTIC COMMITMENT: LOCAL VIEWS OF GLOBAL CAUSALITY.
--
-- The order on a conversation frame is the GLOBAL derived order restricted
-- to that conversation's events — not an order regenerated from the parent
-- edges internal to the conversation. `local-order-is-global-restriction`
-- states this as a definitional equation rather than leaving it to be read
-- off the implementation.
--
-- The consequence is deliberate and should not be mistaken for an artifact:
-- a conversation frame can carry `x ≤ y` whose only witness is a causal
-- chain routed through events in OTHER conversations. A conversation is a
-- local view of one global causal structure, not an independently generated
-- causal system.
--
-- It is also what makes the embedding legal. `FrameHom` demands strict
-- causality REFLECTION (`causal-refl`), so had the local order been
-- generated from intra-conversation parent edges only, two events related
-- solely through a cross-conversation path would be ordered globally and
-- unordered locally, and no `FrameHom` would exist. Under restriction,
-- preservation and reflection are both the identity.
--
-- That paragraph is no longer only prose.
-- `Realization/ConversationOrderComparison.agda` builds the rival
-- parent-generated order and proves the canonical embedding exists exactly
-- when the conversation is causally saturated;
-- `Tests/ConversationOrderComparison.agda` exhibits a conversation of a
-- corpus fixture that is not, and therefore admits no such embedding.
--
-- STATED WITH ITS QUANTIFIER. This does NOT say the internal order fails for
-- every conversation — the same fixture has one where it works. What is
-- forced is the UNIFORM construction: to build the canonical strict
-- embedding for every conversation of every well-formed run, from
-- `WellFormed` alone and with no saturation hypothesis, the internally
-- generated order cannot be used. That is the situation this module is in.
--
-- WHAT `WellFormed` DOES NOT YIELD: A COVER.
--
-- `WellFormed` does not imply that the conversation family is a `Cover` of
-- the global frame. The two coverage obligations differ in kind, and the
-- obstruction is a fact about `valid?` rather than a missing proof:
--
--   * `Cover.event-covered` follows UNIFORMLY — `eventOK`'s first conjunct
--     forces every event's conversation to be present, so every global event
--     lies in some conversation frame.
--   * `Cover.actor-covered` is NOT DERIVABLE from `WellFormed`. `convOK`
--     requires each conversation's actors to be among the global actors, but
--     nothing requires the converse. A run declaring an actor in
--     `traceActors` who appears in no conversation is well-formed, and that
--     actor sits in the global frame with no patch containing them.
--
-- Particular runs may still be covered — the tiny fixture below is one, since
-- its single conversation holds both actors. What is unavailable is the
-- uniform statement, so no `Cover` is constructed here.
--
-- Closing that gap means deciding whether a registered-but-inactive actor is
-- legal evidence — a runtime-contract question, not proof cleanup. It is
-- named here and deferred, not silently assumed away.
--
-- Deferred (later 2S rungs): session-tag assignment (`LocalFrame` carries no
-- session content), then actor-renaming invariance at the raw and realized
-- levels, valid-reordering invariance, and the SIP/univalence capstone.
--
-- Not `--safe`: the actor-causal substrate carries the infective
-- `--guardedness` flag. This module is nonetheless postulate- and hole-free.

module RuntimeContract.Realization.ConversationLocality where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.HLevels using (isSetΣ)
open import Cubical.Data.Nat using (ℕ; isSetℕ)
open import Cubical.Data.Bool using (Bool; true; false)
open import Cubical.Data.Bool.Properties using (isSetBool)
open import Cubical.Data.List using (List; []; _∷_)
open import Cubical.Data.Sigma using (Σ-syntax; _,_; fst; snd; Σ≡Prop)
open import Cubical.Data.Unit using (Unit; tt)

open import Concurrency.Sites.ActorBase using (ActorBase; CausalOrder)
open import Concurrency.Sites.ActorCausal using (LocalFrame; FrameHom)

open import RuntimeContract.Trace
open import RuntimeContract.TraceLookup
  using (firstEvent; eqℕ-sound; ⊆?-mem; allB-firstEvent;
         wellFormed-eventsOK; eventOK-touches)
open import RuntimeContract.Realization.CausalFromParents
  using (REvent; REvent-set; RActor; realizeActorBase; realizeCausal; realizeFrame)

open RawEvent
open RawTrace
open RawRun

------------------------------------------------------------------------
-- Per-conversation locality, for a fixed well-formed run.
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

    -- the global realization this module refines
    AB : ActorBase ℓ-zero
    AB = realizeActorBase r w

    GF : LocalFrame AB ℓ-zero ℓ-zero
    GF = realizeFrame r w

    -- Global order and incidence, reached through the record interface (the
    -- corresponding definitions in `CausalFromParents` are private, and the
    -- interface is the right dependency in any case).
    _≤G_ : REvent r w → REvent r w → Type
    _≤G_ = CausalOrder._≤_ (realizeCausal r w)

    gTouches : REvent r w → RActor r w → Type
    gTouches = LocalFrame.touches GF

    -- the raw event record carried by a realized event
    rawOf : REvent r w → RawEvent
    rawOf e = firstEvent (fst e) es

  --------------------------------------------------------------------
  -- Realized conversations: exactly those present in the run.
  --------------------------------------------------------------------

  RConversation : Type
  RConversation = Σ[ c ∈ ConvId ] ((c ∈? cids) ≡ true)

  RConversation-set : isSet RConversation
  RConversation-set =
    isSetΣ isSetℕ (λ c → isProp→isSet (isSetBool (c ∈? cids) true))

  --------------------------------------------------------------------
  -- Conversation membership for events, and the refined event carrier.
  --------------------------------------------------------------------

  InConversation : RConversation → REvent r w → Type
  InConversation c e = eqℕ (evConv (rawOf e)) (fst c) ≡ true

  InConversation-isProp : (c : RConversation) (e : REvent r w)
                        → isProp (InConversation c e)
  InConversation-isProp c e = isSetBool (eqℕ (evConv (rawOf e)) (fst c)) true

  ConversationEvent : RConversation → Type
  ConversationEvent c = Σ[ e ∈ REvent r w ] InConversation c e

  ConversationEvent-set : (c : RConversation) → isSet (ConversationEvent c)
  ConversationEvent-set c =
    isSetΣ (REvent-set r w) (λ e → isProp→isSet (InConversation-isProp c e))

  --------------------------------------------------------------------
  -- The restricted causal order.
  --
  -- Every law is inherited on the first projection; only antisymmetry needs
  -- work, and only to lift a path in `REvent` to a path in the refined
  -- Σ-type, which `Σ≡Prop` does because conversation membership is a prop.
  --------------------------------------------------------------------

  conversationCausal : RConversation → CausalOrder ℓ-zero ℓ-zero
  conversationCausal c = record
    { Event     = ConversationEvent c
    ; Event-set = ConversationEvent-set c
    ; _≤_       = λ x y → fst x ≤G fst y
    ; ≤-refl    = λ x → CausalOrder.≤-refl (realizeCausal r w) (fst x)
    ; ≤-trans   = CausalOrder.≤-trans (realizeCausal r w)
    ; ≤-antisym = λ p q →
        Σ≡Prop (InConversation-isProp c) (CausalOrder.≤-antisym (realizeCausal r w) p q)
    ; ≤-isProp  = CausalOrder.≤-isProp (realizeCausal r w)
    }

  --------------------------------------------------------------------
  -- Actor membership: this conversation's own actor list.
  --------------------------------------------------------------------

  ConversationActorIn : RConversation → RActor r w → Type
  ConversationActorIn c a = (fst a ∈? lookupConvActors (fst c) convs) ≡ true

  --------------------------------------------------------------------
  -- `touches-in-frame`: the one real proof obligation.
  --
  -- An event of conversation `c` only touches actors of `c`. The chain:
  --
  --   w                                    (the run is well-formed)
  --   ⇒ every event satisfies `eventOK`    (wellFormed-eventsOK)
  --   ⇒ THIS event satisfies `eventOK`     (allB-firstEvent, using the
  --                                         presence proof carried by REvent)
  --   ⇒ touches ⊆ its conversation actors  (eventOK-touches)
  --   ⇒ this actor is among them           (⊆?-mem)
  --   ⇒ … and that conversation is `c`     (eqℕ-sound on the refinement)
  --
  -- The last step is where `ConversationEvent`'s refinement pays for itself:
  -- without it we would only know the actor belongs to SOME conversation.
  --------------------------------------------------------------------

  private
    touches-in-conversation :
      (c : RConversation) (x : ConversationEvent c) (a : RActor r w)
      → gTouches (fst x) a → ConversationActorIn c a
    touches-in-conversation c x a p =
      subst (λ k → (fst a ∈? lookupConvActors k convs) ≡ true) convPath inOwnConv
      where
        e₀ : RawEvent
        e₀ = rawOf (fst x)

        eOK : eventOK cids convs e₀ ≡ true
        eOK = allB-firstEvent (eventOK cids convs) es (fst (fst x))
                              (snd (fst x)) (wellFormed-eventsOK r w)

        inOwnConv : (fst a ∈? lookupConvActors (evConv e₀) convs) ≡ true
        inOwnConv = ⊆?-mem (evTouches e₀) (lookupConvActors (evConv e₀) convs)
                           (fst a) (eventOK-touches cids convs e₀ eOK) p

        convPath : evConv e₀ ≡ fst c
        convPath = eqℕ-sound (evConv e₀) (fst c) (snd x)

  --------------------------------------------------------------------
  -- Checkpoint 1: the conversation as a LocalFrame.
  --------------------------------------------------------------------

  conversationFrame : RConversation → LocalFrame AB ℓ-zero ℓ-zero
  conversationFrame c = record
    { causal           = conversationCausal c
    ; ActorIn          = ConversationActorIn c
    ; ActorIn-isProp   = λ a → isSetBool (fst a ∈? lookupConvActors (fst c) convs) true
    ; touches          = λ x a → gTouches (fst x) a
    ; touches-isProp   = λ x a → LocalFrame.touches-isProp GF (fst x) a
    ; touches-in-frame = λ {x} {a} p → touches-in-conversation c x a p
    }

  --------------------------------------------------------------------
  -- Checkpoint 2: the embedding into the global frame.
  --
  -- `actor-pres` is trivial because the global frame's `ActorIn` is `Unit`.
  -- That is not a gap: `RActor` is already the subtype of actors present in
  -- the trace, so `Unit` is the correct membership predicate for the frame
  -- holding all of them. The content of this rung is that the SOURCE frame's
  -- `ActorIn` is now a genuine predicate.
  --------------------------------------------------------------------

  conversationEmbed : (c : RConversation)
                    → FrameHom AB (conversationFrame c) GF
  conversationEmbed c = record
    { actor-pres   = λ _ → tt
    ; event-map    = fst
    ; touches-pres = λ p → p
    ; causal-pres  = λ p → p
    ; causal-refl  = λ p → p
    }

  --------------------------------------------------------------------
  -- The restriction theorem, stated rather than left implicit.
  --
  -- `refl` IS the content: local causality is global causality on the first
  -- projection, so downstream code may reason about a conversation's order
  -- entirely in the global order — and `causal-refl` above is the identity
  -- rather than a proof.
  --------------------------------------------------------------------

  local-order-is-global-restriction :
    (c : RConversation) (x y : ConversationEvent c)
    → (CausalOrder._≤_ (conversationCausal c) x y) ≡ (fst x ≤G fst y)
  local-order-is-global-restriction c x y = refl

------------------------------------------------------------------------
-- Instantiation sanity: the tiny valid fixture.
--
-- LIMITATION, stated rather than implied: `tiny_trace.json` contains ONE
-- conversation (id 0, actors 0 and 1, both events in it). It therefore
-- exercises the construction — refined carrier, restricted order, the
-- `touches-in-frame` chain, and the embedding — but NOT the cross-conversation
-- causal path that motivates the restricted order. That case is covered
-- elsewhere: `fixtures/valid/cross_conversation.json` is shaped c0 → c1 → c0,
-- and `RuntimeContract.Tests.ConversationOrderComparison` exercises it.
--
-- It also happens to satisfy actor coverage (both actors are in the single
-- conversation), so it cannot reveal that gap either;
-- `fixtures/valid/uncovered_actor.json` is the run that does.
------------------------------------------------------------------------

open import RuntimeContract.Generated.Raw.Valid.TinyTrace using (term)

tiny-valid : valid? term ≡ true
tiny-valid = refl

tinyConversation : RConversation term tiny-valid
tinyConversation = 0 , refl

tinyConversationFrame : LocalFrame (realizeActorBase term tiny-valid) ℓ-zero ℓ-zero
tinyConversationFrame = conversationFrame term tiny-valid tinyConversation

tinyConversationEmbed :
  FrameHom (realizeActorBase term tiny-valid)
           tinyConversationFrame
           (realizeFrame term tiny-valid)
tinyConversationEmbed = conversationEmbed term tiny-valid tinyConversation
