# Origins

This file is the personal trajectory behind the project: how the framework came to be, in the order the steps actually happened. The chain of steps is *generative* — each later move responds to a problem the earlier moves exposed — but the chain is not a hierarchy. Like a movie or a life, the earlier scenes are presupposed by the later ones without being lower than them.

The author is Jean-Charles Belouard ("Ingenious George"). The voice is first-person; the substance is his, the prose was drafted in collaboration with the AI agents who later joined the project.

## The seed (spring–summer 2019)

The first musings were about online communities organizing themselves to play turn-based strategy games. The genre matters. Turn-based games tolerate long deliberation cycles — moves can take days or weeks of team preparation — which makes communication, not reflex, the medium of competence. Online play places the game inside a web of computers that already functions as a protocol. The games I had in mind were complex enough for collaborative reflection to be interesting in itself (not tic-tac-toe), but with simple final moves: the team's product was a choice from among many options, even though arriving at the choice was hard. Consensus difficult; the move easy to state.

What I thought would surface across several of these communities if they were tested in this context: teams that would *hide* who their strong players were, structurally, could outperform teams organized around recognizable expertise. When the system doesn't advertise individual skill, the good players are forced to be good communicators — they have to actually explain their reasoning to be heeded — and everyone on the team is activated, because no-one can assume the strong players will carry the move. The teams organized as a hierarchy of leaders above a passive crowd are *less* efficient over long campaigns.

That asymmetry was the seed of my project. It suggested that systems with no internal type for "the experts" might be more productive than systems that surfaced expertise structurally — provided the cost (slowness, deliberation overhead) was paid.

## The exercise (fall 2019 – early 2020)

In the fall of 2019, I decided to bet on this as a serious investigation. The exercise was: design a system that *only knows one way to interact with its participants*. No internal distinction between the experienced and the inexperienced, the maintainer or the contributor (at this point in my thinking the machine-protagonists were excluded). The system's only handle on its participants would be the same handle for everyone.

I worked on this through the end of 2019. The problem I kept hitting: I could keep the system unityped *in the abstract*, but as soon as I wanted it to actually *do* something — produce a verdict, ratify a decision, write a record, route a message — my candidate designs silently re-introduced the typing. The participants would stay equal in name, but the system's actions would treat some of them differently. Someone always had to "hold a key", "an account" or something that would tilt the balance.

