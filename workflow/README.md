# workflow/ — onboarding map

This folder holds project state, scope, and orientation. Two reading paths.

## Focused path

For active tasks (writing Agda, debugging a postulate, extending a file): **read `status.md` and stop.** It carries current state, live decisions, current task, next step, blockers, completed work, and an archive of settled decisions. Ignore everything in the rest of the folder. If `status.md` feels insufficient, you my ask the instigator for a larger scope and they will direct you to the appropriate files.

## Architecture path

When the task needs wider context — conjecture scope, where things sit in the arc, what has been deferred, what is under the rug — read these in order. They live in `workflow/` and are *not* loaded by default.

## Structure of context path

Some special sessions can be about the structure of contextual information for the project, only in this case are those files needed.

### Backbone

0. **`motivation.md`** — the philosophical seed. Hand-wavy proto-conjecture. *The math we are building is a subsystem of this broader picture, not its totality.* Re-read when the formalism starts to feel self-contained.
1. **`arc.md`** — the conjecture reformulated in cohesive vocabulary. The structural backbone of the project. Each section that has a corresponding proposition in `targets.md` carries a `→ T*n*` pointer.
2. **`targets.md`** — concrete propositions T1–T7 decomposing the arc into work the proof checker can engage with. Each T has an arc-anchor back to the relevant `arc.md` section.
3. **`status.md`** — the same file from the focused path; read third in the architecture path because it grounds arc + targets in current state.

### Reference

- **`conversation.md`** — **negative anchoring.** Forestalls default-LLM mis-readings of this project (e.g. "modal HoTT vs HoTT", "site is S¹", "concurrency is decorative" — each explicitly rejected by the instigator). Read as corrections-against-assumptions, not as historical chat log.
- **`rug.md`** — what is under the rug: postulates we have shortcut, claims that depend on imported soundness (real-cohesive HoTT), and the differential-cohesion gap blocking a content-bearing de Rham theorem. Consult when evaluating new postulates, when "is this really proved?" is in scope, or before extending the postulate budget.
- **`related_structures.md`** — adjacent frameworks (Connes, Bennequin/Laforgue, …) with explicit "Relation to our arc" framing. A locator, not a target; use to position the work against neighbours, not to import their machinery.
- **`naming.md`** — short vocabulary table for the three cohesion modalities (♭, ♯, ʃ — what each *keeps* and *forgets*).

### Memory (both paths)

- **`memory/`** — symlink to the Claude Code auto-memory directory for this project (`~/.claude/projects/-home-ig-Code-doc2cog/memory/`). Cross-conversation memory for the AI agent; the user-facing index is `MEMORY.md` inside it. Read-through to see what the agent already knows about the user and project from past sessions.
