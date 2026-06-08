{-# OPTIONS --cubical --guardedness #-}

-- Change of base for the *supported-subsite* presheaf framework.
--
-- The point-route parallel of `ChangeOfBase.agda`. A functor of value
-- categories `Φ : C → D` induces, by postcomposition, a functor of
-- supported-frame presheaf categories
--
--   SupportedPresheafCategory(C)  →  SupportedPresheafCategory(D)
--
-- unconditionally, with no postulates. This is the engine the
-- point-generated Benton/LNL bridge feeds the value-level `Cart ⇄ V`
-- adjunction through, exactly as `ChangeOfBase.agda` is for the full-site
-- bridge. Following Codex's Brick-4 decision, the supported lift is done
-- directly here rather than routed through `RestrictToSupported.agda`
-- (which stays as compatibility glue): the point bridge lives entirely
-- over supported presheaves, so the direct lift avoids dragging full-site
-- objects and inactive frames back in.
--
-- No adjunction claim, no sheaf claim, no `HasFiniteProducts`: this is the
-- value-functoriality of the supported presheaf category and nothing more.
--
-- Scope guardrails: generic over any two Cubical `Category`s and any
-- `Functor` between them; `C` and `D` may sit at different levels. The
-- supported subsite fixes event level `ℓ-zero`, actor level `ℓA`.

module Concurrency.Hybrid.SupportedChangeOfBase where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Sigma using (_,_ ; fst ; snd ; Σ≡Prop)

open import Cubical.Categories.Category.Base using (Category)
open import Cubical.Categories.Functor.Base using (Functor)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Hybrid.SupportedPresheafCategory
  using ( SupportedPresheaf ; SupportedPresheafCategory
        ; isNat-isProp ; PshHom )

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓC ℓC' ℓD ℓD' : Level}
         (C : Category ℓC ℓC') (D : Category ℓD ℓD')
         (Φ : Functor C D) where

  open Functor Φ
  open SupportedPresheaf

  -- `F-hom` carries applicative composition in `C` to applicative
  -- composition in `D` (`F-seq` read through `g ∘ f = f ⋆ g`).
  F-∘ : {x y z : Category.ob C}
        (g : Category.Hom[_,_] C y z) (f : Category.Hom[_,_] C x y)
      → F-hom (Category._∘_ C g f) ≡ Category._∘_ D (F-hom g) (F-hom f)
  F-∘ g f = F-seq f g

  --------------------------------------------------------------------
  -- Object part: postcompose a supported presheaf with Φ.
  --------------------------------------------------------------------

  mapPshSupported : SupportedPresheaf AB C → SupportedPresheaf AB D
  value         (mapPshSupported P) SF           = F-ob (value P SF)
  restrict      (mapPshSupported P) SF SG φ       = F-hom (restrict P SF SG φ)
  restrict-id   (mapPshSupported P) SF           = cong F-hom (restrict-id P SF) ∙ F-id
  restrict-comp (mapPshSupported P) SF SG SH ψ φ =
      cong F-hom (restrict-comp P SF SG SH ψ φ)
    ∙ F-∘ (restrict P SG SF φ) (restrict P SH SG ψ)

  --------------------------------------------------------------------
  -- Morphism part: postcompose a natural family with `F-hom`.
  --------------------------------------------------------------------

  mapPshHomSupported :
    {P Q : SupportedPresheaf AB C}
    → PshHom AB C P Q
    → PshHom AB D (mapPshSupported P) (mapPshSupported Q)
  mapPshHomSupported {P} {Q} (α , nα) =
    (λ SF → F-hom (α SF)) ,
    (λ {SF} {SG} φ →
        sym (F-∘ (α SG) (restrict P SF SG φ))
      ∙ cong F-hom (nα φ)
      ∙ F-∘ (restrict Q SF SG φ) (α SF))

  --------------------------------------------------------------------
  -- The induced functor on supported presheaf categories.
  --------------------------------------------------------------------

  changeOfBaseSupported :
    Functor (SupportedPresheafCategory AB C)
            (SupportedPresheafCategory AB D)
  Functor.F-ob  changeOfBaseSupported         = mapPshSupported
  Functor.F-hom changeOfBaseSupported {x} {y} = mapPshHomSupported {x} {y}
  Functor.F-id  changeOfBaseSupported {x}     =
    Σ≡Prop (isNat-isProp AB D (mapPshSupported x) (mapPshSupported x))
           (funExt λ SF → F-id {x = value x SF})
  Functor.F-seq changeOfBaseSupported {x} {y} {z} f g =
    Σ≡Prop (isNat-isProp AB D (mapPshSupported x) (mapPshSupported z))
           (funExt λ SF → F-∘ (fst g SF) (fst f SF))
