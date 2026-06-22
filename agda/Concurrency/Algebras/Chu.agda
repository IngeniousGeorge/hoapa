{-# OPTIONS --cubical --guardedness #-}

-- The Chu construction `Chu(SET, k)` — Phase 0, the underlying category.
--
-- This is the first brick of the Chu coefficient-category program (R1/R7
-- value-category decision). The convergence recorded in `workflow/status.md`
-- (`## Next step`) settled that the point-generated R4 theorem
-- `Lpoint ⊣ Rpoint` is generic over a value category `V`, and that the
-- Phase-0, grade-(i) *coefficient non-vacuity* witness is to instantiate
-- that `V` at the genuinely-mathematical `Chu(SET, k)` — Barr's Chu
-- construction over the category of sets and a dualizing object `k` — with
-- `k = Bool` as the concrete nondegenerate witness.
--
-- A Chu object is a triple `(A⁺, A⁻, r : A⁺ × A⁻ → k)`: a set of
-- *positive points* (realizations / processes), a set of *negative states*
-- (tests / observations), and an *evaluation* pairing them into `k`. A Chu
-- morphism `A → B` is an *adjoint pair* of maps `f⁺ : A⁺ → B⁺` and
-- `f⁻ : B⁻ → A⁻` satisfying the compatibility law
-- `r_B (f⁺ a) b⁻ ≡ r_A a (f⁻ b⁻)`. (Polarity meanings are kept neutral and
-- operational per the R1 decision; the Reality reading is a downstream
-- interpretation, not part of this construction.)
--
-- Scope of THIS file (Codex guardrail: verify incrementally). Only the
-- underlying 1-category: objects, morphisms, identity, composition, the
-- unit / associativity laws, and the proof that hom-types are sets. NO
-- monoidal / *-autonomous structure (that is `ChuMonoidal.agda`), NO finite
-- products (`ChuFiniteProducts.agda`), NO adjunction (`ChuLinearNonlinear`).
--
-- Discipline (Phase-0 postulate budget). Postulate-free, and depends on no
-- Sessions module — not even transitively through a convenience lemma. The
-- only imports are the cubical prelude, h-level/structure helpers, Σ, and
-- the library `Category`.
--
-- Hom-sets (Codex risk #6). A Chu morphism is a pair of functions plus a
-- compatibility proof. The compatibility law is an equality in `k`; since
-- `k` is a set, that law is a *proposition* (`isPropIsCompat`). So a Chu
-- hom is `Σ (function) (Σ (function) (proposition))`, hence a set by
-- `isSetΣ` + `isProp→isSet` — and morphism equality reduces to equality of
-- the two function components (`ChuHom≡`), the proof component being
-- carried along automatically.
--
-- Universe decision (Codex: keep levels flexible, but the construction
-- determines them). The duality `_^⊥` (in `ChuMonoidal.agda`) swaps `A⁺`
-- and `A⁻`, so both carriers must live at the same level. The LNL functor
-- `F X = (X, k^X, ev)` (in `ChuLinearNonlinear.agda`) has negative carrier
-- `⟨X⟩ → ⟨k⟩`, which forces `k` to the carrier level. Phase 0 therefore
-- keeps `k : hSet ℓ` at the `SET ℓ` object level and all carriers at `ℓ`,
-- giving `Chu-Cat : Category (ℓ-suc ℓ) ℓ` — definitionally the same level
-- pair as `SET ℓ : Category (ℓ-suc ℓ) ℓ`. The generalization (a separate
-- `ℓk` with explicit `Lift`s) is deferred; it is not needed for the witness.

module Concurrency.Algebras.Chu where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Structure using (⟨_⟩ ; str)
open import Cubical.Foundations.HLevels
  using (hSet ; isSetΣ ; isSetΠ ; isSet× ; isPropΠ2 ; isSetRetract ; isSet→SquareP)
open import Cubical.Data.Sigma using (Σ-syntax ; _×_ ; _,_ ; fst ; snd)

open import Cubical.Categories.Category.Base using (Category)

-- The whole construction is a named submodule parameterized by `k`, so
-- downstream files (`ChuFiniteProducts`, `ChuMonoidal`, …) can `open
-- Construction k` once and refer to `ChuObj`, `chuHom`, `chu-seq`, … with
-- `k` already fixed, rather than threading it through every reference.
module Construction {ℓ : Level} (k : hSet ℓ) where

  ----------------------------------------------------------------------
  -- Objects: a Chu space over `(SET ℓ, k)`.
  --
  -- `(positive, negative, evaluate)` = `(A⁺, A⁻, r : A⁺ × A⁻ → k)`, with
  -- `evaluate` in curried form. Both carriers are `hSet ℓ` (same level —
  -- see the universe note in the header).
  ----------------------------------------------------------------------

  ChuObj : Type (ℓ-suc ℓ)
  ChuObj = Σ[ pos ∈ hSet ℓ ] Σ[ neg ∈ hSet ℓ ] (⟨ pos ⟩ → ⟨ neg ⟩ → ⟨ k ⟩)

  positive : ChuObj → hSet ℓ
  positive A = A .fst

  negative : ChuObj → hSet ℓ
  negative A = A .snd .fst

  evaluate : (A : ChuObj) → ⟨ positive A ⟩ → ⟨ negative A ⟩ → ⟨ k ⟩
  evaluate A = A .snd .snd

  ----------------------------------------------------------------------
  -- Morphisms: an adjoint pair `(f⁺ , f⁻)` with the Chu compatibility
  -- law. `f⁺` is covariant on positive points, `f⁻` contravariant on
  -- negative states.
  ----------------------------------------------------------------------

  -- The two function components of a morphism `A → B`, bundled as one `×`
  -- so that the compatibility law (`isCompat`) is a *single* predicate on
  -- the bundle. Indexing the predicate by the bundle rather than by the two
  -- functions separately is what lets morphism equality (`ChuHom≡`) go
  -- through cleanly: the `isProp→PathP` family is then `isPropIsCompat A B
  -- (p j)` with `p j : FunctionPair A B` reducing directly.
  FunctionPair : ChuObj → ChuObj → Type ℓ
  FunctionPair A B =
    (⟨ positive A ⟩ → ⟨ positive B ⟩) × (⟨ negative B ⟩ → ⟨ negative A ⟩)

  isCompat : (A B : ChuObj) → FunctionPair A B → Type ℓ
  isCompat A B m =
    (a : ⟨ positive A ⟩) (b : ⟨ negative B ⟩)
    → evaluate B (m .fst a) b ≡ evaluate A a (m .snd b)

  -- The compatibility law is a proposition: a family of equalities in the
  -- set `k`. This is what makes hom-types sets (Codex risk #6). The `str k`
  -- endpoints are supplied explicitly — left implicit, the unifier cannot
  -- recover them when `isProp→PathP` reconciles two composites' proofs.
  isPropIsCompat : (A B : ChuObj) (m : FunctionPair A B)
                 → isProp (isCompat A B m)
  isPropIsCompat A B m =
    isPropΠ2 (λ a b → str k (evaluate B (m .fst a) b) (evaluate A a (m .snd b)))

  -- A morphism is a `FunctionPair` carrying the compatibility law as a
  -- propositional second component.
  --
  -- `ChuHom` is a *record*, not the bare `Σ`, deliberately. The category
  -- laws and `Chu-Cat` need Agda to recover the object indices `A`, `B`
  -- from a hypothesis `f : ChuHom A B` (e.g. to infer `chu-seq`'s implicit
  -- objects). A `Σ` unfolds, so that recovery is a non-pattern unification
  -- (`positive ?A ≐ positive A`) that blocks on the objects' internal
  -- structure; a record is recovered by constructor injectivity, so the
  -- indices solve immediately. (The record has eta, so it is still
  -- equivalent to the `Σ`, used for `isSetChuHom` below.)
  record ChuHom (A B : ChuObj) : Type ℓ where
    constructor chuHom
    field
      functionPair : FunctionPair A B
      compatLaw    : isCompat A B functionPair

  open ChuHom public

  mapPos : {A B : ChuObj} → ChuHom A B → ⟨ positive A ⟩ → ⟨ positive B ⟩
  mapPos f = f .functionPair .fst

  mapNeg : {A B : ChuObj} → ChuHom A B → ⟨ negative B ⟩ → ⟨ negative A ⟩
  mapNeg f = f .functionPair .snd

  compat : {A B : ChuObj} (f : ChuHom A B) → isCompat A B (f .functionPair)
  compat f = f .compatLaw

  ----------------------------------------------------------------------
  -- Hom-sets and the extensionality principle for morphisms.
  ----------------------------------------------------------------------

  -- Hom-types are sets: `ChuHom A B` is a retract of the `Σ` it is eta-equal
  -- to, whose set-ness is `isSetΣ` over the function-pair (a product of
  -- function types into sets) and the propositional compatibility law.
  isSetChuHom : {A B : ChuObj} → isSet (ChuHom A B)
  isSetChuHom {A} {B} =
    isSetRetract
      (λ f → f .functionPair , f .compatLaw)
      (λ s → chuHom (s .fst) (s .snd))
      (λ _ → refl)
      (isSetΣ
        (isSet× (isSetΠ (λ _ → str (positive B)))
                (isSetΠ (λ _ → str (negative A))))
        (λ m → isProp→isSet (isPropIsCompat A B m)))

  -- Two Chu morphisms with equal function-pairs are equal; the
  -- compatibility component is filled *pointwise in the set `k`* with
  -- `isSet→SquareP`. An alternative is to transport the whole `compatLaw`
  -- function with `isProp→PathP` (`isPropIsCompat`); both are correct and,
  -- measured here, of comparable cost. The pointwise square fill is used
  -- because it keeps the obligation at the `k` level. (The real
  -- elaboration win for the tensor laws came not from this choice but from
  -- representing tensor negatives as Chu hom-sets — see `ChuMonoidal.agda`.)
  ChuHom≡ : {A B : ChuObj} {f g : ChuHom A B}
          → f .functionPair ≡ g .functionPair
          → f ≡ g
  ChuHom≡ {A} {B} {f} {g} p i =
    chuHom (p i)
      (λ a b → isSet→SquareP (λ _ _ → str k)
                  (f .compatLaw a b) (g .compatLaw a b)
                  (λ j → evaluate B (p j .fst a) b)
                  (λ j → evaluate A a (p j .snd b)) i)

  ----------------------------------------------------------------------
  -- Category structure (diagrammatic: `f ⋆ g` = "f then g").
  ----------------------------------------------------------------------

  chu-id : {A : ChuObj} → ChuHom A A
  chu-id = chuHom ((λ a → a) , (λ b → b)) (λ _ _ → refl)

  -- Composition. The composite's compatibility chains `g`'s law at
  -- `(f⁺ a , c)` with `f`'s law at `(a , g⁻ c)`. Written with direct
  -- projections, not the `mapPos`/`mapNeg` helpers: the unifier unfolds
  -- record projections but not the helper definitions, and the category
  -- laws need the composite's function-pair to reduce under `refl`.
  chu-seq : {A B C : ChuObj} → ChuHom A B → ChuHom B C → ChuHom A C
  chu-seq {A} {B} {C} f g =
    chuHom
      ( (λ a → g .functionPair .fst (f .functionPair .fst a))
      , (λ c → f .functionPair .snd (g .functionPair .snd c)) )
      (λ a c → g .compatLaw (f .functionPair .fst a) c
             ∙ f .compatLaw a (g .functionPair .snd c))

  -- The unit / associativity laws hold by `ChuHom≡ refl`: the function-pair
  -- components are (definitionally) the function-composition laws, and the
  -- compatibility component is propositional. Because `ChuHom` is a record,
  -- the object indices are recovered by injectivity, so the laws can carry
  -- the record fields' own implicit-instance types directly.
  chu-⋆IdL : {A B : ChuObj} (f : ChuHom A B) → chu-seq chu-id f ≡ f
  chu-⋆IdL {A} {B} f = ChuHom≡ {A = A} {B = B} refl

  chu-⋆IdR : {A B : ChuObj} (f : ChuHom A B) → chu-seq f chu-id ≡ f
  chu-⋆IdR {A} {B} f = ChuHom≡ {A = A} {B = B} refl

  chu-⋆Assoc : {A B C D : ChuObj}
               (f : ChuHom A B) (g : ChuHom B C) (h : ChuHom C D)
             → chu-seq (chu-seq f g) h ≡ chu-seq f (chu-seq g h)
  chu-⋆Assoc {A} {B} {C} {D} f g h = ChuHom≡ {A = A} {B = D} refl

  Chu-Cat : Category (ℓ-suc ℓ) ℓ
  Chu-Cat = record
    { ob       = ChuObj
    ; Hom[_,_] = ChuHom
    ; id       = chu-id
    ; _⋆_      = chu-seq
    ; ⋆IdL     = chu-⋆IdL
    ; ⋆IdR     = chu-⋆IdR
    ; ⋆Assoc   = chu-⋆Assoc
    ; isSetHom = isSetChuHom
    }
