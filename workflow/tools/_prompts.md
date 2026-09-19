# Prompts

## Onboarding

### Short (runtime)

Please read all top level files in the workflow folder.
Our working methodology is as follows: 
1. In general we want all our code to follow well established design principles and be clean and modular. For the implementation code we use the methodology of test driven development.
2. Me, the human instigator, and two agents, Claude and Codex, are going to discuss and plan the course of action for this session (I'll copy paste between your terminal windows, and ask you to review each other's output). Each session is focusing on one of those three directions:
    1C. Pure conjecture chasing (Agda)
    2S. Runtime-to-substrate junction (Agda that looks at Elixir/Rust)
    3R. Runtime (Elixir, Rust)
3. When we reach a consensus—and very importantly, in all cases, only after we have discussed and planned the next move—do we write to file. Before any edits we create and name a new branch in git. Claude is in charge of git and writing the code and Codex is in charge of editing the workflow files (only at the end of the session, after the refactor phase)
4. Refactoring phase, to make sure we leave a system in a clean state behind, and that we have respected all the principles we set for ourselves.
5. Codex updates the workflow files and Claude commits (no push)
In this session _

In general:
- Don't call things by their notation names, unless it has been firmly reestablished recently in the conversation. (Ex: don't evoke "R4" out of the blue, but introduce it as "Benton/LNL interface (R4)" or something meaningful, with a reference to the short version for future reference.)
- Don't hesitate to push back when you feel we're not going in the right direction, including with what the instigator says (they're not the boss whose orders you have to follow, but only one of three voices, all committed to making the project develop in the right direction).

### Thorough (conjecture)

Please read all top level files in the workflow folder, plus the files 03, 06, 08, 09, 13 and 14 in /arc, in the order of the numbering.
Our working methodology is as follows: 
1. In general we want all our code to follow well established design principles and be clean and modular. We have several methodologies that we try to adhere to in everything we do: clean code/software craftsmanship for the practice of code, and Grothendieck's relative point of view and rising sea for the practice of mathematics. (And if we can Yin-Yang the two sides all the better.)
2. Me, the human instigator, and two agents, Claude and Codex, are going to discuss and plan the course of action for this session (I'll copy paste between your terminal windows, and ask you to review each other's output). Each session is focusing on one of those three directions:
    1C. Pure conjecture chasing (Agda)
    2S. Runtime-to-substrate junction (Agda that looks at Elixir/Rust)
    3R. Runtime (Elixir, Rust)
3. When we reach a consensus—and very importantly, in all cases, only after we have discussed and planned the next move—do we write to file. Claude is in charge of writing the code and Codex is in charge of editing the workflow files (only at the end of the session, after the refactor phase)
4. Refactoring phase, to make sure we leave a system in a clean state behind, and that we have respected all the principles we set for ourselves.
In this session _

## Discussion

This is the other agent's assessment, please review and come back to me with an updated assessment which details where there is convergence and where these is tension. For convergence, simply lists the items we obtained. For divergence, please expose the situation: what is at stake ; what are our options ; what each option buys and costs us.

## Plan

**Claude**
Please provide a plan for how you wish to structure this session's code writing.

**Codex**
Please review Claude's plan for this session and give them any tips, recommendation, or point to flags, if you feel it could be useful.

## Coding

Please go ahead and write the code. Don't hesitate to stop and start a new discussion if you meet any roadblock. Also, keep in mind to always use the principles of clean, modular code.

## Code review

Please review the code that has been written.

## Refactoring

Now, let's look into refactoring, throughout the elixir code. We want tot make it as optimal and clean code as possible, hunting down duplicates/reusable code and opportunities to modularize. We want to make sure our naming conventions, comments, and all aspects of our code are natural, consistent and follow industry best practices.

## Commit

Codex is done also. I believe you started a branch for this session. Please close it properly using standard git best practices. Make it all clean such that I can push when you're done.

## Self-reflection

Any bias we started with that have been corrected?
Any names you had trouble understanding or that led you to think the named concept was something other that what we meant?
Any known structure you believed the 

## Farewell

Good work. I'm going to clear context. See you on the other side!

## formatting documents

In markdown files, for math notation, and don't use embedded latex because it doesn't compile and it's unreadable, nor the home-cooking keyboard shortcuts like X^1, but the unicode characters whenever applicable. If none exist for the symbol, please notify the instigator.
In latex files, use latex for math notation obviously. And in general remove indentation at the beginning of paragraphs and add a line of white space in between each paragraphs. The author should always be "The Hoapa Project" and the date be month in letters and year in numbers.

---

## Temp

I believe all of the above is going in the right direction.
  I'd like to push things a little bit further and ask you to reevaluate the conjecture (especially in the current context of the project, where the concurrency side is starting to show
  its value while the modal side we started with seems not so strong in comparison) in the light of the architecture, and what this architecture means for the scientific community.
  Basically, if we motivate the concurrency side, understood as a strategy for resource manangement where resources are human brains (possibly paired with AI agents and other tools), on
  the idea that it has a function: to map its context, and a guiding principle: the synthetic decomposition inspired by mathematics, then we're asking the scientific community to do
  something that will appear idiotic to them: to hide who knows what. And in passing, to strip anyone of their degree, carreers as them know them, and the entire network of University.
  We need to do that because all those things classifies human brains analytically, by recognizing in the system what they're "made of". To remove that would be seen as a "carnage on
  knowledge". The way I see it is like an economic crash, versus a war. Think of the state of a generic country's economic the next day after a devastating crash like in 1929: everything
  that was productive the previous day is still available to be productive the next. Machines, tools, workers, know-how, the infrastructure, all of this is preserved. What has changed
  is the flow/organization, the life-blood of the economy. But if it had an alternative model, everything could be back on track overnight. As opposed to a devastating war, which has
  actually destroyed the production capacity. So, to erease from the record the status of scientists and the organization of universities is not a nuclear bomb: everything that was known
  the previous day is still known the next, and everybody is still available to do some work, if you could find an alternative organization.
  What Hoapa wants to do, is to demonstrate, via mathematics, informatics, with some philosophy and models in natural systems, that there is a "most legitimate" organization that could
  be used for a "post-crash" science. And even if there's no crash, to organize the next science "underneath" the current one.

  I believe the proof of the conjecture should be the motivation for members of the scientific community and humans in general to do just that.
  One way to state it, at this non-mathematical level of a system architecture embedded in a certain context, is as follows:

