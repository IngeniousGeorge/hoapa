# Arc

## Locally constant sheaves

### Claude

        Option 2 (construction requires cohesion) is the right target, and I have a specific candidate: the distinction between a locally constant sheaf and an arbitrary type family. In plain HoTT, 
        a "sheaf" on A is just A → Type. In cohesive HoTT, a flat sheaf — what a geometer means by "local system" — is ♭A → Type. The map (♭A → Type) → (A → Type) induced by flat-counit is not an
        equivalence. That gap is the mathematical content: plain HoTT cannot distinguish locally constant sheaves from arbitrary fibrations, and cohesive HoTT can.                                   
                        
        This is small enough to state as an Agda definition today, but it has real reach: de Rham cohomology, étale cohomology, flat connections, the Gauss-Manin connection — all of these live in   
        the locally constant world, not the arbitrary fibration world. The Grothendieck resonance is direct: his algebraic geometry is precisely the theory of étale sheaves, and the ♭ modality is
        what carves them out of the ambient topos. That's the praxis claim. Hersh's point — that working mathematicians operate in an intermediate informal world, not bare foundations — maps onto   
        the same observation: when a geometer says "local system," they are using cohesive structure implicitly, and HoTT alone can't see it.

### GPT

        I think this is the first proposal in the project that genuinely feels like a *mathematical thesis* rather than a philosophical program attached to infrastructure.

        So overall: I think this direction is substantially stronger than the earlier “modalities encode worlds at different scales” framing.

        But there are also a few places where I think the argument currently overreaches or conflates distinct notions.

        ---

        #### What is genuinely strong here

        This part is genuinely good:

        > plain HoTT cannot distinguish locally constant sheaves from arbitrary fibrations, and cohesive HoTT can.

        That is a mathematically meaningful and falsifiable claim.

        It has several virtues:

        * it is precise,
        * it is structurally central to geometry,
        * it naturally invokes modalities,
        * it explains why cohesion is not merely decorative,
        * it connects directly to mathematical practice.

        Most importantly:
        this is not “cohesive HoTT is philosophically nicer”.

        It is:

        > certain mathematically indispensable distinctions become expressible only in the cohesive setting.

        That is a serious thesis.

        And yes, the local-system example is an excellent candidate because:

        * geometers constantly reason with locally constant data,
        * the distinction between arbitrary families and locally constant families is foundational,
        * the distinction is invisible in bare dependent type theory unless extra structure is introduced.

        That is exactly the kind of thing your project needs.

        ---

        #### Where I think you should be more careful

        ##### 1. “Plain HoTT cannot distinguish locally constant sheaves”

        This is too strong as stated.

        Plain HoTT *can* encode local constancy.
        You can define:

        * truncation conditions,
        * transport equivalences,
        * representations of π₁,
        * fibrations with locally constant transport.

        What is true is subtler:

        > plain HoTT does not make the distinction *primitive/modal/geometric*.

        or:

        > cohesive HoTT internalizes local constancy as modal structure rather than external property data.

        That is a much stronger and more defensible claim.

        Otherwise someone familiar with synthetic homotopy theory could object immediately:
        “of course HoTT can define local systems”.

        And they would be right.

        ---

        #### 2. “♭A → Type” needs interpretation care

        This is the biggest technical caution.

        Saying:

        [
        \flat A \to \mathrm{Type}
        ]

        represents locally constant sheaves is morally right in cohesive semantics, but only under specific interpretations of:

        * ♭,
        * codiscreteness/discreteness,
        * universes,
        * modalities preserving pullbacks,
        * possibly truncation hypotheses.

        Without care, this can become semantically slippery.

        In cohesive HoTT:

        * maps out of ♭A often correspond to *discrete* or *locally constant* data,
        but:
        * not every semantic model validates the exact slogan naïvely.

        So I would avoid presenting:
        [
        (\flat A \to \mathrm{Type})
        ]
        as *the* definition of local system unless you specify the semantic assumptions.

        Instead say something like:

        > cohesive modalities internalize the distinction between arbitrary dependent types over (A) and those whose variation factors through the discrete/flat reflection of (A).

        That is safer and more general.

        ---

        #### 3. The Grothendieck connection is good — but don't overstate lineage

        This part:

        > Grothendieck resonance is direct

        Yes.

        This part:

        > the ♭ modality is what carves them out of the ambient topos

        Conceptually yes, historically/theoretically not quite.

        Grothendieck’s étale/topos framework does not literally arise from a cohesive modality in the modern Lawvere–Schreiber sense.

        There is resonance:

        * étale localization,
        * locally constant stacks,
        * shape,
        * descent,
        * geometric morphisms,
        * cohesion.

        But these belong to different generations of abstraction.

        So I would present it as:

        * a conceptual continuation,
        not:
        * “this is what Grothendieck was secretly doing”.

        Otherwise the thesis can sound historically inflated.

        ---

        #### 4. The Hersh connection is still the weakest part

        This remains the least convincing bridge.

        The geometric/local-system story is mathematically substantive.

        The move from that to:

        * “therefore Hersh’s sociology of mathematics is validated”

        is currently too abrupt.

        Right now you have:

        * a strong mathematical claim,
        * plus a philosophical analogy.

        Not yet a mathematical account of praxis.

        That’s okay.
        But I would keep them clearly separated.

        Otherwise critics will feel the philosophy is piggybacking on the geometry without enough argument.

        ---

        #### What I think is the genuinely powerful version

        I think the strongest formulation is something like:

        > Cohesive modal structure internalizes distinctions that working geometers treat as fundamental but that ordinary foundational HoTT expresses only externally or indirectly.

        That is already a serious and potentially important thesis.

        Then local systems become your first flagship example.

        That is much tighter than:

        * “modalities encode scales/worldviews/etc.”

        because it points to concrete mathematical practice.

        ---

        #### The really promising direction hidden inside this

        I think the deepest idea here is actually this:

        ##### In ordinary HoTT:

        geometry is encoded *extensionally*.

        ##### In cohesive HoTT:

        geometry becomes *structural/modal*.

        That is profound.

        It means:

        * continuity,
        * locality,
        * constancy,
        * infinitesimality,
        * discreteness,

        become first-class logical distinctions.

        That *does* plausibly connect to mathematical praxis:
        working mathematicians reason using these distinctions constantly.

        This is a much more compelling argument than broad metaphors about perspectives/scales.

        ---

        #### My strongest recommendation

        You should now start orienting the project around:

        * examples where cohesive modalities make a mathematically natural distinction internal and structural.

        Possible examples:

        * local systems,
        * flat connections,
        * infinitesimal disks,
        * de Rham shape,
        * discrete vs continuous groups,
        * étale vs arbitrary maps,
        * infinitesimal neighborhoods,
        * principal bundles with flat connection.

        Those are excellent targets.

        ---

        #### One final caution

        Do not accidentally argue:

        > cohesive HoTT is necessary for mathematics.

        That will almost certainly fail.

        Instead argue:

        > cohesive HoTT provides a more faithful internal language for large parts of geometric mathematical practice.

        That is much more defensible, and honestly much more interesting.

