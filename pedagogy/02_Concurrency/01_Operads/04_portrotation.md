# PortRotation.agda — rotation-side port helpers

## Where This File Sits

`agda/Concurrency/Operads/PortRotation.agda` is the sibling of `PortGluing.agda`. The previous file handled deletion, splitting, and associativity reindexing. This one handles the small amount of port arithmetic needed to state how rotation interacts with substitution.

The file is intentionally short. It defines:

- `boundary-rot`, the rotation that moves the composite's cyclic start from the left block to the right block;
- `port-before-survivor`, the local helper used in the full cyclic-equivariance laws;
- `port-before-survivor-zero`, the seam case used to derive boundary-swap.

## Chunk 1 — preamble and imports

```agda
{-# OPTIONS --cubical --guardedness #-}

-- Rotation-specific port bookkeeping for cyclic operads.
--
-- PortGluing.agda owns the delete / split / rebracketing combinatorics
-- of operadic substitution. This sibling owns the rotation-side
-- combinatorics: ports and reindexing data whose purpose is to state
-- how cyclic rotation interacts with substitution.
```

The preamble is mainly a boundary marker. This file should not reimplement gluing. It only names the port offsets that rotation laws need.

```agda
module Concurrency.Operads.PortRotation where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Fin                using (Fin ; injectSuc)
open import Cubical.Data.Nat                using (ℕ ; suc ; _+_ ; +-suc)
open import Cubical.Data.Nat.Order          using (_<_)
open import Cubical.Data.Nat.Order.Inductive using (<→<ᵗ)
open import Cubical.Data.Nat.Properties     using (+-comm)

open import Concurrency.Operads.Ports
```

The new name is `injectSuc`. It embeds a value of `Fin (suc n)` into the next larger finite type without taking the final point. That is exactly what "the port immediately before this survivor" needs below.

## Chunk 2 — boundary rotation

```agda
private
  suc-l-bound : ∀ l r → suc l < suc (suc (l + r))
  suc-l-bound l r = r ,
      ( r + suc (suc l)   ≡⟨ +-suc r (suc l) ⟩
        suc (r + suc l)   ≡⟨ cong suc (+-suc r l) ⟩
        suc (suc (r + l)) ≡⟨ cong (λ z → suc (suc z)) (+-comm r l) ⟩
        suc (suc (l + r)) ∎ )

boundary-rot : (l r : ℕ) → Port (suc (l + r))
boundary-rot l r = suc l , <→<ᵗ (suc-l-bound l r)
```

Under the linear-sum convention from `PortGluing.agda`, the composite ports are ordered as:

```text
left survivors, then right survivors
```

There are `suc l` left survivors. So rotating by `suc l` moves the cyclic starting point past the whole left block and lands at the first right survivor. That is `boundary-rot`.

The private helper `suc-l-bound` proves that `suc l` is actually a valid port of the composite. Agda needs this because a port is not just a natural number; it is a natural number plus a proof that it lies inside the finite bound.

The proof chain is arithmetic: `suc l < suc (suc (l + r))`. The interesting mathematical idea is much simpler than the proof term: the first right-side port is inside the composite port list.

## Chunk 3 — the port before a survivor

```agda
port-before-survivor : {n : ℕ} → Port (suc n) → Fin (suc n) → Port (suc n)
port-before-survivor i k = i +ₘ injectSuc k

port-before-survivor-zero :
  {n : ℕ} (i : Port (suc n)) → port-before-survivor i fzero ≡ i
port-before-survivor-zero i = +ₘ-rUnit i
```

In the β convention, survivor `k` after deleting port `i` is:

```agda
i +ₘ fsuc k
```

So the port immediately before that survivor is:

```agda
i +ₘ injectSuc k
```

That is what `port-before-survivor` computes. It is used in cyclic equivariance: if a composite is rotated so that a certain survivor becomes the new first visible port, the local gluing port should move to the port immediately before that survivor.

The zero case says that the port before the first survivor is the deleted/gluing port itself:

```agda
port-before-survivor i fzero ≡ i
```

This is the seam lemma needed for `boundary-swap`: at the first right-side survivor, the "port before survivor" on the right operation is just the original gluing port.

## Closing

`PortRotation.agda` contributes only three names, but they are strategically placed:

- `boundary-rot` names the rotation from left block to right block;
- `port-before-survivor` names the local gluing port after rotating to a survivor;
- `port-before-survivor-zero` identifies the seam case.

`CyclicAssociative.agda` uses these to state full cyclic equivariance and derive the boundary-swap theorem from the b-block seam.
