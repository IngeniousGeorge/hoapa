---
tags: [focus:architecture, kind:reference, level:scoping]
---

# Participant and information-flow architecture

This file records the intended concrete shape of Hoapa as seen by participants
and by information flow. It is the positive architectural reference for the
runtime contract and the layers built above it. Mathematical interpretations
and implementation status live in their own workflow files.

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
independently of its occupant. In the Lautman-facing interpretation, this
arbitrary occupant is one element that lets a common plan operate, not the
object being decomposed or a coordinate from which persons are reconstructed.
Participants help produce, test, and revise documented articulations. The
record represents specified participation and work, not the participant as a
whole.

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
policy, candidate formation, assent, all-or-nothing AI pairing, resolution of
concurrent edits, and the concrete transport used between federated peers.
Those policies may vary without changing the trusted actor ontology or the
append-only publication model.
