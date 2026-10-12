# Separations, integrations, and adapters in Hoapa

Standalone inventory for discussion — 13 October 2026.

Hoapa investigates how a community can produce differentiated, reusable understanding while preserving the conditions of further inquiry. Its architecture repeatedly separates responsibilities that would obstruct one another if fused: who participates from what is contributed, where work occurs from its typed content, a process from its available result, and a local language from the translations connecting it to others. The separations acquire their purpose through the relationships they make possible.

This document inventories three connected subjects: the separations and layers of responsibility within K; their possible contextual echoes as integrations on M; and the adapters that connect structures within K. It also explains neighboring concepts needed to understand those relationships. It deliberately gathers information distributed across the workflows and arcs, so it can be read independently. It is a dated exposition, not another work queue or a new specification of the conjecture.

The guiding idea is reciprocal: **separation enables integration; integration sustains distinctions and can disclose further distinctions needed for subsequent work.** An interface lets a local activity proceed without carrying its whole enabling world. The relationships around that interface determine whether the omission remains adequate. The project seeks mathematics that can make such claims precise, including cases where a proposed separation or integration fails its intended purpose.

## Contents

- [Orientation and the three architectural axes](#orientation)
- [The separations within K](#separations)
- [The layers of complexity and their dependencies](#layers)
- [Integrations and the renewed M-side conjecture](#integrations)
- [Adapters and interfaces within K](#adapters)
- [Crosswalk of the inherited catalogues](#crosswalk)
- [One passage through the architecture](#worked-passage)
- [Intellectual neighbors and the developmental question](#neighbors)
- [Sources and provenance](#sources)

<a id="orientation"></a>

## Orientation and the three architectural axes

**K** names the concurrency side: actor-causal communities with session-typed values, their organization of work, and their documentary interfaces. **M** names the world/context side whose mathematical form is being discovered. HoTT is the foundational working language. Modal and cohesive mathematics remain resources, but a cohesive topos is no longer prescribed as M.

The candidate correspondence remains:

```text
Allow : M → K       Require : K → M
Allow ⊣ Require
```

Neither functor has been constructed. The conjecture seeks a universal-property account of the adequacy of a class of organizations containing Hoapa to independently meaningful contexts, uses, and alternatives. A characterization of that class, Hoapa's membership in it, and the adequacy of its real-world interpretation would be separate achievements. K is not silently redefined as a category of all candidate organizations.

Three architectural axes answer different questions:

| Axis | Question | Example |
|---|---|---|
| **Level** | What does this conversation take as its subject, and what may occupy its subject positions? | A real participant conversation at level −1 can work on documented conversations and outputs forming a level-0 graph. The pattern can recur. |
| **Layer** | Which responsibility is being exercised? | Session orchestration, documentary interpretation, protocol revision, or Federation. |
| **Adapter** | How do distinct structures relate while retaining their respective meanings? | A local-view embedding induces content restriction; a publication interface makes an output referenceable by later work. |

At every conversational level, panels remain the active machinery; the graphs and artifacts they discuss do not become people or acquire participant identity. A conversation about a protocol can exercise the reflexive responsibility, but a higher conversational level is not automatically a new mathematical layer. Similarly, a level-0 graph of episodes is not already the content theory Λ.

There are other uses of “level” in the project: universe levels, levels of homotopy, semantic scales, and the historical placement of Reality at a foundational “−1.” They must be qualified when they occur. The foundational-floor image for Reality is not the participant-conversation level convention. The work lanes 1C, 2S, and 3R are another classification again: they organize research and delivery, not the objects being described here.

The following evidence distinctions apply throughout. **Checked** means represented by a machine-checked result under its stated hypotheses. **Architecturally specified** means an intended responsibility or boundary whose implementation or theorem may still be absent. **Candidate** means a mathematical realization or interpretation under investigation. **Horizon** means a broader possible development. A committed responsibility need not have a chosen mathematical carrier, and a checked carrier need not establish its proposed social interpretation.

The present checked core includes actor-causal locality, finite descent, a supported point-generated reflector, a scoped linear/nonlinear bridge, Chu coefficient semantics, session syntax interpretation, several runtime-to-frame results, and raw actor-renaming invariance. The running software currently records supplied evidence faithfully. It does not yet originate the causal behavior, close conversations, publish artifacts, or implement Λ and Federation. The inventory describes all these concerns while retaining that difference in maturity.

<a id="separations"></a>

## The separations within K

### Reality and its accountable representation

Reality is the constitutive exterior: where perspectives form, material conditions sustain activity, and results encounter consequences that the protocol does not manufacture by describing them. The system receives contributions and produces documentation through a boundary. Its records do not exhaust the people, situations, or worlds from which they arise.

This boundary both separates and connects. It permits observation, interpretation, requests, testing, and externally mediated action without giving a formal description unlimited authority over its subject. In the proposed effect/capability reading, a protocol can formulate a request whose external handler carries out work; a theorem ruling out unmediated reality-changing effects remains to be constructed. The boundary is not a claim that inquiry never changes the world.

The identity channel and the contribution channel have different permissions. What someone brings can enter deliberation and documentation; who they are must not confer special formal standing or become an exposed documentary resource. Inward identity neutrality and outward no-leak are related but distinct obligations. Reality also supplies eligible participants and entropy for selection, without those becoming a complete internal population model.

M should not be identified with all Reality. It is the independently meaningful contextual structure needed to formulate the conjecture. A mathematical account of a world-interface can be rich without claiming to encompass the exterior. The Chu-shaped situation/test/evaluation proposal gives one possible boundary interface; the existing Chu implementation does not reconstruct Reality or prove that boundary adequate.

### Contributors and contributions

The principal organizational separation is between **unityped participants** and **multityped documentation**. Unityping gives admissible participants a common protocol interface and equal formal standing. It leaves their histories, capacities, specialties, and private lives outside the system's classification of actors. Documentation, by contrast, can distinguish claims, evidence, problems, concepts, derivations, objections, and uses as finely as the work requires.

Equal standing does not imply equal contributions or interchangeable outcomes. Different people and panels can change a result substantially. An assessment that one argument is stronger than another is compatible with the architecture. Making that assessment determine the producer's right to participate, speak, or exercise formal authority crosses the separation.

The Lautman-facing interpretation identifies the decomposed subject as **understanding of the world**. Embodied understanding is organized predominantly synthetically, through a common mode of participation; documented understanding is articulated predominantly analytically, through differentiated concepts and relations. Both moments occur in both realms. This is neither a basis of persons nor a theorem of unique conceptual factorization, and it does not assign “synthetic” to M and “analytic” to K.

The boundary remains rigid as an architectural commitment within K. Contextual uptake can let differentiated achievements furnish a common language for later inquiry. That development does not authorize their classifications to flow backward into an organization of people by kinds or ranks. The question of how an achievement becomes a new enabling context belongs to the broader correspondence and its interpretation.

### Eligibility, registration, panel membership, and event participation

Four scopes keep the participant boundary operationally precise. The eligible population exists outside the trace. Registered actors are opaque handles available within a run. Panel members occupy seats in one conversation. Event participants are those touched by one recorded event. A seat or role describes an activity or obligation, not an intrinsic actor kind.

A registered actor may remain silent or join no conversation. Consequently, a family of conversation frames covers the run's events under the current well-formedness assumptions, but it covers the registered actors only under a separate actor-coverage hypothesis. This distinction is checked; an accepted uncovered-actor fixture prevents the validator from quietly turning participation into a registration requirement.

Event-supported frames introduce a further, explicitly narrower scope: their actors are supported by event incidence. They are useful for the point-generated reflector. They must not redefine the larger registered population merely because eventwise mathematics is simpler on that subsite.

Selection creates a situated assembly, not a representative of the whole eligible population by mathematical fiat. Random draws do not prove categorical density, and participants are not automatically test objects. The result's standing comes through open later uptake, criticism, revision, and reuse, rather than the panel closing inquiry on behalf of everyone.

### Locality and typed content

The Hybrid foundation makes two inputs structurally distinct. The **actor-causal site** describes actors, events, incidence, causal order, local views, and covers. The **value category** describes the content assigned to those views and the transformations allowed between such contents. The site does not import session syntax or classify actors through payloads.

A presheaf relates the inputs: it assigns a value to each local frame and a restriction map to each local-view embedding. A sheaf condition adds a law for reconstructing compatible local data. This placement is the original architectural reason for using a sheaf-like organization: locality can remain itself while the algebra of content remains itself.

An actor-causal frame here is an incidence-and-order structure, not a frame in locale theory. Its fixed-base `FrameHom` preserves and reflects causal order. It represents an exact local view rather than an arbitrary causal map or a quotient. A conversation's canonical local order is the global run order restricted to its events; causal paths may leave the conversation and return. Internal generation of that same order is a separate, conversation-relative saturation property.

One finite run can have a realized global frame without supplying a global clock, complete world history, or network-wide observer. The scope of “global” is part of the construction. Nor is causal saturation already encapsulation, output terminality, or Simondonian metastability.

### Cartesian locality and linear session content

This is a second separation, not merely another name for site versus values. On a common site, **Set-valued sheaves** and **linear/session-valued sheaves** can both be formed. Their value disciplines differ. Cartesian structure supports the ordinary reuse and copying of data; linear structure tracks resources and interaction in a way that does not automatically permit unrestricted copying or discarding.

R4 is the explicit adapter between these regimes. A copyable description of an interaction does not thereby make its resources freely duplicable. Conversely, linear content still needs a cartesian account of locality and observation. Keeping both endpoints available allows them to cooperate without exporting the structural rules of one indiscriminately into the other.

Three units also need distinction: the tensor unit, the dualizing object, and the terminal object supplied by cartesian or additive products. Duality relates the first two, but does not supply a conversion between them. The optional unit/dualizing adapter would add genuine structure. Neither the LNL bridge nor convenient use of the word “empty” supplies it.

### Interaction shape, orchestration, content, and provenance

The cyclic operad O₁ names a grammar of interaction: a binary generator with three cyclic ports, substitution, and cyclic action. Session types describe the communication discipline, including dual endpoints. Λ concerns what is being discussed. Provenance records how an event, dependency, or result arose. These responsibilities meet in an episode without becoming one vocabulary.

The practical distinction is often expressed as **how**, **what**, and **how it came about**. An immutable session tag records how a conversation was constituted. A content reference identifies its documented subject or result. A provenance entry can identify a correction, response, derivation, or closure. Currently, the runtime contract carries opaque tags; their presence does not already implement the corresponding semantic theories.

Cyclic boundary symmetry and directed event causality occupy different places. Rotating the presentation of an interaction's ports is not reversing the order of events in its execution. Similarly, a future content operad governing conceptual composition would not automatically be O₁. The relation between interaction grammar, session semantics, and located execution requires explicit interpretation laws.

### Episodes, artifacts, concepts, and versions

A conversation is an episode. Its output artifact is a referenceable achievement of that episode. A concept identity belongs to a documentary interpretation. A documentation version fixes a current presentation and its admitted comparisons. None of these objects can safely stand in for all the others.

An episode can yield an artifact recording an unresolved problem. Several episodes can concern one concept. One artifact can be interpreted in different documentary contexts. A later version can change admitted comparisons while keeping the earlier artifact and the history of its interpretation addressable.

**Promotion** names publication through an explicit artifact interface followed by availability to later work. A completed conversation can become the subject of another conversation through that interface. It does not become an actor by a collapsing frame morphism. The intended gain is independent reuse: later work should not need to recreate the episode or obtain renewed permission from its producer whenever it uses the public result.

### Closure, assent, compatibility, and gluing

A conversation closes through one distinguished terminal event, with success or failure. A successful closure names its output; an unsuccessful closure names a first-class failure record that can support resubmission or further inquiry. Valid live prefixes and completed publications have different conditions: at most one closure for a prefix, exactly one for a published conversation, and no subsequent event belonging to a closed conversation.

Successful resolution requires unanimous acceptance under the conversation interface's participation and assent rules. Those mechanics do not become true merely because a trace has the right closure shape. Likewise, human acceptance and mathematical compatibility are different predicates. A semantic sheaf condition cannot be inferred from unanimity.

The useful example is two incompatible claims whose authors unanimously accept an artifact recording the unresolved alternatives and an experiment that could distinguish them. Assent to that record, fidelity to both claims, compatibility of the documentary data, and a possible gluing theorem are four separate matters. Preserving disagreement may be a successful documentary result.

Closure and publication remain specified responsibilities, not implemented runtime behavior. The example guides a first content semantics; it does not establish that a conversation is already a matching family or that consensus is a limit or colimit.

### Live records, public records, and stable references

The live runtime may temporarily need operational identity for delivery. The intended public record retains declared content, provenance, references, dependency edges, and participant counts while replacing actor handles freshly per conversation and omitting authorship and the live identity map. These are different mathematical objects with a preservation relation to construct.

Public artifact, conversation, and event identifiers stay stable and publisher-scoped. Actor pseudonymization must not rewrite those references. Forgetting the identity channel while retaining documentary lineage is a deliberate asymmetry, essential both to no-leak and to Federation.

The proved Tier A theorem concerns a uniform injective relabeling of the raw actor channel and exact validator invariance. Fresh per-conversation handles are a different transformation: one live actor appearing in two conversations can become two unrelated public handles. The intended preservation theorem concerns each conversation frame, not reconstruction of the entire live actor-overlap structure. Observational no-leak and unlinkability additionally require a specified observer and an account of every surviving channel.

### Directed dependencies and admitted conceptual comparisons

A causal-parent edge records operational dependence on an earlier event. A documentary dependency relates artifacts or episodes through their derivation or use. A frame morphism compares local causal views. A restriction map transports content to a smaller view. An admitted comparison can justify an identification in one version of Λ. Sharing endpoints does not make these the same arrow.

Λ keeps comparison history, current admissions, and the resulting presentation distinct. If Lᵥ is a directed presentation and Wᵥ its admitted comparisons, a localization Lᵥ[Wᵥ⁻¹] is one candidate way to make precisely those comparisons invertible. The original presentation, admission history, and provenance remain available. A withdrawal changes a later version's W; it does not insert an inverse to a past identification or rewrite the old presentation.

Integration can therefore make differently presented knowledge reusable without turning every dependency into an equivalence. A core, a localization, and a groupoid completion do different jobs. Neither connected components nor higher identity witnesses automatically decide conceptual sameness or preserve historical provenance.

### Stabilized articulation and conceptual variation

A stabilized concept is definite enough to name, compose, compare, and reuse. Its declared variations describe what can change under an interpretation, which responses matter, and what else must change to retain compatibility. The first makes understanding portable; the second keeps that portability from becoming a claim that its current articulation exhausts the possibilities.

Variation differs from both provenance and identification. Provenance records actual genesis. A variation can be possible without having occurred. An admitted equivalence relates presentations under a stated criterion; a genuine deformation need not preserve that criterion. Dynamics then asks how documentation and its possibilities actually or hypothetically evolve, rather than merely listing the admissible variations of a fixed interpretation.

The leading mathematical resources are Kock–Lawvere infinitesimal reasoning and algebraic or derived deformation theory. They have distinct jobs: smooth response on the one hand, families, equivalences, and extension obstructions on the other. A family-sensitive moduli account might relate variation and groupoidal identification, but its carrier and compatibility laws are unbuilt. Actor-causal events remain discrete; the proposal does not make people or messages into infinitesimals.

This is now a committed responsibility within Λ. It does not yet add a numbered layer. The universal-language hypothesis asks whether recognizable, stable articulations in such a landscape can become words while their surrounding possibilities remain available. “Peaks” is an image for that question, not a selected metric, maximum, connected component, or canonical representative.

### Artifacts and their derivational and temporal accounts

A clean interface lets later work use an artifact without replaying its construction. An accountable artifact retains enough of its grounds, transformations, and dependencies to inspect, challenge, update, or withdraw its use. These demands motivate the candidate Audit responsibility.

Its **derivational face** records alternative and jointly necessary grounds. Its **temporal face** records changes to local state: adoption, edits, overlays, conflicts, resolutions, and supersessions. A semantic dependency and a storage-change dependency are not the same graph. A materialization interface must relate them.

For example, withdrawing one source can remove one derivation while leaving another valid derivation intact. It need not delete the current artifact, and deleting a patch would not by itself express the semantic conclusion. Conversely, a storage operation can depend on textual context unrelated to the justification of a claim. Accountable reuse requires both faces and laws relating them.

A separate Audit layer remains a candidate. The existing provenance field is an opaque token, and neither provenance circuits nor a general reversible-import theorem have landed. The responsibility may become a layer or remain a facility consumed across Π, Λ, and Federation.

### Present rules and their revision

A system can make its own organization a subject of inquiry while keeping the rules governing a past episode fixed. A meta-conversation runs under an existing protocol, produces a proposal or failure record, and may support a later protocol version with an explicit activation boundary. Closure alone does not enact that change.

Protocol versions and documentation versions also differ. One changes how work is organized; the other can change the vocabulary or admitted comparisons through which existing evidence is interpreted. Ordinary content revision therefore need not wait for complete self-modification machinery.

The desired change interface records what earlier achievements remain usable and what new operation becomes admissible. Identity, composition, concurrent proposals, and local adoption all need laws. Strict causal reflection inside one frame does not prove non-retroactivity across versions. Π names this committed responsibility while its categorical realization remains open.

<a id="layers"></a>

## The layers of complexity and their dependencies

The layer catalogue describes a generative cascade of problems. Once locality and content can cooperate, there is an organization worth maintaining. Maintenance exposes the need to revise rules. A community producing documentation needs a language whose expressiveness remains accessible. A developing language raises questions about change, scale, and measurement. A successful local organization then needs relationships with independently maintained peers.

This explanatory sequence is not the implementation order. Some responsibilities share infrastructure, and later concerns can constrain earlier interfaces. The catalogue also distinguishes committed functions from mathematical horizons.

| Responsibility | Tension it addresses | Present architectural response | Maturity |
|---|---|---|---|
| **Hybrid foundation** | Local activity and content that must remain coherent across views | Actor-causal locality, typed values, restriction, and scoped descent | Substantial checked fragments; broader semantics remain open |
| **Reflexive Π** | Reliable rules and the capacity to change them | Versioned proposals, preservation obligations, and explicit activation | Committed responsibility; mathematical carrier unbuilt |
| **Bulk Λ** | Rich differentiated understanding and intelligible reuse | Versioned content presentations, directed dependencies, and admitted comparisons | First forcing case selected; semantic implementation unbuilt |
| **Conceptual variation within Λ** | Stable articulation and possibilities it does not exhaust | Declared families and responses alongside identification and coherence | Committed responsibility; realization under investigation |
| **Dynamics** | Exploration, stabilization, and change across scales | Investigate observables and transformations of documentary organization | Research horizon |
| **Federation** | Local coherence and plurality of autonomous contexts | Scoped identities, pinned imports, partial translation, and local adoption | Exchange constraints specified; richer mathematical structure unbuilt |
| **Information-cohomological complexity** | Dense expert encoding and accessible understanding | Receiver- and task-relative study of documentary cost | Research horizon |
| **Accounted artifacts/Audit** | Easy reuse and inspectable, revisable grounds | Separate derivational and temporal accounts, related by materialization | Candidate placement; no additional numbered layer adopted |

### Hybrid as the foundation of a compositional architecture

Hybrid is the disciplined collection of relationships between locality and content. Its presheaf chassis handles restriction; finite descent supplies checked gluing for particular witnesses; the reflector and R4 add further relationships between forms of content. It is useful to call this an adapter layer because its purpose is to let the structures on either side remain independently intelligible.

The inherited formal map distinguishes four mathematical responsibilities. They are components of this foundation, not four further stages of collective work:

| Component | Internal distinctions | What its boundary protects |
|---|---|---|
| **Site** | Actor base, category of local frames, and topology of covers | Locality is specified independently of payloads and session syntax |
| **Algebra** | Connectives, proofs or operations, and their categorical presentation | A content discipline has its own meaning and laws |
| **Sheaf** | Presheaf assignment, separatedness, and existence of amalgamation | Assigning local values, detecting equality, and reconstructing compatible values are separate obligations |
| **Topos** | Sheaf category, internal logic, geometric comparisons, and a possible higher lift | Category formation and stronger logical or geometric structure must each be justified |

The topos row records the intended larger organization. The existing finite sheaf categories do not establish every topos axiom or the proposed higher lift. In particular, the cartesian internal logic of an appropriate Set-valued sheaf topos would still need an explicit relationship to linear session semantics. R4 addresses that relationship at its currently constructed scope.

The operadic interaction grammar augments that foundation. O₁ provides composition shapes and cyclic laws; session interpretations give typed meanings to them. Neither replaces the causal site. The longer O₁ → MO₁ → moduli/dessin direction is a possible enrichment, not another description of all the layers below.

### Reflexive Π: changing organization under stated obligations

Π separates running a protocol from changing it. An accepted change must have a version, an activation boundary, and an account of preservation. A peer that accepts it does not thereby edit another peer. Rejected proposals remain available as records of attempted changes.

Patch theory, event structures, and related categorical accounts may eventually organize concurrent edits and conflict. Their role must be earned by actual change examples. Π is not already a category because it has a Greek name; nor does its name assert a dependent-product semantics. Protocol change is a larger responsibility than the promotion adapter through which a proposal becomes available.

### Bulk Λ: producing a language of the subject

The protocol's ambition is to produce a progressively more useful articulation of its context. Λ provides the “what” vocabulary and relationships that session syntax alone cannot supply. It must distinguish episodes, artifacts, concepts, and versions while relating them through evidence and use.

A universal technical language here would support intelligible operations and warranted passages between perspectives. It need not replace local vocabularies with one compulsory alphabet. Two importantly different achievements are possible: witnessing that two presentations express equivalent content, and recognizing a reusable construction pattern across contents that remain different. A language can support both without identifying all instances of a pattern.

Identification, coherence, conceptual variation, and purpose-relative compression initially live inside Λ. Compression is adequate for a declared observation when that observation factors through the compressed presentation. Higher structure becomes useful when a specific coherence problem requires it, such as comparing multiple disciplinary translations and the witnesses relating their composites. A non-closing triangle is not automatically a bias; the interpretation must say what was supposed to agree.

### Dynamics: how documentary organization changes

Variation describes possibilities under an interpretation. Dynamics studies actual or modeled movement among presentations, and possibly changes in the possibilities themselves. This separates the content of a language from an account of its development.

Factorization algebras, content operads, and renormalization-group ideas are proposed resources for local composition and changes of scale. They are not supplied by the existence of a sheaf or by recurring conversation. A Hoapa application needs actual observables, transformations, and a reason simpler versioned presentations are insufficient.

An action functional or numerical heuristic might compare description length, communication burdens, unresolved coherence, or drift from use. Its terms would carry explicit normative and empirical commitments. Such quantities belong to an analytic companion, not the trusted definition of typing, provenance, valid publication, or no-leak. Documentation can evolve without the kernel silently ranking people or treating a numerical objective as semantic validity.

### Federation: local authority and open exchange

Federation distinguishes a language's internal contexts from independently maintained peers. Engineering and biology can be locators in one documentary language; that alone does not make them federated protocols. Federation begins when different maintainers, versions, admissions, and import boundaries must coexist.

A peer exports a finite, versioned publication bundle. A receiving peer pins what it interpreted and makes its own adoption decision. Source updates, withdrawals, and local overlays have explicit effects; an offline import does not silently change. Completeness is relative to the declared import boundary, not possession of all ancestry in the network.

The first categorical candidate organizes publication contexts and partial translations, with composition preserving specified observations and provenance. Comparing translations might later require 2-cells. Meta-topoi, anabelian reconstruction, and GT actions are more distant candidates. An open network can be useful before any of them exists.

Federation's constraints act early: identifiers must be publisher-scoped, source and local authority must differ, and import interpretation must be reproducible. No global actor directory, clock, language quotient, consensus, or mandatory update is supplied. Openness requires the ability to relate local organizations while preserving their differences.

### Measurement: documentation and the cost of understanding it

The information-cohomological concern starts from a practical question: what does it cost a receiver, with a declared task and context, to decode and use an articulation? Dense encoding can be economical for a specialist while imposing heavy prerequisites elsewhere. Unityping makes that an architectural concern because the system cannot solve it by granting an expert caste privileged standing.

Measurements must attach to interfaces, tasks, observations, and contexts without becoming personal rankings. Equal standing does not mean identical representations are suitable for everyone, or that every person's effort is numerically equal. Pedagogy, translation, and multiple interfaces can reduce burdens while keeping the source artifact stable.

Information cohomology, deterministic information loss, description complexity, statistical divergence, and empirical proxies are different candidates. Each requires its own inputs and interpretation. An entropy chain rule can be satisfied rather than obstructed; statistical reconstruction does not recover the actual forgotten history of an episode. No chosen measure currently characterizes Hoapa's adequacy, and the universal-property investigation does not depend on first finding one.

### The dependency picture

The principal dependencies form a partial order:

```text
actor-causal locality + session values + Hybrid interfaces
                         │
              runtime evidence and contract
                         │
              closure, references, publication
                    ┌────┴────┐
                    │         │
             content Λ    later bounded protocol change Π
                    │
          observable documentary organization
                    │
             dynamics and measurement

Federation constrains publication and Λ early,
then grows through actual translations and context renewal.
Accountable-artifact interfaces may be consumed across this diagram.
```

This diagram follows the intended realization route, not a theorem that every abstract Λ investigation must wait for the runtime. Pure conjecture work can test small independent models. The important distinction is between a responsibility's conceptual motivation, its semantic prerequisites, and the sequence through which the executable system will supply evidence for it.

Runtime, checker, storage, and web interfaces are executable responsibilities beside this mathematical catalogue. Their separation matters, but they are not extra mathematical layers. The runtime originates behavior; the recorder preserves supplied evidence; the contract defines acceptance; the checker applies that definition; storage retains changes; the web edge presents interfaces. Today only parts of that assembly exist.

<a id="integrations"></a>

## Integrations and the renewed M-side conjecture

### What the mirror proposes

The renewed mirror asks how disciplined separations in K enable contextual integration in M, and how contextual capabilities in turn demand further distinctions within K. “Secondary” means induced through a relationship, not less important or later in time. The two directions do not require two adjunctions merely by being reciprocal questions.

Integration can assemble local information, relate vocabularies, reconstruct an object from its manifestations, or make independently produced achievements available within one context. It can also sustain the dependencies that allow local work to omit its surroundings. None of these meanings requires erasing the distinctions being integrated.

The mirror does not allocate all separation to K and all integration to M. K already has constructions that glue or compose, and M may have essential distinctions of its own. The sides identify starting points and responsibilities in a proposed correspondence. A K-internal descent theorem is therefore a resource for the mirror, not automatically an established M-side effect.

### Starting from K: the contextual capabilities sought

The following entries bring together candidates already present in the project. They are explanatory connections, not proved implications or a finished axiom list.

| K-side separation | Contextual integration to investigate | What the integration must retain |
|---|---|---|
| Contributor and contribution | Relate work across identities, specialties, and originating groups | Equal standing, situated differences, and assessment of work without classification of its producers |
| Local views and typed content | Assemble understanding available through different views | Restrictions, overlap information, relevant causal structure, and explicit incompatibilities |
| Cartesian description and linear interaction | Make accounts reusable while respecting the resources of work | The difference between copying a description and reproducing the interaction or its enabling conditions |
| Episode and artifact | Let multiple episodes contribute to a reusable contextual resource | Declared evidence and future uses, including use when the producer is unavailable |
| Local vocabulary and explicit translation | Relate partial languages without compulsory replacement by one vocabulary | Their distinctions, translation conditions, and failures of translation |
| Dependency and conceptual comparison | Combine explanatory history with structural understanding | Directed derivation alongside selectively reversible comparison |
| Stable articulation and conceptual variation | Reuse concepts in families and under relevant transformations | Responses required by the new use, conditions of variation, and meaningful obstructions |
| Artifact and account | Compose inherited work without repeating its whole production | Origin, alternative support, versions, and the consequences of changed grounds |
| Current organization and explicit revision | Preserve achievements while enabling changed forms of work | Non-retroactivity, stated preservation, and an independently meaningful new capability |
| Peer autonomy and exchange | Build a plural network of documented contexts | Local admission, pinned interpretation, partial translations, and absence of compulsory convergence |

Several distinctions recur across the rows because different integrations consume the same boundary. Producer-independent reuse, for example, needs an artifact interface, sufficient information, permissible access, and continued support. A single observation-preserving quotient does not supply all four.

### Starting from contextual capabilities: distinctions induced in K

The reverse investigation asks which documentary or operational distinctions become necessary when a context supports a certain form of understanding.

| Contextual resource | Integration it can support in an appropriate model | Further distinction to express in K |
|---|---|---|
| Witnessed equivalence and univalence | Transport between equivalent presentations | Presentation, equivalence witness, directed translation, and computational conversion |
| Locality and descent | Reconstruction from compatible local descriptions | Local data, compatibility evidence, and the assembled object |
| Binding, scope, and freshness | Abstraction and instantiation independent of incidental names | Local names, their scopes, and exported interfaces |
| Context-relative access or decidability | Relate partial accounts without forcing every question into a local yes/no verdict | Established, refuted, and unsettled claims, with their access conditions |
| Torsors and related symmetry-bearing objects | Coherent organization without choosing a global trivialization | The object, a section when one exists, and a preferred section when justified |
| Dependent sums and products | Package particular achievements or construct uniform families | Witness-plus-result data versus an operation instantiable across declared inputs |
| Propositional truncation | Use mere existence where a witness is unnecessary | Existence-only evidence versus structured evidence needed for checking or reuse |
| Relative geometry and change of base | Relate a manifestation to its conditions of availability | Geometric presentation, descent data, and availability over the original context |
| Family-sensitive variation | Compare constructions together with their relevant responses | Equal current answers, admitted equivalence, and preserved behavior under change |

These resources do not come with their Hoapa interpretation. Observer ignorance is not by itself non-Boolean logic. Absence of a preferred section differs from absence of any section. Decidability, judgmental equality, and proof irrelevance differ. Identity witnesses do not automatically record historical provenance. The mathematical force lies in a specified construction and preservation law relating a resource to an actual use.

Two examples keep the mirror concrete. Local data with overlap compatibility provide the familiar shape of separation enabling integration through descent. Conversely, the relative viewpoint can reveal that two geometrically similar presentations have different availability over a base: the project uses x² − 2 and x² − 1 over ℚ, which become isomorphic two-point schemes over an algebraic closure but differ in rational points. The example distinguishes contextual availability from geometric appearance; it does not assign arithmetic exclusively to M or geometry exclusively to K.

A second comparison concerns local prescriptions and global realization. A nonzero simple principal part at one point can be prescribed locally on both the projective line and a genus-one curve, while a global meromorphic function with precisely that sole simple pole exists only in the first case. The project uses this Riemann–Roch example to show integration revealing a distinction between locally similar possibilities. It remains an external mathematical exemplar, not a Hoapa theorem.

### Two candidate interfaces of K to a contextual setting

Arc/19 develops a possible organization in which K offers a documentary interface and an operational interface. The schematic chain is:

```text
              Real                         Free
    D̂ ─────────────────▶ C ─────────────────────────▶ A
       ◀────────────────   ◀─────────────────────────
              Nerve                       Underlying

              Real ⊣ Nerve           Free ⊣ Underlying
```

Here D is a chosen category of documentary probes, D̂ its space-valued presheaves, C an underlying-data category, and A a category of appropriately structured practices. These are candidate interfaces, not replacements for the entire K or M. An ambient semantic setting E may differ from C: elementary E-valued collections are not automatically E itself. A fixed operad, its category of algebras, and a category of operads are also different objects.

Real assembles the contextual meanings of a presentation. Nerve records a context's manifestations through the chosen probes. Free equips contextual data with operations under a stated theory. Underlying forgets selected operational structure. The operational pair is Allow/Require-shaped; the documentary pair has the other adjoint polarity across the proposed contextual/documentary divide. The role labels do not rename the original pair or establish four adopted Hoapa functors.

Monads with arities is a leading resource for relating generation and description. It distinguishes maps of underlying arities from algebraic maps between free objects and supplies nerve theorems under specified hypotheses. Those extra maps matter: an underlying-data description cannot recover operations genuinely forgotten merely because it is called a nerve.

The actual public record needs its own interpretation. An exhaustive probe nerve is not automatically the artifact produced by a finite episode, and the forgetful functor is not automatically the live-to-public transform. The source discussion names a possible episode-to-available-documentation construction and a comparison to the nerve. Its content would have to come from independently specified evidence, protected channels, and future uses. Merely defining it equal to the existing composite would add no publication semantics.

### Borrow, work, return, and replay

If L = Allow and R = Require form an adjunction, an episode w : Lm → k has a contextual transpose:

```text
w♯ = R(w) ∘ ηₘ : m → Rk
```

That is a possible mathematical form for **return**. It exists for every adjunction. **Replay** additionally needs a later context, an admissible input or request, an operation consuming the returned form, and a result showing preservation of the declared use. Transport, descent, realization, and operational composition can participate in replay without any one being its definition.

Particular artifacts and instantiable rules may have different return interfaces. Dependent Σ suggests packaging a witness with a result; dependent Π suggests an operation uniform across a family. Their interpretation needs actual families, variance, and abstraction/instantiation laws. Neither notation alone constructs publication.

Making available also differs from delivery. Hoapa's intended public interface supports consumer-initiated access, appropriate presentations, no paywalls, and reuse without renewed producer authorization. It does not advertise or push content to prospective consumers. Pedagogy and translation can improve accessibility without changing the source episode. An interpretation arrow from a document into a context is not an unsolicited operational message. Open access is an architectural commitment whose realization needs its own account; it does not follow from adjunction axioms.

### Inheritance and contextual renewal

Stable reconstruction can support inheritance. Development need not require every closure operation or every fragment of knowledge to remain non-idempotent. Contextual renewal instead asks for an achievement whose uptake preserves named earlier uses and makes a genuinely new operation admissible. A changed presentation alone does not demonstrate that result; a new object in an unchanged setting might already do so.

The fixed-adjunction non-collapse ladder remains a precise separate investigation: persistent non-stabilization of a unit tower implies monad non-idempotence, which implies a reconstruction defect somewhere in the counit. The reverse implications are unavailable. Even persistent formal iteration needs an interpretation before it counts as new contextual capability.

The earlier unrestricted flat signature collapses its intended modal distinction. It is a legacy control, not a non-degenerate model of M; the focused all-types-flat proof remains an unimplemented diagnostic. The renewed programme permits other settings, and relative cohesion remains an optional relationship between suitable settings. It supplies neither a mandatory M nor a ready-made translation of every architectural separation.

### What would turn a mirror entry into a result

A substantive entry would identify the K structures, an independently meaningful contextual use, the construction relating them, and the law stating what is preserved. It would compare a meaningful alternative under the same use. An alternative might support the capability through another mechanism; that would restrict a necessity claim without making the alternative incoherent.

Adjunctions can contribute representation and preservation properties once those objects and maps exist. They do not, by themselves, prove equal standing, safe publication, accessible understanding, or renewal. A universal property must concern a declared comparison setting rather than one defined only to admit the favored architecture. The present inventory supplies material for that investigation; it does not perform the extraction of K's final categorical essence.

<a id="adapters"></a>

## Adapters and interfaces within K

An adapter is a specified relationship across a separation. Its mathematical kind can be a functor, natural transformation, interpretation, reflector, change-of-base construction, or observational preservation law. Some architectural interfaces have not yet earned one of these forms. The common requirement is to expose the passage and its laws instead of hiding a change of meaning in a cast or a shared name.

The adapters below form a network. Several compose into a longer construction; others constrain an entirely different channel. They should not be pictured as one sequence that every contribution traverses.

### Restriction: local views induce local content

For a presheaf P and an embedding of a smaller actor-causal frame G into F, restriction has the shape:

```text
FrameHom G F → Hom(P(F), P(G))
```

The direction reverses: the embedding goes toward the larger frame, while its content is restricted toward the smaller view. Identity and composition laws make successive restrictions consistent. The generic adapter lets the target category vary without changing what an actor-causal view means.

This is the original concrete Hybrid adapter and is checked both in the arbitrary-frame chassis and in the finite framework. A session-valued instance supplies typed content. Restriction is not automatically an access-control policy: a separate interpretation would have to say which views a particular observer is permitted to obtain.

### Probes, separatedness, and descent: detecting and assembling content

In a linear value category, “element of P(F)” should not silently mean a map from a cartesian terminal object. The framework uses generalized elements, Hom(X, P(F)), for an arbitrary probe X. This keeps observation relative to a declared source and avoids treating the tensor unit as terminal.

Separatedness says that if two such maps become equal after restriction to every member of a cover, they were equal already. It is the uniqueness or detection half of descent. A sheaf condition adds existence of an amalgamation for a matching family: compatible local maps arise as restrictions of a global one. Compatibility is stated on overlaps, not inferred from the fact that a family of local records exists.

The category-generic finite event-product construction is checked. Its concrete Set and Sessions witnesses have a fixed slot P₀ at every event, with arity varying by the frame's event count. They establish nontrivial finite descent but not event-dependent session semantics. The generic interfaces are deliberately broader than these witnesses.

The adapter relates local semantic information to assembled semantic information. Interpreting it as faithful deliberative integration, accountability, or consensus requires further content and protocol theorems. In particular, separatedness is not the entire meaning of auditability, and a unanimous panel is not automatically a matching family.

### Sheafification: a universal comparison with reconstructible content

A reflector a ⊣ ι relates presheaves to a full subcategory satisfying a chosen sheaf condition. Its unit compares an initial assignment with its reflected assignment; its universal property says that maps into the selected sheaves factor through this comparison in the appropriate unique way. This is additional structure beyond finding one presheaf that happens to satisfy descent.

The constructed route uses supported finite frames and a point-generated, event-discrete geometry. Its object formula is:

```text
a(P)(F) = ∏ over events e of F of P(ptₑ)
```

Here ptₑ is an incident event-point, and the factors can vary with e. That variable-slot construction must not be confused with an already completed event-dependent session-content interpretation. It reconstructs from event-point observations under the supported point-cover discipline. Actor-only frames are outside that support condition.

Pointification lands in point sheaves, and the reflector adjunction is checked. It is not the generic reflector for all finite actor-causal covers. The latter may need information on overlaps that isolated event-point observations do not retain. A concrete Λ example must establish which required observation, if any, forces the richer construction. The unresolved-claims example is intended to test this difference without presuming either model adequate in advance.

### Change of value and R4: cartesian and linear semantics cooperate

A functor between value categories changes the values of a presheaf while leaving its frame index fixed. That functorial change of value is checked. The structural frame-noninterference result makes one separation precise: replacing coefficients does not change the actor-causal index. It is not yet a theorem about every observation that might expose an actor.

At value level, the Benton linear/nonlinear interface has F : Cart → V and G : V → Cart, with F ⊣ G and the stated strong-monoidal comparisons for F. It provides a controlled relationship between cartesian and linear disciplines. The composite F ∘ G gives the linear exponential shape; naming it does not make it a runtime verification operation or a public-artifact constructor.

The adjunction lifts to presheaves, and G preserves the relevant sheaf condition. F need not preserve it directly. This is why the sheaf-level left functor uses sheafification:

```text
Lsheaf = aV ∘ liftF ∘ ιCart
Rsheaf = liftG restricted to the sheaf categories
```

The full finite-site assembly is checked conditionally on a V-side reflector. On the supported point-generated site, that reflector has been constructed, yielding Lpoint ⊣ Rpoint relative to the value-level LNL and finite-product hypotheses. The concrete Chu(SET, Bool) coefficient witness discharges those hypotheses for one actual model.

R4 is therefore an internal bridge in K with a precise supported scope. It is not `Allow ⊣ Require`, a full topos theorem, or a proof that live conversation has become a freely copyable public artifact. Those distinctions are particularly important because the same left/right-adjoint vocabulary appears in all these investigations.

### Unit and dualizing object: an optional additional bridge

The tensor unit 𝟙 and the dualizing object ⊥ are related by duality. A morphism between them is extra data. An optional bridge can induce a natural transformation between their constant presheaves, but neither its existence nor its inverse laws follow merely from naming a duality.

This is the historical “Unit/Dualizing Bridge,” sometimes discussed through mix-like structure. A one-way map, maps in both directions, and an isomorphism are progressively different claims. The project has not selected such a bridge, and the LNL interface deliberately does not smuggle it in. Its status illustrates why clean engineering interfaces still have mathematical costs: a convenient conversion can erase a distinction the semantics needs.

### Operadic valuation and located interaction

O₁ supplies formal interaction shapes. A valuation interprets a shape of arity n as a morphism from an appropriate tensor of port values into the dualizing object. The stronger `OperadAlgebra` interface states how operadic substitution is interpreted by `plug` and cyclic action by `shift`, with the required laws.

Those algebra-level interfaces exist. Their Sessions instance still depends on `session-O1-action`: the current thin categorical signature does not derive the action canonically. Removing that assumption requires actual interaction structure and coherence, such as evaluation/cut and coherent tensor rotation; relabeling the assumption would not discharge it.

The historical Hybrid adapter goes further: locate this algebraic interpretation over actor frames and make it compatible with restriction and descent. A presheaf valued in suitable algebras is a possible carrier. The existence of an algebra and a presheaf separately does not yet construct that compatibility. This is where “protocol as a compositional grammar” must meet “protocol situated in a causal locality.”

### Session syntax, Chu semantics, and the two duality faces

The Sessions-to-model interpretation has an object map J0, a morphism map J1, and functorial laws. It is instantiated in Chu(SET, Bool) over postulate-free object and morphism syntax. This gives a concrete semantic interpretation of the syntax and a duality isomorphism; it does not yet supply full send/receive payload behavior.

Chu objects retain points, states, and an evaluation pairing. Their reversal makes them a useful coefficient model for process/context questions. That role differs from being the cartesian–linear bridge itself. Chu is a value model consumed by R4, not another name for R4.

R8 records two related faces: the proved syntactic involution of session duality and the categorical/operadic boundary-swap result, the latter relative to the assumed session action. Their intended bridge remains open. Cyclic rotation generally has an arity-dependent order; it is not the order-two session involution merely renamed. The corresponding Care reading has a checked reciprocal proxy, while developmental adequacy remains a further interpretation.

### Runtime realization: evidence acquires substrate meaning

The raw contract is a substrate-free decidable boundary. Serialization gives it external form; runtime codecs and the recorder preserve that form. Realization then interprets accepted evidence in the actor-causal mathematics rather than making the raw validator import the entire substrate.

The checked sequence derives a causal order from backward parent edges, constructs a global frame, constructs conversation-local frames with strict embeddings, gives conditional conversation coverage, and compares restricted global order with internally generated conversation order. These results say exactly what follows from the supplied raw evidence.

The missing behavioral premise is separate: the runtime kernel must earn parent edges from messages actually consumed. The recorder currently preserves caller-supplied edges faithfully. A realization theorem cannot convert that fidelity into evidence that behavior really produced the dependency. Session assignment and transport of broader sheaf results to executions also remain separate interpretation work.

The same distinction governs replay. Exact recorder replay reproduces an exported structure. Purpose-relative replay reconstructs or resumes a declared activity through its documentary interface. Only the former is currently tested in the runtime.

### Publication and promotion: an episode becomes independently usable

The intended publication adapter exports a closed episode's output or failure through a stable artifact interface. A later conversation references it under its own session and context. This supplies the operational meaning of promotion without changing the fixed-base meaning of `FrameHom`.

Preservation includes stable references, declared content observations, relevant dependencies, and the intended account of origin. Deliberate forgetting includes protected live identity. Independent usability also requires access and capability conditions: an interface that gives the same public answers but demands producer authorization for each reuse may fail the intended future use.

This adapter is architecturally specified and awaits the closure/reference contract and runtime behavior. It does not require MO₁ simply because something is used again. Reusing an artifact in a fresh occurrence can be ordinary directed composition; a modular contraction needs a separately identified self-gluing operation.

### Actor-base change and no-leak: preserving structure across protected forgetting

The existing fixed-base `FrameHom` quantifies over one actor carrier. Realized runs and their relabelings can have different semantic actor carriers. A relative morphism over an actor-base map is therefore needed to state the intended comparison, rather than weakening the existing local-view interface.

The no-leak ladder distinguishes four strengths:

| Rung | Claim | Status |
|---|---|---|
| **Tier A** | Arbitrary raw actor maps respect identity and composition; total injective relabelings preserve the validator exactly; permutations give the invertible specialization | Checked |
| **Tier B** | Appropriate relabelings or publication transforms induce equivalent realized structures over changed actor bases | Relative interface and the selected per-conversation publication case remain unbuilt |
| **Tier C** | A suitably packaged realized equivalence can be upgraded to equality through SIP/univalence | Optional later capstone |
| **Tier D** | Declared trusted observations cannot distinguish protected identity changes; possibly a universal invariant-observation characterization | Research target requiring observation semantics |

The selected closure transform preserves each conversation frame while forgetting live overlaps between conversations. It is not a uniform raw renaming. Public pseudonyms alone do not establish unlinkability, and actor-channel invariance does not erase event, artifact, or protocol identity.

The related protections—no ranking, no exposure, no consumption, no copying of the participant into documentation—also differ. The opaque actor carrier supplies a structural floor; Tier A supplies one exact theorem. The stronger protections remain candidates and must not be read as consequences of omitted fields alone.

### Provenance evaluation and materialization: accountable reuse

The positive provenance candidate records alternatives by addition and joint use by multiplication. A shared circuit over source tokens can represent an account without expanding every derivation. Evaluating the account in a suitable coefficient system can answer different questions about support, multiplicity, or other interpretations under their own laws.

Setting a withdrawn token x to zero determines which positive derivations survive. It does not decide how a local artifact should be repaired, remove a storage patch, or distribute authority between peers. Those are the responsibilities of accountable change and the materialization interface.

The proposed comparison is conditional and observational:

```text
materialize(recompute(account with x set to zero))
    ≃
incrementally-retract(materialize(account), import-change x)
```

The account, materialization, observations, repair policy, overlays, and alternative supports must be typed before this is a theorem. Origin preservation, dependency adequacy, preservation outside the affected cone, and non-retroactivity are supporting obligations. Pijul is a possible storage implementation to refine an abstract interface, not the definition of those laws.

Typed data migration, displayed/indexed categories, lenses, or enriched profunctors may handle particular aspects of transport and repair. They are neighboring candidates with different jobs. None automatically supplies persistent provenance, a linear value category, or reversible changes. The entire accountable-import package remains unimplemented.

### Federated translation and local adoption

The Federation interface relates a stable source bundle to a receiver's pinned import, translation, admission decision, and local materialization. Source authority and adoption authority remain distinct. A receiver may update, detach, fork, or withdraw an imported use without pretending to have authored its source.

Its first concrete test must allow colliding local identifiers, an offline pinned import, different admitted comparisons, and a withdrawal adopted by only one peer. A successful interface makes each view reproducible relative to its declared boundary; it does not force convergence.

Full categorical translation laws remain to be built. This is an interface between independently maintained K-side publication contexts, distinct from the conjectural M/K correspondence. A translator may preserve a selected observation while failing another; completeness and adequacy must be stated relative to the actual use.

### Compatibility between adapters

The next layer of mathematical content is often a law relating two passages already intelligible separately. Does reindexing and then forming a trace agree with forming the trace and then reindexing? Does coefficient change preserve the chosen descent condition? Does erasure preserve the derivational account needed for checking? Does a translation carry the responses needed by a later use?

Some such laws are already checked in the presheaf and R4 constructions. Others are theorem-shaped targets. Beck–Chevalley, Frobenius, naturality, and descent are possible forms, to be used when their actual inputs and hypotheses exist. Mediation through an interface and gluing compatible local data remain different laws even when they occur in one diagram.

This is also where a possible logical presentation would have to work. Contextual indexing by slices, operational value/computation or cartesian/linear phasing, and framework-level judgmental modes are distinct structures. A layer is not automatically a mode; a mode needs a genuine regime of judgments and structural rules. The checked R4 adjunction is a grounded starting point for an LNL/CBPV investigation, not an already constructed calculus of process-to-artifact stabilization.

<a id="crosswalk"></a>

## Crosswalk of the inherited catalogues

### The seven Hybrid slots

Arc/06 first explores several overlapping adapter lists, including a separately numbered section/probe adapter. The later seven-slot catalogue, retained in the original Hybrid header, is the most useful historical numbering to recognize. It includes a cross-side slot and therefore is not literally a list of seven K-internal adapters.

| Historical slot | Current reading | Qualification |
|---|---|---|
| **1. Restriction** | Local-view embeddings induce content restriction | Checked generic chassis and finite variants |
| **2. Descent/Gluing** | Separatedness and existence of compatible amalgamation | Finite event-product descent is checked; the point-generated reflector is a separate construction; full semantic deliberative gluing remains open |
| **3. Unit/Dualizing Bridge** | Optional morphism(s) relating tensor unit and dualizing object | Extra structure, unselected; not supplied by R4 |
| **4. Operadic Valuation** | Relate O₁ interpretation to content located over frames | Algebra-level interfaces exist; the general located lift and a canonical session action remain open |
| **5. Promotion** | Publish an artifact through an interface for later reference | Supersedes conversation-as-actor collapse and automatic consensus-to-protocol-edit readings |
| **6. Allow ⊣ Require** | The conjectural correspondence between M and K | Cross-side, unconstructed; the fixed modal destination is retired |
| **7. No-Leak/Erasure** | Keep typed contributions and public observations from refining protected actor identity | Tier A is checked; realized and observational publication claims remain open |

Arbitrary probes remain part of the restriction/descent discipline even though they do not occupy a separate slot in this later numbering. R4 subsequently becomes central without being identical to slot 3 or slot 6. The possible “Adapter 8” for reflexive editing was a historical placement question; Π now names a broader responsibility, with publication as one of its interfaces.

The old header also retains superseded claims about promotion, consensus as a colimit, and non-retroactivity following from `FrameHom`. This inventory preserves the names for navigation while using their corrected meanings. It does not rewrite that history or treat every old slot as an implementation obligation.

### Structural relations R1–R11

The R catalogue organizes relations among mathematical components. Some entries correspond closely to Hybrid adapters; others name generation, comparison, or long-horizon enrichment. They are not eleven sequential runtime conversions.

| Relation | Responsibility | Present interpretation and scope |
|---|---|---|
| **R1 — Valuation** | Assign content to actor-causal views | Presheaf valuation, with checked finite event-product instances. This use of “valuation” differs from interpreting operadic operations in R7. |
| **R2 — Indexing** | State restriction and descent over the chosen site | Checked finite framework and scoped point-generated route; site and coefficient responsibilities remain distinct. |
| **R3 — Generation** | Form the sheaf category from site and sheaf condition | Finite categories exist. Full Set-valued locality topos/internal logic and higher lifts are not established at the catalogue's original generality. |
| **R4 — Interpretation** | Bridge cartesian locality and linear/session values | Benton/LNL: conditional full finite-site route; constructed supported point-generated bridge and a Chu coefficient witness. |
| **R5 — Ambient comparison** | Relate the settings to a proposed common ambient | Under reconsideration with M. Using Cubical Agda does not itself construct a common cohesive ambient or a cross-side comparison. |
| **R6 — Causal parametrization** | Give locality its event/incidence/order content | Actor-causal site and pullback constructions are checked; runtime realization supplies additional interpretation of raw evidence. |
| **R7 — Algebra over operad** | Interpret interaction shapes and their composition | Valuation and `OperadAlgebra` exist; the concrete session action remains postulated. |
| **R8 — Involution and duality** | Relate session reciprocity to operadic boundary swap | Both faces are stated at their respective scopes; the bridge between them is deferred. |
| **R9 — Modular envelope** | Add self-gluing/contraction to the cyclic organization | Deferred; a concrete need for that operation must be distinguished from ordinary reuse. |
| **R10 — Moduli realization** | Relate appropriate operadic/graphical structure to geometric moduli | Long-horizon candidate; presentation, stability, and geometric hypotheses must be supplied. |
| **R11 — Arithmetic action** | Relate relevant towers and their symmetries to the interaction theory | Long-horizon proposal, not a constructed Galois or GT action on Hoapa. |

Implementation adapters such as the thin `StarAutonomous`-to-Cubical-category conversion and the project/library Set-sheaf comparison serve a further role: they connect presentations or libraries so the semantic construction can be reused. They do not each introduce another project layer. Conversely, a library comparison theorem can be mathematically substantial without being the M/K conjecture.

<a id="worked-passage"></a>

## One passage through the architecture

Consider a conversation in which participants defend two incompatible accounts of a phenomenon. They eventually agree to publish the disagreement, the evidence each account uses, and a proposed observation that could distinguish them. This is an illustration of the intended architecture; it is not a report that the running system already performs the whole passage.

**Constitution and execution.** Participants enter through the common interface. Eligibility and the draw belong to their own boundary; opaque runtime handles do not encode expertise or standing. The conversation has a session tag fixing its communication discipline. Its events record local participation and causal dependencies. The intended runtime must originate lawful behavior, and the recorder must preserve the resulting evidence. Contract acceptance then establishes only the predicates the contract actually checks.

**Local interpretation.** A frame identifies the actors, events, and causal order relevant to a view. The presheaf assigns content to such views, with restriction laws. If the content model and cover satisfy a descent theorem, compatible local records can determine global content at that scope. The theorem does not decide whether either scientific account is true. Nor does agreement on publication supply the missing semantic model.

**Closure and publication.** The participants can unanimously accept the unresolved record. The terminal event marks the episode's outcome, and publication exposes a stable artifact interface. The subject remains open even though the episode closes. A failed episode likewise needs a referenceable failure record. Public actor handles are fresh for this conversation; artifact, conversation, and event identifiers retain the stable scopes needed for citation. Documentary lineage survives without becoming an authorship directory.

**Interpretation in Λ.** Later work can cite the artifact, analyze its alternatives, and relate its concepts to other presentations. One documentary version might admit a comparison between two terms used in different disciplines. Another might withdraw that admission after a counterexample. The old artifact and admission history remain available. Neither operation reverses causal time or changes who participated in the original conversation. A declared conceptual variation can explore how the proposed distinguishing observation would respond to different assumptions without pretending that those variations occurred historically.

**Accounted and federated reuse.** Another peer can import a pinned publication bundle, preserve its source references, and adopt only part of its interpretation. If two derivations support a local result, withdrawing one source may leave the other derivation intact. A materialization law would explain how that change affects the current local artifact. A translation can preserve a specified observation while omitting irrelevant detail; provenance records which translation and source version were used. These are obligations of the proposed interfaces, not consequences of merely exchanging a file.

**A limit of reuse.** The response-preservation example from the infinitesimal arc makes the issue precise. Suppose a richer situation is a pair of bits (a,b), and its published observation is q(a,b) = a. An operation that flips the first bit can be replayed through this publication: the returned operation flips the published bit. An operation that swaps the two bits cannot. Situations (0,0) and (0,1) have the same publication, but after the swap their first bits differ. No operation receiving only the published 0 can reproduce both responses.

In a deterministic model, a returned operation w̄ must satisfy:

```text
q′ ∘ w = w̄ ∘ q
```

Here w is the work on richer situations and q, q′ are the respective publication interfaces. The question is whether w̄ exists. A publication can preserve a present answer while failing to preserve its behavior under later work. Conversely, a publication adequate for one continuation need not preserve every imaginable continuation. New inquiry may require new evidence; it cannot promise to recover deliberately discarded information.

**Renewal.** Later uptake could make the published distinctions part of a new common context: a new question becomes formulable, an earlier representation becomes inadequate, or a previously unavailable construction becomes possible. That is where the M-side conjecture seeks more than faithful storage. If the organization itself needs to change, a further meta-conversation can propose a protocol version through Π. Ordinary reuse, conceptual revision, contextual renewal, and protocol change remain different events. This passage becomes evidence for the conjecture only when its contextual meaning and an appropriate comparison with alternatives are supplied independently.

<a id="neighbors"></a>

## Intellectual neighbors and the developmental question

### Decomposition, genesis, and the relative point of view

The project's use of **Lautman** concerns both how a being is articulated and when an articulation becomes generative. Analytic or intrinsic decomposition seeks the determinations proper to something; synthetic or dimensional decomposition articulates it through a common organization. These are methodological resources for investigating a construction. The architectural commitment to unityped participants and differentiated documentation is specific to Hoapa; it is not a philosophical theorem assigning one pole exclusively to people and the other to artifacts. The passage through which an achievement becomes an enabling context is a separate problem, situated at the contextual correspondence.

**Simondon** contributes the question of individuation together with an associated milieu: what becomes definite, what tensions remain, and what conditions allow further development? A successful output need not exhaust its subject or eliminate its unresolved alternatives. Preserving replayable achievements and sustaining openness to new differences are related responsibilities. Causal saturation, terminal closure, and semantic gluing are useful precise notions, but none alone formalizes this account of individuation.

The **Grothendieckian** method makes the surrounding relationships carry the work. Families, changes of base, relative invariants, and universal properties can explain why a passage succeeds where an isolated calculation does not. Here this means asking what an interface represents for specified uses, how it behaves as the context changes, and what factors through it. An “optimal” organization would be characterized by such a property relative to hypotheses and a comparison class, rather than proclaimed universally best by a score.

The **universal-language** ambition belongs to this developmental picture. It includes the possibility of recognizing recurring construction patterns across distinct subjects, as well as admitting comparisons between presentations of one subject. Its success would include making the current language's inadequacies expressible. Stable words and reusable patterns must coexist with variation and revision. The references to Leibniz, Peirce, and more recent accounts of mathematical synthesis orient this ambition; they do not specify a completed language or its admission rules.

### Trust, accountability, risk, legitimacy, and Care

Trust can be investigated as a relation between a use and an interface: what is being relied on, under which conditions, and with what ways to check or repair the reliance? An enrichment might attach such data to arrows or transformations. A single scalar ranking of contributors would cross the participant/documentation boundary and would not express these dependencies adequately.

Accountability asks for traceable grounds and paths of response when something fails. Risk concerns exposure to particular failures under a declared model. Legitimacy concerns warranted authority or admissibility under the protocol and its interpretation. They can interact, but they need not share one mathematical type or combine into one number. The enrichment discussion is a candidate research direction, with its own typing and composition obligations.

Care has a precise formal foothold in session reciprocity and involutive duality. That foothold does not by itself prove an ethical theorem. The broader concern asks whether a passage preserves the differences, access conditions, and possibilities of continuation relevant to those involved. A publication that preserves answers while making every future use depend on its producer's renewed authorization can therefore fail an architectural purpose that an answer-equivalence test alone misses.

The historical anchors—Complexity, Evolution, Praxis, Anthropic loss, and Care—name connected questions around construction, requirements, situated work, loss, and reciprocity. The renewed conjecture must recover their interpretations with explicit carriers and laws. Their names cannot stand in for a chosen cost measure, a proof of development, or a universal notion of acceptable loss.

### Several meanings of forgetting

Many of the adapters simplify what they expose, but their omissions have different meanings. Restriction changes the local view. An underlying-object functor forgets declared structure. Public pseudonymization removes an identity linkage. A purpose-relative quotient identifies situations indistinguishable for selected uses. Truncation removes higher homotopical distinctions. A coarse observation can discard fine variation. Taking global sections changes which manifestations are visible. These operations do not become interchangeable because each can be described informally as forgetting.

For each one, the relevant question is what must survive and how to state that obligation. A family of controlled logical reducts can preserve different observations without selecting one lowest vocabulary for every use. Likewise, an observation that factors through a publication says nothing by itself about access, provenance, resource use, or behavior under a later transformation. Anthropic loss needs this specificity before it can be measured or used to compare architectures.

### Graphs, field theories, and arithmetic horizons

The field-theory and Esquisse directions ask whether interaction shapes, gluing, and their symmetries admit richer geometric realizations. A modular envelope can add contractions to cyclic composition; appropriate graphical structures may relate to moduli and, under further conditions, dessins and arithmetic symmetries. These possibilities explain why the operadic grammar is of interest beyond a software protocol.

They also impose distinct requirements. A closed dessin is not automatically a directed causal execution, and a cobordism analogy does not supply the needed dualizability or universal property. A finite symmetry such as A₅ can be a detection heuristic without becoming an architectural axiom. The useful next structure is the one forced by a concrete operation or obstruction, not the richest structure available in a neighboring theory.

### Sensitivity, realization, and continuation

The latest infinity/infinitesimal exploration places two methodological refusals beside one another: no contextual enclosure is declared ultimate, and no articulation into elementary constituents is declared final. These commitments permit provisional boundaries and stable interfaces. They do not prove that reality has no atoms, that every construction admits a nontrivial deformation, or that nilpotent infinitesimals are the unique mathematical model of a beginning.

Three responsibilities emerge. **Sensitivity** asks whether a relevant difference can register. **Realization** asks whether a proposed variation extends into an admissible construction. **Continuation** asks whether an achievement supports specified later activity. A detected variation can be obstructed; a realizable variation can damage future possibilities; a recorded obstruction can itself be a useful result. Their compatibility is the research subject, rather than three independent boxes to tick.

This brings the separation/integration mirror back to development. A boundary can make a beginning articulate, its relationships can sustain it, and its integration into a richer setting can disclose differences that were previously unavailable. Preserving established achievements is therefore insufficient if the organization becomes unable to encounter what those achievements cannot express. Equally, renewal need not mean acceleration or perpetual replacement: repair, rest, consolidation, and succession can sustain the conditions of inquiry.

Neither the absolute nor the infinitesimal is assigned to one of M and K. Neither separation nor integration belongs exclusively to one pole. The common question concerns situated work: how can an achieved determination become available for further determination without becoming its final limit? The internal separations keep that question architecturally meaningful; the adapters make particular passages accountable; the contextual conjecture asks when the resulting organization is adequate and generative.

<a id="sources"></a>

## Sources and provenance

This inventory reads the revisable workflows as the source of current commitments and the arcs as records of how those commitments were reached. Earlier assertions are not silently promoted over later corrections. The worked passage and the organization of this inventory are expository synthesis; the bit-publication counterexample is retained from arc 21. No new formal result or architectural decision is introduced here.

### Current working accounts

| Source | Principal contribution to this inventory |
|---|---|
| [Architecture](../architecture.md), especially “Three independent axes,” “Documentation and Λ,” and “Federation” | Levels, layers, adapters, participation, closure, publication, conceptual arrows, and local authority |
| [Motivation](../motivation.md), especially “The foundational conjecture” and “The cascade of trade-offs” | The renewed question and the explanatory layer cascade |
| [Naming](../naming.md), especially “Sides, correspondence, and comparison,” “Participant and publication vocabulary,” and “Architectural axes” | Distinct vocabularies and the status of their names |
| [The arc overview](../arc.md), especially “Return, replay, and mutual constitution” and “Inheritance and development” | The conjecture's present narrative and interpretation |
| [Formal status](../status_formal.md) | Scope of checked locality, reflector, R4, Chu/session, realization, and invariance results; remaining formal gates |
| [Implementation status](../status_implementation.md) | Recorder boundary, contract evidence, executable ownership, and verification scope |
| [Openings](../openings.md), especially “Concurrency-side layers of complexity (planned),” “Conceptual variation within Λ,” and “Local work and its enabling organization” | The longer horizons and the separation/integration interpretation |
| [Related structures](../related_structures.md), especially the [Lautman](../related_structures.md#lautman-decomposition) and [Simondon](../related_structures.md#simondon-individuation) entries | Philosophical interpretations, mathematical comparisons, and limits of proposed correspondences |
| [Targets](../targets.md) | Separation between formal targets, their interpretations, and comparison obligations |
| [Current track](../current_track.md) and [Future work](../future_work.md) | Live maturity and bounded obligations, used here to avoid turning planned interfaces into implemented behavior |
| [Bias correction](../bias_correction.md) | Load-bearing corrections against ranking people, premature global structure, and other rejected defaults; its modal-era work orders are superseded |

### Arc passages supporting the distinctions

The line locators below are for this snapshot; the accompanying phrases remain searchable if the files acquire additional material.

- [Arc 02: concurrency anchor](../arc/02_concurrency_anchor.md), line 246, “What I would really like to get from the site”: the demand that typed content and unityped actors remain independent responsibilities, leading to the Hybrid choice.
- [Arc 06: Hybrid](../arc/06_the_hybrid_as_a_door_to_field_theories.md), line 461, “Restriction Adapter,” and line 522, “Actor-side inclusion/subview”: the original internal adapter discussion and its variance.
- [Arc 07: self-modifying protocol](../arc/07_self-modifying_protocol.md), line 3, “Reader note,” and [arc 08: bulk type theory](../arc/08_bulk_type_theory_layer.md), line 5, “The protocol needs to be able to create its own language”: the reflexive and documentary responsibilities, read through the subsequent architectural corrections rather than the opening modal claims.
- [Arc 10: provenance and Audit](../arc/10_provenance_audit_layer.md), line 106, “The corrections,” line 167, “The two-faced reversibility,” and line 186, “Resolution”: derivational and temporal accountability, corrected against automatic reversibility.
- [Arc 11: Reality](../arc/11_reality.md), line 248, “Codex assessment of reality-as-a-concept”: the boundary and the limited significance of a Chu implementation.
- [Arc 14: trust and legitimacy](../arc/14_trust_and_legitimacy_as_enrichment.md), line 3, “Codex,” and line 476, “Claude”: the enrichment discussion and its review; its earlier cohesive identifications do not determine the renewed M.
- [Arc 17: Simondon and actors](../arc/17_simondon_and_actors.md), line 1142, “Codex's take on this,” line 2382, “harmonizing intended architecture,” and line 3200, “humans as the”: the distinction between human participants, represented work, documentary uptake, and conjectural interpretation.
- [Arc 18: evolutionary adjunction](../arc/18_evolutionary_adjunction.md), line 140, “Starting from K,” line 179, “Generation and description,” and line 577, “Return is weaker than replay”: the mirror, candidate contextual integrations, and the renewed adequacy problem.
- [Arc 19: project architecture](../arc/19_project_architecture.md), line 1330, “Discussion synthesis,” line 1368, “categories and interfaces,” line 1582, “Making available,” and line 1731, “Borrow–work–return–replay”: the corrected realization/nerve and free/underlying picture, open access, and its limits.
- [Arc 20: decompositions](../arc/20_on_decompositions.md), around line 810, “this decomposition stays,” followed by “Inside K the rigidity is a design commitment”: the instigator's insistence on preserving the engineered separation inside K while investigating its contextual passage.
- [Arc 21: infinitesimals](../arc/21_infinitesimals.md), line 2035, “Final conclusion by Astra,” line 2071, “Sensitivity, realization, and continuation,” and line 2327, “The separation/integration mirror”: responsiveness, limits of replay, and the latest reciprocal formulation.
- [Miscellaneous notes](../arc/xx_misc_notes.md), line 53, “Research genealogy,” and line 403, “Lautman's decompositions”: the genealogy of the foundational separation and the distinction between decomposition and genesis.

### Representative formal interfaces

These are entry points for checking the scope of the implementation claims, not a claim that one module proves the whole corresponding architectural interpretation:

- [Presheaf](../../formal/Concurrency/Hybrid/Presheaf.agda), [point sheaf adjunction](../../formal/Concurrency/Hybrid/PointSheafAdjunction.agda), and [point LNL adjunction](../../formal/Concurrency/Hybrid/PointLinearNonlinearAdjunction.agda): restriction, supported reflection, and the scoped R4 bridge.
- [Change of base](../../formal/Concurrency/Hybrid/ChangeOfBase.agda): change of coefficient category by postcomposition, with the frame index fixed. Despite the filename, this is not the unbuilt relative change of actor base needed by Tier B.
- [Session object model](../../formal/Concurrency/Algebras/SessionObjectModel.agda) and [session Chu model](../../formal/Concurrency/Algebras/SessionChuModel.agda): syntactic and coefficient semantics, with the operadic action and R8 bridge still separately accounted for.
- [Actor renaming](../../formal/RuntimeContract/ActorRenaming.agda) and [conversation-order comparison](../../formal/RuntimeContract/Realization/ConversationOrderComparison.agda): the raw invariance and causal-order distinctions used above.
