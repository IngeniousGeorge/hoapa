{-# OPTIONS --cubical --guardedness #-}

-- Brick 2 of the point-generated R4 reflector route: descent over the
-- canonical point cover, and its comparison with point-locality.
--
-- This is the point-cover mirror of `Concurrency/Hybrid/FiniteDescent.agda`,
-- with the cover fixed to the canonical `point-coverₛ` of an event-
-- supported finite frame (`PointCover.agda`). Two parameter scopes, by
-- design (the split is the mathematics, not a stylistic choice):
--
--   * **Scope 1 — descent, product-free.** `PointMatchingFamily`,
--     `PointAmalgamation`, `PointSeparated`, `IsPointSheaf`, generic over a
--     bare `Category C`. "Satisfies descent over the point cover" should
--     mean exactly "matching families amalgamate uniquely" — no value-
--     category product structure. Compatibility lives on the *event-
--     supported* overlaps `Oπ₁`/`Oπ₂` (`PointOverlap.agda`), **not** on the
--     raw pullbacks `pb-π₁`/`pb-π₂` of `FiniteDescent`. That is the Brick-1
--     geometry fix doing its work here.
--
--   * **Scope 2 — comparison, over `HasFiniteProducts C`.** The point-local
--     cone `S(F) → ∏_{e} S(pt_e)` only *exists* once the value category has
--     finite products, so `PointLocal` and the comparison theorems take
--     `FP : HasFiniteProducts C`. The product collapse "sheaf = point-local"
--     is then a *theorem* of this particular topology, not part of the
--     definition of descent.
--
-- What this file proves — the full biconditional `IsPointSheaf ⟺
-- PointLocal` (on this site, a presheaf is a point sheaf iff it is the
-- product of its point-values), packaged as `point-sheaf⟺local`:
--
--   * `local→sheaf : PointLocal → IsPointSheaf` — a point-local presheaf
--     descends. Amalgamation reads off `cone⁻¹`; separatedness is `cone`
--     monic. Neither half touches overlap compatibility.
--   * `sheaf→local : IsPointSheaf → PointLocal` — every point sheaf is the
--     product of its point values. The inverse cone is the amalgamation of
--     the projection family; the only load-bearing lemma is that the
--     projections *are* a matching family (`proj-compatible`). Its
--     difficulty — overlap compatibility — is dissolved three ways:
--     `supported-overlap` packages an overlap as a supported finite frame
--     by *untruncating* its (propositional) support, so `IsPointSheaf`'s
--     separatedness applies at overlaps without touching hidden event
--     counts; the diagonal reduces by path induction to `FrameHom≡`; the
--     off-diagonal uses separatedness over a *vacuous* point cover.
--   * `zero-event-subterminal : PointLocal → (event-count F ≡ 0) → value F
--     is subterminal` — the owed zero-event terminality lemma, in its
--     working (subterminal, uniqueness-only) form. It is the `F = ∅`
--     instance of point-locality (`∏_{e∈∅} = ⊤ₚ`); the proof needs no
--     product transport, only that `extE` over an empty index is vacuous.
--
-- Scope guardrails: quantifies over the canonical point cover only — no
-- stability, no `ActorPullback`, no full `Coverage`. No `pointify`-is-a-
-- sheaf, no `a ⊣ ι`, no bridge (those are Bricks 3–4). Event level
-- `ℓ-zero`, incidence level `ℓA` (the point-reflector route).

module Concurrency.Hybrid.PointDescent where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv using (_≃_ ; equivFun ; invEq ; secEq ; retEq)
open import Cubical.Data.Sigma using (Σ-syntax ; _,_ ; fst ; snd ; _×_)
open import Cubical.Foundations.HLevels using (isPropΣ)
open import Cubical.Data.Nat using (ℕ ; zero ; suc)
open import Cubical.Data.FinData using (Fin)
open import Cubical.Data.Empty renaming (rec to ⊥-elim)
open import Cubical.Relation.Nullary using (Dec ; yes ; no)
open import Cubical.HITs.PropositionalTruncation renaming (rec to ∥rec∥)

open import Cubical.Categories.Category.Base using (Category ; isIso ; isiso)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal using (LocalFrame ; FrameHom)
open import Concurrency.Sites.ActorPullback using (FrameHom≡)
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Sites.EventSupported
  using (SupportedFiniteFrame ; ChosenEventSupport)
open import Concurrency.Sites.PointCover
  using (PointCover ; point-coverₛ ; discreteEventF)
open import Concurrency.Algebras.CategoryApplicative using (module ApplicativeView)
open import Concurrency.Algebras.FiniteProducts
  using (HasFiniteProducts ; module FiniteProductAPI)
open import Concurrency.Hybrid.FinitePresheaf using (FiniteFramePresheaf)
open import Concurrency.Hybrid.EnumeratedProduct
  using (∏E ; projE ; tupleE ; βE ; extE)

private
  -- A `Fin 0` term is absurd; used to discharge the empty-index
  -- (zero-event) cone-comparison hypotheses.
  ¬Fin0 : {ℓ : Level} {A : Type ℓ} → Fin 0 → A
  ¬Fin0 ()

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓV ℓH : Level} (C : Category ℓV ℓH) where

  open ApplicativeView C

  ----------------------------------------------------------------------
  -- Canonical-point-cover accessors (depend on the site only).
  ----------------------------------------------------------------------

  fin : SupportedFiniteFrame AB → FiniteFrame AB ℓ-zero ℓA
  fin = SupportedFiniteFrame.fin

  Idx : SupportedFiniteFrame AB → Type ℓ-zero
  Idx SF = PointCover.Index (point-coverₛ AB SF)

  Pat : (SF : SupportedFiniteFrame AB) → Idx SF → FiniteFrame AB ℓ-zero ℓA
  Pat SF = PointCover.patch (point-coverₛ AB SF)

  Emb : (SF : SupportedFiniteFrame AB) (i : Idx SF)
      → FrameHom AB (FiniteFrame.frame (Pat SF i)) (FiniteFrame.frame (fin SF))
  Emb SF = PointCover.embed (point-coverₛ AB SF)

  Ov : (SF : SupportedFiniteFrame AB) → Idx SF → Idx SF → FiniteFrame AB ℓ-zero ℓA
  Ov SF = PointCover.overlap-frame (point-coverₛ AB SF)

  Oπ₁ : (SF : SupportedFiniteFrame AB) (i j : Idx SF)
      → FrameHom AB (FiniteFrame.frame (Ov SF i j)) (FiniteFrame.frame (Pat SF i))
  Oπ₁ SF = PointCover.ov-π₁ (point-coverₛ AB SF)

  Oπ₂ : (SF : SupportedFiniteFrame AB) (i j : Idx SF)
      → FrameHom AB (FiniteFrame.frame (Ov SF i j)) (FiniteFrame.frame (Pat SF j))
  Oπ₂ SF = PointCover.ov-π₂ (point-coverₛ AB SF)

  ----------------------------------------------------------------------
  -- Scope 1: descent over the canonical point cover (product-free).
  ----------------------------------------------------------------------

  module _ (P : FiniteFramePresheaf AB C {ℓ-zero} {ℓA}) where
    open FiniteFramePresheaf P

    -- Restriction of a global section to the i-th point patch.
    rπ : (SF : SupportedFiniteFrame AB) (i : Idx SF)
       → Hom (value (fin SF)) (value (Pat SF i))
    rπ SF i = restrict (fin SF) (Pat SF i) (Emb SF i)

    record PointMatchingFamily (SF : SupportedFiniteFrame AB) (X : Ob)
         : Type ℓH where
      field
        part : (i : Idx SF) → Hom X (value (Pat SF i))
        compatible :
          (i j : Idx SF)
          → restrict (Pat SF i) (Ov SF i j) (Oπ₁ SF i j) ∘ part i
            ≡ restrict (Pat SF j) (Ov SF i j) (Oπ₂ SF i j) ∘ part j

    record PointAmalgamation : Type (ℓ-suc (ℓ-max ℓA (ℓ-max ℓV ℓH))) where
      field
        amalgamate :
          (SF : SupportedFiniteFrame AB) {X : Ob}
          (m : PointMatchingFamily SF X)
          → Σ[ s ∈ Hom X (value (fin SF)) ]
              ((i : Idx SF) → rπ SF i ∘ s ≡ PointMatchingFamily.part m i)

    record PointSeparated : Type (ℓ-suc (ℓ-max ℓA (ℓ-max ℓV ℓH))) where
      field
        cover-jointly-monic :
          (SF : SupportedFiniteFrame AB) {X : Ob}
          (x y : Hom X (value (fin SF)))
          → ((i : Idx SF) → rπ SF i ∘ x ≡ rπ SF i ∘ y)
          → x ≡ y

    record IsPointSheaf : Type (ℓ-suc (ℓ-max ℓA (ℓ-max ℓV ℓH))) where
      field
        separated    : PointSeparated
        amalgamating : PointAmalgamation

  ----------------------------------------------------------------------
  -- Scope 2: the point-local cone and the comparison theorems.
  ----------------------------------------------------------------------

  module _ (FP : HasFiniteProducts C)
           (P : FiniteFramePresheaf AB C {ℓ-zero} {ℓA}) where
    open FiniteProductAPI C FP
    open FiniteFramePresheaf P

    private
      n' : SupportedFiniteFrame AB → ℕ
      n' SF = FiniteFrame.event-count (fin SF)

      en' : (SF : SupportedFiniteFrame AB) → Idx SF ≃ Fin (n' SF)
      en' SF = FiniteFrame.enum (fin SF)

      slot : (SF : SupportedFiniteFrame AB) → Idx SF → Ob
      slot SF i = value (Pat SF i)

      aprod : SupportedFiniteFrame AB → Ob
      aprod SF = ∏E C FP (n' SF) (Idx SF) (en' SF) (slot SF)

      prj : (SF : SupportedFiniteFrame AB) (i : Idx SF) → Hom (aprod SF) (slot SF i)
      prj SF = projE C FP (n' SF) (Idx SF) (en' SF) (slot SF)

      -- The point-local comparison cone `S(F) → ∏_{e} S(pt_e)`.
      cone : (SF : SupportedFiniteFrame AB) → Hom (value (fin SF)) (aprod SF)
      cone SF = tupleE C FP (n' SF) (Idx SF) (en' SF) (slot SF) (λ i → rπ P SF i)

      -- The cone's defining property: its e-th projection is the
      -- restriction to the point patch e.
      cone-β : (SF : SupportedFiniteFrame AB) (i : Idx SF)
             → prj SF i ∘ cone SF ≡ rπ P SF i
      cone-β SF i = βE C FP (n' SF) (Idx SF) (en' SF) (slot SF) (λ k → rπ P SF k) i

    ------------------------------------------------------------------
    -- Point-locality: the cone is an iso, for every supported frame.
    ------------------------------------------------------------------

    PointLocal : Type (ℓ-max (ℓ-suc ℓA) ℓH)
    PointLocal = (SF : SupportedFiniteFrame AB) → isIso C (cone SF)

    ------------------------------------------------------------------
    -- The cone of a point-local presheaf is monic.
    ------------------------------------------------------------------

    private
      cone-mono :
        (SF : SupportedFiniteFrame AB) (io : isIso C (cone SF)) {X : Ob}
        (x y : Hom X (value (fin SF)))
        → cone SF ∘ x ≡ cone SF ∘ y → x ≡ y
      cone-mono SF io {X} x y eq =
          sym (id-l x)
        ∙ cong (_∘ x) (sym (isIso.ret io))
        ∙ ∘-assoc (isIso.inv io) (cone SF) x
        ∙ cong (isIso.inv io ∘_) eq
        ∙ sym (∘-assoc (isIso.inv io) (cone SF) y)
        ∙ cong (_∘ y) (isIso.ret io)
        ∙ id-l y

    ------------------------------------------------------------------
    -- Zero-event terminality (the owed lemma), in subterminal form.
    --
    -- At a supported frame with no events `∏_{e} S(pt_e)` is the empty
    -- product (subterminal), and `cone` is monic, so `value F` is
    -- subterminal: any two maps into it agree. This is the `F = ∅`
    -- collapse, with no product transport — the empty-index `extE`
    -- hypotheses are discharged by eliminating `Fin 0`.
    ------------------------------------------------------------------

    zero-event-subterminal :
        PointLocal
      → (SF : SupportedFiniteFrame AB) (z : n' SF ≡ 0) {X : Ob}
        (f g : Hom X (value (fin SF)))
      → f ≡ g
    zero-event-subterminal pl SF z {X} f g =
      cone-mono SF (pl SF) f g conefg
      where
        conefg : cone SF ∘ f ≡ cone SF ∘ g
        conefg = extE C FP (n' SF) (Idx SF) (en' SF) (slot SF)
                   (cone SF ∘ f) (cone SF ∘ g)
                   (λ i → ¬Fin0 (subst Fin z (equivFun (en' SF) i)))

    ------------------------------------------------------------------
    -- Direction A: point-local ⇒ point sheaf.
    --
    -- Amalgamation reads off `cone⁻¹`; separatedness is `cone` monic.
    -- Neither half consults the matching family's overlap compatibility.
    ------------------------------------------------------------------

    local→sheaf : PointLocal → IsPointSheaf P
    local→sheaf pl = record { separated = sep ; amalgamating = amalg }
      where
        sep : PointSeparated P
        sep = record { cover-jointly-monic = cjm }
          where
            cjm :
              (SF : SupportedFiniteFrame AB) {X : Ob}
              (x y : Hom X (value (fin SF)))
              → ((i : Idx SF) → rπ P SF i ∘ x ≡ rπ P SF i ∘ y)
              → x ≡ y
            cjm SF {X} x y hyp = cone-mono SF (pl SF) x y conexy
              where
                conexy : cone SF ∘ x ≡ cone SF ∘ y
                conexy = extE C FP (n' SF) (Idx SF) (en' SF) (slot SF)
                           (cone SF ∘ x) (cone SF ∘ y) per
                  where
                    per : (i : Idx SF)
                        → prj SF i ∘ (cone SF ∘ x) ≡ prj SF i ∘ (cone SF ∘ y)
                    per i =
                        sym (∘-assoc (prj SF i) (cone SF) x)
                      ∙ cong (_∘ x) (cone-β SF i)
                      ∙ hyp i
                      ∙ cong (_∘ y) (sym (cone-β SF i))
                      ∙ ∘-assoc (prj SF i) (cone SF) y

        amalg : PointAmalgamation P
        amalg = record { amalgamate = am }
          where
            am :
              (SF : SupportedFiniteFrame AB) {X : Ob}
              (m : PointMatchingFamily P SF X)
              → Σ[ s ∈ Hom X (value (fin SF)) ]
                  ((i : Idx SF) → rπ P SF i ∘ s ≡ PointMatchingFamily.part m i)
            am SF {X} m = s , restr
              where
                io   = pl SF
                invc = isIso.inv io
                tpl  = tupleE C FP (n' SF) (Idx SF) (en' SF) (slot SF)
                              (PointMatchingFamily.part m)

                s : Hom X (value (fin SF))
                s = invc ∘ tpl

                -- `rπ i ∘ cone⁻¹` collapses to the i-th product projection.
                rπ∘inv : (i : Idx SF) → rπ P SF i ∘ invc ≡ prj SF i
                rπ∘inv i =
                    cong (_∘ invc) (sym (cone-β SF i))
                  ∙ ∘-assoc (prj SF i) (cone SF) invc
                  ∙ cong (prj SF i ∘_) (isIso.sec io)
                  ∙ id-r (prj SF i)

                restr : (i : Idx SF) → rπ P SF i ∘ s ≡ PointMatchingFamily.part m i
                restr i =
                    sym (∘-assoc (rπ P SF i) invc tpl)
                  ∙ cong (_∘ tpl) (rπ∘inv i)
                  ∙ βE C FP (n' SF) (Idx SF) (en' SF) (slot SF)
                       (PointMatchingFamily.part m) i

    ------------------------------------------------------------------
    -- The overlap of two point patches, as a supported finite frame.
    --
    -- Its events are the paths `i ≡ j` (a proposition), and its actors
    -- are event-generated, so the support witness `Σ[q] touches` is a
    -- proposition and untruncates — no choice, no case-split. This lets
    -- `IsPointSheaf`'s separatedness be applied at overlaps directly,
    -- without ever touching the hidden `prop-dec-fin` event counts.
    ------------------------------------------------------------------

    private
      supported-overlap :
        (SF : SupportedFiniteFrame AB) (i j : Idx SF) → SupportedFiniteFrame AB
      supported-overlap SF i j = record { fin = Ov SF i j ; support = sup }
        where
          sup : ChosenEventSupport AB (FiniteFrame.frame (Ov SF i j))
          sup a ai =
            ∥rec∥ (isPropΣ (LocalFrame.Event-set (FiniteFrame.frame (fin SF)) i j)
                           (λ _ → LocalFrame.touches-isProp (FiniteFrame.frame (fin SF)) i a))
                  (λ x → x) ai

    ------------------------------------------------------------------
    -- The projection family is a matching family.
    --
    -- This is the one genuinely load-bearing lemma of the reverse
    -- direction. Compatibility of the projections splits on `i ≡ j`:
    --   * diagonal (a path `p : i ≡ j`): `subst` along `p` reduces to the
    --     `refl` case, where `Oπ₁ i i ≡ Oπ₂ i i` by `FrameHom≡` (both
    --     event-maps are constant) and the two projections coincide;
    --   * off-diagonal (`¬ (i ≡ j)`): the overlap has no events, so
    --     separatedness over its (vacuous) point cover collapses any two
    --     maps into `value (Ov i j)`.
    -- The decision is consumed by an explicit helper `go`, never `with`,
    -- so the overlap's hidden event count is left inert.
    ------------------------------------------------------------------

    private
      proj-compatible :
        (sheaf : IsPointSheaf P) (SF : SupportedFiniteFrame AB) (i j : Idx SF)
        → restrict (Pat SF i) (Ov SF i j) (Oπ₁ SF i j) ∘ prj SF i
          ≡ restrict (Pat SF j) (Ov SF i j) (Oπ₂ SF i j) ∘ prj SF j
      proj-compatible sheaf SF i j = go (discreteEventF AB (fin SF) i j)
        where
          motive : Idx SF → Type ℓH
          motive j' = restrict (Pat SF i) (Ov SF i j') (Oπ₁ SF i j') ∘ prj SF i
                    ≡ restrict (Pat SF j') (Ov SF i j') (Oπ₂ SF i j') ∘ prj SF j'

          go : Dec (i ≡ j) → motive j
          go (yes p) = subst motive p diag
            where
              diag : motive i
              diag = cong (λ φ → restrict (Pat SF i) (Ov SF i i) φ ∘ prj SF i)
                          (FrameHom≡ AB (Oπ₁ SF i i) (Oπ₂ SF i i) refl)
          go (no ¬p) =
            PointSeparated.cover-jointly-monic (IsPointSheaf.separated sheaf)
              (supported-overlap SF i j)
              (restrict (Pat SF i) (Ov SF i j) (Oπ₁ SF i j) ∘ prj SF i)
              (restrict (Pat SF j) (Ov SF i j) (Oπ₂ SF i j) ∘ prj SF j)
              (λ k → ⊥-elim (¬p k))

    ------------------------------------------------------------------
    -- Direction B: point sheaf ⇒ point-local.
    --
    -- The inverse of the cone is the amalgamation of the projection
    -- family; `cone ∘ g = id` by product joint-monicity, `g ∘ cone = id`
    -- by separatedness. Together with `local→sheaf` this is the
    -- biconditional `IsPointSheaf ⟺ PointLocal` (over `HasFiniteProducts`).
    ------------------------------------------------------------------

    sheaf→local : IsPointSheaf P → PointLocal
    sheaf→local sheaf SF = isiso g sec-pf ret-pf
      where
        mfam : PointMatchingFamily P SF (aprod SF)
        mfam = record { part = λ i → prj SF i
                      ; compatible = proj-compatible sheaf SF }

        amal = PointAmalgamation.amalgamate (IsPointSheaf.amalgamating sheaf) SF mfam

        g : Hom (aprod SF) (value (fin SF))
        g = fst amal

        gβ : (i : Idx SF) → rπ P SF i ∘ g ≡ prj SF i
        gβ = snd amal

        sec-pf : cone SF ∘ g ≡ id
        sec-pf = extE C FP (n' SF) (Idx SF) (en' SF) (slot SF)
                   (cone SF ∘ g) id per
          where
            per : (i : Idx SF) → prj SF i ∘ (cone SF ∘ g) ≡ prj SF i ∘ id
            per i =
                sym (∘-assoc (prj SF i) (cone SF) g)
              ∙ cong (_∘ g) (cone-β SF i)
              ∙ gβ i
              ∙ sym (id-r (prj SF i))

        ret-pf : g ∘ cone SF ≡ id
        ret-pf =
          PointSeparated.cover-jointly-monic (IsPointSheaf.separated sheaf) SF
            (g ∘ cone SF) id per
          where
            per : (i : Idx SF) → rπ P SF i ∘ (g ∘ cone SF) ≡ rπ P SF i ∘ id
            per i =
                sym (∘-assoc (rπ P SF i) g (cone SF))
              ∙ cong (_∘ cone SF) (gβ i)
              ∙ cone-β SF i
              ∙ sym (id-r (rπ P SF i))

    ------------------------------------------------------------------
    -- The biconditional, bundled (Brick 3 consumes this directly).
    ------------------------------------------------------------------

    point-sheaf⟺local : (IsPointSheaf P → PointLocal) × (PointLocal → IsPointSheaf P)
    point-sheaf⟺local = sheaf→local , local→sheaf
