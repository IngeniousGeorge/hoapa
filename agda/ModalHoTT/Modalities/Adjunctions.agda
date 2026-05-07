{-# OPTIONS --cubical --guardedness #-}

-- Adjunctions ♭ ⊣ ♯ and ʃ ⊣ ♭ for the three cohesion modalities.
--
-- Each adjunction is a postulated hom-set equivalence, with a coherence
-- condition tying it to the existing modality structure in Cohesion.agda.
-- Named transpose operations are derived as definitions from those equivalences.
--
-- Idempotency:
--   IsFlatModal  (FlatModality A)   proved as a theorem via flat-counit-intro
--   IsSharpModal (SharpModality A)  postulated (derivation requires ♯-ind)
--   IsShapeModal (ShapeModality A)  postulated (derivation requires ʃ-ind)

module ModalHoTT.Modalities.Adjunctions where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv
open import Cubical.Foundations.Function
open import Cubical.Foundations.Isomorphism

open import ModalHoTT.Modalities.Cohesion

private
  variable
    ℓ ℓ' : Level

------------------------------------------------------------------------
-- Adjunction ♭ ⊣ ♯
--
-- (♭A → B) ≃ (A → ♯B), naturally in A and B.
-- Coherence: flat-counit : ♭A → A transposes to sharp-unit : A → ♯A.
------------------------------------------------------------------------

postulate
  flat-sharp-transpose : {A : Type ℓ} {B : Type ℓ'}
    → (FlatModality A → B) ≃ (A → SharpModality B)

  flat-sharp-counit-compat : {A : Type ℓ}
    → equivFun (flat-sharp-transpose {A = A} {B = A}) flat-counit ≡ sharp-unit

flat-to-sharp : {A : Type ℓ} {B : Type ℓ'}
  → (FlatModality A → B) → (A → SharpModality B)
flat-to-sharp = equivFun flat-sharp-transpose

sharp-to-flat : {A : Type ℓ} {B : Type ℓ'}
  → (A → SharpModality B) → (FlatModality A → B)
sharp-to-flat = invEq flat-sharp-transpose

flat-sharp-retract : {A : Type ℓ} {B : Type ℓ'} (f : FlatModality A → B)
  → sharp-to-flat (flat-to-sharp f) ≡ f
flat-sharp-retract f = retEq flat-sharp-transpose f

flat-sharp-section : {A : Type ℓ} {B : Type ℓ'} (g : A → SharpModality B)
  → flat-to-sharp (sharp-to-flat g) ≡ g
flat-sharp-section g = secEq flat-sharp-transpose g

------------------------------------------------------------------------
-- Adjunction ʃ ⊣ ♭
--
-- (ʃA → B) ≃ (A → ♭B), naturally in A and B.
-- Coherence: the adjunction unit A → ♭(ʃA) (transpose of id : ʃA → ʃA)
-- equals flat-intro ∘ shape-unit.
------------------------------------------------------------------------

postulate
  shape-flat-transpose : {A : Type ℓ} {B : Type ℓ'}
    → (ShapeModality A → B) ≃ (A → FlatModality B)

  shape-flat-adj-unit-eq : {A : Type ℓ}
    → equivFun (shape-flat-transpose {A = A} {B = ShapeModality A}) (λ u → u)
    ≡ flat-intro ∘ shape-unit

shape-to-flat : {A : Type ℓ} {B : Type ℓ'}
  → (ShapeModality A → B) → (A → FlatModality B)
shape-to-flat = equivFun shape-flat-transpose

flat-to-shape : {A : Type ℓ} {B : Type ℓ'}
  → (A → FlatModality B) → (ShapeModality A → B)
flat-to-shape = invEq shape-flat-transpose

shape-flat-retract : {A : Type ℓ} {B : Type ℓ'} (f : ShapeModality A → B)
  → flat-to-shape (shape-to-flat f) ≡ f
shape-flat-retract f = retEq shape-flat-transpose f

shape-flat-section : {A : Type ℓ} {B : Type ℓ'} (g : A → FlatModality B)
  → shape-to-flat (flat-to-shape g) ≡ g
shape-flat-section g = secEq shape-flat-transpose g

------------------------------------------------------------------------
-- Idempotency
------------------------------------------------------------------------

-- ♭ is idempotent: ♭A is always flat-modal.
-- Proof: build an explicit Iso using flat-counit-intro (rightInv) and
-- flat-ind to extend it to leftInv.
flat-modality-idempotent : {A : Type ℓ} → IsFlatModal (FlatModality A)
flat-modality-idempotent {A = A} = isoToEquiv theIso .snd
  where
    leftInv-proof : (u : FlatModality (FlatModality A))
                  → flat-intro (flat-counit u) ≡ u
    leftInv-proof =
      flat-ind {A = FlatModality A} _
               (λ a → cong flat-intro (flat-counit-intro a))

    theIso : Iso (FlatModality (FlatModality A)) (FlatModality A)
    theIso = iso flat-counit flat-intro flat-counit-intro leftInv-proof

-- ♯ is idempotent: ♯A is always sharp-modal.
-- Follows from ♭ ⊣ ♯ in the Bℤ model; derivation in the synthetic setting
-- requires dependent elimination for ♯ (deferred; see status.md).
postulate
  sharp-modality-idempotent : {A : Type ℓ} → IsSharpModal (SharpModality A)

-- ʃ is idempotent: ʃA is always shape-modal.
-- Follows from ʃ ⊣ ♭ in the Bℤ model; derivation requires ʃ-ind (deferred).
postulate
  shape-modality-idempotent : {A : Type ℓ} → IsShapeModal (ShapeModality A)
