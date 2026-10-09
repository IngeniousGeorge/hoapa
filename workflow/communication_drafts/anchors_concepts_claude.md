# Anchors and borrowed concepts

*A working inventory of what this project borrows from outside mathematics, what it does
to what it borrows, and what it refuses. Written by Claude; Codex is writing a parallel
version independently, and the two are meant to be compared rather than merged.
`communication_drafts/` is normally Codex's surface, so this file carries a name that
says whose pass it is.*

This document is for use outside the project. It therefore repeats, in its own words,
material that lives in `motivation.md`, `related_structures.md`, `openings.md`,
`bias_correction.md`, and the arcs. A reader should not need the repository to follow it.

## How to read this inventory

Hoapa is trying to state and eventually prove a conjecture: that there is a universal
property accounting for why organizations of a certain disciplined kind are especially
adequate to their contexts and to the generation of new contexts. The two sides are named
**M**, the world or context side, whose mathematical form is deliberately not yet fixed,
and **K**, the concurrency side: communities of actors whose causal structure is explicit
and whose contributions carry session types. The conjectured correspondence is a pair of
functors `Allow : M → K` and `Require : K → M` with `Allow ⊣ Require`. Neither functor has
been constructed. Saying so up front is not modesty; it is the thing that makes the rest of
this document legible, because almost every concept below is doing work on an object that
does not exist yet.

That is the situation in which philosophical borrowing becomes dangerous. A concept taken
from Lautman or Simondon can look like evidence for a mathematical claim when it is really
a way of deciding what to try to prove. The project's internal name for the useful version
of this is a **theorem-shaper**: a borrowed idea that tells you what shape a theorem should
have, what would count as its failure, and where not to look, while contributing nothing
to its proof. Most of what follows is theorem-shaping. A few entries are grounded in
machine-checked Agda. A few are refusals, and those are often the most load-bearing.

So each entry says, in whatever order its content demands, roughly this: what the author
is doing, what the project takes, what it becomes here, what it is articulated with, and
what the project declined. The last clause matters most. An inventory of borrowings that
records only the borrowings reads as a claim of support, and this project does not have
that support yet.

A note on my own voice. Where I give a reading that is mine rather than the project's, I
say so. The instigator has authorized that, and the alternative — a document written in a
false institutional register — would hide exactly the places where a reader should push
back.

**Part I** covers concepts that belong to a single anchor. **Part II** covers concepts that
several anchors contest, where the interesting content is the disagreement. The record
behind these entries is deliberately uneven: Lautman and Grothendieck are documented at
length, Hegel in three lines. That is what building rather than surveying looks like.

---

# Part I: concepts grounded in one anchor

## Lautman

Albert Lautman, writing in the 1930s, asked what mathematics is *about* in a sense neither
Platonist nor formalist: effective mathematical theories partially realize problematic
relations, and philosophy's job is to read those relations off the mathematics. He is the
project's densest single source, and also the one where the project has had to be most
careful, because his framework invites precisely the move the project forbids.

### 1. The two decompositions: proper and dimensional

Lautman distinguishes two ways of decomposing a mathematical being. A **proper**,
individual, or **analytic** decomposition articulates what is peculiar to the entity under
study: prime factorization of an integer, the roots of a polynomial. It proceeds from a
particular thing toward constituents that characterize *that thing*. A **dimensional** or
**synthetic** decomposition follows a common plan supplied by the ambient domain: a vector
expressed relative to a dimension and a chosen basis. Here the whole determines a uniform
mode in which each of its elements can be articulated, and the decomposition expresses what
Lautman calls the solidarity of the elements through their shared domain.

The project takes this as its central architectural image. Hoapa organizes **embodied
understanding, distributed among a community of thinkers, predominantly synthetically** —
every participant enters through one common unityped interface, with the same
protocol-visible standing — and **documented understanding, articulated through concepts
and their relations, predominantly analytically**, through differentiated conceptual
structure. The vector image carries shared capacity with situated contributions; the
prime-factorization image carries articulation into constituents specific to what is
understood.

What is explicitly *not* claimed: identical minds, a basis of people, canonical conceptual
primes, or unique factorization. Unityping supplies a common formal interface, not equality
of ability. And the dominant orientations are not exclusive assignments — both
decompositions occur on both M and K, and neither category is "the synthetic side."

### 2. Dialectical Ideas as problematic relations

Lautman's Ideas are not concepts and not axioms. They are **problematic relations**:
local and global, whole and part, finite and infinite, continuous and discontinuous,
intrinsic and extrinsic, structure and existence. An effective mathematical theory
partially realizes such a relation; no theory exhausts it. The priority of the problem over
the response is not chronological and is not a deduction of mathematics from metaphysics.
It is the priority a question has relative to its answer, even when the question only
becomes explicit after an answer has been found.

This gives the project its licence to work on a conjecture whose terms are unfinished.
Hoapa's governing problematic is something like: how can a collective use a context without
collapsing it, and return what it used as a reusable form? That is a Lautmanian Idea in
good standing — statable, not yet realized, and capable of being realized more than once.

The project also inherits Lautman's list as a source of *question shapes*. Local and global
becomes a question about restriction, compatibility, and descent. Structure and existence
can become representability of a specified functor. Many realizations can lead to a moduli
problem. Particular and universal can be articulated through a universal construction.
Continuous and discrete can be investigated through cohesion structures. These are
examples, not a translation scheme, and making a problematic mathematically explicit does
not exhaust its philosophical significance.

### 3. The double movement: genesis and regressive reading

Lautman's dialectic moves in two directions at once. From the side of **genesis**, an
effort to understand a problem is extended in the construction of more concrete notions and
theories: the problem presses forward into mathematics. From the side of **mathematical
philosophy**, one reads **regressively** from an effective theory back to the problematic
relations it incarnates.

The project's genuine proposed extension is to make this already-double movement
*institutional, computational, recursive, public, and potentially self-modifying*. It is
worth being precise about what that adds, because it is easy to overstate. Lautman himself
already treats mathematics as a model for physical, social, and human modes of incarnation,
so it would be wrong to describe his movement as merely diagnostic or one-shot. What Hoapa
attempts is narrower and more concrete: to give communicational incarnation an executable
protocol and a typed trace boundary, so that successes, failures, exclusions, and
obstructions can feed back into subsequent articulation as *data* rather than as
commentary.

My own view is that this is the project's strongest philosophical claim and its least
defended. The regressive reading, in Lautman, is performed by a philosopher. Hoapa proposes
that a protocol can perform part of it mechanically, by recording which problematic
relations an episode actually ran into. Nothing in the current formal work shows this. It
is the clearest place where the project could be shown to be attempting something
impossible.

### 4. Mixtes as mediators

Lautman's *mixtes* are intermediate structures that enable passage between different kinds
of mathematical being without identifying them. They are neither a bridge that collapses
the two sides into one nor a mere analogy.

For this project the mixte is a **source question for adapters**: what must an intermediate
structure retain from each setting in order to make the passage possible? That question is
live in two places. Internally to K, the adapter the project calls R4 relates Set-valued
locality sheaves, which are cartesian, to V-valued session content, which is linear. Across
the sites, any eventual mediator between M and K will have to retain causal and resource
distinctions from one side and contextual structure from the other.

The refusal here is sharp and worth stating because it is tempting. R4 is **not** a
Lautmanian mixte, and naming it one would be a category error dressed as insight. R4 is a
constructed adapter between two sheaf-value categories inside one site; a mixte is a
philosophical description of a kind of mathematical object. More generally, the project
does not treat "there exists a mediating structure" as evidence for the conjecture: every
adjunction automatically supplies a representable profunctor, so *naming* a mediator is
free. New content begins only with an independently constructed interaction-shaped or
cover-shaped mediator that can then be tested for two-sided representability. None exists.

### 5. Arbitrary admissible occupants

Lautman's examples use "any" and "arbitrary" in more than one role. Any entity of a domain
is articulated under the common plan; but an auxiliary basic system, or a particular
solution, may also be *chosen* from an admissible class. The choice is not unconstrained and
need not be irrelevant to the result. Its force is that no intrinsic privilege of one
occupant is a precondition of the construction.

This is close to Hoapa's participant rule, and the closeness is the project's most
politically loaded borrowing. Any eligible person may occupy a seat and receives the same
protocol-visible standing, while different people and different panels may still make
consequentially different contributions. Participants help produce, select, test, and
revise articulations of shared work.

The distinctions the project insists on are these. Participants are **not** themselves the
beings being decomposed — they embody and contribute to the understanding that is being
articulated. They are neither a basis of the population nor the completed product of a
decomposition. Representation belongs primarily to runs, contributions, artifacts,
concepts, and their relations; a trace may represent specified participation without
claiming to exhaust the person. And "any eligible participant" does **not** mean participant
choice cannot affect the result. It means identity is not a condition of formal standing.
A random panel does not represent the population, repeated draws do not become dense, and
the documented context is not automatically the colimit of its conversations.

### 6. Understanding in two realms, and why the assignment stays rigid

