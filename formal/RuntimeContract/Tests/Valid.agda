{-# OPTIONS --cubical --safe --guardedness #-}

-- Hand-authored conformance assertions: valid fixtures must be accepted.
-- The generated raw terms are data only; the polarity lives here.

module RuntimeContract.Tests.Valid where

open import Cubical.Data.Bool using (true)
open import Cubical.Foundations.Prelude using (_≡_; refl)
open import RuntimeContract.Trace using (valid?)
open import RuntimeContract.Generated.Raw.Valid.TinyTrace using (term)

_ : valid? term ≡ true
_ = refl
