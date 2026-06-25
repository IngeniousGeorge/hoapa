{-# OPTIONS --cubical --guardedness #-}

-- The point-product reflector on objects, over the *supported* subsite,
-- built on the slot-indexed P-free product API (`SupportedPointProduct`).
--
-- `pointify P` is the point-product presheaf `a(P)(SF) = ∏_e P(pt_e)`. Its
-- value is `pointProduct SF (slotOf P SF)` — the product *head* is
-- presheaf-free, with the frame `SF` an explicit argument; only the slot
-- family `slotOf P SF` depends on `P`. (That is what lets the reflector
-- functor's naturality — which mixes the P-side and the Q-side — elaborate;
-- see `SupportedPointProduct` and `PointSheafification`.)
--
-- The functoriality (`restrict-id`/`restrict-comp`) reduces, through the
-- product β/ext laws, to frame-local facts about the induced point
-- morphisms (`point-hom-id`, `point-hom-comp`), each a one-line `FrameHom≡`.
--
-- Exposed point interface (consumed downstream): the point frame `pt`, the
-- outer projection `point-proj`, the singleton unwrap `point-unwrap`, the
-- unit triangle `point-unit`, singleton-product monicity `point-unwrap-mono`,
-- and point-projection naturality `point-proj-nat`.
--
-- Spike scope unchanged: frames at event level `ℓ-zero`, incidence `ℓA`.

module Concurrency.Hybrid.SupportedPointification where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Unit using (tt* ; isPropUnit*)

open import Cubical.Categories.Category.Base using (Category)
open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal
  using (LocalFrame ; FrameHom ; frame-id ; _∘ᶠ_)
open import Concurrency.Sites.ActorPullback using (FrameHom≡)
open import Concurrency.Sites.EventPoint using (point-frame ; point-hom ; point-embed)
open import Concurrency.Sites.EventSupported
  using (SupportedFiniteFrame ; sfFrame ; sfEv)
open import Concurrency.Algebras.CategoryApplicative using (module ApplicativeView)
open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)
open import Concurrency.Hybrid.SupportedPresheafCategory using (SupportedPresheaf)
open import Concurrency.Hybrid.SupportedPointProduct
  using ( pt₀ ; slotOf ; pointProduct ; pointProj ; pointTuple
        ; pointβ ; pointη ; pointExt )

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓ ℓ' : Level} (C : Category ℓ ℓ') (FP : HasFiniteProducts C)
         (P : SupportedPresheaf AB C) where

  open ApplicativeView C
  private module Pp = SupportedPresheaf P

  private
    SFF : Type _
    SFF = SupportedFiniteFrame AB

    uframe : SFF → LocalFrame AB ℓ-zero ℓA
    uframe = sfFrame AB

    Ev : SFF → Type
    Ev = sfEv AB

    -- The shared point frame and slot family (P enters only via `slot`).
    ptp : (SF : SFF) → Ev SF → SFF
    ptp = pt₀ AB C FP

    slot : (SF : SFF) → Ev SF → Ob
    slot = slotOf AB C FP P

    aval : SFF → Ob
    aval SF = pointProduct AB C FP SF (slot SF)

    prj : (SF : SFF) (e : Ev SF) → Hom (aval SF) (slot SF e)
    prj SF = pointProj AB C FP SF (slot SF)

    cmp : (SF SG : SFF) (φ : FrameHom AB (uframe SG) (uframe SF)) (d : Ev SG)
        → Hom (slot SF (FrameHom.event-map φ d)) (slot SG d)
    cmp SF SG φ d =
      Pp.restrict (ptp SF (FrameHom.event-map φ d)) (ptp SG d)
                  (point-hom AB (uframe SG) (uframe SF) φ d)

    ares : (SF SG : SFF) (φ : FrameHom AB (uframe SG) (uframe SF))
         → Hom (aval SF) (aval SG)
    ares SF SG φ =
      pointTuple AB C FP SG (slot SG)
        (λ d → cmp SF SG φ d ∘ prj SF (FrameHom.event-map φ d))

    --------------------------------------------------------------------
    -- Frame-local coherences.
    --------------------------------------------------------------------

    point-hom-id : (SF : SFF) (d : Ev SF)
                 → point-hom AB (uframe SF) (uframe SF)
                             (frame-id AB (uframe SF)) d
                   ≡ frame-id AB (point-frame AB (uframe SF) d)
    point-hom-id SF d = FrameHom≡ AB _ _ (funExt (λ e → isPropUnit* tt* e))

    point-hom-comp :
        (SF SG SH : SFF)
        (ψ : FrameHom AB (uframe SG) (uframe SH))
        (φ : FrameHom AB (uframe SF) (uframe SG))
        (d : Ev SF)
      → point-hom AB (uframe SF) (uframe SH) (_∘ᶠ_ AB ψ φ) d
        ≡ _∘ᶠ_ AB (point-hom AB (uframe SG) (uframe SH) ψ
                             (FrameHom.event-map φ d))
                  (point-hom AB (uframe SF) (uframe SG) φ d)
    point-hom-comp SF SG SH ψ φ d = FrameHom≡ AB _ _ refl

    cmp-id : (SF : SFF) (d : Ev SF)
           → cmp SF SF (frame-id AB (uframe SF)) d ≡ id
    cmp-id SF d =
        cong (Pp.restrict (ptp SF d) (ptp SF d)) (point-hom-id SF d)
      ∙ Pp.restrict-id (ptp SF d)

    cmp-comp :
        (SF SG SH : SFF)
        (ψ : FrameHom AB (uframe SG) (uframe SH))
        (φ : FrameHom AB (uframe SF) (uframe SG))
        (d : Ev SF)
      → cmp SH SF (_∘ᶠ_ AB ψ φ) d
        ≡ cmp SG SF φ d ∘ cmp SH SG ψ (FrameHom.event-map φ d)
    cmp-comp SF SG SH ψ φ d =
        cong (Pp.restrict (ptp SH (FrameHom.event-map (_∘ᶠ_ AB ψ φ) d)) (ptp SF d))
             (point-hom-comp SF SG SH ψ φ d)
      ∙ Pp.restrict-comp (ptp SF d) (ptp SG (FrameHom.event-map φ d))
                         (ptp SH (FrameHom.event-map ψ (FrameHom.event-map φ d)))
                         (point-hom AB (uframe SG) (uframe SH) ψ
                                    (FrameHom.event-map φ d))
                         (point-hom AB (uframe SF) (uframe SG) φ d)

    --------------------------------------------------------------------
    -- Functoriality.
    --------------------------------------------------------------------

    ares-id : (SF : SFF) → ares SF SF (frame-id AB (uframe SF)) ≡ id
    ares-id SF =
      pointExt AB C FP SF (slot SF) (ares SF SF fid) id per-d
      where
        fid = frame-id AB (uframe SF)
        per-d : (d : Ev SF) → prj SF d ∘ ares SF SF fid ≡ prj SF d ∘ id
        per-d d =
            pointβ AB C FP SF (slot SF)
               (λ d' → cmp SF SF fid d' ∘ prj SF (FrameHom.event-map fid d')) d
          ∙ cong (_∘ prj SF d) (cmp-id SF d)
          ∙ id-l (prj SF d)
          ∙ sym (id-r (prj SF d))

    ares-comp :
        (SF SG SH : SFF)
        (ψ : FrameHom AB (uframe SG) (uframe SH))
        (φ : FrameHom AB (uframe SF) (uframe SG))
      → ares SH SF (_∘ᶠ_ AB ψ φ) ≡ ares SG SF φ ∘ ares SH SG ψ
    ares-comp SF SG SH ψ φ =
      pointExt AB C FP SF (slot SF)
        (ares SH SF (_∘ᶠ_ AB ψ φ)) (ares SG SF φ ∘ ares SH SG ψ) per-d
      where
        per-d : (d : Ev SF)
              → prj SF d ∘ ares SH SF (_∘ᶠ_ AB ψ φ)
                ≡ prj SF d ∘ (ares SG SF φ ∘ ares SH SG ψ)
        per-d d =
            pointβ AB C FP SF (slot SF)
               (λ d' → cmp SH SF (_∘ᶠ_ AB ψ φ) d' ∘ prj SH (FrameHom.event-map (_∘ᶠ_ AB ψ φ) d')) d
          ∙ cong (_∘ prj SH (FrameHom.event-map ψ (FrameHom.event-map φ d)))
                 (cmp-comp SF SG SH ψ φ d)
          ∙ ∘-assoc (cmp SG SF φ d) (cmp SH SG ψ (FrameHom.event-map φ d))
                    (prj SH (FrameHom.event-map ψ (FrameHom.event-map φ d)))
          ∙ cong (cmp SG SF φ d ∘_)
                 (sym (pointβ AB C FP SG (slot SG)
                          (λ e → cmp SH SG ψ e ∘ prj SH (FrameHom.event-map ψ e))
                          (FrameHom.event-map φ d)))
          ∙ sym (∘-assoc (cmp SG SF φ d)
                         (prj SG (FrameHom.event-map φ d))
                         (ares SH SG ψ))
          ∙ cong (_∘ ares SH SG ψ)
                 (sym (pointβ AB C FP SF (slot SF)
                          (λ d' → cmp SG SF φ d' ∘ prj SG (FrameHom.event-map φ d')) d))
          ∙ ∘-assoc (prj SF d) (ares SG SF φ) (ares SH SG ψ)

  -- The supported point-product presheaf.
  pointify : SupportedPresheaf AB C
  pointify = record
    { value         = aval
    ; restrict      = ares
    ; restrict-id   = ares-id
    ; restrict-comp = ares-comp
    }

  ----------------------------------------------------------------------
  -- Exposed point interface.
  ----------------------------------------------------------------------

  pt : (SF : SFF) (e : Ev SF) → SFF
  pt = ptp

  point-proj : (SF : SFF) (e : Ev SF)
             → Hom (SupportedPresheaf.value pointify SF) (Pp.value (pt SF e))
  point-proj = prj

  point-unwrap : (SF : SFF) (e : Ev SF)
               → Hom (SupportedPresheaf.value pointify (pt SF e)) (Pp.value (pt SF e))
  point-unwrap SF e = pointProj AB C FP (pt SF e) (slot (pt SF e)) tt*

  point-unit : (SF : SFF) (e : Ev SF)
    → point-unwrap SF e
        ∘ SupportedPresheaf.restrict pointify SF (pt SF e)
            (point-embed AB (uframe SF) e)
      ≡ point-proj SF e
  point-unit SF e =
      pointβ AB C FP (pt SF e) (slot (pt SF e))
         (λ d → cmp SF (pt SF e) (point-embed AB (uframe SF) e) d
                ∘ prj SF (FrameHom.event-map (point-embed AB (uframe SF) e) d)) tt*
    ∙ cong (_∘ prj SF e) cmp-diag
    ∙ id-l (prj SF e)
    where
      cmp-diag : cmp SF (pt SF e) (point-embed AB (uframe SF) e) tt* ≡ id
      cmp-diag =
          cong (Pp.restrict (pt SF e) (pt SF e))
               (FrameHom≡ AB
                  (point-hom AB (uframe (pt SF e)) (uframe SF)
                             (point-embed AB (uframe SF) e) tt*)
                  (frame-id AB (uframe (pt SF e)))
                  (funExt (λ u → isPropUnit* tt* u)))
        ∙ Pp.restrict-id (pt SF e)

  point-unwrap-mono : (SF : SFF) (e : Ev SF) {X : Ob}
                      (a b : Hom X (SupportedPresheaf.value pointify (pt SF e)))
                    → point-unwrap SF e ∘ a ≡ point-unwrap SF e ∘ b → a ≡ b
  point-unwrap-mono SF e {X} a b h =
    pointExt AB C FP (pt SF e) (slot (pt SF e)) a b
      (λ t → subst (λ u → pointProj AB C FP (pt SF e) (slot (pt SF e)) u ∘ a
                        ≡ pointProj AB C FP (pt SF e) (slot (pt SF e)) u ∘ b)
                   (isPropUnit* tt* t) h)

  -- Point-projection naturality, stated with the P-free product head
  -- (`pointProj`) and the P-free slot family (`slotOf … P`), so the
  -- reflector functor can use the P-side and Q-side instances together.
  point-proj-nat : (SF SF' : SFF)
                   (φ : FrameHom AB (uframe SF') (uframe SF)) (d : Ev SF')
    → pointProj AB C FP SF' (slotOf AB C FP P SF') d
        ∘ SupportedPresheaf.restrict pointify SF SF' φ
      ≡ Pp.restrict (ptp SF (FrameHom.event-map φ d)) (ptp SF' d)
                    (point-hom AB (uframe SF') (uframe SF) φ d)
        ∘ pointProj AB C FP SF (slotOf AB C FP P SF) (FrameHom.event-map φ d)
  point-proj-nat SF SF' φ d =
    pointβ AB C FP SF' (slot SF')
       (λ d' → cmp SF SF' φ d' ∘ prj SF (FrameHom.event-map φ d')) d