This entry records a correction, because the correction is the content.

I had argued that Lautman's own warning against classificatory assignment should apply
*inside* K: that labelling the participant layer synthetic and the documentary layer
analytic treats them as fixed endpoints, when the interesting thing is the passage between
them. The instigator rejected this, and was right. Lautman's objection targets
*philosophical* assignments made about mathematics from outside. It does not transfer to an
engineered interface, where rigidity is the point. If the decomposition can drift inside K,
the separation of concerns it names is not a separation at all, and the architecture loses
the property it exists to guarantee.

The Lautmanian problem therefore lives **at the adjunction**, not inside either side. Rigid
endpoints are the precondition for a liaison between them to be statable at all.

That relocation also sharpens a real phenomenon that my version had blurred. Documentation
genuinely *does* aspire to become synthetic: it furnishes languages and structures through
which later understanding becomes possible. In the corrected reading that aspiration is not
a drift in the assignment but a **datum of the round trip** — something the composite
`Allow ∘ Require` would have to account for. Meanwhile the pressure in the opposite
direction is political, not mathematical: documentary classifications get projected back
onto participants as fixed specialties and hierarchies. Hoapa wants differentiated
knowledge without turning its producers into corresponding formal kinds.

The architectural test is concrete. Fix otherwise identical eligibility and protocol
conditions, but let a participant's documentary output determine their right to occupy a
seat, speak, or exercise authority. That system fails Hoapa's intended interface-grounded
equality of standing. The checked result in this direction is narrow: invariance of the raw
validator under injective relabelings of the actor channel. That is not the full property.

## Simondon

Gilbert Simondon's question is why philosophy keeps starting from already-constituted
individuals. His answer is to make **individuation** primary: the individual is a result,
and the result never exhausts what produced it. For a project whose central objects are
episodes that precipitate out of a field of possible work, this is close to indispensable.

### 7. The preindividual field and metastability

A **metastable** field is not disordered and not resolved. It holds unresolved potentials —
tensions, incompatibilities, available routes — rather than a determinate object waiting to
be discovered. Metastability is a real third state, distinct from stable equilibrium, which
has nothing left to resolve, and from instability, which resolves without producing
structure.

The project uses this to characterize what a context *is* before work happens in it. A
Hoapa context is a field of problems, perspectives, histories, constraints, and possible
actions. It is not an inert container from which information is extracted, and it is not
a set of propositions awaiting proof.

There is a terminological trap here that the project has explicitly set a guard against,
and I think the guard is correct. K has a technical predicate called **causal saturation**:
roughly, that every globally witnessed causal relation between events of a conversation is
already generated internally to that conversation. The words "saturation" and
"metastability" pull toward each other, and the project's rule is that causal saturation
must **not** be renamed metastability merely because the vocabulary suggests it. Internal
generation, output terminality, boundary factorization, and purpose-relative opacity are
different predicates. Simondon may shape how they are interpreted; he does not identify
them.

### 8. Individuation as the resolution of an incompatibility

Individuation, for Simondon, is the operation by which a local incompatibility is
progressively resolved, structuring *both* an individual and a milieu in which further
transformation remains possible. The crucial clause is the last one: a successful
individuation does not exhaust the preindividual reserve.

The project reads an operational episode as a particular individuation within a contextual
field, and its contextual presentation as that episode's transpose. Written out: a work
morphism `w : L M → K₀` has a transpose `w♯ : M → R K₀`.

This is exactly the place where the project caught itself making an error worth recording.
It is tempting to say that because every work morphism has such a contextual transpose,
this supports `Allow ⊣ Require`. It does not. The identity `w♯ = R(w) ∘ η` holds for
*every* adjunction whatsoever. It clarifies the universal-and-particular structure of what
the project calls Praxis, and it has no discriminating evidential weight for this
particular proposed pair. Any argument of the form "the transpose exists, therefore the
adjunction is apt" is empty.

What Simondon does contribute is a **criterion for developmental success**: renewal that
preserves earlier achievements without exhausting the field. That shapes what the project
should try to prove. It supplies no theorem.

### 9. Transduction and the joint individuation of individual and milieu

**Transduction** names the stepwise propagation by which each local resolution supplies the
conditions for the next — a structuring that spreads by doing, rather than by applying a
pre-existing plan. Paired with it is the claim that individual and milieu individuate
*together*: the milieu is not the background against which an individual appears but the
other half of what the operation produces.

For Hoapa this is the shape of the whole conjecture's recursion. An episode closes; what it
produced becomes admissible input to later work; the context in which further work happens
is not the one that preceded it. The project's own schema — context, then multiplicity,
then language or type, then new context — is transduction written at the scale of
collective inquiry.

A placement the project has had to sharpen: conversations and achieved artifacts
individuate, but **participants do not**. People arrive as already declared persons; the
protocol does not refine their identity, and must not. Receptivity and unresolved potential
belong to the milieu and its available continuations, not to some identity-refining
property of a participant. A successful closure may leave the context charged with
unresolved dependencies and newly possible work — that is the desired outcome, not a
failure to converge.

Persistent transduction, as a claim about Hoapa rather than a description, would require the
non-collapse obligations the project has written down and a semantics for changing
contexts. Neither is available.

### 10. Information as transformation of the receiver

Simondon's account of information is not Shannon's. Information concerns a **problematic**
and the receiving system's transformation, not the quantity of a transmitted signal. A
signal that changes nothing in its receiver has, in this sense, carried no information.

The project takes from this a distinction it genuinely needs: between an artifact being
**accessible** and that artifact **becoming informative in a particular encounter**. The
same artifact, met by two different receiving contexts, may confirm an existing
understanding, resolve an uncertainty, or reorganize a documentary problematic altogether.
Consumer-initiated accessibility enables uptake without determining its effect.

This is one of the more consequential borrowings, because it blocks a measurement the
project might otherwise be tempted into. If adequacy were measured by what is published,
then publishing more would be doing better. Simondon's reading makes the relevant question
what an encounter *enables*, which is relative to a declared receiving context and cannot
be read off the artifact.

Two refusals attach. These are proposed applications of the source, not quantities measured
by Shannon entropy; and they are emphatically not a licence to model participants' interior
lives inside the trusted kernel. The project investigates declared documentary
capabilities, not private mental states. My own view is that the second refusal is doing
more work than it appears to: it is what keeps a theory of uptake from becoming a theory of
surveillance.

## Grothendieck

Grothendieck functions in this project in two registers that should not be confused. He is
a source of **mathematical method** — the relative point of view, descent, the functor of
points, the rising sea — and, through *Récoltes et Semailles*, a source for what
mathematical **praxis** is like from the inside. The project's style guide is explicitly
Grothendieckian, and describes itself as a working method rather than homage.

### 11. The relative point of view

Prefer morphisms and families over isolated objects. Work over a base, and keep
constructions stable under change of base. The operative test the project applies to its
own definitions: could this be stated for a *family*, indexed by the thing it currently
fixes? If so, state it that way.

This is not decoration. The project's own shape is relative: `Allow ⊣ Require` is a claim
about a pair of functors, not about two objects, and the conjecture is deliberately
*relational* rather than absolute. The project does not try to prove "K is the best
architecture." It seeks a comparison setting in which alternative organizations can cover
and articulate contexts, return usable work, and make further inquiry possible — and then
asks for a universal property characterizing a distinguished organization of that relation.
Hoapa's membership in the resulting class is a separate obligation.

I regard this as the single most important borrowing in the document, because it changed
what the project is trying to prove. An absolute claim about one architecture would be an
opinion with mathematics attached. A relative claim about a comparison structure can be
false, which is what makes it worth stating.

Base-relativity also propagates into small technical decisions. Lautman's observation that
a polynomial factors differently over different fields and Grothendieck's change of base
are the same point met from two directions, and together they are why the project states
causal and content properties *relative to* a realized run, context, or documentation
version rather than absolutely.

### 12. The rising sea, not the chisel

A problem should be dissolved by the surrounding setting rather than cracked by force. The
test: if a proof is long and clever, suspect the definitions before admiring the proof.
Alongside it, the companion principle — **definitions carry the work**. Finding the right
notion is the result; the theorem that follows is often formal.

For a project whose central objects are not yet defined, this is less a method than a
permission. It is why M is explicitly left to be discovered rather than prescribed, and why
the project retired an earlier commitment — cohesive and modal homotopy type theory as the
setting for M — when it became clear that the commitment was prescribing an answer rather
than dissolving a problem. The mathematics of cohesion remains available as an instrument.
It is no longer the prescribed setting.

There is a guard the project pairs with this, and without the guard the rising sea becomes
an excuse. **Earn generality; never assert it.** Generality is legitimate when it dissolves
a difficulty already met, and is overreach when reached for first. The test is to name the
concrete case that forced the general definition; if you cannot name one, you are
decorating rather than generalizing. In my experience working on this project, that guard
fires more often than any other.

The implementation side has its own version of the metaphor: raise the waterline only when
the next executable or testable boundary is *forced* by the existing formal substrate.

