{-# OPTIONS --cubical --guardedness #-}

-- The generic runtime-to-substrate junction, first rung.
--
-- `Realization/TinyTrace.agda` exhibits ONE concrete valid trace as a
-- `LocalFrame`, but REUSES `TinyCausal` for the order. This module removes
-- that reuse: for ANY well-formed raw run it DERIVES a `CausalOrder` from the
-- trace's own `causalParents`, and packages the run as a `LocalFrame` over
-- the substrate's actor-causal primitives. It is the generic bridge the
-- north-star header of `Trace.agda` names, at its first honest rung.
--
-- Structure:
--   * checkpoint 1 — `realizeCausal`: a `CausalOrder` whose events are the
--     trace's event IDs, whose `_≤_` is the reflexive-transitive closure of
--     the parent relation, and whose antisymmetry comes from
--     `BackwardRank.edge-decreases-idx` (parent edges strictly decrease
--     first-occurrence rank). The hard combinatorics live in that sibling
--     module; here we only assemble the order and its laws.
--   * checkpoint 2 — `realizeFrame`: the run as a `LocalFrame` over
--     `realizeActorBase`, with incidence read off `evTouches`.
--
-- Deliberately deferred (later B-lane rungs, NOT hidden here):
--   * per-conversation locality + `FrameHom` embeddings: `ActorIn ≡ Unit`
--     models a SINGLE frame holding all present actors (the same modelling
--     choice `TinyTrace.agda` makes). Conversations are validated by `valid?`
--     but do not yet shape the realized object.
--   * session-tag assignment: `LocalFrame` carries no session content, so the
--     minimal bridge needs no tag environment.
--   * renaming / valid-reordering invariance (predicate- and object-level):
--     the "univalence at the runtime boundary" capstone is future work.
--
-- Not `--safe`: the actor-causal substrate carries the infective
-- `--guardedness` flag. This module is nonetheless postulate- and hole-free;
-- the combinatorial core `BackwardRank` is `--safe`.

module RuntimeContract.Realization.CausalFromParents where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.HLevels using (isSetΣ)
open import Cubical.Data.Nat using (ℕ; isSetℕ)
open import Cubical.Data.Nat.Order using (_<_; <-trans; ¬m<m)
open import Cubical.Data.Bool using (Bool; true; false)
open import Cubical.Data.Bool.Properties using (isSetBool)
open import Cubical.Data.List using (List; []; _∷_)
open import Cubical.Data.Sigma using (Σ-syntax; _,_; fst; snd)
open import Cubical.Data.Sum using (_⊎_; inl; inr; isProp⊎)
open import Cubical.Data.Unit using (Unit; tt; isPropUnit)
open import Cubical.Data.Empty using (rec)
open import Cubical.HITs.PropositionalTruncation
  using (∥_∥₁; ∣_∣₁; squash₁; map)
  renaming (rec to ∥rec∥; rec2 to ∥rec2∥)

open import Concurrency.Sites.ActorBase using (ActorBase; CausalOrder)
open import Concurrency.Sites.ActorCausal using (LocalFrame)

open import RuntimeContract.Trace
open import RuntimeContract.Realization.BackwardRank
  using (idx; firstEvent; andB-split; edge-decreases-idx)

open RawEvent
open RawTrace
open RawRun

------------------------------------------------------------------------
-- The realization, for a fixed well-formed run.
------------------------------------------------------------------------

module _ (r : RawRun) (w : WellFormed r) where

  private
    t : RawTrace
    t = trace r

    es : List RawEvent
    es = traceEvents t

    eids : List ℕ
    eids = evIdsOf es

  -- The `backwardOK` clause, peeled out of the full `valid?` conjunction by
  -- dropping the seven leading clauses. Each head conjunct is named so that
  -- `andB-split` leaves no unsolved metavariable; the tails are inferred.
  private
    cids : List ℕ
    cids = convIdsOf (traceConvs t)

    tailT : (a : Bool) {b : Bool} → (a andB b) ≡ true → b ≡ true
    tailT a p = snd (andB-split a _ p)

    backward-ok : backwardOK es ≡ true
    backward-ok =
      tailT (allB (eventOK cids (traceConvs t)) es)
      (tailT (allB (convOK (traceActors t)) (traceConvs t))
      (tailT (distinctB (evIdsOf es))
      (tailT (distinctB cids)
      (tailT (distinctB (traceActors t))
      (tailT (distinctB (siblingProtocolIds r))
      (tailT (eqℕ (traceFormat r) formatCode) w))))))

  --------------------------------------------------------------------
  -- Realized event carrier: the present event IDs.
  --
  -- Faithful (injective-on-events) realization relies on `valid?`'s distinct
  -- event IDs: without them, two raw events sharing an ID would collapse to
  -- one `REvent` (and `firstEvent` would pick the first). The causal order
  -- below does NOT consume distinctness — only `backwardOK` — but the carrier
  -- being a faithful copy of the trace's events does.
  --------------------------------------------------------------------

  REvent : Type
  REvent = Σ[ n ∈ ℕ ] ((n ∈? eids) ≡ true)

  REvent-set : isSet REvent
  REvent-set = isSetΣ isSetℕ (λ n → isProp→isSet (isSetBool (n ∈? eids) true))

  private
    rank : ℕ → ℕ
    rank x = idx x eids

  --------------------------------------------------------------------
  -- Parent relation and its reflexive-transitive closure.
  --------------------------------------------------------------------

  ParentEdge : REvent → REvent → Type
  ParentEdge a b = (fst a ∈? evParents (firstEvent (fst b) es)) ≡ true

  private
    edge-lt : (a b : REvent) → ParentEdge a b → rank (fst a) < rank (fst b)
    edge-lt a b pe = edge-decreases-idx es backward-ok (fst b) (snd b) (fst a) pe

    data Plus : REvent → REvent → Type where
      edge : {a b : REvent} → ParentEdge a b → Plus a b
      cons : {a b d : REvent} → ParentEdge a b → Plus b d → Plus a d

    plus-lt : {a b : REvent} → Plus a b → rank (fst a) < rank (fst b)
    plus-lt {a} {b} (edge pe)            = edge-lt a b pe
    plus-lt {a}     (cons {b = b} pe pl) = <-trans (edge-lt a b pe) (plus-lt pl)

    plus-trans : {a b d : REvent} → Plus a b → Plus b d → Plus a d
    plus-trans (edge pe)    q = cons pe q
    plus-trans (cons pe pl) q = cons pe (plus-trans pl q)

  _≤R_ : REvent → REvent → Type
  a ≤R b = (a ≡ b) ⊎ ∥ Plus a b ∥₁

  private
    ≤R-refl : (a : REvent) → a ≤R a
    ≤R-refl a = inl refl

    ≤R-trans : {a b d : REvent} → a ≤R b → b ≤R d → a ≤R d
    ≤R-trans (inl p) (inl q) = inl (p ∙ q)
    ≤R-trans (inl p) (inr q) = inr (map (λ pl → subst (λ z → Plus z _) (sym p) pl) q)
    ≤R-trans (inr p) (inl q) = inr (map (λ pl → subst (Plus _)     q       pl) p)
    ≤R-trans (inr p) (inr q) = inr (∥rec2∥ squash₁ (λ pl ql → ∣ plus-trans pl ql ∣₁) p q)

    ≤R-antisym : {a b : REvent} → a ≤R b → b ≤R a → a ≡ b
    ≤R-antisym (inl p) _       = p
    ≤R-antisym (inr _) (inl q) = sym q
    ≤R-antisym {a} {b} (inr p) (inr q) =
      ∥rec∥ (REvent-set a b)
            (λ pl → ∥rec∥ (REvent-set a b)
                          (λ ql → rec (¬m<m (<-trans (plus-lt pl) (plus-lt ql))))
                          q)
            p

    ≤R-isProp : {a b : REvent} → isProp (a ≤R b)
    ≤R-isProp {a} {b} = isProp⊎ (REvent-set a b) squash₁ disjoint
      where
        isProp⊥ : isProp _
        isProp⊥ ()
        disjoint : (a ≡ b) → ∥ Plus a b ∥₁ → _
        disjoint p = ∥rec∥ isProp⊥
          (λ pl → ¬m<m (subst (λ n → n < rank (fst b))
                               (cong (λ z → rank (fst z)) p) (plus-lt pl)))

  --------------------------------------------------------------------
  -- Checkpoint 1: the derived CausalOrder.
  --------------------------------------------------------------------

  realizeCausal : CausalOrder ℓ-zero ℓ-zero
  realizeCausal = record
    { Event = REvent ; Event-set = REvent-set
    ; _≤_ = _≤R_ ; ≤-refl = ≤R-refl ; ≤-trans = ≤R-trans
    ; ≤-antisym = ≤R-antisym ; ≤-isProp = ≤R-isProp }

  --------------------------------------------------------------------
  -- Checkpoint 2: the run as a LocalFrame.
  --------------------------------------------------------------------

  private
    acts : List ℕ
    acts = traceActors t

  RActor : Type
  RActor = Σ[ a ∈ ℕ ] ((a ∈? acts) ≡ true)

  realizeActorBase : ActorBase ℓ-zero
  realizeActorBase = record
    { Actor = RActor
    ; Actor-set = isSetΣ isSetℕ (λ a → isProp→isSet (isSetBool (a ∈? acts) true)) }

  private
    touchesR : REvent → RActor → Type
    touchesR e a = (fst a ∈? evTouches (firstEvent (fst e) es)) ≡ true

  realizeFrame : LocalFrame realizeActorBase ℓ-zero ℓ-zero
  realizeFrame = record
    { causal           = realizeCausal
    ; ActorIn          = λ _ → Unit          -- single frame; per-conversation locality deferred
    ; ActorIn-isProp   = λ _ → isPropUnit
    ; touches          = touchesR
    ; touches-isProp   = λ e a → isSetBool (fst a ∈? evTouches (firstEvent (fst e) es)) true
    ; touches-in-frame = λ _ → tt }

------------------------------------------------------------------------
-- Instantiation sanity: the generic realizer applied to the existing tiny
-- valid fixture. This is a generic ANALOGUE of `Realization/TinyTrace.agda`
-- that closes its order-reuse gap — here the order is DERIVED from
-- `causalParents`, not reused from `TinyCausal`. It is NOT a literal
-- subsumption: it produces a different `ActorBase`/`LocalFrame` (all present
-- actors in one frame) and does not reproduce TinyTrace's per-actor
-- correspondence lemmas.
------------------------------------------------------------------------

open import RuntimeContract.Generated.Raw.Valid.TinyTrace using (term)

tiny-valid : valid? term ≡ true
tiny-valid = refl

tinyRealized : LocalFrame (realizeActorBase term tiny-valid) ℓ-zero ℓ-zero
tinyRealized = realizeFrame term tiny-valid
