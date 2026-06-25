{-# OPTIONS --cubical --guardedness #-}

-- Brick 3a: the point-product reflector lands in point sheaves.
--
-- `SupportedPointification.pointify P` is a point sheaf, and (equivalently,
-- via the descent biconditional) point-local. This is the first genuine
-- theorem of the supported route — the first confirmation that the new
-- supported presheaf / descent / pointification stack composes, not just
-- typechecks in isolation.
--
-- Route (the one settled in discussion): prove `IsPointSheaf (pointify P)`
-- *directly* from the product structure of `value (pointify P) SF =
-- ∏_e P(pt_e)`, then derive `PointLocal` through the public
-- `SupportedPointDescent.sheaf→local`. This avoids the `cone` privacy wall
-- of a PointLocal-first proof and uses only the stable point-level
-- interface `SupportedPointification` exposes (`point-proj`,
-- `point-unwrap`, the unit triangle `point-unit`, and singleton-product
-- monicity `point-unwrap-mono`) — never the raw `cmp`/`ares`.
--
-- The two halves are short because the site is point-discrete:
--
--   * Separatedness is product joint-monicity. Two maps into `∏_e P(pt_e)`
--     agreeing after every point restriction `rπ` agree after every outer
--     projection `point-proj` (by the unit triangle), hence are equal
--     (`extE`).
--   * Amalgamation tuples the *unwrapped* parts: `s = ⟨ unwrap_e ∘ part_e
--     ⟩_e`. Each component check `rπ_i ∘ s = part_i` reduces — via the unit
--     triangle, `βE`, and singleton-product monicity — to a one-event
--     fact. Notably the matching family's *compatibility is never used*:
--     point patches do not meaningfully overlap, so each component is
--     independent. (That is exactly the point-discreteness the geometry
--     fix bought.)
--
-- Scope: relative to a value category `C` with finite products and an
-- arbitrary supported presheaf `P`; event level `ℓ-zero`, incidence `ℓA`.

module Concurrency.Hybrid.PointifyIsSheaf where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Sigma using (Σ-syntax ; _,_ ; fst ; snd)

open import Cubical.Categories.Category.Base using (Category)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Sites.EventSupported using (SupportedFiniteFrame)
open import Concurrency.Algebras.CategoryApplicative using (module ApplicativeView)
open import Concurrency.Algebras.FiniteProducts using (HasFiniteProducts)
open import Concurrency.Hybrid.SupportedPresheafCategory using (SupportedPresheaf)
open import Concurrency.Hybrid.SupportedPointProduct
  using (slotOf ; pt₀ ; pointTuple ; pointβ ; pointExt)
open import Concurrency.Hybrid.SupportedPointification
  using (pointify ; pt ; point-proj ; point-unwrap ; point-unit ; point-unwrap-mono)
open import Concurrency.Hybrid.SupportedPointDescent
  using ( IsPointSheaf ; PointSeparated ; PointAmalgamation ; PointMatchingFamily
        ; rπ ; Pat ; Idx ; PointLocal ; point-sheaf⟺local )

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓ ℓ' : Level} (C : Category ℓ ℓ') (FP : HasFiniteProducts C)
         (P : SupportedPresheaf AB C) where

  open ApplicativeView C

  private
    fin : SupportedFiniteFrame AB → FiniteFrame AB ℓ-zero ℓA
    fin = SupportedFiniteFrame.fin

    -- The reflector value.
    aP : SupportedPresheaf AB C
    aP = pointify AB C FP P

    val  = SupportedPresheaf.value aP
    valP = SupportedPresheaf.value P

    -- Pointification's exposed unit interface, specialised to P.
    prjP   = point-proj AB C FP P
    unwrap = point-unwrap AB C FP P
    unit   = point-unit AB C FP P
    uwmono = point-unwrap-mono AB C FP P

    -- Descent accessors at the reflector value `aP`.
    Ix = Idx AB C
    Pa = Pat AB C
    rp = rπ AB C aP

    -- The slot of the outer point product `val SF = ∏_e P(pt_e)`, exactly
    -- as `pointify` uses it (so the abstract `pointProduct` head matches).
    slP : (SF : SupportedFiniteFrame AB) → Ix SF → Ob
    slP = slotOf AB C FP P

  ----------------------------------------------------------------------
  -- Separatedness: product joint-monicity through the unit triangle.
  ----------------------------------------------------------------------

  separated-aP : PointSeparated AB C aP
  separated-aP = record { cover-jointly-monic = cjm }
    where
      cjm : (SF : SupportedFiniteFrame AB) {X : Ob}
            (x y : Hom X (val SF))
          → ((i : Ix SF) → rp SF i ∘ x ≡ rp SF i ∘ y) → x ≡ y
      cjm SF {X} x y hyp =
        pointExt AB C FP SF (slP SF) x y per
        where
          per : (i : Ix SF) → prjP SF i ∘ x ≡ prjP SF i ∘ y
          per i =
              cong (_∘ x) (sym (unit SF i))
            ∙ ∘-assoc (unwrap SF i) (rp SF i) x
            ∙ cong (unwrap SF i ∘_) (hyp i)
            ∙ sym (∘-assoc (unwrap SF i) (rp SF i) y)
            ∙ cong (_∘ y) (unit SF i)

  ----------------------------------------------------------------------
  -- Amalgamation: tuple the unwrapped parts; check each component by
  -- singleton-product monicity. Compatibility of the family is unused.
  ----------------------------------------------------------------------

  amalgamating-aP : PointAmalgamation AB C aP
  amalgamating-aP = record { amalgamate = am }
    where
      am : (SF : SupportedFiniteFrame AB) {X : Ob}
           (m : PointMatchingFamily AB C aP SF X)
         → Σ[ s ∈ Hom X (val SF) ]
             ((i : Ix SF) → rp SF i ∘ s ≡ PointMatchingFamily.part m i)
      am SF {X} m = s , restr
        where
          part : (i : Ix SF) → Hom X (val (Pa SF i))
          part = PointMatchingFamily.part m

          s : Hom X (val SF)
          s = pointTuple AB C FP SF (slP SF) {X = X}
                    (λ e → unwrap SF e ∘ part e)

          restr : (i : Ix SF) → rp SF i ∘ s ≡ part i
          restr i = uwmono SF i (rp SF i ∘ s) (part i) eq
            where
              eq : unwrap SF i ∘ (rp SF i ∘ s) ≡ unwrap SF i ∘ part i
              eq =
                  sym (∘-assoc (unwrap SF i) (rp SF i) s)
                ∙ cong (_∘ s) (unit SF i)
                ∙ pointβ AB C FP SF (slP SF)
                       (λ e → unwrap SF e ∘ part e) i

  ----------------------------------------------------------------------
  -- The two theorems.
  ----------------------------------------------------------------------

  pointify-is-point-sheaf : IsPointSheaf AB C aP
  pointify-is-point-sheaf = record
    { separated    = separated-aP
    ; amalgamating = amalgamating-aP
    }

  pointify-point-local : PointLocal AB C FP aP
  pointify-point-local =
    fst (point-sheaf⟺local AB C FP aP) pointify-is-point-sheaf
