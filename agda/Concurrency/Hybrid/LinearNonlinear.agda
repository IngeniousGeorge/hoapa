{-# OPTIONS --cubical --guardedness #-}

-- The value-level Benton / Linear-Non-Linear adapter — R4's interface,
-- interface-first.
--
-- R4 is the B-internal cartesian↔linear bridge between the two finite
-- sheaf endpoints `Sh_fin(site, Set)` (cartesian/locality) and
-- `Sh_fin(site, V)` (linear/session). The Grothendieckian reading we
-- committed to: R4 is *change of base along a value-level adjunction*
-- `Cart ⇄ V`, lifted to the sheaf categories. This module states that
-- value-level adjunction; `ChangeOfBase.agda` is the lifting engine;
-- `R4Adapter.agda` assembles them and sorts what survives to the sheaf
-- level (G yes, F only via sheafification / a named obligation).
--
-- *Interface-first, deliberately.* `Cart` is an abstract cartesian value
-- category (`HasFiniteProducts`), instantiated at Cubical `SET` later;
-- `V` is any `StarAutonomous`, instantiated at `Sessions-Cat` later. The
-- record's fields are *consumed by a generic proof*: `R4Adapter`'s Tier 2
-- `G-preserves-sheaf` uses the adjunction `F⊣G`'s natural bijection
-- (`adjIso` / `adjNatInD` / `adjNatInD'`) to transport descent — which is
-- what keeps this a Grothendieckian "abstract structure first, instances
-- later" interface rather than a bag of labels. (`mon-unit` / `mon-bin`
-- are not yet consumed; they will be by the sheaf-level monoidal /
-- field-theory work downstream.) A non-vacuity witness — the terminal
-- `StarAutonomous`, showing the record is inhabitable — is a planned
-- follow-up, not yet in this file.
--
-- Benton, not Seely or Chu (decision this session). Benton is the
-- relationship shape R4 needs (two categories + a monoidal adjunction,
-- with `!` derived as `F∘G`); it also rehearses the cross-site
-- `Allow ⊣ Require` shape one level down. Chu is deferred to where its
-- intrinsic process/context duality is load-bearing (the Λ content layer
-- / the deeper form of `V`), not R4. See `future_work.md`.
--
-- Coherence deferred (thin-signature discipline, like `StarAutonomous`).
-- The strong-monoidal structure of `F` is recorded as the two comparison
-- isos (unit and binary); naturality, the pentagon/hexagon/unit
-- coherence, and lax/oplax compatibility are *not* unpacked. Add fields
-- when a downstream proof needs them.

module Concurrency.Hybrid.LinearNonlinear where

open import Cubical.Foundations.Prelude

open import Cubical.Categories.Category.Base using (Category ; CatIso)
open import Cubical.Categories.Functor.Base using (Functor)
open import Cubical.Categories.Adjoint using (module NaturalBijection)

open import Concurrency.Algebras.StarAutonomous using (StarAutonomous)
open import Concurrency.Algebras.StarAutonomousCategory using (StarAutonomous→Category)
open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)

open NaturalBijection using (_⊣_)

module _ {ℓc ℓc' ℓv ℓv' : Level}
         (Cart : Category ℓc ℓc') (cartProd : HasFiniteProducts Cart)
         (V : StarAutonomous ℓv ℓv') where

  private
    Vcat : Category ℓv ℓv'
    Vcat = StarAutonomous→Category V

  open StarAutonomous V using (𝟙 ; _⊗_ ; ⊥-par)
  open HasFiniteProducts cartProd using (⊤ₚ ; _&_)

  ----------------------------------------------------------------------
  -- The value-level Benton/LNL adjunction.
  --
  -- `F` is the free (left) functor, `G` the underlying-object (right)
  -- functor; `F ⊣ G` as a natural bijection (its `adjIso` /
  -- `adjNatInD/C` are what the right-adjoint sheaf-preservation proof
  -- consumes). `F` is strong monoidal — comparisons recorded, coherence
  -- deferred. `!` is *named*, not built, as the comonad `F∘G`.
  ----------------------------------------------------------------------

  record LNLAdjunction : Type (ℓ-max (ℓ-max ℓc ℓc') (ℓ-max ℓv ℓv')) where
    field
      -- (1) the two functors + the adjunction.
      F   : Functor Cart Vcat
      G   : Functor Vcat Cart
      F⊣G : F ⊣ G

      -- (3) 𝟙ₛ vs ⊥ₛ: `F` strong-monoidal comparisons only — `F(⊤) ≅ 𝟙`
      -- (unit) and `F(A & B) ≅ F A ⊗ F B` (binary). NO `𝟙 → ⊥-par` mix
      -- map is introduced; `⊥-par` stays reachable only via `_^⊥`. (A
      -- mix map would be a *declared feature* — a separate `MixMap`
      -- record `Hom 𝟙 ⊥-par` with its laws — not smuggled in here.)
      mon-unit :
        CatIso Vcat (Functor.F-ob F ⊤ₚ) 𝟙
      mon-bin :
        (A B : Category.ob Cart)
        → CatIso Vcat (Functor.F-ob F (A & B))
                      (Functor.F-ob F A ⊗ Functor.F-ob F B)

    ------------------------------------------------------------------
    -- (4) The linear exponential, NAMED as `F∘G`, not assumed.
    --
    -- `!` is the comonad `F∘G` on `V`: its counit is `F⊣G`'s `ε`
    -- (`F (G A) → A`), its comultiplication comes from `F⊣G`'s `η`. The
    -- comonad laws are *deferred* — only the object map is named here,
    -- so nothing about `!` is postulated.
    ------------------------------------------------------------------

    !-ob : Category.ob Vcat → Category.ob Vcat
    !-ob A = Functor.F-ob F (Functor.F-ob G A)

  ----------------------------------------------------------------------
  -- (2) No-leak / erasure. Stated explicitly, split into the two halves
  -- Codex distinguished:
  --
  --   * Structural (PROVED, elsewhere): change of base touches only the
  --     value category — the `FiniteFrame` index, `FrameHom`, and covers
  --     are untouched. This is `ChangeOfBase.frame-noninterference`,
  --     which holds for *any* value functor (so for `F` and `G`). It is
  --     not restated here; it is cited.
  --
  --   * Semantic (NAMED, not proved by functoriality): session
  --     roles/payloads/content do not refine actor identity. At the
  --     value level this is the interpretive reading of `G` as a genuine
  --     "underlying object" forgetting linear/session structure; it is a
  --     law the framework asserts, not a consequence of `G` being a
  --     functor. It becomes formally checkable only against the actor
  --     site (a later layer), so it is documented here, not yet named as
  --     an Agda type or field of this value-level record.
  ----------------------------------------------------------------------
