{-# OPTIONS --cubical --guardedness #-}

-- The V-valued linear sheaf category Sh_fin(site, V): the category of
-- finite-frame sheaves over a `StarAutonomous` value category `V`.
--
-- This is leg 1 of the three-leg program scoped in the workflow
-- discussion (leg 1: this V-valued linear sheaf category; leg 2: a
-- minimal Set-valued cartesian locality side; leg 3: the R4 Benton /
-- linear-non-linear adapter between them). It is the object the
-- cross-site `Require : K → M` must land in and `Allow : M → K` map
-- out of — the "K as a category" that arc/09 names as the gating
-- prerequisite for stating `Allow ⊣ Require`. Building it makes no
-- adjunction claim; it builds the slot.
--
-- Construction (the "bridge, don't re-express" decision). The working
-- representation stays the hand-rolled `FiniteFramePresheaf` record and
-- its `IsSheaf` (from `FiniteDescent`); the honest library-`Functor`
-- view of each presheaf is provided separately in
-- `Concurrency/Hybrid/FiniteFramePresheafFunctor.agda`. Here we package
-- those records into a library `Cubical.Categories.Category.Category`:
--
--   * `FiniteFramePresheafCategory` — objects are presheaf records,
--     morphisms are natural transformations (a family of `V`-morphisms
--     commuting with `restrict`). `isSetHom` is `isSetΣ` of a Π into
--     `V`'s hom-sets with a propositional naturality square — exactly
--     the coherence the library obligation asks us to pay, and it is
--     payable.
--   * `IsSheaf`-is-a-proposition (`isPropIsSheaf`) — proved *now*, not
--     deferred, so the sheaf subcategory has no duplicate objects for
--     distinct proof witnesses. `IsSeparated` is a Π into a hom-set
--     path (a prop); `HasAmalgamation`'s amalgamation Σ is propositional
--     *given separatedness* (the section is unique by joint monicity);
--     so `IsSheaf`-isProp is an `isProp→PathP` over the separatedness
--     path — the amalgamation half depending on the separated half.
--   * `FiniteSheafCategory` — the full subcategory on `IsSheaf`.
--   * a concrete sanity object: the event-product sheaf is an honest
--     object of the category, so it is non-vacuous.
--
-- Convention: diagrammatic `_⋆_` (library style), with `V`'s
-- applicative `_∘_` used inside the naturality / law proofs — the
-- single conversion is isolated, as in `StarAutonomousCategory.agda`.
--
-- Scope guardrails: generic over any `StarAutonomous V`; the value
-- category is *not* enriched onto the sheaf category (Fork B / the
-- Day-convolution `*`-autonomous structure on K is deferred,
-- interface-first). No Set-valued side, no R4 adapter here — those are
-- the reserved `Concurrency/Topos/` work.

module Concurrency.Hybrid.FiniteSheafCategory where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.HLevels
  using ( isSetΠ ; isPropΠ ; isPropImplicitΠ ; isSetΣ )
open import Cubical.Data.Sigma
  using ( Σ-syntax ; _,_ ; fst ; snd ; Σ≡Prop ; ΣPathP )

open import Cubical.Categories.Category.Base using (Category)
open import Cubical.Categories.Instances.FullSubcategory using (FullSubcategory)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal using (FrameHom)
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Sites.FiniteCover using (FiniteCover)
open import Concurrency.Algebras.StarAutonomous using (StarAutonomous)
open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)
open import Concurrency.Hybrid.EventProductPresheaf
  using (FiniteFramePresheaf ; event-product-presheaf)
