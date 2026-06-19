# Provenance and the Audit layer

## Reader note

This file is a preserved design log of the session in which **provenance** was first
explored as a candidate addition to the cascade of separations of concerns. It is written
in the spirit of `07_self-modifying_protocol.md` and `08_bulk_type_theory_layer.md`: it
records *how the idea unfolded*, keeping the original, stronger phrasing next to the
corrected resolution.

Three things to hold in mind while reading:

- **Status: CANDIDATE, not integrated.** The live catalogue (`future_work.md`) and the
  compact cascade (`motivation.md`) were deliberately left untouched. This idea is to be
  folded in *only if* (a) it proves genuinely useful and (b) after the current
  point-generated R4 exposition closes. Until then it lives here, self-contained, with its
  own forward-looking integration checklist rather than edits to the calibrated files.
- **The early framing overclaimed.** As in `07`, the opening reading turned several useful
  *relationships* into mathematical *identities*. The operative content is the later
  **Resolution** section, where those become explicit interfaces and conditional coherence
  laws. The overclaims are preserved (not deleted) under "The first, stronger reading" so
  the correction is legible.
- **It is post-R4 roadmap material.** Nothing here changes the present completion
  criterion. The R4 exposition remains the live priority.

Literature anchors gathered this session:

- Green, Karvounarakis, Tannen — *Provenance Semirings* (PODS 2007): semiring-annotated
  `K`-relations; `ℕ[X]` (provenance polynomials) the free/universal commutative semiring;
  specialization by semiring homomorphism.
- Grädel & Tannen — *Provenance Analysis and Semiring Semantics for First-Order Logic*
  (arXiv:2412.07986): `∨,∃ ↦ +`; `∧,∀ ↦ ×`; negation via NNF + dual indeterminates; the
  "fundamental property" (homomorphisms commute with evaluation).
- Badia, Kolaitis, Noguera — *Codd's Theorem for Databases over Semirings*
  (arXiv:2501.16543; doi:10.1145/3767713): relational algebra ≡ calculus over semirings;
  difference via **monus** (needs monus, support, domain-independence, and — full version —
  no zero divisors).
- Brinke, Dawar, Grädel, Mrkonjić, Naaf — *Compactness in Semiring Semantics* (CSL 2026):
  weak (satisfiability) compactness generalizes broadly; **strong (entailment)** compactness
  fails for the tropical and Łukasiewicz semirings.
- **Dagstuhl 25081**, *Semirings in Databases, Automata, and Logic* (Feb 2025): the meeting
  point of Tannen (provenance), Grädel (model theory of semiring semantics), and Ugolini
  (algebraic semantics of many-valued logics via residuated structures). Organized by
  Badia, Droste, Kolaitis, Noguera; collected by Brinke, Mrkonjić, Petreni.
- Portone (supervised by Badia & Noguera), with Badia, Noguera, Petreni, Tannen — current
  work on **conjunctive queries with negative information** (Helsinki logic seminar). This is
  the negation/monus frontier; it is relevant to v4 below, *not* to the basic import case.
- Implementations: **ProvSQL** (PostgreSQL; unified semiring API incl. monus, Łukasiewicz;
  provenance *circuits*), GProM, Perm, ORCHESTRA (collaborative data sharing / update
  exchange among peers, the closest precedent for the import use-case), and **W3C PROV** as
  the interchange standard — which, importantly, *does* model agents and responsibility.

---

## The seed (instigator)

The idea entered from the implementation end, not the mathematics. ig's first instinct on
seeing provenance was to lower the *processing cost* — measured in conversations — at the
level of the network of protocols (the Federation layer):

> Instead of two protocols each working independently on a similar concept (≥ two
> conversations) and then bridging the two (≥ two more conversations), there could be one
> protocol doing the work (one conversation), and the other simply taking it "as is" (a
> mirroring conversation) plus one bridge conversation on the mirrored side.

Provenance was imagined as the mechanism by which such *imports* are **clear,
separation-of-concern-valid, reusable, editable, and — most importantly — reversible
without dramatic cost** for the importing protocol.

This instinct turned out to land on the canonical home application of provenance semirings:
**collaborative data sharing / update exchange among autonomous peers** (the ORCHESTRA
line). The math for exactly this had already been worked out in databases. So the seed was
sound; the rest of the session was about resisting the temptation to overclaim what
provenance, by itself, delivers.

---

## The first, stronger reading (preserved for the record)

The opening exploration made a series of claims that were *suggestive and useful* but
stated too strongly — as identities rather than relationships. They are kept here verbatim
in spirit so the correction is legible:

