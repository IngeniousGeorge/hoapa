# Abandoning the prescribed modal side

**Disposition — 2026-10-09.** Recoverable ideas and retired work orders, not a
live lane queue. “Abandoning” names the withdrawal of a prescribed route to M,
not a judgment that cohesive mathematics or the preserved constructions are
worthless. No Agda module is deleted or moved by this reorganization.

The sibling [workflow snapshot](workflow/README.md) remains frozen: it records
what the workflow files said at the 2026-09-26 reorientation. This file is the
curated place for subsequent modal-track retirements, with their reasons and
possible uses. Later additions should preserve that distinction rather than
rewrite the snapshot.

## Why the track mattered, and what could return

| Direction | Why it mattered | Why it is not a current work order | What remains reusable |
|---|---|---|---|
| Flat-modal signature, fracture, and crisp-context repair | Separate contextual faces and test how they reconstruct one another. | The unrestricted flat signature makes its modal fragment the whole universe; repairing that specimen no longer defines 1C. | The diagnosis and analytic non-flat contrast; a replacement's own non-degeneracy test, if it actually uses a modality. |
| Bℤ, analytic comparison, and cyclic-bar constructions | Supply a nontrivial test object and a bridge from concrete presentations to homotopical structure. | Bℤ is no longer the prescribed destination or next step for discovering M. | Concrete examples and constructions when an independently motivated contextual or language question needs them. |
| Structural / named-coefficient / differential de Rham ladder | Distinguish adjunction-level coefficient transport from a genuinely differential comparison. | Naming a coefficient did not supply differential content; the differential escalation was not forced by K's present needs. | The distinction between depths, the existing results at their actual scope, and differential cohesion if a new use earns it. |
| Cohesive iteration and convergence | Test the development claim through a round trip and its iterates. | The checked specialization collapses at stage one under the degenerate signature. | A negative control, and the deferred convergence formalization if a consumer needs it; not evidence of development. |
| Cohomological pairing and receiver modalities | Seek a mathematical account of contextual complexity and intelligibility. | Those identifications were not established and are not premises of the rebuilt comparison programme. | Their motivating questions and the independent information-comparison candidates, without prescribing ♭/ʃ/♯ as kinds of receivers. |

Source details and the original alternatives remain in the frozen
[fracture/signature discussion](workflow/future_work.md#regarding-fracture-and-the-modal-signature-defect),
[de Rham depth ladder](workflow/future_work.md#beyond-fracture-the-differential-cohesion-gap),
[named-coefficient discussion](workflow/future_work.md#discussion-of-the-next-step-when-the-bandwidth-was-still-on-the-modal-side),
and [former lane instructions](workflow/current_track.md). They are historical
proposals, including unresolved claims, not revalidated specifications.
The stronger cohomological/receiver claims remain in the snapshot's
[information-cohomological layer](workflow/future_work.md#5-information-cohomological-complexity)
and [cross-cutting reframings](workflow/future_work.md) (the "Appendix — cross-cutting reframings" section).

The generic iteration scaffold and its naturality obligation remain in
[future work](../../future_work.md#regarding-t_recursion-iteration).
Relative cohesion remains in the
[openings portfolio](../../openings.md#candidate-mathematical-resources-for-the-m-rebuild),
as do gated dual/cyclic iteration ideas. Their earlier association with this
track is not a reason to discard them.

## Retained text from the live workflows

The following sections were moved from `workflow/future_work.md` at
`6551018` on 2026-10-09. Their headings and mathematical qualifications are
retained; “programme above” in the historical text refers to the selected
[1C programme](../../future_work.md#selected-1c-programme-relational-adequacy-and-the-m-rebuild).
The mixed iteration section is retained whole for its rationale; the links
above distinguish its still-live generic obligations from the retired specimen.

## Legacy modal diagnosis and retired work orders

The unrestricted `flat-intro` and dependent `flat-ind`, with their β-rule,
derive that `flat-counit` is an equivalence for every type. The intended
flat-modal fragment therefore becomes the whole universe. This diagnoses
loss of that intended distinction, **not Booleanity**, decidability of every
observation, or failure of cohesive mathematics in general.

Retain the proposed named diagnostic `everything-is-flat-modal` when this
control is formalized; it is not reported as a newly checked lemma and does
not take precedence over the programme above. The existing analytic
`¬-IsFlatModal-delooping` remains a checked contrast under its own definitions.

The old repair-first, named-coefficient/de Rham, differential-cohesion, and
cyclic-bar work orders are retired from the selected programme. Their pre-edit
text is preserved in
[the migration archive](../../deep_context/abandonned_modal_side/workflow/README.md).
The Agda files remain in place; generic constructions can be reused at their
actual strength.

## Regarding T_recursion iteration

`formal/ModalHoTT/Modalities/Iteration.agda` lands the generic endofunctor-and-
unit scaffold for T_recursion: iteration `T^n`, iterated unit `η^_n`,
`η^-coherent` derived from postulated naturality, and the sequential-colimit
type `ND A`. It does not bundle a counit, multiplication, or triangle
identities. `IterationCohesion.agda` specializes it at ʃ ⊣ ♭ and checks the
stage-one collapse. Because the surrounding signature already makes every type
flat-modal, this is now a degenerate control. It has no evidential weight for
the intended cohesive semantics or the cross-site conjecture.

Pieces deferred:

- **Dual on the concurrency side.** A symmetric module would iterate the
  *counit* of the comonad `L ∘ R` on the target side, taking the *limit* of a
  decreasing tower `… → M²B → MB → B`. Not written: until the independently
  constructed cross-site adjunction and a non-trivial `ND` exist, the dual is
  a duplicate of an empty scaffold. Do not postulate the cross-site bridge to
  unlock it.

- **Cyclic-operad involution.** The 1=2 perspective-swap "cared-for = caregiver" would be a path constructor (or separate HIT) on top of `SeqColim`, encoding that the iteration is cyclic / self-dual on each level. Deferred for the same reason as the dual: adding the involution to a scaffold that hasn't yet produced non-trivial iteration content is premature.

- **`η-naturality` postulate.** Load-bearing for `η^-coherent`. Same shape and same resolution path as `shape-flat-natural-B` in `Properties.agda` — becomes a theorem once adjunction-naturality is recorded (status_formal.md Open Questions). Not new scope; folds into the existing naturality gap.

- **Full sequential-colimit convergence.** Applying `η-equiv-at-T` at each later iterate shows by induction that all structure maps after stage one are equivalences. The mathematical conclusion `ND A ≃ T A` is therefore known; what remains is formalization, not an open mathematical question. It requires a "convergent sequence has colimit at the convergence point" lemma against cubical's `Sequence` / `SeqColim` infrastructure (`Cubical.Data.Sequence.converges`). This is straightforward but heavier than the checked step lemma and should return only if a downstream use forces it (for example, a comparison with the dual on the concurrency side).

## Retired cohesive escalation

The differential-cohesion depth ladder and the proposed NamedCoefficient
module are preserved in the migration archive's `future_work.md`. They are
not scheduled follow-ons to this M rebuild. A later use must identify the
contextual problem it solves and a sound model for the required modalities.
