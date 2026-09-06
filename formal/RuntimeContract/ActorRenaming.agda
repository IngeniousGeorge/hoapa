{-# OPTIONS --cubical --safe --guardedness #-}

-- Actor relabeling at the raw contract boundary.
--
-- WHAT THIS MODULE PROVES, IN THREE STRATA. The strata differ in what
-- they assume about the relabeling, and the split is the content, not
-- bookkeeping:
--
--   1. Raw-data functoriality — arbitrary actor maps. `renameActors`
--      preserves identity and composition. No hypothesis, because the
--      raw records are functorial in the actor coordinate for *any*
--      function.
--   2. Validator naturality — actor EMBEDDINGS (injective maps). The
--      exact Boolean equality `valid? (rename φ r) ≡ valid? r`, for
--      EVERY raw run including malformed ones. Injectivity is forced:
--      a collapsing map can rescue an invalid run by merging an
--      undeclared identifier onto a declared one.
--   3. Gauge symmetry — actor PERMUTATIONS, the invertible relabelings.
--      Their invariance component is stratum 2 specialized; their own
--      content is the invertible action.
--
-- SCOPE, STATED AT THE IMPLEMENTED STRENGTH. This module is the current
-- endomorphism instance at `ActorId = ℕ`. It is NOT the varying-name
-- functor `RawRun : DecidableNameSet → Set`, and no category is
-- constructed here: `ActorEmbedding` has category-shaped identity and
-- composition, but associativity and unit laws are not proved, so it is
-- arrow vocabulary rather than a category. The arrows are nonetheless
-- stated between two carriers rather than as endomaps of one, because
-- the realized actor carriers of a run and of its relabeling are
-- genuinely different types (see the change-of-base note below).
--
-- ACTOR CHANNEL ONLY. Event IDs, conversation IDs, protocol IDs, content
-- tags, provenance tokens and run IDs are untouched and have their own
-- separate stability questions. Reordering invariance of the actor lists
-- is a distinct later rung: every actor clause of `valid?` is order
-- insensitive, but list order is observable in the raw data.
--
-- ON DENSE COORDINATES. `Trace.agda` records that the serialization
-- generator assigns dense `ℕ` coordinates by first appearance. `valid?`
-- has NO density clause, and that absence is load-bearing here: were
-- density required, this theorem would fail even for permutations, since
-- transposing 0 and 5 sends the actor list [0,1] to [5,1]. Read
-- interpretively, first-appearance normalization APPEARS to provide a
-- global gauge fixing for this discrete global action, and `suc` exits
-- the dense slice without changing acceptance. That reading is not
-- proved: constancy of canonicalization on relabeling orbits, and
-- selection of exactly one representative, are not established here.
--
-- TOWARD CHANGE OF ACTOR BASE (not done here). Tier B must compare
-- realized frames over DIFFERENT actor bases: `CausalFromParents.agda`
-- builds a run-specific carrier `RActor = Σ[ a ∈ ℕ ] (a ∈? acts ≡ true)`,
-- so `RActor r w` and `RActor (renameActors ρ r) w'` are different types,
-- while `Concurrency/Sites/ActorCausal.agda` fixes one `ActorBase` for
-- all frames and gives `FrameHom` no actor map (`actor-pres` quantifies
-- over the SAME actor on both sides). That statement is currently
-- inexpressible. The intended repair is a relative morphism over a map
-- of actor bases, leaving `FrameHom` itself unchanged. The generic
-- `ActorEmbedding A B` below is exactly the arrow that map needs.
--
-- IMPORT DISCIPLINE. `Trace.agda` hand-rolls its Boolean/list primitives
-- to keep the import surface minimal and `--safe`-clean; this module
-- follows that discipline. List recursion is written out rather than
-- routed through `Cubical.Data.List` combinators, and injectivity is
-- written out rather than imported as `isEmbedding`.

module RuntimeContract.ActorRenaming where

open import Cubical.Core.Primitives
open import Cubical.Foundations.Prelude
open import Cubical.Data.Nat using (ℕ; zero; suc)
open import Cubical.Data.Bool using (Bool; true; false)
open import Cubical.Data.List using (List; []; _∷_)
open import Cubical.Data.Unit using (Unit; tt)
open import Cubical.Data.Empty using (⊥; rec)

open import RuntimeContract.Trace
open import RuntimeContract.TraceLookup using (eqℕ-refl; eqℕ-sound)

-- `Trace.agda` opens its record projections without `public`, so the
-- field names are re-opened here rather than inherited through the import.
open RawConversation
open RawEvent
open RawTrace
open RawRun

-- ----------------------------------------------------------------------
-- 1. Arrows.
--
-- Arbitrary actor maps stay bare functions: a one-field record would be
-- a wrapper with nothing computed against it. Embeddings and
-- isomorphisms earn records because they are composed, inverted and
-- applied.
--
-- Both are stated between two carriers at explicit universe levels. The
-- current consumer is `ActorEmbedding ActorId ActorId`; the two-carrier
-- form is what Tier B's map between run-specific realized actor types
-- will need.
-- ----------------------------------------------------------------------

record ActorEmbedding {ℓA ℓB : Level} (A : Type ℓA) (B : Type ℓB)
                    : Type (ℓ-max ℓA ℓB) where
  constructor actorEmbedding
  field
    embeddingMap       : A → B
    embeddingInjective : (m n : A) → embeddingMap m ≡ embeddingMap n → m ≡ n

open ActorEmbedding public

record ActorIsomorphism {ℓA ℓB : Level} (A : Type ℓA) (B : Type ℓB)
                      : Type (ℓ-max ℓA ℓB) where
  constructor actorIsomorphism
  field
    isomorphismTo      : A → B
    isomorphismFrom    : B → A
    isomorphismTo-from : (b : B) → isomorphismTo (isomorphismFrom b) ≡ b
    isomorphismFrom-to : (a : A) → isomorphismFrom (isomorphismTo a) ≡ a

open ActorIsomorphism public

-- A permutation is the endo case. Invertibility is primitive; injectivity
-- is DERIVED (see `isomorphismToEmbedding`), rather than a permutation
-- being defined as "injective and surjective".
ActorPermutation : {ℓ : Level} → Type ℓ → Type ℓ
ActorPermutation A = ActorIsomorphism A A

-- Category-shaped structure. Identity and composition only: the
-- associativity and unit laws have no consumer today and are deliberately
-- omitted (this is arrow vocabulary, not a constructed category).

identityActorEmbedding : {ℓ : Level} {A : Type ℓ} → ActorEmbedding A A
identityActorEmbedding = actorEmbedding (λ a → a) (λ m n p → p)

composeActorEmbedding :
  {ℓA ℓB ℓC : Level} {A : Type ℓA} {B : Type ℓB} {C : Type ℓC}
  → ActorEmbedding B C → ActorEmbedding A B → ActorEmbedding A C
composeActorEmbedding ψ φ =
  actorEmbedding (λ a → embeddingMap ψ (embeddingMap φ a))
    (λ m n p → embeddingInjective φ m n
                 (embeddingInjective ψ (embeddingMap φ m) (embeddingMap φ n) p))

-- The core includes into the arrows: every isomorphism is an embedding.
-- Injectivity is DERIVED from the left inverse; it is not assumed.
isomorphismToEmbedding :
  {ℓA ℓB : Level} {A : Type ℓA} {B : Type ℓB}
  → ActorIsomorphism A B → ActorEmbedding A B
isomorphismToEmbedding π =
  actorEmbedding (isomorphismTo π)
    (λ m n p → sym (isomorphismFrom-to π m)
             ∙ cong (isomorphismFrom π) p
             ∙ isomorphismFrom-to π n)

-- The core carries the same identity/composition vocabulary, so that it
-- is closed under the operations the group-action reading uses. As above,
-- associativity and unit laws are deferred.

identityActorIsomorphism : {ℓ : Level} {A : Type ℓ} → ActorIsomorphism A A
identityActorIsomorphism =
  actorIsomorphism (λ a → a) (λ a → a) (λ _ → refl) (λ _ → refl)

composeActorIsomorphism :
  {ℓA ℓB ℓC : Level} {A : Type ℓA} {B : Type ℓB} {C : Type ℓC}
  → ActorIsomorphism B C → ActorIsomorphism A B → ActorIsomorphism A C
composeActorIsomorphism τ σ =
  actorIsomorphism (λ a → isomorphismTo τ (isomorphismTo σ a))
                   (λ c → isomorphismFrom σ (isomorphismFrom τ c))
                   (λ c → cong (isomorphismTo τ)
                               (isomorphismTo-from σ (isomorphismFrom τ c))
                        ∙ isomorphismTo-from τ c)
                   (λ a → cong (isomorphismFrom σ)
                               (isomorphismFrom-to τ (isomorphismTo σ a))
                        ∙ isomorphismFrom-to σ a)

inverseActorIsomorphism :
  {ℓA ℓB : Level} {A : Type ℓA} {B : Type ℓB}
  → ActorIsomorphism A B → ActorIsomorphism B A
inverseActorIsomorphism π =
  actorIsomorphism (isomorphismFrom π) (isomorphismTo π)
                   (isomorphismFrom-to π) (isomorphismTo-from π)

-- ----------------------------------------------------------------------
-- 2. The action on raw data.
--
-- Touches exactly three fields: `traceActors`, `convActors`, `evTouches`.
-- Everything else — format code, run/protocol/sibling IDs, conversation
-- IDs, event IDs, causal parents, session/content/provenance tags — is
-- carried through unchanged. Defined for ARBITRARY maps.
-- ----------------------------------------------------------------------

renameActorList : (ActorId → ActorId) → List ActorId → List ActorId
renameActorList ρ []       = []
renameActorList ρ (a ∷ as) = ρ a ∷ renameActorList ρ as

renameConversation : (ActorId → ActorId) → RawConversation → RawConversation
renameConversation ρ c =
  mkConv (convId c) (renameActorList ρ (convActors c)) (convSession c)

renameConversations : (ActorId → ActorId) → List RawConversation → List RawConversation
renameConversations ρ []       = []
renameConversations ρ (c ∷ cs) = renameConversation ρ c ∷ renameConversations ρ cs

renameEvent : (ActorId → ActorId) → RawEvent → RawEvent
renameEvent ρ e =
  mkEvent (evId e) (evConv e) (renameActorList ρ (evTouches e))
          (evParents e) (evContent e) (evProv e)

renameEvents : (ActorId → ActorId) → List RawEvent → List RawEvent
renameEvents ρ []       = []
renameEvents ρ (e ∷ es) = renameEvent ρ e ∷ renameEvents ρ es

renameTrace : (ActorId → ActorId) → RawTrace → RawTrace
renameTrace ρ t =
  mkTrace (renameActorList ρ (traceActors t))
          (renameConversations ρ (traceConvs t))
          (renameEvents ρ (traceEvents t))

renameActors : (ActorId → ActorId) → RawRun → RawRun
renameActors ρ r =
  mkRun (traceFormat r) (runId r) (protocolId r) (siblingProtocolIds r)
        (renameTrace ρ (trace r))

-- ----------------------------------------------------------------------
-- 3. Functoriality — arbitrary maps, no hypothesis.
--
-- These are the functor laws of the raw-data stratum. That they need no
-- injectivity is the precise reason stratum 1 is separate from stratum 2.
-- ----------------------------------------------------------------------

renameActorList-id : (as : List ActorId) → renameActorList (λ a → a) as ≡ as
renameActorList-id []       = refl
renameActorList-id (a ∷ as) = cong (a ∷_) (renameActorList-id as)

renameActorList-compose :
  (ρ σ : ActorId → ActorId) (as : List ActorId)
  → renameActorList ρ (renameActorList σ as) ≡ renameActorList (λ a → ρ (σ a)) as
renameActorList-compose ρ σ []       = refl
renameActorList-compose ρ σ (a ∷ as) =
  cong (ρ (σ a) ∷_) (renameActorList-compose ρ σ as)

-- Record-level steps. Each is a path-lambda over the changed fields; the
-- unchanged fields are carried literally, and record eta closes the gap
-- between the reassembled record and the original.
private
  renameConversation-id : (c : RawConversation) → renameConversation (λ a → a) c ≡ c
  renameConversation-id c i =
    mkConv (convId c) (renameActorList-id (convActors c) i) (convSession c)

  renameConversations-id :
    (cs : List RawConversation) → renameConversations (λ a → a) cs ≡ cs
  renameConversations-id []       = refl
  renameConversations-id (c ∷ cs) i =
    renameConversation-id c i ∷ renameConversations-id cs i

  renameEvent-id : (e : RawEvent) → renameEvent (λ a → a) e ≡ e
  renameEvent-id e i =
    mkEvent (evId e) (evConv e) (renameActorList-id (evTouches e) i)
            (evParents e) (evContent e) (evProv e)

  renameEvents-id : (es : List RawEvent) → renameEvents (λ a → a) es ≡ es
  renameEvents-id []       = refl
  renameEvents-id (e ∷ es) i = renameEvent-id e i ∷ renameEvents-id es i

  renameTrace-id : (t : RawTrace) → renameTrace (λ a → a) t ≡ t
  renameTrace-id t i =
    mkTrace (renameActorList-id (traceActors t) i)
            (renameConversations-id (traceConvs t) i)
            (renameEvents-id (traceEvents t) i)

  renameConversation-compose :
    (ρ σ : ActorId → ActorId) (c : RawConversation)
    → renameConversation ρ (renameConversation σ c)
      ≡ renameConversation (λ a → ρ (σ a)) c
  renameConversation-compose ρ σ c i =
    mkConv (convId c) (renameActorList-compose ρ σ (convActors c) i) (convSession c)

  renameConversations-compose :
    (ρ σ : ActorId → ActorId) (cs : List RawConversation)
    → renameConversations ρ (renameConversations σ cs)
      ≡ renameConversations (λ a → ρ (σ a)) cs
  renameConversations-compose ρ σ []       = refl
  renameConversations-compose ρ σ (c ∷ cs) i =
    renameConversation-compose ρ σ c i ∷ renameConversations-compose ρ σ cs i

  renameEvent-compose :
    (ρ σ : ActorId → ActorId) (e : RawEvent)
    → renameEvent ρ (renameEvent σ e) ≡ renameEvent (λ a → ρ (σ a)) e
  renameEvent-compose ρ σ e i =
    mkEvent (evId e) (evConv e) (renameActorList-compose ρ σ (evTouches e) i)
            (evParents e) (evContent e) (evProv e)

  renameEvents-compose :
    (ρ σ : ActorId → ActorId) (es : List RawEvent)
    → renameEvents ρ (renameEvents σ es) ≡ renameEvents (λ a → ρ (σ a)) es
  renameEvents-compose ρ σ []       = refl
  renameEvents-compose ρ σ (e ∷ es) i =
    renameEvent-compose ρ σ e i ∷ renameEvents-compose ρ σ es i

  renameTrace-compose :
    (ρ σ : ActorId → ActorId) (t : RawTrace)
    → renameTrace ρ (renameTrace σ t) ≡ renameTrace (λ a → ρ (σ a)) t
  renameTrace-compose ρ σ t i =
    mkTrace (renameActorList-compose ρ σ (traceActors t) i)
            (renameConversations-compose ρ σ (traceConvs t) i)
            (renameEvents-compose ρ σ (traceEvents t) i)

renameActors-id : (r : RawRun) → renameActors (λ a → a) r ≡ r
renameActors-id r i =
  mkRun (traceFormat r) (runId r) (protocolId r) (siblingProtocolIds r)
        (renameTrace-id (trace r) i)

renameActors-compose :
  (ρ σ : ActorId → ActorId) (r : RawRun)
  → renameActors ρ (renameActors σ r) ≡ renameActors (λ a → ρ (σ a)) r
renameActors-compose ρ σ r i =
  mkRun (traceFormat r) (runId r) (protocolId r) (siblingProtocolIds r)
        (renameTrace-compose ρ σ (trace r) i)

-- ----------------------------------------------------------------------
-- 4. The bridge: what an embedding gives the validator.
--
-- `valid?` observes actor identifiers ONLY through `eqℕ`. This lemma is
-- therefore the categorically primitive property of an arrow of the
-- intended base (decidable name sets and equality-reflecting embeddings);
-- injectivity is kept as the public field for mathematical fidelity, and
-- reflection is derived from it here, once.
-- ----------------------------------------------------------------------

private
  -- Follows `Trace.agda`'s own `So` idiom rather than importing a Bool
  -- disequality lemma, keeping the import surface flat.
  BoolIsTrue : Bool → Type₀
  BoolIsTrue true  = Unit
  BoolIsTrue false = ⊥

  trueNotFalse : true ≡ false → ⊥
  trueNotFalse p = subst BoolIsTrue p tt

  -- The converse of `eqℕ-sound`, which `TraceLookup` does not export.
  eqℕ-complete : (m n : ℕ) → m ≡ n → eqℕ m n ≡ true
  eqℕ-complete m n p = subst (λ x → eqℕ m x ≡ true) p (eqℕ-refl m)

embedding-reflects-identifier-equality :
  (φ : ActorEmbedding ActorId ActorId) (m n : ActorId)
  → eqℕ (embeddingMap φ m) (embeddingMap φ n) ≡ eqℕ m n
embedding-reflects-identifier-equality φ m n = step (eqℕ m n) refl
  where
    -- Case analysis on the Boolean value, carrying its equation. The goal
    -- does not mention the scrutinee, so no `with`-abstraction is needed.
    step : (b : Bool) → eqℕ m n ≡ b
         → eqℕ (embeddingMap φ m) (embeddingMap φ n) ≡ eqℕ m n
    step true  p =
      eqℕ-complete (embeddingMap φ m) (embeddingMap φ n)
                   (cong (embeddingMap φ) (eqℕ-sound m n p))
      ∙ sym p
    step false p = stepFalse (eqℕ (embeddingMap φ m) (embeddingMap φ n)) refl
      where
        -- The only place injectivity is used: a collapsing map could send
        -- distinct identifiers to equal ones, flipping this conjunct.
        stepFalse : (c : Bool) → eqℕ (embeddingMap φ m) (embeddingMap φ n) ≡ c
                  → eqℕ (embeddingMap φ m) (embeddingMap φ n) ≡ eqℕ m n
        stepFalse true q =
          rec (trueNotFalse
                (sym (eqℕ-complete m n
                       (embeddingInjective φ m n
                         (eqℕ-sound (embeddingMap φ m) (embeddingMap φ n) q)))
                 ∙ p))
        stepFalse false q = q ∙ sym p

-- ----------------------------------------------------------------------
-- 5a. Clauses needing only an arbitrary map.
--
-- Five of the eight conjuncts of `valid?` never look at an actor. The
-- conversation-ID and event-ID projections are pure carry-through, and
-- `backwardGo` reads only `evId` and `evParents`. Lookup is controlled by
-- conversation IDs, which renaming does not touch, so it too needs no
-- injectivity — only the actor list it returns is relabeled.
-- ----------------------------------------------------------------------

conversationIds-invariant-under-renaming :
  (ρ : ActorId → ActorId) (cs : List RawConversation)
  → convIdsOf (renameConversations ρ cs) ≡ convIdsOf cs
conversationIds-invariant-under-renaming ρ []       = refl
conversationIds-invariant-under-renaming ρ (c ∷ cs) =
  cong (convId c ∷_) (conversationIds-invariant-under-renaming ρ cs)

eventIds-invariant-under-renaming :
  (ρ : ActorId → ActorId) (es : List RawEvent)
  → evIdsOf (renameEvents ρ es) ≡ evIdsOf es
eventIds-invariant-under-renaming ρ []       = refl
eventIds-invariant-under-renaming ρ (e ∷ es) =
  cong (evId e ∷_) (eventIds-invariant-under-renaming ρ es)

lookupConvActors-commutes-with-renaming :
  (ρ : ActorId → ActorId) (c : ConvId) (cs : List RawConversation)
  → lookupConvActors c (renameConversations ρ cs)
    ≡ renameActorList ρ (lookupConvActors c cs)
lookupConvActors-commutes-with-renaming ρ c []       = refl
lookupConvActors-commutes-with-renaming ρ c (k ∷ ks) =
  pushRenameThroughBranch (eqℕ c (convId k))
  where
    -- Conversation IDs are untouched, so the branch is taken identically
    -- on both sides; only the returned actor list is relabeled.
    pushRenameThroughBranch :
      (b : Bool)
      → ifB b (renameActorList ρ (convActors k))
              (lookupConvActors c (renameConversations ρ ks))
        ≡ renameActorList ρ (ifB b (convActors k) (lookupConvActors c ks))
    pushRenameThroughBranch true  = refl
    pushRenameThroughBranch false = lookupConvActors-commutes-with-renaming ρ c ks

backwardGo-invariant-under-renaming :
  (ρ : ActorId → ActorId) (seen : List EventId) (es : List RawEvent)
  → backwardGo seen (renameEvents ρ es) ≡ backwardGo seen es
backwardGo-invariant-under-renaming ρ seen []       = refl
backwardGo-invariant-under-renaming ρ seen (e ∷ es) =
  cong (λ y → (evParents e ⊆? seen) andB y)
       (backwardGo-invariant-under-renaming ρ (evId e ∷ seen) es)

backwardOK-invariant-under-renaming :
  (ρ : ActorId → ActorId) (es : List RawEvent)
  → backwardOK (renameEvents ρ es) ≡ backwardOK es
backwardOK-invariant-under-renaming ρ es =
  backwardGo-invariant-under-renaming ρ [] es

-- ----------------------------------------------------------------------
-- 5b. Clauses needing an embedding.
--
-- Injectivity first bites where actor identifiers are compared:
-- membership, and everything built from it.
-- ----------------------------------------------------------------------

membership-invariant-under-embedding :
  (φ : ActorEmbedding ActorId ActorId) (a : ActorId) (as : List ActorId)
  → (embeddingMap φ a ∈? renameActorList (embeddingMap φ) as) ≡ (a ∈? as)
membership-invariant-under-embedding φ a []       = refl
membership-invariant-under-embedding φ a (b ∷ bs) =
  cong₂ (λ x y → ifB x true y)
        (embedding-reflects-identifier-equality φ a b)
        (membership-invariant-under-embedding φ a bs)

subset-invariant-under-embedding :
  (φ : ActorEmbedding ActorId ActorId) (as bs : List ActorId)
  → (renameActorList (embeddingMap φ) as ⊆? renameActorList (embeddingMap φ) bs)
    ≡ (as ⊆? bs)
subset-invariant-under-embedding φ []       bs = refl
subset-invariant-under-embedding φ (a ∷ as) bs =
  cong₂ _andB_ (membership-invariant-under-embedding φ a bs)
               (subset-invariant-under-embedding φ as bs)

distinctness-invariant-under-embedding :
  (φ : ActorEmbedding ActorId ActorId) (as : List ActorId)
  → distinctB (renameActorList (embeddingMap φ) as) ≡ distinctB as
distinctness-invariant-under-embedding φ []       = refl
distinctness-invariant-under-embedding φ (a ∷ as) =
  cong₂ (λ x y → ifB x false y)
        (membership-invariant-under-embedding φ a as)
        (distinctness-invariant-under-embedding φ as)

convOK-invariant-under-embedding :
  (φ : ActorEmbedding ActorId ActorId) (acts : List ActorId) (c : RawConversation)
  → convOK (renameActorList (embeddingMap φ) acts)
           (renameConversation (embeddingMap φ) c)
    ≡ convOK acts c
convOK-invariant-under-embedding φ acts c =
  cong₂ _andB_ (distinctness-invariant-under-embedding φ (convActors c))
               (subset-invariant-under-embedding φ (convActors c) acts)

allB-convOK-invariant-under-embedding :
  (φ : ActorEmbedding ActorId ActorId) (acts : List ActorId)
  (cs : List RawConversation)
  → allB (convOK (renameActorList (embeddingMap φ) acts))
         (renameConversations (embeddingMap φ) cs)
    ≡ allB (convOK acts) cs
allB-convOK-invariant-under-embedding φ acts []       = refl
allB-convOK-invariant-under-embedding φ acts (c ∷ cs) =
  cong₂ _andB_ (convOK-invariant-under-embedding φ acts c)
               (allB-convOK-invariant-under-embedding φ acts cs)

eventOK-invariant-under-embedding :
  (φ : ActorEmbedding ActorId ActorId) (cids : List ConvId)
  (cs : List RawConversation) (e : RawEvent)
  → eventOK cids (renameConversations (embeddingMap φ) cs)
            (renameEvent (embeddingMap φ) e)
    ≡ eventOK cids cs e
eventOK-invariant-under-embedding φ cids cs e =
  cong (λ y → (evConv e ∈? cids) andB y)
    (cong₂ _andB_ (distinctness-invariant-under-embedding φ (evTouches e))
      (cong (λ y → distinctB (evParents e) andB y) touchesStep))
  where
    ρ : ActorId → ActorId
    ρ = embeddingMap φ

    -- The touches clause is the only one that has to travel through the
    -- lookup: first commute the renaming past it, then apply subset.
    touchesStep :
      (renameActorList ρ (evTouches e)
         ⊆? lookupConvActors (evConv e) (renameConversations ρ cs))
      ≡ (evTouches e ⊆? lookupConvActors (evConv e) cs)
    touchesStep =
      cong (λ ys → renameActorList ρ (evTouches e) ⊆? ys)
           (lookupConvActors-commutes-with-renaming ρ (evConv e) cs)
      ∙ subset-invariant-under-embedding φ (evTouches e)
                                           (lookupConvActors (evConv e) cs)

allB-eventOK-invariant-under-embedding :
  (φ : ActorEmbedding ActorId ActorId) (cids : List ConvId)
  (cs : List RawConversation) (es : List RawEvent)
  → allB (eventOK cids (renameConversations (embeddingMap φ) cs))
         (renameEvents (embeddingMap φ) es)
    ≡ allB (eventOK cids cs) es
allB-eventOK-invariant-under-embedding φ cids cs []       = refl
allB-eventOK-invariant-under-embedding φ cids cs (e ∷ es) =
  cong₂ _andB_ (eventOK-invariant-under-embedding φ cids cs e)
               (allB-eventOK-invariant-under-embedding φ cids cs es)

-- ----------------------------------------------------------------------
-- 6. The theorems.
-- ----------------------------------------------------------------------

-- Stratum 2. Exact Boolean equality, over EVERY raw run — malformed runs
-- stay malformed, which is what makes this a statement about the
-- validator rather than about valid runs.
validator-invariant-under-actor-embedding :
  (φ : ActorEmbedding ActorId ActorId) (r : RawRun)
  → valid? (renameActors (embeddingMap φ) r) ≡ valid? r
validator-invariant-under-actor-embedding φ r =
  -- The first two conjuncts read fields renaming never touches. They are
  -- pinned with an explicit `cong` rather than `cong₂ … refl`, which leaves
  -- the endpoints ambiguous inside the nested chain.
  cong (λ y → eqℕ (traceFormat r) formatCode andB y)
 (cong (λ y → distinctB (siblingProtocolIds r) andB y)
 (cong₂ _andB_ (distinctness-invariant-under-embedding φ (traceActors t))
 (cong₂ _andB_ (cong distinctB
                     (conversationIds-invariant-under-renaming ρ (traceConvs t)))
 (cong₂ _andB_ (cong distinctB
                     (eventIds-invariant-under-renaming ρ (traceEvents t)))
 (cong₂ _andB_ (allB-convOK-invariant-under-embedding φ (traceActors t) (traceConvs t))
 (cong₂ _andB_ eventsStep
               (backwardOK-invariant-under-renaming ρ (traceEvents t))))))))
  where
    ρ : ActorId → ActorId
    ρ = embeddingMap φ

    t : RawTrace
    t = trace r

    -- The event clause is the only one needing two steps: its conversation
    -- ID list must first be recognized as unchanged before the actor-level
    -- lemma applies.
    eventsStep :
      allB (eventOK (convIdsOf (renameConversations ρ (traceConvs t)))
                    (renameConversations ρ (traceConvs t)))
           (renameEvents ρ (traceEvents t))
      ≡ allB (eventOK (convIdsOf (traceConvs t)) (traceConvs t)) (traceEvents t)
    eventsStep =
      cong (λ ids → allB (eventOK ids (renameConversations ρ (traceConvs t)))
                         (renameEvents ρ (traceEvents t)))
           (conversationIds-invariant-under-renaming ρ (traceConvs t))
      ∙ allB-eventOK-invariant-under-embedding φ (convIdsOf (traceConvs t))
                                                 (traceConvs t) (traceEvents t)

-- `WellFormed r` is definitionally `valid? r ≡ true`, so the Boolean
-- equality transports it as a path of TYPES.
wellFormed-invariant-under-actor-embedding :
  (φ : ActorEmbedding ActorId ActorId) (r : RawRun)
  → WellFormed (renameActors (embeddingMap φ) r) ≡ WellFormed r
wellFormed-invariant-under-actor-embedding φ r =
  cong (λ b → b ≡ true) (validator-invariant-under-actor-embedding φ r)

-- A path between types is not directly usable downstream; Tier B will
-- want an actual proof of the relabeled run's well-formedness. Both
-- directions are exported by name.
wellFormed-transport-along-embedding :
  (φ : ActorEmbedding ActorId ActorId) (r : RawRun)
  → WellFormed r → WellFormed (renameActors (embeddingMap φ) r)
wellFormed-transport-along-embedding φ r w =
  validator-invariant-under-actor-embedding φ r ∙ w

wellFormed-reflect-along-embedding :
  (φ : ActorEmbedding ActorId ActorId) (r : RawRun)
  → WellFormed (renameActors (embeddingMap φ) r) → WellFormed r
wellFormed-reflect-along-embedding φ r w =
  sym (validator-invariant-under-actor-embedding φ r) ∙ w

-- Stratum 3. The invertible action: this is the content permutations add
-- over embeddings. The invariance below is inherited, not re-proved.
renameActors-inverse-from-to :
  (π : ActorPermutation ActorId) (r : RawRun)
  → renameActors (isomorphismFrom π) (renameActors (isomorphismTo π) r) ≡ r
renameActors-inverse-from-to π r =
  renameActors-compose (isomorphismFrom π) (isomorphismTo π) r
  ∙ cong (λ ρ → renameActors ρ r) (funExt (isomorphismFrom-to π))
  ∙ renameActors-id r

renameActors-inverse-to-from :
  (π : ActorPermutation ActorId) (r : RawRun)
  → renameActors (isomorphismTo π) (renameActors (isomorphismFrom π) r) ≡ r
renameActors-inverse-to-from π r =
  renameActors-compose (isomorphismTo π) (isomorphismFrom π) r
  ∙ cong (λ ρ → renameActors ρ r) (funExt (isomorphismTo-from π))
  ∙ renameActors-id r

-- The gauge statement: well-formedness is constant along the orbit of the
-- invertible relabeling action.
wellFormed-invariant-under-actor-permutation :
  (π : ActorPermutation ActorId) (r : RawRun)
  → WellFormed (renameActors (isomorphismTo π) r) ≡ WellFormed r
wellFormed-invariant-under-actor-permutation π r =
  wellFormed-invariant-under-actor-embedding (isomorphismToEmbedding π) r

wellFormed-transport-along-permutation :
  (π : ActorPermutation ActorId) (r : RawRun)
  → WellFormed r → WellFormed (renameActors (isomorphismTo π) r)
wellFormed-transport-along-permutation π r =
  wellFormed-transport-along-embedding (isomorphismToEmbedding π) r

wellFormed-reflect-along-permutation :
  (π : ActorPermutation ActorId) (r : RawRun)
  → WellFormed (renameActors (isomorphismTo π) r) → WellFormed r
wellFormed-reflect-along-permutation π r =
  wellFormed-reflect-along-embedding (isomorphismToEmbedding π) r
