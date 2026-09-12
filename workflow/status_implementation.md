# Implementation Status

This file is the canonical workflow home for the implementation track: the runtime, the checker boundary, and the formal runtime contract.

The current method is **rising sea**: raise the waterline only when the next
executable/testable boundary is forced by the existing formal substrate. The
first waterline crossed the narrow v0 trace/run contract and schema-faithful
recorder. The next program is selected: first a minimal 3R kernel must earn one
causal parent from message behavior; then 2S evolves the contract toward
closure, references, publication, and relative no-leak; the full assembly and
Λ/Federation interpretations follow. Tier A remains banked at raw uniform
actor relabeling and is not yet a publication theorem.

## Directory Consensus

The project should not use implementation-language names as top-level folder names.

Settled top-level shape:

```text
/formal        checked mathematical / formal layer
/runtime       executable system and runtime infrastructure
/communication public and presentation material
/workflow      agent/project state
/pedagogy      explanations of the formal layer
```

The two main legs should **not mirror each other**. They meet at a shared contract, but decompose along different axes:

- `/formal` is organized by mathematical/formal structure: `ModalHoTT`, `Concurrency`, `RuntimeContract`, etc.
- `/runtime` is organized by executable responsibilities: core OTP domain, contract codecs, checker adapter, persistence, web edge, and native/runtime adapters.

`/formal/RuntimeContract/` is the formal home for the Agda code that validates runtime traces. This supersedes the older `Concurrency/Protocol/` reservation. The name is deliberately role-based: it is the contract that `/runtime` must emit evidence for, not a new mathematical protocol layer.

There should be no top-level `/contract` authority for now. The useful serialization material belongs under the formal contract:

```text
/formal/RuntimeContract/
  Trace.agda
  Serialization/
    schema.md
    schema.json
    fixtures/
      valid/
      invalid-schema/
      invalid-semantic/
```

`Trace.agda` owns the meaning. `Serialization/` owns the external JSON representation and regression corpus. Runtime codecs implement that representation; they do not redefine the meaning.

Versioning should live in trace data, not in folder or module names at v0. Serialized traces carry `traceFormat : "hoapa.trace/0"`. Folder/module version splits should happen only when multiple live formats must coexist.

Settled runtime skeleton:

```text
/runtime
  apps/
    hoapa_core/      in-memory event recording/export; conversations and scheduling later
    hoapa_contract/  trace/run structs, JSON codecs, schemas, fixtures
    hoapa_checker/   exports traces, calls the formal checker, handles results
    hoapa_store/     durable event storage, persistence adapters, Pijul boundary later
    hoapa_web/       Phoenix UI/API/channels; edge adapter only
  native/            Rustler NIFs only, if/when needed for narrow pure ops
```

`hoapa_*` app names are preferred because umbrella app names are global atoms in Elixir. Phoenix belongs at the edge (`hoapa_web`) and must not own protocol semantics; the OTP core must be runnable without Phoenix.

`runtime/native/` is reserved for the standard Rustler/NIF meaning: Rust compiled into the BEAM, in-process, for narrow pure operations such as canonical encoding or hashing. Pijul should not start there. Pijul belongs under `hoapa_store` behind a supervised port/CLI boundary, because it is persistence/change-graph infrastructure and should not run in-process until the boundary has earned it.

Still unresolved:

- The exact fields and serialization details of `Boundary`, `Audit`, and `Certificate`; `Trace` and `Run` have the minimal v0 shape recorded below, with richer extensions left open.
- The exact format-tag pattern for later serialized records (`hoapa.run/0`, `hoapa.boundary/0`, etc.); the v0 trace uses `traceFormat : "hoapa.trace/0"`.
- The concrete sum encoding for run-local references and federated artifact
  references, and the protocol metadata that fixes the closure/provenance tags.
- The first real cross-disciplinary Λ example and the designated observations
  that must survive its admitted comparison.
- Whether a language presentation is formalized before its runtime computation
  or specified by an adequacy interface to which the runtime must conform. The
  current lean is the latter.
- Whether a live identity-bearing record ever crosses an internal audit
  boundary after v0. It is not exported in v0.
- The exact future checker invocation path: direct Agda typecheck for tiny witnesses, a compiled/extracted checker, or a separate runtime parser that validates emitted runtime traces against Agda-pinned predicates. Loop 1 uses the top-level `Makefile` as the checker boundary; a `hoapa_checker` app remains deferred until a behavioral originator produces events to validate one-by-one. The actor kernel is the current candidate that meets this gate. A fidelity sampler, a deterministic authored scenario originator, and the pass-1 `EventLog` do not.
- The exact Pijul adapter API inside `hoapa_store`; the folder ownership is settled, but the boundary type is not.
- The internal split of `/formal/RuntimeContract/` after `Trace.agda`; start narrow and let `Run`, `Boundary`, `Audit`, and `Certificate` earn separate files.

## Current Rule

Runtime-contract code is now open only at the narrow trace/run boundary forced by the existing structure. The first formal module is `/formal/RuntimeContract/Trace.agda`, not `Concurrency/Protocol/`; generic bridge theorems, certificates, audit records, and richer boundary objects still have to earn their own files.

Do not use `Snapshot.agda` as a code name. "Snapshot" was a temporary prose word for an infancy-stage protocol state, not a project term. Current role names should be chosen from the contract shape itself: `Trace.agda`, `Run.agda`, `Boundary.agda`, `Audit.agda`, and `Certificate.agda`.

The first trusted checker validates full finite traces before compact certificates. Certificates come later, after the trace predicate and emitted runtime evidence are explicit.

The implementation may know operational identities, network addresses, runtime keys, and other messy facts. The trusted kernel should not. Trusted records should use erased or opaque tokens and should not refine actor identity.

## Runtime Split

- **Runtime (`/runtime`):** actors, supervision, message routing, durable event storage, synthetic large-scale stubs, operator-facing behavior.
- **Formal contract (`/formal/RuntimeContract/`):** finite trace well-formedness, local-view restriction, session compatibility, no-leak/audit predicates, and boundary discipline.
- **Checker:** validates traces, and later certificates, emitted by the runtime against Agda-pinned predicates.
- **Pijul-shaped persistence:** stores document/protocol changes, dependencies, conflicts, resolutions, and partial views where that representation fits. Do not hard-couple the first runtime to Pijul internals.

