{-# OPTIONS --cubical --guardedness #-}

-- Analytic verification of the fracture theorem for ℤ.
--
-- The synthetic file `ModalHoTT.Modalities.Fracture` postulates that the
-- canonical map ♭A → FracturePullback A is an equivalence for every type A.
-- This file discharges that claim for A := ℤ, with zero postulates.
--
-- For ℤ all three modalities are the identity, so the pullback
--
--     Σ[ n ∈ ℤ ] Σ[ m ∈ ℤ ] sharp-unit-integers n ≡ flat-counit-integers m
--
-- collapses definitionally to Σ[ n ∈ ℤ ] singl n — the total space of the
-- based singleton at n. The total space of a contractible fibration is the
-- base, so the projection to ℤ is an equivalence, and the canonical map
-- (its inverse n ↦ (n, n, refl)) is too. The proof routes through
-- `isContrSingl` from Prelude.
--
-- Bℤ excluded: `SharpOfDeloopingOfIntegers` is not defined in
-- `Analytic.ModalHoTT.Modalities.Cohesion` (no cubical construction for
-- the codiscrete reflection of Bℤ), so the pullback type cannot even be
-- stated at A := Bℤ. The fracture instance at Bℤ remains a synthetic-only
-- commitment until ♯(Bℤ) becomes available (crisp contexts / real-cohesive
-- HoTT; see status.md).

module Analytic.ModalHoTT.Modalities.Fracture where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv
open import Cubical.Foundations.Isomorphism
open import Cubical.Data.Int

open import Analytic.ModalHoTT.Modalities.Cohesion

------------------------------------------------------------------------
-- The pullback type for ℤ
--
-- Stated with the actual modality functions for ℤ; since both are the
-- identity, the type reduces definitionally to Σ[ n ∈ ℤ ] singl n.
------------------------------------------------------------------------

FracturePullbackIntegers : Type₀
FracturePullbackIntegers =
  Σ[ n ∈ ℤ ] Σ[ m ∈ ℤ ] sharp-unit-integers n ≡ flat-counit-integers m

------------------------------------------------------------------------
-- The canonical map
--
-- Mirrors the synthetic `flat-to-pullback` at A := ℤ. Sends n to
-- (n, n, refl) — both projections agree on n, and `refl` witnesses
-- commutativity of the (trivial) square at this point.
------------------------------------------------------------------------

flat-to-pullback-integers : FlatOfIntegers → FracturePullbackIntegers
flat-to-pullback-integers n = n , n , refl

------------------------------------------------------------------------
-- The equivalence
--
-- Build an Iso with `fst` as the inverse, then convert with `isoToEquiv`.
--
--   * `ret` (n : ℤ): fst (n, n, refl) ≡ n — definitional, hence `refl`.
--   * `sec` ((n, m, p) : Pullback): (n, n, refl) ≡ (n, m, p) — for fixed
--     outer n, the inner Σ is exactly `singl n`, and the path is supplied
--     by `isContrSingl n .snd (m, p)`. We lift it pointwise into the
--     outer Σ.
------------------------------------------------------------------------

private
  fracture-Iso-integers : Iso FlatOfIntegers FracturePullbackIntegers
  Iso.fun fracture-Iso-integers = flat-to-pullback-integers
  Iso.inv fracture-Iso-integers = fst
  Iso.sec fracture-Iso-integers x i =
    fst x , isContrSingl (fst x) .snd (snd x) i
  Iso.ret fracture-Iso-integers _ = refl

IsFracture-integers : isEquiv flat-to-pullback-integers
IsFracture-integers = isoToEquiv fracture-Iso-integers .snd

------------------------------------------------------------------------
-- The equivalence form
--
-- Mirrors `fracture-equiv` on the synthetic side.
------------------------------------------------------------------------

fracture-equiv-integers : FlatOfIntegers ≃ FracturePullbackIntegers
fracture-equiv-integers = flat-to-pullback-integers , IsFracture-integers
