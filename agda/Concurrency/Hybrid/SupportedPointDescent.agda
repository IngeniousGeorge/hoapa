{-# OPTIONS --cubical --guardedness #-}

-- Point-cover descent and the point-locality comparison, over the
-- *supported* subsite.
--
-- This is the supported-subsite port of
-- `Concurrency/Hybrid/PointDescent.agda`: the same two-scope structure,
-- the same `local→sheaf` / `sheaf→local` / `proj-compatible` proofs, but
-- with the presheaf `P` a `SupportedPresheaf` (`SupportedPresheafCategory.agda`)
-- over `SupportedFiniteFrame`s rather than a full `FiniteFramePresheaf`.
-- The biconditional `IsPointSheaf P ⟺ PointLocal P` is the point-route
-- sheaf/locality theorem the reflector layer (`PointifyIsSheaf.agda`,
-- `PointSheafCategory.agda`) consumes.
--
-- Two changes from the full-site version, both forced by the move to the
-- supported subsite and both *simplifications*:
--
--   * The cover patches `Pat SF i` (point frames) and overlaps `Ov SF i j`
--     are now wrapped as `SupportedFiniteFrame`s (Codex's `pat-supported`
--     / `ov-supported`), via `point-frame-chosen-support` and the overlap
--     support `ov-support` (untruncation of the propositional event-
--     support, exactly the old `supported-overlap`). Their *underlying*
--     frames and the embeds/projections `Emb`/`Oπ₁`/`Oπ₂` come from the
--     point cover unchanged.
--   * Because `Ov SF i j` is now itself a supported frame, the old private
--     `supported-overlap` helper is gone: `proj-compatible`'s off-diagonal
--     applies separatedness at `Ov SF i j` directly.
--
-- Everything else is the `PointDescent` proof verbatim. Scope guardrails as
-- there: the canonical point cover only — no stability, no `ActorPullback`,
-- no full `Coverage`; event level `ℓ-zero`, incidence level `ℓA`.

module Concurrency.Hybrid.SupportedPointDescent where

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
  using (SupportedFiniteFrame ; ChosenEventSupport ; point-frame-chosen-support)
open import Concurrency.Sites.PointCover
  using (PointCover ; point-coverₛ ; discreteEventF
        ; point-frame-finite ; point-overlap-finite ; supported-point)
open import Concurrency.Algebras.CategoryApplicative using (module ApplicativeView)
open import Concurrency.Algebras.FiniteProducts
  using (HasFiniteProducts ; module FiniteProductAPI)
open import Concurrency.Hybrid.SupportedPresheafCategory using (SupportedPresheaf)
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
  -- Canonical-point-cover accessors (depend on the site only). The
  -- patches and overlaps are wrapped as supported finite frames.
  ----------------------------------------------------------------------

  fin : SupportedFiniteFrame AB → FiniteFrame AB ℓ-zero ℓA
  fin = SupportedFiniteFrame.fin

  uframe : SupportedFiniteFrame AB → LocalFrame AB ℓ-zero ℓA
  uframe SF = FiniteFrame.frame (fin SF)

  Idx : SupportedFiniteFrame AB → Type ℓ-zero
  Idx SF = PointCover.Index (point-coverₛ AB SF)

  -- The point patch at `i`, as a supported finite frame (the shared
  -- `supported-point`, syntactically equal to the reflector's `pt`).
  Pat : (SF : SupportedFiniteFrame AB) → Idx SF → SupportedFiniteFrame AB
  Pat SF i = supported-point AB (fin SF) i

  Emb : (SF : SupportedFiniteFrame AB) (i : Idx SF)
      → FrameHom AB (uframe (Pat SF i)) (uframe SF)
  Emb SF = PointCover.embed (point-coverₛ AB SF)

  -- The overlap's chosen support: untruncate its propositional event
  -- support (`ActorIn = ∥ Σ[ p ∈ d ≡ e ] touches d ∥₁`).
  private
    ov-support : (SF : SupportedFiniteFrame AB) (i j : Idx SF)
               → ChosenEventSupport AB
                   (FiniteFrame.frame (point-overlap-finite AB (fin SF) i j))
    ov-support SF i j a ai =
      ∥rec∥ (isPropΣ (LocalFrame.Event-set (uframe SF) i j)
                     (λ _ → LocalFrame.touches-isProp (uframe SF) i a))
            (λ x → x) ai

  -- The point overlap of patches `i`, `j`, as a supported finite frame.
  Ov : (SF : SupportedFiniteFrame AB) → Idx SF → Idx SF → SupportedFiniteFrame AB
  Ov SF i j = record
    { fin     = point-overlap-finite AB (fin SF) i j
    ; support = ov-support SF i j
    }

  Oπ₁ : (SF : SupportedFiniteFrame AB) (i j : Idx SF)
      → FrameHom AB (uframe (Ov SF i j)) (uframe (Pat SF i))
  Oπ₁ SF = PointCover.ov-π₁ (point-coverₛ AB SF)

  Oπ₂ : (SF : SupportedFiniteFrame AB) (i j : Idx SF)
      → FrameHom AB (uframe (Ov SF i j)) (uframe (Pat SF j))
  Oπ₂ SF = PointCover.ov-π₂ (point-coverₛ AB SF)

  ----------------------------------------------------------------------
  -- Scope 1: descent over the canonical point cover (product-free).
  ----------------------------------------------------------------------

  module _ (P : SupportedPresheaf AB C) where
    open SupportedPresheaf P

    -- Restriction of a global section to the i-th point patch.
    rπ : (SF : SupportedFiniteFrame AB) (i : Idx SF)
       → Hom (value SF) (value (Pat SF i))
    rπ SF i = restrict SF (Pat SF i) (Emb SF i)

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
          → Σ[ s ∈ Hom X (value SF) ]
              ((i : Idx SF) → rπ SF i ∘ s ≡ PointMatchingFamily.part m i)

    record PointSeparated : Type (ℓ-suc (ℓ-max ℓA (ℓ-max ℓV ℓH))) where
      field
        cover-jointly-monic :
          (SF : SupportedFiniteFrame AB) {X : Ob}
          (x y : Hom X (value SF))
          → ((i : Idx SF) → rπ SF i ∘ x ≡ rπ SF i ∘ y)
          → x ≡ y

    record IsPointSheaf : Type (ℓ-suc (ℓ-max ℓA (ℓ-max ℓV ℓH))) where
      field
        separated    : PointSeparated
        amalgamating : PointAmalgamation

    -- A point-indexed family is automatically a matching family: its
    -- compatibility is forced (off-diagonal overlaps are empty, the
    -- diagonal is `FrameHom≡`), given separatedness to discharge the
    -- off-diagonal. The reusable form of `proj-compatible`.
    point-family-matching :
        PointSeparated
      → (SF : SupportedFiniteFrame AB) {X : Ob}
      → ((i : Idx SF) → Hom X (value (Pat SF i)))
      → PointMatchingFamily SF X
    point-family-matching sep SF {X} part =
      record { part = part ; compatible = compat }
      where
        compat : (i j : Idx SF)
               → restrict (Pat SF i) (Ov SF i j) (Oπ₁ SF i j) ∘ part i
                 ≡ restrict (Pat SF j) (Ov SF i j) (Oπ₂ SF i j) ∘ part j
        compat i j = go (discreteEventF AB (fin SF) i j)
          where
            motive : Idx SF → Type ℓH
            motive j' = restrict (Pat SF i) (Ov SF i j') (Oπ₁ SF i j') ∘ part i
                      ≡ restrict (Pat SF j') (Ov SF i j') (Oπ₂ SF i j') ∘ part j'
            go : Dec (i ≡ j) → motive j
            go (yes p) = subst motive p diag
              where
                diag : motive i
                diag = cong (λ φ → restrict (Pat SF i) (Ov SF i i) φ ∘ part i)
                            (FrameHom≡ AB (Oπ₁ SF i i) (Oπ₂ SF i i) refl)
            go (no ¬p) =
              PointSeparated.cover-jointly-monic sep
                (Ov SF i j)
                (restrict (Pat SF i) (Ov SF i j) (Oπ₁ SF i j) ∘ part i)
                (restrict (Pat SF j) (Ov SF i j) (Oπ₂ SF i j) ∘ part j)
                (λ k → ⊥-elim (¬p k))

  ----------------------------------------------------------------------
  -- Scope 2: the point-local cone and the comparison theorems.
  ----------------------------------------------------------------------

  module _ (FP : HasFiniteProducts C)
           (P : SupportedPresheaf AB C) where
    open FiniteProductAPI C FP
    open SupportedPresheaf P

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
      cone : (SF : SupportedFiniteFrame AB) → Hom (value SF) (aprod SF)
      cone SF = tupleE C FP (n' SF) (Idx SF) (en' SF) (slot SF) (λ i → rπ P SF i)

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
        (x y : Hom X (value SF))
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
    ------------------------------------------------------------------

    zero-event-subterminal :
        PointLocal
      → (SF : SupportedFiniteFrame AB) (z : n' SF ≡ 0) {X : Ob}
        (f g : Hom X (value SF))
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
    ------------------------------------------------------------------

    local→sheaf : PointLocal → IsPointSheaf P
    local→sheaf pl = record { separated = sep ; amalgamating = amalg }
      where
        sep : PointSeparated P
        sep = record { cover-jointly-monic = cjm }
          where
            cjm :
              (SF : SupportedFiniteFrame AB) {X : Ob}
              (x y : Hom X (value SF))
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
              → Σ[ s ∈ Hom X (value SF) ]
                  ((i : Idx SF) → rπ P SF i ∘ s ≡ PointMatchingFamily.part m i)
            am SF {X} m = s , restr
              where
                io   = pl SF
                invc = isIso.inv io
                tpl  = tupleE C FP (n' SF) (Idx SF) (en' SF) (slot SF)
                              (PointMatchingFamily.part m)

                s : Hom X (value SF)
                s = invc ∘ tpl

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
    -- The projection family is a matching family.
    --
    -- Diagonal (`i ≡ j`): `subst` to the `refl` case, where `Oπ₁ i i ≡
    -- Oπ₂ i i` by `FrameHom≡`. Off-diagonal (`¬ (i ≡ j)`): the overlap
    -- `Ov SF i j` (already a supported frame) has no events, so
    -- separatedness over its vacuous point cover collapses any two maps
    -- into `value (Ov i j)`. The decision is consumed by `go`, never
    -- `with`, so the overlap's hidden event count stays inert.
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
              (Ov SF i j)
              (restrict (Pat SF i) (Ov SF i j) (Oπ₁ SF i j) ∘ prj SF i)
              (restrict (Pat SF j) (Ov SF i j) (Oπ₂ SF i j) ∘ prj SF j)
              (λ k → ⊥-elim (¬p k))

    ------------------------------------------------------------------
    -- Direction B: point sheaf ⇒ point-local.
    ------------------------------------------------------------------

    sheaf→local : IsPointSheaf P → PointLocal
    sheaf→local sheaf SF = isiso g sec-pf ret-pf
      where
        mfam : PointMatchingFamily P SF (aprod SF)
        mfam = record { part = λ i → prj SF i
                      ; compatible = proj-compatible sheaf SF }

        amal = PointAmalgamation.amalgamate (IsPointSheaf.amalgamating sheaf) SF mfam

        g : Hom (aprod SF) (value SF)
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
    -- The biconditional, bundled.
    ------------------------------------------------------------------

    point-sheaf⟺local : (IsPointSheaf P → PointLocal) × (PointLocal → IsPointSheaf P)
    point-sheaf⟺local = sheaf→local , local→sheaf