The at-scale stub belongs in the runtime: thousands of participants, many content tags, and sibling protocols can be generated in Elixir. Formal examples should stay tiny and proof-facing.

## Durable Decisions From The Implementation Discussion

- Reuse existing vocabulary. Do not invent a parallel data model when the actor-causal site, finite-frame layer, session syntax, or presheaf machinery already supplies the noun.
- Anchor the first contract on the stable substrate: opaque actors, Lamport causal events, local frames and finite frames/covers, strict `FrameHom`s, and postulate-free `SessionType` / `SessionHom` syntax.
- Parameterize over moving parts instead of baking them into the contract: `session-O1-action`, Chu closed/evaluation structure, the cross-site `Allow ⊣ Require` adjunction, `MO_1`, the full Reality boundary, and the eventual content category Λ.
- Keep scale outside Agda. Large synthetic runs belong to the Elixir generator; Agda should receive tiny finite examples that exercise the same contract shape.
- Start with full trace/run validation. Compact certificates are a later optimization once the accepted trace predicate is explicit.
- Keep content opaque in v0. The current lean is an opaque content tag plus provenance fields from day one, with Chu-valued or Λ-valued content deferred.
- Do not extract the app from Agda. The runtime emits structured records; the checker validates them against Agda-pinned predicates.
- Keep serialization artifacts under `/formal/RuntimeContract/Serialization/`; do not add a top-level `/contract` authority unless it is later generated/exported from the formal contract.
- Carry trace format versioning as data inside serialized traces. Do not introduce `trace_v0` folders or versioned modules until multiple live formats must coexist.
- Use an Elixir umbrella for the runtime. The compile-time wall is worth the ceremony because `hoapa_core` must not depend on web, persistence, or checker details.
- Keep Phoenix as an edge adapter. The protocol core must run without Phoenix.
- Keep Pijul under `hoapa_store` behind a supervised port/CLI boundary. Use `runtime/native/` only for genuine Rustler NIFs.
- Apply the independent actor-registration decision recorded in `status_formal.md`; the `actorsCoveredByConversations?` condition is downstream, not part of `WellFormed` and not a runtime check.
- Keep `Hoapa.Core.EventLog` an in-memory recorder and reserve `hoapa_store` for durable event storage and persistence. See `bias_correction.md` for the recorder/checker anti-default and `naming.md` for the noun boundary.
- Keep the vendored-corpus layout owned by `Hoapa.Contract.Corpus`. It exposes path helpers only; formal validity remains outside its API.
- Keep the eligible population and entropy source outside the trace. A run
  records only registered handles; panel selection is an injected dependency.
- Keep session tags immutable. A protocol change creates a later conversation
  or version; it does not rewrite the history of a closed conversation.
- Keep public actor handles and public content identity separate. Closure uses
  fresh handles per conversation and does not export the live identity map;
  artifact, conversation, and event identifiers remain stable and
  publisher-scoped for Federation.
- Keep publication bundles finite and versioned, complete relative to an
  explicit import boundary. No runtime component may assume a global actor
  directory, clock, language quotient, or complete network history.

## Minimal Trace/Run Contract — banked v0

This is the prose waterline that made `/formal/RuntimeContract/Trace.agda` forced enough to open. It remains intentionally small: it fixes the serializable nouns and first predicates, not the future runtime architecture.

The v0 checked artifact is a finite exported `Run` containing one finite `Trace`. A `Run` is the release/test boundary: it identifies one exported runtime execution and carries the trace-format tag. A `Trace` is the checker-facing body: actors, conversations/local views, events, causal parents, session tags, content tags, and provenance tokens.

The raw serialized layer is first-order data only. It must contain no proofs, functions, live process handles, database identity, network address, person identity, Pijul internals, or semantic payload body. It may contain meaningless finite IDs and opaque tags, because decidable validation needs concrete names at the serialization boundary.

Minimal v0 `Run` fields:

- `traceFormat`: the literal format tag, v0 value `hoapa.trace/0`.
- `runId`: opaque ID for the exported run.
- `protocolId`: opaque ID for the emitting protocol.
- `siblingProtocolIds`: zero or more opaque sibling protocol IDs.
- `trace`: the finite trace body.

Minimal v0 `Trace` fields:

- `actorIds`: finite list of opaque actor IDs.
- `conversations`: finite list of conversation/local-view records.
- `events`: finite list of event records.

Minimal v0 conversation fields:

- `conversationId`: opaque conversation ID.
- `actorIds`: actors present in this local view.
- `sessionTag`: opaque reference to the session shape assigned to the conversation.

Minimal v0 event fields:

- `eventId`: opaque event ID.
- `conversationId`: the conversation/local view containing the event.
- `touches`: actor IDs touched by the event.
- `causalParents`: event IDs that must occur before this event.
- `contentTag`: opaque content tag; not a payload body and not the future Chu/Λ semantics.
- `provenanceToken`: opaque provenance token; not a positive provenance circuit yet.

Minimal v0 `WellFormed` checks:

- `traceFormat` is recognized.
- IDs are unique inside their namespace where uniqueness is required: actors, conversations, and events. The `runId` identifies the enclosing run.
- Every reference resolves: event conversations exist, touched actors exist, conversation actors exist in the trace, event touched actors belong to that event conversation, causal parents exist, and sibling protocol IDs are just recorded as opaque IDs.
- Causal parents point backward by event-list position: every causal parent must appear at a strictly earlier index in `events`, independent of the numeric ID assigned to either event. Parent edges are global and may cross conversation boundaries; there is no same-conversation clause. This gives the first decidable, renaming-invariant non-retroactivity discipline without requiring a full event-structure theory.
- Actor coverage is deliberately not a `WellFormed` clause. Registered-but-inactive actors are legal; the separate predicate is `actorsCoveredByConversations?`, and `fixtures/valid/uncovered_actor.json` is the accepted-but-uncovered run that keeps the two apart (see the decision log in `status_formal.md`).
- Every conversation has a session tag, and every event has content and provenance tags. If those fields are mandatory in the raw record, this is a schema/constructor obligation rather than an additional semantic check; either way, their internals are deliberately opaque in v0.
- The checked kernel does not refine actor identity from content, provenance, network, storage, or runtime identity. Rich no-leak theorems are later; v0 enforces the structural boundary by excluding those fields from the raw trace.

