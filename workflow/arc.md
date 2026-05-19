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

The non-trivial assembly. Stated as an adjoint triple of modalities

    Allow ⊣ Mediate ⊣ Require

between ModalHoTT (A) (perspectives) and Concurrency (B) = (SessionValues separated from ActorBase) (data-agents),
living in an ambient ∞-topos that contains both as cohesive sub-presentations.

Whether this is the full triple or a single adjoint pair is the first design choice;
default to the triple, fall back to the pair if the middle slot has no content.

## 4. What the adjoint triple says  → T1 (data), T6 (philosophical reading)

For each piece of data in the adjunction, give two readings — math and philosophy —
in parallel:

- Unit  η : id → Require ∘ Allow
- Counit ε : Allow ∘ Require → id
- Left triangle  (separation requires perspectivalism)
- Right triangle (separation allows perspectivalism)
- Idempotency of each modality (perspectives are self-fixing)

This section is the structural meat. The four bullets of `motivation.md:13-17`
("perspectives require / allow typed data handled by unityped agents; separation
requires / allows perspectivalism") are recovered here as the four pieces of
adjoint data, with the asymmetry made explicit.

## 5. Sites and folders  → T2, T4, T5

- `agda/ModalHoTT/`    — site Bℤ, develops the ModalHoTT claim.
- `agda/Concurrency/`  — hybrid substrate (actor-causal + session-type values via sheaf; canonical source `deep_context/arc/02_concurrency_anchor.md`) plus the `O_1` operadic interaction layer named on top. Operadic syntax shipped 2026-05-18 in `Concurrency/Operads/{Ports,RawCyclicOperad,PortGluing,PortRotation,CyclicAssociative}.agda` (HIT-by-copy with sequential/parallel associativity and full cyclic equivariance via `rot-compₒ-a-block` / `rot-compₒ-b-block`; boundary-swap is derived). Algebra signatures shipped in `Concurrency/Algebras/{StarAutonomous,Valuation,OperadAlgebra}.agda`: thin `*`-autonomous target, weak HIT valuation, and structural Step-2 operad algebra with `plug`/`shift` and `boundary-swap-structural`. Sessions and hybrid integration not yet started. SessionValues + ActorBase separation is structural in the hybrid.
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

- Whether the structural claim is one adjunction or the full triple.
- What the middle modality "Mediate" picks out, if it exists.
- The functor / geometric morphism between the two cohesive sites.
- Concurrency-site sub-decisions (`_Site._Category` model, value category V, ∞-lift timing) — currently live in `status.md`; fold durable outcomes here as they stabilize.
- The precise statement of the math fragment as a theorem in the ambient topos.
