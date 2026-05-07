{-# OPTIONS --cubical --guardedness #-}

-- Analytic adjunctions ♭ ⊣ ♯ and ʃ ⊣ ♭ for ℤ and Bℤ.
--
-- Scope and purpose
-- -----------------
-- The synthetic Adjunctions.agda postulates the adjunctions as hom-set
-- equivalences valid for all types. This file asks: for which concrete
-- types can we verify those equivalences without postulates?
--
-- The honest answer is: only for discrete types (ℤ), where all three
-- modalities are the identity and both adjunctions collapse to the
-- reflexivity of function types. For Bℤ, the type-level adjunction is
-- not verifiable in plain cubical Agda — this is a structural limitation
-- of the setting, not a gap to be filled later.
--
-- The key informative result about Bℤ lives in Cohesion.agda:
-- ¬-IsFlatModal-delooping. That is the genuine analytic content — a
-- machine-checked proof that ♭ draws a real distinction. The present
-- file records why the adjunction itself cannot be tested here, and
-- what a correct test would require.
--
-- Why the type-level adjunction cannot be tested for Bℤ
-- ------------------------------------------------------
-- The adjunction ʃ ⊣ ♭ says: (ʃA → B) ≃ (A → ♭B) as types.
-- For (A, B) = (Bℤ, Bℤ), with ʃBℤ = Bℤ and ♭Bℤ = ℤ:
--
--   (Bℤ → Bℤ) ≃? (Bℤ → ℤ)
--
-- The left side computes via the recursion principle of the HIT:
--   (Bℤ → Bℤ) ≃ Σ[ x ∈ Bℤ ] (x ≡ x)    (free loop space ΛBℤ)
--             ≃ Bℤ × ℤ                    (loop-space-equiv + connectedness)
--
-- The right side:
--   (Bℤ → ℤ)  ≃ ℤ  (maps into a set determined by image of base-pt;
--                    translation-step maps to refl since ℤ is a set)
--
-- Bℤ × ℤ ≇ ℤ: the left side has non-trivial homotopy (it is not a set),
-- the right side is discrete. The equivalence fails.
--
-- Note: ‖Bℤ → Bℤ‖₀ ≃ ℤ ≃ ‖Bℤ → ℤ‖₀ (both sides truncate to ℤ), but
-- this is a coincidence — two separate computations sharing a common
-- target — not a manifestation of the adjunction. No natural bijection
-- arising from an adjunction transpose connects the two sides; the
-- bijection on each side uses entirely different data.
--
-- What would the correct ♭(Bℤ) be?
-- ---------------------------------
-- In Sh(Bℤ) — the ∞-topos of spaces with ℤ-action — the flat modality is
-- ♭(X, σ) = (X^{hℤ}, trivial), where X^{hℤ} denotes homotopy fixed points.
-- For (Bℤ, trivial action):
--
--   ♭(Bℤ, trivial) = (Map(Bℤ, Bℤ), trivial) ≃ (Bℤ × ℤ, trivial)
--
-- With this definition, the adjunction holds by currying:
--   Hom((Bℤ × Bℤ, trivial), (Bℤ, trivial))
--     ≃ Hom((Bℤ, trivial), (Map(Bℤ, Bℤ), trivial))
-- No theorem is needed — it is pure abstract nonsense in the right category.
--
-- Our analytic Cohesion.agda chose ♭(Bℤ) = ℤ (the fiber of the universal
-- cover at base-pt, i.e., the loop space Ω(Bℤ)). This is geometrically
-- motivated and gives the correct non-flat-modality result, but it is not
-- the flat modality of any model in which the adjunction holds. The two
-- choices — ♭Bℤ = ℤ (ours) and ♭Bℤ = Map(Bℤ, Bℤ) (Sh(Bℤ) model) —
-- serve different purposes: ours isolates ¬IsFlatModal cleanly; the
-- model-correct one satisfies the adjunction but requires ∞-topos
-- infrastructure to work with.
--
-- The intended path: crisp cohesive type theory (future work)
-- ------------------------------------------------------------
-- The correct analytic test is a proof assistant implementing crisp
-- cohesive type theory (Shulman 2018, Myers' modal cubical TT). In such
-- a system, the adjunction holds by the rules of the type theory: ♭ is
-- a structural modality, flat-intro is derivable for crisp variables, and
-- (ʃA → B) ≃ (A → ♭B) is built into the modal rules of the type theory. No external model is needed; the adjunction and
-- the correct ♭(Bℤ) = ℤ (in the crisp sense) are both derivable.
--
-- This is explicitly left as future work. No mature proof assistant
-- currently supports all three modalities with full crisp contexts.
-- Agda's experimental --cohesion flag covers ♭ partially; ʃ and ♯ are
-- not yet supported anywhere. When tooling matures, this file is where
-- the crisp implementation belongs.
--
-- The alternative — an explicit Sh(Bℤ) formalization with types as
-- ℤ-spaces and modalities as homotopy fixed/coinvariants — is not
-- pursued here. It would verify the adjunction by currying in the
-- correct model, but at PhD-scale infrastructure cost and misaligned
-- with both the crisp-context design goal and the analytic folder's
-- role as a lightweight test suite.
--
-- No postulates are used in this file.

module Analytic.ModalHoTT.Modalities.Adjunctions where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv

open import Analytic.ModalHoTT.Modalities.Cohesion

private
  variable
    ℓ : Level

------------------------------------------------------------------------
-- Adjunctions for ℤ
--
-- Both ♭ ⊣ ♯ and ʃ ⊣ ♭ are trivial: FlatOfIntegers = ShapeOfIntegers =
-- SharpOfIntegers = ℤ, so both adjunctions reduce to (ℤ → B) ≃ (ℤ → B).
-- The equivalence is idEquiv in both cases; no content.
--
-- Included for structural completeness and to confirm the recursion
-- principle: modality triviality on ℤ means every synthetic adjunction
-- postulate is witnessed here by reflexivity.
------------------------------------------------------------------------

-- trivial code to be added

------------------------------------------------------------------------
-- Adjunctions for Bℤ — ʃ ⊣ ♭
--
-- The type-level adjunction (Bℤ → Bℤ) ≃ (Bℤ → ℤ) fails; see module
-- comment for the computation and the structural reason.
--
-- What loop-space-equiv does establish here is a component of the
-- failure diagnosis: it witnesses (Bℤ → Bℤ) ≃ Bℤ × ℤ (via the free
-- loop space), which is the explicit obstruction to the adjunction.
-- That computation belongs here as a named lemma when the trivial
-- code section is filled in, since it records precisely where and why
-- the adjunction breaks.
------------------------------------------------------------------------

-- trivial code to be added

------------------------------------------------------------------------
-- Adjunctions for Bℤ — ♭ ⊣ ♯
--
-- Deferred: SharpOfDeloopingOfIntegers is not defined in Cohesion.agda
-- (no cubical construction for the codiscrete reflection of Bℤ).
-- This adjunction for Bℤ remains out of scope for the same reason as
-- the sharp instance in Cohesion.agda.
------------------------------------------------------------------------
