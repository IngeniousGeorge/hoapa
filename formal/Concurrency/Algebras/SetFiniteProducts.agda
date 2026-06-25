{-# OPTIONS --cubical --guardedness #-}

-- Finite products in the library category `SET` of sets.
--
-- This is the cartesian counterpart of `Sessions-HasFiniteProducts` (the
-- additive products on the linear session value category). Together they
-- are the two value-category instances that the *single* generic
-- event-product witness (`EventProductPresheaf` / `EventProductSheaf`,
-- now parameterized over any Cubical `Category` with `HasFiniteProducts`)
-- runs on: leg 1 at `StarAutonomous→Category (Sessions-Cat Payload)`,
-- leg 2 at `SET`.
--
-- All laws hold by `refl`: `SET`'s composition is function composition,
-- its terminal object is `Unit*` (with η for `Lift Unit`), and its binary
-- product is the cartesian `_×_` (with η for `Σ`). So the projections /
-- pairing satisfy β and η definitionally — the cartesian side is exactly
-- the regime where the descent proofs compute, in contrast to the
-- proof-level discipline forced on the linear side.
--
-- Scope guardrails: pure value-category structure; no actor/site, no
-- session, no operad imports.

module Concurrency.Algebras.SetFiniteProducts where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.HLevels using (isSet×)
open import Cubical.Foundations.Structure using (⟨_⟩ ; str)
open import Cubical.Data.Unit using (Unit* ; tt* ; isPropUnit* ; isSetUnit*)
open import Cubical.Data.Sigma using (_×_ ; _,_ ; fst ; snd)
open import Cubical.Categories.Instances.Sets using (SET)

open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)

module _ (ℓ : Level) where

  SET-HasFiniteProducts : HasFiniteProducts (SET ℓ)
  SET-HasFiniteProducts = record
    { ⊤ₚ              = Unit* , isSetUnit*
    ; terminal        = λ _ → tt*
    ; terminal-unique = λ f → funExt (λ a → isPropUnit* (f a) tt*)
    ; _&_             = λ A B → (⟨ A ⟩ × ⟨ B ⟩) , isSet× (str A) (str B)
    ; π₁              = fst
    ; π₂              = snd
    ; ⟨_,_⟩           = λ f g c → (f c , g c)
    ; &-β₁            = λ f g → refl
    ; &-β₂            = λ f g → refl
    ; &-η             = λ h → refl
    }
