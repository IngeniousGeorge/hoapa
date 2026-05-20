# Discussion of the next step

### Codex

• The next step should be the hybrid bridge R1:

> define a session-valued presheaf, and eventually sheaf, over the actor-causal site.

This is the first place where the project’s structural claim stops being just architecture. We now have the two separated legs:

- locality/base: Concurrency/Sites/{ActorBase,ActorCausal}.agda
- typed content/value: Concurrency/Algebras/Sessions.agda

The bridge must show how typed session values vary over actor-local causal frames without putting session information into actors themselves.

Why This Is Next

The project’s B-side claim is:

> typed data lives in the value layer; unityped agents live in the base; separation of concerns is structural.

Right now we have the two sides separately. R1 is where this becomes one mathematical object:

Actor-causal site  C
Session value category V
Presheaf           Cᵒᵖ → V
Sheaf condition    descent over local-frame covers

That is the first real approach to the “separation of concerns” structural claim. It is also prerequisite for everything downstream: R4, the cross-site adjunction, and eventually the ModalHoTT/
Concurrency comparison.

What To Build First

I would not jump straight to the full sheaf theorem. Build it in layers.

Recommended new directory:

agda/Concurrency/Sheaves/

Recommended first files:

agda/Concurrency/Sheaves/Presheaf.agda
agda/Concurrency/Sheaves/SessionValuation.agda

Presheaf.agda should be generic over a StarAutonomous target. SessionValuation.agda should specialize it to Sessions-Cat.

Layer 1: Generic Frame Presheaf

Define a contravariant functor from actor-local frames into a target category:

FramePresheaf :
ActorCausalSite AB ℓE ℓR ℓI →
StarAutonomous ℓV ℓH →
Type _

Fields:

value :
LocalFrame AB ℓE ℓR → Ob

restrict :
(φ : G ↪ F) → Hom (value F) (value G)

restrict-id :
restrict (frame-id F) ≡ id

restrict-comp :
restrict (ψ ∘ᶠ φ) ≡ restrict φ ∘ restrict ψ

This is the core R1 object. It says: a larger frame has typed content, and every sub-view gets a restricted typed content.

The variance matters. Since FrameHom G F means “G embeds into F as a sub-view,” restriction goes:

value F → value G

Layer 2: Session-Valued Presheaf

Specialize the generic presheaf to Sessions-Cat Payload.

This should produce something like:

SessionPresheaf :
ActorCausalSite AB ℓE ℓR ℓI →
(Payload : Type ℓP) →
Type _

Internally:

SessionPresheaf site Payload =
FramePresheaf site (Sessions-Cat Payload)

The key design goal: the bridge imports both ActorCausal and Sessions, but still never modifies either. That proves the separation architecturally: values sit over frames; they are not inside
actors.

Layer 3: Minimal Witness

Ship a tiny witness, but keep it honest.

A good first witness is a constant presheaf over tiny-site:

value F = end
restrict φ = id-h

This is degenerate mathematically, but valuable as a plumbing check. It proves the bridge typechecks end-to-end:

ActorCausalSite → Sessions-Cat → FramePresheaf

A nonconstant witness can come later.

Layer 4: Descent Interface, Not Full Descent Yet

After presheaf, add a named placeholder/interface for sheaf descent, but do not overclaim.

The full sheaf condition needs careful matching-family machinery over covers, overlaps, and eventually the E2 sieve presentation. We should not fake that.

For v1, define a record such as:

BasisDescentData P

or just leave a clearly named future section:

-- Future:
-- MatchingFamily
-- compatible local sections
-- amalgamation
-- uniqueness

If implemented now, sections can be represented as:

Section F = Hom 𝟙 (value F)

But compatibility over overlaps will be awkward until pullbacks/sieves are better developed. So I’d make the descent target visible, not force it in the first bridge file.

What This Step Should Not Do

Do not:

- define messages;
- add payloads to actors;
- distinguish human / LLM / conversation actors;
- define promotion;
- use gen, plug, or shift directly;
- force the cross-site adjunction;
- solve R4 in the same file;
- switch to MO_1.

The bridge is already important enough.

Success Criterion

This step succeeds if we can point to an Agda object saying:

session values vary contravariantly over actor-local causal frames

with:

- actor carrier still opaque;
- sessions still in the value category;
- restrictions along FrameHom;
- identity and composition laws;
- a concrete constant-session witness over tiny-site.

