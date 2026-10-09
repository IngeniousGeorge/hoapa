---
tags: [focus:architecture, kind:reference, level:scoping]
---

# Participant and information-flow architecture

This file records the intended concrete shape of Hoapa as seen by participants
and by information flow. It is the positive architectural reference for the
runtime contract and the layers built above it. It also records one constrained
correspondence between that architecture and its candidate mathematics. The
correspondence distinguishes represented structure from proposed
interpretation; proofs and implementation status live in their own workflow
files.

## Three independent axes

Levels, layers, and adapters answer different questions.

- **Levels** say what may occupy the active positions of a conversation.
  Level −1 is a real conversation among participants. At level 0, documented
  conversations and their outputs can occupy the subject positions of a new
  level −1 conversation. The same pattern can recur: panels remain the active
  machinery, while the graphs they work on are artifacts.
- **Layers** separate responsibilities within what is represented: session
  orchestration, content and provenance, the content layer Λ, reflexive
  protocol change, dynamics and measurement, and Federation. A layer is not a
  temporal stage and need not correspond to one runtime process.
- **Adapters** relate structures across a separation of concerns. Restriction,
  descent, change of value, promotion, the conjectural `Allow ⊣ Require`, and
  no-leak are relationships between structures; they are not additional
  levels or layers.

## Seats and participants

The eligible population exists outside the trace. A run records only opaque,
run-local actor handles registered for that run. Registration, selection for a
panel, and participation in an event are distinct:

1. a registered actor is available inside the run;
2. a panel member occupies a seat in one conversation;
3. an event participant is touched by one recorded event.

Registration does not require contribution. A registered actor may remain
silent or join no conversation. Panel selection does not inspect an actor's
identity or refine actors into kinds.

