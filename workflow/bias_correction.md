# Bias Correction

## Why this file exists — *negative anchoring*

This file is not a historical chat log. Its job is to forestall the default-LLM mis-readings of this project — the framings a fresh agent will reach for out of habit, but which the instigator has explicitly rejected. Read it as **corrections-against-assumptions**.

Defaults this file rules out, in particular:

- "The project is *modal HoTT vs HoTT*." — Rejected. The framing is *modal HoTT as extending HoTT-as-foundation along the developmental axis*. See "On the structural conjecture".
- "The site is the circle / S¹." — Rejected. The site is the delooping of ℤ. The algebraic structure (subgroup inclusions, comonad story, Lawvere on ℤ) is what's load-bearing, not the topology. See "Goal & first step" + "Precisions".
- "The concurrency / 3-marked-points leg is decorative." — Rejected. It is a co-equal conjecture (community-of-agents, actor model + session types); the full scope is what makes the math conjecture provable rather than opinion. See "On 3 marked points" + "On the structural conjecture".
- "The synthetic side alone is enough." — Rejected. The analytic two-track exists because both instigator and agent need machine-checked grounding during development, and the eventual presentation can't rest on postulates alone. See "3 roles".

Additional fast-track corrections:

- "The current Sessions sheaf is full event-dependent B2(a)." — Rejected. The landed Sessions witness is constant-slot: arity varies by finite frame, but every event carries the same fixed slot `P₀`. Event-dependent session content is future work.
- "Event-dependent slots block R4 or the cross-site adjunction." — Rejected. They refine the value assignment; Set-valued locality sheaves, R4, and `Allow ⊣ Require` should be built generically over `FiniteFramePresheaf` / `IsSheaf`, not over the constant-slot witness.
- "The tiny finite cover example must compute by `refl` to count." — Rejected. The landed witness is proof-level: restriction/amalgamation equations and separatedness hold propositionally. Definitional computation is a bonus only if it falls out naturally and yields reusable lemmas.
- "The arc now has four functors." — Rejected. Current grounding is the adjoint pair `Allow ⊣ Require` with five anchors (Complexity, Evolution, Praxis, Anthropic, Care). Triple, ambidextrous, or quadruple structures are future extras only if earned.
- "Finite descent means the topos is done." — Rejected. Finite event-product descent, finite sheaf categories at both `StarAutonomous→Category V` and `SET`, the finite Cubical `Coverage` bridge, the SET library `Sheaf` comparison, the conditional R4 Benton/LNL sheaf bridge, and the point-generated supported R4 bridge have landed; full Set-valued locality topos/internal logic, the generic full finite actor-causal sheafification reflector construction/inhabitation, and the actual cross-site functors remain pending.
- "The Set endpoint means the Cubical Site/Sheaf work is done." — Rejected. `SetFiniteSheafCategory.agda` and `SetEventProductSheaf.agda` instantiate the project finite framework at `SET`; `SetSheafComparison.agda` now proves agreement with Cubical library `Sheaf` for `FiniteFrameCoverage`. This still does not construct full Set-valued locality topos/internal logic.
- "`Sh_fin(site,V)` is a topos." — Rejected. The landed V-valued side is a linear/session sheaf-value category. Reserve "topos" for the Set-valued/cartesian locality side unless the relevant structure is explicitly proved or assumed.
- "R4 is the cross-site `Allow ⊣ Require` adjunction." — Rejected. R4 is internal to the concurrency category `K`: the adapter between Set-valued locality sheaves and V-valued linear/session sheaves. The cross-site adjunction relates modal contexts in `M` to structured concurrency in `K`.
- "The V-valued and Set-valued sheaf categories should be collapsed." — Rejected. They now share one finite sheaf construction, but their meanings remain distinct: Set-valued locality is cartesian, V-valued session content is linear. Bridge them with R4; do not cast one into the other.
- "Concrete Set and Sessions event-product witnesses finish B2(a)." — Rejected. The witnesses are constant-slot. Event-dependent session content remains future work and must live in a separate displayed/dependent witness rather than leaking into the generic framework.

