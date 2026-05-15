# Targets

Concrete propositions we want to state precisely, and (where applicable) verify in Agda. Distinct from the philosophical seed (`motivation.md`), its cohesive reformulation (`arc.md`), and the analogies (`related_structures.md`). These are what the proof checker should eventually engage with.

Each target: claim, what's needed to state it cleanly, what's needed to verify it. Targets carry an arc-anchor pointing back to the corresponding section in `arc.md`.

---

## T1. Adjoint formulation of requires-allows

*Arc anchor: `arc.md` §3, §4.*

**Claim.** The "requires-allows" coupling between A (perspectives) and B (data-agents) is an adjunction of modalities — minimally a pair `Allow ⊣ Require`, ideally a full triple `Allow ⊣ Mediate ⊣ Require` modeled on cohesion's `ʃ ⊣ ♭ ⊣ ♯`. The four bullets of `motivation.md:13-17` are recovered as unit, counit, and the two triangle identities.

**To state cleanly.**
- Decide pair vs. triple; commit a default and an escape clause.
- Name the slots in arc vocabulary, distinct from `ʃ ♭ ♯` which already have geometric meaning.
- Identify the topos/topoi the modalities live on (ambient ∞-topos containing both cohesive sub-presentations).

**To verify.**
- Postulate the adjunction(s) in Agda; check unit/counit/triangle identities derive.
- Exhibit a non-trivial instance: cohesive Bℤ-or-icosahedral example where the adjunction has content (not all identity).

---

## T2. Cohesion on A_5-equivariant icosahedral S²

*Arc anchor: `arc.md` §5.*

**Claim.** The ∞-topos of A_5-equivariant sheaves on the icosahedrally stratified S² (12 vertices, 30 edges, 20 faces, with the three orthogonal golden-rectangle sub-structure) carries a cohesive structure with explicit modalities `ʃ_G, ♭_G, ♯_G`.

**To state cleanly.**
- Pin down the site: A_5-orbit category of S², or the icosahedral cell complex with A_5 action.
- Settle "3 inscribed golden rectangles" vs. "3 inscribed golden triangles" — the 12-vertex match wants rectangles.
- Specify what the modalities should pick out (typed data via `♭_G`, unityped substrate via `♯_G`, interaction shape via `ʃ_G`).

**To verify.**
- Either: prove cohesion lifts (positive theorem, possibly stated for general finite G with A_5/icosahedron as worked case).
- Or: identify the obstruction (negative result with explicit cause).
- Either outcome is publishable in cohesive HoTT / equivariant ∞-topos theory.

---

## T3. Lawvere fixed-point asymmetry between A and B

*Arc anchor: `arc.md` §6.*

**Claim.** The A side is fixed-point-rich (idempotency `♭♭ ≃ ♭`, `ʃʃ ≃ ʃ`, `♯♯ ≃ ♯` — modal types are fixed points of their modalities). The B side is fixed-point-poor (A_5 simple and transitive on 12 vertices forces the A_5-fixed sub-object to be empty, blocking equivariant self-reference). The `Allow ⊣ Require` adjunction (T1) transports between these poles: Allow turns closed perspectival fixed-points into open A_5-orbited operation; Require reflects open operation into closed perspective.

**To state cleanly.**
- State the fixed-point property of A precisely: "every cohesive modality is idempotent; modal types are fixed-point sets of the modality acting on the topos."
- State the no-fixed-point property of B precisely: equivariant endomaps on objects with empty A_5-fixed part have no equivariant fixed points; Lawvere applied contrapositively blocks self-referential closure.
- Specify what "transport between poles" means in terms of unit/counit data of the adjunction.

**To verify.**
- Mechanically: idempotency proofs already exist on the synthetic side for `♭`; needed for `ʃ` and `♯` (currently postulated, see status.md open questions).
- Compute A_5-equivariant fixed points on the 12-vertex set and on derived objects.
- Show the adjunction's left and right images sit on opposite Lawvere poles.

---

## T4. Hidden partition of A matches partition of B

*Arc anchor: `arc.md` §5.*

**Claim.** The cohesive partition `ʃ / ♭ / ♯` of A mirrors a 3-fold partition of B: typed data ↔ `♭`, unityped agents ↔ `♯`, interaction shape (protocol topology) ↔ `ʃ`. The match is not coincidental — it is the same partition viewed on two sites linked by the T1 adjunction.

**To state cleanly.**
- Identify the third slot on the B side (channel / protocol / address space candidate); decide if it exists or if the partition is genuinely 2-fold on B with `ʃ` having no operational partner.
- Specify "match" precisely: a functor between the two cohesive sites carrying each modality on one side to the corresponding modality on the other.

**To verify.**
- Construct the functor (likely a geometric morphism) between the ModalHoTT site (Bℤ) and the Concurrency site (icosahedral S²).
- Check it intertwines the three modalities.