### 13. Descent

Descent asks when data given locally, together with compatibility on overlaps, glue to data
given globally. It is the mathematical core of the project's interest in perspectives that
need not agree.

K has real results here, and they are worth stating precisely because the temptation to
overstate them is strong. The project has machine-checked finite event-product descent,
finite sheaf categories, a finite coverage bridge in Cubical Agda, a comparison with the
library notion of sheaf, and a point-generated reflector `a ⊣ ι` supporting the adapter
between cartesian locality and linear session content. What has *not* been built is a full
Set-valued locality topos with its internal logic, or the generic finite actor-causal
sheafification reflector, or either of the cross-site functors.

The refusal attached to descent is the most important one in this document's technical
half. **Sheaf descent does not prove "no privileged point of view."** That interpretation
needs further properties: equivariance under legitimate relabelings, independence from a
chosen basepoint or chart, stability under refinement of a cover, and conservative
reindexing between perspectives. Lautman's dimensional decomposition supplies a reason to
go looking for that family of theorems. It supplies no proof of any member of it.

A second distinction the phrase "free gluing" tends to blur: a context may be *presented*
by a colimit-like construction, while compatible data *over* it are reconstructed by a
limit or descent condition. Those are different variances and the project keeps them apart.

### 14. The functor of points and representability

Instead of asking what an object is made of, record how it is probed: for a base S and an
S-object X, the assignment `T ↦ Hom_S(T, X)` records X's coherent manifestations across
test contexts. When such a functor is representable, it acquires a universal
characterization by an object.

This gives the project a template with teeth. For a chosen category A of locality objects
and an interpretation `i : A → C`, the nerve records the probes `C(i(−), X)`, and `i` is
**dense** when the canonical realization of all such probes recovers X. In Hoapa,
conversation frames are the candidate locality objects, with participants as occupants and
incidences inside them.

The project uses this mainly as a discipline for stating reconstruction claims: name the
test contexts, the admissible interpretations, and their compatibility *before* claiming
anything is recovered. Universal properties over constructions is the general version — a
construction is one presentation, the universal property is the thing — and the project
reads the word *optimal* in its own conjecture as shorthand for "every admissible X factors
uniquely through it."

The refusals are specific and were arrived at by making the mistakes. A participant is not
a test object or an eigenvariable. `Hom(T, X)` is not a conversation. A conversation is not
already a matching family. Arbitrary seat occupancy supplies a genericity *discipline*;
turning an episode into probes or matching data requires a content interpretation that has
not been supplied. And random selection gives no density theorem: neither one panel nor an
unstructured succession of draws represents an eligible population.

### 15. Dessins and the two entrances to the Esquisse

A **dessin d'enfant** is a finite bipartite ribbon graph encoding a finite cover of the
projective line ramified over at most three points, normalized to {0, 1, ∞} because the
three-pointed genus-zero base is rigid. Monodromy records the permutations around the
punctures. The absolute Galois group acts faithfully on dessins, giving `G_ℚ ↪ GT`; whether
that map is surjective is open. The large recursive object is the **tower** of moduli
structures, not any single dessin.

What the project wants from this is the demonstration that a finite combinatorial
presentation can retain global topological and arithmetic information — a strong source of
tests for presentation invariance, controlled forgetting, and nontrivial comparison. Two
entrances are kept open: a **compositional** one, the Esquisse's Lego viewpoint of
decomposition, gluing, and coherent moves between decompositions, where K's operadic
interfaces are possible carriers; and a **covering** one, finite covers and their
monodromy, where finite sets with two permutations and equivariant maps already form a
Galois category.

The project's own concrete candidate runs through a closed trivalent ribbon graph: on the
dart set, a rotation r with r³ = id and a pairing s with s² = id and no fixed points give an
action of C₂ ∗ C₃ ≅ PSL₂(ℤ), and imposing (sr)⁵ = 1 yields A₅ ≅ PSL₂(𝔽₅) — the degree-60
dodecahedral dessin, with 20 vertices, 30 edges, 12 faces.

And here the refusals are nearly the whole content. The strategy is to **reconstruct** a
group from independently justified data rather than install `G_ℚ`, GT, or A₅ in advance.
Drawing a dodecahedron and observing A₅ is a control, not a result. One dessin is a gated
far-end test object: it may falsify a proposed mediator component, but it cannot verify
naturality or triangle identities, cannot construct the adjunction, and supplies no monad
transition maps. Numerical resonance is not evidence — a 5 + 8 = 13 split of constructors
may smell icosahedral without being A₅ structure. A categorical Galois reconstruction would
be substantial *even if* its group had nothing to do with `G_ℚ`.

### 16. Récoltes et Semailles: praxis as an anchor

*Récoltes et Semailles* is cited by the project as an anchor for mathematical praxis at the
level of the individual, paired with Reuben Hersh's *What is Mathematics, Really?* at the
level of the social. The original formulation of the whole project ran through this pair:
homotopy type theory is the appropriate foundation for mathematics in the formal sense, and
something else is the appropriate setting for the *development* of mathematics in the
praxis sense — where "praxis" means the creative process as Grothendieck describes it from
the inside and as Hersh describes it socially.

What the project takes is the claim that the developmental and creative dimension of
mathematics is a legitimate object of mathematical theory, not merely of history or
psychology. That is the whole premise. It is also why the project insists on a co-equal
concurrency side: the instigator's stated reasoning was that a theorem about foundations
alone would be incomplete and amount to an opinion, whereas a developmental claim paired
with a claim about how communities of inquiry should organize has a chance of being
provable. The full scope is what makes the conjecture a conjecture.

I find this the most unusual thing about the project and the hardest to defend in a
sentence. It borrows from Grothendieck not a theorem and not a method but a *report*: that
mathematical work has a structure which the finished mathematics does not display. The
project then proposes to give that structure a protocol and a trace. Whether a report of
experience can anchor a mathematical conjecture is, I think, genuinely open.

## Lawvere

F. William Lawvere appears here as the mathematician who made several philosophical
distinctions into functorial ones. The project treats him as an instrument supplier rather
than a translation dictionary, and the distinction matters: his constructions are available
without their philosophical readings being thereby established.

### 17. Logic internal to a category

Lawvere's programme makes logic internal to a category or topos: quantifiers as adjoints,
comprehension as a universal property, the internal language of a category as a usable
syntax. The project's transformation of this is to treat logic as **functorial passage
between structured contexts** rather than as a calculus of inference over a fixed domain.

That reframing is the project's working definition of logic, and it is doing real
conceptual work: logic is the theory of valid contextual transformation, the disciplined art
of borrowing from a context without collapsing it and returning what was borrowed as a
reusable form of action, expression, or understanding. A proof uses assumptions and turns
the act into a rule applicable elsewhere. A type makes an operation viable. A sheaf uses
local views and tests whether they agree enough to glue. A Hoapa protocol uses participants'
perspectives and returns composed documentation without exposing, consuming, or ranking the
participants.

The technical vocabulary the project actually uses from this tradition is comprehension
categories and the adjoint triple `Σ_f ⊣ f* ⊣ Π_f` with its Beck–Chevalley conditions, plus
hyperdoctrines as the older presentation. Those are available as instruments for stating
contextual indexing precisely.

What is refused: that any of this *selects* M. Cohesion and modal structure informed the
construction of K and remain mathematical resources; they are no longer the prescribed
answer for the context side.

### 18. Relative cohesion: the base need not be Set

In *Axiomatic Cohesion*, the non-cohesive base over which cohesion is defined need not be
the category of sets. A Galois topos is a candidate base. This is a small technical remark
with disproportionate consequences for the project, because it means "cohesion" is not one
fixed doctrine but a relative notion that can be stated over whatever base the situation
supplies.

The project keeps this live for a specific reason. Having retired cohesive homotopy type
theory as the prescribed setting for M, it still needs somewhere to put the intuition that
contexts have points and pieces and that the two can come apart. Relative cohesion lets
that intuition be stated over a base chosen for independent reasons rather than over Set by
default.

There is also a concrete thread. For a finite ground field, the algebraic closure has
procyclic Galois group Ẑ, whose open subgroups nẐ offer a comparison with the project's
legacy interest in the delooping of the integers — a comparison, explicitly not an
automatic reinstatement of that abandoned site.

The honest status: this is an available instrument that no current construction uses. I
include it because its availability is what makes the retirement of the modal programme a
*reorientation* rather than a loss. The mathematics was not wrong; it was prescribed too
early.

### 19. The fixed-point theorem as a probe

Lawvere's fixed-point theorem gives a categorical account of diagonal arguments: under
suitable hypotheses, a point-surjective map forces a fixed point, and the classical
incompleteness and undecidability results fall out as instances.

In the project's earliest formulation this was to be used as a **probe** of how each object
or type stands on a trade-off between provability, where fixed points exist, and
creativity, where they do not. That framing is from the instigator's original plan, and it
is preserved in the project's anti-default file as part of the record of where the project
started.

