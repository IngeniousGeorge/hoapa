# Targets

Propositions and unmet obligations for the conjecture, distinguished from
the motivation in `motivation.md`, the map in `arc.md`, and the investigation
programme in `future_work.md`.

**Reorientation, 2026-09-26.** M is being rebuilt; cohesion, a fibred family,
and a numerical comparison are not prescribed. T_comparison makes relational
adequacy a primary target. Existing identifiers remain traceable below:
some claims survive with a wider scope, while modal-specific work orders are
retired. No new Agda result is reported by this rewrite. Pre-edit targets,
inventories, and appendices are preserved in
[the migration archive](deep_context/abandonned_modal_side/workflow/README.md).

## T_comparison. Relational adequacy and specialness

*Arc anchor: arc/18 session consolidation; programme: future_work.md.*

**Target.** Find a comparison structure in which a class of organizations
containing Hoapa is distinguished by its adequacy to contexts, their
articulation, and further development. Prefer a universal property of the
relation, not an architectural score detached from M.

**To state.**

- Extract K's categorical essence, distinguishing checked, specified, and
  conjectural clauses. Define the ambient objects and morphisms in which
  alternatives can be compared; neither the ambient nor its requirements
  may be defined merely as "systems that satisfy Hoapa's architecture."
- Include meaningful alternatives and identify contextual capabilities on
  which the proposed distinction could fail. Source candidates from prior
  architectural choices and `bias_correction.md`, but establish their
  coherence independently of their rejected status there.
- Investigate whether the same contextual transformations organize both
  variability (provisionally P) and the comparison structure.
- State the distinguished universal property, representation, robust bound,
  or other proposed specialness. Distinguish sufficient conditions from
  necessity/no-go claims; verify Hoapa's membership separately.
- Relate the result to a declared borrow–work–return–replay use. An initial
  syntax, a monadic functor, or a dense nerve alone is not the conclusion.

**Named bounded obligations.** The exact finite hypotheses and falsifiers
are in `future_work.md` §E: `observation-quotient-universal`,
`clause-separation-witness`, and a preservation-and-extension renewal
witness. These are candidate obligations in prose, not checked declarations.
The first construction is unselected; the selected one must expose a missing
type/check and an informative control before implementation.

## T1. Construct the world/practice correspondence

*Arc anchor: arc.md §3–4; arc/18.*

**Candidate.** `Allow ⊣ Require`, with `L = Allow : M → K` and
`R = Require : K → M`. The world/context categories, the work relation,
and the functors are not constructed. A candidate can be studied within a
regime and in families, without assuming that a fibration is the eventual
organization of variability.

The adjoint data would be:

```text
K(L m, k) ≅ M(m, R k), natural in m and k
η : Id(M) → R L
ε : L R → Id(K)
T = R L,  μ = R ε L          monad on M
G = L R,  δ = L η R          comonad on K
```

Use mapping spaces and coherent equivalences in a higher-categorical model.
Construct units, counits, and triangle identities rather than postulating a
bridge to populate an existing scaffold.

For work `w : L m → k`, `w♯ = R(w) ∘ η_m : m → R k` is contextual
**return**. Its existence is automatic under an adjunction. Adequate replay
requires additional interpretation and preservation results (T5).

**To investigate.** An independently meaningful work pairing may be tested
for two-sided representability. The newer generation–description candidate
may instead supply related free/forgetful and realization/nerve pairs.
Their endpoints, polarity, distinctness, and compatibility must be stated;
the four role labels are not four adopted functors. Care retains its
separate checked proxy and existing open adequacy questions.

**Progress.** K's banked fragments are listed in `status_formal.md`.
R4 below is K-internal. The synthetic cohesive signature is a degenerate
legacy control, not a model of the rebuilt M. 1C can investigate toy contextual
uses now; it does not wait for completion of the 2S/3R delivery sequence.

### Nerve–realization polarity and reconstruction tests