The interface gives every eligible participant the same formal standing; this
does not say that different participants or panels will produce equivalent
results. Any admissible person may occupy a seat because the role is specified
independently of its occupant. In the Lautman-facing interpretation, what is
articulated is understanding of the world: embodied among participants under
a common plan, predominantly synthetically, and in differentiated conceptual
documentation, predominantly analytically. Both moments occur in both realms;
see [the canonical interpretation](related_structures.md#lautman-decomposition).
Participants help produce, test, and revise documented articulations. The
record represents specified participation and work, not an exhaustive
decomposition of a person. Assessing a contribution must not turn its content
classification or success into a kind, rank, or privilege of its producer.

Each draw creates its own situated assembly and, when successful, its own
result. Neither the panel nor its result stands in for the eligible population.
The result has standing through the open flow into which it is published: later
conversations may reference, test, challenge, revise, or supersede it. No draw
closes that flow on behalf of the whole.

## Conversation kinds and lifecycle

A conversation has one homogeneous kind fixed by its session type. A
participant conversation has participant seats. A content-level conversation
has concept or artifact references in the corresponding subject positions.
The two are not mixed inside one conversation.

The lifecycle is:

```text
task → draw → panel deliberation → one closure → publication
                                  ↘ failure record → resubmission
```

The session tag is immutable history: it says how the conversation was
constituted and orchestrated. Editing never mutates that tag. A new protocol or
shape is used by starting another conversation under another session tag.

A conversation closes exactly once, successfully or unsuccessfully, through a
distinguished closure event. A successful closure names its output artifact. A
failure closure produces a first-class failure record that may be referenced by
a later attempt. No later event belongs to the closed conversation. Editing
content means appending new events or conversations; published history is not
rewritten.

Successful resolution requires unanimous acceptance under the participation
and assent rules declared by the conversation's interface. Candidate
recognition, attribution of assent, and treatment of silence are interface
mechanics. The common trace contract records closure and its output or failure;
it does not by itself certify that an implementation followed those mechanics.

## Event information

The event record keeps three concerns separate.

- `causalParents` records which earlier events this event operationally
  depended on. The runtime kernel must eventually earn these edges from
  consumed messages; the recorder merely preserves them.
- provenance records how an event or dependency arose, including edge kinds
  such as response, deepening, or correction and the success/failure closure
  marker. Provenance describes derivation, not actor essence.
- content records the documented substance. It may carry a run-local reference
  or a federated artifact reference, but those reference kinds remain distinct.

Run-local references must resolve within the accepted run. A federated
artifact reference resolves against a declared imported publication bundle,
including the producer scope and the relevant artifact and protocol versions.

## Live and public records

The live record and public record are different mathematical objects. The live
runtime may temporarily know operational identities needed for delivery. The
closure transform publishes a content-facing record with fresh
per-conversation actor handles, drops authorship and operational identity, and
retains the participant count, outputs, stable content identifiers,
provenance, references, and dependency edges.

Public actor handles are pseudonyms, not claims of anonymity by themselves.
The no-leak obligation is observer-relative: a declared public observer has no
permitted identity channel. The live identity map is not exported in the
initial architecture.

Artifact, conversation, and event identifiers used by public references are
stable opaque identifiers assigned once and scoped by their publisher. Actor
pseudonymization must not reissue or reinterpret content identifiers.

## Documentation and Λ

Closure events and typed dependency edges are evidence from which Λ may be
interpreted; they are not themselves concepts or a complete content theory.
Λ distinguishes conversations, output artifacts, concept identities, and
documentation versions.

Dependency edges remain directed. Comparison claims are separately proposed,
challenged, accepted, or withdrawn. Each documentation version records which
comparisons it admits and constructs its current language presentation from
that set. Only admitted comparisons may become identifications; no global
groupoid completion is assumed. A withdrawal creates a later version and does
not rewrite the history of the earlier admission.

Identification, coherence, and purpose-relative compression are
responsibilities within Λ. Compression is adequate only when every designated
observation descends through it. Locators such as engineering and biology are
contexts inside a language, not automatically Federation peers.

## Constrained mathematical correspondence

This correspondence guides definitions and tests; it is not a second
conformance layer. An entry in the final column becomes a theorem only after
the indicated interpretation and comparison maps have been constructed. Here
an **actor-causal frame** is Hoapa's local structure of actors, events,
incidence, and causal order, not a frame in locale theory.

| In the architecture | What carries it | Candidate mathematical reading |
| --- | --- | --- |
| Seat and occupant | An actor incident to a conversation frame under a role specified independently of identity | An eigenvariable-like genericity discipline: no privileged fact about the occupant is assumed; this is not universal quantification over people |
| Event contribution | Recorded content and provenance at one event | A point-local datum once a content interpretation has been defined |
| Conversation | An episode with a local frame, causal history, closure, and output or failure | It may yield a matching family under a content semantics; the episode is not itself that family |
| Conversation in a run | The conversation-frame embedding into the realized run | Structural local-to-global placement; it becomes a semantic probe of a context only through an additional interpretation |
| Eventwise reconstruction | The point-generated reflector over incident event-points | A candidate reading of contributions collected in isolation |
| Deliberative integration | The recorded episode, its content, and its output artifact | Full actor-causal descent is a candidate when a concrete Λ semantics exhibits overlap data that pointwise reconstruction loses |
| Successful closure | A terminal success event naming an artifact, with unanimity required at the interface | Amalgamation only if a protocol-to-compatibility theorem has been proved |
| Failure closure | A terminal failure event naming a failure record | It may record disagreement, rejection, obstruction, or absence of an admissible result; no single failure equation is assumed |
| Output determinacy | The published artifact and its declared observations | Separatedness may express local determinacy under a chosen semantics; it is not the whole of accountability |
| Documented context | A versioned Λ presentation | Realization from conversational probes, and reconstruction as their colimit, are conditional on a constructed probe functor and a density theorem |
| Participant transformation | Deliberation may affect people, but person-state lies outside the trusted representation | Later documentation and available continuations may change without representing a decomposition of the person |

The represented object in this correspondence is the documented subject or
context, never the participant. Participants instantiate the conditions under
which documentation is produced without becoming objects reconstructed from
that documentation.

## Federation

Federation is an open network of independently maintained conversation graphs
and documentation versions. A peer imports a finite, explicitly versioned
publication bundle and retains the snapshot it interpreted. A bundle is
complete relative to its declared import boundary; it need not recursively
contain the network's whole ancestry.

Peers may admit different comparisons, translations, withdrawals, and
protocol versions. Exchange therefore requires scoped stable identifiers,
explicit translations, pinned versions, and provenance of origin. It does not
impose a global actor directory, language quotient, clock, consensus, or
mandatory update. Local adoption and later reconciliation remain explicit
operations, and pre-compression documentation stays addressable whenever an
adequacy claim depends on it.

## Delegated interfaces

The architecture fixes the boundary above while delegating the following to
instance-specific interfaces: panel size, entropy source, turn-taking, silence
policy, the mechanics of candidate formation and assent, all-or-nothing AI
pairing, resolution of concurrent edits, and the concrete transport used
between federated peers. Those policies may vary without changing the trusted
actor ontology, the append-only publication model, or the unanimity
requirement for successful resolution.
