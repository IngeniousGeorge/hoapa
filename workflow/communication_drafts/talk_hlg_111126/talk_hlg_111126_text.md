# Talk text

J:
    scientists as good as their theories vs. s = pilot, t = car
    I built my own car, by chance, as an exercise
    circling around the idea of oragnization/communication/strategies) in "balance and universality" ~ all play by the same rule ~ simple generator/specs to intricate construction
    last and decisive step = concrete/abstract strict separation (despite apparent loss of usefulness, on top of first = apparent loss of knowledge)
    trusted the result completely and "took it for a ride" : looked for siblings in Nature, models in math, internal structure, relations to others

## Introduction

### Pitch

The core of my research consists in drawing inspiration from the philosophy of mathematics and the engineering of networks to formulate [a theory of work constrained by "*permacultural*" logic: how to produce reusable results while preserving the conditions for future work]. Applied to collectives, it becomes an extension of the *scientific method* which incorporates participatory democracy and sustainability.

- […] : one point of view among many
- Permacultural : abstracted into "concretely minimal, abstractly demanding"
- Scientific method :
    well-regulated scientist–Nature relation + (ad hoc peer review ↪ universities ↪ economy)
    → *well-regulated* network of relations among scientists, each retaining a well-regulated relation with Nature

### Sources

The authors it draws on are mathematicians (F.W. Lawvere, *A. Grothendieck*), philosophers (C.S. Peirce, G. Simondon, G. Deleuze), and *scientists* (S. Kauffman, J. Bowlby). In my project, these approaches meet in *Albert Lautman*’s philosophy of mathematics, as read by Fernando Zalamea (who has been supporting my work).

- A. Grothendieck : gives a rich notion of creativity, the relative point of view, naturalness via the rising sea method, ecological thinking… the structure and destination of the project…
- Albert Lautman : metaphysics as "problems the universe was going to run into no matter what", mathematics and physics as "effective theories answering those problems"…
- Scientists : because we're interested in each step of the evolution of the universe, from field theories to origins of life and attachment…

> …Hoapa as an invariant in the effective theories we see

### Thesis

My main thesis states that in a system that puts the dialectic between concrete and abstract to *work* (brain, computer, community), the relation between concrete substrate and logical labor must be a resource entirely *dedicated* to the design and application of representations and algorithms. A form of separation between two kinds of *decomposition*—analytic (as in prime factorization) and synthetic (as in vector coordinates relative to a basis)—is a guiding principle, informed by Lautman, which can keep this relation fruitful: in a community, between thinkers and the knowledge they produce.

- Work : explosion vs. engine, the role of constraints;
    engine vs. organism, the role of closure;
    engine vs. computer, the role of the "abstract loop"
    (Stuart Kauffman, "Beyond Physics" talk)
- Dedicated : as in computers, in cells, in brains, in communities
- Decomposition (Lautmanian) : synthetic (dimensional) ⟷ analytic (proper)

### Theory of work

The physical starting point is that work depends on *constraints* that channel energy into particular effects. In living systems, activity also helps *maintain* the machinery that makes further activity possible. *Abstract* representations and algorithms enable a system to retain and share experience, discover relations, construct and test possibilities, revise its own means of understanding and action, and turn results into conditions for further work. This makes the relation between concrete conditions and abstract operations a powerful resource. Lautman supplies a way to investigate such relations through the mathematical and physical constructions that give them substance; Peirce, Simondon, and Kauffman help connect the question to living beings, their environments, and their practices of understanding. Hoapa's proposed separation between thinkers and the organization of knowledge is an engineering approach to developing this potential.

- Constraints : effects — Maintain : closure — Abstract : secondary loop

### Process

Hoapa is designed as a network of small *conversations* in which one group's work becomes another group's starting point. A question brings participants *together*; their discussion produces a document that others can examine, challenge, or develop. These documents form a growing map of questions, concepts, arguments, and dependencies: a knowledge *graph*. So that contributions can differ and come unforced, the system gives participants control and equal standing (they all play by the same rules they themselves manage). Knowledge acquires structure *independently* of the structure of its producers, be it social, political, economic…

