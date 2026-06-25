# ActorBase.agda — actors and causal orders

## Where This File Sits

`formal/Concurrency/Sites/ActorBase.agda` is the small primitive substrate for the actor-causal site. It plays for Sites roughly the role `Ports.agda` played for Operads: it defines the minimal vocabulary that the larger site file consumes.

The file has two records:

- `ActorBase`, the opaque actor carrier;
- `CausalOrder`, a Lamport-style partial order on events.

No sessions, payloads, roles, or operads appear here.

## Chunk 1 — header guardrails

```agda
{-# OPTIONS --cubical --guardedness #-}

-- Opaque actor carrier and causal-order primitive for the actor-causal site.
--
-- This file is the locality-leg counterpart of
-- `Concurrency/Operads/Ports.agda`: a minimal substrate file containing
-- the two primitive carriers — `ActorBase` (opaque actor type) and
-- `CausalOrder` (Lamport partial-order on events) — that the site
-- structure in `Concurrency/Sites/ActorCausal.agda` consumes.
```

The header insists on opacity. This file must not distinguish humans from LLMs, ordinary actors from future promoted conversations, or one role from another.

That is not a missing feature. It is the actor/session separation in code. Typed content lives in the algebra layer; actor locality lives here.

## Chunk 2 — imports

```agda
module Concurrency.Sites.ActorBase where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Sigma   using (_×_ ; _,_)
open import Cubical.Relation.Nullary using (¬_)
```

The imports are modest. `Prelude` gives basic types and equality. Sigma gives product notation for the derived concurrency relation. `¬_` is negation, used to say two events are concurrent when neither precedes the other.

## Chunk 3 — `ActorBase`

```agda
record ActorBase (ℓ : Level) : Type (ℓ-suc ℓ) where
  field
    Actor     : Type ℓ
    Actor-set : isSet Actor
```

An `ActorBase` is just a type of actors plus a proof that this type is set-level.

There are no constructors for actors, no decidable equality, no fresh-name generation, and no metadata fields. A concrete instance may provide those outside this record, but the verified kernel does not depend on them.

`Actor-set` matters because later frame membership and cover data need actor identity to behave like ordinary set-level data, not like a higher space with nontrivial paths.

## Chunk 4 — `CausalOrder`

```agda
record CausalOrder (ℓE ℓR : Level) : Type (ℓ-suc (ℓ-max ℓE ℓR)) where
  field
    Event      : Type ℓE
    Event-set  : isSet Event
    _≤_        : Event → Event → Type ℓR
    ≤-refl     : (e : Event) → e ≤ e
    ≤-trans    : {e e' e'' : Event} → e ≤ e' → e' ≤ e'' → e ≤ e''
    ≤-antisym  : {e e' : Event} → e ≤ e' → e' ≤ e → e ≡ e'
    ≤-isProp   : {e e' : Event} → isProp (e ≤ e')
```

This record packages events and their happens-before order.

The order is non-strict: every event precedes itself by `≤-refl`. It is transitive and antisymmetric. It is also proposition-valued: for fixed `e` and `e'`, there is at most one relevant proof of `e ≤ e'`.

`Event-set` is stated separately. Antisymmetry only controls comparable events; it does not by itself force all event equalities to be set-level.

## Chunk 5 — derived concurrency

```agda
Concurrent : Event → Event → Type ℓR
Concurrent e e' = (¬ (e ≤ e')) × (¬ (e' ≤ e))

Concurrent-sym : (e e' : Event) → Concurrent e e' → Concurrent e' e
Concurrent-sym e e' (¬ee' , ¬e'e) = ¬e'e , ¬ee'
```

Two events are concurrent when neither happens before the other.

The definition is symmetric by construction, and `Concurrent-sym` just swaps the two negated order proofs.

Notice that an event is not concurrent with itself: `≤-refl` gives `e ≤ e`.

## Chunk 6 — named antisymmetry

```agda
≤-bidir-equal : {e e' : Event} → e ≤ e' → e' ≤ e → e ≡ e'
≤-bidir-equal = ≤-antisym
```

This is just `≤-antisym` under a name that reads well at later use sites.

`ActorCausal.agda` uses this idea to show that strict frame embeddings cannot collapse distinct events: if two event images are equal, they are ordered both ways, and reflection gives the same in the source.

## Chunk 7 — sanity checks

```agda
private
  _ : (ℓ : Level) → Type (ℓ-suc ℓ)
  _ = ActorBase

  _ : (ℓE ℓR : Level) → Type (ℓ-suc (ℓ-max ℓE ℓR))
  _ = CausalOrder
```

These private witnesses only confirm the records have the expected universe shapes.

The nontrivial concrete witness comes in `ActorCausal.agda`, where `TinyAB` and `TinyCausal` instantiate the two records.

## Closing

`ActorBase.agda` gives the site layer its primitive nouns:

- opaque actors;
- untyped events;
- Lamport-style causal order;
- derived concurrency.

The next file builds local frames, embeddings, covers, and a tiny site from these primitives.
