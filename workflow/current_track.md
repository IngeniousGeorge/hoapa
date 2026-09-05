# Bandwidth organization

This file describes how session bandwidth is organized. It is not the canonical next-step tracker. For up-to-date lane status and concrete next work, read:

- `workflow/status_formal.md` for 1C pure conjecture and 2S runtime-to-substrate work.
- `workflow/status_implementation.md` for 3R runtime work and the checker/runtime contract boundary.

## Lane convention

The project uses a number+letter lane pattern. The number records logical-time progression; the letter names the lane.

- **1C - pure conjecture:** Agda-first conjecture chasing: O1-in-Chu / `session-O1-action`, Reality/Documentation/Chu, full reflector enrichment, cross-site `Allow ⊣ Require`, and the modal cyclic-bar return. This lane can develop independently, but 2S should import from it only after an interface has stabilized.
- **2S - runtime-to-substrate:** Agda that interprets runtime-shaped evidence into the actor-causal substrate. This is the adapter/junction lane between the formal runtime contract and the concurrency substrate.
- **3R - runtime:** Elixir/Rust runtime work. This lane emits executable evidence for the contract and should echo 2S rather than inventing substrate semantics ahead of it.

Dependency discipline: **3R echoes 2S; 1C develops independently; 2S imports 1C only when a 1C result has become a stable interface.**

## Current bandwidth posture

The point-generated Benton/LNL interface (R4) theorem is banked: the supported/event-discrete reflector `a ⊣ ι`, the point-sheaf bridge `Lpoint ⊣ Rpoint`, the `Chu(SET,Bool)` coefficient instance, and the Sessions-to-Chu `J0`/`J1` realization have landed. This remains a concurrency-internal theorem, not the full actor-causal reflector or the cross-site `Allow ⊣ Require` adjunction.

The runtime contract loop 1 and 3R event-log pass 1 are closed and green. An unnamed `Hoapa.Core.EventLog` records caller-supplied actors, conversations, and events without checking or normalizing them, then exports a `Hoapa.Contract.Run`. It can reproduce the Agda-accepted tiny run through a running process, and its wildcard corpus-replay test preserves every schema-decodable valid and semantic-invalid fixture exactly. This is recorder behavior, not an originator or protocol kernel.

The 2S per-conversation locality package is banked. `ConversationLocality.agda` realizes every conversation present in a well-formed run as its own `LocalFrame` and constructs a `FrameHom` into the global frame built by `CausalFromParents.agda`; the local causal order is the global derived order restricted to that conversation's events, which is what makes strict reflection available.

Current bandwidth follows a two-lane dependency. **2S** next adds event coverage, the separate raw/realized actor-coverage pair and its soundness lemma, a conditional `Cover`, and the public parent-edge-implies-causal lemma. It then adds the authoritative valid `c0 → c1 → c0` fixture and the causal-saturation/rigidity comparison. **3R pass 2** follows by exporting that fixture into the vendored corpus; the existing wildcard replay test should reproduce it without runtime code or test changes. Actor-renaming/no-leak follows this package, while session-tag assignment remains deliberately deferred.

## Guardrails

- Point-generated R4 is event-discrete and concurrency-internal; it is not the full finite actor-causal reflector and not `Allow ⊣ Require`.
- `CausalFromParents.agda` is the first generic runtime-to-substrate rung; it is not the complete realization/no-leak theorem. It alone still constructs only the global frame.
- `ConversationLocality.agda` constructs per-conversation frames and strict embeddings; it does not package their family as a `Cover`. The settled actor-registration decision and planned `actorsCovered?` condition are recorded in `status_formal.md`.
- `Chu(SET,Bool)` is a concrete coefficient/value model and a Sessions realization target; it does not reconstruct Reality.
- `Hoapa.Core.EventLog` preserves evidence order, duplicates, unresolved references, and cross-conversation parent edges. It does not infer causality, judge validity, or originate events from actor behavior.
- Keep `hoapa_checker` closed until an originator supplies runtime behavior to check one-by-one. Keep broad OTP, durable storage/Pijul, and Phoenix work behind the status-file gates.