1. **"The hinge to the session core is residuation."** Monus was said to be the same
   residuation as session `⊸`, making provenance-with-negation a direct bridge to Hoapa's
   `*`-autonomous / linear core.
2. **"Provenance is sheaves valued in `S`-semimodules, the cheapest and deepest entry."**
3. **"Provenance subsumes the information-cohomology layer"** (entropy as a homomorphic
   specialization of `ℕ[X]`).
4. **"Provenance is descent-with-witnesses"** — the data the sheaf proof discarded.
5. **"Provenance is the operational shadow of HoTT proof-relevance, hence evidence for
   `Allow ⊣ Require`."**
6. **"No-leak is automatic"** — provenance respects unityping for free.
7. **"Reversibility lands squarely on the monus / negative-information frontier."**
8. **"Pijul changes are invertible Homotopical-Patch-Theory paths,"** and both faces live
   natively in the project's cubical Agda.
9. **The interface theorem as an identity:** `Pijul-unapply = provenance evaluation at
   zero`.

The five "import properties" of the seed were likewise attributed to a *single* provenance
annotation, as if provenance alone supplied clarity, separation, reuse, editability, and
reversibility.

---

## The corrections (Codex's review, accepted)

Each of the above was weakened to its correct, defensible form. These corrections are the
real result of the session and must survive into any future entry.

1. **Residuation is overstated.** Monus co-residualizes *addition*
   (`a ∸ b ≤ c ⇔ a ≤ b + c`); session `⊸` residualizes *tensor*
   (`a ⊗ b ≤ c ⇔ b ≤ a ⊸ c`). Different operations. A semiring-with-monus is not a
   residuated lattice or a `*`-autonomous category. The connection to the many-valued world
   that *does* survive is an **enrichment** fact, not a residuation identity: quantale-
   enriched categories are the common home of fuzzy-logic truth-degrees and *idempotent*
   provenance semirings (tropical / Boolean / Łukasiewicz / PosBool). The universal `ℕ[X]`
   is **not** a quantale, so even that holds only for the idempotent specializations.
2. **`S`-semimodule sheaves do not follow from the literature.** The literature is
   `K`-relations (tuples annotated in `K`). `S-Mod` does not generally give the
   `*`-autonomous + finite-product interfaces R4 needs. "Cheapest and deepest" was unearned.
3. **Provenance does not subsume information cohomology.** Entropy is not a semiring
   homomorphism; substituting probabilities into a provenance polynomial computes
   probability only under independence/disjointness. Layer 5 *consumes* provenance; it is a
   distinct measurement.
4. **"Descent-with-witnesses" is an analogy, not an identity.** Descent concerns compatible
   local sections and their canonical reconstruction; provenance concerns alternative and
   joint derivational dependencies. Provenance can *annotate* descent; it is not what the
   sheaf proof discarded.
5. **Proof-relevance needs decategorification language.** `ℕ[X]` records combinations and
   counts of derivations, not proof terms or higher paths. It is a *decategorified*
   operational shadow of proof-relevance — not yet evidence for `Allow ⊣ Require`. (The
   honest categorified end would be `Set`-/category-valued profunctors, not `ℕ[X]`.)
6. **No-leak is not automatic — it is an against-the-grain Hoapa commitment.** Standard
   provenance (W3C PROV) *records agents and responsibility*. Hoapa deliberately restricts
   trusted provenance tokens to **event / document / artifact / protocol / derivation**
   identities, never actor identities, and owes an explicit erasure/pseudonymization
   boundary plus a no-leak proof. This fights the grain of the literature and must be
   **foundational (v1)**, not bolted on.
7. **Retraction does not need monus (in the common case).** Withdrawing a source and
   re-evaluating a *positive* query is just setting that token to `0` in a `+`/`×`
   expression — no monus. Monus is needed only when the *query language itself* has
   difference/negation (cf. SQL `EXCEPT`; ProvSQL uses monus there). So the negative-
   information frontier (Portone–Petreni–Tannen) belongs to **v4**, not to the basic
   reversible-import story. *(This corrects an explicit earlier claim made in-session to the
   instigator that said the opposite.)* Also: evaluation-at-zero *identifies* which
   justifications vanish; it does **not** perform the repair — patch/update machinery must
   decide whether affected artifacts are removed, recomputed, detached, or left conflicted.
