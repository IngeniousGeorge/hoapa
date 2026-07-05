{-# OPTIONS --cubical --guardedness #-}

-- The sheafification reflector adjunction  a ⊣ ι  for the single-event
-- (point) topology.
--
-- Event-local sheaves form a reflective subcategory of presheaves on the
-- actor-causal site. This file constructs the adjunction that witnesses
-- it: the sheafification functor `a` (`PointSheafification`), which sends
-- a presheaf to the product of its single-event values, is left adjoint
-- to the inclusion `ι` (`PointSheafCategory`) of event-local sheaves into
-- presheaves. This is the reflector  a ⊣ ι  on which the abstract builds
-- the linear/non-linear bridge.
--
-- Because event-local sheaves form a full subcategory, its homs are just
-- presheaf morphisms, so the adjunction bijection is
--
--   adjIso : Hom(a P , S) ≅ Hom(P , ι S).
--
-- The construction:
--   * unit `η_P` — at a frame `SF`, the tuple of restrictions from `SF`
--     to each of its single-event subframes;
--   * forward transpose  `g ↦ g ∘ η_P`;
--   * backward transpose  `f ↦ f̄`  (module `Bwd`) — amalgamate the
--     single-event family  `e ↦ f(ptₑ) ∘ (projection to e)`  through the
--     event-local sheaf property of `S`, using only its public interface;
--   * the two round-trips, each from `S` being separated;
--   * naturality: `adjNatInD` from associativity of composition,
--     `adjNatInC` from separatedness of `S`.
--
-- The finite products are used through an abstract interface: as the
-- abstract notes, keeping them abstract stops the proof assistant from
-- unfolding them into enumeration-dependent normal forms during
-- unification.

module Concurrency.Hybrid.PointSheafAdjunction where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Isomorphism using (Iso ; iso)
open import Cubical.Data.Sigma using (Σ-syntax ; _,_ ; fst ; snd ; Σ≡Prop)
open import Cubical.Data.Unit using (tt* ; isPropUnit*)

open import Cubical.Categories.Category.Base using (Category)
open import Cubical.Categories.Functor.Base using (Functor)
open import Cubical.Categories.Adjoint using (module NaturalBijection)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal using (LocalFrame ; FrameHom ; frame-id ; _∘ᶠ_)
open import Concurrency.Sites.ActorPullback using (FrameHom≡)
open import Concurrency.Sites.EventPoint using (point-hom ; point-embed)
open import Concurrency.Sites.EventSupported
  using (SupportedFiniteFrame ; sfFrame ; sfEv)
open import Concurrency.Algebras.CategoryApplicative using (module ApplicativeView)
open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)
open import Concurrency.Hybrid.SupportedPresheafCategory
  using ( SupportedPresheaf ; SupportedPresheafCategory
        ; NatFam ; isNat ; PshHom ; compPsh ; isNat-isProp )
open import Concurrency.Hybrid.SupportedPointProduct
  using (pt₀ ; slotOf ; pointProj ; pointTuple ; pointβ ; pointExt)
open import Concurrency.Hybrid.SupportedPointification
  using ( pointify ; point-proj-nat
        ; point-unwrap ; point-unit ; point-unwrap-mono )
open import Concurrency.Hybrid.SupportedPointDescent
  using ( IsPointSheaf ; PointSeparated ; PointAmalgamation ; PointMatchingFamily
        ; point-family-matching ; rπ ; Pat ; Idx ; point-sheaf⟺local )
open import Concurrency.Hybrid.PointSheafCategory using (PointSheafCategory ; ιP)
open import Concurrency.Hybrid.PointSheafification using (a)