Fixture categories are part of the conformance suite:

- `valid/`: JSON decodes and `WellFormed` returns yes.
- `invalid-schema/`: JSON does not decode as a raw run/trace, so `WellFormed` is not reached.
- `invalid-semantic/`: JSON decodes as raw data, but `WellFormed` returns no.

Generated Agda files may contain raw run/trace terms generated from fixtures, but not proofs. Hand-authored Agda test modules assert acceptance or rejection of those generated terms. The runtime consumes only the exported contract artifact under `hoapa_contract/priv/runtime_contract/`; it must not read `../../formal` during tests.

## Selected contract v1 — not implemented

The next schema/validator revision gives conversations a lifecycle and gives
published content a referential interface. It is one coordinated contract
change, but it must be landed through focused red-green obligations rather than
as a bulk schema rewrite.

- `sessionTag` remains immutable and determines the homogeneous conversation
  kind. The contract records the tag; the session layer supplies the mapping
  from a tag to participant-facing or content-facing positions.
- Provenance becomes a small tagged interface capable of distinguishing
  ordinary derivation edges from the unique success/failure closure event.
  Response, deepening, and correction are candidate edge kinds; their final
  enumeration is a protocol parameter, not a universal ontology.
- Content becomes an explicit sum retaining an opaque documented-content case
  alongside references. An in-run reference must resolve inside the run. A
  federated artifact reference carries publisher scope, stable artifact
  identity, documentation/protocol version, and an import handle; it is checked
  relative to a finite pinned import environment rather than pretended to
  resolve inside the current run.
- A valid live prefix has at most one closure event per conversation and no
  event of that conversation after closure. A published closed run strengthens
  this to exactly one closure for every exported conversation. Keeping these
  predicates separate permits incremental checking without accepting an open
  prefix as a completed publication.
- Success closure names an output artifact. Failure closure names a failure
  record that may be referenced by a later attempt. Assent, candidate
  selection, and silence policy stay outside the shape checker.
- Public artifact, conversation, and event identifiers are stable,
  publisher-scoped names assigned once. They are not reissued by the closure
  transform. Actor handles are a separate identity channel.

The first retained red fixtures reject a second closure, an event after
closure, and a dangling in-run reference. A positive pair accepts one closed
success and one closed failure that is referenced by a resubmission. A later
Federation fixture checks external resolution relative to two explicit import
environments.

### Closure transform and no-leak consumer

The live-to-public transform is the first concrete consumer of the no-leak
ladder. It replaces participant handles freshly per conversation, omits
authorship and the live identity map, retains the public participant count,
and preserves outputs, stable content identifiers, provenance, references,
and directed dependency edges. It never rewrites concept or artifact
references merely because their IDs share the raw numeric representation of an
actor handle.

Tier A proves only uniform raw relabeling. The selected per-conversation
transform instead needs a local theorem over `(conversation, actor)` handles
and Tier B's relative change of actor base. The preserved geometric statement
is per realized conversation frame; the global live frame is intentionally not
reconstructed after cross-conversation actor overlap has been forgotten.
Unlinkability remains an observer-relative runtime obligation about every
retained side channel, not a corollary of injectivity.

## TDD Starting Point

Start at the contract boundary, not the UI.

The first red-green loop starts with one failing conformance expectation and then makes one tiny trace agree across the formal predicate, serialization corpus, generated raw terms, runtime codec, and checker boundary. This is the canonical order for implementation work:

1. Add or change a fixture expectation under `/formal/RuntimeContract/Serialization/fixtures/`.
2. Generate data-only Agda raw terms from semantic fixtures; generated files must contain data only, not proofs or predicates.
3. Check `/formal/RuntimeContract/Tests/All.agda`, where valid fixtures reduce to `true` and semantic-invalid fixtures reduce to `false`.
4. Export the serialization corpus into `/runtime/apps/hoapa_contract/priv/runtime_contract/`; runtime tests consume only that vendored artifact, never `../../formal`.
5. Run `/runtime/apps/hoapa_contract/` codec tests against the vendored corpus: valid and semantic-invalid fixtures decode and round-trip, schema-invalid fixtures fail at decode.
6. Use the top-level `Makefile` as the loop-1 checker boundary: `contract-check`, `contract-fresh`, `formal-test`, and `runtime-test` keep the generated Agda terms, vendored runtime artifact, formal predicate, and runtime codec in sync.

A separate `/runtime/apps/hoapa_checker/` is deferred until a behavioral originator produces events that need to be checked one-by-one against the formal boundary. The pass-1 event log is intentionally only a recorder, and neither fidelity sampling nor authored scenario generation establishes actor behavior, so adding that app now would still duplicate what the top-level orchestration already tests.

This contract/codecs/freshness loop remains the prerequisite for runtime growth. The pass-1 OTP event log was added only after it was green; fidelity sampling, scenario origination, the actor kernel, the Pijul adapter, and Phoenix UI remain behind their distinct later gates. This keeps the Agda-facing record, serialization corpus, and runtime codec from drifting as the implementation expands.

## Contract Loop 1 Status

Loop 1 is closed and green. The contract now has a narrow end-to-end shape:
formal predicate, serialization corpus, generated Agda raw terms, vendored
runtime artifact, runtime codec tests, and drift gates all agree.

Landed:

