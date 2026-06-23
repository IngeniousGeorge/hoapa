{-# OPTIONS --cubical --guardedness #-}

-- Postulate-free core of the session-type grammar: the `SessionType`
-- formers, the structural duality `_^⊥ₛ`, and the proof that duality is
-- involutive (the syntactic face of R8).
--
-- This was extracted verbatim from `Concurrency/Algebras/Sessions.agda`,
-- which now re-imports it, so there is a single object grammar shared by
-- the syntactic `Sessions-Cat` and any semantic interpretation (e.g. the
-- Sessions-to-Chu realization `J0`). Keeping the object grammar here —
-- away from `Sessions.agda`'s postulated categorical `Hom` laws and `O_1`
-- action — lets a semantic interpreter import the grammar without pulling
-- in any postulate.
--
-- What is deliberately NOT here: the categorical `Hom`, the
-- `SessionO1Action`, `session-interp`, and the additive-product universal
-- property. Those stay in `Sessions.agda`. Only the type formers, duality,
-- and `dual-involutive` live here.

module Concurrency.Algebras.SessionSyntax where

open import Cubical.Foundations.Prelude

module Syntax {ℓv : Level} (Payload : Type ℓv) where

  ------------------------------------------------------------------------
  -- Session-type syntax.
  ------------------------------------------------------------------------

  data SessionType : Type ℓv where
    end  : SessionType
    send : Payload → SessionType → SessionType
    recv : Payload → SessionType → SessionType
    _⊗_  : SessionType → SessionType → SessionType
    _⅋_  : SessionType → SessionType → SessionType
    𝟙ₛ   : SessionType
    ⊥ₛ   : SessionType
    -- Additives (B2(a) descent enrichment, 2026-06-04). `&ₛ`/`⊤ₛ` are
    -- the additive product / its unit; `⊕ₛ`/`𝟘ₛ` are their De Morgan
    -- duals — present as *objects* so that `_^⊥ₛ` stays total and
    -- involutive. The additive coproduct universal property is *not*
    -- asserted here (matching `FiniteProducts.agda` D6).
    _&ₛ_ : SessionType → SessionType → SessionType
    _⊕ₛ_ : SessionType → SessionType → SessionType
    ⊤ₛ   : SessionType
    𝟘ₛ   : SessionType

  ------------------------------------------------------------------------
  -- Duality.
  ------------------------------------------------------------------------

  _^⊥ₛ : SessionType → SessionType
  end       ^⊥ₛ = end
  send P S  ^⊥ₛ = recv P (S ^⊥ₛ)
  recv P S  ^⊥ₛ = send P (S ^⊥ₛ)
  (S ⊗ T)   ^⊥ₛ = (S ^⊥ₛ) ⅋ (T ^⊥ₛ)
  (S ⅋ T)   ^⊥ₛ = (S ^⊥ₛ) ⊗ (T ^⊥ₛ)
  𝟙ₛ        ^⊥ₛ = ⊥ₛ
  ⊥ₛ        ^⊥ₛ = 𝟙ₛ
  (S &ₛ T)  ^⊥ₛ = (S ^⊥ₛ) ⊕ₛ (T ^⊥ₛ)
  (S ⊕ₛ T)  ^⊥ₛ = (S ^⊥ₛ) &ₛ (T ^⊥ₛ)
  ⊤ₛ        ^⊥ₛ = 𝟘ₛ
  𝟘ₛ        ^⊥ₛ = ⊤ₛ

  ------------------------------------------------------------------------
  -- Duality is involutive (the syntactic face of R8).
  ------------------------------------------------------------------------

  dual-involutive : (S : SessionType) → (S ^⊥ₛ) ^⊥ₛ ≡ S
  dual-involutive end        = refl
  dual-involutive (send P S) = cong (send P) (dual-involutive S)
  dual-involutive (recv P S) = cong (recv P) (dual-involutive S)
  dual-involutive (S ⊗ T)    = cong₂ _⊗_ (dual-involutive S) (dual-involutive T)
  dual-involutive (S ⅋ T)    = cong₂ _⅋_ (dual-involutive S) (dual-involutive T)
  dual-involutive 𝟙ₛ         = refl
  dual-involutive ⊥ₛ         = refl
  dual-involutive (S &ₛ T)   = cong₂ _&ₛ_ (dual-involutive S) (dual-involutive T)
  dual-involutive (S ⊕ₛ T)   = cong₂ _⊕ₛ_ (dual-involutive S) (dual-involutive T)
  dual-involutive ⊤ₛ         = refl
  dual-involutive 𝟘ₛ         = refl
