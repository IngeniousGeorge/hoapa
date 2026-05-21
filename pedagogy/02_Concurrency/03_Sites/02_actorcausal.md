# ActorCausal.agda — local frames, covers, and a tiny site

## Where This File Sits

`agda/Concurrency/Sites/ActorCausal.agda` builds the actor-causal site on top of `ActorBase.agda`.

This is the largest Concurrency file in the current pass. The through-line is still simple:

1. define local frames;
2. define strict embeddings between frames;
3. show they form a category-like structure;
4. define basis covers;
5. bundle the site axioms;
6. give a small concrete witness.

The file intentionally imports neither Sessions nor Operads. It is the locality leg only.

## Chunk 1 — header and imports

```agda
{-# OPTIONS --cubical --guardedness #-}

-- The actor-causal site: locality leg of the Concurrency hybrid.
--
-- This file is the locality counterpart to `Concurrency.Algebras.Sessions`:
-- Sessions ships the typed-content layer over the cyclic-operad algebra
-- interface; this file ships the actor-causal Grothendieck site over the
-- `ActorBase` + `CausalOrder` primitives from `ActorBase.agda`.
```

The header explicitly pairs this file with `Sessions.agda`: comparable maturity, separate legs. Sessions supplies typed values; this file supplies actor-local frames.

```agda
module Concurrency.Sites.ActorCausal where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.HLevels using (isPropΠ ; isProp×)
open import Cubical.Data.Sigma  using (Σ-syntax ; _×_ ; _,_ ; fst ; snd)
open import Cubical.Data.Nat    using (ℕ ; zero ; suc)
open import Cubical.Data.Fin    using (Fin ; fzero ; fsuc)
open import Cubical.Data.Empty  using (⊥ ; rec)
open import Cubical.Data.Unit   using (Unit ; tt ; isSetUnit)
open import Cubical.Relation.Nullary using (¬_)

open import Concurrency.Sites.ActorBase
```

The imports cover products, dependent sums, finite sets, empty/unit types, and negation. Those are enough to define frames and a small finite witness.

## Chunk 2 — module parameterization

```agda
module _ {ℓA : Level} (AB : ActorBase ℓA) where
  open ActorBase AB
```

Most of the file is parameterized by a fixed `ActorBase`. All local frames share the same actor carrier. That is the site over one actor universe.

Events may vary from frame to frame, but actors come from the fixed base.

## Chunk 3 — `LocalFrame`

```agda
record LocalFrame (ℓE ℓR : Level) : Type (...) where
  field
    causal           : CausalOrder ℓE ℓR
  open CausalOrder causal public
  field
    ActorIn          : Actor → Type ℓA
    ActorIn-isProp   : (a : Actor) → isProp (ActorIn a)
    touches          : Event → Actor → Type ℓR
    touches-isProp   : (e : Event) (a : Actor) → isProp (touches e a)
    touches-in-frame : {e : Event} {a : Actor} → touches e a → ActorIn a
```

A local frame contains a causal order on events, a predicate saying which actors are in the frame, and an incidence relation saying which event touches which actor.

Both `ActorIn` and `touches` are proposition-valued. An actor is not "in the frame in three different ways." An event does not "touch an actor in many distinguishable ways." These are locality facts, not data-rich payloads.

`touches-in-frame` says incidence cannot point outside the frame: if an event touches an actor, that actor is in the frame.

## Chunk 4 — `FrameHom`

```agda
record FrameHom ... (F : LocalFrame ℓE₁ ℓR₁)
                    (G : LocalFrame ℓE₂ ℓR₂)
                  : Type ... where
  field
    actor-pres   : {a : Actor} → F.ActorIn a → G.ActorIn a
    event-map    : F.Event → G.Event
    touches-pres : {e : F.Event} {a : Actor}
                 → F.touches e a → G.touches (event-map e) a
    causal-pres  : {e e' : F.Event} → e F.≤ e' → event-map e G.≤ event-map e'
    causal-refl  : {e e' : F.Event} → event-map e G.≤ event-map e' → e F.≤ e'
```

A `FrameHom F G` embeds `F` as a sub-view of `G`.

It preserves actor membership, maps events, preserves incidence, and preserves causal order. The last field, `causal-refl`, is the strict part: if the images are causally ordered in `G`, the original events were already ordered in `F`.

