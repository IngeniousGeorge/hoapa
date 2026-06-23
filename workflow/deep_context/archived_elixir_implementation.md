# Elixir implementation

## Codex review

• I read the workflow top-level files, the numbered arc files, and the relevant Agda modules across Concurrency, Hybrid, Sites, Algebras, and ModalHoTT.

  My current read: the Agda codebase is close to being a serious mathematical scaffold for an Elixir implementation, but not yet a verification program for one. The missing piece is not more
  philosophy or even mainly more sheaf theory; it is a small, finite, trace-checker-facing protocol kernel.

  - Strict sub-view FrameHoms and covers: agda/Concurrency/Sites/ActorCausal.agda:167.
  - Finite frames, finite covers, pullback overlaps, and finite Coverage: agda/Concurrency/Sites/FiniteFrame.agda:54, agda/Concurrency/Sites/FiniteCover.agda:54, agda/Concurrency/Sites/
    FiniteFrameCoverage.agda:91.
  - Session syntax with proved dual involution and a postulate-free morphism HIT; the remaining assumed piece is the O_1 action (`session-O1-action`): agda/Concurrency/Algebras/SessionSyntax.agda, agda/Concurrency/Algebras/SessionMorphismSyntax.agda, agda/Concurrency/Algebras/Sessions.agda.
  - Finite event-product sheaf/descent and a concrete tiny example: agda/Concurrency/Hybrid/FiniteDescent.agda:120, agda/Concurrency/Hybrid/EventProductSheaf.agda:270, agda/Concurrency/Hybrid/
    TinyEventProductExample.agda:138.
  - Modal iteration scaffolding exists, but remains synthetic/postulate-relative: agda/ModalHoTT/Modalities/Iteration.agda:42, agda/ModalHoTT/Modalities/Iteration.agda:92.

  I also verified representative modules:

  - agda Concurrency/Sites/FiniteFrameCoverage.agda: passed.
  - agda Concurrency/Hybrid/TinyEventProductExample.agda: passed with the documented Cubical UnsupportedIndexedMatch warnings.
  - agda ModalHoTT/Modalities/IterationCohesion.agda: passed.

  There are four untracked site-layer files in the checkout: FiniteBasisCover.agda, FiniteFrameCoverage.agda, FiniteFramePullback.agda, and FramePullbackUniversal.agda. I did not edit anything.

  Recommendation

  We should not wait for the full cross-site Allow ⊣ Require, MO_1, Reflexive Π, or Bulk Λ layers before starting Elixir. That would stall implementation behind long-horizon math.

  But we also should not start the “meaningful verified implementation” until Agda has one new layer:

  Concurrency/Protocol/Trace.agda
  Concurrency/Protocol/SessionStep.agda
  Concurrency/Protocol/Restriction.agda
  Concurrency/Protocol/Auditability.agda
  Concurrency/Protocol/Certificate.agda

  The minimum useful Agda kernel should specify:

  1. Finite raw traces: actor ids, event ids, causal parents, local frame membership, session action, payload/document hash.
  2. A WellFormedTrace predicate: causal order is acyclic/respected, event ids are unique, actors remain unityped, local views are valid.
  3. Session step validity: enough syntax-level send/receive/dual endpoint checking to validate runtime messages.
  4. Restriction to local views: trace projection along FrameHom, with functorial laws.
  5. Auditability/no-leak: session roles, payloads, and content do not refine actor identity.
  6. A tiny concrete trace example over the existing two-point finite cover.

  Then Elixir can be meaningful: BEAM runs actors and conversations; it emits immutable typed event logs; Agda specifies what makes those logs valid; a checker validates traces or certificates. I
  would avoid trying to extract the whole app from Agda. The realistic architecture is Elixir runtime plus a small checker whose behavior is pinned to Agda.

  So the practical split is now:

  - Math track: point-generated R4 is landed, with `Chu(SET,Bool)` as a concrete coefficient witness and Sessions-to-Chu `J0`/`J1` as a separate realization; focus on exposition and the next deliberate choice, with full actor-causal reflector enrichment deferred.
  - Implementation track: start the trace-kernel Agda layer once the tiny trace schema is fixed.
  - Elixir track: begin once the trace schema and first Agda well-formedness predicate are stable; do not wait for the cross-site adjunction or long-horizon layers.

› Following the discussion in /arc on Pijul, would it make sense to make our Elixir codebase an extension of Pijul?


• Searching the web

• Searched Pijul official manual libpijul architecture hooks API rust crates

• Searching the web

• Searched https://pijul.org/

• Searching the web

• Searched docs.rs libpijul crate

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

• Yes, but I would phrase it carefully:

  Build the Elixir system as Pijul-compatible / Pijul-shaped, not as a hard extension or fork of Pijul at first.

  Pijul fits the arc unusually well because its native objects are patches with dependencies, commuting independent changes, first-class conflicts, and partial clones. Those match our
  actor-causal/descent picture: local views, explicit dependency structure, conflicts as data, and coherent amalgamation. Pijul’s own docs emphasize independent changes commuting, conflicts as
  ordinary objects solved by later changes, and partial clones driven by dependency structure. Sources: Pijul home (https://pijul.org/), FAQ (https://pijul.org/faq).

  But making the first Elixir codebase an actual Pijul extension would probably over-couple us too early. Pijul is a VCS over file/change structure; our kernel needs typed protocol traces: actors,
  causal events, sessions, provenance, local restriction, checker certificates. Pijul also explicitly does not know language/application semantics; semantic validity remains our checker’s job, not
  Pijul’s. The FAQ says semantic correctness depends on the language/application, not the VCS.

  The pragmatic architecture I’d use:

  1. Elixir owns the runtime. Actors, supervision, message routing, durable event log.
  2. Agda owns the specification. Trace validity, no-leak, restriction, session compatibility, auditability.
  3. A checker owns validation. Elixir emits traces/certificates; checker accepts or rejects.
  4. Pijul becomes the patch/provenance backend or adapter. Conversation edits, protocol edits, document revisions, and conflict resolutions can be represented as Pijul changes where that
     representation fits.
  5. Only later consider libpijul/Rust integration. Direct linking has engineering and license implications; Pijul is GPL2+ and the FAQ says to contact them for commercial use of libpijul.

  So: not “our app is a Pijul plugin.” More like:

  Elixir protocol runtime
    emits typed events / documents / edits
  Agda-specified checker
    validates protocol traces
  Pijul-shaped patch layer
    stores document/protocol changes, dependencies, conflicts, partial views

  This also matches the arc discipline: Pijul is the primary implementation-facing candidate for the future patch-theoretic fragment category, but the categorical encoding is not settled yet. We
  should let the first Elixir kernel produce concrete trace and patch data before committing the whole system to Pijul internals.
