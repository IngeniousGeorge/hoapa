# Sessions.agda — the multiplicative session instance

## Where This File Sits

`agda/Concurrency/Algebras/Sessions.agda` is the concrete typed-content instance of the algebra layer. It specializes the abstract interfaces to a minimal multiplicative session-type syntax.

This file is long because it does several jobs:

- defines session syntax and syntactic duality;
- proves duality is involutive;
- defines a structural `Hom` family;
- packages a star-autonomous target `Sessions-Cat`;
- postulates a chosen `O_1` action as `SessionO1Action`;
- defines `session-interp` by HIT recursion;
- fills `Sessions-Val` and `Sessions-Alg`;
- names `boundary-swap-at-gen`, the categorical / operadic R8 face.

It is not a full proof-term calculus for session types. The file is deliberately narrow: enough typed content to instantiate the algebra interfaces, not yet cut elimination or operational semantics.

## Chunk 1 — header guardrails

```agda
-- Multiplicative session-type content layer for cyclic-operad algebras.
--
-- This file is the typed-content / value-layer instance of the algebra
-- interface in `Concurrency/Algebras/{StarAutonomous,Valuation,OperadAlgebra}.agda`.
```

The long header is doing real architectural work.

The file lives on the typed-content side. It does not define actors, frames, covers, or locality. It also does not promote conversations to actors. Those moves belong to the Sites and future modular-envelope layers.

The guardrail "not a Caires-Pfenning proof-term calculus" matters. This file has session *syntax* and categorical structure. It does not yet have proofs-as-processes dynamics.

## Chunk 2 — imports and module parameter

```agda
module Concurrency.Algebras.Sessions where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Nat                using (ℕ ; zero ; suc ; _+_)
open import Cubical.Data.Nat.Properties     using (+-assoc ; +-comm)
open import Cubical.Data.Sum                using (inl ; inr)

open import Concurrency.Operads.Ports
open import Concurrency.Operads.CyclicAssociative
  using ( O ; gen ; compₒ ; rot ; rot-zero ; rot-compose
        ; compₒ-assoc-seq ; compₒ-assoc-par
        ; rot-compₒ-a-block ; rot-compₒ-b-block ; trunc
        ; parallel-arity-eq )
...
module _ {ℓv ℓ' : Level} (Payload : Type ℓv) where
```

The file imports the completed operad, not the raw one, because `session-interp` must respect the full law constructors.

The whole development is parameterized by `Payload`. A session can send or receive values of this payload type. The file does not inspect payloads; it just carries them through the syntax.

## Chunk 3 — session syntax

```agda
data SessionType : Type ℓv where
  end  : SessionType
  send : Payload → SessionType → SessionType
  recv : Payload → SessionType → SessionType
  _⊗_  : SessionType → SessionType → SessionType
  _⅋_  : SessionType → SessionType → SessionType
  𝟙ₛ   : SessionType
  ⊥ₛ   : SessionType
```

This is a small multiplicative session language.

`end` is the terminal session behavior. `send P S` means send a payload of type `P`, then continue as `S`. `recv P S` is the dual receive form.

The connectives `⊗`, `⅋`, `𝟙ₛ`, and `⊥ₛ` mirror the multiplicative linear-logic structure in the target category. The subscript `ₛ` distinguishes session-level units from target-record fields.

There are no choices, exponentials, recursion, roles, or multiparty syntax. That is the intended v1 boundary.

## Chunk 4 — syntactic duality

```agda
_^⊥ₛ : SessionType → SessionType
end       ^⊥ₛ = end
send P S  ^⊥ₛ = recv P (S ^⊥ₛ)
recv P S  ^⊥ₛ = send P (S ^⊥ₛ)
(S ⊗ T)   ^⊥ₛ = (S ^⊥ₛ) ⅋ (T ^⊥ₛ)
(S ⅋ T)   ^⊥ₛ = (S ^⊥ₛ) ⊗ (T ^⊥ₛ)
𝟙ₛ        ^⊥ₛ = ⊥ₛ
⊥ₛ        ^⊥ₛ = 𝟙ₛ
```

Duality flips send and receive, flips tensor and par, and flips the units. `end` is self-dual.

This is the syntactic session-duality operation. It is the order-2 operation that must not be confused with cyclic rotation in the operad.

## Chunk 5 — duality is involutive

```agda
dual-involutive : (S : SessionType) → (S ^⊥ₛ) ^⊥ₛ ≡ S
dual-involutive end        = refl
dual-involutive (send P S) = cong (send P) (dual-involutive S)
dual-involutive (recv P S) = cong (recv P) (dual-involutive S)
dual-involutive (S ⊗ T)    = cong₂ _⊗_ (dual-involutive S) (dual-involutive T)
dual-involutive (S ⅋ T)    = cong₂ _⅋_ (dual-involutive S) (dual-involutive T)
dual-involutive 𝟙ₛ         = refl
dual-involutive ⊥ₛ         = refl
```

