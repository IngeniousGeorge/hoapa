# Hoapa Project Report — fill by deckhand

*Pass by Claude, nickname **deckhand**: the last stretch of work was deck transformations
(p ∘ g = p) and the anchors inventory, and ig's own §5.1 metaphor makes Agda the ship.*

Conventions, as asked:

- `-` items are **inventory**: the material that should be used, as pointers.
- `...` items are **filled**, dried-out.
- `{braces}` are commentary on the draft or the talk, strippable.
- Dried-out throughout: bare minimum, pointers, reminders, structure.

Source of fills: the twelve workflows, arc/22, arc/23, `presentation_of_hoapa_as_pure_form_of_communication.pdf`,
and the arc/21 exchange. Corrections carried from my earlier review are applied in place
and flagged in braces. Nothing is cut for time — §0 alone is over capacity for a single talk.

**Talk is in ~3 weeks (≈ 13 Nov 2026).** Audience mostly logicians.

---

## 0. Context and project history

### - Pitch

- The exercise, not the politics, first. Philosophy of mathematics + network engineering → a **theory of work**.
- For logicians, the hook: that work is constrained by *permacultural* logic, and the constraint is substructural.
- What it can do; its place in Nature.

{Reorder for this room. "Participative democracy" in sentence one signals politics-before-mathematics and will
cost you a fraction of the audience before the exercise arrives. The project's own discipline treats the political
concern as a *testable architectural contrast*, not a motivation — keep it there. Lead with the exercise.}

### - Opening remarks: mixtes, collective science

- 19th c.: analysis, arithmetic, geometry. 20th c.: algebraic geometry, differential geometry. Composite domains became normal.
- Unexplored composites, with the exception each pair needs (reductionism debases the second term):
  - philosophical mathematics — Zalamea, contra analytic philosophy of mathematics (Russell/Wittgenstein)
  - physical-biology — Kauffman, Extended Evolutionary Synthesis
  - biological-psychology — attachment theory (Bowlby)
  - organizational-social-science — Simondon: psychic and collective co-individuate, so the social's partner is not the psychological but a general theory of organizations
- Hoapa's **implementation** sits in the last. Its **theory** is an invariant across all these bridges.
- Mixte (Lautman): an intermediate structure enabling passage between kinds of being **without identifying them**.
  Source question for adapters: what must the intermediate retain from each side to make the passage possible?
- In science, the target is the ad hoc peer-review system and its entanglement with institutional political history.

{The mixte is doing double duty here: Lautman's technical notion and your "composite domain". Say which you mean.
Also: the project explicitly rejects identifying its R4 adapter with a Lautmanian mixte — worth not implying it.}

### - The initial exercise

- *What is the most universal and balanced communication system possible? And how do you make that question rigorous?*
- Arrived at by chance, pursued as a citizen.
- Name: **Hoapa** = "everywhere" (every domain) in **Khoekhoegowab**, Khoe family, spoken in Namibia, Botswana, South Africa
  by Namakhoen, ǂNūkhoen and Haiǁomkhoen. Three reasons for it (PDF §5): the concept has no essential element to name after,
  so name the multiplicity; homage to San culture; new to everyone, so nobody jumps to conclusions.

{Use the PDF's wording, not the letter draft's. The draft said the culture is "now largely extinct" and that they are
"descendants of the first implementers of absolutely universal and balanced communication systems". Both are problems:
San peoples are living (it is many San *languages* that are endangered or extinct), and the claim about prehistoric
social organization is not established — a scholarly room will file it as noble-savage framing and discount what
follows. The PDF already gets this right: living peoples, named, and "the last known human practitioners" as homage
rather than as anthropology. Keep the homage, drop the ethnography.}

### - Points of view adopted in this presentation

- The project admits several registers; this talk picks a path and should say so:
  1. Hoapa as an **implementation** (§1)
  2. as a construction in **set/model-theoretic logic** (§2) — the translation for this room
  3. as a **theory of work** (§3), entered through Kauffman
  4. as an **effective theory** resolving Lautmanian dialectics (§4)
  5. as a **conjectural adjunction** (§5)
  6. as **permacultural logic** (§6)
- Registers *not* taken today, so nobody waits for them: the modal/cohesive route (retired as prescription 2026-09-26);
  the runtime engineering; the Federation layer; Care.

{One slide naming what you are *not* going to argue is worth five minutes later. It also pre-empts the
"so is this mathematics or politics?" question by answering it on your own terms.}

### - Communication up to now & Zalamea

- Existing documents (PDF §7.2), each aimed at a different reader:
  - Extended abstract — "A linear/non-linear adjunction of sheaves…": the first deliberately modest theorem, machine-checked in cubical Agda. **For this room, this is the credential.**
  - Diagram — construction map for the cross-side adjunction
  - Letter of recommendation — Zalamea
  - "An Introduction to Grothendieck's General Theory of Evolution" — exact/natural scientists
  - "Univocal Science — From Spinoza to Grothendieck" — philosophers; the seed of the bridge
  - "Liberation engineering for resistance networks" — social scientists
- Zalamea: leading reader of Grothendieck and Peirce; urged the "big book" and ten years' solitary work. This talk is the turn toward it.
- Repository public on Codeberg.

### - The epistemological landscape

- **Kauffman** is the entry point for the theory-of-work view: constraints specified by separations of concerns,
  guided by the dialectics, embedded in the primary concrete/abstract tension, satisfying closure.
- **Peirce** is the newest addition — a repositioning rather than an addition: the *epistemological* anchor of the theory-of-work view.
- Full anchor roster, by job:
  - Lautman (with Zalamea) — decomposition, problematics, the double movement
  - Simondon (with Kauffman; Montévil–Mossio at closure) — individuation, milieu, non-exhaustion
  - Grothendieck — relative point of view, rising sea, descent, functor of points; *Récoltes* for praxis
  - Lawvere (with Grassmann, Kock) — internal logic, relative cohesion, intensive/extensive
  - Deleuze — immanent problematics, third synthesis of time, refusal to close
  - Peirce — pragmatic clarification, diagrammatic reasoning, community of inquiry, agape
  - Hegel — aufhebung as the schema's engine, minus the Absolute
  - Bowlby — attachment as an algorithm for network continuity; secure base
  - Leibniz — the characteristic, as horizon of the universal language
  - Bergson — the objector: qualitative multiplicity against magnitude
  - Gentzen/Prawitz — intro/elim harmony as the shape of borrow–work–return
- Full provenance ledger exists: `workflow/communication_drafts/anchors_concepts_claude.md` (51 entries, what is taken,
  what it becomes, what is refused) and Codex's parallel pass beside it.

### - Lautman turning point

- **Notions**, usually in pairs: *structure and existence*, whole and part, continuous and discrete, intrinsic and
  extrinsic, *formal systems and their realization*. Their relations and tensions are **Ideas**.
- Ideas are **problems**, never settled in themselves; partially *incarnated* in effective theories, each working the
  relation out its own way, none exhausting it.
- The movement is **double**: genesis forward (a problem presses into construction) and a **regressive** reading back
  (from an effective theory to the problematic it incarnates). Priority of the problem is in the order of reasons, not in time.
- **The domination argument** (use the recurrence form): the same *problem* recurs across theories with no common
  mathematical content — local/global in sheaf cohomology, in Galois descent, in gauge field theory — so what they
  share cannot be internal to any of them.
- Category theory gives precise form to *some* pairs: local/global as descent, particular/universal as a universal
  property, many-realizations as a moduli problem, formal/realization as theory and models.

{Two corrections from the letter draft, both applied above. (i) It said "**essence** & existence"; Lautman's thesis is
*Essai sur les notions de **structure** et d'existence en mathématiques*. Essence/existence is a different, scholastic
pair — and the first thing Zalamea will catch. (ii) It said the sign of domination is "recurrence of structure **and
content** in theories which would otherwise be unrelated" — if the content recurs the theories *are* related and the
argument refutes itself. It is the recurrence of the **problem** with the content differing. (iii) "Made rigorous
through category theory" overclaims; use "gives precise form to some pairs", which is also more interesting because it
says which ones have been cashed out.}

