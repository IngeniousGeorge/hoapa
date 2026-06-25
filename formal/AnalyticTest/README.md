# AnalyticTest — placeholder

Reserved for a third track in the project, distinct from `agda/ModalHoTT/` (synthetic, primary target) and `agda/Analytic/` (mirror, documentation). Empty except for this README; work here is deferred.

## Motivation

The `Analytic/` mirror has known structural limits — no concrete `♯(Bℤ)` in cubical Agda, type-level adjunctions failing diagnostically at `(Bℤ, Bℤ)`, ℤ-instances collapsing modalities to identity. Its role has settled as documentation, not test suite. AnalyticTest is reserved for the test-suite role the mirror cannot carry: a model where the cohesion modalities have concrete, computable content.

## Function

A concrete lower-dimensional model where `ʃ ⊣ ♭ ⊣ ♯` are computable functors with non-trivial instances. The natural candidate is the topos of ℤ-Sets (presheaves on Bℤ, externally), but the choice is held open until work begins. The track is *not* required to mirror the synthetic file structure — it is allowed to find its own natural form. At completion, a one-way interpretation functor (analytic→synthetic) translates its results into instances of synthetic theorems; no reverse direction needed.

## Planning

Parallel to the synthetic track once started. Accepted trade-off: a 1-topos slice of the full ∞-topos picture in exchange for computational backing. The interpretation functor at the end is the soundness contract — it is what makes the truncated results usable for the synthetic theory.

## Why delayed

Starting requires that the synthetic-side postulate signature has stabilized. Adding modalities or changing postulates upstream would force rebuilds here. The trigger is signature stability, not arc completion (T1–T7).
