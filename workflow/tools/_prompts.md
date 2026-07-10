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

- shared memory
- 
Now, Claude is writing the code. In the meanwhile, can you take care of the adga -> formal renaming in all top level workflow files + pedagogy + communication files?