- `/formal/RuntimeContract/Trace.agda`: substrate-free raw run/trace records plus decidable v0 well-formedness.
- `/formal/RuntimeContract/Serialization/`: authoritative schema/prose, fixture corpus, JSON-to-Agda raw-term generator, and export tool.
- `/formal/RuntimeContract/Generated/Raw/`: generated data-only Agda terms for valid and semantic-invalid fixtures.
- `/formal/RuntimeContract/Tests/All.agda`: aggregate conformance runner for the substrate-free `--safe` raw-contract layer; valid fixtures compute to accepted, semantic-invalid fixtures compute to rejected, and the Tier A actor-renaming controls are imported here. Realization-level tests import the guarded actor-causal substrate and remain wired separately through the Makefile.
- `/formal/RuntimeContract/Realization/TinyTrace.agda`: concrete tiny-trace realization witness into the existing actor-causal substrate. This is not the generic bridge theorem.
- `/formal/RuntimeContract/TraceLookup.agda`: safe shared raw-trace layer, moved out of `Realization/` because nothing in it is about realization and substrate-free consumers were importing downward. It owns lookup of the record carried by an event id (`firstEvent`), the membership lemmas (`eqℕ-refl`, `eqℕ-sym`, `eqℕ-sound`, `⊆?-mem`, `allB-firstEvent`), and the named clause-peeling lemmas (`wellFormed-eventsOK`, `wellFormed-backwardOK`, `eventOK-conversation`, `eventOK-touches`). It is the sole downstream proof-consumer module that depends on the positional nesting of `valid?` and `eventOK`, so reordering a validator clause breaks it and not the realization modules.
- `/formal/RuntimeContract/Realization/BackwardRank.agda`: safe trace-level proof that a causal-parent edge strictly decreases first-occurrence event rank under `backwardOK`. This is the hard acyclicity lemma used by the generic realization rung; it now retains only rank-specific machinery and consumes `TraceLookup` for lookup and membership.
- `/formal/RuntimeContract/Realization/CausalFromParents.agda`: first generic runtime-to-substrate rung. It derives a `CausalOrder` from backward parent edges and packages any well-formed run as one global `LocalFrame` over realized actor/event carriers. This module alone still constructs only the global frame, with `ActorIn ≡ Unit`; per-conversation frames are supplied downstream by `ConversationLocality.agda`. Session assignment and realized-frame renaming invariance remain later work.
- `/formal/RuntimeContract/Realization/ConversationLocality.agda`: second generic runtime-to-substrate rung, and the per-conversation locality package. `RConversation` indexes the conversations actually present in a run; `conversationFrame` realizes each as its own `LocalFrame`, with events refined to that conversation, actors taken from its own actor list, and incidence inherited from the global frame; `conversationEmbed` constructs the `FrameHom` into the global frame. The local causal order is the global derived order restricted along the first projection, recorded as the definitional equation `local-order-is-global-restriction`; preservation and reflection are therefore both the identity. The one substantive proof is `touches-in-frame`, which discharges through `eventOK`'s touches-⊆-conversation-actors clause. This rung does not package a `Cover`, does not assign session tags, and does not prove renaming invariance.
- `/formal/RuntimeContract/ActorRenaming.agda`: substrate-free `--safe` Tier A, banked at `5670658`. Generic `ActorEmbedding A B` and `ActorIsomorphism A B` provide arrow vocabulary; the current raw action remains the one-object `ActorId = ℕ` instance. `renameActors` respects identity and composition for arbitrary maps, `valid?` is exactly invariant under total injective endomaps for every raw run, and the permutation/gauge layer inherits `WellFormed` invariance and both named transports. No category or realized change of actor base is constructed.
- `/formal/RuntimeContract/Tests/ActorRenaming.agda`: non-vacuity and boundary controls. Collapsing maps are rejected, including a focused collapse that breaks trace-actor distinctness while conversation/touch clauses pass; `suc` exercises an accepted non-surjective embedding; a transposition moves the actor list and remains accepted; and `WellFormed` transport is exercised at the fixture.
- `/runtime/apps/hoapa_contract/`: minimal Elixir umbrella app with precise contract struct typespecs, camelCase JSON codec, vendored contract artifact under `priv/runtime_contract/`, the public path-only `Hoapa.Contract.Corpus` helper, round-trip tests, fixture-category tests, manifest integrity tests, and the tiny-run construction seam corpus-locked to `fixtures/valid/tiny_trace.json` by decoded-struct equality.
- Top-level `Makefile`: cross-leg conductor for regeneration, freshness, formal tests, and runtime tests.

Verified locally:

- `make contract-check` regenerates raw Agda terms and reports no drift.
- `make contract-fresh` re-exports the runtime artifact and reports no drift.
- `make formal-test` checks `RuntimeContract/Tests/All.agda`—which now reaches `ActorRenaming.agda` and its substrate-free test transitively—plus `RuntimeContract/Realization/TinyTrace.agda`, `RuntimeContract/TraceLookup.agda`, `RuntimeContract/Realization/BackwardRank.agda`, `RuntimeContract/Realization/CausalFromParents.agda`, `RuntimeContract/Realization/ConversationLocality.agda`, `RuntimeContract/ConversationActorCoverage.agda`, `RuntimeContract/Realization/ConversationCover.agda`, `RuntimeContract/Realization/ConversationOrderComparison.agda`, and `RuntimeContract/Tests/ConversationOrderComparison.agda` from the `formal/` include root.
- `make runtime-test` runs 7 `hoapa_contract` codec/conformance tests and 12 `hoapa_core` event-log tests against the vendored `priv/` artifact.
- `make test` runs all of the above and passes.

Banked observations:

- Trace-format Option B is implemented: the JSON schema accepts any string, while `valid?` rejects unsupported formats via the semantic-invalid `wrong_trace_format` fixture.
- Runtime build/dependency/crash artifacts are ignored, so the contract gates report meaningful drift.
- The rank/antisymmetry proof in `BackwardRank.agda` uses the `backwardOK` scan, not global event-ID distinctness. Event-ID distinctness still matters for faithful realization of event records as event-ID-generated objects.
- Total injectivity is the exact raw-validator hypothesis: list-local bijectivity cannot control undeclared identifiers in malformed runs, while an inverse is unnecessary for the direct Boolean proof. The recorded bijective target is satisfied by the permutation specialization.
- Tier A has no identity-sensitive falsifier inside `valid?`; its tests are degeneracy controls. It proves acceptance invariance, not that runtime-visible actor tokens cannot expose operational identity.

## 3R Event-Log Pass 1 Status

Pass 1 is banked in `80060ad`. `/runtime/apps/hoapa_core/` contains one unnamed
`Hoapa.Core.EventLog` GenServer. Actors, conversations, and events are recorded
in independent ordered accumulators through synchronous calls; export restores
the server's processing order and returns a `%Hoapa.Contract.Run{}`. The log
does not originate events or judge semantic validity.

Evidence:

- A running log reproduces the corpus-accepted tiny run through literal
  recording calls and remains stable under codec round-trip.
