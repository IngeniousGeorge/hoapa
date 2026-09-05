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
| Mediate | —      | — | middle slot; content TBD (T1: triple vs. pair; identity if pair) | central, may collapse |
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
