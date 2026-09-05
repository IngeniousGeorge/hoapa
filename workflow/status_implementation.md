# Implementation Status

This file is the canonical workflow home for the implementation track: the runtime, the checker boundary, and the formal runtime contract.

The current method is **rising sea**: raise the waterline only when the next executable/testable boundary is forced by the existing formal substrate. The first waterline has crossed the trace/run contract: the formal predicate, serialization corpus, generated Agda terms, runtime codec, tiny-run construction seam, and cross-leg freshness gates exist in narrow v0 form. The first 3R runtime rung is also banked: a running `hoapa_core` event log records caller-supplied contract evidence and exports it as a `Run`, without becoming a checker or an event originator.

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
- Whether a future synthetic generator becomes its own umbrella app (`hoapa_generator`) or stays test/support code until it earns runtime status.
- The exact future checker invocation path: direct Agda typecheck for tiny witnesses, a compiled/extracted checker, or a separate runtime parser that validates emitted runtime traces against Agda-pinned predicates. Loop 1 uses the top-level `Makefile` as the checker boundary; a `hoapa_checker` app remains deferred until an originator — a synthetic generator or actor kernel — produces events from behavior. The pass-1 `EventLog` only records caller-supplied contract values and does not meet that gate.
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
- Apply the independent actor-registration decision recorded in `status_formal.md`; the planned `actorsCovered?` condition is downstream, not part of `WellFormed` and not a runtime check.
- Keep `Hoapa.Core.EventLog` an in-memory recorder and reserve `hoapa_store` for durable event storage and persistence. See `bias_correction.md` for the recorder/checker anti-default and `naming.md` for the noun boundary.
- Keep the vendored-corpus layout owned by `Hoapa.Contract.Corpus`. It exposes path helpers only; formal validity remains outside its API.

## Minimal Trace/Run Contract

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
- Actor coverage is deliberately not a `WellFormed` clause. Registered-but-inactive actors are legal; the planned separate predicate is `actorsCovered?` (see the decision log in `status_formal.md`).
- Every conversation has a session tag, and every event has content and provenance tags. If those fields are mandatory in the raw record, this is a schema/constructor obligation rather than an additional semantic check; either way, their internals are deliberately opaque in v0.
- The checked kernel does not refine actor identity from content, provenance, network, storage, or runtime identity. Rich no-leak theorems are later; v0 enforces the structural boundary by excluding those fields from the raw trace.

Fixture categories are part of the conformance suite:

- `valid/`: JSON decodes and `WellFormed` returns yes.
- `invalid-schema/`: JSON does not decode as a raw run/trace, so `WellFormed` is not reached.
- `invalid-semantic/`: JSON decodes as raw data, but `WellFormed` returns no.

Generated Agda files may contain raw run/trace terms generated from fixtures, but not proofs. Hand-authored Agda test modules assert acceptance or rejection of those generated terms. The runtime consumes only the exported contract artifact under `hoapa_contract/priv/runtime_contract/`; it must not read `../../formal` during tests.

## TDD Starting Point

Start at the contract boundary, not the UI.

The first red-green loop starts with one failing conformance expectation and then makes one tiny trace agree across the formal predicate, serialization corpus, generated raw terms, runtime codec, and checker boundary. This is the canonical order for implementation work:

1. Add or change a fixture expectation under `/formal/RuntimeContract/Serialization/fixtures/`.
2. Generate data-only Agda raw terms from semantic fixtures; generated files must contain data only, not proofs or predicates.
3. Check `/formal/RuntimeContract/Tests/All.agda`, where valid fixtures reduce to `true` and semantic-invalid fixtures reduce to `false`.
4. Export the serialization corpus into `/runtime/apps/hoapa_contract/priv/runtime_contract/`; runtime tests consume only that vendored artifact, never `../../formal`.
5. Run `/runtime/apps/hoapa_contract/` codec tests against the vendored corpus: valid and semantic-invalid fixtures decode and round-trip, schema-invalid fixtures fail at decode.
6. Use the top-level `Makefile` as the loop-1 checker boundary: `contract-check`, `contract-fresh`, `formal-test`, and `runtime-test` keep the generated Agda terms, vendored runtime artifact, formal predicate, and runtime codec in sync.

A separate `/runtime/apps/hoapa_checker/` is deferred until an originator produces events from behavior that need to be checked one-by-one against the formal boundary. The pass-1 event log is intentionally only a recorder, so adding that app now would still duplicate what the top-level orchestration already tests.

This contract/codecs/freshness loop remains the prerequisite for runtime growth. The pass-1 OTP event log was added only after it was green; a synthetic generator, Pijul adapter, and Phoenix UI remain behind their later gates. This keeps the Agda-facing record, serialization corpus, and runtime codec from drifting as the implementation expands.

