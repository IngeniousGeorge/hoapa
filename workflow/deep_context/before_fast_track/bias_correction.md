# Bias Correction

## Why this file exists — *negative anchoring*

This file is not a historical chat log. Its job is to forestall the default-LLM mis-readings of this project — the framings a fresh agent will reach for out of habit, but which the instigator has explicitly rejected. Read it as **corrections-against-assumptions**.

Defaults this file rules out, in particular:

- "The project is *modal HoTT vs HoTT*." — Rejected. The framing is *modal HoTT as extending HoTT-as-foundation along the developmental axis*. See "On the structural conjecture".
- "The site is the circle / S¹." — Rejected. The site is the delooping of ℤ. The algebraic structure (subgroup inclusions, comonad story, Lawvere on ℤ) is what's load-bearing, not the topology. See "Goal & first step" + "Precisions".
- "The concurrency / 3-marked-points leg is decorative." — Rejected. It is a co-equal conjecture (community-of-agents, actor model + session types); the full scope is what makes the math conjecture provable rather than opinion. See "On 3 marked points" + "On the structural conjecture".
- "The synthetic side alone is enough." — Rejected. The analytic two-track exists because both instigator and agent need machine-checked grounding during development, and the eventual presentation can't rest on postulates alone. See "3 roles".

If you find yourself drifting toward one of these defaults, that is the moment to re-read the corresponding instigator prompt below.

---

### Instigator - 3 roles

We are a trio, me the human instigator, you the LLM agent and it the proof checker. I'm not a recognized  
mathematician, and neither are you, but the proof checker is. When we present our result, we can't rely on a bunch of postulates, we need to have proof checked data, to be taken seriously.  
And also during the developement phase of our work, you and I both need the checking capability of Agda to make sure we're not confidently walking on thin ice and into false statements.     
Now, I agree the synthetic approach is what we want ideally, and eventually how we want to present our result to the community that will be interested in it, because that they're prefered   
approach also, for good reasons. But I believe we should have, maybe in parallel, a more grounded, with step-by-step verification, version of our construction and claims. I'm thinking we    
should actually have two folders inside of /agda, /synthetic and /analytic. /synthetic is what we have been doing so far, and how you suggest we tackle the fracture result. But we should    
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

Synthetic/axiomatic — postulate the cohesion modalities (shape ʃ, flat ♭, sharp ♯) as axioms and develop modal HoTT from there. This is how Wellen, Myers, and Shulman have actually worked in Agda/Coq. The site never appears as a Agda object — it lives in the semantic background justifying the axioms. ... agda/ModalHoTT/Modalities/ is the right starting point, with the cohesion modalities postulated as axioms. That's the first real Agda file — something like Cohesion.agda postulating shape, flat, and sharp with their units and the key adjunctions. Keeping in mind that Bℤ is the intended semantic model for the axioms.

### Instigator

Pure inspiration:  there are too many items on that list of concurrency models, and it's something we don't understand well and have many assumptions about (why did it emerge so long after sequential computation, we must be wrong about it in an essential way), so maybe there's a unique object that give us many different interfaces but if we do what's right and listen carefully we can get to the unique object (the story of motives).

## Useful prompts

### After clear

Next is open:
Please have a look at the files in workflow and tell me where you want to go next. Either with the next step as planned or if you feel something must be corrected/added.

Next is set:
Please have a look at the files in workflow and make sure you understand the next step. Don't hesitate to tell me if you feel something must be corrected/added.