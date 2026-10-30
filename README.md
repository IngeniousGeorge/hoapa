# Hoapa

### Pitch

The core of my research consists in drawing inspiration from the philosophy of mathematics and the engineering of networks to formulate a theory of work constrained by "permacultural" logic: how to produce reusable results while preserving the conditions for future work. Applied to collectives, it becomes an extension of the scientific method which incorporates participatory democracy and sustainability.

### Sources

The authors it draws on are mathematicians (F.W. Lawvere, A. Grothendieck), philosophers (C.S. Peirce, G. Simondon, G. Deleuze), and scientists (S. Kauffman, J. Bowlby). In my project, these approaches meet in Albert Lautman’s philosophy of mathematics, as read by Fernando Zalamea (who has been supporting my work).

### Thesis

My main thesis states that in a system that puts the dialectic between concrete and abstract to work (brain, computer, community), the relation between concrete substrate and logical labour must be a resource entirely dedicated to the design and application of representations and algorithms. A form of separation between two kinds of decomposition—analytic (as in prime factorization) and synthetic (as in vector coordinates relative to a basis)—is a guiding principle, informed by Lautman, which can keep this relation fruitful: in a community, between thinkers and the knowledge they produce.

### Project

Hoapa is an open project in mathematics, software, and the design of collective inquiry. I set its direction, develop its questions, and decide which proposals to pursue. AI agents help explore mathematical connections, compare approaches, and write and review code and documentation. Cubical Agda checks that the formalized constructions fit together under explicit definitions and assumptions, allowing new work to build on results already established.

### Process

Hoapa is designed as a network of small conversations in which one group's work becomes another group's starting point. A question brings participants together; their discussion produces a document that others can examine, challenge, or develop. These documents form a growing map of questions, concepts, arguments, and dependencies: a knowledge graph. So that contributions can differ and come unforced, the system gives participants control and equal standing (they all play by the same rules). Knowledge acquires structure independently of the structure of its producers, be it social, political, economic…

### Verification

The communication protocols specify how these conversations proceed and how their results enter the shared documentation. Software is used as a referee and is itself subject to modification by the conversations. Alongside the conversation process, a mathematical verification layer is being developed in cubical Agda, a language in which proofs can be checked by a computer. One existing result establishes that consistently renaming participants cannot change the checker's verdict. The broader aim is to make the system's promises precise enough to test and prove.

### Conjecture

These constructions extend into a mathematical conjecture which concerns how such an organization fits the world it investigates. Every inquiry begins somewhere. Its questions, instruments, and concepts shape what it can recognize as an object, a problem, or an explanation. Hoapa calls this perspectivism. The challenge is to produce knowledge that other perspectives can use while leaving room for what the original inquiry missed. The project seeks a mathematical correspondence—an adjunction—between what some contexts make possible and what an organized practice requires of them. It also asks whether Hoapa's organization can be distinguished from alternatives by its capacity to turn situated work into resources for further inquiry.

### Theory of work

The physical starting point is that work depends on constraints that channel energy into particular effects. In living systems, activity also helps maintain the machinery that makes further activity possible. Abstract representations and algorithms enable a system to retain and share experience, discover relations, construct and test possibilities, revise its own means of understanding and action, and turn results into conditions for further work. This makes the relation between concrete conditions and abstract operations a powerful resource. Lautman supplies a way to investigate such relations through the mathematical and physical constructions that give them substance; Simondon, Peirce, and Kauffman help connect the question to living beings, their environments, and their practices of understanding. Hoapa's proposed separation between thinkers and the organization of knowledge is an engineering approach to developing this potential.

### Permacultural logic

The project also looks for this pattern inside logic, where "permaculture" is understood broadly as the two-step process of (1) getting to know one's context as much as possible, (2) acting minimally in a manner that will enhance one's condition while preserving and enriching the context. A proof may begin with a provisional assumption (borrow), derive a conclusion (work), and turn the derivation into a conditional statement that later proofs can use (replay). What began as work under particular conditions becomes a reusable achievement. Hoapa investigates this borrow–work–replay pattern as a possible logical expression of its permacultural ambition: the harmony between receiving and giving back.

### Experiment

Autonomous open-science workshops could make these ideas tangible and seed larger systems. Participants would investigate questions they care about, compare evidence, construct explanations, and leave documents another workshop could take up. Unresolved disagreements and failed attempts would remain available alongside successful results. The workshops would also test the organization itself: whether it helps people think together, produces knowledge worth reusing, makes it usable across different vocabularies, and sustains people's capacity to continue.

### Repository

[The repository](https://codeberg.org/doc2cog/hoapa) is hosted on Codeberg.

- [formal/](formal/): the mathematical verification layer, in cubical Agda
- [runtime/](runtime/): the software, in Elixir
- [communication/](communication/): documents presenting the project
- [pedagogy/](pedagogy/): walkthroughs of the formal code
- [workflow/](workflow/): the working records that ground and track the project, used by its AI agents

### Documents

- [Extended abstract: "A linear/non-linear adjunction of sheaves…"](communication/linear_nonlinear_adjunction_abstract.pdf): for mathematicians, the first, deliberately modest theorem of the framework, fully machine-checked in cubical Agda
- [Letter of recommendation from Fernando Zalamea](communication/reference_zalamea.pdf): a mathematician and philosopher, leading expert on the work of Alexander Grothendieck and Charles S. Peirce
- [Article: "An Introduction to Grothendieck's General Theory of Evolution"](communication/general_evolution.pdf): for exact and natural scientists, about the dynamics our universe keeps on repeating, a sort of Hoapa-informed version of Philip Anderson's "More is Different"
- [Article: "Univocal Science — From Spinoza to Grothendieck"](communication/univocal_science.pdf): for philosophers and philosophers of mathematics, the seed of the conjectured bridge
- [Manifesto: "Liberation engineering for resistance networks"](communication/liberation_engineering.pdf): for social scientists, a diagnosis of institutional hierarchy as a "virus" in humanity's world-describing systems
- <a id="31-a-park"></a>[Earlier presentation: "Hoapa protocols as the pure form of communication systems"](communication/presentation_with_preliminary.pdf) (June 2026): the previous version of this page, with its use cases; the park example cited in older project notes is its §5.1