## Contract Loop 1 Status

Loop 1 is closed and green. The contract now has a narrow end-to-end shape:
formal predicate, serialization corpus, generated Agda raw terms, vendored
runtime artifact, runtime codec tests, and drift gates all agree.

Landed:

- `/formal/RuntimeContract/Trace.agda`: substrate-free raw run/trace records plus decidable v0 well-formedness.
- `/formal/RuntimeContract/Serialization/`: authoritative schema/prose, fixture corpus, JSON-to-Agda raw-term generator, and export tool.
- `/formal/RuntimeContract/Generated/Raw/`: generated data-only Agda terms for valid and semantic-invalid fixtures.
- `/formal/RuntimeContract/Tests/All.agda`: formal conformance runner; valid fixtures compute to accepted and semantic-invalid fixtures compute to rejected.
- `/formal/RuntimeContract/Realization/TinyTrace.agda`: concrete tiny-trace realization witness into the existing actor-causal substrate. This is not the generic bridge theorem.
- `/formal/RuntimeContract/Realization/TraceLookup.agda`: safe shared raw-trace layer. It owns lookup of the record carried by an event id (`firstEvent`), the membership lemmas (`eqℕ-sym`, `eqℕ-sound`, `⊆?-mem`, `allB-firstEvent`), and the named clause-peeling lemmas (`wellFormed-eventsOK`, `wellFormed-backwardOK`, `eventOK-touches`). It is the sole downstream proof-consumer module that depends on the positional nesting of `valid?` and `eventOK`, so reordering a validator clause breaks it and not the realization modules.
- `/formal/RuntimeContract/Realization/BackwardRank.agda`: safe trace-level proof that a causal-parent edge strictly decreases first-occurrence event rank under `backwardOK`. This is the hard acyclicity lemma used by the generic realization rung; it now retains only rank-specific machinery and consumes `TraceLookup` for lookup and membership.
- `/formal/RuntimeContract/Realization/CausalFromParents.agda`: first generic runtime-to-substrate rung. It derives a `CausalOrder` from backward parent edges and packages any well-formed run as one global `LocalFrame` over realized actor/event carriers. This module alone still constructs only the global frame, with `ActorIn ≡ Unit`; per-conversation frames are supplied downstream by `ConversationLocality.agda`. Session assignment and renaming invariance remain later work.
- `/formal/RuntimeContract/Realization/ConversationLocality.agda`: second generic runtime-to-substrate rung, and the per-conversation locality package. `RConversation` indexes the conversations actually present in a run; `conversationFrame` realizes each as its own `LocalFrame`, with events refined to that conversation, actors taken from its own actor list, and incidence inherited from the global frame; `conversationEmbed` constructs the `FrameHom` into the global frame. The local causal order is the global derived order restricted along the first projection, recorded as the definitional equation `local-order-is-global-restriction`; preservation and reflection are therefore both the identity. The one substantive proof is `touches-in-frame`, which discharges through `eventOK`'s touches-⊆-conversation-actors clause. This rung does not package a `Cover`, does not assign session tags, and does not prove renaming invariance.
- `/runtime/apps/hoapa_contract/`: minimal Elixir umbrella app with precise contract struct typespecs, camelCase JSON codec, vendored contract artifact under `priv/runtime_contract/`, the public path-only `Hoapa.Contract.Corpus` helper, round-trip tests, fixture-category tests, manifest integrity tests, and the tiny-run construction seam corpus-locked to `fixtures/valid/tiny_trace.json` by decoded-struct equality.
- Top-level `Makefile`: cross-leg conductor for regeneration, freshness, formal tests, and runtime tests.

Verified locally:

- `make contract-check` regenerates raw Agda terms and reports no drift.
- `make contract-fresh` re-exports the runtime artifact and reports no drift.
- `make formal-test` checks `RuntimeContract/Tests/All.agda`, `RuntimeContract/Realization/TinyTrace.agda`, `RuntimeContract/Realization/TraceLookup.agda`, `RuntimeContract/Realization/BackwardRank.agda`, `RuntimeContract/Realization/CausalFromParents.agda`, and `RuntimeContract/Realization/ConversationLocality.agda` from the `formal/` include root.
- `make runtime-test` runs 7 `hoapa_contract` codec/conformance tests and 12 `hoapa_core` event-log tests against the vendored `priv/` artifact.
- `make test` runs all of the above and passes.

Banked observations:

