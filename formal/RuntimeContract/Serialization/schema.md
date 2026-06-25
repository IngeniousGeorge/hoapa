# Runtime contract serialization — v0

This directory is the external representation of the runtime contract. The
**meaning** lives in `RuntimeContract/Trace.agda` (`valid?` / `WellFormed`);
this directory only fixes the JSON wire shape, the fixture corpus, and the
wire ↔ Agda mapping policy. Runtime codecs implement this representation; they
do not redefine the meaning.

## Wire shape

`schema.json` is the authoritative JSON Schema. A serialized artifact is a
`Run`:

- `traceFormat` — literal format tag, v0 value `"hoapa.trace/0"`.
- `runId` — opaque ID for the exported run.
- `protocolId` — opaque ID for the emitting protocol.
- `siblingProtocolIds` — zero or more opaque sibling protocol IDs.
- `trace` — the checker-facing body:
  - `actorIds` — opaque actor IDs present in the run.
  - `conversations` — each has `conversationId`, local `actorIds`, `sessionTag`.
  - `events` — each has `eventId`, `conversationId`, `touches`, `causalParents`,
    `contentTag`, `provenanceToken`.

All IDs and tags are strings on the wire. They carry no meaning beyond
identity; only the relational structure matters.

Naming convention: **camelCase on the wire**, regardless of any leg's internal
naming (Elixir structs may use snake_case; the codec maps).

## Wire ID ↔ Agda ℕ mapping policy

`Trace.agda` uses dense `ℕ` per namespace; the generator (`generate_raw_agda.py`)
fixes the mapping deterministically:

- Each **referent namespace** is mapped independently: actors, events,
  conversations, session tags, content tags, provenance tokens, runId,
  protocolId, sibling protocol IDs.
- Within a namespace, the first time a string is encountered (in a fixed
  traversal: run scalars, `trace.actorIds`, conversations in order, events in
  order) it is assigned the next natural, starting at `0`.
- `traceFormat` maps through a small table: `"hoapa.trace/0" ↦ 0`.

Because `valid?` only inspects structure over these naturals, the specific
assignment is irrelevant to well-formedness — this is the renaming-invariance
property the deferred `Realization` layer will prove. The mapping itself does
not need to be exported.

## `WellFormed` v0 (authority: `Trace.agda`)

- `traceFormat` is recognized.
- Every set-representing list is duplicate-free: global `actorIds`,
  conversation IDs, event IDs, sibling protocol IDs, and the local
  `conversation.actorIds`, `event.touches`, `event.causalParents`.
- References resolve: an event's conversation exists; a conversation's actors
  are global actors; an event's touched actors belong to its conversation.
- Causal parents point backward **by list position**: every parent appears
  earlier in the `events` list (a left-to-right scan with a seen-IDs
  accumulator). This is renaming-invariant; it does not use ID magnitude.

`contentTag` / `provenanceToken` / `sessionTag` are checked for presence and
reference shape only; their internals are opaque in v0.

## Fixture categories (the conformance corpus)

- `valid/` — JSON decodes and `WellFormed` returns yes.
- `invalid-schema/` — JSON does not decode as a raw run/trace; `WellFormed` is
  never reached. **No Agda counterpart** (it is a codec-rejection test only).
- `invalid-semantic/` — JSON decodes as raw data, but `WellFormed` returns no.

The generator emits Agda raw terms for `valid/` and `invalid-semantic/` only.
