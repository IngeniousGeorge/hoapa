{-# OPTIONS --cubical --guardedness #-}

-- Change of base for the finite-frame presheaf framework.
--
-- The decision-light *engine* under R4. A functor of value categories
-- `Φ : C → D` induces, by postcomposition, a functor of finite-frame
-- presheaf categories
--
--   Sh-presheaf-cat(site, C)  →  Sh-presheaf-cat(site, D)
--
-- on the *presheaf* level — unconditionally, with no postulates. R4 is
-- then "feed the value-level `Set ⇄ V` adjunction (`F`, `G`) through this
-- engine"; the genuinely Benton-specific content (which lift preserves
-- sheaves) lives in `R4Adapter.agda`, not here. This file makes no
-- adjunction claim and no sheaf claim: it is exactly the
-- value-functoriality of the presheaf category, mirroring how the C6
-- comparison was floated by proving the general lifting first.
--
-- Frame-noninterference (the *structural* half of no-leak). The lift
-- touches only the value category: `value`/`restrict` are postcomposed
-- with `Φ`'s object/hom maps, while the `FiniteFrame` index, the
-- `FrameHom` restriction shape, and covers are passed through unchanged.
-- This is the `frame-noninterference` refl-lemma below. The *semantic*
-- half — session roles/payloads do not refine actor identity — is a
-- named interpretive law of the R4 interface, NOT proved by
-- functoriality, and lives in `LinearNonlinear.agda`.
--
-- Scope guardrails: generic over any two Cubical `Category`s and any
-- `Functor` between them; no adjunction, no sheaf condition, no session
-- syntax, no operad imports. `C` and `D` may sit at different levels.

module Concurrency.Hybrid.ChangeOfBase where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Sigma using (_,_ ; fst ; snd ; Σ≡Prop)

open import Cubical.Categories.Category.Base using (Category)
open import Cubical.Categories.Functor.Base using (Functor)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Hybrid.FinitePresheaf using (FiniteFramePresheaf)
open import Concurrency.Hybrid.FiniteSheafCategory
  using ( isNat ; isNat-isProp ; PshHom ; FiniteFramePresheafCategory )

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓC ℓC' ℓD ℓD' : Level}
         (C : Category ℓC ℓC') (D : Category ℓD ℓD')
         (Φ : Functor C D)
         {ℓE ℓR : Level} where

  open Functor Φ
  open FiniteFramePresheaf

  -- `F-hom` carries applicative composition in `C` to applicative
  -- composition in `D`. This is `F-seq` read through `g ∘ f = f ⋆ g`
  -- (definitional in the library `Category`): both sides reduce, so the
  -- diagrammatic `F-seq` *is* the applicative-`∘` preservation.
  F-∘ : {x y z : Category.ob C}
        (g : Category.Hom[_,_] C y z) (f : Category.Hom[_,_] C x y)
      → F-hom (Category._∘_ C g f) ≡ Category._∘_ D (F-hom g) (F-hom f)
  F-∘ g f = F-seq f g

  --------------------------------------------------------------------
  -- Object part: postcompose a presheaf with Φ.
  --------------------------------------------------------------------

  mapPsh : FiniteFramePresheaf AB C {ℓE} {ℓR}
         → FiniteFramePresheaf AB D {ℓE} {ℓR}
  value       (mapPsh P) F          = F-ob (value P F)
  restrict    (mapPsh P) F G φ      = F-hom (restrict P F G φ)
  restrict-id (mapPsh P) F          = cong F-hom (restrict-id P F) ∙ F-id
  restrict-comp (mapPsh P) F G H ψ φ =
      cong F-hom (restrict-comp P F G H ψ φ)
    ∙ F-∘ (restrict P G F φ) (restrict P H G ψ)

  -- Frame-noninterference (refl-level): the value object is the only
  -- thing the lift transforms; the frame index is identical.
  frame-noninterference :
    (P : FiniteFramePresheaf AB C {ℓE} {ℓR}) (F : FiniteFrame AB ℓE ℓR)
    → value (mapPsh P) F ≡ F-ob (value P F)
  frame-noninterference P F = refl

  --------------------------------------------------------------------
  -- Morphism part: postcompose a natural family with `F-hom`.
  --------------------------------------------------------------------

  mapPshHom :
    {P Q : FiniteFramePresheaf AB C {ℓE} {ℓR}}
    → PshHom AB C P Q
    → PshHom AB D (mapPsh P) (mapPsh Q)
  mapPshHom {P} {Q} (α , nα) =
    (λ F → F-hom (α F)) ,
    (λ {F} {G} φ →
        sym (F-∘ (α G) (restrict P F G φ))
      ∙ cong F-hom (nα φ)
      ∙ F-∘ (restrict Q F G φ) (α F))

  --------------------------------------------------------------------
  -- The induced functor on presheaf categories.
  --------------------------------------------------------------------

  changeOfBase :
    Functor (FiniteFramePresheafCategory AB C {ℓE} {ℓR})
            (FiniteFramePresheafCategory AB D {ℓE} {ℓR})
  Functor.F-ob  changeOfBase       = mapPsh
  Functor.F-hom changeOfBase {x} {y} = mapPshHom {x} {y}
  Functor.F-id  changeOfBase {x}   =
    Σ≡Prop (isNat-isProp AB D (mapPsh x) (mapPsh x))
           (funExt λ F → F-id {x = value x F})
  Functor.F-seq changeOfBase {x} {y} {z} f g =
    Σ≡Prop (isNat-isProp AB D (mapPsh x) (mapPsh z))
           (funExt λ F → F-∘ (fst g F) (fst f F))