- Trace-format Option B is implemented: the JSON schema accepts any string, while `valid?` rejects unsupported formats via the semantic-invalid `wrong_trace_format` fixture.
- Runtime build/dependency/crash artifacts are ignored, so the contract gates report meaningful drift.
- The rank/antisymmetry proof in `BackwardRank.agda` uses the `backwardOK` scan, not global event-ID distinctness. Event-ID distinctness still matters for faithful realization of event records as event-ID-generated objects.

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
  enumeration means the forthcoming cross-conversation fixture will exercise
  the log without a runtime test change.
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

- The no-leak ladder beyond the realized frames: actor-renaming invariance for raw traces; realized-frame renaming invariance; optional valid-reordering invariance and SIP/univalence capstone. Per-conversation realized frames and `FrameHom`s are no longer on this list — they landed as the 2S locality rung.
- A real `hoapa_checker` app that checks traces originated by runtime behavior one-by-one.
- Synthetic large-run generation, Pijul-backed durable storage, Phoenix/UI, compact certificates, and audit/provenance semantics beyond opaque tokens.

## Verification Commands

Use these as the implementation-track smoke tests:

- `make contract-regen`: regenerate data-only Agda terms from semantic fixtures.
- `make contract-check`: regenerate and fail on generated-term drift or orphans via `git status --porcelain -- formal/RuntimeContract/Generated`.
- `make contract-export`: copy the formal serialization corpus into `runtime/apps/hoapa_contract/priv/runtime_contract/` and write the per-file hash manifest.
- `make contract-fresh`: re-export and fail if the vendored runtime artifact is stale.
- `make formal-test`: run Agda from the `formal/` include root over `RuntimeContract/Tests/All.agda`, `RuntimeContract/Realization/TinyTrace.agda`, `RuntimeContract/Realization/TraceLookup.agda`, `RuntimeContract/Realization/BackwardRank.agda`, `RuntimeContract/Realization/CausalFromParents.agda`, and `RuntimeContract/Realization/ConversationLocality.agda`.
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
| Conversation / local view (v0) | `Sites/ActorCausal.agda`; `RuntimeContract/Realization/ConversationLocality.agda` | `LocalFrame` with `causal`, `ActorIn`, `touches`, `touches-in-frame`; `RConversation`, `conversationFrame`, `conversationEmbed` | G | `RawConversation` supplies the raw record, `RConversation` indexes present conversations, `conversationFrame` realizes them, and `conversationEmbed` proves valid local-view embedding. Their family is not yet packaged as a `Cover`; the planned conditional construction assumes the separate `actorsCovered?` property recorded in `status_formal.md`. |
| Promotable conversation | none | none | O | A first-class conversation object that can be promoted into an actor-like node remains a gap. Promotion is deliberately not a `FrameHom`; it is a future morphism class, and the v0 local-view realization above does not supply it. |
| Event incidence | `Sites/ActorCausal.agda` | `touches`, `touches-isProp`, `touches-in-frame` | G | `touches-in-frame` only says touched actors are in the frame. It does not say every actor is touched. |
| Event support | `Sites/EventSupported.agda` | `EventSupport`, `IsEventSupported`, `ChosenEventSupport` | G | This is the point-generated route's support condition: actor membership is generated by event incidence. |
| Local-view embedding | `Sites/ActorCausal.agda` | `FrameHom`: `actor-pres`, `event-map`, `touches-pres`, `causal-pres`, `causal-refl`; derived `event-map-injective`; alias `_↪_` | G | Strict causality reflection gives sub-view discipline. |
| Session tag ("how") | `Algebras/SessionSyntax.agda`; `Algebras/SessionMorphismSyntax.agda` | `SessionType`, `_^⊥ₛ`, `dual-involutive`, `SessionHom` HIT | G | Postulate-free. Assigning a session tag to a conversation is a new relation. Do not rely on `Sessions.agda` for this boundary; `session-O1-action` remains postulated there. |
| Content tag / payload ("what") | `Algebras/Sessions.agda`; `Hybrid/SessionPresheaf.agda` | `Payload : Type ℓv` parameter | O | Opaque-parametric precedent exists, but a contract-level `ContentTag` or Λ stub is not identical to send/receive payload. The contract still needs its own content-tag relation. |
| Finite event handle | `Sites/FiniteFrame.agda` | `event-count : ℕ`; `enum : Event ≃ Fin event-count` | G | Chosen, untruncated finite event enumeration. |
| Provenance token | none | none | O | Expected opaque token/interface. Trusted provenance should mention artifacts, events, protocol versions, translations, and derivation steps, not persons. |
| Protocol version / sibling reference | `Hybrid/Presheaf.agda` header only | future Reflexive-Π / Adapter-5 slot | O | No `ProtocolId`, version object, sibling-reference type, or Π category in code yet. |

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
| No-leak, structural half | `Hybrid/ChangeOfBase.agda`; `Hybrid/LinearNonlinear.agda` | B | `frame-noninterference` proves change-of-base leaves the frame index unchanged. The full theorem that session roles/payloads/content do not refine actor identity remains a gap. |
| Reality boundary | workflow plus `Algebras/Chu.agda` header-level orientation | B | Workflow-grounded, not Agda-grounded. No `Reality` sort or module should be introduced from this alone. |
| Erasure / lossy admission | `Hybrid/Presheaf.agda` header only | O | Named future slot. Lossiness is intentional; it should not become reconstruction of Reality. |

