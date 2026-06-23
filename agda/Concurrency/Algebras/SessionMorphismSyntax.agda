{-# OPTIONS --cubical --guardedness #-}

-- Postulate-free morphism syntax for session types, as a set-truncated
-- higher inductive type.
--
-- `Sessions.agda` used to present the syntactic `*`-autonomous category
-- `Sessions-Cat` as an *inductive* `Hom` with the 21 categorical / additive
-- laws *postulated*. It now reuses this HIT instead: the same point
-- constructors (the morphism formers) plus the 21 laws as *path
-- constructors*, together with set-truncation. The laws then hold by
-- construction, so a target interpretation has to *prove* them in the
-- target rather than transport postulates — which is the point of the
-- Sessions-to-Chu realization.
--
-- The point/path constructor set is exactly the thin `StarAutonomous` +
-- `HasFiniteProducts` field set (no pentagon/hexagon/triangle, no
-- involution naturality), so that `SessionMorphismInterp.J1` can discharge
-- every path law from the corresponding target field.
--
-- Imports the postulate-free grammar only; does NOT import `Sessions.agda`.

module Concurrency.Algebras.SessionMorphismSyntax where

open import Cubical.Foundations.Prelude
open import Cubical.Categories.Category.Base using (Category)

open import Concurrency.Algebras.SessionSyntax using (module Syntax)

module Morph {ℓv : Level} (Payload : Type ℓv) where

  open Syntax Payload

  infixr 9 _∘-h_

  data SessionHom : SessionType → SessionType → Type ℓv where

    -- Underlying category.
    id-h  : ∀ {S} → SessionHom S S
    _∘-h_ : ∀ {A B C} → SessionHom B C → SessionHom A B → SessionHom A C

    -- Symmetric monoidal structure.
    ⊗-h               : ∀ {A B C D} → SessionHom A C → SessionHom B D
                      → SessionHom (A ⊗ B) (C ⊗ D)
    α-h               : ∀ {A B C} → SessionHom ((A ⊗ B) ⊗ C) (A ⊗ (B ⊗ C))
    α-inv-h           : ∀ {A B C} → SessionHom (A ⊗ (B ⊗ C)) ((A ⊗ B) ⊗ C)
    leftUnitor-h      : ∀ {A} → SessionHom (𝟙ₛ ⊗ A) A
    leftUnitor-inv-h  : ∀ {A} → SessionHom A (𝟙ₛ ⊗ A)
    rightUnitor-h     : ∀ {A} → SessionHom (A ⊗ 𝟙ₛ) A
    rightUnitor-inv-h : ∀ {A} → SessionHom A (A ⊗ 𝟙ₛ)
    braid-h           : ∀ {A B} → SessionHom (A ⊗ B) (B ⊗ A)

    -- Involutive duality.
    dual-h         : ∀ {A B} → SessionHom A B → SessionHom (B ^⊥ₛ) (A ^⊥ₛ)
    inv-dual-h     : ∀ {A} → SessionHom A ((A ^⊥ₛ) ^⊥ₛ)
    inv-dual-inv-h : ∀ {A} → SessionHom ((A ^⊥ₛ) ^⊥ₛ) A

    -- Additive product (terminal + binary &).
    terminal-h : ∀ {A} → SessionHom A ⊤ₛ
    proj₁-h    : ∀ {A B} → SessionHom (A &ₛ B) A
    proj₂-h    : ∀ {A B} → SessionHom (A &ₛ B) B
    pair-h     : ∀ {A B C} → SessionHom C A → SessionHom C B → SessionHom C (A &ₛ B)

    ------------------------------------------------------------------
    -- The 21 laws, as path constructors.
    ------------------------------------------------------------------

    -- Category laws.
    id-l    : ∀ {A B} (f : SessionHom A B) → id-h ∘-h f ≡ f
    id-r    : ∀ {A B} (f : SessionHom A B) → f ∘-h id-h ≡ f
    ∘-assoc : ∀ {A B C D} (f : SessionHom C D) (g : SessionHom B C) (h : SessionHom A B)
            → (f ∘-h g) ∘-h h ≡ f ∘-h (g ∘-h h)

    -- ⊗ bifunctoriality.
    ⊗-h-id-pres : ∀ {A B} → ⊗-h (id-h {A}) (id-h {B}) ≡ id-h
    ⊗-h-∘-pres  : ∀ {A B C D E F}
                  (f : SessionHom C E) (g : SessionHom A C)
                  (h : SessionHom D F) (k : SessionHom B D)
                → ⊗-h (f ∘-h g) (h ∘-h k) ≡ ⊗-h f h ∘-h ⊗-h g k

    -- Associator / unitor iso laws.
    α-iso-l           : ∀ {A B C} → α-inv-h {A} {B} {C} ∘-h α-h ≡ id-h
    α-iso-r           : ∀ {A B C} → α-h {A} {B} {C} ∘-h α-inv-h ≡ id-h
    leftUnitor-iso-l  : ∀ {A} → leftUnitor-inv-h {A} ∘-h leftUnitor-h ≡ id-h
    leftUnitor-iso-r  : ∀ {A} → leftUnitor-h {A} ∘-h leftUnitor-inv-h ≡ id-h
    rightUnitor-iso-l : ∀ {A} → rightUnitor-inv-h {A} ∘-h rightUnitor-h ≡ id-h
    rightUnitor-iso-r : ∀ {A} → rightUnitor-h {A} ∘-h rightUnitor-inv-h ≡ id-h

    -- Braid.
    braid-involutive : ∀ {A B} → braid-h {B} {A} ∘-h braid-h {A} {B} ≡ id-h

    -- Duality functoriality.
    dual-h-id-pres : ∀ {A} → dual-h (id-h {A}) ≡ id-h
    dual-h-∘-pres  : ∀ {A B C} (f : SessionHom B C) (g : SessionHom A B)
                   → dual-h (f ∘-h g) ≡ dual-h g ∘-h dual-h f

    -- Involutive-duality iso laws.
    inv-dual-iso-l : ∀ {A} → inv-dual-inv-h {A} ∘-h inv-dual-h ≡ id-h
    inv-dual-iso-r : ∀ {A} → inv-dual-h {A} ∘-h inv-dual-inv-h ≡ id-h

    -- Additive-product universal property.
    terminal-unique-h : ∀ {A} (f : SessionHom A ⊤ₛ) → f ≡ terminal-h
    &ₛ-β₁ : ∀ {A B C} (f : SessionHom C A) (g : SessionHom C B)
          → proj₁-h ∘-h pair-h f g ≡ f
    &ₛ-β₂ : ∀ {A B C} (f : SessionHom C A) (g : SessionHom C B)
          → proj₂-h ∘-h pair-h f g ≡ g
    &ₛ-η  : ∀ {A B C} (h : SessionHom C (A &ₛ B))
          → pair-h (proj₁-h ∘-h h) (proj₂-h ∘-h h) ≡ h

    -- Set-truncation: hom-types are sets.
    trunc : ∀ {A B} → isSet (SessionHom A B)

  ----------------------------------------------------------------------
  -- The syntactic category of session types and session morphisms.
  --
  -- Diagrammatic composition `f ⋆ g = g ∘-h f`, exactly the convention
  -- flip used in `StarAutonomousCategory.agda`; the unit/associativity
  -- laws are the HIT path constructors read in the other direction. This
  -- is the source category of the realization functor `J` and is built
  -- here so that functor stays free of `Sessions.agda`.
  ----------------------------------------------------------------------

  SessionCategory : Category ℓv ℓv
  SessionCategory = record
    { ob       = SessionType
    ; Hom[_,_] = SessionHom
    ; id       = id-h
    ; _⋆_      = λ f g → g ∘-h f
    ; ⋆IdL     = id-r
    ; ⋆IdR     = id-l
    ; ⋆Assoc   = λ f g h → sym (∘-assoc h g f)
    ; isSetHom = trunc
    }
