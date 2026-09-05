{-# OPTIONS --cubical --safe --guardedness #-}

-- Raw-trace lookup and validation peeling: the shared substrate-free layer
-- underneath every realization module.
--
-- `RuntimeContract.Trace` fixes the serializable records and the Boolean
-- validator `valid?`. Realization modules need two services from that layer
-- before any substrate appears:
--
--   * LOOKUP — retrieve the raw record carried by an id (`firstEvent`), and
--     reason about list membership (`⊆?-mem`, `eqℕ-sound`, `eqℕ-sym`).
--
--   * PEELING — extract a single named conjunct from `WellFormed r`
--     (`wellFormed-eventsOK`, `wellFormed-backwardOK`).
--
-- Both are facts about raw trace DATA, not about causal rank or about the
-- actor-causal substrate, which is why they live here rather than in
-- `BackwardRank` (rank scaffolding) or in a substrate-bearing realization
-- assembly module. Consumers:
-- `BackwardRank`, `CausalFromParents`, `ConversationLocality`.
--
-- Why peeling deserves a name. `valid?` is a right-nested `andB` chain, so
-- reaching its seventh conjunct means writing a tower of projections whose
-- shape depends on the POSITION of every earlier clause. Open-coding that
-- tower in each consumer makes every realization module silently fragile
-- against reordering `valid?`. The two lemmas below are the only place that
-- positional knowledge lives; adding or reordering a `valid?` clause breaks
-- them and nothing else.
--
-- `--safe`: postulate- and hole-free, importing only the equally-safe raw
-- kernel. Nothing here mentions `Actor`, `Event`, or any site structure.

module RuntimeContract.Realization.TraceLookup where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Nat using (ℕ; zero; suc)
open import Cubical.Data.Bool using (Bool; true; false; false≢true)
open import Cubical.Data.List using (List; []; _∷_)
open import Cubical.Data.Sigma using (_×_; _,_; fst; snd)
open import Cubical.Data.Empty using (rec)

open import RuntimeContract.Trace

open RawEvent
open RawTrace
open RawRun

------------------------------------------------------------------------
-- Public API:
--   firstEvent           — first event in a list carrying a given id
--   andB-split           — split a Boolean conjunction that holds
--   eqℕ-refl             — `eqℕ` accepts a number against itself
--   eqℕ-sym              — `eqℕ` is symmetric (as a Bool-valued test)
--   eqℕ-sound            — a successful `eqℕ` test yields a path
--   ⊆?-mem               — membership transports along `⊆?`
--   allB-firstEvent      — instantiate an `allB` at a looked-up event
--   wellFormed-eventsOK  — the per-event clause of `valid?`
--   wellFormed-backwardOK— the backward-parents clause of `valid?`
--   eventOK-conversation — the conversation-resolves clause of `eventOK`
--   eventOK-touches      — the touches ⊆ conversation-actors clause of `eventOK`
------------------------------------------------------------------------

-- the first event in a list carrying a given id (default event if none).
--
-- The default branch is unreachable for realized events: realization
-- carriers pair an id with a proof of `(n ∈? evIdsOf es) ≡ true`, so
-- `firstEvent` is only ever applied to ids that are present. The default is
-- here to keep the function total, not to model an absent event — note it
-- carries `evConv ≡ 0`, so consumers must not read conversation membership
-- off a `firstEvent` call that lacks a presence proof.
private
  defaultEvent : RawEvent
  defaultEvent = mkEvent 0 0 [] [] 0 0

firstEvent : ℕ → List RawEvent → RawEvent
firstEvent c []       = defaultEvent
firstEvent c (e ∷ es) = ifB (eqℕ (evId e) c) e (firstEvent c es)

andB-split : (a b : Bool) → (a andB b) ≡ true → (a ≡ true) × (b ≡ true)
andB-split true  b p = refl , p
andB-split false b p = rec (false≢true p)

------------------------------------------------------------------------
-- Membership lemmas.
------------------------------------------------------------------------

-- `eqℕ` is a Boolean test, so its reflexivity is a computation rather than a
-- consequence of `_≡_`. Needed wherever a refinement is discharged at the
-- value it was read off from — e.g. placing an event in its OWN conversation.
eqℕ-refl : (n : ℕ) → eqℕ n n ≡ true
eqℕ-refl zero    = refl
eqℕ-refl (suc n) = eqℕ-refl n

eqℕ-sym : (m n : ℕ) → eqℕ m n ≡ eqℕ n m
eqℕ-sym zero    zero    = refl
eqℕ-sym zero    (suc n) = refl
eqℕ-sym (suc m) zero    = refl
eqℕ-sym (suc m) (suc n) = eqℕ-sym m n

eqℕ-sound : (m n : ℕ) → eqℕ m n ≡ true → m ≡ n
eqℕ-sound zero    zero    _ = refl
eqℕ-sound zero    (suc n) p = rec (false≢true p)
eqℕ-sound (suc m) zero    p = rec (false≢true p)
eqℕ-sound (suc m) (suc n) p = cong suc (eqℕ-sound m n p)

-- a member of xs is a member of any superset (via ⊆?).
⊆?-mem : (xs L : List ℕ) (x : ℕ) → (xs ⊆? L) ≡ true → (x ∈? xs) ≡ true → (x ∈? L) ≡ true
⊆?-mem []       L x _ q = rec (false≢true q)
⊆?-mem (y ∷ ys) L x h q = lemma (eqℕ x y) refl
  where
    hy  = fst (andB-split (y ∈? L) (ys ⊆? L) h)
    hys = snd (andB-split (y ∈? L) (ys ⊆? L) h)
    lemma : (b : Bool) → b ≡ eqℕ x y → (x ∈? L) ≡ true
    lemma true  eq = subst (λ z → (z ∈? L) ≡ true) (sym (eqℕ-sound x y (sym eq))) hy
    lemma false eq = ⊆?-mem ys L x hys
                       (subst (λ b → ifB b true (x ∈? ys) ≡ true) (sym eq) q)

------------------------------------------------------------------------
-- Instantiating a validated `allB` at a looked-up event.
--
-- `valid?` states its per-event clauses as `allB f es ≡ true`, but a
-- realization module holds an event ID, not a position in `es`. This lemma
-- bridges the two: given that the id is present, the looked-up event
-- satisfies `f`.
--
-- ORIENTATION TRAP. The two scrutinees do NOT agree definitionally:
-- `_∈?_` tests `eqℕ c (evId e)` (element against list head), while
-- `firstEvent` tests `eqℕ (evId e) c` (head against element). The induction
-- therefore has to flip one of them with `eqℕ-sym` before the presence
-- hypothesis can be consumed. (`BackwardRank.go` bridges the same gap the
-- same way.)
------------------------------------------------------------------------

allB-firstEvent :
    (f : RawEvent → Bool) (es : List RawEvent) (c : ℕ)
  → (c ∈? evIdsOf es) ≡ true
  → allB f es ≡ true
  → f (firstEvent c es) ≡ true
allB-firstEvent f []       c cIn _ = rec (false≢true cIn)
allB-firstEvent f (e ∷ es) c cIn h = lemma (eqℕ (evId e) c) refl
  where
    hHead = fst (andB-split (f e) (allB f es) h)
    hTail = snd (andB-split (f e) (allB f es) h)
    lemma : (b : Bool) → b ≡ eqℕ (evId e) c → f (ifB (eqℕ (evId e) c) e (firstEvent c es)) ≡ true
    lemma true  eq = subst (λ b → f (ifB b e (firstEvent c es)) ≡ true) eq hHead
    lemma false eq =
      subst (λ b → f (ifB b e (firstEvent c es)) ≡ true) eq
            (allB-firstEvent f es c cInRest hTail)
      where
        -- flip the orientation: `eqℕ (evId e) c ≡ false` gives `eqℕ c (evId e) ≡ false`
        eqce : eqℕ c (evId e) ≡ false
        eqce = eqℕ-sym c (evId e) ∙ sym eq
        cInRest : (c ∈? evIdsOf es) ≡ true
        cInRest = subst (λ b → ifB b true (c ∈? evIdsOf es) ≡ true) eqce cIn

------------------------------------------------------------------------
-- Peeling named clauses out of `WellFormed`.
--
-- `valid?` is `_andB_`-nested to the right in this order:
--
--   1 traceFormat  2 siblings  3 actors  4 convIds  5 evIds
--   6 convOK       7 eventOK   8 backwardOK
--
-- so clause 7 is "drop six, take head" and clause 8 is "drop seven". Each
-- dropped head is named explicitly rather than left to inference, so the
-- towers below leave no unsolved metavariables.
------------------------------------------------------------------------

private
  tailT : (a : Bool) {b : Bool} → (a andB b) ≡ true → b ≡ true
  tailT a p = snd (andB-split a _ p)

  -- the six leading clauses, dropped in order
  drop6 : (r : RawRun) → WellFormed r
        → ( allB (eventOK (convIdsOf (traceConvs (trace r))) (traceConvs (trace r)))
                 (traceEvents (trace r))
            andB backwardOK (traceEvents (trace r)) ) ≡ true
  drop6 r w =
    tailT (allB (convOK (traceActors t)) (traceConvs t))
    (tailT (distinctB (evIdsOf (traceEvents t)))
    (tailT (distinctB (convIdsOf (traceConvs t)))
    (tailT (distinctB (traceActors t))
    (tailT (distinctB (siblingProtocolIds r))
    (tailT (eqℕ (traceFormat r) formatCode) w)))))
    where
      t : RawTrace
      t = trace r

wellFormed-eventsOK :
    (r : RawRun) → WellFormed r
  → allB (eventOK (convIdsOf (traceConvs (trace r))) (traceConvs (trace r)))
         (traceEvents (trace r)) ≡ true
wellFormed-eventsOK r w =
  fst (andB-split _ (backwardOK (traceEvents (trace r))) (drop6 r w))

wellFormed-backwardOK :
    (r : RawRun) → WellFormed r → backwardOK (traceEvents (trace r)) ≡ true
wellFormed-backwardOK r w = tailT _ (drop6 r w)

-- `eventOK` is nested in the order
--   1 conversation resolves   2 touches distinct
--   3 parents distinct        4 touches ⊆ conversation actors
-- so the two clauses below are "take head" and "drop three".

-- The first conjunct: an event's conversation is present in the run. This is
-- what makes event coverage of the global frame uniform — every realized
-- event has a conversation frame to be covered by, with no side hypothesis.
-- Contrast actor coverage, which `valid?` does not supply at all.
eventOK-conversation :
    (cids : List ConvId) (convs : List RawConversation) (e : RawEvent)
  → eventOK cids convs e ≡ true
  → (evConv e ∈? cids) ≡ true
eventOK-conversation cids convs e ok =
  fst (andB-split (evConv e ∈? cids) _ ok)

-- The fourth conjunct: an event only touches actors of its own conversation.
-- This is the clause that makes per-conversation frames satisfy
-- `LocalFrame.touches-in-frame`, which is why `eventOK` was shaped this way.
eventOK-touches :
    (cids : List ConvId) (convs : List RawConversation) (e : RawEvent)
  → eventOK cids convs e ≡ true
  → (evTouches e ⊆? lookupConvActors (evConv e) convs) ≡ true
eventOK-touches cids convs e ok =
  tailT (distinctB (evParents e))
  (tailT (distinctB (evTouches e))
  (tailT (evConv e ∈? cids) ok))
