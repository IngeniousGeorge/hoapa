{-# OPTIONS --cubical --guardedness #-}

-- Lifting the linear/non-linear adjunction to presheaves, and the right
-- adjoint's preservation of event-local sheaves.
--
-- A Benton linear/non-linear adjunction  F ⊣ G : Cart ⇄ V  between
-- coefficient categories lifts, by postcomposition (change of base), to
-- the presheaf categories over the actor-causal site. This file assembles
-- that lift together with the one preservation property the sheaf-level
-- adjunction needs:
--
--   * `supportedLiftF` / `supportedLiftG` — the pointwise lifts of `F`
--     and `G` to presheaves;
--   * `supportedLiftF⊣supportedLiftG` — their adjunction at the presheaf
--     level, transposed frame by frame from `F ⊣ G`;
--   * `G-preserves-IsPointSheaf` — the right adjoint sends event-local
--     sheaves to event-local sheaves. Descent along the single-event
--     cover is transported across the adjunction bijection
--     `Cart(X , G Y) ≅ V(F X , Y)`, exactly as in the abstract;
--   * `G-preserves-point-local` — the same fact in the `PointLocal` form
--     that the sheaf-level adjunction consumes.
--
-- The linear side is asked to carry finite products (`vProd`): the
-- event-local sheaf condition is phrased through the finite product of a
-- presheaf's single-event values, so those products are needed in the
-- value category too. This is the linear counterpart of `cartProd`, and a
-- separate hypothesis — not part of the Benton data `LNLAdjunction`.
--
-- No postulates. Generic over an abstract cartesian category `Cart` and a
-- *-autonomous `V`; the endpoints are the presheaf and event-local sheaf
-- categories of this development.

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
  -- Presheaf-level lifts of F and G by change of base.
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
  -- The right adjoint G preserves event-local sheaves.
  --
  -- Descent along the single-event cover is transported across the
  -- adjunction bijection  Cart(X , G Y) ≅ V(F X , Y)  (its two directions
  -- written `_♯` and `_♭`):
  --   * separatedness — two Cart-sections `x y` into `G∘P` transpose to
  --     `x ♯`, `y ♯` at the probe `F X`; `adjNatInD'` turns the
  --     single-event restriction hypothesis into the V-side one; `P`'s
  --     separatedness gives `x ♯ ≡ y ♯`; `isoInvInjective` gives `x ≡ y`;
  --   * amalgamation — a Cart matching family transposes (via `_♯`, with
  --     `adjNatInD'` for compatibility) to a V matching family at `F X`;
  --     `P` amalgamates it; `_♭` transposes the glued section back, and
  --     `adjNatInD` with the `♭`/`♯` laws recovers the single-event
  --     equations.
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

  -- The same fact in `PointLocal` form — the shape the sheaf-level
  -- adjunction consumes (through `MapFullSubcategory`). It brackets
  -- `G-preserves-IsPointSheaf` with the `point-sheaf⟺local` biconditional
  -- on each side.
  G-preserves-point-local :
      (P : SupportedPresheaf AB Vcat)
    → PointLocal AB Vcat vProd P
    → PointLocal AB Cart cartProd (mapPshSupported AB Vcat Cart G P)
  G-preserves-point-local P pl =
    fst (point-sheaf⟺local AB Cart cartProd (mapPshSupported AB Vcat Cart G P))
        (G-preserves-IsPointSheaf P
          (snd (point-sheaf⟺local AB Vcat vProd P) pl))

  --------------------------------------------------------------------
  -- The adjunction at the presheaf level:
  --   `supportedLiftF ⊣ supportedLiftG`.
  --
  -- Frame-by-frame transpose by the coefficient adjunction's bijection
  -- `adjIso`; naturality from `adjNatInC'`/`adjNatInD` (forward) and
  -- `adjNatInC`/`adjNatInD'` (back). Purely presheaf-level — it does not
  -- mention the sheaf condition.
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
