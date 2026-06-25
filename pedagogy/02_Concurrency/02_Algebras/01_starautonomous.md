# StarAutonomous.agda — the target category signature

## Where This File Sits

`formal/Concurrency/Algebras/StarAutonomous.agda` defines the kind of category in which `O_1` algebras can take values. It is a parameter signature: later files take a `StarAutonomous` record as an input and build valuations or algebras relative to it.

The file is explicitly thin. It names the operations and local isomorphism laws needed now, while leaving full coherence for later.

## Chunk 1 — preamble

```agda
{-# OPTIONS --cubical --guardedness #-}

-- Parameter signature for the target category of cyclic-operad algebras.
--
-- `StarAutonomous` is a record packaging the structure a target category
-- must carry so that algebras of the cyclic associative operad `O_1` can
-- land in it.
```

The important phrase is "parameter signature." This file does not build a category. It describes the interface a category must provide.

That interface is used by `Valuation.agda` and `OperadAlgebra.agda`, and then instantiated by `Sessions.agda`.

The header is also honest about missing structure: this is not a full categorical formalization of star-autonomy. It carries the fields the project currently needs.

## Chunk 2 — module and record

```agda
module Concurrency.Algebras.StarAutonomous where

open import Cubical.Foundations.Prelude

record StarAutonomous (ℓ ℓ' : Level) : Type (ℓ-suc (ℓ-max ℓ ℓ')) where
  field
```

The record has two universe levels:

- `ℓ` for objects;
- `ℓ'` for morphisms.

This mirrors ordinary category formalization: objects and hom-types may live at different universe levels.

Everything below is a field of this record, except for the derived definitions at the end.

## Chunk 3 — underlying category

```agda
    Ob       : Type ℓ
    Hom      : Ob → Ob → Type ℓ'
    Hom-set  : {A B : Ob} → isSet (Hom A B)
    id       : {A : Ob} → Hom A A
    _∘_      : {A B C : Ob} → Hom B C → Hom A B → Hom A C
    id-l     : {A B : Ob} (f : Hom A B) → id ∘ f ≡ f
    id-r     : {A B : Ob} (f : Hom A B) → f ∘ id ≡ f
    ∘-assoc  : {A B C D : Ob}
               (f : Hom C D) (g : Hom B C) (h : Hom A B)
             → (f ∘ g) ∘ h ≡ f ∘ (g ∘ h)
```

This is the ordinary 1-category layer.

`Ob` is the type of objects. `Hom A B` is the type of morphisms from `A` to `B`. `Hom-set` says each hom-type is set-level: morphisms may be equal, but there is no higher-dimensional structure between equality proofs that this record cares about.

Then come identity, composition, and the usual category laws.

This is the base on which the linear-logic structure is added.

## Chunk 4 — tensor and unit

```agda
    _⊗_       : Ob → Ob → Ob
    𝟙         : Ob

    ⊗-hom     : {A B C D : Ob} → Hom A C → Hom B D → Hom (A ⊗ B) (C ⊗ D)
    ⊗-id-pres : {A B : Ob} → ⊗-hom (id {A}) (id {B}) ≡ id
    ⊗-∘-pres  : {A B C D E F : Ob}
                (f : Hom C E) (g : Hom A C)
                (h : Hom D F) (k : Hom B D)
              → ⊗-hom (f ∘ g) (h ∘ k) ≡ ⊗-hom f h ∘ ⊗-hom g k
```

The tensor product `⊗` combines objects. The object `𝟙` is its unit. In linear logic, `⊗` is the multiplicative "and": resources used together.

`⊗-hom` says tensor also acts on morphisms. If `f : A → C` and `h : B → D`, then `⊗-hom f h : A ⊗ B → C ⊗ D`.

The two preservation laws say this action respects identities and composition. That is the functoriality of tensor, written directly as fields.

The file uses `𝟙` rather than `I` because cubical Agda already has an interval primitive called `I`.

## Chunk 5 — associator, unitors, and braid

