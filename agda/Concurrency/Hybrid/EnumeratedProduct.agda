{-# OPTIONS --cubical --guardedness #-}

-- A finite product indexed by a *type* `T` carrying a chosen enumeration
-- `enum : T ≃ Fin n`, valued in an arbitrary `Category` with finite
-- products.
--
-- Why this module exists (Codex's "variable finite-product wrapper").
-- The constant-slot event product (`EventProductPresheaf.agda`) stays in
-- the regime where every projection lands in the same object, so the
-- enumeration round-trips never touch a codomain. A *variable*-slot
-- product — `∏_{e} P(pt_e)` for the sheafification reflector — leaves
-- that regime: the slot depends on the index, so relating the
-- `Fin n`-indexed projection to the `T`-indexed one passes through the
-- equivalence `enum`. This module pays that cost *once*, exposing a clean
-- `T`-indexed API (`projE`, `tupleE`, `βE`, `ηE`, `extE`). The single
-- non-trivial lemma is `projE-fin`; its only coherence (two paths in `T`
-- agreeing) is free because `T ≃ Fin n` makes `T` a set.
--
-- Spike scope: `T : Type` (universe 0). For the actor-causal point
-- reflector the indexing type is a frame's event set, which is `Type₀` in
-- the spike; lifting to higher event universes is a later, orthogonal
-- concern.

module Concurrency.Hybrid.EnumeratedProduct where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv
  using (_≃_ ; equivFun ; invEq ; retEq ; secEq ; invEquiv)
open import Cubical.Foundations.HLevels using (isOfHLevelRespectEquiv)
open import Cubical.Foundations.Transport using (substCommSlice)
open import Cubical.Data.Nat using (ℕ)
open import Cubical.Data.FinData using (Fin)
open import Cubical.Data.FinData.Properties using (isSetFin)

open import Cubical.Categories.Category.Base using (Category)
open import Concurrency.Algebras.CategoryApplicative using (module ApplicativeView)
open import Concurrency.Algebras.FiniteProducts
  using (HasFiniteProducts ; module FiniteProductAPI)

module _ {ℓ ℓ' : Level} (C : Category ℓ ℓ') (FP : HasFiniteProducts C) where
  open ApplicativeView C
  open FiniteProductAPI C FP

  -- The enumerated product, its projection, and its tupling.
  ∏E : (n : ℕ) (T : Type) (enum : T ≃ Fin n) (slot : T → Ob) → Ob
  ∏E n T enum slot = bigProduct n (λ i → slot (invEq enum i))

  projE : (n : ℕ) (T : Type) (enum : T ≃ Fin n) (slot : T → Ob) (t : T)
        → Hom (∏E n T enum slot) (slot t)
  projE n T enum slot t =
    subst (λ t' → Hom (∏E n T enum slot) (slot t'))
          (retEq enum t)
          (bigπ n (λ i → slot (invEq enum i)) (equivFun enum t))

  tupleE : (n : ℕ) (T : Type) (enum : T ≃ Fin n) (slot : T → Ob) {X : Ob}
         → ((t : T) → Hom X (slot t)) → Hom X (∏E n T enum slot)
  tupleE n T enum slot g = bigTuple n (λ i → slot (invEq enum i)) (λ i → g (invEq enum i))

  --------------------------------------------------------------------
  -- The single coherence lemma: the T-projection at `invEq enum i` is
  -- the underlying Fin-projection at `i`. The path-coherence it needs is
  -- free because `T` is a set (`enum : T ≃ Fin n`).
  --------------------------------------------------------------------

  projE-fin : (n : ℕ) (T : Type) (enum : T ≃ Fin n) (slot : T → Ob) (i : Fin n)
            → projE n T enum slot (invEq enum i)
              ≡ bigπ n (λ k → slot (invEq enum k)) i
  projE-fin n T enum slot i =
      cong (λ p → subst (λ t' → Hom (∏E n T enum slot) (slot t')) p
                        (bigπ n fs (equivFun enum (invEq enum i))))
           coh
    ∙ fromPathP (λ k → bigπ n fs (secEq enum i k))
    where
      fs : Fin n → Ob
      fs k = slot (invEq enum k)

      isSetT : isSet T
      isSetT = isOfHLevelRespectEquiv 2 (invEquiv enum) isSetFin

      -- Two paths in `T` between the same endpoints; equal since `T` is a set.
      coh : retEq enum (invEq enum i) ≡ cong (invEq enum) (secEq enum i)
      coh = isSetT _ _ _ _

  --------------------------------------------------------------------
  -- β: projection of a tuple is the component.
  --------------------------------------------------------------------

  βE : (n : ℕ) (T : Type) (enum : T ≃ Fin n) (slot : T → Ob) {X : Ob}
       (g : (t : T) → Hom X (slot t)) (t : T)
     → projE n T enum slot t ∘ tupleE n T enum slot g ≡ g t
  βE n T enum slot {X} g t =
      sym (substCommSlice (λ t' → Hom (∏E n T enum slot) (slot t'))
                          (λ t' → Hom X (slot t'))
                          (λ _ h → h ∘ tupleE n T enum slot g)
                          (retEq enum t)
                          (bigπ n fs (equivFun enum t)))
    ∙ cong (subst (λ t' → Hom X (slot t')) (retEq enum t))
           (bigβ n fs (λ i → g (invEq enum i)) (equivFun enum t))
    ∙ fromPathP (λ k → g (retEq enum t k))
    where
      fs : Fin n → Ob
      fs k = slot (invEq enum k)

  --------------------------------------------------------------------
  -- η and joint monicity, from projE-fin + the bigProduct laws.
  --------------------------------------------------------------------

  ηE : (n : ℕ) (T : Type) (enum : T ≃ Fin n) (slot : T → Ob) {X : Ob}
       (h : Hom X (∏E n T enum slot))
     → tupleE n T enum slot (λ t → projE n T enum slot t ∘ h) ≡ h
  ηE n T enum slot {X} h =
      cong (bigTuple n (λ i → slot (invEq enum i)))
           (funExt (λ i → cong (_∘ h) (projE-fin n T enum slot i)))
    ∙ bigη n (λ i → slot (invEq enum i)) h

  extE : (n : ℕ) (T : Type) (enum : T ≃ Fin n) (slot : T → Ob) {X : Ob}
         (m m' : Hom X (∏E n T enum slot))
       → ((t : T) → projE n T enum slot t ∘ m ≡ projE n T enum slot t ∘ m')
       → m ≡ m'
  extE n T enum slot m m' hyp =
    bigProduct-ext n (λ i → slot (invEq enum i)) m m'
      (λ i → sym (cong (_∘ m)  (projE-fin n T enum slot i))
           ∙ hyp (invEq enum i)
           ∙ cong (_∘ m') (projE-fin n T enum slot i))
