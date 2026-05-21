# Pedagogy track

Workflow-level pointer for the human-facing `pedagogy/` side project. The detailed writing manual lives at `pedagogy/pedagogy_project.md`; this file records current coverage and scope from the workflow side.

## Current coverage

As of 2026-05-21, the pedagogy track is current for the synthetic ModalHoTT tree and the Concurrency tree.

ModalHoTT coverage:

- `pedagogy/01_ModalHoTT/00_modalhott_intro.md`
- `pedagogy/01_ModalHoTT/01_Modalities/01_cohesion.md`
- `pedagogy/01_ModalHoTT/01_Modalities/02_adjunctions.md`
- `pedagogy/01_ModalHoTT/01_Modalities/03_properties.md`
- `pedagogy/01_ModalHoTT/01_Modalities/04_fracture.md`
- `pedagogy/01_ModalHoTT/01_Modalities/05_discrete.md`
- `pedagogy/01_ModalHoTT/01_Modalities/06_iteration.md`
- `pedagogy/01_ModalHoTT/01_Modalities/07_iterationcohesion.md`
- `pedagogy/01_ModalHoTT/02_Cohomology/01_flatcoefficients.md`

Concurrency coverage:

- `pedagogy/02_Concurrency/00_concurrency_intro.md`
- `pedagogy/02_Concurrency/01_Operads/`
- `pedagogy/02_Concurrency/02_Algebras/`
- `pedagogy/02_Concurrency/03_Sites/`
- `pedagogy/02_Concurrency/04_Hybrid/`

The ignored PDF artifact `pedagogy/01_ModalHoTT/01_Modalities/02_adjunctions.pdf` is not part of the maintained markdown inventory.

## Scope boundary

Do not expand into `agda/Analytic/` or `agda/AnalyticTest/` pedagogy unless the user explicitly asks. The current completed track covers synthetic `agda/ModalHoTT/` and `agda/Concurrency/`.

Future pedagogy work should be triggered by new Agda files or by an explicit request to cover the Analytic track.
