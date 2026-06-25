# Properties.agda - functoriality of the cohesion modalities

## Where this file sits

`formal/ModalHoTT/Modalities/Properties.agda` is the first file after the two adjunctions are installed. `01_cohesion.md` gave us the three consoles: flat, shape, and sharp. `02_adjunctions.md` patched them together and proved the one idempotency theorem that the current eliminators can support. This file asks the next ordinary question: if a modality acts on types, how does it act on functions?

For a function `f : A -> B`, each modality should produce a lifted function:

```text
♭A -> ♭B
ʃA -> ʃB
♯A -> ♯B
```

That is what it means here to be functorial. A functor should also preserve identity maps and composition. The status split is the same one that already appeared in `Adjunctions.agda`: flat has dependent induction, so its map operation and its laws are proved. Shape and sharp have only non-dependent recursion, so their map operations are definable, but their identity and composition laws are postulated.

The other load-bearing item in this file is `shape-flat-natural-B`. It is not a random convenience lemma. It is the one piece of adjunction naturality currently needed downstream, especially in `FlatCoefficients.agda` to pin the structural de Rham equivalence to the canonical map.

In the rack metaphor, this file teaches each console how to transport signal along a wire. Flat has enough internal wiring to prove that transport respects calibration. Shape and sharp can route the signal, but some calibration LEDs are still assumed because their dependent eliminators are missing.