8. **Do not conflate Pijul with HPT.** Homotopical Patch Theory (Angiuli, Morehouse,
   Licata, Harper, JFP 2016) models Darcs-style patches as invertible *paths* in a HIT.
   Pijul is an append-only graph of changes with alive/dead edges, contexts, and
   dependencies (its theoretical basis is Mimram–Di Giusto's pushout model, arXiv:1311.3903,
   *not* HPT); `unrecord` removes a change only with its dependents and does not touch the
   working copy unless asked. The constructive stance: **Agda formalizes an abstract
   accountable-change interface** (HPT and Mimram as formal *resources*), and **Pijul is
   required to *refine* that interface, checked** — never identified with it.
9. **The interface "theorem" is false as an identity.** The honest target is a *conditional
   commutation* law (see Resolution).

And the five import properties are **coordinated by**, not *provided by*, provenance:
provenance supplies origin/dependency; typed mappings establish separation; stable artifact
interfaces enable reuse; overlays/patches enable editing; version/update semantics enable
reversal.

---

## The two-faced reversibility

The clarifying move of the session was to see reversibility as living on **two distinct
axes**, each its own concern, joined at an interface:

- **External face — provenance (derivational).** Cross-protocol derivation and authority.
  Reversal along the *dependency* axis: retract a premise / un-import a concept.
- **Internal face — patch theory (temporal).** Local history, editing, conflict. Reversal
  along the *time/version* axis: undo a change, with unaffected independent changes left in
  place.

The seam, stated honestly: the two dependency graphs are **distinct but explicitly
related**. An import change carries (or references) the external provenance record; every
local bridge/overlay then depends on that import change. Provenance is the semantics
("what depends on what, and how"); the patch substrate is the transport (stores those
dependencies, makes undo and conflict first-class).

---

## Resolution — the Audit layer (candidate)

> **Accounted Artifact / Audit Layer** (provenance + accountable change)

The name audits *artifacts*, not actors, and avoids presenting provenance as sufficient by
itself.

**Placement, if adopted.** A rung between Hybrid and Reflexive:

```
Hybrid → Audit → Reflexive Π → Bulk Λ → Field dynamics → Federation
```

The Audit layer **annotates and extends** descent. Its *provenance face* is a cheap,
early-buildable refinement of the already-shipped finite descent; its *temporal face* and
the editable/reversible-import capability go beyond descent. A basic cited-import prototype
can be built early; editable reversible imports require the temporal account too. Full
Π/Λ/field dynamics are *not* required for that prototype.

**Trade-off.**

```
clean, reusable artifact   ↔   reconstructable, accountable artifact
```

**Strategy.** Separate the live artifact from its *account*; split the account into a
**derivational** face (provenance tokens, expressions/circuits, external dependencies) and
a **temporal** face (local changes, versions, dependencies, conflicts, resolutions); and
reconnect them through explicit coherence laws. This is the project's primitive move
(separation of concerns) applied *twice on orthogonal axes inside one layer*.

**The defining interface law.** Not an identity but a *conditional commutation*:

```
materialize(recompute(provenance[x := 0]))
   ≃
incrementally-retract(materialize(provenance), import-change x)
```

with supporting laws to be designed: dependency adequacy, unaffected-change locality,
non-retroactivity, materialization soundness, origin preservation, no-leak erasure, and
observational equivalence of the two resulting protocol states. This law *is* the content
that makes the two faces one capability; it should be presented as a target theorem whose
exact types remain to be designed, not as established fact.

