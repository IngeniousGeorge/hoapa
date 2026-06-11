# Motivation for the arc

*This file has two sections. The first is the philosophical seed for the project; the second is the engineering register of the same content. The two voices coexist deliberately; the trajectory by which the framework moved from one to the other is in `origins.md`. `arc.md`, `targets.md`, and `related_structures.md` all grow from this file; re-read it when the formalism starts to feel self-contained — the math we're building is a subsystem of the broader picture, not its totality.*

## The foundational conjecture

That modalities (perspectivalism encoded in HoTT) allows complexity to develop is trivial in abstract math [ModalHoTT]

That typed data is more robust, readable, literate... is trivial in any domain concerned with information transfer, such as programming (HoTT says in homotopic math as well) [SessionValues]

That unityped agents are most adapted to handle complexity is trivial in concurrency theory¹ (a lesson of the Yoneda lemma, visible in the notion of comonads/coalgebras?) [ActorBase]

The result we're targeting should show (encoded in category theory): 
If:
- SessionValues and ActorBase follow separation of concern (independence, in the sense of modularity/clean code)
- ModalHoTT and SessionValues-ActorBase are in a requires-allows adjunction.
    codependency: 
    - perspectives require (the optimality) typed data handled by unityped (or "univocal" in spinozism) agents
    - persepctives allow typed data to be handled by unityped agents
    - the separation of concern between data and agents (more precisely, the optimality of the system, secured by that separation) requires perspectivalism (a modal network)
    - it allows it
Then: 
Philosophically: the category which hosts this structure is capable of ? (World understanding and world creation)
Mathematically: something about covers/coverings, recursion, a form of contribution to a developing infinite network...

Current first checked fragment: on the operational side, the project now has a point-generated sheafification reflector and a sheaf-level Benton/LNL adjunction over the supported event-discrete actor-causal site. This is not yet the cross-site `Allow ⊣ Require` adjunction; it is the first modest B-internal theorem that makes one side of that future adjunction concrete.

The last item is the mathematical fragment, interesting for its own sake in mathematics, of a foundational statement in the space of interdisciplinary theories.

¹: and it is the basis of the actor model (and only in this relatively new domain because it is in friction with a foundational assumption of modernity, that complexity is based on specialisation)

## The cascade of trade-offs: a praxis response to structural problems

The framework is, read operationally, a sequence of engineering trade-offs that the foundational commitments generate, together with the strategies that resolve them. The cascade is *generative*: each resolution opens the next problem. The strategy applied at every step is the same shape — separation of concerns. The full layer-by-layer catalogue is in `future_work.md`; what follows is the compact picture.

| Layer | Trade-off it navigates | Strategy |
|---|---|---|
| **Hybrid** | Locality (actors operate in frames) vs globality (content must cohere across frames) | Sheaf descent: compatible local content glues to global |
| **Reflexive (Π)** | Stability (the protocol must be reliable) vs adaptability (it must respond to change) | Meta-conversations propose, consensus ratifies, non-retroactivity protects the past |
| **Bulk (Λ)** | Expressive power (rich vocabulary) vs transparency (decodable by every participant) | Protocol generates its own language; the reflexive layer maintains its transparency over time |
| **Field-theoretic dynamics** | Exploration (proposal storm, high entropy) vs exploitation (stable mature language, low entropy) | RG flow with reflexive insertions; symmetry-breaking → fluctuation → stabilization phases |
| **Federation** | Coherence within one protocol vs plurality across protocols | Typed translation interfaces, partial clones, conflict-as-data |
| **Information cohomology** | Dense encoding (expert-economized) vs accessible encoding (decodable by the unityped receiver population) | Receiver-relative measurement of encoding cost; transparency taken as an engineering -ility on the same footing as performance and security |

The cascade is not a list of features added by choice. It is the sequence of problems the foundational commitments create, with each layer being the structural response to the problem the previous layer's resolution exposed. Hybrid's locality-vs-globality only becomes a problem because we committed to actors and sessions as separate legs. Reflexive's stability-vs-adaptability only becomes a problem because Hybrid gave us a maintainable artifact. Bulk's expressivity-vs-transparency only becomes a problem because Reflexive gave us a self-editing protocol that must now talk about things. Field-theoretic dynamics' exploration-vs-exploitation only becomes a problem because Bulk gave us a language that must evolve well. Federation's coherence-vs-plurality only becomes a problem because the four previous layers gave us a complete protocol that, in isolation, would re-create the one-true-framework failure the project was built to dissolve. Information cohomology's dense-vs-accessible encoding becomes salient as soon as Bulk produces a language, and acute as soon as Federation puts that language in front of multiple receiver populations.

The strategy is uniform across the cascade. Every trade-off is resolved by separating the two concerns that are in tension, giving each its own categorical home, and providing the precise interface between them. Locality and content are separated by the sheaf; current protocol and its edits are separated by Π; how and what are separated by the session/content split; content and dynamics are separated by the factorization-algebra-plus-RG-flow; interior and exterior of a protocol are separated by the meta-topos; content and its measurement are separated by the (co)homology pairing. The foundational commitments themselves — actor-vs-content on B, spatial-vs-discrete on A (cohesion), context-vs-system at the cross-site adjunction — are the same architectural move at the foundational floor.

So separation of concerns is not an engineering principle the framework happens to use. It is the framework's primitive architectural move, applied recursively from the foundations upward, and the cascade of trade-offs is what makes that recursion necessary. The transparency-of-language trade-off (information cohomology) belongs on this list on the same footing as the others — not relegated to "measurement" — because it is the encoding question the unityped commitment forces on the engineer: *how is the unityped receiver going to understand the message?* That question is no less an engineering -ility than performance, security, or maintainability. It is just not currently on the engineer's radar, because the economy of expertise prefers density to transparency. The framework's commitment is to put it there.