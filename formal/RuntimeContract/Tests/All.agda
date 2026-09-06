{-# OPTIONS --cubical --safe --guardedness #-}

-- Aggregate conformance suite for the substrate-free, `--safe`
-- raw-contract layer. Realization-level tests that import the guarded
-- actor-causal substrate are wired separately through the Makefile.
--
-- Green here means the generated raw terms agree with `valid?` across all
-- v0 fixtures, and with the optional per-fixture properties asserted
-- alongside it.
--
-- `Valid` and `InvalidSemantic` carry the verdict the corpus directories
-- encode. `ConversationCoverage` carries a property that is not
-- well-formedness, which is why it is a separate module rather than extra
-- assertions in `Valid`. `ActorRenaming` carries the degeneracy controls
-- for actor relabeling.

module RuntimeContract.Tests.All where

open import RuntimeContract.Tests.Valid
open import RuntimeContract.Tests.InvalidSemantic
open import RuntimeContract.Tests.ConversationCoverage
open import RuntimeContract.Tests.ActorRenaming