This proves the syntactic R8 face: applying session duality twice gives back the original session type.

The recursive cases use `cong` or `cong₂` to lift the induction hypothesis through constructors. For example, if `(S ^⊥ₛ) ^⊥ₛ ≡ S`, then `send P ((S ^⊥ₛ) ^⊥ₛ) ≡ send P S`.

This proof is real, not postulated.

## Chunk 6 — inductive `Hom`

```agda
data Hom : SessionType → SessionType → Type (ℓ-max ℓv ℓ') where
  id-h  : ∀ {S} → Hom S S
  _∘-h_ : ∀ {A B C} → Hom B C → Hom A B → Hom A C

  ⊗-h               : ∀ {A B C D} → Hom A C → Hom B D
                    → Hom (A ⊗ B) (C ⊗ D)
  α-h               : ∀ {A B C} → Hom ((A ⊗ B) ⊗ C) (A ⊗ (B ⊗ C))
  ...
  dual-h         : ∀ {A B} → Hom A B → Hom (B ^⊥ₛ) (A ^⊥ₛ)
  inv-dual-h     : ∀ {A} → Hom A ((A ^⊥ₛ) ^⊥ₛ)
  inv-dual-inv-h : ∀ {A} → Hom ((A ^⊥ₛ) ^⊥ₛ) A
```

`Hom` is an inductive family of structural morphisms between session types.

Its constructors mirror the fields expected by `StarAutonomous`: identity, composition, tensor on morphisms, associator, unitors, braid, duality functoriality, and double-dual isomorphism.

The operadic interaction primitives are *not* constructors here. That separation is deliberate. The category structure is one thing; the chosen `O_1` action on it is packaged later as `SessionO1Action`.

## Chunk 7 — postulated categorical laws

```agda
postulate
  Hom-is-set : ∀ {A B} → isSet (Hom A B)
  id-l       : ∀ {A B} (f : Hom A B) → id-h ∘-h f ≡ f
  id-r       : ∀ {A B} (f : Hom A B) → f ∘-h id-h ≡ f
  ∘-assoc    : ...

  ⊗-h-id-pres : ...
  ⊗-h-∘-pres  : ...
  α-iso-l     : ...
  ...
```

These postulates fill the laws required by `StarAutonomous`.

There are 17 of them. They are bounded: each corresponds to a field of the thin target-category signature. The file is not claiming to derive categorical coherence from the inductive `Hom` constructors.

`Hom-is-set` also matters later when interpreting the `trunc` constructor of `O`; it lets the HIT recursion discharge equality-between-equalities in the target hom-family.

This is one of the file's main honest limitations.

## Chunk 8 — `Sessions-Cat`

```agda
Sessions-Cat : StarAutonomous ℓv (ℓ-max ℓv ℓ')
Sessions-Cat .StarAutonomous.Ob                  = SessionType
Sessions-Cat .StarAutonomous.Hom                 = Hom
Sessions-Cat .StarAutonomous.Hom-set             = Hom-is-set
Sessions-Cat .StarAutonomous.id                  = id-h
Sessions-Cat .StarAutonomous._∘_                 = _∘-h_
...
Sessions-Cat .StarAutonomous._^⊥                 = _^⊥ₛ
Sessions-Cat .StarAutonomous.^⊥-hom              = dual-h
...
```

This packages the session syntax and `Hom` family as a `StarAutonomous` target.

The definition uses copattern matching: each projection of the record is filled directly. This makes projections reduce cleanly downstream. For example, `StarAutonomous.Ob Sessions-Cat` reduces to `SessionType`.

The target is now ready for `Valuation` and `OperadAlgebra`.

## Chunk 9 — `SessionO1Action`

```agda
record SessionO1Action : Type (ℓ-max ℓv ℓ') where
  field
    gen-morph :
        Hom (ports Sessions-Cat end 2) ⊥ₛ

    plug-morph :
        {l r : ℕ}
        (i : Port (suc l)) (j : Port (suc r))
      → Hom (ports Sessions-Cat end (suc l)) ⊥ₛ
      → Hom (ports Sessions-Cat end (suc r)) ⊥ₛ
      → Hom (ports Sessions-Cat end (suc (l + r))) ⊥ₛ

    shift-morph :
        {n : ℕ} (i : Port n)
      → Hom (ports Sessions-Cat end n) ⊥ₛ
      → Hom (ports Sessions-Cat end n) ⊥ₛ
```

This record packages the chosen action of `O_1` on the session hom-family.

`gen-morph` interprets the binary generator. `plug-morph` and `shift-morph` are the session-side versions of `plug` and `shift`.

