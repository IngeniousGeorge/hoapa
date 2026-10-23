# Work

## Conversation with external Claude

### Q

In his talk "beyond physics" Stuart Kauffman makes a reference to a definition of work that seems to him to be more subtle than the usual definition. It adds a sort of condition on what could be called work. (And I believe he then segways into the Montévil and collaborator stuff about closure.)

Can you find out what definition of work he's talking about?

### A

It's the physical chemist **Peter Atkins'** definition: work is the *constrained release of energy into a few degrees of freedom*. Kauffman contrasts it with the textbook "force acting through a distance." The added condition is that energy only counts as work when a constraint channels it. His usual example is a cannon: the cannon is the constraint (a boundary condition), and when the powder explodes it forces the expanding gas to push only along the bore.

From there he moves to closure, as you remembered. He notes that it took work to make the cannon, which gives his "work–constraint cycle": no constraint, no work, and often no work, no constraint. He then credits Maël Montévil and Matteo Mossio with first defining constraint closure in 2015. In their picture, A constrains the energy release in process 1 that builds B, B constrains process 2 that builds C, and C constrains process 3 that builds A. The result is a system that literally does the thermodynamic work of building itself, by constructing its own boundary-condition constraints.

The work–constraint cycle goes back to Kauffman's book *Investigations* (2000). His shorthand there is "work begets constraints beget work."