---

## T5. Protocol as the operational reading of cohesion

*Arc anchor: `arc.md` §5.*

**Claim.** The "engineering protocol" — single way to interact, generating intricate structure with A_5 symmetry — is the operational form of the cohesive modalities on the Concurrency site. Not a new modality layered on top of cohesion, but cohesion read operationally rather than geometrically.

**To state cleanly.**
- Make "operational reading" precise: a translation from the cohesive modal data (objects, modalities, modal types) to the protocol's machinery (operations, participants, message types).
- Specify the universal property: the protocol is the free/cofree object satisfying "single mode of interaction" within the cohesive structure.

**To verify.**
- Depends on T2 (cohesion on icosahedral S²) and T4 (partition match).
- Once both hold: exhibit the operational translation as a theorem.

---

## T6. Two-sided "above" via the adjunction

*Arc anchor: `arc.md` §4, §7.*

**Claim.** A above B via the left adjoint Allow (generative direction); B above A via the right adjoint Require (reflective direction). The two "aboves" are dual, mutually constitutive, and the adjunction structure of T1 *is* this two-sided above-relation.

**To state cleanly.**
- This is largely a consequence of T1 once the adjunction is committed; worth stating separately because it is the *philosophical content* the adjunction carries.
- Phrase in arc.md §4 as the philosophical reading of unit / counit.

**To verify.**
- No separate mechanical verification beyond T1.
- Check that neither side collapses into the other (the adjunction is not an equivalence).

---

## T7. Bridge: fracture / de Rham → arc-level separation

*Arc anchor: `arc.md` §6 (the math fragment that fracture/de Rham instantiates).*

**Claim.** The fracture theorem (status.md current task) and the de Rham separation result (status.md arc target) witness `A` alone — that cohesion is necessary for stating things plain HoTT cannot state. They are pieces of T1's "Allow direction" (perspectives unfold into structure), specifically on the ModalHoTT-side.

**To state cleanly.**
- Locate fracture and de Rham within T1's adjunction structure: which unit/counit/triangle do they instance?
- Distinguish what they witness (cohesion's necessity for A) from what they don't (the requires-allows coupling with B).

**To verify.**
- Already partially scoped in status.md. The bridge work is articulating, not proving — the proofs are status.md's job.

---

## Not targets (orientation only)

- *Grothendieck mapping (PS / Esquisse / RS).* Useful tether and sanity check. Not what we're proving. If subsequent work starts orienting toward "recovering Esquisse-style results," push back.
- *Connes / Bennequin-Laforgue resemblances.* In `related_structures.md`. Locator, not target.
- *"World understanding and world creation."* In `arc.md §7`, held loose. Will sharpen if and only if discovery forces it.
- *The dual community-organization theorem* (concurrency-as-optimal-info-transfer). Co-equal in the long-term arc but out of scope for the current formalization phase.

---

## Dependency sketch

- T1 is foundational; T2, T3, T4, T5, T6, T7 all depend on it.
- T2 is the load-bearing site question for B.
- T3, T4, T5, T6 depend on T1 + T2 in various combinations.
- T7 depends on T1 and on status.md's current work.

T1 and T2 are the two primary targets. The rest are downstream.

---

## Appendix — flow leading to the B-side operational anchor

The T1–T7 above are abstract-mathematical: they ask how cohesive modalities behave on each side and how the two sides relate. Working through whether T2 or T4 should be B-side starting points surfaced that neither anchors B *locally*. T2 imports A's frame onto B by making it carry "a site for cohesion." T4 fixes the modal partition (♭ / ♯ / ʃ ↔ typed data / unityped agents / interaction shape) before B's own primitives are committed to. Both let the A-side dictate B's shape; the dependency runs in the wrong direction.

The fix is structural: A has an anchor *beneath* its modal mathematics — Bℤ as a mathematical object on its own terms, with motivation.md's perspectivalism as the philosophical layer beneath that. The modal vocabulary speaks *about* Bℤ; it doesn't constitute it. B currently has no such under-layer. The proposal is to add one: an **operational anchor** — an operational concurrent system formalized in concurrency's native language (candidate families: Honda–Yoshida–Carbone multiparty session types, asynchronous π-calculus with session types, Caires–Pfenning propositions-as-sessions) — as a mathematical object on its own terms. The modal/cohesive questions (T2, T4, T5) then become questions *about* this system, not constructions designed to mimic A.

The mirror with A: motivation.md is the philosophical layer beneath the modal math on A (perspectivalism — same object under different probes); the operational anchor is the operational layer beneath the modal math on B (agents having conversations and producing typed data). Both layers sit *under* the abstract-mathematical targets, not within them. The B-side operational anchor is a proposed new target upstream of T2, T4, T5 — not a refinement of any of them.
