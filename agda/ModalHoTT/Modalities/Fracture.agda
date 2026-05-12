{-# OPTIONS --cubical --guardedness #-}

-- The fracture theorem for cohesive HoTT.
--
-- For any type A, the canonical square
--
--     ♭A ————→ A
--      |        |
--      ↓        ↓
--     ♭(♯A) ——→ ♯A
--
-- is a pullback. Going right then down sends v : ♭A to sharp-unit (flat-counit v);
-- going down then right sends v to flat-counit (flat-map sharp-unit v). The two
-- agree by naturality of flat-counit at sharp-unit (Properties.flat-counit-natural),
-- giving the commutativity of the square as a derived theorem. The pullback claim
-- — that ♭A is equivalent to the limit — is the one new postulate in this file.
--
-- Status of `fracture` as a postulate:
--
--   In real-cohesive HoTT, fracture is a theorem, derived from ♯ being a lex
--   modality (preserves finite limits). We do not postulate ♯-lex separately;
--   we postulate the specific pullback equivalence we need. Same register as
--   the `flat-intro` crisp-context note in Cohesion.agda — a known meta-fact
--   shortcut, not a deeper independent claim. See `status.md` Open Questions
--   for the ♯-lex entry that would discharge this postulate, and the
--   companion entry on naturality of `fracture` in A.
--
-- Synthetic/analytic asymmetry:
--
--   `fracture` quantifies over all types, including Bℤ. Applied at A := Bℤ it
--   makes its strongest claim — exactly where the analytic side cannot reach:
--   `♯(Bℤ)` is undefined in `Analytic.ModalHoTT.Modalities.Cohesion` (no
--   cubical construction for the codiscrete reflection of Bℤ; see that file's
--   sharp-for-Bℤ comment block). So the analytic test suite verifies fracture
--   at ℤ only; the Bℤ instance is a synthetic-only commitment. This is the
--   sharpest synthetic/analytic divergence in the project to date.

module ModalHoTT.Modalities.Fracture where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv

open import ModalHoTT.Modalities.Cohesion
open import ModalHoTT.Modalities.Properties

private
  variable
    ℓ : Level

------------------------------------------------------------------------
-- The pullback type
--
-- The limit of the cospan  A → ♯A ← ♭(♯A), unfolded as a nested Σ.
-- A point of the pullback is: a point a of A, a point u of ♭(♯A), and
-- a path witnessing that the two project to the same point of ♯A.
------------------------------------------------------------------------

FracturePullback : Type ℓ → Type ℓ
FracturePullback A =
  Σ[ a ∈ A ] Σ[ u ∈ FlatModality (SharpModality A) ]
    sharp-unit a ≡ flat-counit u

------------------------------------------------------------------------
-- Commutativity of the square
--
-- The square commutes by naturality of flat-counit at sharp-unit:
-- the down-then-right path is `flat-counit (flat-map sharp-unit v)`,
-- and `flat-counit-natural` rewrites it to `sharp-unit (flat-counit v)`,
-- the right-then-down path. We take `sym` to orient the path as the
-- pullback type expects (`sharp-unit a ≡ flat-counit u`).
------------------------------------------------------------------------

fracture-square-commutes : (A : Type ℓ) (v : FlatModality A)
  → sharp-unit (flat-counit v) ≡ flat-counit (flat-map sharp-unit v)
fracture-square-commutes A v = sym (flat-counit-natural sharp-unit v)

------------------------------------------------------------------------
-- The canonical map ♭A → FracturePullback A
--
-- Sends v : ♭A to its image under the two projections of the square,
-- packaged with the commutativity witness. The fracture theorem says
-- this specific map is an equivalence — pinning the map matters, since
-- a bare ≃ between ♭A and the pullback type would not constrain which
-- mediating map realizes it.
------------------------------------------------------------------------

flat-to-pullback : (A : Type ℓ) → FlatModality A → FracturePullback A
flat-to-pullback A v =
  flat-counit v , flat-map sharp-unit v , fracture-square-commutes A v

------------------------------------------------------------------------
-- The fracture axiom
--
-- The one new postulate in this file. Theorem in real-cohesive HoTT
-- (♯ lex); axiom here. See file header for the framing.
------------------------------------------------------------------------

postulate
  fracture : (A : Type ℓ) → isEquiv (flat-to-pullback A)

------------------------------------------------------------------------
-- The equivalence form
--
-- Packaged from `flat-to-pullback` and `fracture`. No new content; offered
-- as a convenience for downstream callers that want the ≃ shape directly.
------------------------------------------------------------------------

fracture-equiv : (A : Type ℓ) → FlatModality A ≃ FracturePullback A
fracture-equiv A = flat-to-pullback A , fracture A
