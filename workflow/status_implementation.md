# Implementation Status

This file is the canonical workflow home for the implementation track: the runtime, the checker boundary, and the formal runtime contract.

The current method is **rising sea**: raise the waterline only when the next executable/testable boundary is forced by the existing formal substrate. The first waterline has now crossed the trace/run contract: the formal predicate, serialization corpus, generated Agda terms, runtime codec, tiny-run construction seam, and cross-leg freshness gates exist in narrow v0 form.

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
    hoapa_core/      OTP domain: conversations, events, scheduling
    hoapa_contract/  trace/run structs, JSON codecs, schemas, fixtures
    hoapa_checker/   exports traces, calls the formal checker, handles results
    hoapa_store/     event log, persistence adapters, Pijul boundary later
    hoapa_web/       Phoenix UI/API/channels; edge adapter only
  native/            Rustler NIFs only, if/when needed for narrow pure ops
```

`hoapa_*` app names are preferred because umbrella app names are global atoms in Elixir. Phoenix belongs at the edge (`hoapa_web`) and must not own protocol semantics; the OTP core must be runnable without Phoenix.

`runtime/native/` is reserved for the standard Rustler/NIF meaning: Rust compiled into the BEAM, in-process, for narrow pure operations such as canonical encoding or hashing. Pijul should not start there. Pijul belongs under `hoapa_store` behind a supervised port/CLI boundary, because it is persistence/change-graph infrastructure and should not run in-process until the boundary has earned it.

Still unresolved:

- The exact fields and serialization details of `Boundary`, `Audit`, and `Certificate`; `Trace` and `Run` have the minimal v0 shape recorded below, with richer extensions left open.
- The exact format-tag pattern for later serialized records (`hoapa.run/0`, `hoapa.boundary/0`, etc.); the v0 trace uses `traceFormat : "hoapa.trace/0"`.
- Whether a future synthetic generator becomes its own umbrella app (`hoapa_generator`) or stays test/support code until it earns runtime status.
- The exact future checker invocation path: direct Agda typecheck for tiny witnesses, a compiled/extracted checker, or a separate runtime parser that validates emitted runtime traces against Agda-pinned predicates. Loop 1 uses the top-level `Makefile` as the checker boundary; a `hoapa_checker` app is deferred until there is a real runtime-emitted trace from behavior to feed it.
- The exact Pijul adapter API inside `hoapa_store`; the folder ownership is settled, but the boundary type is not.
- The internal split of `/formal/RuntimeContract/` after `Trace.agda`; start narrow and let `Run`, `Boundary`, `Audit`, and `Certificate` earn separate files.

## Current Rule

Runtime-contract code is now open only at the narrow trace/run boundary forced by the existing structure. The first formal module is `/formal/RuntimeContract/Trace.agda`, not `Concurrency/Protocol/`; generic bridge theorems, certificates, audit records, and richer boundary objects still have to earn their own files.

Do not use `Snapshot.agda` as a code name. "Snapshot" was a temporary prose word for an infancy-stage protocol state, not a project term. Current role names should be chosen from the contract shape itself: `Trace.agda`, `Run.agda`, `Boundary.agda`, `Audit.agda`, and `Certificate.agda`.

The first trusted checker validates full finite traces before compact certificates. Certificates come later, after the trace predicate and emitted runtime evidence are explicit.

The implementation may know operational identities, network addresses, runtime keys, and other messy facts. The trusted kernel should not. Trusted records should use erased or opaque tokens and should not refine actor identity.

## Runtime Split

- **Runtime (`/runtime`):** actors, supervision, message routing, durable event log, synthetic large-scale stubs, operator-facing behavior.
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
- Causal parents point backward by event-list position: every causal parent must appear at a strictly earlier index in `events`, independent of the numeric ID assigned to either event. This gives the first decidable, renaming-invariant non-retroactivity discipline without requiring a full event-structure theory.
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

A separate `/runtime/apps/hoapa_checker/` is deferred until the runtime emits real traces that need to be checked one-by-one against the formal boundary. In loop 1, adding that app would duplicate what the top-level orchestration already tests.

Only after this contract/codecs/freshness loop is clean should the runtime grow a real OTP event log, synthetic generator, Pijul adapter, or Phoenix UI. This keeps the Agda-facing record, serialization corpus, and runtime codec from drifting from the first implementation commit.

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
- `/formal/RuntimeContract/Realization/BackwardRank.agda`: safe trace-level proof that a causal-parent edge strictly decreases first-occurrence event rank under `backwardOK`. This is the hard acyclicity lemma used by the generic realization rung.
- `/formal/RuntimeContract/Realization/CausalFromParents.agda`: first generic runtime-to-substrate rung. It derives a `CausalOrder` from backward parent edges and packages any well-formed run as one global `LocalFrame` over realized actor/event carriers. Per-conversation locality, `FrameHom`s, session assignment, and renaming invariance remain later work.
- `/runtime/apps/hoapa_contract/`: minimal Elixir umbrella app with precise contract struct typespecs, camelCase JSON codec, vendored contract artifact under `priv/runtime_contract/`, a test-only corpus path helper, round-trip tests, fixture-category tests, manifest integrity tests, and the tiny-run construction seam corpus-locked to `fixtures/valid/tiny_trace.json` by decoded-struct equality.
- Top-level `Makefile`: cross-leg conductor for regeneration, freshness, formal tests, and runtime tests.

Verified locally:

- `make contract-check` regenerates raw Agda terms and reports no drift.
- `make contract-fresh` re-exports the runtime artifact and reports no drift.
- `make formal-test` checks `RuntimeContract/Tests/All.agda`, `RuntimeContract/Realization/TinyTrace.agda`, `RuntimeContract/Realization/BackwardRank.agda`, and `RuntimeContract/Realization/CausalFromParents.agda` from the `formal/` include root.
- `make runtime-test` runs the Elixir codec/conformance suite against the vendored `priv/` artifact.
- `make test` runs all of the above and passes.

Banked observations:

- Trace-format Option B is implemented: the JSON schema accepts any string, while `valid?` rejects unsupported formats via the semantic-invalid `wrong_trace_format` fixture.
- Runtime build/dependency/crash artifacts are ignored, so the contract gates report meaningful drift.
- The rank/antisymmetry proof in `BackwardRank.agda` uses the `backwardOK` scan, not global event-ID distinctness. Event-ID distinctness still matters for faithful realization of event records as event-ID-generated objects.

Deferred by design:

- The no-leak ladder beyond the first realization rung: actor-renaming invariance for raw traces; per-conversation realized frames and `FrameHom`s; realized-frame renaming invariance; optional valid-reordering invariance and SIP/univalence capstone.
- A real `hoapa_checker` app that checks runtime-emitted traces from behavior one-by-one.
- Minimal `hoapa_core` event-log/export behavior, synthetic large-run generation, Pijul-backed persistence, Phoenix/UI, compact certificates, and audit/provenance semantics beyond opaque tokens.

## Verification Commands

Use these as the implementation-track smoke tests:

- `make contract-regen`: regenerate data-only Agda terms from semantic fixtures.
- `make contract-check`: regenerate and fail on generated-term drift or orphans via `git status --porcelain -- formal/RuntimeContract/Generated`.
- `make contract-export`: copy the formal serialization corpus into `runtime/apps/hoapa_contract/priv/runtime_contract/` and write the per-file hash manifest.
- `make contract-fresh`: re-export and fail if the vendored runtime artifact is stale.
- `make formal-test`: run Agda from the `formal/` include root over `RuntimeContract/Tests/All.agda`, `RuntimeContract/Realization/TinyTrace.agda`, `RuntimeContract/Realization/BackwardRank.agda`, and `RuntimeContract/Realization/CausalFromParents.agda`.
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
| Conversation / local view | `Sites/ActorCausal.agda` | `LocalFrame` with `causal`, `ActorIn`, `touches`, `touches-in-frame` | R | A local frame is the current stand-in. A promotable first-class conversation object is still a gap; promotion is deliberately not a `FrameHom`. |
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

1. Realize per-conversation local frames from raw conversations.
2. Construct `FrameHom`s from each conversation frame into the global frame built by `CausalFromParents.agda`.
3. Prove these embeddings preserve touches and preserve/reflect the derived causal order. The local causal order should be the global derived order restricted to the conversation events, not a separately invented intra-conversation order.
4. Then return to actor-renaming invariance: raw `valid?` invariance, realized-frame equivalence, and only later SIP/univalence.
5. Add session-tag assignment only after the actor-causal locality bridge is stable; `LocalFrame` itself contains no session content.

**3R - runtime.**

1. Banked: reconstruct the Agda-accepted tiny run from `hoapa_contract` structs, corpus-locked by decoded-struct equality against `fixtures/valid/tiny_trace.json`, with codec round-trip stability. The supporting refactor added a test-only corpus path helper and precise struct typespecs; no production builder or semantic checker was added.
2. Keep validation corpus-locked to Agda. A runtime semantic checker or `hoapa_checker` earns its own app only once there is a real runtime-emitted trace from behavior to validate one-by-one.
3. Add the minimal `hoapa_core` event log/export path only after the 2S per-conversation locality package is stable enough for runtime to echo it.
4. Add a synthetic generator after the event-log export path is green.
5. Add `hoapa_store` and the Pijul port/CLI boundary after the event log exists.
6. Add Phoenix/`hoapa_web` last, as an edge adapter over an already-running core.

Let `Run`, `Boundary`, `Audit`, and `Certificate` earn separate Agda files only when their predicates stop fitting naturally in the current trace/run layer.

## Next step

### Codex

  Bandwidth Recommendation

  I would put the next shared effort on the formal runtime-to-substrate adapter, not on more runtime implementation yet.

  What is at stake: the next runtime step, a minimal hoapa_core event log, will start making real design choices about conversations, events, local views, and export shape. The
  formal side has not yet finished the per-conversation locality package that says exactly how raw conversations sit inside the global frame. If runtime goes first, it may
  accidentally invent semantics the Agda side then has to chase.

  Options:

  Option 1: B-adapter next, per-conversation locality

  Step: realize each raw conversation as a LocalFrame, construct FrameHoms into the global frame from CausalFromParents.agda, and prove touches plus causal preservation/reflection.

  Buys: gives the runtime event log a precise target; advances the no-leak ladder; keeps conversation locality from becoming prose. This is the cleanest next mathematical seam.

  Costs: more Agda work before runtime behavior grows. The implementation lane pauses after a very small green commit.

  Important flag: local causal order should probably be the global derived order restricted to the conversation’s events, not only intra-conversation parent edges. Otherwise strict
  FrameHom reflection can fail if two events in a conversation are related through a cross-conversation causal path.

  Option 2: C-runtime next, minimal hoapa_core event log

  Step: create the smallest runtime event log that can export the same tiny run through hoapa_contract.

  Buys: moves from struct reconstruction to actual runtime behavior. This is the next implementation rung once the seam is banked.

  Costs: opens app/domain design earlier: event append API, conversation state, tag assignment, export semantics. It risks outrunning the formal locality package.

  Option 3: Alternate between both

  Step: formal agent states the expected per-conversation interface while runtime sketches the event-log export surface.

  Buys: keeps momentum in both lanes.

  Costs: coordination overhead and higher risk of premature API shape.

  My recommendation: land this test, update workflow modestly, commit. Then spend the next session on per-conversation LocalFrames and FrameHoms. After that, return to runtime for
  the minimal hoapa_core event log.

### Claude

● Confirmed the load-bearing facts. The contract already guarantees exactly what a per-conversation realization needs: eventOK (Trace.agda:175) forces an event's touches ⊆ its 
  conversation's actors, and convOK (line 167) forces conversation actors ⊆ global actors. And CausalFromParents explicitly collapses locality today — ActorIn ≡ λ _ → Unit, one
  global frame holding everyone (line 209, deferral noted at lines 22–30). That makes the direction question sharp.

  Recommendation: B (the adapter/junction), not C (runtime)

  Bank the emission seam first (it's green, awaiting Codex's workflow note + my commit). Then the natural next bandwidth is B-lane, per-conversation locality — for three grounded
  reasons.

  1. Forced-ness (rising sea). B's next rung reuses carriers that already exist (LocalFrame, FrameHom, the derived global frame) and adds one relation; it's the explicitly named
  immediate frontier in CausalFromParents.agda:22–30. C's next rung — the minimal hoapa_core event log — is not forced by the substrate. The plan phrases it as permission ("add the
  event log only after emission is green"), not compulsion. We just unlocked that permission, but nothing forces us through it. Rising-sea says take the forced boundary, and that's
  B.

  2. Dependency discipline ("A echoes B"). The runtime just echoed B's global-frame rung — the emission seam produces the exact trace CausalFromParents gives meaning to. For the
  runtime to echo again meaningfully, B has to produce the next meaning first. Growing hoapa_core now would be the runtime outrunning the formal side it's supposed to mirror.

  3. Payoff proximity. Per-conversation locality is the direct prerequisite for the no-leak / actor-renaming theorem (T_boundary — "protects humanness by refusing to formalize it").
  That is the mathematically and ethically load-bearing target of this whole leg. C's event log, by contrast, is architecture that doesn't move us toward a theorem. B is where the
  interesting result lives.

  What the step should be

  Replace the collapsed locality with real per-conversation frames and embed them:

  1. Realize each raw conversation as its own LocalFrame over the realized actor/event carriers — ActorIn a ≔ (a ∈ that conversation's actorIds) instead of Unit, events restricted to
  those with matching conversationId. touches-in-frame holds for free from eventOK (touches ⊆ conv actors) — this is why the contract was shaped that way.
  2. Construct a FrameHom from each conversation frame into the global frame from CausalFromParents. Actor-preservation comes from convOK (conv actors ⊆ global actors); the causal
  order on the sub-frame is the restriction of the derived global order.
  3. Prove the embedding preserves touches and preserves+reflects the causal order (FrameHom's strict-reflection requirement). Reflection is the one subtle obligation — restriction
  of a partial order reflects by construction, but it needs care against the globally-derived _≤R_.

  Deferred, named not hidden: session-tag assignment (LocalFrame carries no session content), then actor-renaming/no-leak invariance (the capstone, once locality is stable),
  valid-reordering, SIP/univalence.

  The one scoping choice for the trio

  Whole-package vs. split, following the BackwardRank(hard lemma)/CausalFromParents(assembly) precedent:

  - Split (my lean if reflection proves heavy when I scope it): file 1 = per-conversation LocalFrame realization (carrier + touches-in-frame); file 2 = the FrameHom +
  preserve/reflect proofs. Buys small forced commits and isolates the reflection proof; costs an intermediate sub-frame that's inert until embedded.
  - Whole: one file, subframe + FrameHom + proofs. Buys a rung that's meaningful immediately (the FrameHom is the point); costs a bigger file if reflection balloons.

  I'd scope reflection live and split only if it's heavy — the constructions themselves look short.

  ---
  Net: bank C's emission seam, then move bandwidth to B for per-conversation locality + FrameHoms. That keeps the runtime echoing a formal side that stays one honest step ahead, and
  it's the rung that actually walks toward the no-leak theorem.