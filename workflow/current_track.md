# Bandwidth organization

This is the entry-point summary for the live lanes and their dependency order.
Read `architecture.md` for the intended participant/information-flow shape,
`status_formal.md` for checked and conjectural mathematics, and
`status_implementation.md` for the runtime contract and executable state.

## Lane convention

- **1C — pure conjecture:** develops M, the modal signature, and conjecture-
  scale structures independently.
- **2S — runtime-to-substrate:** interprets runtime evidence in K and proves
  the contract, change-of-base, locality, and no-leak obligations.
- **3R — runtime:** originates behavior and emits evidence conforming to the
  2S contract.

Dependency discipline: 3R echoes 2S; 1C develops independently; 2S imports 1C
only after a 1C result has become a stable interface. Parallel lanes do not
erase dependencies inside the selected program.

## Banked waterline

- K has the actor-causal site, finite descent, point-generated reflector and
  Benton/LNL bridge, `Chu(SET,Bool)` coefficient witness, and Sessions-to-Chu
  object/morphism realization. `session-O1-action` remains postulated.
- 2S derives the global causal frame and conversation-local frames from
  well-formed raw parents, keeps actor coverage conditional, characterizes
  causal saturation per conversation, and proves Tier A raw-validator
  invariance under injective actor relabeling.
- 3R has a schema-faithful in-memory recorder and exact corpus replay. It does
  not originate causality, close conversations, or publish artifacts.

## Selected work

The next program is selected. Its order is architectural, not a demand that
only one lane run at a time.

1. **1C modal diagnosis, in parallel.** Retain a checked derivation that the
   unrestricted `flat-intro` and dependent `flat-ind` make every type
   flat-modal. Reclassify fracture, the cohesive hom-equivalences, and the
   `ʃ ⊣ ♭` iteration control relative to that degenerate signature. Investigate
   repairs only as a contextual design problem; context renewal supplies the
   direction and the analytic non-flat delooping is an acceptance test.
2. **3R minimal causal kernel.** Produce one event whose parent is earned from
   a message actually consumed by a handler, record it through the existing
   `EventLog`, and retain a test that fails when dependency piggybacking is
   broken. This tests the premise beneath the existing 2S causal tower.
3. **2S contract v1.** Add a distinguished success/failure closure event,
   run-local and federated artifact references, reference integrity, at-most-
   one closure and nothing-after-closure for valid prefixes, exactly one
   closure for published conversations, and stable publisher-scoped content
   identifiers. Start with rejecting fixtures.
4. **2S public/live boundary and Tier B.** Specify per-conversation actor
   pseudonymization, no export of the live identity map in v0, and a public
   content observation. Add substrate-native change of actor base and a
   relative `FrameHomOver` beside banked fixed-base `FrameHom`; prove each
   conversation frame equivalent to its public image. Tier A alone does not
   prove this.
5. **2S relative views and base-relative statements.** Relate registered,
   panel, and event-supported views; factor the reusable finite-membership
   lemma; state causal saturation relative to a run and test persistence of an
   unsaturation witness under append-only extension. Do not rename these
   predicates as metastability or encapsulation.
6. **3R full assembly.** Add task intake, injected selection, panel processes,
   event-id dependency flow, success/failure closure, publication transform,
   corpus acceptance, and resubmission. Candidate, assent, silence policy,
   panel size, and entropy remain interface parameters. A separate checker app
   is earned only here, once behavior exists to check incrementally.
7. **Λ and Federation.** Interpret conversations, output artifacts, concepts,
   documentation versions, directed dependencies, and admitted comparisons
   from published evidence. Require designated observations to descend through
   any compression. Exercise the artifact interface with two independent peers
   before freezing it: collide local IDs, retain an offline pinned import,
   admit different comparisons, and withdraw one comparison on only one peer.
8. **Context renewal.** First show a successful artifact becoming an admissible
   input to further work while specified achievements remain usable and a new
   operation becomes possible. Only later add bounded protocol change with
   explicit versions and activation boundaries. This is K's forcing case for
   asking what M must say about contexts.

Every implementation or formal batch begins with a named red fixture, failing
runtime check, or unmet typed obligation, and ends green only under `make test`.

## Guardrails for the selected work

- Levels, layers, and adapters are independent axes. Closure evidence is not
  itself Λ, and a level-0 graph is not identical to the content layer.
- The eligible population stays outside traces. Registration, panel membership,
  and event participation remain distinct; silent registered actors are legal.
- Session tags are immutable. Editing is appending new events or conversations.
- A failed conversation closes and publishes a failure record; consensus is
  not the definition of closure.
- The live and public records are distinct mathematical objects. Tier A covers
  uniform raw relabeling only; per-conversation handles require new local
  change-of-base and observer-relative no-leak results.
- Public actor handles may change at publication. Public artifact,
  conversation, and event identifiers stay stable and publisher-scoped so
  federated references survive.
- The kernel, not Tier B or the recorder, earns causal parents from behavior.
- Dependency edges stay directed. Only comparisons admitted by a particular
  documentation version may become invertible in its presentation.
- Federation has explicit import boundaries and versioned local adoption. It
  supplies no global clock, actor directory, quotient, history, or consensus.
- Participants have equal formal standing but need not produce equivalent
  results. The system represents specified work and participation, not a
  synthetic decomposition of the person.