open import Concurrency.Hybrid.FiniteDescent
open import Concurrency.Hybrid.EventProductSheaf using (event-product-sheaf)

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓV ℓH : Level} (V : StarAutonomous ℓV ℓH)
         {ℓE ℓR : Level} where

  open StarAutonomous V
  open FiniteFramePresheaf

  private
    Frame : Type (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE ℓR)))
    Frame = FiniteFrame AB ℓE ℓR

    Psh : Type (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE (ℓ-max ℓR (ℓ-max ℓV ℓH)))))
    Psh = FiniteFramePresheaf AB V {ℓE} {ℓR}

  ----------------------------------------------------------------------
  -- Morphisms of presheaves: natural families of V-morphisms.
  ----------------------------------------------------------------------

  -- A family of V-morphisms, one per finite frame.
  NatFam : Psh → Psh → Type (ℓ-max (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE ℓR))) ℓH)
  NatFam P Q = (F : Frame) → Hom (value P F) (value Q F)

  -- The (contravariant) naturality square against `restrict`.
  isNat : (P Q : Psh) → NatFam P Q → Type (ℓ-max (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE ℓR))) ℓH)
  isNat P Q α =
    {F G : Frame}
    (φ : FrameHom AB (FiniteFrame.frame G) (FiniteFrame.frame F))
    → (α G ∘ restrict P F G φ) ≡ (restrict Q F G φ ∘ α F)

  isNat-isProp : (P Q : Psh) (α : NatFam P Q) → isProp (isNat P Q α)
  isNat-isProp P Q α =
    isPropImplicitΠ (λ F → isPropImplicitΠ (λ G → isPropΠ (λ φ → Hom-set _ _)))

  PshHom : Psh → Psh → Type (ℓ-max (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE ℓR))) ℓH)
  PshHom P Q = Σ[ α ∈ NatFam P Q ] isNat P Q α

  -- Identity and composition.
  idPsh : (P : Psh) → PshHom P P
  idPsh P =
    (λ F → id) ,
    (λ {F} {G} φ → id-l (restrict P F G φ) ∙ sym (id-r (restrict P F G φ)))

  compPsh : (P Q R : Psh) → PshHom P Q → PshHom Q R → PshHom P R
  compPsh P Q R (α , nα) (β , nβ) =
    (λ F → β F ∘ α F) ,
    (λ {F} {G} φ →
        ∘-assoc (β G) (α G) (restrict P F G φ)
      ∙ cong (β G ∘_) (nα φ)
      ∙ sym (∘-assoc (β G) (restrict Q F G φ) (α F))
      ∙ cong (_∘ α F) (nβ φ)
      ∙ ∘-assoc (restrict R F G φ) (β F) (α F))

  ----------------------------------------------------------------------
  -- The category of finite-frame presheaves over V.
  ----------------------------------------------------------------------

  FiniteFramePresheafCategory :
    Category (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE (ℓ-max ℓR (ℓ-max ℓV ℓH)))))
             (ℓ-max (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE ℓR))) ℓH)
  FiniteFramePresheafCategory = record
    { ob       = Psh
    ; Hom[_,_] = PshHom
    ; id       = λ {P} → idPsh P
    ; _⋆_      = λ {P} {Q} {R} f g → compPsh P Q R f g
    ; ⋆IdL     = λ {P} {Q} f →
        Σ≡Prop (isNat-isProp P Q) (funExt (λ F → id-r (fst f F)))
    ; ⋆IdR     = λ {P} {Q} f →
        Σ≡Prop (isNat-isProp P Q) (funExt (λ F → id-l (fst f F)))
    ; ⋆Assoc   = λ {P} {Q} {R} {S} f g h →
        Σ≡Prop (isNat-isProp P S)
          (funExt (λ F → sym (∘-assoc (fst h F) (fst g F) (fst f F))))
    ; isSetHom = λ {P} {Q} →
        isSetΣ (isSetΠ (λ F → Hom-set)) (λ α → isProp→isSet (isNat-isProp P Q α))
    }

  ----------------------------------------------------------------------
  -- IsSheaf is a proposition.
  ----------------------------------------------------------------------

  module _ {ℓI : Level} (P : Psh) where

    isPropIsSeparated : isProp (IsSeparated AB V {ℓE} {ℓR} {ℓI} P)
    isPropIsSeparated a b i = record
      { cover-jointly-monic = λ {F} c {X} x y hyp →
          Hom-set x y
            (IsSeparated.cover-jointly-monic a c x y hyp)
            (IsSeparated.cover-jointly-monic b c x y hyp) i }

    -- Given separatedness, the amalgamation Σ for a fixed matching
    -- family is a proposition: the section is unique by joint monicity,
    -- and the restriction property is a hom-set path.
    amalgΣ-isProp :
      (sep : IsSeparated AB V {ℓE} {ℓR} {ℓI} P)
      {F : Frame} (c : FiniteCover AB ℓI F) {X : Ob}
      (m : MatchingFamily AB V P c X)
      → isProp (Σ[ s ∈ Hom X (value P F) ]
                  ((i : FiniteCover.Index c)
                    → restrict P F (FiniteCover.patch c i) (FiniteCover.embed c i) ∘ s
                      ≡ MatchingFamily.part m i))
    amalgΣ-isProp sep {F} c {X} m (s , ps) (s' , ps') =
      ΣPathP ( sEq
             , isProp→PathP (λ _ → isPropΠ (λ i → Hom-set _ _)) ps ps' )
      where
        sEq : s ≡ s'
        sEq = IsSeparated.cover-jointly-monic sep c s s'
                (λ i → ps i ∙ sym (ps' i))

    isPropHasAmalgamation :
      IsSeparated AB V {ℓE} {ℓR} {ℓI} P
      → isProp (HasAmalgamation AB V {ℓE} {ℓR} {ℓI} P)
    isPropHasAmalgamation sep a b i = record
      { amalgamate = λ {F} c {X} m →
          amalgΣ-isProp sep {F} c {X} m
            (HasAmalgamation.amalgamate a c m)
            (HasAmalgamation.amalgamate b c m) i }

    isPropIsSheaf : isProp (IsSheaf AB V {ℓE} {ℓR} {ℓI} P)
    isPropIsSheaf a b i = record
      { separated    = sepPath i
      ; amalgamating =
          isProp→PathP (λ j → isPropHasAmalgamation (sepPath j))
            (IsSheaf.amalgamating a) (IsSheaf.amalgamating b) i }
      where
        sepPath : IsSheaf.separated a ≡ IsSheaf.separated b
        sepPath = isPropIsSeparated (IsSheaf.separated a) (IsSheaf.separated b)

  ----------------------------------------------------------------------
  -- The sheaf category: the full subcategory on IsSheaf.
  ----------------------------------------------------------------------

  FiniteSheafCategory : (ℓI : Level)
    → Category
        (ℓ-max (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE (ℓ-max ℓR (ℓ-max ℓV ℓH)))))
               (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE (ℓ-max ℓR (ℓ-max ℓI (ℓ-max ℓV ℓH)))))))
        (ℓ-max (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE ℓR))) ℓH)
  FiniteSheafCategory ℓI =
    FullSubcategory FiniteFramePresheafCategory
      (λ P → IsSheaf AB V {ℓE} {ℓR} {ℓI} P)

  ----------------------------------------------------------------------
  -- Sanity: the event-product sheaf is a concrete object, so the
  -- category is non-vacuous (it has at least one object and its
  -- identity morphism).
  ----------------------------------------------------------------------

  module _ (FP : HasFiniteProducts V) (P₀ : Ob) {ℓI : Level} where

    event-product-object : Category.ob (FiniteSheafCategory ℓI)
    event-product-object =
      event-product-presheaf AB V FP P₀ , event-product-sheaf AB V FP P₀

    event-product-object-id :
      Category.Hom[_,_] (FiniteSheafCategory ℓI)
        event-product-object event-product-object
    event-product-object-id =
      Category.id (FiniteSheafCategory ℓI) {event-product-object}