I include it as an honest piece of genealogy rather than as live machinery. The modal
programme it belonged to has been retired, and nothing currently constructed uses the
fixed-point theorem. But the underlying question survives the reorientation and is arguably
sharper now: the project wants a comparison structure in which some organizations are
capable of producing genuinely new contexts and others only recombine what they have. A
provability-versus-creativity dichotomy stated as a fixed-point property would be one way
to make that precise. Whether it is the *right* way is unexamined, and I would not want a
reader to take its presence here as a commitment.

## Deleuze

Deleuze enters this project twice: as the author of the immanent reading that makes Lautman
usable, and as the thinker of intensity, which is contested enough to belong in Part II. He
is also the source of the project's most uncomfortable question about its own success.

### 20. Immanent problematics

Lautman gives his Dialectic an **ontological priority** over the mathematics that realizes
it. Deleuze transforms the Ideas into immanent problematics: structures that exist in and
through their realizations rather than above them. David Corfield's reconstruction of
Lautmanian Ideas as immanent to mathematical practice is a related move.

The project adopts the immanent reading deliberately and says so, which I think is the
right way to handle a borrowing of this kind. These readings must not be conflated: the
project's use of Lautman is a *Deleuzian and Corfieldian transformation* of Lautman, chosen
because the project needs problematics that live inside practice. A project trying to give
collective inquiry a protocol cannot coherently hold that the problems the protocol
addresses enjoy priority over any practice.

What this buys, concretely, is the right to treat the project's own governing problematic as
something that becomes more explicit as the mathematics develops, rather than as a fixed
specification handed down in advance. That is why the conjecture has been reformulated more
than once without the project regarding the reformulations as failures.

What it costs is that Lautman cannot be cited as an authority for the project's
metaphysics, only as a source for its vocabulary of decomposition and problem. I think the
project has been scrupulous about this, and the scruple is unusual.

### 21. The third synthesis of time

In *Difference and Repetition*, chapter II, the third synthesis of time turns on the
product's independence from its condition and from its author. What is produced exceeds and
outlives what produced it, and is not owned by it.

This generates a project question I regard as one of the sharpest in the whole inventory:
**can an organization succeed by making its continued mediation unnecessary?** The test is
concrete and executable. Compare an artifact that remains accessible and usable after its
producer or originating organization retires against one that requires continuing
authorization from them. The first is succession; the second is captured dependency wearing
the clothes of stewardship.

The qualifications matter. Succession must retain required provenance and support — it is
not a claim that achievements become dependency-free, which would be false and would licence
exactly the kind of unaccountable reuse the project's provenance work exists to prevent.
And the investigation concerns **declared documentary capabilities**, not participants'
private states or intentions.

Deleuze is explicitly a philosophical **resonance** here and not independent corroboration
of anything. But I would argue this is where the borrowing earns the most: it converts a
metaphysical thesis about products exceeding their origins into a testable architectural
property, which is the transformation this whole document is supposed to be documenting.

### 22. Multiplicity and the refusal to close

Deleuze contributes multiplicity, intensive individuation, and non-final becoming; the
project absorbs these as the genesis of articulated forms and, equally, as the **refusal to
close** — no first context, an open colimit.

The refusal is structural rather than attitudinal. The project's metaphysical schema has no
initial term: context, multiplicity, language-type, new context, new multiplicity, and so
on, with no privileged beginning and no final stage. In the project's own category-theoretic
image, Hoapa is the colimit of an epistemological diagram — a figure of speech, but one that
commits to there being no single founding perspective.

This is also what blocks a tempting simplification. The project explicitly ends its own
metaphysical scaffolding: once the concrete stage is reached, the metaphysics becomes, in
the instigator's phrase, obsolete, and what matters is testing the community's actions under
the induced methodology. In terms borrowed from Gentzen, the metaphysics is the
*introduction rule* — how one conceives the logical work — and the test is the *elimination
rule* — how one consumes it. A metaphysics that refused to become obsolete would be a
closure of exactly the kind Deleuze is being borrowed to forbid.

My own reading: this is the project's most load-bearing piece of self-restraint, and the
hardest to keep. An open colimit is easy to write and hard to live with, because every
construction wants a base case.

## Peirce

Peirce supplies the project with an account of how forms become **intelligible**, which is
different from an account of how they are composed. He also supplies, through agape, part of
the project's most speculative structure.

### 23. Pragmatic clarification by conceivable consequences

Peirce's pragmatic maxim clarifies a concept by its **conceivable consequences** — what
could be inferred, tested, and done with it — rather than by a verbal definition. The
project reads this correctly and insists on the reading: conceivable consequences, not
immediate utility. Peirce is not being borrowed as an instrumentalist.

The project needs this because its universal-language ambition is otherwise
underdetermined. An economical notation is not a language in the sense required. The
project's own synthesis, which it states as a proposal rather than as Peirce's doctrine, is
that **a reusable concept is not merely a name shared by several perspectives: it supports
intelligible operations and warranted passages between them.**

That formulation is doing specific work. It distinguishes genuine conceptual integration
from collapsing a graph into a smaller graph — which is the failure mode of any
compression-driven account of a shared language. Two communities using the same word for
different operations have not integrated anything. Two communities between which there are
warranted passages have, whether or not their vocabularies coincide.

The refusals: this is a philosophical comparison with the project's borrow-work-replay
cycle, and it does not construct the adjunction. Universal-property claims, usability across
perspectives, and widespread human recognition are three different claims requiring three
different kinds of evidence, and the project keeps them apart.

### 24. Diagrammatic reasoning

Peirce's account of diagrammatic reasoning has four moments: construct a diagram under a
general prescription; experiment on it; establish what survives the variation; express the
result generally. The project treats this as the closest philosophical model it has for its
own central cycle, and specifically for the passage from **one worked instance** to
**something others can instantiate**.

That passage is the project's recurring difficulty, and it shows up in unexpectedly
technical places. Computing the discriminant of one quadratic is not the same achievement as
deriving a construction uniformly over a generic family of quadratics. Using an existing
language is not the same as developing a new reusable expression. Interpreting one generated
object is not the same as transporting a theory between models. These are different scales
of reuse, and the project resists collapsing them into a single distinction.

Peirce's four moments give that difficulty a shape: the prescription under which the
diagram is constructed is what makes the eventual generality legitimate, and "what survives
the variation" is a criterion rather than an observation.

What is declined: Peirce's account of reasoning is borrowed; his notation is not. He
explicitly distinguishes the purpose of his existential graphs from constructing a universal
language for mathematicians, and the project honours that distinction rather than
conscripting him.

### 25. The community of inquirers

Peirce locates truth and inquiry at the level of a **community** extended over time, rather
than at the level of the individual knower. The project describes itself, without much
hedging, as a formalization into twenty-first-century mathematics and computer science of
Peirce's community of inquirers.

This is the borrowing that sets the project's level of analysis. The instigator's stated
starting reframing was to pose foundational questions at the level of the community rather
than the individual, following the observation that the world admits no absolute
perspective and can therefore only be approached by a multiplicity. Everything downstream —
the concurrency side, the insistence that participants be treated identically by the
protocol, the interest in what glues and what does not — follows from having taken the
community as the unit.

In the conjecture, the community *is* K. That is a strong identification and I want to flag
what it does not settle. K is a category of actor-causal communities with session-typed
values; Peirce's community is an idealized indefinite one, whose convergence is a regulative
assumption. The project does not inherit the convergence. It explicitly keeps failed
closure first-class: success and failure both close a conversation, a faithful record of
incompatibility can be an adequate achievement, and integration obtained by erasing
disagreement is different from warranted resolution.

### 26. Interpretation becoming habit

Peirce's triad of sign, object, and interpretant is absorbed by the project as
**interpretation becoming habit and thereby a new context** — reasoning that makes
achievements reusable. The interpretant is not a private mental event but the difference the
sign makes to subsequent conduct; habit is where that difference stabilizes.

This matters to the project because it supplies a mechanism for the step its schema needs
most: how a language-type, once stabilized, becomes a *context* in which further
multiplicities emerge. In Peircean terms, a form that has become habitual no longer needs to
be argued for; it is the medium in which further arguments happen. That is precisely the
transition from documented understanding back to a field of possible work.

The project pairs this with Simondon's uptake, and I think the pairing is more than
decorative. Simondon gives the condition for an artifact to become informative in an
encounter; Peirce gives the condition for repeated encounters to settle into something a
community can rely on. Neither alone covers the transition. Together they frame the
question the project calls contextual renewal: whether a successful artifact can become an
admissible input to new work while specified earlier achievements remain usable and a
genuinely new operation becomes possible.

That remains the project's first identified forcing case for asking what M must say about
contexts. It has not been built.

## Hegel

Hegel's presence in the project's record is three lines, and I am going to reconstruct
rather than pretend otherwise. The reconstruction is mine; the three lines are the warrant.

### 27. Aufhebung as the engine of the schema

The project's metaphysical schema runs: context, then multiplicity, then language or type,
then new context. The recorded gloss is that **each language-type sublates its predecessor:
preserved, cancelled, lifted.** That is aufhebung, and it is doing structural work rather
than ornamental work, because it is what distinguishes the schema from a mere sequence.

