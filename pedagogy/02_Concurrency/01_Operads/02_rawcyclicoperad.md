# RawCyclicOperad.agda — generated cyclic syntax before the laws

## Where this file sits

`agda/Concurrency/Operads/RawCyclicOperad.agda` is the first file where the operad itself appears. `00_cyclic_operads_intro.md` gave the common picture: one binary generator, three cyclic ports, substitution by gluing, and rotation by modular port offsets. `01_ports.md` made the port arithmetic available in Agda.

This file now defines the raw syntax:

- `gen`, the single binary generator;
- `compₒ`, substitution at chosen ports;
- `rot`, cyclic rotation;
- `rot-zero` and `rot-compose`, the group-action laws for rotation;
- `trunc`, the set-truncation constructor.

"Raw" means substitution exists, but the full substitution laws are not installed yet. Associativity and cyclic equivariance need heavier port reindexing, so they wait for later files.

## Chunk 1 — pragma, module, and imports

```agda
{-# OPTIONS --cubical --guardedness #-}

module Concurrency.Operads.RawCyclicOperad where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Isomorphism using (Iso ; iso ; isoToEquiv)
open import Cubical.Foundations.Equiv       using (_≃_ ; equivFun)
open import Cubical.Data.Nat                using (ℕ ; suc ; _+_)

open import Concurrency.Operads.Ports
```

The imports say what this file will do. `Prelude` gives the basic path/equality tools and proof-chain notation. `Isomorphism` and `Equiv` are needed because the file proves that rotating by a fixed port offset is an equivalence. Natural numbers provide arities and arity addition.

The project import is the real dependency: `Concurrency.Operads.Ports`. That brings in `Port`, `_+ₘ_`, `fzero`, `fsuc`, `port-inv`, and the cancellation laws from the previous file.

## Chunk 2 — the file's own preamble

```agda
-- The raw cyclic operad on one binary generator.
--
-- "Raw" = the syntactic and cyclic-action layer of the cyclic
-- associative operad. The associativity laws (sequential and parallel)
-- and the compatibility of the cyclic action with substitution
-- (rotate-comp equivariance) both require port-reindexing machinery
-- and live in Concurrency/Operads/CyclicAssociative.agda. This file
-- presents the generator, substitution, cyclic action, and the
-- cyclic action's group laws — the structure that doesn't yet
-- involve port-reindexing.
--
-- Semantic background: the smallest cyclic operad capable of naming
-- the actor/session interaction primitive. One binary operation
-- (`gen`); planar / cyclic-associative (not fully symmetric); a
-- ℤ/(n+1) cyclic action on the n+1 ports of each n-ary operation.
-- R8 in workflow/status.md ties the cyclic rotation at arity 2 to
-- session-type duality, but session duality is a *separate*
-- involutive equivalence on the algebra side — not encoded here.
--
-- Naming discipline (load-bearing): the cyclic action is `rot` (the
-- constructor) / `rotate` (the derived equivalence), NOT
-- `involution`. Cyclic rotation has order n+1, not order 2. Session
-- duality is the involutive structure (order 2) and lives on the
-- algebra side.
--
-- Operations are set-truncated via a `trunc` path constructor per
-- arity (cubical HIT idiom). ∞-enrichment is a later upgrade.
```

The comment is unusually dense because it records several project decisions.

First, this is the syntactic and cyclic-action layer only. It gives us operations and rotation laws, but not the laws saying all substitutions associate correctly.

Second, this file keeps cyclic rotation separate from session duality. Rotation by one step around three ports is not an involution. Session duality is expected to be involutive later, on the algebra side. That distinction is important enough to be enforced by names: `rot` and `rotate`, not `involution`.

Third, the operations are set-truncated. The type has operations and equations between operations, but it does not keep higher-dimensional structure between proofs of those equations. This keeps the raw operad at the intended algebraic level.

## Chunk 3 — the arity and port convention

```agda
------------------------------------------------------------------------
-- Arity / port convention
--
-- An n-ary operation has n+1 cyclic ports. Substitution
-- `compₒ i j a b` glues port i of a (suc l)-ary op `a` to port j of
-- a (suc r)-ary op `b`, leaving (suc l + 1) + (suc r + 1) - 2 =
-- l + r + 2 ports remaining, hence arity suc (l + r).
--
-- Inputs are positive-arity (≥ 1): under the current generator set
-- (one binary `gen`), no nullary ops are reachable, and the positive
-- restriction makes the port-gluing iso
--   Port (suc (l + r)) ≃ Fin (suc l) ⊎ Fin (suc r)
-- total. (See PortGluing.agda; decision 2026-05-18.) The earlier
-- monus-based signature `O (m + n ∸ 1)` had Port 0 = Fin 1 vs
-- Fin 0 ⊎ Fin 0 = ∅ at m = n = 0, which the positive-only form
-- avoids cleanly. Reachable arities are unchanged (`gen : O 2`,
-- `compₒ gen gen : O 3`, etc.).
--
-- The port-reindexing that names the surviving ports of the
-- composite is not introduced at this layer; it enters with the
-- associativity / equivariance laws in CyclicAssociative.agda
-- (combinatorial substrate in PortGluing.agda).
------------------------------------------------------------------------
```