That would be the first checked form of the B-side structural separation. After that, the next hard question becomes sheaf descent: when do compatible local session values glue to a global session
value over a frame?

My recommendation: ask Claude to build generic presheaves first, then the Sessions specialization, then a tiny constant witness. Treat full sheaf descent as the next sub-step, not the first one.

### Claude

● Recommendation: hybrid bridge — SessionPresheaf over ActorCausalSite

A presheaf in the actor-causal site, valued in Sessions's syntactic category. R1 (sheaf valuation) made concrete.

Why this is the right next step

1. It's what status.md "After Sessions.agda" item 2 was waiting on. Item 1 (Actors at maturity to Sessions) just landed. The "hybrid bridge — place the shipped session values over the actor-causal
site" item moves to active.
2. Both legs are now at honest comparable maturity. Sessions has the content-side R8 faces; Actors has the locality-side site axioms and a non-trivial cover. Bridging two equally-developed legs is
symmetric; bridging now rather than later locks in that symmetry rather than letting one side outgrow the other.
3. R1 is the structural separation-of-concerns hinge. The motivation file's claim — B1 (typed data) and B2 (unityped agents) follow separation of concerns — is currently a structural assertion in
concurrency_anchor.md, not an Agda artifact. The bridge is what turns it into an artifact: B1 lives in the values (presheaf assignment to frames), B2 lives in the base topology (the site itself),
and modularity is the (eventual) sheaf-gluing condition. Without the bridge, the central claim of the hybrid is unverified.
4. It's the structural gate for the cross-site adjunction. Allow ⊣ Require lives between the A-side cohesive ∞-topos and the B-side topos formed by sheaves on the actor-causal site (per arc/02).
The bridge is the constructive form of that topos's value structure. The A-side return plan (Bℤ → S¹, bar construction) is gated on the cross-site adjunction being statable, which is gated on the
topos having content, which is what the bridge supplies.
5. arc/05's verified-protocol-kernel framing depends on it. "Conversations produce typed documents" reads structurally as "frames bear session values"; "actor identity never leaks into the session
carrier" reads as "the presheaf factors through the base site's locality, not through anything that mentions session types in the actor base." Both become checkable claims once the bridge exists.

What v1 ships

A single file Concurrency/Hybrid/SessionPresheaf.agda, on the order of 400-500 lines, containing:

- SessionPresheaf record. A contravariant assignment: P-on-frame : LocalFrame → SessionType, P-on-hom : (F ↪ G) → Hom (P-on-frame G) (P-on-frame F), plus functoriality fields P-id and P-comp. Same
field-and-postulate-laws shape as StarAutonomous and Sessions-Cat.
- const-presheaf. The trivial inhabitability witness: assigns 𝟙ₛ (or ⊥ₛ — design call below) to every frame, id-h to every FrameHom. Functoriality holds definitionally.
- A non-trivial witness over tiny-site. A presheaf that assigns one session type to PointFrame and a different session type to TinyFrame, with P-on-hom (embed-point b) being a non-identity Hom —
exercising the contravariance of the bridge against the G3 site's embed-point false and embed-point true.
- Header reservation for v2. The sheaf condition (descent over covers) is stated in prose only at v1; the categorical structure Sessions-Cat needs to host matching families (intersections,
pullback-flavored data) is exactly the StarAutonomous extension that SessionO1Action's canonical-derivation slot is waiting on. The two deferred items now share a single trigger.

Design calls

Q1. Subdirectory for the bridge.

- What's at stake: where the file lives and what category of artifact it signals.
- Option Q1a — Concurrency/Hybrid/SessionPresheaf.agda. Buys: matches the concurrency_anchor.md "hybrid" vocabulary; the directory makes "bridge from one leg to another" explicit. Costs: introduces
a new subdirectory pattern (so far we have Operads/, Algebras/, Sites/ — all mathematical-kind names; Hybrid/ is relational).
- Option Q1b — Concurrency/Sites/SessionSheaf.agda. Buys: keeps it under Sites (the bridge gives the site its values). Costs: "Sites" becomes ambiguous between "the actor-causal site itself" and
"things-over-the-site"; also the file is the presheaf, not yet the sheaf, so the filename is forward-leaning.
- Option Q1c — Concurrency/Sheaves/Sessions.agda. Buys: "Sheaves" as a categorical-kind name fits the existing pattern. Costs: same as Q1b on the not-yet-sheaf naming.
- Lean: Q1a. The Hybrid/ subdirectory honestly names the architectural move (cross-leg bridge) and reserves room for a future Hybrid/<Actors-over-Sessions>.agda or Hybrid/Compatibility.agda if
other bridges land.

