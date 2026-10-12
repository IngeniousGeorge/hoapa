# Separations, integrations, and adapters

*An inventory of how Hoapa separates concerns on its concurrency side K, which integrations those separations are hoped to enable on its world/context side M, and which adapters connect the separated structures inside K. Written by Claude; Codex is writing a parallel version independently, and the two are meant to be compared rather than merged. `communication_drafts/` is normally Codex's surface, so the file name says whose pass this is.*

This document is meant to be read without the repository. It therefore repeats, in its own words, material that lives in `motivation.md`, `architecture.md`, `naming.md`, `openings.md`, `future_work.md`, `targets.md`, `status_formal.md`, `status_implementation.md`, `related_structures.md`, `bias_correction.md`, and the arcs (chiefly 02, 06–13, 17–21), as they stood on 2026-10-12. Where the text says "the code", it means the cubical Agda development under `formal/`; where it says "the runtime", it means the Elixir umbrella under `runtime/`. Pointers to sources are given so that a reader who does have the repository can check each claim. The mathematics is not explained; what is explained is what the project does with it.

---

## How to read this inventory

### The conjecture, in the form that matters here

Hoapa is trying to state, and eventually prove, a conjecture about the development of mathematics taken as a collective practice: that there is a universal-property account of why organizations of a certain disciplined kind, Hoapa among them, are especially adequate to their contexts and to the generation of new contexts. The two sides are named **K**, communities of actors with explicit causal structure whose contributions carry session types, and **M**, the world or context side. The candidate correspondence is a pair `Allow : M → K` and `Require : K → M` with `Allow ⊣ Require`. Neither functor is constructed.

Since 2026-09-26 the conjecture has been held in a *renewed* form. The earlier plan prescribed M as a cohesive ∞-topos (originally over the delooping Bℤ) and was abandoned after the synthetic signature used to explore it turned out to make every type flat-modal: unrestricted `flat-intro` together with dependent `flat-ind` proves that the flat counit is an equivalence for every type. M is now to be *discovered*: by extracting K's categorical essence, comparing it with meaningful alternatives and with independent siblings in other sciences, and seeking a comparison structure in which a class of organizations containing Hoapa is distinguished. The primary target is relational adequacy (`targets.md` §T_comparison), not "K is the best architecture".

This reorientation is why the present inventory matters. If M is to be discovered from K, the question "what does K actually separate, and what do those separations make possible?" stops being architectural bookkeeping and becomes the generator of the research programme. The project's current organizing sketch for that generation, the *mirror*, is stated in Part II.

### Separation of concerns as the primitive move

The project's own claim (`motivation.md`, "The cascade of trade-offs") is strong: separation of concerns is not an engineering principle the framework happens to use, but its primitive architectural move, applied recursively from the foundations upward. Each structural layer is presented as the response to a trade-off that the previous layer's resolution exposed, and each response has the same shape: distinguish the responsibilities in tension, and seek a precise interface between them. Whether two responsibilities need separate mathematical carriers is something to be earned, not assumed.

The second foundational commitment is equal standing: every participant plays by the same rules, and the system treats all message carriers identically. The project calls this *unityping*: the system that handles messages can distinguish types of messages but cannot distinguish their carriers. Most of the separations below are, in one way or another, mechanisms for letting knowledge differentiate without letting that differentiation flow back onto the people who produced it.

### Three axes

Since a decision of 2026-09-12 (`architecture.md`, "Three independent axes"; `status_formal.md`, decisions log), the project keeps three axes apart:

- **Levels** say what may occupy the active positions of a conversation. Level −1 is a real conversation among participants; at level 0, documented conversations and their outputs occupy the subject positions of a new level −1 conversation; the pattern can recur.
- **Layers** separate responsibilities within what is represented: session orchestration, content and provenance, identification and conceptual variation, reflexive protocol change, dynamics and measurement, Federation. A layer is not a temporal stage and need not be a runtime process.
- **Adapters** relate structures across a separation of concerns: restriction, descent, change of value, promotion, the conjectural `Allow ⊣ Require`, no-leak. They are relationships, not further levels or layers.

The three questions this document was asked to answer sit across these axes. *Separations* are mostly layers, plus distinctions that are not layers at all. *Integrations* belong to the M side and to the relation between M and K. *Adapters* are the third axis itself.

### Two senses of "separation"

The word is used in two senses that should not be confused, and this inventory keeps them apart:

1. A **responsibility separation**: two jobs in tension get distinct carriers or interfaces. The cascade of layers is made of these.
2. A **preserved distinction**: two things the system refuses to identify, even when they share endpoints or representations. Contributor versus contribution, causal dependence versus conceptual equivalence, live versus public record. Most of these are not layers.

The mirror of Part II draws mostly on the second sense. Section 19 returns to this.

### Status vocabulary

The project is strict about evidence, and this inventory follows it:

- **checked**: machine-checked in Agda, always relative to stated hypotheses and postulates;
- **specified**: fixed by the architecture, not yet implemented;
- **selected**: on the roadmap with a named forcing case;
- **committed responsibility**: a job the architecture must account for, without a chosen mathematical carrier;
- **candidate**: worth testing, with named obligations;
- **horizon**: a research direction without a bounded task;
- **rejected identification**: something explicitly ruled out, usually in `bias_correction.md`.

A *control* is a comparison case used to test what an account distinguishes. A checked instance that collapses is a control, not evidence.

---

# Part I — Separations on K

## 1. The founding separation: unityped carriers, typed contributions

### Origin