This comment explains why `compₒ` has the arity it has.

If `a` has arity `suc l`, it has `suc l + 1` ports. If `b` has arity `suc r`, it has `suc r + 1` ports. Gluing one port of `a` to one port of `b` removes two external ports. So the composite has:

```text
(suc l + 1) + (suc r + 1) - 2 = l + r + 2
```

external ports. Since arity is one less than the number of cyclic ports, the output arity is `suc (l + r)`.

The positive-arity restriction avoids a nullary edge case in the later port-gluing equivalence. It does not remove anything generated by `gen : O 2`, because all reachable operations stay positive-arity.

## Chunk 4 — the generated type of operations

```agda
------------------------------------------------------------------------
-- The HIT
--
-- O n : type of n-ary operations of the raw cyclic operad on one
-- binary generator.
--
-- Constructors:
--   gen          binary generator at arity 2 (3 cyclic ports total).
--   compₒ        operadic substitution at positive arities. Subscript
--                `o` avoids the clash with cubical Agda's `comp` (Kan
--                composition primitive); the operation here is
--                operadic substitution at marked ports, unrelated to
--                Kan composition. Composes a (suc l)-ary and a
--                (suc r)-ary op into a suc (l + r)-ary op.
--   rot          cyclic-group action per arity, as a function-shaped
--                constructor (so the equivalence package can be
--                derived outside the data declaration).
--   rot-zero     the group identity acts as the identity.
--   rot-compose  rot composes additively in the port index (i.e.
--                under the modular group operation _+ₘ_ on Port n).
--   trunc        set-truncation per arity (cubical HIT idiom).
------------------------------------------------------------------------

data O : ℕ → Type where
  gen         : O 2

  compₒ       : {l r : ℕ}
              → Port (suc l) → Port (suc r)
              → O (suc l) → O (suc r)
              → O (suc (l + r))

  rot         : {n : ℕ} → Port n → O n → O n

  rot-zero    : {n : ℕ} (a : O n)
              → rot fzero a ≡ a

  rot-compose : {n : ℕ} (i j : Port n) (a : O n)
              → rot i (rot j a) ≡ rot (i +ₘ j) a

  trunc       : {n : ℕ} (x y : O n) (p q : x ≡ y) → p ≡ q
```

This is the main declaration.

`O : ℕ → Type` means `O` is indexed by arity. For each natural number `n`, `O n` is the type of raw `n`-ary operations.

`gen : O 2` is the only primitive operation. There are no labels, payloads, actors, roles, or sessions in this syntax. Those belong to later interpretation layers.

`compₒ` is substitution. It takes a port of the first operation, a port of the second operation, the two operations themselves, and returns the composite. The subscript distinguishes operadic composition from cubical Agda's own `comp`.

`rot` rotates an operation by a port offset. It changes the cyclic viewpoint but not the arity.

`rot-zero` and `rot-compose` are path constructors. They build the equations saying zero rotation does nothing and consecutive rotations combine by modular addition.

`trunc` set-truncates each `O n`. We keep equations between operations, but not higher structure between proofs of equations.

## Chunk 5 — rotation as an equivalence

```agda
------------------------------------------------------------------------
-- The cyclic action as an equivalence
--
-- For each port index `i`, the function `rot i : O n → O n` is an
-- equivalence with inverse `rot (port-inv i)`. The proofs collapse
-- via `rot-compose` and the cancellation laws from Ports.agda:
--
--   rot (port-inv i) ∘ rot i ≡ rot (port-inv i +ₘ i)  [rot-compose]
--                            ≡ rot fzero              [port-inv-left]
--                            ≡ id                     [rot-zero]
--
-- and dually for the other side via port-inv-right.
------------------------------------------------------------------------

rotate-equiv : {n : ℕ} → Port n → O n ≃ O n
rotate-equiv {n} i = isoToEquiv (iso (rot i) (rot (port-inv i)) right-inv left-inv)
  where
```

The constructor `rot` gives a rotation function. `rotate-equiv` proves that this function is reversible.

For a fixed port offset `i`, the inverse is rotation by `port-inv i`. The file packages that as an `Iso`, then converts the isomorphism to an equivalence with `isoToEquiv`.

The two proof obligations are exactly the two round trips:

