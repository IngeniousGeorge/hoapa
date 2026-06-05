{-# OPTIONS --cubical --guardedness #-}

-- The finite covering-family *basis*: a `FiniteCover` stripped of its
-- carried overlap enumerations, and its adapter into the Cubical library
-- `Cover`.
--
-- Why a separate type (the relative point of view, at the site layer).
-- `Concurrency/Sites/FiniteCover.agda` carries, per ordered pair of
-- patches, a chosen finite enumeration of their overlap — load-bearing
-- data for the event-product *descent witness*, where compatibility is
-- stated on the overlap frame. But a *topology* should not depend on a
-- chosen enumeration of each pairwise overlap: that is chart-level data,
-- not base-stable structure. So the coverage
-- (`Concurrency/Sites/FiniteFrameCoverage.agda`) is built over this
-- leaner `FiniteBasisCover` — finite patches and embeddings only — and the
-- overlap enumerations stay where they belong, on the descent side.
--
-- The explicit forgetful chain (Codex's instruction):
--
--     FiniteCover  ──finiteCover→basis──▶  FiniteBasisCover  ──basis→Cover──▶  Cubical Cover
--
-- keeps the shipped descent witness on `FiniteCover` untouched, while
-- making the topology independent of overlap enumerations.
--
-- The library adapter. A Cubical `Cover C ℓpat c` is just a type of
-- patches together with, for each, an object of the slice category over
-- `c` — i.e. a family of arrows into `c` (`Cubical.Categories.Site.Cover`).
-- For `C := FiniteFrameCategory` and `c := F`, that is exactly `Index`
-- plus `sliceob (embed i)`. By construction the library's `patchArr` of
-- the adapted cover reduces definitionally to `embed i`, which is what
-- keeps the coverage's `pullbackStability` re-expression honest.
--
-- Scope guardrails (inherited from the actor site): pure site machinery;
-- no value / content / operad imports.

module Concurrency.Sites.FiniteBasisCover where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Sigma using (Σ-syntax ; _,_)

open import Cubical.Categories.Instances.Slice using (SliceCat ; sliceob)
open import Cubical.Categories.Site.Cover using (Cover)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal using (LocalFrame ; FrameHom)
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Sites.FiniteFrameCategory using (FiniteFrameCategory)
open import Concurrency.Sites.FiniteFramePullback using (finite-frame-pullback)
open import Concurrency.Sites.FiniteCover using (FiniteCover)

module _ {ℓA : Level} (AB : ActorBase ℓA) where
  open ActorBase AB

  ----------------------------------------------------------------------
  -- The basis cover: finite patches + embeddings + coverage, no overlap
  -- enumerations.
  ----------------------------------------------------------------------

  record FiniteBasisCover {ℓE ℓR : Level} (ℓI : Level)
                          (F : FiniteFrame AB ℓE ℓR)
       : Type (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE (ℓ-max ℓR ℓI)))) where
    open LocalFrame (FiniteFrame.frame F)
    field
      Index : Type ℓI
      patch : Index → FiniteFrame AB ℓE ℓR
      embed : (i : Index)
            → FrameHom AB (FiniteFrame.frame (patch i)) (FiniteFrame.frame F)
      actor-covered : {a : Actor} → ActorIn a
                    → Σ[ i ∈ Index ]
                        LocalFrame.ActorIn (FiniteFrame.frame (patch i)) a
      event-covered : (e : Event)
                    → Σ[ i ∈ Index ]
                        Σ[ ẽ ∈ LocalFrame.Event (FiniteFrame.frame (patch i)) ]
                          FrameHom.event-map (embed i) ẽ ≡ e

  ----------------------------------------------------------------------
  -- FiniteCover ▶ FiniteBasisCover: forget the carried overlap data.
  ----------------------------------------------------------------------

  finiteCover→basis :
      {ℓE ℓR ℓI : Level} {F : FiniteFrame AB ℓE ℓR}
    → FiniteCover AB ℓI F → FiniteBasisCover ℓI F
  finiteCover→basis c = record
    { Index         = FiniteCover.Index c
    ; patch         = FiniteCover.patch c
    ; embed         = FiniteCover.embed c
    ; actor-covered = FiniteCover.actor-covered c
    ; event-covered = FiniteCover.event-covered c
    }

  ----------------------------------------------------------------------
  -- FiniteBasisCover ▶ FiniteCover: complete a basis cover by *deriving*
  -- the overlap enumerations from `finite-frame-pullback`.
  --
  -- This is the section of `finiteCover→basis`: by record η,
  -- `finiteCover→basis (basis→finiteCover bc) ≡ bc` definitionally (the
  -- five basis fields are copied verbatim; only the derivable overlap data
  -- is added). It is what lets the SET sheaf comparison land at the actual
  -- `FiniteFrameCoverage` — whose covers are all `FiniteBasisCover`s — and
  -- not merely per `FiniteCover`: every basis cover the coverage offers is
  -- completed here to feed the `FiniteCover`-based descent witness.
  ----------------------------------------------------------------------

  basis→finiteCover :
      {ℓE ℓR ℓI : Level} {F : FiniteFrame AB ℓE ℓR}
    → FiniteBasisCover ℓI F → FiniteCover AB ℓI F
  basis→finiteCover {ℓE} {ℓR} {F = F} bc = record
    { Index         = FiniteBasisCover.Index bc
    ; patch         = FiniteBasisCover.patch bc
    ; embed         = FiniteBasisCover.embed bc
    ; actor-covered = FiniteBasisCover.actor-covered bc
    ; event-covered = FiniteBasisCover.event-covered bc
    ; overlap-count = λ i j → FiniteFrame.event-count (overlapFF i j)
    ; overlap-enum  = λ i j → FiniteFrame.enum (overlapFF i j)
    }
    where
      overlapFF : (i j : FiniteBasisCover.Index bc) → FiniteFrame AB ℓE ℓR
      overlapFF i j = finite-frame-pullback AB
                        (FiniteBasisCover.patch bc i) (FiniteBasisCover.patch bc j) F
                        (FiniteBasisCover.embed bc i) (FiniteBasisCover.embed bc j)

  ----------------------------------------------------------------------
  -- FiniteBasisCover ▶ Cubical Cover over FiniteFrameCategory.
  ----------------------------------------------------------------------

  basis→Cover :
      {ℓE ℓR ℓI : Level} (F : FiniteFrame AB ℓE ℓR)
    → FiniteBasisCover ℓI F
    → Cover (FiniteFrameCategory AB ℓE ℓR) ℓI F
  basis→Cover F bc =
      FiniteBasisCover.Index bc
    , λ i → sliceob {S-ob = FiniteBasisCover.patch bc i}
                    (FiniteBasisCover.embed bc i)
