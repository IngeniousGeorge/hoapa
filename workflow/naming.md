| Name  | Symbol | Intuition                               | Keeps                   | Forgets            |
| ----- | ------ | --------------------------------------- | ----------------------- | ------------------ |
| flat  | ♭      | discrete / locally constant view        | discrete structure      | cohesive variation |
| sharp | ♯      | codiscrete / maximally connected view   | global connectivity     | local distinctions |
| shape | ʃ      | homotopy shape / fundamental ∞-groupoid | homotopy/path structure | cohesive geometry  |

Above: intra-topos cohesive endofunctors.
Below: cross-site adjoints between modal perspectives **M** and actor-causal
communities **K** (`arc.md` §3); symbols are deferred to keep them distinct from
`ʃ ♭ ♯`.

| Name    | Symbol | Direction | Intuition | Anchor |
| ------- | ------ | --------- | --------- | ------ |
| Allow   | —      | M → K | Modal perspectives unfold into actor-causal communities; perspectives allow typed documentation plus unityped actors | left adjoint (T6) |
| Require | —      | K → M | Actor-causal communities reflect to modal perspectives; operational separation requires perspectivalism | right adjoint (T6) |

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
