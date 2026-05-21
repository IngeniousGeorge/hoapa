# Actor sites intro — locality before content

The Sites folder is the Concurrency-side locality layer. The operads folder built interaction shape. The algebras folder interpreted that shape in typed content. The Sites folder deliberately does neither. It describes *where* interactions happen: actors, events, local frames, sub-view embeddings, and covers.

The separation is load-bearing:

- actors are unityped and opaque;
- events are untyped occurrences;
- session types and payloads do not appear here;
- operads do not appear here;
- promotion of a completed conversation into a new actor is deferred.

This is how the project keeps typed content and actor locality from being mixed too early.

## The Two Files

`ActorBase.agda` gives the primitive carriers:

- `ActorBase`: a type of actors, with set-truncation;
- `CausalOrder`: a Lamport-style partial order on events.

`ActorCausal.agda` builds the site:

- `LocalFrame`: a local view of actors and events;
- `FrameHom`: a strict sub-view embedding;
- `Cover`: a basis-style covering family of local frames;
- `ActorCausalSite`: identity, transitivity, and stability of covers;
- `tiny-site`: a small concrete inhabitability witness.

## Opaque Actors

An actor in this layer is just an actor. The kernel cannot ask whether it is a human, an LLM, a process, or a promoted conversation. That metadata may exist in an implementation adapter, but it is not part of the verified core.

This is what the project means by unityped agents at the site level. The actor type is not refined by role, payload, session type, or origin.

## Lamport Causality

Events carry a non-strict partial order:

```agda
e ≤ e'
```

Read this as "event `e` happened before or at the same time as event `e'`" in the Lamport sense. The order is reflexive, transitive, antisymmetric, and proposition-valued.

> **References**
> - [Lamport, *Time, Clocks, and the Ordering of Events in a Distributed System*](https://lamport.azurewebsites.net/pubs/time-clocks.pdf) — the classic happens-before ordering.

The files do not use Lorentzian geometry, event structures, Petri nets, or process calculi here. Those may be future refinements. The current layer uses the smallest order structure that makes locality and causality meaningful.

## Local Frames

A `LocalFrame` is a partial view:

- which actors are present;
- which events exist;
- which events touch which actors;
- how events are causally ordered.

There is no global frame in the intended reading. Frames are local observations. Covers say how smaller local frames jointly see a larger one.

## Strict Frame Morphisms

A `FrameHom F G` embeds frame `F` as a sub-view of frame `G`.

It preserves:

- actor membership;
- events, via an event map;
- event/actor incidence;
- causality.

It also reflects causality. If the images of two events are ordered in `G`, then the original events were already ordered in `F`.

That reflection is strict by design. It means a `FrameHom` cannot collapse a whole conversation into one event or add new causal structure. Promotion of a conversation into an actor-like node must be a different morphism class later.

## Covers

A `Cover F` is a basis-style cover of a local frame `F`. It contains:

- an index type;
- a patch frame for each index;
- an embedding from each patch into `F`;
- witnesses that every actor and every event of `F` appears in some patch.

This is a concrete basis presentation, not the final sieve presentation of a Grothendieck topology. The file defines `sieve-of` as the bridge toward the future sieve form.

> **References**
> - [nLab: Grothendieck topology](https://ncatlab.org/nlab/show/Grothendieck+topology)
> - [nLab: site](https://ncatlab.org/nlab/show/site)

## Reading Order

Read:

1. `00_actor_sites_intro.md` — this file.
2. `01_actorbase.md` — opaque actors and causal orders.
3. `02_actorcausal.md` — frames, morphisms, covers, site bundle, tiny witness.

The next folder, Hybrid, will place session-valued presheaves over these actor-local frames.
