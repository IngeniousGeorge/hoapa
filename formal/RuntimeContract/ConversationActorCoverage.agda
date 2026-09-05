{-# OPTIONS --cubical --safe --guardedness #-}

-- Actor coverage: every actor declared in a run joins some conversation.
--
-- This is deliberately NOT a clause of `valid?`, and this module is
-- deliberately not `Trace.agda`. `Trace.agda` owns the minimal trusted
-- validator; coverage is an optional strengthening that some constructions
-- require and some runs lack. Folding it into `valid?` would have retired
-- registered-but-inactive actors as legal evidence — a v0 contract narrowing
-- made to serve one downstream construction, and one the runtime's
-- independent actor registration relies on not happening.
-- `fixtures/valid/uncovered_actor.json` is the accepted-but-uncovered run
-- that keeps the two predicates visibly apart.
--
-- SHAPE. The Boolean mirrors the realized existential statement rather than
-- flattening it. `Realization.ConversationCover` states coverage as
--
--   (a : RActor) → Σ[ c ∈ RConversation ] ConversationActorIn c a
--
-- where `RConversation` is a conversation ID carrying a presence proof and
-- `ConversationActorIn c a` is `a ∈? lookupConvActors c convs`. So the
-- Boolean quantifies over `convIdsOf convs` and tests through
-- `lookupConvActors`, making each half of the correspondence a direct
-- induction. Flattening the conversations' actor lists first would have been
-- shorter to write and would then have needed conversation-ID distinctness
-- to relate a found record back to what `lookupConvActors` returns.
--
-- LAYERING NOTE. This module imports `Realization.TraceLookup` for the two
-- raw `eqℕ` facts it needs. That module is substrate-free and `--safe`
-- despite its directory: its stated job is raw-trace lookup and validator
-- peeling, not realization. The alternatives were duplicating the lemmas or
-- widening the trusted kernel, both worse. If `Realization/` ever gains a
-- substrate-bearing dependency, these facts should move down rather than be
-- copied.
--
-- Substrate-free: nothing here mentions `Actor`, `Event`, or site structure.

module RuntimeContract.ConversationActorCoverage where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Nat using (ℕ)
open import Cubical.Data.Bool using (Bool; true; false; false≢true)
open import Cubical.Data.List using (List; []; _∷_)
open import Cubical.Data.Sigma using (Σ-syntax; _×_; _,_; fst; snd)
open import Cubical.Data.Empty using (rec)

open import RuntimeContract.Trace
open import RuntimeContract.Realization.TraceLookup using (eqℕ-refl; eqℕ-sound; andB-split)

open RawTrace
open RawRun

------------------------------------------------------------------------
-- Public API:
--   anyB                          — Boolean existential over a list
--   ∈?-here                       — a head is a member of its own list
--   ∈?-cons                       — membership survives a new head
--   ∈?-tail                       — membership minus a distinct head
--   anyB-found                    — a successful `anyB` yields a member
--   anyB-intro                    — a satisfying member yields `anyB`
--   allB-mem                      — instantiate an `allB` at a member
--   allB-fromMembers              — `allB` from a proof at every member
--   actorsCoveredByConversations? — the coverage predicate
------------------------------------------------------------------------

-- Boolean existential, in `∈?`'s idiom (`ifB` rather than a disjunction, so
-- that it computes the way the rest of the raw layer does).
anyB : {ℓ : Level} {A : Type ℓ} → (A → Bool) → List A → Bool
anyB f []       = false
anyB f (x ∷ xs) = ifB (f x) true (anyB f xs)

------------------------------------------------------------------------
-- Membership bookkeeping.
------------------------------------------------------------------------

∈?-here : (x : ℕ) (xs : List ℕ) → (x ∈? (x ∷ xs)) ≡ true
∈?-here x xs =
  subst (λ b → ifB b true (x ∈? xs) ≡ true) (sym (eqℕ-refl x)) refl

∈?-cons : (x y : ℕ) (ys : List ℕ) → (x ∈? ys) ≡ true → (x ∈? (y ∷ ys)) ≡ true
∈?-cons x y ys p = lemma (eqℕ x y) refl
  where
    lemma : (b : Bool) → b ≡ eqℕ x y → ifB (eqℕ x y) true (x ∈? ys) ≡ true
    lemma true  eq = subst (λ b → ifB b true (x ∈? ys) ≡ true) eq refl
    lemma false eq = subst (λ b → ifB b true (x ∈? ys) ≡ true) eq p

∈?-tail : (x y : ℕ) (ys : List ℕ)
        → eqℕ x y ≡ false → (x ∈? (y ∷ ys)) ≡ true → (x ∈? ys) ≡ true
