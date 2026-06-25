{-# OPTIONS --cubical --guardedness #-}

-- Concrete instances of the cohesion modalities (♭, ʃ, ♯) for two types:
--
--   ℤ  — discrete; all three modalities are the identity.
--   Bℤ — DeloopingOfIntegers; non-discrete; ♭(Bℤ) = ℤ via the
--         universal cover. Bℤ is proved NOT flat-modal (first non-trivial
--         theorem in the analytic folder).
--
-- DeloopingOfIntegers is defined here as a HIT with one base point and
-- one generating path (translation-step). Integer deck transformations
-- are derived; Ω(Bℤ) ≃ ℤ is proved via the universal cover fibration.
--
-- Shape (ʃ) and sharp (♯) for Bℤ are deferred.
--
-- Diagnostic observations:
-- (1) flat-intro exists for ℤ (already discrete) but not for Bℤ:
--     any function Bℤ → ℤ is constant by connectedness, confirming
--     that the synthetic flat-intro postulate is a crisp-context
--     over-approximation.
-- (2) The modal conditions on shape-rec/sharp-rec are vacuous for ℤ;
--     those functions therefore accept any target type.
--
-- No postulates are used in this file.

module Analytic.ModalHoTT.Modalities.Cohesion where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv
open import Cubical.Foundations.Isomorphism
open import Cubical.Foundations.Univalence
open import Cubical.Foundations.Function
open import Cubical.Data.Nat using (ℕ; zero; suc)
open import Cubical.Data.Int
open import Cubical.Data.Empty using (⊥)

private
  variable
    ℓ : Level

------------------------------------------------------------------------
-- DeloopingOfIntegers (Bℤ)
--
-- One point, one generating path: the unit deck transformation (shift
-- by 1). All other deck transformations are derived as integer powers.
------------------------------------------------------------------------

data DeloopingOfIntegers : Type₀ where
  base-pt          : DeloopingOfIntegers
  translation-step : base-pt ≡ base-pt

deck : ℤ → base-pt ≡ base-pt
deck (pos zero)       = refl
deck (pos (suc n))    = deck (pos n) ∙ translation-step
deck (negsuc zero)    = sym translation-step
deck (negsuc (suc n)) = deck (negsuc n) ∙ sym translation-step

------------------------------------------------------------------------
-- Universal cover
------------------------------------------------------------------------

universal-cover : DeloopingOfIntegers → Type₀
universal-cover base-pt              = ℤ
universal-cover (translation-step i) = sucPathℤ i

private
  encode : (x : DeloopingOfIntegers) → base-pt ≡ x → universal-cover x
  encode x p = subst universal-cover p (pos zero)

winding-number : base-pt ≡ base-pt → ℤ
winding-number = encode base-pt

------------------------------------------------------------------------
-- Ω(Bℤ) ≃ ℤ
--
-- deck and winding-number are inverse isomorphisms.
-- (1) winding-number ∘ deck = id: by induction on ℤ.
-- (2) deck ∘ winding-number = id: by path induction (J).
------------------------------------------------------------------------

private
  deck-square : (n : ℤ)
    → PathP (λ i → base-pt ≡ translation-step i) (deck (predℤ n)) (deck n)
  deck-square (pos zero) i j =
    translation-step (i ∨ ~ j)
  deck-square (pos (suc n)) i j =
    hfill (λ k → λ { (j = i0) → base-pt
                   ; (j = i1) → translation-step k })
          (inS (deck (pos n) j)) i
  deck-square (negsuc n) i j =
    hfill (λ k → λ { (j = i0) → base-pt
                   ; (j = i1) → translation-step (~ k) })
          (inS (deck (negsuc n) j)) (~ i)

private
  lift-path : (x : DeloopingOfIntegers) → universal-cover x → base-pt ≡ x
  lift-path base-pt         = deck
  lift-path (translation-step i) y j =
    let n : ℤ
        n = unglue (i ∨ ~ i) y
    in hcomp (λ k → λ { (i = i0) → deck (predSuc y k) j
                      ; (i = i1) → deck y j
                      ; (j = i0) → base-pt
                      ; (j = i1) → translation-step i })
             (deck-square n i j)

winding-deck-id : (n : ℤ) → winding-number (deck n) ≡ n
winding-deck-id (pos zero)       = refl
winding-deck-id (pos (suc n))    = cong sucℤ (winding-deck-id (pos n))
winding-deck-id (negsuc zero)    = refl
winding-deck-id (negsuc (suc n)) = cong predℤ (winding-deck-id (negsuc n))

private
  lift-winding-id : (x : DeloopingOfIntegers) (p : base-pt ≡ x)
                  → lift-path x (encode x p) ≡ p
  lift-winding-id x p = J (λ y q → lift-path y (encode y q) ≡ q) (λ _ → refl) p

loop-space-Iso : Iso (base-pt ≡ base-pt) ℤ
Iso.fun loop-space-Iso = winding-number
Iso.inv loop-space-Iso = deck
Iso.sec loop-space-Iso = winding-deck-id
Iso.ret loop-space-Iso = lift-winding-id base-pt

loop-space-equiv : (base-pt ≡ base-pt) ≃ ℤ
loop-space-equiv = isoToEquiv loop-space-Iso

------------------------------------------------------------------------
-- Flat modality (♭) — instance for ℤ
--
-- ♭ℤ = ℤ. The counit and intro are both the identity; the induction
-- principle is trivial (function application).
------------------------------------------------------------------------

FlatOfIntegers : Type₀
FlatOfIntegers = ℤ

flat-counit-integers : FlatOfIntegers → ℤ
flat-counit-integers n = n

-- Exists because ℤ is already flat-modal (diagnostic observation 1).
flat-intro-integers : ℤ → FlatOfIntegers
flat-intro-integers n = n

flat-ind-integers : (B : FlatOfIntegers → Type ℓ)
                  → ((n : ℤ) → B (flat-intro-integers n))
                  → (u : FlatOfIntegers) → B u
flat-ind-integers B f u = f u

flat-ind-β-integers : (B : FlatOfIntegers → Type ℓ)
                      (f : (n : ℤ) → B (flat-intro-integers n)) (n : ℤ)
                    → flat-ind-integers B f n ≡ f n
flat-ind-β-integers B f n = refl

flat-counit-intro-integers : (n : ℤ)
                           → flat-counit-integers (flat-intro-integers n) ≡ n
flat-counit-intro-integers n = refl

IsFlatModal-integers : isEquiv flat-counit-integers
IsFlatModal-integers = idIsEquiv ℤ

------------------------------------------------------------------------
-- Shape modality (ʃ) — instance for ℤ
--
-- ʃℤ = ℤ. ℤ is discrete, so the unit is the identity. The universal
-- property holds for all target types (diagnostic observation 2).
------------------------------------------------------------------------

ShapeOfIntegers : Type₀
ShapeOfIntegers = ℤ

shape-unit-integers : ℤ → ShapeOfIntegers
shape-unit-integers n = n

IsShapeModal-integers : isEquiv shape-unit-integers
IsShapeModal-integers = idIsEquiv ℤ

shape-rec-integers : {B : Type ℓ} → (ℤ → B) → ShapeOfIntegers → B
shape-rec-integers f u = f u

shape-rec-β-integers : {B : Type ℓ} (f : ℤ → B) (n : ℤ)
                     → shape-rec-integers f n ≡ f n
shape-rec-β-integers f n = refl

------------------------------------------------------------------------
-- Sharp modality (♯) — instance for ℤ
--
-- ♯ℤ = ℤ. Dual to flat: ℤ is also trivially codiscrete. Same
-- observations as for ʃ apply.
------------------------------------------------------------------------

SharpOfIntegers : Type₀
SharpOfIntegers = ℤ

sharp-unit-integers : ℤ → SharpOfIntegers
sharp-unit-integers n = n

IsSharpModal-integers : isEquiv sharp-unit-integers
IsSharpModal-integers = idIsEquiv ℤ

sharp-rec-integers : {B : Type ℓ} → (ℤ → B) → SharpOfIntegers → B
sharp-rec-integers f u = f u

sharp-rec-β-integers : {B : Type ℓ} (f : ℤ → B) (n : ℤ)
                     → sharp-rec-integers f n ≡ f n
sharp-rec-β-integers f n = refl

------------------------------------------------------------------------
-- Flat modality (♭) — instance for Bℤ = DeloopingOfIntegers
--
-- ♭(Bℤ) = ℤ. The fiber of the universal cover at base-pt is ℤ, and the
-- deck transformations encode the ℤ-action. The counit ε : ℤ → Bℤ is
-- the constant map (Bℤ is connected; any map from a discrete type lands
-- at a single point).
--
-- flat-intro does NOT exist: any function Bℤ → ℤ is constant by
-- connectedness, confirming diagnostic observation (1).
--
-- Key result: Bℤ is NOT flat-modal — machine-checked.
------------------------------------------------------------------------

FlatOfDeloopingOfIntegers : Type₀
FlatOfDeloopingOfIntegers = ℤ

flat-counit-delooping : FlatOfDeloopingOfIntegers → DeloopingOfIntegers
flat-counit-delooping _ = base-pt

private
  -- Discriminator: inhabited at pos 0, empty elsewhere.
  posZero? : ℤ → Type₀
  posZero? (pos zero)    = ℕ
  posZero? (pos (suc _)) = ⊥
  posZero? (negsuc _)    = ⊥

¬-IsFlatModal-delooping : isEquiv flat-counit-delooping → ⊥
¬-IsFlatModal-delooping isE =
  let fiber-contr : isContr (fiber flat-counit-delooping base-pt)
      fiber-contr = equiv-proof isE base-pt
      eq : (pos 0 , refl) ≡ (pos 1 , refl {x = base-pt})
      eq = isContr→isProp fiber-contr _ _
      path : pos 0 ≡ pos 1
      path = cong fst eq
  in subst posZero? path zero

------------------------------------------------------------------------
-- Shape modality (ʃ) — instance for Bℤ = DeloopingOfIntegers
--
-- ʃ(Bℤ) ≃ Bℤ: Bℤ is shape-modal. This is trivial, but for a different
-- reason than ℤ's triviality:
--
--   ℤ is shape-modal because it is discrete — shape strips cohesive
--   structure and leaves a discrete type unchanged.
--
--   Bℤ is shape-modal because it is already a pure homotopy type (a HIT
--   with no extra smooth or cohesive structure to forget). Shape has
--   nothing to strip, so it leaves Bℤ unchanged.
--
-- Both instances are the identity, but they sit at opposite ends of the
-- modality spectrum: ℤ at the discrete end, Bℤ at the homotopy-theoretic
-- end. It is flat that distinguishes them: ℤ is flat-modal, Bℤ is not.
------------------------------------------------------------------------

ShapeOfDeloopingOfIntegers : Type₀
ShapeOfDeloopingOfIntegers = DeloopingOfIntegers

shape-unit-delooping : DeloopingOfIntegers → ShapeOfDeloopingOfIntegers
shape-unit-delooping x = x

IsShapeModal-delooping : isEquiv shape-unit-delooping
IsShapeModal-delooping = idIsEquiv DeloopingOfIntegers

------------------------------------------------------------------------
-- Sharp modality (♯) — instance for Bℤ: deferred
--
-- ♯ is the right adjoint to ♭. Computing ♯(Bℤ) concretely would require
-- to know what the codiscrete reflection of Bℤ looks like in the model
-- as currently constructed, and there's no analogous cubical construction
-- for that — no "universal cocover." Without a concrete handle on ♯(Bℤ),
-- we can't even state whether the sharp unit Bℤ → ♯(Bℤ) is an
-- equivalence, let alone prove or disprove it. The asymmetry is entirely
-- about proof tractability.
------------------------------------------------------------------------
