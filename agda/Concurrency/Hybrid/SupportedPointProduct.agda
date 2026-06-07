{-# OPTIONS --cubical --guardedness #-}

-- The slot-indexed, presheaf-free point-product API.
--
-- This is the load-bearing refactor for the reflector functor's
-- naturality. The point product of a supported finite frame `SF` is the
-- finite product over its events of an arbitrary slot family
-- `slot : sfEv AB SF → Ob`:
--
--   pointProduct SF slot = ∏_{e ∈ events SF} slot e.
--
-- Crucially this is parameterized by `AB C FP` only — *not* by a presheaf.
-- The presheaf enters solely through the *value* of the `slot` argument
-- (`slotOf P SF = λ e → P (pt₀ SF e)`), never through the generated name of
-- the product / projection / tupling. That is what lets the reflector
-- functor's naturality proof — which mixes the P-side and the Q-side —
-- elaborate: both sides share one `pointProduct`/`pointProj` head whose
-- frame argument `SF` is explicit, so a frame metavariable unifies
-- directly instead of being reconstructed from the (non-invertible)
-- `event-count`/`enum` of a per-presheaf product presentation.
--
-- Everything here is a thin wrapper over the `EnumeratedProduct` API at the
-- frame's shared P-free shape (`sfCount`/`sfEv`/`sfEnum` from
-- `EventSupported`); the single non-trivial content lives in
-- `EnumeratedProduct`.
--
-- Scope guardrails: generic over a value category `C` with finite
-- products; the only presheaf use is the convenience `slotOf`.

module Concurrency.Hybrid.SupportedPointProduct where

open import Cubical.Foundations.Prelude
open import Cubical.Categories.Category.Base using (Category)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.EventSupported
  using (SupportedFiniteFrame ; sfEv ; sfCount ; sfEnum)
open import Concurrency.Sites.PointCover using (supported-point)
open import Concurrency.Algebras.CategoryApplicative using (module ApplicativeView)
open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)
open import Concurrency.Hybrid.SupportedPresheafCategory using (SupportedPresheaf)
open import Concurrency.Hybrid.EnumeratedProduct
  using (∏E ; projE ; tupleE ; βE ; ηE ; extE)

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓ ℓ' : Level} (C : Category ℓ ℓ') (FP : HasFiniteProducts C) where

  open ApplicativeView C

  -- The supported point frame at an event (the shared `supported-point`).
  pt₀ : (SF : SupportedFiniteFrame AB) → sfEv AB SF → SupportedFiniteFrame AB
  pt₀ SF e = supported-point AB (SupportedFiniteFrame.fin SF) e

  -- The slot family of a presheaf: its value at each point.
  slotOf : SupportedPresheaf AB C → (SF : SupportedFiniteFrame AB) → sfEv AB SF → Ob
  slotOf P SF e = SupportedPresheaf.value P (pt₀ SF e)

  ----------------------------------------------------------------------
  -- The point product, with the frame `SF` as an explicit argument.
  --
  -- `abstract`, deliberately: outside this block `pointProduct SF slot`
  -- stays a *stuck head* with `SF` explicit, rather than reducing through
  -- `∏E` to `bigProduct (sfCount SF) …` (which would bury the frame in the
  -- non-invertible `sfCount`/`sfEnum`). That is what lets a frame
  -- metavariable unify directly off `pointProduct`'s explicit argument —
  -- the obstruction that defeated the reflector functor's naturality when
  -- the product was transparent. The β/η/ext laws are the only way to
  -- compute with the product downstream.
  ----------------------------------------------------------------------

  abstract
    pointProduct : (SF : SupportedFiniteFrame AB) (slot : sfEv AB SF → Ob) → Ob
    pointProduct SF slot = ∏E C FP (sfCount AB SF) (sfEv AB SF) (sfEnum AB SF) slot

    pointProj : (SF : SupportedFiniteFrame AB) (slot : sfEv AB SF → Ob) (e : sfEv AB SF)
              → Hom (pointProduct SF slot) (slot e)
    pointProj SF slot e = projE C FP (sfCount AB SF) (sfEv AB SF) (sfEnum AB SF) slot e

    pointTuple : (SF : SupportedFiniteFrame AB) (slot : sfEv AB SF → Ob) {X : Ob}
               → ((e : sfEv AB SF) → Hom X (slot e)) → Hom X (pointProduct SF slot)
    pointTuple SF slot g = tupleE C FP (sfCount AB SF) (sfEv AB SF) (sfEnum AB SF) slot g

    pointβ : (SF : SupportedFiniteFrame AB) (slot : sfEv AB SF → Ob) {X : Ob}
             (g : (e : sfEv AB SF) → Hom X (slot e)) (e : sfEv AB SF)
           → pointProj SF slot e ∘ pointTuple SF slot g ≡ g e
    pointβ SF slot g e = βE C FP (sfCount AB SF) (sfEv AB SF) (sfEnum AB SF) slot g e

    pointη : (SF : SupportedFiniteFrame AB) (slot : sfEv AB SF → Ob) {X : Ob}
             (h : Hom X (pointProduct SF slot))
           → pointTuple SF slot (λ e → pointProj SF slot e ∘ h) ≡ h
    pointη SF slot h = ηE C FP (sfCount AB SF) (sfEv AB SF) (sfEnum AB SF) slot h

    pointExt : (SF : SupportedFiniteFrame AB) (slot : sfEv AB SF → Ob) {X : Ob}
               (m m' : Hom X (pointProduct SF slot))
             → ((e : sfEv AB SF) → pointProj SF slot e ∘ m ≡ pointProj SF slot e ∘ m')
             → m ≡ m'
    pointExt SF slot m m' hyp = extE C FP (sfCount AB SF) (sfEv AB SF) (sfEnum AB SF) slot m m' hyp
