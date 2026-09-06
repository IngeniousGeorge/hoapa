# pedagogy/ — the human-facing side of the project

This folder holds everything written to be *read by people* rather than consumed by agents or checked by Agda. It has three siblings, each answering a different question about the same body of work.

```text
pedagogy/
  commentary/    what does this source file actually say?
  cartography/   how do the concepts hang together?
  dictionary/    what are the things called?
```

**`commentary/`** walks individual source files chunk by chunk, for a reader who is mathematically curious but not a type theorist. This was the folder previously called `pedagogy/` at top level; it has been renamed so that the umbrella name is free for all three. Its writing manual is `commentary/pedagogy_project.md` — audience, tone, honesty rules, and the standing conventions. That manual is unchanged from before the move, so where it describes the folder layout it describes the *old* one; read its paths as relative to `commentary/` now.

**`cartography/`** is a document graph of the framework: one file per concept, one per link, one per region. `cartography/SCHEMA.md` is authoritative for its conventions. Moved here unchanged from the repository root.

**`dictionary/`** collects, per working session, the names of the mathematical objects that carried the work. It is very new and deliberately minimal — names only, no definitions yet.

## Two mirror conventions, on purpose

`commentary/` currently contains two different naming schemes, and this is a deliberate experiment rather than drift.

The older material uses numbered reader-order folders:

```text
commentary/01_ModalHoTT/01_Modalities/01_cohesion.md
commentary/02_Concurrency/03_Sites/02_actorcausal.md
```

The newer material mirrors `formal/` exactly, with no numbering:

```text
formal/RuntimeContract/ActorRenaming.agda
commentary/RuntimeContract/ActorRenaming.md

formal/RuntimeContract/Tests/ActorRenaming.agda
commentary/RuntimeContract/Tests/ActorRenaming.md
```

The numbered scheme tells a reader where to start; the faithful mirror tells a reader where a file *is*. Both are defensible and we are running them side by side to find out which wears better. Later sessions may converge them. Until then, do not "fix" the older folders to match the newer ones, and do not add numbering to the mirrored ones.

A consequence worth naming: the mirrored track currently starts in the middle. `commentary/RuntimeContract/` covers `ActorRenaming.agda` but not `Trace.agda`, which defines the vocabulary it uses. The commentary says so in its opening section and carries a compressed on-ramp. When `Trace.md` is written it belongs before it.

## The new_/edited_ marker

Files added or changed during a session that inserts itself into existing collections carry a filename prefix, so old and new stay distinguishable at a glance:

```text
cartography/nodes/new_equality-pattern-blindness.md
dictionary/edited_dictionary_index.md
```

The prefix is a marker for human readers only. It is not part of any identifier — a cartography node's `id` lives in its frontmatter and is unaffected, so edges keep resolving normally. Wholly new subtrees, where everything is new by construction, do not carry it: `commentary/RuntimeContract/` is all new and the prefix would say nothing.

## What is not here

Agent-facing architecture, lane status, and the conjecture ledger live in `workflow/`. That separation is intentional: this folder is downstream of the mathematics and should never become a second place where project state is recorded. Where a commentary needs a fact about status, it should point at the workflow file rather than restate it.

`workflow/deep_context/pedagogy_tracking.md` is the workflow-side pointer at this folder. It still uses the pre-move paths and will need a pass.
