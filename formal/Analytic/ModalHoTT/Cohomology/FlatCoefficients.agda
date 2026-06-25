{-# OPTIONS --cubical --guardedness #-}

-- Analytic mirror of ModalHoTT.Cohomology.FlatCoefficients.
--
-- Place in the de Rham depth ladder: the structural level.
-- (See the synthetic file's header for the full three-level taxonomy
-- structural / named-coefficient / differential.)
--
-- What the analytic side records at this depth
-- ---------------------------------------------
-- At the structural level, the de Rham equivalence
--
--     (ShapeModality A → B) ≃ (A → B)     for B flat-modal
--
-- collapses on the analytic test types (ℤ and Bℤ) because both are
-- already shape-modal — ShapeOfIntegers = ℤ and
-- ShapeOfDeloopingOfIntegers = DeloopingOfIntegers definitionally.
-- So the analytic equivalence is idEquiv at both A = ℤ and A = Bℤ,
-- and it holds for *any* coefficient type B — no flatness hypothesis
-- is needed on this side.
--
-- That gap (analytic equivalence is stronger than the synthetic one
-- requires) is harmless. It reflects the analytic folder's role:
-- demonstrate non-vacuity, not validate the synthetic hypothesis set.
-- The real non-vacuity content at this depth is in the *statement*:
-- every statement here mentions ShapeModality (i.e. ʃ), which is not
-- statable in plain HoTT. The fact that both proofs reduce to idEquiv
-- on the test types does not weaken the separation claim — the claim
-- is about what can be *said*, not how hard the proof is on a given
-- instance.
--
-- No postulates.

module Analytic.ModalHoTT.Cohomology.FlatCoefficients where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv
open import Cubical.Data.Int using (ℤ)

open import Analytic.ModalHoTT.Modalities.Cohesion

private
  variable
    ℓ : Level

------------------------------------------------------------------------
-- Flat cohomology, analytic version.
--
-- Mirrors the synthetic definition for the two test types. Defined as
-- a plain function type out of the (definitionally identity) shape.
------------------------------------------------------------------------

FlatCohomology-integers : Type ℓ → Type ℓ
FlatCohomology-integers B = ShapeOfIntegers → B

FlatCohomology-delooping : Type ℓ → Type ℓ
FlatCohomology-delooping B = ShapeOfDeloopingOfIntegers → B

------------------------------------------------------------------------
-- Structural de Rham equivalence on the test types.
--
-- Both instances are idEquiv, because shape is identity on each test
-- type. Stronger than the synthetic statement: no flatness hypothesis
-- on B is required.
------------------------------------------------------------------------

-- ℤ: ShapeOfIntegers = ℤ, so flat cohomology of ℤ with any B is (ℤ → B).
flat-coefficients-factor-integers : {B : Type ℓ}
  → FlatCohomology-integers B ≃ (ℤ → B)
flat-coefficients-factor-integers = idEquiv _

-- Bℤ: ShapeOfDeloopingOfIntegers = DeloopingOfIntegers, so flat cohomology
-- of Bℤ with any B is (Bℤ → B). Same triviality as ℤ — Bℤ is already a
-- pure homotopy type, so ʃ acts as identity on it.
flat-coefficients-factor-delooping : {B : Type ℓ}
  → FlatCohomology-delooping B ≃ (DeloopingOfIntegers → B)
flat-coefficients-factor-delooping = idEquiv _