## Findings

The implementation contract is less green-field than it first looked. Actor tokens, events, causal order, local frames, local-view embeddings, finite event handles, session syntax, and point-generated support all already have formal homes.

The gaps are mostly the right kind of gaps: opaque content tags, provenance tokens, protocol versions, sibling references, Reality-boundary requests, and full no-leak theorems. These should enter as small interfaces or predicates only after the contract prose fixes their role.

The current `Payload : Type ℓv` parameter is evidence that the code already accepts opaque content-like parameters, but it is not yet the content layer Λ and should not be treated as the final "what" tag.

The structural no-leak half exists as frame-noninterference under change of base. The semantic no-leak theorem remains future work.

## Next Contract Work

The next work splits by the number+letter lane convention: 1C pure conjecture, 2S runtime-to-substrate, and 3R runtime. This file is the canonical home for 2S/3R contract-boundary status; `workflow/status_formal.md` owns broader formal state.

**2S - runtime-to-substrate.**

1. Banked: per-conversation local frames realized from raw conversations, `FrameHom`s into the global frame built by `CausalFromParents.agda`, and the preservation/reflection obligations discharged. The local causal order is the global derived order restricted to the conversation's events rather than a separately invented intra-conversation order, which is what makes strict reflection available; it is recorded as `local-order-is-global-restriction`.
2. Planned formal pass A: prove unconditional event coverage of the global frame; add raw `actorsCovered?`, its realized counterpart, and their soundness relation; construct a `Cover` under that explicit hypothesis; and expose the parent-edge-implies-causal lemma needed downstream. These modules are forthcoming, not landed.
3. Then add the authoritative valid `c0 → c1 → c0` fixture and `ConversationOrderComparison.agda` for causal saturation and the rigidity characterization. The fixture supplies evidence still missing from the locality rung: two events in one conversation related through a causal path in another conversation.
4. Actor-renaming invariance remains the next no-leak rung after this package: raw `valid?` invariance, then realized-frame equivalence, and only later SIP/univalence.
5. Session-tag assignment is unlocked but deferred. `LocalFrame` contains no session content by design, so this is a new relation or decorating layer over the realized frames, not a new field on them, and it should carry its own transport/invariance lemma rather than being folded into the core renaming theorem.

**3R - runtime.**

1. Banked: reconstruct the Agda-accepted tiny run from `hoapa_contract` structs, corpus-locked by decoded-struct equality against `fixtures/valid/tiny_trace.json`, with codec round-trip stability. The supporting refactor added precise struct typespecs and the public path-only `Hoapa.Contract.Corpus`; no semantic checker was added.
2. Banked: the minimal `hoapa_core` event-log/export path described above. It preserves the exact raw shape needed by later formal witnesses, including independent actor registration and global causal-parent references.
3. Pass 2 waits for the authoritative `c0 → c1 → c0` fixture to land in the formal corpus. `make contract-export` will refresh the vendored artifact and manifest; the wildcard corpus-replay test will then exercise that run through `EventLog` without a runtime code or test rewrite.
4. Keep validation corpus-locked to Agda. A runtime semantic checker or `hoapa_checker` earns its own app only once a generator or actor kernel originates events from behavior to validate one-by-one.
5. Add a synthetic generator after the cross-conversation pass is green, then `hoapa_store` and its Pijul port/CLI boundary. Add Phoenix/`hoapa_web` last, as an edge adapter over an already-running core.

## Next step

The locality package and 3R event-log pass 1 are banked. The next dependency
sequence is now explicit rather than a bandwidth choice:

- **2S first:** land the event/actor-coverage package and public parent-edge
  lemma, then the authoritative cross-conversation fixture and order-comparison
  theorem. Do not describe those forthcoming modules as present evidence.
- **3R pass 2:** export that fixture into the vendored runtime corpus and let the
  existing wildcard replay test reproduce it unchanged. This should require no
  `EventLog` rewrite.
- **Afterward:** continue the 2S actor-renaming/no-leak ladder. Session-tag
  assignment remains a separate decorating layer and stays deferred.
- **Runtime breadth remains gated:** an event originator precedes a separate
  checker; synthetic generation, durable storage, Pijul, and Phoenix follow only
  as their boundaries become executable.
