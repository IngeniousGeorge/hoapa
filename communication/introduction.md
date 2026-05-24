# Polyphony

> *A mathematics-backed framework for communication protocols in which every participant is treated as an equal, the diversity of their perspectives is presumed, and the discipline of their exchange is held to the standard a sheaf-theoretic universe expects of itself.*

---

## What this is

This project tests a single conjecture, expressed in two registers — one formal, one applied.

**Formal.** Modal homotopy type theory, specifically in its cohesive ∞-topos form (Lawvere–Schreiber–Shulman), is the natural setting not for mathematics-as-foundation but for **mathematics-as-praxis** — the practice as Grothendieck described it in *Récoltes et Semailles* and Hersh in *What Is Mathematics, Really?*: dialogical, distributed, typed, mutually correcting. The classical use of HoTT as a foundation of mathematics — replacing or refining the role of set theory in the formal substrate of the discipline — is correct on its own terms but addresses the wrong problem if what one wants to understand is how mathematics is *done*. The praxis is not a finished proof. It is a community of partial views adjusting one another toward a moving consensus.

**Applied.** A communication protocol — between humans, between large language models, between any combination of typed-information-exchanging agents — admits a precise statement of its desirable properties: every participant's view is consistent with every other's where they overlap (sheaf descent); typed obligations are met before being discharged (linear session typing); no semantic difference exists between two protocol states that all participants observe as equal (separatedness); a closed sub-conversation does not silently become an agent in a larger one (a discipline on promotion). These properties are formalisable. The kernel needed to formalise them is the *same* mathematical object as the cohesive ∞-topos in the formal register.

That a community-of-equals-exchanging-typed-information is the *same* category-theoretic object as a particular modal type-theoretic setting is the conjecture this project is built around.

---

## Where we are

The work is in cubical Agda. The two formal legs of the conjecture are built as independent modules; the cross-leg comparison theorem — which would be the project's first non-trivial mathematical statement — is conjectural and not yet stated. The current scope is roughly twenty Agda modules, in the neighbourhood of three thousand lines of formalised mathematics, all type-checking under `--cubical --guardedness`.

### Leg A — the modal side

A formalisation of cohesive HoTT around the site `Bℤ` (the delooping of the integers as a higher inductive type), with the modal adjoint triple `ʃ ⊣ ♭ ⊣ ♯` (shape, flat, sharp) and, eventually, the differential cohesion rung `ℜ ⊣ ℑ ⊣ &` (reduction, infinitesimal shape, formal smoothness). What has shipped:

- The flat cohomology layer with named coefficient computations.
- A fracture theorem stated relative to its load-bearing assumptions (which are postulated rather than discharged from below — appropriate citations to Shulman, Wellen, and Myers).
- An iteration scaffold: the developing network `N_∞ A` of a type along the unit of any modality, formalised as the sequential colimit of `A → TA → T²A → …`. This is the structure that, on the conjecture, becomes the *iterated* shape of a long-running dialogue.

This leg is currently on pause; bandwidth has shifted to leg B, where the active reframing has been most productive.

### Leg B — the concurrent side

A category of *actor-causal frames* glued together by sheaves of *session types*. The site is built bottom-up, with strict separation between the carrier (who participates, in what causal order) and the typed content (what is being exchanged).

- **Actors are opaque and unityped.** No constructors distinguish a human from a large language model from a promoted sub-conversation. The verified communication kernel cannot branch on actor origin. This is the mathematical form of the political claim *participants are treated as equals*. (`agda/Concurrency/Sites/ActorBase.agda`.)

- **Causality is Lamport partial-order.** Events have a happens-before relation; that and the standard reflexive/antisymmetric/transitive proposition-valued discipline is the entire content of "time" in this kernel. No Lorentzian signature, no event structure, no privileged clock.

- **Local frames are sub-views, not totalities.** A frame is an actor-membership predicate plus a causal sub-order; a frame morphism is a strictly causality-reflecting embedding. The strictness is load-bearing — it ensures that the "promotion" of a closed sub-conversation into a single node of a larger one is *not* a frame morphism. Promotion is a different (deferred) class. (`Concurrency/Sites/ActorCausal.agda`.)

- **Covers are basis-form, with the sieve form available as a bridge.** A non-trivial witness with two actors and a Bool-event order is shipped; pullback-stability is currently the one named postulate inside the site kernel.

