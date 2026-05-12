# doc2cog

## Project Goal

Establish a conjecture/theorem: while HoTT is the most appropriate *foundation* for mathematics in the formal sense, modal HoTT (especially cohesive toposes) is the most appropriate setting for the *development* of mathematics in the praxis sense — as discussed individually by Grothendieck in *Récoltes et Semailles* and socially by Hersh in *What is Mathematics, Really?*

## Current Phase

The site for the ∞-topos is **Bℤ** (delooping of the integers — the algebra, not the topology, is what's load-bearing; `workflow/only_read_if_asked_to/conversation.md` explicitly rejects "site is S¹"). Synthetic and analytic tracks both have `Cohesion`, `Adjunctions`, `Properties`, and `Fracture` files complete.

**Current task: the de Rham separation arc.** Fracture has landed (synthetic postulate + analytic ℤ verification). The next step is the de Rham separation result — exhibit something stateable in cohesive HoTT but not in plain HoTT. A three-way branching point is pending: (i) abstract coefficients `ʃX → B` for flat-modal `B`, (ii-weak) instantiate at postulated ℝ, (ii-strong) full differential cohesion with the infinitesimal shape modality ℑ. See `workflow/status.md` "Discussion of the next step" for the live reading; `workflow/only_read_if_asked_to/rug.md` for what (ii-strong) would cost.

## Roles

- **Instigator (ig):** Sets direction, proposes conjectures, reviews and approves formalizations, decides when something is "done enough" to move on.
- **Agent (Claude):** Implements Agda code, explores formalization options, reports findings and blockers, flags when a choice has mathematical consequences worth flagging to the instigator.

## Workflow Conventions

1. **Propose before implementing non-trivial choices.** If there are multiple formalization strategies, surface the tradeoff in 2-3 sentences before writing code.
2. **One file per concept.** Keep Agda modules small and focused; prefer many small files to one large one.
3. **No silent imports.** When a new Agda dependency or library is introduced, say so explicitly.
4. **Mathematical fidelity first.** Prefer the formalization that matches the mathematical intent, even if a more pragmatic encoding type-checks more easily.
5. **Track blockers in workflow/status.md.** If a formalization is stuck (e.g., universe levels, termination checker, missing stdlib), record it there rather than papering over it.
6. **Long names over notation.** Prefer `DeloopingOfIntegers` over `Bℤ`, `ThreePointedStruct` over `C₃`, `FlatModality` over `♭`. Math notation belongs in comments, not identifiers.

## Directory Layout

**Start with `workflow/README.md`** — onboarding map. It defines two reading paths: a **focused** path (read `status.md` and stop) for active tasks, and an **architecture** path (the files in `workflow/only_read_if_asked_to/`) for orientation, reframing, or big-picture decisions. The architecture-path files are *not* loaded by default; consult them when `status.md` proves insufficient or when explicitly directed.

```
agda/
  ModalHoTT/           Synthetic (axiomatic) track — modalities postulated
  Analytic/ModalHoTT/  Analytic (verification) track — demonstrates non-vacuity
  Concurrency/         B-side stub (dormant; ThreePointedStruct only)
workflow/              Project management; read README.md first
  README.md            Onboarding map (two reading paths)
  status.md            Focused-path file: current state, live decisions, blockers
  memory/              Symlink to Claude auto-memory for this project
  only_read_if_asked_to/   Architecture-path files; not loaded by default
    motivation.md          Philosophical seed (the math is a subsystem of this)
    arc.md                 Cohesive reformulation (Allow ⊣ Mediate ⊣ Require)
    targets.md             T1–T7: concrete propositions decomposing the arc
    conversation.md        Negative anchoring — defaults the project rejects
    rug.md                 What's under the rug: shortcut postulates, gaps, horizons
    related_structures.md  Adjacent frameworks (Connes, Bennequin/Belfiore/Laforgue)
    naming.md              Modality vocabulary (♭/♯/ʃ)
```

## Agda Notes

- Library: cubical Agda (`~/libs/agda-libs/cubical`), registered in `~/.agda/libraries`.
- Universe polymorphism should be explicit, not implicit where possible.
- All files use `--cubical` pragma.
