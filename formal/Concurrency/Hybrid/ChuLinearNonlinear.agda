{-# OPTIONS --cubical --guardedness #-}

-- The Benton / linear-non-linear adjunction `SET ⇄ Chu(SET, k)` — Phase 0.
--
-- Inhabits `LNLAdjunction (SET ℓ) (SET-HasFiniteProducts ℓ) Chu-StarAutonomous`:
-- the value-level adjunction the point-generated R4 theorem consumes as
-- `lnl`. This is the constructive `F ⊣ G` of the Chu construction.
--
--   G A   = A⁺                     (positive points; `G = positive`)
--   F X   = (X, k^X, λ x f → f x)  (free Chu space on a set)
--
-- The hom-bijection `Chu(F X, A) ≅ Set(X, A⁺)` is *forced*: a Chu morphism
-- `F X → A` is a pair `(f⁺ : X → A⁺, f⁻ : A⁻ → k^X)` whose compatibility
-- pins `f⁻ a⁻ = λ x → r_A (f⁺ x) a⁻`, so the morphism is determined by `f⁺`.
-- Hence `adjIso .fun = mapPos`, and `♯ g` reconstructs the forced `f⁻`.
--
-- Strong-monoidal comparisons:
--   mon-unit : F ⊤ ≅ 𝟙        (`k^Unit ≅ k`)
--   mon-bin  : F (X × Y) ≅ F X ⊗ F Y   (currying `(X × Y → k) ≅ ChuHom (F X) (dual (F Y))`)
--
-- The tensor's negative is the Chu hom-set `ChuHom (F X) (dual (F Y))`
-- (see `ChuMonoidal.agda`), so `mon-bin` is the curry/uncurry iso between
-- `X × Y → k` and that hom-set, with the iso laws discharged through the
-- Chu compatibility equation.
--
-- Discipline: postulate-free; no Sessions. Depends on `Chu`/`ChuMonoidal`,
-- `LinearNonlinear` (the record), `SetFiniteProducts`, and the cubical
-- category/Set machinery.

module Concurrency.Hybrid.ChuLinearNonlinear where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Structure using (⟨_⟩ ; str)
open import Cubical.Foundations.HLevels using (hSet ; isSetΠ ; isSet×)
open import Cubical.Foundations.Isomorphism using (Iso ; iso)
open import Cubical.Data.Sigma using (_×_ ; _,_ ; fst ; snd ; ΣPathP)
open import Cubical.Data.Unit using (Unit* ; tt* ; isSetUnit*)

open import Cubical.Categories.Category.Base using (Category ; isiso)
open import Cubical.Categories.Functor.Base using (Functor)
open import Cubical.Categories.Adjoint using (module NaturalBijection)
open import Cubical.Categories.Instances.Sets using (SET)

open import Concurrency.Algebras.StarAutonomousCategory using (StarAutonomous→Category)
open import Concurrency.Algebras.SetFiniteProducts using (SET-HasFiniteProducts)
open import Concurrency.Algebras.ChuMonoidal using (module Monoidal)
open import Concurrency.Hybrid.LinearNonlinear using (LNLAdjunction)

open NaturalBijection using (_⊣_)

module _ {ℓ : Level} (k : hSet ℓ) where

  open Monoidal k

  private
    Vcat : Category (ℓ-suc ℓ) ℓ
    Vcat = StarAutonomous→Category Chu-StarAutonomous

  ----------------------------------------------------------------------
  -- The free functor `F X = (X, k^X, ev)` and the points functor `G = A⁺`.
  ----------------------------------------------------------------------

  Fob : Category.ob (SET ℓ) → ChuObj
  Fob X = X , ((⟨ X ⟩ → ⟨ k ⟩) , isSetΠ (λ _ → str k)) , (λ x f → f x)

  Ffun : Functor (SET ℓ) Vcat
  Ffun = record
    { F-ob  = Fob
    ; F-hom = λ h → chuHom (h , (λ g x → g (h x))) (λ _ _ → refl)
    ; F-id  = ChuHom≡ refl
    ; F-seq = λ f g → ChuHom≡ refl
    }

  Gfun : Functor Vcat (SET ℓ)
  Gfun = record
    { F-ob  = positive
    ; F-hom = λ f → mapPos f
    ; F-id  = refl
    ; F-seq = λ f g → refl
    }

  ----------------------------------------------------------------------
  -- The adjunction `F ⊣ G`. `♭ = mapPos`; `♯ g` reconstructs the forced
  -- negative map; the naturality squares are `refl` / `ChuHom≡ refl`.
  ----------------------------------------------------------------------

  Fadj : Ffun ⊣ Gfun
  Fadj = record
    { adjIso = λ {X} {A} →
        iso (λ t → mapPos t)
            (λ g → chuHom (g , (λ a⁻ x → evaluate A (g x) a⁻)) (λ _ _ → refl))
            (λ g → refl)
            (λ t → ChuHom≡ (ΣPathP ( refl
                                   , funExt (λ a⁻ → funExt (λ x → compat t x a⁻)) )))
    ; adjNatInD = λ f g → refl
    ; adjNatInC = λ g h → ChuHom≡ refl
    }

  ----------------------------------------------------------------------
  -- Strong-monoidal comparison: unit. `F ⊤ ≅ 𝟙`.
  ----------------------------------------------------------------------

  monUnitFwd : ChuHom (Fob (Unit* , isSetUnit*)) chuUnit
  monUnitFwd = chuHom ((λ u → u) , (λ c _ → c)) (λ _ _ → refl)

  monUnitInv : ChuHom chuUnit (Fob (Unit* , isSetUnit*))
  monUnitInv = chuHom ((λ u → u) , (λ f → f tt*)) (λ _ _ → refl)

  ----------------------------------------------------------------------
  -- Strong-monoidal comparison: binary. `F (X × Y) ≅ F X ⊗ F Y`.
  ----------------------------------------------------------------------

  module _ (X Y : Category.ob (SET ℓ)) where

    SetProd : Category.ob (SET ℓ)
    SetProd = (⟨ X ⟩ × ⟨ Y ⟩) , isSet× (str X) (str Y)

    monBinFwd : ChuHom (Fob SetProd) (Fob X ⊗ Fob Y)
    monBinFwd =
      chuHom
        ( (λ m → m)
        , (λ t m → t .functionPair .fst (m .fst) (m .snd)) )
        (λ _ _ → refl)

    monBinInv : ChuHom (Fob X ⊗ Fob Y) (Fob SetProd)
    monBinInv =
      chuHom
        ( (λ m → m)
        , (λ f → chuHom ((λ x y → f (x , y)) , (λ y x → f (x , y))) (λ _ _ → refl)) )
        (λ _ _ → refl)

    -- inv ⋆ fwd ≡ id (on F X ⊗ F Y): the negative round-trip rebuilds each
    -- bilinear form, the two halves matched by its own Chu compatibility.
    monBinSec : chu-seq monBinInv monBinFwd ≡ chu-id
    monBinSec =
      ChuHom≡ (ΣPathP ( refl
                      , funExt (λ t →
                          ChuHom≡ (ΣPathP ( refl
                                          , funExt (λ y → funExt (λ x → compat t x y)) ))) ))

    -- fwd ⋆ inv ≡ id (on F (X × Y)): `refl` up to product η.
    monBinRet : chu-seq monBinFwd monBinInv ≡ chu-id
    monBinRet = ChuHom≡ refl

  ----------------------------------------------------------------------
  -- Assembly.
  ----------------------------------------------------------------------

  Chu-LNL : LNLAdjunction (SET ℓ) (SET-HasFiniteProducts ℓ) Chu-StarAutonomous
  Chu-LNL = record
    { F   = Ffun
    ; G   = Gfun
    ; F⊣G = Fadj
    ; mon-unit = monUnitFwd , isiso monUnitInv (ChuHom≡ refl) (ChuHom≡ refl)
    ; mon-bin  = λ X Y →
        monBinFwd X Y , isiso (monBinInv X Y) (monBinSec X Y) (monBinRet X Y)
    }
