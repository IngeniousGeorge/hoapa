# hoapa — agent brief

The single set of instructions for every agent on this project. `CLAUDE.md` imports
this file; Codex reads it directly. Keep it short and mostly pointers: it is loaded
in full at the start of every session, and anything restated here will drift.

## Project goal

Develop a mathematical account of the *development* of mathematics, taking HoTT
as the foundational working language and collective scientific praxis as a co-equal
concern. Seek a universal-property account of the adequacy of Hoapa-like organizations
to their contexts and to the generation of new contexts. The world/context setting
is to be discovered, not prescribed as cohesive or modal HoTT. The conjecture and
its philosophical anchors are stated in `workflow/motivation.md`.

## Current phase

**Read `workflow/current_track.md` first** for the live lane and next-step posture.
Three lanes: **1C** pure conjecture, **2S** runtime-to-substrate interpretation,
**3R** runtime. Dependency discipline: 3R echoes 2S; 1C develops independently; 2S
imports 1C only once a 1C result has become a stable interface.

- Formal and conjectural state: `workflow/status_formal.md`
- Runtime and checker state: `workflow/status_implementation.md`
- Participant and information-flow architecture: `workflow/architecture.md`
- Canonical concurrency reframe: `workflow/arc/02_concurrency_anchor.md`
- Rejected default readings: `workflow/bias_correction.md`

Lane status is deliberately *not* restated here. Those files are authoritative; this
one goes stale.

## Roles and division of labour

- **Instigator (ig) sets direction, proposes conjectures,
reviews and approves formalizations, decides when something is done enough to move on.
- **Claude:** implements Agda, explores formalization options, reports findings and
blockers, flags choices with mathematical consequences.
- **Codex:** owns `workflow/` files and the written abstracts
Conversation is relayed through ig.

This is the default division, not a wall — whoever is asked does the work. But do not
take over another agent's surface unprompted, and say so when you do cross over.

## Working in parallel

Agents work in one checkout, in relay through ig: one writes while another reads.
The working tree is therefore shared state — treat every commit as if another agent
has uncommitted edits in it, because usually one does.

- Re-read `git status` and `git log` immediately before staging or committing. Never
rely on a snapshot from earlier in the session.
- Stage explicit paths, never `git add -A`, so another agent's in-flight files cannot
be swept into your commit.
- Never `git checkout` a different branch while another agent is working.

## Working with ig

**Alignment precedes all code.** Nothing is written until ig and the agent are on the
same page.** This covers *all* file creation and edits — code, workflow files, memory,
scaffolding. "Low-stakes" is not an exemption, and having just argued for a change is
not permission to make it. Before any write, say which files and why, and leave room
to redirect.

**Plain text, not widgets.** ig runs this project as a multi-agent exchange, pasting
excerpts between Claude Code and Codex. Option-list UIs and plan-mode files do not
survive that relay; prose does. For a multiple-choice question, write the options as a
short list with your lean and ask in prose. For an implementation plan, propose it
inline and ask for sign-off. Never gate work behind a plan file.

**No Latex.** It doesn't render at all most of the time. Put all math notation in
unicode (note explicitly if a desired symbol is missing and give the latex handle for
it) and text formatting in markdown.

## Conversation keywords

### in reaching consensus before writing to files

*Discuss:* at the start of a prompt, followed by another agent's ouput in curly braces, 
means you should provide adequate feedback: correct mistakes, flag issues, give tips, etc.
In an output that itself can be discussed.
*Stakes:* at the start of a prompt, followed by another agent's output in curly braces
or not, means you should state, for any remaining tension: what's at stake, what our
options are, and what each cost and buy us. Please use numbering for future reference.
FYI, if you see "❯" in a transcript it means the human is talking, "●" means the AI agent
is talking.

### misc

*Workflows*, plural, always means the top-level files of `workflow/`, not any of
its subfolders.

*Define:* at the start of a prompt, followed by a term or symbol in curly braces should
be answered with a one-paragraph pedagogical presentation of what's in the braces. This
should be understood as a parenthesis in the conversation and shouldn't interupt the flow.

## Workflow conventions

1. **Propose before implementing.** See "Working with ig" — it applies to every write,
not only to non-trivial formalization choices. Where several strategies exist,
surface the tradeoff in 2–3 sentences first.
2. **One file per concept.** Keep Agda modules small and focused; prefer many small
files to one large one.
3. **No silent imports.** When a new Agda dependency or library is introduced, say so
explicitly.
4. **Mathematical fidelity first.** Prefer the formalization matching the mathematical
intent, even if a more pragmatic encoding type-checks more easily.
5. **Track blockers in the canonical status file.** Formal and conjectural blockers in
`workflow/status_formal.md`; runtime and checker blockers in
`workflow/status_implementation.md`; lane priority in `workflow/current_track.md`.
6. **Long names over notation.** Prefer `DeloopingOfIntegers` over `Bℤ`,
`FlatModality` over `♭`. Math notation belongs in comments, not identifiers.
7. **Two-sides vocabulary.** The world/context side is **M** (its mathematical
form is under investigation); the concurrency side is **K** (actor-causal
communities with session-typed values). The current candidate pair is
`Allow : M → K` and `Require : K → M`; see `workflow/naming.md` for status
and exploratory extensions. The
retired labels `A-side` / `B-side` were ambiguous — `A` named both the modal side
and `Allow` — and `C` for the concurrency category collided with Complexity. Do not
reintroduce them. Lanes (`1C`/`2S`/`3R`) are not sides; a sentence needs at most one
of the two schemes.
8. **This file holds patterns; `workflow/` holds state.** When the two disagree, the
workflow file wins — always one-way. Before adding anything here, ask whether it
could be re-derived by reading `workflow/`. If yes, put it there and link instead.
9. **Anti-default files are load-bearing.** `workflow/bias_correction.md` exists to
forestall default-LLM misreadings the project explicitly rejects. Read it at session
start as corrections against defaults you would otherwise apply, and treat anything
that looks like anti-default scaffolding as structural rather than decorative.
Its modal-era work orders are superseded by the 2026-09-26 reorientation in
`workflow/current_track.md`; the architectural corrections and examples remain
useful. The file itself is retained unchanged.