The concurrency side was given its anchor in arc/02. The instigator wanted one proposition "for free, or as low-hanging fruit": that typed data (in the sense of session types) and unityped agents (in the sense of Hewitt's actor model) follow separation of concerns, in the sense of modularity and clean code. The demand was that this separation be **structural rather than provable**.

The resolution was the *hybrid*: a Grothendieck site of actor-causal frames, with Caires–Pfenning session-type structures as the values of sheaves on it. Agents live in the base topology; typed data lives in the values; modularity is the gluing condition. On this construction the separation is definitional. The trade-off was recorded at the time: a single framework would have been cheaper to set up but would have left the separation as a theorem to prove, possibly with caveats; the hybrid costs more scaffolding and buys the separation as structure.

The actor model's locality principle (no global state, no global clock, each actor with its own frame, causality only through message passing) was read as general-relativity-inspired and supplied the topology. Of three levels of causal specificity considered (Lamport partial order, event structures, Lorentzian sheaves), the simplest was chosen as a starting point, the others kept as regulative.

### What it became

- `ActorBase` is an opaque, unityped carrier: no constructors, no origin tags, no roles, no message syntax, no fresh-name operation, no decidable equality in the kernel. A person is not a kernel type.
- Typed content lives in the value category of presheaves on the actor-causal site, first `Sessions-Cat`, now also `Chu(SET,Bool)`.
- The separation is also enforced as an *import discipline*: the actor-site modules import neither session syntax nor the operad, and the Hybrid chassis imports neither the operad nor `Sessions.agda`.

### How the project reads it

The Lautman-facing interpretation (`related_structures.md`, "Lautman — analytic/synthetic decomposition") takes **understanding of the world** as the thing decomposed, existing in two realms. Embodied understanding, distributed among participants, is organized *predominantly synthetically*: Lautman's dimensional decomposition, articulation according to a common plan supplied by the whole, here the uniform actor interface. Documented understanding is organized *predominantly analytically*: Lautman's proper decomposition into constituents specific to what is understood, here typed concepts and their relations.

Both moments occur in both realms, and the reading is not an assignment of synthetic to K and analytic to M. Documentation *aspires* to become synthetic, by furnishing common languages for later work. The contrary political pressure makes participants analytic in the organizational sense: classifying people by their products and fixing them into specialties and hierarchies. The architectural response is to let knowledge differentiate without letting its classifications determine the formal standing of its producers. The test case is concrete: a rival that fixes everything else but lets documentary output determine a participant's right to occupy a seat or exercise authority violates Hoapa's intended interface. A rival in which different contributions receive different assessments, while producers keep equal standing, does not.

A sharper Lautmanian reading was put forward in arc/20 and is worth recording: Lautman does not want a permanent classification, but mathematical theories in which the relation between the poles becomes an internal problem. On that reading, the object to formalize is not "participants are synthetic" but the *passage*: an artifact analytically articulated becoming a common plan for later work.

### A precursor of the mirror

Arc/09 paired this separation with a condition on the other side: "separation of concerns" on K and "sufficient complexity" (Manin's sense) on M were proposed as the two faces of the conjecture's single "if", and both were identified with non-degeneracy of the unit. The same arc also observed that the actor/data separation is internal to K (in effect an internal fibration of K), not one of the cross-site functors. Arc/16 later replaced the proposed inference with explicit proof obligations (the non-collapse ladder of `targets.md` §T3), and the cohesive M it relied on is retired. The pairing of a K-side separation with an M-side capability survives, transformed, as the mirror.

## 2. The foundational floor

Below the layers, the project names separations it treats as foundational rather than as responses to a trade-off (`motivation.md`; `openings.md`, "Reality"):

- **actor versus content**, on K: section 1;
- **context versus system**, at the proposed correspondence: M and K are kept distinct, and M must not be reduced to commentary on K, nor K to a projection of M (`targets.md` §T6);
- **reality versus protocol**, proposed in arc/11 as a further floor-level separation, the instigator's "level −1";
- **spatial versus discrete**, on M: the legacy cohesive version, now retired with the cohesive prescription. `motivation.md` currently writes "contextual distinctions still to be identified on M" in its place.

### Reality as constitutive exterior

Reality is described as present by its absence. Negatively, nearly every "the kernel must not do X" is an unnamed invocation of the reality/protocol boundary: unityping, no-leak, actor-origin metadata living outside the kernel, availability-only delivery, non-enactment. Positively, Reality is where perspectives are formed: agents explore it from a secure base (in the attachment-theory sense), the protocol is where formed perspectives meet and glue, documentation charts Reality, and care returns secure bases to it. The loop is explore → glue → document → care → new secure base.

The boundary carries one barrier on the **identity channel**, working both ways, while the **contribution channel** passes freely:

- outward, *no-leak*: public documentation does not encode who an actor is;
- inward, *anti-distortion*: who an actor is does not bias how their contribution is received.

The second direction is the original motivation of the project (hide the experts so the reasoning stands on its own).

The prescribed discipline is an *open-system interface, never an internal sort*. Reality's whole formal footprint is the set of operations that cross the boundary (request, demand, buffered entry, availability-only pull) and the negative constraints that do not cross it. In a call-by-push-value idiom: `P → Request(R)` exists and `P → Effect(R)` does not. "Openness at the top" (no topos of all topoi) and "non-enactment at the bottom" (no protocol encloses or controls Reality) are presented as one refusal to totalize, stated at the two ends of the construction.

Status: candidate under evaluation, recorded in `openings.md`, with no Agda module. The panel draw is named as the concrete entry mechanism: an injected sampler consults an entropy source outside the trace to select from an eligible population that also lives outside the trace.

### The surface

Arc/18 generalized this boundary into the **surface**: the separation between reality and the system designed to understand it, which both separates and connects. It is an organizing image, explicitly not an ontological hierarchy, a temporal arrow, or a prohibition on intervention. The surface matters in this inventory because it is where Part I's separations and Part II's integrations are supposed to meet, and because, as a Claude remark in arc/18 put it, the project's hardest unproven obligations cluster there: the closure transform, no-leak, and the live/public split. Section 20 checks that remark against the adapter inventory.

## 3. The cascade of trade-offs: the layers

### Two presentations of one cascade

There are two presentations, and they differ in a way that matters.

`motivation.md` gives a seven-row table of layers or responsibilities, each with the trade-off it navigates and its strategy: Hybrid, Reflexive Π, Bulk Λ, conceptual variation within Λ, field-theoretic dynamics, Federation, information cohomology. It frames the sequence as *generative*: each layer's problem exists only because the previous layer was resolved.

`openings.md` gives a numbered catalogue of five layers (1 Π, 2 Λ, 3 dynamics, 4 Federation, 5 information cohomology). It treats Hybrid as the shipped substrate rather than a numbered layer, and places conceptual variation inside Λ. It also says explicitly that the conceptual build order is not the implementation order. Federation's exchange constraints must pressure-test the artifact interface early, and Λ is opened by closure evidence before any Reflexive Π exists. The dependency picture is a partial order, not a staircase: Hybrid and the runtime contract feed Π and Λ; Λ supports dynamics and measurement; Federation consumes those layers and constrains their public boundaries early.

A further candidate layer, provenance and accountable change, would sit between Hybrid and Π if adopted.

Behind the whole cascade stands a disciplinary commitment stated in `openings.md`: *praxis is part of the theory*. The protocol's use by a community of equal-standing participants is constitutive of the framework, not an application of it.

### 3.1 Hybrid: locality versus globality

- **Trade-off.** Actors operate in local frames; content must cohere across frames.
- **Strategy.** Sheaf descent: compatible local content glues to global content.
- **Problem it answers.** It is the first consequence of the founding separation: having separated actors from sessions, one must say how local typed content assembles.
- **Status.** The only layer with substantial checked mathematics:
  - the actor-causal site, with strict-reflecting frame embeddings and basis covers;
  - finite descent, category-generic, at both a linear value category and `SET`;
  - a finite Cubical `Coverage` and its comparison with the library sheaf condition at `SET`;
  - the point-generated sheafification reflector;
  - the point-generated Benton/LNL bridge between cartesian and linear sheaves (R4);
  - a postulate-free `Chu(SET,Bool)` coefficient witness.

  Arc/06 reframed this layer as "the adapter layer"; Part III treats it in that light.
- **Not established.** Event-dependent session content, the full actor-causal sheafification reflector, and topos or internal-logic structure for the Set endpoint.

### 3.2 Candidate: accounted artifact (provenance and accountable change)

- **Trade-off.** A clean, reusable artifact versus a reconstructable, accountable one. A protocol needs stable interfaces to use results without replaying their construction. It also needs enough account of origin and change to know what a result depends on, and what happens when those grounds move.
- **Strategy.** Keep the live artifact separate from its account, and split the account into two faces:
  - *provenance*, the external or derivational face: positive semiring provenance over `ℕ[X]`, evaluated by semiring homomorphisms;
  - *accountable change*, the internal or temporal face: patch-theoretic, with Pijul as an implementation candidate behind a refinement relation.

  The two faces are joined by a *materialization* interface whose central law is a conditional, observational commutation, not an identity:

  ```text
  materialize(recompute(provenance[x := 0]))  ≃  incrementally-retract(materialize(provenance), import-change x)
  ```
- **Motivating use.** Avoiding repeated derivation across protocols through cited, typed, retractable imports: a *partial mirror by citation*, not silent absorption.
- **No-leak divergence.** Standard provenance (W3C PROV) records agents and attribution; Hoapa's must audit artifacts, never actors.
- **Status.** Candidate. It earns layer status only if the trade-off is generated by Hybrid, the two-face separation is necessary, and the materialization laws add content not already owned by Π. Source: arc/10.

### 3.3 Reflexive Π: stability versus adaptability

- **Trade-off.** The protocol must be reliable, and it must respond to change.
- **Strategy.** Bounded meta-conversations propose later protocol versions. Acceptance publishes a new version with an activation boundary. Past conversations keep the protocol identity under which they ran.
- **History of the reading.** Arc/07 first read this very strongly:
  - Π as a category of protocol versions;
  - consensus as existence of a colimit of edit proposals in a patch-theoretic fragment category;
  - promotion as the bridge from a closed meta-conversation to a Π-morphism;
  - the genus grading of the modular envelope MO₁ as protocol versions;
  - non-retroactivity inherited from strict causality reflection.

  All of that has been narrowed. Π now names the responsibility, not a constructed category. Non-retroactivity is a contract and version property *to prove*. Consensus is not the definition of closure. The label "Reflexive Π" asserts no dependent-product semantics.
- **Forcing case.** Ordinary artifact reuse comes first, not self-modification: a closed output becomes an admissible input to further work while specified earlier achievements remain usable. Bounded protocol change comes only after that.
- **Status.** Committed responsibility; formal shape unearned.

### 3.4 Bulk Λ: expressive power versus transparency

- **Trade-off.** A rich vocabulary versus decodability by every participant.
- **Original intuition.** Arc/08: the protocol must create its own language, which is its true output. Each message carries a session tag (the "how") and a content tag (the "what"). Refinement through conversation would build a concept structure with homotopy-like links. The external seed languages assumed at the start would progressively be replaced by the protocol's own.
- **Current form.** Λ is an *interpretation of published evidence*. It distinguishes conversations (episodes), output artifacts, concept identities, and documentation versions. Dependency edges stay directed. Comparison claims are retained history; each documentation version admits a set of comparisons and builds its language presentation from that set. Only admitted comparisons may become invertible, and no global groupoid completion is assumed. Localization at the admitted set, `Lᵥ[Wᵥ⁻¹]`, is one candidate presentation, universal for interpretations that invert exactly those comparisons. Withdrawal of a comparison creates a later version and rewrites nothing.
- **Responsibilities inside Λ.** Identification, coherence, purpose-relative compression, and conceptual variation (section 3.5). Compression is adequate only when every designated observation descends through it.
- **Locators.** "Engineering" and "biology" are contexts *inside* a language, not Federation peers.
- **First forcing test.** Two incompatible claims whose authors unanimously publish an artifact saying the alternatives remain unresolved, naming an observation that would distinguish them. The evidence must keep the two claims, their disagreement, and the unanimous output as distinct facts. Documentary compatibility must become neither substantive agreement nor human assent.
- **Status.** Selected v0 forcing case; higher categorical form open.

### 3.5 Conceptual variation within Λ: stable articulation versus openness to variation

- **Trade-off.** Stabilized, graph-based articulations make understanding portable. Variation preserves access to possibilities those articulations do not exhaust.
- **Strategy.** Keep the presentations distinct from their declared admissible variations and responses under an interpretation. Continuous and infinitesimal variation is the leading target.
- **Candidate resources, kept distinct:**
  - Kock–Lawvere and synthetic differential geometry. The tangent functor `T X = X^D` preserves limits, so `T(X ×_B Y) ≅ T X ×_(T B) T Y`: variations of an assembly modeled as a pullback are compatible variations of its parts.
  - Algebraic and derived deformation theory, for organizing variations, equivalences and extension obstructions together.
- **Hypothesis.** Variation, groupoidal identification and naming may be aspects of one family-sensitive moduli structure: a groupoid `G(S)` of families and admitted equivalences for each parameter space S. Its stable "peaks" could become words.
- **Status.** Committed responsibility (2026-10-12), mathematical realization under investigation. It sits beside identification inside Λ, not in a new numbered layer. Messages do not become infinitesimals, and no smooth M is prescribed.
- **Three investigations not to confuse.** Conceptual variation, *clause variation* of candidate architectures, and *contextual variability P* on M.

### 3.6 Field-theoretic dynamics: exploration versus exploitation

- **Trade-off.** Proposal instability and high entropy versus a stable, mature, low-entropy language.
- **Strategy (candidate).** Renormalization-group flow with reflexive insertions; symmetry breaking, fluctuation and stabilization phases; a factorization algebra on the actor-causal site valued in Λ; a content operad `O_C`.
- **Discipline.** Every action-functional term is a normative commitment to be made explicit. Kernel claims (typing, provenance, non-retroactivity, descent, no-leak) must never depend on numerical field-theoretic quantities.
- **Status.** Research horizon, gated on Λ supplying a scale-dependent observable that the versioned-presentation model cannot express. Source: arc/06 and arc/08.

### 3.7 Federation: coherence versus plurality

- **Trade-off.** Coherence within one protocol versus plurality across protocols. A complete protocol in isolation would recreate the one-true-framework failure the project was built to dissolve.
- **Strategy.** Independently maintained peers exchange finite, versioned publication bundles. Each bundle is complete relative to an explicit import boundary. Exchange uses typed partial translations, pinned versions, provenance of origin and local adoption, and keeps conflicts and missing translations as data.
- **What it supplies, and what not.** No global actor directory, clock, language quotient, history, consensus, or mandatory update.
- **First forcing fixture.** Two peers with colliding local identifiers; an offline pinned import; different admitted comparisons; a withdrawal adopted by only one peer. Success means each current view is reproducible from its own version and imports. Convergence is not required.
- **Status.** Exchange constraints selected; the categorical layer (a bicategory of publication contexts, with Yoneda, anabelian or GT-equivariance tests) unearned.

### 3.8 Information-cohomological complexity: dense versus accessible encoding

- **Trade-off.** Encoding that is efficient for experts versus encoding decodable by any member of the unityped receiver population. The project counts transparency as an engineering property on the same footing as performance and security: "how is the unityped receiver going to understand the message?"
- **Candidates.** Information cohomology, deterministic information loss, task-relative information flow. No probability model is chosen.
- **Discipline.** A satisfied chain rule is a cocycle, not an obstruction. Measurement characterization must be kept apart from architectural specialness.
- **Status.** Research horizon; no complexity rank for actors, ever.

### 3.9 What the cascade claims, and what it does not

`motivation.md` gives a compact list of what each separation separates, worth keeping in one place:

- locality from content, by the sheaf;
- current protocol from its edits, by a meta layer;
- "how" from "what", by an orchestration/content split;
- stabilized articulation from conceptual variation, within Λ;
- content from dynamics, by factorization algebra plus RG flow;
- the interior of a protocol from its exterior, by a meta-topos;
- content from its measurement, by a (co)homology pairing.

Most of the carriers named in that list are candidates. The table itself says so: it is an architectural research horizon, not a claim that every proposed mechanism is forced or implemented. What the cascade does claim firmly is a *method*: each separation is introduced as the answer to a tension exposed by the previous one, and the strategy is uniform.

## 4. Separations in the architecture that are not layers

These are preserved distinctions, in the second sense above. Most are recorded in `architecture.md` and `naming.md`, and several came out of the arc/17 alignment with the instigator.

### Participants and seats

- **Four scopes, never collapsed.** The *eligible population* (outside the trace), *registered actors* (run-local opaque handles), *panel members* (occupying seats in one conversation), and *event participants* (touched by one event). Registration does not require contribution, and a registered actor may stay silent or join no conversation. Actor coverage by conversations is a separate downstream hypothesis, decided by `actorsCoveredByConversations?`, not a well-formedness clause.
- **Seat, occupant, role.** A seat is a protocol-local position any eligible participant may occupy. A role is an activity or obligation attached to a seat or event, not an actor kind. Seat occupancy is read as a genericity discipline (eigenvariable-like), explicitly not universal quantification over people.
- **Formal standing versus results.** Equal standing does not mean participant choice is irrelevant: different panels may produce consequentially different results. Each draw creates its own situated result, with standing through the open flow into which it is published. No draw represents the population.
- **Evaluating work versus ranking producers.** The political separation, made testable by the output-dependent-standing counterexample of section 1.

### Conversations and their records

- **Two conversation kinds, never mixed.** Participant conversations have participant seats; content-level conversations have concepts or artifacts in the subject positions. The kind is fixed by an immutable session tag. Editing means appending events or starting new conversations, never mutating the tag.
- **Closure event versus closure transform.** The closure event is the unique terminal event of a conversation, marking success (naming an output artifact) or failure (naming a first-class failure record). The closure transform maps the live record to the public record.
- **Closure versus consensus.** Both success and failure close. Successful resolution requires unanimity under interface-declared participation and assent rules, but the common trace contract records closure shape, not those mechanics. Candidate recognition, assent and silence are interface concerns: arc/17 settled on the cheapest versions and kept them out of the theorem scope.
- **The event record's three concerns.**
  - `causalParents`: which earlier events this event operationally depended on, to be earned by the runtime kernel from consumed messages.
  - Provenance: how an event or dependency arose (response, deepening, correction, the closure marker); a description of derivation, not of actor essence.
  - Content: the documented substance, carrying run-local or federated references.
- **Live versus public record.** These are different mathematical objects. The live runtime may hold operational identities temporarily. The public record carries fresh per-conversation actor handles, drops authorship and the live identity map, and keeps the participant count, outputs, stable content identifiers, provenance, references and dependency edges.
- **Pseudonymization versus erasure, and handles versus identifiers.** Pseudonymization replaces an identity channel by scoped handles; erasure removes a field. Neither alone entails unlinkability, which is relative to a declared observer. Public actor handles may change at publication. Public artifact, conversation and event identifiers must stay stable and publisher-scoped so that federated references survive.
- **Run-local versus federated references.** One resolves inside an accepted run; the other against an imported, versioned bundle with publisher scope. Neither is an actor identity.

### Arrows and content objects

- **Five kinds of arrow** (`naming.md`):
  - causal-parent edges;
  - typed documentary dependencies;
  - frame morphisms;
  - restriction maps;
  - admitted comparisons.

  Sharing endpoints never lets one supply another. Dependency edges stay directed; only admitted comparisons may be inverted.
- **Episode, output artifact, concept identity, documentation version.** Four things, none a synonym for another.
- **Comparison claim, admitted comparison, language presentation.** The claim is history; admission is version-relative; the presentation is built from the admitted set under an adequacy condition. The core, a localization and groupoid completion are different constructions.
- **Three kinds of variation.** Conceptual variation, clause variation, and contextual variability P (section 3.5).

### Policy versus property

The architecture fixes a boundary and delegates the rest to instance-specific interfaces:

- panel size;
- entropy source;
- turn-taking and silence policy;
- candidate formation and assent;
- all-or-nothing AI pairing;
- resolution of concurrent edits;
- federated transport.

These may vary without changing the trusted actor ontology, the append-only publication model, or the unanimity requirement. Arc/17 gave an example of the relative point of view doing real work here: the 5–21 panel-size bound is not a Hoapa property, so it becomes a module parameterized over its bounds, never a fixture in the authoritative corpus.

### The Harper-X pair

Arc/18 records an exchange in which a remark attributed to Robert Harper (reconstructed, not verified) was read as two separations that HoTT depends on:

- **being versus decidability**: Heyting rather than Boolean, not well-pointed;
- **truth versus evidence**: proof relevance.

Claude proposed that both already exist on K. No-leak is a non-well-pointedness requirement: the live record contains facts the public observer cannot decide. Provenance and first-class failure records are proof relevance as a system requirement. On this reading, the flat collapse on the old M was the same separation failing on the M side. A conditional further step was noted: if the agent substrate were reflexive in Scott's sense, Lawvere's fixed-point theorem would make unityping *force* non-Booleanness. The project has never committed to that reflexivity.

Arc/18 itself qualifies the whole pairing. Booleanity, well-pointedness, enough points, proof relevance, observer ignorance and proper modal subuniverses are different properties, and the flat collapse proves none of their proposed identifications.

## 5. Separations in the checked mathematics

These are the distinctions the code enforces, often by what it refuses to construct.

- **Cartesian locality versus linear content.** Set-valued locality sheaves and V-valued linear/session sheaves are built by *one* finite construction, instantiated twice, and their meanings are kept distinct. "Topos" is reserved for the Set side unless more is proved. They are related by an adapter (R4, section 15), never identified or cast into one another.

  The strongest argument for why this separation is forced came from arc/13. A dagger-compact (self-dual, resource-sensitive, no-cloning) category that is also cartesian degenerates, so a system wanting both a resource-honest interactive layer and a freely shareable knowledge layer must keep them in separate categories. The same arc added the honest caveat that the separation bites only to the extent the linear pole is genuinely non-copyable. Arc/19 restates the requirement as a design rule: copying a description must not license copying its resource.

- **Site, algebra, operad.** Three module families with a deliberate import discipline (section 1). `O₁` is the interaction grammar on top of the hybrid, an augmentation and not a replacement.
- **Rotation versus involution.** The cyclic action on the operad is named `rot`, never "involution": rotation has order n+1. Session duality is the order-2 structure and lives on the algebra side. The 1=2 perspective swap appears as a *derived* `boundary-swap` theorem induced by full cyclic equivariance, not as primitive data.
- **The two faces of duality (R8).** The syntactic face, `dual-involutive` in `SessionSyntax.agda`, is postulate-free. The categorical/operadic face, `boundary-swap-at-gen` in `Sessions.agda`, is relative to the one remaining Sessions postulate, `session-O1-action`. The bridge between them is deliberately not postulated. This is the project's live instance of its rule "let the math surface the framework, don't postulate the bridge": both sides are recorded as distinct Agda objects, and the bridge stays in prose until richer structure lets it hold or fail.
- **Tensor unit versus dualizing object.** `𝟙ₛ` (no demanded interaction) and `⊥ₛ` (dualizing target) are related by duality but no morphism between them is assumed. A mix map would change the linear discipline and must be a declared feature, not a convenience.
- **Constant-slot versus event-dependent content.** The landed witnesses give every event the same slot `P₀`. Everything downstream is built generically over `FiniteFramePresheaf` and `IsSheaf` so that the constant-slot case cannot leak into the framework.
- **Fixed-base versus relative frame morphisms.** `FrameHom` is a strict-reflecting sub-view embedding over one fixed actor base: it preserves and reflects causality. A relative `FrameHomOver`, living over an actor-base map, is selected future work. The banked interface is to be kept, not mutated.
- **Restricted global order versus internally generated order.** A conversation's frame carries the global causal order *restricted*, not an order regenerated from its own parent edges (decision of 2026-09-04). Causal saturation varies per conversation, and a banked fixture exhibits both outcomes.
- **Synthetic versus analytic formal tracks.** From the project's first months (`bias_correction.md`, "3 roles"): a synthetic, axiomatic presentation and an analytic one that derives what the synthetic one postulates, kept as a test suite. The flat-collapse diagnosis is the clearest example of why: the analytic non-flatness witness for the delooping and the synthetic signature are jointly unsatisfiable.

## 6. Separations in the implementation

- **Two legs that do not mirror each other.** `formal/` is organized by mathematical structure; `runtime/` by executable responsibility. They meet only at a shared contract.
- **Meaning versus representation.** `Trace.agda` owns the meaning; `Serialization/` owns the JSON representation and the fixture corpus; runtime codecs implement the representation without redefining it.
- **Raw decidable syntax versus substrate semantics.** The trusted checker stays `--safe`, substrate-free and decidable. It cannot import the opaque substrate, whose actors have no decidable equality. The connection is a realization, an interpretation rather than shared types (adapter 14 in section 15).
- **Three originators of evidence** (`naming.md`):
  - a *fidelity sampler*, which tests codec and recorder faithfulness;
  - a *scenario originator*, which derives runs from authored transition logic;
  - an *actor kernel*, which derives events and causal parents from actual message behaviour.

  Only the last meets the gate for a separate checker. The current 3R task is its minimal version: one parent edge earned from a consumed message, with a retained test that fails if dependency piggybacking is broken.
- **Recorder, checker, storage.** `Hoapa.Core.EventLog` is an in-memory recorder that neither validates nor originates. Durable storage belongs to `hoapa_store`, with Pijul behind a supervised port. Phoenix is an edge adapter, and the core must run without it.
- **Two senses of replay.** *Recorder-fidelity replay* (feed a decoded run through a fresh log and check exact equality) is tested. *Purpose-relative replay* (reconstructing or resuming the process) is future work.
- **Sealed legs.** Runtime tests read the vendored contract artifact, never `../../formal`.

## 7. Levels: the third axis

Levels were clarified by the instigator in arc/17 and recorded in `architecture.md`. Level −1 conversations are populated by participants only. A conversation-of-conversations is not an assembly of assemblies. It is itself a level −1 conversation whose subject matter is a graph of level 0 objects, conversations taken through their documented outputs. A level X conversation-of-conversations is a level −1 conversation about level X−1 material. The tower is therefore *a tower of subject matters, not of assemblies*: panels are the only active machinery, and graphs are passive artifacts.

Two consequences recorded at the time:

- The level 0 graph's edges are partly given by cross-conversation causal parents already present in the contract. Claude's reading in arc/17 made the banked order-comparison module the graph-skeleton constructor. That reading has not been adopted as a decision in the workflows, and typing an edge as response or deepening is content, not causality.
- Level 0 is not Λ, and a closure event is not a concept (`bias_correction.md`). Closure events and typed dependency edges are evidence from which a Λ interpretation may be built.

---

# Part II — Integrations on M

## 8. Why integrations, and why now

The cohesive M failed in two ways: its synthetic signature collapsed, and, less visibly, the two sides were mismatched in kind. A Claude remark in arc/18 put it bluntly: K had become a layered, checked, implementable structure with several separations, while M had remained one site plus three modalities, and "you cannot have an informative adjunction between a cathedral and a brick." Repairing the brick would not fix that.

The mirror was proposed to make the sides comparable in kind. Arc/18 also saw in it a derivation procedure for M: for each K separation, ask what M-side structure would make it productive.

## 9. The mirror hypothesis

### Statement

The current statement is `targets.md` §T4, superseding an earlier separation-to-separation sketch. The question is whether **separations of concerns in K enable structural capacities for integration in M**, and whether M's integration capacities in turn **induce further separations in K**, especially within documentation.

The vocabulary is fixed in `naming.md`:

- *Integration*, or *unification*, means relating, composing or reconstructing partial understanding while preserving specified differences. It might be a coherent family, a translation system, a common interface or a reconstruction. It need not be identification or one merged object.
- *Secondary* means induced through the correspondence. It does not mean less important, later in time, or another architectural layer.
- *Primary* marks where a particular investigation starts, not a hierarchy between M and K.
- The *surface* separates reality from its understanding and connects them through accountable observation, interpretation and action.

### The three movements

The pre-philosophical exploration of arc/21 sharpened the mirror into three movements, now in `openings.md` ("Infinity and infinitesimality"):

1. **Separation enables integration.** Distinct activities, contributions or responsibilities can enter relationships because their differences remain articulate.
2. **Integration sustains separation.** Those relationships let a local activity continue without reproducing its whole enabling world. `openings.md` puts it organizationally: separation lets an activity proceed without carrying the whole, and integration sustains the relationships that make this omission safe and productive. Local omission is not independence from the milieu.
3. **Integration reveals further separations.** A richer shared setting makes previously invisible differences available for subsequent work.

The positive commitment behind all three is *relational determination*: a difference can acquire efficacy through relations without being dissolved into them. The accompanying table of an "absolute" and an "infinitesimal" pole is explicitly not a map onto M and K. Neither "absolute = M" nor "infinitesimal = K" is assumed. Each pole needs both movements.

### The rising sea

`openings.md` records the intuition that Grothendieck's preference for the rising sea expresses the K/M correspondence. Respecting the distinct responsibilities of mathematical structures makes possible a surrounding setting in which they integrate naturally, and discovering that setting reveals which distinctions matter. In this reading K's separations and M's integrations are not successive stages or fixed compartments; they develop together. The project flags that this is not independent evidence, since Grothendieck's method already shaped it.

### The Lautmanian and Simondonian readings

- **Lautman** (arc/20, Codex). K organizes the collective articulation of understanding, and can discover through work that its present decomposition is inadequate: it "goes out hunting for its problematic". M expresses the contextual relationships through which articulations acquire meaning and can be integrated.
- **Simondon** supplies their co-individuation: neither organization nor milieu needs to be complete before the encounter.
- **Deleuze** opens it toward the production of new problematics.

The joint demand: *articulate without confusing the kinds of decomposition; translate without erasing their different roles; generate without assuming that all future distinctions are already given.*

### Perspectivism as an open relation

Arc/18 keeps three things apart: the available contextual variation, the perspectives K can access and articulate, and new perspectives made possible by K's work. It does not assert that K produces all perspectivism in M, nor that K merely receives a fixed inventory.

## 10. Candidate integrations, indexed by the separation that would enable them

None of the following is constructed. Each row needs the indicated bridge before it counts as evidence; arc/18 insists that matching lists prove no equivalence and non-matching lists measure no loss.

### Starting from K

Arc/18 lists four separations and the integrations they might enable on M:

| K-side separation | Integration capacity sought on M | Comparison case under the same task and uses |
|---|---|---|
| Contributor versus contribution | A producer-independent documentary organization connecting work across identities and specialties | Output-dependent participant standing |
| Episode versus artifact | Different episodes contributing to one reusable context, even when producers are unavailable | An interface requiring renewed producer authorization for reuse |
| Local vocabulary versus explicit translation | A coherent network that preserves local vocabularies | Compulsory adoption of one vocabulary, with the same required distinctions |
| Causal dependence versus conceptual equivalence | Integration retaining both explanatory history and structural comparison | A directed dependency that would wrongly become reversible if the two were merged |

Each needs carriers, a construction, and a preservation or comparison law. A positive result would not establish necessity, since a rival may support the same use by another mechanism.

### Starting from M

Arc/18 also lists eight M-side resources, each with a candidate secondary separation it would induce in K, an integration to investigate, and a comparison case:

| Candidate resource on M | Induced separation on K | Integration to investigate |
|---|---|---|
| Definitional versus propositional equality | Computational conversion versus an explicitly witnessed identification | Reuse justified by a witness without silently changing conversion rules |
| Univalence and equivalences | Presentation, admitted equivalence, and directed translation | Transport across equivalent presentations without definitional identity |
| Binding, scope, freshness | Local names and scope versus exported interfaces | Abstraction and instantiation without dependence on incidental names or capture |
| Locality and descent | Local contributions, compatibility witnesses, assembled result | Assembly preserving restrictions to local views |
| Context-relative decidability or access | Established, refuted, and locally unsettled claims | Composing partial accounts without imposing total local decision |
| Torsors and global sections | Coherent organization versus a chosen global representative | A global object assembled without a global trivialization |
| Dependent Σ and Π | A particular witness-plus-result versus a uniformly instantiable rule | Reuse of an indexed construction across admissible inputs |
| Propositional truncation | Existence of acceptable evidence versus the evidence retained for use | Combining existence-level claims while keeping structured data where needed |

The rows come with clarifications that the project insists on keeping in one place:

- decidability of a predicate, judgmental equality, and proof irrelevance are three different things;
- undecidability, absence of global elements, and absence of a *preferred* global element are distinct;
- `valid?` is an internal Boolean function, not judgmental equality;
- identity witnesses do not automatically retain historical provenance;
- unityping, equivariance and parametricity are related but distinct.

### Further exemplars from the mathematical record

`openings.md` ("Relative presentations…", "Galoisian replay", "Examples, comparison cases") and `related_structures.md` add worked examples, each established in its own setting and placed here only as a proposal:

- **Separation enabling integration: descent.** Descent organizes local data and compatibility; reconstruction needs the effective-descent hypotheses.
- **Integration revealing separation: relative geometry.** Deligne's account of the relative situation X → S makes a geometric manifestation and its availability over a base distinct without making them interchangeable. The control is x² − 2 and x² − 1: isomorphic two-point schemes over ℚ̄, but over ℚ the first has no rational point and the second has two. The Galois actions retain the distinction.
- **Riemann–Roch as local prescription versus global realization.** A single simple pole is prescribable locally both on ℙ¹ and on a genus-one curve, and globally realizable only on the first. Separating local data from ambient geometry makes the integration question precise, and the global framework reveals a distinction between locally similar possibilities.
- **Galois descent as borrow–work–return.** Borrow a splitting field and named roots; δ = r₁ − r₂ depends on their order; Δ = δ² = a² − 4b descends. The return can be relative to an intermediate field: invariance under H supports return to Lᴴ, not necessarily to k.
- **Decidable presentations and undecidable meanings.** An epimorphism q : D → X with D decidable gives an effective equivalence relation presenting X, while membership in that relation can stay undecidable. The project's caution: generators belong to the contextual setting, and their use as vocabulary belongs to a documentary interface in K. In Boolean Galois examples, by contrast, the limitation is that no root is invariantly preferred.
- **Symmetry versus orbit set.** A nontrivial transitive G-set has no invariant selected element, while its orbit set has one.
- **Lawvere's extensive/intensive pairing.** For f : X → Y, ⟨f_* μ, φ⟩ = ⟨μ, f* φ⟩. Two algorithms computing the same pushforward may have different resource requirements, so agreement of observations and identification of procedures are separate questions. That is a small, exact instance of "integration reveals a further separation".

## 11. Proposed mechanisms

These are the mathematical shapes proposed for turning the mirror into a correspondence. All are candidates.

### What an adjunction supplies

If `Allow ⊣ Require` existed, it would supply:

- the natural correspondence K(L m, k) ≅ M(m, R k);
- the unit η : Id(M) → R L and counit ε : L R → Id(K);
- the monad R L and the comonad L R;
- for each work morphism w : L m → k, a contextual *return* w♯ = R(w) ∘ η_m : m → R k.

Left adjoints preserve colimits and right adjoints limits, so once an integration is characterized by a universal property, preservation can do real work. The project is emphatic about the limits:

- adjointness alone names none of the disciplines;
- the transpose exists for every adjunction and carries no evidential weight for this pair;
- *replay* (adequate uptake in further work) needs a declared future use and a preservation result;
- a noninvertible counit diagnoses a specified round trip, not automatically privacy, entropy or empirical loss.

The anchors of arc/09 remain as hypotheses to test, in their committed polarity:

- Complexity = Allow;
- Evolution = Require;
- Praxis = η;
- Anthropic loss = the failure of ε to be invertible;
- Care = the checked involution (–)⊥.

### Generation and description

The newer candidate framework (arc/18 and arc/19) proposes that K faces the contextual side through *two* interfaces:

- an **operational** interface: Free ⊣ Underlying between underlying contextual data C and structured systems A, read as Allow-shaped and Require-shaped;
- a **documentary** interface: Real ⊣ Nerve between space-valued presheaves on documentary probes, D̂ = Fun(Dᵒᵖ, Spaces), and C.

Across the philosophical divide they have opposite polarities. Nerve is a right adjoint from M-interface to K-interface; Free is a left adjoint in the same direction.

The discriminating compatibility, under the hypotheses of monads with arities, is

```text
j* ∘ Nerve_A ≃ Nerve_C ∘ Underlying
```

Here j : D → Θ sends arities to free objects. The formula is not an identification of the two nerves: Θ carries operations absent from D.

The arc/19 synthesis adds four points:

- the documentary counit is a candidate locus for observation-relative Anthropic loss, distinct from the operational counit;
- a candidate `Avail : Episodes → D̂` with α : Avail ⇒ Nerve ∘ Underlying ∘ J would make "making available" precise;
- the instigator's correction that Hoapa makes content available and never pushes it (consumer-initiated access, no paywalls) constrains delivery operations, not mathematical arrows;
- a preservation table names what this architecture must not erase in K: equal standing, directed causality, the cartesian/linear adapter, session duality, live/public, failure closure, federation, and the runtime boundary.

### Relative cohesion

Relative cohesion asks whether "K is cohesive over M" rather than installing cohesion on M over Set. Its chain Π ⊣ Disc ⊣ Γ ⊣ Codisc has three adjacent adjunctions plus full-faithfulness and preservation axioms. The project records a consequence to test rather than hide: if Allow and Require were Disc and Γ with Disc fully faithful, the unit would be invertible, which could support a stable fragment but not the old non-idempotent monad target for that same pair.

### Variance as the shape of the work relation

Arc/18 and arc/20 propose a work relation Work_p : M_pᵒᵖ × K_p → Spaces: contravariant in the world variable, covariant in the practice variable. Two-sided representability would yield the adjunction with the recorded polarity.

Claude's reading in arc/20 aligns this with Lawvere's intensive (contravariant) and extensive (covariant) quantities, and observes that the banked Chu coefficient witness already has the shape of such a pairing. Codex's reading resists fixing "M intensive, K extensive" and prefers that a result articulated on one side become an organizing condition on the other. Both readings agree on one point: if the project adopts the vocabulary, it must say whose "intensive" it means, since Lawvere's and Deleuze's uses differ.

### Mediators and compatibility laws

- **Lautman's mixtes** supply a source question for every adapter and correspondence: what must an intermediate structure retain from each setting to make passage possible? They prescribe no category.
- **A space-valued mediator** P_shape : Mᵒᵖ × K → Spaces is to be constructed independently from interaction-, cover- and dessin-shaped realizations, and only then tested for two-sided representability (arc/16). It is gated on M acquiring branch data.
- **The logical-presentation track** proposes a context-indexed family Γ ↦ Mod_Hoapa(ℰ/Γ). Its central questions are Beck–Chevalley or Frobenius in shape: does contextual reindexing commute with the operational adjunction?
- **Lautman as theorem-shaper** (Family C in `openings.md`) asks for the same kind of law between analytic articulation and synthetic recomposition: trace/reindexing naturality, local analytic descent, process-to-artifact stabilization, and decompose/recompose adequacy.

The project's judgment, stated in several places, is that the Hoapa-specific mathematical content is most likely to lie in these compatibility theorems, not in declaring modes or adjunctions.

## 12. What would count, and the cautions that travel with the mirror

### Requirements for a candidate

From T4 and `openings.md`, each candidate must name:

- its K-side separation;
- its M-side capability;
- the construction relating them;
- the distinctions preserved;
- the compatibility law;
- a comparison case testing whether the separation actually matters for the declared use.

Sufficiency and necessity are separate claims. A successful rival is an informative outcome.

### Bounded obligations

The bounded obligations closest to this question, all unmet and written in prose rather than Agda (`future_work.md` §E), are:

- **`clause-separation-witness`**: Adequate(A, c, u) × ¬ Adequate(B, c, u), for a common context, future use and pair of architectures constructed first. If both are adequate, that is evidence against the distinguishing clause.
- **`observation-quotient-universal`**: a finite sufficiency candidate. Every adequate surjective publication factors uniquely through the observation quotient. It has a known limit: it cannot distinguish a rival requiring producer authorization for reuse until an access interface and a future operation are added.
- **`continuation-factorization-criterion`**: a returned operation w̄ with q′ ∘ w = w̄ ∘ q exists exactly when the work respects the fibres of q. Bit-flip is the positive control, bit-swap the negative one.
- **A contextual-renewal witness**: an artifact, a transition p → q, preservation of named earlier uses, and a use available at q but not at p, under an independently justified admission rule.

### Changing the conditions of integration

`openings.md` distinguishes three things:

1. new objects within a fixed setting;
2. another presentation of the same semantics;
3. changed contextual structure or capabilities.

Different sites can present equivalent topoi, so a changed site alone does not establish renewal. Integration obtained by erasing disagreement differs from warranted resolution. A faithful, reusable record of incompatibility can itself be an adequate achievement.

### Cautions

Arc/18 attached four cautions to the mirror:

1. **The mirror must be imperfect, and the imperfection is the content.** A perfect clause-by-clause mirror is an equivalence, the degenerate case the conjecture forbids. The interesting result would be "K's separations are mirrored except at clause N".
2. **"Below explains above" walks toward the metalanguage trap.** The test for each proposed M separation: could it be stated by someone who had never heard of Hoapa?
3. **"Below" must mean co-constitutive, not prior.**
4. **The mirror needs a first confirmed instance.** The Harper-X pair was offered as one; see section 23 for my reservations.

To these the workflows add that protected differences, inadequacy and loss must stay distinct.

**Status of Part II as a whole.** Nothing in it is constructed. M is undefined; no category of architectures, world/practice pairing, cross-side adjunction, comparison invariant or nonconstant family exists. The mirror is the selected programme's organizing candidate, not an additional selected construction.

---

# Part III — Adapters internal to K

## 13. What an adapter is

`naming.md`: an adapter relates structures across a separation. Arc/06, where the idea was born, gives the governing rule:

> every adapter is a named natural transformation, morphism of sites, or functorial action. No hidden casts. That is how both sides "stay themselves" while the hybrid makes them belong to one protocol.

The same arc gives the operational payoff: the protocol stays manageable if it is built as a small verified kernel plus named adapters, each one interface with one invariant, and becomes a monster if every layer is made operational at once. Read as protocol APIs, the adapters say:

- *restriction*: what a participant or subconversation is allowed to see;
- *cover*: which local views count as enough observation;
- *separatedness*: no hidden global difference if all authorized local views agree;
- *descent*: compatible local reports assemble into an official record;
- *duality*: every process has a corresponding context or counterparty;
- *operadic*: protocols compose by declared interaction shapes;
- *trace*: recursive review and self-reference are controlled.

Two neighbouring notions use similar words and should be kept apart (section 16): the *structuring relations* R1–R11 of the module inventory, and *software adapters* in the runtime.

## 14. Genealogy of the adapter list

**Arc/06** (before the Hybrid was written) produced several overlapping lists:

- a first list of six: restriction, cover/descent, section/probe, operadic valuation, promotion, no-leak/erasure, with a long discussion concluding that a 𝟙ₛ ↔ ⊥ₛ bridge is natural but not forced;
- a rereading of the existing plan as adapters: restriction, cover observation, separatedness/auditability, descent/gluing, operadic protocol, promotion, cross-site modal;
- a nine-item list adding duality/reversal and trace/feedback;
- a modal-facing list of hoped-for cross-site adapters (boundary, duality, gluing, trace, shape, require, allow), with the remark that `Allow ⊣ Require` "is no longer one giant bridge. It becomes the endpoint of many smaller compatibility adapters."

**The `Presheaf.agda` header** (2026-05-20/21) fixed the only numbered list, still in the code:

| Number | Name | Content |
|---|---|---|
| 1 | Restriction | |
| 2 | Descent / gluing | |
| 3 | Unit/dualizing bridge | Optional, mix-like |
| 4 | Operadic valuation | Lifting O₁-algebras to presheaves |
| 5 | Promotion | A completed conversation becoming an actor in a higher conversation; consensus emitting a Π-morphism; deferred to MO₁ |
| 6 | Allow ⊣ Require | The cross-site modal adapter |
| 7 | No-leak / erasure | |

The header also carries the reservation for `Hybrid/Reflexive.agda`.

**`architecture.md`** (2026-09-12) gives the current prose list: restriction, descent, change of value, promotion, the conjectural `Allow ⊣ Require`, and no-leak.

Between the header and the architecture three things changed:

1. **Promotion was re-understood.** Strict reflection in `FrameHom` rules out collapsing a conversation into an actor. Since 2026-09-12, promotion is *publication of a closed output through a stable artifact interface plus a typed reference from later work*. It is not a morphism, it is not deferred to MO₁, and consensus is not closure. MO₁ may later organize self-gluing elsewhere, but it does not change this boundary.
2. **"Change of value" entered the list**, recording the value-functorial change of base that the R4 work made necessary.
3. **The cartesian/linear bridge became the central landed adapter**, although it never received a number.

## 15. The series, as it now stands

For each adapter: what it relates, what it does, its status, and what it does not do. I have grouped them by the separation they cross.

### A. Locality ↔ content: the Hybrid proper

**1. Restriction (Adapter 1).**
- *Relates.* Actor-side sub-views to value-side restriction maps: `FrameHom AB G F → Hom (value F) (value G)`. Identity and composition of actor views agree with value restriction.
- *Status.* Checked in `Presheaf.agda` (generic over a `StarAutonomous` target) and `SessionPresheaf.agda` (Sessions specialization), with constant witnesses at `𝟙ₛ` and `⊥ₛ`. Mirrored on the finite subsite by `FiniteFramePresheaf`.
- *Does not.* Discriminate frames inside `value` without further machinery.

**2. Separatedness / auditability (Adapter Law 1, absorbing arc/06's section/probe adapter).**
- *Relates.* Local agreement to global agreement: equality of two maps into `value F` after restriction to every patch implies global equality.
- *Probe form.* It quantifies over an arbitrary probe X rather than global sections 𝟙ₛ → P F, which keeps the value side linear rather than pretending it is cartesian.
- *Status.* Checked; zero postulates.
- *Reading.* No hidden global difference if all authorized local views agree.

**3. Descent / gluing (Adapter 2).**
- *Relates.* Compatible local typed content to global typed content.
- *Status at full generality.* Over arbitrary frames, `Hybrid/Descent.agda` supplies the probe-form definitions as property records, never postulates. Equalizer form is not even statable over the thin value signature.
- *Status on the finite subsite.* Checked as finite event-product descent, category-generic, packaged as finite sheaf categories at both `StarAutonomous→Category V` and `SET`, with a concrete two-point cover validated at proof level.
- *Does not.* Supply event-dependent content, a topos, or the full actor-causal sheafification.

**4. Cover / observation.**
- *Relates.* The global frame to local patches. The full site uses basis-form `Cover` with `sieve-of` as a bridge artifact.
- *Status.* On the finite subsite, `FiniteBasisCover` adapts to a Cubical `Coverage`, and `SetSheafComparison` proves that the project's sheaf condition agrees with the library's at `SET`. The project treats this comparison as a *legitimacy theorem* for its own endpoint, not a replacement for it.

### B. The value axis: bookkeeping adapters and change of value

**5. Convention and presentation adapters.**
- *What they are.*
  - `StarAutonomousCategory` turns the thin session signature into a Cubical `Category` and isolates the ⋆/∘ convention flip;
  - `CategoryApplicative` gives an applicative-law view of any category;
  - `FiniteFramePresheafFunctor` bridges project records to library functors without re-expressing descent;
  - `RestrictToSupported` restricts finite presheaves to the supported subsite;
  - `ChuPointVProd` supplies an exactly typed finite-products instance.
- *Status.* Checked.
- *Why they count.* They are the no-hidden-casts rule applied to conventions: each makes a change of presentation explicit and local.

**6. Change of value / change of base.**
- *Relates.* A functor between value categories to a functor between presheaf categories (`ChangeOfBase.agda`, `SupportedChangeOfBase.agda`).
- *Also.* A structural frame-noninterference lemma that the workflows call the structural half of no-leak.
- *Status.* Checked.

**7. R4: the cartesian ↔ linear adapter.** This is the adapter the project leans on most.
- *Value level.* `LinearNonlinear.agda` states a Benton LNL adapter F ⊣ G interface-first. It has strong-monoidal comparisons for F, with ! named as F ∘ G, and deliberately no mix map.
- *Presheaf level.* `liftF ⊣ liftG`, with G preserving sheaves.
- *Sheaf level.* `FiniteSheafification.agda` names a finite-site reflector, and `LinearNonlinearSheafAdjunction.agda` gives the adjunction *conditionally* on it.
- *The constructed route.* The supported point-generated site carries:
  - pointification, with a(P)(SF) = ∏ over events e of P(pt_e);
  - the biconditional IsPointSheaf P ↔ PointLocal P;
  - the reflector a ⊣ ι;
  - the point-generated sheaf bridge `Lpoint ⊣ Rpoint`.
- *Status.* Checked, relative to a value-level `lnl : LNLAdjunction` and a finite-products hypothesis `vProd`.
- *Interpretation the project allows itself.* The system's global point of view is not a god's-eye view; it is the sheafified coherence of its event-local perspectives.
- *What it is not.* It is internal to K (R4 is not `Allow ⊣ Require`). It is not the full actor-causal reflector, and it does not collapse the Set and V endpoints.
- *The "verification = !" reading.* Arc/13 read this axis as "verification = !". The grounded correction recorded there: the Benton bridge *is* R4, a K-internal adapter, and the identification "buffer = !" is rejected.
- *A candidate on top.* A live conversation as computation and a completed, citable artifact as value is a candidate phase distinction (call-by-push-value) that would require additional structure on R4. It is not constructed.

**8. The Chu coefficient witness.**
- *What it does.* `Chu(SET,Bool)` instantiates the point-generated R4 hypotheses with a postulate-free import closure: a non-vacuity witness for adapter 7.
- *Check before rhetorical use.* `future_work.md` flags that in this instance !A = F(G A) appears to rebuild a copyable Chu object from the point carrier, replacing the state carrier.

**9. Sessions → Chu realization.**
- *What it does.* `SessionObjectModel` and `SessionChuModel` define J0, J0-dual and J1 and an underlying Cubical functor from the postulate-free session syntax into any session object model, instantiated at `Chu(SET,Bool)`. This turns the syntactic duality face into a semantic isomorphism.
- *Status.* Checked.
- *Why it matters beyond itself.* It is the template arc/12 later proposed for the runtime realization: syntax, an interpretation environment, semantics.

### C. Operad and algebra ↔ content

**10. Operadic valuation (Adapter 4; structuring relation R7).**
- *What it does.* `Valuation` interprets O₁ into the dualizing object, `O n → Hom (ports Carrier n) ⊥-par`. `OperadAlgebra` adds plug and shift with laws making operadic substitution factor through categorical plug and rotation through shift.
- *Status.* `Sessions.agda` inhabits it relative to the postulated `session-O1-action`, the last Sessions postulate.
- *What the header promised and is not done.* Lifting to *presheaves* valued in O₁-algebras, where "protocol as operad meets protocol located over actor frames".
- *What removes the postulate.* Earned closed/evaluation/cut structure and coherent tensor rotation, not renaming.

**11. Duality / reversal (R8).** The two faces of section 5, with the bridge deliberately deferred. Arc/06's cobordism/session dictionary makes process/context reversal the deep thread: a process can be re-read as a context by duality. The dictionary is a design pressure, not an imported theorem.

**12. The unit/dualizing bridge (Adapter 3).** *Deliberately absent.* A named `Hom 𝟙ₛ ⊥ₛ` or its inverse would be a mix-like structure changing the linear discipline. If added, it must be declared.

**13. Trace / feedback.** Named only in arc/06. Its current descendant is the question of what would earn MO₁: a specified use that needs self-gluing which the cyclic interface cannot express. Later reuse of an artifact is not automatically such a contraction; it may be ordinary composition with a fresh occurrence.

### D. Runtime ↔ substrate (the 2S lane)

**14. Realization.**
- *Origin.* Arc/12 framed the correspondence between the raw runtime contract and the mathematical substrate in three tiers:
  - Tier 0: every well-formedness clause is the decidable shadow of a substrate axiom. Codex's correction: this is disciplined traceability, not proof.
  - Tier 1: realization instantiates the substrate's generic carriers with a trace's finite data.
  - Tier 2: the substrate's theorems transport onto actual executions.

  The model was "J for traces", the Sessions realization template.
- *Landed.*
  - `BackwardRank` and `CausalFromParents` derive a causal order and one global actor-causal frame from any well-formed run.
  - `ConversationLocality` realizes each conversation as a local frame with a strict embedding.
  - `ConversationCover` packages the conversation frames as a cover *conditionally* on actor coverage.
  - `ConversationOrderComparison` characterizes causal saturation per conversation.
  - `TraceLookup` is the one module allowed to depend on the positional nesting of the validator's clauses: an adapter between validator layout and proof consumers.
- *Status.* Checked at these scopes.
- *Not established.* Session assignment, content or provenance realization, and transport of the sheaf theorems.

**15. Tier A, raw actor-renaming invariance.**
- *What it proves.* Functoriality under arbitrary actor maps; exact equality `valid? (renameActors ρ r) ≡ valid? r` under total injective endomaps of `ActorId = ℕ`, for every raw run, malformed ones included; and the permutation, or gauge, specialization with `WellFormed` transports.
- *Status.* Checked (commit `5670658`).
- *Honest value.* A standing obligation on the validator, close to true by construction, since `valid?` has no identity-sensitive clause. Its tests are degeneracy controls, not leak falsifiers.
- *Scope.* The actor channel only. Event, conversation, content and provenance identifiers have their own questions.

**16. Tier B, change of actor base.**
- *What it would add.* A substrate-native `ActorBaseMap` or isomorphism, and a relative `FrameHomOver` that recovers the banked `FrameHom` over the identity.
- *Status.* Selected, and currently *inexpressible*: realized actor carriers vary with the run, while `FrameHom` lives over one fixed base. The first consumer is the closure transform.

**17. The closure transform, live → public.**
- *What it does.* Pseudonymizes actor occurrences freshly per conversation, drops authorship and the live identity map, and keeps participant count, outputs, provenance, references, directed edges and stable publisher-scoped identifiers.
- *Preservation target.* Each conversation frame. The global frame is *not* preserved by design: a person on two live panels becomes two unrelated public handles. Descent over live panel overlaps can be nontrivial while the public view forgets those overlaps, which is controlled loss.
- *Falsifiers.* Non-injective handles; a transform that rewrites a content reference.
- *Status.* Selected.

**18. No-leak / erasure (Adapter 7).**
- *Today.* Enforced by omission and import discipline.
- *Ladder* (`openings.md`):
  - Tier A, checked;
  - Tier B and the local publication theorem, selected;
  - Tier C, optional univalent upgrade;
  - Tier D, observational no-leak for trusted documentation and audit observations, with a possible universal invariant quotient. Research-scale, blocked on observations that do not yet exist.
- *Four protections, of which only the second is under formal development:*
  - *not ranked*: grounded by omission, not a theorem that no ranking is definable;
  - *not exposed*;
  - *not consumed*;
  - *not copied*: no natural diagonal copies the actor carrier into documentation.

### E. Publication and onward (K at one time ↔ K at a later time)

**19. Promotion = publication + typed reference (formerly Adapter 5).**
- *Relates.* A closed conversation's output to later work, through a stable artifact interface.
- *Arc/19's refinement.* This is "making available", consumer-initiated, with no pushing, and Avail names a construction to investigate.
- *Status.* Specified; contract v1 (closure events, run-local and federated references) is selected and starts with rejecting fixtures.

**20. Federation import and translation.**
- *Relates.* One peer's published bundle to another peer's local presentation: pinned, locally admitted, with typed partial translations.
- *If provenance is adopted.* It would add the lifecycle adopt, update, retract, detach, fork, rebase and supersede, with authority separated: the source is authoritative for its artifact, the importer for adoption and local interpretation.
- *Status.* Exchange constraints selected; morphism laws for partial translations open.

**21. Protocol version change (Π).**
- *Relates.* One protocol version to a later one, with preservation evidence, a newly admissible operation, and an activation boundary.
- *Requirements.* Identity must recover prior behaviour; renaming or duplication must not count as renewal.
- *Status.* Committed responsibility.

**22. Provenance materialization.** The conditional commutation law of section 3.2, between the derivational and temporal faces of an accounted artifact. Candidate.

## 16. Boundary cases and neighbours

### Allow ⊣ Require

The cross-side adjunction is counted as an adapter by `architecture.md` but is not internal to K. `bias_correction.md` insists on the distinction: R4 is the K-internal adapter; `Allow ⊣ Require` relates M and K; nerve–realization does not automatically reverse it.

Arc/06's hope that the cross-side pair would be "the endpoint of many smaller compatibility adapters" survives as an intuition, not a plan. Section 21 suggests one way to make it useful.

### Doc ⊣ Aff

A third candidate adjunction, `Doc : Op → Ct` with `Aff : Ct → Op`, came out of the external exchange in arc/15. It is kept distinct from `Allow ⊣ Require`, from a ⊣ ι, and from `Lpoint ⊣ Rpoint`, and is downstream of the Lautman adequacy, invariance and compatibility families.

### The structuring relations R1–R11

The module inventory in `status_formal.md` names relations between modules:

| Relation | Name | Content |
|---|---|---|
| R1 | Valuation | Presheaves valued in a category |
| R2 | Indexing | Sheaves over a site |
| R3 | Generation | Topos from site plus topology |
| R4 | Interpretation | Cartesian internal logic versus linear algebra; the Benton bridge |
| R5 | Ambient comparison | Under reconsideration with M |
| R6 | Parametrization | Causality parametrizing the site |
| R7 | Algebra over operad | |
| R8 | Involution and duality | |
| R9–R11 | Modular envelopment, moduli realization, arithmetic action | Deferred to MO₁ |

These describe how the modules hang together. An adapter, in the sense of this inventory, is such a relation given an explicit, named interface. R4 is the one relation that has become a fully fledged adapter.

### Set-level reducts

A "truncate everything" exchange (`openings.md`) proposed a family of named reducts from the rich structures to set-based ones:

- an *actor portal* preserving relabeling invariance;
- a *linear portal* through Chu;
- a *sheaf portal* to Set-valued sheaves or global sections.

Each must state what it preserves and forgets. The information lies in the kernel and the non-faithfulness. These are adapters downward, toward ordinary set-based mathematics, rather than across a separation inside K.

### Software adapters

The runtime uses the word in the hexagonal-architecture sense:

- Phoenix as edge adapter;
- the checker adapter, gated on an actor kernel;
- persistence adapters and a Pijul port under `hoapa_store`;
- the admission adapter keeping the eligible population out of every run (arc/17).

This is a homonym, but the discipline is the same: compile-time walls so that `hoapa_core` depends on neither web, persistence nor checker.

---

# Part IV — Observations in my own voice

The instigator authorized a closing section of my own readings. These are mine, not the project's, and are offered for Codex's parallel version and for discussion.

## 17. The only numbered adapter list in the repository is stale

The `Presheaf.agda` header is the one place adapters are numbered, and it predates several decisions:

- Its Adapter 5 still describes promotion as a conversation becoming an actor, consensus emitting a Π-morphism, and deferral to MO₁. All three were superseded on 2026-09-12.
- Its Reflexive reservation says non-retroactivity is inherited from `FrameHom` strictness, which `openings.md` now denies explicitly.
- It refers to `workflow/status.md`, which no longer exists.
- Its Adapter 6 uses the retired A-side/B-side vocabulary.
- The list has no entry for change of value, R4, the Chu witness and realization, runtime realization, Tier B, or the closure transform. These are the adapters that actually carry weight.

Separately, `Hybrid/Descent.agda` (the arbitrary-frame, probe-form Adapter 2) is absent from the Hybrid file table in `status_formal.md`.

The code headers are my surface, and I am not changing them in this pass. My suggestion would be to retire the numbering in favour of the prose list in `architecture.md`, and to make the header point there.

## 18. The two cascade presentations should be reconciled, not merged

`motivation.md`'s seven rows and `openings.md`'s five numbered layers are both right about different things: the first about the generative narrative, the second about maturity and build dependence. A reader meeting them separately will think they disagree, about whether Hybrid is a layer and where conceptual variation sits. One sentence in each, pointing to the other, would do.

The candidate accounted-artifact layer has a third placement, between Hybrid and Π. That placement too is visible only in `openings.md`.

## 19. "Separation" means two things, and the mirror uses the less organized one

As "How to read this inventory" notes, the cascade is made of responsibility separations, each attached to a *trade-off between two goods*. The mirror's inventory in arc/18 is made of preserved distinctions (contributor/contribution, episode/artifact, local vocabulary/translation, dependence/equivalence), which are not layers and have no trade-off attached.

That suggests a source of M-side candidates that the record has not yet used. Each layer's trade-off names two goods held in tension:

- locality and globality;
- stability and adaptability;
- expressive power and transparency;
- exploration and exploitation;
- coherence and plurality;
- density and accessibility.

The M-side question for each layer would be: what contextual structure makes both goods *jointly* available, so that the K-side separation is the price of that joint availability? Sheaf descent already answers it for the first pair. That is exactly why the Hybrid is the one layer with real mathematics, and it is also the one place where a K separation and an M integration have been seen together in the same construction. This is a suggestion, not a reading of the record.

## 20. A pattern in the adapter inventory: internal adapters are checked, surface adapters are open

Arc/18 predicted that the hardest unproven obligations would cluster at the surface. Sorting the adapters of section 15 by whether they relate two K-structures or cross the reality/representation boundary bears this out quite sharply:

- **Every checked adapter is internal:** restriction, separatedness, finite descent, the value-axis adapters, change of base, R4, Chu, the Sessions realization, raw realization, and Tier A (which is about a raw encoding, not about the boundary).
- **Every surface-crossing adapter is open:** the closure transform, Tier B, observational no-leak, the admission of the eligible population, the Reality interface, publication as "making available", and Federation imports.

I would not claim this as evidence for the surface reading, since it may only reflect where the work has been done so far. But it gives the 2S lane a clean description: it is the lane that builds the surface adapters. It also suggests the M rebuild may first become visible there, at the surface, rather than in the internal sheaf machinery.

## 21. The adapter list could serve as a checklist for M candidates

Arc/06's hope that `Allow ⊣ Require` is the endpoint of many smaller adapters can be turned into something testable without constructing anything. Each internal adapter names a structure the architecture protects:

- locality and restriction;
- local agreement detecting global agreement;
- gluing;
- the cartesian/linear resource distinction;
- process/context duality;
- actor-neutrality;
- directed causality.

A candidate M, or a candidate correspondence, that would force any of these to be forgotten fails T4's preservation requirement before any adjunction is attempted. Arc/19's preservation table (section 11) is already a version of this. Making it an explicit, retained negative control for every M proposal would be cheap, and would catch the cathedral-and-brick mismatch early.

## 22. Promotion is the clearest instance of the project's own method

Promotion has had three lives:

1. a future morphism class turning a conversation into an actor;
2. the bridge from consensus to a protocol-version morphism, read through MO₁'s genus grading;
3. publication plus a typed reference.

The difficulty that drove the first two (strict reflection forbids collapsing a conversation) was never solved. It was dissolved by changing the definition: results enter later work through an interface, not a morphism. That is the rising sea working as the project's style guide describes it, and it is worth telling as such when the architecture is presented.

## 23. The "first confirmed mirror pair" is weaker than it was called

The Harper-X pair (section 4) was offered in arc/18 as one verified instance of the mirror. On closer reading it rests on three things:

- a reconstructed, unverified sentence;
- an identification of no-leak with non-well-pointedness that the same arc later says is unproved;
- for its strongest version, a reflexivity assumption the project has never made.

It is a good *candidate* pair, and its machine-checkable fragment is worth keeping: a non-degeneracy obligation of the form "some type the modality does not resolve". But "confirmed" overstates it. If the mirror needs a first instance, sheaf descent on the Hybrid, the one place a K separation and an M-like integration already share a construction, is a better-grounded candidate than any pair imported from a remark.

## 24. One word, two meanings: "bulk"

Arc/08 calls the content layer Λ the "Bulk"; arc/11 calls Reality the bulk and documentation its boundary. Arc/11 proposed reading these as nested (Reality | Documentation, and within documentation Λ | session), and `openings.md` lists the disambiguation as an open decision gate. Until it is settled, a reader meeting both uses will see a contradiction. Since the holographic reading is explicitly rejected in favour of Isbell/Gelfand-style space–observables duality, retiring "bulk" for Λ may be the simplest fix.

## 25. What is grounded, overall

Part I is largely grounded, in the sense that its separations are either checked, enforced by the code's refusals, or fixed by architectural decisions with retained fixtures. Part III's internal adapters are checked at stated scopes, and its surface adapters are selected or candidate. Part II has no constructed content at all: it is a well-specified research programme with named obligations and controls. That asymmetry is the current state of the conjecture in one sentence. The project's own position, which I share, is that this is the honest place to be: an open gate stated precisely.

---

## Index

| Term | Section here | Main source |
|---|---|---|
| Absolute / infinitesimal table | 9 | `openings.md` "Infinity and infinitesimality"; arc/21 |
| Accounted artifact, provenance, accountable change | 3.2, 15 (22) | `openings.md` provenance section; arc/10 |
| Adapter (definition, rule) | 13 | `architecture.md`; `naming.md`; arc/06 |
| Adapter numbering 1–7 | 14, 17 | `formal/Concurrency/Hybrid/Presheaf.agda` header |
| Allow ⊣ Require | intro, 11, 16 | `motivation.md`; `targets.md` T1 |
| Anchors (Complexity, Evolution, Praxis, Anthropic, Care) | 11 | arc/09; `motivation.md` |
| Bulk | 3.4, 24 | arc/08; arc/11 |
| Cartesian / linear | 5, 15 (7) | `status_formal.md`; arc/13; `bias_correction.md` |
| Cascade of trade-offs | 3 | `motivation.md`; `openings.md` layers |
| Chu witness and Sessions realization | 15 (8, 9) | `future_work.md` "Chu construction" |
| Closure event, closure transform | 4, 15 (17) | `architecture.md`; `future_work.md` Tier B |
| Comparison claim / admitted comparison / presentation | 3.4, 4 | `naming.md`; `architecture.md` |
| Conceptual variation | 3.5 | `openings.md` "Conceptual variation within Λ" |
| Contextual renewal | 12 | `future_work.md` §E; `openings.md` "Changing the conditions of integration" |
| Federation | 3.7, 15 (20) | `openings.md` layer 4; `architecture.md` |
| Five arrows | 4 | `naming.md` |
| Founding separation (hybrid) | 1 | arc/02 |
| Generation / description | 11 | arc/18; arc/19 synthesis |
| Harper-X pair | 4, 23 | arc/18 |
| Integration (meaning) | 9 | `naming.md` |
| Levels | intro, 7 | `architecture.md`; arc/17 |
| Live / public record | 4, 15 (17) | `architecture.md` |
| Lautman two realms | 1 | `related_structures.md` |
| Mirror (T4) | 9–12 | `targets.md` T4; arc/18 |
| No-leak ladder, four protections | 15 (15–18) | `openings.md` no-leak section; `targets.md` T_boundary |
| Promotion | 14, 15 (19), 22 | `bias_correction.md`; `status_formal.md` decisions |
| R1–R11 | 16 | `status_formal.md` "Structuring relations" |
| R4 | 15 (7) | `status_formal.md`; `targets.md` R4 subtarget |
| R8, two faces | 5, 15 (11) | `status_formal.md` |
| Reality, surface | 2 | `openings.md` Reality section; arc/11; arc/18 |
| Realization tiers | 15 (14) | arc/12; `status_formal.md` scope notes |
| Reflexive Π | 3.3, 15 (21) | `openings.md` layer 1; arc/07 |
| Relative cohesion | 11 | arc/18; `targets.md` T2 |
| Rising sea | 9 | `openings.md` "Reciprocal mirror and rising sea" |
| Tier A / Tier B | 15 (15, 16) | `targets.md` T_boundary; `future_work.md` |
| Unityping | intro, 1, 2 | `motivation.md` footnote 1 |
