{-# OPTIONS --cubical --guardedness #-}

-- R4 — the B-internal cartesian↔linear adapter, assembled.
--
-- This file feeds the value-level Benton/LNL adjunction
-- (`LinearNonlinear.LNLAdjunction`) through the change-of-base engine
-- (`ChangeOfBase.changeOfBase`), and sorts the result into the four tiers
-- agreed in the R4 design discussion. The point of the sort is honesty
-- about what is proved vs owed: the presheaf-level lifts are
-- unconditional; the sheaf level splits into a tractable right-adjoint
-- direction and a genuinely separate left-adjoint problem.
--
-- The four tiers:
--
--   Tier 1  (PROVED, here):    presheaf-level lifts `liftF`, `liftG` —
--           change of base in the value category, both directions. No
--           adjunction, no sheaf condition needed; pure functoriality.
--
--   Tier 1.5 (PROVED, `liftF⊣liftG`): the *presheaf-level* adjunction
--           `liftF ⊣ liftG`, the pointwise lift of the value-level
--           `F ⊣ G` along change-of-base. Purely presheaf-level —
--           independent of `IsSheaf` and of Tiers 2/3.
--
--   Tier 2  (PROVED, `G-preserves-sheaf`): the right adjoint `G` sends
--           V-valued sheaves to cartesian sheaves. The probe-form descent
--           is limit-shaped and `G` preserves it; the proof transports a
--           matching family through the adjunction's natural bijection
--           `Cart [ X , G d ] ≅ Vcat [ F X , d ]`, amalgamates on the V
--           side, transports back. This is the proof that makes the LNL
--           interface's adjunction field "consumed by a theorem", not a
--           label. (`G-PreservesSheaf` is kept as the obligation type.)
--
--   Tier 3  (named obligation `F-PreservesSheaf`): the left adjoint `F`
--           does NOT preserve descent for free. The sheaf-level left
--           functor needs either an `F`-preservation proof (special to
--           the instance) or a sheafification reflector. Named here as a
--           *distinct* obligation precisely so it is not mistaken for a
--           corollary of Tier 2.
--
--   Tier 4  (derivable from 1.5 + 2 + 3, not yet): the genuine
--           *sheaf-level* adjunction, by restricting the presheaf-level
--           adjunction to the `IsSheaf` full subcategories once both
--           preservation directions hold. Deferred; documented, not
--           asserted.
--
-- No postulates. Tiers 2 and 3 are stated as *types* (the obligations a
-- later module discharges), in the project's "property record / named
-- obligation, not postulate" discipline; Tiers 1.5 and 4 are derivations
-- and are documented rather than given as fields, so nothing here
-- over-claims an adjunction the framework has not built.
--
-- Interface-first guardrails: generic over an abstract cartesian value
-- category `Cart` (instantiated at `SET` later) and `V : StarAutonomous`
-- (instantiated at `Sessions-Cat` later); endpoints stay the project's
-- own finite sheaf categories, never the library presentation.

module Concurrency.Hybrid.R4Adapter where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Isomorphism using (Iso ; isoInvInjective)
open import Cubical.Data.Sigma using (_,_ ; fst ; snd ; Σ≡Prop)

open import Cubical.Categories.Category.Base using (Category)
open import Cubical.Categories.Functor.Base using (Functor)
open import Cubical.Categories.Adjoint using (module NaturalBijection)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.FiniteCover using (FiniteCover)
open import Concurrency.Algebras.StarAutonomous using (StarAutonomous)
open import Concurrency.Algebras.StarAutonomousCategory using (StarAutonomous→Category)
open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)
open import Concurrency.Hybrid.FinitePresheaf using (FiniteFramePresheaf)
open import Concurrency.Hybrid.FiniteDescent
  using (IsSheaf ; IsSeparated ; HasAmalgamation ; MatchingFamily)
open import Concurrency.Hybrid.FiniteSheafCategory
  using (FiniteFramePresheafCategory ; PshHom ; isNat ; isNat-isProp)
open import Concurrency.Hybrid.ChangeOfBase using (changeOfBase ; mapPsh)
open import Concurrency.Hybrid.LinearNonlinear using (LNLAdjunction)