- "R4 is concretely complete now." — Rejected unless scoped. The point-generated/event-discrete supported R4 bridge is now concrete and machine-checked (`Lpoint ⊣ Rpoint`), relative to `lnl` and `vProd`. The full finite actor-causal R4 bridge is still conditional on a generic finite-site sheafification reflector.
- "`G` preserving sheaves gives the full sheaf-level adjunction." — Rejected. `G-preserves-sheaf` is the right-adjoint half. The full finite-site workflow uses a sheafification-mediated left functor, and `LinearNonlinearSheafAdjunction.agda` gives the adjunction conditionally. The point-generated route makes the left side concrete only because `PointSheafAdjunction.agda` supplies the supported reflector `a ⊣ ι`.
- "Chu was rejected." — Rejected. Benton/LNL was chosen for R4 because R4 lives on the cartesian↔linear / forgetful axis, but Chu is now live as a coefficient/value model: `Chu(SET,Bool)` instantiates the point-generated R4 theorem, and the Sessions-to-Chu `J0`/`J1` realization interprets the postulate-free session syntax. What remains deferred is full send/receive payload semantics, O1-in-Chu, and the Reality/Documentation boundary theorem.
- "Chu now reconstructs Reality." — Rejected. Chu gives the point/state/evaluation shape for Documentation as protocol observables over Reality. The intended round trip is lossy; preserving the protocol kernel under tests is not reconstructing Reality.
- "The last Sessions postulate can be removed by moving it into syntax." — Rejected. `session-O1-action` is the remaining real postulate. Removing it requires earned structure for `gen`, `plug`, `shift`, and their laws, likely closed/evaluation/cut or coherent tensor-rotation data. Adding aliases, extra HIT constructors, or a differently named parameter only moves the debt.
- "Benton gives a `𝟙ₛ ↔ ⊥ₛ` conversion." — Rejected. `LinearNonlinear.agda` records strong-monoidal comparisons for `F` with the tensor unit and binary products; it deliberately introduces no mix map between `𝟙ₛ` and `⊥ₛ`. Any such bridge must be an explicit later structure.


Additional no-leak / humanness corrections:

