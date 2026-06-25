{-# OPTIONS --cubical --guardedness #-}

-- Finite products in `Chu(SET, k)` — Phase 0, the additive `&` / `⊤ₚ`.
--
-- This supplies `HasFiniteProducts (Chu-Cat k)`: the cartesian product
-- structure the point-generated R4 theorem consumes as `vProd` on the
-- linear value category. (It is stated over the bare `Chu-Cat` built in
-- `Chu.agda`; once `ChuMonoidal.agda` packages the `StarAutonomous` record
-- with composition defined as the flip of `chu-seq`, `StarAutonomous→Category`
-- should be definitionally `Chu-Cat`, so this same instance serves as
-- `vProd` — to be confirmed after that assembly, repackaging if a proof
-- field normalizes differently.)
--
-- The Chu product is NOT componentwise (Codex guardrail #2): the *positive*
-- side is the Set product, the *negative* side the Set coproduct.
--
--   ⊤ₚ      = (Unit , ∅,    vacuous)        -- terminal: terminal pos, initial neg
--   A & B   = (A⁺ × B⁺ , A⁻ ⊎ B⁻ , ⟨case⟩)  -- product pos, coproduct neg
--
-- Evaluation of `A & B`: `r ((a,b)) (inl a⁻) = r_A a a⁻`,
-- `r ((a,b)) (inr b⁻) = r_B b b⁻`. The universal property (β + η) is
-- *proved*, not assumed: β holds by `refl` (the projections compute), and
-- η needs one coproduct case-split (`⊎` has no definitional η).
--
-- Discipline: postulate-free; depends only on `Chu.agda`, `FiniteProducts`,
-- and the cubical Set/Sum/Unit/Empty data. No Sessions, no monoidal layer.

module Concurrency.Algebras.ChuFiniteProducts where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Structure using (⟨_⟩ ; str)
open import Cubical.Foundations.HLevels using (hSet ; isSet×)
open import Cubical.Data.Sigma using (_×_ ; _,_ ; fst ; snd ; ΣPathP)
open import Cubical.Data.Sum using (_⊎_ ; inl ; inr ; isSet⊎)
open import Cubical.Data.Unit using (Unit* ; tt* ; isPropUnit* ; isSetUnit*)
open import Cubical.Data.Empty using (⊥* ; isProp⊥* ; rec*)

open import Concurrency.Algebras.Chu using (module Construction)
open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)

module _ {ℓ : Level} (k : hSet ℓ) where

  open Construction k

  ----------------------------------------------------------------------
  -- Terminal object: `(Unit , ∅)`.
  --
  -- A morphism `A → ⊤ₚ` is `(f⁺ : A⁺ → Unit , f⁻ : ∅ → A⁻)` — `f⁺` unique
  -- because `Unit` is terminal in Set, `f⁻` unique because `∅` is initial.
  ----------------------------------------------------------------------

  chuTerminal : ChuObj
  chuTerminal =
      (Unit* , isSetUnit*)
    , (⊥* , isProp→isSet isProp⊥*)
    , (λ _ b → rec* b)

  chuTerminalMap : {A : ChuObj} → ChuHom A chuTerminal
  chuTerminalMap = chuHom ((λ _ → tt*) , (λ b → rec* b)) (λ _ b → rec* b)

  chuTerminalUnique : {A : ChuObj} (f : ChuHom A chuTerminal)
                    → f ≡ chuTerminalMap
  chuTerminalUnique f =
    ChuHom≡ (ΣPathP ( funExt (λ a → isPropUnit* (mapPos f a) tt*)
                    , funExt (λ b → rec* b) ))

  ----------------------------------------------------------------------
  -- Binary product: `A & B = (A⁺ × B⁺ , A⁻ ⊎ B⁻)`.
  ----------------------------------------------------------------------

  chuProd : ChuObj → ChuObj → ChuObj
  chuProd A B =
      (⟨ positive A ⟩ × ⟨ positive B ⟩
        , isSet× (str (positive A)) (str (positive B)))
    , (⟨ negative A ⟩ ⊎ ⟨ negative B ⟩
        , isSet⊎ (str (negative A)) (str (negative B)))
    , (λ m → λ { (inl a⁻) → evaluate A (m .fst) a⁻
               ; (inr b⁻) → evaluate B (m .snd) b⁻ })

  -- First projection: `fst` on the positive product, `inl` on the negative
  -- coproduct. Compatibility holds by `refl` — `r_{A&B} (m) (inl a⁻)`
  -- computes to `r_A (m .fst) a⁻`.
  chuπ₁ : {A B : ChuObj} → ChuHom (chuProd A B) A
  chuπ₁ = chuHom (fst , inl) (λ _ _ → refl)

  chuπ₂ : {A B : ChuObj} → ChuHom (chuProd A B) B
  chuπ₂ = chuHom (snd , inr) (λ _ _ → refl)

  -- Pairing: `⟨f⁺,g⁺⟩` on positives, case-split on negatives.
  chuPair : {A B C : ChuObj}
          → ChuHom C A → ChuHom C B → ChuHom C (chuProd A B)
  chuPair f g =
    chuHom
      ( (λ c → (mapPos f c , mapPos g c))
      , (λ { (inl a⁻) → mapNeg f a⁻ ; (inr b⁻) → mapNeg g b⁻ }) )
      (λ c → λ { (inl a⁻) → compat f c a⁻ ; (inr b⁻) → compat g c b⁻ })

  ----------------------------------------------------------------------
  -- Universal property. β by `refl`; η by one coproduct case-split.
  ----------------------------------------------------------------------

  chuβ₁ : {A B C : ChuObj} (f : ChuHom C A) (g : ChuHom C B)
        → chu-seq (chuPair f g) chuπ₁ ≡ f
  chuβ₁ f g = ChuHom≡ refl

  chuβ₂ : {A B C : ChuObj} (f : ChuHom C A) (g : ChuHom C B)
        → chu-seq (chuPair f g) chuπ₂ ≡ g
  chuβ₂ f g = ChuHom≡ refl

  chuη : {A B C : ChuObj} (h : ChuHom C (chuProd A B))
       → chuPair (chu-seq h chuπ₁) (chu-seq h chuπ₂) ≡ h
  chuη h =
    ChuHom≡ (ΣPathP ( refl
                    , funExt (λ { (inl a⁻) → refl ; (inr b⁻) → refl }) ))

  ----------------------------------------------------------------------
  -- Assembly. The field types compose with the applicative `∘` of
  -- `ApplicativeView (Chu-Cat k)` (`g ∘ f = chu-seq f g`); `chuβ`/`chuη`
  -- are stated with `chu-seq` directly, which is that composite.
  ----------------------------------------------------------------------

  Chu-HasFiniteProducts : HasFiniteProducts Chu-Cat
  Chu-HasFiniteProducts = record
    { ⊤ₚ              = chuTerminal
    ; terminal        = chuTerminalMap
    ; terminal-unique = chuTerminalUnique
    ; _&_             = chuProd
    ; π₁              = chuπ₁
    ; π₂              = chuπ₂
    ; ⟨_,_⟩           = chuPair
    ; &-β₁            = chuβ₁
    ; &-β₂            = chuβ₂
    ; &-η             = chuη
    }
