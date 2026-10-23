# For HLG

Here is what "all of the above" had built up to, by the time you asked whether Helsinki could hear it.

The starting problem was self-reference, and the escape was to give up prediction. The discussion had been circling whether a theory of mathematical evolution can be rigorous without having to contain its own successors. Several exits were weighed: lowering rigour historically, in the manner of Lakatos or Wilder, which works because Gödel and Tarski only bite a system strong enough to talk about itself; or treating rigour the way physics treats effective theories, exact locally and informal in the glue. The resolution adopted was Thom's — prédire n'est pas expliquer. The framework feeds on the mathematics you give it and returns a digested map; it does not produce new mathematics. That dissolves the self-reference problem outright, since a theory that does not predict need not contain what comes after it. Two costs were accepted openly: good maps suggest whether you want them to or not, as Mendeleev's gaps did, so "produces no new mathematics" is unattainable and "suggests but does not produce" is the honest version; and Thom's own catastrophe theory shows that giving up prediction is defensible but will have to be defended.

The engine was then located in failure, not in success. The strongest idea on the table was that incompatibilities between local mathematical perspectives should be read cohomologically: locally consistent, globally not, with nonzero classes as content rather than defect. The historical pattern fits — failure of unique factorisation gave ideals, the missing square root of −1 gave complex numbers, noncommutativity gave noncommutative geometry — each time an obstruction class becoming a new object. There is a precise precedent in Abramsky's use of sheaves and Čech cohomology to measure quantum contextuality, so this is not merely a metaphor, though treating the space of mathematical settings as a site with coefficients remains a programme rather than a theorem. A refinement followed: a single total scale would make evolution a line without branching, so evolution lives in the fibres of a measure and in the mismatch between measures that disagree — which is precisely where the cohomology would sit. And unification was given its own rhythm: zoo, then a common language, then a new zoo one level up, with absorption trivialising some obstruction classes while creating others higher.

The stable thread through all of it was declared to be the relative point of view, with two amendments. Objects over a base, stable under pullback, appears inside nearly every pillar: dependent types are types over a context, sheaves and descent are data relative to a cover, forcing is set theory relative to a ground model, Caramello's programme is literally relative topos theory. It survives changes of foundation because it is a pattern rather than a structure, and it applies to itself — the evolutionary framework can be taken relative to "mathematics as of stage t". The first amendment: it is not independent of sameness, since base change is coherent only up to canonical isomorphism, so a relative viewpoint is a pseudofunctor into a 2-category, and the real thread is the cluster relative plus invariant, Grothendieck plus Klein, leaning on the adjoints Σ ⊣ pullback ⊣ Π that are the quantifiers. The second, sharper: a principle that always holds risks being empty, so the content lies in what fails — properties unstable under base change, local data that does not descend, sections existing locally but not globally. The thread stays true; the obstructions to gluing along it are where new mathematics comes from.

Then your anthropic argument was given a mathematical form. Your claim was that the universe's apparent conspiracy to produce us is an artefact of seeing it from one position with most of it hidden, and that science cannot easily say this because it is committed to its own neutral standpoint. Grothendieck's framework turned out to contain a precise version, together with a way past the dilemma: you do not need a view from nowhere to have objectivity, you need the coherent family of all views. Skolem's paradox is the effect almost verbatim — a countable model believes it holds uncountable sets because the bijection that would reveal otherwise lives outside it. The internal logic of a topos makes each world's axioms feel to its inhabitants like just how mathematics is. Set looks privileged only because it is the chosen base. The functor of points then formalises the resolution: a scheme is the coherent family of its views, with Yoneda guaranteeing nothing is lost. Two facts sharpened it further — some toposes have no points at all, so reality exceeds the union of the viewpoints anyone happens to have; and the objective fragment is computable, since geometric logic is exactly what transfers along every change of viewpoint while negation and excluded middle are perspectival. The frontier between objective and perspectival truth is a theorem, not a stance. Where the analogy strains was stated too: mathematics has no "we could not have existed otherwise", so this is a selection effect on access, not on existence — which is the cleaner version anyway, since it needs no conspiracy, only a base.

Finally, your own proposal: encode all of it as a fibred adjunction. Mathematical worlds as relative structures on one side; on the other a continuum of methodologies for a community of unityped inquirers approaching its Lautmanian problems — with the free functor generating new worlds and the forgetful functor being the anthropic principle. The answer was that this can be made precise and already has a prototype in Lawvere's Adjointness in Foundations, with classifying toposes as the sharp instance of the free direction. Each component acquired an exact meaning: the counit compares the world regenerated from its inhabitants' methods with the actual world, so the anthropic illusion is "the counit looks invertible from inside", and Vickers's toposes without enough points are worlds that classical methods cannot recover. The unit asks whether a methodology learns anything by passing through the world it generates. Beck–Chevalley demands that generating a world then changing context agrees with changing context then generating — and where it fails, the order of operations matters, which is a natural home for the obstruction classes. The induced monad gives research cycles, with its algebras as self-consistent methodologies, and Peirce's long-run convergence reading as the limit of that tower. Two further pieces: human organisations factor through abstract processes by a forgetful functor keeping a group's formal shadow and discarding its sociology, so the pure-mathematical reading stays free of any notion of research or communication; and unityped has a precedent in Scott's models, where types emerge as idempotents on one universal domain rather than from differences between agents. The caveats closed it — morphisms and direction must be fixed, since geometric morphisms run contravariantly to intuition; and the antidote to metaphor is a concrete test fibre, namely geometric theories against Grothendieck toposes over a base, where free generation, internal view, counit gap and Beck–Chevalley are all already theorems.

### Q

