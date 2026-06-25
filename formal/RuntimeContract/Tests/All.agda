{-# OPTIONS --cubical --safe --guardedness #-}

-- Aggregate conformance suite for the formal half of contract loop 1.
-- Typechecking this module is the formal test runner: green here means the
-- generated raw terms agree with `valid?` across all v0 fixtures.

module RuntimeContract.Tests.All where

open import RuntimeContract.Tests.Valid
open import RuntimeContract.Tests.InvalidSemantic