For probes `i : A → M`, the nerve is `N : M → Psh(A)`.
With suitable smallness and colimits its left adjoint realizes presheaves
in M. Identifying Psh(A) with K and N with Allow would reverse the recorded
handedness. That was the earlier polarity test, not a reason to flip names.

For probes `j : A → K`, the nerve instead has direction
`N : K → Psh(A)`. Its realization has direction `Psh(A) → K`.
Taking Psh(A) as a contextual presentation category therefore has the
proposed local nerve direction, but changes the category assignment. State
which candidate is being tested.

A dense probe functor yields a fully faithful nerve and, when realization
exists, invertible reconstruction counit on every object. A noninvertible
component is a possible observation-relative reconstruction defect. Calling
it Anthropic loss needs an interpretation of the probes and lost
distinctions; it is not automatically privacy or the unique locus of loss
across an enlarged framework. Density is a property of the whole probe
functor, not of a random human panel.

Monads with arities is a leading compatibility template, not a proof that
K is monadic or that its nerve has the intended observations. See arc/18.

### Current R4 Subtarget: Point-Generated R4 Theorem and Exposition

**Claim.** On the point-generated / supported finite actor-causal site, event-points form the dense basis for the first R4 reflector. For any value category `C` with finite products and any supported finite-frame presheaf `P`, pointification has the object formula:

```text
a(P)(SF) = ∏_{e ∈ events SF} P(pt_e)
```

The spike has landed the variable-slot functorial core in `Concurrency/Sites/EventPoint.agda`, `Concurrency/Hybrid/EnumeratedProduct.agda`, and `Concurrency/Hybrid/Pointification.agda`. Brick 1 of the higher-quality Option-2 geometry has also landed: `EventSupported.agda`, `PointOverlap.agda`, and `PointCover.agda` build the event-supported wrapper, event-supported point overlaps, and the canonical point cover without reusing `FiniteCover` raw actor-intersection overlaps. Brick 2 has landed in `Concurrency/Hybrid/PointDescent.agda` and `SupportedPointDescent.agda`: point descent, `PointLocal`, zero-event subterminality, and the biconditional `IsPointSheaf P ↔ PointLocal P`. Brick 3 has landed through `SupportedPointProduct.agda`, `SupportedPointification.agda`, `PointifyIsSheaf.agda`, `PointSheafCategory.agda`, `PointSheafification.agda`, and `PointSheafAdjunction.agda`: pointification is a point sheaf and the reflector adjunction `a ⊣ ι` is machine-checked over the supported point-generated site. Brick 4 has landed through `SupportedChangeOfBase.agda`, `SupportedLinearNonlinearSheafAdapter.agda`, and `PointLinearNonlinearAdjunction.agda`: the point-generated sheaf-level Benton/LNL adjunction `Lpoint ⊣ Rpoint` is machine-checked, relative to `lnl` and `vProd`.

**To state cleanly.**
- Work over the point-generated/event-discrete site, not the full finite actor-causal site.
- Use supported/incident point covers; do not claim event-points cover actor-only frames.
- Use `PointDescent.agda`'s `IsPointSheaf P ↔ PointLocal P` comparison as the sheaf/locality theorem for the point topology.
- Treat the zero-event result as subterminality/uniqueness unless a stronger terminal-object package is later added.
- Use the constructed point-generated sheafification reflector `a ⊣ ι` from `PointSheafAdjunction.agda`.
- The R4 bridge has been assembled, still relative to a value-level `lnl : LNLAdjunction` and `vProd : HasFiniteProducts (StarAutonomous→Category V)`.
- Do not claim a full Cubical `Coverage` / library-sheaf agreement until the normalized-pullback and stability layer is built.

**To verify.**
- Optional instantiation checks: discharge `vProd` for the intended linear value category and add concrete SET/Sessions-facing examples if desired.
- Stronger topology/full-site upgrades remain separate targets.

