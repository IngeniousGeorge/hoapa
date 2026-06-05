{-# OPTIONS --cubical --guardedness #-}

-- C6: the project's finite-descent sheaf condition at SET and the Cubical
-- library's element-based sheaf condition for the generated
-- `FiniteFrameCoverage` imply each other.
--
-- This is the flotation test for the whole site-axis sequence: with the
-- coverage (C9) and the basis adapter (C8) at the right generality, the
-- comparison floats up from general principles rather than being a fresh
-- hard proof. It splits cleanly along the UP / SET-specific line.
--
-- Forward (`project-sheaf→library-sheaf`, finiteness-free, **no UP**). For
-- a `FiniteCover c` over `F` (forgotten to the library cover
-- `basis→Cover (finiteCover→basis c)`), `elementToCompatibleFamily` is an
-- equivalence: its inverse is project amalgamation, with the library's
-- all-cones compatibility *specialized* to the one chosen overlap-frame
-- cone `(pb-π₁ , pb-π₂)` whose commuting witness is `pb-square`; the
-- round-trips are project amalgamation + separatedness at the terminal
-- probe `⊤ = Unit*`. Lifted to the actual coverage by `basis→finiteCover`
-- (`project-IsSheaf→library-isSheaf`).
--
-- Reverse (`library-isSheaf→project-IsSheaf`, option C, two pieces):
--   * Lemma A `overlapCompat→libCompat` — the UP heart: project
--     overlap-compatibility ⟹ library all-cones compatibility. The *only*
--     place the pullback universal property enters; any cone factors
--     through the overlap via `mediating`, carried by `restrict-comp`.
--   * reverse-at-⊤ (`amalg⊤` / `sep⊤`): the library equivalence gives
--     descent at `⊤`, via Lemma A + the equiv's inverse / embedding.
--   * SET well-pointedness (`amalg-wellpointed` / `sep-wellpointed`):
--     terminal-probe descent lifts to all probes, pointwise by funExt.
--     UP-free; the isolated SET-specific fact.
--
-- The agreement `project-IsSheaf↔library-isSheaf` packages both directions
-- (a bi-implication, not an equivalence: the library side is a
-- proposition, the project `IsSheaf` record is not obviously one).
--
-- Scope guardrails: a theorem about a `FiniteFramePresheaf AB (SET ℓ)` and
-- its `presheaf→Functor`, against `FiniteFrameCoverage`. It does not
-- replace `SetFiniteSheafCategory` or build a new sheaf category.

module Concurrency.Hybrid.SetSheafComparison where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Structure using (⟨_⟩)
open import Cubical.Foundations.Isomorphism using (Iso ; iso ; isoToIsEquiv)
open import Cubical.Foundations.Equiv using (invIsEq ; secIsEq)
open import Cubical.Functions.Embedding using (isEmbedding→Inj ; isEquiv→isEmbedding)
open import Cubical.Data.Sigma using (_,_ ; _×_ ; fst ; snd)
open import Cubical.Data.Unit using (Unit* ; tt*)
open import Cubical.Data.Unit.Properties using (isSetUnit* ; isPropUnit*)

open import Cubical.Categories.Category.Base using (Category)
open import Cubical.Categories.Functor.Base using (Functor)
open import Cubical.Categories.Instances.Sets using (SET)
open import Cubical.Categories.Site.Sheaf
  using ( hasAmalgamationPropertyForCover ; elementToCompatibleFamily
        ; CompatibleFamily ; CompatibleFamily≡ ; isSheaf
        ; isCompatibleFamily ; FamilyOnCover )

open import Concurrency.Algebras.CategoryApplicative using (module ApplicativeView)
open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorPullback using (pb-π₁ ; pb-π₂ ; pb-square)
open import Concurrency.Sites.FramePullbackUniversal
  using (mediating ; mediating-π₁ ; mediating-π₂)
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Sites.FiniteCover using (FiniteCover)
open import Concurrency.Sites.FiniteBasisCover
  using (finiteCover→basis ; basis→finiteCover ; basis→Cover)
open import Concurrency.Sites.FiniteFrameCoverage using (FiniteFrameCoverage)
open import Concurrency.Hybrid.FinitePresheaf using (FiniteFramePresheaf)
open import Concurrency.Hybrid.FiniteFramePresheafFunctor using (presheaf→Functor)
open import Concurrency.Hybrid.FiniteDescent
  using (IsSheaf ; MatchingFamily ; HasAmalgamation ; IsSeparated)

module _ {ℓA : Level} (AB : ActorBase ℓA) (ℓ : Level)
         {ℓE ℓR ℓI : Level} (Pp : FiniteFramePresheaf AB (SET ℓ) {ℓE} {ℓR}) where

  private
    C = SET ℓ
    open ApplicativeView C
    open FiniteFramePresheaf Pp
    Pfun = presheaf→Functor AB C Pp

    -- The terminal SET probe; its elements are the global sections.
    ⊤S : Ob
    ⊤S = Unit* , isSetUnit*

  module _ {F : FiniteFrame AB ℓE ℓR} (c : FiniteCover AB ℓI F) where

    private
      libcov = basis→Cover AB F (finiteCover→basis AB c)

    --------------------------------------------------------------------
    -- Forward: project IsSheaf ⟹ library hasAmalgamationPropertyForCover.
    --------------------------------------------------------------------

    project-sheaf→library-sheaf :
        IsSheaf AB C Pp
      → hasAmalgamationPropertyForCover Pfun libcov
    project-sheaf→library-sheaf sh =
      isoToIsEquiv (iso (elementToCompatibleFamily Pfun libcov) from sec ret)
      where
        open IsSheaf sh using (amalgamating ; separated)
        open HasAmalgamation amalgamating using (amalgamate)
        open IsSeparated separated using (cover-jointly-monic)

        -- Library compatible family ⟹ project matching family at ⊤.
        -- All-cones compatibility specialized to the overlap-frame cone.
        toMatch : CompatibleFamily Pfun libcov → MatchingFamily AB C Pp c ⊤S
        toMatch cf = record
          { part = λ i _ → cf .fst i
          ; compatible = λ i j → cong (λ z _ → z)
              (cf .snd i j (FiniteCover.overlap-frame c i j)
                 (pb-π₁ AB (FiniteCover.embed c i) (FiniteCover.embed c j))
                 (pb-π₂ AB (FiniteCover.embed c i) (FiniteCover.embed c j))
                 (pb-square AB (FiniteCover.embed c i) (FiniteCover.embed c j)))
          }

        from : CompatibleFamily Pfun libcov → ⟨ Functor.F-ob Pfun F ⟩
        from cf = amalgamate c (toMatch cf) .fst tt*

        sec : (cf : CompatibleFamily Pfun libcov)
            → elementToCompatibleFamily Pfun libcov (from cf) ≡ cf
        sec cf = CompatibleFamily≡ Pfun libcov _ cf
          (λ i → cong (λ h → h tt*) (amalgamate c (toMatch cf) .snd i))

        ret : (x : ⟨ Functor.F-ob Pfun F ⟩)
            → from (elementToCompatibleFamily Pfun libcov x) ≡ x
        ret x = cong (λ h → h tt*)
          (cover-jointly-monic c {⊤S}
            (amalgamate c (toMatch (elementToCompatibleFamily Pfun libcov x)) .fst)
            (λ _ → x)
            (λ i → amalgamate c (toMatch (elementToCompatibleFamily Pfun libcov x)) .snd i))

    --------------------------------------------------------------------
    -- Lemma A (the UP heart): project overlap-compatibility ⟹ library
    -- all-cones compatibility. This is the *only* place the pullback
    -- universal property enters the comparison: any cone (d , f , g) into
    -- a pair of patches factors through the chosen overlap via
    -- `mediating` (the library cone condition `eq` is definitionally the
    -- UP's commuting square), and `restrict-comp` functoriality carries
    -- the single overlap equation `ocompat i j` to the cone. Reduction is
    -- to the *original* `FiniteCover.overlap-frame c i j` (carried
    -- overlap), per Codex's note — not the derived completion's.
    --------------------------------------------------------------------

    overlapCompat→libCompat :
        (fam : FamilyOnCover Pfun libcov)
      → ( (i j : FiniteCover.Index c)
          → FiniteFramePresheaf.restrict Pp
              (FiniteCover.patch c i) (FiniteCover.overlap-frame c i j)
              (pb-π₁ AB (FiniteCover.embed c i) (FiniteCover.embed c j)) (fam i)
            ≡ FiniteFramePresheaf.restrict Pp
              (FiniteCover.patch c j) (FiniteCover.overlap-frame c i j)
              (pb-π₂ AB (FiniteCover.embed c i) (FiniteCover.embed c j)) (fam j) )
      → isCompatibleFamily Pfun libcov fam
    overlapCompat→libCompat fam ocompat i j d f g eq =
        cong (λ φ → restrict pᵢ d φ (fam i)) (sym mπ₁)
      ∙ cong (λ h → h (fam i)) (restrict-comp d ov pᵢ π₁ m̄)
      ∙ cong (restrict ov d m̄) (ocompat i j)
      ∙ sym (cong (λ h → h (fam j)) (restrict-comp d ov pⱼ π₂ m̄))
      ∙ cong (λ φ → restrict pⱼ d φ (fam j)) mπ₂
      where
        ei = FiniteCover.embed c i
        ej = FiniteCover.embed c j
        pᵢ = FiniteCover.patch c i
        pⱼ = FiniteCover.patch c j
        ov = FiniteCover.overlap-frame c i j
        π₁ = pb-π₁ AB ei ej
        π₂ = pb-π₂ AB ei ej
        m̄  = mediating   AB ei ej f g eq
        mπ₁ = mediating-π₁ AB ei ej f g eq
        mπ₂ = mediating-π₂ AB ei ej f g eq

    --------------------------------------------------------------------
    -- Probe-indexed project descent predicates for cover c, plus the two
    -- reverse pieces (option C):
    --   * reverse-at-⊤ (`amalg⊤` / `sep⊤`): the library equivalence gives
    --     descent at the terminal probe. The UP enters only via Lemma A.
    --   * SET well-pointedness (`amalg-wellpointed` / `sep-wellpointed`):
    --     terminal-probe descent lifts to all probes, pointwise by funExt.
    --     UP-free; this is the isolated SET-specific fact.
    --------------------------------------------------------------------

    -- The `∘` object implicits are given explicitly: at `C = SET`,
    -- `Hom[y,z]` reduces to a function type, so unification cannot recover
    -- the objects `y , z` from a morphism's type (`⟨_⟩` is not injective).
    -- (This is why the same expression in `FiniteDescent`, over an abstract
    -- category, needs no annotation.)
    AmalgAt : Ob → Type (ℓ-max ℓI ℓ)
    AmalgAt X =
      (m : MatchingFamily AB C Pp c X)
      → Σ[ s ∈ Hom X (value F) ]
          ( (i : FiniteCover.Index c)
            → _∘_ {x = X} {y = value F} {z = value (FiniteCover.patch c i)}
                (restrict F (FiniteCover.patch c i) (FiniteCover.embed c i)) s
              ≡ MatchingFamily.part m i )

    SepAt : Ob → Type (ℓ-max ℓI ℓ)
    SepAt X =
      (x y : Hom X (value F))
      → ( (i : FiniteCover.Index c)
          → _∘_ {x = X} {y = value F} {z = value (FiniteCover.patch c i)}
              (restrict F (FiniteCover.patch c i) (FiniteCover.embed c i)) x
            ≡ _∘_ {x = X} {y = value F} {z = value (FiniteCover.patch c i)}
              (restrict F (FiniteCover.patch c i) (FiniteCover.embed c i)) y )
      → x ≡ y

    module _ (lib : hasAmalgamationPropertyForCover Pfun libcov) where

      amalg⊤ : AmalgAt ⊤S
      amalg⊤ m =
          (λ _ → invIsEq lib cf)
        , (λ i → funExt (λ u →
              cong (λ cf' → cf' .fst i) (secIsEq lib cf)
            ∙ cong (MatchingFamily.part m i) (isPropUnit* tt* u)))
        where
          cf : CompatibleFamily Pfun libcov
          cf = (λ i → MatchingFamily.part m i tt*)
             , overlapCompat→libCompat (λ i → MatchingFamily.part m i tt*)
                 (λ i j → funExt⁻ (MatchingFamily.compatible m i j) tt*)

      sep⊤ : SepAt ⊤S
      sep⊤ x y h = funExt (λ u →
            cong x (isPropUnit* u tt*)
          ∙ isEmbedding→Inj (isEquiv→isEmbedding lib) (x tt*) (y tt*)
              (CompatibleFamily≡ Pfun libcov _ _ (λ i → funExt⁻ (h i) tt*))
          ∙ cong y (isPropUnit* tt* u))

    amalg-wellpointed : AmalgAt ⊤S → (X : Ob) → AmalgAt X
    amalg-wellpointed at⊤ X m =
        (λ ξ → at⊤ (mξ ξ) .fst tt*)
      , (λ i → funExt (λ ξ → cong (λ k → k tt*) (at⊤ (mξ ξ) .snd i)))
      where
        mξ : ⟨ X ⟩ → MatchingFamily AB C Pp c ⊤S
        mξ ξ = record
          { part = λ i _ → MatchingFamily.part m i ξ
          ; compatible = λ i j → cong (λ z _ → z)
              (funExt⁻ (MatchingFamily.compatible m i j) ξ) }

    sep-wellpointed : SepAt ⊤S → (X : Ob) → SepAt X
    sep-wellpointed sp⊤ X x y h = funExt (λ ξ →
        cong (λ k → k tt*)
          (sp⊤ (λ _ → x ξ) (λ _ → y ξ)
            (λ i → cong (λ z _ → z) (funExt⁻ (h i) ξ))))

  --------------------------------------------------------------------
  -- Coverage-level forward: project IsSheaf ⟹ library isSheaf at the
  -- actual `FiniteFrameCoverage`. Each basis cover the coverage offers is
  -- completed to a `FiniteCover` (`basis→finiteCover`), to which the
  -- per-cover theorem applies; `finiteCover→basis ∘ basis→finiteCover`
  -- is the identity by record-η, so the conclusion lands on the original
  -- basis cover.
  --------------------------------------------------------------------

  project-IsSheaf→library-isSheaf :
      IsSheaf AB C Pp
    → isSheaf (FiniteFrameCoverage AB {ℓE} {ℓR} {ℓI}) Pfun
  project-IsSheaf→library-isSheaf sh Ĝ bc =
    project-sheaf→library-sheaf (basis→finiteCover AB bc) sh

  --------------------------------------------------------------------
  -- Coverage-level reverse: library isSheaf ⟹ project IsSheaf. For each
  -- FiniteCover the library hypothesis is read off at `finiteCover→basis`,
  -- giving terminal-probe descent (reverse-at-⊤), which the SET
  -- well-pointedness lift carries to all probes.
  --------------------------------------------------------------------

  library-isSheaf→project-IsSheaf :
      isSheaf (FiniteFrameCoverage AB {ℓE} {ℓR} {ℓI}) Pfun
    → IsSheaf AB C Pp
  library-isSheaf→project-IsSheaf lib = record
    { separated = record
        { cover-jointly-monic = λ {G} c′ {X} x y h →
            sep-wellpointed c′ (sep⊤ c′ (lib G (finiteCover→basis AB c′))) X x y h }
    ; amalgamating = record
        { amalgamate = λ {G} c′ {X} m →
            amalg-wellpointed c′ (amalg⊤ c′ (lib G (finiteCover→basis AB c′))) X m }
    }

  --------------------------------------------------------------------
  -- The agreement (C6): project finite-descent at SET and the Cubical
  -- library sheaf condition for the generated `FiniteFrameCoverage`
  -- imply each other. Stated as a bi-implication (not an equivalence):
  -- the library side is a proposition, but the project `IsSheaf` record
  -- is not obviously one without folding in uniqueness.
  --------------------------------------------------------------------

  project-IsSheaf↔library-isSheaf :
      (IsSheaf AB C Pp → isSheaf (FiniteFrameCoverage AB {ℓE} {ℓR} {ℓI}) Pfun)
    × (isSheaf (FiniteFrameCoverage AB {ℓE} {ℓR} {ℓI}) Pfun → IsSheaf AB C Pp)
  project-IsSheaf↔library-isSheaf =
    project-IsSheaf→library-isSheaf , library-isSheaf→project-IsSheaf
