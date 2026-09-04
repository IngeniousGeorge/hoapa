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

The runtime contract loop 1 is closed and green. The tiny-run construction seam is now banked in 3R: runtime-side code can reconstruct the Agda-accepted `tiny_trace.json` run from `hoapa_contract` structs and keep it corpus-locked by decoded-struct equality. This is still an emission seam, not protocol behavior; the protocol kernel has not yet emitted a trace from a running event log.

The 2S per-conversation locality package is banked. `ConversationLocality.agda` realizes every conversation present in a well-formed run as its own `LocalFrame` and constructs a `FrameHom` into the global frame built by `CausalFromParents.agda`; the local causal order is the global derived order restricted to that conversation's events, which is what makes strict reflection available.

That package supplies the target the next 3R expansion was waiting for, so current bandwidth moves to **3R**: the minimal `hoapa_core` event-log/export path, emitting against conversation-shaped local views rather than inventing its own. Actor-renaming/no-leak remains the next 2S theorem, and session-tag assignment is unlocked but deliberately still deferred — it is a decorating layer over the realized frames, not a field on `LocalFrame`.

## Guardrails

- Point-generated R4 is event-discrete and concurrency-internal; it is not the full finite actor-causal reflector and not `Allow ⊣ Require`.
- `CausalFromParents.agda` is the first generic runtime-to-substrate rung; it is not the complete realization/no-leak theorem. It alone still constructs only the global frame.
- `ConversationLocality.agda` constructs per-conversation frames and strict embeddings; it does not package their family as a `Cover`. `WellFormed` supplies event-to-conversation resolution but does not imply actor coverage.
- `Chu(SET,Bool)` is a concrete coefficient/value model and a Sessions realization target; it does not reconstruct Reality.
- The 3R tiny-run construction seam is not runtime behavior. Keep `hoapa_checker`, broad OTP, Pijul, and Phoenix work behind the status-file gates.
