{-# OPTIONS --cubical --guardedness #-}

-- Analytic functoriality of ♭, ʃ, ♯ for ℤ and Bℤ.
--
-- For ℤ all three modalities are the identity (FlatOfIntegers =
-- ShapeOfIntegers = SharpOfIntegers = ℤ), so every map reduces to
-- function application and every law reduces to refl. The file is a
-- structural completeness check; there is no mathematical content here
-- beyond what is already in Cohesion.agda.
--
-- For Bℤ:
--   ♭ — flat-map is blocked; see section comment.
--   ʃ — trivial: ShapeOfDeloopingOfIntegers = DeloopingOfIntegers, so
--       shape-map f = f and both laws are refl.
--   ♯ — deferred; SharpOfDeloopingOfIntegers is not defined.
--
-- No postulates are used in this file.

module Analytic.ModalHoTT.Modalities.Properties where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Function
open import Cubical.Data.Int

open import Analytic.ModalHoTT.Modalities.Cohesion

------------------------------------------------------------------------
-- Flat modality — functoriality for ℤ
------------------------------------------------------------------------

flat-map-integers : (ℤ → ℤ) → FlatOfIntegers → FlatOfIntegers
flat-map-integers f n = f n

flat-map-id-integers : (n : FlatOfIntegers) → flat-map-integers (λ k → k) n ≡ n
flat-map-id-integers _ = refl

flat-map-comp-integers : (f g : ℤ → ℤ) (n : FlatOfIntegers)
  → flat-map-integers (g ∘ f) n ≡ flat-map-integers g (flat-map-integers f n)
flat-map-comp-integers _ _ _ = refl

------------------------------------------------------------------------
-- Shape modality — functoriality for ℤ
------------------------------------------------------------------------

shape-map-integers : (ℤ → ℤ) → ShapeOfIntegers → ShapeOfIntegers
shape-map-integers f n = f n

shape-map-id-integers : (n : ShapeOfIntegers) → shape-map-integers (λ k → k) n ≡ n
shape-map-id-integers _ = refl

shape-map-comp-integers : (f g : ℤ → ℤ) (n : ShapeOfIntegers)
  → shape-map-integers (g ∘ f) n ≡ shape-map-integers g (shape-map-integers f n)
shape-map-comp-integers _ _ _ = refl

------------------------------------------------------------------------
-- Sharp modality — functoriality for ℤ
------------------------------------------------------------------------

sharp-map-integers : (ℤ → ℤ) → SharpOfIntegers → SharpOfIntegers
sharp-map-integers f n = f n

sharp-map-id-integers : (n : SharpOfIntegers) → sharp-map-integers (λ k → k) n ≡ n
sharp-map-id-integers _ = refl

sharp-map-comp-integers : (f g : ℤ → ℤ) (n : SharpOfIntegers)
  → sharp-map-integers (g ∘ f) n ≡ sharp-map-integers g (sharp-map-integers f n)
sharp-map-comp-integers _ _ _ = refl

------------------------------------------------------------------------
-- Flat modality — Bℤ: flat-map is blocked
--
-- The synthetic flat-map derives as flat-ind (λ _ → ♭B) (flat-intro ∘ f).
-- That derivation requires flat-intro: to send a : A into ♭A. For Bℤ,
-- flat-intro does not exist — any function Bℤ → ℤ is constant by
-- connectedness, which is precisely what ¬-IsFlatModal-delooping
-- witnesses. The synthetic route to flat-map therefore fails in the
-- analytic model for Bℤ, not just for the laws but for the definition
-- itself. The mirroring breaks exactly where flat-intro breaks.
------------------------------------------------------------------------

------------------------------------------------------------------------
-- Shape modality — functoriality for Bℤ
--
-- ShapeOfDeloopingOfIntegers = DeloopingOfIntegers, so shape-map f = f.
------------------------------------------------------------------------

shape-map-delooping : (DeloopingOfIntegers → DeloopingOfIntegers)
                    → ShapeOfDeloopingOfIntegers → ShapeOfDeloopingOfIntegers
shape-map-delooping f x = f x

shape-map-id-delooping : (x : ShapeOfDeloopingOfIntegers)
  → shape-map-delooping (λ y → y) x ≡ x
shape-map-id-delooping _ = refl

shape-map-comp-delooping : (f g : DeloopingOfIntegers → DeloopingOfIntegers)
  (x : ShapeOfDeloopingOfIntegers)
  → shape-map-delooping (g ∘ f) x ≡ shape-map-delooping g (shape-map-delooping f x)
shape-map-comp-delooping _ _ _ = refl

------------------------------------------------------------------------
-- Sharp modality — Bℤ: deferred
--
-- SharpOfDeloopingOfIntegers is not defined; see Cohesion.agda.
------------------------------------------------------------------------
