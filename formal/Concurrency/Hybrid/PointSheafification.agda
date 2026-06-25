{-# OPTIONS --cubical --guardedness #-}

-- Brick 3b, Stage 1: the point-product reflector as a functor.
--
-- `a : SupportedPresheafCategory → PointSheafCategory`, sending a supported
-- presheaf to its point-product reflector (`SupportedPointification.pointify`,
-- which lands in point sheaves by `PointifyIsSheaf`). This file builds the
-- *functor*: the action on objects, the action on natural transformations,
-- and the two functor laws.
--
-- The action on a morphism `α : P → Q` is "apply α at each point":
--
--   (a α) SF = ⟨ α(pt_e) ∘ pointProj_P SF e ⟩_e  : ∏_e P(pt_e) → ∏_e Q(pt_e).
--
-- Naturality of `a α` reduces, via point-projection naturality
-- (`point-proj-nat`) and the point-product β-law (`pointβ`), to `α`'s own
-- naturality at the induced point morphism `point-hom φ d`. The whole proof
-- runs through the *abstract*, slot-indexed, presheaf-free product API
-- (`SupportedPointProduct`): because `pointProduct SF slot` is `abstract`,
-- it stays a stuck head with the frame `SF` an explicit argument and never
-- unfolds to `bigProduct (sfCount SF) …`. That is what lets the P-side and
-- Q-side naturality lemmas coexist — a frame metavariable unifies directly
-- off `pointProduct`'s explicit argument instead of being reconstructed from
-- the non-invertible `sfCount`/`sfEnum`.
--
-- Scope: generic over a value category `C` with finite products.

module Concurrency.Hybrid.PointSheafification where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Sigma using (_,_ ; fst ; snd ; Σ≡Prop)

open import Cubical.Categories.Category.Base using (Category)
open import Cubical.Categories.Functor.Base using (Functor)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal using (LocalFrame ; FrameHom)
open import Concurrency.Sites.EventPoint using (point-hom)
open import Concurrency.Sites.EventSupported
  using (SupportedFiniteFrame ; sfFrame ; sfEv)
open import Concurrency.Algebras.CategoryApplicative using (module ApplicativeView)
open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)
open import Concurrency.Hybrid.SupportedPresheafCategory
  using ( SupportedPresheaf ; SupportedPresheafCategory
        ; NatFam ; isNat ; PshHom ; idPsh ; compPsh ; isNat-isProp )
open import Concurrency.Hybrid.SupportedPointProduct
  using ( pt₀ ; slotOf ; pointProduct ; pointProj ; pointTuple
        ; pointβ ; pointη ; pointExt )
