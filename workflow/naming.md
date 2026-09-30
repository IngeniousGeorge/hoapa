# Naming

## Sides, correspondence, and comparison

- **M** names the world/context side under reconstruction, not a commitment
  to modal HoTT or a category of all Reality. **K** names actor-causal
  communities with session-typed values. Keep these names; no rename to E is
  selected. A category of candidate architectures is a further object, not K
  silently reinterpreted.
- **Allow : M → K**, left adjoint, and **Require : K → M**, right adjoint,
  name the current unconstructed pair. Their polarity and interpretation must
  be tested on actual candidates. **Free/Forget** and **Realize/Nerve** are
  exploratory role labels, not four newly adopted Hoapa functors.
- **Adequacy** names the purpose-relative relation. **Comparison structure**
  names the mathematics that organizes it. **Optimality** or **specialness**
  names the sought result, relative to stated contexts, uses, and comparisons,
  not an already available scalar score.
- Do not use **fitness** as the project's name for this relation or structure.
  **Sufficiency** is reserved for a specified information/factorization
  property, not a synonym for adequacy in general.
- **P** is a provisional name for contextual variability. "Fibred,"
  "continuous," "moduli," and "metric" indicate candidate structures, not
  mechanisms already chosen.
- **Alternative** or **clause variation** is neutral. Use **degeneration**
  only after naming the property lost; a non-Hoapa architecture can be a
  coherent and useful system.
- **Return** presents completed work contextually. **Replay** is its adequate
  uptake in further work. A contextual transpose alone establishes only
  return.
- Dependent **Σ** packages witnesses with their data; dependent **Π** supplies
  a family of outputs uniformly over its inputs. Neither identifies an
  artifact-publication mechanism by notation alone. The existing layer label
  **Reflexive Π** does not assert a dependent-product semantics.

## Synthetic/analytic interpretation and the mirror

