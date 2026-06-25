{-# OPTIONS --cubical --guardedness #-}

-- The tiny two-event actor frame, lifted into the finite-frame /
-- finite-cover interface, with its overlap enumerations computed.
--
-- This is the first *concrete* inhabitant of `FiniteFrame` / `FiniteCover`
-- in the codebase. Until now the finite-descent stack
-- (`FiniteFrame` → `FiniteCover` → `EventProductPresheaf` →
-- `FiniteDescent` → `EventProductSheaf`) was entirely generic: every
-- inhabitant quantified "for all finite frames, covers, matching
-- families, …", and nothing had ever been run against a concrete cover
-- with a real overlap. This file (with `Hybrid/TinyEventProductExample`)
-- closes that non-vacuity gap and, in doing so, stress-tests the one
-- untested piece of the interface: the *carried overlap enumeration*.
--
-- The objects lifted, from `ActorCausal.agda`'s G3 witness:
--   * `TinyFrame`  (events `Bool`, order `false ⊑ true`) ⟶ `TinyFrameF`
--     with `event-count 2` and `enum = Bool≃Fin2`;
--   * `PointFrame` (event `Unit`) ⟶ `PointFrameF` with `event-count 1`
--     and `enum = Unit≃Fin1`;
--   * `two-point-cover` (two `PointFrame` patches, `embed = embed-point`)
--     ⟶ `TinyFiniteCover`.
--
-- The crux — the overlap enumeration. The overlap of patches `i`, `j`
-- over `F` is their pullback `frame-pullback (embed-point i)
-- (embed-point j)`, whose events are (from `ActorPullback`)
--
--   Σ[ a ∈ Unit ] Σ[ b ∈ Unit ] (event-map (embed-point i) a
--                              ≡ event-map (embed-point j) b)
--     = Σ[ _ ∈ Unit ] Σ[ _ ∈ Unit ] (i ≡ j),
--
-- since `event-map (embed-point i) = λ _ → i`. So the four ordered pairs
-- split cleanly:
--
--   (false,false), (true,true):  overlap ≃ (b ≡ b), contractible
--                                (`isSetBool`)        ⟶ count 1, ≃ Fin 1;
--   (false,true), (true,false):  overlap ≃ (false ≡ true), empty
--                                (`false≢true`)       ⟶ count 0, ≃ Fin 0.
--
-- The diagonal overlaps are the single shared event; the off-diagonal
-- overlaps are empty (the two points are distinct events of `TinyFrame`).
-- This is exactly the carried-overlap data `FiniteCover` asks for, built
-- with `isoToEquiv` against the *literal* pullback `Event` type — no
-- transport, no postulate. That the interface is suppliable here, and on
-- which two facts it leans (`Bool` is a set; `false ≢ true`), is the
-- thing this file confirms.
--
-- Scope guardrails (inherited from the actor site): pure site / locality
-- machinery. No value / content / operad imports. The event
-- enumerations target `Cubical.Data.FinData.Fin` (what `FiniteFrame.enum`
-- and the product API use); `TinyAB`'s actor `Cubical.Data.Fin.Fin` is
-- unrelated and never appears.

module Concurrency.Sites.TinyFiniteCover where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv using (_≃_)
open import Cubical.Foundations.Isomorphism using (Iso ; iso ; isoToEquiv)
open import Cubical.Data.Nat using (ℕ)
open import Cubical.Data.FinData using (Fin) renaming (zero to fzero ; suc to fsuc)
open import Cubical.Data.Bool using (Bool ; false ; true ; isSetBool ; false≢true ; true≢false)
open import Cubical.Data.Unit using (Unit ; tt ; isPropUnit)
open import Cubical.Data.Empty using (⊥) renaming (rec to ⊥-rec)
open import Cubical.Data.Sigma using (_,_ ; ΣPathP)

open import Concurrency.Sites.ActorCausal
  using (LocalFrame ; TinyAB ; TinyFrame ; PointFrame ; embed-point)
open import Concurrency.Sites.ActorPullback using (frame-pullback)
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Sites.FiniteCover using (FiniteCover)

------------------------------------------------------------------------
-- Chosen event enumerations (into the inductive `FinData.Fin`).
------------------------------------------------------------------------

Bool≃Fin2 : Bool ≃ Fin 2
Bool≃Fin2 = isoToEquiv (iso f g s r)
  where
    f : Bool → Fin 2
    f false = fzero
    f true  = fsuc fzero
    g : Fin 2 → Bool
    g fzero        = false
    g (fsuc fzero) = true
    s : (k : Fin 2) → f (g k) ≡ k
    s fzero        = refl
    s (fsuc fzero) = refl
    r : (b : Bool) → g (f b) ≡ b
    r false = refl
    r true  = refl

Unit≃Fin1 : Unit ≃ Fin 1
Unit≃Fin1 = isoToEquiv (iso (λ _ → fzero) (λ _ → tt) s r)
  where
    s : (k : Fin 1) → fzero ≡ k
    s fzero = refl
    r : (u : Unit) → tt ≡ u
    r _ = refl

------------------------------------------------------------------------
-- The two finite frames.
------------------------------------------------------------------------

TinyFrameF : FiniteFrame TinyAB ℓ-zero ℓ-zero
TinyFrameF = record
  { frame       = TinyFrame
  ; event-count = 2
  ; enum        = Bool≃Fin2
  }

PointFrameF : FiniteFrame TinyAB ℓ-zero ℓ-zero
PointFrameF = record
  { frame       = PointFrame
  ; event-count = 1
  ; enum        = Unit≃Fin1
  }

------------------------------------------------------------------------
-- Overlap data for the two-point cover.
--
-- `overlap-count i j = 1` on the diagonal (the shared event), `0` off it
-- (no shared event); `overlap-enum` is the matching equivalence against
-- the literal pullback `Event` type.
------------------------------------------------------------------------

overlap-count : Bool → Bool → ℕ
overlap-count false false = 1
overlap-count true  true  = 1
overlap-count false true  = 0
overlap-count true  false = 0

-- Diagonal: the overlap is the single shared event, contractible because
-- `b ≡ b` is a proposition (`Bool` is a set).
diag-overlap-enum :
  (b : Bool)
  → LocalFrame.Event (frame-pullback TinyAB (embed-point b) (embed-point b)) ≃ Fin 1
diag-overlap-enum b = isoToEquiv (iso to from sec ret)
  where
    E : Type
    E = LocalFrame.Event (frame-pullback TinyAB (embed-point b) (embed-point b))
    to : E → Fin 1
    to _ = fzero
    from : Fin 1 → E
    from _ = tt , tt , refl
    sec : (k : Fin 1) → to (from k) ≡ k
    sec fzero = refl
    ret : (e : E) → from (to e) ≡ e
    ret (a , b' , p) =
      ΣPathP (isPropUnit tt a , ΣPathP (isPropUnit tt b' , isSetBool b b refl p))

-- Off-diagonal: the overlap is empty, because the third component asks
-- for `i ≡ j` with `i ≠ j`.
off-overlap-enum :
  (i j : Bool) → (i ≡ j → ⊥)
  → LocalFrame.Event (frame-pullback TinyAB (embed-point i) (embed-point j)) ≃ Fin 0
off-overlap-enum i j i≢j = isoToEquiv (iso to from sec ret)
  where
    E : Type
    E = LocalFrame.Event (frame-pullback TinyAB (embed-point i) (embed-point j))
    to : E → Fin 0
    to (_ , _ , p) = ⊥-rec (i≢j p)
    from : Fin 0 → E
    from ()
    sec : (k : Fin 0) → to (from k) ≡ k
    sec ()
    ret : (e : E) → from (to e) ≡ e
    ret (_ , _ , p) = ⊥-rec (i≢j p)

overlap-enum :
  (i j : Bool)
  → LocalFrame.Event (frame-pullback TinyAB (embed-point i) (embed-point j))
    ≃ Fin (overlap-count i j)
overlap-enum false false = diag-overlap-enum false
overlap-enum true  true  = diag-overlap-enum true
overlap-enum false true  = off-overlap-enum false true false≢true
overlap-enum true  false = off-overlap-enum true false true≢false

------------------------------------------------------------------------
-- The finite two-point cover of `TinyFrameF`.
--
-- `Index`, `patch`, `embed`, `actor-covered`, `event-covered` are the
-- finite-interface lift of `two-point-cover`; `overlap-count` /
-- `overlap-enum` are the new carried-overlap data.
------------------------------------------------------------------------

TinyFiniteCover : FiniteCover TinyAB ℓ-zero TinyFrameF
TinyFiniteCover = record
  { Index         = Bool
  ; patch         = λ _ → PointFrameF
  ; embed         = embed-point
  ; actor-covered = λ _ → false , tt
  ; event-covered = λ where
      false → false , tt , refl
      true  → true  , tt , refl
  ; overlap-count = overlap-count
  ; overlap-enum  = overlap-enum
  }