open NaturalBijection using (_⊣_)

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓ ℓ' : Level} (C : Category ℓ ℓ') (FP : HasFiniteProducts C) where

  open ApplicativeView C

  private
    sheafify = pointify AB C FP
    ppnat    = point-proj-nat AB C FP
    pProj    = pointProj AB C FP
    pTup     = pointTuple AB C FP
    pβ       = pointβ AB C FP
    pExt     = pointExt AB C FP
    sl       = slotOf AB C FP
    ptz      = pt₀ AB C FP
    unwrap   = point-unwrap AB C FP
    unit     = point-unit AB C FP
    uwmono   = point-unwrap-mono AB C FP

    uf : SupportedFiniteFrame AB → LocalFrame AB ℓ-zero ℓA
    uf = sfFrame AB

    ev : SupportedFiniteFrame AB → Type ℓ-zero
    ev = sfEv AB

  ----------------------------------------------------------------------
  -- The unit family and its naturality.
  ----------------------------------------------------------------------

  ηfam : (P : SupportedPresheaf AB C) → NatFam AB C P (sheafify P)
  ηfam P SF =
    pTup SF (sl P SF) {X = SupportedPresheaf.value P SF}
      (λ e → SupportedPresheaf.restrict P SF (ptz SF e) (point-embed AB (uf SF) e))

  ηnat : (P : SupportedPresheaf AB C) → isNat AB C P (sheafify P) (ηfam P)
  ηnat P {SF} {SG} φ =
    pExt SG (sl P SG) {X = SupportedPresheaf.value P SF}
      (ηfam P SG ∘ SupportedPresheaf.restrict P SF SG φ)
      (SupportedPresheaf.restrict (sheafify P) SF SG φ ∘ ηfam P SF)
      per
    where
      rr = SupportedPresheaf.restrict P
      rc = SupportedPresheaf.restrict-comp P

      per : (e : ev SG)
          → pProj SG (sl P SG) e ∘ (ηfam P SG ∘ SupportedPresheaf.restrict P SF SG φ)
            ≡ pProj SG (sl P SG) e ∘ (SupportedPresheaf.restrict (sheafify P) SF SG φ ∘ ηfam P SF)
      per e =
          sym (∘-assoc (pProj SG (sl P SG) e) (ηfam P SG)
                       (SupportedPresheaf.restrict P SF SG φ))
        ∙ cong (_∘ SupportedPresheaf.restrict P SF SG φ)
               (pβ SG (sl P SG)
                  (λ e' → rr SG (ptz SG e') (point-embed AB (uf SG) e')) e)
        ∙ sym (rc (ptz SG e) SG SF φ (point-embed AB (uf SG) e))
        ∙ cong (rr SF (ptz SG e))
               (FrameHom≡ AB
                  (_∘ᶠ_ AB φ (point-embed AB (uf SG) e))
                  (_∘ᶠ_ AB (point-embed AB (uf SF) φe) ph)
                  refl)
        ∙ rc (ptz SG e) (ptz SF φe) SF (point-embed AB (uf SF) φe) ph
        ∙ cong (rr (ptz SF φe) (ptz SG e) ph ∘_)
               (sym (pβ SF (sl P SF)
                       (λ e' → rr SF (ptz SF e') (point-embed AB (uf SF) e')) φe))
        ∙ sym (∘-assoc (rr (ptz SF φe) (ptz SG e) ph) (pProj SF (sl P SF) φe) (ηfam P SF))
        ∙ cong (_∘ ηfam P SF) (sym (ppnat P SF SG φ e))
        ∙ ∘-assoc (pProj SG (sl P SG) e)
                  (SupportedPresheaf.restrict (sheafify P) SF SG φ) (ηfam P SF)
        where
          φe = FrameHom.event-map φ e
          ph = point-hom AB (uf SG) (uf SF) φ e

  η : (P : SupportedPresheaf AB C) → PshHom AB C P (sheafify P)
  η P = ηfam P , ηnat P

  ----------------------------------------------------------------------
  -- The backward transpose, as a parameterized module so that the
  -- amalgamation property is available to the roundtrips.
  ----------------------------------------------------------------------

  module Bwd (P : SupportedPresheaf AB C)
             (S : Category.ob (PointSheafCategory AB C FP))
             (f : PshHom AB C P (fst S)) where
    Sp     = fst S
    isps   = snd (point-sheaf⟺local AB C FP Sp) (snd S)
    sepS   = IsPointSheaf.separated isps
    amalgS = IsPointSheaf.amalgamating isps
    ffam   = fst f
    fnat   = snd f
    rπS    = rπ AB C Sp
    rrS    = SupportedPresheaf.restrict Sp
    rcS    = SupportedPresheaf.restrict-comp Sp
    rrP    = SupportedPresheaf.restrict P

    partf : (SF : SupportedFiniteFrame AB) (e : Idx AB C SF)
          → Hom (SupportedPresheaf.value (sheafify P) SF) (SupportedPresheaf.value Sp (Pat AB C SF e))
    partf SF e = ffam (ptz SF e) ∘ pProj SF (sl P SF) e

    amal : (SF : SupportedFiniteFrame AB)
         → Σ[ s ∈ Hom (SupportedPresheaf.value (sheafify P) SF) (SupportedPresheaf.value Sp SF) ]
             ((i : Idx AB C SF) → rπS SF i ∘ s ≡ partf SF i)
    amal SF = PointAmalgamation.amalgamate amalgS SF
                (point-family-matching AB C Sp sepS SF (partf SF))

    bfam : NatFam AB C (sheafify P) Sp
    bfam SF = fst (amal SF)

    bprop : (SF : SupportedFiniteFrame AB) (i : Idx AB C SF)
          → rπS SF i ∘ bfam SF ≡ partf SF i
    bprop SF = snd (amal SF)

    bnat : isNat AB C (sheafify P) Sp bfam
    bnat {SF} {SG} φ =
      PointSeparated.cover-jointly-monic sepS SG (bfam SG ∘ rP) (rS ∘ bfam SF) hyp
      where
        rP = SupportedPresheaf.restrict (sheafify P) SF SG φ
        rS = SupportedPresheaf.restrict Sp SF SG φ

        hyp : (e : Idx AB C SG) → rπS SG e ∘ (bfam SG ∘ rP) ≡ rπS SG e ∘ (rS ∘ bfam SF)
        hyp e = lhsM ∙ sym rhsM
          where
            φe     = FrameHom.event-map φ e
            ph     = point-hom AB (uf SG) (uf SF) φ e
            emb-SG = point-embed AB (uf SG) e
            emb-SF = point-embed AB (uf SF) φe

            M : Hom (SupportedPresheaf.value (sheafify P) SF) (SupportedPresheaf.value Sp (ptz SG e))
            M = rrS (ptz SF φe) (ptz SG e) ph ∘ (ffam (ptz SF φe) ∘ pProj SF (sl P SF) φe)

            lhsM : rπS SG e ∘ (bfam SG ∘ rP) ≡ M
            lhsM =
                sym (∘-assoc (rπS SG e) (bfam SG) rP)
              ∙ cong (_∘ rP) (bprop SG e)
              ∙ ∘-assoc (ffam (ptz SG e)) (pProj SG (sl P SG) e) rP
              ∙ cong (ffam (ptz SG e) ∘_) (ppnat P SF SG φ e)
              ∙ sym (∘-assoc (ffam (ptz SG e)) (rrP (ptz SF φe) (ptz SG e) ph)
                             (pProj SF (sl P SF) φe))
              ∙ cong (_∘ pProj SF (sl P SF) φe) (fnat {ptz SF φe} {ptz SG e} ph)
              ∙ ∘-assoc (rrS (ptz SF φe) (ptz SG e) ph) (ffam (ptz SF φe))
                        (pProj SF (sl P SF) φe)

            rπS-rS : rπS SG e ∘ rS ≡ rrS (ptz SF φe) (ptz SG e) ph ∘ rπS SF φe
            rπS-rS =
                sym (rcS (ptz SG e) SG SF φ emb-SG)
              ∙ cong (rrS SF (ptz SG e))
                     (FrameHom≡ AB (_∘ᶠ_ AB φ emb-SG) (_∘ᶠ_ AB emb-SF ph) refl)
              ∙ rcS (ptz SG e) (ptz SF φe) SF emb-SF ph

            rhsM : rπS SG e ∘ (rS ∘ bfam SF) ≡ M
            rhsM =
                sym (∘-assoc (rπS SG e) rS (bfam SF))
              ∙ cong (_∘ bfam SF) rπS-rS
              ∙ ∘-assoc (rrS (ptz SF φe) (ptz SG e) ph) (rπS SF φe) (bfam SF)
              ∙ cong (rrS (ptz SF φe) (ptz SG e) ph ∘_) (bprop SF φe)

    bwd : PshHom AB C (sheafify P) Sp
    bwd = bfam , bnat

  ----------------------------------------------------------------------
  -- Two coherences of the unit at a single-event subframe (needed for the
  -- left round-trip).
  ----------------------------------------------------------------------

  -- The unit at a single-event subframe unwraps to the identity.
  unwrap∘η≡id : (P : SupportedPresheaf AB C) (SF : SupportedFiniteFrame AB) (e : ev SF)
              → unwrap P SF e ∘ ηfam P (ptz SF e) ≡ id
  unwrap∘η≡id P SF e =
      pβ (ptz SF e) (sl P (ptz SF e))
         (λ t' → SupportedPresheaf.restrict P (ptz SF e) (ptz (ptz SF e) t')
                   (point-embed AB (uf (ptz SF e)) t')) tt*
    ∙ cong (SupportedPresheaf.restrict P (ptz SF e) (ptz SF e))
           (FrameHom≡ AB
              (point-embed AB (uf (ptz SF e)) tt*)
              (frame-id AB (uf (ptz SF e)))
              (funExt (λ u → isPropUnit* tt* u)))
    ∙ SupportedPresheaf.restrict-id P (ptz SF e)

  -- The unit composed with the projection to a single event is the
  -- restriction to that single-event subframe.
  η-pProj : (P : SupportedPresheaf AB C) (SF : SupportedFiniteFrame AB) (e : ev SF)
          → ηfam P (ptz SF e) ∘ pProj SF (sl P SF) e
            ≡ SupportedPresheaf.restrict (sheafify P) SF (ptz SF e) (point-embed AB (uf SF) e)
  η-pProj P SF e =
    uwmono P SF e
      (ηfam P (ptz SF e) ∘ pProj SF (sl P SF) e)
      (SupportedPresheaf.restrict (sheafify P) SF (ptz SF e) (point-embed AB (uf SF) e))
      h
    where
      h : unwrap P SF e ∘ (ηfam P (ptz SF e) ∘ pProj SF (sl P SF) e)
        ≡ unwrap P SF e
            ∘ SupportedPresheaf.restrict (sheafify P) SF (ptz SF e) (point-embed AB (uf SF) e)
      h =
          sym (∘-assoc (unwrap P SF e) (ηfam P (ptz SF e)) (pProj SF (sl P SF) e))
        ∙ cong (_∘ pProj SF (sl P SF) e) (unwrap∘η≡id P SF e)
        ∙ id-l (pProj SF (sl P SF) e)
        ∙ sym (unit P SF e)

  ----------------------------------------------------------------------
  -- The hom-set bijection.
  ----------------------------------------------------------------------

  adjIso : (P : SupportedPresheaf AB C) (S : Category.ob (PointSheafCategory AB C FP))
         → Iso (PshHom AB C (sheafify P) (fst S)) (PshHom AB C P (fst S))
  adjIso P S = iso fwd (Bwd.bwd P S) rightInv leftInv
    where
      Sp = fst S

      fwd : PshHom AB C (sheafify P) Sp → PshHom AB C P Sp
      fwd g = compPsh AB C P (sheafify P) Sp (η P) g

      rightInv : (f : PshHom AB C P Sp) → fwd (Bwd.bwd P S f) ≡ f
      rightInv f = Σ≡Prop (λ γ → isNat-isProp AB C P Sp γ) (funExt rfam)
        where
          module Bf = Bwd P S f
          rfam : (SF : SupportedFiniteFrame AB)
               → fst (fwd (Bwd.bwd P S f)) SF ≡ fst f SF
          rfam SF =
            PointSeparated.cover-jointly-monic Bf.sepS SF
              (Bf.bfam SF ∘ ηfam P SF) (fst f SF) hyp
            where
              hyp : (e : ev SF)
                  → Bf.rπS SF e ∘ (Bf.bfam SF ∘ ηfam P SF) ≡ Bf.rπS SF e ∘ fst f SF
              hyp e =
                  sym (∘-assoc (Bf.rπS SF e) (Bf.bfam SF) (ηfam P SF))
                ∙ cong (_∘ ηfam P SF) (Bf.bprop SF e)
                ∙ ∘-assoc (Bf.ffam (ptz SF e)) (pProj SF (sl P SF) e) (ηfam P SF)
                ∙ cong (Bf.ffam (ptz SF e) ∘_)
                       (pβ SF (sl P SF)
                          (λ e' → SupportedPresheaf.restrict P SF (ptz SF e')
                                    (point-embed AB (uf SF) e')) e)
                ∙ Bf.fnat {SF} {ptz SF e} (point-embed AB (uf SF) e)

      leftInv : (g : PshHom AB C (sheafify P) Sp) → Bwd.bwd P S (fwd g) ≡ g
      leftInv g = Σ≡Prop (λ γ → isNat-isProp AB C (sheafify P) Sp γ) (funExt lfam)
        where
          module Bg = Bwd P S (fwd g)
          lfam : (SF : SupportedFiniteFrame AB)
               → fst (Bwd.bwd P S (fwd g)) SF ≡ fst g SF
          lfam SF =
            PointSeparated.cover-jointly-monic Bg.sepS SF
              (Bg.bfam SF) (fst g SF) hyp
            where
              hyp : (e : ev SF)
                  → Bg.rπS SF e ∘ Bg.bfam SF ≡ Bg.rπS SF e ∘ fst g SF
              hyp e =
                  Bg.bprop SF e
                ∙ ∘-assoc (fst g (ptz SF e)) (ηfam P (ptz SF e)) (pProj SF (sl P SF) e)
                ∙ cong (fst g (ptz SF e) ∘_) (η-pProj P SF e)
                ∙ snd g {SF} {ptz SF e} (point-embed AB (uf SF) e)

  ----------------------------------------------------------------------
  -- The two naturality fields, then the adjunction `a ⊣ ι`.
  ----------------------------------------------------------------------

  private
    aF = a AB C FP
    ιF = ιP AB C FP

  private
    ncFam : (P' P : SupportedPresheaf AB C)
            (S : Category.ob (PointSheafCategory AB C FP))
            (g : PshHom AB C P (fst S)) (h : PshHom AB C P' P)
            (SF : SupportedFiniteFrame AB)
          → fst (Bwd.bwd P' S (compPsh AB C P' P (fst S) h g)) SF
            ≡ fst (compPsh AB C (sheafify P') (sheafify P) (fst S)
                            (Functor.F-hom aF {P'} {P} h) (Bwd.bwd P S g)) SF
    ncFam P' P S g h SF =
      PointSeparated.cover-jointly-monic Bf'.sepS SF
        (Bf'.bfam SF)
        (Bg.bfam SF ∘ fst (Functor.F-hom aF {P'} {P} h) SF)
        hyp
      where
        module Bf' = Bwd P' S (compPsh AB C P' P (fst S) h g)
        module Bg  = Bwd P S g
        hyp : (e : ev SF)
            → Bf'.rπS SF e ∘ Bf'.bfam SF
              ≡ Bf'.rπS SF e ∘ (Bg.bfam SF ∘ fst (Functor.F-hom aF {P'} {P} h) SF)
        hyp e = lhsC ∙ sym rhsC
          where
            lhsC : Bf'.rπS SF e ∘ Bf'.bfam SF
                 ≡ fst g (ptz SF e) ∘ (fst h (ptz SF e) ∘ pProj SF (sl P' SF) e)
            lhsC =
                Bf'.bprop SF e
              ∙ ∘-assoc (fst g (ptz SF e)) (fst h (ptz SF e)) (pProj SF (sl P' SF) e)

            rhsC : Bf'.rπS SF e ∘ (Bg.bfam SF ∘ fst (Functor.F-hom aF {P'} {P} h) SF)
                 ≡ fst g (ptz SF e) ∘ (fst h (ptz SF e) ∘ pProj SF (sl P' SF) e)
            rhsC =
                sym (∘-assoc (Bf'.rπS SF e) (Bg.bfam SF) (fst (Functor.F-hom aF {P'} {P} h) SF))
              ∙ cong (_∘ fst (Functor.F-hom aF {P'} {P} h) SF) (Bg.bprop SF e)
              ∙ ∘-assoc (fst g (ptz SF e)) (pProj SF (sl P SF) e)
                        (fst (Functor.F-hom aF {P'} {P} h) SF)
              ∙ cong (fst g (ptz SF e) ∘_)
                     (pβ SF (sl P SF)
                        (λ e' → fst h (ptz SF e') ∘ pProj SF (sl P' SF) e') e)

  a⊣ι : aF ⊣ ιF
  a⊣ι = record
    { adjIso = λ {P} {S} → adjIso P S
    ; adjNatInD = λ {P} {S} {S'} f k →
        Σ≡Prop (λ γ → isNat-isProp AB C P (fst S') γ)
          (funExt (λ SF → ∘-assoc (fst k SF) (fst f SF) (ηfam P SF)))
    ; adjNatInC = λ {P'} {P} {S} g h →
        Σ≡Prop (λ γ → isNat-isProp AB C (sheafify P') (fst S) γ)
          (funExt (λ SF → ncFam P' P S g h SF))
    }