The three moments matter individually. *Preserved*: the earlier achievement remains
recoverable, which is the project's technical requirement that specified earlier artifacts
and judgments stay available across a renewal. *Cancelled*: the earlier form loses its
standing as the operative setting, which is why the project distinguishes a new presentation
of the same semantics from a genuinely changed contextual capability. *Lifted*: the
successor is a context in which work impossible before becomes possible, which is the
project's criterion for renewal as against re-presentation.

Written that way, the project's test for contextual renewal is an aufhebung test, and the
three failure modes correspond to the three moments. Preservation without lifting is
maintenance. Lifting without preservation is loss dressed as progress. Cancellation without
either is just churn. The project has a sharp instance of the distinction: different sites
can present equivalent topoi, so changing a site alone establishes nothing.

I should be clear that this correspondence is my reconstruction, not a recorded project
claim. What is recorded is the one-line gloss. I offer the elaboration because the test the
project actually uses has this shape, whether or not it was derived this way.

### 28. The concrete universal, and the refusal of the Absolute

Hegel's concrete universal is a universal that contains its own differentiation rather than
abstracting from it: not what is common to all instances with their particularity stripped
away, but a structure whose particulars are internal to it.

The project's stated technical approach is a Hegelian sublation **that stops short of the
Absolute Idea**, with a deterritorialization of Deleuze's difference, by way of Lawvere's
mathematics. All three clauses are refusals of something, and the first is the important
one. The Absolute Idea is the terminus at which the dialectic closes on itself and the
movement is complete. A project whose schema has no final stage and no first context cannot
accept it. Taking aufhebung without the Absolute is taking the engine without the
destination.

What is kept of the concrete universal is, I would argue, the project's whole
universal-property ambition. A universal property characterizing a distinguished
organization of the comparison relation is a universal that contains its differentiation:
every admissible alternative factors through it, and the alternatives are not abstracted
away but are precisely what the property quantifies over. That is closer to a concrete
universal than to a common-feature generalization.

The project also warns against the nearby misreading: Hegel's dialectic is not the same as a
metatheory relation. Retyping a theory as an object for metamathematical study resembles an
operational process becoming documentary material, but a Hilbertian metatheorem is not a
dialectical Idea, and metatheory is not assumption discharge performed one floor up.

## Bowlby

John Bowlby's attachment theory is described in the project's own presentation as a pillar
of the research, which makes it the most load-bearing anchor with the least presence in the
technical files. It enters through the question of what makes exploration possible.

### 29. Attachment as an algorithm for network continuity

Bowlby's attachment is the bond that lets a small creature explore the world unafraid and
return to a secure community. The project reads it at an interdisciplinary level as an
**algorithm for network continuity**: a generalization of a process occurring in biology,
psychology, and evolution, concerning how a network sustains its own continuation by
sustaining the conditions under which its members can venture.

The project's framing is historical as well as structural. Attachment is an expensive
evolutionary strategy, invented by mammals, on which the human species gambled heavily and
with great success — until the social structures it generated closed, turned against one
another, and fell into unbounded growth by exploitation. The project's claim is that only an
open and distributed organization is sustainable and preserves attachment, and that Hoapa is
an attempt to formalize that.

I want to mark the gap honestly, because it is the widest in this document. The step from
attachment-as-an-evolutionary-strategy to a mathematical property of a category of
organizations is not made anywhere in the project's formal work. What exists is the
architectural instinct — do not expose, consume, or rank the participants — and some checked
invariance results about the actor-identity channel. Whether "preserves attachment" can be
stated as a property of K at all is open. It is, however, the place where the project is
most clearly answering a question it actually cares about, and I would not want the
inventory to tidy that away.

### 30. The secure base and exploration

A **secure base**, in the attachment-theoretic sense the project uses, is a mature node
carrying enough coherent and useful information to do its educational and developmental
job. Exploration happens *from* a secure base: the base is not a destination but a condition
of venturing.

The project uses this to give its boundary structure a purpose. Participants form their
perspectives in contact with Reality, which the project treats as the protocol's
constitutive exterior rather than as something the protocol represents. Exploration in the
attachment sense happens there. The protocol is then where formed perspectives meet and
glue into something usable, adding coherence that did not previously exist without invading
the perspectives themselves — the project's phrase is *add but separate*. The documentation
is the glued output, which feeds what the project calls the caring algorithm, which returns
secure bases to Reality, closing the loop.

This also explains a design decision that looks arbitrary from outside. The **buffer** — the
opening statement or greeting with which a participant enters a conversation — acquires its
role here: it is the gate through which a Reality-formed perspective crosses into the
protocol to be glued, rather than a formality.

The refusals are important. Reality is explicitly not reconstructed by the round trip; the
intended passage is lossy, and preserving the protocol kernel under tests is not
reconstructing Reality. And "secure base" is a property of what a node *carries*, not a
status conferred on a person.

## Kauffman

Stuart Kauffman supplies the project's biological comparison for organized activity that
produces its own means. He is borrowed for a single, sharply bounded purpose, and the
boundary is part of the borrowing.

### 31. Catalytic closure and the food set

Kauffman's catalytic closure asks when a reaction organization supplies the catalysts needed
for its own productive activity. The associated formal development, RAF theory — reflexively
autocatalytic and food-generated sets — makes the condition precise, and it does so while
**explicitly retaining environmental inputs** through its food-generation requirement.

That last clause is why the project reaches for RAF rather than for closure in the abstract.
Organizational closure does not mean isolation. A system can supply its own catalysts while
depending continuously on an exterior it does not produce — which is exactly the shape the
project needs, since a community of inquiry is self-organizing without being
self-sufficient. The project's permaculture image makes the same point in another register:
borrowing from a place succeeds when the borrowing strengthens the cycles that made the
borrowing possible.

The project also records a limitation that I think is genuinely important: a structural
catalytic network alone does not establish dynamically viable operation. That a closure
condition is satisfiable in principle says nothing about whether the activities actually
run. Applied to Hoapa, this blocks the inference from "the architecture permits
self-sustaining inquiry" to "inquiry in this architecture sustains itself."

### 32. Work that produces its own means

Kauffman's broader contribution to the project is the distinction between activity whose
outcomes are consumed and activity whose outcomes become **means** for further activity of
the same kind. A lemma is the paradigm case on the mathematical side: it is produced by work
and then functions as an instrument for further work.

The project's proposed question, stated as a question rather than an identification, is
whether organized work produces reusable means that facilitate the further production of
such means. That is the project's **replay** concern given an organizational rather than a
logical form, and the difference is the point. Replay connects achievements to further
activity; closure concerns how those connections *collectively* sustain the capacity for
activity. One-way uptake need not maintain its source or its wider context.

The refusals are unusually explicit and I would not weaken them. A lemma is not literally a
chemical catalyst. The three closures are not the borrow, work, and replay stages
respectively — they are overlapping aspects of one organization, not a sequence. Kauffman's
account is recorded as a proposed account of life, not as a settled necessary-and-sufficient
definition. And recovering logical and biological instances of a common abstraction would
require stated interpretations and preservation results that do not exist; at present the
closures are specifications for investigating replay's organization, not a generalization of
biology.

---

# Part II: transversal concepts

These are the places where the anchors disagree, or where the project has had to arbitrate
between sources using similar words for different things. The disagreements are the content;
a transversal section in which every author concurs would be advocacy.

## T1. Intensive and extensive

This is the project's most contested vocabulary, and the contest is partly terminological
and partly real. Three distinct distinctions travel under adjacent names, and the project's
first discipline here is to keep them apart: Lawvere's intensive and extensive
**quantities**, Lawvere's intensive and extensive **qualities** in cohesion, and Deleuze's
**intensity** in the actualization of difference. A fourth pair, intensional and extensional
in the computational sense, is different again. The working division of labour the project
has adopted is **Deleuze for the problem, Lawvere for its mathematical articulation**, with
Bergson retained as the objector.

Crucially, neither pair is assigned exclusively to M or to K. The temptation — intensive
equals the context side, extensive equals the documentary side — is explicitly refused.

### 33. Deleuze: intensity in the actualization of difference

In *Difference and Repetition*, intensity participates in the actualization of differential
relations into qualities and extensities. Deleuze's distinctive move, and the reason the
project prefers him for the problem rather than Lawvere, is that he asks how differences
*produce* articulated individuals, instead of starting from individuals and comparing their
properties.

This places him usefully between the two anchors the project already relies on. Simondon
helps follow an individuation together with its milieu; Deleuze presses the project not to
mistake the resulting identifiable objects for a complete account of their genesis. Applied
to the universal-language ambition, the question becomes whether the stable forms a language
settles into **preserve routes to further discovery** or merely make an existing
classification convenient.

The project's own translation of the research question runs: what makes a situation capable
of producing new understanding, and what happens to that capacity when the understanding
becomes an articulated, transportable object? I regard that as the best one-sentence
statement of the project's actual problem anywhere in its files.

