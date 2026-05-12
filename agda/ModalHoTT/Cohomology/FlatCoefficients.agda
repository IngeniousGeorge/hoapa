{-# OPTIONS --cubical --guardedness #-}

-- Flat-coefficient cohomology — the structural level of the de Rham depth ladder.
--
-- The "de Rham depth" ladder names three levels of the de Rham / separation
-- arc, distinguished by what each level adds on top of the previous one:
--
--   structural        — only the existing ʃ ⊣ ♭ adjunction; no new postulates.
--                       The separation result is real but carries no geometric
--                       content beyond modal algebra. *This file.*
--
--   named-coefficient — adds a postulated cohesive type ℝ and instantiates
--                       at ♭ℝ. The statement names reals but is tautological:
--                       de Rham cohomology *is* flat-ℝ cohomology by
--                       definition. (Future file.)
--
--   differential      — adds the differential-cohesion modalities (the
--                       triple ℜ ⊣ ℑ ⊣ &) and identifies differential forms
--                       as ℑX → ♭ℝ. The de Rham theorem then becomes
--                       content-bearing: forms compute flat-ℝ cohomology.
--                       (A separate phase, comparable in size to plain
--                       cohesion. Out of scope here.)
--
-- The separation content already lives at the structural level: every
-- statement here mentions ʃ and IsFlatModal, neither of which is statable
-- in plain HoTT. The arc target (T7) — exhibit something statable in
-- cohesive HoTT but not in plain HoTT — is witnessed by this file.

module ModalHoTT.Cohomology.FlatCoefficients where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv
open import Cubical.Foundations.Function
open import Cubical.Foundations.Isomorphism

open import ModalHoTT.Modalities.Cohesion
open import ModalHoTT.Modalities.Adjunctions

private
  variable
    ℓ ℓ' : Level

------------------------------------------------------------------------
-- Cohomology with flat coefficients.
--
-- For a coefficient type B, the flat cohomology of A with values in B
-- is the type of maps out of the homotopy shape of A. Reading: "B-valued
-- data on ʃA".
------------------------------------------------------------------------

FlatCohomology : Type ℓ → Type ℓ' → Type (ℓ-max ℓ ℓ')
FlatCohomology A B = ShapeModality A → B

------------------------------------------------------------------------
-- The structural de Rham equivalence.
--
-- When B is flat-modal, flat cohomology of A with values in B agrees
-- with the plain function type A → B. Proof: the ʃ ⊣ ♭ adjunction gives
-- (ʃA → B) ≃ (A → ♭B); when ♭B ≃ B (the IsFlatModal hypothesis),
-- post-composing on the right with that equivalence finishes.
--
-- No new postulates: the equivalence is built entirely from
-- shape-flat-transpose and flat-counit.
--
-- Note: the resulting map (ʃA → B) → (A → B) is determined by the
-- composition shape-flat-transpose followed by post-composition with
-- flat-counit; it is not pinned here to the more obvious precomposition
-- f ↦ f ∘ shape-unit. Showing those agree would require either
-- naturality of the adjunction in B (currently postulated only as a
-- bare equivalence; see status.md Open Questions) or the bridge
-- IsFlatModal ↔ IsShapeModal (also Open Questions). Pinning can be
-- added if a downstream use forces it.
------------------------------------------------------------------------

flat-coefficients-factor : {A : Type ℓ} {B : Type ℓ'}
  → IsFlatModal B
  → FlatCohomology A B ≃ (A → B)
flat-coefficients-factor {A = A} {B = B} Bm =
  compEquiv shape-flat-transpose postcompose-counit
  where
    counit-equiv : FlatModality B ≃ B
    counit-equiv = flat-counit , Bm

    postcompose-counit : (A → FlatModality B) ≃ (A → B)
    postcompose-counit = isoToEquiv (iso
      (λ f → flat-counit ∘ f)
      (λ g → invEq counit-equiv ∘ g)
      (λ g → funExt (λ a → secEq counit-equiv (g a)))
      (λ f → funExt (λ a → retEq counit-equiv (f a))))
