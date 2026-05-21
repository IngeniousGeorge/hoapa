# Adjunctions.agda — wiring the three consoles into a cohesive rack

## Where this file sits

`agda/ModalHoTT/Modalities/Adjunctions.agda` is the second floor of the synthetic track. (01_§2) installed three consoles — `FlatModality`, `ShapeModality`, `SharpModality` — each on its own panel, with entry and exit jacks but no connections between them. This file runs the cables: two adjunctions, `♭ ⊣ ♯` and `ʃ ⊣ ♭`, plus the idempotency results that follow from having them. With the cables in place, the three consoles are no longer independent — they form a single coherent rack, and *that* rack is what we mean by *cohesive*. The closing chunk of the previous file (01_§12) previewed exactly this move.

## What an adjunction does, briefly

An adjunction between two operations is a *natural bijection of hom-sets*: the maps out of one operation, on one side, correspond one-to-one with the maps into the other operation, on the matching side. The bijection isn't between individual maps — it's between the whole space of maps on each side, in a way that respects the structure around it.

In our case:

- `♭ ⊣ ♯` says: the maps `♭A → B` are in bijection with the maps `A → ♯B`.
- `ʃ ⊣ ♭` says: the maps `ʃA → B` are in bijection with the maps `A → ♭B`.

The picture, in metaphor: each adjunction is a *family of patch cables*, one for every pair of types A and B. The cable doesn't move information — it *re-routes* it. Whatever you could do by sending signal out of `♭A`'s exit jack into B, you could equivalently do by sending signal from A into `♯B`'s entry jack. The cable is the bijection that swaps your view of the wiring without changing what gets done.

The word "natural" in "natural bijection" is doing real work: the bijection isn't just for one fixed (A, B), it's a coherent system of bijections that play well with maps between different A's and different B's. Naturality is **not** recorded in this file — it lives, in the one piece currently load-bearing, in `Properties.agda` as `shape-flat-natural-B`. We'll come back to that.