Layered on top of this substrate is an **interaction algebra**. A small cyclic operad `O_1` is formalised: one binary generator (the actor's send/receive across a channel), a cyclic action on three ports (sender / receiver / channel — the trinion), and full cyclic equivariance. The cyclic involution at the boundary derives, as a theorem, the linear-logic duality `S ↔ S^⊥` — the mathematical form of the symmetry *the sender of `S` is the receiver of `S^⊥`*. (`Concurrency/Operads/`.)

Algebras of `O_1` interpret the operad's grammar into a target category. A target signature `StarAutonomous` (a thin axiomatisation of `*`-autonomous categories — the categorical semantics of multiplicative linear logic) and its first concrete inhabitant `Sessions-Cat`, built from multiplicative session-type syntax (Caires–Pfenning lineage, without the full proof calculus), ship the typed-content layer. Both faces of the duality theorem `S ≡ S^⊥⊥` are present in Agda — the syntactic involutive duality on session types, and the categorical / operadic boundary-swap induced by cyclic equivariance. (`Concurrency/Algebras/`.)

The most recent layer, shipped during the week this document was drafted, is the first **adapter** between the actor-causal locality and the session-typed content: a frame-presheaf chassis valued in any `*`-autonomous category, specialised to session types, with a zero-postulate property record for the auditability half of descent. It implements the first of seven adapter slots connecting the two parts of the framework. (`Concurrency/Hybrid/{Presheaf,SessionPresheaf}.agda`.)

### The conjectural centre

If the central theorem of the project lands, the relation between leg A and leg B is an adjoint triple

> **Allow ⊣ Mediate ⊣ Require**

between cohesive modalities on the A side and adapter operations on the B side. The Lawvere fixed-point asymmetry between the two sides — the modal side is *rigid* in a precise categorical sense, the actor-causal-sheaf side is *fluid* — is what prevents the iterated `Require ∘ Allow` from collapsing to a single fixed point. Each iteration adds a layer of perspective; the limit object is the developing network of a long-running dialogue, in which local conversations have descended into a globally coherent body of typed content, in turn becoming the material for new local conversations.

The full theorem is downstream of:

- Full sheaf descent on the actor-causal side (the next active piece of work, immediately after the just-landed restriction adapter).
- The differential cohesion rung on the modal side. Originally held as a rhetorical layer beyond the named-coefficient tautology, now elevated to load-bearing: the operadic side's natural infinitesimal structure (formal smoothness on the moduli of curves `M̄_{0,3}`, where dessins and Belyi pairs live) needs an A-side infinitesimal layer to talk to.
- A precise statement of what the cross-site adjunction *says* in each modality.

We do not yet claim this central theorem. We claim that the scaffolding necessary to state it is being built honestly, in Agda, with the gaps named where they live and with the parts that *are* mathematically interesting on their own — the cyclic operad of actor interaction, the session-typed restriction adapter, the modal iteration scaffold — surviving as mathematics regardless of whether the central conjecture is reached.

---

## What's at stake

Several disciplines have something to recognise in this work, and we expect each to find a different point of interest. The unifying claim is that the *domain* of the project is not a discipline. It is the network of disciplines themselves. Said more concretely:

- **For category theorists and HoTT readers.** The framework is a concrete use of modal / cohesive type theory for something the cohesive ∞-topos community has long argued should be possible: a categorical description of an active scientific community as a moving cohesive object. The cross-site adjunction, when stated, would be a candidate for the first machine-checked theorem of mathematics-as-praxis in the Grothendieck–Hersh sense.

- **For concurrency theorists and operationalists.** The actor-causal-sheaf substrate is a clean, unityped, fully formal foundation for actor and session-type semantics that is independent of any particular process calculus. The cyclic operad `O_1` is, to our knowledge, the first machine-checked operad whose binary generator coincides with the actor's send/receive primitive and whose boundary involution coincides with linear-logic duality.

- **For operadic and moduli readers.** `O_1` is staged toward its modular envelope `MO_1`, which would be a small machine-checked computational realisation of the modular operad world — Getzler–Kapranov for `Ass_cyc`, ribbon-decorated `M̄_{g,n}`. The eventual evaluation at genus zero with three marked points is the natural home of dessins d'enfants, Belyi pairs, and the Grothendieck–Teichmüller-group action — the same `(g, n) = (0, 3)` neighbourhood the *Esquisse d'un programme* points to.

- **For programming-language and verification theorists.** The whole construction reads as a formal kernel for a *protocol verification system*. A typed communication protocol between distributed agents — humans, large language models, or any mix — admits formal invariants (separatedness, descent, no-leak, controlled promotion) that a verified kernel can enforce. The framework is, at the engineering level, the mathematical justification for such a kernel. The Hybrid layer's seven adapter slots name the engineering surfaces directly.

- **For philosophy-of-mathematics readers.** The project is, in part, a constructive engagement with Grothendieck's claim that the universe is sheaf-theoretic and with Hersh's claim that mathematics is community-of-inquiry. The conjecture is that the two claims become the same statement when the formal kernel is in place — and that the implications run further than either Grothendieck or Hersh stated, into a precise account of how disciplines compose without any single one being privileged.

The cross-cutting commitment is **omnidisciplinarity**. The project does not belong to any of the disciplines above. Each contributes something it needs; none describes its centre. The bet is that omnidisciplinarity is a coherent intellectual stance, not a slogan — and that a sufficiently honest formal account of *how* the disciplines compose can be built, in code.

---

## What we are asking for

This project is opening to contribution. The single ask is plain: **come and participate, philosophically, as a unityped participant**. The project's own discipline applies to its own development — a contribution is the contribution of an agent who exchanges typed information with the rest of the community over the site that *is* the project itself.

That declines into a list of concrete forms a contribution might take. None is privileged.

- **Advise and consult.** Specific stuck points are documented in `workflow/status.md` and `workflow/future_work.md`. Weighing in on, for example, the choice of differential cohesion rung, the canonical derivation of the `O_1` action from richer session-categorical structure, or the right formulation of the cross-site adjunction, is real help.
- **Review and co-author.** Pieces of the project will eventually need to be written for publication. The conjectural central theorem is collaborative work.
- **Implement and extend.** Six of the seven adapter slots in the Hybrid layer (descent, unit-dualising bridge, operadic valuation, promotion, modal cross-site, no-leak) are sized for individual contributors. Full sheaf descent on the actor-causal site is the next live piece.
- **Build the applied side.** A protocol-verification system on top of the formal kernel — running over Git, Pijul, or a fresh substrate, layering typed sessions on pull requests, requests-for-comment, and merges — is a substantial software project that would put the kernel to work. We have ideas; we do not have an implementation.
- **Fund or institutionally host.** The project's bandwidth is currently one engineer plus two AI agents. Institutional time, even at lightweight consulting cadence, would change the timeline of the central theorem materially.
- **Pass it along.** Many of the readers who would do well by this work are not the readers who will first see this document. Sharing it with the right person is itself a contribution.

The mechanics of how contribution proceeds, what the discipline of disagreement looks like inside the project, what the durable artifacts of contribution will be — these are themselves part of the subject matter: they are what the verified protocol kernel is intended eventually to instantiate, for itself. In the meantime, the practical contact path is the repository.

---

## A wider frame

The project is a bet that omnidisciplinarity is the right register, not as an attitude but as a structural commitment.

The bet has internal evidence behind it: when the formal work is followed seriously, the two-leg structure (modal A, concurrent B) is *forced*, the cross-leg adjunction is forced, the centrality of the dialogical pattern (descent, modal iteration, Lawvere asymmetry) is forced. None of this is imported from any single discipline. All of it is recognisable to multiple disciplines once it is in place.

There is a long line of thinking behind it — Grothendieck's sheaf-theoretic universe, Peirce's community of inquiry, Pask's conversation theory, more recently Caires–Pfenning's linear-logic concurrency, Shulman's cohesive ∞-toposes, Joyal's tribes and clans, the proof-theoretic semantics community's work on dialogue games. The project does not claim originality in the insight that disciplines are perspectival and that disciplines compose. It claims that a sufficiently honest formal statement of *how* they compose — what the mathematics actually has to be — is being built, in machine-checkable form, with the gaps named where they live.

If the conjecture lands, the consequence is concrete: a mathematical statement of what an open community of equals exchanging typed information *is*, with enough internal structure that one can build verified communication protocols on top of it. The political reading — that no agent's perspective is foundationally privileged, that specialisation lives in the documentation rather than in the type of the agent — is downstream of the mathematics. It does not need a separate justification once the mathematics is in place.

If the conjecture does not land, the partial results — the formalised actor-causal site, the cyclic operad with derived session duality, the modal iteration scaffold, the restriction adapter and the rest of the Hybrid layer as it grows — survive on their own. They are mathematics. They contribute something to category theory and to formal concurrency regardless.

That is the floor. The ceiling is a precise account, in cohesive type theory, of what disciplined dialogue between unequals who deserve to be treated as equals actually *is* — what it is mathematically, and what it asks of any artefact (a paper, a protocol, an institution) that pretends to host it.

---

## Provenance and authorship

The project's human engineer is **Jean-Charles Belouard** ("Ingenious George"), who has spent six years building and studying communication protocols and working in dialogue with the philosophical-mathematical tradition above.

The formalisation in Agda — and a substantial fraction of the structuring decisions documented in `workflow/` — was developed in collaboration with two AI agents over the past six months:

- **Claude** (Anthropic) — primary partner in the Agda development, in workflow architecture, and in this document.
- **Codex** (OpenAI) — primary partner in cross-checking, in critical review, and in the pedagogical companions to the Agda code under `pedagogy/`.

This is not an authorship-by-AI claim. The mathematics is checked by Agda; the conjectures are decided by Belouard. The agents' contributions are visible throughout the repository (the `workflow/deep_context/arc/` conversation logs, the per-file decision trail in commit messages) and are credited accordingly.

A formative external piece of feedback came from **Fernando Zalamea** (Universidad Nacional de Colombia), Grothendieck scholar and recipient of Colombia's *Premio Nacional de Matemáticas* (2025). His February 2026 recommendation letter, alongside this document in `communication/`, names the project's earlier framing and the trajectory it has continued along.

---

## Repository layout

- `agda/` — the formalisation in cubical Agda.
  - `agda/ModalHoTT/` — leg A (modal / cohesive HoTT around `Bℤ`).
  - `agda/Concurrency/` — leg B (actor-causal site, cyclic operad `O_1`, session-typed values, Hybrid adapter layer).
  - `agda/Analytic/` — an analytic mirror of leg A, documenting non-vacuity in a concrete model.
- `workflow/` — live state, motivation, target propositions, decision logs, deep-context conversation archives.
- `pedagogy/` — narrative companions walking the Agda code chunk by chunk (in progress, with Codex).
- `communication/` — outward-facing material, including this introduction and the Zalamea reference letter.
