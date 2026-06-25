{-# OPTIONS --cubical --guardedness #-}

-- The finite-frame presheaf record, valued in an arbitrary Cubical
-- `Category`.
--
-- This is the framework abstraction at the heart of the finite descent /
-- sheaf-category stack, extracted (Phase 1 of the value-category program)
-- from `EventProductPresheaf.agda` and re-parameterized over a plain
-- library `Category C` rather than the hand-rolled `StarAutonomous V`.
-- The record only ever needed the underlying 1-category — `Ob`, `Hom`,
-- `id`, composition — never any `*`-autonomous structure; making that
-- explicit is what lets legs 1 (V-valued, `C := StarAutonomous→Category
-- V`) and 2 (Set-valued, `C := SET`) be the *same* construction at two
-- value categories.
--
-- A `FiniteFramePresheaf` is a contravariant functor on the finite-frame
-- subsite: it assigns a value object to each `FiniteFrame` and a
-- restriction morphism to each sub-view embedding `FrameHom`, with the
-- two finite frames passed explicitly to `restrict` (since
-- `FiniteFrame.frame` is not injective for unification — see the original
-- header in `EventProductPresheaf.agda`). The honest library-`Functor`
-- view is provided separately in `FiniteFramePresheafFunctor.agda`; this
-- record stays the *working* representation, so the landed
-- `restrict-comp`-style proofs are not re-derived under the `⋆`/`∘` flip.
--
-- Scope guardrails: generic over any `Category C`; no value-category
-- structure beyond the underlying 1-category, no session syntax, no
-- operad imports.

module Concurrency.Hybrid.FinitePresheaf where

open import Cubical.Foundations.Prelude
open import Cubical.Categories.Category.Base using (Category)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal
  using ( LocalFrame ; FrameHom ; frame-id ; _∘ᶠ_ )
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Algebras.CategoryApplicative using (module ApplicativeView)

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓV ℓH : Level} (C : Category ℓV ℓH) where

  open ApplicativeView C

  record FiniteFramePresheaf {ℓE ℓR : Level}
       : Type (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE (ℓ-max ℓR (ℓ-max ℓV ℓH))))) where
    field
      value :
        FiniteFrame AB ℓE ℓR → Ob
      restrict :
        (F G : FiniteFrame AB ℓE ℓR)
        → FrameHom AB (FiniteFrame.frame G) (FiniteFrame.frame F)
        → Hom (value F) (value G)
      restrict-id :
        (F : FiniteFrame AB ℓE ℓR)
        → restrict F F (frame-id AB (FiniteFrame.frame F)) ≡ id
      restrict-comp :
        (F G H : FiniteFrame AB ℓE ℓR)
        (ψ : FrameHom AB (FiniteFrame.frame G) (FiniteFrame.frame H))
        (φ : FrameHom AB (FiniteFrame.frame F) (FiniteFrame.frame G))
        → restrict H F (_∘ᶠ_ AB ψ φ) ≡ restrict G F φ ∘ restrict H G ψ
