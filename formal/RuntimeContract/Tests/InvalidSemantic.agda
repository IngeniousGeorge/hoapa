{-# OPTIONS --cubical --safe --guardedness #-}

-- Hand-authored conformance assertions: semantic-invalid fixtures decode as
-- raw data but must be rejected. `dupEvent` repeats an event id;
-- `forwardParent` references a parent not yet seen in event order (the
-- backward-by-list-position check).

module RuntimeContract.Tests.InvalidSemantic where

open import Cubical.Data.Bool using (false)
open import Cubical.Foundations.Prelude using (_≡_; refl)
open import RuntimeContract.Trace using (valid?)
open import RuntimeContract.Generated.Raw.InvalidSemantic.DupEvent
  using () renaming (term to dupEvent)
open import RuntimeContract.Generated.Raw.InvalidSemantic.ForwardParent
  using () renaming (term to forwardParent)
open import RuntimeContract.Generated.Raw.InvalidSemantic.WrongTraceFormat
  using () renaming (term to wrongFormat)

_ : valid? dupEvent ≡ false
_ = refl

_ : valid? forwardParent ≡ false
_ = refl

-- Unrecognized traceFormat is a semantic rejection (exercises the format clause).
_ : valid? wrongFormat ≡ false
_ = refl
