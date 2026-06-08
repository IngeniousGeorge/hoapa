# Hoapa protocols as the "pure form" of communication systems

## Scope

The Hoapa project is composed of several layers:

- a communication system (written in Elixir, a programming language optimized for concurrency)
- a model verifier which checks the mathematical properties of the system (written in Agda, a programming language that can check mathematical proofs)
- a pedagogical explanation of what each code-base accomplishes and how
- a documentation of what it is in theory (/communication) and how it develops in practice (/workflow)

The project belongs to a broad category of "informational architectures" which has been studied by disciplines such as:  
(Here from the most holistic to the most mechanistic)  

- Cybernetics/systems theory
- Collective intelligence
- Protocol studies
- Semiotics
- Network science
- Concurrency (in computer science)
- Information theory

Our framework assumes the point of view of yet another: Applied Category Theory. Where category theory is the most abstract branch of mathematics, the study of how things relate, regardless of what they are. It asks: "What patterns of connection, transformation, and composition appear everywhere?" Applied Category Theory (ACT) takes those formal patterns and uses them to:

- Design better communication systems (with guarantees about their behavior)
- Model complex interactions compositionally—building up systems from verified pieces
- Translate between these different disciplines—so insights from one domain can inform another
- Predict emergent properties before implementation

Which more or less mirrors the four layers of our project: the system, its verification, its explanation and its working documentation.

Examples of Hoapa's relatives include:
The internet, the universal postal union, supply-chain logistics networks, road signaling systems, a distributed computing system, the genetic code, the vast underground fungal forest network, a flock of starlings in murmurations, nervous systems, immune systems, wikipedia, social media, citizen assemblies, the scientific method, a conversation…

## Synopsis

### Objective

The main objective of this project is to demonstrate the optimality of Hoapa protocols. We do so by leveraging the universality and expressiveness of category theory to recognize it as a distinguished element in its domain.

Category theory is made out of categories, which are like webs of family relations (morphisms) between similar enough things (objects). The existence of a "new" category is often revealed by a bridge (adjunction) between two "prior" categories, and this bridge also identifies certain objects as being the "original incarnation" of the family members (initial object), their "final incarnation" (terminal object), or their "default incarnation" (free object).

This is the story we're trying to tell here: there is a "pure form" of communication architecture whose social, engineering or scientific characteristics reflect its advantageous mathematical properties.

This can be used practically in two ways:

- The optimality to organize collective work
- The "naturality" to start it uncontroversially

Just like many games and sports start at the center of the field of play, Hoapa can be the center from which productive communication starts. (The fact that Hoapa protocols are absolutely decentralized, autonomous and capable of self-modifications to adapt to their context makes them all the more suitable for the role.)

### Construction

The two categories our bridge will connect are:

**Op:** The operational structure of Hoapa networks
**Ct:** The context in which they are optimal

The operational side **Op** is an intricate construction because it must navigate several trade-offs to ensure optimality and obtain decentralization, autonomy, openness to peers, expressiveness, transparency, scalability or self-reflection. But all of them are answered with the same strategy: separation of concerns. And they all descend from an original separation which encapsulates the entire system, between:

- a community of *unityped* communicating agents,
- and layers of *typed* documentation their communication produces.

This has a precise meaning in computer science, which is more or less the double specification that:

- All participants must "play by the same rules" (like basketball players, and unlike goal keepers vs fields players in sports with goals), meaning the communication system can never distinguish between them. To the system, participants are computational resources, and whenever it needs resources, it taps into its reserves at random. Importantly, this should not be interpreted as "the system wants all participants to be the same", on the contrary, the whole point of this is to welcome diversity.
- Whatever the participants produce, it should be put in meaningful containers and properly labelled. And here, contrary to the participants who are all of the same type, the multiplicity of types is the crucial mechanism through which the system copes with complexity.

At the integrated level, the context **Ct** becomes the recognition that the world is profoundly perspectival: all assertions must be evaluated as points of view, never from a supposedly neutral or absolute standpoint.

The bridge is then the statement that the generative complexity emerging from such perspectival contexts is what **allows** concurrent architectures like Hoapa to **unfold**, while the operational layer of Hoapa is what is **required** by this context to **persist**. (Where the context is represented by the organization of a community of agents living in this context, or how we can view an ecosystem as a network of relations between organisms.)

Perspectivism is represented mathematically in our framework by *(modal) homotopy type theory*. To its advocates, it's the best foundations we have for the whole of mathematics at the moment. It is in particular much more capable of reasoning about relations and equality, while the long established *set theory*, to which it is an extension, focuses on objects viewed in isolation.

The bridge is still conjectural at this point. But while building for it, we've extracted a first theorem which can be interpreted as "there are no privileged points of view on the operational side of our construction".

---

## ToC

Context for more info
Extended abstract for where we are in the math
Aims and Potential Impact
Repository folder structure

---

## Context



## Place in current research

The acknowledgment and proper study of systems like Hoapa has been inhibited by deeply ingrained assumptions about how much harmony can be expected of free humans, what efficiency is, or the role of hierarchies in Nature. Domains that, interestingly, often use "lower order" mathematics to "prove" their assertions. 

In our framework, "higher order" mathematics serves as a counterargument against those: from an interdisciplinary and integrated perspective, Hoapa-as-solution becomes both apparent and accessible. As a communication architecture, the department-based and overspecialization-imposing university is not just ill-adapted to . The tech-envy influences of capitalism do little to help the situation.

Hoapa has relatives in many disciplines:

- The homotopy presentation of field theories in physics
- The extended evolutionary synthesis or relational biology in life sciences
- The study of African Egalitarianism or the view of the Paleolithic period as predominantly collaborative in anthropology
- 
- Category and topos theory in mathematics

All of them exist in research communities as disadvantaged undercurrents completely relying on the passion of the scholars who believe in them. Their unification at the interdisciplinary level is simply unattainable in the current academic context.

-> academic Recognition is the first step, it needs legitimacy, to become more than play (stakes are needed to demand work).

---

motivation -> adjunction

"pure form" -> free/initial object (the center of the circle analogy -- two advantages: it is efficient, despite unwarranted assumptions revealed as false by citizen assemblies, it is not arbitrary and can be used as the base-context for any collective endeavour--and because it evolves autonomously, it can then adapt to its particular context as it matures)

implementation (in Elixir, for which the Agda code is a verification layer)

