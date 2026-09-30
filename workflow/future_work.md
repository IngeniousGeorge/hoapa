# Future Work

Selected research obligations, candidate investigations, and deferred
implementation work, with their evidence levels kept distinct.

## Reader's note

This file documents four kinds of future work:

- *Selected research programme.* The 1C section records the adopted direction,
  named unmet obligations, and criteria for choosing a build; it does not
  preselect M's mathematical mechanism.
- *Punchlist style.* The "Regarding X" sections (iteration, Sessions, actor-causal site, Hybrid) catalogue deferred pieces inside material that has already shipped.
- *Architectural style.* The "Concurrency-side layers of complexity (planned)" section catalogues responsibilities at different maturity levels: committed functions, selected forcing cases, and research horizons. It is prose-heavy, structured around a Function / Math anchor / Trigger / Open questions / Agda slot rhythm, and is calibrated to be readable by both future Claude/Codex agents picking up the project and humans being shown the work.
- *Candidate-investigation style.* The provenance, no-leak theorem ladder, Reality, and logical-presentation sections record structures whose absence or possible role has become visible but whose exact mathematical ownership is not settled. They state the motivating gap, nearest established mathematics, anti-overclaim discipline, falsifying tests, and decision gates. They do not alter the committed cascade or reserve implementation modules.

Selection of a programme is not proof of its hypotheses. Punchlist items
extend shipped material; architectural entries state their own maturity;
candidate investigations may be promoted, revised, split, or rejected.

For the seed-level commitments, see `motivation.md`; for T_comparison and
the other proposition-level targets, see `targets.md`. The implementation
track remains canonically tracked in `status_implementation.md`.

Status snapshot, 2026-09-26: K's banked waterline and the 2S/3R dependency
sequence are unchanged. 1C now rebuilds M through relational adequacy and the
categorical essence of K, not through a prescribed repair of cohesive HoTT.
See `current_track.md` for priority and `status_formal.md` for proof status.

## Selected 1C programme: relational adequacy and the M rebuild

