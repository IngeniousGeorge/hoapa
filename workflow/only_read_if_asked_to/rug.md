# Under the rug

All aspects of the code that will need to be completed of corrected if we want to present it.

## Regarding fracture

- flat-intro is unconditionally postulated — should be crisp-context-only. The codebase already flags this (Cohesion.agda comment, memory note). In our intended analytic interpretation it's
known to be too strong: ¬-IsFlatModal-delooping directly contradicts having flat-intro : Bℤ → ♭(Bℤ) with ♭(Bℤ) = ℤ. So the synthetic axiomatization commits to more than the analytic model
can deliver. Not a contradiction in synthetic-land (synthetic land never names ♭(Bℤ) concretely), but a documented over-approximation.
- The hom-set adjunctions are postulated at type level. Diagnostically known to fail at (Bℤ, Bℤ) in the analytic model: (Bℤ → Bℤ) ≃ Bℤ × ℤ but (Bℤ → ♯Bℤ) is forced to ℤ once ♯ is identified
naively. Same over-approximation pattern.
- fracture itself. In real-cohesive HoTT it is a theorem (♯ is lex → ♭ preserves finite limits → fracture). We shortcut to the conclusion without taking on ♯-lex as a separate axiom. So
fracture is a consequence of axioms we haven't formalized but which are known to hold in the published model.
- ♯/ʃ idempotency and map-laws postulated rather than derived; same gap (no dependent ♯/ʃ-induction in Agda).
- Analytic test is weak. ℤ collapses everything to identity, so the analytic file doesn't exercise the postulate — it confirms non-vacuity in the degenerate case only. The case that would
test the postulate (Bℤ) is exactly what we cannot reach analytically. So fracture has been verified where it is trivial and asserted where it is interesting.

### Verdict

Fracture is trustworthy as a *postulate-relative theorem in an axiomatization known to be sound in real-cohesive HoTT* (Shulman 2018, Wellen, Myers). It is **not** trustworthy as a *plain HoTT* theorem; it is not even a derivation from the cohesion postulates we've stated — it is an added axiom we justify by citation. The analytic verification confirms the postulate's non-emptiness, not its non-trivial content. The biggest single risk lever in the chain is `flat-intro`, not `fracture`. Internal coherence is what Agda checks (no type errors, well-formed dependencies); soundness in any external model is an imported assumption.

A useful frame: we are building a *consistent axiomatic stance* and naming the geometric objects it commits to. The proof-checker confirms internal coherence; soundness comes from citation, not from our own work.

## Beyond fracture: the differential-cohesion gap

The de Rham target splits three ways once examined — the **de Rham depth ladder**, three levels distinguished by what each adds:

- **structural**: `ʃX → B` for arbitrary flat-modal `B`. Costless; just instantiates the ʃ ⊣ ♭ adjunction.
- **named-coefficient**: postulate `ℝ` as a cohesive type, then instantiate structural at `B := ♭ℝ`. Tautological as a "de Rham theorem" — de Rham cohomology is *defined* to be flat-ℝ cohomology, so the theorem reduces to its definition. Rhetorical packaging.
- **differential**: actual differential forms = `ℑX → ♭ℝ` (or via a refined hypercohomology construction), where `ℑ` is the **infinitesimal shape modality** — part of **differential cohesion**, a *separate* refinement of plain cohesion adding three new modalities, the triple `ℜ ⊣ ℑ ⊣ &` (reduction ⊣ infinitesimal shape ⊣ infinitesimal flat). Plain ♭/ʃ/♯ cannot see "differential" in the classical sense; that is exactly the gap differential cohesion was invented to fill.

Current plan goes structural → named-coefficient, aiming at differential. The named-coefficient result will look like the de Rham theorem in name but is tautologous. The *content-bearing* de Rham theorem — differential forms compute the same cohomology that flat-ℝ coefficients compute — requires the differential refinement. This is a *future* rug, not a current one: nothing in the structural / named-coefficient path will be wrong, but it will not have delivered what "de Rham theorem" normally means.

What an upgrade to the differential level would need:

- Three new modality postulates: `ℜ` (reduction) ⊣ `ℑ` (infinitesimal shape) ⊣ `&` (infinitesimal flat), with units/counits/induction principles, mirroring what Cohesion.agda + Adjunctions.agda already do for plain cohesion.
- A redefinition of differential forms in the cohesive setting as `ℑX → ♭ℝ` (or refined).
- The de Rham theorem proper: `(ℑX → ♭ℝ) ≃ (ʃX → ♭ℝ)` (or similar) — a statement that *is* content-bearing.

Scope: a separate phase, comparable in size to the entire plain-cohesion phase we have just finished.

**Under the three-track strategy:** the differential rung is deferred to `agda/AnalyticTest/` (see folder README); structural and named-coefficient remain on synthetic + `Analytic/`. The "future rug" framing above is updated accordingly — differential is deferred to a specific track, not indefinitely.