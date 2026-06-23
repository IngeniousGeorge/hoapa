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
- Praxis = the unit η : id_M ⇒ R ∘ L, formally indexed on M and felt in K.
- Anthropic = the counit ε : L ∘ R ⇒ id_K, read through its non-invertibility / forgetful loss.
- Care = the order-2 involution _^⊥, orthogonal to the pair and already visible in session duality.

A triple Allow ⊣ Mediate ⊣ Require, an ambidextrous pair, or a quadruple can return only as extra structure. The current code and motivation use the pair-shaped seed reading.

## 4. What the adjoint pair says  → T1 (data), T6 (philosophical reading)

For each piece of data in the adjunction, give two readings — math and philosophy —
in parallel:

- Unit  η : id → Require ∘ Allow
- Counit ε : Allow ∘ Require → id
- Left triangle  (separation requires perspectivalism)
- Right triangle (separation allows perspectivalism)
- Non-invertibility / non-collapse (the Lawvere asymmetry that keeps the iteration from becoming trivial)

This section is the structural meat. The four bullets of `motivation.md:13-17`
("perspectives require / allow typed data handled by unityped agents; separation
requires / allows perspectivalism") are recovered here as the four pieces of
adjoint data, with the asymmetry made explicit.

The formal indexing of the 2-cells and their experiential homes do not coincide perfectly: η is formally on M but felt as praxis in K, while ε is formally on K but felt as anthropic loss on the modal side. This mismatch is not an error to erase by flipping the adjunction; it is the pair conservation law and a small instance of the anthropic reading itself.

## 5. Sites and folders  → T2, T4, T5

- `agda/ModalHoTT/`    — site Bℤ, develops the ModalHoTT claim.
- `agda/Concurrency/`  — hybrid substrate (actor-causal + session-type values via sheaves; canonical source `deep_context/arc/02_concurrency_anchor.md`) plus the `O_1` operadic interaction layer. Operadic syntax, algebra signatures, the split Sessions syntax/HIT/action layers, actor-causal sites, finite frames/covers, and the arbitrary-frame Hybrid adapter are shipped. The finite sheaf layer is category-generic, with V-valued and SET endpoints, concrete constant-slot event-product objects, finite `Coverage`, and SET library `isSheaf` comparison. R4 has advanced through the conditional full finite-site Benton/LNL bridge, and the supported point-generated route now constructs the concrete reflector `a ⊣ ι` and wires it into the point-sheaf Benton/LNL bridge `Lpoint ⊣ Rpoint`, relative to value-level `lnl` and `vProd`. `Chu(SET,Bool)` now supplies a concrete coefficient instance, and Sessions-to-Chu `J0`/`J1` realizes the postulate-free session object/morphism syntax. The current B-side discovery layer is exposition plus a deliberate next choice: O1-in-Chu / `session-O1-action`, Reality/Documentation/Chu boundary, or later full actor-causal reflector enrichment.
- `agda/Analytic/`     — analytic mirror for ModalHoTT; documents non-vacuity.
- `agda/AnalyticTest/` — reserved third track; see folder README.

The arc-level theorem lives in the ambient ∞-topos relating the two cohesive sites via a functor or geometric morphism. (The specific shape of this functor is deferred — both sites are intended to sit inside the same cubical-set ambient; see `deep_context/arc/02_concurrency_anchor.md`.)

## 6. The mathematical fragment  → T3 (Lawvere asymmetry), T_recursion (iteration / developing network)

The line from `motivation.md:20` ("covers / coverings, recursion, infinite network")
restated in cohesive vocabulary:

- covers from the Grothendieck topology on each site
- recursion from Lawvere fixed-point on the modalities
- infinite network from the comonadic structure inducing co-presheaves on a developing diagram

This is the part of the arc that is genuinely interesting in mathematics on its own.

The "recursion" and "infinite network" bullets are the prose form of T_recursion: the iteration of the adjunction's unit η : id → Require ∘ Allow, with its sequential colimit as the developing network. T3 (the Lawvere fixed-point asymmetry between the two sides) is what makes this iteration non-trivial — without it, `Require ∘ Allow` would be idempotent and the network would collapse after one step. T_recursion is the structural target this section names; T3 is the asymmetry-engine that powers it.

## 7. Interpretation  → T6 (philosophical reading of unit / counit)

- World-understanding ↔ internal language / sections of cover (the topos as a place where things mean).
- World-creation     ↔ forcing / no-fixed-point side of Lawvere (the topos as a place where things originate).

Held loose: this section is a placeholder for what discovery will sharpen.

## 8. What is left for discovery

Explicit list. Examples to seed it:

- Whether extra structure beyond the pair is eventually earned: a middle "Mediate", an ambidextrous adjunction, or a genuine quadruple.
- The functor / geometric morphism between the two cohesive sites.
- Concurrency-site sub-decisions (`_Site._Category` model, value category V, Set-valued locality side, R4, ∞-lift timing) — currently live in `status.md`; fold durable outcomes here as they stabilize. Current durable outcome: the V-valued and Set-valued finite sheaf endpoints are one generic construction at two value categories, and the Set endpoint agrees with the Cubical library sheaf condition for the finite coverage. Do not collapse their cartesian and linear meanings. R4 is the named adapter between them; its presheaf-level Benton structure, right-adjoint sheaf preservation, finite-sheafification interface, and conditional full finite-site sheaf-level adjunction have landed. The point-generated supported reflector and point-generated R4 bridge have also landed, with `Chu(SET,Bool)` as a concrete coefficient witness. The Sessions-to-Chu object/morphism realization has landed separately; the remaining Sessions postulate is `session-O1-action`. The generic full finite actor-causal reflector remains open.
- The precise statement of the math fragment as a theorem in the ambient topos.
