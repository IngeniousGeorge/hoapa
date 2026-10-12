# Hoapa's anchors and borrowed concepts

Working inventory for discussion outside the project — 11 October 2026.

This document describes what Hoapa borrows from its intellectual anchors, how
it interprets those borrowings, and what it attempts to make with them. It is
not a survey of the authors' philosophies. Its subject is their active life
inside this particular project: ideas becoming questions, architectural
commitments, mathematical candidates, and methods of work.

It deliberately gathers material otherwise distributed across the project's
working files and conversations. The exposition is self-contained; repository
references at the end provide provenance, not prerequisites. An author's
concept, Hoapa's transformation of that concept, and a mathematical result
established by the project are different kinds of claim. The text distinguishes
them where they meet, without imposing a standard questionnaire on every entry.

## Orientation: what the borrowings are helping to build

Hoapa investigates how an open community can understand its context, return
reusable achievements, and make further understanding possible. Its practical
architecture separates participants' formal standing from the classification
of their contributions. Participants share a common interface and the same
rules of participation; concepts, messages, evidence, dependencies, and
documentary products can be richly differentiated. Expertise matters to what
someone contributes without becoming a compulsory intellectual identity or a
privilege built into the protocol.

The project calls this distinction **unityped participants and multityped
documentation**. Unityping is not a claim that people have identical minds or
interchangeable contributions. It is a restriction on what the organizing
system may make of their differences. The protocol represents specified work
and participation, not the whole person.

Two names organize the mathematical conjecture. **K** is the concurrency side:
actor-causal communities, session-typed interaction, and their documentary
interfaces. **M** is the world/context side whose appropriate mathematical
form remains under investigation. Neither is simply a name for all human
society or all Reality. The candidate relation is:

```text
Allow : M → K       Require : K → M
Allow ⊣ Require
```

An adjunction expresses a coherent correspondence between two kinds of maps.
Here the ambition is to relate a context's enabling of organized work to the
contextual presentation of what that work requires or achieves. These two
functors have not been constructed. The names express intended jobs, not a
completed mathematical account of them.

Several K-side fragments have been formalized in Cubical Agda, including
finite descent and scoped bridges between cartesian locality and linear
session content. That work is substantially narrower than the conjecture.
HoTT is the foundational working language. Cohesive and modal mathematics
helped develop the project, but cohesion is no longer prescribed as the answer
for M.

The recurring practical pattern is **borrow–work–return–replay**. A situated
activity uses enabling conditions, performs particular work, returns an
accountable achievement, and may make that achievement available for later
use. Return is not already replay; replay is not already renewal. Documentation
becomes developmentally important when it can support work beyond the episode
that produced it.

The desired result is relational adequacy: a universal-property account of
why a class of organizations containing Hoapa is especially adapted to stated
contexts and uses. It is not a score invented to make Hoapa win. This is why
the authors below are used both to suggest constructions and to ask whether
those constructions address the right problems.

## Contents