> **References**
> - [nLab: functor](https://ncatlab.org/nlab/show/functor)
> - [nLab: natural transformation](https://ncatlab.org/nlab/show/natural+transformation)
> - [nLab: adjunction](https://ncatlab.org/nlab/show/adjunction)

## Chunk 1 - pragma, module, imports, variables

```agda
{-# OPTIONS --cubical --guardedness #-}

module ModalHoTT.Modalities.Properties where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv
open import Cubical.Foundations.Function

open import ModalHoTT.Modalities.Cohesion
open import ModalHoTT.Modalities.Adjunctions

private
  variable
    ℓ ℓ' ℓ'' : Level
```

The project imports are the important part. `Cohesion` supplies the three modalities and their units, counits, and recursors. `Adjunctions` supplies the idempotency results and the named transpose operations. This file sits exactly on top of those two layers.

The third universe variable `ℓ''` appears because composition involves three types:

```agda
A : Type ℓ
B : Type ℓ'
C : Type ℓ''
```

## Chunk 2 - the file's own preamble

```agda
-- Functoriality of the three cohesion modalities ♭, ʃ, ♯.
--
-- Each modality extends to an endofunctor on Type: a map f : A → B
-- lifts to F(f) : FA → FB, and the lift respects identity and
-- composition.
--
-- ♭ has full dependent elimination (flat-ind), so its functorial action
-- and both laws are proved here without new postulates. ʃ and ♯ have
-- only non-dependent recursion; the maps are definable but the laws
-- require induction over elements of ʃA or ♯A.
```

This comment gives the whole status table.

Flat is the strong leg because `flat-ind` from (01_§6) can eliminate into dependent families. The identity and composition laws are themselves families of equality types indexed by elements of `♭A`, so dependent elimination is exactly the tool required.

Shape and sharp can still define maps, because their non-dependent recursors are enough to map out of `ʃA` or `♯A` into a modal target. But proving that those maps preserve identity and composition requires a path-valued predicate varying over the input. That is dependent elimination, and the current synthetic interface does not provide `shape-ind` or `sharp-ind`.

## Chunk 3 - flat-map

```agda
flat-map : {A : Type ℓ} {B : Type ℓ'} → (A → B) → FlatModality A → FlatModality B
flat-map f = flat-ind (λ _ → FlatModality _) (flat-intro ∘ f)
```

`flat-map f` lifts `f : A -> B` to a function `♭A -> ♭B`.

The definition says: eliminate from `♭A` using `flat-ind`; on a generator `flat-intro a`, apply `f` to get `f a : B`; then reintroduce it with `flat-intro`.

So the operational picture is:

```text
flat-intro a  ↦  flat-intro (f a)
```

The target family `λ _ -> FlatModality _` is constant. Agda infers the hidden type argument in the underscore as `B`. No idempotency theorem is needed here; the induction principle itself supplies the lifted function.

## Chunk 4 - flat preserves identity

```agda
flat-map-id : {A : Type ℓ} (u : FlatModality A) → flat-map (λ a → a) u ≡ u
flat-map-id = flat-ind (λ u → flat-map (λ a → a) u ≡ u)
                       (λ a → flat-ind-β _ flat-intro a)
```

This proves pointwise that lifting the identity function gives the identity function on `♭A`.

The goal is a family indexed by `u : ♭A`:

```agda
flat-map id u ≡ u
```

That is exactly the shape `flat-ind` can handle. It reduces the proof to the generator case `u = flat-intro a`. In that case, the beta rule for `flat-ind` says `flat-map id (flat-intro a)` computes back to `flat-intro a`. The proof is not a postulate; it is the first small calibration theorem for the flat console.

## Chunk 5 - flat preserves composition

```agda
flat-map-comp : {A : Type ℓ} {B : Type ℓ'} {C : Type ℓ''}
  (f : A → B) (g : B → C) (u : FlatModality A)
  → flat-map (g ∘ f) u ≡ flat-map g (flat-map f u)
flat-map-comp f g = flat-ind _
  (λ a → flat-ind-β _ (flat-intro ∘ g ∘ f) a
       ∙ sym (  cong (flat-map g) (flat-ind-β _ (flat-intro ∘ f) a)
              ∙ flat-ind-β _ (flat-intro ∘ g) (f a)))
```

This is the composition law:

```text
♭(g after f) = ♭g after ♭f
```

Again the proof is by `flat-ind`, because the goal varies over `u : ♭A`. At a generator `flat-intro a`, both sides reduce to:

```agda
flat-intro (g (f a))
```

The proof term is a path calculation. The left side reduces by one beta rule. The right side reduces by first reducing `flat-map f (flat-intro a)`, then reducing `flat-map g (flat-intro (f a))`. `cong (flat-map g)` transports the first beta equality through the outer `flat-map g`.

The important reader-level fact: this is a real theorem because flat has dependent induction.

## Chunk 6 - flat-counit naturality

```agda
flat-counit-natural : {A : Type ℓ} {B : Type ℓ'}
  (f : A → B) (u : FlatModality A)
  → flat-counit (flat-map f u) ≡ f (flat-counit u)
flat-counit-natural f = flat-ind _
  (λ a →   cong flat-counit (flat-ind-β _ (flat-intro ∘ f) a)
         ∙ flat-counit-intro (f a)
         ∙ sym (cong f (flat-counit-intro a)))
```

This is naturality of the flat counit. It says the square commutes:

```text
♭A --flat-map f--> ♭B
 |                 |
 ε                 ε
 v                 v
 A -----f--------> B
```

In words: lift `f` and then forget flatness, or forget flatness and then apply `f`; the result is path-equal.

This theorem is used directly in `Fracture.agda`. There, `f` is `sharp-unit`, and the theorem proves that the fracture square commutes. This is one reason `Properties.agda` is not just a "nice laws" file; it supplies a proved cable law that later files depend on.

## Chunk 7 - naturality of the ʃ ⊣ ♭ transpose in B

```agda
postulate
  shape-flat-natural-B : {A : Type ℓ} {B : Type ℓ'} {B' : Type ℓ''}
    (g : B → B') (h : ShapeModality A → B)
    → shape-to-flat (g ∘ h) ≡ flat-map g ∘ shape-to-flat h
```

This is the one new adjunction-naturality postulate in the file.

The adjunction from `Adjunctions.agda` gives an equivalence:

```agda
(ʃA → B) ≃ (A → ♭B)
```

Naturality in `B` says postcomposing the left-side map with `g : B -> B'` agrees with transposing first and then applying `flat-map g` on the right side. That is exactly the equation above.

This data belongs to a full adjunction package, but the current `Adjunctions.agda` only records the hom-set equivalences and selected calibration equations. So this file postulates the specific naturality law that is already load-bearing. `FlatCoefficients.agda` uses it to show that the forward direction of the structural de Rham equivalence is the canonical precomposition map, not just some abstract equivalence.

## Chunk 8 - shape-map

```agda
shape-map : {A : Type ℓ} {B : Type ℓ'} → (A → B) → ShapeModality A → ShapeModality B
shape-map f = shape-rec shape-modality-idempotent (shape-unit ∘ f)
```

`shape-map f` lifts `f : A -> B` to `ʃA -> ʃB`.

The target is `ʃB`, and `shape-rec` requires the target to be shape-modal. That requirement is supplied by:

```agda
shape-modality-idempotent : IsShapeModal (ShapeModality B)
```

from `Adjunctions.agda`. Remember the status: that idempotency fact is itself postulated, because proving it would need dependent `shape-ind` (02_§8).

The map is still a definition. The laws about the map are where the missing eliminator becomes visible.

## Chunk 9 - shape functor laws

```agda
postulate
  shape-map-id : {A : Type ℓ} (u : ShapeModality A)
    → shape-map (λ a → a) u ≡ u

  shape-map-comp : {A : Type ℓ} {B : Type ℓ'} {C : Type ℓ''}
    (f : A → B) (g : B → C) (u : ShapeModality A)
    → shape-map (g ∘ f) u ≡ shape-map g (shape-map f u)
```

These are the same identity and composition laws flat proved in chunks 4 and 5. For shape, they are postulated.

The reason is precise. A proof of `shape-map-id` would need to reason over arbitrary `u : ʃA` with the dependent family:

```agda
shape-map id u ≡ u
```

But the file only has `shape-rec`, which eliminates into a fixed shape-modal target. It does not have dependent `shape-ind`, which would eliminate into a family of types indexed by `u`. So the law is true in the intended cohesive setting, but not derived from the current synthetic interface.

## Chunk 10 - sharp-map and sharp functor laws

```agda
sharp-map : {A : Type ℓ} {B : Type ℓ'} → (A → B) → SharpModality A → SharpModality B
sharp-map f = sharp-rec sharp-modality-idempotent (sharp-unit ∘ f)

postulate
  sharp-map-id : {A : Type ℓ} (u : SharpModality A)
    → sharp-map (λ a → a) u ≡ u

  sharp-map-comp : {A : Type ℓ} {B : Type ℓ'} {C : Type ℓ''}
    (f : A → B) (g : B → C) (u : SharpModality A)
    → sharp-map (g ∘ f) u ≡ sharp-map g (sharp-map f u)
```

The sharp block is the shape block with `♯` in place of `ʃ`.

`sharp-map` is definable because `sharp-rec` can map out of `♯A` into the sharp-modal target `♯B`, and `sharp-modality-idempotent` supplies the needed modal-target proof. The identity and composition laws are postulated because proving them would require dependent `sharp-ind`.

This is the same unsoldered-slot pattern as before: the console can route signal, but the general calibration laws are assumed until the dependent eliminator is installed.

## Closing

What this file proves:

- `flat-map`;
- `flat-map-id`;
- `flat-map-comp`;
- `flat-counit-natural`.

What it defines using earlier postulates:

- `shape-map`;
- `sharp-map`.

What it newly postulates:

- `shape-flat-natural-B`;
- `shape-map-id` and `shape-map-comp`;
- `sharp-map-id` and `sharp-map-comp`.

The next file, `Fracture.agda`, immediately uses the proved flat naturality law to make the fracture square commute. It then postulates the stronger claim that the canonical map into the pullback is an equivalence.