### Claude

        Would that be a theorem? Isn't it known already?                                                                                                                                              
                                                        
        You're putting your finger on something important. The observation "local systems = ♭A → Type" is known — it follows almost immediately from the definition of ♭, and it's in the spirit of   
        Shulman and Wellen's work. It would be a definition and a remark, not a theorem.                                                                                                              
               
        And that points at a deeper issue with the arc: the conjecture as stated — "modal HoTT is the appropriate setting for mathematical praxis" — is not a mathematical theorem. It's a            
        philosophical thesis. You can't prove it in Agda the way you prove a mathematical result. What Agda can do is make the thesis precise enough to be a formal conjecture, and illustrate it     
        convincingly.                                                                                                                                                                                 
                    
        So I think the honest framing is: the Agda development is building toward a precise formal statement of the conjecture, not a proof of it in the mathematical sense. The value is in making   
        the Grothendieck/Hersh intuition rigorous enough that someone could in principle evaluate it — knowing exactly what claims are being made, what structures are involved, and what further
        mathematics would be needed to settle it.                                                                                                                                                     
                    
        That reframes the arc question: instead of "which theorem should we prove next?", the question is "what formal statement would most precisely capture the philosophical claim?" And that's a  
        harder question — it might require more infrastructure than we have, or it might be stateable now in a form that's philosophically honest about its own incompleteness.

