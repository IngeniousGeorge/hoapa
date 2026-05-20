{-# OPTIONS --cubical --guardedness #-}

-- Hybrid layer: the session-valued specialization of Adapter 1.
--
-- This file specializes the generic frame-presheaf chassis in
-- `Concurrency/Hybrid/Presheaf.agda` to the *-autonomous target
-- `Sessions-Cat Payload` from `Concurrency/Algebras/Sessions.agda`,
-- and ships the two named constant inhabitants at the tensor unit
-- `𝟙ₛ` and the dualizing object `⊥ₛ` (best-of-both-worlds, Q3
-- resolution).
--
-- Adapter framing. This file is *not* a sheaf module. It is the
-- session-side instance of Adapter 1 (Restriction) from the Hybrid
-- adapter layer. The full adapter list — Descent, Unit/Dualizing
-- Bridge, Operadic Valuation, Promotion, Allow ⊣ Require, No-Leak —
-- is documented in `Presheaf.agda`'s header; this file inherits that
-- catalogue and adds no new slots.
--
-- Best-of-both-worlds (Q3). Both `const-𝟙ₛ-presheaf` and
-- `const-⊥ₛ-presheaf` are shipped as inhabitants; neither is
-- privileged as "the" constant presheaf. Reading:
--
--   * `𝟙ₛ` — tensor unit. The neutral / "no demanded interaction"
--     assignment, natural on the actor side.
--   * `⊥ₛ` — dualizing object (par unit). Matches the codomain choice
--     in `Concurrency/Algebras/Valuation.agda` and
--     `OperadAlgebra.agda` (R7 commitment); natural on the session /
--     operadic side.
--
-- A *-autonomous category gives `⊥ₛ ≡ 𝟙ₛ ^⊥ₛ` definitionally
-- (`⊥-par = 𝟙 ^⊥` in `StarAutonomous`), but that is duality, not a
-- canonical morphism between them. Any actual `Hom 𝟙ₛ ⊥ₛ` or
-- `Hom ⊥ₛ 𝟙ₛ` belongs to Adapter 3 (Unit/Dualizing Bridge), deferred.
-- v1 keeps the two readings as separate inhabitants and does not
-- smuggle a conversion.
--
-- Scope guardrails. Same as `Presheaf.agda`: no operad imports
-- (`gen`, `plug`, `shift` belong to Adapter 4), no payload metadata
-- on actors, no promotion. The session-side imports of `SessionType`
-- / `Sessions-Cat` are confined to this file; the chassis stays
-- generic.

module Concurrency.Hybrid.SessionPresheaf where

open import Cubical.Foundations.Prelude

open import Concurrency.Sites.ActorBase
  using ( ActorBase )
open import Concurrency.Algebras.StarAutonomous
  using ( StarAutonomous )
open import Concurrency.Algebras.Sessions
  using ( Sessions-Cat )
open import Concurrency.Hybrid.Presheaf
  using ( FramePresheaf ; IsSeparatedPresheaf ; const-presheaf )

------------------------------------------------------------------------
-- Module parameterization.
--
-- A session-valued presheaf is specified by:
--   * an `ActorBase` AB (the opaque actor carrier);
--   * a payload type `Payload : Type ℓv` (the message-content
--     parameter of session syntax);
--   * a Hom-level `ℓ'` (the second universe of `Sessions-Cat`).
--
-- The frame-category levels `ℓE, ℓR` and cover-index level `ℓI` stay
-- record-local.
------------------------------------------------------------------------

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓv ℓ' : Level} (Payload : Type ℓv) where

  ----------------------------------------------------------------------
  -- SessionsV: the chosen *-autonomous target.
  --
  -- `Sessions-Cat` from `Concurrency/Algebras/Sessions.agda` packages
  -- `SessionType`, `Hom`, the symmetric monoidal structure, and the
  -- involutive duality into a `StarAutonomous` record. We expose it
  -- here under a short local name so the rest of the file reads as
  -- "the session-side presheaf is a `FramePresheaf` over
  -- `SessionsV`."
  ----------------------------------------------------------------------

  SessionsV : StarAutonomous ℓv (ℓ-max ℓv ℓ')
  SessionsV = Sessions-Cat {ℓ' = ℓ'} Payload

  ----------------------------------------------------------------------
  -- SessionPresheaf: session-valued presheaf over the actor-causal
  -- frame category.
  --
  -- A definitional alias; no new content beyond instantiating the
  -- generic chassis. Sessions-specific structure (tensor, duality,
  -- linear connectives) is inherited through `SessionsV`'s
  -- `StarAutonomous` interface.
  ----------------------------------------------------------------------

  SessionPresheaf : {ℓE ℓR : Level}
    → Type (ℓ-suc (ℓ-max ℓA
                    (ℓ-max ℓE
                      (ℓ-max ℓR (ℓ-max ℓv ℓ')))))
  SessionPresheaf {ℓE} {ℓR} = FramePresheaf AB SessionsV {ℓE} {ℓR}

  IsSeparatedSessionPresheaf :
    {ℓE ℓR ℓI : Level}
    → SessionPresheaf {ℓE} {ℓR}
    → Type (ℓ-suc (ℓ-max ℓA
                    (ℓ-max ℓE
                      (ℓ-max ℓR
                        (ℓ-max ℓI (ℓ-max ℓv ℓ'))))))
  IsSeparatedSessionPresheaf {ℓE} {ℓR} {ℓI} P =
    IsSeparatedPresheaf AB SessionsV {ℓE} {ℓR} {ℓI} P

  ----------------------------------------------------------------------
  -- Constant session presheaves at 𝟙ₛ and ⊥ₛ.
  --
  -- `const-𝟙ₛ-presheaf` assigns the tensor unit `𝟙ₛ` to every frame
  -- and the identity morphism on `𝟙ₛ` to every FrameHom. Reading:
  -- "no demanded interaction at any local view."
  --
  -- `const-⊥ₛ-presheaf` assigns the dualizing object `⊥ₛ` (computed
  -- as `𝟙 ^⊥` in `StarAutonomous`, which unfolds in `Sessions-Cat`
  -- to the session `⊥ₛ` constructor via `_^⊥ₛ`'s clause for `𝟙ₛ`).
  -- Reading: "canonical sink for operadic interpretation."
  --
  -- Both are built by passing the chosen object to the generic
  -- `const-presheaf` combinator. Functoriality discharges as in the
  -- generic case (`refl` and `sym (id-l id)`).
  ----------------------------------------------------------------------

  const-𝟙ₛ-presheaf : {ℓE ℓR : Level} → SessionPresheaf {ℓE} {ℓR}
  const-𝟙ₛ-presheaf =
    const-presheaf AB SessionsV (StarAutonomous.𝟙 SessionsV)

  const-⊥ₛ-presheaf : {ℓE ℓR : Level} → SessionPresheaf {ℓE} {ℓR}
  const-⊥ₛ-presheaf =
    const-presheaf AB SessionsV (StarAutonomous.⊥-par SessionsV)