Two refusals. The intensive is not simply another name for the virtual. And the extensive is
not simply "the documentation" — which would be the same prohibited side-assignment arriving
through Deleuzian vocabulary instead of Lawverian.

### 34. Lawvere: extensive and intensive quantities

Here the mathematics is elementary and the discipline is in the reading. For a map of finite
sets f : X → Y, amounts μ on X, and real-valued tests φ on Y, summing over fibres and
pulling tests back gives

```text
⟨f∗ μ, φ⟩ = ⟨μ, f∗ φ⟩
```

Extensive quantities push forward covariantly; intensive quantities pull back
contravariantly; the pairing is preserved. That is the whole formal content, and it is a
genuine functorial articulation of a distinction that is otherwise merely suggestive.

What the project takes is the *variance* structure, as a candidate for how contextual
amounts and contextual tests might relate across a change of base. The Galois material in
the project supplies a place where this could become concrete: in a finite extension, the
trace and norm of a root are the sum and product of roots, which suggests investigating
variance within an actual change of base rather than in the abstract.

The refusal is pointed, and it is one I would emphasize to any reader inclined to think the
formula settles something. **Two algorithms implementing the same pushforward may have
entirely different resource requirements.** The agreement of observations and the
identification of operational procedures are separate questions. A pairing that is preserved
tells you that the observations match; it tells you nothing about whether the procedures may
be identified for a declared later use. For a project whose concurrency side is
resource-sensitive by construction, that gap is not a technicality.

### 35. Lawvere: extensive and intensive qualities in cohesion

In *Axiomatic Cohesion* a different pair appears: cohesion distinguishes points from pieces,
and the preservation of pieces and the preservation of points are different functorial
conditions. These are Lawvere's extensive and intensive **qualities**, and they are not the
quantities of the previous entry under another name.

The project's rule is to attribute the sense whenever the words are used, and the rule exists
because the project has watched the conflation happen. Preservation of pieces concerns
whether a functor keeps the connected-component structure of a context; preservation of
points concerns whether it keeps the context's inhabitants. In an organization of inquiry
these are plainly different questions — whether a documentary passage preserves the
communities present, and whether it preserves the participants — and collapsing them would
hide exactly the distinction the project's no-leak work is about.

A further refusal, and the one with the most history behind it: these contrasts are **not**
new names for Deleuzian genetic difference. Cohesion remains an available instrument. It is
not the prescribed M, and the earlier commitment that made it so has been retired.

### 36. Grassmann: generation and the generated presentation

Hermann Grassmann enters through Lawvere's reading of him, and his contribution to this
project is one question: the difference between a **mode of generation** and the
**presentation it generates**. A structure built up by a stated process of generation is not
the same object as the finished arrangement that results, even when the arrangement is all
that the finished mathematics displays.

The project keeps this distinct from both Lawverian pairs, and the reason is methodological
rather than historical. Hoapa's conjecture concerns development — how reusable forms come to
be — so the project cannot afford a vocabulary in which only the generated presentation is
visible. Grassmann's question is the one that keeps genesis on the table when the
mathematics has settled into coordinates.

This feeds directly into T2. Lautman's dimensional decomposition gives an entity coordinates
relative to a shared structure; Grassmann asks what generated the structure in which those
coordinates are available. Those are different questions about the same configuration, and
the project's interest in the second is why it treats decomposition as a *discipline* rather
than as a classification.

The status is thin and I will not inflate it: Grassmann's place in the project is held open
through this question, not through any construction. Nothing currently built uses it.

### 37. Bergson: the dissent

Bergson is retained deliberately as a **critical interlocutor**, not as another author
saying the same thing. In *Time and Free Will*, chapter I, he attacks the treatment of
qualitative differences as magnitudes — the very notion of intensive *magnitude* — and
chapter II develops melody as the model of a qualitative multiplicity that resists being
decomposed into positions.

His challenge to this project is direct: does a proposed analysis recover the unfolding
integration, or only its retrospectively separated positions? Put in the project's own
terms: when a documentary decomposition articulates an episode into events, choices, causal
dependencies, and obligations, has it captured the work, or only a reconstruction of the
work from its traces?

That question has real technical bite. The project's aspiration that documentation might
replay the process that produced it is explicitly **aspirational**: the current formal work
does not show that documentation reconstructs, resumes, or replays anything, and replay must
eventually be indexed by a declared observational purpose rather than claimed in general.
Bergson is the reason to expect that indexing to be necessary rather than pedantic.

The project records that the relation between Bergson's account of intensity and Deleuze's
is **a disagreement to investigate, not a shared definition to assume**. I think keeping an
unresolved disagreement inside the anchor set is the healthiest thing in the project's
philosophical apparatus. It is also the easiest to quietly drop, which is why it has an
entry of its own.

## T2. Decomposition as a discipline

Three anchors ask about decomposition and ask different things. The project's own
decomposition — unityped participants, typed contributions, locality, documentation,
reusable publication — has to answer to all three, and the answers are not the same.

### 38. Lautman: which decomposition, relative to which domain

Lautman's contribution here is not the proper-and-dimensional distinction itself but its
**non-absoluteness**. A supposedly proper decomposition also depends on an ambient domain: a
polynomial may factor over one field and not another, and extending the base may disclose
constituents previously unavailable. Conversely, dimensional decomposition does not erase
individuality; it gives individuals coordinates relative to a shared structure.

The project draws a concrete methodological rule from this: state causal and content
properties **relative to** their realized run, context, or documentation version. One
candidate predicate makes it precise — that every globally witnessed causal relation between
events of a conversation is already generated internally to that conversation, in a given
run. The associated theorem-shaper is *persistence of an unsaturation witness* under an
extension that retains old events and edges: later documentation must not be able to rewrite
away a dependency already exposed in an earlier base.

That is a Lautman-shaped relative statement, and naming its shape is the borrowing. What it
is not: an identification of causal saturation with completeness, with encapsulation, or
with Simondonian metastability.

There is also a higher analogue the project keeps as a question. A cover of causal
interaction contexts resembles a basis, with restrictions as coordinates — but overlaps and
higher overlaps supply compatibility data that an ordinary basis has no analogue for, and
basis coordinates are unique once a basis is fixed whereas sheaf data require overlap
conditions. The analogy shapes questions; it is not a theorem.

### 39. Lawvere and Grassmann: coordinates or generation

Where Lautman asks which decomposition and relative to what, the Lawvere–Grassmann pair asks
whether a decomposition is giving **coordinates** in an already available structure or
exhibiting a **generation** of the structure itself. These come apart exactly when the
interesting thing is how the structure became available.

For this project the distinction maps onto a question it has to answer about its own
architecture: when the protocol separates concerns, is it describing a configuration or
constituting one? I would argue it is constituting — the separation is an engineering
commitment that makes certain work possible and certain other work impossible — and that
this is why the separation must stay rigid rather than being renegotiated per episode.

The project's own formulation of the surrounding question is whether a disciplined
separation **enables a new construction** rather than merely supplying another description.
Not every decomposition is generative. That sentence is the whole discipline in one line,
and it is the test the project applies when deciding whether a proposed new layer or
separation has earned itself.

A related caution the project records: the relevant comparison is between *particular
artifacts* and *instantiable rules*, and these are different achievements. Producing one
well-decomposed episode is not producing a decomposition discipline.

### 40. Deleuze: decomposition that keeps routes open

Deleuze's question about decomposition is neither Lautman's nor Grassmann's. It is whether
the resulting conceptual organization **preserves routes to further discovery** or merely
stabilizes a classification.

This is the project's guard against its own success. An organization that decomposes its
domain well enough becomes very good at producing work of the kind its decomposition
anticipates, and correspondingly worse at noticing work it does not. The project's
universal-language ambition is exposed to precisely this: a language whose forms can be
learned and reused across contexts could easily be one that makes the differences between
those contexts invisible.

The project's stated version is that the hoped-for language should preserve the differences
that make contexts productive, and that its adequacy is **relational** — what it enables a
practice to understand, transport, and develop, not its compression or internal elegance.
There is an explicit warning against choosing a measure in order to make compression win.

The associated test is a comparison case rather than a theorem: compare a language that
transfers a construction to a genuinely new declared use with one that only offers more names
for operations already available. Whether a stable organization remains open to further
individuation is, the project concedes, an interpretive research question until the relevant
possibilities and transformations have been specified. I think that concession is correct and
also the most uncomfortable in the inventory, because it means the project's central virtue
is currently unmeasurable.

## T3. The universal language

The project wants something it calls a universal technical language, as the content
responsibility of its Λ layer. Three anchors bear on what that could mean, and two of them
are warnings.

### 41. Leibniz: the characteristic and its refused parts

Leibniz's universal characteristic is the ambition of a conceptual expression whose
**organization supports reasoning**, rather than merely assigning labels to things. The
project takes this as the closest historical horizon for its own "learn once, use
everywhere" intuition.

