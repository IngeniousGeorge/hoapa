# Concurrency intro - conversations as the implementation side

The Concurrency side is the part of the framework that talks about agents doing things together. The agents may eventually be humans, programs, proof assistants, LLMs, services, or completed conversations that have become reusable units. The important point is that the verified core does not classify an agent by what kind of thing it is. At the lowest operational level, an agent is an actor: something that can participate in interactions, update its local state, and appear in an event history.

A conversation is then a structured patch of interaction among actors. It is not just a transcript. It has a protocol: who may send or receive what kind of content, how the exchange can continue, and what counts as a completed or coherent exchange.

In practical terms, a future implementation should look more like an event-log and protocol engine than like a single global database. There are actors, events, local views of events, protocols governing content, and documents or artifacts produced by conversations. Different participants may see different parts of the history. The framework needs to say when those partial views are compatible and when they determine the same global content.

## A Practical Run

A single run might look like this.

Some actors enter a conversation about a topic. They exchange messages. The message content is typed by a protocol: a question expects a compatible answer, an offer expects an acceptance or rejection, a claim may require evidence, and so on. Each actor sees only its local view of the conversation, not an omniscient global state.

As the conversation develops, it may produce a document: a decision, a proof sketch, an agreed interface, a review report, a research note. That document is typed content. It is the "what was said" and "what was agreed," not the actor identity of the participants.

When we say "consensus" in this track, we do not mean that the current Agda files implement Paxos, Raft, or any other distributed-consensus algorithm. Consensus here means a conversation has produced a stable typed artifact, relative to a protocol and to the local views that support it. Later implementation work may connect this to concrete consensus algorithms, but the current formalization is about the shape and typing of the situation.

The long-horizon move is conversation-of-conversations. A completed conversation can become a new actor-like unit in a larger conversation. It can send, receive, update, and help spawn further conversations. That move is not implemented yet. The current files protect the slot where it belongs.

## The Separation of Concerns

The Concurrency side is built around one strict separation:

- actors are unityped and opaque;
- typed content lives in a separate value layer;
- interaction shape is its own layer;
- locality and partial observation are their own layer;
- the bridge between locality and typed content is an adapter layer.

This is not bureaucracy. It prevents a common modeling failure.

If actor identity carries the protocol type, then an actor stops being the same kind of thing when it changes conversation. If a session type carries actor identity, then a protocol cannot be reused over different participants. If a conversation is represented only as a global transcript, then local views and auditability become afterthoughts. If a completed conversation is forced to be a different kind of object from an actor, the conversation-of-conversations idea breaks at the first recursion step.

So the project keeps the layers apart.

Actors answer "who can participate, and where did events occur?" Session content answers "what kind of information is being exchanged?" Operads answer "what is the compositional shape of an interaction?" Presheaves and sheaves answer "how do local views restrict, agree, and eventually glue?"

## Actors

An actor is the operational participant.

At the verified-core level, we do not ask whether an actor is a person, a process, a model, a theorem prover, or a previous conversation. That metadata can exist in an application layer, but it is not part of the mathematical kernel.

The Sites folder introduces actors only after the interaction and content layers have been separated. There, actors live in local frames with events and a Lamport-style causal order. A local frame is a partial view: some actors, some events, and the causal relations visible in that view.