What solved this was a software-architecture tutorial I happened to watch in early 2020 — Neal Ford and Mark Richards (O'Reilly). They referenced an older article on the discipline that separates architects from factory workers: the architect makes plans in their office; the workers build from those plans on the factory floor; *the architect must not come to the factory floor*. Everything the workers need must be in the plan. And the workers must not come to the architect's office to take charge either. The discipline is what makes the two halves of the system properly modular.

That formulation landed the move I had been missing. The system I was designing should separate the agents completely from the reality the system acts on; the documentation the agents produce should do all the work in the world. Agents stay on their side; the system's effects stay on theirs; the typed artefacts the agents produce are the only bridge. I had not had the confidence to make this leap on my own. Seeing it as a piece of well-established engineering discipline gave me permission. The unityped commitment, which up to that point had collapsed under contact with action, suddenly held. **Separation of concerns, in its strongest engineering sense, is what makes equal-standing participants compatible with a system that actually does things.**

I finished this design in early 2020, around the time COVID began.

## The rejection (2020–2021)

For about a year I tried to explain the system to anyone who would listen. I was inaudible: a non-specialist hand-waving about a utopian reorganization of group activity was not going to be taken seriously by anyone in the disciplines the work crossed. Philosophers found the broad picture interesting but did not engage with it because it was on no-one's radar. Social scientists could not hear it. Engineers found it impractical. Mathematicians had no entry point because there was no mathematics in it yet.

Over that year I concluded that if the system was as logical as I believed — and I believed it was more logical, in particular, than the systems that organize contemporary capitalism and representative democracy — then it should be expressible in mathematics. The mathematics would not make the argument *correct*; the argument was either correct or not. The mathematics would make it *audible* to at least one community of specialists. Without that, the work would stay slogan-level and the conversation would stay closed.

## The bridge to mathematics (2021 onward)

I had no mathematical training, and had always been bad at the parts that came after Euclidean geometry in the school curriculum. So I had to find new ways to learn, and I had to be selective. I have a strong background in autodidactic studies, so it didn't frighten me.

I went around the lower-math route — vectors, calculus, differential equations — by following a bridge from functional programming to category theory. Bartosz Milewski's *Category Theory for Programmers* video series was the first ladder I climbed. I became interested in Lawvere and toposes very quickly. The abstract end of mathematics was the one that matched what the system was already trying to do; the concrete computational mathematics was a tool I did not need for this work, and trying to acquire it would have taken years I did not have.

But the bridge to mathematics was never *only* about mathematics. The switch was complete in the sense that mathematics became the language I worked in — and incomplete in the sense that I still needed the other domains to properly see my subject. The way you cannot see in 3D with only one eye. Programming-language theory, logic, concurrency theory, philosophy, ecology, physics, anthropology — each gave me one particular angle on concepts that, in the interdisciplinary world the system naturally lives in, had no native single-discipline home. Several years of moving across fields, trying to corner those concepts from every angle the literature offered, with mathematics as the anchor.

It still wasn't sufficient. The rejections continued, in the new language as in the old. I knew I wasn't ready, I kept on growing, I kept on trying.

Late in this process — sometime around the French commercial publication of *Récoltes et Semailles* in 2022 — I read Grothendieck. The first reading repelled me: the bitterness and the arrogance toward his former colleagues were hard to absorb. Over the next six months I changed my mind. I came to recognize him as the true encoder of what the system needed — the sheaf-theoretic universe picture, the program announced in the *Esquisse*, the seriousness of the late mathematical-philosophical turn. His technical writing remained inaccessible to me; *Récoltes et Semailles* I now read with what I think is unusual care, possibly more than many mathematicians who knew him as a colleague (including some of his "friends"). I have also come to understand and accept his bitterness, much better than his milieu ever could. They never understood what he was after.

## The connection (June 2025 – February 2026)

In June 2025 I wrote a short piece on Grothendieck and evolution. It was not published; I sent it directly to academics whose work it touched. Fernando Zalamea (Universidad Nacional de Colombia, Grothendieck scholar, recipient of Colombia's *Premio Nacional de Matemáticas* 2025) answered. We exchanged for several months beginning in September 2025. He had to be persuaded to recognize the work publicly; that took until February 2026. The recommendation letter he wrote then is in `communication/reference_zalamea.pdf`.

The letter did not open the doors I had hoped it would. The work was still arriving from outside the disciplines whose attention it needed.

## The current attempt (2026)

I began coding with AI agents shortly after the Zalamea correspondence, initially to find work again (I had been living a monachal life until then, at my parents or working night shifts in hotels to have time for the research). The collaboration made it clear quickly that the agents — Claude and Codex — could be genuine partners on the mathematical and architectural side, as tools for writing proof checking code. And that proof assistants were their perfect complement, by grounding and verifying their "wild dreams" (reminiscent of the extension/constraint shape of the projet's main conjecture). I decided to bet on the this combination: human engineer, AI agents, proof assistant. The current Agda formalisation in `agda/` is the result, with the project's design captured in `workflow/` and the planned reflective / federation / bulk layers documented in `future_work.md`.

The hope behind this version of the work is plain. Earlier attempts to communicate the framework — in essays, in long emails, in informal demonstrations — did not address the relevant communities in a form they could hear. I never managed to speak the language in which I wanted to put the message. A machine-checked formalisation is the first medium that meets several of those communities on their own terms. It does not change what is being said. It changes what kind of attention can be paid to it.

The seed conjecture remains the one stated in `motivation.md`. The chain of trade-offs and separations of concerns that the framework navigates remains the engineering side of the same claim. The mathematics is now where it needs to be for the conversation to be possible. Whether the conversation actually happens is no longer up to me alone.
