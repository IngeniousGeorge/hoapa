{-# OPTIONS --cubical --guardedness #-}

-- Bridge: every `FiniteFramePresheaf` record (over a value category `C`)
-- is a genuine library `Functor (FiniteFrameCategory ^op) C`.
--
-- Why a bridge rather than a re-expression. The finite event-product
-- descent stack (`EventProductPresheaf`, `FiniteDescent`,
-- `EventProductSheaf`, and the Sessions / tiny witnesses) is built and
-- typechecks against the hand-rolled `FiniteFramePresheaf` record. The
-- sheaf-category program adopts the cubical-library category ecosystem,
-- but we deliberately do *not* rewrite that landed stack around library
-- `Functor` as its primary representation — that would re-derive
-- `restrict-comp`-style proofs under the `_⋆_` / `_∘_` flip, exactly
-- where bugs hide. Instead:
--
--   * the *working* representation stays the record + `IsSheaf`;
--   * this file provides the *categorical view* as a thin conversion,
--     `presheaf→Functor`, so that the linear–nonlinear bridge and the later geometric-morphism
--     machinery have an honest `Functor` interface to consume.
--
-- The conversion is direct: `F-ob = value`, `F-hom = restrict`,
-- `F-id = restrict-id`, `F-seq = restrict-comp` (with frame arguments
-- permuted to match the opposite category's composition order). No new
-- mathematical content — it certifies that the record's functoriality
-- laws are precisely a library functor's laws, which is what makes the
-- "objects are presheaves" category in `FiniteSheafCategory.agda`
-- honest.
--
-- Direction bookkeeping. `FiniteFrameCategory` has `Hom[F,G] =
-- FrameHom (frame F) (frame G)` (F embeds into G). A presheaf is
-- contravariant, so it is a functor out of the *opposite* category:
-- `((FiniteFrameCategory) ^op) [F,G] = FrameHom (frame G) (frame F)`,
-- which is exactly the argument `restrict F G` expects.
--
-- Scope guardrails: generic over any Cubical `Category C`; no value-
-- category structure beyond the underlying 1-category, no session syntax,
-- no operad imports, no descent files modified.

module Concurrency.Hybrid.FiniteFramePresheafFunctor where

open import Cubical.Foundations.Prelude
open import Cubical.Categories.Category.Base using (Category ; _^op)
open import Cubical.Categories.Functor.Base using (Functor)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Sites.FiniteFrameCategory using (FiniteFrameCategory)
open import Concurrency.Hybrid.FinitePresheaf using (FiniteFramePresheaf)

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓV ℓH : Level} (C : Category ℓV ℓH)
         {ℓE ℓR : Level} where

  open FiniteFramePresheaf

  -- The categorical view of a finite-frame presheaf.
  presheaf→Functor :
      FiniteFramePresheaf AB C {ℓE} {ℓR}
    → Functor ((FiniteFrameCategory AB ℓE ℓR) ^op) C
  presheaf→Functor P = record
    { F-ob  = value P
    ; F-hom = λ {x} {y} φ → restrict P x y φ
    ; F-id  = λ {x} → restrict-id P x
    ; F-seq = λ {x} {y} {z} f g → restrict-comp P z y x f g
    }
