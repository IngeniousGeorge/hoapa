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

Bandwidth should generally pass through **2S** before the next 3R expansion. The next 2S status question is per-conversation locality: raw conversations should become local actor/event frames with `FrameHom`s into the global frame built by `CausalFromParents.agda`. Once that substrate meaning is stable, 3R can echo it with a minimal `hoapa_core` event log/export path.

## Guardrails

- Point-generated R4 is event-discrete and concurrency-internal; it is not the full finite actor-causal reflector and not `Allow ⊣ Require`.
- `CausalFromParents.agda` is the first generic runtime-to-substrate rung; it is not the complete realization/no-leak theorem.
- `Chu(SET,Bool)` is a concrete coefficient/value model and a Sessions realization target; it does not reconstruct Reality.
- The 3R tiny-run construction seam is not runtime behavior. Keep `hoapa_checker`, broad OTP, Pijul, and Phoenix work behind the status-file gates.
