# Current track - towards publishable material

## Current state (2026-07-04)

The point-generated R4 theorem is banked. The supported/event-discrete reflector `a ⊣ ι`, the point-sheaf Benton/LNL bridge `Lpoint ⊣ Rpoint`, the `Chu(SET,Bool)` coefficient instance, and the Sessions-to-Chu `J0`/`J1` realization have landed. This remains the first modest operational theorem, not the full actor-causal reflector or the cross-site `Allow ⊣ Require` adjunction.

The runtime contract loop 1 is closed and green. The formal predicate, fixture corpus, generated Agda raw terms, vendored runtime artifact, Elixir codec tests, freshness gates, and `make test` all agree.

The B-lane runtime-to-substrate junction has its first generic rung. `RuntimeContract/Realization/BackwardRank.agda` proves that parent edges decrease first-occurrence rank under `backwardOK`; `RuntimeContract/Realization/CausalFromParents.agda` derives a `CausalOrder` and one global `LocalFrame` for any well-formed run. This closes the TinyTrace order-reuse gap at the global-frame level, but does not yet provide per-conversation frames, `FrameHom`s, session assignment, or renaming/no-leak.

## Active lane split

- **A - pure implementation:** Elixir/Rust runtime work. The next useful runtime move is to programmatically build a tiny valid run through existing `hoapa_contract` structs/codecs and round-trip it through JSON.
- **B - runtime-to-substrate junction:** Agda that interprets runtime-shaped evidence into the actor-causal substrate. The next B return should realize per-conversation local frames and construct `FrameHom`s into the global frame from `CausalFromParents.agda`.
- **C - pure conjecture:** O1-in-Chu / `session-O1-action`, Reality/Documentation/Chu, full reflector enrichment, cross-site `Allow ⊣ Require`, and the A-side cyclic-bar return. These are real directions, but not the next bandwidth claim.

Dependency discipline: A echoes B; C develops independently; B imports C only when a C result has become a stable interface.

## Current recommendation

After this workflow close, pass bandwidth back to A-lane runtime. Do not open broad OTP, Pijul, Phoenix, or `hoapa_checker` work yet. Build the smallest runtime-emitted valid trace first: construct the run with the existing contract structs, encode it, decode it, and prove the round trip stays inside the corpus-pinned contract boundary.

`hoapa_checker` earns a separate app only once there is a real runtime-emitted trace that needs per-trace semantic validation. Until then, Agda remains authoritative for semantic validity and the fixture corpus plus Makefile gates keep the runtime codec aligned.

## Next B-lane return

The next formal junction step is per-conversation locality:

1. Extract each raw conversation as a local actor/event subframe.
2. Construct a `FrameHom` from that conversation frame into the global frame built by `CausalFromParents.agda`.
3. Prove preservation of touches and preservation/reflection of the derived causal order.
4. Only then return to actor-renaming/no-leak: raw `valid?` invariance, realized-frame equivalence, and optional SIP/univalence capstone.

Session-tag assignment stays later. `LocalFrame` itself contains no session content.

## Advertising guardrails

- Point-generated R4 is B-internal and event-discrete; it is not the full finite actor-causal reflector and not `Allow ⊣ Require`.
- `CausalFromParents.agda` is the first generic runtime-to-substrate rung; it is not the complete Realization/no-leak theorem.
- `Chu(SET,Bool)` is a concrete coefficient/value model and a Sessions realization target; it does not reconstruct Reality.
- Runtime loop 1 is closed, but runtime behavior is still at the contract/codec boundary. The protocol kernel has not yet emitted a trace from behavior.