- Every schema-decodable fixture in `valid/` and `invalid-semantic/` is decoded,
  replayed through a fresh log, and compared by exact struct equality. Wildcard
  enumeration meant the cross-conversation and uncovered-actor fixtures, added
  later, exercised the log with no runtime code or test change — 7 contract and
  12 core tests green.
- A deliberately invalid fidelity run distinguishes event sorting from
  conversation grouping and checks repeated actors, repeated conversations,
  an independently registered actor in no conversation, cross-conversation
  parents, and a dangling parent.
- Run-metadata tests cover the `trace_format` and `sibling_protocol_ids`
  defaults, preserve caller-supplied sibling IDs, and copy an opaque format
  string without inspecting it.
- The fidelity, corpus-replay, and metadata tests arrived green against the
  minimal recorder and were then mutation-checked: sorting, grouping, each of
  the three deduplication cases, actor derivation from conversations, and
  dropping unknown parents each make a retained assertion fail. Only the two
  hand-built tiny-run tests were genuinely red before `EventLog` existed.
- The full `make test` gate passed with no formal, fixture, generator, or
  Makefile change.

This remains recorder behavior, not actor execution or protocol behavior. In
particular, it does not satisfy the gate for a separate checker app.

Deferred by design:

- The no-leak ladder beyond raw Tier A: change of actor base and realized-frame renaming equivalence; optional valid-reordering invariance and SIP/univalence capstone; and observational audit/provenance no-leak. Per-conversation realized frames and `FrameHom`s are no longer on this list — they landed as the 2S locality rung.
- A real `hoapa_checker` app that checks traces originated by runtime behavior one-by-one.
- Fidelity sampling and scenario origination at scale, Pijul-backed durable storage, Phoenix/UI, compact certificates, and audit/provenance semantics beyond opaque tokens.

## Verification Commands

Use these as the implementation-track smoke tests:

- `make contract-regen`: regenerate data-only Agda terms from semantic fixtures.
- `make contract-check`: regenerate and fail on generated-term drift or orphans via `git status --porcelain -- formal/RuntimeContract/Generated`.
- `make contract-export`: copy the formal serialization corpus into `runtime/apps/hoapa_contract/priv/runtime_contract/` and write the per-file hash manifest.
- `make contract-fresh`: re-export and fail if the vendored runtime artifact is stale.
- `make formal-test`: run Agda from the `formal/` include root over `RuntimeContract/Tests/All.agda`, `RuntimeContract/Realization/TinyTrace.agda`, `RuntimeContract/TraceLookup.agda`, `RuntimeContract/Realization/BackwardRank.agda`, `RuntimeContract/Realization/CausalFromParents.agda`, `RuntimeContract/Realization/ConversationLocality.agda`, `RuntimeContract/ConversationActorCoverage.agda`, `RuntimeContract/Realization/ConversationCover.agda`, `RuntimeContract/Realization/ConversationOrderComparison.agda`, and `RuntimeContract/Tests/ConversationOrderComparison.agda`.
- `make runtime-test`: run `mix test` inside `/runtime`; tests read only the vendored `priv/` artifact.
- `make test`: run all of the above.

Do not invoke Agda from the repo root as `agda formal/RuntimeContract/Trace.agda`; the module root is `formal/`, so the module path is `RuntimeContract.Trace`.

## Substrate-Readiness Audit

Status legend:

- `G` grounded: existing formal substrate already supplies the noun or invariant.
- `R` reuse with new relation: existing substrate supplies the carrier or law, but the runtime contract must add a relation/predicate.
- `O` opaque-stub-shaped gap: expected gap; future contract should add an opaque token or interface, not a rich theory.
- `B` boundary-facing/candidate: relevant to no-leak, Reality, audit, or implementation boundary; do not force a module yet.

### Contract Nouns

| Noun | Formal home | Exact type / field | Status | Caveat / future relation |
|---|---|---|---|---|
| Actor token | `Sites/ActorBase.agda` | `Actor : Type ℓ`; `Actor-set : isSet Actor` | G | Opaque and unityped by design. No decidable equality or fresh-name allocation in the kernel. |
| Event | `Sites/ActorBase.agda` | `Event : Type ℓE`; `Event-set : isSet Event` | G | Untyped occurrence. Unique event ids are a trace-level relation, not substrate. |
| Causal order | `Sites/ActorBase.agda` | `_≤_`, `≤-refl`, `≤-trans`, `≤-antisym`, `≤-isProp`; derived `Concurrent`, `≤-bidir-equal` | G | Lamport-style non-strict partial order. Conflict, choice, and event-structure refinements are deferred. |
| Conversation / local view (v0) | `Sites/ActorCausal.agda`; `RuntimeContract/Realization/ConversationLocality.agda` | `LocalFrame` with `causal`, `ActorIn`, `touches`, `touches-in-frame`; `RConversation`, `conversationFrame`, `conversationEmbed` | G | `RawConversation` supplies the raw record, `RConversation` indexes present conversations, `conversationFrame` realizes them, and `conversationEmbed` proves valid local-view embedding. Their family is packaged as a `Cover` only conditionally: `conversation-event-covered` is unconditional, while `conversation-cover` assumes `ConversationActorCoverage`, decided by `actorsCoveredByConversations?`. |
| Published artifact interface | none | none | O | A closure may publish an artifact that later conversations reference. This does not turn the completed conversation into an actor or require a new frame-morphism class; the selected v1 contract must first distinguish closure, artifact identity, and references. |
| Event incidence | `Sites/ActorCausal.agda` | `touches`, `touches-isProp`, `touches-in-frame` | G | `touches-in-frame` only says touched actors are in the frame. It does not say every actor is touched. |
| Event support | `Sites/EventSupported.agda` | `EventSupport`, `IsEventSupported`, `ChosenEventSupport` | G | This is the point-generated route's support condition: actor membership is generated by event incidence. |
| Local-view embedding | `Sites/ActorCausal.agda` | `FrameHom`: `actor-pres`, `event-map`, `touches-pres`, `causal-pres`, `causal-refl`; derived `event-map-injective`; alias `_↪_` | G | Strict causality reflection gives sub-view discipline. |
| Session tag ("how") | `Algebras/SessionSyntax.agda`; `Algebras/SessionMorphismSyntax.agda` | `SessionType`, `_^⊥ₛ`, `dual-involutive`, `SessionHom` HIT | G | Postulate-free. Assigning a session tag to a conversation is a new relation. Do not rely on `Sessions.agda` for this boundary; `session-O1-action` remains postulated there. |
| Content tag / payload ("what") | `Algebras/Sessions.agda`; `Hybrid/SessionPresheaf.agda` | `Payload : Type ℓv` parameter | O | Opaque-parametric precedent exists, but a contract-level `ContentTag` or Λ stub is not identical to send/receive payload. The contract still needs its own content-tag relation. |
| Finite event handle | `Sites/FiniteFrame.agda` | `event-count : ℕ`; `enum : Event ≃ Fin event-count` | G | Chosen, untruncated finite event enumeration. |
| Provenance token | none | none | O | Expected opaque token/interface. Trusted provenance should mention artifacts, events, protocol versions, translations, and derivation steps, not persons. |
| Protocol version / federated reference | `Hybrid/Presheaf.agda` header only | future Π / publication-boundary responsibility | O | No `ProtocolId`, version object, external import environment, or Π category exists in code yet. The selected v1 contract separates in-run references from publisher-scoped imported references. |