Science is made out of two parts: a scientific community (a list of brains) β, and a documentation α (a list of symbols and the texts written with those symbols, including annotations of all kinds of documents).
To organize β according to a synthetic decomposition (Lautman) is much less costly for the organization of science than analytic, because brains are already synthetic, they're already like vectors. A system that wants to assign "prime factors" to each of them has a lot of work to do: selection, control, constraint, hierarchy, etc.
To organize α according to an analytic decomposition (Lautman) is much less costly for the organization of science than synthetic, because the synthetic frame in which to encapsulate all things is far from obvious.
The "freedom of shape" allowed by the synthetic decomposition of β can then be spent on system's optimality, such that it can achieve a maximal fluidity of information transfer.
Furthermore, if this shape is extended to the organization, not just of science, but of all work, then every agent is even more adapted to the task of science in a synthetic method: they have more time, information transfer is more fluid, immersion in context is more direct and meaningful, and it now makes sense to do science the synthetic way.
Logic becomes permacultural, and there is the emergence of the consciousness of care at the global scale and of the new dimensions in which new worlds can form.

If don't know if "Allow" and "Require" are the best terms for what I believe is the core of the conjecture, or even if it's an adjunction, but it certainly ends up being a virtuous-circle-process.


  On the one hand, the motivation for why we should build a system that has no information about the participants:
  Where we understand the no-information part as "freedom of shape", because the opposite case of having to collect and manage information is a constraint of the shape of the system that simply doesn't exist in the no-information case. And this freedom of shape is a budget that can be spent on optimizing the process at hand (for a community of agents embedded in a context to map this context) and its tool-suite. *Even if* this optimal strategy implies picking resources at random whenever the system needs something to be done.
  On the other hand, what this means for the specific system-of-science context in which "the agents we just unityped" are going to make this science happen, if the freedom of shape extends to the entire :