This is a bounded stepping stone toward broader R4, not a replacement for the full actor-causal sheafification problem where causal order and actor incidence become descent content.

---

## T2. Cohesion as an optional relative structure

*Disposition: the prescribed "cohesion on K" route is retired.*

Relative cohesion is a candidate relationship between suitably structured
settings, not a required structure on either side. A quadruple
`Π ⊣ Disc ⊣ Γ ⊣ Codisc` includes three adjacent adjunctions and
additional axioms; it is not the same data as two unrelated adjoint pairs.
For "K cohesive over M," identify suitable categorical/topos endpoints first;
the banked linear/session value category is not automatically a topos.

The return criterion is a concrete contextual job plus the necessary
compatibility and non-degeneracy witnesses. No cohesive construction is
selected.

## T3. Non-collapse within a specified adjunction

*Arc anchor: arc.md §6. Retained, with scope made explicit.*

For an adjunction `L ⊣ R`, let `T = R L` and `μ = R ε L`.
An everywhere invertible counit makes μ invertible. The converse does not
hold: for `L(X) = (X, ∅)` and `R(X,Y) = X`, the monad is the identity
but the counit need not be invertible.

The **non-collapse ladder** remains:

1. **Reconstruction defect:** some `ε_k : L R k → k` is not an equivalence.
   Its Anthropic interpretation is a separate adequacy claim.
2. **Non-idempotent monad:** some `μ_m : T² m → T m` is not an equivalence;
   equivalently, `η_{T m} : T m → T² m` is not an equivalence.
3. **Persistent unit-tower development:** for some m, the structure maps
   `η_{Tⁿ m}` fail to be equivalences cofinally. Stabilization means those
   maps are equivalences from some stage onward, not merely that the colimit
   happens to be equivalent to a finite stage.

The implications are `3 ⇒ 2 ⇒ 1`; no converses are assumed. T3 asks for
rung 2 when this adjunction is proposed as an engine of within-regime
development. Rung 3 is the vertical route in T_recursion.

**New scope.** This is not a demand that every inheritable fragment be
non-idempotent. A stable local core can coexist with changes of context,
observations, or doctrine. If more than one adjunction is constructed, name
which counit and monad are being tested.

**Evidence.** `IterationCohesion.agda` proves `η-equiv-at-T` and
`η-equiv-fst` for the `ʃ ⊣ ♭` specialization under its postulates.
Its tower stabilizes after stage one; it is a control, not evidence about
the unconstructed cross-side pair. No new cross-side witness exists.

Lawvere fixed-point asymmetry remains a possible explanation to investigate,
not a consequence of actor locality or of the absence of a global directory.
The differential-cohesion refinement is archived, not a required next rung.

## T4. Separation, integration, and reciprocal induced structure

*Disposition: replaces the separation-to-separation mirror target; the fixed
♭/♯/ʃ ↔ actor/content/protocol partition remains retired.*

**Target.** Specify a separation of concerns in K and a contextual integration
capability in M, then construct the relation showing how the former enables
the latter while preserving declared distinctions. Investigate the reciprocal
direction: an M-side capability may induce further separations in K,
especially in documentation. "Secondary" means induced through the relation,
not a lower rank or later time.

Each candidate must name its carriers, contextual use, construction,
preservation/compatibility law, and comparison case. Establish what changes
when the proposed separation changes, allowing alternative architectures to
support the same capability. Sufficiency and necessity are separate claims.
An adjunction may supply passage and preservation laws once these structures
exist; a bare adjunction does not establish the proposed effects.

The surface both distinguishes reality from its understanding and connects
them without identifying them. Integration need not mean one merged object,
and M does not stand for all Reality. The mirror remains an organizing
candidate, not a constructed correspondence or an additional-adjunction
commitment. Protected differences, inadequacy, and loss remain distinct.

