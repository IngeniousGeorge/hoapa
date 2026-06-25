{-# OPTIONS --cubical --guardedness #-}

-- Status: IMPORTED by `Modalities/IterationCohesion.agda` (2026-05-16).
--
-- The bridge was originally queued to support pinning the structural
-- de Rham map in Cohomology/FlatCoefficients.agda. On working through
-- the pinning derivation, naturality of `shape-flat-transpose` in B
-- turned out to be the load-bearing piece, not the bridge — so this
-- file's two postulates were initially held in reserve. They are now
-- used in `IterationCohesion.agda` to derive that `T A = ♭(ʃ A)` is
-- shape-modal (via `flat-modal-to-shape-modal`) and that `ʃ(T A)` is
-- flat-modal (via `shape-modal-to-flat-modal`), which together give
-- the first-level collapse of T_recursion's iteration. They remain
-- independently well-motivated for ♯-side work later.
--
-- Coincidence of the discrete and shape-modal type classes.
--
-- In any cohesive ∞-topos, the types fixed by the flat modality
-- (♭A ≃ A) and the types fixed by the shape modality (A ≃ ʃA)
-- pick out the same class — the "discrete" types. Synthetically,
-- this is a structural fact of cohesion, postulated here in the
-- same idiom as `shape-modality-idempotent` and
-- `sharp-modality-idempotent` in Adjunctions.agda: true in the
-- intended (real-cohesive) model, blocked from derivation by the
-- current synthetic infrastructure.
--
-- Why neither direction is derived synthetically
-- ----------------------------------------------
-- Both directions hit a gap already documented in status.md and
-- rug.md:
--
--   * `flat-modal-to-shape-modal` — would need uniqueness of
--     factorization through `shape-unit` (dependent ʃ-induction),
--     which is absent. `shape-rec` only handles the non-dependent
--     case, so even with B flat-modal we cannot show
--     `shape-rec _ (f ∘ shape-unit) ≡ f` for arbitrary f.
--
--   * `shape-modal-to-flat-modal` — would need the crisp η-rule
--     `flat-intro ∘ flat-counit ≡ id` on ♭A. Only the reverse
--     `flat-counit ∘ flat-intro ≡ id` (flat-counit-intro) is
--     available; in crisp-context HoTT the missing direction holds
--     definitionally.
--
-- Both are theorems in real-cohesive HoTT (Shulman 2018, Wellen,
-- Myers). The project's stance — postulate-relative theorem in an
-- axiomatization known to be sound — is articulated in rug.md.
--
-- Downstream
-- ----------
-- Used by Cohomology/FlatCoefficients.agda to pin the structural
-- de Rham equivalence to precomposition with `shape-unit`.

module ModalHoTT.Modalities.Discrete where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv

open import ModalHoTT.Modalities.Cohesion

private
  variable
    ℓ : Level

postulate
  -- A flat-modal type is shape-modal.
  -- Synthetic blocker: dependent ʃ-induction.
  flat-modal-to-shape-modal : {A : Type ℓ} → IsFlatModal A → IsShapeModal A

  -- A shape-modal type is flat-modal.
  -- Synthetic blocker: crisp η-rule for ♭ (`flat-intro ∘ flat-counit ≡ id`).
  shape-modal-to-flat-modal : {A : Type ℓ} → IsShapeModal A → IsFlatModal A