- "Protecting humanness by refusing to formalize it is already proved." — Rejected. The grounded kernel discipline is opaque unityped actors and no identity-refining fields in the trusted trace. Tier A now adds exact raw-validator blindness under total injective actor relabeling and its permutation specialization. Realized-frame equivalence and invariance of trusted observations are still required before this becomes a no-leak theorem about documentation or audit.
- "The generic RuntimeContract Realization is complete." — Rejected. `BackwardRank.agda`, `CausalFromParents.agda`, `ConversationLocality.agda`, `ConversationCover.agda`, and `ConversationOrderComparison.agda` land causal order from backward parents, one global frame, per-conversation frames with strict embeddings, coverage, and the order-comparison theorem. `ActorRenaming.agda` lands raw actor-channel invariance only. Realized actor-base change, reordering invariance, session assignment, and audit/provenance no-leak remain pending.
- "Every declared actor must participate in a conversation." — Rejected. Actor registration is independent, and a well-formed run may retain a registered actor who joins no conversation. `actorsCoveredByConversations?` names a separate downstream hypothesis; it is not a `WellFormed` clause, and the runtime must neither derive the actor list from conversations nor silently remove inactive actors. `fixtures/valid/uncovered_actor.json` keeps the two predicates apart executably.
- "The conversation frames are now a `Cover` of the global frame." — Rejected as stated. `conversation-event-covered` is unconditional, but `actor-covered` is not derivable from `WellFormed`, so `conversation-cover` takes `ConversationActorCoverage` as a hypothesis. `actorsCoveredByConversations?` decides that hypothesis in both directions, so a `false` verdict rules it out — which says the canonical construction is unavailable for that run, NOT that the global frame has no cover. Every frame has its identity cover.
- "The order comparison shows a conversation's own parent edges never generate its order." — Rejected. Saturation varies PER CONVERSATION, and the same fixture exhibits both outcomes: `c1` is causally saturated and does admit the internal-order embedding, `c0` is not and does not. What is forced is the UNIFORM construction — building the canonical strict embedding for every conversation of every well-formed run, from `WellFormed` alone with no saturation hypothesis. Never drop that quantifier.
- "The order-comparison result is a descent or R4 advance." — Rejected. It is concurrency-internal and proof-near: a statement about which pairs of events two orders relate, and about `FrameHom` existence. It says nothing about sheaf descent, the Benton/LNL bridge, or `Allow ⊣ Require`, and the conversation family's `Cover` status is conditional in any case.
- "`Hoapa.Core.EventLog` is a semantic checker or a source of protocol behavior." — Rejected. It is an in-memory, append-only recorder of caller-supplied contract values. It preserves server processing order, duplicate IDs, unresolved references, and cross-conversation causal parents exactly; it does not validate, normalize, infer, generate IDs, or originate actor events. A distinct checker remains gated on an actual runtime originator.
- "Actor-renaming invariance means every identifier is meaningless." — Rejected. The humanness theorem concerns the actor-identity channel. Event IDs, conversation IDs, protocol IDs, content tags, and provenance tokens have separate stability and alpha-equivalence questions.
- "Raw actor-renaming invariance licenses public tokens derived from operational identity." — Rejected. Tier A proves only that `valid?` cannot distinguish injective encodings of the actor channel. Other observers can still recover or expose operational identity; that question belongs to Tier D observational no-leak.
- "Tier C is the quotient of runs by the actor-renaming action." — Rejected. Tier C is the optional SIP/univalence upgrade from a properly packaged realized-frame equivalence to equality. An action groupoid or invariant quotient would be additional structure, and the universal observational quotient belongs, if anywhere, to Tier D after trusted observations exist.
- "No constructors or actor order already prove a no-ranking theorem." — Rejected. The current code omits ranking structure and actor classifiers; proving that no trusted observation can define a ranking is a stronger future theorem.
- "Gauge/no-leak makes Hoapa a field theory." — Rejected. Gauge invariance is an interpretive home for actor identity as redundant presentation data. It is not a claim that Hoapa has constructed a gauge field theory, Ward identities, or a QFT model.


Additional arc/16 and conjecture-sharpening corrections:

- "Because every work morphism has a contextual transpose, arc/16 supports `Allow ⊣ Require`." — Rejected. `w♯ = R(w) ∘ η` exists for every adjunction. It clarifies the universal/particular structure of Praxis but has no discriminating evidential weight for this proposed pair.
- "Anthropic loss, T3, and T_recursion are independent signs of non-degeneracy." — Rejected. Their mathematical strengths are ordered by the canonical non-collapse ladder in `targets.md` §T3. Stronger non-collapse entails the relevant counit loss; the converse implications are not available.
- "`η-equiv-at-T` proves or threatens the cross-site conjecture." — Rejected in both directions. It is a checked collapsing control for the particular `ʃ ⊣ ♭` specialization, unconnected to the unconstructed cross-site adjunction. It constrains where a non-collapse witness is not to be sought.
- "The `(0, 3)` moduli point is where dessins themselves vary, so both sides already land at the same `S²`." — Rejected. The three-pointed genus-zero curve is rigid; dessins are varying ramified covers over that normalized marked base. The modal side currently has no demonstrated route from a bare `S²` or cyclic structure to the required branch / orbifold data.
- "The icosahedral dessin can instantiate the adjunction or its iteration." — Rejected. One dessin is a gated K-side far-end object and possible test element for a future mediator. It may falsify a candidate component, but it cannot verify naturality or triangle identities, and its finite A5 symmetry supplies no monad transition maps. Branch data comes first; A5 monodromy is a secondary test.
- "`G_ℚ ↪ GT` is a known non-isomorphism and therefore a precedent for T3." — Rejected. Surjectivity is open. The faithful map warns that monicity, fullness, surjectivity, and equivalence are different strengths; it says nothing directly about Hoapa's counit or monad multiplication.
- "Care has now been refined from duality into a viability predicate, with Kleisli as its settled home." — Rejected. The checked anchor remains `(–)⊥`; developmental adequacy is a theorem-shaper whose identity/no-ranking clauses depend on the unproved 2S no-leak family. Care-compatible Kleisli arrows are a plausible candidate, not a constructed class or a replacement for the unit-tower colimit.
- "A space-valued mediator has effectively been constructed by naming a representable profunctor." — Rejected. Every adjunction already gives such a profunctor. New content begins only with an independently constructed interaction/cover/dessin-shaped ∞-profunctor that can then be tested for two-sided representability; none exists yet.