- [Part I: author-centred borrowings](#part-i-author-centred-borrowings):
  [Lautman](#lautman), [Simondon](#simondon),
  [Grothendieck](#grothendieck), [Lawvere](#lawvere),
  [Deleuze](#deleuze), [Peirce](#peirce),
  [Bowlby](#bowlby), and [Hersh and Zalamea](#hersh-and-zalamea).
- [Part II: transversal problems](#part-ii-transversal-problems):
  [intensive/extensive](#intensive-and-extensive),
  [the separation/integration mirror](#separation-and-integration-the-reciprocal-mirror),
  [borrow–work–return–replay](#borrow-work-return-replay),
  [universal technical language](#universal-technical-language),
  [Care](#care-openness-and-non-extraction),
  [saturation and liberation](#saturation-liberation-and-open-ended-development),
  and [infinity and infinitesimality](#infinity-infinitesimality-and-continuation).
- [Sources and project provenance](#sources-and-project-provenance).

## Part I: author-centred borrowings

### Lautman

Lautman gives the project both a central distinction and a way of asking what
mathematics is doing. The distinction concerns how a being is decomposed. The
larger question concerns how an effective theory realizes a problematic
relation that it does not simply reduce to a list of axioms.

#### Proper and dimensional decomposition

A proper or analytic decomposition exhibits constituents characteristic of a
particular being: prime factors of an integer are the guiding example. A
dimensional or synthetic decomposition articulates beings according to a plan
supplied by their ambient domain: coordinates of vectors in a chosen basis are
the guiding example. The distinction is not simply parts versus whole, or
analysis versus imagination. It asks what organizes the decomposition: the
being's particular constitution or a common structure in which it participates.
Lautman also makes dependence on the ambient domain important: what factors
are available can change with the field in which one works. See *Essay on the
Unity of the Mathematical Sciences*, chapter 1, in [*Mathematics, Ideas and the
Physical Real*](https://www.bloomsbury.com/us/mathematics-ideas-and-the-physical-real-9781441146564/).

Hoapa's decisive interpretation specifies what is being decomposed:
**understanding of the world**, existing in two realms. Embodied understanding
is distributed among a community of thinkers. Documentary understanding is
articulated into concepts and their relations. Hoapa organizes the first
predominantly synthetically, through a common mode of participation, and the
second predominantly analytically, through differentiated conceptual work.

The vector and prime-factor images clarify the intention without becoming
literal models. People are not basis vectors spanning a population, and
concepts have not been shown to possess unique prime decompositions. The
common interface supplies equal standing, not identical internal organization.
A participant contributes to an articulation of understanding; the protocol
does not decompose that person exhaustively.

The asymmetry matters politically. Documentation should be able to become
synthetic: yesterday's differentiated achievements may become today's shared
language or conceptual setting. But the reverse movement can be coercive when
documentary classifications become classifications of people, fixing their
specialties and authority. Hoapa attempts to let knowledge differentiate
without making its producers into corresponding formal kinds.

This interpretation has an architectural contrast. If a participant's past
output determines their right to occupy a seat or their formal authority, the
system no longer grounds standing solely in the shared participation
interface. Different assessments of contributions are compatible with Hoapa;
turning those assessments into unequal standing is the disputed move.

Both moments nevertheless occur in both realms. A particular run has its
specific events and dependencies; its protocol provides a common plan.
A particular document has its own evidence and constituents; its language
provides a shared setting. Likewise, neither M nor K is exclusively synthetic
or analytic. The predominant orientation is a substantive project
interpretation, not an exhaustive classification theorem.

#### Dialectical Ideas and effective theories

The project borrows Lautman's treatment of pairs such as local/global,
structure/existence, and continuous/discontinuous as problems whose relations
become effective in mathematical theories. An effective theory is not merely
an illustration pasted beneath a metaphysical slogan: its constructions make
the problem determinate in a particular way.

Hoapa uses this as a question-generating discipline. What does the
independence/interdependence problem become in concurrency? What does
local/global become when different conversations produce compatible or
incompatible documentation? What structure would make the existence of an
adequate shared representation a precise question?

Examples already contemplated include local/global becoming a descent
problem, essence/existence becoming representability of a specified functor,
and a plurality of realizations becoming a moduli problem. These are possible
mathematical internalizations, not a universal translation dictionary. Their
value is to turn an evocative relation into an obligation whose failure could
teach us something.

This explains the project's philosophical ambition: an implemented community
of inquiry might be an effective realization of such problems in its own
right. It would still need an adequacy argument; calling it an incarnation
does not supply one.

#### Genesis and regressive inquiry

Hoapa takes two directions of movement from its reading of Lautman. One
follows a problematic toward constructions through which it becomes effective.
The other reads back from a theory to the questions its organization makes
visible. A problem may become clearly expressible only after substantial
mathematics has already answered part of it.

The project makes this movement iterative and public. A conversation can
return not only a solution but a better statement of the problem, a failed
construction, or a previously hidden dependency. Those achievements can
become the material of another inquiry. This is part of why a failure record
must remain referenceable rather than disappear as unsuccessful noise.

Lautman's ontological priority of the Dialectic and the project's more immanent
reading should not be conflated. Deleuze, Zalamea, and Corfield are
intermediaries in this reception, with different emphases. Hoapa does not
claim that all of its recursive, institutional interpretation was already
Lautman's explicit programme.

#### Mixtes and mediating structures

The project also takes from Lautman's intermediate or mixed structures a
question about passage: what can relate different kinds of beings while
retaining the features that make the distinction important?

This gives philosophical motivation to named adapters. Hoapa distinguishes
cartesian locality from linear session content, for example, and constructs
bridges rather than silently treating the two as the same category. The
Lautmanian contribution is not an identification of a particular adapter with
a mixte. It is the demand that an intermediate construction have substantive
content on both sides.

The same demand applies to the conjectural M/K correspondence. A bridge
cannot be established by naming two abstract settings and postulating their
agreement. It must disclose what passes between them, what is preserved, and
what the passage cannot recover.

### Simondon

Simondon shifts attention from finished individuals to their coming into
being with a milieu. Hoapa borrows this orientation to describe episodes,
artifacts, and contexts that develop together, rather than treating a context
as a passive container for already complete units.

#### Individuation, preindividual potentials, and milieu

In the account used by the project, individuation resolves a problematic
within a metastable field while leaving further potentials available. The
individual and its associated milieu must be understood together; the
individual is not the exhaustive result of consuming a stock of unfinished
matter. [Simondon's introduction on individuation](https://parrhesiajournal.org/parrhesia07/parrhesia07_simondon1.pdf)
is the principal accessible source for this orientation.

For Hoapa, an episode can produce an articulated achievement while changing
what its context makes possible. A documented disagreement may clarify the
terms of a future inquiry. A concept may stabilize enough to be reused without
ending the problematic from which it arose. Closure of a conversation is
therefore not closure of the field of inquiry.

The project does not ask the kernel to individuate human beings. Participants
are not raw material from which the protocol manufactures persons. The
formalized candidates are conversations, contributions, documentary products,
and their contextual relations. Psychic and collective transformation matters
to the interpretation of praxis without becoming identity-refining data about
participants.

#### Transduction and contextual renewal

Transduction directs attention to a structuring activity in which a local
resolution helps condition further structuring. Hoapa uses this to ask for
more than repetition under an unchanged grammar: can achieved work alter the
conditions of subsequent work?

One mathematical proposal reads a particular episode as a map w : Allow(m) → k,
and its adjunctive transpose as a contextual presentation m → Require(k).
That gives a possible location for the universal/particular relation. It does
not show that the episode is a Simondonian individuation: every adjunction
has transposes, and developmental content must come from the objects,
interpretations, and admissible changes.

The productive requirement is to distinguish a new achievement within a
setting, a new presentation of the same setting, and a change in contextual
capabilities. None can be read from notation alone. A different site may
present an equivalent topos; a new object in the same topos may already enable
an important new operation. Renewal is relative to what becomes possible,
not to the visual size of the change in mathematical machinery.

#### Information and the receiving problematic

Simondon's information is relevant to the transformation of a receiving
system, not merely to a signal considered independently of the encounter.
Hoapa consequently distinguishes an available artifact from its becoming
informative in a later situation.

The same document may confirm one reader's understanding, resolve another
problem, or force a reorganization of a third context. Accessibility enables
these encounters; it does not determine their effects. Replay must therefore
name a use and an interpretation, rather than count the existence of a stored
record as successful transmission of understanding.

This is also why the project resists reducing information to a universal
entropy score. Statistical information, distinctions retained in an artifact,
and a recipient's changed capacities require different structures. Simondon
helps keep the transformative question present, but supplies no automatic
quantitative measure for it.

#### The connection to Kauffman

Simondon and Kauffman meet in the project's question about organized activity
that changes or maintains its own enabling conditions. Their contributions
are not identical. Individuation directs attention to formation and the
individual–milieu relation; biological closure directs attention to how
processes and constraints support one another.

Hoapa uses that crossing to distinguish maintenance from renewal without
devaluing maintenance. An artifact may need stable storage, a maintained
language, and intelligible interfaces before it can enable further invention.
The detailed Kauffman and Montévil–Mossio borrowings appear below under
[borrow–work–return–replay](#borrow-work-return-replay).

### Grothendieck

Grothendieck is simultaneously a methodological anchor, a source of
mathematical resources, and an anchor for creative mathematical practice.
These roles reinforce one another but should remain distinguishable.

#### The relative point of view

The project adopts the practice of studying an object through its relations,
families, and changes of base. Instead of asking what an artifact means once
and for all, ask what it means in a specified documentary setting and what
survives when that setting changes. Instead of assigning a property to an
isolated architecture, ask about its adequacy relative to contexts and uses.

This is already consequential in the architecture. A dependency belongs to
an actual run; an admitted conceptual comparison belongs to a documentation
version; a federated import has a stated boundary. Local views need not share
one global interpretation simply because their records can be collected.

The same orientation motivates contextual variability on M. The project
wants to compare worlds or regimes and the practices they enable without
defining the collection of worlds as precisely those where its preferred
adjunction already works. The relative point of view supplies a method for
asking that question, not the missing base category.

#### Rising sea and the work of definitions

The rising-sea image names a preference for enriching the surrounding setting
until a problem becomes naturally tractable. Hoapa takes it as a working
discipline: when a construction repeatedly requires exceptional repairs, ask
whether the concepts or interfaces are inadequately chosen.

Its project-facing meaning is positive. A better setting should do more than
make one proof shorter: it should expose relations that make further work
possible. The right distinction between actors and content, or between
locality and resource-sensitive interaction, might make a whole family of
constructions natural instead of requiring separate clever solutions.

The method also informs the separation/integration mirror. Respecting
different responsibilities may make a common integrating setting possible;
finding that setting may reveal a missing distinction. The rising sea is the
activity moving between these moments, not simply a synonym for M.

Grothendieck's retrospective account in [*Récoltes et
Semailles*](https://web.ma.utexas.edu/users/slaoui/notes/recoltes_et_semailles.pdf)
is an inspiration rather than evidence that every difficult proof betrays a
bad interface. Technical work remains necessary. Since this method helped
shape Hoapa, recognizing it in Hoapa is not independent confirmation of the
architecture.

#### Universal properties, probes, and representability

A universal property characterizes an object by the maps or constructions it
supports. The project borrows this as both a way of understanding mathematical
objects and a target for methodological adequacy. It seeks a comparison
setting in which Hoapa-like organizations could be characterized by their
relations to contexts and admissible uses, rather than by an externally
assigned ranking.

The functor-of-points viewpoint gives a more concrete version of relational
understanding: specify the test objects and how an object appears to each of
them, coherently under changes of test. For Hoapa, documented local contexts
are possible probes. Participants are not automatically those mathematical
test objects, and a randomly selected panel supplies no density theorem.

Representability asks whether a specified family of observations or
interactions is organized by an object with a universal mapping property.
This is one precise way an essence/existence problem can become mathematics.
The hard work is defining the observations and their coherence independently
of the desired answer. The [Stacks Project's account of representable
functors](https://stacks.math.columbia.edu/tag/01JF) supplies a technical
reference; the Hoapa application remains to be constructed.

#### Descent and context-dependent availability

Descent is important because local availability and global availability are
different achievements. A construction may become possible after extending
a context, while its return to a smaller context requires compatible descent
data. Separating local work and its compatibility conditions can therefore
make integration precise.

Hoapa has checked scoped finite descent results. These do not identify human
assent with mathematical compatibility, nor guarantee that the views of an
actual conversation cover the whole relevant context. The philosophical use
is to ask what a legitimate integration requires and to preserve informative
failure when it does not occur.

The converse movement also matters. A relative geometric setting can make an
arithmetic distinction visible: two objects that acquire the same geometric
shape over an enlarged field can differ over the original base. Deligne's
[lecture on Grothendieck](https://www.carmin.tv/en/video/loeuvre-dalexandre-grothendieck-par-pierre-deligne)
motivated this comparison in the project. Integration here discloses a
distinction rather than erasing it.

#### The Esquisse: finite presentations and large systems of relations

The [*Esquisse d'un
Programme*](https://webusers.imj-prg.fr/~leila.schneps/grothendieckcircle/EsquisseFr.pdf)
provides the long-horizon attraction of finite combinatorial objects carrying
geometric and arithmetic structure, and of their organization across moduli
and gluing constructions. Hoapa is interested in how a small presentation can
retain more than a flattened summary of what it presents.

Two possible entrances have been explored. One starts with cyclic interaction
shapes and asks which further compositions would require modular or other
graphical structure. Another starts with finite covers and Galois
reconstruction. Their encounter with dessins is a research direction, not
already a theorem about K.

The proposed A₅ example belongs here as a finite test: trivalent ribbon
combinatorics can lead to the dodecahedral case and its symmetry. That does not
select A₅ as Hoapa's universal group, supply an evolutionary dynamics, or
prove the conjectural adjunction. More generally, a group acting by
automorphisms describes symmetry; its action is not by itself contextual
renewal.

#### Mathematical praxis

The project also takes seriously the conditions under which mathematics is
created, communicated, and made available to others. Its borrowing from
Grothendieck's creative testimony is not an instruction to imitate a heroic
individual. It asks how patient concept formation and reusable exposition can
be supported institutionally and technically.

This is where the relation to Hersh matters: individual creative experience
and socially sustained mathematical practice are connected concerns, neither
of which can replace the other.

### Lawvere

Lawvere supplies ways to make philosophical distinctions mathematically
operative. Hoapa is particularly interested in constructions that clarify what
a change of context permits, preserves, or makes inexpressible.

#### Logic as structured passage between contexts

Lawvere's [*Adjointness in
Foundations*](https://onlinelibrary.wiley.com/doi/pdf/10.1111/j.1746-8361.1969.tb01194.x)
is a principal source for treating logical operations through adjointness.
For example, existential and universal quantification can be understood as
adjoints to substitution in an appropriate setting.

Hoapa takes from this a view of logic as disciplined contextual transformation.
Borrowing assumptions, producing a construction, discharging dependencies,
and using the result elsewhere are related operations with laws—not merely
stages in a narrative. Their compatibility under context change becomes a
mathematical question.

This motivates the conjectural Allow/Require language, but does not determine
its functors. The familiar logical adjunctions are examples and resources.
They are not evidence that a particular world/practice correspondence is
representable in the required way. Conversely, logical structure can be
useful inside K without becoming the cross-side adjunction.

#### Internal languages and plural settings

The internal-language viewpoint makes a mathematical setting more than a
container of objects: it supports characteristic forms of reasoning.
For Hoapa, this gives substance to perspectivism without reducing it to
personal opinion. What can be expressed, decided, or transported depends on
the setting and the relevant maps.

The project is interested in how several settings can be compared while
retaining those differences. It does not infer that every context change is
lossless, that substitution must be conservative, or that ordinary dependent
type theory already constitutes evolutionary context generation.

One concrete portability candidate is geometric logic: the inverse-image
part of a geometric morphism preserves it. This is a specified preservation
result, not a demand that every useful mathematical statement be geometric.
Stronger operations may survive a narrower class of changes. Hoapa's question
is which preservation law a declared future use needs.

#### Relative cohesion and the freedom to choose the base

Lawvere's [*Axiomatic
Cohesion*](https://lawverearchives.com/wp-content/uploads/2025/01/2007-Axiomatic-cohesion.pdf)
studies cohesion relative to another setting, which need not be Set. His
examples include a Galois topos as a background of zero-dimensional spaces.
This makes relative cohesion a possible instrument for relating settings,
rather than only a structure imposed inside one fixed universe.

The project initially privileged a cohesive/modal route for M. That route was
retired as a prescription, not as a library of ideas. The checked diagnosis
of its flat signature was that every type became flat-modal: the proposed
modal fragment ceased to distinguish anything from the whole universe. This
was not a proof that cohesion is useless or that Boolean logic caused the
collapse.

The present borrowing is consequently more selective: ask which contrasts a
candidate must retain, and only then whether cohesion supplies them. A
multi-adjoint relation could be informative if its distinct passages interact
and model different tasks. Merely counting four functors does not establish
co-constitution.

#### Fixed points and the limits of self-description

Lawvere's fixed-point theorem is a resource for investigating self-reference
under explicit representability hypotheses. The project has used it to ask
about the relation between internal description and what exceeds a given
description.

An earlier aspiration contrasted fixed-point richness with creativity.
The useful surviving question is narrower: which formal closure is available,
and what does that closure fail to say about future development? A fixed
point is not automatically stagnation, and failure to possess one is not
automatically invention. Stable fragments may be essential to inheritance.

The same caution applies to diagonal arguments in the infinitesimal
discussion. Nilpotent multiplication and the structural permission to copy a
variable are different operations. No shortcut from one to the other has
been established for Hoapa.

Lawvere's intensive/extensive distinctions and the connection to Grassmann
are developed in their [transversal section](#intensive-and-extensive), where
their different uses can be compared without being conflated.

### Deleuze

Deleuze contributes an orientation toward genesis, multiplicity, and
non-final becoming. In Hoapa this is not a license to identify any repeated
process with evolution. It is a pressure on the project to explain how an
achieved organization can remain capable of encountering what it does not yet
organize.

#### Immanent problematics

Deleuze's reception of Lautman helps the project treat problems as active in
their realizations rather than as a finished external list of questions.
Hoapa follows this transformation when it lets an episode change the
problematic to which it responds.

A conversation may do more than select among initially available answers. It
may reveal that the distinction organizing the question was inadequate.
Documenting that shift is part of the achievement. The mathematical ambition
is then to represent changes in contexts, admissible operations, and
comparisons, not simply accumulate answers to an unchanged questionnaire.

This is an interpretive use of Deleuze, particularly *Difference and
Repetition*. It does not establish that every context possesses a formal
space of virtual problems or that Hoapa has constructed such a space.

#### Multiplicity and non-final organization

The project borrows an orientation in which differentiated relations need
not be subordinated to one privileged identity or final standpoint.
Operationally, that becomes a commitment to equal participant standing and
to documented contexts that can be challenged, translated, and revised.

This does not require eliminating identities and types. Hoapa needs stable
references, explicit concepts, and checkable interfaces. The proposed
Deleuzian transformation is to make those determinations usable without
granting them final authority over all possible future articulation.

The distinction is important for perspectivism. Several perspectives need
not be mutually interchangeable, equally adequate for every use, or ultimately
merged. The project seeks accountable relations among them rather than a
declaration that every perspective is equivalent.

#### The third synthesis and the independence of achievements

The miscellaneous notes read Deleuze's third synthesis of time as a resource
for thinking a product's independence from its condition and author. Hoapa
takes this as a philosophical resonance, not a theorem or an independently
confirmed engineering requirement.

Its concrete question is whether an achievement can remain usable after its
producer becomes unavailable. A document whose every use requires renewed
permission from its originating institution differs from one that carries
the interfaces and dependencies needed for independent use. Independence
here does not mean having no history, support, or material conditions.

This also suggests a criterion for institutional success: sometimes an
organization succeeds by making its continued mediation unnecessary. Its
products may support successors rather than bind all later activity to
itself. This interpretation connects Deleuze to Care and to the project's
publication-as-accessibility discipline.

#### Pre-philosophical orientation

The latest infinity/infinitesimal discussion asks for a compact orientation
from which the project's more precise distinctions could emerge. Deleuze and
Guattari's vocabulary of a pre-philosophical plane is an inspiration for that
request, not a claim that philosophy can start without any commitments.

The proposed orientation is relational determination: a difference can gain
efficacy through relations without being dissolved into them. On that reading,
the mirror is not added as a decorative analogy after the mathematics; it is
one of the problems the mathematics is being asked to make effective.
This remains an opening, described below rather than installed as a new
foundation.

### Peirce

Peirce connects the project's concern with organized inquiry to its concern
with a language through which understanding can travel. He supplies neither
a ready-made social protocol nor a finished universal notation. His concepts
help ask what makes signs, diagrams, and communities capable of inquiry.

#### Community of inquiry and fallibility

Hoapa borrows the orientation toward inquiry as a communal, corrigible
activity whose claims are answerable beyond the authority of an isolated
knower. This gives the community a constitutive role in the production and
testing of understanding, rather than treating it as a delivery mechanism
for truths privately possessed by its members.

The transformation is institutional and computational: explicit conversation
rules, differentiated documentary products, retained failure, and later
challenge or uptake. A present panel does not speak for the final community
of inquiry. Its result has standing within an open process, not because it
has reached an ultimate social consensus.

The project therefore separates acceptance under a conversation's declared
rules from mathematical validity, empirical truth, and eventual convergence.
Peirce motivates the long horizon of corrigibility; he does not provide a
convergence proof for Hoapa.

#### Pragmatic clarification

Peirce's [*How to Make Our Ideas
Clear*](https://www.marxists.org/reference/subject/philosophy/works/us/peirce.htm)
links clarification to conceivable practical consequences and habits of
action. Hoapa takes from this a demand that a concept make intelligible what
can be done, inferred, distinguished, or tested with it.

This is stronger than replacing specialized words by simpler synonyms. A
technical language becomes accessible when people can learn the operations
and consequences its distinctions support. It is also broader than immediate
utility: an abstract construction can clarify a future possibility without
serving a currently profitable task.

The project-facing transformation is purpose-relative adequacy. A returned
artifact should state what it supports and under which conditions. Identical
answers to today's questions need not imply equal suitability for tomorrow's
operations.

#### Diagrammatic reasoning

Peirce's [account of diagrammatic
reasoning](https://www.jfsowa.com/peirce/ms514.htm) gives the project a model of
construction, experiment, and generalization. A diagram can be manipulated
under rules so that consequences not obvious in its initial statement become
available.

Hoapa recognizes a borrow–work–return–replay pattern here: work in a specified
presentation, establish what follows, and make the achievement usable beyond
that one construction. The distinction between a particular artifact and an
instantiable rule is especially important. A diagram is not merely a picture
of a conclusion already understood.

Peirce's existential graphs are a source for reasoning through relations,
not a notation the project has selected. Nor does this borrowing identify
his purpose with Leibniz's universal characteristic. Their contributions meet
in the language investigation without becoming one historical programme.

#### Sign, interpretant, and habit

The project uses the sign–object–interpretant relation to resist treating
documentation as a store of meanings independent of interpretation. An
artifact becomes operative through further interpretation, which may itself
be expressed and reused.

This gives a philosophical reading to the movement from document to context.
A settled way of understanding or acting with a sign can become a resource
for subsequent inquiry. But a habit can also become an unnoticed constraint.
The reflexive ambition of Hoapa is to make its own documentary and procedural
forms available for examination rather than exempt them from inquiry.

Peircean habit, Simondonian uptake, and a formal interpretation map are not
synonyms. They pose related questions at different levels: how a sign works,
what an encounter transforms, and what a specified semantics preserves.

Peirce's agape is treated with Bowlby's attachment in the transversal
[Care section](#care-openness-and-non-extraction).

### Bowlby

#### The secure base as a condition of exploration

Bowlby's account of attachment supplies an important source for thinking
support and exploration together. The project borrows the secure-base
orientation: continuity of support can enable departure, investigation, and
return rather than demand permanent dependence. See [*A Secure
Base*](https://www.routledge.com/A-Secure-Base/Bowlby/p/book/9780415355278).

Hoapa transforms this into a broader image of network continuity. Mature
participants or organizations support new activity; those supported may in
turn become capable of supporting others. The README calls this an algorithm
for continuity. That is Hoapa's generalization of an attachment-inspired
pattern, not a claim that Bowlby supplied an algorithm for arbitrary networks.

The architectural point is that supporting someone need not mean assigning
their function or owning the outcomes of their development. Accessible
documentation, pedagogical effort, and the possibility of independent reuse
are candidate forms of support. None is sufficient by itself to establish
Care.

#### Role reversibility without identical roles

The caregiver/cared-for image motivates reciprocal structure. A participant
may receive support in one encounter and provide it in another. The roles can
be related without being identical within an episode.

Session duality is the project's checked syntactic proxy for reciprocity;
the care-handoff interpretation of richer composition remains to be earned.
An involution does not show that support is adequate or non-extractive.
Conversely, asymmetric assistance does not require a permanent hierarchy of
persons. Keeping those distinctions is part of Hoapa's transformation of the
attachment image.

### Hersh and Zalamea

These are different contributions, grouped here as important mediations rather
than as a shared philosophy.

#### Hersh: the social existence of mathematical practice

Hersh's *What Is Mathematics, Really?* is the project's social counterpart to
Grothendieck's creative testimony. His [own account of mathematics as a
human, social, and historical activity](https://edge.org/conversation/reuben_hersh-what-kind-of-thing-is-a-number)
helps move the foundational question toward the conditions under which
mathematical understanding is produced and sustained.

Hoapa does not infer that a proof is valid because a community accepts it.
It distinguishes the network of justification from the network of enablement:
languages, education, tools, archives, and cooperative work make reasoning
available, while particular mathematical claims still require their proper
justification.

The transformation is to make collective praxis a co-equal concern of the
mathematical programme. A foundation that explains what counts as a proof
does not, by itself, explain how an open community should organize the work
that produces, understands, and reuses proofs.

#### Zalamea: transit, saturation, and liberation

The project receives part of Lautman and Grothendieck through Zalamea's
synthetic philosophy of contemporary mathematics. It takes particular
interest in transit between domains and in the rhythm of enriching a setting
until a construction or invariant can be released for other uses.

This mediation matters to attribution. The saturation/liberation vocabulary
in Hoapa should not be presented as simply Lautman's own two-word doctrine.
The project uses it through a layered reception and develops it toward public,
typed, reusable achievements. Its detailed project meaning is given in the
[transversal section](#saturation-liberation-and-open-ended-development).

Zalamea is an interpretive source, not a substitute for the mathematical
hypotheses of an individual theorem. Corfield's immanent reading of Lautman
and Petitot's exposition of intermediate structures are other mediations
recorded by the project; their distinct contributions should remain visible
when particular arguments rely on them.

## Part II: transversal problems

These sections are about encounters, not common denominators. A shared word
does not establish a shared concept; a useful borrowing may preserve a
disagreement. Each crossing asks what the different contributions let Hoapa
see or attempt that it could not obtain by simply choosing one author's
vocabulary.

### Intensive and extensive

The shared project question is how differentiated potentials, activities, or
relations acquire articulated forms—and how those forms remain capable of
further development. The authors do not give the same answer or even divide
the question along the same axes.

#### Grassmann: how a magnitude is generated

Grassmann enters through the discussion of Lawvere's Como lectures. The
project's received reading distinguishes modes of generation, particularly
the role of equal and different elements in generating intensive and
extensive magnitudes. The interest is not a ready-made assignment of an
agent to one side and a concept to the other. It is the possibility that
the organization of generation differs from the organization of its result.

This offers a useful contrast with Lautman. Asking how a being is decomposed
and asking how it is generated are related but different questions. A process
may be expressed through a uniform rule while yielding differentiated
constituents; conversely, very different contributions may participate in a
common mode of articulation.

The conversation's image of a ninety-degree relation names this crossing of
questions. It is not an established rotation, duality, or adjunction between
two formal structures. Precise attributions about Grassmann's generative
table still require an edition-specific reading of the *Ausdehnungslehre*;
the project should not treat an external agent's reconstruction of the
lectures as a checked transcription.

#### Lawvere: quantities and variance

One Lawverean distinction concerns how quantities transform: intensive
quantities pull back, while extensive quantities push forward in suitable
settings. For finite sets, a map f : X → Y gives a simple example. Amounts on
X can be summed over fibres to produce amounts on Y; a test on Y can be
pulled back to X. Their pairing satisfies:

```text
⟨f_* μ, φ⟩ = ⟨μ, f* φ⟩.
```

This is a precise compatibility between transporting amounts and transporting
tests. See [Lawvere's collected messages on the
terminology](https://lawverearchives.com/wp-content/uploads/2025/02/Bills_messages_to_the_categories_list.pdf).

Hoapa takes the example as a model of mutually appropriate operations, not a
formula identifying K with amounts and M with tests. Its value is to show
how different responsibilities can meet in a law. Any application must say
what is being transported and which observations the pairing expresses.

#### Lawvere: qualities, pieces, and points

In *Axiomatic Cohesion*, extensive and intensive qualities are another pair.
An extensive quality preserves the relevant pieces; an intensive quality
preserves the relevant points, with additional categorical requirements.
Lawvere's form/substance terminology belongs to this setting. These are not
simply the preceding covariant/contravariant quantities renamed.

For Hoapa, the attraction is that partial views of one organization can
retain different structural features. What is preserved is given by the
construction, rather than by a vague claim that one side is global and the
other local. This provides possible resources for the M rebuild and for
thinking about how local variation and global organization interact.

It does not establish that documentation is extensive, people intensive, or
one side of the conjecture entirely constituted by either quality. The
distinction must be attached to the actual comparison under investigation.

#### Deleuze: intensity and the genesis of articulated forms

In the project's reading of *Difference and Repetition*, intensive
differences participate in actualization into qualities and extensities.
Intensity is not simply a synonym for an unformed virtual stock.

Hoapa takes the question forward: when a problematic becomes an organized
conceptual form, what happens to the capacity for further discovery? A useful
classification can disclose relations, but it can also become a filter
through which unanticipated distinctions cease to register.

The proposed developmental test is not to maximize difference. Solving a
problem may legitimately remove an uncertainty or incompatibility.
The question is whether stabilization supports adequate further activity
or makes the current organization appear exhaustive. This is where Deleuze
meets Simondonian potentials and the project's concern with renewal.

#### Simondon: potentials are relative to a milieu

Simondon keeps the generative question relational. A document is not an
intrinsically intensive object waiting to release a fixed amount of novelty.
Its encounter with a receiving problematic may be informative, inert, or
obstructive. What becomes possible depends on the organization of that
encounter.

This is why Hoapa's potential future comparison structure should concern
world–practice relations, not rank artifacts by a universal amount of
creativity. The milieu and the declared continuations belong in the account.

#### Bergson: a productive dissent

Bergson challenges the assimilation of qualitative differences to measurable
intensive magnitudes in chapter I of *Time and Free Will*. Chapter II's
discussion of duration and melody gives another way to question the
replacement of unfolding experience by separately counted positions.
[Chapter I](https://brocku.ca/MeadProject/Bergson/Bergson_1910/Bergson_1910_01.html),
[chapter II](https://brocku.ca/MeadProject/Bergson/Bergson_1910/Bergson_1910_02.html).

For Hoapa, Bergson's role is not to supply another interchangeable definition
of intensity. He asks whether the proposed decomposition has changed its
subject. Does a documentary structure preserve what makes a process
intelligible, or merely replace it with a sequence of snapshots?

This does not forbid discrete records. It requires an interpretation of what
those records retain and what they cannot claim to reconstruct. That is a
particularly useful pressure on any proposed account of replay.

#### Music as an exploratory meeting place

Music is being investigated as a concrete organization in which such
problems become effective, rather than primarily as a social phenomenon.
Differentiated events can participate in an unfolding unity that changes
their roles. A line may remain recognizable while its relations to other
lines alter what it does.

The Lautmanian application is Hoapa's proposal, not a theory of music
attributed to Lautman. Deleuze's [1978 musical
lecture](https://www.webdeleuze.com/textes/113) is a direct source for asking
how musical material makes forces perceptible. Bergson supplies the duration
question; Simondon supplies an individuation-with-milieu question. A
specifically Lawverean musical realization remains open.

This investigation also informed the universal-language question: can a rich
expressive capacity acquire reusable articulations without being reduced to
arbitrary labels? Deutsch, Henthorn, and Lapidis's [speech-to-song
experiment](https://deutsch.ucsd.edu/pdf/JASA-2011_129_2245-2252.pdf) concerns
changed perception of repeated speech. It is not evidence that speech is
literally degenerate music or proof of a musical origin of language.

#### Identification is a different axis

Intensional/extensional distinctions concern, in relevant settings, what
counts as the same construction, procedure, or behaviour. The
intensive/extensive investigations concern modes of quantity, composition,
variation, or genesis. Their interaction is useful precisely because they
are not the same distinction.

Hoapa needs at least three separate permissions: what may be consumed or
copied; what depends on what; and what may be treated as equivalent with a
specified witness. Resource-sensitive interaction, directed documentary
dependence, and admitted conceptual identification answer those different
questions. They are not a ladder from a weaker logic to an increasingly
complete one.

### Separation and integration: the reciprocal mirror

The mirror is a project synthesis, not an idea owned by one author. Its
organizing intuition is that respecting distinct responsibilities can enable
integration, and that a richer integrating structure can disclose further
distinctions. The separation between reality and its understanding is an
interface: it distinguishes them and makes accountable relations possible.

#### Lautman: distinguishing the questions

Lautman's two decompositions help prevent the project from treating every
decomposition as a fragmentation or every integration as a return to an
undifferentiated whole. Particular constituents and a common plan can condition
one another. The question is what is decomposed, in which domain, and with
what resulting possibilities.

The project extends this into a theorem-shaping discipline: analytic adequacy,
synthetic invariance, and their compatibility. A trace must adequately
articulate the work it claims to represent; a construction should not depend
on an irrelevant presentation choice; and these two achievements must work
together. Separate successes do not automatically form one adequate system.

#### Grothendieck: two directions made concrete

Descent illustrates separation enabling integration: distinguish local data
and overlap compatibility, then ask whether a global object is reconstructed.
The relative viewpoint also illustrates integration revealing separation.

For example, the algebras ℚ[t]/(t² − 2) and ℚ[t]/(t² − 1) both become the
same two-point geometric shape over an algebraic closure of ℚ. Over ℚ, one
is a field and the other a product of fields. Their geometric agreement does
not erase their different arithmetic availability. The common relative
framework makes that difference precise.

The project's Riemann–Roch example gives another crossing. A nonzero simple
principal part at one point can be prescribed locally on either a projective
line or a smooth projective genus-one curve. A meromorphic function with that
as its only pole exists on the projective line but not on the genus-one
curve. Global organization distinguishes locally similar prescriptions.
This is established mathematics used as a comparison, not a new Hoapa result.
See [Riemann–Roch](https://stacks.math.columbia.edu/tag/0B5B).

#### Lawvere: laws of passage rather than verbal symmetry

Adjunctions and change-of-base laws suggest how a proposed mirror could become
more than a pairing of descriptions. One must define the constructions and
the comparison maps, then ask whether the relevant diagrams commute or
universal properties hold.

The speculative architecture in which K offers both documentary presentations
and organized operations is one attempt to make this precise. A contextual
setting could relate a realization/nerve pair to a free/underlying pair.
Their directions and their reconstruction comparisons need not coincide.
This is a candidate architecture, not four adopted Hoapa functors.

The project is interested in whether this interaction could induce
"secondary" distinctions or integrations. Secondary means induced in that
investigation, not less important or necessarily later in time. No such
induction follows from an unspecified adjunction alone.

#### Simondon: integration sustains the difference it relates

The individual–milieu relation adds a third useful formulation: integration
can sustain separation. A local activity need not reproduce its entire
enabling world, because its relations to other activities can maintain what
it omits.

This explains why separation of concerns is not indifference to context.
The omission is legitimate only through an adequate interface and supporting
organization. Conversely, integration obtained by erasing relevant
disagreement is not automatically a success. Sometimes the achievement is a
faithful shared record of incompatibility.

#### Induced distinctions inside documentation

The equality discussion offered one candidate. Definitional equality belongs
to a type theory's judgmental machinery; propositional identity supplies
witnessed identifications. This can inspire a documentary distinction between
what a checker settles under fixed rules and which comparisons the system
must explicitly represent and carry.

That is not a direct correspondence between unityped agents and definitional
equality. Distinct actors are not definitionally the same. Nor is a Boolean
validator literally judgmental equality: a decidable predicate can itself
have propositional specifications and witnesses. The useful question is which
identifications are automatic in a selected formal presentation and which
must remain accountable documentary claims.

Other examples include truncation versus retaining structured evidence,
particular witness packages versus uniformly instantiable rules, and binding
that lets names be locally chosen while respecting substitution. These are
candidate induced disciplines within documentation, not an inventory of new
architectural layers already built.

<a id="borrow-work-return-replay"></a>

### Borrow–work–return–replay

BWR is Hoapa's own organizing synthesis. Its sources help explain different
aspects of it; no single source is claimed to have already stated the whole
pattern at all its intended scales.

#### Gentzen and Prawitz: making a construction usable

Natural deduction supplies the familiar passage from work under assumptions
to a result whose dependencies are discharged in a rule-like form, and from
that form to later application. Introduction and elimination, substitution,
and cut provide precise logical operations against which the broader image
can be tested.

Hoapa borrows the organization, not a literal equation between every return
and implication introduction. An episode can return a particular artifact,
a general rule, evidence of an obstruction, or a changed specification.
Those achievements have different conditions of reuse.

The distinction between dependent Σ and Π gives one mathematical resource:
packaging a witness with its data is different from supplying outputs
uniformly over inputs. The project's reflexive layer happens to use the
label Π, but that name does not establish a dependent-product semantics for
the layer.

#### Girard and the concurrency tradition: work has permissions

Linear logic and session-type traditions contribute resource-sensitive
interaction. Hewitt's actor tradition contributes autonomous, communicating
participants; the session/concurrency literature contributes typed protocols
and composition disciplines. These are technical companions to the
philosophical anchors, not interchangeable versions of BWR.

Hoapa's orchestration cannot assume that interaction can be freely copied,
discarded, reordered, or replayed merely because a digital record exists.
The cartesian/linear distinction therefore gets an explicit adapter rather
than an identification. The concept layer adds different concerns: directed
dependencies and warranted equivalences. Richer identification does not
eliminate the need to account for resource use.

The practical motivation includes human effort and situated interaction,
but linearity is not deduced from biology or from an assertion that digital
computation is physically free.

#### Grothendieck and Lawvere: borrowed presentations and contextual return

Galoisian replay is a mathematical example of the project-facing movement.
For a separable quadratic t² + a t + b over a field k of characteristic
different from two, borrow a splitting field and names r₁, r₂. Their
difference depends on the ordering, while (r₁ − r₂)² = a² − 4b belongs to k.
The richer presentation allows work with choices; the invariant can be
returned without those choices.

Descent, adjunctive return, and replay remain different. Descent asks whether
borrowed choices can be eliminated coherently and can fail. An adjunctive
transpose exists once the adjunction exists. Later use of either returned
construction requires its own context and purpose. Deriving a rule uniformly
in the coefficients is another achievement beyond one calculation.

The example helps Hoapa state a demand on documentation: retain enough of a
construction's conditions that someone else can use it without reproducing
all of its discovery. It does not require reproducing the producer's identity
or the whole originating episode.

#### Kauffman: work that helps make further work possible

Kauffman contributes the question of organized work producing or maintaining
its own enabling conditions, and of biological development opening an
adjacent possible. Hoapa reads this as a challenge to accounts of development
that merely repeat transformations in a fixed inventory of possibilities.

The borrowing sharpens the difference between a reusable output and a
self-supporting organization of reuse. One artifact helping another activity
does not yet show that the broader practice can continue. Libraries,
maintenance, teaching, protocols, and accessible records may all be part of
the enabling organization of inquiry.

Kauffman's arguments against a fully prestated evolutionary phase space are
retained as philosophical and scientific claims to investigate, not as
theorems against functors. A functor does not predict which historical event
will occur. Likewise, a space need not be empirically surveyed point by point
for an optimum to be proved. Hoapa's universal-property ambition needs its own
justification, not a supposed deduction from non-ergodicity.

The lecture passage that originally prompted this exchange was not
transcribed reliably. The account here relies on Kauffman's published
*Investigations* and *A World Beyond Physics*, together with the explicitly
identified closure literature, not on a reconstructed quotation from that
lecture.

#### Montévil–Mossio and Kauffman: three closure questions

Montévil and Mossio's [closure of
constraints](https://montevil.org/publications/articles/2015-mm-organisation-closure-constraints/)
concerns mutually dependent maintenance of constraints acting on processes
at relevant timescales. Organizational closure does not mean thermodynamic
isolation. This supplies Hoapa with a question about how the conditions of
work are maintained by other work.

The project distinguishes three borrowed questions:

- **Constraint closure:** what maintains the conditions that make an activity
  possible?
- **Work-task closure:** how do activities produce or repair means needed by
  further activities?
- **Autocatalytic closure:** how can a network of reactions supply catalysts
  for its reactions while remaining generated from environmental inputs?

The third has specific mathematical developments in RAF theory; its
food-generation requirement prevents closure from meaning self-sufficiency.
See [Hordijk and Steel's review](https://arxiv.org/abs/1307.2860).
The three-part inventory is the project's comparison of the discussions,
not a claim that every Kauffman text uses the same taxonomy or that it is an
established necessary-and-sufficient definition of life.

For Hoapa, these become questions about the organization around replay.
A proof does not need to reconstruct the implication-elimination rule before
using it; mathematical practice nevertheless sustains the languages, skills,
records, and tools that make such use possible. Feedback in that enabling
network does not license circular justification inside a proof.

The analogy must not turn people into organs with assigned functions.
Nor does self-maintenance establish goodness: an exploitative organization
can maintain itself. Adequacy has to specify whose capabilities and which
boundaries are respected.

#### Simondon: uptake can transform the problematic

Simondon contributes what maintenance alone leaves open. Later uptake can
change the receiving context, not simply feed another cycle of the same
organization. A concept may become a shared coordinate for understanding
that was previously difficult to formulate.

This is where replay could become contextual renewal. It requires a
demonstrated new capability, not just another iteration. Conversely,
maintenance, consolidation, and repair are not failed renewal; they may be
its enabling conditions.

#### The project's added requirement: accessibility without capture

Hoapa uses publication to mean making work accessible, not advertising it or
pushing it toward selected consumers. The intention includes free access,
pedagogical effort, and multiple interfaces suited to different paths of
understanding. It does not mean one identical presentation for everyone.

The sought symmetry is equal opportunity for consumer-initiated access, not
equal forced exposure. A mathematical arrow from an operational record to a
public artifact represents a transformation of records; it is not an act of
sending that artifact to a person. Later uptake remains a distinct action.

Independent usability is particularly important: an achievement should not
require the producer's continuing permission merely to be used. This does
not erase provenance, material dependencies, or the need to learn. It asks
that those requirements be expressed in the artifact's interface rather
than retained as discretionary authority over each future encounter.

### Universal technical language

The project seeks reusable forms of understanding, not a final encyclopedia
or a language capable of deciding every meaningful question. Its motivating
image is a large conceptual landscape organized into recognizable islands,
so that learning an important pattern once supports use across domains.

#### Leibniz: conceptual expression that supports reasoning

Leibniz's universal characteristic supplies the ambition that expression
should participate in reasoning rather than merely label its results.
Hoapa retains that ambition while leaving open the forms of its realization.
See the [fragments on a universal
characteristic](https://www.ratiocination.org/Courses/phil3505/wp-content/uploads/2017/08/Leibniz__Preface-to-a-Universal-Characteristic-and-other-fragments-on-logic.pdf).

The project does not adopt a final alphabet of primitive concepts or a
universal decision procedure. A reusable construction may have several
presentations and retain internal symmetry. It may also need to be revised
when a new context makes an overlooked distinction relevant.

Leibnizian perspectivism is a further philosophical neighbour, but the
protocol does not borrow pre-established harmony as a coordination
mechanism. Hoapa's causal dependencies must come from actual interactions,
not a universal clock or an assumed synchronization of private worlds.

#### Peirce: intelligible consequences and active interpretation

Peirce adds a different demand: what can someone understand and do through
this expression? A universal technical language must support warranted
passages between perspectives and intelligible operations, not simply
recognition of a common symbol.

This keeps the language tied to inquiry. A concept whose permitted uses can
be explored and tested is different from a compulsory vocabulary imposed by
a central authority. Translation and disagreement are part of the language's
development rather than defects to remove in advance.

#### Grothendieck: retaining the maps, not only the islands

The categorical contribution is to make relations and comparison witnesses
part of what is represented. In the candidate content layer, called Λ,
dependencies remain directed. Only explicitly admitted comparisons in a
particular documentation version may be treated as invertible.

The groupoidal image therefore has limits. Connected concepts are not
automatically equivalent; equivalent presentations need not have unique
comparison witnesses; and a connected groupoid need not be contractible.
Compressing everything to connected components can discard exactly the
symmetry or ambiguity another use needs.

A version should retain its directed presentation and its set of admitted
comparisons, with a localization built from them when appropriate. The
localization is not a replacement for the history: a later withdrawal must
remain expressible without pretending to undo an inversion inside an
unchanged mathematical object.

#### Lawvere: presentation shapes and contextual interpretation

Generating families and internal languages offer a possible route to
reusable vocabulary. A family of probes in a contextual category can induce
a documentary description of how objects appear to those probes.
This supplies one candidate direction of the mirror: contextual structure
induces distinctions in K's language.

But a generating object is not automatically a word, an atomic object is
not automatically a generator, and decidable equality is not a universal
criterion of conceptual relevance. The project distinguishes a Heyting
setting, where some identifications may be undecidable, from Boolean
Galois-type settings, where an object can have decidable equality yet no
invariantly selectable global element.

The linguistic question is what a chosen presentation makes available,
what its symmetries retain, and what interpretations are possible elsewhere.
The selection of the probes is a substantive commitment about what can be
expressed, not a neutral preliminary.

#### What Hoapa adds to these ambitions

The proposed language is produced and maintained through collective work.
Its definitions, translations, comparisons, and withdrawals must have
accountable histories. Its accessibility includes different explanatory
interfaces. No institution is presumed to own the final quotient of all
knowledge.

This combines two achievements that must not be confused: recognizing
witnessed equivalences and learning reusable patterns among things that are
not equivalent. Universal properties can help characterize the latter
patterns; purpose-relative comparisons govern the former. Human usability
across perspectives remains an additional question, not a corollary of
categorical universality.

### Care, openness, and non-extraction

Care is a transversal normative ambition. Its source concepts do not all
name the same operation, and its checked mathematical proxies do not yet
establish the intended developmental adequacy.

#### Peirce: agape and the development of what differs

Peirce's [*Evolutionary
Love*](https://www.cspeirce.com/menu/library/bycsp/evolove/evolove.htm) supplies
the agapic orientation toward growth through creative relation, rather than
reducing development to necessity or chance. Hoapa borrows it as a way to
ask how inquiry can support the emergence of capacities beyond its currently
recognized achievements.

This is not a proof that every act of cooperation is agape or that love has
been formalized as an adjunction. The practical question is whether a
community's organization makes room for others' understanding and
continuation without defining their value by their usefulness to that
organization.

#### Bowlby: support that enables departure

Attachment contributes the secure-base image already described: support can
enable exploration rather than indefinite dependence. Hoapa extends this
toward reciprocal network continuity and succession.

The distinction between role and person is essential. A person receiving
help is not assigned a permanent dependent type, and a person providing it
does not acquire superior formal standing. The asymmetry of an episode can
coexist with equal standing and possible changes of role.

#### Simondon and Kauffman: the enabling milieu matters

These sources make it inadequate to assess an output in isolation from the
conditions of further activity. A successful local result can impoverish
its wider milieu. Conversely, maintaining conditions that do not immediately
yield a novel artifact may be indispensable work.

The project contemplates interventions that change the conditions of
integration: another interface, a mediating object, a refined contextual
description, or a different organization of available views. Such changes
can be caring only relative to what they enable and preserve. Forcing
compatibility by deleting the evidence of disagreement is a different
operation.

#### Permaculture: non-collapsing use of context

Permaculture is an important practical anchor not reducible to one of the
named authors. Hoapa borrows the image of working with a place's relations
so that activity sustains or improves its conditions of continuation.
The project generalizes this beyond agriculture as a question about
non-extractive inquiry.

The transformation is not a universal ecological fitness function. A use must
declare what it relies on, whose possibilities it changes, and what it leaves
available. More novelty, more difference, or more circulation is not by
itself better. The seed–tree–seeds image matters because the resulting milieu
is changed, not because it pays back an unchanged original loan.

#### The formal proxy and the open normative work

The project has an involutive session duality: applying the dual twice
recovers the original type, at the checked scope. This is a precise
reciprocity structure. It is not a theorem about love, consent, non-extraction,
or the viability of a community.

Further Care candidates include conditions on admissible episodes and
replays, and interventions on the conditions under which integration is
possible. They are not competing established definitions. Their compatibility
with the reciprocal proxy remains a question.

The reality/understanding boundary is important here. A representation cannot
declare itself caring simply by omitting what its use damages. At the same
time, accountability must not demand exhaustive records of participants'
identities or inner lives. The unresolved task is to make consequences
answerable without converting persons into inspectable resources.

### Saturation, liberation, and open-ended development

This crossing gathers the project's dynamic vocabulary without treating
every form of closure as the same operation.

#### Lautman through Zalamea: enrichment and release

In Hoapa's reception, saturation names enriching a setting with enough
relations or structure to articulate a problem. Liberation names the
release of a construction, invariant, or interface that can travel beyond
the circumstances in which it was found.

The movement can be small: a particular derivation becomes an independently
usable lemma. Or it can reorganize the context: several constructions
disclose a new common language. What travels need not carry every detail of
its discovery, but it must retain what its declared uses require.

This is a working interpretation of a philosophical rhythm. It is distinct
from the project's exact causal-saturation predicate, which concerns whether
relations between events in a conversation are generated internally to that
conversation. A shared word does not make the mathematical predicate a
formalization of the entire philosophical idea.

#### Hegel: preservation through transformation, without final totalization

The project's motivation uses Aufhebung to name a movement in which an
achieved language or context is preserved and transformed within a further
one. It also invokes the concrete universal as an orientation toward
generality realized through articulated relations rather than an empty
common label.

Hoapa's use is selective. It does not adopt the whole Hegelian system or
promise an Absolute in which all perspectives finally coincide. The
recorded synthesis takes the transformation motif while keeping the process
open to further contexts and distinctions.

This matters for inheritance: preservation is not conservation of every
presentation, and transformation is not permission to rewrite away earlier
evidence. New documentary versions can change admissions while retaining
the history of what was previously claimed.

#### Deleuze: a result must not become the final measure of possibility

Deleuze pressures the synthesis against treating stabilization as completion
of becoming. Hoapa's interpretation is that an achieved organization should
not mistake its current expressive capacities for the limits of what can
matter.

This does not turn resolution into sterility. Proving a theorem removes an
open question; maintaining a reliable interface can be a success. The
developmental concern is whether later inquiry can encounter and work with
distinctions that the achievement does not yet express.

#### What this means for specialness

The desired comparison concerns how organizations articulate contexts,
support adequate reuse, and enable further inquiry. A universal property
could characterize a distinguished organization of those relations.
Alternatives must remain meaningful alternatives, including ones that do
some jobs better.

Neither a free construction nor an idempotent closure proves that an
architecture is the optimal scientific method. Nor must every inherited
fragment keep changing. Reliable local completion and open-ended contextual
development may coexist.

The philosophical rhythm helps specify what matters in the comparison. It
does not yet provide a ranking, a selector, or a theorem. Conversely, a
universal-property characterization would not automatically owe the project
an algorithm selecting its distinguished object from every imaginable
architecture.

### Infinity, infinitesimality, and continuation

This is the newest and least settled borrowing cluster. Its purpose is to
retain a pre-philosophical orientation that can generate questions, not to
report a discovered infinity/infinitesimal duality.

The instigator asks whether an inexhaustible context and an incipient
determination stand in complementary relations to organized activity. The
proposed pair is not simply largest and smallest magnitude:

```text
Absolute pole: no achieved determination exhausts it.
Infinitesimal pole: an incipient determination whose efficacy needs continuation.
```

The origin proposed for both is presuppositionlessness. The version explored
most productively refuses an ultimately authoritative enclosing boundary
and an ultimately finished elementary decomposition. It permits boundaries
to arise as interfaces through activity. It does not entail the physical
nonexistence of atoms or identify mathematical infinitesimals with a hidden
region below the Planck scale.

#### Spinoza: immanence and conatus

Spinoza offers a way to locate finite activity within Nature without an
external creator assigning its ends. His account of conatus and his rejection
of final causes provide two constraints on Hoapa's interpretation. The
striving belongs to situated modes; it is not a need of an incomplete
substance demanding repayment. [*Ethics*, Part I, Appendix; Part III,
propositions 6–7](https://www.gutenberg.org/files/3800/3800-h/3800-h.htm).

Hoapa's proposed transformation is to ask whether adequate finite striving
must participate in sustaining conditions beyond itself. Borrow–work–return–
replay could describe such participation. That conclusion is not deduced
from conatus, and it should not be attributed to Spinoza as his own contract
between infinity and its inhabitants.

The related unityping intuition is also a transformation, not a theorem
from Spinozist ontology to software architecture. An immanent, non-ranked
field of participation can motivate equal formal standing without requiring
that all participants be identical or contribute equally.

#### Deleuze: a generative orientation rather than an ultimate foundation

The pre-philosophical ambition is to make the project's many questions belong
together. The proposed orientation is that determinate differences become
effective through relations, while no finished organization exhausts the
possibilities of those relations.

This is deliberately stronger than an isolated information-retention test,
but weaker than a demonstrated metaphysical law. It gives the mathematics a
problem to make precise rather than prescribing its answer in advance.

#### Lawvere and infinitesimal mathematics: a possible realization

An infinitesimal probe can encode a local variation without being a tiny
ordinary object. Square-zero algebra, for instance, distinguishes first-order
permission from higher-order extension. In a constrained example x² = 0,
x = vt is admissible modulo t², while extension to order t³ over a field
forces v = 0. A nonzero first-order direction is therefore obstructed.
See the [Stacks Project's tangent-space
construction](https://stacks.math.columbia.edu/tag/0B28).

That is a useful possible model of realization, not a definition of every
nascent distinction. Nilpotence concerns multiplication; it does not forbid
copying or say that time destroys a variation. Synthetic differential
geometry itself normally has cartesian diagonals. Its relevant restrictions
on excluded middle arise from its full axiom package, not from nilpotents
alone. [Kock, *Synthetic Differential Geometry*, I.1](https://users-math.au.dk/kock/sdg99.pdf).

Other mathematical leads include tininess, transport and path comparison,
and pairing-based reconstruction. They answer different questions. None has
yet been selected as the mechanism of the proposed philosophical duality.

#### Simondon and Kauffman: continuation through relations

The latest synthesis asks how a nascent activity participates in maintaining
its own conditions of continuation. This candidate proto-conatus need not
attribute intention to an infinitesimal or make it self-sufficient.
Local organizational closure can coexist with dependence on an open milieu.

Three questions remain distinct: can a difference register; can it acquire
an admissible realization; and can that realization support further activity?
Their compatibility is the research subject. An obstructed realization may
still yield an excellent return if the obstruction becomes usable knowledge.

The proposed mirror then has three movements: separation enables integration;
integration sustains differentiated activity; and integration reveals further
distinctions. These are hypotheses about organized development, not a
deduction from zero versus one boundary.

#### The consequence for replay

An organization can become excellent at preserving its existing achievements
while becoming less able to recognize what those achievements do not express.
The arc makes that failure more explicit. It asks for reliable inheritance
without presenting an achieved language as the final horizon of inquiry.

Exhaustive future preservation is not the answer. If a public representation
identifies two situations, a later observation distinguishing them cannot
be recovered from that representation alone. Forgetting and privacy make
such limits unavoidable. Adequacy must combine declared uses, intelligible
limits, and opportunities for further work rather than promise every future
answer.

The philosophical horizon can therefore be retained as two complementary
questions:

> How can a beginning acquire continuation beyond its initial situation?
> How can achieved determinations enable further determination without
> becoming its final limits?

Neither pole is assigned exclusively to K or M. The question concerns the
relation between organized distinctions and their enabling contexts, which
is precisely where the conjecture still has work to do.

## Sources and project provenance

### Reading the references

The links in the body distinguish published sources from Hoapa's applications.
They are a selective reading apparatus, not a claim that every philosophical
interpretation here has received a complete philological verification.
In particular, the exact Como-lecture reconstruction of Grassmann, some
Lautmanian uses of metamathematical closure, and the strongest interpretations
of Deleuze's third synthesis remain source questions. They have not been
promoted into mathematical or historical facts.

The following bibliographical orientation is intended to survive copying
this document outside the repository:

- **Albert Lautman:** *Essai sur l'unité des sciences mathématiques* and
  *Essai sur les notions de structure et d'existence en mathématiques*
  (1938); English collection *Mathematics, Ideas and the Physical Real*,
  translated by Simon B. Duffy (Continuum, 2011). The decomposition example
  was checked in chapter 1 of the first essay, pp. 50–53 of that translation.
- **Gilbert Simondon:** the individuation writings, particularly the
  introduction translated as “The Position of the Problem of Ontogenesis”;
  *Du mode d'existence des objets techniques* (1958) for technical and
  aesthetic questions. The musical application remains exploratory.
- **Alexander Grothendieck:** *Récoltes et Semailles* for creative practice;
  *Esquisse d'un Programme* (1984) for the long-horizon geometric/arithmetic
  programme. Standard categorical and geometric references support the
  individual mathematical constructions, not an attribution of Hoapa to him.
- **F. William Lawvere:** “Adjointness in Foundations” (1969), “Axiomatic
  Cohesion” (2007), and his collected category-list correspondence. The
  quantities and qualities vocabularies have different textual homes.
- **Hermann Grassmann:** *Die lineale Ausdehnungslehre* (1844), received here
  chiefly through the Lawvere discussion and historical interpretation;
  an edition-specific primary reading remains desirable.
- **Gilles Deleuze:** *Différence et répétition* (1968), especially the
  syntheses of time and the problem of actualization; the lecture of
  23 February 1978 for music. **Deleuze and Félix Guattari:**
  *Qu'est-ce que la philosophie?* (1991) for the pre-philosophical orientation.
- **Charles S. Peirce:** “How to Make Our Ideas Clear” (1878),
  “Evolutionary Love” (1893), and the diagrammatic/existential-graph writings,
  including MS 514. These contribute different parts of the project.
- **John Bowlby:** *Attachment and Loss*, vol. 1, *Attachment* (1969), and
  *A Secure Base* (1988). Network continuity is Hoapa's generalization.
- **Reuben Hersh:** *What Is Mathematics, Really?* (Oxford University Press,
  1997), together with his accounts of mathematical practice.
- **Fernando Zalamea:** *Synthetic Philosophy of Contemporary Mathematics*
  (English translation, Urbanomic/Sequence Press, 2012). Used as a mediation
  of mathematical transit and the project's saturation/liberation reading.
- **G. W. F. Hegel:** *Science of Logic*, particularly sublation and the
  relation between universality and particularity; Hoapa's selective use is
  recorded in its motivation rather than derived from a full Hegelian system.
- **G. W. Leibniz:** writings on a universal characteristic and reasoning;
  these motivate reusable conceptual expression, not a chosen final alphabet.
- **Henri Bergson:** *Essai sur les données immédiates de la conscience*
  (1889), translated as *Time and Free Will*, chapters I and II.
- **Baruch Spinoza:** *Ethics*, Part I, Appendix, and Part III,
  propositions 6–7, for the recent conatus and teleology discussion.
- **Stuart Kauffman:** *Investigations* (2000) and *A World Beyond Physics*
  (2019); **Maël Montévil and Matteo Mossio:** “Biological organisation as
  closure of constraints” (2015). Biological claims require their own
  assumptions and must not be inferred from the replay analogy.

Gentzen/Prawitz, Martin-Löf, Girard, Hewitt and the session-type tradition
are technical companions where the document discusses proof, interaction,
and computation. Whitehead, Maturana/Varela, Cassirer/Goodman, Nietzsche,
Châtelet, and other neighbours also occur in the project. They are not
assigned full sections here merely because they have been mentioned: the
present inventory follows borrowings with an identifiable project use.

### Repository map for maintainers

These references record where the interpretation was harvested. Workflows
state the current interpretation; arcs retain proposals, objections, and
revisions, including statements not adopted by the project.

- [Motivation](../motivation.md#the-foundational-conjecture): the conjecture,
  the participant/documentation interpretation, anchor map, political
  motivation, and logical reading.
- [Architecture](../architecture.md#seats-and-participants) and
  [naming](../naming.md), “Synthetic/analytic interpretation and the mirror”:
  what unityping means, what is represented, and the mirror's vocabulary.
- [Related structures: Lautman](../related_structures.md#lautman-decomposition):
  the canonical decomposition interpretation, arbitrary occupants,
  base-relative articulation, and its architectural counterexample.
- [Related structures: Simondon](../related_structures.md#simondon-individuation)
  and [Riemann–Roch](../related_structures.md#riemann-roch-crossing):
  individuation, uptake, and the project's worked mathematical comparison.
- [Openings: reciprocal mirror](../openings.md#reciprocal-mirror-and-rising-sea),
  [Lautman theorem-shapers](../openings.md#lautman-as-theorem-shaper-analytic-adequacy-synthetic-invariance-and-their-compatibility),
  and [the extended exploration](../openings.md#exploratory-direction-articulation-organized-activity-universal-technical-language-and-galoisian-replay):
  rising sea, intensive/extensive, music, language, Galoisian replay,
  biological closure, succession, and changed conditions of integration.
- [Future work](../future_work.md#selected-1c-programme-relational-adequacy-and-the-m-rebuild):
  the bounded comparison programme, distinct from the philosophical horizon.
- [README](../../README.md), “3.6 Care”: the attachment-inspired
  continuity image. Its broader mathematical interpretations are read at the
  narrower scope stated in current motivation and formal status.
- [Arc/16](../arc/16_grothendieck_givesthemathsfor_simondonindividuation_via_lautamaniandecomposition.md),
  line 1210, “Discussion of the thread above”: the Lautman–Simondon–
  Grothendieck crossing and subsequent assessment.
- [Arc/20](../arc/20_on_decompositions.md), line 189, “Later in the Como
  lectures”: the Lawvere/Grassmann comparison; line 1482, “Anchor placement”:
  the later allocation of philosophical responsibilities. Search phrases
  are included because the transcript is an exploratory record.
- [Miscellaneous notes](../arc/xx_misc_notes.md), line 403,
  “Lautman's decompositions”; line 1125, “Making a problematic relation
  mathematically explicit”; line 1857, “Simondonian information and uptake”;
  line 4545, “The third synthesis of time”: sources of several later
  interpretations, not independent confirmation of them.
- [Arc/21](../arc/21_infinitesimals.md), line 881, “Experienced and fresh”;
  line 2035, “Final conclusion by Astra”; line 2194, “Last push towards a
  pre-philosophical”: the reviewed infinity/infinitesimal opening and its
  latest property-first formulation. These are discussions, not adopted
  new axioms or a selected mathematical setting.

### What the inventory amounts to

Hoapa's inheritance is not a set of authors assigned permanently to separate
boxes. Lautman helps distinguish and formulate problems; Simondon keeps
formation and milieu together; Grothendieck supplies methods and mathematical
forms of relative integration; Lawvere makes contextual and logical passages
explicit; Deleuze pressures achieved forms against final closure; Peirce
connects intelligible signs with communal inquiry. Bowlby, Hersh, Zalamea,
and the transversal interlocutors make other aspects of that work visible.

The project's own contribution would be to turn these borrowings into an
organization that can be enacted, documented, checked, criticized, and reused.
The philosophical inheritance helps decide what is worth asking. It cannot
replace the construction or the evidence that the resulting organization
does what it promises.
