# PortGluing.agda — deleting, splitting, and reindexing ports

## Where This File Sits

`agda/Concurrency/Operads/PortGluing.agda` is the first heavy bookkeeping file in the operads folder. `01_ports.md` gave the finite cyclic port type; `02_rawcyclicoperad.md` used it to define raw substitution and rotation. This file explains what happens to the *names of ports* when a substitution glues two ports together.

There are three jobs:

- delete a port and renumber the surviving ports;
- split the ports of a composite into "came from the left operand" and "came from the right operand";
- compute the reindexing needed when associativity changes the bracketing of a composite.

This is not glamorous, but it is the layer that makes the later laws honest. If we want to state that two composites are equal, Agda needs to know exactly which surviving port on one side corresponds to which surviving port on the other.

## Chunk 1 — file preamble

```agda
{-# OPTIONS --cubical --guardedness #-}

-- Port-gluing combinatorial substrate for the cyclic associative operad.
--
-- This file owns the heavier port arithmetic that CyclicAssociative.agda
-- needs to state its laws:
--   * delete-and-renumber (β convention), parameterizing surviving ports
--     by the deleted port;
--   * the port-gluing equivalence
--       Port (suc (l + r)) ≃ Fin (suc l) ⊎ Fin (suc r),
--     which classifies the composite's ports as coming from `a` or `b`;
--   * reindexing families that compute the gluing-port location after
--     re-bracketing (sequential / parallel associativity).
```

The comment names the file as the "combinatorial substrate" for the cyclic associative laws. `RawCyclicOperad.agda` could say "compose operation `a` with operation `b`." `CyclicAssociative.agda` needs more: it must compare composites built in different orders, and that means tracking the ports that survive each gluing.

The key equivalence:

```agda
Port (suc (l + r)) ≃ Fin (suc l) ⊎ Fin (suc r)
```

says every port of the composite can be classified as either a surviving port from the left operation or a surviving port from the right operation. The sum type `_⊎_` is a disjoint choice: `inl x` means "left side," `inr y` means "right side."

## Chunk 2 — the β convention

```agda
-- β convention (decision 2026-05-18): delete-port i k = i +ₘ fsuc k.
-- This anchors the renumbering of surviving ports to the deleted port
-- itself (not to fzero), making per-operand cyclic action commute with
-- delete-and-renumber by construction. The alternative (linear punch-in,
-- using < order on Fin) would force rot-compₒ to absorb the discrepancy
-- between the linear order and the cyclic action.
```

This is the important design decision of the file.

Suppose we delete port `i`. We need to enumerate the surviving ports. The β convention says: start immediately after the deleted port, then walk cyclically. So surviving index `0` means "the port after `i`," surviving index `1` means "the next one," and so on.

In code this becomes:

```agda
delete-port i k = i +ₘ fsuc k
```

The `fsuc` skips the deleted port itself. If we used `i +ₘ k`, then `k = fzero` would give back `i`, the port we meant to remove.

The alternative would be a linear convention: remove an element from a list ordered from zero and shift later elements down. That is natural for arrays. But here the structure is cyclic, not linear. The β convention makes rotation and deletion agree with each other instead of fighting in later proofs.

## Chunk 3 — imports

```agda
module Concurrency.Operads.PortGluing where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv       using (_≃_ ; equivFun ; invEq ; compEquiv)
open import Cubical.Foundations.Isomorphism using (isoToEquiv)
open import Cubical.Foundations.Univalence  using (pathToEquiv)
open import Cubical.Data.Nat                using (ℕ ; suc ; _+_ ; +-suc)
open import Cubical.Data.Nat.Properties     using (snotz)
open import Cubical.Data.Fin                using (Fin ; fzero ; fsuc ; predFin)
open import Cubical.Data.Fin.Properties     using (Fin+≅Fin⊎Fin)
open import Cubical.Data.Sum                using (_⊎_ ; inl ; inr)
open import Cubical.Relation.Nullary        using (¬_)

open import Concurrency.Operads.Ports
```