Sources:
- [Kauffman, *Is There a 4th Law for Non-Ergodic Systems…* (arXiv)](https://arxiv.org/pdf/2205.09762)
- [Kauffman & Roli, *Is the Emergence of Life an Expected Phase Transition…* (arXiv)](https://arxiv.org/pdf/2401.09514)
- [*The Kinetic Basis of Self-Organized Pattern Formation* (arXiv)](https://arxiv.org/pdf/1404.1283)


### Q

Could we introduce "thinking" or logic in this cycle by utilizing a duality between concrete and abstract, and say that there is a type of work where the constraint is apparatus A, in which concrete and abstract are flipped: an arbitrary piece of the world is dedicated to manipulate abstractions (neurons, circuits) which can design and apply algorithms and use memory "in the abstract" to then flip back again, into apparatus B which is their metabolism, which applies what A has decided into the concrete we started with?

### A

Yes, and you'd be in good company. The closest existing version is Howard Pattee's **"semantic closure"** and **"epistemic cut."** Pattee argued that life requires two kinds of constraint. One kind is lawful, dynamical constraints like membranes and enzymes. The other is "symbolic" constraints whose physical form is *arbitrary* relative to what they stand for, like the genetic code, where the mapping from codon to amino acid is a frozen convention, not chemistry. Semantic closure is when the symbols specify the machinery that reads the symbols. Jesper Hoffmeyer and Claus Emmeche called a similar idea "code duality" (digital vs analog), and von Neumann's self-reproducing automaton separates a description from a constructor in the same way.

Your flip fits Atkins' definition neatly, if you notice where the energy goes. For a substrate to hold abstractions, its states must be roughly energy-degenerate: a spike pattern or a bit costs about the same whichever "meaning" it carries, so physics doesn't decide the content. Apparatus A therefore does only tiny amounts of work, but that work builds *constraints* (a decision, a plan) that then gate much larger energy releases in B. Thinking becomes cheap work on constraints that channel expensive work. Kauffman gestures at this when he says information is essentially the release of energy into fewer degrees of freedom.

Two things to tighten. First, the flip isn't unique to brains. The cell already does it with DNA, so neurons look like a second, faster, rewritable layer of the same trick rather than a new kind. Second, for it to count as *closure* in the Montévil–Mossio sense, the loop has to be complete: B's metabolism must also do the work that rebuilds and maintains A (neurons, synapses, memory traces). Otherwise A is just a controller sitting on top. With that condition, you get a nested constraint closure where one of the constraints is a model of the world. That is arguably what Kauffman means when he links constraint closure to agents that sense, decide, and act.


### Q

What do those authors do with those models? What sort of thesis do they propose?
I know Kauffman is pushing for autocatalytic sets as a definition of life and its origin, that's why he's interested in closure, but what about the others?

### A

Each of them uses closure or the symbol–matter split to answer a different question:

- **Howard Pattee** is asking a physics question: how can symbols exist in a world of laws? His thesis is that life, like measurement in quantum mechanics, requires an irreducible split between dynamics (rate-dependent, governed by laws) and symbolic constraints (rate-independent, arbitrary, "rules"). Neither can be reduced to the other. Semantic closure is his minimal criterion for something that can evolve open-endedly. Without the split, you get self-organization but not heredity or real novelty.

- **John von Neumann** wanted to know what logical architecture lets a machine reproduce itself *and* grow more complex instead of degrading. His answer, worked out in the late 1940s before DNA's structure was known, was that you need a description used in two ways: *interpreted* to build the offspring and *copied uninterpreted* to pass along. That is essentially the logic of the genome, and it underlies his cellular automata work.

- **Jesper Hoffmeyer and Claus Emmeche** founded modern **biosemiotics**. Their thesis is that meaning and sign relations are real natural phenomena, not metaphors. Code duality says an organism exists twice: as a digital "message to itself" across generations (DNA) and as an analog body that interprets its world. Hoffmeyer adds that evolution tends to increase *semiotic freedom*, the richness of what organisms can interpret and respond to.

- **Matteo Mossio, Maël Montévil, and Alvaro Moreno** are after the *organization* of living things rather than their origin. Their thesis is that closure of constraints is what makes a system biologically autonomous. The big payoff is that it **naturalizes function**: a part has a function if and only if it is a constraint that contributes to maintaining the closure. That gives a non-mysterious basis for talking about "what something is for." Their lineage runs through Kant, Maturana and Varela's autopoiesis, and Robert Rosen.

Rosen is worth adding to your list. His (M,R) systems define life as "closure to efficient causation," and he argued this makes organisms impossible to simulate fully. Kauffman's claim that the biosphere isn't governed by entailing laws owes something to that line.


### Q

Could we express "requires an irreducible split between dynamics (rate-dependent, governed by laws) and symbolic constraints (rate-independent, arbitrary, "rules")" as an Idea in the sense of Lautman? As a tension/resolution between a couple of notions.
(And maybe as a continuation/extension of the previous work-constraint couple we identified in non-thinking work—also, what could the work-constraint couple be related to in the Lautmanian vocabulary?)

### A

Yes, and Lautman's framework fits surprisingly well. For him, an Idea is a *problem*: how do two contrary notions relate, such as local and global, or structure and existence? The Idea is never settled in itself. It gets partially resolved, or "incarnated," in concrete theories, each of which works out the relation in its own way. Pattee's split can be posed like this: **the dynamical and the symbolic** (or law and code). The tension is how something arbitrary, which no law determines, can act causally inside a world of necessity. The genetic code, nervous systems, language, and computers would be successive incarnations. Each is a partial solution, and none exhausts the Idea.

**The work–constraint couple** maps most naturally onto Lautman's **structure and existence**, his "schemas of genesis," where the structure of one domain gives rise to entities in another. A constraint is structure. Work is the act that brings something into existence. The cycle is a genesis that loops: structure engenders existence (constraint channels energy into work), and existence engenders structure (that work builds the next constraint).

Two of his other couples fit closure itself:
- **Intrinsic vs induced properties.** A cannon's constraints are *induced*, imposed from outside by whoever built it. A cell's constraints are *intrinsic*, produced by the system itself. Constraint closure is the point where all the relevant constraints become intrinsic.
- **The ascent toward completion.** Algebraic closure means every equation over a field finds its roots inside the field. Constraint closure means every constraint the system needs is produced inside the system.

**The extension to thinking** then reads as a doubling. At the first level, structure and existence are tightly bound: every constraint is paid for in work at its own scale. The symbolic level appears when constraints become energy-degenerate, so their *structure* is freed from the cost of their *existence*. That freedom creates a gap between two heterogeneous domains, and here Lautman's notion of the **mixte** helps. A mixte is an intermediate structure that belongs to both domains, the way analytic number theory links the continuous and the discrete. The ribosome and tRNA are mixtes between code and chemistry. In your concrete→abstract→concrete loop, perception and motor action are the two mixtes that perform the flips.

A caveat: Lautman worked almost entirely within mathematics, with occasional forays into physics such as symmetry and time. The biological extension is precedented, though. Deleuze, in *Difference and Repetition*, takes Lautman's Ideas-as-problems explicitly and applies them to the organism, treating genes and development as the actualization of an Idea. That would be a natural place to anchor your reading.


### Q

Dynamical and symbolic (Pattee) ≈ _ and formal (Lautman) ?

### A

**Realization**: *systems formal and their realizations* (*les systèmes formels et leur réalisation*). It appears in Lautman's list of dialectical couples alongside whole and part, and intrinsic and situational properties. In the 1939 presentation he gave with Cavaillès, the passage from a formal system to its realizations is one of the themes he reads as a possible link between notions in an ideal Dialectic.

The match with Pattee is good. Symbolic is to formal as dynamical is to realization: a code only means something once a machinery realizes it, just as a formal system only has content through its models. Lautman's favorite example also has a biological echo. The Skolem paradox shows that a formal system can't pin down its realizations, so unintended models always slip in. Similarly, a symbol never fully determines the dynamics that read it, and interpretation has to be supplied by the machinery.

Two differences are worth keeping in view. In Lautman, the realization is still mathematical (a model), not a physical process. In Pattee, the symbolic side is itself physical, just energy-degenerate. And the multiplicity runs both ways. For Lautman, one formal system has many realizations. For Pattee, the arbitrariness of the code means one dynamics could have been driven by many different symbol assignments. That two-way slack may be exactly the tension the Idea names.

Sources:
- [Cavaillès & Lautman, "La pensée mathématique" (1939)](https://www.imj-prg.fr/~emmanuel.ferrand/sensible/cavailles.pdf)


### Q

A. "Constraint closure is the point where all the relevant constraints become intrinsic." & "Constraint closure means every constraint the system needs is produced inside the system."
Could we say that this is the "engineering" equivalent of immanence in the sense of Deleuze? 
And if so, how does that relate to the univocity of Being?

B. Can we *roughly* apply Lautman's two kinds of decomposition: synthetic and analytic/proper (where he changes the meaning of those words substantially), which appears in chapter one of the unity thesis, along the line of the cell's metabolism-genetics divide (where the metabolism is seen as the "common plan with variations that tells you about how the cell is in its milieu" and the genetic code is "a list of constituents which tells you about this cell in particular"), and along a similar line in nervous systems (where the synthetic decomposition is the decomposing into neurons which are all based on the same blueprint and whose nature/functioning gives you what a brain is on its milieu, and the analytic is the view of brain activity as a list of thoughts which constitutes this particular brain)? And if we do, can we use those three examples to say something meaningful about the unity of "abstract work", by recycling the argument Lautman makes in mathematics into our framework about work happening at the concrete/abstract boundary and which follows the work-constraint/structure-existence|genesis context?

### A

**A. Immanence.** Yes. The closest precise match is Spinoza's *immanent cause*, which Deleuze builds on: a cause that stays inside its effects instead of acting on them from outside. A cannon has a transcendent cause, its maker. In a closed system, the constraints are produced by the very processes they constrain. Closure is a finite, approximate *causa sui*.

There is one tension. Closure produces an *individual*, with an inside and an outside, and Deleuze and Guattari are suspicious of exactly that. For them the organism is a "stratum," an organization that captures flows. So closure is immanent in how it is caused, but it is also how a living thing marks itself off from the plane. Note too that closure is organizational, not energetic: the system stays open to the energy flowing through it.

**Univocity** fits better than immanence. Being is said in one sense of everything, and the differences are of degree or intensity, not of kind. The work–constraint frame is univocal in exactly this way. "Work" means the same thing for the cannon, the cell, and thought, so life and mind are not a different *sense* of being: no vital force, no Cartesian dualism. Pattee's split survives as a difference in *mode*: symbolic constraints are those whose energy cost is decoupled from their structure. That is a difference within one physics, not a second substance. Univocity is also what your project needs, since the univocity of work is what would make "abstract work" a genuine kind of work.

**B. The two decompositions.** I couldn't retrieve the text of that chapter, so I'm working from your summary. Note that *propre* is also the French for "eigen" (as in *valeur propre*, eigenvalue), which likely colors his usage. Roughly, then:

- **Cell:** the synthetic decomposition is metabolism, a common core plan with variations that situates the cell in its milieu. The analytic decomposition is the genome, the list proper to this lineage.
- **Brain:** the synthetic decomposition is neurons built on one blueprint. The analytic decomposition is the repertoire of memories and thoughts proper to this brain. Attractor models of memory make "eigen" almost literal here.
- **Mathematics:** Lautman's own case, with the structure of a domain on one side and the decomposition of its elements on the other.

The pattern is that the synthetic decomposition sits on the dynamical side and the analytic one on the symbolic side. **Your concrete/abstract flip is the passage from one decomposition of the same system to the other.**

**Recycling Lautman's argument.** His move is that Weyl's split between analytic and synthetic mathematics is not a fault line between two irreducible disciplines, because algebraic, synthetic viewpoints turn up inside modern analysis itself. Unity comes from the convergence of methods, not from reducing everything to a common foundation such as arithmetic. Transposed:

1. Abstract work in cells, brains, and mathematics is unified not by a shared substrate (no reduction to chemistry or neurons) but because each realizes the same problem: a double decomposition linked by work.
2. Abstract work can be defined as work *paid for* in the synthetic decomposition (ATP, firing, a mathematician's effort) whose *product* is a constraint in the analytic one (a gene, a memory, a theorem). That is the structure–existence genesis, run across the boundary.
3. This makes a checkable prediction: each level should have **mixes** that belong to both decompositions. The ribosome is one, synaptic plasticity another. Lautman's own example in mathematics is Hilbert space, which he saw as a remarkable synthesis of continuous and discrete. A function becomes a list of coefficients, which is your flip in mathematical form.

The main caveat is that Lautman's two decompositions apply to *one* object, while metabolism and genome are physically distinct parts. The analogy therefore holds at the level of the cell's organization, not its matter. That is acceptable for a rough mapping, but it is the first objection a careful reader would raise.

Sources:
- [Lautman, *Mathematics, Ideas and the Physical Real* (Duffy trans.)](https://warwick.ac.uk/fac/soc/philosophy/people/beistegui/175683193-albert-lautman-simon-duffy-translator-mathematics-ideas-and-the-physical-real-2011.pdf)
- [Nature review of the *Essai sur l'unité*](https://www.nature.com/articles/143873a0)


### Q

Could we remark that when the metabolism participates in the genetics, the genetics doesn't "reward" the metabolism with privileges, or that when the neuron participates in the brain activity the activity doesn't reward the neuron with privileges? And could we explain that by saying that the relation between the concrete synthetic/univocal layer and the abstract analytic layer is and must be governed exclusively by the design (concrete -> abstract) and application (abstract -> concrete) of the "algorithmic work" that makes the loop into the abstract worthwhile for the concept of work (as opposed to "purely physical" work which doesn't have that loop)?

### A

Mostly yes, with one correction that sharpens your explanation.

**There *are* privileges, but only of one kind.** Brain activity does reward neurons. Hebbian plasticity strengthens the synapses that take part, and during development, active neurons receive survival signals while inactive ones are pruned. Genetics likewise "favors" core metabolism: those genes are more conserved, more tightly protected by selection, and more strongly expressed. What never happens is a privilege of *kind*. No neuron becomes a different sort of thing, and no metabolic pathway gains a rank that exempts it from the common plan. Differential treatment only ever comes through the unit's role in the computation.

This is Deleuze's univocity almost exactly. He doesn't say univocal Being has no hierarchy. He says the only legitimate hierarchy ranks things by their *power*, what they can do, not by their nearness to a higher principle. He contrasts a "nomadic" distribution with a fixed, "sedentary" allotment of shares. Your synthetic layer is nomadic in this sense: identical blueprints, with differences that are earned in the loop, not assigned.

**So your explanation works if "exclusively" is read as a condition rather than a fact.** The relation between layers is *supposed* to run only through design (concrete → abstract) and application (abstract → concrete). When something bypasses that channel, we get the classic pathologies:
- **Cells:** selfish genetic elements copy themselves without serving the organism, and cancer lineages grab resources outside the regulatory logic.
- **Brains:** seizures are runaway activity with no computation in it, and addiction hijacks the reward signal directly instead of earning it.

Each of these is a *breakdown of closure*. So the "must" is not a law that cannot be broken. It is the condition under which the loop keeps building itself. That is a stronger claim, and one you can check against cases.

**Why the loop is worth it compared with purely physical work.** Two reasons, both expressible in Atkins' terms:
- **Leverage:** a cheap constraint in the abstract layer gates a large energy release in the concrete one.
- **Memory:** a constraint stored abstractly can be reused indefinitely without rebuilding it each time.

The cannon has neither, so it never makes the detour.

**One asymmetry to flag.** In the cell, the *design* step happens mostly through selection across generations, not inside any single cell. In the brain, learning closes the loop within one life. The two incarnations differ in the timescale over which design runs. That may be the natural axis for ranking them by "power" in Deleuze's sense, without breaking univocity.

### Q

When I asked "Could we introduce "thinking" or logic in this cycle by utilizing a duality between concrete and abstract..." you answered with Pattee, von Neumann, biosemiotics and Mossio/Montévil/Moreno.
Could we say that Peirce was the original figure in all this? 
For one thing, he's the first to have proposed to use electrical circuits to simulate logical operations, which is, if I understand correctly, what "taking work from a purely concrete path to a concrete path that loops into the abstract (where there is this degenerate-energy aspect)" is all about.
If it is the case, could you expose that view clearly for me please, and provide references.

### A

Peirce is a strong candidate for the *original figure*, but not for being the root of the actual lineage. He anticipated almost every piece of the picture. Most of the later authors, however, reached it without him, with one exception: biosemiotics, which is openly Peircean.

## Peirce's view, reconstructed

**1. Logic is independent of its substrate.** In a letter dated 30 December 1886, Peirce told his former student Allan Marquand that logical operations could be carried out by electrical switching circuits. Marquand had built a mechanical logic machine in wood. Peirce's point was that the same logic could run on batteries and switches. A circuit diagram for an electrical version survives in Marquand's papers, but there is no evidence either of them built it. Your gloss captures the philosophical core: a piece of the world is dedicated to carrying a form that doesn't depend on what it is made of. The "energy-degenerate" part is not Peirce's, though. It is a 20th-century thermodynamic reading, from Szilard and Landauer to Pattee.

**2. Every machine reasons, but no machine designs.** In "Logical Machines" (1887), Peirce argued that every machine is in a sense a reasoning machine, since the relations among its parts entail relations nobody intended. This is a univocity move: no gap of kind between mechanism and logic. He also argued that every machine has two built-in impotencies. It has no originality, so it cannot find its own problems, and it can only do what it was contrived for. In your terms, machines can *apply* but not *design*. Design has to come from the loop.

**3. Dynamical action vs semiosis.** This is the deepest anticipation of Pattee. In "Pragmatism" (1907), Peirce says all brute-force action, physical or psychical, happens between pairs or results from actions between pairs. Semiosis, by contrast, involves a cooperation of three: sign, object, and interpretant, and it cannot be broken down into pairwise actions. That is the dynamical/symbolic split some sixty years before Pattee.

**4. The loop back to the concrete.** In the same 1907 manuscript, Peirce sorts a sign's effects into emotional, energetic, and logical interpretants: feelings, efforts, and habit-changes. The energetic interpretant is literally an exertion, which is work. The ultimate logical interpretant is a *habit-change*, that is, a new standing constraint on future action. So semiosis passes through work and ends by building a constraint. That is your design/application loop and Kauffman's work–constraint cycle in one schema.

**5. Laws as habits.** In his cosmological essays of 1891–92, Peirce argued that natural laws are habits the universe has acquired, and that matter is mind whose habits have hardened. Constraints emerging from activity, all the way down, is the work–constraint cycle generalized to cosmology.

## Where the claim needs qualifying

- **Precedence.** Jevons built the first logic machine in 1869, and Leibniz and Babbage came before that. Peirce's priority is specifically the *electrical* idea.
- **Influence.** The Marquand letter was only published in 1993. Shannon reinvented switching logic independently in 1937, and von Neumann, Pattee, Kauffman, and Mossio–Montévil don't build on Peirce. Pattee's sources are von Neumann, Bohr, and Polanyi; Mossio–Montévil's are Kant and Rosen.
- **The real Peircean line** is Hoffmeyer and Emmeche's biosemiotics and Terrence Deacon. Both take Peirce's triad as their foundation.

So the accurate claim is that Peirce is the first thinker to hold all the pieces together: substrate-independent logic, the irreducibility of the symbolic to the dynamical, effort as the bridge, and habit as the constraint left behind. The later tradition rediscovered these pieces separately.

## References

**Peirce**
- Letter to A. Marquand, 30 Dec 1886, in *Writings of Charles S. Peirce: A Chronological Edition*, vol. 5 (Indiana UP, 1993).
- "Logical Machines," *American Journal of Psychology* 1 (1887): 165–170; also in *Writings*, vol. 6.
- "Pragmatism" (1907), in *The Essential Peirce*, vol. 2, pp. 398–433 (semiosis at p. 411); also CP 5.464–496 (interpretants at 5.475–476).
- "The Architecture of Theories" (1891), "The Law of Mind" (1892), "Man's Glassy Essence" (1892), in *The Essential Peirce*, vol. 1.

**Secondary**
- K. L. Ketner, "The early history of computer design: Charles Sanders Peirce and Marquand's logical machines," *Princeton University Library Chronicle* (1984).
- T. Jappy, "The cautionary tale of Peirce's logical interpretant," *Language and Semiotic Studies* 10(1), 2024. A caution: the emotional/energetic/logical triad appears in only one manuscript, and Peirce later abandoned it.
- V. Romanini & E. Fernández (eds.), *Peirce and Biosemiotics: A Guess at the Riddle of Life* (Springer, 2014).
- J. Hoffmeyer, *Signs of Meaning in the Universe* (1996); T. Deacon, *Incomplete Nature* (2012).
- H. Pattee & J. Rączaszek-Leonardi, *Laws, Language and Life* (Springer, 2012), for comparison with point 3.

Sources:
- [History of Information: Peirce and switching circuits](https://historyofinformation.com/detail.php?id=3634)
- [Wikipedia: Logical machine](https://en.wikipedia.org/wiki/Logical_machine)
- [Peirce, "Logical Machines" (1887), Project Euclid reprint](https://projecteuclid.org/download/pdf_1/euclid.rml/1204900343)
- [Peirce's semiotic theory (Wikipedia)](https://en.wikipedia.org/wiki/Semiotic_theory_of_Charles_Sanders_Peirce)
- [Jappy, "The cautionary tale of Peirce's logical interpretant"](https://www.degruyterbrill.com/document/doi/10.1515/lass-2023-0043/html?lang=en)
- [Lyceum Institute semiotics seminar (EP2:411 text; Peirce and Biosemiotics)](https://lyceum.institute/news-and-announcements/2024/02/25/2024-spring-an-introduction-to-semiotics/)
- [Peirce Writings vol. 6 contents](https://peirce.indianapolis.iu.edu/writings/v6/toc6x.htm)

---



