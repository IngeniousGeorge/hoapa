{-# OPTIONS --cubical --guardedness #-}

-- Cohesion modalities for modal HoTT, postulated as axioms.
--
-- Semantic background: the cohesive ∞-topos is modelled by the site Bℤ
-- (delooping of ℤ ≃ S¹ as ∞-groupoids, but foregrounding the algebraic/
-- covering structure of ℤ). The site is not an Agda type; the modalities
-- are axiomatic, justified by the Bℤ semantics.
--
-- Adjunctions (♭ ⊣ ♯, ʃ ⊣ ♭) are stubbed; see Adjunctions.agda.

module ModalHoTT.Modalities.Cohesion where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv
open import Cubical.Foundations.Function

private
  variable
    ℓ ℓ' : Level

------------------------------------------------------------------------
-- Flat modality (♭)
--
-- Semantics: ♭A is the "discrete cover" of A — the same underlying set
-- with the discrete topology. Comonadic: ♭♭A ≃ ♭A.
------------------------------------------------------------------------

postulate
  FlatModality : Type ℓ → Type ℓ

  -- ε : ♭A → A
  flat-counit : {A : Type ℓ} → FlatModality A → A

  -- [−] : A → ♭A  (crisp introduction; in real-cohesive HoTT this is only
  -- valid when the input is in a crisp context; postulated unconditionally
  -- here because Agda lacks native crisp-context support)
  flat-intro : {A : Type ℓ} → A → FlatModality A

  -- Comonadic induction: eliminate ♭A into a dependent type over ♭A.
  flat-ind : {A : Type ℓ} (B : FlatModality A → Type ℓ')
             → ((a : A) → B (flat-intro a))
             → (u : FlatModality A) → B u

  flat-ind-β : {A : Type ℓ} (B : FlatModality A → Type ℓ')
               (f : (a : A) → B (flat-intro a)) (a : A)
               → flat-ind B f (flat-intro a) ≡ f a

  -- In real-cohesive HoTT this holds definitionally (crisp η-rule for ♭).
  flat-counit-intro : {A : Type ℓ} (a : A) → flat-counit (flat-intro a) ≡ a

-- A type is flat-modal (discrete) when its counit is an equivalence.
IsFlatModal : Type ℓ → Type ℓ
IsFlatModal A = isEquiv (flat-counit {A = A})

------------------------------------------------------------------------
-- Shape modality (ʃ)
--
-- Semantics: ʃA is the "path-components" of A — the underlying homotopy
-- type, with topological cohesion stripped. Monadic (a localization).
------------------------------------------------------------------------

postulate
  ShapeModality : Type ℓ → Type ℓ

  -- η : A → ʃA
  shape-unit : {A : Type ℓ} → A → ShapeModality A

-- A type is shape-modal when its shape-unit is an equivalence.
IsShapeModal : Type ℓ → Type ℓ
IsShapeModal A = isEquiv (shape-unit {A = A})

postulate
  -- Non-dependent recursion: map out of ʃA into any shape-modal type.
  -- Dependent induction (for shape-modal fibrations) is deferred.
  shape-rec : {A : Type ℓ} {B : Type ℓ'}
              → IsShapeModal B
              → (A → B)
              → ShapeModality A → B

  shape-rec-β : {A : Type ℓ} {B : Type ℓ'}
                (Bm : IsShapeModal B) (f : A → B) (a : A)
                → shape-rec Bm f (shape-unit a) ≡ f a

------------------------------------------------------------------------
-- Sharp modality (♯)
--
-- Semantics: ♯A is the "codiscrete space" over A — maximal cohesion
-- imposed. Right adjoint to ♭ (adjunction stubbed below).
------------------------------------------------------------------------

postulate
  SharpModality : Type ℓ → Type ℓ

  -- η : A → ♯A
  sharp-unit : {A : Type ℓ} → A → SharpModality A

-- A type is sharp-modal when its sharp-unit is an equivalence.
IsSharpModal : Type ℓ → Type ℓ
IsSharpModal A = isEquiv (sharp-unit {A = A})

postulate
  -- Non-dependent recursion: map out of ♯A into any sharp-modal type.
  sharp-rec : {A : Type ℓ} {B : Type ℓ'}
              → IsSharpModal B
              → (A → B)
              → SharpModality A → B

  sharp-rec-β : {A : Type ℓ} {B : Type ℓ'}
                (Bm : IsSharpModal B) (f : A → B) (a : A)
                → sharp-rec Bm f (sharp-unit a) ≡ f a

------------------------------------------------------------------------
-- Adjunction stubs
--
-- These tie the three modalities into a genuine cohesive structure.
-- Deferred to Adjunctions.agda.
--
-- ♭ ⊣ ♯ : (FlatModality A → B) ≃ (A → SharpModality B)
-- ʃ ⊣ ♭ : (ShapeModality A → B) ≃ (A → B)   [for B flat-modal]
------------------------------------------------------------------------
