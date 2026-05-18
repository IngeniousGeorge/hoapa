{-# OPTIONS --cubical --guardedness #-}

-- Codex draft: the associative/equivariance frontier for the cyclic
-- associative operad.
--
-- This file intentionally imports the raw syntax rather than redefining it.
-- In a final merged version, the laws below should either become path
-- constructors of the higher-inductive presentation or be replaced by a
-- quotient/initiality construction. For now they are postulated and clearly
-- isolated, because the missing work is exactly the finite-port reindexing
-- described in `codex_Ports.agda`.
--
-- This file therefore earns only the status "Codex scaffold for the
-- cyclic-associative layer", not a completed formalization.

module Concurrency.Operads.codex_CyclicAssociative where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Nat using (ℕ ; suc)

open import Concurrency.Operads.codex_Ports
open import Concurrency.Operads.codex_RawCyclicOperad

private
  variable
    left right third : ℕ

------------------------------------------------------------------------
-- Sequential associativity frontier
------------------------------------------------------------------------

-- Reading:
--   first compose `left-operation` with `right-operation`;
--   then compose the result with `third-operation` at a port that came
--   from the right operation.
--
-- The right-hand side first composes right with third, then composes left
-- with that composite. The extra ports are placeholders for the reindexed
-- ports that a real implementation must compute.
postulate
  compose-associative-sequential :
    (left-port : Port (suc left))
    (right-port : Port (suc right))
    (outer-port : Port (composed-arity left right))
    (third-port : Port (suc third))
    (right-port-after-reindex : Port (suc right))
    (third-port-after-reindex : Port (suc third))
    (right-third-composite-port : Port (composed-arity right third))
    (left-operation : RawOperation (suc left))
    (right-operation : RawOperation (suc right))
    (third-operation : RawOperation (suc third))
    → PathP
        (λ i → RawOperation (sequential-composed-arity left right third i))
        (compose outer-port third-port
          (compose left-port right-port left-operation right-operation)
          third-operation)
        (compose left-port right-third-composite-port
          left-operation
          (compose right-port-after-reindex third-port-after-reindex
            right-operation third-operation))

------------------------------------------------------------------------
-- Parallel associativity frontier
------------------------------------------------------------------------

-- Reading:
--   first compose left with right; then compose third into a port that
--   came from the left operation, not the right operation.
--
-- The right-hand side composes left with third first, then composes the
-- result with right. Again, the additional ports stand for the reindexed
-- ports to be computed by the final port-bookkeeping layer.
postulate
  compose-associative-parallel :
    (left-port : Port (suc left))
    (right-port : Port (suc right))
    (outer-port : Port (composed-arity left right))
    (third-port : Port (suc third))
    (left-port-after-reindex : Port (suc left))
    (third-port-after-reindex : Port (suc third))
    (left-third-composite-port : Port (composed-arity left third))
    (right-port-after-reindex : Port (suc right))
    (left-operation : RawOperation (suc left))
    (right-operation : RawOperation (suc right))
    (third-operation : RawOperation (suc third))
    → PathP
        (λ i → RawOperation (parallel-composed-arity left right third i))
        (compose outer-port third-port
          (compose left-port right-port left-operation right-operation)
          third-operation)
        (compose left-third-composite-port right-port-after-reindex
          (compose left-port-after-reindex third-port-after-reindex
            left-operation third-operation)
          right-operation)

------------------------------------------------------------------------
-- Rotation/composition equivariance frontier
------------------------------------------------------------------------

-- A final cyclic-operad presentation must say that rotating a composite is
-- the same as composing the appropriately rotated and reindexed pieces.
-- The precise statement depends on the same port-splitting functions as
-- associativity, so this scaffold states the intended shape and leaves the
-- reindexing data explicit.
postulate
  rotate-compose-equivariant :
    (left-port : Port (suc left))
    (right-port : Port (suc right))
    (rotation : Port (composed-arity left right))
    (left-rotation : Port (suc left))
    (right-rotation : Port (suc right))
    (left-port-after-reindex : Port (suc left))
    (right-port-after-reindex : Port (suc right))
    (left-operation : RawOperation (suc left))
    (right-operation : RawOperation (suc right))
    → rotate (composed-arity left right) rotation
        (compose left-port right-port left-operation right-operation)
    ≡ compose left-port-after-reindex right-port-after-reindex
        (rotate (suc left) left-rotation left-operation)
        (rotate (suc right) right-rotation right-operation)

