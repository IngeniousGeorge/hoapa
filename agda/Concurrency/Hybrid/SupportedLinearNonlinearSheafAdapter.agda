{-# OPTIONS --cubical --guardedness #-}

-- The supported-subsite linear–nonlinear adapter — the point-route
-- parallel of `LinearNonlinearSheafAdapter.agda`.
--
-- This file feeds the value-level Benton/LNL adjunction (`F ⊣ G : Cart ⇄
-- V`) through the *supported* change-of-base engine
-- (`SupportedChangeOfBase.changeOfBaseSupported`) and provides the two
-- pieces the point-generated bridge (`PointLinearNonlinearAdjunction.agda`)
-- needs that are not already in Brick 3:
--
--   * `supportedLiftF` / `supportedLiftG` — the presheaf-level lifts over
--     the supported subsite (Tier 1, change of base);
--   * `supportedLiftF⊣supportedLiftG` — the supported-presheaf-level
--     adjunction (Tier 1.5), a literal port of
--     `LinearNonlinearSheafAdapter.liftF⊣liftG`;
--   * `G-preserves-IsPointSheaf` — the new Tier-2 lemma: the right adjoint
--     `G` sends point sheaves to point sheaves. The proof is the
--     `Ad.G-preserves-sheaf` transport across the adjunction's natural
--     bijection, but over the *point* descent records
--     (`PointSeparated` / `PointAmalgamation` / `PointMatchingFamily`),
--     consuming the public `IsPointSheaf` interface rather than the private
--     comparison cone;
--   * `G-preserves-point-local` — its `PointLocal`-form, derived by
--     bracketing with the `point-sheaf⟺local` biconditional, which is the
--     shape `MapFullSubcategory` consumes in the assembled bridge.
--
-- The bridge over the linear side needs `V` to carry finite products
-- (`vProd`), since the point reflector and `PointLocal` are stated via the
-- comparison cone into the finite point product in the value category.
-- That is the linear-side counterpart of `cartProd`; it is a bare module
-- parameter here, NOT a field of `LNLAdjunction` (the value-level Benton
-- structure does not need it).
--
-- No postulates. Scope guardrails as in the full-site adapter: generic
-- over an abstract cartesian `Cart` and `V : StarAutonomous`; endpoints
-- are the project's own supported / point categories.

module Concurrency.Hybrid.SupportedLinearNonlinearSheafAdapter where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Isomorphism using (Iso ; isoInvInjective)
open import Cubical.Data.Sigma using (_,_ ; fst ; snd ; Σ≡Prop)

open import Cubical.Categories.Category.Base using (Category)
open import Cubical.Categories.Functor.Base using (Functor)
open import Cubical.Categories.Adjoint using (module NaturalBijection)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Algebras.StarAutonomous using (StarAutonomous)
open import Concurrency.Algebras.StarAutonomousCategory using (StarAutonomous→Category)
open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)
open import Concurrency.Hybrid.SupportedPresheafCategory
  using ( SupportedPresheaf ; SupportedPresheafCategory ; isNat ; isNat-isProp ; PshHom )
open import Concurrency.Hybrid.SupportedPointDescent
  using ( IsPointSheaf ; PointSeparated ; PointAmalgamation ; PointMatchingFamily
        ; PointLocal ; point-sheaf⟺local )
open import Concurrency.Hybrid.SupportedChangeOfBase
  using (changeOfBaseSupported ; mapPshSupported)
open import Concurrency.Hybrid.LinearNonlinear using (LNLAdjunction)