## Mathematical style

The register is Grothendieckian. This is a working method, not homage — each point is
meant to be checked against what you are about to write.
- **The relative point of view.** Prefer morphisms and families over isolated objects.
Work over a base and keep constructions stable under change of base. *Test:* could
this definition be stated for a family, indexed by the thing it currently fixes? If
so, state it that way. The project's own shape is relative — `Allow ⊣ Require` is a
statement about a pair of functors, not about two objects.
- **The rising sea, not the chisel.** A problem should be dissolved by the surrounding
setting rather than cracked by force. *Test:* if a proof is long and clever, suspect
the definitions before admiring the proof.
- **Definitions carry the work.** Finding the right notion is the result; the theorem
that follows is often formal. *Test:* when stuck, reconsider the definition before
adding machinery to the proof.
- **Universal properties over constructions.** Characterize an object by what it
represents; a construction is one presentation, the universal property is the thing.
*Test:* can this be stated as "every admissible X factors uniquely through it"? That
is already the intended meaning of *optimal* in the conjecture.
- **Functoriality as a smell test.** A construction that resists being made functorial
is usually the wrong construction.
- **Earn generality; never assert it.** Generality is legitimate when it dissolves a
difficulty already met, and is overreach when reached for first. *Test:* name the
concrete case that forced the general definition. If you cannot name one, you are
decorating rather than generalizing. This is the guard that keeps the previous five
points from becoming license — see `workflow/bias_correction.md`.
- **State exactly what is proved.** Thoroughness means the claim and the evidence are
the same size. Name the hypotheses a result is relative to, the postulates it rests
on, and the case it actually covers. A checked instance that collapses is a control,
not evidence; discharging a postulate at a trivial type is much weaker than at a
non-trivial one. Say which.
- **Craft.** Small, focused, well-named modules a reader can follow; comments that
record why a choice was made and what was rejected, not just what the code does.
This work will be reread for years — write it at that speed.
- **Patience with the unresolved.** An open gate stated precisely is worth more than a
closed one stated loosely. Retiring a claim that does not hold is a result, and
reporting that a pass produced no new support is the honest headline, not a failure.

## Code and test style

The executable register is test-driven and clean, and has the same standing as the
mathematical style above. Each point is a check against what you are about to write.

- **Red first.** Expose missing behaviour as a failing focused check, or missing formal
content as an unmet typed obligation, before implementing it. *Test:* can you name the
check or obligation that was red, and is it retained now? "I verified it by hand" is
not a check. Type-checking only after writing the implementation establishes green, but
does not establish that the obligation was red first.
- **`make test` is the definition of green.** Focused commands are appropriate during
the inner red-green loop, but the completed change is green only when the top-level
suite passes: drift gates, freshness gates, formal conformance, and runtime tests. The
canonical loop order lives in `workflow/status_implementation.md`; do not restate it
here.
- **Contract fixtures are executable specifications.** Claims about serialized contract
acceptance or rejection belong in the authoritative formal corpus with an expected
verdict. Runtime tests may construct recorder inputs, including invalid ones, but must
not introduce their own fixtures claimed to be formally valid. *Test:* if the claim
broke silently, which check would go red?
- **Refactor from green.** Restructuring and behaviour change are separate steps, with a
passing suite between them.
- **Legs stay sealed.** Runtime tests read the vendored artifact under
`priv/runtime_contract/`, never `../../formal`. A test that reaches across a boundary
tests the boundary away.
- **Small, one job, named for what it is.** Prefer long names over abbreviations,
explicit dependencies, and few unrelated arguments. No function should carry more
responsibility than its shape makes visible. This is the *Craft* standard above applied
to executable code.

## Agda conventions

- Library: cubical Agda (`~/libs/agda-libs/cubical`), registered in `~/.agda/libraries`.
The Agda leg lives under `formal/`; modules are `RuntimeContract.*`, not
`formal.RuntimeContract.*`, so Agda must be run from `formal/`.
- Universe polymorphism should be explicit, not implicit, where possible.
- All files use the `--cubical` pragma.
- **Flat postulates over record wrappers.** When a group of results cannot be proved and
must be postulated, use simple individual postulates rather than packaging them in a
record. The conceptual point ("the missing ingredient is functorial coherence, not four
isolated facts") belongs in a comment. Reserve record and typeclass structure for
things actively computed with.
- **Flag workarounds as workarounds.** When a fix uses `{X = X}` on an implicit, an
annotation Agda should have inferred, or any other idiom that fights inference, name
it as a hint and offer one or two cleaner alternatives rather than absorbing it
silently. This holds beyond Agda: any workaround for a tool's limitation gets flagged,
not buried.
- **Let the math surface the framework, don't postulate the bridge.** When the
interdisciplinary framework asserts a connection and at least one side is itself
abstract or postulated, record both sides as distinct Agda objects and leave the
bridge in prose. A bridge postulate is a scaffold on scaffolds: it declares the
framework's claim without proving it, and forecloses both outcomes — the bridge
holding is an Agda success, the bridge failing is an informative discovery. Materialize
it only once richer structure gives the math somewhere to show or fail to show the
connection. Live instance: `Sessions.agda` carries both R8 faces
(`dual-involutive`, `boundary-swap-at-gen`) with the bridge deferred.
