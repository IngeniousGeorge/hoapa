# Compact restructure proposal

Assumes the duplication audit's clean-up pass (one canonical home per concept; phantom Concurrency stub either filled or removed) has already been done. The shape below is the steady state, not a migration plan.

---

## 1. What's actually wrong now

Three things, in order of cost:

1. **`status.md` is overloaded.** 154 lines carrying live state + two decisions tables + completed log + forward-looking forecast. The focused-path reader pays for all of it on every session.
2. **`only_read_if_asked_to/` is a behavioural label, not a topical one.** Files in it are the *durable reference* layer; the name reads like a permission gate.
3. **Memory naming is half-conventional.** Eight `feedback_*` files set a pattern that the ninth feedback file breaks; project/reference files have no prefix at all.

No deeper structural problem. The skeleton (focused path / architecture path / memory) is sound — only the inside of the boxes needs tidying.

---

## 2. Target file layout

```
workflow/
  README.md                    onboarding map (essentially unchanged)
  status.md                    LIVE only: current task, next step, blockers,
                               open questions, "Discussion of the next step"
  decisions.md                 NEW: split out from status.md
                                 § Relevant   (in-flow live decisions)
                                 § Archived   (settled / dead-ended)
  log.md                       NEW: split out from status.md
                                 § Completed  (the [x] checklist)
                                 § Forecast   (was "Unlocking ♯" — long-horizon)
  architecture/                RENAMED from only_read_if_asked_to/
    motivation.md
    arc.md
    targets.md
    conversation.md
    rug.md
    related_structures.md
    naming.md
  structure/                   this folder — kept as the meta-layer
    inventory.md
    reference_graph.md
    code_connections.md
    duplication_audit.md
    proposal.md                ← you are here
  memory/                      symlink (unchanged target)
```

Net delta: 2 new files in `workflow/` (`decisions.md`, `log.md`), 1 rename (`only_read_if_asked_to/` → `architecture/`). `status.md` shrinks from 154 to roughly 60–80 lines.

---

## 3. What each change buys

| Change | Buys |
|---|---|
| `status.md` shrinks to live state only | Focused-path reader sees the whole document at once; no scrolling past archived rows. |
| `decisions.md` (Relevant + Archived) | Long-lived but read-rarely. Loading it is opt-in, like `architecture/`. The Relevant/Archived split (per `memory/decisions_log_split.md`) is preserved as two sections inside one file. |
| `log.md` (Completed + Forecast) | "What's done" and "what's far out" answer different questions than "what's now" — split. The "Unlocking ♯" forecast belongs with completed work, not next-step planning, because nothing in it is actionable this session. |
| Rename `only_read_if_asked_to/` → `architecture/` | The README already uses the phrase "architecture path" for this set; folder name finally matches. Shorter to type, less behavioural. |
| `structure/` kept as a sibling | Meta-layer; not in the loading order, but discoverable via `ls workflow/`. |

`architecture/` internals (motivation/arc/targets/conversation/rug/related/naming) stay as-is. The two reading orders documented in README (Backbone vs Reference) remain the right grouping.

---

## 4. Memory conventions

**Naming.** `<type>_<slug>.md` for every file, where `<type>` ∈ `{user, project, feedback, ref}`. Concretely:

| Current name | Target name |
|---|---|
| `user_profile.md` | (already conformant if we accept `user_profile` as a name) — leave |
| `negative_anchoring.md` | `project_negative_anchoring.md` |
| `math_is_subsystem.md` | `project_math_is_subsystem.md` |
| `b_side_site_icosahedral.md` | `project_b_side_site_icosahedral.md` |
| `analytic_strategy.md` | `project_analytic_strategy.md` |
| `decisions_log_split.md` | `feedback_decisions_log_split.md` |
| `de_rham_depth_ladder.md` | `ref_de_rham_depth_ladder.md` |
| eight `feedback_*.md` | unchanged |

Cheap-win-only variant: rename just `decisions_log_split.md` → `feedback_decisions_log_split.md`. The rest is cosmetic.

**`MEMORY.md` index grouped by type:**

```
# Memory Index

## User
- [User Profile](user_profile.md) — …

## Project
- [Negative Anchoring](project_negative_anchoring.md) — …
- [Math is a Subsystem](project_math_is_subsystem.md) — …
- …

## Feedback
- [Memory ≠ Workflow](feedback_memory_not_workflow.md) — …
- …

## Reference
- [De Rham Depth Ladder](ref_de_rham_depth_ladder.md) — …
```

Trade-off vs current insertion-order list: a fresh agent finds the relevant slice faster; the cost is one extra second when adding an entry. Worth it past ~15 entries.

---

## 5. Working habits to add

Three rules, each one sentence with a concrete trigger.

1. **One canonical home per concept.** Every multi-home concept (de Rham depth ladder, fracture framing, analytic-folder purpose, ...) names exactly one file as canonical; everywhere else carries a one-line back-pointer to that file, never a copy of its content. *Trigger:* when the same paragraph is about to be written into a second file, stop and write a pointer instead.

2. **Conclusion ritual.** When a Current Task completes or an Open Question is resolved, the same commit: (a) moves the row from Relevant to Archived in `decisions.md`; (b) adds a [x] line to `log.md`; (c) updates any code-header or memory pointer that referenced the resolved item. *Trigger:* the commit message contains "completes" / "resolves" / "lands".

3. **B-side honesty.** No phantom stubs. A directory under `agda/` either contains a file or doesn't exist; documentation describes what *is*, not what *will be*. *Trigger:* whenever a Decisions Log row or `CLAUDE.md` Directory Layout entry claims a file exists, that claim is verified before merging.

These three sit at three different scales (writing, finishing, scaffolding). Each is enforceable by a single mechanical check.

---

## 6. What I'd ask the instigator before acting on this

1. Folder rename `only_read_if_asked_to/` → `architecture/` — yes / no / different name (`background/` / `reference/` / keep as-is).
2. `status.md` split into three files (`status`, `decisions`, `log`) — yes / no / different split / leave monolithic and accept the length.
3. Memory rename — full (`<type>_` prefix on all 15 entries) / cheap (just `decisions_log_split.md`) / none.
4. Whether the three working habits in §5 should be added to `CLAUDE.md` "Workflow Conventions" as rules 7–9.

Cheapest meaningful version of this proposal: do #2 (status.md split) and #3-cheap. That alone cuts the focused-path load roughly in half and removes the one strict naming inconsistency, with no folder rename and no memory churn.