> **References**
> - [nLab: adjunction](https://ncatlab.org/nlab/show/adjunction)
> - [nLab: adjoint modality](https://ncatlab.org/nlab/show/adjoint+modality)
> - [Schreiber, *Differential cohomology in a cohesive ∞-topos*, §3 (arXiv)](https://arxiv.org/abs/1310.7930) — adjoint-modality perspective on `ʃ ⊣ ♭ ⊣ ♯`

## Chunk 1 — pragma, module, imports, variables

```agda
{-# OPTIONS --cubical --guardedness #-}

module ModalHoTT.Modalities.Adjunctions where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv
open import Cubical.Foundations.Function
open import Cubical.Foundations.Isomorphism

open import ModalHoTT.Modalities.Cohesion

private
  variable
    ℓ ℓ' : Level
```

Most of this is familiar from (01_§1) and (01_§3). Two new pieces.

`open import Cubical.Foundations.Isomorphism` adds `Iso` and `isoToEquiv` to scope. We'll meet both at chunk 7, where the ♭-idempotency proof builds an `Iso` first and lifts it to an equivalence.

`open import ModalHoTT.Modalities.Cohesion` is the first time a file in the project imports another project file. Everything postulated in (01) — the three modality operators, their units and counits, `flat-ind`, the `IsXModal` predicates — comes into scope here. The cables we're about to install are *between* objects from that file.

## Chunk 2 — the file's own preamble comment

```agda
-- Adjunctions ♭ ⊣ ♯ and ʃ ⊣ ♭ for the three cohesion modalities.
--
-- Each adjunction is a postulated hom-set equivalence, with a coherence
-- condition tying it to the existing modality structure in Cohesion.agda.
-- Named transpose operations are derived as definitions from those equivalences.
--
-- Idempotency:
--   IsFlatModal  (FlatModality A)   proved as a theorem via flat-counit-intro
--   IsSharpModal (SharpModality A)  postulated (derivation requires ♯-ind)
--   IsShapeModal (ShapeModality A)  postulated (derivation requires ʃ-ind)
--
-- Naturality of the hom-set equivalences is not recorded here; the one
-- piece currently load-bearing — naturality of `shape-flat-transpose`
-- in B — sits in Properties.agda as `shape-flat-natural-B`.
```

The comment compactly previews the whole file. Three things worth pulling out.

First, "postulated hom-set equivalence, with a coherence condition" is the architecture. Each adjunction lands as *two* postulates: one declaring the cable exists (the equivalence), one calibrating it to the modality structure built in (01) (the coherence). The named transpose operations on top are then *definitions*, not postulates — they're convenient handles on the two directions of the equivalence.

Second, the idempotency table is the asymmetry the rest of the file makes precise. ♭ is proved idempotent; ♯ and ʃ are postulated to be. The reason is that ♭ shipped with a dependent eliminator — `flat-ind` from (01_§6) — that we can actually use to construct the proof, while the corresponding `sharp-ind` and `shape-ind` are the unsoldered slots flagged at (01_§10). What looks from outside like a unified "three modalities are all idempotent" claim breaks, on closer reading, into one proof and two postulates.

Third, the naturality note matters more than its position in a comment suggests. A bare hom-set equivalence at each individual (A, B) is enough to write the type signature, but not enough to do real category theory on top — you need naturality to compose anything. One specific piece, `shape-flat-natural-B`, is recorded in `Properties.agda` because the de Rham work needed it; the rest is open. See `workflow/rug.md` for the broader picture of what's been shortcut.

## Chunk 3 — the first cable: ♭ ⊣ ♯ as a hom-set equivalence

```agda
postulate
  flat-sharp-transpose : {A : Type ℓ} {B : Type ℓ'}
    → (FlatModality A → B) ≃ (A → SharpModality B)
```

The cable. For any types A and B, the postulate declares an equivalence — written `≃` — between two function types: maps `♭A → B` on the left, maps `A → ♯B` on the right.

A short pause on `≃`. At (01_§9), `≃` (via `isEquiv`) was a *property* of a particular map — `IsFlatModal A = isEquiv (flat-counit)` said "the counit `♭A → A` is an equivalence." Here `≃` is doing something one step heavier: it asserts an equivalence between two *types*, namely the function-types `(♭A → B)` and `(A → ♯B)`. In HoTT, an equivalence between types is the right form of "sameness" — a bijection between their inhabitants, with coherence data showing the bijection plays well with paths.

This is exactly the *patch cable* foreshadowed at (01_§12). Concretely: every function `f : ♭A → B` on the left has a unique counterpart `g : A → ♯B` on the right, and vice versa. The cable doesn't move information; it re-routes the view. Whatever you can express as a map out of `♭A`, you can equivalently express as a map into `♯B`, and the rerouting is bijective.

The cable is a *family*. Implicit arguments make this read as a single declaration, but `flat-sharp-transpose {A} {B}` is a different equivalence for each choice of A and B. The "family of cables" picture is literal — the type signature has free indices A and B.

What this postulate does **not** say: that the family is natural in A and B, i.e., that the cables play well with maps `A → A'` and `B → B'`. See chunk 2 for where the one load-bearing piece of naturality lives.

## Chunk 4 — calibrating the cable: the coherence postulate

```agda
  flat-sharp-counit-compat : {A : Type ℓ}
    → equivFun (flat-sharp-transpose {A = A} {B = A}) flat-counit ≡ sharp-unit
```

A bare equivalence (chunk 3) declares a cable exists. It doesn't say *which* cable. Any two equivalences between the same pair of types would satisfy chunk 3 alone — there's no constraint that the cable be the *right* one (the one the cohesive structure actually needs).

This second postulate is the constraint. Read the signature carefully:

- `flat-sharp-transpose {A = A} {B = A}` is the cable instance at `B := A`. So the left side is `(♭A → A)` and the right side is `(A → ♯A)`.
- `equivFun` is the forward direction of an equivalence — it's how you "use the `≃` as a function from left to right." We'll meet `equivFun`, `invEq`, `retEq`, `secEq` together in chunk 5.
- `flat-counit : ♭A → A` is the operation we postulated at (01_§4). It lives on the left side of this particular cable.
- `sharp-unit : A → ♯A` is the operation we postulated at (01_§11). It lives on the right side.

Reading the equation: send `flat-counit` through the cable, and the cable returns `sharp-unit`. The cable *pins* these two operations to each other.

In the metaphor: the cable is calibrated to the existing jacks on the consoles. The counit jack on ♭'s panel — the exit from `♭A` to `A` — must align, through the cable, with the unit jack on ♯'s panel — the entry from `A` to `♯A`. Without this alignment, the cable would still exist (the bijection of hom-sets would hold), but it would be the wrong cable — a re-wiring that didn't respect the modal structure (01) built up.

This is the kind of postulate it's easy to skim past as "obvious type-theory bookkeeping," but it is where the whole adjunction earns its name. *An adjunction between modalities is precisely a hom-set bijection that aligns counit and unit.* Without the coherence, you'd have two operations that happen to admit a bijection between their map-spaces; with it, you have an actual adjoint pair.

## Chunk 5 — what an equivalence affords: the four projections

```agda
flat-to-sharp : {A : Type ℓ} {B : Type ℓ'}
  → (FlatModality A → B) → (A → SharpModality B)
flat-to-sharp = equivFun flat-sharp-transpose

sharp-to-flat : {A : Type ℓ} {B : Type ℓ'}
  → (A → SharpModality B) → (FlatModality A → B)
sharp-to-flat = invEq flat-sharp-transpose

flat-sharp-retract : {A : Type ℓ} {B : Type ℓ'} (f : FlatModality A → B)
  → sharp-to-flat (flat-to-sharp f) ≡ f
flat-sharp-retract f = retEq flat-sharp-transpose f

flat-sharp-section : {A : Type ℓ} {B : Type ℓ'} (g : A → SharpModality B)
  → flat-to-sharp (sharp-to-flat g) ≡ g
flat-sharp-section g = secEq flat-sharp-transpose g
```

Four definitions, all unfolding the same equivalence — `flat-sharp-transpose` — into four named operations. Note the absence of `postulate`: nothing new is being asserted. Each line uses one of the standard cubical-library projections from an equivalence:

- `equivFun e` — the forward direction of the equivalence `e`.
- `invEq e` — the backward direction.
- `retEq e f` — the proof that going forward then backward returns `f` (the "retract" half).
- `secEq e g` — the proof that going backward then forward returns `g` (the "section" half).

Together, these four are everything an equivalence packages up: two maps, plus the two round-trip witnesses. (HoTT's equivalences carry more coherence than this, but for working with them at the level we need, these four are the day-to-day handles.)

The reason to give them names rather than always writing `equivFun flat-sharp-transpose`: downstream files will compose these often, and named operations make the intent clear in proof bodies. `flat-to-sharp` reads — and behaves — as a function of its own, not as a projection through machinery.

In the metaphor: the cable affords four operations — push left-to-right, push right-to-left, round-trip on the left side and check it returns home, round-trip on the right side and check the same. These are *the* operations the patch cable supports; there are no others worth naming.

A small Ruby/JS analogy if it helps: think of a bidirectional adapter object. `equivFun` is `.encode`, `invEq` is `.decode`, `retEq` and `secEq` are the witnesses that decode-after-encode and encode-after-decode each return the identity. The cubical library wires the four together coherently and hands you the whole package as `≃`.

## Chunk 6 — the second cable: ʃ ⊣ ♭

```agda
postulate
  shape-flat-transpose : {A : Type ℓ} {B : Type ℓ'}
    → (ShapeModality A → B) ≃ (A → FlatModality B)

  shape-flat-adj-unit-eq : {A : Type ℓ}
    → equivFun (shape-flat-transpose {A = A} {B = ShapeModality A}) (λ u → u)
    ≡ flat-intro ∘ shape-unit

shape-to-flat : {A : Type ℓ} {B : Type ℓ'}
  → (ShapeModality A → B) → (A → FlatModality B)
shape-to-flat = equivFun shape-flat-transpose

flat-to-shape : {A : Type ℓ} {B : Type ℓ'}
  → (A → FlatModality B) → (ShapeModality A → B)
flat-to-shape = invEq shape-flat-transpose

shape-flat-retract : {A : Type ℓ} {B : Type ℓ'} (f : ShapeModality A → B)
  → flat-to-shape (shape-to-flat f) ≡ f
shape-flat-retract f = retEq shape-flat-transpose f

shape-flat-section : {A : Type ℓ} {B : Type ℓ'} (g : A → FlatModality B)
  → shape-to-flat (flat-to-shape g) ≡ g
shape-flat-section g = secEq shape-flat-transpose g
```

The second cable follows the template from chunks 3, 4, and 5: one postulate for the equivalence, one for the calibration, four definitions for the named projections. The four projections aren't worth re-explaining — same template, different cable. The coherence postulate is.

Compare the two calibrations:

- For `♭ ⊣ ♯` (chunk 4), `flat-sharp-counit-compat` pins `flat-counit ↦ sharp-unit` — counit on the left, unit on the right, at the diagonal `B := A`.
- For `ʃ ⊣ ♭`, `shape-flat-adj-unit-eq` pins the cable's action on the *identity* `(λ u → u) : ʃA → ʃA` to the composite `flat-intro ∘ shape-unit : A → ♭(ʃA)`.

These look different but they're the same shape, viewed from two ends. Every adjunction has a *unit* (a map into a composition of the two operations, in one direction) and a *counit* (a map out of the composition, in the other direction). The two coherence postulates each pin one natural witness on each cable:

- The counit `flat-counit : ♭A → A` transposes, through the `♭ ⊣ ♯` cable, to the unit `sharp-unit : A → ♯A`.
- The identity `id : ʃA → ʃA` transposes, through the `ʃ ⊣ ♭` cable, to the unit of the adjunction itself, `flat-intro ∘ shape-unit : A → ♭(ʃA)`.

Both equations say the same kind of thing: *the canonical map on one side of the cable corresponds, through the cable, to the canonical map on the other side*. The two postulates *look* different only because what counts as "canonical" differs between the two adjunctions. For `♭ ⊣ ♯`, the cleanest pin runs from counit to unit at the diagonal; for `ʃ ⊣ ♭`, the cleanest pin runs from identity to the adjunction unit.

> **References**
> - [nLab: unit of an adjunction](https://ncatlab.org/nlab/show/unit+of+an+adjunction)
> - [nLab: counit of an adjunction](https://ncatlab.org/nlab/show/counit+of+an+adjunction)

## Chunk 7 — ♭ is idempotent: where flat-ind finally does work

```agda
-- ♭ is idempotent: ♭A is always flat-modal.
-- Proof: build an explicit Iso using flat-counit-intro (rightInv) and
-- flat-ind to extend it to leftInv.
flat-modality-idempotent : {A : Type ℓ} → IsFlatModal (FlatModality A)
flat-modality-idempotent {A = A} = isoToEquiv theIso .snd
  where
    leftInv-proof : (u : FlatModality (FlatModality A))
                  → flat-intro (flat-counit u) ≡ u
    leftInv-proof =
      flat-ind {A = FlatModality A} _
               (λ a → cong flat-intro (flat-counit-intro a))

    theIso : Iso (FlatModality (FlatModality A)) (FlatModality A)
    theIso = iso flat-counit flat-intro flat-counit-intro leftInv-proof
```

The longest chunk in the file. Take it carefully — this is where the abstract postulates from (01) finally pay off.

**What we're proving.** `flat-modality-idempotent` has type `IsFlatModal (FlatModality A)`. Unfolding the definition from (01_§9): this is `isEquiv (flat-counit {A = ♭A})` — that the counit at `♭A`, which is the map `♭(♭A) → ♭A`, is an equivalence. Operationally: applying ♭ to something already ♭'d doesn't change it; ♭ is *idempotent*. This is one of the basic facts every cohesive modality must satisfy, and the only one of the three idempotency results we can actually prove. The other two — for ♯ and ʃ — are postulated in chunk 8 because the tools needed to prove them are exactly the unsoldered slots from (01_§10).

**The strategy.** Build an `Iso` first, then lift it to an equivalence via `isoToEquiv`. An `Iso` between types X and Y, in the cubical library, packages four pieces: a forward function `X → Y`, a backward function `Y → X`, a *section* (`forward ∘ backward = id` on Y), and a *retract* (`backward ∘ forward = id` on X). The `iso` constructor takes them in that order.

So `theIso : Iso (♭(♭A)) (♭A)` needs:

- forward: `♭(♭A) → ♭A`. We have `flat-counit` at the right type.
- backward: `♭A → ♭(♭A)`. We have `flat-intro` at the right type.
- section: `flat-counit ∘ flat-intro = id` on `♭A`. This is exactly `flat-counit-intro` from (01_§8), now at base type `♭A`.
- retract: `flat-intro ∘ flat-counit = id` on `♭(♭A)`. This is *not* a postulate; we have to build it.

The retract is what `leftInv-proof` constructs, and it's the only piece of real work in this chunk.

**The retract construction.** The goal is a proof that for every `u : ♭(♭A)`, we have `flat-intro (flat-counit u) ≡ u`. The trick is that we don't have to define this directly on arbitrary `u`. `flat-ind` from (01_§6) lets us reduce to the case where `u` has the form `flat-intro a` for some `a : ♭A`.

Recall what (01_§6) said `flat-ind` does: to define a function `(u : ♭A) → B u` for a dependent family `B`, it suffices to define it on inputs of the form `flat-intro a`. We're using it here for `B u := (flat-intro (flat-counit u) ≡ u)` — a family of *equality types* parameterized by `u`. The underscore `_` in `flat-ind {A = FlatModality A} _ …` is where that family goes; Agda infers it.

On the `flat-intro a` case, the goal becomes `flat-intro (flat-counit (flat-intro a)) ≡ flat-intro a`. By `flat-counit-intro` from (01_§8), we have `flat-counit (flat-intro a) ≡ a`. Applying `flat-intro` to both sides of *that* path — that's what `cong flat-intro` does — gives `flat-intro (flat-counit (flat-intro a)) ≡ flat-intro a`. Done.

This is the moment two postulates from (01) earn their keep in five lines of proof. The abstract eliminator `flat-ind`, which (01_§6) introduced as "case analysis for a sealed type," is here used for its actual purpose: extending a pointwise identity that's easy to check on `flat-intro a` inputs into a global identity holding on every `u : ♭(♭A)`. The β-rule `flat-counit-intro` from (01_§8) supplies the pointwise check.

**On `cong`.** `cong f p` is the standard HoTT operation "transport a path along a function": given `p : x ≡ y`, it gives `cong f p : f x ≡ f y`. You can read it as "f respects the equality between x and y." From the cubical prelude.

**The `.snd` at the end.** `isoToEquiv theIso` produces a value of type `Σ` (forward function) (proof it's an equivalence) — equivalently, a pair `(forward, isEquiv-proof)`. We want the proof, which is the second projection: `.snd`.

> **References**
> - [Cubical Agda library: Foundations.Equiv](https://agda.github.io/cubical/Cubical.Foundations.Equiv.html) — `equivFun`, `invEq`, `retEq`, `secEq`, `isEquiv`
> - [Cubical Agda library: Foundations.Isomorphism](https://agda.github.io/cubical/Cubical.Foundations.Isomorphism.html) — `Iso`, `iso`, `isoToEquiv`

## Chunk 8 — ♯ and ʃ idempotency: the unsoldered slots show through

```agda
-- ♯ is idempotent: ♯A is always sharp-modal.
-- Follows from ♭ ⊣ ♯ in the Bℤ model; derivation in the synthetic setting
-- requires dependent elimination for ♯ (deferred; see status.md).
postulate
  sharp-modality-idempotent : {A : Type ℓ} → IsSharpModal (SharpModality A)

-- ʃ is idempotent: ʃA is always shape-modal.
-- Follows from ʃ ⊣ ♭ in the Bℤ model; derivation requires ʃ-ind (deferred).
postulate
  shape-modality-idempotent : {A : Type ℓ} → IsShapeModal (ShapeModality A)
```

The other two idempotency results. We'd *want* them as theorems, mirroring chunk 7. Instead they're postulates, and the reason is visible if we look back: (01_§10) and (01_§11) shipped the shape and sharp consoles with non-dependent recursors only (`shape-rec`, `sharp-rec`), and left empty slots where the dependent inductors (`shape-ind`, `sharp-ind`) would go.

Chunk 7's proof of ♭-idempotency leaned on `flat-ind`'s *dependent* elimination — it built a path-valued family `(u : ♭(♭A)) → flat-intro (flat-counit u) ≡ u` and extended a pointwise check across it. With only non-dependent recursion, the corresponding move for ♯ and ʃ is blocked: a recursor that only lets you land in a fixed target type can't be used to inhabit a family of equality types varying with the input. The comments in the file say exactly this: "derivation requires ♯-ind" and "derivation requires ʃ-ind." Both are open items in `workflow/status.md`.

The honest framing: in the intended semantic model (the cohesive ∞-topos on Bℤ), all three modalities are idempotent. We're not making something up; we're recording theorems-of-the-model that we can't yet derive *inside* the synthetic theory because the synthetic theory is missing two postulates from (01). Adding `shape-ind` and `sharp-ind` — as further postulates, in the shape of `flat-ind` — would turn both of these into theorems with proofs mechanically identical to chunk 7's.

This same asymmetry will ripple through the next file: four map laws in `Properties.agda` that are theorems for ♭ but postulates for ʃ and ♯. The unsoldered slots from (01_§10) and (01_§11) are the root cause every time.

## Chunk 9 — closing

What this file has installed:

- Two cables — `♭ ⊣ ♯` and `ʃ ⊣ ♭` — each a postulated hom-set equivalence plus a coherence condition pinning it to the modality structure from (01).
- Eight named projections (four per cable) — derived definitions, no new commitments, giving day-to-day handles on each equivalence.
- One real theorem — ♭'s idempotency — built from `flat-ind` and `flat-counit-intro`, both from (01).
- Two parallel postulates — ♯ and ʃ idempotency — placeholders where theorems would sit if `sharp-ind` and `shape-ind` existed.

What this file has **not** installed: naturality of the hom-set equivalences in A and B. A bare equivalence at each individual (A, B) is enough to write the type signature, but not enough to compose adjunctions or to build the higher coherences real category theory requires. One specific piece of naturality lives downstream in `Properties.agda` (`shape-flat-natural-B`), because the de Rham work needed it; the rest is an open task.

With the cables in place, the three consoles from (01) are no longer independent — they form a single rack. That rack is what we mean by *cohesive*. From here, two more files extend the picture:

- `Properties.agda` derives the functoriality of each modality (its `map` operation, plus the `map-id` and `map-comp` laws) and consequences like the commutativity of the fracture square. It also records the one piece of naturality currently load-bearing.
- `Fracture.agda` states the fracture theorem — a structural property of the cohesive rack that's the door to the de Rham work the project is currently pointed at.
