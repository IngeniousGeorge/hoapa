# WIP — cyclic equivariance repair

## Context

The old `O_1` implementation used `rot-compₒ` as a **boundary-rotation operand-swap** constructor:

```agda
rot (boundary-rot l r) (compₒ i j a b) ≡ compₒ j i b a
```

This equation is still important, but it is now a theorem rather than primitive quotient data. The boundary rotation only moves the cyclic start past the whole `a` block; full cyclic equivariance also has to say what happens when the new first composite port lies inside the `a` block or inside the `b` block.

The implemented resolution is **option 2(a)** from the discussion, in the arbitrary-port form:

1. replace the boundary-swap primitive with cyclic-equivariance cases;
2. derive boundary-swap as a named lemma/theorem;
3. make R8 refer to the derived boundary-swap lemma, not to the primitive axiom.

The philosophical/narrative reading is: the 1=2 boundary swap follows from cyclic equivariance. It is not itself the whole cyclic axiom.

## What changed

Rotation-specific port bookkeeping was split out of `PortGluing.agda` into a new sibling file:

- `agda/Concurrency/Operads/PortGluing.agda`
  - owns delete-and-renumber, port splitting/gluing, and associativity reindexing;
  - no longer owns `boundary-rot`;
  - stale prose saying the unit-rotation form derives from boundary-swap via `rot-compose` was removed.

- `agda/Concurrency/Operads/PortRotation.agda`
  - owns `boundary-rot`;
  - adds `port-before-survivor`, the local operation used by cyclic equivariance;
  - proves `port-before-survivor-zero`, the seam specialization needed by boundary-swap.

- `agda/Concurrency/Operads/CyclicAssociative.agda`
  - replaced the old boundary-swap constructor with two grouped cyclic-equivariance constructors:
    - `rot-compₒ-a-block`;
    - `rot-compₒ-b-block`;
  - exposes their shapes as `rot-compₒ-a-block-target`, `rot-compₒ-b-block-target`, and `rot-compₒ-seam-target`;
  - proves `boundary-rot-is-b-seam`;
  - proves `boundary-swap-from-seam`;
  - defines `boundary-swap` from the b-block seam case.

Workflow references in `arc.md`, `status.md`, and `targets.md` now describe the operad as full cyclic equivariance with boundary-swap derived.

## Non-obvious code facts

The key helper is:

```agda
port-before-survivor : {n : ℕ} → Port (suc n) → Fin (suc n) → Port (suc n)
port-before-survivor i k = i +ₘ injectSuc k
```

Reading: if survivor `k` is to become the first visible port of an operand, then the local gluing port is the port immediately before that survivor.

The b-block seam is `y = fzero`. Two bookkeeping facts identify that seam with the old boundary-swap statement:

```agda
port-before-survivor j fzero = j
port-glue (inr fzero) = boundary-rot l r
```

The second fact is not definitional because `port-glue` goes through the Cubical library `Fin+≅Fin⊎Fin` equivalence and an arity cast. The proof uses `Fin-fst-≡` with the first-coordinate path `cong suc (+-zero l)`.

The derived theorem is:

```agda
boundary-swap :
  PathP (λ ι → O (suc (+-comm l r ι)))
    (rot (boundary-rot l r) (compₒ i j a b))
    (compₒ j i b a)
```

It is obtained by applying `rot-compₒ-b-block` at `fzero`, then rewriting the two seam endpoints by the bookkeeping facts above.

## Verification

The operad layer typechecks with:

```bash
agda -l cubical -i agda agda/Concurrency/Operads/CyclicAssociative.agda
```

No stale occurrence of the old claim "unit-rotation form derives from boundary-swap by `rot-compose`" remains.

## State

- `Concurrency/Algebras/StarAutonomous.agda` — landed (~130 lines, typechecks). Thin parametric symmetric multiplicative *-autonomous record. Underlying 1-category; ⊗ and 𝟙 with associator / unitors / braiding as named isomorphisms (no pentagon / hexagon / triangle unpacked); involutive duality `_^⊥` with contravariant functoriality and the involutive iso. ⅋, ⊥-par, ⊸ derived from ⊗, 𝟙, _^⊥. Tensor unit named `𝟙` because cubical's interval primitive `I` is in transitive scope. Polycategory alternative flagged in header.

- `Concurrency/Algebras/OperadAlgebra.agda` — landed (~110 lines, typechecks). `Algebra T` record over a `StarAutonomous` target T: Carrier + self-duality (`Carrier ≃ Carrier ^⊥`) + interpretation `⟦_⟧ : O n → Hom (ports Carrier n) 𝟙`. `ports X n` is the (suc n)-fold tensor of X. **Design call:** `⟦_⟧` is a function field; well-definedness on the HIT inherently forces respect for every path constructor (rot-zero, rot-compose, compₒ-assoc-seq, compₒ-assoc-par, rot-compₒ-a-block, rot-compₒ-b-block, trunc). No separate compatibility fields. R8 bridge provided as `boundary-swap-image` — a one-liner `cong ⟦_⟧ boundary-swap` lifting the operad theorem to a PathP in the algebra's morphism space. Cyclic-shift and compose-at-port morphisms (structural witnesses that `⟦_⟧` factors through specific categorical operations) are deferred to follow-up; Sessions.agda will surface what's needed.

## Next

`Concurrency/Algebras/Sessions.agda` — R8's Involution-Duality lands here. Open design calls before coding:

1. **Session-type syntax shape.** Caires–Pfenning lineage was committed (decisions log 2026-05-17), but the specific Agda presentation isn't pinned: full multiplicative-additive linear logic (⊗, ⅋, &, ⊕, !, ?, units, ⊸), or minimum-viable (⊗, ⅋, units, _^⊥ only — matching `StarAutonomous`'s scope)? The thinner version aligns with the "minimal multiplicative" decision; richer features can be added later if the bridge needs them.
2. **Syntactic category construction.** Objects = session types. Morphisms = ? (proof terms / cut-eliminated proofs / equivalence classes). Different presentations make this lighter or heavier.
3. **The `Algebra T` instance.** Concrete Carrier = some session type (which one?); concrete `⟦_⟧` defined by HIT recursion over `O n`; the self-dual iso is session duality. The HIT recursion is heavy in its own right.

Worth one alignment round with the user before starting.
