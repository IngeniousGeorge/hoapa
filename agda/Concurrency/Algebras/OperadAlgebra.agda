{-# OPTIONS --cubical --guardedness #-}

-- Algebras of the cyclic associative operad O_1 in a *-autonomous target.
--
-- An `OperadAlgebra T` extends a `Valuation T` with the structural
-- commitments that make it a genuine operad-over-algebra rather than a
-- "any consistent interpretation":
--
--   * `plug`, the operation-on-interpretations corresponding to
--     operadic substitution. Given the interpretations of two operands
--     and the gluing ports, it produces the interpretation of the
--     composite — entirely in the target category, no reference to
--     `O`.
--   * `shift`, the operation-on-interpretations corresponding to the
--     cyclic action. Given a port-rotation amount and the
--     interpretation of an operation, it produces the interpretation
--     of the rotated operation.
--   * Structural axioms `interp-compₒ` and `interp-rot` pinning the
--     valuation's `⟦_⟧` to factor through `plug` and `shift`.
--   * `boundary-swap-structural`, the derived theorem combining the
--     structural axioms with the operad's `boundary-swap`. This is
--     the categorical R8-relevant identity: boundary-rotation of a
--     plugged composite equals the operand-swapped plug (over the
--     arity commutation). The arity-2 instance is Sessions.agda's
--     session-type-duality witness.
--
-- This is "Step 2" of the refactor (decision 2026-05-19): plug and
-- shift are *fields* of the algebra record, supplied by each concrete
-- instance (e.g. Sessions.agda from the session-typed *-autonomous
-- category). The full derivation from `StarAutonomous` — building
-- `plug` from self-duality + tensor and `shift` from braiding +
-- associator generically — is "Step 3," deferred until `MO_1` enters
-- scope. Upgrading Step 2 → Step 3 later is mechanical: the auxiliary
-- fields become defined operations, the structural axioms become
-- theorems.
--
-- R8 bridge: at every (l, r), combining the structural axioms with
-- the operad's `boundary-swap` theorem yields a categorical identity
-- relating `plug` and `shift` over `+-comm l r`. The arity-2 case
-- (`a = b = gen`) is where session-type duality lands in
-- Sessions.agda. The derivation is materialized below as
-- `boundary-swap-structural`.
--
-- Scope of plug and shift: at Step 2 these are *auxiliary categorical
-- handles for factoring `⟦_⟧`*, not generic target-category operations.
-- The structural axioms constrain them only on the image of `⟦_⟧`. On
-- morphisms outside that image, `shift i m` and `plug i j m m'` are
-- unconstrained — there is no standalone associativity, group-action,
-- or unit law. If a downstream call site uses plug or shift on
-- non-interpretation morphisms, the laws it relies on should be added
-- as fields then. At Step 3 these laws will be derived consequences
-- of the (then-derived) plug and shift definitions.

module Concurrency.Algebras.OperadAlgebra where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Nat              using (ℕ ; suc ; _+_)
open import Cubical.Data.Nat.Properties   using (+-comm)

open import Concurrency.Operads.Ports
open import Concurrency.Operads.CyclicAssociative
  using ( O ; compₒ ; rot ; boundary-swap )
open import Concurrency.Operads.PortRotation
  using ( boundary-rot )
open import Concurrency.Algebras.StarAutonomous
open import Concurrency.Algebras.Valuation
  using ( Valuation ; ports )

module _ {ℓ ℓ' : Level} (T : StarAutonomous ℓ ℓ') where
  open StarAutonomous T

  record OperadAlgebra : Type (ℓ-max ℓ ℓ') where
    field
      valuation : Valuation T

    open Valuation valuation public

    field
      -- plug: the operation on interpretations corresponding to
      -- operadic substitution. Takes the interpretations of two
      -- operands (`a`-interpretation, `b`-interpretation) plus the
      -- gluing ports, produces the interpretation of `compₒ i j a b`.
      plug :
          {l r : ℕ}
          (i : Port (suc l)) (j : Port (suc r))
        → Hom (ports T Carrier (suc l)) ⊥-par
        → Hom (ports T Carrier (suc r)) ⊥-par
        → Hom (ports T Carrier (suc (l + r))) ⊥-par

      -- shift: the operation on interpretations corresponding to the
      -- cyclic action. Takes a port-rotation amount and an
      -- interpretation; produces the rotated interpretation.
      shift :
          {n : ℕ} (i : Port n)
        → Hom (ports T Carrier n) ⊥-par
        → Hom (ports T Carrier n) ⊥-par

      -- Structural axiom: the valuation's interpretation of `compₒ`
      -- factors through `plug`.
      interp-compₒ :
          {l r : ℕ}
          (i : Port (suc l)) (j : Port (suc r))
          (a : O (suc l)) (b : O (suc r))
        → ⟦ compₒ i j a b ⟧ ≡ plug i j ⟦ a ⟧ ⟦ b ⟧

      -- Structural axiom: the valuation's interpretation of `rot`
      -- factors through `shift`.
      interp-rot :
          {n : ℕ} (i : Port n) (a : O n)
        → ⟦ rot i a ⟧ ≡ shift i ⟦ a ⟧

    ----------------------------------------------------------------
    -- Boundary-swap, structural form.
    --
    -- Combining the structural axioms with the operad's `boundary-swap`
    -- theorem yields a categorical identity in the target between
    -- `plug` and `shift`: boundary-rotation of a plugged composite
    -- equals the operand-swapped plugged composite (over `+-comm l r`).
    -- This is the R8-relevant theorem; the arity-2 instance (a = b =
    -- gen) is where Sessions.agda will read off session-type duality.
    --
    -- Proof structure: prepend a plain path from
    -- `shift (boundary-rot l r) (plug i j ⟦a⟧ ⟦b⟧)` to
    -- `⟦ rot (boundary-rot l r) (compₒ i j a b) ⟧` (built from the
    -- structural axioms applied to the LHS), append `interp-compₒ j i b a`
    -- to the RHS, and put `congP ⟦_⟧ boundary-swap` in the middle.
    ----------------------------------------------------------------

    boundary-swap-structural :
        {l r : ℕ}
        (i : Port (suc l)) (j : Port (suc r))
        (a : O (suc l)) (b : O (suc r))
      → PathP (λ ι → Hom (ports T Carrier (suc (+-comm l r ι))) ⊥-par)
          (shift (boundary-rot l r) (plug i j ⟦ a ⟧ ⟦ b ⟧))
          (plug j i ⟦ b ⟧ ⟦ a ⟧)
    boundary-swap-structural {l} {r} i j a b =
        pre ◁ congP (λ _ → ⟦_⟧) (boundary-swap i j a b) ▷ interp-compₒ j i b a
      where
        pre :
            shift (boundary-rot l r) (plug i j ⟦ a ⟧ ⟦ b ⟧)
              ≡ ⟦ rot (boundary-rot l r) (compₒ i j a b) ⟧
        pre =
            cong (shift (boundary-rot l r)) (sym (interp-compₒ i j a b))
          ∙ sym (interp-rot (boundary-rot l r) (compₒ i j a b))