Additional architecture, content, and Federation corrections:

- "The unrestricted flat rules are an acceptable approximation to cohesive
  HoTT." — Rejected. In the current signature, unconditional `flat-intro`
  together with dependent `flat-ind` proves `flat-intro ∘ flat-counit ≡ id`
  for every type, so every type is flat-modal. Fracture, the cohesive
  hom-equivalences, and the iteration collapse must be read relative to that
  degenerate signature until 1C repairs it.
- "Tier A is the anonymization theorem for per-conversation handles." —
  Rejected. Tier A concerns one uniform injective relabeling of the raw actor
  channel. Per-conversation pseudonymization changes the actor base and needs a
  local change-of-base theorem plus an observer-relative no-leak statement.
- "A completed conversation becomes an actor through a collapsing frame
  morphism." — Rejected. Promotion is publication through an exported artifact
  interface plus a later reference. Banked `FrameHom`s remain fixed-base,
  strict-reflecting local-view embeddings.
- "A conversation's closure is consensus, and unanimity is automatically a
  limit or a colimit." — Rejected. Success and failure both close. Successful
  resolution requires unanimity under interface-declared participation and
  assent rules, while the common trace contract checks closure shape. A
  categorical universal property must be constructed before either a limit or
  colimit reading is claimed.
- "Causal saturation is Simondonian metastability or encapsulation." —
  Rejected. Internal generation, output terminality, boundary factorization,
  and purpose-relative opacity are different predicates. Simondon may shape
  their interpretation but does not identify them.
- "Level 0 is Λ, and a closure event is a concept." — Rejected. Levels and
  layers are independent. Closure events and typed dependency edges are
  evidence from which a Λ interpretation may be constructed; Λ must still
  distinguish episodes, artifacts, concepts, and documentation versions.
- "Dependency edges are homotopy paths." — Rejected. Dependencies remain
  directed. Only comparisons explicitly admitted in a documentation version
  may be inverted. The core, localization, and groupoid completion are
  different constructions.
- "π₀ computes the real set of distinct concepts, and any non-closing loop is
  a bias." — Rejected. Both claims require semantics and an adequacy criterion;
  Cubical Agda is not a decision procedure for conceptual sameness.
- "Withdrawing an identification appends an inverse constructor to the same
  type." — Rejected. The history retains the earlier claim, while a later
  documentation version ceases to admit it. No meaning-preserving map between
  the two presentations is automatic.
- "The homotopy layer is already the core of Λ, so it deserves a new numbered
  layer." — Rejected. Identification, coherence, and purpose-relative
  compression are responsibilities inside Λ until a forcing case earns a
  separate layer.
- "Engineering and biology locators are already Federation." — Rejected.
  Locators are contexts inside a language. Federation concerns exchange
  between independently maintained peers and versions.
- "Federation supplies one global history, clock, language quotient, actor
  directory, or consensus." — Rejected. Peers import finite pinned bundles,
  make local admissions, and may retain divergent translations or
  withdrawals. Completeness is relative to a declared import boundary.
