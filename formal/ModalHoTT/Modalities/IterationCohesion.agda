{-# OPTIONS --cubical --guardedness #-}

-- Sanity check: instantiate the generic Iteration module with the A-side
-- ʃ ⊣ ♭ adjunction. Confirms the scaffold composes with the existing
-- cohesion postulates, and uses the held-in-reserve `Discrete.agda` bridge
-- to derive the first-level collapse of the iteration.
--
-- For T_recursion (workflow/targets.md): the "Iteration-alone layer"
-- sanity check — verifies the scaffold gives the expected (collapsing)
-- answer on the (fixed-point-rich) A-side. The cross-site case (where
-- iteration has content) is downstream of Concurrency-side scoping.
--
-- What this file checks:
--   • The generic Iteration module instantiates with ʃ ⊣ ♭'s data.
--   • T computes to ♭ ∘ ʃ definitionally.
--   • η^_1 computes to flat-intro ∘ shape-unit (the adjunction unit per
--     `shape-flat-adj-unit-eq` in Adjunctions.agda).
--   • Using Discrete.agda's bridge: T A = ♭(ʃ A) is shape-modal, and
--     consequently the next iterated unit `η_{T A} : T A → T(T A)` is
--     an equivalence — the iteration collapses at the first level.
--
-- What this file does NOT (yet) check:
--   • Full ND A ≃ T A as the colimit's actual value. That additionally
--     requires a sequential-colimit convergence lemma; the first-level
--     step proved here is the essential ingredient. Left as a follow-up
--     if a downstream use demands it.
--   • Concrete value at A := Bℤ. The synthetic side does not name Bℤ
--     as an Agda type; the analytic side has its own complications with
--     ♭(Bℤ) (see `future_work.md` "Regarding fracture"). A separate
--     analytic-side specialization is the right place for that.
--
-- Note on the synthetic over-approximation:
-- ----------------------------------------
-- This file uses `Discrete.agda`'s bridge, which is the first place in
-- the project that imports it. The bridge is independently motivated
-- (status.md Open Questions) and held in reserve elsewhere. Using it
-- here is local: nothing outside this file depends on its postulates.

module ModalHoTT.Modalities.IterationCohesion where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv
open import Cubical.Foundations.Isomorphism

open import ModalHoTT.Modalities.Cohesion
open import ModalHoTT.Modalities.Adjunctions
open import ModalHoTT.Modalities.Properties
open import ModalHoTT.Modalities.Discrete
open import ModalHoTT.Modalities.Iteration

private
  variable
    ℓ : Level

------------------------------------------------------------------------
-- Specialize the generic Iteration module to ʃ ⊣ ♭
--
-- L     = ShapeModality       (ʃ : Type ℓ → Type ℓ)
-- R     = FlatModality        (♭ : Type ℓ → Type ℓ)
-- L-map = shape-map
-- R-map = flat-map
-- η     = flat-intro ∘ shape-unit
--         (the adjunction's unit; transpose of id : ʃA → ʃA per
--          `shape-flat-adj-unit-eq` in Adjunctions.agda.)
------------------------------------------------------------------------

module ʃ⊣♭ {ℓ : Level} where
  open Iteration {ℓ = ℓ} {ℓ' = ℓ}
    ShapeModality FlatModality
    shape-map flat-map
    (λ a → flat-intro (shape-unit a))
    public

------------------------------------------------------------------------
-- Computational sanity (refl-level)
------------------------------------------------------------------------

-- T is exactly the monad ♭ ∘ ʃ on the source side.
T-as-flat-shape : (A : Type ℓ) → ʃ⊣♭.T A ≡ FlatModality (ShapeModality A)
T-as-flat-shape A = refl

-- η^_1 unfolds to the adjunction unit `flat-intro ∘ shape-unit`.
-- (Mixfix `η^_` is greedy; parens around `η^ 1` keep the parser happy.)
η^1-is-unit : {A : Type ℓ} (a : A) → (ʃ⊣♭.η^ 1) a ≡ flat-intro (shape-unit a)
η^1-is-unit a = refl

------------------------------------------------------------------------
-- First-level collapse via Discrete.agda bridge
------------------------------------------------------------------------

-- Helper: flat-intro on a flat-modal type is an equivalence.
-- When flat-counit is an equivalence, its definitional right-inverse
-- `flat-intro` (via `flat-counit-intro`) is also a left-inverse, hence
-- the two-sided inverse. Proven by an inline injectivity argument using
-- the retEq of the flat-counit equivalence.
flat-intro-equiv : {A : Type ℓ} → IsFlatModal A → isEquiv (flat-intro {A = A})
flat-intro-equiv {A = A} AfM = isoToIsEquiv theIso
  where
    e : FlatModality A ≃ A
    e = (flat-counit , AfM)

    flat-counit-inj : {x y : FlatModality A}
                    → flat-counit x ≡ flat-counit y → x ≡ y
    flat-counit-inj {x = x} {y = y} p =
      sym (retEq e x) ∙ cong (invEq e) p ∙ retEq e y

    leftInv : (u : FlatModality A) → flat-intro (flat-counit u) ≡ u
    leftInv u = flat-counit-inj (flat-counit-intro (flat-counit u))

    theIso : Iso A (FlatModality A)
    theIso = iso flat-intro flat-counit leftInv flat-counit-intro

-- T A = ♭(ʃ A) is flat-modal (`flat-modality-idempotent`).
T-is-flat-modal : (A : Type ℓ) → IsFlatModal (ʃ⊣♭.T A)
T-is-flat-modal A = flat-modality-idempotent

-- T A is shape-modal via the Discrete.agda bridge.
T-is-shape-modal : (A : Type ℓ) → IsShapeModal (ʃ⊣♭.T A)
T-is-shape-modal A = flat-modal-to-shape-modal (T-is-flat-modal A)

-- The first iterate-step is an equivalence:  T A ≃ T (T A) via η_{T A}.
--
-- Decomposes as
--   T A --shape-unit--> ʃ(T A) --flat-intro--> ♭(ʃ(T A)) = T(T A),
-- both factors of which are equivalences:
--   • shape-unit_{T A}     since T A is shape-modal (above);
--   • flat-intro_{ʃ(T A)}  since ʃ(T A) is flat-modal (shape-modality-
--                          idempotent + the bridge).
η-equiv-at-T : (A : Type ℓ) → ʃ⊣♭.T A ≃ ʃ⊣♭.T (ʃ⊣♭.T A)
η-equiv-at-T A =
  compEquiv (shape-unit , T-is-shape-modal A)
            (flat-intro , flat-intro-equiv
                            (shape-modal-to-flat-modal
                               (shape-modality-idempotent {A = ʃ⊣♭.T A})))

-- The forward map of the collapse equivalence is exactly the
-- structure map of the iteration sequence at T A (= `flat-intro ∘
-- shape-unit` = the adjunction unit applied at T A).
-- (Pin: confirms the equivalence we built really is the structure map.
-- Note: the underlying η lives as a module parameter of `Iteration`,
-- which `open ... public` does not re-expose; we name the function
-- directly.)
η-equiv-fst : (A : Type ℓ) (b : ʃ⊣♭.T A)
            → η-equiv-at-T A .fst b ≡ flat-intro (shape-unit b)
η-equiv-fst A b = refl
