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
- Permacultural : concretely minimal, abstractly demanding
- Scientific method :
    well-regulated scientist–Nature relation + (ad hoc peer review ↪ universities ↪ economy)
    → *well-regulated* network of relations among scientists, each retaining a well-regulated relation with Nature

[]: not a pitch but one of them ; inherently perspectivist ; a sort of motive
P: the agricultural technique → abstraction ; requires a lot of knowledge (your knowledge ≅ the system's), allows minimal imprint (your system ≅ the natural's)
S: !an extension! not a modification/relaxation ; "the conversation" as a protocol becomes an object of science and scientists sign up for the protocol they believe is the most trustworthy ; trust = guarantees [ … ] ("layers of complexity")
[ perspectivism, decentralization, autonomy, openness to peers, expressiveness, transparency, scalability, self-reflection… ]

### Sources

The authors it draws on are mathematicians (F.W. Lawvere, *A. Grothendieck*), philosophers (C.S. Peirce, G. Simondon, G. Deleuze), and *scientists* (S. Kauffman, J. Bowlby). In my project, these approaches meet in *Albert Lautman*’s philosophy of mathematics, as read by Fernando Zalamea (who has been supporting my work).

- A. Grothendieck : creativity, relative point of view, naturalness via rising sea, ecological thinking… the structure and destination of the project
- Albert Lautman : metaphysics as "problems the universe was going to run into no matter what", mathematics and physics as "effective theories answering those problems"…
- Scientists : we're interested in each step of the evolution of the universe, from field theories to origins of life and attachment

> …Hoapa as an invariant in the effective theories we see

G: "And all science, when we do not understand it as an instrument for power and domination, but
as an adventure in knowledge undertaken by our species through the ages, is but this harmony,
more or less wide and more or less rich from one period to the other, which unfolds over the
generations and centuries, by the gentle counterpoint of all the themes emerging in turns, as if
summoned from the abyss, to join and embrace in her."
L: …from covers/coverings as results of "generalized inquiry" to the Lautmanian movement from metaphysics to effective theories ; demystifying metaphysics ; giving a context to mathematics and physics 
S: …Zalamea's attention from a text called "Grothendieck's Generalized Theory of Evolution", where what I'm talking about today is the recursor/successor function, and one can find a trace of the abstractions I propose in each of the main steps of the evolution of the universe we know and love

### Thesis

My main thesis states that in a system that puts the dialectic between concrete and abstract to *work* (brain, computer, community), the relation between concrete substrate and logical labor must be a resource entirely *dedicated* to the design and application of representations and algorithms. A form of separation between two kinds of *decomposition*—analytic (as in prime factorization) and synthetic (as in vector coordinates relative to a basis)—is a guiding principle, informed by Lautman, which can keep this relation fruitful: in a community, between thinkers and the knowledge they produce.

- Work : explosion vs. engine, the role of constraints;
    engine vs. organism, the role of closure;
    engine vs. computer, the role of the "abstract loop"
    (Stuart Kauffman, "Beyond Physics" talk)
- Dedicated : in computers, in cells, in brains, in communities
- Decomposition : synthetic ~ dimensional ; analytic ~ proper

W: from physics to Peter Atkins: work = "constrained release of energy into a few degrees of freedom" ; in Kauffman, searching for origins of life ; symbolic and dynamical (Pattee, von Neumann, M&M, Peirce) ≈ (Lautman, logic) formal system and realization, abstract/concrete ; why "loop"
Dd: evident in computers, the hardware is dedicated to the operations of the software, same with the letters of the genetic alphabet: concrete substrate as "pure constraints" for abstract work, the shape is the execution ; brains are muddier, I claim because there are a lot more "layers of complexity" with their own concrete/abstract separations (like internal concrete/abstract divides in math and code) ; communities are "degenerate": the concrete substrate is not just coupled, but dependent on the abstract 
Dc: in math: dim = decompose through the structure of the ambient space, prop = decompose through the structure of the element itself ; what is being decomposed at the community level is knowledge: brains are like vectors, (documented) statements like prime factorization

### Theory of work

The physical starting point is that work depends on *constraints* that channel energy into particular effects. In living systems, activity also helps *maintain* the machinery that makes further activity possible. *Abstract* representations and algorithms enable a system to retain and share experience, discover relations, construct and test possibilities, revise its own means of understanding and action, and turn results into conditions for further work. This makes the relation between concrete conditions and abstract operations a powerful resource. Lautman supplies a way to investigate such relations through the mathematical and physical constructions that give them substance; Peirce, Simondon, and Kauffman help connect the question to living beings, their environments, and their practices of understanding. Hoapa's proposed separation between thinkers and the organization of knowledge is an engineering approach to developing this potential.

