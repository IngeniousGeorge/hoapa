{-# OPTIONS --cubical --guardedness #-}

-- The canonical point cover of an event-supported finite frame.
--
-- Brick 1 of the point-generated R4 reflector route, and a *parallel*
-- interface to `FiniteCover.agda` — deliberately not a reuse of it. The
-- difference is exactly the geometry fix: `FiniteCover`'s overlaps are
-- `ActorPullback.frame-pullback` (actor-intersection `ActorIn`), whereas
-- the point cover's overlaps are the *event-supported* `PointOverlap.
-- point-overlap` (event-generated `ActorIn`). That is what makes an
-- off-diagonal overlap actor-empty, not merely event-empty.
--
-- The cover of a finite frame `F`:
--
--   * patches  = the event points `point-frame e` (one per event of `F`);
--   * embeds   = `point-embed e`;
--   * event-covered : event `e` is covered by patch `e` (definitional);
--   * actor-covered : from a *chosen* event support of `F` — an actor in
--     `F` is touched by some chosen event, and the corresponding point
--     patch contains it (`(point-frame e).ActorIn = touches e`);
--   * overlaps = `point-overlap d e`, made finite by *deciding* `d ≡ e`
--     through `F`'s enumeration (`Event` is discrete because `Event ≃ Fin
--     n`): on-diagonal the overlap has one event, off-diagonal it is the
--     empty frame.
--
-- Looking forward (Brick 2). The point-generated sheaf condition will be
-- `IsPointSheaf`/`PointLocal`, *defined* via descent over this cover —
-- **not** `FiniteDescent.IsSheaf`, which carries extra actor-only-overlap
-- content the point geometry has deliberately removed. The empty frame's
-- canonical point cover is the empty-index cover; the `PointDescent`
-- record (Brick 2) must accept that case so sheafness *forces*
-- `value(empty) ≅ terminal` — the **owed zero-event terminality lemma**.
-- This file does not claim a full Cubical `Coverage`: only the canonical
-- point cover and its event-supported overlap cone are built here; the
-- normalized-pullback / stability layer (for a genuine coverage) is the
-- later upgrade and is not attempted.
--
-- Event level `ℓ-zero`, relation/actor level `ℓA` (the incident point
-- frames of `EventPoint.agda`).
--
-- Scope guardrails: pure site / locality machinery; no value / content /
-- operad imports.

module Concurrency.Sites.PointCover where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv using (_≃_ ; equivFun ; invEq ; retEq)
open import Cubical.Foundations.Isomorphism using (Iso ; iso ; isoToEquiv)
open import Cubical.Data.Nat using (ℕ)
open import Cubical.Data.FinData using (Fin) renaming (zero to fzero)
open import Cubical.Data.FinData.Properties using (discreteFin)
open import Cubical.Data.Empty renaming (rec to ⊥-elim)
open import Cubical.Data.Sigma using (Σ-syntax ; _,_ ; fst ; snd)
open import Cubical.Data.Unit using (Unit* ; tt*)
open import Cubical.Relation.Nullary using (Dec ; yes ; no)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal using (LocalFrame ; FrameHom)
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Sites.EventPoint using (point-frame ; point-embed)
open import Concurrency.Sites.PointOverlap using (point-overlap ; po-π₁ ; po-π₂)
open import Concurrency.Sites.EventSupported
  using (ChosenEventSupport ; SupportedFiniteFrame ; point-frame-chosen-support)

module _ {ℓA : Level} (AB : ActorBase ℓA) where
  open ActorBase AB

  ------------------------------------------------------------------
  -- Two small enumeration helpers.
  ------------------------------------------------------------------

  -- `Unit* ≃ Fin 1` (the single event of a point frame).
  private
    Unit*≃Fin1 : Unit* {ℓ-zero} ≃ Fin 1
    Unit*≃Fin1 = isoToEquiv (iso (λ _ → fzero) (λ _ → tt*) sec (λ _ → refl))
      where
        sec : (k : Fin 1) → fzero ≡ k
        sec fzero = refl

  -- A *prop* with decidable inhabitation is finite: `Fin 1` if it holds,
  -- `Fin 0` if not. (The overlap event type `d ≡ e` is such a prop.)
  prop-dec-fin : {ℓ : Level} (P : Type ℓ) → isProp P → Dec P
               → Σ[ n ∈ ℕ ] (P ≃ Fin n)
  prop-dec-fin P pP (yes p) =
    1 , isoToEquiv (iso (λ _ → fzero) (λ _ → p) sec (λ x → pP p x))
    where
      sec : (k : Fin 1) → fzero ≡ k
      sec fzero = refl
  prop-dec-fin P pP (no ¬p) =
    0 , isoToEquiv (iso (λ x → ⊥-elim (¬p x)) (λ ()) (λ ()) (λ x → ⊥-elim (¬p x)))

  ------------------------------------------------------------------
  -- Finite frames are event-discrete (the enumeration transports
  -- `Fin`-discreteness back to events).
  ------------------------------------------------------------------

  discreteEventF : (F : FiniteFrame AB ℓ-zero ℓA)
                   (x y : LocalFrame.Event (FiniteFrame.frame F))
                 → Dec (x ≡ y)
  discreteEventF F x y = lemma (discreteFin (equivFun en x) (equivFun en y))
    where
      en = FiniteFrame.enum F
      injEnum : equivFun en x ≡ equivFun en y → x ≡ y
      injEnum q = sym (retEq en x) ∙ cong (invEq en) q ∙ retEq en y
      lemma : Dec (equivFun en x ≡ equivFun en y) → Dec (x ≡ y)
      lemma (yes q)  = yes (injEnum q)
      lemma (no ¬q)  = no (λ p → ¬q (cong (equivFun en) p))

  ------------------------------------------------------------------
  -- The finite patch and overlap frames.
  ------------------------------------------------------------------

  point-frame-finite : (F : FiniteFrame AB ℓ-zero ℓA)
                       (e : LocalFrame.Event (FiniteFrame.frame F))
                     → FiniteFrame AB ℓ-zero ℓA
  point-frame-finite F e = record
    { frame       = point-frame AB (FiniteFrame.frame F) e
    ; event-count = 1
    ; enum        = Unit*≃Fin1
    }

  -- The event point as a *supported* finite frame: the canonical, presheaf-
  -- independent point frame shared by the pointification reflector
  -- (`SupportedPointification.pt`) and the point cover / descent
  -- (`SupportedPointDescent.Pat`). Being one named function (rather than an
  -- inline record rebuilt in each module) is what keeps the two definitionally
  -- *syntactically* identical, so the reflector functor's naturality unifies
  -- without η-expanding frame metavariables.
  supported-point : (F : FiniteFrame AB ℓ-zero ℓA)
                    (e : LocalFrame.Event (FiniteFrame.frame F))
                  → SupportedFiniteFrame AB
  supported-point F e = record
    { fin     = point-frame-finite F e
    ; support = point-frame-chosen-support AB (FiniteFrame.frame F) e
    }

  point-overlap-finite : (F : FiniteFrame AB ℓ-zero ℓA)
                         (d e : LocalFrame.Event (FiniteFrame.frame F))
                       → FiniteFrame AB ℓ-zero ℓA
  point-overlap-finite F d e = record
    { frame       = point-overlap AB (FiniteFrame.frame F) d e
    ; event-count = fst dec-fin
    ; enum        = snd dec-fin
    }
    where
      dec-fin : Σ[ n ∈ ℕ ] ((d ≡ e) ≃ Fin n)
      dec-fin = prop-dec-fin (d ≡ e)
                  (LocalFrame.Event-set (FiniteFrame.frame F) d e)
                  (discreteEventF F d e)

  ------------------------------------------------------------------
  -- The point-cover interface (parallel to `FiniteCover`).
  ------------------------------------------------------------------

  record PointCover (F : FiniteFrame AB ℓ-zero ℓA) : Type (ℓ-suc ℓA) where
    open LocalFrame (FiniteFrame.frame F)
    field
      Index : Type ℓ-zero
      patch : Index → FiniteFrame AB ℓ-zero ℓA
      embed : (i : Index)
            → FrameHom AB (FiniteFrame.frame (patch i)) (FiniteFrame.frame F)

      -- Coverage on the underlying frame of `F`.
      actor-covered : {a : Actor} → ActorIn a
                    → Σ[ i ∈ Index ]
                        LocalFrame.ActorIn (FiniteFrame.frame (patch i)) a
      event-covered : (e : Event)
                    → Σ[ i ∈ Index ]
                        Σ[ ẽ ∈ LocalFrame.Event (FiniteFrame.frame (patch i)) ]
                          FrameHom.event-map (embed i) ẽ ≡ e

      -- Event-supported overlaps, with their two projections.
      overlap-frame : Index → Index → FiniteFrame AB ℓ-zero ℓA
      ov-π₁ : (i j : Index)
            → FrameHom AB (FiniteFrame.frame (overlap-frame i j))
                          (FiniteFrame.frame (patch i))
      ov-π₂ : (i j : Index)
            → FrameHom AB (FiniteFrame.frame (overlap-frame i j))
                          (FiniteFrame.frame (patch j))

  ------------------------------------------------------------------
  -- The canonical point cover of a chosen-supported finite frame.
  ------------------------------------------------------------------

  point-cover : (F : FiniteFrame AB ℓ-zero ℓA)
                (cs : ChosenEventSupport AB (FiniteFrame.frame F))
              → PointCover F
  point-cover F cs = record
    { Index         = LocalFrame.Event (FiniteFrame.frame F)
    ; patch         = point-frame-finite F
    ; embed         = λ e → point-embed AB (FiniteFrame.frame F) e
    ; actor-covered = λ {a} pa → cs a pa            -- (point-frame e).ActorIn = touches e
    ; event-covered = λ e → e , tt* , refl
    ; overlap-frame = point-overlap-finite F
    ; ov-π₁         = λ d e → po-π₁ AB (FiniteFrame.frame F) d e
    ; ov-π₂         = λ d e → po-π₂ AB (FiniteFrame.frame F) d e
    }

  -- The same, from a bundled `SupportedFiniteFrame` (the Brick-2 object).
  point-coverₛ : (SF : SupportedFiniteFrame AB)
               → PointCover (SupportedFiniteFrame.fin SF)
  point-coverₛ SF =
    point-cover (SupportedFiniteFrame.fin SF) (SupportedFiniteFrame.support SF)
