{-# OPTIONS --cubical --guardedness #-}

-- Target-generic object model for interpreting session types, and the
-- generic object-level interpretation `J0`.
--
-- A `SessionObjectModel V` is the data needed to fold the session-type
-- grammar (`SessionSyntax`) into the objects of a thin `*`-autonomous
-- value category `V` with finite (additive) products: a chosen self-dual
-- object for `end`, and an interpretation of payloads. Everything else is
-- forced by the connective structure of `V`.
--
-- The content-bearing theorem is `J0-dual`: the syntactic duality
-- `_^⊥ₛ` is sent to the categorical dual `_^⊥` *up to isomorphism* — not
-- object equality, because the thin `StarAutonomous` interface provides
-- involutive duality only as a morphism-level iso (`^⊥-involutive`). So
-- `J0 (S ^⊥ₛ) ≅ (J0 S) ^⊥` for every session type `S`. This turns the
-- syntactic R8 face into a theorem about the semantics, not a transported
-- postulate; `Sessions.agda` is not imported here.
--
-- This is grade-(ii) intended-instance content. The morphism layer has
-- also landed: `Interpretation.J1` interprets the session morphism HIT
-- (`SessionMorphismSyntax`) into `V`, discharging every path law from the
-- corresponding target field (duality via the `dualconj`/`dd` isos). What
-- remains of Phase 1B is packaging `J0`/`J1` as an actual (thin) functor
-- object.

module Concurrency.Algebras.SessionObjectModel where

open import Cubical.Foundations.Prelude

open import Concurrency.Algebras.SessionSyntax using (module Syntax)
open import Concurrency.Algebras.SessionMorphismSyntax using (module Morph)
open import Concurrency.Algebras.StarAutonomous using (StarAutonomous)
open import Concurrency.Algebras.StarAutonomousCategory using (StarAutonomous→Category)
open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)
open import Cubical.Categories.Functor using (Functor)