- "Public pseudonyms make participation unlinkable." — Rejected. The current
  lean is fresh handles per conversation and no live identity-map export, but
  unlinkability is a statement relative to an observer and every surviving
  side channel.
- "Public IDs should be reissued at closure to improve forgetting." —
  Rejected. Federated references require stable publisher-scoped artifact,
  conversation, and event identifiers. Actor pseudonymization is a separate
  channel.
- "Lautman's synthetic decomposition decomposes the person, or the selected
  panel is a basis of the population." — Rejected. Participants are arbitrary
  admissible occupants and co-producers within a common scheme. The work may
  be represented and reconstructed without the trace exhausting the person;
  no spanning or change-of-basis theorem for panels is claimed.
- "Any eligible participant means participant choice cannot affect the
  result." — Rejected. It means identity is not a condition of formal standing.
  Different participants and panels may make consequentially different
  contributions.
- "A participant is therefore a test object or eigenvariable, `Hom(T,X)` is a
  conversation, or a conversation is already a matching family." — Rejected.
  Arbitrary seat occupancy supplies a genericity discipline; actor-causal
  frames are the candidate locality objects, and a content interpretation is
  still required to obtain probes or matching data from an episode.
- "A random panel represents the population, repeated draws become dense, or
  the documented context is automatically the colimit of its conversations."
  — Rejected. Each draw produces its own situated result. Its standing comes
  from the open flow of later uptake and revision, while categorical density
  and colimit reconstruction require a specified probe functor and theorem.
- "Unanimity is sheaf amalgamation, separatedness is accountability, or a
  contractible Λ settles Hoapa's social-choice problem." — Rejected. Human
  assent, semantic compatibility, local determinacy, provenance, and the
  topology of a space of positions are distinct obligations.
- "Nerve–realization reverses `Allow ⊣ Require`." — Rejected as an automatic
  conclusion. Under one candidate identification its adjoint handedness is
  opposite to the recorded names, which makes it a T1 polarity test after the
  categories and functors exist, not a reason to reverse the target now.
- "The conjectured adjunction proves that M can donate to K but can never
  diagnose it." — Rejected as a general slogan. A left adjoint preserves
  colimits and a right adjoint preserves limits, but transfer of a particular
  construction requires its actual hypotheses and comparison maps. The
  counit is a ceiling on reconstruction, not a substitute for constructing
  either side independently.


If you find yourself drifting toward one of these defaults, that is the moment to re-read the corresponding instigator prompt below.

---

### Instigator - 3 roles

We are a trio, me the human instigator, you the LLM agent and it the proof checker. I'm not a recognized  
mathematician, and neither are you, but the proof checker is. When we present our result, we can't rely on a bunch of postulates, we need to have proof checked data, to be taken seriously.  
And also during the developement phase of our work, you and I both need the checking capability of Agda to make sure we're not confidently walking on thin ice and into false statements.     
Now, I agree the synthetic approach is what we want ideally, and eventually how we want to present our result to the community that will be interested in it, because that they're prefered   
approach also, for good reasons. But I believe we should have, maybe in parallel, a more grounded, with step-by-step verification, version of our construction and claims. I'm thinking we    
should actually have two folders inside of /formal, /synthetic and /analytic. /synthetic is what we have been doing so far, and how you suggest we tackle the fracture result. But we should    
also work on the analytic folder, in which we basically derive all the postulates that go in the synthetic construction, to work as a kind of "test suite" for what we're doing.

### Instigator - Goal & first step

The ultimate goal is to setup a conjecture/theorem which says roughly "while *HoTT* is the most appropriate *foundation* for mathematics in the *formal* sense, *modal HoTT* (especially cohesive toposes) is the most appropriate setting for the *development* of mathematics, in the *praxis* sense (the creative process as discussed on the individual level by Grothendieck in 'Recoltes et Semailles' and at the social level by Hersh in 'What is Mathematics, Really?')". Our first order of business is to encode a version of modal HoTT in Agda. The site that will give us the ∞-topos we need will be the delooping of the circle. So let's start with that.

