# The arc reformulated in cohesive vocabulary

## 1. Preamble

What this document grows from (`motivation.md`'s proto-conjecture), what it preserves, what it sharpens.
The interdisciplinary frame: HoTT-as-foundation extended along the developmental / praxis axis,
with a co-equal community-of-agents leg.

Cross-reference convention: each section below that maps to a concrete proposition in `targets.md` carries a "→ T*n*" pointer. Read the two files together — arc.md gives the motivation-language scaffold, targets.md gives the proposition-language decomposition.

## 2. The three per-domain claims

ModalHoTT.     Modalities allow complexity to develop.        (cohesive HoTT)
SessionValues. Typed data is robust for information transfer. (programming / session types)
ActorBase.     Unityped agents handle complexity well.        (concurrency / actor model)

For each: a short sentence on why it is trivial in its own domain, and the citation / anchor.

## 3. The structural claim  → T1

The non-trivial assembly is now held, by default, as an adjoint pair

    Allow ⊣ Require

between ModalHoTT (M) (perspectives / modal structural contexts) and Concurrency (K) = actor-causal communities with session-typed values, living in an ambient ∞-topos that contains both as cohesive sub-presentations.

This is the arc/09 grounding: do not present Complexity / Evolution / Praxis / Anthropic as four functors unless future mathematics earns extra adjunctions. The pair carries five anchors:

- Complexity = Allow / left adjoint L : M → K, the generative direction.
- Evolution = Require / right adjoint R : K → M, the reflective direction; its monad R ∘ L is the source of the developing-network iteration.
- Praxis = the unit η : id_M ⇒ R ∘ L, the universal opening from which particular operational episodes are transposed.
- Anthropic = the counit ε : L ∘ R ⇒ id_K, read through its non-invertibility / forgetful loss. Its non-degeneracy is ordered below T3 and T_recursion by the non-collapse ladder in `targets.md` §T3; it is not independent corroboration.
- Care = the order-2 involution _^⊥, orthogonal to the pair and already visible in session duality. This is the checked structural proxy; its interpretation as developmental or ethical Care remains conjectural.

A triple Allow ⊣ Mediate ⊣ Require, an ambidextrous pair, or a quadruple can return only as extra structure. The current code and motivation use the pair-shaped seed reading.

## 4. What the adjoint pair says  → T1 (data), T6 (philosophical reading)

For each piece of data in the adjunction, give two readings — math and philosophy —
in parallel:

- Unit  η : id → Require ∘ Allow
- Counit ε : Allow ∘ Require → id
- Left triangle  (separation requires perspectivalism)
- Right triangle (separation allows perspectivalism)
- Non-invertibility / non-collapse (distinct, ordered conditions; see the non-collapse ladder in `targets.md` §T3)

This section is the structural meat. The four bullets in `motivation.md` § "The foundational conjecture"
("perspectives require / allow typed data handled by unityped agents; separation
requires / allows perspectivalism") are recovered here as the four pieces of
adjoint data, with the asymmetry made explicit.

The apparent indexing mismatch for Praxis has a precise morphism-level resolution. Given a particular operational episode `w : L M → K₀`, its contextual presentation is the transpose `w♯ = R(w) ∘ η_M : M → R K₀`. Thus `η_M` is the universal / synthetic opening, `w` is the particular / analytic episode, and `w♯` presents the whole episode formally on M without removing its K-side content. This is the pair conservation law rather than a reason to flip the adjunction. But `w♯` exists for every adjunction: the transposition clarifies the reading and supplies no evidence that Hoapa's particular `Allow` and `Require` exist or satisfy the conjecture. The content remains in constructing the pair and distinguishing morphisms whose transposes satisfy the required care, locality, controlled-loss, and non-collapse laws.

## 5. Sites and folders  → T2, T4, T5

- `formal/ModalHoTT/`    — site Bℤ, develops the ModalHoTT claim.
- `formal/Concurrency/`  — hybrid substrate (actor-causal + session-type values via sheaves; canonical source `deep_context/arc/02_concurrency_anchor.md`) plus the `O_1` operadic interaction layer. Operadic syntax, algebra signatures, the split Sessions syntax/HIT/action layers, actor-causal sites, finite frames/covers, and the arbitrary-frame Hybrid adapter are shipped. The finite sheaf layer is category-generic, with V-valued and SET endpoints, concrete constant-slot event-product objects, finite `Coverage`, and SET library `isSheaf` comparison. R4 has advanced through the conditional full finite-site Benton/LNL bridge, and the supported point-generated route now constructs the concrete reflector `a ⊣ ι` and wires it into the point-sheaf Benton/LNL bridge `Lpoint ⊣ Rpoint`, relative to value-level `lnl` and `vProd`. `Chu(SET,Bool)` now supplies a concrete coefficient instance, and Sessions-to-Chu `J0`/`J1` realizes the postulate-free session object/morphism syntax. The pure-conjecture backlog remains O1-in-Chu / `session-O1-action`, Reality/Documentation/Chu boundary, and later full actor-causal reflector enrichment; current bandwidth has shifted to the runtime-to-substrate junction and then runtime emission.
- `formal/RuntimeContract/` - runtime boundary and 2S realization bridge. Loop 1 is closed: trace predicate, serialization corpus, generated Agda raw terms, vendored runtime artifact, runtime codec tests, and Makefile gates agree. `RuntimeContract/Realization/BackwardRank.agda` and `RuntimeContract/Realization/CausalFromParents.agda` derive a causal order and global `LocalFrame` from well-formed raw parents, over the shared lookup and validator-peeling lemmas in `RuntimeContract/Realization/TraceLookup.agda`. `RuntimeContract/Realization/ConversationLocality.agda` adds per-conversation `LocalFrame`s with `FrameHom`s into that global frame. The next 2S package separates event coverage from the explicit `actorsCovered?` hypothesis, then exercises cross-conversation causal saturation; actor-renaming/no-leak follows it, while session-tag assignment remains deferred. On 3R, the minimal `hoapa_core` event-log/export recorder is banked and awaits that cross-conversation fixture for pass 2.
- `formal/Analytic/`     — analytic mirror for ModalHoTT; documents non-vacuity.
- `formal/AnalyticTest/` — reserved third track; see folder README.

The arc-level theorem lives in the ambient ∞-topos relating the two cohesive sites via a functor or geometric morphism. (The specific shape of this functor is deferred — both sites are intended to sit inside the same cubical-set ambient; see `deep_context/arc/02_concurrency_anchor.md`.)

## 6. The mathematical fragment  → T3 (Lawvere asymmetry), T_recursion (iteration / developing network)

The line from `motivation.md` § "The foundational conjecture" ("covers / coverings, recursion, infinite network")
restated in cohesive vocabulary:

- covers from the Grothendieck topology on each site
- recursion from iterating the unit of the proposed cross-site adjunction, with the Lawvere asymmetry retained as a conjectural explanation of non-collapse
- the developing network as the candidate sequential colimit of that unit sequence

This is the part of the arc that is genuinely interesting in mathematics on its own.

The "recursion" and "infinite network" bullets are the prose form of T_recursion: the iteration of the adjunction's unit η : id → Require ∘ Allow, with its sequential colimit as the candidate developing network. Nothing about an adjunction makes that iteration non-trivial automatically. The canonical mathematics and the ordering between Anthropic loss, one non-trivial monad step, and persistent non-stabilization live only in the non-collapse ladder in `targets.md` §T3. The checked `ʃ ⊣ ♭` specialization is a collapsing control that constrains where a cross-site witness may be sought; it is evidence neither for nor against the conjecture.

## 7. Interpretation  → T6 (philosophical reading of unit / counit)

- World-understanding ↔ internal language / sections of cover (the topos as a place where things mean).
- World-creation     ↔ forcing / no-fixed-point side of Lawvere (the topos as a place where things originate).

Held loose: this section is a placeholder for what discovery will sharpen.

## 8. What is left for discovery

Explicit list. Examples to seed it:

- Whether extra structure beyond the pair is eventually earned: a middle "Mediate", an ambidextrous adjunction, or a genuine quadruple.
- The functor / geometric morphism between the two cohesive sites.
- Whether the Esquisse-facing comparison can be constructed independently as a space-valued shape-witness profunctor, and only then shown representable by `Allow` and `Require`. Generic two-sided representability merely restates T1.
- Whether the modal side can acquire the three-point branch / orbifold data required to compare with Belyi covers. A bare `S²` and a rigid three-marked base carrying varying covers are not yet the same cross-site object.
- Concurrency-site sub-decisions (`_Site._Category` model, value category V, Set-valued locality side, R4, ∞-lift timing) — currently live in `status_formal.md`; fold durable outcomes here as they stabilize. Current durable outcome: the V-valued and Set-valued finite sheaf endpoints are one generic construction at two value categories, and the Set endpoint agrees with the Cubical library sheaf condition for the finite coverage. Do not collapse their cartesian and linear meanings. R4 is the named adapter between them; its presheaf-level Benton structure, right-adjoint sheaf preservation, finite-sheafification interface, and conditional full finite-site sheaf-level adjunction have landed. The point-generated supported reflector and point-generated R4 bridge have also landed, with `Chu(SET,Bool)` as a concrete coefficient witness. The Sessions-to-Chu object/morphism realization has landed separately; the remaining Sessions postulate is `session-O1-action`. The runtime-to-substrate bridge now includes the global-frame and per-conversation-locality rungs, and 3R has an exact in-memory recorder. Coverage/causal-saturation, actor-renaming/no-leak, and runtime origination of events from behavior remain open. The generic full finite actor-causal reflector remains open.
- The precise statement of the math fragment as a theorem in the ambient topos.