{Giving the French once for *les systèmes formels et leur réalisation* is cheap and buys this room a lot: it is the
model-theoretic pair, and Lautman's own example is the **Skolem paradox** — a formal system cannot pin down its
realizations. That is your single best bridge from Lautman to Helsinki.}

### - The argument

- Abstract work cannot reward its concrete substrate.
- Concrete/abstract is **relative**: a mathematical object is concrete relative to a more abstract one (Lautman).
- The relation substrate↔abstract must be dedicated to:
  a. mapping the context — `[concrete ↔ abstract] ↔ world`
  b. design: concrete → abstract
  c. application: abstract → concrete
- Within abstract work, the decomposition:
  - **synthetic** (Lautman) agents — actor model, one common plan
  - **analytic** (Lautman) documented concepts — differentiated, diagrammatic; this pole is well developed in current science
- Read as an object in a category of possible organizations of abstract work, Hoapa would be a **special object**.
  That is the project's sense of "optimality".
- Privileges of **degree** happen and are fine; privileges of **kind** never do. Hebbian plasticity rewards participating
  synapses; conserved genes are protected; no neuron becomes a different sort of thing. Deleuze's univocity: hierarchy by
  power, not by proximity to a higher principle — nomadic, not sedentary, distribution.
- "Exclusively through design and application" is a **condition**, not a fact. Bypassing the channel gives the pathologies:
  selfish genetic elements, cancer; seizures, addiction. Each is a breakdown of closure.

