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

### Codex last output

The response now converges on the right session and theorem. Three phrases still need correction before sign-off: total injection need not replace the bijective target, list-bijection is
  insufficient rather than universally unsound, and backwardOK’s generic lemma would not serve event-ID renaming.

  1. Headline theorem versus stronger implementation lemma

  What is at stake: preserving the gauge/equivalence meaning of “renaming” while proving the strongest natural Boolean fact.

  Options:

  - Recommended: define renameActors for arbitrary total functions, prove exact valid? equality under total injectivity, and expose bijective/permutation invariance as the named Tier A
    corollary.
      - Buys: malformed-run invariance, the clean Boolean proof, and the stronger reusable result.
      - Costs: one corollary.
      - Effect on the ledger: the target in workflow/targets.md:178 remains correct. Only the proposed inverse-based proof route in workflow/future_work.md:709 changes.

  - Make total injection the Tier A headline.
      - Buys: the strongest result is foregrounded.
      - Costs: “renaming” now includes noninvertible embeddings such as suc; the gauge reading applies only to its permutation subgroup. This would be a genuine target amendment.

  - Require a total permutation throughout.
      - Buys: exact agreement with the recorded target and clearest gauge semantics.
      - Costs: an unnecessarily strong hypothesis and additional inverse machinery.

  I recommend the first. The raw validator theorem belongs to the injective endomorphism monoid; the semantic gauge theorem belongs to the permutation group.

  “Bijection between actor lists” should not be retired as universally unsound. It is insufficient for exact equality over arbitrary malformed RawRuns unless it is extended to a total
  injective map, made fresh on the complement, or the theorem is restricted to well-formed inputs. It may remain useful at Tier B, where realization already starts from WellFormed. The
  precise finding is:

  > List-local bijectivity is not a sufficient hypothesis for Tier A Boolean equality over all raw runs.

  2. backwardOK lemma boundary

  What is at stake: whether this session creates a general transformation API or only the result currently forced.

  Claude is correct that backwardOK needs an explicit proof: traceEvents becomes a mapped event list even though evId and evParents remain unchanged. Conversation-ID and event-ID
  distinctness likewise need map-fusion or induction rather than simple refl.

  Options:

  - Recommended: expose an actor-specific backwardOK-renameActors lemma. A generic “maps preserving evId and evParents” helper may remain private if it simplifies the proof.
      - Buys: a narrow public theorem surface and no premature abstraction.
      - Costs: a later non-actor transformation may generalize it again.

  - Publish the generic preservation lemma immediately.
      - Buys: reuse for conversation, content, provenance, and other transformations that leave the causal-ID channel untouched.
      - Costs: additional parameters and an abstraction not yet demanded by a second use.

  It would not directly support event-ID renaming. That operation changes evId, evParents, and the accumulated seen list together, so it needs a separate equivariance theorem under
  injective event-ID relabeling. The claimed event-ID reuse should be removed.

  3. Red-first and the test runner

  What is at stake: ruling out the vacuous implementation without broadening this session into test-infrastructure cleanup.

  The concrete test module should contain:

  - A moving permutation witness on cross_conversation proving that traceActors changes.
  - The corresponding unchanged valid? verdict.
  - Concrete applications of identity and composition if useful.

  The generic identity and composition laws belong in ActorRenaming.agda; they specify functoriality but do not rule out the trivial action. The moving witness is the actual no-op guard
  and should be made red first.

  For wiring:

  - Recommended: import Tests.ActorRenaming from formal/RuntimeContract/Tests/All.agda:1.
  - Do not fold ConversationOrderComparison into it during this change.

  ConversationOrderComparison is a realization-level theorem test, whereas the proposed actor-renaming witness is a raw-contract corpus property, like ConversationCoverage. Its separate
  line in the Makefile:45 does not force the same placement here. Any broader clarification of what “All” aggregates can be handled separately.

  4. Gate 6

  What is at stake: whether the result is presented as evidence of discovering no leakage or as enforcement of an intentionally identity-blind design.

  There is no present identity-sensitive clause inside valid?, so there is no honest in-corpus leak counterexample. The moving witness proves only that the action is nontrivial.

  The disposition should be:

  - Tier A’s non-vacuity control is resolved by the moving witness.
  - Gate 6’s identity-sensitive falsifier remains deferred to the observation/provenance layer.
  - Tier A’s value is that identity-insensitivity becomes a permanent checked obligation: a later validator clause depending on a particular actor number makes the generic theorem fail.

  That is stronger and more accurate than calling gate 6 answered.

  5. Workflow accounting

  What is at stake: correcting real overclaims without turning the formal session into a documentation sweep.

  The following corrections are warranted when their files are next authorized for editing:

  - Tighten the runtime-payback sentence in status_implementation.md: acceptance independence does not license exposing operational identity.
  - Change Trace.agda’s “raw IDs” wording to “actor IDs.”
  - Replace the inverse-renaming proof route with the direct injectivity route.
  - Record list-local bijection as insufficient for raw Boolean equality—not simply mathematically unsound.
  - Perform the four identified stale-status corrections as one short synchronization pass.

  My proposed final alignment statement is:

  > This session takes 2S Tier A. renameActors acts on exactly traceActors, convActors, and evTouches. We prove identity and composition for arbitrary total actor maps, exact raw-validator
  > equality under total injectivity, and derive the recorded bijective/permutation and WellFormed corollaries. A moving permutation witness on cross_conversation rules out the no-op
  > implementation. The named semantic target remains bijective actor relabeling; total injectivity is the stronger raw-validator lemma supporting it. Tier B, reordering, SIP/univalence,
  > other identifier channels, and observational no-leak remain separate.

  That is ready for sign-off. No files have been changed.