# doc2cog

## Project Goal

Establish a conjecture/theorem: while HoTT is the most appropriate *foundation* for mathematics in the formal sense, modal HoTT (especially cohesive toposes) is the most appropriate setting for the *development* of mathematics in the praxis sense — as discussed individually by Grothendieck in *Récoltes et Semailles* and socially by Hersh in *What is Mathematics, Really?*

## Current Phase

Bandwidth has shifted from the ModalHoTT side (the formal-foundation leg) to the Concurrency side (the community-of-agents leg, dual conjecture). ModalHoTT work is on pause at the de Rham named-coefficient rung; the Concurrency side is in scoping after a major reframe — canonical source `workflow/deep_context/concurrency_anchor.md`. Live state in `workflow/status.md`; the "Discussion of the next step" section there carries the level-2 Concurrency inventory and structuring relations.

## Roles

- **Instigator (ig):** Sets direction, proposes conjectures, reviews and approves formalizations, decides when something is "done enough" to move on.
- **Agent (Claude):** Implements Agda code, explores formalization options, reports findings and blockers, flags when a choice has mathematical consequences worth flagging to the instigator.

## Workflow Conventions

1. **Propose before implementing non-trivial choices.** If there are multiple formalization strategies, surface the tradeoff in 2-3 sentences before writing code.
2. **One file per concept.** Keep Agda modules small and focused; prefer many small files to one large one.
3. **No silent imports.** When a new Agda dependency or library is introduced, say so explicitly.
4. **Mathematical fidelity first.** Prefer the formalization that matches the mathematical intent, even if a more pragmatic encoding type-checks more easily.
5. **Track blockers in workflow/status.md.** If a formalization is stuck (e.g., universe levels, termination checker, missing stdlib), record it there rather than papering over it.
6. **Long names over notation.** Prefer `DeloopingOfIntegers` over `Bℤ`, `FlatModality` over `♭`. Math notation belongs in comments, not identifiers.

## Agda Notes

- Library: cubical Agda (`~/libs/agda-libs/cubical`), registered in `~/.agda/libraries`.
- Universe polymorphism should be explicit, not implicit where possible.
- All files use `--cubical` pragma.
