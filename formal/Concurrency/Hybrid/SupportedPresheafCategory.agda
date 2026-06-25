{-# OPTIONS --cubical --guardedness #-}

-- Presheaves over the supported (point-generated) finite-frame subsite,
-- packaged as a library `Category`.
--
-- The point-route parallel of the `FiniteFramePresheafCategory` built
-- inside `FiniteSheafCategory.agda`, but over `SupportedFiniteFrame`s
-- (`SupportedFiniteFrameCategory.agda`) rather than all finite frames.
-- This is the category the point-generated reflector `a ⊣ ι` lives over:
-- restricting the *morphisms* to the supported subsite is exactly what
-- removes the uncontrolled inactive-frame components that would otherwise
-- block the reflection (the universal property genuinely fails on
-- inactive frames).
--
-- A `SupportedPresheaf` is the supported-subsite analogue of
-- `FinitePresheaf.FiniteFramePresheaf`: a contravariant assignment of a
-- value object to each supported finite frame and a restriction morphism
-- to each sub-view embedding `FrameHom` between underlying frames, with
-- the two frames passed explicitly to `restrict`. It is kept as a
-- hand-rolled record (not a library `Functor`) for the same reason
-- `FiniteFramePresheaf` is: so that `IsPointSheaf`/`PointLocal` and the
-- ported pointification consume it without re-deriving `restrict-comp`
-- under the `⋆`/`∘` flip. (A library-`Functor` view, à la
-- `FiniteFramePresheafFunctor`, is a later add if Brick 4 needs it.)
--
-- Orientation matches `FiniteFrameCategory`/`FinitePresheaf`:
-- `restrict SF SG` takes a `FrameHom (uframe SG) (uframe SF)` (the smaller
-- frame `SG` embeds into `SF`) and produces `value SF → value SG`.
--
-- Event level `ℓ-zero`, relation/actor level `ℓA` (fixed by
-- `SupportedFiniteFrame`).
--
-- Scope guardrails: generic over any Cubical `Category C`; no value-
-- category structure beyond the underlying 1-category, no
-- `HasFiniteProducts` (the sheaf subcategory's product-facing predicate
-- lives in `PointSheafCategory.agda`), no session / operad imports.

module Concurrency.Hybrid.SupportedPresheafCategory where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.HLevels
  using ( isSetΠ ; isPropΠ ; isPropImplicitΠ ; isSetΣ )
open import Cubical.Data.Sigma
  using ( Σ-syntax ; _,_ ; fst ; snd ; Σ≡Prop )

open import Cubical.Categories.Category.Base using (Category)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal
  using ( LocalFrame ; FrameHom ; frame-id ; _∘ᶠ_ )
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Sites.EventSupported using (SupportedFiniteFrame)
open import Concurrency.Algebras.CategoryApplicative using (module ApplicativeView)

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓV ℓH : Level} (C : Category ℓV ℓH) where

  open ApplicativeView C

  private
    uframe : SupportedFiniteFrame AB → LocalFrame AB ℓ-zero ℓA
    uframe SF = FiniteFrame.frame (SupportedFiniteFrame.fin SF)

  ----------------------------------------------------------------------
  -- The supported-frame presheaf record (contravariant on the subsite).
  ----------------------------------------------------------------------

  record SupportedPresheaf : Type (ℓ-suc (ℓ-max ℓA (ℓ-max ℓV ℓH))) where
    field
      value :
        SupportedFiniteFrame AB → Ob
      restrict :
        (SF SG : SupportedFiniteFrame AB)
        → FrameHom AB (uframe SG) (uframe SF)
        → Hom (value SF) (value SG)
      restrict-id :
        (SF : SupportedFiniteFrame AB)
        → restrict SF SF (frame-id AB (uframe SF)) ≡ id
      restrict-comp :
        (SF SG SH : SupportedFiniteFrame AB)
        (ψ : FrameHom AB (uframe SG) (uframe SH))
        (φ : FrameHom AB (uframe SF) (uframe SG))
        → restrict SH SF (_∘ᶠ_ AB ψ φ) ≡ restrict SG SF φ ∘ restrict SH SG ψ

  open SupportedPresheaf

  ----------------------------------------------------------------------
  -- Morphisms: natural families over the supported subsite.
  ----------------------------------------------------------------------

  NatFam : SupportedPresheaf → SupportedPresheaf → Type (ℓ-max (ℓ-suc ℓA) ℓH)
  NatFam P Q = (SF : SupportedFiniteFrame AB) → Hom (value P SF) (value Q SF)

  isNat : (P Q : SupportedPresheaf) → NatFam P Q → Type (ℓ-max (ℓ-suc ℓA) ℓH)
  isNat P Q α =
    {SF SG : SupportedFiniteFrame AB}
    (φ : FrameHom AB (uframe SG) (uframe SF))
    → (α SG ∘ restrict P SF SG φ) ≡ (restrict Q SF SG φ ∘ α SF)

  isNat-isProp : (P Q : SupportedPresheaf) (α : NatFam P Q) → isProp (isNat P Q α)
  isNat-isProp P Q α =
    isPropImplicitΠ (λ SF → isPropImplicitΠ (λ SG → isPropΠ (λ φ → Hom-set _ _)))

  PshHom : SupportedPresheaf → SupportedPresheaf → Type (ℓ-max (ℓ-suc ℓA) ℓH)
  PshHom P Q = Σ[ α ∈ NatFam P Q ] isNat P Q α

  idPsh : (P : SupportedPresheaf) → PshHom P P
  idPsh P =
    (λ SF → id) ,
    (λ {SF} {SG} φ → id-l (restrict P SF SG φ) ∙ sym (id-r (restrict P SF SG φ)))

  compPsh : (P Q R : SupportedPresheaf) → PshHom P Q → PshHom Q R → PshHom P R
  compPsh P Q R (α , nα) (β , nβ) =
    (λ SF → β SF ∘ α SF) ,
    (λ {SF} {SG} φ →
        ∘-assoc (β SG) (α SG) (restrict P SF SG φ)
      ∙ cong (β SG ∘_) (nα φ)
      ∙ sym (∘-assoc (β SG) (restrict Q SF SG φ) (α SF))
      ∙ cong (_∘ α SF) (nβ φ)
      ∙ ∘-assoc (restrict R SF SG φ) (β SF) (α SF))

  ----------------------------------------------------------------------
  -- The category of supported-frame presheaves over C.
  ----------------------------------------------------------------------

  SupportedPresheafCategory :
    Category (ℓ-suc (ℓ-max ℓA (ℓ-max ℓV ℓH))) (ℓ-max (ℓ-suc ℓA) ℓH)
  SupportedPresheafCategory = record
    { ob       = SupportedPresheaf
    ; Hom[_,_] = PshHom
    ; id       = λ {P} → idPsh P
    ; _⋆_      = λ {P} {Q} {R} f g → compPsh P Q R f g
    ; ⋆IdL     = λ {P} {Q} f →
        Σ≡Prop (isNat-isProp P Q) (funExt (λ SF → id-r (fst f SF)))
    ; ⋆IdR     = λ {P} {Q} f →
        Σ≡Prop (isNat-isProp P Q) (funExt (λ SF → id-l (fst f SF)))
    ; ⋆Assoc   = λ {P} {Q} {R} {S} f g h →
        Σ≡Prop (isNat-isProp P S)
          (funExt (λ SF → sym (∘-assoc (fst h SF) (fst g SF) (fst f SF))))
    ; isSetHom = λ {P} {Q} →
        isSetΣ (isSetΠ (λ SF → Hom-set)) (λ α → isProp→isSet (isNat-isProp P Q α))
    }
