{-# OPTIONS --cubical --guardedness #-}

-- A concrete `SessionObjectModel` at the coefficient category
-- `Chu(SET, Bool)`: the Phase-1A inhabitant that makes the generic object
-- model and the duality theorem `J0-dual` non-vacuous.
--
-- It is deliberately modest. `end` is interpreted by a simple *self-dual*
-- Chu object — positive and negative carriers both `Bool`, with the
-- constant pairing `λ _ _ → true`. Because `dual` swaps carriers and flips
-- the pairing, and the pairing here is symmetric *definitionally*, this
-- object is its own dual on the nose, so the required self-dual iso is the
-- identity. Payloads are interpreted *non-constantly* (the two tags go to
-- two genuinely different Chu objects). Concrete send/receive payload
-- semantics are Phase 2; this file only inhabits the object-level
-- interface.
--
-- Discipline: imports the postulate-free Chu stack and `SessionObjectModel`;
-- it does NOT import `Sessions.agda`.

module Concurrency.Algebras.SessionChuModel where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.HLevels using (hSet)
open import Cubical.Data.Bool using (Bool ; true ; false ; isSetBool)

open import Concurrency.Algebras.Chu using (module Construction)
open import Concurrency.Algebras.ChuMonoidal using (module Monoidal)
open import Concurrency.Hybrid.ChuPointVProd using (Chu-SA-HasFiniteProducts)
open import Concurrency.Algebras.StarAutonomous using (StarAutonomous)
open import Concurrency.Algebras.SessionSyntax using (module Syntax)
open import Concurrency.Algebras.SessionMorphismSyntax using (module Morph)
open import Concurrency.Algebras.SessionObjectModel using (module Model)

-- The two-element dualizing object.
kBool : hSet ℓ-zero
kBool = Bool , isSetBool

open Construction kBool using (ChuObj)
open Monoidal kBool using (Chu-StarAutonomous ; chuUnit)
open StarAutonomous Chu-StarAutonomous using (_^⊥ ; Hom)
open Model Bool Chu-StarAutonomous

----------------------------------------------------------------------
-- The interpreting data.
----------------------------------------------------------------------

-- A self-dual Chu object: both carriers `Bool`, constant pairing. Its
-- dual `(neg, pos, λ b a → r a b)` is `(Bool, Bool, λ _ _ → true)`, i.e.
-- itself, definitionally.
end-chu : ChuObj
end-chu = (Bool , isSetBool) , (Bool , isSetBool) , (λ _ _ → true)

-- Non-constant payload interpretation: the two tags go to two distinct
-- Chu objects (the unit, with positive carrier `Unit*`, and `end-chu`,
-- with positive carrier `Bool`).
payload-chu : Bool → ChuObj
payload-chu true  = chuUnit
payload-chu false = end-chu

Sessions-Chu : SessionObjectModel
Sessions-Chu = record
  { hasProducts = Chu-SA-HasFiniteProducts kBool
  ; end-obj     = end-chu
  ; payload-obj = payload-chu
  ; end-self    = id≅
  }

----------------------------------------------------------------------
-- Sanity checks: the fold and the duality theorem compute at the
-- concrete model on representative session types.
----------------------------------------------------------------------

private
  open Syntax Bool
  open Interpretation Sessions-Chu

  -- The interpretation lands in Chu objects.
  _ : ChuObj
  _ = J0 (send true (recv false end))

  -- The duality theorem is inhabited at a concrete session type.
  _ : J0 ((send true end ⊗ recv false 𝟙ₛ) ^⊥ₛ)
        ≅ (J0 (send true end ⊗ recv false 𝟙ₛ) ^⊥)
  _ = J0-dual (send true end ⊗ recv false 𝟙ₛ)

  -- An additive example, to exercise the &ₛ / ⊕ₛ duality clauses.
  _ : J0 ((end &ₛ 𝟙ₛ) ^⊥ₛ) ≅ (J0 (end &ₛ 𝟙ₛ) ^⊥)
  _ = J0-dual (end &ₛ 𝟙ₛ)

  -- J1 specializes here too: a structural morphism and a duality
  -- morphism (the latter exercising the `dualconj` interpretation) both
  -- land as concrete Chu morphisms.
  open Morph Bool

  _ : Hom (J0 (end ⊗ 𝟙ₛ)) (J0 (𝟙ₛ ⊗ end))
  _ = J1 (braid-h {end} {𝟙ₛ})

  _ : Hom (J0 (end ^⊥ₛ)) (J0 (end ^⊥ₛ))
  _ = J1 (dual-h (id-h {end}))