open NaturalBijection using (_⊣_)

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓc ℓc' ℓv ℓv' : Level}
         (Cart : Category ℓc ℓc') (cartProd : HasFiniteProducts Cart)
         (V : StarAutonomous ℓv ℓv')
         (lnl : LNLAdjunction Cart cartProd V)
         {ℓE ℓR : Level} where

  private
    Vcat : Category ℓv ℓv'
    Vcat = StarAutonomous→Category V

  open LNLAdjunction lnl using (F ; G ; F⊣G)
  open NaturalBijection._⊣_ F⊣G

  --------------------------------------------------------------------
  -- Tier 1 (PROVED): presheaf-level change-of-base lifts.
  --------------------------------------------------------------------

  -- Right adjoint `G : V → Cart` lifts to `Sh-presheaf(site,V) →
  -- Sh-presheaf(site,Cart)`.
  liftG : Functor (FiniteFramePresheafCategory AB Vcat {ℓE} {ℓR})
                  (FiniteFramePresheafCategory AB Cart {ℓE} {ℓR})
  liftG = changeOfBase AB Vcat Cart G

  -- Left adjoint `F : Cart → V` lifts to `Sh-presheaf(site,Cart) →
  -- Sh-presheaf(site,V)`.
  liftF : Functor (FiniteFramePresheafCategory AB Cart {ℓE} {ℓR})
                  (FiniteFramePresheafCategory AB Vcat {ℓE} {ℓR})
  liftF = changeOfBase AB Cart Vcat F

  --------------------------------------------------------------------
  -- Tier 2 (PROVED): the right adjoint G preserves the sheaf condition.
  --
  -- `G-PreservesSheaf` is the obligation type; `G-preserves-sheaf`
  -- discharges it. The proof transports descent across the adjunction's
  -- natural bijection `Cart [ X , G d ] ≅ Vcat [ F X , d ]`:
  --
  --   * Separatedness: two Cart-sections `x y` into `G∘P` pull back to
  --     `x ♯`, `y ♯` at probe `F X`; `adjNatInD'` turns the per-patch
  --     restriction hypothesis into the V-side hypothesis; `P`'s
  --     separatedness gives `x ♯ ≡ y ♯`; `isoInvInjective` gives `x ≡ y`.
  --   * Amalgamation: a Cart-matching-family pulls back (via `_♯` +
  --     `adjNatInD'` for overlap compatibility) to a V-matching-family at
  --     `F X`; `P` amalgamates it; `_♭` pushes the section back, and
  --     `adjNatInD` + the `♭`/`♯` section law recover the restriction
  --     equations.
  --
  -- This is the theorem that makes the LNL interface's adjunction field
  -- load-bearing — the Grothendieckian "fields consumed by a proof" test.
  --------------------------------------------------------------------

  G-PreservesSheaf : (ℓI : Level) → Type _
  G-PreservesSheaf ℓI =
    (P : FiniteFramePresheaf AB Vcat {ℓE} {ℓR})
    → IsSheaf AB Vcat {ℓE} {ℓR} {ℓI} P
    → IsSheaf AB Cart {ℓE} {ℓR} {ℓI} (mapPsh AB Vcat Cart G P)

  G-preserves-sheaf : (ℓI : Level) → G-PreservesSheaf ℓI
  G-preserves-sheaf ℓI P shP = record
    { separated = record
        { cover-jointly-monic = λ {Fr} c {X} x y hyp →
            isoInvInjective adjIso x y
              (IsSeparated.cover-jointly-monic (IsSheaf.separated shP) c (x ♯) (y ♯)
                 (λ i → adjNatInD' x _ ∙ cong _♯ (hyp i) ∙ sym (adjNatInD' y _))) }
    ; amalgamating = record
        { amalgamate = λ {Fr} c {X} m →
            let vs = HasAmalgamation.amalgamate (IsSheaf.amalgamating shP) c
                       {Functor.F-ob F X}
                       (record
                         { part = λ i → MatchingFamily.part m i ♯
                         ; compatible = λ i j →
                               adjNatInD' (MatchingFamily.part m i) _
                             ∙ cong _♯ (MatchingFamily.compatible m i j)
                             ∙ sym (adjNatInD' (MatchingFamily.part m j) _) })
            in (fst vs ♭) ,
               (λ i → sym (adjNatInD (fst vs) _)
                    ∙ cong _♭ (snd vs i)
                    ∙ Iso.sec adjIso (MatchingFamily.part m i)) } }

  --------------------------------------------------------------------
  -- Tier 3 (named obligation, genuinely separate): F preservation /
  -- sheafification. Stated, not implied by Tier 2.
  --------------------------------------------------------------------

  F-PreservesSheaf : (ℓI : Level) → Type _
  F-PreservesSheaf ℓI =
    (P : FiniteFramePresheaf AB Cart {ℓE} {ℓR})
    → IsSheaf AB Cart {ℓE} {ℓR} {ℓI} P
    → IsSheaf AB Vcat {ℓE} {ℓR} {ℓI} (mapPsh AB Cart Vcat F P)

  --------------------------------------------------------------------
  -- Tier 1.5 (PROVED): the presheaf-level adjunction `liftF ⊣ liftG`.
  --
  -- The pointwise lift of the value-level `F ⊣ G`: a presheaf morphism
  -- `liftF P → Q` is, frame-by-frame, a `Vcat`-morphism `F(P fr) → Q fr`,
  -- which transposes (by `adjIso`) to a `Cart`-morphism `P fr → G(Q fr)`,
  -- i.e. a presheaf morphism `P → liftG Q`. Naturality of the transposed
  -- family is `adjNatInC'`/`adjNatInD` (forward) and
  -- `adjNatInC`/`adjNatInD'` (back), exactly as in the Tier 2 transport;
  -- the iso laws and the two `adjNat` laws are `Iso.sec`/`Iso.ret` and the
  -- value-level `adjNat`s applied componentwise (`Σ≡Prop` over the natural
  -- family, naturality being a proposition).
  --
  -- This is PURELY presheaf-level — it must not, and does not, depend on
  -- `IsSheaf`, `G-preserves-sheaf`, or `F-PreservesSheaf`. The
  -- *sheaf-level* adjunction (Tier 4) is still blocked on Tier 3 (the
  -- left functor `liftF` is not known to land in sheaves).
  --------------------------------------------------------------------

  liftF⊣liftG : liftF ⊣ liftG
  liftF⊣liftG = record
    { adjIso     = λ {P} {Q} → psh-iso P Q
    ; adjNatInD  = λ {P} {Q} {Q'} f k →
        Σ≡Prop (isNat-isProp AB Cart P (mapPsh AB Vcat Cart G Q'))
               (funExt λ fr → adjNatInD (fst f fr) (fst k fr))
    ; adjNatInC  = λ {P'} {P} {Q} g h →
        Σ≡Prop (isNat-isProp AB Vcat (mapPsh AB Cart Vcat F P') Q)
               (funExt λ fr → adjNatInC (fst g fr) (fst h fr))
    }
    where
      psh-iso :
        (P : FiniteFramePresheaf AB Cart {ℓE} {ℓR})
        (Q : FiniteFramePresheaf AB Vcat {ℓE} {ℓR})
        → Iso (PshHom AB Vcat (mapPsh AB Cart Vcat F P) Q)
              (PshHom AB Cart P (mapPsh AB Vcat Cart G Q))
      psh-iso P Q = record
        { fun = λ fα → (λ fr → fst fα fr ♭) , natβ fα
        ; inv = λ gβ → (λ fr → fst gβ fr ♯) , natα gβ
        ; sec = λ gβ → Σ≡Prop (isNat-isProp AB Cart P (mapPsh AB Vcat Cart G Q))
                              (funExt λ fr → Iso.sec adjIso (fst gβ fr))
        ; ret = λ fα → Σ≡Prop (isNat-isProp AB Vcat (mapPsh AB Cart Vcat F P) Q)
                              (funExt λ fr → Iso.ret adjIso (fst fα fr))
        }
        where
          natβ :
            (fα : PshHom AB Vcat (mapPsh AB Cart Vcat F P) Q)
            → isNat AB Cart P (mapPsh AB Vcat Cart G Q) (λ fr → fst fα fr ♭)
          natβ (α , nα) {F'} {G'} φ =
              adjNatInC' (α G') (FiniteFramePresheaf.restrict P F' G' φ)
            ∙ cong _♭ (nα φ)
            ∙ adjNatInD (α F') (FiniteFramePresheaf.restrict Q F' G' φ)

          natα :
            (gβ : PshHom AB Cart P (mapPsh AB Vcat Cart G Q))
            → isNat AB Vcat (mapPsh AB Cart Vcat F P) Q (λ fr → fst gβ fr ♯)
          natα (β , nβ) {F'} {G'} φ =
              sym (adjNatInC (β G') (FiniteFramePresheaf.restrict P F' G' φ))
            ∙ cong _♯ (nβ φ)
            ∙ sym (adjNatInD' (β F') (FiniteFramePresheaf.restrict Q F' G' φ))