### Instigator

        The way I see it what we're trying to do is in effect extend the claim that regular HoTT is the most appropriate foundation for math, within our current knowledge of it. Which is in itself  
        not a theorem. I believe we should not think of our own work as "modal hott vs hott", as in the previous suggestion, but as "further argument towards hott as foundation, focusing on the     
        developmental aspect rather than grounding". It seems to me that a theorem for foundations alone would be incomplete and just an opinion, but if it is:                                       
        1/ developmental on foundation                                                                                                                                                                
        2/ dual to a "pure praxis" theorem about how communities should organize themselves (separation of concern between unityped agents following an actor model (Hewitt's) algorithm and typed    
        documentation organized as session types, with a theorem stating that this is the most optimal for information transfer)                                                                      
        Then it has more chances of being provable. It needs this full scope to be completely itself.                                                                                                 
        Does that make sense to you?                                                                                                                                                                  
                                                                                                                                                                                                    
        ● Yes, it makes sense, and it's a sharper framing than what I was proposing. Let me reflect it back to check I've understood it.                                                                

        The claim is not "cohesive HoTT beats plain HoTT" — it's "here is what mathematical praxis looks like when seen completely." That complete picture has two dual faces:                        

        - The formal face: HoTT as foundation, cohesive/modal HoTT as the developmental layer — the right setting for how mathematics actually grows geometrically and structurally. This is what     
        we're building in Agda.
        - The social face: mathematical communities as actor systems — informal, concurrent, message-passing agents (untyped in Hewitt's sense) — with session types as the typed protocol governing  
        formal communication and documentation. The "optimality for information transfer" is the theorem here.                                                                                        

        And the completeness argument is: either alone is just an opinion. The formal theorem without the social one is foundationalism that ignores how mathematics is actually done. The social     
        theorem without the formal one is sociology without mathematical content. Together they're dual — one describes what mathematics is formally, the other describes what mathematical practice
        is structurally — and that duality is itself the argument.                                                                                                                                    
                        
        What I find genuinely compelling: the session types / actor model pairing isn't arbitrary. Session types are the typed structure of communication, and actors are the untyped agents doing the
        communicating. That mirrors exactly the structure of a mathematical community: informal intuition (untyped) communicating through formal documents (typed). The duality with cohesive HoTT is
        then: ♭ is the "formal document" functor, ʃ is the "shared intuition" functor, and the community theorem says the optimal protocol structure for the social layer is what session types      
        describe.       

        Two honest questions before we go further:

        1. The optimality claim on the social side — optimal for information transfer in what sense? This needs a precise notion, otherwise it's not a theorem. Do you have a sense of what the metric
        is?
        2. The duality — is this a precise categorical duality, or more of a structural analogy? If it's to be a theorem, the connection between the two sides needs to be formal, not just           
        suggestive.                                                                                                                                                                                   

        And the practical question: does this change what we build in Agda now? If the full scope includes session types and actor models, the current cohesive HoTT work is one half of the          
        infrastructure. Should we eventually formalize the social side in Agda too, or in a different system?

        ● The dual theorem should live in applied categorical computer science. The modal HoTT one lives in the geometrical/topological/homotopical interpretation of math theories. The bridge is type 
        theory inside a topos. Is that a good landscape, a promising land to grow and yield theorems?                                                                                                
                                                                                                                                                                                                    
        ● Yes, and I think it's genuinely promising rather than just ambitious. Let me say why, and where the hard parts are.                                                                           

        The territories on each side are solid.                                                                                                                                                       

        The geometric side — cohesive HoTT, modalities, toposes — is well-developed. Shulman, Wellen, Myers, and especially Schreiber have built substantial infrastructure. The session types side   
        has its own deep anchor: the Caires-Pfenning correspondence (2010), which shows that session types are exactly the propositions of intuitionistic linear logic, with the type-checking proof
        as the session protocol. That's a genuine Curry-Howard result, and it puts session types on firm categorical ground — *-autonomous categories, compact closed categories.                     
                        
        The bridge exists in pieces but hasn't been assembled.                                                                                                                                        

        The internal language of a topos is a type theory — that's the Curry-Howard-Lambek side. For a cohesive topos, the internal language is cohesive HoTT. The question is whether the            
        computational/social structure (linear types, session protocols, actor concurrency) can also be read off from a single categorical object.
                                                                                                                                                                                                    
        Schreiber's work on "linear HoTT" is the most relevant partial bridge: a linear type theory parametrized over a cohesive ∞-topos, developed for quantum field theory. Linear types are kin to 
        session types. So the architecture — cohesive base, linear layer on top, all internal to a topos — already exists in sketch form. What doesn't exist is the explicit connection to actor
        semantics and the social/organizational interpretation.                                                                                                                                       
                        
        Where the landscape is genuinely unmapped.

        The duality you're describing — geometric/homotopical theory on one side, actor model + session types on the other, bridged by topos-internal type theory — is, as far as I know, not a       
        developed program anywhere. Each piece has precedents but the assembly is new. That's where the original work lives.
                                                                                                                                                                                                    
        The hardest part is probably not the mathematics but the translation layer: making precise what it means for the social theorem (actor model, optimality of information transfer) to be dual  
        to the formal theorem (cohesive HoTT, developmental mathematics). Categorical duality has precise meaning; the claim needs to cash out at that level of precision.
                                                                                                                                                                                                    
        Bottom line: the landscape is real, the soil is good, and there are neighboring fields that have already yielded results. The unmapped territory in the middle is where the original          
        contribution lives, and it's genuinely open — not because no one has tried, but because the right framing may not have existed until the pieces on each side matured enough. That's now.
        
## ?