> **References**
> - [Lamport, *Time, Clocks, and the Ordering of Events in a Distributed System*](https://lamport.azurewebsites.net/pubs/time-clocks.pdf) - the classic source for the happens-before ordering used as the causal model here.

## Protocols and Session Content

A protocol describes the typed content of a conversation.

In the current Agda files, the first concrete protocol language is a small multiplicative session-type syntax. Session types are a way of typing communication behavior: send this kind of payload, receive that kind of payload, compose channels linearly, take the dual perspective, and so on.

The important design decision is that session typing belongs to the content layer. It does not define actor identity. The same actor can participate in different protocols. The same protocol can be instantiated over different actors.

> **References**
> - [Caires and Pfenning, *Session Types as Intuitionistic Linear Propositions*](https://www.cs.cmu.edu/~fp/papers/concur10.pdf) - one of the central references connecting session types and linear logic.
> - [nLab: linear logic](https://ncatlab.org/nlab/show/linear+logic) - the logic behind tensor, par, linear implication, and duality.

## Interaction Shape

Before the framework can say what a message means, it needs a small grammar for how interactions compose.

That is why the Concurrency track begins with operads. This can feel backwards from an implementation standpoint: users see actors and conversations first, while the first folder talks about ports, rotation, and gluing. The reason is that interaction shape is the smallest layer shared by the Concurrency construction:

- actors participate in interactions;
- session content is carried by interactions;
- conversations are built by composing interactions;
- later, completed conversations may become new interaction units.

The current shape object is `O_1`, the cyclic operad generated by one binary operation. Its primitive interaction has three cyclic boundary ports. Gluing two ports composes interactions. Rotating ports changes which boundary is being treated as the exposed perspective.

This layer intentionally has no actors and no payloads. It is the skeleton that later layers interpret.

> **References**
> - [nLab: operad](https://ncatlab.org/nlab/show/operad) - operations that can be plugged into other operations.
> - [nLab: cyclic operad](https://ncatlab.org/nlab/show/cyclic+operad) - operads where the output is not permanently distinguished from the inputs.

## Locality and Covers

Real conversations are not viewed from nowhere.

Each actor has a local view. A reviewer may see a thread but not a private clarification. A service may see timestamps and payload hashes but not decrypted content. A proof assistant may see formal obligations but not the human motivation. Even in a clean mathematical model, different frames can see different actors and events.

The Sites folder models this with local frames and covers.

A frame says which actors and events are visible. A frame morphism embeds one view as a sub-view of another. A cover says that a larger frame is jointly seen by smaller patches. This is the beginning of the local-to-global story.

The project uses this to keep auditability local. We do not assume every participant has a God's-eye view. We ask what can be checked by restricting to patches and comparing what those patches see.

> **References**
> - [nLab: site](https://ncatlab.org/nlab/show/site) - a category equipped with a notion of cover.
> - [nLab: sheaf](https://ncatlab.org/nlab/show/sheaf) - the standard local-to-global pattern: compatible local data glues to global data.

## The Current Agda Layers

The current `agda/Concurrency/` tree has four folders.

`Operads` builds the interaction-shape layer. It defines finite cyclic ports, raw generated syntax, gluing arithmetic, rotation helpers, and finally the cyclic associative operad `O_1`.

`Algebras` explains how `O_1` is interpreted in a target category. The target signature is star-autonomous, because the intended content semantics is linear/session-like. This folder also gives the first concrete session-type instance.

`Sites` builds the locality layer. It defines opaque actors, causally ordered events, local frames, strict sub-view embeddings, covers, and a small witness that the definitions are inhabited.

`Hybrid` is the first adapter layer. It assigns typed content to actor-local frames and restricts that content along sub-view embeddings. The current version gives presheaves and separatedness, not full sheaf descent.

Read in this order:

1. `00_concurrency_intro.md` - this file.
2. `01_Operads/00_cyclic_operads_intro.md`
3. `02_Algebras/00_algebras_intro.md`
4. `03_Sites/00_actor_sites_intro.md`
5. `04_Hybrid/00_hybrid_intro.md`

The source companions inside each folder then walk the Agda files in order.

## What Is Implemented and What Is Not

Implemented now:

- the `O_1` interaction-shape syntax and laws;
- the star-autonomous target signature;
- weak and structural interpretations of `O_1`;
- a small multiplicative session syntax;
- opaque actors and Lamport-style causal frames;
- basis covers of frames;
- generic frame presheaves;
- session-valued frame presheaves;
- separatedness as the uniqueness half of descent.

Not implemented yet:

- full sheaf gluing/descent;
- real cut elimination or process semantics for sessions;
- a derived, canonical `O_1` action from session cut/evaluation;
- promotion of a completed conversation into an actor-like node;
- the modular envelope `MO_1`;
- the cross-site bridge to ModalHoTT.

These omissions are not cosmetic. They are the current frontier.

## Relation to the Modal Side

The ModalHoTT side and the Concurrency side are not two presentations of the same code.

The ModalHoTT side studies perspectives, modalities, and changes of viewpoint inside a cohesive type-theoretic setting. It asks how worlds at different scales can see, flatten, sharpen, or approximate each other.

The Concurrency side studies an operational community: actors exchanging typed content through protocols, with only local views, producing documents and eventually conversations that can become units in larger conversations.

The eventual bridge is expected to be cross-site: ModalHoTT gives the language of perspectives; Concurrency gives the algorithmic structure of a community moving through perspectives by interaction. Workflow notes call this relation `Allow ⊣ Require`: roughly, modal structure allows the concurrency substrate to unfold, while a disciplined concurrency substrate requires a perspectival/modal account to explain why local views can be organized coherently.

That bridge is not built in the current Agda. The Concurrency files are preparing the B-side object carefully enough that such a bridge can later be stated without collapsing actors, protocols, locality, and modal perspective into one undifferentiated record.

For now, the right reading is practical: this side is about how a typed conversation network could actually run, be checked locally, and produce reusable consensus artifacts without losing the separation between who acts, what is said, how interaction composes, and how local views fit together.
