{-# OPTIONS --cubical --guardedness #-}

-- The event-product presheaf: a genuinely frame-varying sheaf-candidate
-- over the finite-frame subsite. Milestone 2 of the value-category
-- enrichment program (milestone 1: `Concurrency/Algebras/FiniteProducts.agda`;
-- subsite objects: `Concurrency/Sites/FiniteFrame.agda`).
--
-- What this is. For a fixed "slot" object `P₀` of a value category `V`
-- carrying finite products, the event-product presheaf sends a finite
-- frame `F` to the product of one `P₀` per event of `F`:
--
--   value F = P₀ ^ (event-count F)   (= bigProduct (event-count F) (λ _ → P₀))
--
-- and sends a sub-view embedding `G ↪ F` (contravariantly) to the
-- reindexing morphism `value F → value G` that projects onto the events
-- of `F` named by `G`'s events. This is the relative point of view made
-- concrete: unlike the constant presheaf (which ignores the frame),
-- `value` here varies with the frame — its *arity* tracks the event
-- count — so amalgamation will do real, locality-sensitive gluing
-- (milestone 3).
--
-- Why this dodges the projection/weakening problem. A contravariant
-- restriction along a sub-view *drops* the events of `F` not present in
-- `G` — that is weakening, which the multiplicative (`⊗`) structure
-- forbids. The fix is to value events in the *additive* product `&`
-- (with projections), supplied by `HasFiniteProducts`. So `restrict` is
-- a tuple of projections, built with `bigTuple` / `bigπ`, not a tensor
-- manipulation.
--
-- Why functoriality goes through the universal property. `restrict`
-- reindexes along the event-map of a `FrameHom`, transported across the
-- chosen enumerations `Event ≃ Fin event-count`. Those enumerations
-- involve `equivFun` / `invEq`, so the reindexing maps compose only *up
-- to* the equivalence coherences (`secEq`, `retEq`). We therefore prove
-- `restrict-id` and `restrict-comp` through the product's universal
-- property (`bigβ` for projecting a tuple, `bigProduct-ext` for joint
-- monicity), never by definitional reduction of `bigπ` under a
-- transported index. The *constant slot* `λ _ → P₀` is what makes this
-- clean: every projection `bigπ (count F) (λ _ → P₀) i` lands in the
-- same `P₀`, so rewriting an index along an enumeration path is a plain
-- `cong` in a fixed `Hom`-type — no `PathP` over a varying codomain.
-- This is exactly the regime in which the `UnsupportedIndexedMatch`
-- warning on the product API is harmless (documented there).
--
-- v1 scope (decisions recorded in the workflow discussion):
--   * **Constant slot `P₀`.** The value is still frame-varying because
--     the product *arity* changes with the event set; an
--     event-dependent slot is deferred (it would reintroduce
--     index-dependent codomains and real transport burden).
--   * **Events only.** `value` reads only the event set (via the chosen
--     enumeration) and its injections under sub-views. Causal order and
--     actor incidence are *not* reflected in the value at v1; flagged
--     for a later enrichment.
--   * **Finite-frame subsite, not all frames.** This is a
--     `FiniteFramePresheaf`, a functor on `FiniteFrame`s, not an
--     inhabitant of the all-frames `FramePresheaf` from
--     `Concurrency/Hybrid/Presheaf.agda`. "Full descent" downstream
--     means full descent *for this finite-frame site*.
--   * **Explicit frame arguments on `restrict`.** A morphism of finite
--     frames is a `FrameHom` between underlying frames; since
--     `FiniteFrame.frame` is not injective for unification, the two
--     finite frames are passed explicitly (unlike the implicit style of
--     `Presheaf.agda`'s `FramePresheaf`).
--
-- Scope guardrails: generic over any Cubical `Category C` with
-- `HasFiniteProducts C`; no value-category structure beyond the
-- underlying 1-category plus finite products, no session syntax, no
-- operad imports. Instantiated at `StarAutonomous→Category V` (linear V
-- side, `SessionEventProductSheaf.agda`) and `SET` (cartesian Set side,
-- `SetEventProductSheaf.agda`).

module Concurrency.Hybrid.EventProductPresheaf where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv
  using ( equivFun ; invEq ; secEq ; retEq )
open import Cubical.Data.Nat using (ℕ)
open import Cubical.Data.FinData using (Fin)

open import Cubical.Categories.Category.Base using (Category)
open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal
  using ( LocalFrame ; FrameHom ; frame-id ; _∘ᶠ_ )
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Algebras.CategoryApplicative using (module ApplicativeView)
open import Concurrency.Algebras.FiniteProducts
  using ( HasFiniteProducts ; module FiniteProductAPI )
open import Concurrency.Hybrid.FinitePresheaf using (FiniteFramePresheaf)

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓV ℓH : Level} (C : Category ℓV ℓH) where

  open ApplicativeView C
  open FiniteFramePresheaf

  --------------------------------------------------------------------
  -- The event-product witness, for a value category `C` with finite
  -- products and a chosen slot object `P₀`. Generic over any Cubical
  -- `Category` with `HasFiniteProducts`, exactly like the descent /
  -- sheaf-category framework: leg 1 feeds `C := StarAutonomous→Category
  -- V` (with `V`'s additive products), leg 2 feeds `C := SET` (with the
  -- cartesian products of sets). Every operation below is `C`'s own,
  -- via the applicative view and the finite-product API.
  --------------------------------------------------------------------

  module _ (FP : HasFiniteProducts C) {ℓE ℓR : Level} (P₀ : Ob) where

    open FiniteProductAPI C FP

    private
      cnt : FiniteFrame AB ℓE ℓR → ℕ
      cnt F = FiniteFrame.event-count F

      -- The constant-slot value: one `P₀` per event of the frame.
      val : FiniteFrame AB ℓE ℓR → Ob
      val F = bigProduct (cnt F) (λ _ → P₀)

      -- Reindex a `G`-event-index to the `F`-event-index it embeds to,
      -- transported across the two chosen enumerations.
      reindex : (F G : FiniteFrame AB ℓE ℓR)
              → FrameHom AB (FiniteFrame.frame G) (FiniteFrame.frame F)
              → Fin (cnt G) → Fin (cnt F)
      reindex F G φ j =
        equivFun (FiniteFrame.enum F)
          (FrameHom.event-map φ (invEq (FiniteFrame.enum G) j))

      -- Restriction: the `G`-product's j-th component is the
      -- `F`-product's projection at the reindexed position.
      res : (F G : FiniteFrame AB ℓE ℓR)
          → FrameHom AB (FiniteFrame.frame G) (FiniteFrame.frame F)
          → Hom (val F) (val G)
      res F G φ =
        bigTuple (cnt G) (λ _ → P₀)
          (λ j → bigπ (cnt F) (λ _ → P₀) (reindex F G φ j))

      -- Functoriality, unit. `reindex` of the identity is the identity
      -- on indices (by `secEq` of the enumeration), so the tuple of
      -- projections is `id` (by `bigη`).
      res-id : (F : FiniteFrame AB ℓE ℓR)
             → res F F (frame-id AB (FiniteFrame.frame F)) ≡ id
      res-id F =
          cong (bigTuple (cnt F) (λ _ → P₀))
               (funExt (λ j →
                  cong (bigπ (cnt F) (λ _ → P₀)) (secEq (FiniteFrame.enum F) j)))
        ∙ cong (bigTuple (cnt F) (λ _ → P₀))
               (funExt (λ j → sym (id-r (bigπ (cnt F) (λ _ → P₀) j))))
        ∙ bigη (cnt F) (λ _ → P₀) id

      -- Functoriality, composition (contravariant). Proved by joint
      -- monicity of the product: both sides agree after every
      -- projection. The per-index agreement reduces, via `bigβ`, to
      -- `reindex (ψ ∘ φ) k ≡ reindex ψ (reindex φ k)`, which holds by
      -- `retEq` of the middle enumeration.
      res-comp : (F G H : FiniteFrame AB ℓE ℓR)
                 (ψ : FrameHom AB (FiniteFrame.frame G) (FiniteFrame.frame H))
                 (φ : FrameHom AB (FiniteFrame.frame F) (FiniteFrame.frame G))
               → res H F (_∘ᶠ_ AB ψ φ) ≡ res G F φ ∘ res H G ψ
      res-comp F G H ψ φ =
        bigProduct-ext (cnt F) (λ _ → P₀)
          (res H F (_∘ᶠ_ AB ψ φ))
          (res G F φ ∘ res H G ψ)
          per-k
        where
          per-k : (k : Fin (cnt F))
                → bigπ (cnt F) (λ _ → P₀) k ∘ res H F (_∘ᶠ_ AB ψ φ)
                  ≡ bigπ (cnt F) (λ _ → P₀) k ∘ (res G F φ ∘ res H G ψ)
          per-k k =
              bigβ (cnt F) (λ _ → P₀)
                   (λ j → bigπ (cnt H) (λ _ → P₀) (reindex H F (_∘ᶠ_ AB ψ φ) j)) k
            ∙ cong (bigπ (cnt H) (λ _ → P₀)) q
            ∙ sym rhs
            where
              x : LocalFrame.Event (FiniteFrame.frame G)
              x = FrameHom.event-map φ (invEq (FiniteFrame.enum F) k)

              q : reindex H F (_∘ᶠ_ AB ψ φ) k
                ≡ reindex H G ψ (reindex G F φ k)
              q = sym (cong (λ y →
                              equivFun (FiniteFrame.enum H)
                                       (FrameHom.event-map ψ y))
                            (retEq (FiniteFrame.enum G) x))

              rhs : bigπ (cnt F) (λ _ → P₀) k ∘ (res G F φ ∘ res H G ψ)
                  ≡ bigπ (cnt H) (λ _ → P₀) (reindex H G ψ (reindex G F φ k))
              rhs =
                  sym (∘-assoc (bigπ (cnt F) (λ _ → P₀) k)
                               (res G F φ) (res H G ψ))
                ∙ cong (_∘ res H G ψ)
                       (bigβ (cnt F) (λ _ → P₀)
                             (λ j → bigπ (cnt G) (λ _ → P₀) (reindex G F φ j)) k)
                ∙ bigβ (cnt G) (λ _ → P₀)
                       (λ j → bigπ (cnt H) (λ _ → P₀) (reindex H G ψ j))
                       (reindex G F φ k)

    -- The witness.
    event-product-presheaf : FiniteFramePresheaf AB C {ℓE} {ℓR}
    event-product-presheaf = record
      { value         = val
      ; restrict      = res
      ; restrict-id   = res-id
      ; restrict-comp = res-comp
      }
