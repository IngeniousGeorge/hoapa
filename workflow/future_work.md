# Future Work

The coming-work register: the selected research programme, concrete obligations,
and continuations of shipped modules. This is not a second immediate queue.

## Reader's note

[current_track.md](current_track.md) owns **what is immediate**; this file owns
**what is coming up**; [openings.md](openings.md) holds **the horizon**.
The status files report checked scope, implementation state, and blockers.
A horizon may supply a bounded coming task without moving its whole subject here;
selection of a task does not prove its hypotheses.

This reorganization preserves existing priorities and evidence levels. The
selected 1C programme remains independent of the 2S/3R delivery sequence, and
no first 1C construction is chosen. Source arcs and frozen snapshots are unchanged.
See the [migration ledger](deep_context/archived_planning_2026-10-09.md#migration-ledger)
for where earlier sections went, including retired work orders whose rationale
remains recoverable.

## Coming programme and dependency order

The next program is selected. Its order is architectural, not a demand that
only one lane run at a time.

1. **1C relational adequacy and M rebuild, in parallel.** Extract K's
   categorical essence, compare meaningful alternatives and independent
   siblings, and seek what makes Hoapa-like organization especially adequate
   to a context and its renewal. Universal properties lead the search; neither
   cohesive topoi, a fibred base, nor a numerical metric is preselected.
   The programme and named unmet obligations are in [future_work.md](future_work.md#selected-1c-programme-relational-adequacy-and-the-m-rebuild).
   The mirror sketch in [arc/18](arc/18_evolutionary_adjunction.md#the-mirror-separation-integration-and-reciprocal-induced-structure)
   investigates K's separations enabling integration on M and M's capabilities
   inducing further distinctions on K. It and the generation–description
   sketch are candidate organizations, not implemented frameworks.
2. **3R minimal causal kernel.** Produce one event whose parent is earned from
   a message actually consumed by a handler, record it through the existing
   `EventLog`, and retain a test that fails when dependency piggybacking is
   broken. This tests the premise beneath the existing 2S causal tower.
3. **2S contract v1.** Add a distinguished success/failure closure event,
   run-local and federated artifact references, reference integrity, at-most-
   one closure and nothing-after-closure for valid prefixes, exactly one
   closure for published conversations, and stable publisher-scoped content
   identifiers. Start with rejecting fixtures.
4. **2S public/live boundary and Tier B.** Specify per-conversation actor
   pseudonymization, no export of the live identity map in v0, and a public
   content observation. Add substrate-native change of actor base and a
   relative `FrameHomOver` beside banked fixed-base `FrameHom`; prove each
   conversation frame equivalent to its public image. Tier A alone does not
   prove this.
5. **2S relative views and base-relative statements.** Relate registered,
   panel, and event-supported views; factor the reusable finite-membership
   lemma; state causal saturation relative to a run and test persistence of an
   unsaturation witness under append-only extension. Do not rename these
   predicates as metastability or encapsulation.
6. **3R full assembly.** Add task intake, injected selection, panel processes,
   event-id dependency flow, success/failure closure, publication transform,
   corpus acceptance, and resubmission. Candidate, assent, silence policy,
   panel size, and entropy remain interface parameters. A separate checker app
   is earned only here, once behavior exists to check incrementally.
7. **Λ and Federation.** Interpret conversations, output artifacts, concepts,
   documentation versions, directed dependencies, and admitted comparisons
   from published evidence. Require designated observations to descend through
   any compression. Exercise the artifact interface with two independent peers
   before freezing it: collide local IDs, retain an offline pinned import,
   admit different comparisons, and withdraw one comparison on only one peer.
8. **Context renewal.** First show a successful artifact becoming an admissible
   input to further work while specified achievements remain usable and a new
   operation becomes possible. Only later add bounded protocol change with
   explicit versions and activation boundaries. This is K's forcing case for
   asking what M must say about contexts.

## Selected contract and runtime work

This gives the detailed contract/runtime continuation of the dependency order above.
It separates
the smallest behavioral test from the eventual assembly so that the causal
premise is tested before more formal structure depends on it.
Earlier competing recommendations are retained in the
[planning archive](deep_context/archived_planning_2026-10-09.md#superseded-recommendations).

1. **3R minimal causal kernel.** A few in-memory actor processes exchange
   messages carrying the event ID that produced them. A handler records an
   event whose parents are the IDs attached to the messages it actually
   consumed. The event passes through the existing `Hoapa.Core.EventLog` and
   exports through the current contract. Red-first: disabling dependency
   piggybacking changes the exported trace and fails a retained test. No
   closure, selection, persistence, Phoenix, or checker app is required here.
2. **2S contract v1.** Add closure and reference constructors and the separate
   valid-prefix/closed-publication predicates specified in
   [implementation status](status_implementation.md#selected-contract-v1). Add fixture
   expectations first, regenerate data-only Agda terms, export the corpus, and
   make every existing freshness/conformance gate green. This work changes
   schema and codecs only as the chosen sum representation requires.
3. **2S publication/no-leak.** Specify the live-to-public transform and its
   public observation; prove conversation-ID renaming invariance where useful,
   then add substrate-native `ActorBaseMap`/isomorphism and `FrameHomOver`
   without changing banked `FrameHom`. Prove local actor pseudonymization and
   each realized conversation-frame comparison. A non-injective actor mapping
   and a transform that rewrites a content reference are retained falsifiers.
4. **2S relative views.** Relate registered, panel, and event-supported views;
   factor a reusable equivalence between membership in a distinct finite list
   and `Fin` of its length; then state base-relative saturation and append-only
   persistence only at their actual hypothesis strength.
5. **3R full assembly.** Add task intake, injected panel selection, bounded
   panel processes, closure, publication, corpus acceptance, and resubmission
   around the minimal causal kernel. Candidate and assent mechanisms, silence,
   panel size, turn-taking, all-or-nothing AI pairing, and entropy remain
   replaceable interfaces. The first incrementally checked behavioral trace
   opens the gate for `hoapa_checker`.
6. **Λ/Federation forcing case.** Before freezing the artifact interface,
   construct two independent peers with colliding local identifiers, one pinned
   offline import, different admitted comparisons, and a withdrawal adopted by
   only one peer. Acceptance requires stable scoped references and reproducible
   interpretation relative to each declared import boundary; convergence is
   not required.

`make test` remains the definition of green for each implemented batch.

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
See [the interpretation and its architectural counterexample](related_structures.md#lautman-decomposition):
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

A concrete candidate distinguishes new objects in a fixed setting, another
presentation of the same semantics, and a change of contextual capabilities.
See [Changing the conditions of integration](openings.md#changing-the-conditions-of-integration). A change of site alone does not establish renewal.

The reciprocal mirror and rising-sea investigation remain live research
horizons in [openings.md](openings.md#reciprocal-mirror-and-rising-sea).
Their examples inform this programme; no extra adjunction is thereby selected.

<a id="borrow-work-return-replay"></a>

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

<a id="continuation-and-response-preservation"></a>

**Continuation and response preservation — candidate.** Extend the finite
sufficiency test to a specified continuation. This is the bounded obligation
for [conceptual variation within Λ](openings.md#conceptual-variation-within-λ),
not a selected first build or a second explanatory account of that responsibility.
Independently specify finite situations X and X′, publication maps q : X → Q
and q′ : X′ → Q′, and work w : X → X′. Require q to be surjective, or restrict
Q to its image. Seek a returned operation w̄ : Q → Q′ satisfying:

```text
q′ ∘ w = w̄ ∘ q
```

The named unmet obligation `continuation-factorization-criterion` is to
construct, in this finite setting, the equivalence between existence of such
a unique w̄ and the fibre-compatibility condition:

```text
for all x, y in X:
  q(x) = q(y) ⇒ q′(w(x)) = q′(w(y))
```

This is a proposed obligation, not an Agda declaration or a checked result.
Do not choose q or q′ retrospectively to force success. With X = X′ the
two-bit situations and q = q′ projection to the first bit, flipping the first
bit is a positive control. Swapping the bits is negative: (0,0) and (0,1)
publish identically before the swap and differently afterward. Retain both
cases and a check of the criterion before claiming continuation preservation.
Existence of a returned operation concerns information; the separate
producer-unavailable reuse test above still concerns access and enabledness.
Failure may call for permissible refinement, renewed work, or an explicit
limitation, not automatic disclosure of omitted or protected information.

Keep a distinct first-order response comparison: at θ = 0, f(θ) = θ and
g(θ) = 2θ agree in value but differ in slope. By contrast, f and
h(θ) = θ + θ² agree in both value and slope there, while differing beyond
first order. Declare which response is required before accepting or rejecting
their interchangeability. This tests response-aware adequacy, not yet a need
for SDG: ordinary calculus already distinguishes these cases. A further
Kock–Lawvere investigation must identify what family-wise reasoning,
compatibility with assembly, or coherent transport adds, with an actual
interpretation and a discriminating case. No SDG model or deformation complex
is prescribed by the finite test.

**Dependence across finite families — available candidate.** The proposed
[team-semantics example](related_structures.md#team-semantics-dependence)
tests a relation between runs rather than each run separately. Specify finite
public inputs l, protected inputs h, outputs o, an admissible run family, and
a local validity predicate. Name the missing obligation before implementing:
a dependence checker must agree with pairwise public-output agreement for
equal public input, accept the constant-output family, and reject o = h when
both protected values occur at the same public input. Both families should
pass the stipulated local validity check.

This is a proposed finite build, not an Agda declaration or a selected first
task. Testing completeness of the intended input variations is a separate
requirement. The [Riemann–Roch comparison](related_structures.md#riemann-roch-crossing) remains an explanatory
mathematical example, not a similarly cheap finite formalization.

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

The [candidate resource portfolio](openings.md#candidate-mathematical-resources-for-the-m-rebuild)
retains the generation/description, pairing, inheritance, quantitative-comparison,
and relative-cohesion leads. It supports the obligations above without selecting
M's mechanism. Promote a bounded task here when its use and test are explicit.

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

## Regarding T_recursion iteration

The generic endofunctor-and-unit scaffold in `Iteration.agda` remains reusable;
it is not retired with the cohesive specialization. It provides iteration,
iterated units, coherence relative to postulated naturality, and `ND A`, not
a constructed cross-side monad.

The `η-naturality` obligation stays live at its stated scope; see
[formal status](status_formal.md). Possible dual and cyclic extensions remain
[openings](openings.md#iteration-beyond-the-current-scaffold), with their existing
gates. The stage-one-collapse specialization, its deferred colimit formalization,
and the original rationale are preserved in
[abandoning_modal.md](deep_context/abandonned_modal_side/abandoning_modal.md#regarding-t_recursion-iteration).
No modal repair is made an entry condition for the M rebuild.

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

## Tier B: change of actor base and closure transform

**Status and scope.** Coming 2S work after the minimal causal kernel; the
[broader ladder](openings.md#candidate-under-evaluation-no-leak-theorem-ladder-and-humanness-as-refusal)
retains the motivation, Tier A context, optional Tier C, Tier D, and open
observation questions. The live facts and expressibility blocker remain in
[formal status](status_formal.md). This split changes neither order nor theorem scope.

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

## Λ: first local-to-global content test

The [content-layer horizon](openings.md#content-layer-lambda)
supplies the interpretation; the [coming programme](#coming-programme-and-dependency-order)
supplies its contract and Federation dependencies. This bounded test is retained
here so that the horizon has a concrete entry point.

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


## Relocated investigations

These old section anchors remain as navigation for append-only arcs and earlier
citations. The linked destinations own the content; this is not a second queue.

<a id="legacy-modal-diagnosis-and-retired-work-orders"></a>

- [Legacy modal diagnosis and retired work orders](deep_context/abandonned_modal_side/abandoning_modal.md#legacy-modal-diagnosis-and-retired-work-orders)

<a id="retired-cohesive-escalation"></a>

- [Retired cohesive escalation](deep_context/abandonned_modal_side/abandoning_modal.md#retired-cohesive-escalation)

<a id="concurrency-side-layers-of-complexity-planned"></a> <a id="what-is-intentionally-not-in-this-catalogue"></a> <a id="implementation-track--runtime-checker-boundary-and-protocol-contract"></a>
<a id="1-reflexive-protocol-layer-π"></a> <a id="2-bulk-type-theory--content-layer-λ"></a> <a id="3-field-theoretic-dynamics-on-the-content-layer"></a>
<a id="4-federation--open-network-of-documented-contexts"></a> <a id="5-information-cohomological-complexity"></a> <a id="appendix--cross-cutting-reframings-different-in-nature-from-the-layers-above"></a>
<a id="a-contextual-distinctions-without-a-prescribed-modal-threshold"></a> <a id="b-candidate-corresponding-systems-of-separations"></a> <a id="c-context-renewal-and-possible-recursive-co-evolution"></a>
<a id="glossary"></a>

- [Concurrency-side layers of complexity (planned)](openings.md#concurrency-side-layers-of-complexity-planned)

<a id="candidate-addition-under-evaluation-provenance-accountable-artifacts-and-reversible-import"></a> <a id="problem-and-motivating-use"></a> <a id="human-world-import-lifecycle"></a>
<a id="two-faces-and-their-interface"></a> <a id="positive-semiring-provenance"></a> <a id="descent-and-applied-category-theory"></a>
<a id="accountable-change-and-the-pijul-boundary"></a> <a id="no-leak-and-security-boundaries"></a> <a id="language-documentation-and-orchestration"></a>
<a id="possible-cascade-effect-if-adopted"></a> <a id="staged-investigation-and-possible-build-order"></a> <a id="decision-gates-and-next-discussions"></a>
<a id="candidate-implementation-slots-not-reservations"></a> <a id="research-anchors-and-cautions"></a>

- [Candidate addition under evaluation: provenance, accountable artifacts, and reversible import](openings.md#candidate-addition-under-evaluation-provenance-accountable-artifacts-and-reversible-import)

<a id="candidate-under-evaluation-no-leak-theorem-ladder-and-humanness-as-refusal"></a> <a id="what-is-already-grounded"></a> <a id="the-theorem-ladder"></a>
<a id="four-protections-and-their-current-status"></a> <a id="relationship-to-provenance-contextuality-and-reality"></a> <a id="candidate-implementation-slots-not-reservations-1"></a>
<a id="decision-gates"></a>

- [Candidate under evaluation: no-leak theorem ladder and humanness-as-refusal](openings.md#candidate-under-evaluation-no-leak-theorem-ladder-and-humanness-as-refusal)

<a id="candidate-under-evaluation-reality-and-the-protocols-constitutive-exterior"></a> <a id="the-absencepresence"></a> <a id="the-identity-filter"></a>
<a id="realitys-positive-role"></a> <a id="how-to-deal-with-it"></a> <a id="bulkboundary-duality-mention-only-transcript-in-arc11"></a>
<a id="discipline--what-this-does-not-claim"></a> <a id="decision-gates-before-elevating-the-conjecture"></a>

- [Candidate under evaluation: Reality and the protocol's constitutive exterior](openings.md#reality-constitutive-exterior)

<a id="lautman-as-theorem-shaper-analytic-adequacy-synthetic-invariance-and-their-compatibility"></a> <a id="the-theorem-shaping-protocol"></a> <a id="family-a--analytic-adequacy-of-process-to-trace-articulation"></a>
<a id="family-b--synthetic-invariance-under-change-of-presentation"></a> <a id="family-c--compatibility-of-analytic-and-synthetic-decomposition"></a> <a id="family-d--recursive-replay-only-after-adequacy"></a>
<a id="status-and-sequence"></a> <a id="guardrails-and-falsifiers"></a> <a id="decision-gates-1"></a>

- [Lautman as theorem-shaper: analytic adequacy, synthetic invariance, and their compatibility](openings.md#lautman-as-theorem-shaper-analytic-adequacy-synthetic-invariance-and-their-compatibility)

<a id="arc16-consolidation-mediator-and-care-theorem-shapers"></a> <a id="a-specific-space-valued-mediator-candidate"></a> <a id="care-compatible-episode-morphisms"></a>
<a id="comparison-strength-and-iteration-warnings"></a>

- [Arc/16 consolidation: mediator and care theorem-shapers](openings.md#arc-16-mediator-and-care)

<a id="candidate-logical-presentation-track-mode-theory-and-indexed-context"></a> <a id="intended-role"></a> <a id="three-structures-that-must-remain-distinct"></a>
<a id="1-contextual-indexing-telescopes-slices-and-descent"></a> <a id="2-operational-phasing-cbpv-and-lnl"></a> <a id="3-framework-level-modes-and-modalities"></a>
<a id="piecewise-naturality-protocol"></a> <a id="grounded-relationships-candidates-and-rejected-shortcuts"></a> <a id="candidate-architecture-held-loose"></a>
<a id="staged-investigation"></a> <a id="possible-theorem-targets"></a> <a id="relationship-to-the-candidate-holes"></a>
<a id="decision-gates-2"></a> <a id="research-anchors"></a> <a id="discussion-of-truncate-everything"></a>
<a id="claude"></a> <a id="codex"></a>

- [Candidate logical-presentation track: mode theory and indexed context](openings.md#candidate-logical-presentation-track-mode-theory-and-indexed-context)

<a id="emails-for-extended-abstract"></a>

- [Emails for extended abstract](communication_drafts/extended_abstract_outreach.md#emails-for-extended-abstract)

<a id="exploratory-direction-articulation-organized-activity-universal-technical-language-and-galoisian-replay"></a> <a id="1-music-as-an-effective-realization-of-a-problematic"></a> <a id="identification-variation-and-genesis"></a>
<a id="2-universal-technical-language-musical-articulation-reasoning-and-reuse"></a> <a id="concurrency-as-an-abstraction-of-organized-activity"></a> <a id="3-relative-presentations-decidable-generators-and-limits-on-perspective"></a>
<a id="4-galoisian-replay-as-borrowworkreturnreplay"></a> <a id="replay-across-logical-scales"></a> <a id="portability-and-universal-reuse"></a>
<a id="local-work-and-its-enabling-organization"></a> <a id="three-closures-as-questions-about-replays-organization"></a> <a id="continuation-across-scales"></a>
<a id="information-regeneration-and-succession"></a> <a id="changing-the-conditions-of-integration"></a> <a id="5-galoisian-organization-and-two-entrances-to-the-esquisse"></a>
<a id="6-detailed-candidate-cyclic-ports-closed-graphs-and-a₅"></a> <a id="7-examples-comparison-cases-and-open-tests"></a>

- [Exploratory direction: articulation, organized activity, universal technical language, and Galoisian replay](openings.md#exploratory-direction-articulation-organized-activity-universal-technical-language-and-galoisian-replay)
