{-# OPTIONS --cubical --guardedness #-}

-- Change of base for presheaves on the actor-causal site.
--
-- A functor of coefficient categories  Φ : C → D  induces, by
-- postcomposition, a functor of presheaf categories
--
--   SupportedPresheafCategory C  →  SupportedPresheafCategory D
--
-- with no postulates. This is the postcomposition lift by which the
-- abstract carries the value-level functors F and G to presheaves; the
-- linear/non-linear bridge feeds its coefficient-level adjunction
-- Cart ⇄ V through this construction.
--
-- The lift assumes only a functor between the coefficient categories: no
-- adjunction, no sheaf condition, no finite products. It is exactly the
-- functoriality of the presheaf construction in its coefficient category
-- — only the value assigned to each context is transported, the site is
-- untouched.
--
-- Generic over any two coefficient categories C, D (which may sit at
-- different universe levels) and any functor between them; the
-- actor-causal site fixes event level `ℓ-zero` and actor level `ℓA`.

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