```agda
    α         : {A B C : Ob} → Hom ((A ⊗ B) ⊗ C) (A ⊗ (B ⊗ C))
    α-inv     : {A B C : Ob} → Hom (A ⊗ (B ⊗ C)) ((A ⊗ B) ⊗ C)
    α-iso-l   : {A B C : Ob} → α-inv {A} {B} {C} ∘ α ≡ id
    α-iso-r   : {A B C : Ob} → α {A} {B} {C} ∘ α-inv ≡ id

    leftUnitor       : {A : Ob} → Hom (𝟙 ⊗ A) A
    ...

    rightUnitor       : {A : Ob} → Hom (A ⊗ 𝟙) A
    ...

    braid            : {A B : Ob} → Hom (A ⊗ B) (B ⊗ A)
    braid-involutive : {A B : Ob} → braid {B} {A} ∘ braid {A} {B} ≡ id
```

These fields give the symmetric monoidal structure.

The associator `α` moves parentheses:

```agda
(A ⊗ B) ⊗ C → A ⊗ (B ⊗ C)
```

The unitors remove tensor units on the left and right. The braid swaps tensor factors.

Each isomorphism is represented by a morphism, an inverse morphism, and the two inverse laws. What is missing are the global coherence laws: pentagon, triangle, hexagon, and naturality. The header explicitly says to add them when downstream proofs need them.

## Chunk 6 — involutive duality

```agda
    _^⊥        : Ob → Ob
    ^⊥-hom     : {A B : Ob} → Hom A B → Hom (B ^⊥) (A ^⊥)
    ^⊥-id-pres : {A : Ob} → ^⊥-hom (id {A}) ≡ id
    ^⊥-∘-pres  : {A B C : Ob} (f : Hom B C) (g : Hom A B)
               → ^⊥-hom (f ∘ g) ≡ ^⊥-hom g ∘ ^⊥-hom f

    ^⊥-involutive       : {A : Ob} → Hom A ((A ^⊥) ^⊥)
    ^⊥-involutive-inv   : {A : Ob} → Hom ((A ^⊥) ^⊥) A
    ^⊥-involutive-iso-l : {A : Ob} → ^⊥-involutive-inv {A} ∘ ^⊥-involutive ≡ id
    ^⊥-involutive-iso-r : {A : Ob} → ^⊥-involutive {A} ∘ ^⊥-involutive-inv ≡ id
```

The operation `_^⊥` is linear duality. It is contravariant: a morphism `A → B` becomes a morphism `B ^⊥ → A ^⊥`.

The involutive fields say every object is isomorphic to its double dual:

```agda
A ≃ (A ^⊥) ^⊥
```

Again, the record does not include all naturality/coherence laws. It records the local operations and inverse laws needed by the current algebra files.

## Chunk 7 — derived par, dualizing object, and lollipop

```agda
  _⅋_ : Ob → Ob → Ob
  A ⅋ B = ((A ^⊥) ⊗ (B ^⊥)) ^⊥

  ⊥-par : Ob
  ⊥-par = 𝟙 ^⊥

  _⊸_ : Ob → Ob → Ob
  A ⊸ B = (A ^⊥) ⅋ B
```

These are definitions, not extra assumptions.

`⅋` is par, defined by De Morgan duality from tensor. `⊥-par` is the dualizing object, the dual of the tensor unit. `⊸` is linear implication, the lollipop:

```agda
A ⊸ B = A ^⊥ ⅋ B
```

The file does not prove the universal property of `⊸`. So `⊸` is named, but not yet characterized as an internal hom. That is one of the specific upgrades needed before the project can derive `plug` generically from the target category.

## Closing

`StarAutonomous.agda` supplies the target-category interface for the algebra layer. It is intentionally thin:

- enough category, tensor, symmetry, and duality structure for current files;
- derived `⅋`, `⊥-par`, and `⊸`;
- no full coherence package yet;
- no closed/evaluation structure yet.

The next file, `Valuation.agda`, takes a target `T : StarAutonomous` and defines the weakest interpretation layer for `O_1`.