∈?-tail x y ys neq p = subst (λ b → ifB b true (x ∈? ys) ≡ true) neq p

------------------------------------------------------------------------
-- The two directions of `anyB`, each carrying membership.
------------------------------------------------------------------------

anyB-found :
    (f : ℕ → Bool) (xs : List ℕ)
  → anyB f xs ≡ true
  → Σ[ x ∈ ℕ ] (((x ∈? xs) ≡ true) × (f x ≡ true))
anyB-found f []       p = rec (false≢true p)
anyB-found f (y ∷ ys) p = lemma (f y) refl
  where
    lemma : (b : Bool) → b ≡ f y
          → Σ[ x ∈ ℕ ] (((x ∈? (y ∷ ys)) ≡ true) × (f x ≡ true))
    -- the head passes: it is the witness, and it is its own member
    lemma true  eq = y , (∈?-here y ys , sym eq)
    -- the head fails: recurse, then weaken the membership proof
    lemma false eq = fst rest , (∈?-cons (fst rest) y ys (fst (snd rest))
                                , snd (snd rest))
      where
        rest : Σ[ x ∈ ℕ ] (((x ∈? ys) ≡ true) × (f x ≡ true))
        rest = anyB-found f ys
                 (subst (λ b → ifB b true (anyB f ys) ≡ true) (sym eq) p)

anyB-intro :
    (f : ℕ → Bool) (xs : List ℕ) (x : ℕ)
  → (x ∈? xs) ≡ true → f x ≡ true → anyB f xs ≡ true
anyB-intro f []       x xIn _  = rec (false≢true xIn)
anyB-intro f (y ∷ ys) x xIn fx = lemma (f y) refl
  where
    lemma : (b : Bool) → b ≡ f y → ifB (f y) true (anyB f ys) ≡ true
    -- the head passes: done, wherever `x` sits
    lemma true  eq = subst (λ b → ifB b true (anyB f ys) ≡ true) eq refl
    -- the head fails: `x` cannot BE the head, since `x` passes and the head
    -- does not, so `x` lies in the tail and the induction hypothesis applies
    lemma false eq = subst (λ b → ifB b true (anyB f ys) ≡ true) eq
                           (anyB-intro f ys x xInTail fx)
      where
        xNotHead : eqℕ x y ≡ false
        xNotHead = notHead (eqℕ x y) refl
          where
            notHead : (b : Bool) → b ≡ eqℕ x y → eqℕ x y ≡ false
            notHead false e = sym e
            notHead true  e =
              rec (false≢true (eq ∙ cong f (sym (eqℕ-sound x y (sym e))) ∙ fx))
        xInTail : (x ∈? ys) ≡ true
        xInTail = ∈?-tail x y ys xNotHead xIn

------------------------------------------------------------------------
-- The matching two directions of `allB`. `TraceLookup.allB-firstEvent`
-- instantiates an `allB` at an event reached by ID lookup; these two work
-- from `∈?` membership instead, which is the form the actor carrier gives.
------------------------------------------------------------------------

allB-mem :
    (f : ℕ → Bool) (xs : List ℕ) (x : ℕ)
  → allB f xs ≡ true → (x ∈? xs) ≡ true → f x ≡ true
allB-mem f []       x _ xIn = rec (false≢true xIn)
allB-mem f (y ∷ ys) x h xIn = lemma (eqℕ x y) refl
  where
    hHead = fst (andB-split (f y) (allB f ys) h)
    hTail = snd (andB-split (f y) (allB f ys) h)
    lemma : (b : Bool) → b ≡ eqℕ x y → f x ≡ true
    lemma true  eq = subst (λ z → f z ≡ true) (sym (eqℕ-sound x y (sym eq))) hHead
    lemma false eq = allB-mem f ys x hTail (∈?-tail x y ys (sym eq) xIn)

allB-fromMembers :
    (f : ℕ → Bool) (xs : List ℕ)
  → ((x : ℕ) → (x ∈? xs) ≡ true → f x ≡ true)
  → allB f xs ≡ true
allB-fromMembers f []       _ = refl
allB-fromMembers f (y ∷ ys) h =
  subst (λ b → (b andB allB f ys) ≡ true) (sym (h y (∈?-here y ys)))
        (allB-fromMembers f ys (λ x xIn → h x (∈?-cons x y ys xIn)))

------------------------------------------------------------------------
-- The predicate.
------------------------------------------------------------------------

actorsCoveredByConversations? : RawRun → Bool
actorsCoveredByConversations? r =
  allB (λ a → anyB (λ c → a ∈? lookupConvActors c convs) (convIdsOf convs))
       (traceActors t)
  where
    t : RawTrace
    t = trace r
    convs : List RawConversation
    convs = traceConvs t