### Contract Invariants

| Invariant | Formal home | Exact lemma / field | Status | Caveat / future relation |
|---|---|---|---|---|
| Causal acyclicity substrate | `Sites/ActorBase.agda` | `≤-refl`, `≤-trans`, `≤-antisym`, `≤-isProp` | R | The partial order rules prevent order-theoretic two-cycles. "Parents point backward" for a concrete trace is a new trace-level predicate. |
| Unique event ids | `Sites/ActorBase.agda` | `Event-set : isSet Event` | R | Set-truncation is grounded. Uniqueness of events in a finite trace is a contract predicate. |
| Unityped actors | `Sites/ActorBase.agda` | opaque `Actor` carrier plus no constructors / no decidable equality in the kernel | G | Structural no-branching discipline: actor origin is outside the verified kernel. |
| Valid local views | `Sites/ActorCausal.agda` | `FrameHom` | G | The morphism itself is the local-view validity condition. |
| Non-retroactivity-shaped discipline | `Sites/ActorCausal.agda` | `causal-pres` and `causal-refl` | B | Blocks rewriting causal sub-views. Versioned protocol edits still need the future Π layer. |
| Auditability-shaped separatedness | `Hybrid/Presheaf.agda` | `cover-jointly-monic` in `IsSeparatedPresheaf` | B | Compatible local sections determine a global section. Runtime trace auditability still needs event, provenance, and no-leak structure. |
| Cover / gluing substrate | `Sites/ActorCausal.agda`; `Sites/FiniteCover.agda`; `Sites/ActorPullback.agda` | `Cover`, `FiniteCover`, overlap frames, pullback projections, `pb-square`, pullback stability | G | Finite overlaps are actual pullbacks with carried finite enumerations. |

### Boundary-Facing Vocabulary

| Item | Formal home | Status | Caveat |
|---|---|---|---|
| No-leak, raw boundary | `RuntimeContract/ActorRenaming.agda`; `Hybrid/ChangeOfBase.agda`; `Hybrid/LinearNonlinear.agda` | B | Tier A proves exact raw-validator invariance under actor embeddings; `frame-noninterference` proves coefficient change leaves the frame index unchanged. Neither is realized actor-base equivalence or the full theorem that observations/session content do not refine actor identity. |
| Reality boundary | workflow plus `Algebras/Chu.agda` header-level orientation | B | Workflow-grounded, not Agda-grounded. No `Reality` sort or module should be introduced from this alone. |
| Erasure / lossy admission | `Hybrid/Presheaf.agda` header only | O | Named future slot. Lossiness is intentional; it should not become reconstruction of Reality. |

## Findings

The implementation contract is less green-field than it first looked. Actor tokens, events, causal order, local frames, local-view embeddings, finite event handles, session syntax, and point-generated support all already have formal homes.

The gaps are mostly the right kind of gaps: opaque content tags, provenance tokens, protocol versions, sibling references, Reality-boundary requests, and full no-leak theorems. These should enter as small interfaces or predicates only after the contract prose fixes their role.

The current `Payload : Type ℓv` parameter is evidence that the code already accepts opaque content-like parameters, but it is not yet the content layer Λ and should not be treated as the final "what" tag.

Raw validator blindness now exists under total injective actor relabeling, alongside frame-noninterference under coefficient change of base. Realized actor-base equivalence and observational no-leak remain future work; neither existing result is the full semantic theorem.

## Selected contract and runtime work

The following order supersedes the recommendations retained below. It separates
the smallest behavioral test from the eventual assembly so that the causal
premise is tested before more formal structure depends on it.

1. **3R minimal causal kernel.** A few in-memory actor processes exchange
   messages carrying the event ID that produced them. A handler records an
   event whose parents are the IDs attached to the messages it actually
   consumed. The event passes through the existing `Hoapa.Core.EventLog` and
   exports through the current contract. Red-first: disabling dependency
   piggybacking changes the exported trace and fails a retained test. No
   closure, selection, persistence, Phoenix, or checker app is required here.
2. **2S contract v1.** Add closure and reference constructors and the separate
   valid-prefix/closed-publication predicates described above. Add fixture
   expectations first, regenerate data-only Agda terms, export the corpus, and
   make every existing freshness/conformance gate green. This work changes
   schema and codecs only as the chosen sum representation requires.
3. **2S publication/no-leak.** Specify the live-to-public transform and its
   public observation; prove conversation-ID renaming invariance where useful,
   then add substrate-native `ActorBaseMap`/isomorphism and `FrameHomOver`
   without changing banked `FrameHom`. Prove local actor pseudonymization and
   each realized conversation-frame comparison. A non-injective actor mapping
   and a transform that rewrites a content reference are retained falsifiers.
4. **2S relative views.** Relate registered, panel, and event-supported views;
   factor a reusable equivalence between membership in a distinct finite list
   and `Fin` of its length; then state base-relative saturation and append-only
   persistence only at their actual hypothesis strength.
5. **3R full assembly.** Add task intake, injected panel selection, bounded
   panel processes, closure, publication, corpus acceptance, and resubmission
   around the minimal causal kernel. Candidate and assent mechanisms, silence,
   panel size, turn-taking, all-or-nothing AI pairing, and entropy remain
   replaceable interfaces. The first incrementally checked behavioral trace
   opens the gate for `hoapa_checker`.