### Instigator - Precisions

Eventually we'll have 1/ Comonads & coalgebras, via the Yoneda lemma 2/ Lawvere's fixed-point theorem. We want the topos to have objects which have an intrinsic notion of cover/covering, and which can support internally a structure with 3 marked points (circle or sphere). From the comonad/coalgebras we get a sort of "networkization" of the category, from the fixed point theorem a way to probe how each object/type stands of a trade-off between provability (fixed-point) and creativity (no fixed-point). All this is important for the final picture, which we interpret in the real world. Modality here is a way to encode how "worlds at different scales" view each other (how humans "see" biology as rather chaotic, or physics via a quantum filter), and interact with/support each other (how humanity rests on biology, in the ecosystem). An alternative for the delooping of S¹ for the site is the delooping of ℤ, would that be more appropriate? In general, what do you think of this plan? Do you see how it can get to the theorem we're targetting? [the delooping of the integers was favored]

### Instigator - On 3 marked points

The 3 marked points are the entryway to a complementary conjecture/theorem: "while *modal HoTT* is the most appropriate setting for the *development* of mathematics itself, *concurrency theory* with a clear separation of concerns between unityped probes (actors) and typed documentation (session types) is the most appropriate *algorithm* for the community of mathematicians". The two conjectures live in different spaces: across scales in a network of worlds (that which modalities encode and navigate) for the modal HoTT side, within a community of agents (that which concurrency encodes and animates) for the concurrency side. We can think of the implementation of the concurrent algorithm as being an object in the ambient ∞-topos. But let's not focus on that for now, and just accept that we must include this aspect in our current model. If it's not going to get us into trouble later, we can leave it as a hole for now. [It will be a stub]

### Instigator - On the structural conjecture

What we're trying to do is in effect extend the claim that regular HoTT is the most appropriate foundation for math, within our current knowledge of it. Which is in itself not a theorem. I believe we should not think of our own work as "modal hott vs hott", as in the previous suggestion, but as "further argument towards hott as foundation, focusing on the developmental aspect rather than grounding". It seems to me that a theorem for foundations alone would be incomplete and just an opinion, but if it is:                           
1/ developmental on foundation
2/ dual to a "pure praxis" theorem about how communities should organize themselves (separation of concern between unityped agents following an actor model (Hewitt's) algorithm and typed documentation organized as session types, with a theorem stating that this is the most optimal for information transfer)                                                                      
Then it has more chances of being provable. It needs this full scope to be completely itself.

### Agent - Synthetic structure

Synthetic/axiomatic — postulate the cohesion modalities (shape ʃ, flat ♭, sharp ♯) as axioms and develop modal HoTT from there. This is how Wellen, Myers, and Shulman have actually worked in Agda/Coq. The site never appears as a Agda object — it lives in the semantic background justifying the axioms. ... formal/ModalHoTT/Modalities/ is the right starting point, with the cohesion modalities postulated as axioms. That's the first real Agda file — something like Cohesion.agda postulating shape, flat, and sharp with their units and the key adjunctions. Keeping in mind that Bℤ is the intended semantic model for the axioms.

### Instigator

Pure inspiration:  there are too many items on that list of concurrency models, and it's something we don't understand well and have many assumptions about (why did it emerge so long after sequential computation, we must be wrong about it in an essential way), so maybe there's a unique object that give us many different interfaces but if we do what's right and listen carefully we can get to the unique object (the story of motives).

## Useful prompts

### After clear

Next is open:
Please have a look at the files in workflow and tell me where you want to go next. Either with the next step as planned or if you feel something must be corrected/added.

Next is set:
Please have a look at the files in workflow and make sure you understand the next step. Don't hesitate to tell me if you feel something must be corrected/added.
