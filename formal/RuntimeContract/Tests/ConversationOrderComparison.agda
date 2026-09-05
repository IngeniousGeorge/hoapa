{-# OPTIONS --cubical --guardedness #-}

-- Concrete saturation witnesses, on the four-event cross-conversation run.
--
-- `Realization/ConversationOrderComparison.agda` is generic: it defines the
-- internal parent-generated order and characterizes when it supports the
-- canonical embedding. This module supplies the instances, and they are the
-- reason `fixtures/valid/cross_conversation.json` was admitted to the corpus.
--
-- The run, by event id:
--
--   e0  in c0   parents []      e1  in c1   parents [e0]
--   e2  in c0   parents [e1]    e3  in c1   parents [e1]
--
-- so it exhibits BOTH outcomes at once, in one causal structure:
--
--   * c1 = {e1, e3} is causally saturated, and NON-TRIVIALLY so: its two
--     events are distinct and related by an internal parent edge, so the
--     positive direction is not discharged at a degenerate instance.
--   * c0 = {e0, e2} is NOT saturated. e0 ≤ e2 globally — the only witness
--     runs e0 → e1 → e2, through c1 — while c0 has no internal parent edge
--     at all, so its generated order is discrete.
--
-- Saturation is therefore a per-conversation property, varying between two
-- conversations of ONE run. A run with a single conversation could not have
-- shown that, which is why the fixture has two.
--
-- The corollary is the point of the whole comparison: `ConversationLocality`
-- gives conversation frames the restricted global order, and for c0 the
-- parent-generated alternative is unavailable under the canonical strict
-- embedding. Note the quantifier — c1 shows the alternative CAN work; what it
-- cannot do is work uniformly, for every conversation, from `WellFormed`
-- alone.
--
-- STATED EXACTLY. `c0-no-canonical-embedding` rules out embeddings whose
-- event map is pointwise `fst`. It says nothing about embeddings with some
-- other event map, and nothing about c0's internal-order frame in general.

module RuntimeContract.Tests.ConversationOrderComparison where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Nat using (ℕ; zero; suc; znots; injSuc)
open import Cubical.Data.Bool using (true; false≢true)
open import Cubical.Data.Bool.Properties using (isSetBool)
open import Cubical.Data.List using (List)
open import Cubical.Data.Sum using (_⊎_; inl; inr)
open import Cubical.Data.Sigma using (_,_; fst; snd; Σ≡Prop)
open import Cubical.Data.Empty using (rec)
open import Cubical.Relation.Nullary using (¬_)
open import Cubical.HITs.PropositionalTruncation using (∣_∣₁)

open import Concurrency.Sites.ActorBase using (CausalOrder)
open import Concurrency.Sites.ActorCausal using (FrameHom)

open import RuntimeContract.Trace
open RawEvent
open RawTrace
open RawRun
open import RuntimeContract.TraceLookup using (firstEvent)
open import RuntimeContract.Realization.CausalFromParents
  using (REvent; ParentEdge; parent-edge-implies-causal; realizeCausal;
         realizeActorBase; realizeFrame)
open import RuntimeContract.Realization.ConversationLocality
  using (RConversation; ConversationEvent; ConversationEvent-set;
         InConversation-isProp; conversationCausal)
open import RuntimeContract.Realization.ConversationOrderComparison
open import RuntimeContract.Generated.Raw.Valid.CrossConversation
  using () renaming (term to run)

------------------------------------------------------------------------
-- The run, its conversations, and its events.
--
-- Every one of these is `refl`: the fixture's well-formedness, conversation
-- presence, and event presence all COMPUTE. Nothing here is asserted.
------------------------------------------------------------------------

wf : WellFormed run
wf = refl

c0 c1 : RConversation run wf
c0 = 0 , refl
c1 = 1 , refl

private
  es : List RawEvent
  es = traceEvents (trace run)

  _≤G_ : REvent run wf → REvent run wf → Type
  _≤G_ = CausalOrder._≤_ (realizeCausal run wf)

  ev0 ev1 ev2 ev3 : REvent run wf
  ev0 = 0 , refl
  ev1 = 1 , refl
  ev2 = 2 , refl
  ev3 = 3 , refl

  -- Both projections out of a conversation event are proof-irrelevant, so an
  -- equality of ids lifts to an equality of events.
  sameREvent : (a b : REvent run wf) → fst a ≡ fst b → a ≡ b
  sameREvent a b p = Σ≡Prop (λ n → isSetBool (n ∈? evIdsOf es) true) p

  sameCEvent : (c : RConversation run wf) (x y : ConversationEvent run wf c)
             → fst (fst x) ≡ fst (fst y) → x ≡ y
  sameCEvent c x y p =
    Σ≡Prop (InConversation-isProp run wf c) (sameREvent (fst x) (fst y) p)

------------------------------------------------------------------------
-- Enumerating each conversation's events.
--
-- A `ConversationEvent` carries an id, a presence proof, and a membership
-- refinement. Splitting on the id, every branch outside the conversation is
-- closed by COMPUTATION: ids past the last event fail the presence test, and
-- ids of the other conversation's events fail the refinement.
------------------------------------------------------------------------

private
  classify-c0 : (x : ConversationEvent run wf c0)
              → (fst (fst x) ≡ 0) ⊎ (fst (fst x) ≡ 2)
  classify-c0 ((zero , _) , _)                        = inl refl
  classify-c0 ((suc zero , _) , inc)                  = rec (false≢true inc)
  classify-c0 ((suc (suc zero) , _) , _)              = inr refl
  classify-c0 ((suc (suc (suc zero)) , _) , inc)      = rec (false≢true inc)
  classify-c0 ((suc (suc (suc (suc _))) , mem) , _)   = rec (false≢true mem)

  classify-c1 : (x : ConversationEvent run wf c1)
              → (fst (fst x) ≡ 1) ⊎ (fst (fst x) ≡ 3)
  classify-c1 ((zero , _) , inc)                      = rec (false≢true inc)
  classify-c1 ((suc zero , _) , _)                    = inl refl
  classify-c1 ((suc (suc zero) , _) , inc)            = rec (false≢true inc)
  classify-c1 ((suc (suc (suc zero)) , _) , _)        = inr refl
  classify-c1 ((suc (suc (suc (suc _))) , mem) , _)   = rec (false≢true mem)

------------------------------------------------------------------------
-- The parent edges, as causal relations.
------------------------------------------------------------------------

private
  edge-e0-e1 : ParentEdge run wf ev0 ev1
  edge-e0-e1 = refl

  edge-e1-e2 : ParentEdge run wf ev1 ev2
  edge-e1-e2 = refl

  edge-e1-e3 : ParentEdge run wf ev1 ev3
  edge-e1-e3 = refl

  -- The concrete witnesses pass `ParentEdge` endpoints explicitly. `ParentEdge a b` unfolds to a
  -- Boolean equation in which `a` and `b` appear only under `∈?` and
  -- `firstEvent`, so unification cannot recover them from the argument's
  -- type. Making it a record or data type would let inference work; that is
  -- a change to `CausalFromParents`, not worth making for two call sites.
  ev0≤ev2 : ev0 ≤G ev2
  ev0≤ev2 = CausalOrder.≤-trans (realizeCausal run wf)
              (parent-edge-implies-causal run wf {ev0} {ev1} edge-e0-e1)
              (parent-edge-implies-causal run wf {ev1} {ev2} edge-e1-e2)

  ev1≤ev3 : ev1 ≤G ev3
  ev1≤ev3 = parent-edge-implies-causal run wf {ev1} {ev3} edge-e1-e3

ce0 ce2 : ConversationEvent run wf c0
ce0 = ev0 , refl
ce2 = ev2 , refl

-- The selected order on c0, exercised on the case it exists for: the two c0
-- events ARE related in the conversation frame `ConversationLocality` builds,
-- and the only witness is the path through e1 in c1. This is the same term as
-- `ev0≤ev2` — which is the content of `local-order-is-global-restriction`,
-- now applied rather than merely stated.
c0-restricted-sees-external-path :
  CausalOrder._≤_ (conversationCausal run wf c0) ce0 ce2
c0-restricted-sees-external-path = ev0≤ev2

------------------------------------------------------------------------
-- c1 IS saturated, non-trivially.
------------------------------------------------------------------------

c1-saturated : ConversationCausallySaturated run wf c1
c1-saturated x y p with classify-c1 x | classify-c1 y
-- diagonal: the two events coincide, so the empty chain suffices
... | inl px | inl py =
      subst (λ z → _≤L_ run wf c1 x z) (sameCEvent c1 x y (px ∙ sym py))
            ∣ nil ∣₁
... | inr px | inr py =
      subst (λ z → _≤L_ run wf c1 x z) (sameCEvent c1 x y (px ∙ sym py))
            ∣ nil ∣₁
-- e1 ≤ e3: a single INTERNAL parent edge, which is what makes this instance
-- non-degenerate — the events are distinct and the chain is non-empty
... | inl px | inr py =
      ∣ cons
          (subst2 (λ m n → (m ∈? evParents (firstEvent n es)) ≡ true)
                  (sym px) (sym py) edge-e1-3)
          nil ∣₁
  where
    edge-e1-3 : (1 ∈? evParents (firstEvent 3 es)) ≡ true
    edge-e1-3 = refl
-- e3 ≤ e1 is impossible: with e1 ≤ e3 already established, antisymmetry
-- would identify the two events, hence the ids 1 and 3
... | inr px | inl py = rec (znots (injSuc (cong fst ev1≡ev3)))
  where
    x≡ev3 : fst x ≡ ev3
    x≡ev3 = sameREvent (fst x) ev3 px
    y≡ev1 : fst y ≡ ev1
    y≡ev1 = sameREvent (fst y) ev1 py
    ev3≤ev1 : ev3 ≤G ev1
    ev3≤ev1 = subst2 _≤G_ x≡ev3 y≡ev1 p
    ev1≡ev3 : ev1 ≡ ev3
    ev1≡ev3 = CausalOrder.≤-antisym (realizeCausal run wf) ev1≤ev3 ev3≤ev1

c1-canonical-embedding :
  FrameHom (realizeActorBase run wf)
           (conversationInternalFrame run wf c1)
           (realizeFrame run wf)
c1-canonical-embedding = saturated→embed run wf c1 c1-saturated

------------------------------------------------------------------------
-- c0 is NOT saturated.
--
-- The route avoids inspecting chains: c0 has no internal parent edge at all,
-- so by leastness its generated order is contained in equality. e0 ≤ e2
-- globally, so saturation would identify e0 with e2.
------------------------------------------------------------------------

private
  no-internal-edge-c0 :
    (x y : ConversationEvent run wf c0) → ¬ InternalEdge run wf c0 x y
  no-internal-edge-c0 x y e with classify-c0 x | classify-c0 y
  ... | inl px | inl py = false≢true (closed px py)
    where
      closed : fst (fst x) ≡ 0 → fst (fst y) ≡ 0
             → (0 ∈? evParents (firstEvent 0 es)) ≡ true
      closed p q = subst2 (λ m n → (m ∈? evParents (firstEvent n es)) ≡ true) p q e
  ... | inl px | inr py = false≢true (closed px py)
    where
      closed : fst (fst x) ≡ 0 → fst (fst y) ≡ 2
             → (0 ∈? evParents (firstEvent 2 es)) ≡ true
      closed p q = subst2 (λ m n → (m ∈? evParents (firstEvent n es)) ≡ true) p q e
  ... | inr px | inl py = false≢true (closed px py)
    where
      closed : fst (fst x) ≡ 2 → fst (fst y) ≡ 0
             → (2 ∈? evParents (firstEvent 0 es)) ≡ true
      closed p q = subst2 (λ m n → (m ∈? evParents (firstEvent n es)) ≡ true) p q e
  ... | inr px | inr py = false≢true (closed px py)
    where
      closed : fst (fst x) ≡ 2 → fst (fst y) ≡ 2
             → (2 ∈? evParents (firstEvent 2 es)) ≡ true
      closed p q = subst2 (λ m n → (m ∈? evParents (firstEvent n es)) ≡ true) p q e

  -- leastness at equality: no internal edges, so nothing beyond reflexivity
  ≤L-c0-discrete : {x y : ConversationEvent run wf c0}
                 → _≤L_ run wf c0 x y → x ≡ y
  ≤L-c0-discrete =
    ≤L-least run wf c0 _≡_
      (ConversationEvent-set run wf c0 _ _)
      (λ _ → refl)
      _∙_
      (λ {x} {y} e → rec (no-internal-edge-c0 x y e))


c0-not-saturated : ¬ ConversationCausallySaturated run wf c0
c0-not-saturated sat =
  znots (cong fst (cong fst (≤L-c0-discrete (sat ce0 ce2 ev0≤ev2))))

------------------------------------------------------------------------
-- The corollary: for c0 the parent-generated order admits no canonical
-- embedding, so the restricted global order was not a preference.
------------------------------------------------------------------------

c0-no-canonical-embedding :
    (φ : FrameHom (realizeActorBase run wf)
                  (conversationInternalFrame run wf c0)
                  (realizeFrame run wf))
  → ¬ ((x : ConversationEvent run wf c0)
       → FrameHom.event-map φ x ≡ fst x)
c0-no-canonical-embedding φ canonical =
  c0-not-saturated (embed→saturated run wf c0 φ canonical)