6. **Λ/Federation forcing case.** Before freezing the artifact interface,
   construct two independent peers with colliding local identifiers, one pinned
   offline import, different admitted comparisons, and a withdrawal adopted by
   only one peer. Acceptance requires stable scoped references and reproducible
   interpretation relative to each declared import boundary; convergence is
   not required.

`make test` remains the definition of green for each implemented batch.

## Superseded recommendations — retained for rationale

The next work splits by the number+letter lane convention: 1C pure conjecture, 2S runtime-to-substrate, and 3R runtime. This file is the canonical home for 2S/3R contract-boundary status; `workflow/status_formal.md` owns broader formal state.

**2S - runtime-to-substrate.**

1. Banked: per-conversation local frames realized from raw conversations, `FrameHom`s into the global frame built by `CausalFromParents.agda`, and the preservation/reflection obligations discharged. The local causal order is the global derived order restricted to the conversation's events rather than a separately invented intra-conversation order, which is what makes strict reflection available; it is recorded as `local-order-is-global-restriction`.
2. Banked formal pass A: `conversation-event-covered` proves unconditional event coverage of the global frame; `actorsCoveredByConversations?` and its realized counterpart `ConversationActorCoverage` are related in BOTH directions (`coverage-sound`, `coverage-complete`), so the Boolean decides the hypothesis rather than merely certifying it; `conversation-cover` builds the `Cover` under that explicit hypothesis; and `parent-edge-implies-causal` is public without exposing the private chain type.
3. Banked formal pass B: the authoritative valid `c0 → c1 → c0` fixture and `ConversationOrderComparison.agda` for causal saturation and the rigidity characterization. The fixture supplied the evidence the locality rung was missing — two events in one conversation related through a causal path in another — and `c0-restricted-sees-external-path` names a term of the selected order on exactly that pair.
4. Banked Tier A at `5670658`: actor relabeling is functorial under arbitrary total maps; raw `valid?` is exactly invariant under total injective endomaps of `ActorId = ℕ`; permutations give the invertible gauge specialization and both `WellFormed` transports. The theorem covers every raw run but only the actor channel.
5. If 2S is selected next, Tier B starts with change of actor base. `RActor` is run-specific while `FrameHom` fixes one actor base and has no actor map, so the realized equivalence is currently inexpressible. Add a relative morphism over an actor-base map while leaving fixed-base `FrameHom` intact; then make realization equivariant. The generic arrow vocabulary in `ActorRenaming.agda` is a down-payment, not yet a category.
6. Session-tag assignment is unlocked but deferred. `LocalFrame` contains no session content by design, so this is a new relation or decorating layer over the realized frames, not a new field on them, and it should carry its own transport/invariance lemma rather than being folded into the core renaming theorem.

**3R — banked runtime state and selected continuation.**

1. Banked: reconstruct the Agda-accepted tiny run from `hoapa_contract` structs, corpus-locked by decoded-struct equality against `fixtures/valid/tiny_trace.json`, with codec round-trip stability. The supporting refactor added precise struct typespecs and the public path-only `Hoapa.Contract.Corpus`; no semantic checker was added.
2. Banked: the minimal `hoapa_core` event-log/export path described above. It preserves the exact raw shape needed by later formal witnesses, including independent actor registration and global causal-parent references.
3. Banked at recorder-fidelity scope: the authoritative `c0 → c1 → c0` fixture is exported into the vendored corpus and the wildcard replay test exercises it through `EventLog` without a runtime code or test rewrite. A second literal-call transcription would duplicate the fixture's asserted causality and is optional, not a remaining pass-2 obligation.
4. Keep validation corpus-locked to Agda. A runtime semantic checker or `hoapa_checker` earns its own app only once a behavioral originator produces events to validate one-by-one. Of the current candidates, only the actor kernel meets that gate.
5. Keep three runtime notions distinct: a fidelity sampler tests codecs and recorder behavior over arbitrary well-typed values; a scenario originator derives run structure from authored transition logic; an actor kernel derives events and causal parents from actual message behavior. The selected next 3R slice is the smallest actor kernel that earns one parent edge from a consumed message. Full sampling, panel lifecycle, and closure follow around that causal seam.
6. Add `hoapa_store` and its Pijul port/CLI boundary only after behavior and lifecycle worth persisting exist. Add Phoenix/`hoapa_web` last, as an edge adapter over an already-running core.

### Superseded next-step comparison

Tier A was banked and no next lane had been selected when the comparison below
was written. Its arguments explain the selected order above but no longer state
current priority:

- **2S:** construct the change-of-actor-base setting needed to state Tier B, then prove realized global and conversation-frame equivalence under invertible relabeling. Keep `FrameHom` fixed-base and add a relative morphism rather than rewriting banked locality proofs.
- **3R:** hold a design conversation for the actor kernel, the first candidate that would earn causal-parent edges from actual dependencies. A fidelity sampler or deterministic scenario originator is smaller but has a different, explicitly weaker payoff.
- **1C:** pursue O1-in-Chu / `session-O1-action` through earned categorical structure, or open the Reality/Documentation/Chu boundary track.

The checker remains gated on behavioral origination. Session assignment, persistence/Pijul, and Phoenix remain separate later layers.

### Codex

My recommendation is 2S, but as a bounded Tier B1 session: construct semantic change of actor base and use it to prove global realized-frame invariance. Do not attempt all of Tier B,
  per-conversation transport, SIP, or descent in one pass.

  One correction emerged from checking the code. The workflow currently compresses two different bases:

  - Raw name presentations: decidable coordinate systems used by RawRun. ActorEmbedding currently lives here in formal/RuntimeContract/ActorRenaming.agda:100.
  - Semantic actor bases: opaque set-level carriers in formal/Concurrency/Sites/ActorBase.agda:65, deliberately without decidable equality.

  The concurrency substrate must not import RuntimeContract to reuse its arrow record. I recommend defining substrate-native ActorBaseEmbedding/ActorBaseIsomorphism, then relating the raw
  and semantic arrows inside the 2S realization layer. The generic varying-name RawRun category can wait; Tier B does not yet force it.

  A good session target would be:

  > Construct the category-shaped change-of-base interface for semantic ActorBases, add FrameHomOver over an actor-base map while leaving FrameHom unchanged, and prove that a raw actor
  > permutation induces an equivalence between the two global frames realized from a run and its relabeling.

  That gives every abstraction an immediate consumer and makes the gauge reading mathematical: actor bases form the base, frames vary over them, and realized relabeling becomes an
  invertible morphism in the total structure. A transposition on cross_conversation should be the concrete non-identity witness.

  Explicitly defer:

  - Generic RawRun A.
  - The decidable-name presentation category.
  - Per-conversation and cover-level equivariance.
  - Local gauge/descent coherence.
  - SIP/univalence and action-groupoid packaging.

  3R’s actor kernel is the strongest alternative and should probably follow soon: it would be the first source of causality earned from behavior. But Tier B1 wins this session because it
  is the direct consumer that has now forced the categorical infrastructure, and it can bank a precise theorem rather than only a runtime design. 1C remains less attractive by default
  because both available directions still require a broader exploratory commitment.

