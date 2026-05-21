# Presheaf.agda - the generic Hybrid adapter

## Where This File Sits

`agda/Concurrency/Hybrid/Presheaf.agda` is the generic core of the Hybrid layer.

The file does one concrete thing: it turns sub-view embeddings of actor frames into restriction morphisms in a target category. That is Adapter 1 from the Hybrid intro.

It also states separatedness, the uniqueness half of sheaf descent. It does not prove separatedness for every presheaf, and it does not state full gluing. The file is careful about that boundary because the project does not yet have the richer categorical structure needed for the full descent story.

## Chunk 1 - header and adapter map

```agda
{-# OPTIONS --cubical --guardedness #-}

-- Hybrid layer (Adapter 1): generic frame-presheaf chassis.
--
-- This file is the first concrete realization of the Hybrid as an
-- *adapter layer* between the actor-causal locality leg
-- (`Concurrency/Sites/ActorCausal.agda`) and the session-content /
-- *-autonomous algebra leg (`Concurrency/Algebras/StarAutonomous.agda`,
-- specialized to `Concurrency/Algebras/Sessions.agda` in the sibling
-- file `Concurrency/Hybrid/SessionPresheaf.agda`).
```

The header is unusually long because it is doing architectural bookkeeping.

The key phrase is "adapter layer." This file is not the whole hybrid theory. It is not even the whole sheaf theory. It implements one adapter: a sub-view of an actor frame induces a restriction of typed content.

The comments also name future adapters: descent, the unit/dualizing bridge, operadic valuation over frames, promotion, the modal cross-site adapter, and no-leak erasure. Naming them here keeps the current file from being overloaded. The file can be small because the deferred pieces have explicit names.

## Chunk 2 - imports

```agda
module Concurrency.Hybrid.Presheaf where

open import Cubical.Foundations.Prelude

open import Concurrency.Sites.ActorBase
  using ( ActorBase )
open import Concurrency.Sites.ActorCausal
  using ( LocalFrame ; FrameHom ; frame-id ; _∘ᶠ_ ; Cover )
open import Concurrency.Algebras.StarAutonomous
  using ( StarAutonomous )
```

The imports enforce the intended separation.

From the Sites side, the file imports actor bases, local frames, frame morphisms, frame identity/composition, and covers. From the Algebras side, it imports only the abstract `StarAutonomous` target.

It does not import operads. It does not import session syntax. That is not an accident. This generic adapter should work for any star-autonomous target, not only for the current session instance.

## Chunk 3 - module parameterization

```agda
module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓV ℓH : Level} (V : StarAutonomous ℓV ℓH) where

  open StarAutonomous V
```

The whole file works over a fixed actor base `AB` and a fixed target category `V`.

Opening `StarAutonomous V` brings names like `Ob`, `Hom`, `id`, and composition into scope. So the presheaf can assign target objects to frames and target morphisms to frame inclusions.

The file takes `ActorBase`, not `ActorCausalSite`. Adapter 1 needs the frame category and the cover type, but it does not use the site axioms. Pullback-stability and transitivity of covers become important when full gluing is stated. They are not needed to say what restriction is.

## Chunk 4 - `FramePresheaf`

```agda
  record FramePresheaf {ℓE ℓR : Level}
       : Type (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE (ℓ-max ℓR (ℓ-max ℓV ℓH))))) where
    field
      value :
        LocalFrame AB ℓE ℓR → Ob
      restrict :
        {F G : LocalFrame AB ℓE ℓR}
        → FrameHom AB G F
        → Hom (value F) (value G)
      restrict-id :
        {F : LocalFrame AB ℓE ℓR}
        → restrict (frame-id AB F) ≡ id
      restrict-comp :
        {F G H : LocalFrame AB ℓE ℓR}
        (ψ : FrameHom AB G H) (φ : FrameHom AB F G)
        → restrict (_∘ᶠ_ AB ψ φ) ≡ restrict φ ∘ restrict ψ
```

This is the presheaf record.

`value` assigns typed content to each local frame. In the generic file, "typed content" just means an object of the target category `V`.

`restrict` is the heart of the adapter. A frame morphism `G ↪ F` embeds the smaller view `G` into the larger view `F`. Restriction goes the other way:

```agda
Hom (value F) (value G)
```

That is the contravariant direction. If we know content over the larger view, we can forget down to the smaller view.

`restrict-id` says restricting along the identity sub-view is the identity morphism.

`restrict-comp` says nested restrictions compose in the reversed order. If `F ↪ G ↪ H`, then restricting from `H` to `F` is the same as first restricting from `H` to `G`, then from `G` to `F`.

## Chunk 5 - separatedness

```agda
  record IsSeparatedPresheaf
           {ℓE ℓR ℓI : Level}
           (P : FramePresheaf {ℓE} {ℓR})
       : Type (...) where
    open FramePresheaf P
    field
      cover-jointly-monic :
        {F : LocalFrame AB ℓE ℓR}
        (c : Cover AB ℓI F)
        {X : Ob}
        (x y : Hom X (value F))
        → ((i : Cover.Index c)
            → restrict (Cover.embed c i) ∘ x
              ≡ restrict (Cover.embed c i) ∘ y)
        → x ≡ y
```

This record says the presheaf is separated.

Take a cover `c` of a frame `F`. Take two candidate morphisms into the content over `F`:

```agda
x y : Hom X (value F)
```

The object `X` is an arbitrary probe. The file does not use only `𝟙 → value F`, because in a linear or star-autonomous setting `𝟙` is the tensor unit, not automatically a terminal object. Quantifying over all `X` states the cleaner categorical property: the cover restrictions are jointly monic on hom-sets into `value F`.

If every patch sees `x` and `y` as equal after restriction, then `x` and `y` are equal globally.

This is not full descent. Full descent would also say that compatible local data can be glued into global data. Separatedness says only that such a global datum, if it exists, is unique.

## Chunk 6 - the constant presheaf

```agda
  const-presheaf : {ℓE ℓR : Level} → Ob → FramePresheaf {ℓE} {ℓR}
  const-presheaf X = record
    { value         = λ _ → X
    ; restrict      = λ _ → id
    ; restrict-id   = refl
    ; restrict-comp = λ _ _ → sym (id-l id)
    }
```

The constant presheaf assigns the same target object `X` to every frame.

Every restriction morphism is the identity on `X`. The identity law is immediate by `refl`. The composition law uses the left identity law for target morphism composition: composing identity with identity is still identity.

This is an inhabitability witness for the interface. It shows the record is usable without building a frame-sensitive example yet.

The file does not prove that every constant presheaf is separated. That omission is intentional. If the site allowed an empty cover, separatedness over that cover would say any two parallel morphisms into `X` are equal, because there are no patches on which to test them. That is not true in an arbitrary target category.

## Chunk 7 - what the file leaves open

```agda
-- Non-trivial witnesses (varying `value` over distinct frames) are
-- deferred to v1.1 alongside displayed-subsite machinery.
```

The current `LocalFrame` type is intentionally austere. Building honest frame-sensitive values would require more infrastructure for discriminating frames without smuggling in postulates about frame equality.

So v1 does the correct first step: define the presheaf interface, define separatedness as a property, and give the constant presheaf. The session-specific constants come next.