- **Predominantly synthetic** describes Hoapa's organization of embodied
  understanding among unityped participants; **predominantly analytic**
  describes its articulation in differentiated conceptual documentation.
  The decomposed subject is **understanding of the world**, not persons.
  Both moments occur in both realms. See
  [related_structures.md](related_structures.md#lautman--analyticsynthetic-decomposition-and-recursive-incarnation).
- Neither **the synthetic side** nor **the analytic side** is a synonym for
  M, K, agents, or documentation. Synthetic/axiomatic versus analytic/model
  construction in the formalization is another use; state which use is meant.
- **Integration** or **unification** in the mirror means relating, composing,
  or reconstructing partial understanding while preserving specified
  differences; it need not mean identification or one merged object.
- **Secondary separation/unification** means structure proposed to be induced
  through the correspondence, not lower importance, a later time, or another
  architectural layer. **Primary** marks the starting point of that particular
  investigation, not an intrinsic hierarchy between M and K.
- The **surface** distinguishes reality from its understanding and connects
  them through accountable observation, interpretation, and action. This
  separating-and-connecting reading does not identify M with all Reality.

## Legacy cohesive notation

| Name | Symbol | Role in the cohesive candidate |
| --- | --- | --- |
| flat | ♭ | discrete view |
| sharp | ♯ | codiscrete view |
| shape | ʃ | homotopy shape |

These are intra-setting cohesive operators, not the names of cross-side
functors or a mandatory decomposition of M. The current synthetic signature
makes every type flat-modal; see `status_formal.md`. Cohesive structures remain
available as candidates, including relative cohesion between settings.

## Runtime recording and storage

- **Event log** names `Hoapa.Core.EventLog`: the in-memory ordered recorder in
  `hoapa_core`. It provides no durability and neither originates nor validates
  events.
- **Durable event storage** names the future persistence responsibility in
  `hoapa_store`, including the Pijul boundary. Do not also call that component an
  event log; let its eventual public noun be earned by its API.
- **Recorder-fidelity replay** means feeding a decoded run through a fresh event
  log and checking exact exported-struct equality. **Purpose-relative replay**
  means reconstructing or resuming the process that produced a trace. The first
  is tested; the second remains future work.

## Actor relabeling

- **Actor map** is an arbitrary function on actor names. Raw record relabeling
  respects identity and composition for these maps without an injectivity
  hypothesis.
- **Actor embedding** is an injective actor map. At the current raw boundary it
  is a total endomap of `ActorId = ℕ`; exact `valid?` invariance lives at this
  level.
- **Actor isomorphism** is an invertible map between actor carriers.
  **Actor permutation** is its endomorphism case. This is the gauge-symmetry
  vocabulary; do not use it for a merely injective, non-surjective map.
- **Validator blindness** names exact acceptance invariance under actor
  embeddings. **Gauge invariance** names the invertible specialization and,
  later, equivalence of realized structures. Neither phrase by itself means
  observational no-leak.

## Participant and publication vocabulary

- A **person** is not a kernel type. A **seat** is a protocol-local position
  that any eligible participant may occupy. A **role** is an activity or
  obligation attached to a seat or event; it is not an actor kind.
- The **eligible population** lives outside traces. **Registered actors** are
  run-local handles, **panel members** occupy seats in one conversation, and
  **event participants** are the actors touched by one event. Do not collapse
  these four scopes.
- A **conversation kind** is fixed by its immutable session tag. Current kinds
  separate participant conversations from content-level conversations; a
  mixed actor carrier is not implied.
- A **closure event** is the unique terminal event of a conversation and marks
  success or failure. A **closure transform** maps the live record to the
  public record; it is not the closure event itself.
- The **live record** may carry ephemeral operational identity needed for
  delivery. The **public record** carries per-conversation actor handles and
  stable content-facing identifiers. A **public content view** forgets actor
  identity while retaining declared artifacts, references, provenance, and
  dependency structure.
- **Pseudonymization** replaces an identity channel by scoped handles.
  **Erasure** removes a field or observation. Neither term alone entails
  unlinkability; that is relative to a declared observer and retained maps.
- A **run-local reference** resolves inside one accepted run. A **federated
  artifact reference** resolves against an explicitly imported, versioned
  publication bundle and includes publisher scope. Neither is an actor
  identity.
- Public **artifact**, **conversation**, and **event identifiers** are stable,
  opaque, publisher-scoped names. Actor handles may change at publication
  without reissuing those content identifiers.

## Content and comparison vocabulary

- A **conversation** is an episode, an **output artifact** is a published
  result of an episode, a **concept identity** is a content-layer object, and a
  **documentation version** fixes a current interpretation. None is a synonym
  for another.
- A **comparison claim** is retained history. An **admitted comparison** is one
  a particular documentation version currently accepts. A **language
  presentation** is constructed from the admitted set subject to an adequacy
  condition. Withdrawal changes the admitted set in a later version; it does
  not delete the earlier claim.
- The **core**, a **localization**, and **groupoid completion** are different
  constructions. Dependency edges remain directed; only explicitly admitted
  comparisons are candidates for inversion.
- A **locator** names a context inside a language, such as engineering or
  biology. A locator does not by itself name a federated peer.

## Locality and arrow vocabulary

- An **actor-causal frame** is Hoapa's local structure of actors, events,
  incidence, and causal order. It is not a locale-theoretic frame (a complete
  lattice of opens with finite meets distributing over arbitrary joins).
- A **conversation** is the operational episode. Its **conversation frame** is
  the structural local view extracted from its trace. A **probe** or
  **standpoint** is a candidate semantic map from a chosen local view into a
  documented context. A **matching family** is possible interpreted content of
  an episode, not another name for the episode or its frame.
- Keep five kinds of arrows distinct: a **causal-parent edge** records consumed
  event dependence; a **typed documentary dependency** relates conversations
  or artifacts through provenance; a **frame morphism** embeds or compares
  actor-causal views under its stated laws; a **restriction map** reindexes
  presheaf data; and an **admitted comparison** may be inverted in one Λ
  presentation. None supplies the others merely by sharing endpoints.

## Architectural axes

- A **level** says what occupies the positions being discussed; a **layer** is
  a separation of responsibility; an **adapter** relates structures across a
  separation. These are independent axes.
- **Promotion** means publishing an output through an explicit interface so it
  can be referenced by later work. It is not a collapsing `FrameHom` and does
  not turn a participant into a concept.
- A **publication bundle** is a finite, versioned federated export complete
  relative to a declared **import boundary**. Completeness is not recursive
  possession of the network's entire history.

## Runtime origination

- **Fidelity sampler** produces arbitrary well-typed contract values to test
  codec and recorder faithfulness. It does not claim valid scenarios or causal
  origination.
- **Scenario originator** derives identifiers, append order, conversation
  assignment, and parent references from an authored seed or scenario. It
  constructs runs, but its causality still comes from declared transition
  logic rather than actor behavior.
- **Actor kernel** derives events and causal parents from actual message
  behavior. Of these three, only the actor kernel meets the current behavioral
  originator gate for a separate checker.

Avoid bare **generator** where the evidential distinction matters.
