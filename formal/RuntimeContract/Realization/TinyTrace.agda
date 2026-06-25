{-# OPTIONS --cubical --guardedness #-}

-- First CONCRETE realization witness: the tiny valid trace `term`
-- (Generated/Raw/Valid/TinyTrace) is exhibited as a finite actor-causal
-- `LocalFrame` over the substrate's own `TinyAB` / `TinyCausal`, with its
-- incidence COMPUTED FROM the trace rather than asserted by hand.
--
-- This is the junction where the two project legs touch, at witness strength:
-- a concrete runtime trace is presented as an object of the actor-causal site
-- the conjecture side proves theorems about. It is deliberately NOT the
-- generic bridge.
--
-- Honesty discipline (why this is a witness, not the theorem):
--   * `tinyTouches` is a function of `term` (`∈? evTouches (eventAt e)`), so
--     changing tiny_trace.json's touches breaks the `realize-*` lemmas.
--   * `source-*` lemmas pin the trace fields the realization depends on
--     (actors, event ids, the parent edge, both touch lists); changing the
--     fixture breaks them by `refl` failure.
--   * Order and actors are pure REUSE of `TinyCausal` / `TinyAB`. We do NOT
--     construct the causal order from the parent list — that generic step
--     ("derive CausalOrder from causalParents") is a separate milestone.
--
-- Coordinate / presentation choice (concrete; the generic theorem will later
-- abstract it via renaming invariance):
--   event id 0  ↔ false  (first event)     actor id 0 ↔ fzero
--   event id 1  ↔ true   (second event)    actor id 1 ↔ fone
--
-- Future generic theorem (NOT here):
--   (r : RawRun) → WellFormed r → RealizedFrame r,
--   plus renaming invariance and valid-reordering invariance.
--
-- Postulate-free (the substrate is postulate-free after the TinyActorBase /
-- TinyActorCausalSite cleanup), though not `--safe`: the substrate carries
-- the infective `--guardedness` flag.

module RuntimeContract.Realization.TinyTrace where

open import Cubical.Foundations.Prelude using (ℓ-zero; _≡_; refl)
open import Cubical.Core.Primitives using (Type)
open import Cubical.Data.Bool using (Bool; false; true)
open import Cubical.Data.Bool.Properties using (isSetBool; false≢true)
open import Cubical.Data.Nat using (ℕ)
open import Cubical.Data.List using (List; []; _∷_)
open import Cubical.Data.Sigma using (_,_; fst)
open import Cubical.Data.Fin using (Fin)
open import Cubical.Data.Unit using (Unit; tt)
open import Cubical.Relation.Nullary using (¬_)

open import Concurrency.Sites.ActorBase using (CausalOrder)
open import Concurrency.Sites.TinyActorBase using (TinyAB)
open import Concurrency.Sites.ActorCausal using (LocalFrame; TinyCausal)

open import RuntimeContract.Trace
open RawRun
open RawTrace
open RawEvent
open RawConversation
open import RuntimeContract.Generated.Raw.Valid.TinyTrace using (term)

-- The realization claim is only made for well-formed traces.
source-valid : valid? term ≡ true
source-valid = refl

------------------------------------------------------------------------
-- Total accessors into the trace's event list. Reduction uses the real
-- generated list; the default cases only keep the functions total.
------------------------------------------------------------------------

defaultEvent : RawEvent
defaultEvent = mkEvent 0 0 [] [] 0 0

headE : List RawEvent → RawEvent
headE []      = defaultEvent
headE (e ∷ _) = e

secondE : List RawEvent → RawEvent
secondE []          = defaultEvent
secondE (_ ∷ [])    = defaultEvent
secondE (_ ∷ e ∷ _) = e

termEvents : List RawEvent
termEvents = traceEvents (trace term)

-- false ↦ first event (id 0), true ↦ second event (id 1).
eventAt : Bool → RawEvent
eventAt false = headE termEvents
eventAt true  = secondE termEvents

defaultConv : RawConversation
defaultConv = mkConv 0 [] 0

headC : List RawConversation → RawConversation
headC []      = defaultConv
headC (c ∷ _) = c

termConvs : List RawConversation
termConvs = traceConvs (trace term)

------------------------------------------------------------------------
-- Source pins: the trace fields the realization depends on. Each is `refl`
-- against the generated `term`, so a divergent fixture breaks the build.
------------------------------------------------------------------------

source-actors : traceActors (trace term) ≡ (0 ∷ 1 ∷ [])
source-actors = refl

source-event0-id : evId (eventAt false) ≡ 0
source-event0-id = refl

source-event1-id : evId (eventAt true) ≡ 1
source-event1-id = refl

source-parent-e1 : evParents (eventAt true) ≡ (0 ∷ [])
source-parent-e1 = refl

source-touch-e0 : evTouches (eventAt false) ≡ (0 ∷ [])
source-touch-e0 = refl

source-touch-e1 : evTouches (eventAt true) ≡ (1 ∷ [])
source-touch-e1 = refl

-- The single conversation's local view contains both actors, which is what
-- `ActorIn = Unit` realizes in the frame below.
source-conv-actors : convActors (headC termConvs) ≡ (0 ∷ 1 ∷ [])
source-conv-actors = refl

------------------------------------------------------------------------
-- Incidence COMPUTED from the trace: actor a touches event e iff a's id is
-- in that event's `evTouches` list. (`_∈?_` and the projections come from
-- RuntimeContract.Trace.)
------------------------------------------------------------------------

-- The actor's underlying ℕ id (Σ projection; `toℕ`'s bound is not inferable
-- here because Fin is a type synonym, so we use `fst` directly).
actorIdOf : Fin 2 → ℕ
actorIdOf a = fst a

tinyTouches : Bool → Fin 2 → Type ℓ-zero
tinyTouches e a = (actorIdOf a ∈? evTouches (eventAt e)) ≡ true

-- Built as explicit Σ pairs (Fin n = Σ ℕ (_<ᵗ n)) so toℕ reduces definitionally.
a0 a1 : Fin 2
a0 = 0 , tt
a1 = 1 , tt

-- The realized object: a LocalFrame over TinyAB whose order is TinyCausal
-- (so e0 ≺ e1 is inherited) and whose incidence is read off `term`.
tinyTraceFrame : LocalFrame TinyAB ℓ-zero ℓ-zero
tinyTraceFrame = record
  { causal           = TinyCausal
  ; ActorIn          = λ _ → Unit
  ; ActorIn-isProp   = λ _ _ _ → refl
  ; touches          = tinyTouches
  ; touches-isProp   = λ e a → isSetBool (actorIdOf a ∈? evTouches (eventAt e)) true
  ; touches-in-frame = λ _ → tt
  }

------------------------------------------------------------------------
-- Correspondence lemmas. Because `tinyTouches` reduces through `term`, these
-- are facts about the realized frame AND the trace simultaneously: they fail
-- if the fixture's touches change.
------------------------------------------------------------------------

realize-e0-touches-a0 : tinyTouches false a0
realize-e0-touches-a0 = refl

realize-e1-touches-a1 : tinyTouches true a1
realize-e1-touches-a1 = refl

realize-e0-misses-a1 : ¬ (tinyTouches false a1)
realize-e0-misses-a1 = false≢true

-- The parent edge `e1.causalParents = [e0]` (pinned by source-parent-e1) is
-- realized as the order `false ⊑ true`, inherited from TinyCausal.
parent-edge-realized : CausalOrder._≤_ TinyCausal false true
parent-edge-realized = tt