So a `FrameHom` cannot add causality, and it cannot be a quotient-like promotion map. That is why future "conversation becomes actor" structure must be a different morphism class.

The file also defines:

```agda
_↪_ : LocalFrame ... → LocalFrame ... → Type ...
F ↪ G = FrameHom F G
```

The infix alias lets later statements read as "F embeds into G."

## Chunk 5 — event-map injectivity

```agda
event-map-injective :
    {e e' : F.Event}
  → event-map e ≡ event-map e'
  → e ≡ e'
```

This lemma derives injectivity of the event map from strict causality reflection.

If `event-map e` equals `event-map e'`, then in `G` the image of `e` is ≤ the image of `e'`, and vice versa, by reflexivity transported along the equality. Reflection gives `e ≤ e'` and `e' ≤ e` back in `F`. Antisymmetry then gives `e ≡ e'`.

That is the formal version of "FrameHom is an embedding, not a collapse."

## Chunk 6 — identity and composition

```agda
frame-id : {ℓE ℓR : Level} (F : LocalFrame ℓE ℓR) → F ↪ F
frame-id F = record
  { actor-pres   = λ x → x
  ; event-map    = λ e → e
  ; touches-pres = λ t → t
  ; causal-pres  = λ p → p
  ; causal-refl  = λ p → p
  }

_∘ᶠ_ : ... → G ↪ H → F ↪ G → F ↪ H
```

Frames have identity embeddings, and embeddings compose. Composition just composes the actor preservation, event maps, incidence preservation, and causal preservation/reflection fields.

The file then proves:

```agda
frame-id-l φ = refl
frame-id-r φ = refl
∘ᶠ-assoc χ ψ φ = refl
```

These are definitional because the records are built field-by-field in the direct way.

## Chunk 7 — basis covers

```agda
record Cover {ℓE ℓR : Level} (ℓI : Level) (F : LocalFrame ℓE ℓR)
           : Type ... where
  field
    Index         : Type ℓI
    patch         : Index → LocalFrame ℓE ℓR
    embed         : (i : Index) → patch i ↪ F

    actor-covered : {a : Actor} → ActorIn a
                  → Σ[ i ∈ Index ] LocalFrame.ActorIn (patch i) a

    event-covered : (e : Event)
                  → Σ[ i ∈ Index ]
                      Σ[ ẽ ∈ LocalFrame.Event (patch i) ]
                        FrameHom.event-map (embed i) ẽ ≡ e
```

A cover of `F` is an indexed family of patch frames, each embedded into `F`, such that every actor and every event of `F` is seen by some patch.

The witnesses are explicit dependent pairs. For an event, `event-covered` returns a patch index, an event in that patch, and a proof that embedding the patch event gives the original event.

This is basis-form coverage. It is concrete and easy to instantiate. A future sieve-form topology can be built from it.

## Chunk 8 — generated sieve

```agda
sieve-of :
    (c : Cover ℓI F)
    {H : LocalFrame ℓEH ℓRH}
  → (H ↪ F)
  → Type ...
sieve-of c g =
  Σ[ i ∈ Cover.Index c ]
    Σ[ h ∈ H ↪ Cover.patch c i ]
      g ≡ Cover.embed c i ∘ᶠ h
```

`sieve-of c` says a morphism `g : H ↪ F` belongs to the sieve generated by the cover if it factors through one of the cover patches.

This is not yet the final sieve formalization because the factorization is chosen data, not mere existence. But it is the bridge from the basis cover to the future Grothendieck topology presentation.

## Chunk 9 — identity and transitivity covers

```agda
identity-cover-canonical :
    (ℓI : Level)
    (F : LocalFrame ℓE ℓR)
  → Cover ℓI F
```

The identity cover covers a frame by itself. Every actor and event is already present.

```agda
transitivity-cover-canonical :
    (F : LocalFrame ℓE ℓR)
    (c : Cover ℓI F)
    (d : (i : Cover.Index c) → Cover ℓI (Cover.patch c i))
  → Cover ℓI F
```

Transitivity says covers compose: if `c` covers `F`, and each patch of `c` is covered by another cover, then the composite family covers `F`.

The composite index type is a dependent pair `(i , j)`: first choose a patch of `c`, then choose a patch of its cover.

Both constructions are generic and proof-checked. They are not postulates.

