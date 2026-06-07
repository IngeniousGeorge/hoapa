{-# OPTIONS --cubical --guardedness #-}

-- The point-product presheaf `a(P)` — the candidate sheafification
-- reflector on objects, for an *arbitrary* finite-frame presheaf `P`.
--
--   a(P)(F) = ∏_{e ∈ events F} P(pt_e)
--
-- where `pt_e` is the single-event sub-frame at `e` (`EventPoint.agda`).
-- This is the variable-slot generalization of `EventProductPresheaf.agda`
-- (constant slot `P₀`), and the spike's load-bearing test (Codex's step
-- 4): does the reflector's *value-level functoriality* — `restrict-id`,
-- `restrict-comp` — stay clean once the enumeration transport is confined
-- to `EnumeratedProduct.agda`?
--
-- The answer this file demonstrates: yes. With the event-indexed product
-- API (`projE`/`tupleE`/`βE`/`extE`), the restriction is
--
--   a(P)(F → G along φ) = tupleE (λ d → restrict P (point-hom φ d)
--                                          ∘ projE (event-map φ d))
--
-- and both functoriality laws reduce, via `extE` + `βE`, to *frame-local*
-- facts about the induced point morphisms: `point-hom` of the identity is
-- the identity (`point-hom-id`), and `point-hom` of a composite is the
-- composite (`point-hom-comp`) — each a one-line `FrameHom≡`. No enum
-- zigzag survives at this layer.
--
-- Spike scope: frames at event level `ℓ-zero` (the wrapper indexes over
-- `Type₀` event sets); value category `C` and presheaf `P` fully generic.
-- The adjunction (`a ⊣ ι`), the point cover, `IsSheaf ↔ PointLocal`, and
-- the `ActorIn := touches` incidence refinement are the *next* steps,
-- gated on this functoriality landing.

module Concurrency.Hybrid.Pointification where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv using (_≃_)
open import Cubical.Foundations.Isomorphism using (Iso ; iso ; isoToEquiv)
open import Cubical.Data.Nat using (ℕ)
open import Cubical.Data.FinData using (Fin) renaming (zero to fzero)
open import Cubical.Data.Unit using (Unit* ; tt* ; isPropUnit*)

open import Cubical.Categories.Category.Base using (Category)
open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal
  using (LocalFrame ; FrameHom ; frame-id ; _∘ᶠ_)
open import Concurrency.Sites.ActorPullback using (FrameHom≡)
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Sites.EventPoint using (point-frame ; point-hom)
open import Concurrency.Algebras.CategoryApplicative using (module ApplicativeView)
open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)
open import Concurrency.Hybrid.FinitePresheaf using (FiniteFramePresheaf)
open import Concurrency.Hybrid.EnumeratedProduct
  using (∏E ; projE ; tupleE ; βE ; extE)

-- The single-event frame's chosen enumeration `Unit* ≃ Fin 1`.
Unit*≃Fin1 : ∀ {ℓ} → Unit* {ℓ} ≃ Fin 1
Unit*≃Fin1 = isoToEquiv (iso (λ _ → fzero) (λ _ → tt*) sec ret)
  where
    sec : (k : Fin 1) → fzero ≡ k
    sec fzero = refl
    ret : (u : Unit*) → tt* ≡ u
    ret _ = refl