The new imports are exactly the ones the file's jobs require.

`_⊎_`, `inl`, and `inr` are for splitting composite ports into left-side and right-side survivors. `Fin+≅Fin⊎Fin` is the cubical library equivalence saying a finite set of size `m + n` is equivalent to the disjoint sum `Fin m ⊎ Fin n`. The file adapts that equivalence to the operadic arity convention.

`pathToEquiv`, `compEquiv`, and `isoToEquiv` are equivalence plumbing. They let the file first cast between definitionally different but equal finite types, then compose that cast with the library's finite-sum equivalence.

## Chunk 4 — delete-and-renumber

```agda
delete-port : {n : ℕ} → Port (suc n) → Fin (suc n) → Port (suc n)
delete-port i k = i +ₘ fsuc k
```

`delete-port i k` means: after deleting port `i`, take the survivor with renumbered index `k`.

The type is worth reading:

- before deletion, the operation has ports `Port (suc n)`;
- deleting one port leaves `suc n` surviving ports;
- those survivors are indexed by `Fin (suc n)`;
- the result is again a port of the original operation, because we are naming *which original port survived*.

So `delete-port` does not produce a port of a smaller operation. It maps a renumbered survivor back into the original cyclic port set.

## Chunk 5 — the deleted port is not returned

```agda
delete-port-not-deleted : {n : ℕ} (i : Port (suc n)) (k : Fin (suc n))
                        → ¬ (delete-port i k ≡ i)
delete-port-not-deleted {n} i k path = snotz (cong fst fsuc-eq-fzero)
  where
    fsuc-eq-fzero : fsuc k ≡ fzero
    fsuc-eq-fzero =
        fsuc k                       ≡⟨ sym (+ₘ-lUnit (fsuc k))            ⟩
        fzero +ₘ fsuc k              ≡⟨ cong (_+ₘ fsuc k) (sym (+ₘ-lCancel i)) ⟩
        ((-ₘ i) +ₘ i) +ₘ fsuc k      ≡⟨ +ₘ-assoc (-ₘ i) i (fsuc k)         ⟩
        (-ₘ i) +ₘ (i +ₘ fsuc k)      ≡⟨ cong ((-ₘ i) +ₘ_) path             ⟩
        (-ₘ i) +ₘ i                  ≡⟨ +ₘ-lCancel i                       ⟩
        fzero                        ∎
```

This proves the sanity check promised by the β convention: `delete-port i k` never returns `i`.

The proof works by contradiction. Suppose `i +ₘ fsuc k ≡ i`. Add the inverse of `i` on the left. The `i` cancels, and the assumption forces `fsuc k ≡ fzero`. But a successor in `Fin` cannot be zero; `snotz` is the library's "successor is not zero" contradiction.

For a reader not living in Agda: this proof is just the cyclic arithmetic version of "if `i + (k + 1) = i` modulo `n + 2`, then `k + 1 = 0`, impossible because `k + 1` is one of the nonzero surviving offsets."

## Chunk 6 — delete commutes with rotation

```agda
delete-port-equivariant : {n : ℕ} (i k : Port (suc n)) (j : Fin (suc n))
                        → delete-port (i +ₘ k) j ≡ i +ₘ delete-port k j
delete-port-equivariant i k j = +ₘ-assoc i k (fsuc j)
```

This is the second sanity check, and the real reason for the β convention.

The statement says: rotating the deleted port and then deleting gives the same survivor as deleting first and then rotating the result. The proof is just associativity of modular addition:

```agda
(i +ₘ k) +ₘ fsuc j = i +ₘ (k +ₘ fsuc j)
```

That is exactly `+ₘ-assoc`.

This tiny proof is the payoff. The cyclic action will later need to commute with substitution. If delete-and-renumber already respects rotation, the later equivariance law can talk about real operadic structure instead of compensating for a bad indexing convention.

