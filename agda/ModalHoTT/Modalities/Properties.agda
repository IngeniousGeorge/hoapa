{-# OPTIONS --cubical --guardedness #-}

-- Functoriality of the three cohesion modalities ♭, ʃ, ♯.
--
-- Each modality extends to an endofunctor on Type: a map f : A → B
-- lifts to F(f) : FA → FB, and the lift respects identity and
-- composition. The two laws together say that each modality is a functor
-- Typeℓ → Typeℓ (allowing universe shifts).
--
-- ♭ has full dependent elimination (flat-ind), so its functorial action
-- and both laws are proved here without new postulates. ʃ and ♯ have
-- only non-dependent recursion; the maps are definable but the laws
-- require induction over elements of ʃA or ♯A — i.e., dependent
-- elimination — which is not yet available (see status.md). Those laws
-- are postulated for now.

module ModalHoTT.Modalities.Properties where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv
open import Cubical.Foundations.Function

open import ModalHoTT.Modalities.Cohesion
open import ModalHoTT.Modalities.Adjunctions

private
  variable
    ℓ ℓ' ℓ'' : Level

------------------------------------------------------------------------
-- Flat modality — functoriality and naturality
------------------------------------------------------------------------

-- The functorial action of ♭.
--
-- We eliminate from ♭A via flat-ind, reintroducing into ♭B with
-- flat-intro after applying f. No idempotency of ♭ is needed: the
-- induction principle directly supplies the lift, with no circularity.
flat-map : {A : Type ℓ} {B : Type ℓ'} → (A → B) → FlatModality A → FlatModality B
flat-map f = flat-ind (λ _ → FlatModality _) (flat-intro ∘ f)

-- Identity law: flat-map id is the identity pointwise.
--
-- Proof by flat-ind on the goal, which is now a path type over ♭A.
-- At the generator flat-intro a, the β-rule flat-ind-β reduces
-- flat-map id (flat-intro a) to flat-intro a, closing the goal.
flat-map-id : {A : Type ℓ} (u : FlatModality A) → flat-map (λ a → a) u ≡ u
flat-map-id = flat-ind (λ u → flat-map (λ a → a) u ≡ u)
                       (λ a → flat-ind-β _ flat-intro a)

-- Composition law: flat-map (g ∘ f) ≡ flat-map g ∘ flat-map f pointwise.
--
-- Again by flat-ind on the path-type goal. At the generator flat-intro a,
-- both sides reduce to flat-intro (g (f a)) by two applications of
-- flat-ind-β; the proof path is: lhs-β ∙ sym (cong (flat-map g) rhs-β₁ ∙ rhs-β₂).
flat-map-comp : {A : Type ℓ} {B : Type ℓ'} {C : Type ℓ''}
  (f : A → B) (g : B → C) (u : FlatModality A)
  → flat-map (g ∘ f) u ≡ flat-map g (flat-map f u)
flat-map-comp f g = flat-ind _
  (λ a → flat-ind-β _ (flat-intro ∘ g ∘ f) a
       ∙ sym (  cong (flat-map g) (flat-ind-β _ (flat-intro ∘ f) a)
              ∙ flat-ind-β _ (flat-intro ∘ g) (f a)))

-- Naturality of the counit: flat-counit ∘ flat-map f ≡ f ∘ flat-counit.
--
-- The unit/counit-naturality square for ♭, completing its functorial data
-- alongside flat-map-id and flat-map-comp. Proof mirrors flat-map-comp:
-- flat-ind on the path goal, β-rules at the generator. At flat-intro a,
-- the left side rewrites via flat-ind-β (unfolding flat-map) and
-- flat-counit-intro; the right side via flat-counit-intro alone.
--
-- The analogous shape-unit-natural and sharp-unit-natural are blocked on
-- dependent elimination for ʃ/♯, same gap that blocks shape-map-id etc.
flat-counit-natural : {A : Type ℓ} {B : Type ℓ'}
  (f : A → B) (u : FlatModality A)
  → flat-counit (flat-map f u) ≡ f (flat-counit u)
flat-counit-natural f = flat-ind _
  (λ a →   cong flat-counit (flat-ind-β _ (flat-intro ∘ f) a)
         ∙ flat-counit-intro (f a)
         ∙ sym (cong f (flat-counit-intro a)))

------------------------------------------------------------------------
-- Shape modality — functoriality
------------------------------------------------------------------------

-- The functorial action of ʃ.
--
-- We factor shape-unit ∘ f : A → ʃB through ʃA via the universal
-- property shape-rec. That recursion principle requires the target to
-- be shape-modal; ʃB qualifies by shape-modality-idempotent (ʃ is
-- idempotent: ʃ(ʃB) ≃ ʃB).
shape-map : {A : Type ℓ} {B : Type ℓ'} → (A → B) → ShapeModality A → ShapeModality B
shape-map f = shape-rec shape-modality-idempotent (shape-unit ∘ f)

-- The identity and composition laws for ʃ require induction over
-- u : ʃA, i.e., dependent elimination for ʃ. This is the same gap
-- that blocks the proof of shape-modality-idempotent itself: the
-- fiberwise modality conditions needed for ʃ-ind are not yet
-- postulated. Both laws become theorems once ʃ-ind is available.
postulate
  shape-map-id : {A : Type ℓ} (u : ShapeModality A)
    → shape-map (λ a → a) u ≡ u

  shape-map-comp : {A : Type ℓ} {B : Type ℓ'} {C : Type ℓ''}
    (f : A → B) (g : B → C) (u : ShapeModality A)
    → shape-map (g ∘ f) u ≡ shape-map g (shape-map f u)

------------------------------------------------------------------------
-- Sharp modality — functoriality
------------------------------------------------------------------------

-- The functorial action of ♯.
--
-- Dual to shape-map: sharp-unit ∘ f : A → ♯B factors through ♯A via
-- sharp-rec, which requires ♯B to be sharp-modal — supplied by
-- sharp-modality-idempotent.
sharp-map : {A : Type ℓ} {B : Type ℓ'} → (A → B) → SharpModality A → SharpModality B
sharp-map f = sharp-rec sharp-modality-idempotent (sharp-unit ∘ f)

-- Same blocker as for ʃ: dependent elimination for ♯ is needed to
-- prove these laws pointwise, and it is not yet available (see status.md).
postulate
  sharp-map-id : {A : Type ℓ} (u : SharpModality A)
    → sharp-map (λ a → a) u ≡ u

  sharp-map-comp : {A : Type ℓ} {B : Type ℓ'} {C : Type ℓ''}
    (f : A → B) (g : B → C) (u : SharpModality A)
    → sharp-map (g ∘ f) u ≡ sharp-map g (sharp-map f u)