The carrier is `end`, so `ports Sessions-Cat end n` is the iterated tensor of `end` over the ports of an `n`-ary operation.

Why not make these constructors of `Hom`? The header explains the choice: the categorical structure is universal, while the operadic action is additional chosen action data. Keeping them separate avoids transport noise and keeps `interp-compₒ` and `interp-rot` definitional later.

## Chunk 10 — the six operadic action laws

```agda
shift-zero-h : ...
shift-compose-h : ...
plug-assoc-seq-h : ...
plug-assoc-par-h : ...
rot-plug-a-block-h : ...
rot-plug-b-block-h : ...
```

The rest of `SessionO1Action` mirrors the non-trunc path constructors of `O`.

Each law says the session-side chosen operations respect the corresponding operad law:

- zero rotation;
- composition of rotations;
- sequential associativity;
- parallel associativity;
- a-block cyclic equivariance;
- b-block cyclic equivariance.

These laws are stated for arbitrary morphisms of the right arities, not only those that happen to come from `session-interp`. That makes `SessionO1Action` a genuine chosen action on the session hom-family, not just bare recursor data.

Then v1 postulates one such action:

```agda
postulate
  session-O1-action : SessionO1Action
```

This is the main deferred proof obligation of the file. Future richer session-categorical structure should derive it.

## Chunk 11 — interpreting `O`

```agda
session-interp : {n : ℕ} → O n → Hom (ports Sessions-Cat end n) ⊥ₛ
session-interp gen =
  gen-morph
session-interp (compₒ i j a b) =
  plug-morph i j (session-interp a) (session-interp b)
session-interp (rot i a) =
  shift-morph i (session-interp a)
```

The point constructors of `O` are interpreted by the corresponding fields of `SessionO1Action`.

The path constructors are then discharged by the six laws:

```agda
session-interp (rot-zero a ι) =
  shift-zero-h ... ι
session-interp (rot-compose i j a ι) =
  shift-compose-h ... ι
...
```

And the `trunc` constructor is discharged using `Hom-is-set`:

```agda
session-interp (trunc x y p q ι ι') =
  Hom-is-set _ _
    (cong session-interp p) (cong session-interp q)
    ι ι'
```

This is HIT recursion in action: to define a function out of `O`, the file must say what happens to every point constructor and every path constructor.

## Chunk 12 — valuation and algebra instances

```agda
Sessions-Val : Valuation Sessions-Cat
Sessions-Val .Valuation.Carrier         = end
Sessions-Val .Valuation.self-dual       = id-h
Sessions-Val .Valuation.self-dual-inv   = id-h
Sessions-Val .Valuation.self-dual-iso-l = id-l id-h
Sessions-Val .Valuation.self-dual-iso-r = id-l id-h
Sessions-Val .Valuation.⟦_⟧             = session-interp

Sessions-Alg : OperadAlgebra Sessions-Cat
Sessions-Alg .OperadAlgebra.valuation    = Sessions-Val
Sessions-Alg .OperadAlgebra.plug         = plug-morph
Sessions-Alg .OperadAlgebra.shift        = shift-morph
Sessions-Alg .OperadAlgebra.interp-compₒ = λ i j a b → refl
Sessions-Alg .OperadAlgebra.interp-rot   = λ i a → refl
```

`Sessions-Val` chooses `end` as the carrier and `session-interp` as the interpretation. Since `end` is definitionally self-dual, the self-duality maps are identities.

`Sessions-Alg` adds `plug-morph` and `shift-morph`. The structural axioms are `refl` because `session-interp` was defined so that interpreting `compₒ` and `rot` already reduces to those operations.

This is the payoff of the Path 3 architecture described in the header.

## Chunk 13 — boundary-swap at the generator

```agda
boundary-swap-at-gen =
  OperadAlgebra.boundary-swap-structural Sessions-Alg
    {l = 1} {r = 1} fzero fzero gen gen
```

This specializes the generic structural boundary-swap theorem to the binary generator, with the first port on each side.

It is the categorical / operadic R8 face for the Sessions instance. The syntactic R8 face was `dual-involutive`.

The file deliberately does not prove that these two faces are the same. It places both into Agda and leaves the bridge for richer session-categorical structure.

## Closing

`Sessions.agda` gives the first concrete typed-content instance of the algebra layer:

- session syntax and duality;
- a proof that duality is involutive;
- a structural `Hom` family;
- a thin star-autonomous target `Sessions-Cat`;
- a postulated chosen `O_1` action;
- the interpretation `session-interp`;
- `Sessions-Val` and `Sessions-Alg`;
- `boundary-swap-at-gen`.

The main honest gap is `session-O1-action`: v1 assumes the chosen action. Deriving it from cut/evaluation/coherent tensor rotation is future work.