This programme is selected; its mathematical mechanisms and first build are
not. Its objective is a useful, non-circular account of the special adequacy
of Hoapa-like organization **to contexts and their renewal**. The newer
mirror/generation–description sketch is an organizing candidate, not another
set of prerequisites. See
[arc/18's synthesis](arc/18_evolutionary_adjunction.md#session-consolidation-2026-09-26).

### A. Extract K's categorical essence

Make a clause-and-interface inventory from `architecture.md`, the Agda
interfaces, and the intended extensions recorded here. For each clause give:

- its intrinsic job, before choosing a categorical name;
- objects, morphisms, and universal property if one is available;
- its status: checked (with hypotheses), architecturally specified, or proposed;
- what a meaningful change of that clause would change;
- the contextual capability or future use it supports.

Starting material includes strict-reflecting local views; Set-valued locality
and linear/session-valued content connected by R4; actor-channel invariance;
and persistent, independently reusable publication. These are not four equally
banked axioms: Tier A is raw-validator invariance, R4 has a supported
point-generated scope, and closure/publication and observational no-leak are
still open. Do not turn this inventory into a completed category of
architectures by declaring a record alone.

The stated Lautman-facing interpretation takes **understanding of the world**
as the decomposed subject: embodied understanding organized predominantly
synthetically through unityped participation, and documentation predominantly
analytically through typed concepts and relations. Both moments occur in both
realms; this does not designate M or K as exclusively synthetic or analytic.
Neither the person nor the whole context is exhausted by represented work.
See [the interpretation and its architectural counterexample](related_structures.md#lautman--analyticsynthetic-decomposition-and-recursive-incarnation):
output-dependent formal standing violates the intended common interface,
whereas differing assessments of contributions need not. Test that boundary
without claiming every typed rival lacks synthetic organization. The exact
categorical essence remains a research result, not this initial list.

### A1. Alternatives and the comparison setting

Use `bias_correction.md` as an explicit source of previously considered
alternatives, without editing it: identity-refining actor schemes, identifying
the R4 endpoints, collapsing local-view maps, treating dependencies as paths,
closure-as-consensus, and global actor directories. Some are architectural
alternatives; some are ill-typed identifications until redesigned. Establish
their coherence rather than importing the rejections as ready-made objects.

That history explains where the examples came from; it is not a proof of
non-circularity. State capabilities independently of Hoapa's implementation
choices, allow alternatives to satisfy them, and compare under the same
contextual requirements. A requirement such as "an artifact is usable when its
producer is unavailable" is different from "every architecture must implement
Hoapa's organization."

Construct the ambient comparison objects and morphisms, including inferior,
incomparable, and unsuccessful cases. The objects may be architectures,
world/practice pairs, or correspondences; this choice must not silently
replace operational K by a category of architectures. Clause deletion is a
useful test, not the definition of the whole comparison class.

### A2. Independent siblings

Use `related_structures.md` for the sibling inventory and clause cross-index:
categorical essence, ambient, universal property if known, what changes with
a clause, and the exact relationship to K. Physics, chemistry, ecosystems,
and cognition are search domains, not required successes. Galois
reconstruction and nominal methods are further mathematical leads.

Start with analogues in their own settings. Showing that two siblings inhabit
one common comparison category is an additional theorem. Independent examples
can guide definitions and challenge accidental choices; resemblance alone
does not establish that Hoapa is optimal.

When §A produces or revises the clause inventory, re-index the sibling
catalogue and clause-to-failure crossing in `related_structures.md` against
it. The current rows are provisional prompts, not the extracted essence.

### B. Seek the comparison structure

The primary target is `targets.md` §T_comparison. Prefer a universal property
or a representation/factorization theorem. Attained bounds, robustness under
changes of assessment, and deformation rigidity are alternatives to explore,
not a requirement to manufacture a scalar.

Engineering supplies candidate capabilities: reusable interfaces, independent
replacement, compositionality, provenance, intelligibility, and maintained
room for further work. Test which are consequences of an organization rather
than writing "clean design" into the definition of the winner.

Extract an invariance list and ask what it forces. Invariance may force a
factorization without uniquely determining a measure. A theorem characterizing
a measure is not yet a theorem characterizing architectures. State sufficient
conditions separately from necessity/no-go claims. The theorem should concern
a class; checking Hoapa's membership is a separate task.

### C. Rebuild M and its variability together with comparison

M must carry independently meaningful contextual structure that work can
encounter, articulate, and change. It is neither a preselected cohesive topos
nor a metalanguage whose sole content is explaining Hoapa.

Investigate whether the transformations organizing contextual variation also
induce the comparisons of adequacy. P is a provisional name: an indexed
category, correspondence, category of elements, moduli construction, or other
organization may earn the role. Do not define it by successful adjunctions or
optimal architectures alone.

Keep within-regime work distinct from transitions between regimes. For a
fibred candidate, specify base arrows, reindexing, and comparison squares
before naming Beck–Chevalley obligations. Coherent transport does not force a
family to be constant; failure of coherence is not a prerequisite for
evolution. This programme can investigate both scales without asserting a
constructed bridge between them.

**Mirror investigation — reciprocal induced structure.** Restated T4 asks
whether K's separations enable integration on M, and whether M's integration
capabilities induce further separations, particularly within documentation.
"Secondary" means induced, not subordinate or temporally later. The surface
both distinguishes reality from its understanding and connects them; M need
not model participants' interior lives. The detailed examples, comparison
cases, and consolidated technical distinctions live in
[arc/18](arc/18_evolutionary_adjunction.md#the-mirror-separation-integration-and-reciprocal-induced-structure).

For each candidate, specify the K-side separation, the M-side capability,
the construction relating them, the distinctions it preserves, the
compatibility law, and a comparison case testing whether the separation
actually matters for the declared use. A successful rival is an informative
outcome. Seek definitions under which the induced effect follows from a
universal property or preservation theorem; adjointness alone does not supply
it. No additional adjunction or first build is selected by this sketch.

**Rising sea — separation and integration as two faces of mathematical
understanding.** Explore the intuition that Grothendieck's preference for the
rising sea expresses the correspondence sought between K and M: respecting the
distinct responsibilities of mathematical structures makes possible a
surrounding setting in which they integrate naturally; discovering that setting,
in turn, reveals which distinctions matter. The refusal of the hammer and chisel
would express a reluctance to force a result through an organization not yet
adequate to its subject. Raising the sea would mean developing the context until
the relationships among its constituents carry the solution — and enable further
mathematics beyond the original problem.

In this reading, K's separations and M's integrations are not successive stages
or fixed compartments. They develop together. The rising-sea method is the
activity moving between them: articulating distinctions, discovering their
relationships, and returning a more resourceful context for subsequent work.
This is a candidate interpretation of the mirror, particularly on the
documentary/conceptual side, not a claim that Grothendieck implemented Hoapa's
social architecture.

When this direction becomes active, seek concrete instances where an improved
separation enables integration, or an integrating construction reveals a missing
distinction. Universal properties and descent offer starting points. The
correspondence remains an intuition to develop and test, not independent
evidence for optimality, since Grothendieck's method already helped shape the
project.

### D. Borrow–work–return–replay and renewal

For each candidate, say what is borrowed, what work can do, what returns, and
which later operation consumes it. A hom-set transpose supplies a contextual
presentation, not by itself adequate replay. Test preservation of declared
achievements together with a genuinely newly admissible operation.

**Particular artifact versus instantiable rule.** Investigate the distinction
between returning witness-plus-result data (a dependent-Σ candidate) and
returning a construction uniform over inputs (a dependent-Π candidate).
Specify the family and the variance before using either interpretation.
Publication is not automatically Σ, and the Reflexive Π layer name is not a
dependent-product theorem. In a comprehension setting, absence of a right
adjoint Π to a particular reindexing functor could obstruct uniform return;
it is not automatically the same thing as counit loss.

**Directedness — named open question.** K has causal parents, causal
local-view maps, directed documentary dependencies, and only selectively
invertible comparisons. What does each candidate correspondence preserve,
forget, or invert? Test a noninvertible transition. HoTT's identity paths are
invertible, but categories and directed structures can be defined within
HoTT; an ∞-topos does not mean that every map is invertible. The question is
a selection aid, not a new hard requirement that M use directed type theory.

### E. Concrete obligations and build selection

No first build is selected. Select a bounded obligation for which:
(1) the claim and independent assumptions can be stated;
(2) a positive instance and an informative negative/variation control exist;
(3) a named missing type or failing check can precede implementation; and
(4) the outcome changes a decision about the essence, comparison, or M.

A comparison witness must be capable of distinguishing its proposed
architecture from a meaningful rival. A grammar/control lemma need not compare
whole architectures, but must test the interpretation it is used to support.
Reject vacuous witnesses, not useful small results. The next session should
choose one entry, name its red obligation, and say what either outcome teaches.

**Observation-relative sufficiency — finite candidate.** Let X be a finite
set of episodes and O a finite family of observations with decidable equality
of outputs. Define x ≈O y when every observation agrees, and q : X → Q_O as
the quotient. For a finite, image-normalized publication d : X → D
(surjective onto D), define Adequate_O(d) to mean that every o in O factors
through d. Proposed obligation, in mathematical type notation:

```text
observation-quotient-universal :
  (d : X → D) → Surjective(d) → Adequate_O(d) →
  Unique (r : D → Q_O) such that r ∘ d = q
```

The object Q_O, its own adequacy, and this factorization must be constructed;
this is a **named unmet obligation, not an Agda declaration or a checked
result**. Using all of D without surjectivity would make uniqueness wrong;
alternatively work on the image of d. A two-bit episode observed through its
first bit separates q from a constant, inadequate publication. Adding the
second-bit observation supplies a refinement test.

Include a rival with the same public answers but mandatory producer
authorization for reuse. The observation quotient alone cannot distinguish
it: add a declared future operation and an access/capability interface, then
test producer-unavailable reuse. This limitation is part of the candidate's
value, not a reason to claim that sufficiency already proves Hoapa optimal.

Refining O gives maps between its quotients. Investigate this as a small
fragment linking contextual variability and comparison, not as an already
built P or full Tier D theorem. For any probability law on finite X,
adequacy implies H(d(X)) = H(q(X)) + H(d(X) | q(X)); the structural
factorization comes first, and the inequality holds for every such law.
No probability model is thereby chosen for Hoapa.

**Clause-sensitive adequacy — candidate.** After specifying a common context
c, future use u, and architectures A and B, seek:

```text
clause-separation-witness :
  Adequate(A, c, u) × ¬ Adequate(B, c, u)
```

Construct both architectures and their common requirements before inhabiting
this schematic type. If both are adequate, that is evidence against the
proposed distinguishing clause. A record listing clauses with the conclusion
as another field is not the sought result.

**Contextual renewal — candidate.** Exhibit an artifact, a transition p → q,
preservation of named earlier uses, and a use available at q but not p.
The admission rule must be independently justified, not defined to certify
that particular artifact. This can be tested at toy scale without waiting
for the 3R implementation; later runtime realization is a separate obligation.

**Modal non-degeneracy — conditional candidate.** If a proposed replacement
actually has a modal predicate, name the obligation:

```text
proper-modal-fragment : Σ (A : Universe), ¬ IsModal(A)
```

Here the modality and universe belong to the selected model; the old analytic
delooping witness is a comparison case, not an axiom imposed on every possible
M. Under the old unrestricted flat signature this obligation conflicts with
the all-types-flat derivation. No modal predicate is required of non-modal
candidates. Neither this declaration nor the clause witness is added to Agda
by this documentation update.

### F. Candidate mathematical resources

- **Generation and description:** monads with arities is the lead literature
  test for the two-correspondence sketch, not a chosen model of K. Identify
  arities, free structure, probes, and a nerve-image condition. See arc/18.
- **Pairing and representability:** name what world/practice interaction
  actually is before seeking a profunctor or its representing functors.
  Doctrine-scale correspondence and work within a regime are separate
  constructions until their compatibility is specified.
- **Stable cores and inheritance:** investigate fixed-point or mutually
  adequate fragments as possible homes for reliable inheritance, with
  evolution between regimes. Do not require every local closure to remain
  non-idempotent. Distinguish Chu biextensional collapse, Isbell/concept
  completion, and the Pavlovic–Hughes nuclear-adjunction construction.
  Existing Chu code does not implement these constructions.
- **Entropy and quantitative comparison:** distinguish actual distinctions
  lost, future-use adequacy, statistical reconstruction, and leakage.
  BFL-type information loss, information cohomology, and diversity are
  candidates with different inputs. State the probability/observable/similarity
  data where required; no probability model of Hoapa has been selected.
  A fulfilled entropy chain rule is not an obstruction to gluing. KL is not
  a Lawvere metric without an additional construction.
- **Quantitative no-leak:** g-leakage/min-entropy approaches are candidates,
  with a stated secret, observer, channel, and gain/task. Seek comparison
  robust across a declared class of priors or tasks, rather than a privileged
  distribution. Identity neutrality does not require contributions to be
  statistically independent of contributors.
  Primary source: [Alvim–Chatzikokolakis–Palamidessi–Smith](https://homepages.dcc.ufmg.br/~msalvim/publications/2012-CSF.pdf).
- **Relative cohesion:** reusable candidate for a relation between settings,
  not an automatic return to the discarded M prescription. An adjoint
  quadruple requires more compatibility than two unrelated adjunctions;
  appropriate categorical/topos hypotheses are not yet available for K.

### G. Anchors as working methods

Lautman asks which problematic relations and synthetic/analytic decompositions
the effective mathematics realizes. Simondon asks whether individual and
milieu can become determinate together while leaving possibilities for further
individuation. The rising sea asks for the surrounding setting in which the
comparison becomes natural. Grothendieck's relative point of view, descent,
reconstruction, deformation questions, and later work on organizing families
are tools to investigate, not a demand to recover an arithmetic tower.

These anchors guide definitions and interpretations. They do not replace the
obligations above. Existing Care-as-inheritance and viability candidates remain
open.

## Legacy modal diagnosis and retired work orders

The unrestricted `flat-intro` and dependent `flat-ind`, with their β-rule,
derive that `flat-counit` is an equivalence for every type. The intended
flat-modal fragment therefore becomes the whole universe. This diagnoses
loss of that intended distinction, **not Booleanity**, decidability of every
observation, or failure of cohesive mathematics in general.

Retain the proposed named diagnostic `everything-is-flat-modal` when this
control is formalized; it is not reported as a newly checked lemma and does
not take precedence over the programme above. The existing analytic
`¬-IsFlatModal-delooping` remains a checked contrast under its own definitions.

The old repair-first, named-coefficient/de Rham, differential-cohesion, and
cyclic-bar work orders are retired from the selected programme. Their pre-edit
text is preserved in
[the migration archive](deep_context/abandonned_modal_side/workflow/README.md).
The Agda files remain in place; generic constructions can be reused at their
actual strength.

## Regarding T_recursion iteration

`formal/ModalHoTT/Modalities/Iteration.agda` lands the generic endofunctor-and-
unit scaffold for T_recursion: iteration `T^n`, iterated unit `η^_n`,
`η^-coherent` derived from postulated naturality, and the sequential-colimit
type `ND A`. It does not bundle a counit, multiplication, or triangle
identities. `IterationCohesion.agda` specializes it at ʃ ⊣ ♭ and checks the
stage-one collapse. Because the surrounding signature already makes every type
flat-modal, this is now a degenerate control. It has no evidential weight for
the intended cohesive semantics or the cross-site conjecture.

Pieces deferred:

- **Dual on the concurrency side.** A symmetric module would iterate the
  *counit* of the comonad `L ∘ R` on the target side, taking the *limit* of a
  decreasing tower `… → M²B → MB → B`. Not written: until the independently
  constructed cross-site adjunction and a non-trivial `ND` exist, the dual is
  a duplicate of an empty scaffold. Do not postulate the cross-site bridge to
  unlock it.

- **Cyclic-operad involution.** The 1=2 perspective-swap "cared-for = caregiver" would be a path constructor (or separate HIT) on top of `SeqColim`, encoding that the iteration is cyclic / self-dual on each level. Deferred for the same reason as the dual: adding the involution to a scaffold that hasn't yet produced non-trivial iteration content is premature.

- **`η-naturality` postulate.** Load-bearing for `η^-coherent`. Same shape and same resolution path as `shape-flat-natural-B` in `Properties.agda` — becomes a theorem once adjunction-naturality is recorded (status_formal.md Open Questions). Not new scope; folds into the existing naturality gap.

- **Full sequential-colimit convergence.** Applying `η-equiv-at-T` at each later iterate shows by induction that all structure maps after stage one are equivalences. The mathematical conclusion `ND A ≃ T A` is therefore known; what remains is formalization, not an open mathematical question. It requires a "convergent sequence has colimit at the convergence point" lemma against cubical's `Sequence` / `SeqColim` infrastructure (`Cubical.Data.Sequence.converges`). This is straightforward but heavier than the checked step lemma and should return only if a downstream use forces it (for example, a comparison with the dual on the concurrency side).

## Regarding Sessions and the canonical O_1 action

`Concurrency/Algebras/Sessions.agda` v1 landed with the `O_1` action (`gen`, `plug`, `shift`) packaged as explicit data rather than derived from the current categorical structure. This is the right current shape. The present `StarAutonomous` signature is intentionally thin: it has tensor, unit, braiding, duality, and local iso laws, but not the closed/evaluation structure or coherence needed to construct interaction composition canonically.

What shipped: a `SessionO1Action` record containing `gen-morph`, `plug-morph`, `shift-morph`, and the six laws mirroring `O`'s path constructors. `Sessions.agda` constructs `Valuation` and `OperadAlgebra` from that action, defines `session-interp` by HIT recursion, and names both R8 faces: syntactic `dual-involutive` and categorical / operadic `boundary-swap-at-gen`. This is better than loose postulates and does not pretend the action is intrinsic to session syntax alone.

The eventual quality target is stronger: replace the action assumption with a canonical definition from categorical/session structure. That should come back as a priority when the project reaches a richer session-category phase, after enough hybrid integration clarifies what the value-category morphisms mean operationally, but before serious `MO_1` / modular-envelope work.

Expected ladder:

1. **Done:** split the Sessions layer. `SessionSyntax.agda` now owns the
   postulate-free object grammar, `SessionMorphismSyntax.agda` owns the
   set-truncated morphism HIT, and `Sessions.agda` packages the remaining
   explicit `SessionO1Action` assumption.
2. **Done:** build the Sessions-to-target realization. `SessionObjectModel.agda`
   defines `J0`, `J0-dual`, `J1`, and the underlying Cubical functor; the
   `Chu(SET,Bool)` instance lives in `SessionChuModel.agda`.
3. **Done at finite-descent, finite sheaf-category, point-generated R4, and
   Chu-coefficient level:** Hybrid integration now has arbitrary-frame
   `FramePresheaf` / `SessionPresheaf`, zero-postulate separatedness,
   category-generic finite products, finite frames/covers, category-generic
   finite event-product descent, the constant-slot Sessions sheaf, proof-level
   tiny finite-cover validation, the V-valued finite sheaf/value category, and
   the framework-at-`SET` finite sheaf category with a concrete Set
   event-product object. The finite Coverage/library comparison has landed,
   and R4 now has the Benton/LNL presheaf bridge, right-adjoint sheaf
   preservation, a finite-sheafification interface, a conditional full
   finite-site sheaf-level adjunction, the point-generated supported reflector,
   the point-generated supported bridge `Lpoint ⊣ Rpoint`, and a concrete
   `Chu(SET,Bool)` coefficient witness.
4. Richer session category: add proof terms or an equivalent categorical
   semantics, cut as composition, cut-elimination/equality, closed
   structure/evaluation, and enough tensor/braiding coherence to manipulate
   long tensor strings.
5. Canonical `O_1` action: define `SessionO1Action` rather than assume it.
   `shift` should come from coherent cyclic permutation of tensor factors;
   `plug` should come from closed/evaluation/cut structure composing two
   morphisms into the dualizing object.
6. Only then push hard on `MO_1`: extend the canonical `O_1` action toward
   self-gluing and modular closure. This does not supply the runtime promotion
   interface, which is publication plus typed reference.

Practical trigger: when the session target can state and use an evaluation/cut map of the form `eval : Hom ((A ⊸ B) ⊗ A) B` (or the equivalent polycategorical/sequent form) and can coherently rotate tensor factors, the deferred derivation of `gen`, `plug`, and `shift` should return to the top of the concurrency queue.

## Regarding the actor-causal site

`Concurrency/Sites/{ActorBase,ActorCausal}.agda` v1 landed the R6 locality leg: opaque unityped actors, Lamport-style event causality, actor-local frames, strict-reflecting `FrameHom`, basis-form covers, `sieve-of`, generic identity / transitivity cover constructions, and constructive tiny frame/cover witnesses. `TinyActorBase.agda` now owns the postulate-free two-actor base, and `TinyActorCausalSite.agda` assembles the bundled tiny site using `ActorPullback.agda`'s constructed stability path. The actor-causal site no longer contains a real project postulate.

Pieces deferred:

- **Full-site pullback / stability presentation.** `ActorPullback.agda` gives the generic pullback frame construction and `stability-cover-pullback`, and the bundled tiny site now uses that constructed path. What remains deferred is not a legacy fallback but the broader presentation work: decide when the non-finite actor-causal site needs a full generated-sieve Grothendieck topology rather than the current basis-form `Cover` plus `sieve-of` bridge.

- **E2 sieve / Grothendieck topology presentation.** On the finite subsite, the library-site presentation has landed: `FiniteBasisCover` strips finite covers to base-stable covering-family data, `FiniteFrameCoverage` gives a Cubical `Coverage` over `FiniteFrameCategory`, and `SetSheafComparison` proves the SET sheaf-condition agreement. For the full non-finite actor-causal site, `Cover` remains basis-form and `sieve-of` remains the bridge artifact; add a full generated-sieve topology only when a later construction needs the non-finite site.

- **Promotion interface.** Strict `FrameHom` reflection deliberately prevents
  quotienting or reifying a sub-conversation as a single event or actor.
  Promotion is now publication of a closed output through a stable artifact
  interface plus a reference from later work. No additional collapsing frame
  morphism is planned. `MO_1` may eventually organize self-gluing at another
  layer, but it does not change this substrate boundary.

- **Richer concrete site witnesses.** The bundled Bool tiny-site is now postulate-free. Future witnesses should add genuinely richer actor/event/causality shapes, not merely re-prove the two-point case.

## Regarding Hybrid finite descent, finite sheaf categories, and next sheaf steps

`Concurrency/Hybrid/{Presheaf,SessionPresheaf}.agda` remains the arbitrary-frame adapter layer: generic restriction along `FrameHom`, zero-postulate separatedness as a property, and constant Sessions witnesses. The fast-track finite layer is now separate, stronger, and category-generic:

- `Concurrency/Algebras/CategoryApplicative.agda` gives the applicative-law view of any Cubical `Category`; `StarAutonomousCategory.agda` remains the adapter from the thin session value-category signature to Cubical `Category`.
- `Concurrency/Algebras/FiniteProducts.agda` is now finite products over an arbitrary Cubical `Category`; `SetFiniteProducts.agda` instantiates it at `SET`.
- `Concurrency/Sites/FiniteFrame.agda`, `FiniteFrameCategory.agda`, and `FiniteCover.agda` define the finite-frame subsite as a Cubical `Category` and finite covers with carried overlap enumerations.
- `Concurrency/Sites/FramePullbackUniversal.agda` and `FiniteFramePullback.agda` provide the pullback universal property and finite closure under pullback with a chosen enumeration.
- `Concurrency/Sites/FiniteBasisCover.agda` and `FiniteFrameCoverage.agda` define lean finite basis covers, complete them back to `FiniteCover` when descent needs overlap enums, adapt them to Cubical `Cover`, and construct the Cubical `Coverage` over `FiniteFrameCategory`.
- `Concurrency/Hybrid/FinitePresheaf.agda`, `FiniteDescent.agda`, `FiniteFramePresheafFunctor.agda`, and `FiniteSheafCategory.agda` define the category-generic finite presheaf/descent/sheaf-category framework.
- `Concurrency/Hybrid/EventProductPresheaf.agda`, `EventProductSheaf.agda`, and `EventProductSheafObject.agda` define the category-generic constant-slot event-product witness and package it as a sheaf-category object.
- `Concurrency/Hybrid/SessionEventProductSheaf.agda` and `TinyEventProductExample.agda` instantiate the witness on the V-valued/session side through `StarAutonomous→Category`; `TinyFiniteCover.agda` validates the carried-overlap interface on the concrete two-point cover.
- `Concurrency/Hybrid/SetFiniteSheafCategory.agda` and `SetEventProductSheaf.agda` instantiate the same framework at `SET`, giving the canonical framework-at-`SET` R4 endpoint and a concrete Set-valued event-product object.
- `Concurrency/Hybrid/SetSheafComparison.agda` proves the C6 agreement: project SET `IsSheaf` and Cubical library `isSheaf` for `FiniteFrameCoverage` imply each other, with the pullback-UP content isolated from the SET pointwise well-pointedness step.

This is a real finite sheaf landing, but it is deliberately scoped:

- It is one finite descent/sheaf construction instantiated at both `StarAutonomous→Category V` and `SET`; it is not two unrelated descent notions.
- It now makes the framework-at-`SET` side concrete and compares it with the Cubical library `Sheaf` condition for the finite coverage.
- It is constant-slot Sessions and constant-slot Set event products: arity varies by event count, but every event carries the same slot `P₀`.
- It does not claim event-dependent session content.
- It does not claim additive coproduct universal properties.
- It does not by itself claim a full Set-valued locality topos/internal logic or a generic full finite actor-causal reflector. The inhabited bridge currently available is the separate supported point-generated/event-discrete R4 theorem.
- It accepts the `UnsupportedIndexedMatch` warnings in finite-product / finite-enumeration helpers only under the constant-slot / proof-level API discipline.

Validation outcome: the concrete tiny finite cover over the existing `TinyFrame` / `PointFrame` two-point cover has landed, and the Set-valued endpoint now has a concrete event-product object. The carried-overlap `FiniteCover` interface is inhabitable on a non-trivial cover without structural revision, transport machinery, or new postulates.

### Computing witness policy

The target for the tiny finite cover example is proof-level, not definitional, computation:

- Required: propositional restriction/amalgamation equations and separatedness on the concrete cover.
- Optional bonus: definitional or `refl` computation where it falls out naturally from the concrete `Bool` / `Unit` enumerations.
- Do not engineer the example around definitional normalization unless the resulting lemma is reusable beyond the tiny cover.
- Failure to obtain definitional computation is not a weakness of the framework; the finite descent stack is intentionally stated through product universal properties (`bigβ`, `bigη`, `terminal-unique`) and propositional equality.

The global framework should not depend on tiny-cover normalization. R4 and `Allow ⊣ Require` should consume sheaf/category interfaces and proof-level laws; the library comparison is now available as legitimacy for the Set endpoint, not as a replacement for the project endpoint.

Outcome: Option A landed. The witness proves propositional restriction/amalgamation equations and separatedness on the concrete cover. Option B, a definitional or `refl` computing witness, remains a future opportunistic enhancement only if a later example exposes reusable normalization lemmas; it is not required for the framework.

### Event-dependent session slots

Event-dependent slots remain future work, not a blocker for R4 or the adjunction. The current witness works because all projections land in the fixed codomain `P₀`; reindexing along event enumerations is therefore a `cong` in a fixed `Hom` type. A dependent value

```text
value F = bigProduct (event-count F) (slot F)
```

would make projection codomains index-dependent and turn the current `UnsupportedIndexedMatch` warning into a load-bearing transport problem. That cost is intrinsic and does not grow just because we defer it.

The one real deferral risk is lock-in. Guard against it by building all layers between here and future R4 uses generically over:

```text
FiniteFramePresheaf
IsSheaf
```

not over `event-product-presheaf`, `session-event-product-presheaf`, or any lemma that assumes all projections land in `P₀`. Any constant-slot-only lemma belongs inside the constant-slot witness files.

When resumed, event-dependent slots should live in a new module, likely `Concurrency/Hybrid/DisplayedSessionEventSheaf.agda`, leaving `SessionEventProductSheaf.agda` as the clean constant-slot base case. Expected work: define displayed slot families over finite frames, add restriction coherence along finite-frame morphisms, build the dependent event-product presheaf, and reprove functoriality/descent with explicit transports.

### Next sheaf steps

1. R4 tiers 1/1.5/2 have landed: `ChangeOfBase.agda` gives value-functorial finite-presheaf change of base; `LinearNonlinear.agda` states the interface-first Benton/LNL value adapter; `LinearNonlinearSheafAdapter.agda` proves the presheaf-level lifted adjunction and right-adjoint sheaf preservation.
2. Tier 3 still has the generic full-site reflector interface in `FiniteSheafification.agda`, but the constructed route is now the point-generated/event-discrete supported site. `SupportedPointProduct.agda`, `SupportedPointification.agda`, `SupportedPointDescent.agda`, `PointifyIsSheaf.agda`, `PointSheafCategory.agda`, `PointSheafification.agda`, and `PointSheafAdjunction.agda` build the point-generated reflector and prove `a ⊣ ι`.
3. Brick 4 has landed the W3-style point-generated R4 bridge wiring: `PointLinearNonlinearAdjunction.agda` consumes `PointSheafAdjunction.a⊣ι` and assembles `Lpoint ⊣ Rpoint` over point-sheaf categories. This remains scoped to the event-discrete supported site and remains relative to `lnl : LNLAdjunction` plus `vProd : HasFiniteProducts (StarAutonomous→Category V)`.
4. Keep `SetFiniteSheafCategory` as the canonical cartesian endpoint for R4; use `SetSheafComparison` as the proof that this endpoint agrees with the Cubical library presentation at `SET`.
5. Current near-term status after Brick 4: the point-generated R4 theorem, Chu coefficient witness, and Sessions-to-Chu realization are banked. Optional exposition or instantiation checks remain useful, but the active bandwidth has moved to the 2S/3R boundary. Deferred beyond that are normalized-pullback / stability for a full Cubical `Coverage` presentation of the point-generated topology, the full actor-causal finite sheafification reflector, event-dependent session slots, and the modal-context category `M` with cross-site `Allow ⊣ Require`.

## Chu construction

Chu is now live, but still scoped. Benton/LNL remains the right R4 bridge shape because R4 relates cartesian Set-valued locality sheaves to V-valued linear/session sheaves. Chu entered as a concrete value category `V`, not as a replacement for the bridge: `Chu(SET,Bool)` now supplies a postulate-free coefficient model for the point-generated R4 theorem, and Phase 1 builds a Sessions-to-Chu realization over postulate-free session syntax.

**What has landed.** `Concurrency/Algebras/Chu.agda`, `ChuFiniteProducts.agda`, and `ChuMonoidal.agda` construct `Chu(SET,k)` as a category with finite products and the project's thin `StarAutonomous` structure. `Concurrency/Hybrid/ChuLinearNonlinear.agda`, `ChuPointVProd.agda`, and `ChuPointExample.agda` instantiate the point-generated R4 hypotheses at `k = Bool`. The actor-site cleanup split `TinyActorBase.agda` and `TinyActorCausalSite.agda`, so the final `Chu-nonvacuity` witness has no project postulate in its transitive import closure.

**Sessions realization.** `SessionSyntax.agda` and `SessionMorphismSyntax.agda` extract the postulate-free object and morphism syntax. `SessionObjectModel.agda` defines `J0`, `J0-dual`, `J1`, and the underlying Cubical functor into any `SessionObjectModel`; `SessionChuModel.agda` instantiates that interface at `Chu(SET,Bool)`. This turns the syntactic duality face into a semantic isomorphism theorem, not a transported Sessions postulate. `Sessions.agda` now reuses the morphism HIT for its structural categorical/product laws; its remaining postulate is the operadic `session-O1-action`.

**What Chu still buys later.** A Chu object `(A⁺, A⁻, r : A⁺ × A⁻ → k)` makes extension/intension, point/state, process/context reversal, and duality intrinsic. That is now both implemented as value-category infrastructure and still a future guide for formal concept analysis, Barwise-Seligman-style information flow, the cobordism / cup-cap dictionary attached to Care, and the Reality/Documentation boundary.

To check before using rhetorically: in the concrete LNL instance, the exponential `!A = F(G A)` appears to rebuild a copyable Chu object from the point carrier and replace the original state carrier `A⁻`; if verified, this is a useful explanation of how the copyable reflection forgets resource/context constraints.

**Remaining Chu phases.**

- Phase 2: concrete send/receive and payload semantics. The current payload map is parametric/nonconstant; it is not operational communication semantics.
- Phase 3: O1-in-Chu, if earned. Removing `session-O1-action` requires real structure for `gen`, `plug`, `shift`, and their laws, likely closed/evaluation/cut or coherent tensor-rotation data. Do not discharge it by adding aliases or moving the postulate sideways.
- Phase 4: Reality-boundary admission/erasure. Chu's point/state/evaluation shape is the natural formal carrier for Documentation as protocol observables over Reality, but Reality itself must not become an internal sort.

**Agda slot.** The value-category construction lives under `Concurrency/Algebras/Chu*.agda`; the point-generated R4 instantiation lives under `Concurrency/Hybrid/Chu*.agda`; the Sessions realization lives under `Concurrency/Algebras/Session*.agda`. A later Reality/Documentation boundary should start as an interface over existing Chu objects and trace/audit data, not as a core `Reality` type.

## Retired cohesive escalation

The differential-cohesion depth ladder and the proposed NamedCoefficient
module are preserved in the migration archive's `future_work.md`. They are
not scheduled follow-ons to this M rebuild. A later use must identify the
contextual problem it solves and a sound model for the required modalities.

## Concurrency-side layers of complexity (planned)

The Concurrency side, at the time of writing, has shipped the actor-causal site, pullback overlaps, the cyclic operad `O_1` and its `*`-autonomous algebra interface, the Sessions instance, the Hybrid v1 presheaf/restriction adapter, finite-site event-product descent with constant-slot Sessions and Set instances, the concrete tiny finite-cover validation, finite sheaf categories at both `StarAutonomous→Category V` and `SET`, the finite Coverage/SET library sheaf comparison, and the R4 Benton/LNL finite-sheaf bridge through conditional Tier 4: presheaf-level change of base, presheaf-level adjunction, right-adjoint sheaf preservation, a finite-sheafification reflector interface, and the sheaf-level adjunction conditional on a V-side reflector. The point-generated reflector route has also landed over the supported subsite: event-supported frames, incident point frames, event-supported point overlaps, the canonical point cover, `IsPointSheaf P ↔ PointLocal P`, abstract point products, pointification as a point sheaf, the point-sheaf category, the reflector functor, and the adjunction `a ⊣ ι`. `PointLinearNonlinearAdjunction.agda` now consumes that reflector and assembles the point-generated sheaf-level Benton/LNL bridge `Lpoint ⊣ Rpoint`, relative to `lnl` and `vProd`. The point-generated R4 theorem is banked rather than the live frontier. At the 2S/3R boundary, global and per-conversation realization, conditional coverage, causal-saturation comparison, and raw actor-renaming invariance have landed; the 3R event log records exact contract evidence and replays the expanded corpus. Several additional layer responsibilities are visible at different maturity levels but are not yet in code. This section catalogues them, with for each: what it does for the protocol's use in the human world (possibly with LLMs as participants), what mathematics it commits to—or deliberately leaves open—and what currently shipped scaffolds it presupposes.

A unifying disciplinary commitment behind all the layers below: **praxis is part of the theory**. The protocol's use by a community of equal-standing participants is constitutive of the framework, not an applied addendum to an underlying mathematics. This is what distinguishes the framework's combination from each of the historical precedents catalogued in `related_structures.md` — at least one of (mathematical depth, theory-of-community, runnable protocol, self-validation through use, recursive co-evolution structure) was missing in each of them.

The five layers below are listed in conceptual build-dependence order. This is
not the same as implementation order. Federation's full higher mathematics is
downstream, but its basic exchange constraints—stable scoped identities,
versioned imports, local adoption, and no global authority—must pressure-test
the artifact interface before that interface freezes. Likewise, Λ is opened by
the closure/reference evidence now selected, rather than waiting for a complete
Reflexive Π. The compact dependency picture is therefore a partial order, not
one staircase: the Hybrid and runtime-contract substrates feed Π and Λ; Λ
supports later dynamics and information-cohomological measurements; Federation
both consumes those layers and constrains their public boundaries early.

The table states a separate status for each layer. "Committed responsibility"
means the architecture must eventually account for the function; it does not
commit the project to the current mathematical presentation. "Selected v0"
means a concrete forcing case is on the roadmap. "Research horizon" remains
conditional. A separate appendix gathers cross-cutting reframings, which affect
what to aim for rather than adding numbered construction work.

| Layer | Properties |
|---|---|
| **1. Reflexive Protocol Layer (Π)** | **Function:** bounded meta-conversations propose later protocol versions without rewriting conversations already run. <br> **Math anchor:** explicit versions, preservation obligations, and an activation boundary; the categorical carrier remains open. <br> **Status:** Committed responsibility; formal shape unearned. |
| **2. Bulk Type Theory / Content Layer (Λ)** | **Function:** interpret published episodes, artifacts, concepts, dependencies, and comparison history as versioned languages that can grow and compress without rewriting evidence. <br> **Math anchor:** directed content graph plus a version-relative presentation in which only admitted comparisons may be inverted; every compression is relative to designated observations. <br> **Status:** Selected v0 forcing case; higher categorical form open. |
| **3. Field-theoretic dynamics on the content layer** | **Function:** investigate the growth, stabilization, and purpose-relative compression of versioned language presentations. <br> **Math anchor:** factorization algebra and renormalization-group ideas are candidates only after Λ supplies actual local observables and transformations; no fixed trajectory or action functional is assumed. <br> **Status:** Research horizon. |
| **4. Federation — open network of documented contexts** | **Function:** independently maintained peers exchange typed, versioned artifacts while retaining local adoption authority, conflicts, and missing translations as data. <br> **Math anchor:** first a category/bicategory candidate of publication contexts and partial translations; Yoneda, anabelian reconstruction, and GT-equivariance remain research tests, not consequences. <br> **Status:** Exchange constraints selected; full mathematical layer unearned. |
| **5. Information-cohomological complexity** | **Function:** investigate receiver-relative description cost without assigning complexity ranks to actors. <br> **Math anchor:** information cohomology and related empirical proxies, after Λ defines a category of observations. <br> **Status:** Research horizon; measurement interface unearned. |

### What is intentionally *not* in this catalogue

To set honest expectations and prevent scope-creep:

- *Implementation-track infrastructure.* The actual protocol kernel as running software, the verification runtime, the persistence / cryptographic / consensus backend, and the LLM-tooling integration shape are not part of the five mathematical layers below. They are tracked separately in the implementation-track section that follows this scope note.
- *UI / UX decisions.* What a participant's interface to the protocol looks like; how messages are composed; how meta-conversations are surfaced.
- *Specific Lagrangian weights of Layer 3.* Each term is a normative commitment about what makes a language "good" and will need explicit calibration; the calibration itself is implementation-and-deployment work, not framework work.
- *Specific seed-language choices for Layer 2.* Lawvere theory vs categorial grammar vs dependent-type theory — the architectural commitment is that one or more of these is used; which is decided per-deployment.
- *The choice of metric on concepts.* Wasserstein-style, information-geometric, embedding-based — multiple may coexist for different sub-tasks; the framework does not pre-commit.
- *Below-kernel infrastructure.* Networking, distribution, storage, retry semantics. The framework's kernel is type- and category-theoretic; the infrastructure that runs the kernel is engineering work the kernel does not constrain except by interface.

These exclusions are not deficiencies. They are the right scope for a workflow document calibrated to the mathematical-content track of the project.

### Implementation track — runtime, checker boundary, and protocol contract

The durable implementation-track plan lives in `workflow/status_implementation.md`. That file replaces the old top-level `workflow/elixir.md` transcript, which has been archived under `workflow/deep_context/`.

The first rising-sea gate has been crossed narrowly. The project did not open a broad `Concurrency/Protocol/` layer; it opened `/formal/RuntimeContract/Trace.agda` plus the smallest serialization/runtime boundary that the existing substrate forced. Loop 1 is closed and green: the v0 contract now has a formal predicate, a fixture corpus, generated Agda raw terms, a vendored runtime artifact, and an Elixir `hoapa_contract` codec suite. The runtime-to-substrate bridge derives rank and causal order in `BackwardRank.agda` and `CausalFromParents.agda`, then realizes each present conversation and its strict embedding in `ConversationLocality.agda`.

This means the contract/export/runtime-codec harness is no longer future work. The 3R construction seam and event-log pass 1 have landed: an unnamed `Hoapa.Core.EventLog` records caller-supplied contract values without checking or normalization, exports a `Run`, reproduces the accepted tiny run from literal calls, and replays every schema-decodable corpus fixture by exact struct equality. It is still a recorder, not protocol behavior or an event originator. The live implementation queue belongs in `workflow/status_implementation.md`; `hoapa_checker` remains deferred until a behavioral originator—currently the actor-kernel candidate—produces events to validate one-by-one. A fidelity sampler or authored scenario originator does not meet that gate.

The implementation still should not wait for the full cross-site `Allow ⊣ Require`, `MO_1`, Reflexive Π, or Bulk Λ layers. It also should not claim verification beyond the finite trace/run predicates Agda actually states. Elixir owns runtime behavior; Agda owns the specification of well-formed traces and boundary laws; the top-level checker boundary currently orchestrates formal and runtime tests, with compact certificates and richer audit/provenance semantics deferred.

See `workflow/status_implementation.md` for the substrate-readiness audit, runtime split, naming guardrails, verification commands, and next contract decisions.

### 1. Reflexive Protocol Layer (Π)

A protocol capable of renewal must be able to propose a later version without
rewriting work performed under an earlier one. The Reflexive layer is the
eventual home of bounded protocol change. Meta-conversations run under an
existing immutable session tag, publish a proposed change as an artifact, and
activate an accepted version only at an explicit boundary. Past conversations
retain the protocol identity under which they occurred. Consensus is not the
definition of closure, and no fragment-category model of assent is fixed here.

**Function in the human-world implementation.** The first case is not an
automatic self-scan. A bounded meta-conversation cites the current protocol,
states the proposed change, names which earlier artifacts and judgments remain
usable, and names the first newly admissible operation. Acceptance publishes a
new version and activation point; rejection or obstruction publishes a failure
record. Non-retroactivity is a contract/version property to prove. It does not
follow automatically from strict causality reflection inside one frame.

**Mathematical structure.** Π remains a name for the responsibility, not yet a
constructed category. Candidate objects are explicit protocol versions;
candidate arrows are changes carrying preservation and genuine-extension
evidence. Identity must recover prior behavior, composition must preserve the
declared achievements, and mere renaming or duplication must not count as
renewal. Patch theory, event structures, adhesive categories, and a temporal
site remain possible presentations. They are not required for the first
artifact-reuse case and must be chosen only when a concrete conflict or
concurrent-edit example forces them.

**Trigger / dependencies.** First establish ordinary artifact reuse: a closed
output becomes an admissible input to further work while specified earlier
observations remain available. Bounded protocol change comes only after that
transition, explicit protocol identities, and activation boundaries exist.
Promotion is the publication/reference interface, not a morphism collapsing a
frame. Neither a fragment category nor `MO_1` is a prerequisite for v0.

**Open questions / deferred pieces.** Which achievements form the first
preservation interface; whether changes compose strictly or coherently; how a
proposal is admitted; how concurrent proposals are reconciled; and whether
rule, vocabulary, and interface changes require stratified version families.
Federation requires local activation: accepting a version in one peer never
edits another peer.

**Agda tree slot.** `Concurrency/Hybrid/Reflexive.agda` is a historical
reservation, not permission to open the file. The first preservation-and-
extension obligation decides whether the responsibility belongs there or in a
separate contextual/version layer.

*Originating design conversation:* `deep_context/arc/07_self-modifying_protocol.md`.

### 2. Bulk Type Theory / Content Layer (Λ)

The runtime currently records an opaque session tag, content tag, and
provenance token. Contract v1 supplies the first forcing evidence for Λ:
closure outputs, run-local and federated references, derivation kinds, and
documentation versions. These data are not already concepts or a type theory.
Λ is the interpretation that distinguishes episodes, output artifacts, concept
identities, and versioned presentations while preserving their relationships.

**Function in the human-world implementation.** Users can inspect the retained
history of comparison proposals, acceptances, challenges, and withdrawals;
select the comparisons admitted by one documentation version; and query the
language presentation built from that admitted set. Dependency and provenance
edges remain directed. Only admitted comparisons may become invertible.
Locators such as engineering and biology are contexts inside the language, so
one construction can be transported between them without erasing its origin.
A withdrawn comparison changes the current presentation while leaving the
historical record intact.

**Mathematical structure.** V0 requires three separate objects: the persistent
history of comparison claims, the set admitted by a particular documentation
version, and a presentation constructed from that set. Localization at the
admitted comparisons is one candidate presentation; neither the free category,
the core, nor groupoid completion is declared to be the meaning. Any quotient,
localization, or compression must satisfy an adequacy condition: each
designated observation descends through it. A 2- or (∞,1)-categorical
refinement becomes earned only when a real coherence problem—such as a
non-closing triangle among three disciplinary translations—cannot be stated at
set level.

**Trigger / dependencies.** Contract v1 must first distinguish closure,
artifacts, references, provenance, and versions. Λ then interprets that
evidence without changing the actor-causal substrate or `Sessions-Cat`.
Finite descent and R4 remain mathematical resources for later local-to-global
content theorems, not prerequisites for naming the v0 evidence. Reflexive Π is
also not a prerequisite: ordinary content comparison and withdrawal can force
the first versioned presentation before protocol self-modification exists.

**First local-to-global content test.** Begin with two incompatible claims
about one subject whose authors unanimously publish an artifact saying that
the alternatives remain unresolved and naming an observation or experiment
that would distinguish them. The retained evidence must preserve both claims,
their disagreement, and the unanimously accepted output as distinct facts.
The content semantics must then say what its local data observe and what
compatibility on an overlap means; documentary compatibility must not silently
become either substantive agreement or human assent.

Use the smallest model that realizes this architectural case, even before a
larger Λ implementation exists. Compare its eventwise pointification with a
candidate full actor-causal descent construction and state exactly what either
one forgets. The full reflector is earned only if this or another concrete Λ
case needs overlap information that the point-generated route cannot retain;
the comparison may instead show that neither proposal captures the required
observation. A disconnected toy presheaf remains useful as a control but does
not supply the consumer by itself.

**Open questions / deferred pieces.** The first engineering/biology comparison
and the observations it must preserve; the formal presentation versus runtime
computation boundary; composition of directed dependency edges; the exact
adequacy interface; and the first coherence that forces higher structure.
Whether a content operad `O_C`, a fibred construction over Λ, or a particular
seed-language formalism is useful remains conditional on those examples.

**Agda tree slot.** No subtree is reserved. The first adequacy obligation and
runtime interpretation decide whether a small `Concurrency/Content/` sibling or
another location is warranted.

*Originating design conversation:* `deep_context/arc/08_bulk_type_theory_layer.md` (placeholder file; design captured in workflow conversation logs).

### 3. Field-theoretic dynamics on the content layer

Once Λ exists, its languages will change under use, comparison, correction,
and compression. Field theory, factorization algebras, and renormalization-group
flow offer a possible mathematics for locality and scale in that change. They
are currently an interpretive research program, not the same phenomenon by
definition and not a committed implementation objective. The forcing case must
first identify a real scale-dependent observable or local composition law that
the simpler versioned-presentation model cannot express.

**Possible function in the human-world implementation.** If earned, an action
functional could compare proposed language states using declared terms such as
description length, unresolved coherence, communication overhead, and drift
from observed use. Metrics could assist clustering and change detection, while
correlators could measure concept co-occurrence across frames or versions. Such
quantities belong to an analytic/heuristic layer and require empirical
validation. They must not introduce metrics or rankings of persons into the
trusted kernel, and agreement with renormalization-group dynamics or
universality classes is an eventual hypothesis rather than current fact.

**Mathematical structure.** A factorization algebra on the actor-causal site
valued in Λ, a content operad `O_C`, and Wilsonian flow on a moduli space remain
candidate structures. None has been constructed or forced. In particular,
"start with all concepts identified and then add distinctions" cannot be
modeled as monotone accumulation inside one fixed type: adding distinctions
withdraws identifications and changes the presentation. The versioned Λ model
must state that transition before any symmetry-breaking or fixed-point reading
is meaningful.

**Trigger / dependencies.** Λ must first have a non-trivial versioned example,
an adequacy interface, and observable change across at least two scales. Π and
`MO_1` are possible later inputs, not prerequisites asserted in advance.

**Open questions / deferred pieces.** The specific shape of `O_C` (genuinely open). The specific Lagrangian terms and their relative weights — every term is a normative commitment about what makes a language "good," to be entered with eyes open; this is also the place where the project's values become explicit and editable, which is a feature, not a bug. Whether universality classes exist and are testable in practice. The action functional should remain in the analytic / heuristic layer rather than the trusted kernel: kernel claims (typing, provenance, non-retroactivity, descent, no-leak, and valid publication) should not silently depend on numerical field-theoretic quantities even when those quantities are guiding the implementation's decisions.

**Agda tree slot.** Co-located with Λ. The trusted-kernel verification work (typing, descent, provenance) stays in the existing Hybrid / Sessions / Sites tree; the field-theoretic-flavored dynamics layer is an analytic companion to that, not a refinement of it.

*Originating design conversation:* `deep_context/arc/06_the_hybrid_as_a_door_to_field_theories.md` (cobordism / field-theory dictionary); RG-flow / factorization-algebra reading captured in workflow conversation logs.

### 4. Federation — open network of documented contexts

Federation prevents a successful local protocol from silently becoming the
only authority over a plural field. Every instance must be capable of
publishing and importing typed artifacts while remaining responsible for its
own admissions and versions. This social commitment constrains the artifact
boundary now. It does not follow from Yoneda, and it does not yet supply a
bicategory, a meta-topos, an anabelian reconstruction theorem, or a
Grothendieck–Teichmüller action.

**Function in the human-world implementation.** A peer publishes a finite,
versioned bundle with a publisher scope, stable artifact identifiers, protocol
identity, declared imports, and typed partial translations. Another peer pins
that bundle and decides locally what to admit. Missing translations, conflicts,
and challenges remain data. A later source update or withdrawal does not
rewrite an offline import, and an edit accepted by peer P does not edit peer Q.
The bundle is complete relative to its explicit import boundary rather than by
recursively containing the whole network history.

**Mathematical structure.** The first candidate is a category or bicategory of
publication contexts and partial translations: objects carry versioned local
presentations; arrows preserve declared observations and provenance relative
to an import boundary; 2-cells, if forced, compare translations. Yoneda may
later test whether a protocol is adequately determined by its translation
surface, but representability alone does not mandate openness or connectedness.
Geometric morphisms, institutions, anabelian recovery, dessins, `MO_1`, and
GT-equivariance remain progressively stronger research candidates. No one of
them is inherited automatically by assembling protocols into a network.

**Trigger / dependencies.** The lower-level interface is tested early, after
contract v1 defines stable artifact identity and before the Λ representation
is frozen. Full categorical Federation waits for non-trivial Λ translations
and versioned context renewal. Field-theoretic dynamics, `MO_1`, and R11 are not
prerequisites for a useful connected network.

**Open questions / deferred pieces.** The morphism laws for partial
translations; authentication and integrity without a privileged admitting
authority; version negotiation; cycles of imports; observation-preserving
composition; and whether Π's local changes and Federation's translations share
one higher structure. Hoapa itself remains one proposed protocol among others;
typed interfaces to adjacent communities are a design obligation, not a claim
that those communities already form one category.

**First forcing fixture.** Two peers issue colliding local identifiers, one
retains a pinned import while offline, the peers admit different comparisons,
and only one adopts a later withdrawal. The test succeeds when each current
view is reproducible from its own local version and declared imports; it does
not require convergence. A formal subtree is named only after this fixture
forces a reusable mathematical interface.

*Originating design conversations:* `deep_context/arc/06_the_hybrid_as_a_door_to_field_theories.md` (cobordism dictionary, Sketch-of-a-Program connection); federation discipline and Yoneda + anabelian / GT-action reading captured in workflow conversation logs.

### 5. Information-cohomological complexity

**Function.** Investigate how the difficulty of using documentation varies
with a receiver's declared task and available context. The architectural
concern is intelligibility and reusable understanding, not ranking persons.
No per-person monitoring scheme or scalar optimization objective is selected.

**Candidate mathematics.** Information cohomology, deterministic information
loss, and task-relative information-flow comparisons are distinct resources.
Entropy characterizations need specified observables, coefficients, and,
where relevant, probability models. A cocycle can express a satisfied chain
rule rather than an obstruction. Shannon loss, conditional entropy,
relative entropy, description complexity, and language-model perplexity are
not interchangeable without an interpretation theorem.

The comparison programme at the top of this file owns the axioms and
measurement question. It begins with structural adequacy where possible,
then asks which numerical invariants report it robustly. There is no theorem
identifying `Allow ⊣ Require` with a homology/cohomology pairing, and no
selected identification of ♭/ʃ/♯ with kinds of receivers.

**Trigger / dependencies.** For a Hoapa application, define a non-trivial
documentary use, the permitted observations, and the data a measurement
requires. A finite toy comparison can precede a full Λ implementation.
Any eventual runtime observation must respect the public/live boundary and
the no-leak obligations. A content topos, factorization algebra, or
differential cohesion is not assumed as a universal prerequisite.

**Open obligation.** Demonstrate a case in which the proposed invariant
distinguishes two interfaces under the same task, and explain what it fails
to distinguish. Separate measurement characterization from architectural
specialness. No Agda module is reserved.

The previous stronger cohomological-pairing and receiver-modality claims are
preserved in the migration archive's `future_work.md`, not silently carried
as premises of the new programme.

### Appendix — cross-cutting reframings (different in nature from the layers above)

The five entries above name responsibilities at different maturity levels:
some are committed functions, Λ has a selected forcing case, and others remain
research horizons. The items below are *reframings*—sharper readings of
structure already under discussion. They affect what to aim for rather than
adding numbered construction work.

#### A. Contextual distinctions, without a prescribed modal threshold

The new 1C programme asks what distinctions M must support and how they relate
to K. Cohesion and differential cohesion are possible resources, not required
floors of complexity. The flat collapse is a diagnostic of one signature,
not a reason to impose a replacement cohesive package.

#### B. Candidate corresponding systems of separations

The mirror sketch is recorded in arc/18's session consolidation. A
field-theoretic M counterpart remains one possible specialization, not the
definition of the mirror or a prerequisite to recursive co-evolution.

#### C. Context renewal and possible recursive co-evolution

The selected forcing case is a single transition: a documented artifact makes
a previously unavailable conversation admissible while specified earlier work
remains usable. A later case may let a bounded meta-conversation activate a new
protocol version. Only after those transitions have objects, morphisms,
composition, and non-trivial examples does it make sense to ask for a sequence
`(M₀, K₀) → (M₁, K₁) → …`, an iterated cross-site adjunction, or a colimit.
The existing modal iteration scaffold is a collapsing control under the
current signature, not evidence that such a long-horizon object exists.

Simondon supplies a direction—context and organized activity should be allowed
to become determinate together—without specifying this mathematics. Analogies
to biological niche construction, institutional development, or cosmology
remain interpretive tests after a formal transition exists, not evidence for
the transition.

### Glossary

Brief definitions of recurring terms in the layers / reframings section above, for readers without category-theory or cohesive-HoTT background:

- **`MO_1`** — the *modular envelope* of the cyclic operad `O_1`; closure under self-gluing of marked points, producing operations at every `(genus, arity)` configuration.
- **Π** — the protocol-renewal responsibility from Layer 1. Explicit versions,
  bounded changes, preservation, and activation are selected; a category of
  protocols has not yet been earned.
- **Λ** — the content-layer responsibility from Layer 2. It distinguishes
  conversations, output artifacts, concept identities, documentation versions,
  directed dependencies, and version-relative admitted comparisons; its higher
  categorical presentation remains open.
- **`O_C`** — the (conjectural) *content operad* from Layer 3, governing how concepts compose; sibling to `O_1` on the content side.
- **`Ass_cyc`** — the *planar cyclic associative* operad; the ribbon-graph world, as opposed to the fully symmetric `Com_cyc`.
- **Factorization algebra** — a sheaf-like structure on a topological / causal space, with disjoint-union composition controlled by an operad; the modern categorical framework for QFT (Costello–Gwilliam).
- **Anabelian** — a property of geometric objects recoverable from fundamental
  groups with arithmetic action. It is a distant comparison test here, not a
  proved property of Federation.
- **GT** — the *Grothendieck–Teichmüller group*. Its established action on
  moduli/dessin structures does not supply an action on Hoapa's protocols.
- **`*`-autonomous category** — a symmetric monoidal category with a dualizing object; the categorical semantics of multiplicative linear logic / session-type duality.
- **Information cohomology** — Baudot–Bennequin–Vigneaux framework relating information functions and cohomology on specified observable structures; its hypotheses, coefficients, and interpretation must be supplied for any Hoapa application.
- **RG flow** — *renormalization group flow*; a possible later model for
  purpose-relative coarse-graining after Λ has concrete observables, not a
  present dynamics derived from consensus.
- **Meta-topos** — a possible future higher-categorical presentation of a
  network of contexts. Federation v0 neither requires nor establishes one.

For broader project-wide terms (cohesion, modal adjoint pair, actor-causal site, sheaf descent, etc.), see `motivation.md` and `arc.md`.

## Future steps

### Concurrency category and R4

The finite sheaf framework now has both endpoints: `Sh_fin(site,V)` via `StarAutonomous→Category V` and `Sh_fin(site,Set)` via Cubical `SET`, each with a concrete constant-slot event-product object. The finite site-axis legitimacy work has also landed: `FiniteFrameCoverage` supplies the Cubical coverage, and `SetSheafComparison` proves the framework-at-`SET` sheaf condition agrees with the library condition. The R4 treatment has landed interface-first through conditional Tier 4: `ChangeOfBase.agda`, `LinearNonlinear.agda`, and `LinearNonlinearSheafAdapter.agda` prove presheaf-level Benton change of base, the presheaf-level lifted adjunction, and right-adjoint sheaf preservation; `FiniteSheafification.agda` names the finite-site reflector; `LinearNonlinearSheafAdjunction.agda` proves the sheaf-level adjunction conditional on a V-side reflector. The supported point-generated route removes that reflector hypothesis for the event-discrete site: `PointSheafAdjunction.agda` constructs `a ⊣ ι`, and `PointLinearNonlinearAdjunction.agda` assembles `Lpoint ⊣ Rpoint`, still relative to the value-level `lnl` and `vProd`.

This keeps the two concurrency poles separate: Set-valued locality sheaves carry cartesian/internal-logic structure; V-valued sheaves carry linear/session content. R4 is the named adapter between them, not a collapse and not the cross-site `Allow ⊣ Require` adjunction. The framework-at-`SET` category remains the canonical R4 endpoint; the library comparison is its legitimacy theorem, not a replacement endpoint.

Immediate inside this leg: write the theorem exposition and decide whether to add a concrete instantiation witness. Deferred beyond that: the normalized-pullback / stability layer needed for a full Cubical `Coverage` presentation of the point-generated topology, the full actor-causal finite sheafification reflector, enriching `Sh_fin(site,V)` with inherited linear / star-autonomous structure, constructing the free/forgetful Set-to-session adjunction rather than assuming it, proving full topos/internal-logic structure for the Set endpoint, and extending from the finite common site to the full actor-causal Set-valued topos.

### World/context category options

The selected programme above owns this question. The older preference for
cartesian/discrete core + cohesive context + cohesion adapter is retired.
Candidates must earn their role through contextual uses, comparisons, and
transitions. Related contextual categories may be more appropriate than
forcing all roles into one M.

### Cross-side correspondence threshold

Naming `Allow ⊣ Require` or a four-functor diagram is not a construction.
Identify independently meaningful objects and maps, then state the
representation and compatibility obligations. A positive result may be
adequacy, a universal factorization, a contextual-renewal distinction, or a
failure that rules out a candidate. Non-idempotent iteration is one route,
not the universal acceptance condition.

## Candidate addition under evaluation: provenance, accountable artifacts, and reversible import

**Status and scope.** This section records a newly identified possibility, not a change to the five layer responsibilities above. It does not renumber them, alter the selected program, reserve an Agda module, or commit the project to a new mathematical construction. It is deliberately self-contained because adopting the proposal could reorganize patch-theoretic ownership, the implementation trace schema, and the relationship between Reflexive Π and Federation. Until that evaluation is complete, every additional structure below is a candidate.

### Problem and motivating use

The motivating use is not retrospective attribution for its own sake. It is the cost of repeated work in a network of protocols. Suppose protocol `P` has developed an artifact or concept and protocol `Q` needs substantially the same result. Without disciplined import, both derive it independently and then spend further conversations constructing and maintaining a bridge. A better path may be for `P` to do the derivational work once, for `Q` to adopt an explicitly cited and typed realization, and for `Q` to spend only the local conversation needed to translate or bridge it. Provenance does not itself eliminate conversations; it can make non-repetition acceptable by preserving what is needed to inspect, update, detach, or retract an import.

The import is neither an unmarked copy nor an assertion that `Q` independently established the result. It should retain the source protocol, source artifact and version, derivational grounds, translation used by `Q`, explicit adoption decision, and local changes depending on it. Authority remains separated: `P` is authoritative for the source artifact and history; `Q` is authoritative for adoption, local interpretation, overlays, and forks. This is a *partial mirror by citation*, not silent absorption.

The candidate trade-off is:

> **clean, reusable artifact versus reconstructable, accountable artifact.**

A protocol needs stable interfaces so it can use results without replaying their construction. It also needs enough account of origin, derivation, interpretation, and change to know what a result depends on and what happens if those grounds move. The candidate follows the framework's recurrent strategy: keep the live artifact separate from its account; divide the account into derivational and temporal faces; and state laws relating both faces to the artifact. Working names are *Accounted Artifact*, *Audit*, and *Accountability and Provenance*. “Audit” here concerns artifacts, derivations, and changes, not the typing or ranking of actors.

### Human-world import lifecycle

A candidate import record would contain:

1. a stable source-protocol identifier;
2. a stable artifact identifier and source-version identifier;
3. a derivational account over event/document/artifact tokens;
4. the typed translation or migration used locally;
5. `Q`'s acceptance decision and applicable trust policy;
6. the local materialization change introducing the imported view; and
7. references from local bridges and overlays to that change.

It should support distinct operations:

- *adopt*: create a local cited realization;
- *update*: import a newer version and reconcile downstream changes;
- *retract*: invalidate or remove a realization whose grounds no longer support it;
- *detach*: preserve the snapshot while ceasing to follow its source;
- *fork*: retain ancestry while transferring future authority locally;
- *rebase*: replay a local bridge and overlays over a newer realization; and
- *supersede*: retain the old account while making a newer artifact current.

Local edits should normally be overlays, bridges, or forks rather than mutations of the imported source. Provenance cannot promise that withdrawal is cheap: a heavily reused artifact may have a large downstream cone, and semantic repair may require conversations. The honest promise is narrower: compute and expose the structural dependency cone, preserve unrelated work, and let the protocol choose a repair policy. This localizes structural impact; it does not predict the full human cost.

### Two faces and their interface

**External / derivational face: provenance.** This records why an artifact is supported across protocol boundaries: which sources were used, which alternatives support it, and which grounds were required jointly. It supports citation, dependency analysis, trust filtering, and counterfactual questions such as whether support survives withdrawal of token `x`.

**Internal / temporal face: accountable change.** This records how local protocol state changed: which import, edit, bridge, resolution, or supersession introduced the current state; which changes depend on earlier changes; which independent changes commute; and which combinations conflict. It supports versioning, non-retroactivity, compensation or local undo, and preservation of unrelated changes.

**Materialization interface.** The dependency graphs are not the same. A semantic derivation may depend on an artifact without shared textual context, while a VCS change may depend on file context without expressing semantic justification. An import must carry or reference its derivational account, and its local materialization change must expose a checked relation to it. Provenance supplies grounds; accountable change supplies local transition and conflict handling; materialization makes them one capability.

The central law must not identify provenance deletion with patch removal. The target is conditional commutation:

```text
materialize(recompute(provenance[x := 0]))
  ≃
incrementally-retract(materialize(provenance), import-change x)
```

The equivalence is observational, not syntactic, and is meaningful only after artifact, account, materialization, observation, and repair policy are typed. Side conditions govern overlays, alternative derivations, accepted versions, and unresolved conflicts. This interface law is the proposed content that could make the two faces one layer.

Supporting obligations include:

- **Origin preservation.** Materialization retains source artifact/version and translation.
- **Dependency adequacy.** If a source token can affect a local artifact, its import change lies in the local dependency closure. Conservative adequacy may precede completeness.
- **Materialization soundness.** The local artifact denotes the recorded translation applied to the recorded source version.
- **Locality.** Retraction or update preserves changes outside the affected cone.
- **Non-retroactivity.** Withdrawal creates a new invalidation, supersession, compensation, or conflict event; it does not rewrite what earlier participants saw.
- **Alternative-support preservation.** Removing one derivation preserves an artifact still supported by another accepted derivation.
- **No-leak erasure.** Erasing actor-identifying runtime information preserves what the trusted checker needs.
- **Authority separation.** A source update does not silently enact local adoption or repair decisions.

These laws are stronger than storing a dependency list and weaker than universal reversible computation. They are the candidate meaning of “editable and reversible import.”


### Positive semiring provenance

For a set `X` of source tokens, the standard positive provenance object is the free commutative semiring `ℕ[X]`. Addition represents alternative derivations; multiplication represents joint use; coefficients retain multiplicity. Evaluation produces an expression or, more practically, a shared circuit/DAG. A semiring homomorphism out of the free object specializes the same account to Boolean support, counting, costs, access conditions, trust values, or other coefficient systems when their laws apply. The value is “record once, interpret in multiple ways,” not a claim that every desired measurement is a semiring homomorphism.

Withdrawing an input from a positive derivation does not require monus: assign its token `0` and reevaluate. That computes which justifications survive. It does not edit the importing protocol or decide how downstream artifacts should be repaired. Monus or other extra structure becomes relevant when the derivation/query language itself contains difference, negation, or other nonmonotone operations. The Badia–Kolaitis–Noguera work on Codd's theorem over semirings and the developing Badia–Noguera–Petreni–Portone–Tannen negative-information line therefore belong to a later extension, not the minimum reversible-import story.

Circuits or shared DAGs should be preferred initially to expanded polynomials: expanded expressions can grow prohibitively, while circuits preserve sharing and admit multiple evaluations. Stable tokens are required, but hashes are only one implementation. Logical artifact identities plus explicit versions may be preferable where content changes without changing conceptual identity.

### Descent and Applied Category Theory

The phrase *accounted descent* is a candidate description, not a theorem. Existing Hybrid descent says when compatible local sections glue. A provenance refinement could annotate sections and derivations so a glued artifact retains an account of which local material supports it. This does not mean the existing proof discarded provenance, nor that a semiring annotation automatically forms a sheaf. Compatibility between restriction, gluing, and provenance evaluation must be stated.

Relevant categorical constructions cover different parts:

- A category of elements, displayed category, or Grothendieck construction can organize tokens and transport. It does not supply the additive/multiplicative algebra of alternative and joint derivations. Variance is open: covariant transport suggests an opfibration, contravariant restriction a fibration, and the full import situation may require a bifibration or profunctor.
- Spivak-style functorial data migration supplies typed schema translation through `Σ ⊣ Δ ⊣ Π` and is a candidate for import/migration. The adjunctions do not automatically retain a persistent audit record, and a left Kan extension is not generally reversible.
- Quantale-valued relations can be enriched matrices/profunctors. This is useful for suitable complete idempotent specializations, including Boolean, tropical, and some many-valued cases. It does not contain universal `ℕ[X]` provenance without changing or completing the coefficients.
- Set-valued profunctors are proof-relevant relations, and a categorified derivation theory may connect to HoTT. `ℕ[X]` is at most a decategorified shadow: labeled monomials retain more than counts, but not full witness objects or higher identifications.
- Functorial aggregation combines values over fibers. Its commutative-monoid operation resembles provenance addition algebraically but has a different semantic role. It may aggregate import costs later; it is not the provenance construction.
- Lenses and optics may express update or repair propagation. They do not record derivational grounds.

The conservative posture is positive semiring provenance first; an indexed/categorical transport layer once variance is known; functorial data migration for typed imports; and enriched or categorified refinements only when a theorem requires them. No commitment should yet be made to semimodule-valued sheaves or R4 enrichment: the needed `*`-autonomous, finite-product, and change-of-base interfaces have not been established.

### Accountable change and the Pijul boundary

Agda should specify an abstract accountable-change interface before the project commits to a version-control implementation. Candidate ingredients are artifact states, typed changes, dependencies, composition/application, partial commutation, conflict and resolution data, materialization, and an observation relation. The minimum interface should not assume every real change is invertible. Compensation, unrecording from selected history, and adding a change that marks older material dead are distinct operations.

Mimram–Di Giusto's categorical theory of patches and Homotopical Patch Theory are formal resources: the former studies merge through pushouts and finite-colimit completion; the latter presents Darcs-style invertible patches through higher inductive types. Neither is a verified description of Pijul's append-only graph, alive/dead edges, contextual dependencies, or `unrecord` behavior. Pijul remains a strong implementation candidate because it provides stable change identities, explicit dependencies, partial clones, commutation of independent changes, and conflicts as stored data. The relationship should be refinement, not identification:

```text
Agda:    abstract accountable-change laws
Pijul:   concrete storage and change semantics
checker: evidence that emitted operations refine the abstract interface
```

This creates an open ownership question. If the candidate becomes a layer, it could own the accountable artifact/change substrate, with Reflexive Π consuming it for bounded version proposals, preservation evidence, and activation. Alternatively, patch infrastructure could remain under Π and provenance remain cross-cutting. The materialization laws must earn an independent rung before existing ownership changes.

### No-leak and security boundaries

Standard provenance records people, institutions, agents, attribution, and responsibility; W3C PROV explicitly supports them. Hoapa's unityped/no-leak commitment therefore runs against the default grain of provenance systems and must be present from v1. Trusted tokens should identify events, documents, artifacts, protocol versions, translations, and derivation steps, not refine actor identity. Runtime infrastructure may need actor identifiers, but an erasure or pseudonymization theorem must show that the trusted account and certificate do not depend on them.

The following guarantees remain separate:

```text
stable identity       is not necessarily content addressing
content addressing    gives tamper evidence, not authorship
signatures             attest control of keys, not semantic correctness
provenance             records derivation, not authorization
trust policy           governs adoption, not mathematical validity
```

Hashes may align with Pijul changes and typed documents but are not mandatory. Signatures, capabilities, revocation distribution, and key management belong at the security/infrastructure boundary. The mathematical layer should expose attachment points without deriving authenticity from provenance.

### Language, documentation, and orchestration

Provenance is language-agnostic. Existing systems range from relational query rewriting and provenance circuits in PostgreSQL/C/C++ to RDF/OWL interchange. The transferable requirements are structured accounts, stable identifiers, explicit versions and translations, deterministic evaluation, and checkable certificates, not a particular language or universal writer-monad encoding.

A possible Hoapa split is:

- Agda specifies circuits, erasure, accountable-change laws, materialization, and conditional coherence.
- Elixir emits runtime events, import/adoption decisions, and provenance references as structured metadata.
- A checker validates finite accounts/certificates against Agda-pinned predicates.
- Pijul-shaped persistence stores local changes, dependencies, conflicts, resolutions, and partial views where its representation fits.
- Typed documentation supplies artifact/version identities, typed references, canonical serialization where feasible, and explicit translation signatures.
- The conversation-of-conversations orchestrator records which artifacts, proposals, and sub-conversations influenced each output.

Provenance does not select the documentation or orchestration language. It constrains their interfaces: outputs must cite typed inputs and transformations without parsing informal prose, and orchestrated results must not become originless flattened summaries. Elixir can meet this if its schema is typed and checked; no new orchestration language follows automatically.


### Possible cascade effect if adopted

The strongest candidate placement is between Hybrid and Reflexive:

```text
Hybrid finite descent
  → candidate Accounted Artifact / Audit layer
  → Reflexive Π
  → Bulk Λ
  → field-theoretic dynamics
  → Federation

Information cohomology continues to read from the content side.
```

The generative argument would be: Hybrid produces coherent global artifacts, but usable abstraction hides origin and transformation history; Audit separates the artifact from its derivational and temporal accounts; Π can then revise a protocol over accountable changes without rewriting the past. The candidate would be localized in construction and cross-cutting in consumption.

Potential downstream effects:

- **Reflexive Π:** consumes accountable changes, dependencies,
  non-retroactivity, and conflicts; adds bounded version proposals,
  preservation obligations, and explicit activation.
- **Bulk Λ:** carries concept lineage and distinguishes inherited concepts, overlays, and forks.
- **Field dynamics:** may use accounts as observables or costs, but numerical dynamics must not determine trusted provenance validity.
- **Federation:** receives the main payoff: typed cited imports, partial mirrors, origin preservation, local adoption authority, and update/retraction behavior.
- **Information cohomology:** may measure an account but is not subsumed by provenance; entropy is not generally a homomorphic specialization of `ℕ[X]`.

The selected narrow Federation fixture exists independently of this candidate.
If accountable artifacts are adopted, that same two-peer fixture can test one
typed translation, one cited artifact, and one update/retraction account
without claiming an anabelian or meta-topos layer. The candidate may remain a
cross-cutting kernel facility or Federation feature. It earns layer status only
if the trade-off is generated by Hybrid, the two-face separation is necessary,
and the materialization laws add formal content not already owned by Π.

No current layer numbering or dependency claim changes while this remains open.

### Staged investigation and possible build order

The selected causal-kernel and contract/publication work remains first. This
candidate creates no immediate code obligation; revisit it when the
Λ/Federation fixture needs derivational accounts beyond the provenance
interface already selected for contract v1.

**v1: positive derivational account.** Define finite stable tokens, positive provenance circuits/expressions, commutative-semiring evaluation, support, restriction/gluing compatibility, and no-leak erasure. Prove the homomorphism/evaluation law and alternative-support behavior. No monus, Pijul coupling, quantale enrichment, or reversible-local-state claim.

**v2: accountable change and materialized import.** Specify the abstract change interface and typed import/materialization record. Prove origin preservation, materialization soundness, and conservative dependency adequacy. Define adoption, overlay, detach, and fork.

**v3: update and retraction coherence.** Add source succession/invalidation, incremental impact, local preservation, compensation/conflict policies, and the conditional recompute-versus-incremental theorem. Only here would “reversible import” be justified.

**v4: nonmonotone derivations and advanced specializations.** Add monus/difference or a better negative-information construction if needed. Separately evaluate quantale-enriched profunctors, many-valued specializations, categorified witnesses, and any R4 enrichment. These extensions are independent.

A small falsifying example should drive all stages. Protocol `P` produces artifact `a` from tokens `x` and `y`, with alternative and jointly required derivations. Protocol `Q` imports `a` through a typed translation, adds one dependent bridge and one unrelated artifact, and then observes `P` withdraw `x` or publish a successor. The example must show which support survives, which changes are affected, which remain unchanged, what history remains, and what no-leak reveals. The existing two-point finite cover is a natural test if the descent connection proves real.

### Decision gates and next discussions

Before integration into the stable catalogue:

1. **Capability:** Is accountable import a kernel capability or a Federation/runtime feature?
2. **Layer:** Is clean artifact versus reconstructable account a generated cascade trade-off?
3. **Ownership:** Should a candidate Audit layer own accountable change, or should Π retain it?
4. **Categorical carrier:** What indexes tokens and translations, with what variance, and where does the circuit live?
5. **Equivalence:** What observation makes recomputation and incremental retraction comparable?
6. **No-leak:** Which identifiers survive into trusted certificates, and what erasure theorem is required?
7. **Implementation:** Can Pijul operations refine the abstract interface without entering the kernel?
8. **Economics:** In the finite example, does accountable reuse reduce conversations or verification work?

The next discussions should first settle capability, layer, and ownership; then compare categorical carriers against the finite example; then specify the Pijul/checker refinement boundary; and finally decide whether to promote, retain cross-cutting, or reject the candidate. Promotion would require explicit later edits to the cascade, Π, Federation, implementation schema, and compact motivation table. Until then, this section is the sole roadmap for the idea.

### Candidate implementation slots, not reservations

If the proposal survives:

```text
formal/RuntimeContract/Audit/Provenance.agda
formal/RuntimeContract/Audit/AccountableChange.agda
formal/RuntimeContract/Audit/Materialization.agda
formal/RuntimeContract/Audit/NoLeak.agda
formal/RuntimeContract/Certificate.agda
```

These are illustrative. The future `RuntimeContract/Audit` area would cover trace no-leak and accountable provenance if the candidate survives; integration would decide whether to rename, split, or keep the broader Audit capability separate from compact certificates. No file is reserved here.

### Research anchors and cautions

- Green–Karvounarakis–Tannen, *Provenance Semirings* (2007): free-semiring/K-relation foundation.
- Grädel–Tannen, *Provenance Analysis and Semiring Semantics for First-Order Logic* (2024/2025): first-order extension and homomorphism/evaluation.
- Green–Ives–Tannen, *Update Exchange with Mappings and Provenance*, and ORCHESTRA: closest precedent for autonomous-peer import/update, not the sole origin of provenance.
- Badia–Kolaitis–Noguera, *Codd's Theorem for Databases over Semirings* (2025): monus/support/domain-independence, relevant for nonmonotone queries.
- The Badia–Noguera–Petreni–Portone–Tannen negative-information work should be monitored when public; it should not be reconstructed from seminar metadata.
- Spivak, *Functorial Data Migration*: typed migration, not automatically semiring how-provenance or persistent lineage.
- Garner–Spivak–Fairbanks, *Functorial Aggregation*: aggregation over fibers and its naturality problem, not provenance addition.
- Fujii, *Enriched Categories and Tropical Mathematics*: quantale enrichment and tropical/many-valued specializations, not a quantale presentation of `ℕ[X]`.
- Mimram–Di Giusto, *A Categorical Theory of Patches*, and Angiuli–Morehouse–Licata–Harper, *Homotopical Patch Theory*: formal patch resources, not established Pijul models.
- Pijul's graph/change semantics: implementation evidence for stable changes, dependencies, partial clones, and conflict-as-data; semantic validity remains outside the VCS.
- W3C PROV: an interchange vocabulary and a reminder that standard provenance includes agents and attribution, where Hoapa requires an explicit no-leak divergence.


## Candidate under evaluation: no-leak theorem ladder and humanness-as-refusal

**Status and scope.** This section records the 2S runtime-to-substrate theorem
ladder exposed by arc/13 and given a concrete consumer by arc/17. Tier A is
banked. Tier B change of actor base, the local per-conversation theorem, and the
closure transform are selected future work; observational no-leak and a
universal quotient remain candidates. This is not a new cascade layer.

The motivating formulation is:

> The system protects humanness by refusing to formalize it.

The formal reading must stay negative and boundary-shaped. The kernel should not recognize a `Human` predicate, an expert caste, a designer actor type, or a ranking of participants. It should instead prove that trusted protocol observations are insensitive to actor identity except through permitted participation structure. The proof-near core is therefore no-leak / actor-renaming invariance.

### What is already grounded

The substrate already carries the syntactic floor of the claim:

- `Concurrency/Sites/ActorBase.agda` gives an opaque, unityped actor carrier with no constructors, no origin tags, no roles, no message syntax, no fresh-name operation, and no decidable equality in the kernel.
- `RuntimeContract/Trace.agda` uses dense natural-number coordinates at the serializable boundary, while deliberately excluding person identity, network identity, runtime handles, semantic payload bodies, and identity-refining fields.
- `RuntimeContract/Realization/TinyTrace.agda` gives one concrete trace-to-frame witness, explicitly labelled as a witness rather than the generic bridge.
- `RuntimeContract/Realization/BackwardRank.agda` proves that a causal-parent edge strictly decreases first-occurrence rank under `backwardOK`; global event-ID distinctness is not load-bearing for that order lemma.
- `RuntimeContract/Realization/CausalFromParents.agda` gives the first generic bridge checkpoint: any well-formed raw run determines a causal order and one global actor-causal `LocalFrame`.
- `RuntimeContract/Realization/ConversationLocality.agda` realizes each present conversation as a `LocalFrame` and supplies its strict `FrameHom` into the global frame.
- `RuntimeContract/ActorRenaming.agda` gives the substrate-free Tier A theorem in three strata: functoriality under arbitrary actor maps, exact raw-validator equality under total injective actor endomaps, and the invertible permutation/gauge specialization with `WellFormed` transport and reflection.
- `Hybrid/ChangeOfBase.agda` contains the structural half of no-leak as frame-noninterference under change of base.

These results establish the raw boundary discipline, not the full observation-level theorem. Realized-frame equivalence and trusted observations remain absent.

### The theorem ladder

**Tier A: raw actor-renaming invariance — landed at `5670658`.** `renameActors` changes exactly `traceActors`, `convActors`, and `evTouches`. The result separates three natural hypothesis levels:

```text
arbitrary total maps:       renameActors respects identity and composition
total injective endomaps:   valid? (renameActors rho r) ≡ valid? r
invertible relabelings:     WellFormed is invariant under the permutation action
```

The Boolean theorem holds for every raw run, malformed included; forward and reflected `WellFormed` transports are exported by name. Injectivity is the exact boundary because actor equality is all the validator observes: a collapsing map can merge an undeclared actor into a declared one or destroy actor distinctness and thereby change the verdict. The permutation statement satisfies the recorded bijective target, but its invariance is inherited from the stronger embedding theorem; its additional content is the inverse action.

The proof is direct through Boolean equality, membership, subset, distinctness, conversation lookup, and the validator clauses. It does not use the formerly proposed inverse-renaming route. A list-local bijection is not a sufficient hypothesis for exact Boolean equality over all raw runs, because malformed runs may mention undeclared actor identifiers outside the declared list. That notion remains potentially useful at Tier B, whose input is already `WellFormed`.

This is a standing obligation more than a surprising discovery: `valid?` has no actor-identity-sensitive clause. The tests therefore supply degeneracy controls—a moving transposition, a non-surjective `suc` embedding, and rejected collapsing maps—not a leak falsifier. A future clause that reads a particular actor identity will turn the generic theorem red.

Do not silently broaden this to all identifiers. Event IDs, conversation IDs, content tags, provenance tokens, run IDs, and protocol IDs have their own alpha-equivalence or stability questions. The humanness/no-leak theorem concerns the actor-identity channel.

**Tier B: realized-object change of actor base.** The generic realization checkpoints have landed:

```text
WellFormed r -> global LocalFrame r
WellFormed r -> each present conversation has a LocalFrame and global FrameHom
```

`CausalFromParents.agda` derives the causal order from backward parent edges and
packages one global actor-causal frame over realized actor/event carriers.
`ConversationLocality.agda` realizes each raw conversation as a local frame and
constructs its fixed-base `FrameHom`. Tier B must express actor relabeling over
a different semantic actor carrier. Uniform global relabeling and fresh
per-conversation publication handles are distinct cases; only the latter is the
selected closure-transform consumer.

Tier A exposed a genuine expressibility gap. `CausalFromParents.agda` builds the run-specific carrier

```text
RActor r w = Σ[ a ∈ ℕ ] ((a ∈? traceActors (trace r)) ≡ true),
```

so a run and its relabeling live over different actor types. But `ActorCausal.agda` fixes one `ActorBase` for all frames and `FrameHom` has no actor map: actor preservation quantifies over the same actor on both sides. Tier B is therefore not merely unproved in the current interface; its relative statement is not yet expressible.

### Earned direction: change of actor base

The proportionate next infrastructure is substrate-native change of actor base,
not a full category of name presentations in advance. The serializable
`ActorId = ℕ` contract remains the current coordinate presentation.

The formal sequence should be:

1. add a substrate-native `ActorBaseMap` or isomorphism without importing the
   raw contract arrow record;
2. add a relative `FrameHomOver` over that map, leaving banked fixed-base
   `FrameHom` unchanged and recovering it over the identity;
3. specify the live-to-public transform with fresh handles on
   `(conversation, actor)` occurrences and prove each realized conversation
   frame equivalent to its image;
4. state the public content observation and prove the transform preserves it;
5. separately retain uniform global relabeling as a useful theorem if a later
   consumer needs the live global frame.

The relative interface is earned by the closure transform: its public actor
base differs from the live one. It is not yet constructed. Tier A supplies raw
arrow vocabulary and the one-object `ActorId = ℕ` action; no `FrameHomOver`,
public transform theorem, action groupoid, or varying-name `RawRun` functor has
landed.

### Closure transform as the first consumer

The selected transform pseudonymizes actor occurrences freshly per
conversation, drops authorship and the live identity map, and keeps the public
participant count, outputs, provenance, references, directed dependency edges,
and stable publisher-scoped artifact/conversation/event identifiers. It must
not rename concept references merely because actor and content tokens share a
raw representation. Non-injective handles and accidental content renaming are
the first falsifiers.

The global frame is not preserved by design when one live actor appearing on
two panels becomes two unrelated public handles. Each conversation frame is
the preservation target. Descent over live panel overlaps may therefore be
non-trivial while the public actor view forgets those overlaps. This is
controlled loss, not global realized equivalence.

The dense first-appearance convention may be read as a gauge choice because `valid?` deliberately has no density clause and the `suc` witness leaves that slice without changing acceptance. A global section selecting exactly one representative per orbit, or constancy of canonicalization on orbits, has not been proved; density-as-gauge-fixing remains an interpretation, not a result.

The banked proof fact is that the order/antisymmetry rung uses the `backwardOK` scan, not global event-ID distinctness. Distinct event IDs still matter for faithful event-record realization.

**Tier C: univalent equality capstone.** Once Tier B has a well-packaged structure and equivalence notion, optionally upgrade frame isomorphism/equivalence to equality using SIP/univalence for the realized structure. This is mathematically attractive, but it should not block the more useful Tier B theorem.

**Tier D: full humanness-as-refusal theorem schema.** The slogan-complete version would say that documentation is the universal actor-renaming-invariant observation of contribution-structure, and that the four protections below assemble into an optimal boundary discipline. This is research-scale and partly blocked on unshipped layers: trusted documentation observations, provenance/audit semantics, content-layer `Λ`, and a formal account of protocol-visible information.

### Four protections and their current status

| Protection | Formal reading | Current status | Guardrail |
|---|---|---|---|
| not ranked | actors remain unityped, unordered, and not internally classified | grounded by omission in `ActorBase` | not yet a theorem that no ranking observation is definable |
| not exposed | trusted observations are invariant under actor relabeling | raw-validator Tier A banked; realized and observational tiers open | actor-renaming, not all-ID erasure; acceptance is not every observation |
| not consumed | actor/catalyst carrier is preserved across contribution | candidate invariant | no runtime actor-token conservation theorem yet |
| not copied | no natural diagonal copies the actor-carrier into documentation | process-theoretic analogy/candidate | no quantum claim unless modeled |

Exposure/no-leak is the first protection under formal development: its raw Tier A is banked, while its realized and observational statements remain open. The other protections are useful theorem-shapes, but they should not be pulled into Tier B unless a runtime artifact forces them.

### Relationship to provenance, contextuality, and Reality

This ladder shares a boundary with the provenance and Reality candidates.

- Provenance should record events, artifacts, versions, translations, derivation steps, and materialization changes, not trusted actor essence. A future provenance/no-leak theorem should show that erasing or relabeling actor identity preserves the trusted account.
- Contextuality is a possible sheaf-theoretic bridge: local provenance support may fail to glue into a global account without adding forbidden hidden structure. That obstruction should be recorded as protocol information, not repaired by exposing actor identity.
- Reality remains the constitutive exterior. The incubator or runtime may know messy facts, but the trusted kernel should only receive boundary evidence and invariant contribution-structure.

The physics language stays interpretive: actor labels as gauge data is a useful reading of no-leak; it is not a claim that Hoapa has constructed a gauge field theory, Ward identities, or a QFT model.

### Candidate implementation slots, not reservations

The first slot has now been earned; later names remain illustrative:

```text
formal/RuntimeContract/ActorRenaming.agda                 # landed Tier A
formal/RuntimeContract/Realization/ActorBaseChange.agda   # illustrative Tier B
formal/RuntimeContract/NoLeak.agda
formal/RuntimeContract/Audit/NoLeak.agda
```

The earlier candidates `ConversationFrames.agda` and `FrameHoms.agda` are superseded by the landed `RuntimeContract/Realization/ConversationLocality.agda`; encountering the old names in archived planning should lead there. The Tier B filename and `FrameHomOver` name are not reservations. Audit-level no-leak should wait until audit/provenance semantics stop being opaque tokens.

### Decision gates

Resolved before Tier A: per-conversation locality came before renaming, and it landed directly as `LocalFrame`s plus `FrameHom`s in `ConversationLocality.agda`, without a new packaged `RealizedFrame`.

1. **Resolved for Tier A:** the raw theorem uses total injective endomaps of `ActorId = ℕ`, a fourth option not listed in the original gate. Its permutation specialization satisfies the bijective target. List-local bijectivity alone is insufficient for Boolean equality over every raw run, though it remains live for well-formed Tier B inputs.
2. **Resolved for Tier A:** exact equality of Booleans, with the `WellFormed` path and both transports as corollaries. The universal quotient reading remains Tier D.
3. **Open:** what is the first trusted observation map, if any, beyond `valid?` itself?
4. **Standing order:** build Tier B as realized-frame isomorphism/equivalence first; defer SIP/univalent equality to Tier C.
5. **Open:** which provenance identifiers survive no-leak, and which are actor-identity channels to erase?
6. **Negative Tier A answer:** no identity-sensitive falsifier exists inside `valid?` because the predicate contains no such clause. The retained tests are degeneracy controls. This gate becomes answerable only when Tier D has a trusted observation beyond `valid?`.

Within the no-leak ladder, the selected order is the local closure-transform
case of Tier B, its public observation theorem, optional uniform/global Tier B,
optional Tier C SIP/univalence, and only later provenance/audit no-leak or an
optimality/quotient formulation. The minimal 3R causal kernel precedes this
formal growth because it tests the behavioral premise underneath the realized
causal frames.


## Candidate under evaluation: Reality and the protocol's constitutive exterior

**Status and scope.** Like provenance, this is a **candidate under evaluation**, recorded because the concept is **present by its absence**: it does real work throughout the project but has never been named. It changes nothing in the live cascade — no renumbering, no new Agda module reserved. Crucially it is **not a cascade layer**. It sits at the *foundational floor* (the instigator's level "−1"), below the existing foundational separations (`actor-vs-content` in K, `spatial-vs-discrete` in M, `context-vs-system` at the cross-site adjunction); it adds one more, `reality-vs-protocol`. The originating discussion is preserved as a transcript in `arc/11_reality.md`. The separate logical-presentation / mode-theory track will eventually have to account for Reality; it is logged here as the present-by-absence gap, not folded into that track.

### The absence/presence

Reality (`R`) is the framework's **constitutive exterior**, and it is present in three asymmetric ways:

- **Negatively, in the kernel** — almost every "the kernel must *not* do X" is an unnamed invocation of the `R|P` boundary: unityping / no-leak; the decision that actor-origin metadata lives *outside* the kernel; and the presentation's buffer / availability-only / non-enactment prose ("chart the world, not inhabit and certainly not control it").
- **Positively, in the motivation** — the GR-inspired locality that motivates the Lamport-causal site, and the runtime↔reality boundary in the implementation-track plan. Elixir currently records caller-supplied contract evidence; a future runtime originator will produce behavior, and only then does a separate checker validate those events one-by-one.
- **Absent as a theorem in the formal middle** — workflow and `targets.md` now name the boundary, and Chu supplies a live point/state/evaluation carrier, but no Agda module yet formalizes Reality admission, erasure, or no-enactment.

Load-bearing fact: the kernel's identity *is* the boundary it maintains against Reality. Naming `R` is therefore mostly a *re-reading* — collecting the scattered refusals under one interface — not a new construction.

The draw is the concrete entry mechanism for this exterior. A task arrives in
one protocol-visible shape and an injected sampler consults an entropy source
outside the trace to select eligible people. The sampler interface and its
certificate shape can be stated internally; the eligible population, entropy,
and fact of selection are not thereby generated by the kernel. The draw is not
a second constitutive exterior and it should not carry task content, prior
failure history, or actor kinds.

### The identity filter

There is **one barrier on the identity channel, two-way**, and the *contribution* channel passes freely through it. *What an actor is* (origin, status, identity) is filtered out at the `R|P` boundary; *what an actor brings* is not.

- **Outward** (no-leak): the public documentation view does not encode who an
  actor is. A live runtime may temporarily hold operational routing identity,
  but v0 does not export its identity map.
- **Inward** (anti-distortion): who an actor is never biases how their contribution is received — this is the original 2019 insight (hide the experts so the reasoning stands on its own legs), and the same anti-essentialism as receiver-relative complexity (Layer 5).

### Reality's positive role

Reality is not only a boundary; it is the **site where perspectives are formed**. Agents *explore* Reality and shape their own perspectives there (exploration in the attachment-theory sense: exploring from a secure base). The Protocol is then where formed perspectives *meet and glue* into useful, sheaf-theoretically-conglomerated perspectives — *add-but-separate*: it adds coherence that did not exist without invading (non-enactment). The **buffer** (work / greeting / opening statement) acquires its purpose here: it is the entry gate through which a Reality-formed perspective crosses into the Protocol to be glued. The Documentation is the glued output, which feeds the caring algorithm, which returns secure bases to Reality — closing the loop. See the bootstrap-of-the-care-loop appendix in `motivation.md` for the tie to the initial/free model.

### How to deal with it

The discipline is the **open-system interface**, **not an internal sort.** Formalizing the interior of the exterior is the category error the openness principle forbids (and would re-import the totalization the framework refuses). Reality's entire formal footprint is the interface: the operations that cross the boundary (request, demand, buffered entry, availability-only *pull*) and the negative constraints that do not (no actor identity; no enactment). In CBPV form: `P → Request(R)` exists, `P → Effect(R)` does not — an external handler, outside the theory, turns a request into real work.

This yields a unification worth stating once: **openness at the top** (no total context, no topos of all toposes — Lawvere) and **non-enactment at the bottom** (no protocol encloses or controls Reality) are the *same* refusal-to-totalize, stated at two ends of the construction.

- **Re-reading (now, low cost):** collect the existing kernel-refusals under one named `R|P` interface; state the top/bottom openness unification.
- **Genuinely new (later, if earned):** the effect/capability discipline that makes non-enactment a *type-safety theorem* ("no well-typed protocol term has an unmediated reality-changing effect"); the buffered-entry model; the documented-demands ledger. All live at the runtime↔checker boundary (implementation track), and should be **co-designed with the Audit/provenance candidate** — the demands ledger and the no-leak erasure are shared between the two (provenance records *derivational* exterior dependence; Reality records *material/causal* exterior dependence).

### Bulk/boundary duality (mention only; transcript in arc/11)

A duality reading was explored: Reality and Documentation as two points of view related by a dualizing object — better named **Isbell/Gelfand duality** (space ↔ observables; Connes for the noncommutative/perspectival face) than holography, with a **Chu** realization `(Reality, Documentation, ⟨−,−⟩ : · → k)`. Chu is now implemented as value-category infrastructure and as the Sessions realization target, which makes this reading technically credible as an interface shape. It is still **non-reflexive** — the double-dual (Reality → observations → reconstruction) does not invert, and that non-invertibility *is* openness / the Anthropic anchor — so it is *not* a holographic equivalence. Full transcript in `arc/11_reality.md`. The current code supports the boundary/evaluation pattern; it does not yet prove a Reality-boundary theorem. Held as a conjecture, not a result; in particular, whether its dualizing object `k` coincides with the session dualizing object `⊥ₛ` is **open** and must be written as a conjecture, never asserted.

### Discipline / what this does not claim

- **Teleology quarantine.** `raison-d'être` (R→P) and `care-toward-reality` (P→R) stay as *motivation / prose*, not formal arrows — the same discipline `arc/09` used to keep Care as structure, not purpose.
- **No holographic equivalence** is claimed; the mirror is lossy by design.
- Reality is **not** added as an internal sort.

### Decision gates (before elevating the conjecture)

1. Foundational-floor reframing only, or does it earn the new constructions (effect-discipline, buffer, demands ledger)?
2. The "bulk" disambiguation: nested holographies (Reality | Documentation, then Λ | session) vs. renaming, since `arc/08` already calls the content layer `Λ` the "Bulk."
3. Does the no-enactment effect-discipline become a stated safety theorem on the implementation track, and is it co-designed with Audit/provenance?
4. Does the `k = ⊥ₛ` question resolve, or stay a permanent open conjecture?

## Lautman as theorem-shaper: analytic adequacy, synthetic invariance, and their compatibility

**Status and scope.** This is a cross-cutting theorem-shaping note, not a new cascade layer, a new formal dependency, or a reservation of Agda modules. Lautman's two decompositions do not supply Hoapa with theorems or a proof method. They supply a diagnostic matrix for converting philosophical interpretations into explicit mathematical obligations. The substantial comparison is recorded in `related_structures.md`; this section records only its future-work consequences and points back to the existing 2S, no-leak, provenance, Reality, and logical-presentation tracks.

The basic test has three questions:

1. **Analytic adequacy:** has the formal decomposition retained enough of this particular work-process to individuate it for the declared purpose?
2. **Synthetic invariance:** is the result stable under legitimate changes of the common basis, cover, actor presentation, or context?
3. **Compatibility:** do process-specific articulation and contextual recomposition commute coherently?

The third question is the most important. Separate analytic and synthetic constructions can each be mathematically sound while failing to constitute one architecture. Lautman's value as a theorem-shaper is to keep asking for the comparison law between them.

At the philosophical level the decomposed subject is understanding of the
world, embodied among participants and articulated in documentation. The
former is organized predominantly synthetically, the latter predominantly
analytically; the crossing above does not cancel that orientation. Participants
are co-producers inside a common scheme, not persons to be exhaustively
coordinatized. Formal candidates must select a represented fragment—runs,
contributions, artifacts, concepts, or contextual relations—and its adequacy
criterion. The assignment does not itself supply a decomposition map.

An architectural counterexample is formal standing determined by documentary
output, with other eligibility and protocol conditions fixed. Pair it with
the positive case where contributions receive different assessments but their
producers retain equal standing. This tests Hoapa's intended organization,
not a universal implication from unityping to synthetic decomposition.
See the canonical account in `related_structures.md`. It changes no
implementation batch or proof status and claims no panel-as-basis theorem.

### The theorem-shaping protocol

For every Lautman-inspired candidate, record:

1. the mathematical being being decomposed — raw run, realized frame, operational process, trace, artifact, sheaf, or context;
2. its ambient domain — actor namespace, causal frame, protocol version, documentation version, site, cover, slice, universe, or coefficient category;
3. the role of participants or other arbitrary admissible choices, kept distinct from both the being represented and its reference system;
4. the analytic decomposition map and its intended codomain;
5. the synthetic presentation that supplies the common mode of articulation;
6. the permitted changes of presentation;
7. the equality, equivalence, or trusted-observation notion against which invariance is measured;
8. what must be preserved;
9. what must deliberately be forgotten or hidden;
10. the naturality, descent, or comparison square that must commute; and
11. a small falsifier showing how the interpretation could fail.

This protocol is stricter than matching philosophical nouns to existing constructions. Until the entries above are specified, "analytic," "synthetic," "basis independence," and "replay" remain readings rather than theorem statements.

### Family A — analytic adequacy of process-to-trace articulation

The candidate shape is:

```text
W ↦ τ(W)
```

where `W` is an actual work-process and `τ(W)` is its typed trace or stabilized artifact. Adequacy must be relative to a declared family of trusted observations. Full faithfulness is neither required nor desirable: no-leak, privacy, and the constitutive exterior require the trace to forget actor identity and other protected dimensions.

Possible obligations include:

- **causal adequacy:** the trace records the parent/order structure required by the protocol's account of the process;
- **dependency and provenance adequacy:** assumptions, artifacts, open obligations, versions, and derivational dependencies needed for later checking remain identifiable;
- **concurrency invariance:** harmless reordering of independent events does not alter the trusted process represented by the trace;
- **purpose-relative sufficiency:** the trace contains enough information for a stated operation such as audit, checking, translation, resumption, or replay;
- **selective noninterference:** changing protected actor identity does not change trusted documentary content.

This family should consume the existing 2S runtime-to-substrate ladder rather than duplicate it. `BackwardRank.agda` and `CausalFromParents.agda` provide the global realization floor, while `ConversationLocality.agda` supplies per-conversation frames and strict embeddings. Event/actor coverage and cross-conversation causal saturation are banked, as is raw actor-renaming invariance. Realized change of actor base and frame equivalence remain next within the no-leak ladder. Provenance and purpose-relative replay adequacy come later, once the relevant artifact and observation interfaces exist.

### Family B — synthetic invariance under change of presentation

Lautman's basis example suggests a family of "no privileged presentation" targets. None follows from descent alone:

- **refinement invariance:** for an explicitly defined refinement `V → U`, descent objects over the two covers are equivalent under stated topology/cofinality hypotheses;
- **equivariance:** legitimate actor, event, frame, or site automorphisms act naturally and leave the reconstructed trusted object invariant up to the chosen equivalence;
- **no chosen basepoint:** a construction does not depend on a distinguished agent, event, chart, point, or global section unless one is part of the input;
- **conservative reindexing:** change of perspective transports the relevant judgments and evidence without silently strengthening, replacing, or erasing them;
- **presentation independence:** different admissible covers or coordinate systems reconstruct equivalent contextual objects.

The raw actor-renaming theorem is now the first proved member of this family: exact validator invariance under total injective actor relabeling, with the permutation specialization. Its realized change-of-base analogue is still open. Refinement invariance and general cover independence are later targets: the existing finite and supported point-generated results establish scoped descent and sheafification, not a general basis-independence theorem.

A second, base-relative candidate comes from the banked order comparison. State
`SaturatedIn(R, c)` relative to the realized run rather than treating
saturation as intrinsic to `c`, define append-only extension with an explicit
embedding of old evidence, and test whether an existing unsaturation witness
persists. The intended result is non-retroactivity of an exposed dependency,
not Simondonian metastability or a general completion theorem.

### Family C — compatibility of analytic and synthetic decomposition

This is the principal cross-layer family:

- **trace/reindexing naturality:** reindexing a process and then forming its trace agrees, up to the declared equivalence, with forming the trace and reindexing the artifact;
- **local analytic descent:** compatible process-specific decompositions on local frames glue to a global decomposition without inventing hidden actor or causal data;
- **operational/contextual Beck–Chevalley or Frobenius laws:** contextual base change commutes coherently with the relevant operational phase change where the required adjoints exist;
- **process-to-artifact stabilization:** a completed artifact satisfies an appropriate universal property relative to the work and observations it is intended to stabilize;
- **decompose/recompose adequacy:** reconstructing from analytic pieces preserves exactly the trusted content declared by the observational interface, neither less nor more.

These targets overlap deliberately with the logical-presentation track's stability-under-reindexing, Beck–Chevalley/Frobenius, descent, and process-to-artifact targets. The Lautmanian reading does not add a second list; it explains why those compatibility theorems, rather than a bare declaration of modes or layers, are likely to carry the framework-specific mathematical content.

### Family D — recursive replay, only after adequacy

The conversation in `workflow/arc/15_metaphysics_and_logic.md` proposed a possible `Doc : Op → Ct`, `Aff : Ct → Op`, and `Doc ⊣ Aff` reading with replayability and contextual-adequacy transformations. This family stays downstream of A–C.

Before an adjunction is proposed as a theorem, the project must:

1. define the categories `Op` and `Ct` at the required level;
2. construct `Doc` and `Aff` as functors;
3. choose the observational equivalence relative to which documentation is replay-sufficient;
4. show that replay respects no-leak and does not claim total reconstruction of Reality;
5. state and test the hom-equivalence, unit, counit, naturality, and triangle laws; and
6. verify that the proposed direction matches the implemented semantics rather than the desired prose.

Failure of an adjunction would not invalidate the analytic/synthetic reading. The correct interface may instead be a fibration, factorization, capability boundary, profunctor, or noninterference relation. `Doc ⊣ Aff` remains distinct from the conjectural cross-site `Allow ⊣ Require`, the checked point-generated reflector `a ⊣ ι`, and the checked point-generated LNL bridge `Lpoint ⊣ Rpoint`.

### Status and sequence

- **Banked ingredients:** actor-causal frames and strict-reflecting `FrameHom`; category-generic finite descent; the supported point-generated reflector; the point-generated LNL bridge; global and per-conversation realization from well-formed runs; and exact recorder-fidelity replay in 3R.
- **Nearest selected targets:** the minimal behavioral kernel first tests the
  causal premise; contract closure/reference evidence then supplies a
  live-to-public transform; relative actor-base change and each conversation-
  frame comparison consume it. Raw actor-renaming remains banked at `5670658`.
- **Later compatibility targets:** purpose-relative trace adequacy, provenance preservation, reindexing/refinement laws, and local-to-global trace formation.
- **Research-scale candidates:** a universal process-to-artifact property, replay/resumption semantics, and any `Doc`/`Aff` adjunction.

This classification now shapes the selected roadmap at two points: the
live-to-public observation makes selective analytic adequacy concrete, and the
base-relative unsaturation theorem supplies a bounded synthetic-invariance
candidate. It still provides no evidence for the cross-site conjecture.

### Guardrails and falsifiers

- A sheaf condition can hold while a construction still uses a privileged point, enumeration, actor, or cover; descent is not the full no-privileged-viewpoint theorem.
- A refinement statement such as `Desc_U(F) ≃ Desc_V(F)` is not valid without a precise refinement map and sufficient hypotheses.
- The cover/basis analogy fails if change of cover changes trusted global content in a way not explained by the chosen equivalence.
- Analytic adequacy fails if a trace loses causal or provenance information required for its declared use; it also fails by overreach if it reconstructs or exposes information the boundary promised to forget.
- Compatibility fails if local traces are individually valid but their gluing invents hidden dependencies, or if trace formation is not natural under perspective change.
- Replay fails if two observationally equivalent traces afford materially different trusted continuations, or if replay requires access to protected exterior data.
- Hilbertian theory/metatheory remains a useful second-order parallel, not an identification of metatheory with Lautman's Dialectic.

### Decision gates

1. What is the first declared observational equivalence for traces: checker acceptance, causal-frame isomorphism, audit equivalence, or another relation?
2. Which target should first instantiate the synthetic family beyond actor renaming: no chosen basepoint, cover refinement, or reindexing conservativity?
3. Can the landed per-conversation realization and cross-conversation witness state a first trace/reindexing naturality square without waiting for provenance or Bulk `Λ`?
4. Which data must analytic adequacy preserve, and which identity channels must it provably forget?
5. Is process-to-artifact stabilization a universal construction in the current LNL/CBPV candidate, or does it require a different mathematical kind?
6. What concrete counterexample would distinguish genuine basis independence from invariance built in by a trivial presentation?
7. Only after A–C have nontrivial witnesses: do `Doc` and `Aff` exist as functors, and is an adjunction still the right relation?


## Arc/16 consolidation: mediator and care theorem-shapers

**Status and scope.** The substantive outcome of
`workflow/arc/16_grothendieck_givesthemathsfor_simondonindividuation_via_lautamaniandecomposition.md`
is corrective and consolidating. It adds no new support for
`Allow ⊣ Require` and does not move the `MO_1` gate. It sharpened the
non-collapse ladder, the distinction between `(0, 3)` arity and Belyi cover
data, and the then-control reading of `η-equiv-at-T`. Arc/17 subsequently
exposed the flat-signature collapse and reopened 1C for a different reason.
Context renewal, informed by the Lautman–Simondon–Grothendieck crossing, is now
the forcing direction for M; it is not evidence that M or the adjunction exists.

### A specific space-valued mediator candidate

An adjunction already determines a profunctor representable on both sides, so merely asking for a two-sided representable `P` would restate T1. The content-bearing route is the reverse: construct independently from admissible interaction-, cover-, and dessin-shaped realizations a specific space- / ∞-groupoid-valued profunctor

```text
P_shape : Mᵒᵖ × K → Spaces,
```

and only then ask whether there are coherent equivalences

```text
Map_K(Allow(M), K₀) ≃ P_shape(M, K₀) ≃ Map_M(M, Require(K₀)).
```

Space-valuedness is essential: a Set-valued mediator would truncate the homotopy-shape information it is meant to carry. Before this becomes a target, the project must define M and K at the required level, define `P_shape` on objects and morphisms independently of `Allow` and `Require`, and state its homotopy coherence. Until then, the "mediator column" in `targets.md` is an interpretive locator rather than a third constructed category.

The branch-data gate comes first. The modal route currently suggests a bare `S²`; the Esquisse route uses a rigid three-marked projective line together with varying ramified covers. A cyclic bar construction supplies cyclic structure or an `S¹`-action, but does not by itself supply marked branch values or ramification. The research question is therefore whether the M side can acquire and preserve three-point branch / orbifold data, or whether the proposed meeting point must move.

The regular degree-60 A5 dessin is a gated finite test element for such a `P_shape`, after that branch structure exists. Its first test is structural—whether both presentations preserve compatible branch cycles and monodromy—and only secondarily whether the resulting group is A5. Failure to recover A5 from a bare suspension chain would show only that the branch data were absent. A single dessin may falsify a candidate component or compatibility law; it cannot construct an adjunction, verify naturality or triangle identities, or model the iteration. Its static finite symmetry supplies none of T_recursion's transition maps.

### Care-compatible episode morphisms

The checked Care anchor remains the involution `(–)⊥`. Arc/16 suggests a downstream semantic class of morphisms on which that involution would act coherently. A plausible technical home is a distinguished class of Kleisli arrows `M_t → T(M_{t+1})`, composed through the multiplication of the eventual cross-site monad. Such arrows can express successive actual episodes through changing contexts, whereas the existing `η`-orbit iterates one seed. This is a candidate complement to the current sequential-colimit construction, not a replacement or a settled refinement.

To earn the name *care-compatible*, the class would at minimum need a stated observational semantics, closure laws, compatibility with `(–)⊥`, and proofs that its replay preserves exactly the declared carriers, plurality, and future admissibility. The identity/no-ranking part depends explicitly on the unproved 2S no-leak theorem family; it is not scheduled independently of that work. Construction also requires the full adjunction/monad interface absent from the current `Iteration` scaffold, plus whatever cocompleteness and coherence hypotheses relate a changing-context Kleisli chain to a sequential colimit.

### Comparison-strength and iteration warnings

The faithful map `G_ℚ ↪ GT` is not a known proper inclusion: surjectivity remains open. It therefore supplies no precedent for counit non-invertibility, monad non-idempotence, or persistent iteration. Its useful lesson is methodological: faithfulness or monicity must not be confused with fullness, surjectivity, or equivalence. Structurally, the Esquisse-side theorem-shaper for recursion is the moduli tower, not any single dessin and not the unresolved gap between `G_ℚ` and `GT`.


## Candidate logical-presentation track: mode theory and indexed context

**Status and scope.** This section records the candidate research program for giving the **whole Hoapa framework** a mathematical-logical presentation. It is independent of the presentation's `R/P/A/D` conceptual diagram and of the Reality and provenance repairs above. Those concepts may eventually require types, effects, interfaces, or modalities in a Hoapa logic, but they do not determine that logic's modes in advance. This track is not a cascade layer and reserves no Agda module. It now supplies candidate grammar for the selected 1C programme; its staged investigation below is local to this candidate, not a second lane-wide schedule. Its first task is discovery: identify the framework's genuine judgmental regimes and transformations before choosing an encoding.

The current candidate is **mode theory** in the broad line from adjoint logic through the Licata–Shulman–Riley fibrational framework, Multimodal Dependent Type Theory (MTT), and Multimodal Adjoint Type Theory (MATT). These frameworks can generate a type theory from a small presentation of modes, modalities, and transformations, and supply general metatheory such as cut admissibility, normalization, consistency, or canonicity under their respective hypotheses. This makes mode theory a credible presentation language. It does **not** establish that any current Hoapa noun is a mode, that any philosophical reciprocity is an adjunction, or that one existing multimodal calculus already contains all of Hoapa.

### Intended role

The target is a logical grammar whose models can include:

- the world/context side being rebuilt (including cohesive candidates where appropriate);
- the actor-causal, sheaf, session, and operadic concurrency side;
- the concurrency-internal cartesian↔linear R4 bridge;
- eventually, the cross-site `Allow ⊣ Require` pair and its iteration;
- later extensions such as protocol versions, content, federation, provenance, and the Reality boundary, only after each earns a logical form.

The logical presentation should expose which structures are primitive, which are derived, and which are properties of models. A higher cohesive realization and a lower logical shadow may later be related by explicit interpretations or reducts, but neither is fixed at this stage. In particular, the higher theory is not obtained by "undoing truncation" of a lower one, and the syntax's initial model would establish freeness or least commitment relative to chosen rules, not social or engineering optimality.

### Three structures that must remain distinct

#### 1. Contextual indexing: telescopes, slices, and descent

Dependent type theory supplies the most natural current candidate for **context as point of view**. A telescope `Γ` is an iterated context extension; in categorical semantics, types in that context live over `Γ`, and in a topos or ∞-topos `ℰ` they are read in the slice `ℰ/Γ`. A substitution `f : Δ → Γ` induces base change `f* : ℰ/Γ → ℰ/Δ`, with the familiar dependent adjoints `Σ_f ⊣ f* ⊣ Π_f` when they exist.

This gives a disciplined interpretation of one logical grammar varying over contexts and suggests an indexed family such as:

```text
Γ ↦ Hoapa-structures internal to ℰ/Γ
```

It does not yet give the project's full recursion. Ordinary extension from `Γ` to `Γ.A` makes a new type-theoretic context, but it does not by itself show that a completed covering, protocol, or documentation generates a new world of inquiry. Likewise, slices do not supply a Grothendieck topology, descent, or a network of distinct topoi without additional data. These are separate naturality obligations.

#### 2. Operational phasing: CBPV and LNL

Call-by-push-value (CBPV) supplies a candidate distinction between **stable values** and **effectful computations**, connected by an adjunction `F ⊣ U`. Benton linear/non-linear logic supplies a related cartesian↔linear adjunction, with the linear exponential obtained from its composite. The relationship is close but not identity: CBPV emphasizes evaluation and effects, while LNL emphasizes cartesian and linear resource disciplines.

The checked point-generated R4 theorem is the grounded Hoapa fragment on this axis:

```text
Lpoint ⊣ Rpoint
```

over cartesian locality and linear/session-valued point sheaves, relative to the value-level LNL and finite-product hypotheses. This has the outer categorical shape needed for an LNL/CBPV investigation, but it is not yet a CBPV calculus, an operational semantics, or a process→artifact construction.

A promising interpretation is that a live conversation or document-producing activity is a computation, while a completed, citable artifact is a value. This is a **candidate phase distinction**, not a result. The current Agda constructs linear session-valued sheaves and cartesian locality sheaves; it does not construct the claimed stabilized artifact phase. Before adoption, the track must identify the extra structure that makes completion, persistence, copying, citation, and provenance coherent with R4.

#### 3. Framework-level modes and modalities

A Hoapa mode must denote a genuine **regime of judgment**, not merely a component, stakeholder, or sort. For every candidate mode `m`, the project must be able to state:

```text
Γ ⊢_m A
```

and explain what propositions/types `A` mean, what hypotheses may occur in `Γ`, which structural rules apply, and which category or higher category interprets the judgments. A mode morphism must act on judgments/types; a 2-cell must compare such actions. If an adjunction is claimed, its natural hom-equivalence, unit, counit, and triangles must be exhibited in a model.

This test deliberately does not preselect `R`, `Ag`, `P`, `D`, ModalHoTT, Concurrency, or the cascade layers as modes. Some may become modes; others may instead be effects, models, sorts, predicates, audits, factorization laws, or external interfaces. Reality in particular remains the constitutive exterior described in the preceding section, not an internal mode by default.

### Piecewise naturality protocol

Every proposed import into the logical presentation must be recorded in six parts:

1. **Intrinsic claim.** State the Hoapa claim without imported technical vocabulary.
2. **Mathematical kind.** Classify the required object: judgmental mode, modality, adjunction, effect, capability, factorization, descent condition, audit, transition, or model property.
3. **Nearest established structure.** Name the existing theory that appears to carry it.
4. **Exact gain.** State only what that theory supplies without further Hoapa assumptions.
5. **Missing obligations.** List the functors, equations, coherence, model, or theorem still required.
6. **Falsifier.** Give a small example or incompatibility that would show the proposed identification is wrong.

For a candidate mode, add a **mode-legitimacy table** with judgment form, context discipline, structural rules, semantic category, and at least one non-syntactic model. For a candidate edge, record whether it is a modality, effect/computation, audit/relation, or factorization law; only the first class belongs automatically in a mode theory. Mediation and descent must never be conflated: factorization through an interface and unique gluing of compatible local data are different laws.

### Grounded relationships, candidates, and rejected shortcuts

**Grounded or literature-backed:**

- mode theories can present interacting modal and substructural logics and can support reusable metatheory;
- dependent contexts have slice/base-change semantics, with `Σ_f ⊣ f* ⊣ Π_f` under the usual hypotheses;
- CBPV separates values from computations and factors effects through `F ⊣ U`;
- LNL separates cartesian and linear regimes;
- point-generated R4 is a machine-checked sheaf-level LNL adjunction under its stated hypotheses;
- cohesive modalities are geometric/modal structure and must not be identified with operational roles without a theorem.

**Candidates to test:**

- a fixed Hoapa logical grammar interpreted in every contextual slice;
- compatibility of that grammar with reindexing, covers, and descent;
- an R4-supported CBPV interpretation of protocol execution;
- a constructed transition from live linear processes to stable artifacts;
- an indexed or fibred mode theory combining contextual and operational structure;
- a later derivation or concrete model of `Allow ⊣ Require` from independently justified ingredients.

**Rejected as present conclusions:**

- `R/P/A/D` are already the four modes of Hoapa;
- every reciprocal conceptual relation is an adjunction;
- the contextual and operational structures are proved independent or orthogonal;
- the CBPV value/computation distinction already solves the session/document distinction;
- context extension `Γ.A` already is evolutionary context generation;
- mediation already is sheaf descent;
- R4 already is the cross-site adjunction;
- the cross-site adjunction simply reads off from a mode diagram;
- initiality or a free adjoint proves optimality;
- one can reconstruct the higher framework uniquely from a lower logical reduct.

### Candidate architecture, held loose

The current least-committal shape is a context-indexed family of models of a not-yet-fixed Hoapa grammar:

```text
Γ ↦ Mod_Hoapa(ℰ/Γ)
```

with reindexing along context maps and, where a topology is present, descent along covers. Within each fiber there may be an operational value/computation or cartesian/linear adjunction. Cohesion may structure the ambient contextual geometry. None of these placements is yet an equality of structures.

The central compatibility questions are likely Beck–Chevalley- or Frobenius-shaped: does contextual reindexing commute coherently with the operational adjunction, and do the resulting structures descend? These questions are more informative than selecting a large fixed mode graph in advance because they test whether the two candidate dimensions genuinely form one logical system.

### Staged investigation

1. **Claim inventory.** Extract the framework's actual judgmental distinctions and transformations from `motivation.md`, `arc.md`, `targets.md`, the Agda interfaces, and the candidate-hole sections. Do not translate them yet.
2. **Legitimacy pass.** Apply the mode/edge tests and the six-part naturality protocol. Produce the smallest candidate grammar and record rejected identifications.
3. **Toy semantics.** Construct a finite Set-valued or presheaf-valued model. The first goal is consistency and intelligibility, not coverage of the cascade.
4. **R4↔CBPV test.** State exactly which extra action, enrichment, term, or effect data turns the point-generated LNL adjunction into a CBPV-like model, and construct or reject the process→artifact phase.
5. **Context-indexing test.** Reindex the toy/R4 structure along a small family of context maps; formulate the relevant Beck–Chevalley/Frobenius comparisons; then test descent on a finite cover.
6. **Framework choice.** Only after the toy models decide whether LSR-style adjoint logic, MTT, MATT, linear dependent type theory, dependent CBPV, an indexed combination, or a custom calculus is the natural host. The existing Cubical Agda development and external tools such as multimodal proof assistants are implementation options, not selection criteria.
7. **Higher/lower comparison.** Once syntax and at least two semantics exist, define any reduct/interpretation explicitly and state what it forgets. Investigate an initial syntactic model and free/forgetful constructions without reading them as optimality results.
8. **Cross-site instance.** Attempt `Allow ⊣ Require` only after the modal-context semantics, structured concurrency semantics, and their compatibility laws have independent definitions.

### Possible theorem targets

- soundness and normalization inherited from a host framework after an adequate encoding theorem;
- adequacy of the toy model for the chosen Hoapa judgments;
- stability of the operational adjunction under contextual reindexing;
- Beck–Chevalley/Frobenius laws relating context change and operational phase change;
- descent of Hoapa-model structure over a cover;
- a universal property for process→artifact stabilization;
- a preservation theorem for a later higher→lower reduct;
- a concrete non-collapse or non-trivial-iteration witness for the cross-site instance.

The first Hoapa-specific mathematical value is most likely to lie in one of the compatibility theorems, not in the bare declaration of modes. Novelty should be claimed only after comparison with multimodal, linear dependent, effectful, and indexed type theories.

### Relationship to the candidate holes

Reality and provenance remain independent candidate repairs. They should be consumed by the logical-presentation track only after their mathematical kinds are clear. Reality may contribute an external effect/capability boundary; provenance may contribute an audit, indexed history, or transition structure. Neither should fix the mode graph or dominate the logical presentation of the whole framework. Conversely, the mode-theory track must eventually explain how such interfaces attach if they are promoted, rather than treating their prose as primitive modalities.

### Decision gates

1. What are the first genuine Hoapa judgments, and which differences between them require distinct modes rather than distinct types or effects?
2. Is the contextual organization one ambient `ℰ` with slices, a network of topoi, or a staged combination?
3. Does R4 admit the extra structure required for a CBPV interpretation, and what exactly is a stabilized artifact?
4. Do contextual reindexing and the operational adjunction satisfy coherent comparison laws?
5. Which host framework expresses the smallest validated grammar without forcing unsupported structure?
6. Which model beyond syntax demonstrates that the presentation is not merely a restatement of its rules?
7. What precise property would make the eventual logical presentation foundational for Hoapa: initiality, classifying semantics, conservativity, theorem transport, or another universal property?

### Research anchors

- Licata–Shulman, *Adjoint Logic with a 2-Category of Modes*.
- Licata–Shulman–Riley, *A Fibrational Framework for Substructural and Modal Logics*.
- Gratzer–Kavvos–Nuyts–Birkedal, *Multimodal Dependent Type Theory*.
- Shulman, *Semantics of Multimodal Adjoint Type Theory*.
- Levy, *Call-By-Push-Value* and *Adjunction Models for Call-By-Push-Value with Stacks*.
- Benton, *A Mixed Linear and Non-Linear Logic: Proofs, Terms and Models*.
- Vákár, *A Framework for Dependent Types and Effects*.
- Vákár, *Syntax and Semantics of Linear Dependent Types*.

### Discussion of "truncate everything"

Historical exchange retained as source material, not additional selected work.
The current programme and its evidence levels are stated at the top of this file.

#### Claude

❯ Now, I want to briefly discuss, on a philosophical level, how the framework can use the analogy between unityping of actors and the distinguishability of elements of a set         
  introduced by the axiom of choice. A target I have in the back of my head is to be able to "truncate everything in the framework" into a purely set theoretical setting, killing a  
  large part of the structure, and crucially, what makes it implementable, but still be able to say something meaningful at this level and in this language. Truncation itself I      
  think would be our main tool, but in some places we're probably going to have to be more subtle, and in the end construct a sort of Yoneda-like functor that retains something of   
  the rich structure in the low structure, that truncation would have simply ignored.                                                                                                 
  First, do you see this as a. interesting? b. feasible? c. possibily of some help for our conjecture? (since set theory is actually what most everyday-mathematicians want their     
  math to be grounded upon, I think we should be able to have a meaningful portal from the rich & collective setting to the low & individual setting)                                 
  
● Short verdict: a. yes, genuinely; b. feasible, but only if you're precise about what "truncate" and "set-theoretic" mean; c. yes, but as a measuring/demonstration instrument for 
  the conjecture, not as a proof of it. Let me give you the substance, including two places where I'd push on the framing.

  The framing needs sharpening in two spots

  1. "Truncation" is not one operation. What you're calling truncation is really a family of collapses along independent axes of richness, and only some are h-truncations:

  - homotopical (h-levels): 0-truncation ‖-‖₀, a genuine modality in cubical, kills higher paths;
  - cohesive/modal (the modal side): passing to discrete objects trivializes shape/flat;
  - locality (the sheaf side): global sections Γ, or evaluation at a point, collapses descent;
  - linear (the coefficient side): the Benton right adjoint G, which is exactly the "take the points" map — in Chu, G(A)=A⁺, discarding the state-carrier A⁻. That's the transcript's
  !-erases-A⁻ observation, read as a truncation.

  Treating these as one tool is where it would go wrong. They're distinct forgetful/reflective functors, and the interesting content is which invariants survive each.

  2. "Purely set-theoretic" has to mean Set-valued, not bare sets. This is the crux, and it's exactly your Yoneda instinct made honest. You cannot retain rich structure in bare-set
  objects — that's what "the higher structure is nontrivial" means. But you can retain all of it in Set-valued functors: Yoneda embeds any category faithfully into [C^op, Set]; the
  nerve stores an ∞-category in simplicial sets; a symmetry-carrying set is a functor BG → Set. So the portal doesn't land in Set, it lands in presheaves / relational structures over
  Set — ordinary mathematics, which is what everyday mathematicians actually mean by "grounded in sets," not a single bare set. With that reading your goal is achievable; with the
  bare-set reading it's provably lossy, and the loss is the whole point.

  Why it's more feasible than it looks: two portals are already built

  The mature name for "truncate but keep an invariant" is decategorification (Baez–Dolan) — groupoid cardinality retaining what π₀ forgets is the prototype. And the framework already
  contains two decategorification-style portals:

  - The SET endpoint of the finite sheaf construction (you already instantiate the generic descent at coefficients = Set): the collective descent has a set-level shadow already.
  - Chu(Set, Bool) is itself the portal for the linear axis. It is pure set-theoretic data — two sets and a Bool-valued pairing, i.e. a relation — that nonetheless carries
  ⋆-autonomous structure. So the one axis where naive truncation must fail (linear structure can't live in cartesian Set objects) is precisely the one where the framework already
  encodes the structure in set-level relational data. That's your Yoneda-like retention, concretely, and it's checked.

  The genuinely beautiful part: the actor axis carries the conjecture's content

  Here the AC analogy pays off exactly. Truncating to a classical, choice-holding Set setting is distinguishing the actors — Booleanization gives decidable equality, which
  individuates them. So the passage rich→low is literally collective → individual: the uniform, unityped, no-privileged-viewpoint community collapses into a set of atomized,
  choosable elements. And what breaks in that collapse is precisely the "no privileged points of view" / actor-renaming-invariance theorem.

  That tells you what a faithful portal on this axis must retain: not the set of actors, but the relabeling symmetry acting on it — a G-set, a functor BG → Set, a presheaf on a
  delooping. Which is exactly the homotopical richness bare-set truncation throws away, and it points straight at the modal side's Bℤ site: deloopings are the canonical retention of
  the symmetry that sets forget. So the renaming-invariance theorem is not just a nice property; it is the obstruction that measures the collective→individual collapse. The portal's
  failure to be faithful on the actor axis is the theorem.

  For the conjecture

  It helps in two honest ways, neither of which is "it proves T1":

  - It makes the foundation/praxis split measurable. The kernel of the portal — what truncation kills — is exactly the praxis surplus: implementability, concurrency, the collective.
  Foundation-adequacy = the statements survive to the set-level target; praxis-adequacy = the doing lives only upstairs. The portal turns the Grothendieck/Hersh thesis into a
  comparison you can point at, rather than a slogan. That is strong, and it's aimed precisely at the set-minded reader you want to reach.
  - It's structurally on-brand. rich⊣low and collective⊣individual are themselves adjunction-shaped, orthogonal to Allow ⊣ Require, and fit the framework's "every separation is an
  adjunction" motif.

  The caution: "truncate everything" can trivialize into "of course Set can host the statements," so the value is never the truncated object; it is the kernel and the
  non-faithfulness. The creative act is choosing the retention invariant (which is not canonical — Yoneda retains everything but only into presheaves). Pick the wrong one and you get
  a tautology; pick the right one (equivariance for actors, Chu for linearity, nerve for the homotopy) and you get a shadow theorem that says something.

  Want me to try stating the portal as an actual functor — domain, codomain, and the one invariance it's required to preserve — and see whether it survives contact, the way the
  outside instance offered to pressure-test the negative? That would tell us fast whether "meaningful shadow" or "tautology."

#### Codex

• This is a strong answer. I agree with most of it, with a few corrections to keep it from becoming too smooth.

  The best part is the warning that “truncation” is not one operation. That is exactly right. In this framework we have at least:

  - homotopy truncation;
  - forgetting cohesive/modal structure;
  - taking global sections or points of sheaves;
  - forgetting linear structure through an adjoint;
  - decategorifying operational traces;
  - replacing equivariant/community structure by bare sets.

  Those are different functors with different kernels. The interesting mathematics is not “we truncate everything,” but “which invariants survive which forgetful move?”

  I also strongly agree with the “Set-valued, not bare sets” correction. A meaningful low-level portal should not usually land in an unstructured set. It should land in ordinary set-
  based mathematics: presheaves, relations, graphs, G-sets, simplicial sets, Chu spaces, structures over Set. That is still “set-theoretic” in the everyday mathematical sense, but it
  can retain shape, symmetry, incidence, duality, and observables. Bare-set truncation is mostly useful as a failure mode.

  Where I’d be more cautious:

  1. “Booleanization gives decidable equality, which individuates actors.”
     This is philosophically useful, but technically it depends on where the actors live. In our current theorem, actor-uniformity is site-level/naturality/equivariance, not
     undecidable equality inside a topos. Classical Set can distinguish elements, yes, but the more relevant loss is not just decidable equality. It is forgetting actor-renaming
     symmetry and no-leak constraints.

  2. “The portal’s failure to be faithful on the actor axis is the theorem.”
     This is promising, but not yet a theorem. The honest theorem shape is something like actor-renaming invariance / no-leak: relabeling actors changes presentation, not trusted
     observable content. Then a bare-set portal fails exactly because it remembers actor identity too strongly or forgets equivariance too aggressively, depending on the direction.

  3. “Every separation is an adjunction.”
     Useful slogan, dangerous as a rule. Some separations are adjunctions, some are fibrations, some are quotient/forgetful maps, some are noninterference constraints, some are just
     interface boundaries. We should keep the adjunction motif, but not force it.

  What I think is genuinely valuable here:

  - It gives a good name to a future track: set-level shadows or ordinary-mathematics shadows.
  - It clarifies that the goal is not to reduce Hoapa to Set, but to build controlled reducts into set-based structures.
  - It says the real information lies in the kernel: what the reduct forgets, what it preserves, and what obstruction appears when you try to recover the upstairs structure.
  - It links well to the next formal target: actor-renaming/no-leak as the first “shadow theorem.”

  My suggested formulation of the direction:

  > Build a family of named reducts from the rich Hoapa structures to set-based structures. Each reduct must state what it preserves, what it forgets, and which non-faithfulness or
  > obstruction measures the lost praxis structure.

  I would not yet try to make one grand Yoneda-like functor for the whole framework. Start with three portals:

  1. Actor portal: from actor-causal contexts to equivariant set-based structures, preserving relabeling invariance.
  2. Linear portal: from Chu/LNL coefficients to relational set-based data, preserving duality enough to witness the linear shadow.
  3. Sheaf portal: from event-local sheaves to Set-valued sheaves or global sections, measuring what descent loses.

  Then later ask whether they assemble into one doctrine-level reduct.

  So: yes, interesting; yes, feasible in pieces; yes, useful for the conjecture as a measuring instrument. But it should be developed as a family of carefully named reducts, not as
  “truncate everything” in one stroke.

## Emails for extended abstract

2. Email Plan

  I’d write 3 core emails, with a possible 4th if we have a very specific target.

  Audience A: Formalization / Cubical Agda / proof assistant people

  Angle:
  “This is a modest theorem, but a checked integration of Chu, Benton LNL, finite sheaf/descent, and cubical Agda infrastructure.”

  Topics:

  - postulate-free Chu coefficient model;
  - Benton LNL interface;
  - event-local sheafification;
  - why Cubical Agda matters.

  Ask:
  “Does this look like reusable formalization infrastructure, and is there a natural venue/community for it?”

  Response strategy:
  Make the ask concrete: not “is Hoapa interesting?” but “is this formalization package legible/useful?”

  Audience B: Categorical logic / linear logic / LNL people

  Angle:
  “We have a small checked Benton-style sheaf lift, with a concrete Chu coefficient instance.”

  Topics:

  - LNL adjunction lifted to event-local sheaves;
  - Set ↔ Chu(Set,Bool);
  - resource-sensitive coefficients vs cartesian locality;
  - limitations explicitly stated.

  Ask:
  “Is the formulation mathematically honest, and are the hypotheses the right ones?”

  Topics:

  - actor-causal site;
  - site/fiber separation;
  - event-local descent;
  - path toward richer causal descent and operational session semantics.

  Ask:
  “Does this site/fiber framing look like a useful categorical model of interaction, and what next theorem would make it compelling?”

  Response strategy:
  Aim for strategic feedback, not acceptance. They care about payoff.

  Optional Audience D: HoTT / foundations / modal type theory

  Angle:
  “This is the first operational fragment of a larger modal/cohesive architecture.”

  - the theorem as the K side;
  - eventual M ↔ K adjunction;
  - cubical/funext relevance;
  - future mode-theoretic presentation.

  Ask:
  “Is the foundational Outlook coherent, or does it overstate what the checked theorem supports?”

  Response strategy:
  This email should be the most cautious. It risks sounding grand unless the modest theorem is foregrounded first.

  General Email Dynamics

  Each email should be short:

  - one sentence of context;
  - one paragraph stating the theorem;
  - one paragraph saying why we’re contacting them specifically;
  - one concrete question;
  - links to PDF, repo, and theorem entry file.

  The key tactic is to ask for a bounded judgment, not general approval. People answer specific questions; they ignore “what do you think of my framework?”

  • The plan is basically sound, but it needs one correction and one sharpening.

  First correction: the excerpt has a structural omission. Audience C is missing its header. The block beginning with:

  > actor-causal site; site/fiber separation; event-local descent...

  is clearly Audience C: Applied category theory / categorical concurrency. That needs to be restored, otherwise the plan jumps from B directly into topics without an angle.

  Second correction: for emails, I would now use site/coefficient separation, not site/fiber separation, because we deliberately chose that vocabulary in the abstract. “Fiber” is
  mathematically suggestive, but it is not introduced.

  The general strategy is right: each audience gets a bounded ask, not a plea for validation. That is the most important thing. The recipient should know exactly what kind of reply
  would help.

  My assessment by audience:

  A. Formalization / Cubical Agda
  Strongest near-term email. This is where the work has the clearest concrete value. The ask should be about reusable infrastructure, proof style, and whether the Cubical Agda
  packaging is legible. This is likely the best first batch.

  B. Categorical Logic / Linear Logic / LNL
  Useful, but should be humble. A specialist may find the theorem unsurprising, so the email should explicitly say “modest checked fragment” and ask whether the statement/hypotheses
  are clean. Do not lead with novelty here.

  C. ACT / Categorical Concurrency
  Potentially the most conceptually aligned, but also the most demanding. They will care less that the assembly typechecks and more whether the actor-causal site and site/coefficient
  separation pay off. The right ask is exactly: what next theorem would make this compelling?

  D. HoTT / Foundations / Modal Type Theory
  Highest risk, highest ceiling. The Outlook may interest them, but it can sound overextended. This should probably go only to people likely to tolerate speculative architecture, and
  the email must foreground the checked theorem before mentioning M ↔ K.

  One adjustment: I would not include all three links in every email if it makes the message look bulky. Use:

  - PDF attached;
  - repo link;
  - one “entry module” link only if the audience is formalization or technically likely to click code.

  Suggested send order:

  1. Formalization people first.
  2. Categorical logic/LNL second.
  3. ACT/concurrency third, after seeing if the first replies surface issues.
  4. HoTT/foundations last, and selectively.

  The exchange is good overall. It gives us a disciplined outreach strategy: different audiences, different value proposition, one bounded question each.