-- Relation level fixed to `ℓA` (the actor level): incident point frames
-- (`EventPoint.agda`) require `ℓR = ℓA`, so the reflector route runs over
-- finite frames whose incidence level equals the actor level.
module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓ ℓ' : Level} (C : Category ℓ ℓ') (FP : HasFiniteProducts C)
         (P : FiniteFramePresheaf AB C {ℓ-zero} {ℓA}) where

  open ApplicativeView C
  private module Pp = FiniteFramePresheaf P

  private
    FF : Type _
    FF = FiniteFrame AB ℓ-zero ℓA

    Ev : FF → Type
    Ev F = LocalFrame.Event (FiniteFrame.frame F)

    en : (F : FF) → Ev F ≃ Fin (FiniteFrame.event-count F)
    en F = FiniteFrame.enum F

    nF : FF → ℕ
    nF F = FiniteFrame.event-count F

    -- The single-event sub-frame at an event, as a finite frame.
    ptf : (F : FF) → Ev F → FF
    ptf F e = record
      { frame       = point-frame AB (FiniteFrame.frame F) e
      ; event-count = 1
      ; enum        = Unit*≃Fin1
      }

    slotE : (F : FF) → Ev F → Ob
    slotE F e = Pp.value (ptf F e)

    aval : FF → Ob
    aval F = ∏E C FP (nF F) (Ev F) (en F) (slotE F)

    -- Convenience: projection / tupling / laws at a frame's event product.
    prj : (F : FF) (e : Ev F) → Hom (aval F) (slotE F e)
    prj F = projE C FP (nF F) (Ev F) (en F) (slotE F)

    -- The component restriction along φ at an event d of the smaller frame.
    cmp : (F G : FF) (φ : FrameHom AB (FiniteFrame.frame G) (FiniteFrame.frame F))
          (d : Ev G)
        → Hom (slotE F (FrameHom.event-map φ d)) (slotE G d)
    cmp F G φ d =
      Pp.restrict (ptf F (FrameHom.event-map φ d)) (ptf G d)
                  (point-hom AB (FiniteFrame.frame G) (FiniteFrame.frame F) φ d)

    ares : (F G : FF) (φ : FrameHom AB (FiniteFrame.frame G) (FiniteFrame.frame F))
         → Hom (aval F) (aval G)
    ares F G φ =
      tupleE C FP (nF G) (Ev G) (en G) (slotE G)
        (λ d → cmp F G φ d ∘ prj F (FrameHom.event-map φ d))

    --------------------------------------------------------------------
    -- The two frame-local coherences (one-line `FrameHom≡`).
    --------------------------------------------------------------------

    point-hom-id : (F : FF) (d : Ev F)
                 → point-hom AB (FiniteFrame.frame F) (FiniteFrame.frame F)
                             (frame-id AB (FiniteFrame.frame F)) d
                   ≡ frame-id AB (point-frame AB (FiniteFrame.frame F) d)
    point-hom-id F d =
      FrameHom≡ AB _ _ (funExt (λ e → isPropUnit* tt* e))

    point-hom-comp :
        (F G H : FF)
        (ψ : FrameHom AB (FiniteFrame.frame G) (FiniteFrame.frame H))
        (φ : FrameHom AB (FiniteFrame.frame F) (FiniteFrame.frame G))
        (d : Ev F)
      → point-hom AB (FiniteFrame.frame F) (FiniteFrame.frame H) (_∘ᶠ_ AB ψ φ) d
        ≡ _∘ᶠ_ AB (point-hom AB (FiniteFrame.frame G) (FiniteFrame.frame H) ψ
                             (FrameHom.event-map φ d))
                  (point-hom AB (FiniteFrame.frame F) (FiniteFrame.frame G) φ d)
    point-hom-comp F G H ψ φ d = FrameHom≡ AB _ _ refl

    -- `cmp` of the identity is the identity.
    cmp-id : (F : FF) (d : Ev F) → cmp F F (frame-id AB (FiniteFrame.frame F)) d ≡ id
    cmp-id F d =
        cong (Pp.restrict (ptf F d) (ptf F d)) (point-hom-id F d)
      ∙ Pp.restrict-id (ptf F d)

    -- `cmp` of a composite factors through the two component restrictions.
    cmp-comp :
        (F G H : FF)
        (ψ : FrameHom AB (FiniteFrame.frame G) (FiniteFrame.frame H))
        (φ : FrameHom AB (FiniteFrame.frame F) (FiniteFrame.frame G))
        (d : Ev F)
      → cmp H F (_∘ᶠ_ AB ψ φ) d
        ≡ cmp G F φ d ∘ cmp H G ψ (FrameHom.event-map φ d)
    cmp-comp F G H ψ φ d =
        cong (Pp.restrict (ptf H (FrameHom.event-map (_∘ᶠ_ AB ψ φ) d)) (ptf F d))
             (point-hom-comp F G H ψ φ d)
      ∙ Pp.restrict-comp (ptf F d) (ptf G (FrameHom.event-map φ d))
                         (ptf H (FrameHom.event-map ψ (FrameHom.event-map φ d)))
                         (point-hom AB (FiniteFrame.frame G) (FiniteFrame.frame H) ψ
                                    (FrameHom.event-map φ d))
                         (point-hom AB (FiniteFrame.frame F) (FiniteFrame.frame G) φ d)

    --------------------------------------------------------------------
    -- Functoriality.
    --------------------------------------------------------------------

    ares-id : (F : FF) → ares F F (frame-id AB (FiniteFrame.frame F)) ≡ id
    ares-id F =
      extE C FP (nF F) (Ev F) (en F) (slotE F) (ares F F fid) id per-d
      where
        fid = frame-id AB (FiniteFrame.frame F)
        per-d : (d : Ev F) → prj F d ∘ ares F F fid ≡ prj F d ∘ id
        per-d d =
            βE C FP (nF F) (Ev F) (en F) (slotE F)
               (λ d' → cmp F F fid d' ∘ prj F (FrameHom.event-map fid d')) d
          ∙ cong (_∘ prj F d) (cmp-id F d)
          ∙ id-l (prj F d)
          ∙ sym (id-r (prj F d))

    ares-comp :
        (F G H : FF)
        (ψ : FrameHom AB (FiniteFrame.frame G) (FiniteFrame.frame H))
        (φ : FrameHom AB (FiniteFrame.frame F) (FiniteFrame.frame G))
      → ares H F (_∘ᶠ_ AB ψ φ) ≡ ares G F φ ∘ ares H G ψ
    ares-comp F G H ψ φ =
      extE C FP (nF F) (Ev F) (en F) (slotE F)
        (ares H F (_∘ᶠ_ AB ψ φ)) (ares G F φ ∘ ares H G ψ) per-d
      where
        per-d : (d : Ev F)
              → prj F d ∘ ares H F (_∘ᶠ_ AB ψ φ)
                ≡ prj F d ∘ (ares G F φ ∘ ares H G ψ)
        per-d d =
            βE C FP (nF F) (Ev F) (en F) (slotE F)
               (λ d' → cmp H F (_∘ᶠ_ AB ψ φ) d' ∘ prj H (FrameHom.event-map (_∘ᶠ_ AB ψ φ) d')) d
          ∙ cong (_∘ prj H (FrameHom.event-map ψ (FrameHom.event-map φ d)))
                 (cmp-comp F G H ψ φ d)
          ∙ ∘-assoc (cmp G F φ d) (cmp H G ψ (FrameHom.event-map φ d))
                    (prj H (FrameHom.event-map ψ (FrameHom.event-map φ d)))
          ∙ cong (cmp G F φ d ∘_)
                 (sym (βE C FP (nF G) (Ev G) (en G) (slotE G)
                          (λ e → cmp H G ψ e ∘ prj H (FrameHom.event-map ψ e))
                          (FrameHom.event-map φ d)))
          ∙ sym (∘-assoc (cmp G F φ d)
                         (prj G (FrameHom.event-map φ d))
                         (ares H G ψ))
          ∙ cong (_∘ ares H G ψ)
                 (sym (βE C FP (nF F) (Ev F) (en F) (slotE F)
                          (λ d' → cmp G F φ d' ∘ prj G (FrameHom.event-map φ d')) d))
          ∙ ∘-assoc (prj F d) (ares G F φ) (ares H G ψ)

  -- The point-product presheaf.
  pointify : FiniteFramePresheaf AB C {ℓ-zero} {ℓA}
  pointify = record
    { value         = aval
    ; restrict      = ares
    ; restrict-id   = ares-id
    ; restrict-comp = ares-comp
    }
