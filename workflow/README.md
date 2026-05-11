# workflow/ — onboarding map

This folder is the project's working memory: state, scope, conventions, and orientation for any new contributor (human or AI).

## Backbone — read in this order

1. **`arc.md`** — the conjecture's scope, reformulated in cohesive vocabulary. The structural backbone of the project. Each section that has a corresponding proposition in `targets.md` carries a `→ T*n*` pointer.
2. **`targets.md`** — concrete propositions T1–T7 that decompose the arc into work the proof checker can engage with. Each T has an arc-anchor back to the relevant `arc.md` section.
3. **`status.md`** — current state, live decisions, what's being worked on right now, what's next, what's blocked. Read top-to-bottom: orientation (arc / B-side / semantic background / analytic method) → live decisions → open questions → current task → next step → longer horizon (unlocking ♯) → blockers → completed → archived decisions.

## Reference

- **`motivation.md`** — the philosophical seed. Hand-wavy proto-conjecture. *The math we're building is a subsystem of this broader picture, not its totality.* `arc.md`, `targets.md`, and `related_structures.md` are all consequences of work done on top of this intuition. Re-read it when the formalism starts to feel self-contained.
- **`related_structures.md`** — adjacent frameworks (Connes, Bennequin/Laforgue, …) with an explicit "Relation to our arc" framing. A locator, not a target; use to position the work against neighbours, not to import their machinery.
- **`conventions.md`** — short vocabulary table for the three cohesion modalities (♭, ♯, ʃ — what each *keeps* and *forgets*).
- **`conversation.md`** — **negative anchoring.** Forestalls the default-LLM mis-readings of this project (e.g. "modal HoTT vs HoTT", "site is S¹", "concurrency is decorative" — each explicitly rejected by the instigator). Read as corrections-against-assumptions, not as historical chat log. Its preamble lists the specific defaults it rules out.
- **`memory/`** — symlink to the Claude Code auto-memory directory for this project (`~/.claude/projects/-home-ig-Code-doc2cog/memory/`). Cross-conversation memory for the AI agent; the user-facing index is `MEMORY.md` inside it. Read-through to see what the agent already knows about the user and project from past sessions.