open NaturalBijection using (_⊣_)

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓc ℓc' ℓv ℓv' : Level}
         (Cart : Category ℓc ℓc') (cartProd : HasFiniteProducts Cart)
         (V : StarAutonomous ℓv ℓv')
         (vProd : HasFiniteProducts (StarAutonomous→Category V))
         (lnl : LNLAdjunction Cart cartProd V) where

  private
    Vcat : Category ℓv ℓv'
    Vcat = StarAutonomous→Category V

  open LNLAdjunction lnl using (F ; G ; F⊣G)
  open NaturalBijection._⊣_ F⊣G

  --------------------------------------------------------------------
  -- Tier 1 (PROVED): supported presheaf-level change-of-base lifts.
  --------------------------------------------------------------------

  -- Right adjoint `G : V → Cart` lifts to supported presheaves.
  supportedLiftG : Functor (SupportedPresheafCategory AB Vcat)
                           (SupportedPresheafCategory AB Cart)
  supportedLiftG = changeOfBaseSupported AB Vcat Cart G

  -- Left adjoint `F : Cart → V` lifts to supported presheaves.
  supportedLiftF : Functor (SupportedPresheafCategory AB Cart)
                           (SupportedPresheafCategory AB Vcat)
  supportedLiftF = changeOfBaseSupported AB Cart Vcat F

  --------------------------------------------------------------------
  -- Tier 2 (PROVED): the right adjoint G preserves point sheaves.
  --
  -- `Ad.G-preserves-sheaf` transported to the point descent records.
  -- Separatedness: two Cart-sections `x y` into `G∘P` pull back to `x ♯`,
  -- `y ♯` at probe `F X`; `adjNatInD'` turns the per-point restriction
  -- hypothesis into the V-side hypothesis; `P`'s point-separatedness gives
  -- `x ♯ ≡ y ♯`; `isoInvInjective` gives `x ≡ y`. Amalgamation: a
  -- Cart-point-matching-family pulls back (via `_♯` + `adjNatInD'` for
  -- overlap compatibility) to a V-point-matching-family at `F X`; `P`
  -- amalgamates it; `_♭` pushes the section back, and `adjNatInD` + the
  -- `♭`/`♯` section law recover the per-point equations.
  --------------------------------------------------------------------

  G-preserves-IsPointSheaf :
      (P : SupportedPresheaf AB Vcat)
    → IsPointSheaf AB Vcat P
    → IsPointSheaf AB Cart (mapPshSupported AB Vcat Cart G P)
  G-preserves-IsPointSheaf P shP = record
    { separated = record
        { cover-jointly-monic = λ SF {X} x y hyp →
            isoInvInjective adjIso x y
              (PointSeparated.cover-jointly-monic (IsPointSheaf.separated shP) SF (x ♯) (y ♯)
                 (λ i → adjNatInD' x _ ∙ cong _♯ (hyp i) ∙ sym (adjNatInD' y _))) }
    ; amalgamating = record
        { amalgamate = λ SF {X} m →
            let vs = PointAmalgamation.amalgamate (IsPointSheaf.amalgamating shP) SF
                       {Functor.F-ob F X}
                       (record
                         { part = λ i → PointMatchingFamily.part m i ♯
                         ; compatible = λ i j →
                               adjNatInD' (PointMatchingFamily.part m i) _
                             ∙ cong _♯ (PointMatchingFamily.compatible m i j)
                             ∙ sym (adjNatInD' (PointMatchingFamily.part m j) _) })
            in (fst vs ♭) ,
               (λ i → sym (adjNatInD (fst vs) _)
                    ∙ cong _♭ (snd vs i)
                    ∙ Iso.sec adjIso (PointMatchingFamily.part m i)) } }

  -- The `PointLocal`-form, which is what `MapFullSubcategory` consumes in
  -- the assembled bridge. `PointLocal → IsPointSheaf →
  -- G-preserves-IsPointSheaf → PointLocal`, via the `point-sheaf⟺local`
  -- biconditional on each side.
  G-preserves-point-local :
      (P : SupportedPresheaf AB Vcat)
    → PointLocal AB Vcat vProd P
    → PointLocal AB Cart cartProd (mapPshSupported AB Vcat Cart G P)
  G-preserves-point-local P pl =
    fst (point-sheaf⟺local AB Cart cartProd (mapPshSupported AB Vcat Cart G P))
        (G-preserves-IsPointSheaf P
          (snd (point-sheaf⟺local AB Vcat vProd P) pl))

  --------------------------------------------------------------------
  -- Tier 1.5 (PROVED): the supported presheaf-level adjunction
  -- `supportedLiftF ⊣ supportedLiftG`.
  --
  -- Literal port of `Ad.liftF⊣liftG`: pointwise transpose by `adjIso`,
  -- naturality by `adjNatInC'`/`adjNatInD` (forward) and
  -- `adjNatInC`/`adjNatInD'` (back). Purely presheaf-level — independent
  -- of point-locality.
  --------------------------------------------------------------------

  supportedLiftF⊣supportedLiftG : supportedLiftF ⊣ supportedLiftG
  supportedLiftF⊣supportedLiftG = record
    { adjIso     = λ {P} {Q} → psh-iso P Q
    ; adjNatInD  = λ {P} {Q} {Q'} f k →
        Σ≡Prop (isNat-isProp AB Cart P (mapPshSupported AB Vcat Cart G Q'))
               (funExt λ SF → adjNatInD (fst f SF) (fst k SF))
    ; adjNatInC  = λ {P'} {P} {Q} g h →
        Σ≡Prop (isNat-isProp AB Vcat (mapPshSupported AB Cart Vcat F P') Q)
               (funExt λ SF → adjNatInC (fst g SF) (fst h SF))
    }
    where
      psh-iso :
        (P : SupportedPresheaf AB Cart)
        (Q : SupportedPresheaf AB Vcat)
        → Iso (PshHom AB Vcat (mapPshSupported AB Cart Vcat F P) Q)
              (PshHom AB Cart P (mapPshSupported AB Vcat Cart G Q))
      psh-iso P Q = record
        { fun = λ fα → (λ SF → fst fα SF ♭) , natβ fα
        ; inv = λ gβ → (λ SF → fst gβ SF ♯) , natα gβ
        ; sec = λ gβ → Σ≡Prop (isNat-isProp AB Cart P (mapPshSupported AB Vcat Cart G Q))
                              (funExt λ SF → Iso.sec adjIso (fst gβ SF))
        ; ret = λ fα → Σ≡Prop (isNat-isProp AB Vcat (mapPshSupported AB Cart Vcat F P) Q)
                              (funExt λ SF → Iso.ret adjIso (fst fα SF))
        }
        where
          natβ :
            (fα : PshHom AB Vcat (mapPshSupported AB Cart Vcat F P) Q)
            → isNat AB Cart P (mapPshSupported AB Vcat Cart G Q) (λ SF → fst fα SF ♭)
          natβ (α , nα) {SF} {SG} φ =
              adjNatInC' (α SG) (SupportedPresheaf.restrict P SF SG φ)
            ∙ cong _♭ (nα φ)
            ∙ adjNatInD (α SF) (SupportedPresheaf.restrict Q SF SG φ)

          natα :
            (gβ : PshHom AB Cart P (mapPshSupported AB Vcat Cart G Q))
            → isNat AB Vcat (mapPshSupported AB Cart Vcat F P) Q (λ SF → fst gβ SF ♯)
          natα (β , nβ) {SF} {SG} φ =
              sym (adjNatInC (β SG) (SupportedPresheaf.restrict P SF SG φ))
            ∙ cong _♯ (nβ φ)
            ∙ sym (adjNatInD' (β SF) (SupportedPresheaf.restrict Q SF SG φ))