- Conversation : modeled after citizen assemblies (helps autonomy, role-symmetry, modularity… control and equal standing)
- Together (concurrency) : message passing style, as in the actor model or π-calculus
- Graph : typed knowledge graphs, which are versioned, multiplex, homotopical, federated…
- Independently : respecting the concrete/abstract separation of concerns and dedicated relation between the two

### Verification

The communication protocols specify how these conversations proceed and how their results enter the shared documentation. Software is used as a *referee* and is itself subject to modification by the conversations. Alongside the conversation process, a mathematical *verification* layer is being developed in cubical Agda, a language in which proofs can be checked by a computer. One existing result establishes that consistently renaming *participants* cannot change the checker's verdict. The broader aim is to make the system's promises precise enough to test and prove.

- Referee : or automation as _liberation from control mechanisms_, from the necessity to have management
- Verification : machine-checks that the record of each conversation is well-formed according to the protocol, never that its conclusions are true
- Participants : the protocol is blind to identity of contributors, which means it can't count on specialization (…is knowledge lost?)

### Conjecture

The project seeks a mathematical correspondence—an *adjunction*—between two poles. One organizes inquiry through conversations, verification, and knowledge graphs. The other represents mathematical contexts and the different perspectives through which they can be investigated. The conjecture is guided by an intuition prompted by the perspectival nature of the world: our different understandings of it invite discussion, without presuppositions, from which something the world can reuse may *emerge*. The conjecture asks whether a *universal property* can distinguish Hoapa’s organization from alternatives. This talk will explore a candidate in which methods are represented by logics and mathematical worlds by the inner models they generate.

- Adjunction : context & inquiry,  perspectivism & praxis, structure & genesis/recursion…
- Emerge : points to the recursive nature of evolution: physics to biology, biology to psychology…
- Universal property : "specialness" in mathematics → optimality in engineering

### Rising sea as a reason to believe in permacultural logic

Video: P. Deligne, *L'œuvre d'Alexandre Grothendieck* (Nice, 1996), the first 1'12, with English subtitles (deligne_rising_sea.mp4). Click to play.

### Permacultural logic

The project also looks for this pattern inside logic, where "permaculture" is understood broadly as the two-step process of (1) getting to know one's context as much as possible, (2) acting minimally in a manner that will enhance one's condition while preserving and enriching the context. A proof may begin with a provisional assumption (borrow), derive a conclusion (work), and turn the derivation into a conditional statement that later proofs can use (return) or start afresh from (*replay*). Hoapa investigates this borrow–work–replay pattern as a possible logical expression of its permacultural ambition: the *harmony* between receiving and giving back.

- Harmony : as in Gentzen, type theory, Hilbert's axiomatic method
- Replay : the hidden part of logic that makes logic work

### Development

The architecture of a "mature" Hoapa system is both demanding—to respect its constraints—and—by virtue of presuppositionlessness—*unpredictable*. Autonomous open-science workshops could make these ideas tangible and seed larger systems, embracing both pragmaticism and experimentalism. Their first requirement is usefulness: knowledge sharing must be truly at *stake*, so that the organization develops through serving a real purpose. Concretely, I envision something based on the philosophy of "document-driven-development", where *documentation* gradually replaces the instructor, both as the joint source of truth and the manager of the process.

- Unpredictable : collective inquiry helps determine how collective inquiry is organized
- Stake : what distinguishes and makes citizen assemblies efficient; you can't simulate life or understanding
- Documentation : does in the Lautmanian-analytic what specialization does in the synthetic agents: shared source and management, but "softer"

## Implementation - Use cases

### A park

Hoapa can also operate at small scales and with only the "base layer of complexity" which separates the role-symmetric agents from the typed documentation they produce.

