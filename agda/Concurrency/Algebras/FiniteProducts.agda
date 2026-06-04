{-# OPTIONS --cubical --guardedness #-}

-- Finite products over an arbitrary Cubical `Category`.
--
-- Terminal object plus binary product, as a genuine categorical product
-- (projections, pairing, β and η), generic over any `Category C` (via the
-- applicative view in `CategoryApplicative`). It carries no value-category
-- structure beyond the underlying 1-category, so it instantiates at both
-- `StarAutonomous→Category V` — where it is read as the *additive* product
-- `&` / `⊤ₚ` dual to the linear/session structure (the instance-specific
-- motivation the comments below describe) — and at `SET`, where it is the
-- cartesian product `×` / `Unit` (`SetFiniteProducts.agda`).
--
-- This was *milestone 1* of the B-side value-category enrichment that
-- unlocks an honest, non-degenerate descent witness (the event-indexed
-- presheaf, "B2(a)") and, in the same stroke, the empty-cover
-- normalization rung of the sheaf condition. The design call (recorded
-- in the workflow discussion preceding this file) was:
--
--   * **Finite, not indexed.** We add binary product `&` and the
--     terminal object `⊤ₚ`, *not* products indexed by an arbitrary
--     type. Indexed products over an arbitrary `Event` set would force
--     an infinitary `&` constructor into session syntax and demand
--     (near-)completeness of the value category — abandoning the
--     finitely-presented character the whole B-side rests on (finite
--     operads; dessins are finite ribboned combinatorics; the
--     anti-drift invariant in `targets.md`). Finiteness is fidelity,
--     not a compromise: the event-product presheaf will live on the
--     *finite-frame* subsite, with chosen enumeration data per frame.
--
--   * **Separate extension record, not a mutation of
--     `StarAutonomous`.** `StarAutonomous` is consumed by
--     `Valuation.agda`, `OperadAlgebra.agda`, and `Sessions.agda`;
--     adding fields there would ripple through all of them. Instead
--     `HasFiniteProducts V` is an *extension* a value category may or
--     may not carry, exactly as `IsSeparatedPresheaf` is a property a
--     presheaf may or may not carry. The operad/algebra layer stays
--     stable; the new strength is explicit and opt-in.
--
--   * **Only `&` and `⊤ₚ` are primitive; the `⊕` / `0` *objects* are
--     derived.** In a `*`-autonomous category the additive disjunction
--     and its unit are the De Morgan duals of the additive conjunction
--     and its unit: the *object expressions* `A ⊕ B := (A^⊥ & B^⊥)^⊥`
--     and `0 := (⊤ₚ)^⊥` come for free from the involution already in
--     `StarAutonomous`, exactly as the `⅋` / `⊥-par` objects are derived
--     from `⊗` / `𝟙` there. Caveat (Codex): only the *objects* are free;
--     the *coproduct universal property* of `⊕` (injections, copairing,
--     their β/η) would need duality coherence/naturality that the thin
--     `StarAutonomous` deliberately omits. This is not a gap in this
--     file — it uses no coproduct laws — but it means "⊕ for free" is a
--     claim about objects, not about the universal property. (The
--     *concrete* session syntax in `Sessions.agda` is a further matter:
--     because `dual` is defined there by recursion on constructors,
--     instantiating this record at the Sessions target will require all
--     four of `&`, `⊕`, `⊤`, `0` as syntactic constructors with duality
--     clauses. A later milestone, gated here only by the abstract
--     interface.)
--
-- Why the universal property (β + η), not just the objects. The descent
-- proof (milestone 3) reconstructs a global section of a product
-- *component by component* from local sections, with overlap
-- compatibility guaranteeing the per-component choice is well defined.
-- That argument needs:
--   * `&-β` to read back each component of a tupled section, and
--   * `&-η` (uniqueness of the mediating map) to discharge
--     separatedness — two sections into a product agreeing on every
--     projection are equal.
-- So `&` is required to be a genuine categorical product, not merely a
-- bifunctor. The terminal object `⊤ₚ` is the nullary case; it is what
-- lets the empty frame's value be `⊤ₚ`, satisfying the empty-cover
-- normalization `value(∅) ≅ terminal` and so promoting the descent
-- target from "positive (inhabited-cover) descent" to full descent on
-- the finite-frame site.
--
-- The derived `Fin n` product API (`bigProduct`, `bigπ`, `bigTuple`,
-- `bigβ`, `bigη`) is exposed immediately, per Codex's amendment: the
-- descent construction folds a product over a frame's chosen event
-- enumeration `Event ≃ Fin event-count`, and without a ready-made
-- finite-arity product API that fold drowns the proof in associativity
-- transports. We use the *inductive* `Cubical.Data.FinData.Fin` for
-- this API (declared explicitly; renamed `fzero`/`fsuc` to avoid the
-- `Cubical.Data.Nat` `zero`/`suc` clash and to match the project's
-- existing `fzero`/`fsuc` naming) because it pattern-matches cleanly
-- under recursion — the right tool for a fold. Milestone 2's frame
-- enumeration will use this same `FinData.Fin`, which is the chosen,
-- non-truncated enumeration data the construction needs (bare
-- `isFinSet` is `Σ n ∥ Event ≃ Fin n ∥₁` — its enumeration is
-- truncated and unusable for folding).
--
-- Known warning (deliberate, not overlooked). Pattern-matching `bigπ` /
-- `bigβ` on the indexed family `FinData.Fin` raises Cubical Agda's
-- `UnsupportedIndexedMatch` warning: these functions will not *reduce
-- under a transport applied to the index argument* (Agda cannot yet
-- prove injectivity of the `suc` index constructor in cubical mode).
-- This is harmless for the descent construction downstream, by design:
--   * the event-product presheaf uses a *constant* slot `value F =
--     bigProduct (count F) (λ _ → P₀)`, so every projection lands in the
--     same `P₀` and no index-dependent codomain transport ever arises;
--   * functoriality and descent are proved through the *propositional*
--     universal property (`bigβ` / `bigη`) used as equations, never by
--     relying on `bigπ` reducing definitionally under transport.
-- Switching to the Σ-based `Cubical.Data.Fin` would silence the warning
-- but injects index-path `subst`s into `bigπ`'s own definition, trading
-- a benign warning for genuine transport noise; with a constant slot the
-- inductive `FinData.Fin` is strictly cleaner. Revisit only if a future
-- non-constant slot forces index-dependent codomains.
--
-- Scope guardrails:
--   * Generic over any Cubical `Category` `C`; no session syntax, no
--     operad imports, no actor/site imports. This is pure value-category
--     structure. (Originally parameterized over `StarAutonomous`; the
--     record only ever used the underlying 1-category, so it is now over
--     a plain `Category` — the same move as the descent/sheaf framework —
--     which lets it be instantiated at both `StarAutonomous→Category V`
--     (linear V side) and `SET` (cartesian Set side).)
--   * Uses only the underlying category of `C` (`Ob`, `Hom`, `∘`, and
--     associativity, via the applicative view in `CategoryApplicative`).
--     For a linear value category this means it does *not* touch `⊗`,
--     `^⊥`, or any `*`-autonomous field — additive products are
--     orthogonal to the multiplicative structure, and depending only on
--     the bare category makes that orthogonality visible.

module Concurrency.Algebras.FiniteProducts where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Nat using (ℕ ; zero ; suc)
open import Cubical.Data.FinData
  using (Fin) renaming (zero to fzero ; suc to fsuc)

open import Cubical.Categories.Category.Base using (Category)
open import Concurrency.Algebras.CategoryApplicative using (module ApplicativeView)

module _ {ℓ ℓ' : Level} (C : Category ℓ ℓ') where
  open ApplicativeView C

  ----------------------------------------------------------------------
  -- HasFiniteProducts: terminal object + binary product, as a genuine
  -- categorical product (projections, pairing, β and η).
  --
  -- `⊕` and `0` are intentionally absent: they are the duals
  -- `(A^⊥ & B^⊥)^⊥` and `(⊤ₚ)^⊥`, derivable from the involution in
  -- `StarAutonomous`, and are added only where a concrete instance's
  -- syntax forces them.
  ----------------------------------------------------------------------

  record HasFiniteProducts : Type (ℓ-max ℓ ℓ') where
    field
      -- Terminal object (additive ⊤): the nullary product.
      ⊤ₚ              : Ob
      terminal        : {A : Ob} → Hom A ⊤ₚ
      terminal-unique : {A : Ob} (f : Hom A ⊤ₚ) → f ≡ terminal

      -- Binary product (additive &).
      _&_  : Ob → Ob → Ob
      π₁   : {A B : Ob} → Hom (A & B) A
      π₂   : {A B : Ob} → Hom (A & B) B
      ⟨_,_⟩ : {A B C : Ob} → Hom C A → Hom C B → Hom C (A & B)
      &-β₁ : {A B C : Ob} (f : Hom C A) (g : Hom C B)
           → π₁ ∘ ⟨ f , g ⟩ ≡ f
      &-β₂ : {A B C : Ob} (f : Hom C A) (g : Hom C B)
           → π₂ ∘ ⟨ f , g ⟩ ≡ g
      &-η  : {A B C : Ob} (h : Hom C (A & B))
           → ⟨ π₁ ∘ h , π₂ ∘ h ⟩ ≡ h

  --------------------------------------------------------------------
  -- Derived finite-arity product API.
  --
  -- A product of `n` objects indexed by `Fin n`, built by folding the
  -- binary product to the right and capping with `⊤ₚ`:
  --
  --   bigProduct 0       f = ⊤ₚ
  --   bigProduct (suc n) f = f 0 & bigProduct n (f ∘ fsuc)
  --
  -- with component projections `bigπ`, tupling `bigTuple`, and the
  -- finite-arity universal property `bigβ` / `bigη`.
  --------------------------------------------------------------------

  module FiniteProductAPI (FP : HasFiniteProducts) where
    open HasFiniteProducts FP

    bigProduct : (n : ℕ) → (Fin n → Ob) → Ob
    bigProduct zero    f = ⊤ₚ
    bigProduct (suc n) f = f fzero & bigProduct n (λ i → f (fsuc i))

    -- The i-th projection out of the fold.
    bigπ : (n : ℕ) (f : Fin n → Ob) (i : Fin n)
         → Hom (bigProduct n f) (f i)
    bigπ (suc n) f fzero    = π₁
    bigπ (suc n) f (fsuc i) = bigπ n (λ j → f (fsuc j)) i ∘ π₂

    -- Tupling a compatible family of components into the fold.
    bigTuple : (n : ℕ) {C : Ob} (f : Fin n → Ob)
             → ((i : Fin n) → Hom C (f i)) → Hom C (bigProduct n f)
    bigTuple zero    f g = terminal
    bigTuple (suc n) f g =
      ⟨ g fzero , bigTuple n (λ i → f (fsuc i)) (λ i → g (fsuc i)) ⟩

    -- β: the i-th projection of a tuple is the i-th component.
    bigβ : (n : ℕ) {C : Ob} (f : Fin n → Ob)
           (g : (i : Fin n) → Hom C (f i)) (i : Fin n)
         → bigπ n f i ∘ bigTuple n f g ≡ g i
    bigβ (suc n) f g fzero    = &-β₁ _ _
    bigβ (suc n) f g (fsuc i) =
        ∘-assoc (bigπ n (λ j → f (fsuc j)) i) π₂ (bigTuple (suc n) f g)
      ∙ cong (bigπ n (λ j → f (fsuc j)) i ∘_)
             (&-β₂ (g fzero) (bigTuple n (λ j → f (fsuc j)) (λ j → g (fsuc j))))
      ∙ bigβ n (λ j → f (fsuc j)) (λ j → g (fsuc j)) i

    -- η / uniqueness: a map into the fold equals the tuple of its
    -- projections. The separatedness half of descent reads off of this.
    bigη : (n : ℕ) {C : Ob} (f : Fin n → Ob) (h : Hom C (bigProduct n f))
         → bigTuple n f (λ i → bigπ n f i ∘ h) ≡ h
    bigη zero    f h = sym (terminal-unique h)
    bigη (suc n) f h =
      cong (λ z → ⟨ π₁ ∘ h , z ⟩) second ∙ &-η h
      where
        -- The tail tuple reassembles `π₂ ∘ h`, after re-associating
        -- each component `(bigπ … i ∘ π₂) ∘ h` to `bigπ … i ∘ (π₂ ∘ h)`.
        second :
          bigTuple n (λ i → f (fsuc i))
            (λ i → bigπ (suc n) f (fsuc i) ∘ h)
          ≡ π₂ ∘ h
        second =
            cong (bigTuple n (λ i → f (fsuc i)))
                 (funExt (λ i →
                    ∘-assoc (bigπ n (λ j → f (fsuc j)) i) π₂ h))
          ∙ bigη n (λ i → f (fsuc i)) (π₂ ∘ h)

    -- Joint monicity: a map into a finite product is determined by its
    -- projections. This is the product-level separatedness the descent
    -- uniqueness half reads off — two sections of a product agreeing on
    -- every component are equal.
    bigProduct-ext : (n : ℕ) {C : Ob} (f : Fin n → Ob)
                     (m m' : Hom C (bigProduct n f))
                   → ((i : Fin n) → bigπ n f i ∘ m ≡ bigπ n f i ∘ m')
                   → m ≡ m'
    bigProduct-ext n f m m' h =
        sym (bigη n f m) ∙ cong (bigTuple n f) (funExt h) ∙ bigη n f m'
