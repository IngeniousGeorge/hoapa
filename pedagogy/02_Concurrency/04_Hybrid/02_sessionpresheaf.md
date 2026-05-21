# SessionPresheaf.agda - session-valued frame presheaves

## Where This File Sits

`agda/Concurrency/Hybrid/SessionPresheaf.agda` specializes the generic Hybrid adapter to the session target.

The previous file was generic over any `StarAutonomous` category. This file chooses:

```agda
Sessions-Cat Payload
```

as the target. That turns a `FramePresheaf` into a session-valued presheaf over actor-local frames.

The file then exports two constant examples, one at the session tensor unit and one at the session dualizing object.

## Chunk 1 - header and scope

```agda
{-# OPTIONS --cubical --guardedness #-}

-- Hybrid layer: the session-valued specialization of Adapter 1.
--
-- This file specializes the generic frame-presheaf chassis in
-- `Concurrency/Hybrid/Presheaf.agda` to the *-autonomous target
-- `Sessions-Cat Payload` from `Concurrency/Algebras/Sessions.agda`,
-- and ships the two named constant inhabitants at the tensor unit
-- `𝟙ₛ` and the dualizing object `⊥ₛ` (best-of-both-worlds, Q3
-- resolution).
```

The header makes two things explicit.

First, this is still Adapter 1: restriction. It is not full sheaf descent and it is not operadic valuation over presheaves.

Second, both constant choices are exported. The tensor unit and the dualizing object have different meanings, and the current signature does not include a canonical morphism converting one into the other.

## Chunk 2 - imports

```agda
module Concurrency.Hybrid.SessionPresheaf where

open import Cubical.Foundations.Prelude

open import Concurrency.Sites.ActorBase
  using ( ActorBase )
open import Concurrency.Algebras.StarAutonomous
  using ( StarAutonomous )
open import Concurrency.Algebras.Sessions
  using ( Sessions-Cat )
open import Concurrency.Hybrid.Presheaf
  using ( FramePresheaf ; IsSeparatedPresheaf ; const-presheaf )
```

This file is the first Hybrid file that imports `Sessions-Cat`.

It still does not import the operad files. That is the same boundary as before: restriction over frames is Adapter 1, while the operadic valuation of session content over frames is a later adapter.

From `Presheaf.agda`, this file reuses three things: the presheaf record, the separatedness property, and the generic constant presheaf constructor.

## Chunk 3 - module parameterization

```agda
module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓv ℓ' : Level} (Payload : Type ℓv) where
```

The specialization is parameterized by an actor base and a payload type.

The actor base supplies the frames. The payload type supplies the message-content parameter for session syntax. As before, actors are not refined by payloads. Payloads live in the session content layer, not in actor identity.

`ℓ'` is the hom-level parameter used by the session category. The details are bookkeeping, but the separation is useful: payloads and session morphism proofs need not live in the same universe.

## Chunk 4 - the target category

```agda
  SessionsV : StarAutonomous ℓv (ℓ-max ℓv ℓ')
  SessionsV = Sessions-Cat {ℓ' = ℓ'} Payload
```

`SessionsV` is just a local name for the chosen target.

The previous file talked about an abstract target `V`. Here `V` is the star-autonomous category built from the multiplicative session syntax in `Sessions.agda`.

Naming it makes the rest of the file read cleanly: a session presheaf is a frame presheaf valued in `SessionsV`.

## Chunk 5 - aliases

```agda
  SessionPresheaf : {ℓE ℓR : Level}
    → Type (ℓ-suc (ℓ-max ℓA
                    (ℓ-max ℓE
                      (ℓ-max ℓR (ℓ-max ℓv ℓ')))))
  SessionPresheaf {ℓE} {ℓR} = FramePresheaf AB SessionsV {ℓE} {ℓR}

  IsSeparatedSessionPresheaf :
    {ℓE ℓR ℓI : Level}
    → SessionPresheaf {ℓE} {ℓR}
    → Type (...)
  IsSeparatedSessionPresheaf {ℓE} {ℓR} {ℓI} P =
    IsSeparatedPresheaf AB SessionsV {ℓE} {ℓR} {ℓI} P
```

These are definitional aliases.

`SessionPresheaf` does not add fields beyond `FramePresheaf`. It simply fixes the target to `SessionsV`.

`IsSeparatedSessionPresheaf` does the same for separatedness. A session-valued presheaf is separated exactly when the generic separatedness property holds after specializing the target to sessions.

That is an important simplicity point. The session specialization does not change the mathematics of restriction. It only chooses what kind of content lives over each actor-local frame.

## Chunk 6 - the constant presheaves

```agda
  const-𝟙ₛ-presheaf : {ℓE ℓR : Level} → SessionPresheaf {ℓE} {ℓR}
  const-𝟙ₛ-presheaf =
    const-presheaf AB SessionsV (StarAutonomous.𝟙 SessionsV)

  const-⊥ₛ-presheaf : {ℓE ℓR : Level} → SessionPresheaf {ℓE} {ℓR}
  const-⊥ₛ-presheaf =
    const-presheaf AB SessionsV (StarAutonomous.⊥-par SessionsV)
```

Both definitions reuse the generic `const-presheaf`.

`const-𝟙ₛ-presheaf` assigns the tensor unit to every frame. Its reading is neutral: no demanded interaction at this local view.

`const-⊥ₛ-presheaf` assigns the dualizing object to every frame. This matches the codomain used by the `Valuation` and `OperadAlgebra` interfaces, where an interpreted operation lands in `⊥-par`.

The two are deliberately kept separate. In the session target, `⊥ₛ` is the dual of `𝟙ₛ`, but duality is not a morphism from one to the other. A real bridge between them would be additional structure, not something the current star-autonomous signature gives for free.

## Chunk 7 - why this is enough for v1

```agda
-- Scope guardrails. Same as `Presheaf.agda`: no operad imports
-- (`gen`, `plug`, `shift` belong to Adapter 4), no payload metadata
-- on actors, no promotion.
```

The file ends at the right boundary.

It gives a session-valued version of the restriction adapter and two canonical constant inhabitants. It does not say how operadic operations vary over covers. It does not promote conversations into actors. It does not identify tensor unit and dualizing object by a hidden conversion.

That restraint is the point of the Hybrid v1 layer. It establishes the contact surface between locality and typed content without pretending the later adapters already exist.