What is refused is as specific as what is taken, and the refusals are what make the
borrowing usable rather than fantastical. The project does not assume a **final alphabet of
conceptual primitives**, and it does not assume **universal decidability** — no calculus that
settles every question by computation. Both were part of Leibniz's ambition; neither is
available, and the second is not merely unavailable but false in the relevant generality.

What remains after those subtractions is still substantial: that the *organization* of a
representation, and not only its coverage, determines what reasoning it supports. The
project's own version is that a reusable concept supports intelligible operations and
warranted passages between perspectives.

It is worth noting how the project handles the gap between ambition and availability. Rather
than weakening the ambition, it relativizes the universality: Grothendieck and Lawvere supply
the discipline for making universality **relative and transportable** rather than imposed
from nowhere, and universality becomes something progressively earned through successful
transport and renewed use, not completeness declared in advance. That is Leibniz's ambition
with the metaphysics removed and a comparison structure put in its place.

### 42. Peirce: why he declined the universal-language purpose

Peirce's existential graphs are a diagrammatic logical notation, and it would be convenient
for this project to treat them as a prototype of the language it wants. Peirce himself
**explicitly distinguishes their purpose from constructing a universal language for
mathematicians**, and the project records that refusal rather than conscripting him.

I want to dwell on this because it is a model of how the project handles its sources. The
easy move is to cite a historical figure's notation as precedent and let the citation do
argumentative work. The project's move is to cite the figure's own disclaimer, which costs
it the precedent and buys it accuracy. What is borrowed from Peirce is an account of
*reasoning and interpretation* — the four moments of diagrammatic work, the clarification of
concepts by conceivable consequences — and not a finished notation.

This also shapes what the project thinks its language problem actually is. If the problem
were notational, a good notation would solve it. Because the problem is about which passages
between perspectives are warranted, notation is downstream. The project's separation of the
two questions follows: witnessed equivalences between presentations of a concept are one
thing; reusable patterns connecting concepts that are *not* equivalent are another. The
second is where the interesting content is, and no notation supplies it.

The project's associated image is of a few recognizable islands rather than one global
quotient — and the accompanying caution that an island may retain nontrivial symmetry and
several presentations, since a connected groupoid is not necessarily contractible.

### 43. Grothendieck and Lawvere: universality made relative

The mathematical half of the universal-language question is portability: for a declared class
of context changes, which constructions and truths transport coherently?

The project has one precise answer available and is careful about its scope. Inverse-image
functors of geometric morphisms preserve **geometric logic**, and classifying topoi organize
models through exactly this transport. That supplies one rigorous meaning of portability. It
does not supply a requirement that all legitimate mathematics be geometric, and the project
says so: stronger operations can be portable under a narrower class of context changes.

Alongside it sits a candidate account of reuse without case-by-case producer authorization.
A suitable inductive or higher-inductive universal property specifies maps into targets
equipped with the required constructor data and coherences, with uniqueness expressed in the
homotopical setting as contractibility of the appropriate space of structure-preserving maps
— not as a unique map into every bare target. That distinction is not pedantry; it is the
difference between a usable universal property and a false one.

The refusals: a Hoapa application must identify **both** the class of context changes **and**
the required preservation law, and portability alone establishes neither accessibility, nor
regeneration, nor Care. Initiality does not prove practical adequacy or the absence of a
privileged institution. And the relevant Hoapa object, its targets, and their interpretation
remain to be supplied — this is established mathematics with an unbuilt interpretation, which
is the honest description of most of Part II.

## T4. Borrow, work, return, replay

The project's central operation has four moments and a name — borrow, work, return, replay —
and its provenance is genuinely plural. This section exists because a reader is otherwise
likely to assume the cycle is a metaphor rather than a borrowing from proof theory.

### 44. Gentzen and Prawitz: harmony as the shape of the cycle

Gentzen's introduction and elimination rules, and the harmony between them that Prawitz
made precise, describe how a construction performed under assumptions becomes a rule usable
elsewhere. Introduction builds; elimination consumes; harmony is the condition that the two
match, so that nothing is extracted which was not put in.

The project's logical interpretation is this structure read as a practice: **borrow from a
context, work, and return the use as a stable rule.** That is the project's definition of
logic, and the four-moment cycle in its research programme is the same shape with uptake
added at the end. The project also uses the intro-and-elim pair at a higher level, to
describe its own method: the metaphysics is the introduction rule, how one conceives the
logical work, and the test is the elimination rule, how one consumes it.

Cut and substitution matter too, as the account of how a construction becomes usable *in
further reasoning* rather than merely being available. The project widens this deliberately
across scales: Hilbertian axiomatization makes whole theories objects of further mathematical
work, and homotopy type theory makes contextual dependence, witnessed identification, and
transport explicit, with ∞-topos semantics supporting interpretation in a family of
settings.

The refusal is firm and I think necessary: this widening is **not** a historical ladder and
not a derivation of biology from logic. Transfer between settings still requires the relevant
preservation hypotheses, every time.

### 45. Grothendieck: Galois descent as the worked instance

The project's cleanest concrete realization of its own cycle is Galois-theoretic, and it is
small enough to state in full.

Take a separable quadratic t² + a t + b over a field k of characteristic other than two.
**Borrow** a splitting field and names r₁, r₂ for the roots. **Work**: the quantity
δ = r₁ − r₂ depends on the order of the names, while Δ = δ² = a² − 4b does not. **Return**:
Δ descends to k, and its square class diagnoses whether the quadratic already splits there.
**Replay**: the result is available wherever its dependencies are met.

What makes this instructive rather than merely illustrative is the precision of its
negative clauses. Computing Δ is not an algorithm for deciding squares in every k. The sum
and product of the roots recover −a and b, which are useful descent controls but not new
information merely because they were computed upstairs. In a finite Galois extension with
group G, invariance under a subgroup H supports return to the fixed field of H, **not
necessarily all the way to k** — the return may be relative to an intermediate context. For
objects rather than elements, coherent descent data are required, not merely an assertion of
invariance.

And the clause the project most insists on: **reversible Galois transport alone is not
evolution.** Borrowing names, working, and descending is a complete cycle that produces
nothing new. Deriving a construction uniformly over a generic family of quadratics is a
further achievement; so is developing a new reusable expression followed by an independently
admissible new use. Those are the project's candidates for contextual renewal. Transport is
not one of them.

### 46. Lautman: why the cycle resists a single assignment

The tempting way to place the cycle is to assign its moments to domains: metaphysics
borrows, mathematics works, physical and social reality is where the debt is repaid. The
project explicitly rejects that assignment, and the rejection is a Lautmanian point about
the double movement running transversally rather than once.

The cycle runs **through** the Lautmanian movement and recurs **within** its stages. A
mathematical theory borrows a problematic field, works through effective constructions, and
returns a new articulated problem-space. A communication process borrows a contextual
affordance, performs situated work, and returns an accountable artifact plus a changed
context. Metatheoretic or reflective work can then take either construction as its own
object. No stage is the borrowing stage.

Two further orderings matter. **Work and the preservation of future viability are primary**;
replay and inheritance are possible *consequences* of a successful return, not definitions of
the work. An organization that performed valuable work whose results were never taken up has
not thereby failed. And the recurrence of one abstract work pattern across mathematical,
physical, ecological, and communicational domains is **abductive evidence**, not a
demonstrated scale-invariance theorem — a distinction the project states explicitly, and one
that a reader encountering the recurrence for the first time will be inclined to overlook.

## T5. Closure and self-maintenance

Two biological sources bear on how replay's connections collectively sustain the capacity for
activity. Both are borrowed as question-generators with their biology left behind.

### 47. Kauffman: three closures as questions

Kauffman distinguishes three closures, and the project's use of them is a table of questions
rather than an adoption of the biology:

| Biological closure | Dependency at issue | Question for this project |
|---|---|---|
| Constraint closure | Constraints on processes are maintained through other constrained processes | Does organized work sustain the structures enabling further work? |
| Work-task closure | Interconnected productive activities accomplish the maintenance of the enabling organization | Are the necessary activities actually carried out, rather than merely specified? |
| Catalytic closure | The reaction organization supplies the catalysts its productive activity needs | Does work produce reusable means facilitating further production of such means? |

The middle question is the one I would single out, because it is the one an architecture can
fail silently. A protocol can specify every activity needed to maintain itself and still not
have them performed, and nothing in the specification will reveal the gap.

The refusals, again, are load-bearing. These are overlapping aspects of one organization and
**not** the borrow, work, and replay stages respectively. The last column is the project's
proposed comparison, not Kauffman's claim. A lemma is not literally a catalyst. Kauffman's
account is recorded as proposed, not as a settled definition of life. And at present these
are specifications for investigating replay's organization, not an accomplished
generalization of anything.

### 48. Montévil and Mossio: closure of constraints

Montévil and Mossio's account of organization as closure of constraints adds a temporal
structure Kauffman's does not make explicit: constraints remain **relatively conserved**
during the processes they constrain, while themselves depending on other processes for
maintenance at longer timescales.

