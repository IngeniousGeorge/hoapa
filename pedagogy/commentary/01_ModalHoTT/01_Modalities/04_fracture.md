# Fracture.agda - the cohesive pullback square

## Where this file sits

`formal/ModalHoTT/Modalities/Fracture.agda` states the fracture theorem for the synthetic cohesive setting. This is one of the first places where the three-console rack does something genuinely geometric.

The picture is a square:

```text
♭A ---------> A
 |            |
 v            v
♭(♯A) -----> ♯A
```

The upper arrow is `flat-counit`. The right arrow is `sharp-unit`. The left arrow applies `flat-map sharp-unit`. The lower arrow is again `flat-counit`, now at `♯A`.

The file does two different things, and the distinction matters:

- it proves that the square commutes, using `flat-counit-natural` from `Properties.agda`;
- it postulates that `♭A` is equivalent to the pullback of the lower-right cospan.

In real-cohesive HoTT, the fracture theorem follows from sharp being lex, meaning sharp preserves finite limits. This project does not postulate all of `♯`-lex. It postulates the exact pullback equivalence it needs.

> **References**
> - [nLab: cohesive homotopy type theory](https://ncatlab.org/nlab/show/cohesive+homotopy+type+theory)
> - [nLab: modality](https://ncatlab.org/nlab/show/modality+%28in+homotopy+type+theory%29)
> - [nLab: pullback](https://ncatlab.org/nlab/show/pullback)
> - [Shulman, *Brouwer's fixed-point theorem in real-cohesive HoTT*, 2018 (arXiv)](https://arxiv.org/abs/1509.07584)

## Chunk 1 - header status

```agda
{-# OPTIONS --cubical --guardedness #-}

-- The fracture theorem for cohesive HoTT.
--
-- For any type A, the canonical square
--
--     ♭A ————→ A
--      |        |
--      ↓        ↓
--     ♭(♯A) ——→ ♯A
--
-- is a pullback.
```

The header announces the theorem before the code unfolds it.

The square has a simple reading. A point of `♭A` can be viewed in two ways:

- forget flatness to get a point of `A`, then include it into `♯A`;
- first map it into `♭(♯A)` by applying `sharp-unit` under `flat-map`, then forget flatness.

Those two routes should land at the same point of `♯A`. That is the commutative-square part. The stronger fracture claim says `♭A` is not merely mapped into the pullback: it *is* the pullback, up to equivalence.

## Chunk 2 - imports and variables

```agda
module ModalHoTT.Modalities.Fracture where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv

open import ModalHoTT.Modalities.Cohesion
open import ModalHoTT.Modalities.Properties

private
  variable
    ℓ : Level
```

The dependencies are spare.

`Cohesion` supplies `FlatModality`, `SharpModality`, `flat-counit`, and `sharp-unit`. `Properties` supplies `flat-map` and `flat-counit-natural`. Notice that `Adjunctions` is not imported directly; fracture here needs the modal operations and the flat naturality law, not the transpose names.

## Chunk 3 - the pullback type

```agda
FracturePullback : Type ℓ → Type ℓ
FracturePullback A =
  Σ[ a ∈ A ] Σ[ u ∈ FlatModality (SharpModality A) ]
    sharp-unit a ≡ flat-counit u
```

This defines the pullback object explicitly as nested dependent pairs.

A point of `FracturePullback A` contains three pieces:

- `a : A`;
- `u : ♭(♯A)`;
- a path saying `sharp-unit a` and `flat-counit u` agree in `♯A`.

The last component is what makes this a pullback rather than just a product. We are not choosing an `A`-point and a `♭(♯A)`-point independently. We choose them together with evidence that they project to the same point in `♯A`.

The syntax `Σ[ a ∈ A ] ...` is dependent-pair notation from the cubical prelude. It is the type-theoretic version of "there exists an `a`, together with more data depending on `a`."

## Chunk 4 - the square commutes

```agda
fracture-square-commutes : (A : Type ℓ) (v : FlatModality A)
  → sharp-unit (flat-counit v) ≡ flat-counit (flat-map sharp-unit v)
fracture-square-commutes A v = sym (flat-counit-natural sharp-unit v)
```

This is the proved part of the file.

Instantiate `flat-counit-natural` from `Properties.agda` with:

```agda
f = sharp-unit
```

It gives:

```agda
flat-counit (flat-map sharp-unit v) ≡ sharp-unit (flat-counit v)
```

The pullback type wants the path in the opposite direction:

```agda
sharp-unit (flat-counit v) ≡ flat-counit (flat-map sharp-unit v)
```

So the proof is just `sym`, path reversal.

This is a useful example of how the project separates what is proved from what is assumed. The commutativity of the square is not another fracture axiom. It is a direct consequence of the flat functoriality laws.

## Chunk 5 - the canonical map into the pullback

```agda
flat-to-pullback : (A : Type ℓ) → FlatModality A → FracturePullback A
flat-to-pullback A v =
  flat-counit v , flat-map sharp-unit v , fracture-square-commutes A v
```

This packages the two routes from `v : ♭A` into the pullback.

The first component is the top arrow:

```agda
flat-counit v : A
```

The second component is the left arrow:

```agda
flat-map sharp-unit v : ♭(♯A)
```

The third component is the commutativity witness from chunk 4. Together they form a point of the nested sigma type from chunk 3.

This named map is important. The fracture theorem below does not merely say there exists some equivalence between `♭A` and the pullback. It says this specific canonical map is an equivalence.

## Chunk 6 - the fracture postulate

```agda
postulate
  fracture : (A : Type ℓ) → isEquiv (flat-to-pullback A)
```

This is the one new postulate in the file.

Read the type as:

```text
for every A, flat-to-pullback A behaves as an equivalence
```

The postulate is narrow. Instead of assuming all finite-limit preservation for `♯`, the project assumes the exact fracture equivalence it currently needs. In the intended real-cohesive setting, this is a theorem. In the current Agda interface, it is not derivable because the sharp side is still underpowered: no `sharp-ind`, no analytic construction of `♯(Bℤ)`, and no full `♯`-lex package.

This is also where the synthetic and analytic tracks diverge most sharply. The synthetic statement quantifies over all types, including the intended `Bℤ` case. The analytic mirror cannot check that case because it does not construct `♯(Bℤ)`.

## Chunk 7 - equivalence form

```agda
fracture-equiv : (A : Type ℓ) → FlatModality A ≃ FracturePullback A
fracture-equiv A = flat-to-pullback A , fracture A
```

This is a packaging definition, not a new assumption.

In cubical Agda, a type equivalence `X ≃ Y` is a pair:

```agda
f : X → Y
isEquiv f
```

The file already has both pieces: `flat-to-pullback A` and `fracture A`. `fracture-equiv` just packages them in the form downstream files are likely to want.

## Closing

What this file proves:

- the fracture square commutes;
- the canonical map `flat-to-pullback` is well-defined.

What this file postulates:

- that `flat-to-pullback A` is an equivalence for every `A`.

The file is a structural hinge for the de Rham arc, but it is not the de Rham theorem. It gives a cohesive pullback property of the modalities. The later cohomology file uses the `ʃ ⊣ ♭` side for a structural flat-coefficient equivalence; differential forms and differential cohesion remain future work.