For instance we could have a neighborhood "manage" its local park via a protocol in which the motivated residents discuss how it could be enhanced, and produce a to-do list for its maintenance.

Here it is crucial to understand that the system can preserve its advantageous mathematical, social and engineering properties if it is **only** a communication system, and not a full management system which also enacts in reality what has been discussed in the abstract.

Its task is to chart the world and design appropriate algorithms, not interfere with and certainly not control it. (That would kill all the carefully crafted separations of concerns, starting with the role-symmetry of agents, because it necessarily introduces some hierarchical structure and tension—for basically the same reasons you can share an idea with the entire world without losing it, but you can't do that with a loaf of bread.)

Hoapa protocols can interact with the world only behind buffers which respect individual freedom:

- If it needs something it simply asks for it, and expects those needs to be met (for instance, if it uses the internet, it states via a self-reflective conversation how much bandwidth it needs, and specifies the characteristics of its network). Individuals or communities, outside of the protocol, would then respond to those needs without compensation.
- If it wants something to be known it simply makes it as available and accessible as possible, which includes a pedagogical effort in presentation and terminology. But it can't advertise, at the risk of favoring certain targets over others.

In either direction, we can think of Hoapa as a coach in sports: its domain of action is preparation and strategy, but it can never enter the field of play or control the players. The game belongs to the players.

In this example, we can imagine an institution/Hoapa hybrid in which the city government has delegated the supervision of the park to the protocol, but it's still the paid workforce of gardeners which will perform the tasks suggested by the protocol. But ideally, in the spirit of the protocol, it would be only voluntary work, suggested by the protocol but decided at the level of the individuals and communities.

> Which makes Hoapa protocols especially well suited to organize the open source economy.

### Open source

Because open source produces code, it mostly "lives in the abstract". Historically, it has also used a lot of voluntary labor. So it is by design a process that respects the separation of concerns Hoapa systems start with.

The main recurring problem open source projects face is scalability and continuation beyond the circle of core contributors and maintainers, usually the instigators of the project: because open source projects are structured around "circles of knowledge and influence", which is in essence a hierarchy, it is very likely to terminate the moment the inner circle quits.

Hoapa revokes the privileges of the inner circle, distributes the workload evenly and transfers all the essential knowledge from the original designer's minds into a strictly typed and *operational documentation*.

While this is more demanding in the early stages of the process, it pays off by making the project truly scalable and persistent (not persistent in the sense of a capitalistic endeavor, which always needs to grow and colonize new markets, but closer to how ecosystems work, with minimalism and circularity).

> The same arguments can be used to suggest a reform of how science is conducted.

- Operational documentation : using team semantics and provenance, what must remain traceable for others to understand, revise, and continue the work (as an extension to the collective of Knuth's literate programming)

### Science

~~Universities organize inquiry through hierarchies that also distribute funding, employment, and recognition. These dependencies influence which questions can be pursued and whose contributions are heard.~~

Universities are extremely hierarchical political machines whose ties to reality are clearly not behind buffers, which impair their capacity to describe the world they inhabit.*

While the scientific method, in the domains where it is applicable, makes claims answerable to evidence and correction, it doesn't prevent other types of evils. Notably a mismanagement of efforts toward certain technologies at the expense of understanding, the fragmentation of the study of Nature into opposing departments, the proliferation of opaque jargons, the insistence that there exists a "view from nowhere", the enclosure of knowledge behind paywalls, proprietary tools, and restricted access, the depreciation of errors and failures, etc.

Hoapa protocols, on the other hand, are ideal for the realization of what citizen science promised to be, but only marginally developed. In a real and, hopefully, demonstrable sense, they are an extension of the Galilean scientific method to the collective.

In the Hoapa extension, we define how scientists are supposed to converse among themselves, and how they should refine and store information into a strictly typed and operational technical *language*. Our conjecture is that a universal property can distinguish Hoapa among organizations pursuing this work.

Hoapa protocols are designed for education, as part of their mandate to treat everybody on an equal footing. What is removed with the status is not the knowledge, but the hunt for the status, and at the same time it resituates the obligation to make one's specialized knowledge accessible to others.

Crucially, each individual practitioner gets to decide what questions are worth pursuing, opening a path to restoring science’s sense of purpose from the ground up.

> And the organization of inquiry is itself something we can try to understand mathematically.

- Language : "Learn once, write everywhere" ← a shared conceptual landscape built through explicit and systematic comparisons (interpretation, equivalence, coherence…)

\*: "And all science, when we do not understand it as an instrument for power and domination, but
as an adventure in knowledge undertaken by our species through the ages, is but this harmony,
more or less wide and more or less rich from one period to the other, which unfolds over the
generations and centuries, by the gentle counterpoint of all the themes emerging in turns, as if
summoned from the abyss, to join and embrace in her" (Grothendieck, R&S)

"From a semiotical and philosophical perspective, the general method is fascinating: to understand
something, consider all possible points of view and search for a structural connection between
them. Only then you will be approaching true knowledge. A systematic use of the liberty and
multiplicity of topos theory in our ordinary life would have huge consequences on tolerance, ethics,
politics, and social action: an example of how high mathematical practice would transform our
everyday practice." (Zalamea, 'Grothendieck’s 40 Main Years: A Unitary Vision Through the TSK Models')

### Mathematics

All of the above applies in mathematics as well, but here the connection goes *further*: mathematics also supplies the language in which the organization of mathematical work can itself be investigated. Hoapa’s formalization uses Cubical Agda, bringing together homotopy type theory, computer-checked proofs, and a line of thought connecting Alexander Grothendieck’s ideas about homotopy types and higher groupoids with Vladimir Voevodsky’s univalent foundations.

Hoapa proposes to carry this connection into the organization of collective inquiry itself. This ambition echoes Grothendieck’s memoirs, which weave together reflections on creativity, mathematical practice and mathematics itself.

> Grothendieck also questioned the ecological consequences of scientific activity; Hoapa approaches that concern by asking how understanding a world can help us inhabit it.

- Further : a method of articulating a context can generate a new context for further inquiry (in math and logic, in generalized evolution)

### Generalized permaculture

I believe Hoapa protocols can stage and target the kind of recursive and self-reflective patterns just mentioned, in the ecosystem, by generalizing the concept of permaculture and applying it to a vast majority of human endeavors. Permaculture could in effect become the default mode of being of humanity, following this very simple algorithm:

- Make a very detailed and executable map of your environment, including your imprint on it.
- Use it to figure out what is best for both you and your environment, and do it (which becomes the default if individual freedom replaces "investability" as the condition for action).

This is where the "layers of complexity" which respect and target perspectivism, decentralization, autonomy, openness to peers, expressiveness, transparency, scalability and self-reflection, start to be really useful.

> To tend a place is also to attend to the relations that sustain it—and those relations lead us into a network.

### Networks

In all the preceding examples we've looked at instances of Hoapa protocols in isolation, but each of them would be better envisioned as a node of a vast network.

A mature protocol regulating a park would necessarily have typed conversations with other park protocols, especially those close by, to share information and reuse each other's research. It would also have ties to all the independent but interlinked networks a city would be made up of: electricity grid, water management, transportation, agriculture… and then beyond the city limits, into all sorts of other communities organized through protocols, each bringing its own point of view, from playground design to natural philosophy.

A park’s investigation of soil and water becomes useful to another park; a software improvement made for its documentation becomes available to other projects; a scientific question raised locally finds research communities elsewhere equipped to pursue it. The park community’s teaching material can help newcomers elsewhere. And communities can help one another translate documentation, test proposals, or investigate disagreements. Records of failed attempts can spare others the same mistakes.

In all of this, each protocol is both an agent and a recipient of *care*, as a concrete ecosystem as well as an abstract community of participants.

- Care : Hoapa’s generalization of attachment theory (biology, psychology) into a two-step cyclic algorithm
    1. In a given network, the evolution toward maturity of newer elements is taken care of by the
    mature elements already present in the network
    2. In turn, those newer elements become mature and take care of a new generation of elements

## The conjecture - an adjunction

### Informal recap diagram

### Motivations and goals

To motivate its adoption and distinguish Hoapa from other “interesting projects” we can attach buzzwords to, I need a mathematical reason for organizing inquiry this way. The goal is to characterize Hoapa by a universal property, in a setting that represents both the contexts it investigates and alternative ways of investigating them.

If the conjecture succeeds, this universal property would translate into a claim of *optimality* for any implementation satisfying its conditions. The world we inhabit must explain why those conditions matter. Hoapa is also its own experiment: implementing its protocols lets us test the conjecture's claims.

*Perspectivism* motivates this ambition; *presuppositionlessness* guides the response. The world has already produced different beings, experiences, skills, and ways of understanding. Their contributions must be able to enter the inquiry without their worth being decided in advance by a hierarchy or an established division of knowledge. What the world has already developed becomes material for collective work; what that work will produce remains open.

- Optimality : the constraints imposed on a process, in a given context, to achieve an intended outcome
    constraints = the protocol ; process = collective inquiry ; context = this world ; outcome = understanding that enables generalized permaculture to be enacted

- Perspectivism : global understanding is assembled from local views, with obstructions to their integration retained as information

- Presuppositionlessness : applied to protocols, a principle saying we need common rules, open rules with equally distributed power to revise them, and only the rules needed to make communication possible

### Categories from metaphysics

The proposed adjunction relates a category of contexts to a category of organizations of inquiry: write Ctx for the first and Inq for the second. We seek functors F : Ctx → Inq and G : Inq → Ctx with natural bijections Hom_Inq(F c, i) ≅ Hom_Ctx(c, G i). The unit η_c : c → GF c and the counit ε_i : FG i → i compare each side with its round trip. The mathematical form of Ctx is still under investigation, and neither functor has been constructed.

Each piece of this structure is meant to carry one of the project's concepts: *F*, *G*, the unit *η* and the counit *ε*.

- F : Complexity, the organized work a context allows
- G : Evolution, what organized inquiry produces can become part of the conditions under which further inquiry takes place
- η : Praxis, the general opening; how a piece of work w : F c → i realizes it in particular, and its transpose G(w) ∘ η_c : c → G i returns the work in contextual form
- ε : Anthropic loss, the possible failure of the reconstruction map ε_i : FG i → i to be invertible

### Permacultural logic from the adjunction

#### 1. From work to reusable construction

The permacultural question is how an achievement becomes a means of further construction. Implication provides a precise mathematical example. We borrow an assumption A, derive B, and *return* the derivation as an implication. Other proofs can *replay* that work when its conditions are supplied.

In the cartesian closed interpretation of intuitionistic logic, this is the adjunction:

**(− × A) ⊣ (A ⇒ −)**

**Hom(Γ × A, B) ≅ Hom(Γ, A ⇒ B)**

The remaining assumptions Γ stay visible: discharging one dependency does not erase the others. Introduction and elimination are governed by *harmony*. Their compatibility makes work under an assumption interchangeable with a reusable operation expecting that assumption.

- **Return:** abstraction turns w : Γ × A → B into w♯ : Γ → A ⇒ B.¹
- **Replay:** evaluation applies the returned operation to an input: (A ⇒ B) × A → B.²
- **Harmony:** β and η make currying and uncurrying inverse—elimination extracts neither more nor less than introduction warrants.³

#### 2. What does the work leave available?

The same adjunction produces two familiar constructions. The *state monad* composes computations by passing the state left by one into the next. The *store comonad* holds a family of values together with a selected position, and allows that family to be considered from each position.

These structures organize work and access to its setting. Their laws alone do not preserve the conditions for further work. A computation p(a) = (x, a₀) can replace every incoming state with the same a₀, erasing distinctions that subsequent work needs.

Hoapa therefore asks about *continuation*: can the work we intend to do next still be performed from what has been returned? A publication may be sufficient for one use and insufficient for another. The requirement must specify what is to remain possible.

- **State monad:** Stateₐ(X) = A ⇒ (X × A)—receive a state; return a result and a resulting state.¹
- **Store comonad:** Storeₐ(X) = (A ⇒ X) × A—retain an indexed family and a current position.²
- **Continuation:** q′ ∘ w = w̄ ∘ q—q and q′ publish before and after the work w; w̄ performs the corresponding operation using only the published input.³

#### 3. The economy of replay

Earlier I called replay “the hidden part of logic that makes logic work.” *Cut* gives this phrase a precise sense. An established result enters a later proof; cut elimination can remove that intermediate use without changing what is provable. But removing it can make the proof enormously longer.

There are families of short proofs with cut whose shortest cut-free proofs grow beyond every elementary bound in the original proof lengths. Reuse can therefore be dispensable for provability and decisive for *feasibility*.

This gives the sustainability intuition a concrete dimension. Mathematical development concerns what our means of reasoning let us accomplish with finite resources. An achievement can leave the set of consequences unchanged while transforming our capacity to establish and use them.

- **Cut:** a proved result becomes a premise of further reasoning.¹
- **Feasibility:** the same conclusions can require radically different proof lengths; preserving intermediate achievements can make complex work practicable.²

#### 4. Achievements become means of inquiry

A further step occurs when an achievement changes the tools through which inquiry proceeds. In proof by *reflection*, a procedure is defined, its correctness is proved, and that proof supports its use in subsequent reasoning. Coq's `ring` tactic provides a concrete example: established mathematics becomes machinery for later mathematics, while the existing kernel continues to check the proofs.

The reusable material can also widen: from derivations in Gentzen's systems, to formalized theories in Hilbert's metamathematics, to constructions and their transport between equivalent types in HoTT. Lautman's passage from structure to genesis, and Simondon's account of produced structures supporting further structuring, guide our interpretation of this movement.

*Renewal* occurs when achievements change what further work can do. With Kauffman, we must also ask whether the organization producing them maintains its *conditions of activity*. Hoapa's evolutionary hypothesis joins these demands: work should produce reusable achievements while sustaining and developing the conditions for further work.

- **Reflection:** a verified procedure becomes part of the proof-producing toolbox, without becoming a new trusted rule.¹
- **Renewal:** preserve declared earlier uses and make a genuinely new operation available.²
- **Conditions of activity:** reusable results still depend on people, skills, records, tools, and material support.³

### Conclusion

To me, Hoapa is a theory of everywhere: the humble counterpart to a theory of everything.

*Hoapa* means "everywhere", in the sense of every domain, in Khoekhoegowab, a Khoe language spoken in Namibia, Botswana and South Africa.

The egalitarian societies of Africa, such as the San and the Hadza, can be seen as the first human implementers of Hoapa systems.

The debate about human nature, a nature Hoapa trusts, turns on how we view the Paleolithic, our deep past: as violent and brutish, or as complex and social. The contrast echoes the one between selection and adaptation.

Inquiry in universities shows the same structure across many disciplines: two camps, a "mainstream" and its "rebels". The mainstream reduces Nature's complexity and robs Her of what makes Her trustworthy. (That trust is then quietly transferred to structures of control: hierarchies, capitalism, and "reason" as understood from Galton to Dawkins.) The rebels form a holistic camp, which offers a fuller picture, more adequate to understand our own adaptation.

Hoapa would give these movements a chance to federate and to find strength in numbers, through a broad base of support in citizen science. Together, they could do justice to the complexity of Nature. We hope this would also bring peace to our relationship with Her and to our relationships with one another, and end the systematic exploitation of Nature and of ourselves.

### Reading guide (from *Categories from metaphysics* on)

**Categories and arrows**

- Ctx — say "context" (the category of contexts); never spell out C-T-X
- Inq — say "inquiry" (the category of organizations of inquiry); never spell out I-N-Q
- F : Ctx → Inq — "F, from context to inquiry" (or "F, a functor from Ctx to Inq")
- F c, G i, GF c, FG i — "F of c", "G of i", "G F of c", "F G of i"
- Hom_Inq(F c, i) — "Hom in Inq, from F c to i"; Hom rhymes with "Tom", not "home"
- ≅ — "is in natural bijection with" (or "is isomorphic to")
- ⊣ — "is left adjoint to"
- ∘ — "after" (or "composed with"): G(w) ∘ η_c is "G of w after eta c"
- w♯ — "w sharp", the transpose of w
- (− × A) — "dash times A", the product with A; the dash is an empty slot, not a minus
- A ⇒ B — "A implies B" (also "B to the A", the exponential)

**Greek letters**

- η — eta: "EE-tuh" (or "AY-tuh"); the unit
- ε — epsilon: "EP-sih-lon"; the counit
- β — beta: "BAY-tuh" (or "BEE-tuh")
- Γ — capital gamma: "GAM-uh"; the remaining assumptions
- Careful: η means two different things. On the Categories slides it is the unit; in the Harmony line it is the η-law, so say "the eta law" there.

**Subscripts, primes and bars**

- η_c, ε_i — "eta c", "epsilon i" (or "eta sub c", "epsilon sub i")
- a₀ — "a nought" (or "a zero")
- q′ — "q prime"
- w̄ — "w bar"
- State_A(X), Store_A(X) — "State A of X", "Store A of X"
- p(a) = (x, a₀) — "p of a is the pair x, a nought"
- q′ ∘ w = w̄ ∘ q — "q prime after w equals w bar after q"

**Inner models (the Evolution line)**

- L — "L": Gödel's constructible universe, built with first-order definability
- C* — "C star": the inner model built with the cofinality quantifier (Kennedy, Magidor, Väänänen)
- HOD — letter by letter, "H-O-D": the hereditarily ordinal definable sets, built with second-order definability

**Words**

- functor — "FUNK-ter"
- monad, comonad — "MON-ad" (or "MOH-nad"), "co-MON-ad"
- counit — "CO-you-nit"
- topos — "TOP-oss" (or "TOE-poss"); plural toposes or topoi
- univalence — "you-nih-VAY-lence"
- currying, uncurrying — "KUR-ee-ing", after Haskell Curry
- cartesian closed — "car-TEE-zhun closed"
- intuitionistic — "in-tew-ISH-uh-nis-tik"
- HoTT — said "hot": homotopy type theory
- elementary bound — if asked: bounded by a tower of exponentials of fixed height
- Coq — said like the French "coq"; renamed Rocq ("rock") in 2025, so "Rocq, formerly Coq" avoids the English pun
- ring — the tactic's name, said as the word

**Names**

- Ehrenfeucht — "AIR-en-foyt"
- Fraïssé — "fra-ee-SAY"
- Gentzen — "GENT-sen"
- Zalamea — "sa-la-MAY-a"
- Kauffman — "KAWF-mun"
- Peirce (oral commentary) — "purse", never "pierce"
- Lawvere (oral commentary) — "law-VEER"
- Grothendieck (oral commentary) — "GROH-ten-deek"
- Schrödinger (oral commentary) — "SHRUR-ding-er"

## Conclusion

### Theory of everywhere

 Care, the continuity of the network, is not assigned to any of these components. It finds a first formal foothold in the reciprocity of roles; how that reciprocity sustains continued participation remains to be shown.