- rotate by the inverse, then by `i`;
- rotate by `i`, then by the inverse.

Both reduce to the same pattern: compose rotations, cancel the port offsets, then use `rot-zero`.

> **References**
> - [Cubical Agda: `Cubical.Foundations.Isomorphism`](https://agda.github.io/cubical/Cubical.Foundations.Isomorphism.html) — `Iso`, `iso`, and `isoToEquiv`.
> - [Cubical Agda: `Cubical.Foundations.Equiv`](https://agda.github.io/cubical/Cubical.Foundations.Equiv.html) — equivalences and their projections.

## Chunk 6 — the right inverse proof

```agda
    right-inv : (a : O n) → rot i (rot (port-inv i) a) ≡ a
    right-inv a =
        rot i (rot (port-inv i) a)
      ≡⟨ rot-compose i (port-inv i) a ⟩
        rot (i +ₘ port-inv i) a
      ≡⟨ cong (λ z → rot z a) (port-inv-right i) ⟩
        rot fzero a
      ≡⟨ rot-zero a ⟩
        a ∎
```

Read the proof chain as a calculation.

Start with `rot i (rot (port-inv i) a)`. Use `rot-compose` to combine the rotations into `rot (i +ₘ port-inv i) a`. Use `port-inv-right i` to replace `i +ₘ port-inv i` by `fzero`. Then `rot-zero` finishes the proof.

The line with `cong` transports equality of port offsets into equality of rotated operations:

```agda
cong (λ z → rot z a) (port-inv-right i)
```

If `i +ₘ port-inv i ≡ fzero`, then applying the function `λ z → rot z a` to both sides gives `rot (i +ₘ port-inv i) a ≡ rot fzero a`.

## Chunk 7 — the left inverse proof

```agda
    left-inv : (a : O n) → rot (port-inv i) (rot i a) ≡ a
    left-inv a =
        rot (port-inv i) (rot i a)
      ≡⟨ rot-compose (port-inv i) i a ⟩
        rot (port-inv i +ₘ i) a
      ≡⟨ cong (λ z → rot z a) (port-inv-left i) ⟩
        rot fzero a
      ≡⟨ rot-zero a ⟩
        a ∎
```

This is the same calculation in the other order. Now the cancellation law is `port-inv-left i`, because the combined offset is `port-inv i +ₘ i`.

Both directions are needed. To prove an equivalence, it is not enough to name a backwards function; the two round trips have to be witnessed.

## Chunk 8 — rotation as a plain function

```agda
-- Convenience: the cyclic action as a plain function. (Equal to the
-- constructor `rot` definitionally; named here to read the public
-- API as "rotate by this port offset" while keeping `rot` as the
-- HIT-level identifier the path constructors refer to.)
rotate : {n : ℕ} → Port n → O n → O n
rotate i = equivFun (rotate-equiv i)
```

`rotate` extracts the forward function from the equivalence `rotate-equiv i`.

It is definitionally the same action as `rot`, but it reads differently at the API level. `rot` is the constructor named by the path laws. `rotate` is the public function obtained from the equivalence package.

## Chunk 9 — sanity checks

```agda
------------------------------------------------------------------------
-- Sanity checks
--
-- Concrete inhabitants confirming the constructors are usable.
-- Not theorems — type-level witnesses only.
------------------------------------------------------------------------

private
  -- The binary generator lives at arity 2.
  _ : O 2
  _ = gen

  -- Rotating the binary generator at each of its three cyclic ports
  -- produces three (not necessarily distinct, but well-typed) arity-2
  -- operations.
  _ : O 2
  _ = rot fzero gen

  _ : O 2
  _ = rot (fsuc fzero) gen

  _ : O 2
  _ = rot (fsuc (fsuc fzero)) gen

  -- Substituting the generator into itself at the first port of each
  -- gives a 3-ary operation (gen : O 2 = O (suc 1); compₒ {1} {1}
  -- gives O (suc (1 + 1)) = O 3).
  _ : O 3
  _ = compₒ fzero fzero gen gen
```

The private block contains typechecking witnesses. They are not exported and they are not theorems.

The first witness confirms `gen : O 2`. The next three rotate `gen` by each of the three ports of `Port 2 = Fin 3`. The final witness composes `gen` with itself and checks that the result has arity 3.

This is the first small growth step of the free-generated object: one binary generator can already produce a ternary operation by substitution.

## Closing

`RawCyclicOperad.agda` installs the raw generated syntax and proves that rotation is reversible. It still does not impose associativity of substitution or compatibility between substitution and rotation.

That missing structure is the point of the next files. Before we can state the laws honestly, we need to know how the surviving ports of a composite are renamed. That is the job of `PortGluing.agda` and `PortRotation.agda`.