Q2. Presheaf-only vs. sheaf-too at v1.

- What's at stake: how much of the descent picture lands at v1 vs. is deferred.
- Option Q2a — Presheaf only. Buys: honest; ships exactly what current Sessions-Cat supports; clean deferral story. Costs: the separation-of-concerns claim is only half-stated — the topology side
is there, the descent side isn't.
- Option Q2b — Presheaf + separated-presheaf property (uniqueness without existence). Buys: records the "at most one global section per matching family" half of the sheaf condition. Costs: still
needs intersection-of-patches morphisms to state compatibility, which Sessions-Cat doesn't supply cleanly without enrichment.
- Option Q2c — Full sheaf, postulates filling the categorical gaps. Buys: full structural commitment at v1. Costs: heavy postulate budget; many will be re-derived in v2 once Sessions-Cat is
enriched, so the postulate work is throwaway.
- Lean: Q2a. The bridge HALF that current ingredients support, with the descent half explicitly waiting on the same StarAutonomous extension that SessionO1Action's canonical derivation needs. Two
deferred items, one trigger.

Q3. The target object of the trivial presheaf.

- What's at stake: whether const-presheaf returns 𝟙ₛ (tensor unit) or ⊥ₛ (dualizing object / par unit) at every frame.
- Option Q3a — 𝟙ₛ. Buys: matches "no content yet" reading (tensor unit = empty product); standard for terminal-object presheaves in cartesian topoi. Costs: in *-autonomous (linear) settings, 𝟙ₛ is
the multiplicative unit, not the terminal object — there's no canonical "everything maps to 𝟙ₛ."
- Option Q3b — ⊥ₛ. Buys: matches the Valuation/OperadAlgebra codomain (R7 already commits to ⊥-par as the natural session-valued target); presheaves into the dualizing object are the natural shape
downstream operadic algebras want to compose with. Costs: less standard outside linear-logic settings.
- Lean: Q3b. The R7 commitment in Valuation.agda already pins ⊥-par as the canonical codomain; the bridge inherits that.

Q4. Non-trivial v1 witness.

- What's at stake: how concrete v1's non-degenerate inhabitant is.
- Option Q4a — Constant presheaf only (I1-class). Buys: minimum. Costs: doesn't exercise P-on-hom non-trivially; same critique we just fixed for tiny-site.
- Option Q4b — A two-value presheaf over tiny-site: assigns 𝟙ₛ to PointFrame, some other type (e.g., 𝟙ₛ ⊗ 𝟙ₛ) to TinyFrame, with P-on-hom (embed-point b) being one of the unitor morphisms. Buys:
exercises every field non-trivially; demonstrates that the contravariance of the bridge against a non-identity FrameHom (the G3 work) actually shows up. Costs: 60-100 lines of additional witness
code.
- Option Q4c — Two "shadow" presheaves: an actor-only shadow that returns 𝟙ₛ everywhere (projects away content) and a content-only example. Buys: makes B1/B2 separation visible as an Agda artifact
(the two shadows witness that the two legs can be looked at independently). Costs: needs frame-internal data the records don't currently expose for the content shadow.
- Lean: Q4b. The two-shadow story (Q4c) is appealing but properly belongs at the sheaf level, where the descent picture makes "what each shadow forgets" precise. At the presheaf level, Q4b is
honest non-triviality.

Q5. Functoriality laws.

- What's at stake: whether the laws are stated-and-postulated (Sessions's pattern) or stated-and-discharged-per-instance.
- Option Q5a — Stated as fields, each instance discharges them. Buys: matches Sessions's pattern; the const-presheaf discharges by refl (id and composition are both identity), the non-trivial
witness discharges them by short proofs. Costs: every future instance writes the discharges.
- Option Q5b — Stated as fields, postulated globally for any inhabitant. Buys: less ceremony. Costs: hides actual mathematical content; instances could violate without notice.
- Lean: Q5a.

Q6. Whether to expose Codex-side "transition data" for v2.