- Constraints : effects — Maintain : closure — Abstract : secondary loop

### Process

Hoapa is designed as a network of small *conversations* in which one group's work becomes another group's starting point. A question brings participants *together*; their discussion produces a document that others can examine, challenge, or develop. These documents form a growing map of questions, concepts, arguments, and dependencies: a knowledge *graph*. So that contributions can differ and come unforced, the system gives participants control and equal standing (they all play by the same rules they themselves manage). Knowledge acquires structure *independently* of the structure of its producers, be it social, political, economic…

- Conversation : modeled after citizen assemblies (helps autonomy, role-symmetry, modularity… control and equal standing)
- Together : message passing style, as in the actor model or π-calculus in concurrency
- Graph : typed knowledge graphs, which are versioned, multiplex, homotopical, federated…
- Independently : respecting the concrete/abstract separation of concerns and dedicated relation between the two

C: random selection, resolution by consensus, "let it crash" ; amazing results when experimented in politics
B: actors are "synthetic" agents, their messages "analytic" decomposition
G: the "base" layer is the orchestration, the trace of the conversations (records "verbatim" the process), upon which other conversations work on "refining" the content into specialized/pruned graphs, sharing the same underlying substrate but with different kinds of edges…

### Verification

The communication protocols specify how these conversations proceed and how their results enter the shared documentation. Software is used as a *referee* and is itself subject to modification by the conversations. Alongside the conversation process, a mathematical *verification* layer is being developed in cubical Agda, a language in which proofs can be checked by a computer. One existing result establishes that consistently renaming *participants* cannot change the checker's verdict. The broader aim is to make the system's promises precise enough to test and prove.

- Referee : automation as _liberation from control mechanisms_, from the necessity to have management
- Verification : machine-checks that the record of each conversation is well-formed according to the protocol, never that its conclusions are true
- Participants : the protocol is blind to identity of contributors, which means it can't count on specialization (is knowledge lost?)