## Chunk 10 — `ActorCausalSite`

```agda
record ActorCausalSite (ℓE ℓR ℓI : Level) : Type ... where
  field
    identity-cover :
        (F : LocalFrame ℓE ℓR) → Cover ℓI F

    transitivity-cover :
        (F : LocalFrame ℓE ℓR)
        (c : Cover ℓI F)
        (d : (i : Cover.Index c) → Cover ℓI (Cover.patch c i))
      → Cover ℓI F

    stability-cover :
        {F G : LocalFrame ℓE ℓR}
        (g : G ↪ F) (c : Cover ℓI F)
      → Σ[ d ∈ Cover ℓI G ] ...
```

This is the site bundle. It records identity covers, transitivity of covers, and stability of covers under pullback along frame embeddings.

Identity and transitivity have generic constructions above. Stability is harder: to construct it generically, the frame category would need pullbacks of `FrameHom`s. This signature does not include them.

So the file exposes a named postulate:

```agda
stability-cover-postulate
```

That is the current site-level axiom gap.

## Chunk 11 — the tiny causal order

```agda
private
  _⊑_ : Bool → Bool → Type
  true  ⊑ false = ⊥
  _     ⊑ _     = Unit
```

The concrete witness uses two events, `false` and `true`, with `false ⊑ true`. The reverse `true ⊑ false` is impossible.

The file proves reflexivity, transitivity, antisymmetry, and proposition-valuedness for this tiny order by pattern matching.

This gives a non-discrete causal order small enough to write directly.

## Chunk 12 — tiny actors and frames

```agda
TinyAB : ActorBase ℓ-zero
TinyAB = record
  { Actor     = Fin 2
  ; Actor-set = isSetFin {k = 2}
  }

TinyCausal : CausalOrder ℓ-zero ℓ-zero
TinyCausal = record
  { Event     = Bool
  ; Event-set = isSetBool
  ; _≤_       = _⊑_
  ; ... }

TinyFrame : LocalFrame TinyAB ℓ-zero ℓ-zero
```

`TinyAB` has two actors. `TinyCausal` has two events with one nontrivial causal arrow. `TinyFrame` includes both actors, both events, and full incidence: every event touches every actor.

The file also defines `PointCausal` and `PointFrame`, a one-event frame used as a patch.

## Chunk 13 — point embeddings and nontrivial cover

```agda
embed-point : (b : Bool) → FrameHom TinyAB PointFrame TinyFrame
embed-point b = record
  { actor-pres   = λ _ → tt
  ; event-map    = λ _ → b
  ; touches-pres = λ _ → tt
  ; causal-pres  = λ _ → ⊑-refl b
  ; causal-refl  = λ _ → tt
  }
```

`embed-point b` embeds the one-event frame into `TinyFrame` by choosing which event, `false` or `true`, the single point maps to. This is non-identity because the event map is constant at a chosen Bool.

```agda
two-point-cover : Cover TinyAB ℓ-zero TinyFrame
two-point-cover = record
  { Index         = Bool
  ; patch         = λ _ → PointFrame
  ; embed         = embed-point
  ; actor-covered = λ _ → false , tt
  ; event-covered = λ where
      false → false , tt , refl
      true  → true  , tt , refl
  }
```

The cover has two patches, one for each event. It is the file's nontrivial topology witness: not just the identity cover, and not a vacuous index.

## Chunk 14 — bundled tiny site

```agda
tiny-site : ActorCausalSite TinyAB ℓ-zero ℓ-zero ℓ-zero
tiny-site = record
  { identity-cover     = identity-cover-canonical     TinyAB ℓ-zero
  ; transitivity-cover = transitivity-cover-canonical TinyAB
  ; stability-cover    = stability-cover-postulate    TinyAB
  }
```

The tiny site bundles the generic identity and transitivity constructions with the current stability postulate.

The private sanity checks at the end confirm that the base, frames, embeddings, covers, and full site all typecheck.

## Closing

`ActorCausal.agda` establishes the locality leg:

- local frames over opaque actors;
- strict sub-view embeddings;
- basis covers;
- generated sieves as future bridge;
- generic identity and transitivity of covers;
- a named stability postulate;
- a concrete tiny site with a nontrivial two-patch cover.

The next folder, Hybrid, uses this frame category as the base over which session-valued presheaves vary.
