{-# OPTIONS --cubical --guardedness #-}

-- Codex draft: raw cyclic syntax with a cyclic port action.
--
-- This file deliberately does not claim associativity. It gives the first
-- executable layer: one binary generator, gluing composition for positive
-- arities, and a cyclic action on the ports of each operation.
--
-- The cyclic action is named `rotate`. It is not an involution. For an
-- operation of arity n, it is a cyclic action on suc n ports. Session
-- duality is the later involutive structure on algebras, not part of this
-- operad-syntax layer.
--
-- The syntax is set-truncated. This keeps the first Concurrency-side
-- object in ordinary set-valued operad territory; infinity-enrichment can
-- be added later as an explicit upgrade rather than smuggled in by
-- untracked higher paths.

module Concurrency.Operads.codex_RawCyclicOperad where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv
open import Cubical.Foundations.Isomorphism
open import Cubical.Data.Fin.Arithmetic using (_+ₘ_ ; -ₘ_ ; +ₘ-rCancel ; +ₘ-lCancel)
open import Cubical.Data.Nat using (ℕ ; suc)

open import Concurrency.Operads.codex_Ports

private
  variable
    left right : ℕ

------------------------------------------------------------------------
-- Raw syntax
------------------------------------------------------------------------

data RawOperation : ℕ → Type₀ where
  binary-generator : RawOperation 2

  compose :
    {left right : ℕ}
    → Port (suc left)
    → Port (suc right)
    → RawOperation (suc left)
    → RawOperation (suc right)
    → RawOperation (composed-arity left right)

  rotate :
    (arity : ℕ)
    → Port arity
    → RawOperation arity
    → RawOperation arity

  rotate-zero :
    (arity : ℕ)
    (operation : RawOperation arity)
    → rotate arity first-port operation ≡ operation

  rotate-compose :
    (arity : ℕ)
    (first second : Port arity)
    (operation : RawOperation arity)
    → rotate arity first (rotate arity second operation)
    ≡ rotate arity (first +ₘ second) operation

  raw-operation-is-set :
    (arity : ℕ)
    → isSet (RawOperation arity)

------------------------------------------------------------------------
-- Rotation packaged as an equivalence
------------------------------------------------------------------------

rotate-equivalence :
  (arity : ℕ)
  → Port arity
  → RawOperation arity ≃ RawOperation arity
rotate-equivalence arity port = isoToEquiv the-iso
  where
    forward : RawOperation arity → RawOperation arity
    forward = rotate arity port

    backward : RawOperation arity → RawOperation arity
    backward = rotate arity (-ₘ port)

    right-inverse : (operation : RawOperation arity)
      → forward (backward operation) ≡ operation
    right-inverse operation =
        rotate-compose arity port (-ₘ port) operation
      ∙ cong (λ index → rotate arity index operation) (+ₘ-rCancel port)
      ∙ rotate-zero arity operation

    left-inverse : (operation : RawOperation arity)
      → backward (forward operation) ≡ operation
    left-inverse operation =
        rotate-compose arity (-ₘ port) port operation
      ∙ cong (λ index → rotate arity index operation) (+ₘ-lCancel port)
      ∙ rotate-zero arity operation

    the-iso : Iso (RawOperation arity) (RawOperation arity)
    the-iso = iso forward backward right-inverse left-inverse

------------------------------------------------------------------------
-- Small witnesses
------------------------------------------------------------------------

generator : RawOperation 2
generator = binary-generator

rotated-generator : RawOperation 2
rotated-generator = rotate 2 second-port generator

generator-composed-with-generator : RawOperation 3
generator-composed-with-generator =
  compose first-port first-port generator generator