The predominant synthetic/analytic reading concerns embodied/documented
understanding within the intended organization, not a partition of M/K.
For the examples and open bridges, see
[arc/18](arc/18_evolutionary_adjunction.md#the-mirror-separation-integration-and-reciprocal-induced-structure)
and [future_work.md §C](future_work.md#c-rebuild-m-and-its-variability-together-with-comparison).

## T5. Adequate return and replay

*Disposition: replaces the prescribed "protocol as operational cohesion"
reading while retaining its question about operational meaning.*

**Target.** State an episode, its return interface, and a future operation.
Prove the returned structure supports that operation under the declared
contextual interpretation, with the required provenance and protected
boundaries. Separate particular artifacts from uniformly instantiable rules;
dependent Σ/Π is a candidate semantics only after the families exist.

A candidate nerve could supply a reusable description; transport and
realization could participate in consuming it. None is already publication
or replay by its categorical name. Nor is descent automatically the actual
give-back operation of a conversation.

## T6. Mutual constitution, without a hierarchy

*Arc anchor: arc.md §4, §7.*

**Interpretive target.** M and K should be related without reducing one to
commentary on the other. The surface between reality and a generative system
of understanding is an organizing image, not an ontological ordering or an
arrow of time.

Adjoint data supplies precise maps; showing that they express the intended
two-sided process is an adequacy task, not an automatic consequence of the
triangle identities. Non-equivalence alone is also insufficient.

## T7. Fracture / de Rham bridge — retired work order

The old prescribed bridge from fracture/de Rham to the cross-side conjecture
is archived. Its checked relative statements remain in code and in
`status_formal.md`; they are not erased. A new use of this mathematics
requires its own contextual job and valid hypotheses, not completion of
the old escalation as a prerequisite to 1C.

## T_boundary. Runtime no-leak via actor-renaming invariance

*Arc anchor: `arc/11`, `arc/12`, `arc/13`.*

**Claim.** The proof-near core of "the system protects humanness by refusing to formalize it" is actor-renaming invariance. Actor identity is treated as presentation data at the trusted boundary: relabeling actors preserves well-formedness, and after generic realization it yields an equivalent actor-causal object. Trusted documentation or audit observations should depend only on contribution-structure visible to the protocol, not on actor origin, rank, or identity predicates.

This is a boundary target, not a new philosophical layer. It is the runtime-contract version of unityping/no-leak and the positive theorem-shape behind the arc/13 gauge reading.

**To state cleanly.**
- Define actor renamings on `RuntimeContract.Trace` data. Keep actor renaming separate from event/conversation/protocol/content/provenance ID alpha-equivalence.
- State Tier A at its proved strength: exact `valid?` / `WellFormed` invariance under total injective actor endomaps, with permutations as the invertible specialization.
- State Tier B over a change of semantic actor base. Keep fixed-base `FrameHom` banked and add a relative morphism over an actor-base map. For the selected per-conversation closure transform, the preserved object is each realized conversation frame; the public global frame need not retain live cross-conversation actor overlap.
- Separate stable content identity from actor relabeling. Conversation-ID renaming is a cheap independent invariance target; public artifact, conversation, and event identifiers remain stable across closure so federated references resolve.
- Define trusted observations before claiming any quotient/optimality theorem. Until then, "documentation as invariant quotient" is a theorem-shaped target, not a theorem.
- Keep `Human`, `Designer`, expert status, runtime identity, and ranking predicates outside the trusted kernel.

**To verify.**
- Tier A — banked at `5670658`: raw actor-renaming invariance of `valid?` / `WellFormed` in `RuntimeContract.ActorRenaming`.
- Tier B: construct substrate-native actor-base maps/isomorphisms and a relative `FrameHomOver`; then prove each realized conversation frame equivalent to its image under the live-to-public transform. If a global uniform relabeling is also studied, retain its global-frame theorem as a distinct case.
- Local publication rung: prove the per-conversation relabeling theorem on `(conversation, actor)` occurrences and specify the public content observation. Use non-injective handles and accidental content-reference renaming as falsifiers.
- Tier C: optionally upgrade equivalence/isomorphism to equality by SIP/univalence for the packaged realized structure.
- Tier D: only once provenance/audit/documentation observations exist, state no-leak for those observations and investigate the universal invariant-quotient reading.

### Progress

Tier A is banked at `5670658`. `ActorRenaming.agda` proves identity and composition for arbitrary total actor maps, exact Boolean invariance of `valid?` under total injective endomaps of `ActorId = ℕ` for every raw run, and the recorded bijective/permutation result as the invertible specialization; it also exports the `WellFormed` path and transports in both directions. Concrete tests distinguish collapsing maps, the non-surjective `suc` embedding, and a transposition. Thus the bijective target above is satisfied by a stronger raw-validator theorem without changing its gauge reading.

This remains actor-channel-only and close to true by construction: its value is
as a standing obligation on the trusted validator, not as a full observational
no-leak theorem. The selected closure transform is now its first consumer, but
fresh per-conversation handles are not an instance of Tier A. Tier B requires
change of actor base because `CausalFromParents.agda` builds run-specific
realized actor carriers while `ActorCausal.agda` fixes one `ActorBase` and gives
`FrameHom` no actor map. The local publication theorem, observation package,
and runtime obligation not to retain the identity map remain open. Tier C and
Tier D remain optional later rungs.


## T_recursion. Inheritance, replay, and contextual development

*Arc anchor: arc.md §6; arc/18.*

**Target.** Give a compositional account of episodes whose returned artifacts
support further work: specified achievements remain usable and some new
operation becomes admissible. Identify what changes—objects within a
regime, observations, language, protocol, or the regime itself.

Two routes are open:

- **Vertical:** after T1, instantiate a particular monad's unit tower and
  prove T3 rung 3 if persistent non-stabilization is the intended mechanism.
  Specify any colimit and its adequacy separately.
- **Horizontal:** construct transitions between contextual regimes, together
  with preservation and extension witnesses. Local adjunctions or closure
  operations may stabilize. Identify the composition and compatibility laws
  before claiming a developing family.

Neither route is a theorem and neither defines evolution merely as
noninvertibility. The second permits inherited stable cores without
weakening the first route's exact mathematical obligations.

**Progress.** `Iteration.agda` supplies generic endofunctor/unit iteration
and a sequential-colimit scaffold, with naturality postulated; it does not
bundle the whole adjunction or monad. `IterationCohesion.agda` is the checked
collapsing specialization. No cross-side instance, nonconstant family, or
contextual-renewal theorem has been constructed. The code is unchanged.

The operadic/session and actor-causal developments remain independently
valuable. Cyclic/modular structure, dessins, branch data, and the Esquisse
remain possible long-horizon resources, not mandatory identifications of
every contextual transition. Do not mistake session duality for the whole
developing-network claim, or require the whole modular programme before
testing a bounded contextual renewal.

## Dependency sketch and handoff

T_comparison guides the search for M and meaningful alternatives; it does not
wait for a final M definition. T1 constructs a correspondence, T4 investigates
its separation/integration effects, T5 its use for replay, and T6 its interpretation. T3 concerns
a specified adjunction; only T_recursion's vertical route depends on its
rung 2. T_boundary and the existing 2S/3R sequence retain their scope.

For a next 1C batch, select a bounded obligation from `future_work.md` §E,
state its types and a failing check or unmet proof, and retain a positive and
negative control. No first build is selected by this file.

## Historical routes and orientation

The former modal inventory, "Unlocking ♯" escalation, and shape/Esquisse
appendices are preserved in the migration archive's `targets.md`.
They document why the earlier route was plausible, not live instructions.
Sibling correspondences live in `related_structures.md`; the two-stratum
decision and candidate generation–description sketch live in arc/18.

Methodological legitimacy is a primary research goal (T_comparison), not an
out-of-scope social corollary. Its eventual real-world interpretation must
still state what the mathematical comparison does and does not establish.