R: once the rules enforced by the program are always open, without "higher constraints", and communally owned by a process in which "all play by the same rules"  
V: ∅
P: unityped in computer science, univocal in philosophy, synthetic/dimensional in mathematics ; people will specialize no matter what ; how participants in citizen assemblies deal with specialized knowledge: they go get it (and they're good at it) ; "Role symmetry gives us a concrete requirement to verify. Take a recorded interaction and consistently rename its participants, without merging distinct participants or changing their contributions and relations. The checker must still accept or reject the record exactly as before. This is called renaming invariance, and we have proved it in Cubical Agda for the current record validator. It gives one precise, checkable expression of the participants’ equal formal standing"

### Conjecture

The project seeks a mathematical correspondence—an *adjunction*—between two poles. One organizes inquiry through conversations, verification, and knowledge graphs. The other represents mathematical contexts and the different perspectives through which they can be investigated. The conjecture is guided by an intuition prompted by the perspectival nature of the world: our different understandings of it invite discussion, without presuppositions, from which something the world can reuse may *emerge*. The conjecture asks whether a *universal property* can distinguish Hoapa’s organization from alternatives. This talk will explore a candidate in which methods are represented by logics and mathematical worlds by the inner models they generate.

- Adjunction : context & inquiry,  perspectivism & praxis, structure & genesis/recursion…
- Emerge : the recursive nature of evolution: physics to biology, biology to psychology…
- Universal property : "specialness" → optimality

A: see later
E: Simondon's view: a context is full of potentials and tensions, and individuals coevolve with the milieu, without ever exhausting it ; candidate for future individuation from new context: AGI
U: a translation

### Rising sea

Video: P. Deligne, *L'œuvre d'Alexandre Grothendieck* (Nice, 1996), the first 1'12, with English subtitles (deligne_rising_sea.mp4). Click to play.

### Permacultural logic

The project also looks for this pattern inside logic, where "permaculture" is understood broadly as the two-step process of (1) getting to know one's context as much as possible, (2) acting minimally in a manner that will enhance one's condition while preserving and enriching the context. A proof may begin with a provisional assumption (borrow), derive a conclusion (work), and turn the derivation into a conditional statement that later proofs can use (return or *replay*). What began as work under particular conditions becomes a reusable achievement. Hoapa investigates this borrow–work–replay pattern as a possible logical expression of its permacultural ambition: the *harmony* between receiving and giving back.

- Harmony : as in Gentzen, type theory, Hilbert's axiomatic method
- Replay : the hidden part of logic that makes logic work

H: Gentzen in intro/elim, in type theory with how to construct a type and how to use a type, Hilbert in axioms and metamathematical theory (in the vision of Lautman) ; biological analogy: A cell draws on a proton gradient to produce ATP for new work, while consuming fuel to replenish the gradient; some of that work maintains the machinery that keeps the cycle going ; see later
R: you can't see the feedback (à la cybernetics), but for the structural rules to hold (≅ "the system to be sustainable"), there must be a form of non-exhaustion and positive feedback (visible part is the feedforward: new problems leading to new results)

### Development

The architecture of a "mature" Hoapa system is both demanding—to respect its constraints—and—by virtue of presuppositionlessness—*unpredictable*. Autonomous open-science workshops could make these ideas tangible and seed larger systems, embracing both pragmaticism and experimentalism. Their first requirement is usefulness: knowledge sharing must be truly at *stake*, so that the organization develops through serving a real purpose. Concretely, I envision something based on the philosophy of "document-driven-development", where *documentation* gradually replaces the instructor, both as the joint source of truth and the manager of the process.

- Unpredictable : collective inquiry helps determine how collective inquiry is organized
- Stake : what distinguishes and makes citizen assemblies efficient; you can't simulate life or understanding
- Documentation : does in the Lautmanian-analytic what specialization does in the synthetic agents: shared source and management, but "softer"

U: only collective intelligence should shape what collective intelligence should be (the same form of non-ergodicity as biology)
S: stakes are facilitators of consensus, so are role-symmetry and general equalitarian conditions, openness, anonymity… 
D: Grothendieck in 1972, when asked about "the revolution", he first discards the top-down approach, then calls for a bottom-up approach (start with "fixing" the relations between individuals), and uses the example of the teacher-student relation.


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

O: my working model was *literate programming*, by Donald Knuth, the great missed opportunity of software development ; better model is team semantics and provenance: for the work to have document-to-document continuity, as opposed to brain-to-brain or self-to-self, the documentation needs to show how a result was obtained, what it depends on, and what may need reconsidering when those dependencies change, etc.

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

L: Homotopy theoretic work on the raw output of the protocol, that you can think of as a landscape of concepts (plane of immanence of Deleuze) where the terrain is all those homotopy paths, and some concepts appear as peaks in the landscape, we then keep those peaks, as the words of our language, discard the rest and give them symbols and a grammar to interact and form structures and statements (optimized for accessibility, not specialized usage); the "rest" is preserved in the "abstract infinitesimal variations", literally, the "in between the words", which is in dialectic tension with the "concrete language substrate" → third separation: 1. concrete/abstract 2. synthetic/analytic 3. language/variations ; technical bridge: Awodey and Forssell’s First-Order Logical Duality, which explicitly connects with the Grothendieckian setting, relating categories presenting theories to topological groupoids of models and their isomorphisms, using topos theory to establish a syntax–semantics duality.

### Mathematics

All of the above applies in mathematics as well, but here the connection goes *further*: mathematics also supplies the language in which the organization of mathematical work can itself be investigated. Hoapa’s formalization uses Cubical Agda, bringing together homotopy type theory, computer-checked proofs, and a line of thought connecting Alexander Grothendieck’s ideas about homotopy types and higher groupoids with Vladimir Voevodsky’s univalent foundations.

Hoapa proposes to carry this connection into the organization of collective inquiry itself. This ambition echoes Grothendieck’s memoirs, which weave together reflections on creativity, mathematical practice and mathematics itself.

> Grothendieck also questioned the ecological consequences of scientific activity; Hoapa approaches that concern by asking how understanding a world can help us inhabit it.

- Further : a method of articulating a context can generate a new context for further inquiry (in math and logic, in generalized evolution)

F: Kennedy, Magidor and Väänänen - "Inner Models from Extended Logics", or Kennedy's essay "On the “Logic without Borders” Point of View" as concrete examples of what “a mathematical world generated through specified expressive resources” can mean

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

- Care : Hoapa’s generalization of attachment theory into a two-step cyclic algorithm
    1. In a given network, the evolution toward maturity of newer elements is taken care of by the
    mature elements already present in the network
    2. In turn, those newer elements become mature and take care of a new generation of elements

C: Lautman's "solidarity networks" ; Yoneda lemma ; game-theoretic semantics, particularly the tradition of Hintikka, Sandu, and Väänänen. Abramsky and Väänänen - From IF to BI: A Tale of Dependence and Separation (In game semantics, negation exchanges the verifier’s and falsifier’s roles: a mathematical precedent for treating reciprocity of roles as part of an interaction’s structure)

## The conjecture - an adjunction

### Informal recap diagram

D: looking for a mathematical setting in which the questions motivating the design become questions we can investigate precisely

### Motivations and goals

To motivate its adoption and distinguish Hoapa from other “interesting projects” we can attach buzzwords to, I need a mathematical reason for organizing inquiry this way. The goal is to characterize Hoapa by a universal property, in a setting that represents both the contexts it investigates and alternative ways of investigating them.

If the conjecture succeeds, this universal property would translate into a claim of *optimality* for any implementation satisfying its conditions. The world we inhabit must explain why those conditions matter. Hoapa is also its own experiment: implementing its protocols lets us test the conjecture's claims.

*Perspectivism* motivates this ambition; *presuppositionlessness* guides the response. The world has already produced different beings, experiences, skills, and ways of understanding. Their contributions must be able to enter the inquiry without their worth being decided in advance by a hierarchy or an established division of knowledge. What the world has already developed becomes material for collective work; what that work will produce remains open.

- Optimality : the constraints imposed on a process, in a given context, to achieve an intended outcome
    constraints = the protocol ; process = collective inquiry ; context = this world ; outcome = understanding that enables generalized permaculture to be enacted

- Perspectivism : global understanding assembled from local views, with obstructions to their integration retained as information

- Presuppositionlessness: applied to protocols, a principle saying we need common rules, open rules with equally distributed power to revise them, and only the rules needed to make communication possible

O: understanding = demanding abstract work
P: Deleuzian perspectivism with a long tradition (notably Spinoza) ; Lautman anticipates sheaf-theory in his treatment of the global/local dialectic ; in HLG scope: Ehrenfeucht–Fraïssé games, Abramsky’s contextuality work, and its translation into team semantics with Puljujärvi and Väänänen
P: The condition for the openness of the construction and its dedication to the concrete/abstract work relation: every assumption coming in and staying fixed is an unnecessary constraint ; reduce to one assumption: the assumption-free minimal open system which permits balanced community communication is also the special/optimal one (amounts to trusting communication itself, unlike the entire field of "collective intelligence")

### Categories from metaphysics

The proposed adjunction relates a category of contexts to a category of organizations of inquiry: write Ctx for the first and Inq for the second. We seek functors F : Ctx → Inq and G : Inq → Ctx with natural bijections Hom_Inq(F c, i) ≅ Hom_Ctx(c, G i). The unit η_c : c → GF c and the counit ε_i : FG i → i compare each side with its round trip. The mathematical form of Ctx is still under investigation, and neither functor has been constructed.

Each piece of this structure is meant to carry one of the project's concepts: *F*, *G*, the unit *η* and the counit *ε*.

- F : Complexity, the organized work a context allows
- G : Evolution, what organized inquiry produces can become part of the conditions under which further inquiry takes place
- η : Praxis, the general opening; how a piece of work w : F c → i realizes it in particular, and its transpose G(w) ∘ η_c : c → G i returns the work in contextual form
- ε : Anthropic loss, the possible failure of the reconstruction map ε_i : FG i → i to be invertible

F: Complexity in the sense of Yuri Manin ; Nature operates at a constant level of complexity, any apparent variation reflects a change in perspective…
G: Darwinian evolution generalizes, but the part that generalizes is not selection, but recursion: what evolution produces becomes a condition for what can evolve next
η: It's a mistake to remove the process of inquiry from the object of the inquiry ; "What is mathematics, really?" by Ruben Hersh
ε: Nature operates at a constant level of complexity, any apparent reduction reflects what is forgotten by the functors mediating between the world and an observer’s perspective

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

Oral commentary:

¹: Peirce describes diagrammatic reasoning as constructing a diagram, experimenting on it, and establishing which consequences hold for any construction made under the same conditions. A particular act of understanding yields a general relation. This is the movement that interests me in return: work acquires a form that can outlive the occasion of its discovery. Hoapa asks a conversation to leave such an achievement, with the relations it establishes and the conditions under which they hold available to others. See [Peirce on diagrammatic reasoning, NEM 4:47–48](https://www.jfsowa.com/peirce/ms514.htm).

²: Grothendieck's relative point of view gives this portability a discipline: keep the setting and the relationships through which a construction can pass to another setting. What must be established is which passages preserve what we want to use. Hoapa takes this as a design demand. Another community should be able to understand what it is importing, examine its applicability, and develop it without needing the original producers to return or authorize each use. An achievement becomes common means while its dependencies remain visible. This is our application of the [relative viewpoint](../anchors_concepts_codex.md#the-relative-point-of-view).

³: Lawvere shows how logical operations can be characterized through their relations to other operations. That gives Hoapa a way to make a philosophical demand exact: what must using an achievement preserve of the work that made it warranted? Establishing and using have different responsibilities, but their rules must answer to one another. Here the separation/integration mirror reaches inside logic itself. The harmony between receiving and giving back acquires a precise instance, which can then guide our search for adequate relations between inquiry and context. See Lawvere's [“Adjointness in Foundations,” §3](https://conceptualmathematics.wordpress.com/wp-content/uploads/2023/04/adjointness_foundations.pdf).

#### 2. What does the work leave available?

The same adjunction produces two familiar constructions. The *state monad* composes computations by passing the state left by one into the next. The *store comonad* holds a family of values together with a selected position, and allows that family to be considered from each position.

These structures organize work and access to its setting. Their laws alone do not preserve the conditions for further work. A computation p(a) = (x, a₀) can replace every incoming state with the same a₀, erasing distinctions that subsequent work needs.

Hoapa therefore asks about *continuation*: can the work we intend to do next still be performed from what has been returned? A publication may be sufficient for one use and insufficient for another. The requirement must specify what is to remain possible.

- **State monad:** Stateₐ(X) = A ⇒ (X × A)—receive a state; return a result and a resulting state.¹
- **Store comonad:** Storeₐ(X) = (A ⇒ X) × A—retain an indexed family and a current position.²
- **Continuation:** q′ ∘ w = w̄ ∘ q—q and q′ publish before and after the work w; w̄ performs the corresponding operation using only the published input.³

Oral commentary:

¹: Simondon asks us to understand an individual through the process that constitutes it together with its milieu. The achieved form partially resolves a situation containing tensions and potentials; further individuation remains a separate possibility. I apply this question to Hoapa's conversations and their achievements: what has been resolved, and what situation has the resolution left for others? Solving a problem can rightly remove a tension. The permacultural demand concerns whether the capacity for further development survives that success. See [Simondon, “The Position of the Problem of Ontogenesis,” pp. 5–8](https://parrhesiajournal.org/parrhesia07/parrhesia07_simondon1.pdf).

²: Kauffman's discussion of constraint closure draws attention to what an activity relies on: living processes help produce the constraints that channel those processes. This is the enabling side of work. A Hoapa document similarly relies on a maintained language, working tools, and people able to interpret it. A local task can use those conditions without reproducing their whole history, because other activities support them. That is the philosophical question I bring to the comonadic side: how does a local use remain connected to the organization that makes it possible? See Kauffman's [“Answering Schrödinger's ‘What Is Life?’,” §16](https://pmc.ncbi.nlm.nih.gov/articles/PMC7517386/).

³: Peirce's pragmatic maxim clarifies a concept through its conceivable practical consequences. This directs us toward what a community can understand and do through an expression, including uses beyond the immediate task. A publication should let later inquirers recognize the operations it supports and the points where their question exceeds it. Hoapa's universal technical language has this ambition: make relations usable across different inquiries, while allowing a new problem to demand a new distinction. This is the philosophical purpose of testing continuation. See Peirce's [“How to Make Our Ideas Clear,” §II](https://www.marxists.org/reference/subject/philosophy/works/us/peirce.htm).

#### 3. The economy of replay

Earlier I called replay “the hidden part of logic that makes logic work.” *Cut* gives this phrase a precise sense. An established result enters a later proof; cut elimination can remove that intermediate use without changing what is provable. But removing it can make the proof enormously longer.

There are families of short proofs with cut whose shortest cut-free proofs grow beyond every elementary bound in the original proof lengths. Reuse can therefore be dispensable for provability and decisive for *feasibility*.

This gives the sustainability intuition a concrete dimension. Mathematical development concerns what our means of reasoning let us accomplish with finite resources. An achievement can leave the set of consequences unchanged while transforming our capacity to establish and use them.

- **Cut:** a proved result becomes a premise of further reasoning.¹
- **Feasibility:** the same conclusions can require radically different proof lengths; preserving intermediate achievements can make complex work practicable.²

Oral commentary:

¹: Lautman distinguishes the constituents proper to an object from the common scheme in which objects are expressed. Hoapa uses this distinction to describe a change of role: the differentiated product of one inquiry can become part of the common language of another. A lemma remains a particular achievement while becoming an available step in someone else's work. This is what I mean when I say that the analytic aspires to become synthetic. The community builds a body of knowledge that can become a shared basis for further thought. See [our reading of Lautman's proper and dimensional decompositions](../anchors_concepts_codex.md#proper-and-dimensional-decomposition).

²: Peirce explicitly places an economy of research within his account of logical method. He asks how acquiring and spreading knowledge relate to the effort they require. That is close to Hoapa's motivation: the organization of inquiry determines how much earlier work can help later work. The proof-length result gives one exact instance of this concern. A community's finite capacity can be spent rebuilding what it already knows, or extending what its achievements now let it do. Making knowledge accessible and reusable therefore participates in the development of knowledge itself. See Peirce's [Carnegie application, memoirs 27–28](https://www.cspeirce.com/menu/library/bycsp/l75/ver1/l75v1-08.htm).

#### 4. Achievements become means of inquiry

A further step occurs when an achievement changes the tools through which inquiry proceeds. In proof by *reflection*, a procedure is defined, its correctness is proved, and that proof supports its use in subsequent reasoning. Coq's `ring` tactic provides a concrete example: established mathematics becomes machinery for later mathematics, while the existing kernel continues to check the proofs.

The reusable material can also widen: from derivations in Gentzen's systems, to formalized theories in Hilbert's metamathematics, to constructions and their transport between equivalent types in HoTT. Lautman's passage from structure to genesis, and Simondon's account of produced structures supporting further structuring, guide our interpretation of this movement.

*Renewal* occurs when achievements change what further work can do. With Kauffman, we must also ask whether the organization producing them maintains its *conditions of activity*. Hoapa's evolutionary hypothesis joins these demands: work should produce reusable achievements while sustaining and developing the conditions for further work.

- **Reflection:** a verified procedure becomes part of the proof-producing toolbox, without becoming a new trusted rule.¹
- **Renewal:** preserve declared earlier uses and make a genuinely new operation available.²
- **Conditions of activity:** reusable results still depend on people, skills, records, tools, and material support.³

Oral commentary:

¹: In Lautman's universal-covering example, an achieved structure makes further mathematical constructions possible. Zalamea reads such passages through saturation and liberation: enriching a setting can release new forms of construction. Hoapa asks for a similar passage in collective inquiry. Reflection makes the point tangible: a proved result becomes machinery for proving. The achievement changes its role in the activity and helps constitute the means through which subsequent achievements are produced. This is the structure/genesis relation we want to investigate. Sources: Lautman, Mathematics, Ideas and the Physical Real, pp. 130–131; Zalamea's introduction to that volume, pp. xxiv–xxv.

²: Simondon calls transduction a process in which an already formed structure supports further structuring. Grothendieck's rising-sea method gives us a mathematical kinship: develop the surrounding concepts until constructions become available within them. Hoapa aims to give this movement an organized collective form. Documents become shared concepts; those concepts change the questions a community can formulate; those questions set further work in motion. This is renewal when the new setting supports a capability its predecessor did not provide. See [Simondon, p. 11](https://parrhesiajournal.org/parrhesia07/parrhesia07_simondon1.pdf), and Grothendieck's [Récoltes et Semailles, English translation, PDF p. 93](https://www.ucw.cz/~ps/grothendieck/grothendieck-harvests-lisker1.pdf).

³: Kauffman's account of biological work suggests a stronger requirement than accumulating products: the productive organization has to keep making its own activity possible. Hoapa brings this question into collective inquiry. Knowledge should help sustain people's capacity to investigate, the means they share, and the world on which both depend. This is how I understand its possible participation in a generalized evolution: a context enables inquiry; inquiry produces achievements that become part of a changed context; that context supports further inquiry, with new means and new problems. The conjecture seeks a mathematical account of this passage, and permacultural logic names the demand that development sustain what enables it.

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