{"Special object" needs its category before it means anything, and this room will say so. The honest version: the
*comparison setting* is the primary target (T_comparison), the universal property would characterize a distinguished
organization of that relation, and Hoapa's membership in the resulting class is a **separate** obligation. Say all three.}

### - A theory of everywhere (a generalization of Yoneda), of work, of in-betweens (mixtes)

- Not a theory of everything: no essential element to privilege, so the name points at the multiplicity.
- Of **work**: §3–§4.
- Of **in-betweens**: mixtes, the composite domains of the opening remarks, Zalamea's Lautman.
- **Yoneda as analogy**: a world reconstructible from its web of relations to neighbouring worlds, as an object is
  determined by its maps from all others. State as an **analogy worth making rigorous**, and say plainly that Hoapa
  does not have the resources to do that any time soon.
- What the analogy would need before it is a claim: a category of worlds, the morphisms, a probe family, and a density
  or representability theorem. arc/22 already works through where Yoneda helps and where it fails — it captures identity,
  **not genesis**, and it recovers the ambient relationship only if the category is chosen to contain it.

{Being upfront here is a net gain with logicians: Yoneda is a theorem, and claiming a generalization you cannot state
is the one move that would make the room stop trusting the rest. "Analogy, unresourced, here is what it would take"
reads as competence.}

### - 1. As an implementation

→ §1. Scale, operations, biological metaphor.

### - 2. The implementation in logic

→ §2. Item-by-item translation of §1 into set/model theory. **The section that decides whether the talk lands here.**

### - 3. The context of work

→ §3. Kauffman, the loop into the abstract, the branch into concrete/abstract.

### - 4. The dialectics of abstract work

→ §4. Four pairs: concrete/abstract, synthetic/analytic, variation/individuation, structure/existence|genesis.

### - 5. The conjectural adjunction

→ §5. Allow ⊣ Require, Zalamea's three movements, what is checked, methodology.

### - 6. Permacultural logic

→ §6. Viral vs permacultural; the invitation.

### - Conclusion: objective & future work

→ Conclusion. The ask, and the message to education departments.

---

## 1. Hoapa as an implementation

- 1.1 Scale & context (by scale we mean "at the level of collective organization")
  - Scale: collective organization. Not individual cognition, not institutions as given.
  - Three layers: a communication system (program); its verification layer (proof checker); documentation of what they are and how they develop.
  - Context: the world is perspectival. All assertions are points of view; no neutral standpoint, because none exists.
  - **Levels** (what may occupy the active positions): level −1 a real conversation among participants; level 0 documented conversations and outputs occupying subject positions of a new level −1. Recurs: panels stay the active machinery, graphs are artifacts.
  - **Layers** (responsibilities within what is represented): session orchestration; content and provenance; identification and conceptual variation in Λ; reflexive protocol change; dynamics and measurement; Federation. Not temporal stages.
  - **Adapters** (relations across a separation): restriction, descent, change of value, promotion, the conjectural `Allow ⊣ Require`, no-leak. Not further levels or layers.
  - Hard boundary: Hoapa **charts** the world, does not inhabit or control it. Not a management system. Buffers both ways — it asks for what it needs, makes what it knows available, never advertises. Coach, never player.
  - Why the boundary is load-bearing: enacting would reintroduce hierarchy and destroy the separations, starting with unityping. You can share an idea without losing it; not a loaf of bread.
- 1.2 Operations
  - Actor model, three primitives: send; receive and update internal state; create new actors.
  - The real unit of computation is the **conversation**, not the individual.
  - Lifecycle: `task → draw → panel deliberation → one closure → publication`, with `↘ failure record → resubmission`.
  - Draw: a small number of registered participants selected **at random**, given a specification, time and resources.
  - Registration ≠ panel membership ≠ event participation. A registered actor may stay silent and join nothing.
  - Closure happens **exactly once**, success or failure, through a distinguished event. Success names an output artifact; failure produces a first-class failure record a later attempt may reference. Nothing is appended to a closed conversation.
  - Successful resolution requires **unanimity** under the interface's declared participation and assent rules. Candidate formation, assent attribution and silence policy are interface mechanics, delegated.
  - Session types carry orchestration — the "how": the shape and history of the global conversation, so documentation knows its own structure. Content types carry the "what".
  - Event record keeps three concerns apart: `causalParents` (operational dependence, to be *earned* from consumed messages); provenance (how it arose — response, deepening, correction, closure marker); content (the documented substance).
  - **Closure transform**: publishes a content-facing record with fresh per-conversation handles, drops authorship and operational identity, retains participant count, outputs, stable content identifiers, provenance, references, dependency edges.
  - Append-only. Editing means new events or conversations; published history is not rewritten.
  - Federation: peers import finite, explicitly versioned bundles and keep the snapshot they interpreted. No global directory, clock, consensus, language quotient or mandatory update.
  - The type/container strategy repeats whenever complexity is added: six layers encoded or planned, each from an engineering trade-off — local vs global content (sheaf descent); protocol stability vs adaptability (Π with a patch-theoretic fragment); expressivity vs accessibility (Λ); exploration vs exploitation (factorization algebra over the actor site valued in Λ); internal coherence vs plurality (2-category of protocols); receiver-relative complexity (information cohomology).
- 1.3 Biological metaphor
  - Keep as the memorable slide; the six rows are good rhetoric.
  - Supporting material: arc/23 throughout; PDF §3.5–3.7 for permaculture and Care.
  - Energy = Open source → because open source lives wholly in the abstract and has only ever used voluntary labour.
  - Neuron = Citizen assembly → citizen assemblies are the existing partial, compact realization of the operational side: random selection from the register, time and resources, consensus-only report.
  - Memory = knowledge graphs → Λ: directed dependency edges, versioned admitted comparisons, no global groupoid completion.
  - Internal language = self-produced language → the groupoidal layer inside Λ, plus "learn once, use everywhere" federation of jargons.
  - Sociability = Federation → finite pinned bundles, divergent admissions permitted.

{One row collides with §3–§4 and I would change it. "Metabolism = Hoapa" makes Hoapa the whole organism, but arc/23's
own mapping puts **metabolism on the synthetic pole and the genome on the analytic pole** — which is exactly your
agents/documentation split. So: *Metabolism = the agent layer; Genome = the documentation layer; Hoapa = the loop
between them.* That turns the slide from decoration into the same claim §4.2 makes, and it gives you the arc/23
examples (cell, brain, mathematics) for free.}

{Carry arc/23's caveat onto the slide or a careful listener will raise it: Lautman's two decompositions apply to **one**
object, while metabolism and genome are physically distinct parts. The analogy holds at the level of the cell's
*organization*, not its matter.}

---

## 2. The implementation in model and set theoretical logic

First pass, item by item against §1. Flagged `[?]` where I am least confident.

- **Unityped agents** → a one-sorted carrier for participants with **no distinguishing predicates**. Consequence: the automorphism group acts transitively on it. Checked result is stronger: the validator is invariant under all **injective endomaps**, not only permutations — so invariance over the *monoid of embeddings*, not the automorphism group.
- **Why that matters to this room** → Tarski's criterion: a notion is logical iff invariant under every permutation of the domain. Unityping is that criterion imposed on the participant sort. The embedding-monoid version is strictly stronger and has **no analogue in the group setting** — worth stating as an open question in logical form. `[?]` whether a known invariance class matches it.
- **Typed documentation** → many-sorted structure; sorts are the content types. Diversity of input handled by one sort; complexity of output handled by many.
- **A conversation** → a finite **induced substructure** of the run.
- **Causal order** → a partial order on events (Lamport). A run is a labelled poset plus an actor-incidence relation.
- **Local frames and their maps** → induced substructures with **order-reflecting** embeddings: `f(x) ≤ f(y) → x ≤ y`, not merely order-preserving. Fixed-base sub-view embeddings, never quotients.
- **Covers and descent** → a family of finite substructures jointly covering the run; descent is **amalgamation**: every compatible family of local data has a unique global amalgam. This is the Fraïssé-style vocabulary — amalgamation property, direct limits of finite structures.
- **The sheaf condition, set-theoretically** → for every cover and every compatible family of local sections there is exactly one global section. Separatedness = at most one; sheaf = exactly one.
- **Perspectivism** → a compatible family of local sections with **no** global amalgam. This is Abramsky's sheaf-theoretic contextuality verbatim, and it is the cleanest single bridge: obstruction as information, not failure. `Op`-side theorem already banked reads "no privileged points of view on the operational side".
- **Point-generated reflector `a ⊣ ι`** → the structure generated by its one-point (event-point) restrictions; the reflection of a presheaf onto those generated by point data. Model-theoretically: the substructure generated by the singletons, with reflection as a left adjoint to inclusion.
- **Session types and duality** → an involutive operation on a grammar of protocol terms, `S ↔ S^⊥`, with `dual-involutive` syntactic. The operadic boundary swap is the 1↔2 perspective exchange.
- **Linear/non-linear (Benton LNL)** → two fragments and an adjunction between them: a cartesian fragment where **contraction and weakening** are available, and a resource-sensitive fragment where they are not; `!` readmits copying under control. Straight substructural logic; the room knows this.
- **`Chu(SET,Bool)`** → a Chu space is `(points P, states S, r : P × S → Bool)`: a **two-sorted first-order structure with one binary relation**. Its Galois connection is formal concept analysis; the concept lattice is the nucleus of the pairing. **Lead §2 with this** — it is the item that needs no translation at all.
- **`Allow ⊣ Require`** → an adjoint pair; on posets a **Galois connection**. For this room the familiar instance is the connection between theories and their model classes, or between syntax and semantics. Neither functor is constructed.
- **Λ and concepts** → a directed graph (dependency edges stay directed) plus, per documentation version, a chosen set of **admitted** comparisons that may be inverted. Localization at that set only; no global groupoid completion. Withdrawal makes a later version, never rewrites the earlier admission.
- **Federation** → amalgamation over pinned finite bundles, with the amalgam **not** required to exist globally. Peers are different completions of overlapping finite data; divergent translations permitted.
- **Non-collapse (T1/T3)** → failure of a comparison map to be invertible. Model-theoretic analogue: a non-surjective or non-elementary embedding, or failure of elementary equivalence between a structure and its image. The ladder is ordered — rung 3 ⟹ 2 ⟹ 1, converses not assumed.
- **Lautman, for this room** → *formal systems and their realization* is the syntax/semantics pair, and his own example is the **Skolem paradox**: a formal system cannot pin down its realizations, so unintended models slip in. Pattee's symbolic/dynamical split is the same shape with the realization made physical.
- **The one postulate** → `session-O1-action`, named and isolated. Everything else in the Sessions line is postulate-free syntax plus derived results.
- **What is *not* available in this language** → the homotopical content. The formal work is **cubical** Agda: identity as structure, transport, higher coherence. A set-theoretic rendering loses exactly the layer Λ's identification and coherence responsibilities live in. Say so rather than let someone find it.

{This is the section I would rehearse against a hostile reader. Two honest framings available, and I would use the
second: (a) "here is the construction, in your language" — invites the reply that the translation lost the point;
(b) "here is which parts translate cleanly, which translate with loss, and which do not translate — and the ones that
do are already first-order structures you recognize". The Chu space, the poset of events, the amalgamation property and
the substructural fragment all land in (b) with nothing lost. The homotopical layer does not. Leading with the
honest partition is stronger than leading with a complete-looking dictionary.}

{Pre-empt the obvious question: *why not just do this in set theory then?* The answer the project actually has:
nothing stops the base layer being set-theoretic, and the Chu/descent/substructural parts were in fact built in a
setting that is agnostic about it. What needs more is Λ — conceptual identity, admitted comparisons, coherence —
where identity-as-structure is the point rather than an ornament.}

---

## 3. Thinking about abstract work

- 3.1 Work in the context of Kauffman (see arc/23)
  - **Atkins' definition**: work is the *constrained release of energy into a few degrees of freedom*. Contrast the textbook "force acting through a distance". Energy counts as work only when a constraint channels it.
  - Canonical example: the cannon. The cannon is the constraint — a boundary condition — forcing the expanding gas to push along the bore.
  - It took work to make the cannon → the **work–constraint cycle**. "Work begets constraints beget work" (*Investigations*, 2000). No constraint, no work; often no work, no constraint.
  - **Constraint closure** (Montévil–Mossio 2015): A constrains the release in process 1 that builds B; B constrains process 2 that builds C; C constrains process 3 that builds A. The system does the thermodynamic work of building its own boundary conditions.
  - Constraints are **relatively conserved** during the processes they constrain, while depending on other processes for maintenance at longer timescales.
  - **Non-ergodicity**: at the protein level the universe does not visit its state space, so evolution is inherently *historical*. Ergodic at the atomic level.
  - **RAF theory** keeps environmental inputs through the food-generation condition — closure is organizational, not energetic; the system stays open to the flow through it. And a structural catalytic network does not establish dynamically viable operation.
  - Three closures as **questions**, not as borrow/work/replay stages: constraint closure — does organized work sustain the structures enabling further work? work-task closure — are the necessary activities actually *carried out* rather than merely specified? catalytic closure — does work produce reusable means facilitating further production of such means?
- 3.2 Adding a loop into the abstract (Peirce, biosemiotics, Pattee, von Neumann, Deacon, Mossio & al., etc.)
  - **Pattee**: life needs two kinds of constraint — lawful dynamical ones (membranes, enzymes; rate-dependent) and **symbolic** ones whose physical form is *arbitrary* relative to what they stand for (the genetic code; rate-independent). **Semantic closure**: the symbols specify the machinery that reads the symbols. The **epistemic cut**. Neither side reduces to the other.
  - **von Neumann**: a description used two ways — *interpreted* to build the offspring, *copied uninterpreted* to pass along. Worked out before DNA's structure was known.
  - **Hoffmeyer & Emmeche**: code duality — an organism exists twice, as a digital message to itself across generations and as an analog body interpreting its world. Hoffmeyer adds increasing *semiotic freedom*.
  - **Mossio, Montévil, Moreno**: closure **naturalizes function** — a part has a function iff it is a constraint contributing to maintaining the closure. Lineage: Kant, Maturana–Varela, Rosen.
  - **Rosen**: (M,R) systems, closure to efficient causation.
  - **The energy-degeneracy mechanism** (the key move, and not Peirce's — it is 20th c. thermodynamics, Szilard/Landauer to Pattee): for a substrate to hold abstractions its states must be roughly energy-degenerate, so physics does not decide the content. The abstract layer therefore does *tiny* work, which builds constraints that gate *large* releases. **Thinking is cheap work on constraints that channel expensive work.**
  - **Why the detour is worth it**, in Atkins' terms: **leverage** — a cheap constraint gates a large release; **memory** — a constraint stored abstractly is reusable without being rebuilt. The cannon has neither, so it never makes the detour.
  - For it to be **closure** and not just a controller on top: B's metabolism must also do the work that rebuilds and maintains A.
  - Not unique to brains — the cell already does it with DNA; neurons are a second, faster, rewritable layer of the same trick.
  - **Peirce as the original figure** (holds all the pieces; not the root of the lineage):
    - Letter to Allan Marquand, 30 Dec 1886: logical operations by **electrical switching circuits**. A circuit diagram survives in Marquand's papers; no evidence either built it.
    - "Logical Machines" (1887): every machine is in a sense a reasoning machine — the relations among its parts entail relations nobody intended. Univocity: no gap of kind between mechanism and logic. Two built-in impotencies: no originality, so it cannot find its own problems; and it can only do what it was contrived for. **Machines apply; they do not design.**
    - "Pragmatism" (1907): all brute-force action is dyadic; **semiosis is irreducibly triadic** — sign, object, interpretant — and cannot be decomposed into pairwise actions. Pattee's split, sixty years early.
    - Same MS: emotional, energetic and logical interpretants. The **energetic** interpretant is an exertion — work. The **ultimate logical** interpretant is a *habit-change* — a new standing constraint on future action. Semiosis passes through work and ends by building a constraint.
    - 1891–92 cosmology: natural laws are habits the universe has acquired; matter is mind whose habits have hardened.
  - **Qualifications, state them**: Jevons built the first logic machine in 1869, and Leibniz and Babbage precede that — Peirce's priority is specifically the *electrical* idea. The Marquand letter was published only in 1993; Shannon reinvented switching logic independently in 1937; von Neumann, Pattee, Kauffman and Mossio–Montévil do not build on Peirce. The genuinely Peircean line is biosemiotics and Deacon. And the interpretant triad appears in only one manuscript, which Peirce later abandoned (Jappy 2024).
- 3.3 Branching into Lautmanian dialectics: concrete & abstract
  - The flip: an arbitrary piece of the world dedicated to manipulating abstractions, which then applies the result back.
  - What is concrete and what is abstract is **relative** — a mathematical object is concrete relative to a more abstract one.
  - The two **mixtes** performing the flips are perception and motor action. Ribosome and tRNA are mixtes between code and chemistry.
  - **Asymmetry worth flagging**: in the cell, design runs mostly by selection across generations, not inside any single cell; in the brain, learning closes the loop within one life. The incarnations differ by the timescale over which *design* runs — a candidate axis for ranking by power without breaking univocity.
  - Lautman's own mathematical mixte: **Hilbert space**, a synthesis of continuous and discrete — a function becomes a list of coefficients, which is the flip in mathematical form.
  - Unity argument, recycled: Lautman's move is that Weyl's analytic/synthetic split is **not** a fault line between irreducible disciplines, because synthetic viewpoints turn up inside analysis itself. Unity comes from **convergence of methods**, not from reduction to a common foundation. Transposed: abstract work in cells, brains and mathematics is unified not by a shared substrate but because each realizes the same problem.

{The map/territory framing in the letter draft — "a map can't include the things it's supposed to represent" — invites
immediate contradiction in this room: self-referential systems exist, and Lawvere's fixed-point theorem is about
exactly when. The project also *has* a reflexive protocol layer. Restate as cost and faithfulness: a representation
that includes its own territory pays for it, and the question is what it must give up.}

---

## 4. Hoapa in the dialectics of Lautman

- 4.1 Concrete / abstract (following the ideas in 3.)
  - Level I. How do particular mathematical realities and general structures determine one another?
  - The reflection image: the world to be reflected occupies the concrete, the reflecting apparatus a small fragment, and its work happens in the abstract. From the reflector's side the reflected world is the abstract and it is the concrete. **The reversal is the interesting part and deserves more than a clause.**
  - **Covering spaces, as a structural analogy and not a mathematical identification.** A covering `p : E → B` provides a space in which distinctions between lifts become available, while its deck transformations `g` preserve reference to the base: `p ∘ g = p`. That is transformation without change of the *specified projection* — not transformation without change of anything whatsoever (Hatcher §1.3). Hoapa's analogous ambition: enable articulation and transformation while preserving declared relations to context, and propose a corresponding requirement for the conditions of participation — participants' standing, and the boundary between their lives and their contributions. Covering theory supplies the example; it neither derives the requirement nor establishes that Hoapa satisfies it.
  - **Two differences that make the comparison productive rather than decorative.** Deck transformations form a **group**, being homeomorphisms with inverses, whereas the invariance actually proved on the participant channel is over injective — not necessarily surjective — relabelings, hence a **monoid**. Invariance under transformations that cannot be undone is a different and in one respect stronger demand with no covering-theoretic analogue. And a covering preserves *one canonical projection*, while Hoapa would preserve a **declared family** of relations — which places the nearer mathematical home at a site with a declared topology rather than at a covering space.
  - The two failure poles the covering picture gives for free: **collapsed fibre** (occupants genuinely interchangeable — the misreading that actor-renaming invariance makes every identifier meaningless, explicitly rejected) and **trivial deck group** (every occupant pinned, identity load-bearing — the architectural counterexample: fix eligibility and protocol, then let documentary output determine the right to occupy a seat). The architecture wants a non-trivial fibre with a non-trivial group acting on it.
  - Lautman's pair here: *les systèmes formels et leur réalisation*, with the Skolem paradox as his example.
- 4.2 Synthetic / analytic
  - Lautman's **two decompositions**:
    - **proper / individual / analytic** — articulates what is peculiar to the entity. Prime factorization; the roots of a polynomial. From the particular toward constituents that characterize *it*.
    - **dimensional / synthetic** — follows a common plan supplied by the ambient domain. A vector relative to a dimension and a chosen basis; the whole determines a uniform mode in which each element is articulated. Expresses the **solidarity** of the elements through their shared domain.
  - **Not an absolute separation.** A proper decomposition also depends on an ambient domain: a polynomial factors over one field and not another, and extending the base discloses constituents previously unavailable. Conversely the dimensional decomposition does not erase individuality; it gives coordinates relative to a shared structure.
  - `propre` is also the French for "eigen" (*valeur propre*), which almost certainly colours his usage. Good for this room.
  - **Project reading**: what is decomposed is *understanding of the world*, in two realms — embodied among a community of thinkers, organized **predominantly synthetically** through one common unityped mode of participation; and documented through concepts and their relations, organized **predominantly analytically**. The vector image carries shared capacity with situated contributions; prime factorization carries articulation into constituents specific to what is understood.
  - **Rejections, say them**: not identical minds; no basis of people; no canonical conceptual primes; no unique factorization; `Op = analytic` and `Ct = synthetic` rejected as an exhaustive layer assignment; unityped ≠ untyped or dimensionless; both moments occur in **both** realms, and neither M nor K is "the synthetic side".
  - **The rigidity requirement.** In K the assignment stays rigid, or the separation of concerns it names is not a separation. The Lautmanian problem lives **at the adjunction**, not inside either side. Rigid endpoints are the precondition for the liaison to be statable. Documentation's aspiration to become synthetic — furnishing languages for later understanding — is then a datum of the round trip `Allow ∘ Require`, not a drift in the assignment.
  - **arc/23's three examples** (use all three; this is where the biological metaphor earns its keep):
    - cell — synthetic: metabolism, a common core plan situating the cell in its milieu; analytic: the genome, the list proper to this lineage
    - brain — synthetic: neurons on one blueprint; analytic: the repertoire of memories proper to this brain (attractor models make "eigen" almost literal)
    - mathematics — Lautman's own case
  - The pattern: **synthetic sits on the dynamical side, analytic on the symbolic side.** The concrete/abstract flip is the passage from one decomposition of the same system to the other.
  - **Caveat to volunteer**: Lautman's two decompositions apply to *one* object; metabolism and genome are physically distinct parts. The analogy holds at the level of organization, not matter. First objection a careful reader raises.
- 4.3 Variation / individuation
  - Level III. How are constituents identified, and how do their identities and relations persist or change?
  - Three candidates weighed (arc/22 §7): discrete/continuous — too general, misses decomposition; rigid/deformable — does not express coarse-graining; **individuation/variation** — chosen, with rigidity/deformability as its principal mathematical manifestation.
  - It permits a distinction worth having: a decomposition can stay **exact** while varying continuously; **individuation** of constituents can fail at singularities and degenerations; a **coarse-grained** invariant can remain stable throughout.
  - Mathematical ladder: eigenvalue decomposition (the elementary case) → moduli spaces (classifying objects → studying their variation) → persistent homology (makes coarse-graining precise and quantifiable).
  - **The third level reactivates the second**: families of decompositions become new synthetic wholes — moduli spaces, categories of families — which then become objects of abstract investigation and concrete realization. Schema: object → analysis → constituents → variation → families of decompositions → synthesis → new whole.
  - **Simondon** here: preindividual field; **metastability** as a real third state, neither resolved nor unstable; individuation as the progressive resolution of a local incompatibility, structuring both an individual and a milieu in which further transformation stays possible; **transduction** as stepwise propagation where each resolution supplies conditions for the next; a successful individuation does **not** exhaust the preindividual reserve.
  - **Simondonian information** is not Shannon's: it concerns a problematic and the receiving system's transformation, not a transmitted signal. Distinguish an artifact being *accessible* from its *becoming informative in a particular encounter*.
  - Project tie: **conceptual variation in Λ** is a committed responsibility whose mathematics is under investigation — a participant should be able to distinguish a stabilized result from its declared possibilities of variation, inspect the conditions and evidence for those possibilities, and ask what a proposed reuse preserves. A comparison may preserve a present answer without preserving its response to change. Provenance records how a result arose; it does not recover how it could vary.
  - Placement sharpening already recorded: conversations and artifacts individuate; **participants do not** — people arrive as already declared persons and the protocol does not refine their identity. Receptivity belongs to the milieu and its available continuations.
  - **Do not rename the project's causal "saturation" as metastability** because the words suggest each other. Internal generation, output terminality, boundary factorization and purpose-relative opacity are different predicates.
- 4.4 Structure / existence | genesis
  - The thesis is *Essai sur les notions de structure et d'existence en mathématiques*, in two parts: **Schemas of Structure** and **Schemas of Genesis**. The hinge quote sits between them.
  - > "[T]he ascent towards the absolute has as a consequence, not only to confer on a mathematical entity the greatest simplicity of internal structure possible, but to make it able to give rise to entities other than itself." — Duffy trans., Continuum 2011, pp. 130–131.
  - His example: **Riemann surfaces** — passing to the universal covering surface enables new constructions of functions. Structure's simplification is what makes genesis possible.
  - **Work–constraint maps onto structure/existence**: a constraint is structure; work is the act bringing something into existence; the cycle is a genesis that loops — structure engenders existence (constraint channels energy into work), existence engenders structure (that work builds the next constraint).
  - Two further pairs fit closure itself:
    - **intrinsic vs induced** — a cannon's constraints are *induced*, imposed by whoever built it; a cell's are *intrinsic*, produced by the system. Closure is where all the relevant constraints become intrinsic.
    - **the ascent toward completion** — algebraic closure: every equation over a field finds its roots inside the field. Constraint closure: every constraint the system needs is produced inside the system. **The analogy a logic audience will enjoy most.**
  - **Solidarity** (Lautman's word, four senses): between whole and parts; between a mathematical being and its ambient universe; between domains and operations; reciprocal between theories. Solidarity is the *relation*, genesis the *movement*.
  - **Immanence**: the closest precise match is Spinoza's *immanent cause* — a cause that stays inside its effects. A cannon has a transcendent cause, its maker; in a closed system the constraints are produced by the processes they constrain. Closure is a finite, approximate *causa sui*. Tension: closure produces an individual with an inside and an outside, which Deleuze and Guattari distrust (the organism as a stratum capturing flows). **Univocity fits better than immanence**: work means the same thing for the cannon, the cell and thought — no vital force, no dualism; Pattee's split survives as a difference of *mode*, within one physics.
  - Project renewal criterion, stated as a test with its failure modes — aufhebung's three moments: **preserved** (specified earlier artifacts and judgments stay recoverable), **cancelled** (the earlier form loses standing as the operative setting), **lifted** (work impossible before becomes possible). Preservation without lifting is maintenance; lifting without preservation is loss dressed as progress; cancellation without either is churn.
  - Sharp instance: **different sites can present equivalent topoi, so a changed site alone establishes nothing.** Distinguish new objects within a fixed setting; another presentation of the same semantics; and changed contextual capability.
  - Open: a mathematical notion of **extension** that preserves the old structure while introducing genuinely new objects, relations or operations — which would separate mere reproduction, conservative extension, and creative continuation.

{§4.3 and §4.4 both import reversible machinery, and it is worth one honest sentence. Moduli, deformation, transport
and holonomy are **groupoidal**; K's dependency edges are **directed**, and only explicitly admitted comparisons may be
inverted. The project has met this mismatch by several independent routes. Saying so turns a hidden weakness into a
stated open problem, which is the better position in front of logicians.}

---

## 5. The conjectural adjunction

- 5.1 The adjunction in Zalamea's Lautman (where 1 = K, 2 = M, 3 = the category resulting from the adjunction):
  - *[the two quoted passages, as in the draft]*
  - The annotation is the content and should be said aloud: ① "a world much richer in determinations, full of precisions and delimitations" = **K**; ② "a world of ideas of possible, free relations" = **M**; ③ "the back-and-forth is inevitable" = the category the adjunction produces.
  - Note the direction, because it is the reverse of what a reader guesses: **K is the determinate side, M the side of free possibility.** It also matches the project — M is contexts and their possibility, K the determinate protocol.
  - Lautman's levels of structure, from the long quote, as a ladder worth reusing: structured concrete objects (groups, algebras, Hilbert spaces) → intermediate structural correspondences (duality theorems, **Galois correspondences**, conformal representations) → generic structures (lattices) → **structural schemas**, at an upper logical level, more simple and universal, assembling free oppositions (local/global, intrinsic/extrinsic, discrete/continuous) across collections of possible structures.
  - Restrictions and delimitations are an **enrichment**, not an impoverishment, through the precision and certainty they provide. Pair this with the separations of concerns: each restriction buys a guarantee.
- The state of the conjecture
  - `Allow : M → K`, `Require : K → M`, conjecturally `Allow ⊣ Require`. **Neither functor is constructed.**
  - The conjecture is **relational**, not "K is the best architecture": seek a comparison setting in which alternative organizations can cover and articulate contexts, return usable work, and make further inquiry possible. A universal property would characterize a distinguished organization of **that relation**. Hoapa's membership in the resulting class is a separate obligation. That is what *optimal* means here.
  - M is **to be discovered**, not prescribed. Cohesive and modal HoTT informed the construction of K and remain resources; since the 2026-09-26 reorientation they are no longer the prescribed answer.
  - What is **machine-checked**: the actor-causal site (opaque unityped actors, Lamport causality, local frames, strict-reflecting embeddings, basis covers); full finite-site event-product descent; the point-generated sheafification and reflector `a ⊣ ι`; the point-generated Benton/LNL bridge `Lpoint ⊣ Rpoint`, relative to a value-level `lnl` and a finite-products hypothesis; a `Chu(SET,Bool)` coefficient witness; the Sessions-to-Chu object/morphism realization; postulate-free session object grammar with syntactic `dual-involutive`, and the derived operadic `boundary-swap-at-gen`; Tier A — raw-validator invariance under total injective actor endomaps, with permutations as the invertible specialization; and on the runtime side a schema-faithful recorder with exact corpus replay.
  - The **one** remaining Sessions postulate: `session-O1-action`.
  - What is **not** done, said plainly: the cross-side functors; the full Set-valued locality topos and its internal logic; the generic finite actor-causal sheafification reflector; event-dependent session content; realized change of actor base; observational no-leak; Λ.
  - Methodology metaphor: **AI is the elements** — sea and wind, which supply motion; **Agda is the ship** — persistence and the safeguarding of coherence; **ig and the anchoring authors supply the direction.**
  - Expected result: see `workflow/motivation.md`.

{The previous draft described the far side as "some category representing 'nice mathematics'". That contradicts the
project's own current position, where M is the **world/context** side, explicitly to be discovered. It is also the
pre-reorientation framing, when the claim was about the development of mathematics. Zalamea is precisely the reader
who will hold you to whichever one you pick, so pick deliberately — and if you do mean to revert, say that you are.}

{The "what is checked / what is not" pair is the highest-value slide in the talk for this audience, and it is currently
absent from the outline. Three sentences of banked results plus one named postulate plus a list of what remains buys
more credit than any philosophical claim in the deck, because it demonstrates the discipline you are asking them to
trust.}

---

## 6. Permacultural logic

- **Viral** logic: takes from context, exploits, exhausts, leaves no continuation.
- **Permacultural** logic: borrow → work → return → replay.
- Nature uses both — Patrick Forterre, "To be or not to be alive". {State this as Forterre's thesis about viruses, not as a general law; it is contested and the attribution protects you.}
- **Keep all four moments.** Borrow supplies an enlarged context, presentation, resource or temporary assumption. Work explores and articulates. **Return** presents an achievement — or an obstruction — with its dependencies. **Replay** is a later, purpose-relative uptake. Integration is not automatically return; return is not replay; replay is not automatically renewal. Dropping Return loses the step where the closure transform acts.
- The logical home is **Gentzen**: introduction, elimination, harmony. Borrow from context, work, return the use as a stable rule. Cut and substitution are how a construction becomes usable in further reasoning.
- The **substructural inventory** by responsibility — this is the concrete invitation, and it is the part this room can actually take up:
  - linear — orchestration: resources consumed once
  - relevant (diagonal without projection) — provenance: nothing used may be discarded from the record
  - affine — one-shot channels
  - ordered / Lambek — protocol sequencing
  - bunched BI / separation logic — locality and the frame rule: intervene in one part while preserving the surrounding frame
- Worked logical instance of permacultural return: **Galois descent**. Borrow a splitting field and names r₁, r₂ for a separable quadratic t² + at + b, char ≠ 2. δ = r₁ − r₂ depends on the order of the names; Δ = δ² = a² − 4b does not. Δ **descends**; its square class diagnoses whether the quadratic already splits. Negative clauses matter: computing Δ is not an algorithm for deciding squares in every k; invariance under a subgroup H returns you to Lᴴ, **not necessarily to k**; for objects rather than elements you need coherent descent data, not an assertion of invariance. And **reversible Galois transport alone is not evolution** — borrowing, working and descending is a complete cycle that produces nothing new.
- **Closure, as the organizational condition on replay**: replay connects achievements to further activity; closure concerns how those connections *collectively* sustain the capacity for activity. One-way uptake need not maintain its source. Of Kauffman's three, **work-task closure is the one that fails silently** — a protocol can specify every activity needed to maintain itself and simply not have them performed, with nothing in the specification revealing the gap.
- **What an interface lets work leave outside** (Montévil–Mossio): an enzyme-mediated transformation proceeds under locally available conditions without reconstructing the organization supplying them. Separation lets an activity proceed without carrying the whole; integration sustains the relationships that make the omission safe. **Local omission is not independence from the milieu.**
- Boundary worth drawing explicitly for logicians: mathematics as a practice maintains languages, skills, records, methods and tools through which reasoning stays available — but this does **not** make validity a product of collective agreement. Keep the network of **justification** distinct from the network of **enablement**; feedback in the latter licenses no circular proofs in the former.
- **The invitation**: make permacultural logic rigorous in pure logic. Concretely, candidates to hand them: (i) which substructural discipline corresponds to "returns without exhausting"; (ii) whether invariance under a *monoid* of embeddings, rather than a group, has a known logical characterization; (iii) a selection criterion that is purely eliminative — survival with no optimand.
- The motivation: a rigorous basis for an economy of degrowth based on voluntary work, contrasted with the exploitative-to-exhaustion viral logic of forced-labour capitalism.

{Two notes on the last line. First, it will cost you part of the room if it arrives as the *conclusion* of the logic
rather than as the *motivation* for it. The stronger order for this audience: here is the substructural question, here
is why I care, now please attack the question. Second, there is a real asset you have not used. Your own "fuzzy game
with red cards" image — it is not clear what winning is, but you can be expelled at any point — is a **purely
eliminative** viability criterion: selection with no optimand. That matters because the project's standing gap is
exactly that variation and inheritance are specified while selection is not, and because it escapes the objection you
have had to "fitness" from the beginning. It is also something a logician can formalize. I would promote it into this
section rather than leave it in the pre-philosophical notes.}

---

## Conclusion

- Objective: show that the work done and the work planned are serious enough to earn attention and effort.
- Calibrate the ask with the evidence. What is banked, what is postulated, what is conjectural — in that order.
- The three lanes, so the ask is legible: **1C** pure conjecture, **2S** runtime-to-substrate interpretation, **3R** runtime. 3R echoes 2S; 1C develops independently; 2S imports 1C only once a 1C result is a stable interface.
- Selection discipline for anything proposed from the floor: a named obligation that is **red first**, with positive and negative controls, and a decision the outcome changes.
- Three concrete things the room could supply: the substructural characterization of permacultural return; the monoid-vs-group invariance question; a toy case for conceptual variation in Λ.
- Message to any department of education applying the Finnish style: implement an embryonic version of the protocol — **autonomous and open science workshops**. Random selection, time and resources, consensus-only report, published output. The citizen-assembly template already works; this is that template aimed at inquiry.
- Standing offer: the repository is public, the Agda is checkable, the one postulate is named.

{The education ask is the most actionable thing in the talk and currently sits last in a parenthesis. For a Finnish
audience it may be the thing they can actually *do*, so it deserves its own slide and a concrete minimum: how many
participants, how long, what the output is, what it would take to run one.}

---

## Appendix: elements from our work with no slot in the current outline

Inventory only, so none of this is lost. Each has surfaced in the project and none has a home in §0–§6.

- **Red cards / eliminative selection.** Survival without a success metric. Fills the selection gap; compatible with refusing a universal fitness function. See the brace note in §6.
- **Directedness mismatch.** K is directed in several places; the groupoidal machinery the project keeps reaching for does not fit. Met by several independent routes. Relevant to §4.3, §4.4, and to any transport or holonomy reading.
- **Deck transformations are a group; Tier A's relabelings are a monoid.** Non-invertible invariance has no covering-theoretic analogue. Possibly the same obstruction as directedness in different clothes. In §4.1 above, and offered to the room in §6.
- **Isbell conjugation and the nucleus** as the formal home for a two-sided pairing: profunctor → Isbell adjunction → nucleus, with `V = 2` giving the FCA concept lattice and `V =` extended reals giving **Legendre–Fenchel**, which pairs amounts against slopes with the convex functions as fixed points. Recorded in `related_structures.md`; untested as a home for the infinite/infinitesimal relation.
- **The period distinction, relabelled.** Three cases by **what the integral depends on**: nothing (exact), the homology class only (closed, non-exact), the specific chain (non-closed). Finite decidable form: 1-cochains on a finite 2-complex — filled triangle with a closed cochain forces exactness; unfilled triangle carries a closed non-exact class; filled triangle with a non-closed cochain is curvature. Λ hook: whether a triangle is filled is whether a coherence among three translations is admitted. The *maintenance / sustainable surplus / acceleration* labels were retired as unsupported.
- **The infinitesimal as first-order variation of a spec.** Alternatives near Hoapa as deformations of its clause inventory; "small" needs a structural definition since K is combinatorial. Deformation theory's obstruction tower — first-order, formal, actual — is the honest version of "can a difference become consequential".
- **Concurrency diamonds.** Two orders of independent events give two paths between the same states; "harmless reordering of independent events does not alter the trusted process" is flatness on diamonds in K's own vocabulary, with conflicting events as its curvature. Native, already an obligation, falsifiable.
- **Non-ergodicity is path-dependence.** The route through a cascade of selections is information not recoverable from the endpoint. Same concern as the period distinction.
- **Retired in arc/21, so they do not come back on stage**: the chain from nilpotence through absence of contraction to R4 (SDG models are toposes — contraction is free and D survives; what kills D is excluded middle or decidable equality); reading ε² = 0 as "no second step" (sums of infinitesimals climb the tower D ⊂ D₂ ⊂ …); assigning the synthetic pole to the absolute and the analytic to the infinitesimal (first-order variation is linear, so locally the infinitesimal is where the *synthetic* decomposition lives); and the de Rham labels above.
- **Care has two placements and they are not compatible.** Recorded: reciprocal role duality with checked anchor `(–)⊥`, its agape reading conjectural and gated on the no-leak family. Proposed in arc/21: hospitality toward a fragile difference. An involution is symmetric; hospitality is asymmetric. The only reconciliation on the table is that the asymmetry holds within an episode and the role swap happens across the cycle — unevaluated. Not in this talk; do not let both stand in the records.
- **`bias_correction.md` rejections most relevant to this room**: sheaf descent does not prove "no privileged point of view" (that needs equivariance, basepoint-independence, refinement stability, conservative reindexing); the existence of a contextual transpose is no evidence for the adjunction, since every adjunction supplies one; unanimity is not sheaf amalgamation; separatedness is not accountability; actor-renaming invariance does not make every identifier meaningless; gauge invariance does not make this a field theory.
- **Hersh.** Named in `motivation.md` as the *social* anchor for mathematical praxis beside *Récoltes et Semailles*, with no entry in the anchors inventory. Either he earns one or that wording is loose.

---

# Appendix B: letter to Zalamea — elements, dried

Task: convey how Hoapa **now** uses Lautman, and that the series of dialectical tensions
**begins** with concrete/abstract, entered through Kauffman on work, extended into a
Pattee-loop, which is the biological implementation of Simondon and the extension of Peirce.

Calibrated to him throughout: explain nothing he owns, introduce in one line what he does not.

## Calibration: what he already has

Do not explain, do not summarize, use as shared vocabulary:

- **Lautman entire.** Notions and Ideas-as-problems; *structure et existence*; schemas of structure and of genesis; mixtes; solidarity; the double movement; the priority of the problem in the order of reasons.
- **His own apparatus.** Transit; saturation and liberation; the *triple va-et-vient*; residues and obstructions; eidal / quiddital / archeal.
- **Peirce in depth.** *Peirce's Logic of Continuity*. Pragmaticism, synechism, triadic semiosis, existential graphs, agape, the community of inquiry.
- **Grothendieck.** Relative point of view, rising sea, descent, the *Esquisse*, dessins, Galois–Teichmüller.
- **The mathematics.** Sheaves, descent, Galois correspondences, coverings, the structural ladder of his own long passage.
- **Deleuze on Lautman.** Including the transformation of dialectical Ideas into immanent problematics.
- Riemann, Galois, Grothendieck as his three pillars.

## Calibration: what he does not have, one line each

- **Atkins' definition of work** — the constrained release of energy into a few degrees of freedom. Not force through a distance. Energy counts as work only when a constraint channels it.
- **Kauffman** — the work–constraint cycle: "work begets constraints beget work" (*Investigations*, 2000). The cannon is the constraint, and it took work to make the cannon. Also autocatalytic sets, and non-ergodicity above the atomic scale, from which evolution is *historical*.
- **Montévil–Mossio (2015)** — constraint closure: A constrains the release in process 1 that builds B, B constrains 2 that builds C, C constrains 3 that builds A. The system does the thermodynamic work of building its own boundary conditions. Function is thereby naturalized: a part has a function iff it is a constraint maintaining the closure.
- **Pattee** — the *epistemic cut*: lawful, rate-dependent dynamical constraints against rate-independent **symbolic** constraints whose physical form is arbitrary relative to what they stand for. *Semantic closure*: the symbols specify the machinery that reads the symbols.
- **Energy-degeneracy** — the thermodynamic condition for a substrate to hold abstractions: its states must cost about the same whichever meaning they carry, so physics does not decide the content. Not Peirce's; a twentieth-century reading, Szilard and Landauer to Pattee.
- **Simondon** — probably a name rather than a working anchor. Preindividual field; metastability as a genuine third state; individuation as the progressive resolution of a local incompatibility, structuring individual **and** milieu together; transduction; the reserve is not exhausted by a successful individuation.
- **Concurrency** — actor model: send, receive-and-update, create. Session types and duality S ↔ S⊥. Not his field; keep to two sentences.
- **The formal layer** — cubical Agda; what is banked; `session-O1-action` as the one named postulate.

## The one door he already owns: biosemiotics

- Hoffmeyer, Emmeche and Deacon are **explicitly Peircean**; *Peirce and Biosemiotics* (Romanini & Fernández, Springer 2014) exists.
- So the whole Pattee / closure / code-duality complex can be entered through the Peircean door rather than introduced cold.
- **Most efficient calibration move in the letter.** Enter by his author, not by the biologists.
- Code duality (Hoffmeyer–Emmeche): an organism exists twice, as a digital message to itself across generations and as an analog body interpreting its world. Hoffmeyer's increasing *semiotic freedom*.

## The spine, in one chain

1. **Peirce, the original figure.** Substrate-independent logic — the Marquand letter, 30 Dec 1886, logic by electrical switching. "Logical Machines" (1887): every machine reasons, since the relations among its parts entail relations nobody intended, but every machine has two impotencies — no originality, so it cannot find its own problems, and it can do only what it was contrived for. **Machines apply; they do not design.** "Pragmatism" (1907): brute-force action is dyadic, semiosis irreducibly triadic — Pattee's cut sixty years early. Same manuscript: the **energetic** interpretant is an exertion, which is work; the **ultimate logical** interpretant is a *habit-change*, a standing constraint on future action. So semiosis passes through work and ends by building a constraint. 1891–92: laws are habits the universe has acquired.
   - Qualify at once, because it is a claim about **his** author: Peirce is the original figure but not the root of the lineage. Jevons precedes him on logic machines (1869) and his priority is the *electrical* idea; the Marquand letter was published only in 1993; Shannon reinvented switching logic independently in 1937; von Neumann, Pattee, Kauffman and Montévil–Mossio do not build on him. The genuinely Peircean line is biosemiotics and Deacon. And the interpretant triad appears in one manuscript which Peirce later abandoned (Jappy 2024).
2. **Simondon, the philosophical account.** How an individual precipitates from a metastable field, structuring its milieu with it, leaving the field capable of further individuation. Transduction propagates it stepwise.
3. **Kauffman and Montévil–Mossio, the biological implementation.** Work as constrained release; the cycle; closure as the point where every constraint the system needs is produced inside it.
   - **The sentence for him:** a constraint is **structure**, work is the act that brings into **existence**, and the cycle is a genesis that loops — structure engenders existence as the constraint channels energy into work, existence engenders structure as that work builds the next constraint. So the work–constraint couple maps onto *structure et existence*, and the loop is a **schema of genesis**.
   - Two further pairs of his fit closure itself: **intrinsic against induced** — the cannon's constraints are induced by its maker, the cell's are intrinsic, and closure is where all the relevant ones become intrinsic; and **the ascent toward completion** — algebraic closure means every equation over a field finds its roots inside the field, constraint closure means every constraint the system needs is produced inside the system.
4. **The Pattee-loop, the extension into the symbolic.** Constraints become energy-degenerate, so their *structure* is freed from the cost of their *existence*. That freedom opens a gap between heterogeneous domains — and a **mixte** is exactly what occupies it. The ribosome and tRNA are mixtes between code and chemistry; perception and motor action are the two mixtes performing the flips.
   - **Lautman's own mathematical mixte closes the circle:** Hilbert space, a synthesis of continuous and discrete, where a function becomes a list of coefficients. That is the flip in mathematical form.
   - Why the detour is worth making, in Atkins' terms: **leverage** — a cheap constraint gates a large release; **memory** — a constraint stored abstractly is reusable without being rebuilt. The cannon has neither, which is why it never makes the detour.
   - Thinking is therefore **cheap work on constraints that channel expensive work**.
   - For it to be closure rather than a controller sitting on top, the metabolic side must also do the work that rebuilds and maintains the abstract side.
5. **Concrete/abstract arrives as a problematic, not a stipulation.** An arbitrary piece of the world is dedicated to manipulating abstractions, which design and apply back into the concrete it started from. And what counts as concrete or abstract is **relative** — his own relativity, where a mathematical object is concrete relative to a more abstract one.
6. **Then the series.** concrete/abstract → synthetic/analytic → individuation/variation → structure/existence and genesis.

## How Hoapa now uses Lautman: what changed

- **The entry point moved.** Previously Lautman entered through the two decompositions mapped onto the architecture. Now **concrete/abstract is primary**, entered biologically through work and closure, and the two decompositions are the *second* tension rather than the first.
- **The domination thesis is now carried by the recurrence argument**, in its correct form: the same *problem* recurs across theories with no common mathematical content — local/global in sheaf cohomology, in Galois descent, in gauge field theory — so what they share cannot be internal to any of them. Not recurrence of content, which would make the theories related and the argument circular.
- **The decomposition stays rigid inside K.** The Lautmanian problem lives **at the adjunction**, not inside either side. Rigid endpoints are the precondition for a liaison between them to be statable at all. Documentation's genuine aspiration to become synthetic — furnishing languages for later understanding — is then a **datum of the round trip** `Allow ∘ Require`, not a drift in the assignment.
- **Mixtes are used as a source question for adapters**, not as a classification: what must an intermediate structure retain from each setting to make the passage possible? Explicitly **not** an identification of the project's R4 adapter with a mixte.
- **Structure and genesis now supply the renewal criterion**, with the hinge passage between the two parts of the thesis doing the work.
- **A third tension has been added that is not in Lautman**: individuation/variation. Say this to him before he says it: the four-tension series is a *proposed Lautmanian interpretation of modern mathematics*, not a claim that Lautman formulated the hierarchy.
- **The reading is immanent, not orthodox.** Lautman gives the Dialectic an ontological priority over the mathematics realizing it; the project uses the Deleuzian and Corfieldian transformation into problematics immanent to practice, because a project giving collective inquiry a protocol cannot coherently hold that the problems enjoy priority over any practice. Say so, or he will assume the orthodox reading.

## The four tensions, in order, with what is new in each

- **I. Concrete / abstract.** How particular realities and general structures determine one another. Entered through §3's work and loop. Lautman's pair here is *les systèmes formels et leur réalisation*, and his own example is the **Skolem paradox** — a formal system cannot pin down its realizations. Pattee's cut is that shape with the realization made physical.
- **II. Synthetic / analytic.** His two decompositions: **proper, individual, analytic** — prime factorization, the roots of a polynomial, from the particular toward constituents characterizing it; and **dimensional, synthetic** — a vector relative to a dimension and a chosen basis, a common plan supplied by the ambient domain, expressing the **solidarity** of the elements. Not absolute: a polynomial factors over one field and not another, so extension of the base discloses constituents previously unavailable. Project reading: embodied understanding predominantly synthetic through one unityped mode of participation, documented understanding predominantly analytic. Both moments in both realms; neither M nor K is "the synthetic side". `propre` is also the French for *eigen*.
- **III. Individuation / variation.** Weighed against discrete/continuous (too general, misses decomposition) and rigid/deformable (does not express coarse-graining). Chosen, with rigidity and deformability as its principal mathematical manifestation. The ladder: eigenvalue decomposition, moduli spaces, persistent homology. A decomposition can stay exact while varying continuously; individuation of constituents can fail at singularities and degenerations; a coarse-grained invariant can stay stable throughout. **The third level reactivates the second**: families of decompositions become new synthetic wholes, which become objects of abstract investigation again.
- **IV. Structure / existence and genesis.** The hinge: *"the ascent towards the absolute has as a consequence, not only to confer on a mathematical entity the greatest simplicity of internal structure possible, but to make it able to give rise to entities other than itself."* His Riemann-surface example: passing to the universal covering surface enables new constructions of functions. Project use: the renewal criterion — specified earlier achievements remain recoverable while a genuinely unavailable continuation becomes admissible; and the sharp negative, that **different sites can present equivalent topoi, so a changed site alone establishes nothing**.

## Meeting him on his own ground

- **Lead with coverings.** He structured his own introduction to Lautman around coverings, sheaves, descent and the Galois correspondence. §4.1's passage is a covering-space passage. His emphasis returning as the project's entry is the strongest single move available.
  - The passage, with its hedge intact: a covering `p : E → B` provides a space in which distinctions between lifts become available, while deck transformations preserve reference to the base, `p ∘ g = p` — transformation without change of the *specified projection*, not without change of anything whatsoever. Structural analogy, not mathematical identification; it neither derives the requirement for participation nor establishes that Hoapa satisfies it.
  - And the two productive differences: deck transformations form a **group**, while the invariance actually proved on the participant channel is over injective, not necessarily surjective, relabelings — a **monoid**; and a covering preserves one canonical projection while Hoapa would preserve a **declared family** of relations, which puts the nearer home at a site with a declared topology.
- **Use his annotation of his own two passages**, since it is the project's conjecture in his words: ① the world rich in determinations, full of precisions and delimitations = **K**; ② the world of ideas of possible, free relations = **M**; ③ the inevitable back-and-forth = the category the adjunction produces. Note the direction is the reverse of the naive guess — K is the determinate side.
- **His sentence doing the project's work:** restrictions and delimitations are an *enrichment* of knowledge through the precision and certainty they provide, not an impoverishment. Pair it with separations of concerns: each restriction buys a guarantee.
- **Solidarity**, his emphasis and Lautman's word. Four senses: between whole and parts; between a mathematical being and its ambient universe; between domains and operations; reciprocal between theories. Solidarity is the relation, genesis the movement.
- **Saturation and liberation** attributed to *his* reading of Lautman. Then the project's non-conflation: K's technical *causal saturation* — every globally witnessed causal relation between a conversation's events is already generated internally to it — is a different predicate with an unfortunate name overlap, and is not Simondonian metastability either.
- **The licence for the biological extension is Deleuze**, whom he knows on this better than anyone: *Difference and Repetition* takes Lautman's Ideas-as-problems and applies them to the organism, with genes and development as the actualization of an Idea. Lautman himself worked almost entirely within mathematics, with occasional forays into physics. Cite the precedent rather than assert the extension.

## What to ask him

Precise questions, each answerable only by him.

1. **Has anyone related Lautman to Peirce?** He is the major living scholar of both. If the answer is no, that is the project's opening; if yes, it is a literature the project needs. Probably the single best question in the letter.
2. **Does the four-tension series map onto the *triple va-et-vient*, and in what order?** Connecting them rigorously needs the actual wording and sequence of his three movements, which the project has not done.
3. **Where exactly does Lautman use "solidarity", and does it bear this weight?** Four senses have been located; whether they are one notion is his question.
4. **Is the biological extension licit beyond Deleuze's precedent?** Did Lautman ever go past physics?
5. **Structure/existence against essence/existence** — which does he take as the primary pair, and does the distinction bear on the schemas of genesis?
6. Optional, and the most useful if he bites: **is the passage from an object's decomposition to the moduli of its decompositions** the passage from concrete to abstract and back that he regards as constitutive of mathematical creativity?

## Things he will catch

- **The thesis title.** *Essai sur les notions de structure et d'existence en mathématiques* — **structure**, not essence. Essence/existence is a different, scholastic pair. First thing he catches.
- **The hinge quote's pagination.** Given as pp. 130–131 in Duffy's Continuum 2011 translation; verify, and be ready for him to cite the Spanish.
- **Which introduction.** The English Continuum volume's introduction is Duffy's. If the project means Zalamea's introduction, name the edition — his Spanish Lautman volume.
- **The hierarchy is the project's.** Not Lautman's, and he will know.
- **"Domination" needs its argument.** Never let it stand without the recurrence form behind it.
- **R4 is not a mixte**, and the project says so in its own records.
- **The Yoneda move is an analogy**, unresourced, and the project cannot make it rigorous any time soon. Say it before he asks; what it would need is a category of worlds, its morphisms, a probe family, and a density or representability theorem.
- **Three claims he may expect that the project does not make**: that sheaf descent proves there is no privileged point of view (it needs equivariance, basepoint-independence, refinement stability and conservative reindexing); that the existence of a contextual transpose supports the adjunction (every adjunction supplies one); that unanimity is sheaf amalgamation.

## Reporting movement against his advice

- He urged the big book and ten years of solitary work. Report against that concretely rather than in the abstract.
- What has become stable since: the concurrency side's banked results and the one named postulate; the retirement of cohesive and modal HoTT as the *prescribed* setting for M, with M now to be discovered; the comparison setting as the primary target rather than an absolute claim about one architecture.
- What the Lautman reading changed, in one line: it supplied the justification the construction lacked, and relocated the project's own problem from inside the architecture to the adjunction.
