# hoapa

## Project Goal

Establish a conjecture/theorem: while HoTT is the most appropriate *foundation* for mathematics in the formal sense, modal HoTT (especially cohesive toposes) is the most appropriate setting for the *development* of mathematics in the praxis sense — as discussed individually by Grothendieck in *Récoltes et Semailles* and socially by Hersh in *What is Mathematics, Really?*

## Current Phase

Read `workflow/current_track.md` first for the live lane and next-step posture. The project uses three lanes: 1C for pure conjecture work, 2S for runtime-to-substrate interpretation, and 3R for the runtime. Current bandwidth is at the 2S/3R boundary: the 3R tiny-run construction seam is banked, and the next 2S return is per-conversation locality plus `FrameHom`s. The 1C lane develops independently, but ModalHoTT remains paused at the de Rham named-coefficient rung and the cross-site `Allow ⊣ Require` adjunction remains downstream of its stated gates. The canonical Concurrency reframe is `workflow/arc/02_concurrency_anchor.md`; read `workflow/status_formal.md` for formal/conjectural state and `workflow/status_implementation.md` for runtime state.

## Roles

- **Instigator (ig):** Sets direction, proposes conjectures, reviews and approves formalizations, decides when something is "done enough" to move on.
- **Agent (Claude):** Implements Agda code, explores formalization options, reports findings and blockers, flags when a choice has mathematical consequences worth flagging to the instigator.

## Workflow Conventions

1. **Propose before implementing non-trivial choices.** If there are multiple formalization strategies, surface the tradeoff in 2-3 sentences before writing code.
2. **One file per concept.** Keep Agda modules small and focused; prefer many small files to one large one.
3. **No silent imports.** When a new Agda dependency or library is introduced, say so explicitly.
4. **Mathematical fidelity first.** Prefer the formalization that matches the mathematical intent, even if a more pragmatic encoding type-checks more easily.
5. **Track blockers in the canonical status file.** Formal and conjectural blockers belong in `workflow/status_formal.md`; runtime and checker blockers belong in `workflow/status_implementation.md`. Lane priority belongs in `workflow/current_track.md`.
6. **Long names over notation.** Prefer `DeloopingOfIntegers` over `Bℤ`, `FlatModality` over `♭`. Math notation belongs in comments, not identifiers.

## Agda Notes

- Library: cubical Agda (`~/libs/agda-libs/cubical`), registered in `~/.agda/libraries`.
- Universe polymorphism should be explicit, not implicit where possible.
- All files use `--cubical` pragma.