- What's at stake: should the v1 file expose a derived matching-family type (parallel to sieve-of for the E1→E2 transition) that v2 will use to state descent?
- Option Q6a — Just the presheaf; defer matching-family entirely. Buys: simpler. Costs: v2 starts from scratch on the descent machinery.
- Option Q6b — Expose a derived matching-family : (P : SessionPresheaf) (c : Cover F) → Type. Buys: same role as sieve-of — the bridge artifact between v1 and v2 lives in the v1 file. Costs: needs
to use Sessions-Cat's morphisms, and at v1 the compatibility condition has to be honest about which intersection-data is unavailable.
- Lean: Q6b, in the same spirit as sieve-of. Even if the compatibility condition is partial at v1 (postulating the intersection witnesses with a flag), having the type live in v1 anchors v2.

Q7. Should the bridge be parameterized over Payload?

- What's at stake: Sessions takes a Payload parameter; the bridge inherits the question.
- Option Q7a — Parameterized over Payload, like Sessions. Buys: maximum flexibility; matches Sessions's signature. Costs: one more implicit parameter at every use site.
- Option Q7b — Fix Payload = Unit at v1. Buys: simpler signatures. Costs: binds an arbitrary choice; later instances either re-instantiate or live with the choice.
- Lean: Q7a.

What's explicitly NOT in v1

- Sheaf condition (descent, matching families with full compatibility on intersections). Deferred — same trigger as SessionO1Action's canonical derivation: the StarAutonomous extension with closed
structure / evaluation / cut. When that lands, both the sheaf condition and the canonical action become statable, and the bridge gets a v2.
- Sheaves of O_1-algebras over the site. A second-level bridge: instead of presheaves valued in SessionType, presheaves valued in OperadAlgebra Sessions-Cat. This is where the operadic interaction
algebra and the site-with-values picture fuse. Properly a v3 artifact.
- Actor-causal stability witness. Still postulated in ActorCausal.agda. The bridge doesn't unblock it; concrete stability for tiny-site (the smallest tractable witness) is a separate, smaller piece
of work.
- Promotion morphism. Still header-prose in ActorCausal.agda. Properly an MO_1 / arc/05 artifact.
- A-side return. Still gated on the cross-site adjunction being statable, which is gated on the sheaf condition, not just the presheaf.
- MO_1 / modular envelope. Premature.
- Pedagogy companions. Held loose.

What v2 of the bridge looks like (for context, not for now)

