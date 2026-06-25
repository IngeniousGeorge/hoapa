{-# OPTIONS --cubical --guardedness #-}

-- The adapter from full finite-frame presheaves to supported-subsite
-- presheaves.
--
-- A `FiniteFramePresheaf` (over *all* finite frames) restricts to a
-- `SupportedPresheaf` (over the supported subsite) by simply forgetting
-- its values on inactive frames: evaluate only at `fin SF` for supported
-- `SF`, and restrict only along `FrameHom`s between underlying frames.
-- This is support-blind — it never inspects the chosen `support` witness —
-- so it is well defined on the whole supported subsite.
--
-- Why it exists. The point-generated reflector `a ⊣ ι` lives over
-- `SupportedPresheafCategory`, but the inputs that will eventually feed it
-- (e.g. the `liftF`/`liftG` images on the R4 Benton/LNL side) are full
-- `FiniteFramePresheaf`s in `FiniteFramePresheafCategory`. This module is
-- the bridge between the two worlds. It is built as a genuine library
-- `Functor`, not just an object map, so the Brick-4 wiring
-- `full-Psh → supported-Psh → point-sheaf` typechecks while the category
-- definitions are fresh.
--
-- The functor is identity-like on morphisms: a natural family over all
-- finite frames is restricted to the supported ones, and its naturality
-- square is reused unchanged at the supported instances. The functor laws
-- are therefore `refl` on the underlying natural families, closed by
-- `Σ≡Prop` over the propositional naturality predicate.
--
-- Scope guardrails: generic over any Cubical `Category C`; no value-
-- category structure, no `HasFiniteProducts`, no session / operad imports.

module Concurrency.Hybrid.RestrictToSupported where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Sigma using ( _,_ ; fst ; snd ; Σ≡Prop )

open import Cubical.Categories.Category.Base using (Category)
open import Cubical.Categories.Functor.Base using (Functor)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Sites.EventSupported using (SupportedFiniteFrame)
open import Concurrency.Hybrid.FinitePresheaf using (FiniteFramePresheaf)
open import Concurrency.Hybrid.FiniteSheafCategory using (FiniteFramePresheafCategory)
open import Concurrency.Hybrid.SupportedPresheafCategory
  using ( SupportedPresheaf ; SupportedPresheafCategory ; isNat-isProp )

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓV ℓH : Level} (C : Category ℓV ℓH) where

  private
    fin = SupportedFiniteFrame.fin

  ----------------------------------------------------------------------
  -- The object adapter.
  ----------------------------------------------------------------------

  restrict-to-supported :
      FiniteFramePresheaf AB C {ℓ-zero} {ℓA} → SupportedPresheaf AB C
  restrict-to-supported P = record
    { value         = λ SF → FiniteFramePresheaf.value P (fin SF)
    ; restrict      = λ SF SG φ → FiniteFramePresheaf.restrict P (fin SF) (fin SG) φ
    ; restrict-id   = λ SF → FiniteFramePresheaf.restrict-id P (fin SF)
    ; restrict-comp =
        λ SF SG SH ψ φ →
          FiniteFramePresheaf.restrict-comp P (fin SF) (fin SG) (fin SH) ψ φ
    }

  ----------------------------------------------------------------------
  -- The functor `FiniteFramePresheafCategory → SupportedPresheafCategory`.
  --
  -- Restrict the natural family to supported frames; reuse its naturality
  -- square at the supported instances. Functor laws are `refl` on the
  -- underlying families, closed by `Σ≡Prop` over isNat.
  ----------------------------------------------------------------------

  RestrictToSupportedF :
      Functor (FiniteFramePresheafCategory AB C {ℓ-zero} {ℓA})
              (SupportedPresheafCategory AB C)
  RestrictToSupportedF = record
    { F-ob  = restrict-to-supported
    ; F-hom = λ {P} {Q} f → (λ SF → fst f (fin SF)) , (λ {SF} {SG} φ → snd f φ)
    ; F-id  = λ {P} →
        Σ≡Prop (λ α → isNat-isProp AB C (restrict-to-supported P)
                                        (restrict-to-supported P) α) refl
    ; F-seq = λ {P} {Q} {R} f g →
        Σ≡Prop (λ α → isNat-isProp AB C (restrict-to-supported P)
                                        (restrict-to-supported R) α) refl
    }