open import Concurrency.Hybrid.SupportedPointification using (pointify ; point-proj-nat)
open import Concurrency.Hybrid.PointifyIsSheaf using (pointify-point-local)
open import Concurrency.Hybrid.PointSheafCategory using (PointSheafCategory)

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓ ℓ' : Level} (C : Category ℓ ℓ') (FP : HasFiniteProducts C) where

  open ApplicativeView C

  private
    SPsh = SupportedPresheafCategory AB C
    PtSh = PointSheafCategory AB C FP

    pf    = pointify AB C FP
    ppnat = point-proj-nat AB C FP
    pProj = pointProj AB C FP
    pTup  = pointTuple AB C FP
    pβ    = pointβ AB C FP
    pη    = pointη AB C FP
    pExt  = pointExt AB C FP
    sl    = slotOf AB C FP
    ptz   = pt₀ AB C FP

    uf : SupportedFiniteFrame AB → LocalFrame AB ℓ-zero ℓA
    uf = sfFrame AB

    ev : SupportedFiniteFrame AB → Type ℓ-zero
    ev = sfEv AB

    Val : SupportedPresheaf AB C → SupportedFiniteFrame AB → Ob
    Val = SupportedPresheaf.value

    ----------------------------------------------------------------------
    -- The action on a morphism: apply α at each point.
    ----------------------------------------------------------------------

    aMor : (P Q : SupportedPresheaf AB C)
         → PshHom AB C P Q → PshHom AB C (pf P) (pf Q)
    aMor P Q (α , nα) = fam , nat
      where
        fam : NatFam AB C (pf P) (pf Q)
        fam SF = pTup SF (sl Q SF) {X = Val (pf P) SF}
                      (λ e → α (ptz SF e) ∘ pProj SF (sl P SF) e)

        nat : isNat AB C (pf P) (pf Q) fam
        nat {SF} {SF'} φ =
          pExt SF' (sl Q SF') {X = Val (pf P) SF} (fam SF' ∘ rP) (rQ ∘ fam SF) per
          where
            rP = SupportedPresheaf.restrict (pf P) SF SF' φ
            rQ = SupportedPresheaf.restrict (pf Q) SF SF' φ

            per : (d : ev SF')
                → pProj SF' (sl Q SF') d ∘ (fam SF' ∘ rP)
                  ≡ pProj SF' (sl Q SF') d ∘ (rQ ∘ fam SF)
            per d =
                sym (∘-assoc (pProj SF' (sl Q SF') d) (fam SF') rP)
              ∙ cong (_∘ rP) (pβ SF' (sl Q SF')
                                (λ e → α (ptz SF' e) ∘ pProj SF' (sl P SF') e) d)
              ∙ ∘-assoc (α (ptz SF' d)) (pProj SF' (sl P SF') d) rP
              ∙ cong (α (ptz SF' d) ∘_) (ppnat P SF SF' φ d)
              ∙ sym (∘-assoc (α (ptz SF' d)) rPpt (pProj SF (sl P SF) φd))
              ∙ cong (_∘ pProj SF (sl P SF) φd) (nα {ptz SF φd} {ptz SF' d} ph)
              ∙ ∘-assoc rQpt (α (ptz SF φd)) (pProj SF (sl P SF) φd)
              ∙ cong (rQpt ∘_)
                     (sym (pβ SF (sl Q SF)
                              (λ e → α (ptz SF e) ∘ pProj SF (sl P SF) e) φd))
              ∙ sym (∘-assoc rQpt (pProj SF (sl Q SF) φd) (fam SF))
              ∙ cong (_∘ fam SF) (sym (ppnat Q SF SF' φ d))
              ∙ ∘-assoc (pProj SF' (sl Q SF') d) rQ (fam SF)
              where
                φd   = FrameHom.event-map φ d
                ph   = point-hom AB (uf SF') (uf SF) φ d
                rPpt = SupportedPresheaf.restrict P (ptz SF φd) (ptz SF' d) ph
                rQpt = SupportedPresheaf.restrict Q (ptz SF φd) (ptz SF' d) ph

    ----------------------------------------------------------------------
    -- Functor laws.
    ----------------------------------------------------------------------

    a-id : (P : SupportedPresheaf AB C)
         → aMor P P (idPsh AB C P) ≡ idPsh AB C (pf P)
    a-id P = Σ≡Prop (λ γ → isNat-isProp AB C (pf P) (pf P) γ) (funExt famPath)
      where
        famPath : (SF : SupportedFiniteFrame AB)
                → fst (aMor P P (idPsh AB C P)) SF ≡ fst (idPsh AB C (pf P)) SF
        famPath SF =
            cong (pTup SF (sl P SF) {X = Val (pf P) SF})
                 (funExt (λ e → id-l (pProj SF (sl P SF) e)
                              ∙ sym (id-r (pProj SF (sl P SF) e))))
          ∙ pη SF (sl P SF) id

    a-seq : (P Q R : SupportedPresheaf AB C)
            (f : PshHom AB C P Q) (g : PshHom AB C Q R)
          → aMor P R (compPsh AB C P Q R f g)
            ≡ compPsh AB C (pf P) (pf Q) (pf R) (aMor P Q f) (aMor Q R g)
    a-seq P Q R (α , nα) (β , nβ) =
      Σ≡Prop (λ γ → isNat-isProp AB C (pf P) (pf R) γ) (funExt famPath)
      where
        famPath : (SF : SupportedFiniteFrame AB)
                → fst (aMor P R (compPsh AB C P Q R (α , nα) (β , nβ))) SF
                  ≡ fst (compPsh AB C (pf P) (pf Q) (pf R)
                                 (aMor P Q (α , nα)) (aMor Q R (β , nβ))) SF
        famPath SF =
          pExt SF (sl R SF) {X = Val (pf P) SF}
               (fst (aMor P R (compPsh AB C P Q R (α , nα) (β , nβ))) SF)
               (fst (compPsh AB C (pf P) (pf Q) (pf R)
                              (aMor P Q (α , nα)) (aMor Q R (β , nβ))) SF)
               per
          where
            aαfam = fst (aMor P Q (α , nα)) SF
            aβfam = fst (aMor Q R (β , nβ)) SF

            per : (d : ev SF)
                → pProj SF (sl R SF) d
                    ∘ fst (aMor P R (compPsh AB C P Q R (α , nα) (β , nβ))) SF
                  ≡ pProj SF (sl R SF) d
                    ∘ fst (compPsh AB C (pf P) (pf Q) (pf R)
                                  (aMor P Q (α , nα)) (aMor Q R (β , nβ))) SF
            per d =
                pβ SF (sl R SF)
                   (λ e → (β (ptz SF e) ∘ α (ptz SF e)) ∘ pProj SF (sl P SF) e) d
              ∙ ∘-assoc (β (ptz SF d)) (α (ptz SF d)) (pProj SF (sl P SF) d)
              ∙ cong (β (ptz SF d) ∘_)
                     (sym (pβ SF (sl Q SF)
                              (λ e → α (ptz SF e) ∘ pProj SF (sl P SF) e) d))
              ∙ sym (∘-assoc (β (ptz SF d)) (pProj SF (sl Q SF) d) aαfam)
              ∙ cong (_∘ aαfam)
                     (sym (pβ SF (sl R SF)
                              (λ e → β (ptz SF e) ∘ pProj SF (sl Q SF) e) d))
              ∙ ∘-assoc (pProj SF (sl R SF) d) aβfam aαfam

  ----------------------------------------------------------------------
  -- The reflector functor.
  ----------------------------------------------------------------------

  a : Functor SPsh PtSh
  a = record
    { F-ob  = λ P → pf P , pointify-point-local AB C FP P
    ; F-hom = λ {P} {Q} α → aMor P Q α
    ; F-id  = λ {P} → a-id P
    ; F-seq = λ {P} {Q} {R} f g → a-seq P Q R f g
    }