**Ownership.** Audit owns the minimal **accountable artifact/change substrate**. Π
*consumes* it (for reflexive modification, adaptation, consensus, promotion). This is
cleaner than splitting the patch object by operation ("Audit owns inverses, Π owns
pushouts"): one substrate, one home, consumed upward.

**Import lifecycle to cover.** produce once → publish an accountable artifact → adopt via a
typed import → perform only the local bridge conversation. Plus: mirror, update, retract,
detach, fork, rebase, local overlays.

**The honest cost guarantee.**

> Audit makes the affected dependency cone **computable and localized**; patch theory lets
> unaffected work remain in place.

It does **not** guarantee the cone is small, that semantic repair is cheap, or that the
human cost of repairing a bridge is predictable. "Know the exact reversal cost" is too
strong; the honest claim is "identify and bound the structural blast radius."

**No-leak divergence (foundational).** Record explicitly that Hoapa departs from standard
provenance here, with a proof obligation. Required distinctions to keep straight:

```
stable identity  ≠  content addressing
content addressing  ≠  authenticity     (content-addressing gives integrity, not authenticity)
provenance  ≠  authorization
integrity  ≠  trust
```

Stable identifiers are required; content hashes are *helpful but not mandatory*, and do not
by themselves solve schema evolution, semantic equivalence, redaction, or authenticity.

**Staged roadmap (algebraic stages kept separate).**

```
v1  positive provenance circuits, evaluation, stable tokens,
    descent compatibility, erasure / no-leak
v2  abstract accountable-change interface, typed imports,
    materialization, dependency adequacy, locality
v3  update / retraction workflow; conditional commutation with internal changes
v4  difference / negation via monus and other genuinely nonmonotone operations
```

A generic-semiring v1 must **not** promise deletion semantics that require stronger algebra
or an incremental-update model. Quantale enrichment, enriched profunctors, and categorified
proof-relevance are **later specializations, not v1 foundations**.

**Categorical landscape (no single construction owns the layer).**

- semiring provenance — derivational accounting;
- Spivak-style functorial data migration (`Σ ⊣ Δ ⊣ Π`) — typed import / translation and
  *structural* lineage (not semiring how-provenance);
- categories of elements / Grothendieck fibrations — token organization (the cheapest
  faithful home of "indexed annotation over tokens");
- enriched profunctors / `K`-matrices — the clean form for *quantale* specializations only;
- Spivak's *Functorial Aggregation* (Poly) — later cost/aggregation work; note Spivak's own
  finding that aggregation resists naive functoriality, so it is a beast, not a starting
  point;
- lenses / optics (and Chu/Dialectica) — update propagation, adjacent to the Care axis; not
  lineage itself.

---

## Deferred-integration checklist (do NOT execute now)

Recorded so that Codex's integration thinking is preserved without being enacted. If and
when this layer is adopted (post-R4, if proven useful), integrating it would require:

1. **Catalogue restructure** in `future_work.md`: "five layers" → six; insert Audit as the
   new Layer 1; renumber current 1–5 → 2–6 *(open: renumber vs. call it "Layer 0")*. Update
   the dependency paragraph and summary table.
2. **Main entry** in the established Function / Math-anchor / Trigger rhythm, carrying the
   Resolution content above.
3. **Downstream consumers** updated: Π consumes Audit's change substrate; Λ preserves
   concept lineage; field dynamics may inspect accounts but does not define them; Federation
   uses typed accountable imports and partial mirrors; information cohomology measures/
   consumes provenance but is not subsumed by it; glossary gains *Audit*, *provenance token*,
   *materialization*, *accountable change*.
4. **Patch-theory ownership** clarified: the accountable-change substrate sits below Π,
   owned by Audit and consumed by Π.
5. **Implementation track** revised: trace kernel gains artifact/version identifiers,
   provenance-circuit references, import records, translations, certificates. Likely Agda
   slots: `Concurrency/Protocol/{Provenance,AccountableChange,Materialization,NoLeak}.agda`.
   Elixir emits structured provenance events by construction (no new language forced); the
   checker validates them; Pijul-shaped persistence stores local changes/conflicts; typed
   documentation provides stable identities and explicit references.
6. **Companion edit** to the compact cascade in `motivation.md` (the trade-off table), made
   *together* with the `future_work.md` change so the two catalogues do not disagree.
7. **Separately** (pre-existing, unrelated to provenance): the reader's note in
   `future_work.md` is now stale — it says the implementation track is not catalogued there,
   though it is. Fix on its own, not bundled with this.

`arc_progression.md` and other historical files are *not* to be rewritten.

---

## Open questions / decisions to settle before adoption

- Final layer name (working: *Accounted Artifact / Audit*).
- Renumber to six layers vs. "Layer 0".
- Rung vs. cross-cutting framing — current answer: a rung whose two faces are *consumed*
  cross-layer (cross-cutting in consumption, localized in construction).
- Construction target after v1: separate fibration vs. `V`-enrichment vs. R4-lift — current
  lean: token-indexed fibration first, enriched-profunctor as target, `V`/R4 only if the
  quantale case earns it.
- Representation: circuits / shared DAGs (as ProvSQL) are the right default over expanded
  polynomials or a writer monad.
- Which semiring first: generic positive commutative semiring (circuit form), with
  idempotent/quantale specializations deferred.

---

## Status footer

This is **post-R4 roadmap material** and a **candidate** only. The R4 exposition remains the
live priority. Nothing in the live catalogue (`future_work.md`, `motivation.md`,
`status.md`) was changed by recording this. Fold in later, deliberately, if it materializes
as truly useful — using the checklist above.