On a side note/quest, could all of the above be made intelligible to logicians practicing model and/or set theory? For instance the Helsinki logic group. (Granted we encapsulate the mathematics expressible in their language only with a little bit of philosophical context, expressed in almost-ordinary English.)
What would this presentation look like and rely on?

### A

Yes, and a Helsinki audience is unusually well placed for it. Much of what we discussed already exists in their language, some of it in their own recent work. The presentation should translate rather than import. Use only one categorical idea explicitly: the syntax–semantics correspondence between theories and classes of models, which they already know as a pair of closure operators (Th and Mod). Everything else maps to notions native to model theory and set theory.

**Dictionary**

| What we discussed | Their language |
|---|---|
| world / setting | model, Boolean-valued model, inner model |
| change of base | relativization, forcing extension, ultrapower |
| truth invariant across viewpoints | absoluteness (e.g. Shoenfield) |
| perspectival illusion | Skolem's relativism; internal categoricity (unique from inside, plural from outside) |
| "enough points" (Deligne's theorem) | Gödel completeness, and its failure for strong infinitary logics |
| Morita equivalence | bi-interpretability |
| subtoposes ↔ quotient theories | lattice of extensions of a theory |
| methodology | a logic in Lindström's sense, or an Ehrenfeucht–Fraïssé game |
| what a method can't see | two structures indistinguishable by that logic's EF game |
| trade-offs between pillars | Lindström's theorem: first-order logic is the strongest logic with both compactness and Löwenheim–Skolem |
| structured poset with measurement | Shelah's dividing lines, Keisler's order, Borel reducibility of isomorphism relations (Friedman–Hyttinen–Kulikov) |
| contextuality | team semantics |
| obstruction to gluing | failure of generalized amalgamation |

The bridge that makes the dictionary trustworthy is that Boolean-valued models are sheaves on a complete Boolean algebra. Forcing is literally a topos construction, so this is a translation, not an analogy.

**Three flagship examples, each Helsinki-native**

1. **Methodology generates a world.** Kennedy, Magidor and Väänänen observe that replacing first-order logic by second-order logic in Gödel's definition of L gives HOD. They then study the inner models produced by logics of intermediate strength. Both L and HOD show some "formalism freeness": they are not very sensitive to the choice of logic. The cofinality quantifier, by contrast, gives a new robust inner model C* between L and HOD. This is your free functor exactly: a logic (a method) generates a world.

   Better still, assuming a proper class of Woodin cardinals, the theory of C* is absolute under set forcing. So generating the world commutes with changing the ground model, which is the condition I called Beck–Chevalley earlier. L illustrates the same stability, while HOD shows it can fail, since HOD can change under forcing.
2. **No global viewpoint.** Abramsky, Puljujärvi and Väänänen showed that Abramsky's relational empirical models can be read as teams in the sense of team semantics. The basic quantum-theoretic properties then become independence atoms, and relations between hidden-variable properties become logical consequences in independence logic. Contextuality, and with it your "no privileged viewpoint," is already expressible in their own logic.
3. **Failure to glue is content.** Goodrick, Kim and Kolesnikov defined homology groups attached to amalgamation functors. These groups vanish when generalized amalgamation holds. For strong types in stable theories, they showed any profinite abelian group can occur as H₂. This grew out of Hrushovski's discovery that failure of 3-uniqueness forces the existence of a definable groupoid. So a nontrivial obstruction class is hidden structure. That is the cohomology-of-evolution idea with a working proof of concept.

**What the presentation would look like**

- **Opening (plain English, about one page).** No privileged universe: Skolem, Hamkins's multiverse, Kennedy's formalism freeness. Objectivity as absoluteness rather than a view from nowhere. Mathematics grows by changing logics and changing grounds.
- **Core.** The Galois connection between logics and the worlds they generate or distinguish, stated uniformly in the ground model and asked to be compatible with forcing. The anthropic direction is "reduce a world to what a given logic's EF games can distinguish."
- **Evidence.** The three examples above, each a theorem they already accept.
- **Program.** Evolution as iteration of the method ↔ world cycle, with amalgamation-style homology measuring what fails to glue. Explicitly explanatory, not predictive.
- **Appendix only.** The topos dictionary, for those who want the categorical version.

**What it relies on, and what to avoid**

It relies on their existing toolkit: relativization and absoluteness, forcing, Lindström's abstract model theory, inner model constructions, classification theory, team semantics, and EF games. The games deserve emphasis, since they give "methodology as process" a native form with no reference to research or communication.

Avoid 2-categories, fibrations and toposes in the main text. Present the evolutionary theory as a program whose instances are known theorems, not as a new foundation. Kennedy's vocabulary (formalism freeness) already gives them a philosophical register they use, which is the "little bit of philosophical context" you mentioned.

Sources:
- [Kennedy–Magidor–Väänänen, Inner models from extended logics: Part 1 (JML)](https://www.worldscientific.com/doi/abs/10.1142/S0219061321500124)
- [Inner models from extended logics: Part 1 (arXiv version)](https://www.researchgate.net/publication/343124448_Inner_Models_from_Extended_Logics_Part_1)
- [Abramsky–Puljujärvi–Väänänen, Team Semantics and Independence Notions in Quantum Physics (BSL)](https://www.cambridge.org/core/journals/bulletin-of-symbolic-logic/article/team-semantics-and-independence-notions-in-quantum-physics/E095EBD19F457BBE1F6B8548E26BDE9C)
- [Goodrick–Kim–Kolesnikov, Amalgamation functors and homology groups in model theory](https://arxiv.org/pdf/1105.2921)
- [Goodrick–Kim–Kolesnikov, arXiv abstract](https://arxiv.org/abs/1105.2921)