When the StarAutonomous extension with closed structure / evaluation / cut lands (the trigger named in future_work.md's "Regarding Sessions and the canonical O_1 action" ladder, item 3):

- IsSheaf record using the v1 matching-family type, now with full compatibility-on-intersections.
- The constant presheaf upgraded to a trivial sheaf.
- A genuine actor-only / session-only shadow pair making B1/B2 separation a theorem rather than an architectural claim.
- The cross-site adjunction Allow ⊣ Require becomes statable: Allow takes A-side modal data to sheaves on the actor-causal site; Require reflects back.
- A-side return (bar construction at S¹) unblocked.

Plan if my leans are accepted

A single file Concurrency/Hybrid/SessionPresheaf.agda, ~400-500 lines, structured as:
1. Header with discipline guardrails (no operad-level imports, etc.) and explicit v2 deferral note.
2. Imports (Sessions, ActorBase, ActorCausal).
3. Module parameterized over (AB, S, Payload) where S is an ActorCausalSite over AB.
4. SessionPresheaf record with five fields (Q5a).
5. const-presheaf returning ⊥ₛ everywhere (Q3b).
6. The two-value witness over tiny-site (Q4b), exercising embed-point false and embed-point true non-trivially.
7. Derived matching-family type (Q6b), with partial compatibility data flagged in a comment as the v2 transition slot.
8. Sanity checks.

### Codex

• I agree with the overall direction, but I’d change two things before Claude starts.

First: I would not make v1 a single SessionPresheaf directly valued in SessionType only. I’d split the idea slightly:

Concurrency/Hybrid/Presheaf.agda
Concurrency/Hybrid/SessionPresheaf.agda

That keeps R1 from being “sessions happen to work over frames” and makes it the actual structural bridge:

ActorCausalSite + value category V → presheaf Cᵒᵖ → V

Then Sessions are the first value category instance. This will matter later if the value category becomes richer than Sessions-Cat, or if we need presheaves valued in OperadAlgebra.

Second: I’d be careful with Claude’s proposed Q4b. A nontrivial witness is good, but using unitors to map:

TinyFrame value = 𝟙ₛ ⊗ 𝟙ₛ
PointFrame value = 𝟙ₛ

is only possible in the contravariant direction if the available Hom has the right constructor. In Sessions.agda, we have:

leftUnitor-h  : Hom (𝟙ₛ ⊗ A) A
rightUnitor-h : Hom (A ⊗ 𝟙ₛ) A

So Hom (𝟙ₛ ⊗ 𝟙ₛ) 𝟙ₛ is available. Good. But functoriality over all FrameHoms of the whole site may become impossible if the witness is meant as a global presheaf over all frames. The nontrivial
witness should therefore be scoped narrowly, either over a small displayed subsite or as a “tiny-frame diagram witness,” not advertised as a full global presheaf unless the record supports
restricting the domain.

My refined recommendations on Claude’s questions:

- Q1: Concurrency/Hybrid/ is fine. It names the bridge honestly.
- Q2: Presheaf only. Full sheaf/descent later.
- Q3: I’m less convinced by ⊥ₛ for the constant presheaf. ⊥ₛ is natural for Valuation codomains, but a frame’s value object as “no content yet” reads more cleanly as 𝟙ₛ. I’d use 𝟙ₛ for the trivial
presheaf unless Claude can show downstream composition already requires ⊥ₛ.
- Q4: include a nontrivial tiny witness, but don’t force it to be a full presheaf over all frames if that creates artificial postulates.
- Q5: functoriality laws as fields, discharged per instance. Yes.
- Q6: I would not implement matching families yet. Add a named header section and maybe a skeletal record only if it can be stated without fake intersection data. Avoid partial compatibility
postulates.
- Q7: parameterize over Payload. Yes.

So my suggested v1 shape:

1. Hybrid/Presheaf.agda
- generic FramePresheaf over ActorCausalSite and StarAutonomous;
- fields: on-frame, on-hom, id, comp.
2. Hybrid/SessionPresheaf.agda
- SessionPresheaf as specialization to Sessions-Cat Payload;
- constant session presheaf, probably at 𝟙ₛ;
- small nontrivial tiny-site witness if it can be honest;
- descent/matching-family section reserved in prose.

The key standard is the same as before: ship what the current structures genuinely support, and make the deferred sheaf/descent step precise without pretending it has landed.

### Instigator

About Claude's Qs:

#### Q1

Hybrid

#### Q2

I'd go for a "safe Q2b", like in the following presentation of Codex:

  • For Q2b specifically: it does not have to force the sheaf condition. Done carefully, it takes what is available now.

  The clean v1 version is:

  IsSeparatedPresheaf P

  meaning: if two global session-side morphisms over a frame become equal after restriction to every patch of a cover, then they were already equal globally.

  That uses only things we already have:

  - Cover gives patches and embeddings.
  - SessionPresheaf gives restriction maps along FrameHom.
  - Sessions-Cat gives Hom, composition, and equality of morphisms.

  - equalizers/limits in Sessions-Cat.

  So Q2b is the uniqueness half only. It says local agreement detects global equality. It does not say compatible local data can be glued.


  cover-jointly-monic :
    (c : Cover F) →
    (x y : Hom X (P-on-frame F)) →
    ((i : Cover.Index c) →
      P-on-hom (Cover.embed c i) ∘ x
        ≡
      P-on-hom (Cover.embed c i) ∘ y) →
    x ≡ y

  I prefer quantifying over an arbitrary probe object X, rather than pretending 𝟙ₛ is a terminal object. In a linear/*-autonomous setting, “global section as 𝟙 → A” is a choice, not automatic
  terminal-object logic.

  Postulate budget: ideally zero.

  Q2b should be a property record, not a global postulate. Individual presheaves either prove separatedness or do not. I would not add:

  postulate every-presheaf-separated : ...

  and I would also avoid postulating separatedness for the non-trivial witness unless there is a very explicit reason.

  The one caveat: current Cover may allow empty-index covers over empty frames. Full separatedness over empty covers implies “there is at most one section over the empty frame,” which is
  mathematically normal for sheaves but may be too strong for arbitrary session-valued presheaves. So either:

  1. define IsSeparatedPresheaf honestly and do not prove many examples yet, or
  2. define a weaker IsSeparatedOnInhabitedCovers as a v1 sanity version.

  My recommendation: take Q2b, but in the restrained form:

  - ship SessionPresheaf,
  - ship IsSeparatedSessionPresheaf,
  - do not define full matching families yet,
  - do not call anything a sheaf yet,
  - prove only cheap separatedness lemmas if they are actually cheap,
  - use zero new postulates.

  That gives the project a real first grip on descent without pretending the gluing half is already available.

#### Q3

Prepare for a "best of both world" adapter in v2. See the following snipet of a conversation with Codex.

About Q3, is there a way for the hybrid to have "best of both world" and, as an interface, show the tensor unit to the Actor module and the dualizing object to the sessions module, while it, the hybrid, knows how to convert one into the other and can work with both? (here I'm speaking as a clean code practioner, that's what a good interface would do)

  Codex:
  
  Best Of Both Worlds For Q3

  Yes, but with an important constraint: the hybrid can expose both interfaces, but it should not pretend there is a canonical conversion between 𝟙ₛ and ⊥ₛ unless we explicitly add one.

  ⊥ₛ = 𝟙ₛ ^⊥ₛ

  But that is not the same as having a canonical morphism:

  Hom 𝟙ₛ ⊥ₛ

  or

  Hom ⊥ₛ 𝟙ₛ

  Duality relates them structurally; it does not automatically give a runtime adapter.

  So the clean-code interface version should be:

  - Actor/locality side sees only frames, covers, restrictions, and maybe the neutral “no demanded content” role of 𝟙ₛ.
  - Session/content side sees the linear protocol semantics, where ⊥ₛ is the natural dualizing target.
  - Hybrid owns the boundary between those two readings.
  - Any actual conversion 𝟙ₛ → ⊥ₛ or ⊥ₛ → 𝟙ₛ must be named as extra structure, not hidden.

  I would model that as an optional adapter record later:

  record UnitDualizingBridge where
    field
      unit-to-dual : Hom 𝟙ₛ ⊥ₛ
      dual-to-unit : Hom ⊥ₛ 𝟙ₛ
      -- laws only if we genuinely need them

  But I would not put that into v1 unless the code needs it. Otherwise we risk smuggling a mathematical claim into what should be only an interface convenience.

  For v1, the best design is probably:

  - define presheaves generically over StarAutonomous;
  - provide const-unit-presheaf;
  - provide const-dualizing-presheaf;
  - make separatedness quantify over arbitrary probes X, avoiding dependence on either;
  - keep any 𝟙ₛ ↔ ⊥ₛ adapter explicitly deferred.

  That gives the “best of both worlds” architecturally: the Actor side is not contaminated by session duality, the Session side keeps its correct dualizing target, and the Hybrid layer is the only
  place where their relation is discussed.

Do we dramatically change the plan we already had for the Hybrid, if we think of it as, in essence, a set of adapters (taking into account that the plan was for a v1, and the adapters would really be realized in future versions, but v1 would have been the precise perfect setting for those realizations)?

• No, we would not have to substantially change the plan. The current Hybrid plan already contains the adapter list implicitly.

  What changes is the reading of the plan, not the core architecture.

  The existing plan has:

  ActorCausalSite
  SessionPresheaf
  IsSeparatedPresheaf
  future sheaf condition
  future operadic valuation
  future promotion/MO₁
  future Allow ⊣ Require

  Read as adapters, that becomes:

  FrameHom restriction adapter
  Cover observation adapter
  Separatedness/auditability adapter
  Descent/gluing adapter
  Operadic protocol adapter
  Promotion adapter
  Cross-site modal adapter

  So the adapter architecture is already there.

  Concrete mapping:

  | Existing plan item | Adapter interpretation |
  |---|---|
  | P-on-frame : LocalFrame → SessionType | assigns session content to actor-local contexts |
  | P-on-hom : F ↪ G → Hom (P G) (P F) | restriction adapter from actor subviews to session morphisms |
  | functoriality laws | adapter coherence: identity and composition of actor views agree with session restriction |
  | Cover | observation interface: global frame seen through local patches |
  | IsSeparatedPresheaf | auditability/non-equivocation adapter |
  | future sheaf condition | gluing/consensus adapter |
  | future UnitDualizingBridge | neutral/dualizing interface adapter |
  | future operadic valuation | protocol-shape adapter |
  | future promotion morphism | conversation-as-actor adapter |
  | future Allow ⊣ Require | modal/concurrency adapter |

  So if we decide “Hybrid = eventually a list of adapters,” the current plan does not become wrong. It becomes better motivated.

  The only concrete change I would make is documentary/organizational: name the adapter reading explicitly in the Hybrid file header and workflow. For example, describe SessionPresheaf as the first
  adapter, not as a final semantic object.

  The important constraint remains: v1 should implement the adapters that are actually supported now. The rest should be named as future adapter slots, not faked.

  Final note, the key refinement is:

  > Hybrid = adapter layer between actor-locality and session-content, with presheaf restriction as Adapter 1.