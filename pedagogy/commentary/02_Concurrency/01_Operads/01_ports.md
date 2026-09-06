# Ports.agda — cyclic port arithmetic

## Where this file sits

`formal/Concurrency/Operads/Ports.agda` is the first source companion in the Concurrency operads folder. The common picture is in `00_cyclic_operads_intro.md`: we are building the small cyclic operad artifact whose binary generator has three cyclic boundary ports.

This file does not define the operad itself. It fixes the finite cyclic arithmetic the rest of the folder will use. That makes it a vocabulary file: what counts as a port, how ports rotate, and how to name the inverse rotation.

The whole file is intentionally small. Later files do the visible operadic work; this one makes their notation stable.

## Chunk 1 — pragma and file preamble

```agda
{-# OPTIONS --cubical --guardedness #-}

-- Port arithmetic for cyclic operads.
--
-- An n-ary operadic operation has n+1 cyclic ports (the "trinion"
-- shape for the binary generator: 3 ports total, n+1 = 2+1 = 3).
-- This file owns the combinatorial substrate: the Port type and the
-- cyclic-group arithmetic re-exported from Cubical.Data.Fin.Arithmetic.
--
-- Intentionally minimal. RawCyclicOperad.agda only needs Port,
-- modular addition, and the cyclic inverse (with cancellation laws)
-- to derive the rotate equivalence. Heavier port arithmetic — the
-- β delete-and-renumber, the port-gluing equivalence, and the
-- reindexing families used by CyclicAssociative.agda's laws — live in
-- the sibling files Concurrency/Operads/PortGluing.agda and
-- Concurrency/Operads/PortRotation.agda (decision 2026-05-18).
```

The pragma says this file is checked in cubical Agda, with the same guardedness flag as the cubical library. The file itself does not use coinduction; the flag is part of the project's standard library environment.

The comment states the boundary of the file. `Ports.agda` owns the port type and the cyclic arithmetic re-export. It does not own gluing, delete-and-renumber, or associativity reindexing. That split keeps this file small enough to be a base layer rather than a dumping ground for every port fact.

## Chunk 2 — module and public imports

```agda
module Concurrency.Operads.Ports where

open import Cubical.Foundations.Prelude using (Type ; _≡_) public
open import Cubical.Data.Nat       using (ℕ ; suc)           public
open import Cubical.Data.Fin       using (Fin ; fzero ; fsuc) public
open import Cubical.Data.Fin.Arithmetic
  using (_+ₘ_ ; -ₘ_ ; _-ₘ_
        ; +ₘ-assoc ; +ₘ-comm
        ; +ₘ-lUnit ; +ₘ-rUnit
        ; +ₘ-lCancel ; +ₘ-rCancel) public
```

The module line gives the Agda module name. The path mirrors it under `formal/`.

All imports are `public`, so a later file can import `Concurrency.Operads.Ports` and get this vocabulary too. This is deliberate. The port layer is the doorway through which later files receive natural numbers, finite port indices, modular addition, modular inverse, and cancellation laws.

The imported names are the ones the intro prepared: `ℕ` for arities, `Fin` for finite port sets, `fzero` and `fsuc` for the inhabitants of `Fin`, `_+ₘ_` for modular addition, and `-ₘ_` for modular inverse.

## Chunk 3 — the port type

```agda
------------------------------------------------------------------------
-- Port type
--
-- An n-ary operation has n+1 cyclic ports, indexed by Fin (suc n).
-- The cyclic group ℤ/(n+1) acts on Port n via _+ₘ_.
------------------------------------------------------------------------

Port : ℕ → Type
Port n = Fin (suc n)
```

This is the central definition. A port of an `n`-ary operation is one of `n + 1` cyclic boundary positions.

So:

```agda
Port 2 = Fin 3
```

The binary generator will live at arity 2, and therefore has three ports. That is the trinion convention from the intro, now fixed as Agda code.

The comment mentions the cyclic group `ℤ/(n+1)`, but the file does not construct that group separately. It uses modular arithmetic on `Fin (suc n)` directly. For the rest of the folder, this is enough: adding a port offset rotates around the finite cycle.

## Chunk 4 — cyclic inverse

```agda
------------------------------------------------------------------------
-- Cyclic inverse
--
-- The cyclic-group inverse of a port. Aliased from the modular
-- additive inverse -ₘ_ for readability in operadic vocabulary at the
-- call site. The two cancellation laws below are what RawCyclicOperad
-- uses to discharge that the cyclic action `rot` is an equivalence;
-- they re-export the library's +ₘ-lCancel / +ₘ-rCancel under names
-- that read locally.
------------------------------------------------------------------------

port-inv : {n : ℕ} → Port n → Port n
port-inv x = -ₘ x
```

`port-inv` is a rename. The cubical library already has modular inverse as `-ₘ_`; the project gives it a local operadic name.

This is not cosmetic fussing. In the next file, the inverse of rotation by `i` is rotation by `port-inv i`. That sentence reads in the language of ports. If the proof said only `-ₘ i`, the reader would constantly translate back from library arithmetic.

The implicit `{n : ℕ}` means this works at every arity. A port inverse stays in the same finite cyclic port set.

## Chunk 5 — cancellation laws in port vocabulary

```agda
port-inv-left : {n : ℕ} (i : Port n) → port-inv i +ₘ i ≡ fzero
port-inv-left i = +ₘ-lCancel i

port-inv-right : {n : ℕ} (i : Port n) → i +ₘ port-inv i ≡ fzero
port-inv-right i = +ₘ-rCancel i
```

These two definitions rename the library cancellation laws:

- inverse then original offset gives zero;
- original offset then inverse gives zero.

The zero is `fzero`, the identity rotation. The equality symbol `≡` is the path/equality type from cubical Agda: each line gives a witness that the two port offsets are equal.

Again, no new mathematics is happening. The point is to package the exact facts `RawCyclicOperad.agda` needs to prove that rotation is reversible.

## Closing

This file gives the rest of the folder four public pieces:

- `Port n = Fin (suc n)`;
- modular addition `_+ₘ_`, re-exported for rotating ports;
- `port-inv`, the inverse port offset;
- `port-inv-left` and `port-inv-right`, the two cancellation laws.

The next file uses exactly these pieces to define raw cyclic syntax and prove that every rotation is an equivalence.
