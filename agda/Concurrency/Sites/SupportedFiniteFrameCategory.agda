{-# OPTIONS --cubical --guardedness #-}

-- The supported (point-generated) finite-frame subsite, packaged as a
-- library `Cubical.Categories.Category.Category`.
--
-- This is the parallel of `Concurrency/Sites/FiniteFrameCategory.agda`
-- for the point-generated reflector route: objects are
-- `SupportedFiniteFrame`s (a finite frame bundled with a *chosen* event
-- support, `EventSupported.agda`), morphisms are `FrameHom`s between the
-- underlying frames. As with `FiniteFrameCategory`, finiteness and the
-- chosen support / enumeration are extra structure on objects, *not* a
-- constraint on morphisms: a morphism is support-blind, so the category
-- never requires equality of support witnesses in its laws. (Two objects
-- sharing a `fin` but with different chosen supports are distinct but
-- isomorphic — the same chosen-data redundancy `FiniteFrame` already
-- tolerates with its `event-count`/`enum`.)
--
-- Why a *separate* supported subsite rather than the full finite-frame
-- category. The point-generated sheafification reflector `a ⊣ ι`
-- genuinely fails on inactive (non-event-supported) frames; its universal
-- property lives over the supported subsite. So both the presheaf
-- category (`SupportedPresheafCategory.agda`) and the reflector
-- adjunction are built over *this* category, not over
-- `FiniteFrameCategory`. The adapter from full finite presheaves is
-- `RestrictToSupported.agda`.
--
-- `_⋆_` is diagrammatic (`f ⋆ g = g ∘ᶠ f`), exactly as in
-- `FiniteFrameCategory`; identity is `frame-id`, composition `_∘ᶠ_`, and
-- the unit / associativity laws are the `refl`-level
-- `frame-id-l`/`frame-id-r`/`∘ᶠ`-assoc already proved in `ActorCausal`.
-- `isSetHom` is reused verbatim from `FiniteFrameCategory.isSetFrameHom`
-- (it holds for any two local frames; finiteness is not used).
--
-- Event level `ℓ-zero`, relation/actor level `ℓA` (fixed by
-- `SupportedFiniteFrame`, the incident point-frame route).
--
-- Scope guardrails: only `ActorBase`/`ActorCausal`/`FiniteFrame`/
-- `EventSupported` and the library `Category`. No value category, no
-- presheaves, no operad / session content.

module Concurrency.Sites.SupportedFiniteFrameCategory where

open import Cubical.Foundations.Prelude
open import Cubical.Categories.Category.Base using (Category)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal
  using ( LocalFrame ; FrameHom ; frame-id ; _∘ᶠ_ ; frame-id-l ; frame-id-r )
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Sites.FiniteFrameCategory using (isSetFrameHom)
open import Concurrency.Sites.EventSupported using (SupportedFiniteFrame)

module _ {ℓA : Level} (AB : ActorBase ℓA) where

  -- The underlying local frame of a supported finite frame.
  uframe : SupportedFiniteFrame AB → LocalFrame AB ℓ-zero ℓA
  uframe SF = FiniteFrame.frame (SupportedFiniteFrame.fin SF)

  ----------------------------------------------------------------------
  -- The supported-frame category at the fixed point-route levels.
  ----------------------------------------------------------------------

  SupportedFiniteFrameCategory : Category (ℓ-suc ℓA) ℓA
  SupportedFiniteFrameCategory = record
    { ob       = SupportedFiniteFrame AB
    ; Hom[_,_] = λ SF SG → FrameHom AB (uframe SF) (uframe SG)
    ; id       = λ {SF} → frame-id AB (uframe SF)
    ; _⋆_      = λ f g → _∘ᶠ_ AB g f
    ; ⋆IdL     = λ f → frame-id-r AB f       -- id ⋆ f = f ∘ᶠ frame-id ≡ f
    ; ⋆IdR     = λ f → frame-id-l AB f       -- f ⋆ id = frame-id ∘ᶠ f ≡ f
    ; ⋆Assoc   = λ f g h → refl              -- ∘ᶠ associative definitionally
    ; isSetHom = λ {SF} {SG} → isSetFrameHom AB (uframe SF) (uframe SG)
    }