### Claude

Recommendation: 3R, the minimal actor kernel

  Not for lane balance. Because of where the project's risk is concentrated, and because of a red-first failure that nothing currently catches.

  The argument

  causal_parents is the load-bearing field of the entire contract. backwardOK constrains it, BackwardRank.agda derives rank from it, CausalFromParents.agda builds the global causal order
  out of it, ConversationLocality.agda's restricted order depends on it, and ConversationOrderComparison.agda is a theorem about which pairs it relates. Five banked formal modules stand on
  that one relation.

  And in the system as it exists, every parent edge that has ever existed was typed by a human — in a fixture, in a test literal, or in a decoded fixture pushed back through the recorder.
  Nothing has ever derived one from an actual dependency.

  Here is the sharp form. Ask the project's own question: which check goes red? Suppose the system never derives causality from behavior at all — suppose it is, forever, a very good
  transcription service for hand-authored edges. Which of the 7 contract tests, 12 core tests, or the formal conformance suite fails? None. Every one of them operates on fixtures a person
  wrote. The obligation that would expose the gap does not exist, and by AGENTS.md's standard that means the behavior has never been red.

  That is a different kind of hole from an unproved theorem. An unproved theorem is a known gap with a known cost. This is an unvalidated premise underneath proved theorems, and its cost
  is unknown because nobody has looked. If real message causality turns out to have a shape evParents and backwardOK's list-position reading do not capture, the revision reaches back
  through all five modules — and it gets more expensive with every rung added on top of them. Tier B, Tier C and Tier D each raise that price.

  So the question I'd actually ask is not "what is the next rung?" but "what is the cheapest moment to find out whether the foundation holds?" The answer is now, and it has been getting
  more expensive for several sessions.

  What "minimal" has to mean

  The failure mode is a session that produces a design document and no evidence. So the kernel should be scoped to the smallest thing that closes the gap, and the gap is one sentence wide:
  a parent edge derived from an actual dependency.

  Concretely — a few actors, message send and receive, each handler emitting one event whose parents are the events that produced the messages it consumed. Deterministic, in-memory, no
  supervision tree, no persistence, no Phoenix, no checker app. The bankable minimum is one run in which at least one parent edge exists because a message caused a handler to run, recorded
  through the existing Hoapa.Core.EventLog, exported, and accepted by the corpus boundary.

  And the red-first obligation is nameable in advance, which is the test of whether the session is honestly scoped: mutate the kernel's dependency-tracking and the exported trace must 
  change and a test must fail. If the kernel's test can pass while dependency tracking is broken, it is another replay client wearing a costume and the session did not close the gap.

  The close call, honestly

  Tier B — realized-frame equivalence over a changing actor base — is the strongest alternative and I do not think it is a bad choice. It is more precisely specified than the kernel right
  now, because this session located its blocker in code: ActorCausal.agda:94-98 fixes one ActorBase for all frames and FrameHom carries no actor map, while CausalFromParents.agda:200-205
  builds a run-specific carrier, so the comparison is currently inexpressible rather than merely hard. And it is smaller than it looks, since actor renaming leaves evId, evConv and
  evParents untouched, so the entire event and causal side transports along a path I already proved rather than needing new construction.

  I put it second for one reason: its risk is contained. If the presentation-category setting is wrong, we lose a session and a few records. If the causal-parent premise is wrong, we lose
  part of the 2S tower — and Tier B adds to that tower.

  The decision criterion I would actually use: if you believe the contract's causality model is obviously right, take Tier B, it is the tidier session. If you are not certain it is right, 
  take the kernel, because its cost rises every time we don't. I am not certain, and the fact that nothing in the system has ever tested it is why.

  One cost of choosing the kernel that I should name rather than hide: the two-carrier ActorEmbedding A B I argued for this session stays unexercised for another session, and an
  unexercised generalization is a debt by the project's own rule. It is a small and clearly recorded debt, but it is real, and it is the strongest thing on Tier B's side of the ledger
  after specification.

  A standing observation, not a recommendation

  Worth saying because it is the kind of thing that goes unsaid until it is expensive: the concurrency side K is now far ahead of the modal side M, and the project's central claim is a 
  relation between them. M — the modal-context category — does not exist. Without it there is no Allow, no Require, no unit, no counit, no T1. ModalHoTT has been paused since the de Rham
  named-coefficient rung, and every 2S and 3R session widens the gap.

  The recorded reason for the ordering is that the cross-site adjunction should wait until the concurrency-internal adapter and runtime junction are "stable enough to serve as the
  operational side." That is a real reason, but it is worth checking whether it has already been met: the junction now has a global frame, per-conversation frames, embeddings, a
  conditional cover, an order-comparison theorem and a renaming rung. If that is not yet stable enough, it would be useful to write down what would be — because "held loose" with no
  criterion is how the tractable side quietly becomes the whole project.

  I am not proposing M for the next session; opening it is a research move with a high chance of producing scaffolding rather than a result, which is exactly what the project's
  anti-default notes warn against. I am proposing that it acquire a stated trigger rather than remaining indefinitely downstream.

  Defer

  Session-tag assignment, per-conversation and cover-level equivariance, SIP/univalence, local gauge and descent coherence, the generic varying-name construction, hoapa_checker,
  persistence and Pijul, Phoenix. All unchanged, and all still behind their recorded gates.
