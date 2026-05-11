# doc2cog

## Project Goal

Establish a conjecture/theorem: while HoTT is the most appropriate *foundation* for mathematics in the formal sense, modal HoTT (especially cohesive toposes) is the most appropriate setting for the *development* of mathematics in the praxis sense — as discussed individually by Grothendieck in *Récoltes et Semailles* and socially by Hersh in *What is Mathematics, Really?*

## Current Phase

The site for the ∞-topos is **Bℤ** (delooping of the integers — the algebra, not the topology, is what's load-bearing; `workflow/conversation.md` explicitly rejects "site is S¹"). Synthetic and analytic tracks both have `Cohesion`, `Adjunctions`, and `Properties` files complete.

**Current task: the fracture theorem** — the canonical pullback square

```
♭A ————→ A
 |        |
 ↓        ↓
♭(♯A) ——→ ♯A
```

as the geometric backbone for the de Rham separation result (the arc target). See `workflow/status.md` for the precise plan.

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

**Start with `workflow/README.md`** — it is the onboarding map and lists the read order (arc.md → targets.md → status.md, then references).

```
agda/
  ModalHoTT/           Synthetic (axiomatic) track — modalities postulated
  Analytic/ModalHoTT/  Analytic (verification) track — demonstrates non-vacuity
  Concurrency/         B-side stub (dormant; ThreePointedStruct only)
workflow/              Project management; read README.md first
  README.md            Onboarding map
  arc.md               Cohesive reformulation (Allow ⊣ Mediate ⊣ Require)
  targets.md           T1–T7: concrete propositions decomposing the arc
  status.md            Current state, live decisions, blockers
  motivation.md        Philosophical seed (the math is a subsystem of this)
  conversation.md      Negative anchoring — defaults the project rejects
  naming.md            Modality vocabulary (♭/♯/ʃ)
  related_structures.md  Adjacent frameworks (Connes, Bennequin/Belfiore/Laforgue)
  memory/              Symlink to Claude auto-memory for this project
```

## Agda Notes

- Library: cubical Agda (`~/libs/agda-libs/cubical`), registered in `~/.agda/libraries`.
- Universe polymorphism should be explicit, not implicit where possible.
- All files use `--cubical` pragma.
