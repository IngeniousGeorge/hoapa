{-# OPTIONS --cubical --guardedness #-}

-- The `*`-autonomous structure on `Chu(SET, k)` — Phase 0, assembling the
-- project's `StarAutonomous` record.
--
-- Built on `Chu.agda` (the category) via `open Construction k`. The thin
-- `StarAutonomous` signature asks for `⊗`, `𝟙`, `^⊥` with the named
-- isomorphisms (associator, unitors, braid, involution) and their inverse
-- laws and functoriality — but NOT Mac Lane coherence (pentagon / hexagon /
-- triangle), which it omits by design.
--
-- The three primitives:
--
--   A ^⊥  = (A⁻, A⁺, flip r)              -- swap polarities, flip evaluation
--   𝟙     = (Unit, k, λ _ c → c)          -- tensor unit
--   A ⊗ B = (A⁺ × B⁺, ChuHom A (dual B), …) -- product positives; the negative
--                                           -- carrier is the Chu hom-set
--
-- KEY representation choice. The Chu tensor negative `(A ⊗ B)⁻` is, up to
-- the symmetry of the compatibility equation, *exactly* the Chu hom-set
-- `ChuHom A (dual B)` — a pair `(p : A⁺ → B⁻, q : B⁺ → A⁻)` with
-- `r_B b (p a) ≡ r_A a (q b)`, which is the data of a morphism `A → B^⊥`.
-- Representing it as `ChuHom A (dual B)` (rather than a bespoke
-- `TensorNeg` record) makes the negative action of `⊗-hom` *categorical
-- composition* — `⊗-hom f g` sends `t ↦ f ; t ; dual-hom g` — so the
-- functoriality and coherence laws reduce to the category laws already
-- proved in `Chu.agda` (`chu-⋆IdL/R`, `chu-⋆Assoc`, `dual-id`, `dual-comp`)
-- composed as *named paths*, instead of forcing Agda to normalize deeply
-- nested constructors. This is what keeps elaboration tractable (the
-- bespoke-record version was correct but cost ~2 minutes per functoriality
-- law and did not finish a full build inside the harness limits); it also
-- exposes the closed / currying structure that the later O₁ work needs.
--
-- Note `(A ^⊥) ^⊥ ≡ A` definitionally (double swap, `flip ∘ flip = id`), so
-- the involution isos are `id`, and `dual` is its own inverse on morphisms
-- up to `sym (sym _) ≡ _`.
--
-- Discipline: postulate-free; depends only on `Chu.agda`, `StarAutonomous`,
-- and cubical Set/Sigma/Unit data. No Sessions.

module Concurrency.Algebras.ChuMonoidal where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Structure using (⟨_⟩ ; str)
open import Cubical.Foundations.HLevels using (hSet ; isSet×)
open import Cubical.Data.Sigma using (_×_ ; _,_ ; fst ; snd ; ΣPathP)
open import Cubical.Data.Unit using (Unit* ; tt* ; isSetUnit*)

open import Concurrency.Algebras.Chu using (module Construction)
open import Concurrency.Algebras.StarAutonomous using (StarAutonomous)

-- Named submodule (parameterized by `k`) re-exporting `Construction`, so
-- downstream files `open Monoidal k` once for both the category and the
-- `*`-autonomous structure.
module Monoidal {ℓ : Level} (k : hSet ℓ) where

  open Construction k public

  ----------------------------------------------------------------------
  -- Duality `_^⊥`: swap positive/negative, flip evaluation.
  ----------------------------------------------------------------------

  dual : ChuObj → ChuObj
  dual A = negative A , positive A , (λ a⁻ a⁺ → evaluate A a⁺ a⁻)

  dual-hom : {A B : ChuObj} → ChuHom A B → ChuHom (dual B) (dual A)
  dual-hom f =
    chuHom (mapNeg f , mapPos f) (λ b⁻ a⁺ → sym (compat f a⁺ b⁻))

  dual-id : {A : ChuObj} → dual-hom (chu-id {A}) ≡ chu-id
  dual-id = ChuHom≡ refl

  -- Contravariant functoriality. With the record's applicative `_∘_`
  -- (`g ∘ f = chu-seq f g`), the law `^⊥-∘-pres` reads as below.
  dual-comp : {A B C : ChuObj} (f : ChuHom A B) (g : ChuHom B C)
            → dual-hom (chu-seq f g) ≡ chu-seq (dual-hom g) (dual-hom f)
  dual-comp f g = ChuHom≡ refl

  ----------------------------------------------------------------------
  -- Tensor unit `𝟙 = (Unit, k, λ _ c → c)`.
  ----------------------------------------------------------------------

  chuUnit : ChuObj
  chuUnit = (Unit* , isSetUnit*) , k , (λ _ c → c)

  ----------------------------------------------------------------------
  -- Tensor object: the negative carrier is the Chu hom-set `ChuHom A (dual B)`.
  ----------------------------------------------------------------------

  _⊗_ : ChuObj → ChuObj → ChuObj
  A ⊗ B =
      (⟨ positive A ⟩ × ⟨ positive B ⟩
        , isSet× (str (positive A)) (str (positive B)))
    , (ChuHom A (dual B) , isSetChuHom)
    , (λ m t → evaluate B (m .snd) (t .functionPair .fst (m .fst)))

  ----------------------------------------------------------------------
  -- Tensor functoriality. Positives map by `f⁺ × g⁺`; the negative action
  -- is categorical: `t ↦ f ; t ; dual-hom g`.
  ----------------------------------------------------------------------

  ⊗-hom : {A B C D : ChuObj}
        → ChuHom A C → ChuHom B D → ChuHom (A ⊗ B) (C ⊗ D)
  ⊗-hom {A} {B} {C} {D} f g =
    chuHom
      ( (λ m → (f .functionPair .fst (m .fst) , g .functionPair .fst (m .snd)))
      , (λ t → chu-seq (chu-seq f t) (dual-hom g)) )
      (λ m t → g .compatLaw (m .snd) (t .functionPair .fst (f .functionPair .fst (m .fst))))

  ⊗-id : {A B : ChuObj} → ⊗-hom (chu-id {A}) (chu-id {B}) ≡ chu-id
  ⊗-id =
    ChuHom≡ (ΣPathP ( refl
                    , funExt (λ t →
                          cong (chu-seq (chu-seq chu-id t)) dual-id
                        ∙ chu-⋆IdR (chu-seq chu-id t)
                        ∙ chu-⋆IdL t) ))

  -- Functoriality on composition. With applicative `_∘_`, the record law
  -- `⊗-∘-pres f g h k : ⊗-hom (f ∘ g) (h ∘ k) ≡ ⊗-hom f h ∘ ⊗-hom g k`
  -- reads, in `chu-seq` terms, as below. The negative side is a
  -- five-fold composite reassociated via `chu-⋆Assoc` after rewriting the
  -- dual of a composite with `dual-comp`.
  ⊗-comp : {A B C D E F : ChuObj}
           (f : ChuHom C E) (g : ChuHom A C) (h : ChuHom D F) (k : ChuHom B D)
         → ⊗-hom (chu-seq g f) (chu-seq k h)
         ≡ chu-seq (⊗-hom g k) (⊗-hom f h)
  ⊗-comp f g h k =
    ChuHom≡ (ΣPathP ( refl
                    , funExt (λ t →
                          cong (chu-seq (chu-seq (chu-seq g f) t)) (dual-comp k h)
                        ∙ chu-⋆Assoc (chu-seq g f) t (chu-seq (dual-hom h) (dual-hom k))
                        ∙ chu-⋆Assoc g f (chu-seq t (chu-seq (dual-hom h) (dual-hom k)))
                        ∙ sym ( chu-⋆Assoc g (chu-seq (chu-seq f t) (dual-hom h)) (dual-hom k)
                              ∙ cong (chu-seq g) (chu-⋆Assoc (chu-seq f t) (dual-hom h) (dual-hom k))
                              ∙ cong (chu-seq g) (chu-⋆Assoc f t (chu-seq (dual-hom h) (dual-hom k)))) )))

  ----------------------------------------------------------------------
  -- Braiding `A ⊗ B → B ⊗ A`. The negative action is just `dual-hom`
  -- (using `(dual (dual A)) ≡ A`): `ChuHom B (dual A) → ChuHom A (dual B)`.
  ----------------------------------------------------------------------

  braid : {A B : ChuObj} → ChuHom (A ⊗ B) (B ⊗ A)
  braid {A} {B} =
    chuHom
      ( (λ m → (m .snd , m .fst))
      , (λ t → dual-hom t) )
      (λ m t → t .compatLaw (m .snd) (m .fst))

  braid-inv : {A B : ChuObj}
            → chu-seq (braid {A} {B}) (braid {B} {A}) ≡ chu-id
  braid-inv =
    ChuHom≡ (ΣPathP (refl , funExt (λ t → ChuHom≡ refl)))

  ----------------------------------------------------------------------
  -- Left unitor `𝟙 ⊗ A → A`.
  ----------------------------------------------------------------------

  leftUnitor : {A : ChuObj} → ChuHom (chuUnit ⊗ A) A
  leftUnitor {A} =
    chuHom
      ( (λ m → m .snd)
      , (λ a⁻ → chuHom ((λ _ → a⁻) , (λ x → evaluate A x a⁻)) (λ _ _ → refl)) )
      (λ _ _ → refl)

  leftUnitor-inv : {A : ChuObj} → ChuHom A (chuUnit ⊗ A)
  leftUnitor-inv {A} =
    chuHom ((λ a → (tt* , a)) , (λ t → t .functionPair .fst tt*)) (λ _ _ → refl)

  leftUnitor-iso-l : {A : ChuObj}
                   → chu-seq (leftUnitor {A}) leftUnitor-inv ≡ chu-id
  leftUnitor-iso-l {A} =
    ChuHom≡ (ΣPathP ( refl
                    , funExt (λ t →
                        ChuHom≡ (ΣPathP ( refl
                                        , funExt (λ x → t .compatLaw tt* x) ))) ))

  leftUnitor-iso-r : {A : ChuObj}
                   → chu-seq leftUnitor-inv (leftUnitor {A}) ≡ chu-id
  leftUnitor-iso-r = ChuHom≡ refl

  ----------------------------------------------------------------------
  -- Right unitor `A ⊗ 𝟙 → A`.
  ----------------------------------------------------------------------

  rightUnitor : {A : ChuObj} → ChuHom (A ⊗ chuUnit) A
  rightUnitor {A} =
    chuHom
      ( (λ m → m .fst)
      , (λ a⁻ → chuHom ((λ x → evaluate A x a⁻) , (λ _ → a⁻)) (λ _ _ → refl)) )
      (λ _ _ → refl)

  rightUnitor-inv : {A : ChuObj} → ChuHom A (A ⊗ chuUnit)
  rightUnitor-inv {A} =
    chuHom ((λ a → (a , tt*)) , (λ t → t .functionPair .snd tt*))
           (λ a t → t .compatLaw a tt*)

  rightUnitor-iso-l : {A : ChuObj}
                    → chu-seq (rightUnitor {A}) rightUnitor-inv ≡ chu-id
  rightUnitor-iso-l {A} =
    ChuHom≡ (ΣPathP ( refl
                    , funExt (λ t →
                        ChuHom≡ (ΣPathP ( funExt (λ x → sym (t .compatLaw x tt*))
                                        , refl ))) ))

  rightUnitor-iso-r : {A : ChuObj}
                    → chu-seq rightUnitor-inv (rightUnitor {A}) ≡ chu-id
  rightUnitor-iso-r = ChuHom≡ refl

  ----------------------------------------------------------------------
  -- Associator `(A ⊗ B) ⊗ C → A ⊗ (B ⊗ C)`. The negative action is the
  -- curry/uncurry shuffle between `ChuHom A (dual (B ⊗ C))` and
  -- `ChuHom (A ⊗ B) (dual C)`, threading the inner Chu compatibilities.
  ----------------------------------------------------------------------

  assoc : {A B C : ChuObj} → ChuHom ((A ⊗ B) ⊗ C) (A ⊗ (B ⊗ C))
  assoc {A} {B} {C} =
    chuHom
      ( (λ m → (m .fst .fst , (m .fst .snd , m .snd)))
      , (λ t → chuHom
                 ( (λ m → (t .functionPair .fst (m .fst)) .functionPair .fst (m .snd))
                 , (λ c → chuHom
                            ( (λ a → (t .functionPair .fst a) .functionPair .snd c)
                            , (λ b → t .functionPair .snd (b , c)) )
                            (λ a b → sym ((t .functionPair .fst a) .compatLaw b c)
                                   ∙ t .compatLaw a (b , c))) )
                 (λ m c → (t .functionPair .fst (m .fst)) .compatLaw (m .snd) c)) )
      (λ _ _ → refl)

  assoc-inv : {A B C : ChuObj} → ChuHom (A ⊗ (B ⊗ C)) ((A ⊗ B) ⊗ C)
  assoc-inv {A} {B} {C} =
    chuHom
      ( (λ m → ((m .fst , m .snd .fst) , m .snd .snd))
      , (λ s → chuHom
                 ( (λ a → chuHom
                            ( (λ b → s .functionPair .fst (a , b))
                            , (λ c → (s .functionPair .snd c) .functionPair .fst a) )
                            (λ b c → s .compatLaw (a , b) c))
                 , (λ bc → (s .functionPair .snd (bc .snd)) .functionPair .snd (bc .fst)) )
                 (λ a bc → s .compatLaw (a , bc .fst) (bc .snd)
                         ∙ (s .functionPair .snd (bc .snd)) .compatLaw a (bc .fst))) )
      (λ _ _ → refl)

  assoc-iso-l : {A B C : ChuObj}
              → chu-seq (assoc {A} {B} {C}) assoc-inv ≡ chu-id
  assoc-iso-l =
    ChuHom≡ (ΣPathP ( refl
                    , funExt (λ t →
                        ChuHom≡ (ΣPathP ( refl
                                        , funExt (λ c → ChuHom≡ refl) ))) ))

  assoc-iso-r : {A B C : ChuObj}
              → chu-seq assoc-inv (assoc {A} {B} {C}) ≡ chu-id
  assoc-iso-r =
    ChuHom≡ (ΣPathP ( refl
                    , funExt (λ t →
                        ChuHom≡ (ΣPathP ( funExt (λ a → ChuHom≡ refl)
                                        , refl ))) ))

  ----------------------------------------------------------------------
  -- Assembly: the `StarAutonomous` record on `Chu(SET, k)`.
  --
  -- Composition is the applicative flip of `chu-seq` (`g ∘ f = chu-seq f g`),
  -- so `StarAutonomous→Category Chu-StarAutonomous` matches `Chu-Cat`'s
  -- diagrammatic `_⋆_` up to η. The unit/associativity laws are the
  -- `chu-⋆…` laws read in the flipped direction; the involution isos are
  -- `chu-id` because `(A ^⊥) ^⊥ ≡ A` definitionally.
  ----------------------------------------------------------------------

  Chu-StarAutonomous : StarAutonomous (ℓ-suc ℓ) ℓ
  Chu-StarAutonomous = record
    { Ob       = ChuObj
    ; Hom      = ChuHom
    ; Hom-set  = isSetChuHom
    ; id       = chu-id
    ; _∘_      = λ g f → chu-seq f g
    ; id-l     = λ f → chu-⋆IdR f
    ; id-r     = λ f → chu-⋆IdL f
    ; ∘-assoc  = λ f g h → sym (chu-⋆Assoc h g f)
    ; _⊗_      = _⊗_
    ; 𝟙        = chuUnit
    ; ⊗-hom    = ⊗-hom
    ; ⊗-id-pres = ⊗-id
    ; ⊗-∘-pres = λ f g h k → ⊗-comp f g h k
    ; α        = assoc
    ; α-inv    = assoc-inv
    ; α-iso-l  = assoc-iso-l
    ; α-iso-r  = assoc-iso-r
    ; leftUnitor       = leftUnitor
    ; leftUnitor-inv   = leftUnitor-inv
    ; leftUnitor-iso-l = leftUnitor-iso-l
    ; leftUnitor-iso-r = leftUnitor-iso-r
    ; rightUnitor       = rightUnitor
    ; rightUnitor-inv   = rightUnitor-inv
    ; rightUnitor-iso-l = rightUnitor-iso-l
    ; rightUnitor-iso-r = rightUnitor-iso-r
    ; braid            = braid
    ; braid-involutive = braid-inv
    ; _^⊥       = dual
    ; ^⊥-hom    = dual-hom
    ; ^⊥-id-pres = dual-id
    ; ^⊥-∘-pres = λ f g → dual-comp g f
    ; ^⊥-involutive       = chu-id
    ; ^⊥-involutive-inv   = chu-id
    ; ^⊥-involutive-iso-l = ChuHom≡ refl
    ; ^⊥-involutive-iso-r = ChuHom≡ refl
    }