## Chunk 7 — the port-gluing equivalence

```agda
private
  arity-cast : ∀ l r → Fin (suc (suc (l + r))) ≡ Fin (suc l + suc r)
  arity-cast l r = cong Fin (sym (cong suc (+-suc l r)))

port-gluing-equiv : {l r : ℕ}
                  → Port (suc (l + r)) ≃ Fin (suc l) ⊎ Fin (suc r)
port-gluing-equiv {l} {r} =
  compEquiv (pathToEquiv (arity-cast l r))
            (isoToEquiv (Fin+≅Fin⊎Fin (suc l) (suc r)))
```

This constructs the classification of composite ports.

The left side is:

```agda
Port (suc (l + r))
```

Unfolding `Port`, that is:

```agda
Fin (suc (suc (l + r)))
```

The library equivalence wants a finite type of size `suc l + suc r`. Those two sizes are equal, but not definitionally identical to Agda. So `arity-cast` builds the path between the two finite types, `pathToEquiv` turns that path into an equivalence, and `compEquiv` composes it with the library's `Fin+≅Fin⊎Fin`.

The result is a reusable equivalence:

```agda
composite port ≃ left survivor ⊎ right survivor
```

This is linear as a classification: first all left survivors, then all right survivors. The cyclic content still lives in `delete-port` and the later rotation functions.

## Chunk 8 — glue and split

```agda
port-glue : {l r : ℕ} → Fin (suc l) ⊎ Fin (suc r) → Port (suc (l + r))
port-glue = invEq port-gluing-equiv

port-split : {l r : ℕ} → Port (suc (l + r)) → Fin (suc l) ⊎ Fin (suc r)
port-split = equivFun port-gluing-equiv
```

These are the two directions of the equivalence, given local names.

`port-split` takes a port of the composite and tells us whether it came from the left side or right side. `port-glue` goes the other way: given either a left survivor or a right survivor, it names the corresponding composite port.

The naming is slightly counterintuitive at first: `port-glue` does not glue two operations. It glues a branch label (`inl` or `inr`) plus a survivor index back into the single composite port numbering.

## Chunk 9 — associativity reindexing helpers

```agda
b-port-after-inner-glue : {r : ℕ} → Fin (suc r) → Fin (suc r)
b-port-after-inner-glue {r} y = predFin r (-ₘ fsuc y)

a-port-after-inner-glue : {l : ℕ} → Fin (suc l) → Fin (suc l)
a-port-after-inner-glue {l} x = predFin l (-ₘ fsuc x)
```

These two functions are small, but they hide the bookkeeping that would otherwise make the associativity laws unreadable.

Sequential associativity says: if we first compose `a` with `b`, then compose the result with `c`, we should be able to rebracket as `a` composed with `(b composed with c)`. But when we rebracket, the port of `b` that used to be the inner gluing port has moved to a new survivor index in the new composite.

`b-port-after-inner-glue y` computes that new index. The `a` version does the symmetric job for parallel associativity.

The formula:

```agda
predFin r (-ₘ fsuc y)
```

is the closed form that comes from the β convention. We do not need to rederive it in `CyclicAssociative.agda`; we give it a name here and use the name in the law constructor.

## Closing

`PortGluing.agda` installs the port bookkeeping needed for the full cyclic associative laws:

- `delete-port`, using the β convention;
- two β sanity checks: not returning the deleted port, and equivariance under rotation;
- `port-gluing-equiv`, classifying composite ports as left or right survivors;
- `port-glue` and `port-split`, the two named directions of that equivalence;
- `b-port-after-inner-glue` and `a-port-after-inner-glue`, the reindexing helpers for associativity.

The next file, `PortRotation.agda`, adds the rotation-side helpers. Then `CyclicAssociative.agda` can state the real laws without drowning in index arithmetic.