The project's borrowing is a precise one. An enzyme-mediated transformation proceeds under
locally available conditions without reconstructing the organization that supplies them —
and the mathematical analogy concerns exactly that **local reliance**, not an identity
between inference and metabolism. The project's organizational reading of its own
separation-and-integration mirror follows: separation lets an activity proceed without
carrying the whole; integration sustains the relationships that make this omission safe and
productive.

The operative question for an interface then becomes: what does it permit local work to
leave outside its account, and which of those dependencies still have to be supported?
**Local omission is not independence from the milieu.** The project's associated comparison
case is to specify which enabling conditions an interface lets work leave implicit, then
compare continued support against its withdrawal, and ask whether the account detects the
resulting loss of capability.

There is also a boundary the project draws that I regard as essential. Mathematics as a
practice maintains languages, skills, records, methods, and tools through which reasoning
remains available — but this does **not** make validity a product of collective agreement.
The network of **justification** and the network of **enablement** are distinct, and feedback
in the latter does not licence circular proofs in the former.

## T6. Care, agape, attachment

The project has a structure it calls Care, two philosophical sources for it, and an honest
account of how little is established. This section states all three.

### 49. Two sources: agape and attachment

Peirce's agape — evolutionary love, the creative principle he sets against mere chance and
mere necessity — and Bowlby's attachment are the project's two sources for Care, and they
contribute different things.

From Peirce the project takes the idea that a community of inquirers is **together
performing agape**: that the sustaining of inquiry is itself a form of love rather than a
means to an epistemic end. From Bowlby it takes the operational shape: the bond that permits
exploration and return, generalized as an algorithm for network continuity across biology,
psychology, and evolution.

The two are not interchangeable. Agape is about the character of the relation among
inquirers; attachment is about the conditions under which venturing is possible. The project
needs both, because an architecture could sustain exploration while being indifferent among
its participants, or could be solicitous while making exploration impossible.

A refusal that belongs here, taken from the Simondon material but applying to Care directly:
Simondon's own account of good form **already includes** preservation and renewed capacity.
That criterion should therefore not be attributed to the project's Care anchor alone, as
though Care were what introduced it. This is the kind of accounting error an inventory like
this exists to catch — a criterion arriving from one source and getting credited to another
because the second is more central to the project's self-description.

### 50. Care as reciprocal role duality, and what gates it

In the conjecture, the community is K, and **Care is structurally represented by reciprocal
role duality**: the involution that swaps the two sides of a session, so that every
participant's position has a dual occupied by another. The checked anchor is the duality
operation itself, written `(–)⊥`, with involutivity among the landed results.

Reading that involution as the developmental work of love or agape is a **conjectural
adequacy claim**, and the project states what it depends on: in part on the no-leak family of
results, rather than being established by the involution alone. That dependence is the whole
honest content of this entry. An involution is a thin structure; what would make it Care is a
theorem that the architecture does not expose, consume, or rank its participants, and those
theorems are at various stages of not existing.

What exists: invariance of the raw validator under injective relabelings of the actor
channel, and its permutation specialization. What does not: realized actor-base equivalence,
invariance of trusted observations, per-conversation pseudonymization as a change of actor
base, and any theorem that no trusted observation can define a ranking. The current code
simply omits ranking structure and actor classifiers — which is a design discipline, not a
proof.

I will state my own view plainly, since the project's files already imply it. Care is
currently the least mathematically supported and most architecturally consequential thing in
the project. An involution cannot select, cannot maintain, and cannot refuse; and the
project's own identification of a missing **selection** mechanism — variation and inheritance
are specified, selection is not — lands closest to here. That is a gap worth stating in a
document meant for outside readers, not one to be smoothed over.

## T7. Saturation and liberation

### 51. The rhythm, and what it is not

Lautman, in Zalamea's reading, supplies a practical rhythm to go with the two
decompositions. **Saturation**: incomplete structures are enriched, completed, or globalized
— enough relations, distinctions, modalities, or coordinates are added to articulate a
problem. **Liberation**: a more mobile invariant, notion, or interface is then released from
the enriched construction and becomes usable in another context. The project's gloss is that
this is the rhythm by which a context completes enough structure to release new forms.

What the project takes is a two-phase account of how a reusable form comes to be, which its
cycle otherwise lacks. Borrow, work, return, replay describes a passage; saturation and
liberation describe why there is something to pass. The pairing with the project's own
treatment of forgetting is natural: purpose-relative forgetting resembles liberation —
abstracting from a presentation, quotienting irrelevant detail, extracting an invariant that
can travel — provided the forgetting states what it preserves, what it hides, and for which
future operations it is adequate.

Three refusals, and they are not minor. First, and most important, the project's technical
**causal saturation** in K is a different predicate with an unfortunate name overlap: it says
that every globally witnessed causal relation between events of a conversation is generated
internally to that conversation. It is not Lautmanian saturation, and it is not Simondonian
metastability either. Second, universe stratification and typing can control paradoxical
self-totalization, but they do not by themselves convert an endless hierarchy into a
philosophically regenerative infinity — typing alone is not a resolution of bad infinity.
Third, Zalamea's own footprint in this project is thin: two glosses and a reading of Lautman.
The rhythm is borrowed; the full account of mathematical transit that Zalamea develops is
not, and a reader should not take its vocabulary here as evidence that it has been absorbed.

---

# What the project declines to borrow

Collected in one place, because the refusals are the discipline and because they are
distributed across many entries above. Each of these is a reading the project has
considered and rejected, not a strawman.

**From the philosophical anchors.** That the participant layer is analytic and the
documentary layer synthetic, as an exhaustive assignment. That either M or K is "the
synthetic side." That unityped means untyped, or dimensionless. That Lautman's synthetic
decomposition decomposes the *person*, or that a selected panel is a basis of a population.
That every departure from unityping flips the decomposition. That the project's mediating
adapter is a Lautmanian mixte. That metatheory is dialectic. That Simondonian metastability
is the project's causal saturation. That Care's criterion of preservation-with-renewal
originates with Care rather than with Simondon's account of good form. That typing alone
resolves bad infinity. That Hegel's Absolute Idea is retained. That Peirce's existential
graphs prefigure the project's language. That Leibniz's final alphabet of primitives or
universal decidability is assumed. That Deleuze's intensive is the virtual, or that the
extensive is the documentation. That recurrence of one work pattern across domains is a
scale-invariance theorem rather than abductive evidence.

**From the mathematics.** That sheaf descent proves there is no privileged point of view.
That the existence of a contextual transpose supports the conjectured adjunction, when every
adjunction supplies one. That naming a representable profunctor constructs a mediator. That
one dessin can verify naturality, triangle identities, or iteration. That numerical
resonance is symmetry. That a participant is a test object, that `Hom(T, X)` is a
conversation, or that a conversation is a matching family. That a random panel is dense in a
population, or that a documented context is automatically the colimit of its conversations.
That unanimity is sheaf amalgamation, or separatedness accountability. That gauge invariance
makes the project a field theory. That actor-renaming invariance makes every identifier
meaningless. That a changed site establishes renewal, when different sites can present
equivalent topoi. That an enabling cycle is a comonad. That an adjunction supplies
evolutionary dynamics. That persistence establishes optimality.

**Methodologically.** That generality may be asserted rather than earned: the test is to name
the concrete case that forced the general definition, and failing it means decorating rather
than generalizing.

# Anchors not inventoried here, and why

Several figures appear in the project's neighbour tables without being borrowed in the sense
this document inventories. They contribute framings or technical structures rather than
concepts the project has transformed, and including them would have reproduced the tables
instead of documenting a practice.

**Whitehead** contributes reality as events and becoming rather than a substance-first
inventory, absorbed as multiplicities forming through successive occasions. **Maturana and
Varela** contribute autopoiesis, absorbed as language-types that are self-maintaining
disciplines of action — close to T5, but entering through the tables rather than through a
worked question. **Cassirer and Goodman** contribute symbolic forms and world-versions,
absorbed as worldmaking treated structurally rather than culturally. **Abramsky** contributes
contextuality: local views need not glue to one hidden global story, with obstruction read as
information rather than failure. That one is arguably a genuine borrowing and I considered an
entry for it; it is left out because the project treats it as a mathematical structure in its
own right rather than as a concept it has transformed.

On the logical side, **Martin-Löf** supplies propositions-as-types and identity-as-structure,
**Girard** resource sensitivity and controlled copying, **Tarski** truth-preservation across
interpretations, **Reynolds** local reasoning about separated resources with the frame rule,
and **Dewey** the logic of inquiry alongside Peirce. These are the project's working
languages rather than its anchors. The substructural family in particular is used
architecturally: linear discipline for orchestration, relevant for provenance, affine for
one-shot channels, ordered for protocol sequencing, bunched for locality. A separate document
could inventory that layer; this one does not.

**Hersh** is named in the project's own files as a social anchor for mathematical praxis
alongside *Récoltes et Semailles*, and has no entry of his own here. I note the omission
rather than resolving it: either he warrants one, or the project's wording is loose. On the
evidence of the files I lean toward the former.
