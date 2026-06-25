{-# OPTIONS --cubical --guardedness #-}

-- Parameter signature for the target category of cyclic-operad algebras.
--
-- `StarAutonomous` is a record packaging the structure a target category
-- must carry so that algebras of the cyclic associative operad `O_1` can
-- land in it. The record parameterizes both
-- `Concurrency/Algebras/Valuation.agda` (the weak interpretation layer)
-- and `Concurrency/Algebras/OperadAlgebra.agda` (the structural layer
-- adding plug, shift, and their axioms). The first concrete instance —
-- the session-type syntactic target — lives in
-- `Concurrency/Algebras/Sessions.agda`; it presents a *-autonomous-
-- style category over session-type syntax with structural fields
-- postulated, not a Caires–Pfenning proof-term calculus. R8
-- (Involution-Duality) splits into a syntactic face there
-- (`dual-involutive`) and a categorical / operadic face
-- (`boundary-swap-at-gen`), via the derived `boundary-swap` theorem in
-- `Concurrency/Operads/CyclicAssociative.agda` lifted to
-- `boundary-swap-structural` in `OperadAlgebra.agda`. The bridge
-- between the two faces is the project's R8 claim and is deliberately
-- not materialized in code.
--
-- Status: *thin signature*, not a full *-autonomous category. The
-- signature names the operations (⊗, _^⊥, units) and the local iso
-- laws (α, unitors, braid, involutive duality); the global coherence
-- is not unpacked. What's missing relative to a full *-autonomous
-- category:
--   * Mac Lane coherence: pentagon (associator), hexagon (associator /
--     braiding), triangle (associator / unitors).
--   * Naturality of the associator, unitors, braiding, and the
--     involutive iso `A ≃ (A ^⊥) ^⊥`.
--   * `_^⊥`-compatibility of `⊗` (the De Morgan iso `(A ⊗ B)^⊥ ≃ A^⊥
--     ⅋ B^⊥` is auto-definitional via ⅋'s definition, but its
--     compatibility with the involutive iso is not stated).
--   * Universal property of `_⊸_` (it is named but not characterized
--     as a hom-functor adjoint to `⊗`).
-- Concrete instances, such as the session-type syntactic target in
-- `Sessions.agda`, supply this content implicitly through their
-- constructions (or postulate it where the target is itself
-- axiomatized); downstream code that depends on coherence must add
-- the corresponding fields here.
--
-- Step 3 upgrade path (when `MO_1` / dessin work enters scope): to
-- derive `plug` and `shift` of `OperadAlgebra.agda` from this signature
-- alone — rather than carrying them as fields per instance — we will
-- need the **evaluation / closed-structure** content for `_⊸_` (the
-- ⊗ ⊣ ⊸ adjunction with its counit `(A ⊸ B) ⊗ A → B`) plus the
-- coherence omissions above. `shift` follows from braiding + associator
-- already; `plug` is the substantive demand. These are the specific
-- omissions Step 3 will need.
--
-- Scope (decisions 2026-05-17):
--   * Minimal multiplicative *-autonomous: tensor (⊗), par (⅋), tensor
--     unit (𝟙), par unit (⊥-par), involutive duality (_^⊥), and the
--     duality / tensor / par interaction. No additives (&, ⊕), no
--     exponentials (!, ?), no concrete session syntax.
--     ('𝟙' rather than 'I' because the cubical interval primitive 'I'
--     is in transitive scope from Cubical.Foundations.Prelude.)
--   * Symmetric *-autonomous is committed here (braiding is a field).
--     The polycategory alternative — natural if Caires–Pfenning turns
--     out to need a non-symmetric setting — would replace this record
--     rather than extend it. Not started.
--   * 1-categorical (hom-types are sets). ∞-enrichment is a later
--     upgrade; downstream uses should flag sites that would benefit.
--
-- Convention: record-scoped notation. `⊗`, `⅋`, `^⊥`, `⊸` are used as
-- identifiers because they are the standard linear-logic / *-autonomous
-- notation and pronounceable (tensor, par, dual, lollipop). This matches
-- the existing operad files' use of `compₒ`, `rot`. CLAUDE.md's "long
-- names over notation" rule targets opaque single symbols like `♭`/`ʃ`;
-- the linear-logic connectives are conventional enough to read.

module Concurrency.Algebras.StarAutonomous where

open import Cubical.Foundations.Prelude

record StarAutonomous (ℓ ℓ' : Level) : Type (ℓ-suc (ℓ-max ℓ ℓ')) where
  field
    ----------------------------------------------------------------
    -- Underlying 1-category.
    ----------------------------------------------------------------
    Ob       : Type ℓ
    Hom      : Ob → Ob → Type ℓ'
    Hom-set  : {A B : Ob} → isSet (Hom A B)
    id       : {A : Ob} → Hom A A
    _∘_      : {A B C : Ob} → Hom B C → Hom A B → Hom A C
    id-l     : {A B : Ob} (f : Hom A B) → id ∘ f ≡ f
    id-r     : {A B : Ob} (f : Hom A B) → f ∘ id ≡ f
    ∘-assoc  : {A B C D : Ob}
               (f : Hom C D) (g : Hom B C) (h : Hom A B)
             → (f ∘ g) ∘ h ≡ f ∘ (g ∘ h)

    ----------------------------------------------------------------
    -- Symmetric monoidal structure on (⊗, I).
    --
    -- ⊗ is a bifunctor (preserves identities and composition).
    -- α, leftUnitor, rightUnitor, braid are named isomorphisms; their
    -- inverses are separate fields with iso-laws on both sides.
    -- Pentagon, hexagon, and triangle coherence axioms are *not*
    -- unpacked here — add as fields if a downstream proof needs them.
    ----------------------------------------------------------------
    _⊗_       : Ob → Ob → Ob
    𝟙         : Ob

    ⊗-hom     : {A B C D : Ob} → Hom A C → Hom B D → Hom (A ⊗ B) (C ⊗ D)
    ⊗-id-pres : {A B : Ob} → ⊗-hom (id {A}) (id {B}) ≡ id
    ⊗-∘-pres  : {A B C D E F : Ob}
                (f : Hom C E) (g : Hom A C)
                (h : Hom D F) (k : Hom B D)
              → ⊗-hom (f ∘ g) (h ∘ k) ≡ ⊗-hom f h ∘ ⊗-hom g k

    α         : {A B C : Ob} → Hom ((A ⊗ B) ⊗ C) (A ⊗ (B ⊗ C))
    α-inv     : {A B C : Ob} → Hom (A ⊗ (B ⊗ C)) ((A ⊗ B) ⊗ C)
    α-iso-l   : {A B C : Ob} → α-inv {A} {B} {C} ∘ α ≡ id
    α-iso-r   : {A B C : Ob} → α {A} {B} {C} ∘ α-inv ≡ id

    leftUnitor       : {A : Ob} → Hom (𝟙 ⊗ A) A
    leftUnitor-inv   : {A : Ob} → Hom A (𝟙 ⊗ A)
    leftUnitor-iso-l : {A : Ob} → leftUnitor-inv {A} ∘ leftUnitor ≡ id
    leftUnitor-iso-r : {A : Ob} → leftUnitor {A} ∘ leftUnitor-inv ≡ id

    rightUnitor       : {A : Ob} → Hom (A ⊗ 𝟙) A
    rightUnitor-inv   : {A : Ob} → Hom A (A ⊗ 𝟙)
    rightUnitor-iso-l : {A : Ob} → rightUnitor-inv {A} ∘ rightUnitor ≡ id
    rightUnitor-iso-r : {A : Ob} → rightUnitor {A} ∘ rightUnitor-inv ≡ id

    braid            : {A B : Ob} → Hom (A ⊗ B) (B ⊗ A)
    braid-involutive : {A B : Ob} → braid {B} {A} ∘ braid {A} {B} ≡ id

    ----------------------------------------------------------------
    -- Involutive duality (_^⊥).
    --
    -- _^⊥ is contravariant functorial on the underlying category, with
    -- an involutive isomorphism A ≃ (A ^⊥) ^⊥. Naturality of the
    -- involution and its compatibility with ⊗ are not unpacked here.
    ----------------------------------------------------------------
    _^⊥        : Ob → Ob
    ^⊥-hom     : {A B : Ob} → Hom A B → Hom (B ^⊥) (A ^⊥)
    ^⊥-id-pres : {A : Ob} → ^⊥-hom (id {A}) ≡ id
    ^⊥-∘-pres  : {A B C : Ob} (f : Hom B C) (g : Hom A B)
               → ^⊥-hom (f ∘ g) ≡ ^⊥-hom g ∘ ^⊥-hom f

    ^⊥-involutive       : {A : Ob} → Hom A ((A ^⊥) ^⊥)
    ^⊥-involutive-inv   : {A : Ob} → Hom ((A ^⊥) ^⊥) A
    ^⊥-involutive-iso-l : {A : Ob} → ^⊥-involutive-inv {A} ∘ ^⊥-involutive ≡ id
    ^⊥-involutive-iso-r : {A : Ob} → ^⊥-involutive {A} ∘ ^⊥-involutive-inv ≡ id

  ----------------------------------------------------------------
  -- Derived: par, par unit, linear implication.
  --
  -- `⅋` is the De Morgan dual of `⊗`; `⊥-par` is the dual of `𝟙`;
  -- `A ⊸ B` (linear implication / lollipop) is `A^⊥ ⅋ B`. These are
  -- definitional unfoldings, not new commitments — the *-autonomous
  -- content of the record is the duality fields above.
  ----------------------------------------------------------------

  _⅋_ : Ob → Ob → Ob
  A ⅋ B = ((A ^⊥) ⊗ (B ^⊥)) ^⊥

  ⊥-par : Ob
  ⊥-par = 𝟙 ^⊥

  _⊸_ : Ob → Ob → Ob
  A ⊸ B = (A ^⊥) ⅋ B
