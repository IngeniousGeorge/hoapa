{-# OPTIONS --cubical --guardedness #-}

-- Applicative view of a Cubical-library `Category`.
--
-- Why this exists. The finite descent / sheaf-category framework
-- (`FinitePresheaf`, `FiniteDescent`, `FiniteSheafCategory`,
-- `FiniteFramePresheafFunctor`) was first written against the hand-rolled
-- `StarAutonomous` value-category signature, whose underlying 1-category
-- is spelled with *applicative* composition `_∘_` (`g ∘ f` = "f then g")
-- and the law names `id-l`, `id-r`, `∘-assoc`. Phase 1 of the
-- value-category program re-parameterizes that framework over a plain
-- library `Category` so that legs 1 (V-valued, linear) and 2 (Set-valued,
-- cartesian) are *one* construction at two value categories — which is
-- what keeps the cartesian-vs-linear bridge clean.
--
-- A library `Category` is spelled *diagrammatically* (`_⋆_`, `f ⋆ g` =
-- "f then g") and already derives an applicative `_∘_` with `g ∘ f =
-- f ⋆ g`. This module re-exposes that applicative `_∘_` together with the
-- three applicative law aliases (`id-l`, `id-r`, `∘-assoc`) and the
-- `Ob`/`Hom`/`Hom-set` names, so the framework bodies — written in the
-- applicative idiom — stay essentially unchanged when their parameter
-- switches from `StarAutonomous V` to `Category C`.
--
-- The convention flip lives in exactly two places: this module (the
-- applicative view of *any* `Category`) and `StarAutonomousCategory.agda`
-- (the `Category` view of a `StarAutonomous`). Composing them recovers
-- leg 1: for `C := StarAutonomous→Category V`, every name below reduces
-- *definitionally* to `V`'s own operation/law —
--   * `_∘_`     to `V`'s `_∘_`        (`g ∘ f = f ⋆ g = g ∘ᵥ f`);
--   * `id-l`/`id-r` to `V`'s `id-l`/`id-r` (since `⋆IdR`/`⋆IdL` of the
--     adapter *are* `V`'s `id-l`/`id-r`);
--   * `∘-assoc` to `V`'s `∘-assoc`    (`sym (sym p) = p` definitionally).
-- This is what makes the leg-1 re-derivation mechanical rather than a
-- re-proof.
--
-- Scope guardrails: only the underlying 1-category is exposed. No
-- monoidal / `*`-autonomous structure — value categories that carry it
-- (the V side) keep it on their own `StarAutonomous` record; value
-- categories that do not (the Set side) never acquire it here.

module Concurrency.Algebras.CategoryApplicative where

open import Cubical.Foundations.Prelude using (Level ; Type ; isSet ; _≡_ ; sym)
open import Cubical.Categories.Category.Base using (Category)

module ApplicativeView {ℓ ℓ' : Level} (𝒞 : Category ℓ ℓ') where

  -- The diagrammatic primitive, the derived applicative composition, the
  -- identity, and the diagrammatic laws, re-exported for openers.
  open Category 𝒞 public using (id ; _⋆_ ; _∘_ ; ⋆IdL ; ⋆IdR ; ⋆Assoc)

  Ob : Type ℓ
  Ob = Category.ob 𝒞

  Hom : Ob → Ob → Type ℓ'
  Hom A B = Category.Hom[_,_] 𝒞 A B

  Hom-set : {A B : Ob} → isSet (Hom A B)
  Hom-set = Category.isSetHom 𝒞

  -- Applicative law aliases. `g ∘ f = f ⋆ g`, so:
  --   `id ∘ f = f ⋆ id` is `⋆IdR`;
  --   `f ∘ id = id ⋆ f` is `⋆IdL`;
  --   `(f ∘ g) ∘ h = h ⋆ (g ⋆ f)` and `f ∘ (g ∘ h) = (h ⋆ g) ⋆ f`,
  --     so applicative associativity is `sym ⋆Assoc`.
  id-l : {A B : Ob} (f : Hom A B) → id ∘ f ≡ f
  id-l f = ⋆IdR f

  id-r : {A B : Ob} (f : Hom A B) → f ∘ id ≡ f
  id-r f = ⋆IdL f

  ∘-assoc : {A B D E : Ob} (f : Hom D E) (g : Hom B D) (h : Hom A B)
          → (f ∘ g) ∘ h ≡ f ∘ (g ∘ h)
  ∘-assoc f g h = sym (⋆Assoc h g f)