module Model {ℓ ℓ' ℓv : Level} (Payload : Type ℓv) (V : StarAutonomous ℓ ℓ') where

  open StarAutonomous V renaming (_⊗_ to _⊗ᵥ_ ; _⅋_ to _⅋ᵥ_)
  open Syntax Payload

  ----------------------------------------------------------------------
  -- Isomorphisms in the underlying category of V (applicative idiom:
  -- `g ∘ f` = "f then g").
  ----------------------------------------------------------------------

  record _≅_ (A B : Ob) : Type ℓ' where
    constructor iso
    field
      fwd     : Hom A B
      bwd     : Hom B A
      fwd-bwd : fwd ∘ bwd ≡ id
      bwd-fwd : bwd ∘ fwd ≡ id
  open _≅_

  -- (g ∘ f) ∘ (f' ∘ g') ≡ id from f ∘ f' ≡ id and g ∘ g' ≡ id.
  private
    whisker-cancel :
      {A B C : Ob}
      (g : Hom B C) (g' : Hom C B) (f : Hom A B) (f' : Hom B A)
      → g ∘ g' ≡ id → f ∘ f' ≡ id
      → (g ∘ f) ∘ (f' ∘ g') ≡ id
    whisker-cancel g g' f f' gg' ff' =
        (g ∘ f) ∘ (f' ∘ g')   ≡⟨ ∘-assoc g f (f' ∘ g') ⟩
        g ∘ (f ∘ (f' ∘ g'))   ≡⟨ cong (g ∘_) (sym (∘-assoc f f' g')) ⟩
        g ∘ ((f ∘ f') ∘ g')   ≡⟨ cong (λ z → g ∘ (z ∘ g')) ff' ⟩
        g ∘ (id ∘ g')         ≡⟨ cong (g ∘_) (id-l g') ⟩
        g ∘ g'                ≡⟨ gg' ⟩
        id                    ∎

  id≅ : {A : Ob} → A ≅ A
  id≅ = iso id id (id-l id) (id-l id)

  sym≅ : {A B : Ob} → A ≅ B → B ≅ A
  sym≅ f = iso (bwd f) (fwd f) (bwd-fwd f) (fwd-bwd f)

  infixr 9 _∙≅_
  _∙≅_ : {A B C : Ob} → A ≅ B → B ≅ C → A ≅ C
  f ∙≅ g = iso (fwd g ∘ fwd f) (bwd f ∘ bwd g)
    (whisker-cancel (fwd g) (bwd g) (fwd f) (bwd f) (fwd-bwd g) (fwd-bwd f))
    (whisker-cancel (bwd f) (fwd f) (bwd g) (fwd g) (bwd-fwd f) (bwd-fwd g))

  -- Dual on isos (covariant: A ≅ B ⇒ A^⊥ ≅ B^⊥, using contravariant ^⊥-hom).
  ^⊥≅ : {A B : Ob} → A ≅ B → (A ^⊥) ≅ (B ^⊥)
  ^⊥≅ f = iso (^⊥-hom (bwd f)) (^⊥-hom (fwd f)) lhs rhs
    where
      lhs : ^⊥-hom (bwd f) ∘ ^⊥-hom (fwd f) ≡ id
      lhs = sym (^⊥-∘-pres (fwd f) (bwd f))
          ∙ cong ^⊥-hom (fwd-bwd f)
          ∙ ^⊥-id-pres
      rhs : ^⊥-hom (fwd f) ∘ ^⊥-hom (bwd f) ≡ id
      rhs = sym (^⊥-∘-pres (bwd f) (fwd f))
          ∙ cong ^⊥-hom (bwd-fwd f)
          ∙ ^⊥-id-pres

  -- Tensor on isos.
  ⊗≅ : {A B C D : Ob} → A ≅ C → B ≅ D → (A ⊗ᵥ B) ≅ (C ⊗ᵥ D)
  ⊗≅ f g = iso (⊗-hom (fwd f) (fwd g)) (⊗-hom (bwd f) (bwd g)) lhs rhs
    where
      lhs : ⊗-hom (fwd f) (fwd g) ∘ ⊗-hom (bwd f) (bwd g) ≡ id
      lhs = sym (⊗-∘-pres (fwd f) (bwd f) (fwd g) (bwd g))
          ∙ cong₂ ⊗-hom (fwd-bwd f) (fwd-bwd g)
          ∙ ⊗-id-pres
      rhs : ⊗-hom (bwd f) (bwd g) ∘ ⊗-hom (fwd f) (fwd g) ≡ id
      rhs = sym (⊗-∘-pres (bwd f) (fwd f) (bwd g) (fwd g))
          ∙ cong₂ ⊗-hom (bwd-fwd f) (bwd-fwd g)
          ∙ ⊗-id-pres

  -- Involution iso A ≅ (A^⊥)^⊥.
  invol≅ : (A : Ob) → A ≅ ((A ^⊥) ^⊥)
  invol≅ A = iso ^⊥-involutive ^⊥-involutive-inv ^⊥-involutive-iso-r ^⊥-involutive-iso-l

  -- Par on isos (derived from ^⊥ and ⊗, since A ⅋ B = (A^⊥ ⊗ B^⊥)^⊥).
  ⅋≅ : {A B C D : Ob} → A ≅ C → B ≅ D → (A ⅋ᵥ B) ≅ (C ⅋ᵥ D)
  ⅋≅ f g = ^⊥≅ (⊗≅ (^⊥≅ f) (^⊥≅ g))

  -- De Morgan iso: (A ⊗ B)^⊥ ≅ A^⊥ ⅋ B^⊥  (the RHS unfolds to
  -- ((A^⊥)^⊥ ⊗ (B^⊥)^⊥)^⊥, definitionally).
  deMorgan⊗ : (A B : Ob) → ((A ⊗ᵥ B) ^⊥) ≅ ((A ^⊥) ⅋ᵥ (B ^⊥))
  deMorgan⊗ A B = ^⊥≅ (⊗≅ (invol≅ A) (invol≅ B))

  ----------------------------------------------------------------------
  -- The object model.
  ----------------------------------------------------------------------

  record SessionObjectModel : Type (ℓ-max (ℓ-max ℓ ℓ') ℓv) where
    field
      hasProducts : HasFiniteProducts (StarAutonomous→Category V)
      end-obj     : Ob
      payload-obj : Payload → Ob
      -- `end` is self-dual, as an iso.
      end-self    : (end-obj ^⊥) ≅ end-obj

  ----------------------------------------------------------------------
  -- The generic object-level interpretation.
  ----------------------------------------------------------------------

  module Interpretation (M : SessionObjectModel) where
    open SessionObjectModel M
    open HasFiniteProducts hasProducts

    -- Pairing absorbs post-composition: ⟨ a , b ⟩ ∘ h ≡ ⟨ a ∘ h , b ∘ h ⟩.
    private
      ⟨⟩-∘ : {A B C : Ob} (a : Hom C A) (b : Hom C B) {D : Ob} (h : Hom D C)
           → ⟨ a , b ⟩ ∘ h ≡ ⟨ a ∘ h , b ∘ h ⟩
      ⟨⟩-∘ a b h =
          ⟨ a , b ⟩ ∘ h
            ≡⟨ sym (&-η (⟨ a , b ⟩ ∘ h)) ⟩
          ⟨ π₁ ∘ (⟨ a , b ⟩ ∘ h) , π₂ ∘ (⟨ a , b ⟩ ∘ h) ⟩
            ≡⟨ cong₂ ⟨_,_⟩
                 (sym (∘-assoc π₁ ⟨ a , b ⟩ h) ∙ cong (_∘ h) (&-β₁ a b))
                 (sym (∘-assoc π₂ ⟨ a , b ⟩ h) ∙ cong (_∘ h) (&-β₂ a b)) ⟩
          ⟨ a ∘ h , b ∘ h ⟩ ∎

      ⟨π,π⟩≡id : {A B : Ob} → ⟨ π₁ {A} {B} , π₂ {A} {B} ⟩ ≡ id
      ⟨π,π⟩≡id =
          ⟨ π₁ , π₂ ⟩
            ≡⟨ cong₂ ⟨_,_⟩ (sym (id-r π₁)) (sym (id-r π₂)) ⟩
          ⟨ π₁ ∘ id , π₂ ∘ id ⟩
            ≡⟨ &-η id ⟩
          id ∎

    -- Binary product of isos, from the universal property.
    &≅ : {A B C D : Ob} → A ≅ C → B ≅ D → (A & B) ≅ (C & D)
    &≅ f g = iso ⟨ fwd f ∘ π₁ , fwd g ∘ π₂ ⟩ ⟨ bwd f ∘ π₁ , bwd g ∘ π₂ ⟩
                 (cancel f g) (cancel (sym≅ f) (sym≅ g))
      where
        -- A component projection through the pair: (h ∘ π) ∘ ⟨ h'∘π , _ ⟩ ≡ π
        -- when h ∘ h' ≡ id (here for π₁; the π₂ form is symmetric).
        comp₁ : {A B C D : Ob} (f : A ≅ C) (g : B ≅ D)
              → (fwd f ∘ π₁) ∘ ⟨ bwd f ∘ π₁ , bwd g ∘ π₂ ⟩ ≡ π₁
        comp₁ f g =
            (fwd f ∘ π₁) ∘ ⟨ bwd f ∘ π₁ , bwd g ∘ π₂ ⟩
              ≡⟨ ∘-assoc (fwd f) π₁ ⟨ bwd f ∘ π₁ , bwd g ∘ π₂ ⟩ ⟩
            fwd f ∘ (π₁ ∘ ⟨ bwd f ∘ π₁ , bwd g ∘ π₂ ⟩)
              ≡⟨ cong (fwd f ∘_) (&-β₁ (bwd f ∘ π₁) (bwd g ∘ π₂)) ⟩
            fwd f ∘ (bwd f ∘ π₁)
              ≡⟨ sym (∘-assoc (fwd f) (bwd f) π₁) ⟩
            (fwd f ∘ bwd f) ∘ π₁
              ≡⟨ cong (_∘ π₁) (fwd-bwd f) ⟩
            id ∘ π₁
              ≡⟨ id-l π₁ ⟩
            π₁ ∎

        comp₂ : {A B C D : Ob} (f : A ≅ C) (g : B ≅ D)
              → (fwd g ∘ π₂) ∘ ⟨ bwd f ∘ π₁ , bwd g ∘ π₂ ⟩ ≡ π₂
        comp₂ f g =
            (fwd g ∘ π₂) ∘ ⟨ bwd f ∘ π₁ , bwd g ∘ π₂ ⟩
              ≡⟨ ∘-assoc (fwd g) π₂ ⟨ bwd f ∘ π₁ , bwd g ∘ π₂ ⟩ ⟩
            fwd g ∘ (π₂ ∘ ⟨ bwd f ∘ π₁ , bwd g ∘ π₂ ⟩)
              ≡⟨ cong (fwd g ∘_) (&-β₂ (bwd f ∘ π₁) (bwd g ∘ π₂)) ⟩
            fwd g ∘ (bwd g ∘ π₂)
              ≡⟨ sym (∘-assoc (fwd g) (bwd g) π₂) ⟩
            (fwd g ∘ bwd g) ∘ π₂
              ≡⟨ cong (_∘ π₂) (fwd-bwd g) ⟩
            id ∘ π₂
              ≡⟨ id-l π₂ ⟩
            π₂ ∎

        cancel : {A B C D : Ob} (f : A ≅ C) (g : B ≅ D)
               → ⟨ fwd f ∘ π₁ , fwd g ∘ π₂ ⟩ ∘ ⟨ bwd f ∘ π₁ , bwd g ∘ π₂ ⟩ ≡ id
        cancel f g =
            ⟨ fwd f ∘ π₁ , fwd g ∘ π₂ ⟩ ∘ ⟨ bwd f ∘ π₁ , bwd g ∘ π₂ ⟩
              ≡⟨ ⟨⟩-∘ (fwd f ∘ π₁) (fwd g ∘ π₂) ⟨ bwd f ∘ π₁ , bwd g ∘ π₂ ⟩ ⟩
            ⟨ (fwd f ∘ π₁) ∘ ⟨ bwd f ∘ π₁ , bwd g ∘ π₂ ⟩
            , (fwd g ∘ π₂) ∘ ⟨ bwd f ∘ π₁ , bwd g ∘ π₂ ⟩ ⟩
              ≡⟨ cong₂ ⟨_,_⟩ (comp₁ f g) (comp₂ f g) ⟩
            ⟨ π₁ , π₂ ⟩
              ≡⟨ ⟨π,π⟩≡id ⟩
            id ∎

    ------------------------------------------------------------------
    -- The generic object-level interpretation J0.
    ------------------------------------------------------------------

    J0 : SessionType → Ob
    J0 end        = end-obj
    J0 (send p S) = payload-obj p ⊗ᵥ J0 S
    J0 (recv p S) = (payload-obj p ^⊥) ⅋ᵥ J0 S
    J0 (S ⊗ T)    = J0 S ⊗ᵥ J0 T
    J0 (S ⅋ T)    = J0 S ⅋ᵥ J0 T
    J0 𝟙ₛ         = 𝟙
    J0 ⊥ₛ         = ⊥-par
    J0 (S &ₛ T)   = J0 S & J0 T
    J0 (S ⊕ₛ T)   = ((J0 S ^⊥) & (J0 T ^⊥)) ^⊥
    J0 ⊤ₛ         = ⊤ₚ
    J0 𝟘ₛ         = ⊤ₚ ^⊥

    ------------------------------------------------------------------
    -- The content-bearing theorem: J0 sends syntactic duality to the
    -- categorical dual, up to isomorphism.
    ------------------------------------------------------------------

    J0-dual : (S : SessionType) → J0 (S ^⊥ₛ) ≅ (J0 S ^⊥)
    J0-dual end        = sym≅ end-self
    J0-dual (send p S) =
      ⅋≅ id≅ (J0-dual S) ∙≅ sym≅ (deMorgan⊗ (payload-obj p) (J0 S))
    J0-dual (recv p S) =
      ⊗≅ id≅ (J0-dual S)
      ∙≅ ⊗≅ (invol≅ (payload-obj p)) id≅
      ∙≅ invol≅ (((payload-obj p ^⊥) ^⊥) ⊗ᵥ (J0 S ^⊥))
    J0-dual (S ⊗ T) =
      ⅋≅ (J0-dual S) (J0-dual T) ∙≅ sym≅ (deMorgan⊗ (J0 S) (J0 T))
    J0-dual (S ⅋ T) =
      ⊗≅ (J0-dual S) (J0-dual T) ∙≅ invol≅ ((J0 S ^⊥) ⊗ᵥ (J0 T ^⊥))
    J0-dual 𝟙ₛ         = id≅
    J0-dual ⊥ₛ         = invol≅ 𝟙
    J0-dual (S &ₛ T)   = ^⊥≅ (&≅ (di S) (di T))
      where
        di : (U : SessionType) → (J0 (U ^⊥ₛ) ^⊥) ≅ J0 U
        di U = ^⊥≅ (J0-dual U) ∙≅ sym≅ (invol≅ (J0 U))
    J0-dual (S ⊕ₛ T)   =
      &≅ (J0-dual S) (J0-dual T) ∙≅ invol≅ ((J0 S ^⊥) & (J0 T ^⊥))
    J0-dual ⊤ₛ         = id≅
    J0-dual 𝟘ₛ         = invol≅ ⊤ₚ

    ------------------------------------------------------------------
    -- The morphism interpretation J1.
    --
    -- The session morphism HIT's point/path constructors mirror the
    -- target's `StarAutonomous` + `HasFiniteProducts` fields exactly, so
    -- every point constructor maps to a target operation and every path
    -- law to the corresponding target law. The one subtlety is duality:
    -- `J0 (S ^⊥ₛ)` is only *isomorphic* to `(J0 S) ^⊥` (via `J0-dual`),
    -- so `dual-h` is interpreted by conjugating `^⊥-hom` through the
    -- endpoint isos (`dualconj`), and `inv-dual-h` by the double-dual iso
    -- `dd`.
    --
    -- The 10 path-law names that collide with target-interface field
    -- names are renamed `h-…` on import.
    ------------------------------------------------------------------

    open Morph Payload renaming
      ( id-l to h-id-l ; id-r to h-id-r ; ∘-assoc to h-∘assoc
      ; α-iso-l to h-α-iso-l ; α-iso-r to h-α-iso-r
      ; leftUnitor-iso-l to h-lu-iso-l ; leftUnitor-iso-r to h-lu-iso-r
      ; rightUnitor-iso-l to h-ru-iso-l ; rightUnitor-iso-r to h-ru-iso-r
      ; braid-involutive to h-braid-inv )

    -- Conjugate a morphism through the duality isos: the semantic reading
    -- of the contravariant `dual-h`.
    dualconj : {A B : SessionType}
             → Hom (J0 A) (J0 B) → Hom (J0 (B ^⊥ₛ)) (J0 (A ^⊥ₛ))
    dualconj {A} {B} h = bwd (J0-dual A) ∘ (^⊥-hom h ∘ fwd (J0-dual B))

    private
      dualconj-id : {A : SessionType} → dualconj {A} {A} id ≡ id
      dualconj-id {A} =
          bwd dA ∘ (^⊥-hom id ∘ fwd dA)
            ≡⟨ cong (λ z → bwd dA ∘ (z ∘ fwd dA)) ^⊥-id-pres ⟩
          bwd dA ∘ (id ∘ fwd dA)
            ≡⟨ cong (bwd dA ∘_) (id-l (fwd dA)) ⟩
          bwd dA ∘ fwd dA
            ≡⟨ bwd-fwd dA ⟩
          id ∎
        where dA = J0-dual A

      dualconj-∘ : {A B C : SessionType}
                   (F : Hom (J0 B) (J0 C)) (G : Hom (J0 A) (J0 B))
                 → dualconj {A} {C} (F ∘ G)
                   ≡ dualconj {A} {B} G ∘ dualconj {B} {C} F
      dualconj-∘ {A} {B} {C} F G =
          dualconj {A} {C} (F ∘ G)
            ≡⟨ cong (λ z → bwd dA ∘ (z ∘ fwd dC)) (^⊥-∘-pres F G) ⟩
          bwd dA ∘ ((^⊥-hom G ∘ ^⊥-hom F) ∘ fwd dC)
            ≡⟨ sym rhs-reduce ⟩
          dualconj {A} {B} G ∘ dualconj {B} {C} F ∎
        where
          dA = J0-dual A
          dB = J0-dual B
          dC = J0-dual C
          g = ^⊥-hom G
          f = ^⊥-hom F
          -- The RHS reduces to the same fully-reassociated form by
          -- cancelling `fwd dB ∘ bwd dB ≡ id` in the middle.
          rhs-reduce :
            dualconj {A} {B} G ∘ dualconj {B} {C} F
            ≡ bwd dA ∘ ((g ∘ f) ∘ fwd dC)
          rhs-reduce =
              (bwd dA ∘ (g ∘ fwd dB)) ∘ (bwd dB ∘ (f ∘ fwd dC))
                ≡⟨ ∘-assoc (bwd dA) (g ∘ fwd dB) (bwd dB ∘ (f ∘ fwd dC)) ⟩
              bwd dA ∘ ((g ∘ fwd dB) ∘ (bwd dB ∘ (f ∘ fwd dC)))
                ≡⟨ cong (bwd dA ∘_) (∘-assoc g (fwd dB) (bwd dB ∘ (f ∘ fwd dC))) ⟩
              bwd dA ∘ (g ∘ (fwd dB ∘ (bwd dB ∘ (f ∘ fwd dC))))
                ≡⟨ cong (λ z → bwd dA ∘ (g ∘ z)) (sym (∘-assoc (fwd dB) (bwd dB) (f ∘ fwd dC))) ⟩
              bwd dA ∘ (g ∘ ((fwd dB ∘ bwd dB) ∘ (f ∘ fwd dC)))
                ≡⟨ cong (λ z → bwd dA ∘ (g ∘ (z ∘ (f ∘ fwd dC)))) (fwd-bwd dB) ⟩
              bwd dA ∘ (g ∘ (id ∘ (f ∘ fwd dC)))
                ≡⟨ cong (λ z → bwd dA ∘ (g ∘ z)) (id-l (f ∘ fwd dC)) ⟩
              bwd dA ∘ (g ∘ (f ∘ fwd dC))
                ≡⟨ cong (bwd dA ∘_) (sym (∘-assoc g f (fwd dC))) ⟩
              bwd dA ∘ ((g ∘ f) ∘ fwd dC) ∎

    -- The double-dual iso J0 A ≅ J0 ((A ^⊥ₛ) ^⊥ₛ).
    dd : (A : SessionType) → J0 A ≅ J0 ((A ^⊥ₛ) ^⊥ₛ)
    dd A = invol≅ (J0 A) ∙≅ sym≅ (^⊥≅ (J0-dual A)) ∙≅ sym≅ (J0-dual (A ^⊥ₛ))

    J1 : {A B : SessionType} → SessionHom A B → Hom (J0 A) (J0 B)
    -- Point constructors.
    J1 id-h               = id
    J1 (g ∘-h f)          = J1 g ∘ J1 f
    J1 (⊗-h f g)          = ⊗-hom (J1 f) (J1 g)
    J1 α-h                = α
    J1 α-inv-h            = α-inv
    J1 leftUnitor-h       = leftUnitor
    J1 leftUnitor-inv-h   = leftUnitor-inv
    J1 rightUnitor-h      = rightUnitor
    J1 rightUnitor-inv-h  = rightUnitor-inv
    J1 braid-h            = braid
    J1 (dual-h {A} {B} f) = dualconj {A} {B} (J1 f)
    J1 (inv-dual-h {A})     = fwd (dd A)
    J1 (inv-dual-inv-h {A}) = bwd (dd A)
    J1 terminal-h         = terminal
    J1 proj₁-h            = π₁
    J1 proj₂-h            = π₂
    J1 (pair-h f g)       = ⟨ J1 f , J1 g ⟩
    -- Path constructors.
    J1 (h-id-l f i)              = id-l (J1 f) i
    J1 (h-id-r f i)              = id-r (J1 f) i
    J1 (h-∘assoc f g h i)        = ∘-assoc (J1 f) (J1 g) (J1 h) i
    J1 (⊗-h-id-pres i)          = ⊗-id-pres i
    J1 (⊗-h-∘-pres f g h k i)   = ⊗-∘-pres (J1 f) (J1 g) (J1 h) (J1 k) i
    J1 (h-α-iso-l i)            = α-iso-l i
    J1 (h-α-iso-r i)            = α-iso-r i
    J1 (h-lu-iso-l i)          = leftUnitor-iso-l i
    J1 (h-lu-iso-r i)          = leftUnitor-iso-r i
    J1 (h-ru-iso-l i)          = rightUnitor-iso-l i
    J1 (h-ru-iso-r i)          = rightUnitor-iso-r i
    J1 (h-braid-inv i)         = braid-involutive i
    J1 (dual-h-id-pres {A} i)   = dualconj-id {A} i
    J1 (dual-h-∘-pres {A} {B} {C} f g i) = dualconj-∘ {A} {B} {C} (J1 f) (J1 g) i
    J1 (inv-dual-iso-l {A} i)   = bwd-fwd (dd A) i
    J1 (inv-dual-iso-r {A} i)   = fwd-bwd (dd A) i
    J1 (terminal-unique-h f i)  = terminal-unique (J1 f) i
    J1 (&ₛ-β₁ f g i)            = &-β₁ (J1 f) (J1 g) i
    J1 (&ₛ-β₂ f g i)            = &-β₂ (J1 f) (J1 g) i
    J1 (&ₛ-η h i)              = &-η (J1 h) i
    J1 (trunc f g p q i j)      =
      Hom-set (J1 f) (J1 g) (λ i → J1 (p i)) (λ i → J1 (q i)) i j

    ------------------------------------------------------------------
    -- The underlying 1-functor of the realization.
    --
    -- `J0` on objects, `J1` on morphisms. `F-id` and `F-seq` are `refl`:
    -- the source `⋆` is `g ∘-h f` and the target `⋆` is `J1 g ∘ J1 f`,
    -- and `J1 (g ∘-h f) = J1 g ∘ J1 f` holds definitionally.
    --
    -- This is the underlying 1-functor only — NOT yet a packaged
    -- strong-monoidal / additive / `*`-autonomous functor with coherence
    -- data. The structure-preservation it does carry (tensor, duality,
    -- products up to the target's named isos) is exactly what `J0-dual`
    -- and the connective clauses of `J0`/`J1` witness pointwise.
    ------------------------------------------------------------------

    J-underlying-functor : Functor SessionCategory (StarAutonomous→Category V)
    J-underlying-functor = record
      { F-ob  = J0
      ; F-hom = J1
      ; F-id  = refl
      ; F-seq = λ f g → refl
      }
