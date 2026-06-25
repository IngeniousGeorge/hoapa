{-# OPTIONS --cubical --safe --guardedness #-}

-- The decidable raw boundary of the runtime contract (v0).
--
-- This module is the trusted, serializable kernel of the implementation
-- track: a first-order record of runtime evidence (`RawRun` / `RawTrace`)
-- plus a Boolean well-formedness validator (`valid?`). It is deliberately
-- self-contained:
--
--   * It imports NONE of the project substrate (`Sites/`, `Algebras/`,
--     `Hybrid/`). Substrate `Actor` / `Event` are opaque and lack decidable
--     equality, so they cannot live at a serializable, decidable boundary.
--   * IDs are dense `ℕ` coordinates, not the opaque carriers. The JSON wire
--     uses readable string IDs; the generator maps them to `ℕ` per namespace
--     by first appearance. `valid?` sees only structure over `ℕ`, never the
--     labels — which is what makes renaming invariance hold.
--   * `--safe` is requested to advertise that this kernel is postulate- and
--     hole-free. The requirement is postulate-freedom; the flag is its proof.
--
-- NORTH STAR (deferred, not built here): `RuntimeContract/Realization.agda`.
-- A later interpretation layer should prove that a well-formed `RawTrace`
-- PRESENTS a finite actor-causal object of the existing substrate:
--   actor IDs   ↦ a finite actor carrier (a choice for the generic `Actor`);
--   events      ↦ event carrier;
--   causalParents (backward) ↦ a `CausalOrder` (refl/trans/antisym/isProp);
--   conversations ↦ `LocalFrame`s (ActorIn / touches / touches-in-frame);
--   sessionTag  ↦ a real `SessionType`, via a tag environment;
--   content / provenance ↦ opaque until their theories exist.
-- The key philosophical theorem there is renaming invariance: bijectively
-- renaming raw IDs yields an EQUAL realized object (the boundary instance of
-- univalence / unityping). Each `valid?` clause below is designed as the
-- decidable shadow of a substrate axiom so that proof stays near-mechanical.

module RuntimeContract.Trace where

open import Cubical.Core.Primitives
open import Cubical.Foundations.Prelude
open import Cubical.Data.Nat using (ℕ; zero; suc)
open import Cubical.Data.Bool using (Bool; true; false)
open import Cubical.Data.List using (List; []; _∷_)
open import Cubical.Data.Unit using (Unit; tt)
open import Cubical.Data.Empty using (⊥)
open import Cubical.Relation.Nullary using (Dec; yes; no; ¬_)

-- ----------------------------------------------------------------------
-- Identifier namespaces. All are meaningless dense `ℕ` coordinates; their
-- semantic roles (actor / event / conversation / tag) are documentation,
-- and the wire ↔ ℕ mapping policy is recorded in Serialization/schema.md.
-- ----------------------------------------------------------------------

ActorId EventId ConvId TagId : Type₀
ActorId = ℕ
EventId = ℕ
ConvId  = ℕ
TagId   = ℕ

-- ----------------------------------------------------------------------
-- Raw serializable records (first-order data only: no proofs, no
-- functions, no live handles, no identity-refining fields).
-- ----------------------------------------------------------------------

record RawConversation : Type₀ where
  constructor mkConv
  field
    convId      : ConvId
    convActors  : List ActorId   -- actors present in this local view
    convSession : TagId          -- opaque "how" tag

record RawEvent : Type₀ where
  constructor mkEvent
  field
    evId      : EventId
    evConv    : ConvId           -- containing conversation / local view
    evTouches : List ActorId     -- actors touched by the event
    evParents : List EventId     -- events that must occur before this one
    evContent : TagId            -- opaque "what" tag (not a payload body)
    evProv    : TagId            -- opaque provenance token

record RawTrace : Type₀ where
  constructor mkTrace
  field
    traceActors : List ActorId
    traceConvs  : List RawConversation
    traceEvents : List RawEvent

record RawRun : Type₀ where
  constructor mkRun
  field
    traceFormat        : ℕ       -- format code; 0 ↦ "hoapa.trace/0"
    runId              : ℕ
    protocolId         : ℕ
    siblingProtocolIds : List ℕ
    trace              : RawTrace

open RawConversation
open RawEvent
open RawTrace
open RawRun

-- ----------------------------------------------------------------------
-- Small Boolean / list primitives (hand-rolled to keep the import
-- surface minimal and `--safe`-clean).
-- ----------------------------------------------------------------------

infixr 6 _andB_

_andB_ : Bool → Bool → Bool
true  andB b = b
false andB _ = false

notB : Bool → Bool
notB true  = false
notB false = true

ifB : {ℓ : Level} {A : Type ℓ} → Bool → A → A → A
ifB true  x _ = x
ifB false _ y = y

eqℕ : ℕ → ℕ → Bool
eqℕ zero    zero    = true
eqℕ zero    (suc _) = false
eqℕ (suc _) zero    = false
eqℕ (suc m) (suc n) = eqℕ m n

allB : {ℓ : Level} {A : Type ℓ} → (A → Bool) → List A → Bool
allB f []       = true
allB f (x ∷ xs) = f x andB allB f xs

infix 4 _∈?_

_∈?_ : ℕ → List ℕ → Bool
x ∈? []       = false
x ∈? (y ∷ ys) = ifB (eqℕ x y) true (x ∈? ys)

infix 4 _⊆?_

_⊆?_ : List ℕ → List ℕ → Bool
xs ⊆? ys = allB (λ x → x ∈? ys) xs

distinctB : List ℕ → Bool
distinctB []       = true
distinctB (x ∷ xs) = ifB (x ∈? xs) false (distinctB xs)

-- Projections to ID lists.

convIdsOf : List RawConversation → List ConvId
convIdsOf []       = []
convIdsOf (c ∷ cs) = convId c ∷ convIdsOf cs

evIdsOf : List RawEvent → List EventId
evIdsOf []       = []
evIdsOf (e ∷ es) = evId e ∷ evIdsOf es

-- Actors of the conversation with a given id ([] if absent; absence is
-- separately rejected by the reference-resolution clause).
lookupConvActors : ConvId → List RawConversation → List ActorId
lookupConvActors c []       = []
lookupConvActors c (k ∷ ks) = ifB (eqℕ c (convId k)) (convActors k) (lookupConvActors c ks)

-- ----------------------------------------------------------------------
-- Per-record well-formedness clauses (each is the decidable shadow of a
-- substrate axiom; see north-star header).
-- ----------------------------------------------------------------------

-- local actor list is a duplicate-free subset of the global actors
convOK : List ActorId → RawConversation → Bool
convOK acts c = distinctB (convActors c) andB (convActors c ⊆? acts)

-- conversation resolves; touch/parent lists are sets; touches ⊆ conv actors
eventOK : List ConvId → List RawConversation → RawEvent → Bool
eventOK cids convs e =
      (evConv e ∈? cids)
  andB distinctB (evTouches e)
  andB distinctB (evParents e)
  andB (evTouches e ⊆? lookupConvActors (evConv e) convs)

-- causal parents point backward: every parent was already seen earlier in
-- the event list (the renaming-invariant, list-position reading).
backwardGo : List EventId → List RawEvent → Bool
backwardGo seen []       = true
backwardGo seen (e ∷ es) = (evParents e ⊆? seen) andB backwardGo (evId e ∷ seen) es

backwardOK : List RawEvent → Bool
backwardOK = backwardGo []

formatCode : ℕ
formatCode = 0   -- "hoapa.trace/0"

-- ----------------------------------------------------------------------
-- The executable validator. Boolean-first so tests are computational.
-- ----------------------------------------------------------------------

valid? : RawRun → Bool
valid? r =
      eqℕ (traceFormat r) formatCode
  andB distinctB (siblingProtocolIds r)
  andB distinctB (traceActors t)
  andB distinctB cids
  andB distinctB eids
  andB allB (convOK (traceActors t)) (traceConvs t)
  andB allB (eventOK cids (traceConvs t)) (traceEvents t)
  andB backwardOK (traceEvents t)
  where
    t : RawTrace
    t = trace r
    cids : List ConvId
    cids = convIdsOf (traceConvs t)
    eids : List EventId
    eids = evIdsOf (traceEvents t)

-- ----------------------------------------------------------------------
-- Propositional wrapper + decision procedure (the checker-facing API).
-- ----------------------------------------------------------------------

WellFormed : RawRun → Type₀
WellFormed r = valid? r ≡ true

private
  So : Bool → Type₀
  So true  = Unit
  So false = ⊥

  decEqTrue : (b : Bool) → Dec (b ≡ true)
  decEqTrue true  = yes refl
  decEqTrue false = no (λ p → subst So (sym p) tt)

decide : (r : RawRun) → Dec (WellFormed r)
decide r = decEqTrue (valid? r)
