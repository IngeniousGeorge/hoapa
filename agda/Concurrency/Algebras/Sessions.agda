{-# OPTIONS --cubical --guardedness #-}

-- Multiplicative session-type content layer for cyclic-operad algebras.
--
-- This file is the typed-content / value-layer instance of the algebra
-- interface in `Concurrency/Algebras/{StarAutonomous,Valuation,OperadAlgebra}.agda`.
-- It supplies:
--
--   * Session-type syntax (multiplicative-only) and structural duality
--     (the syntactic R8 face: `dual-involutive`, proved).
--   * An inductive `Hom` over `SessionType` with 17 categorical
--     constructors of a symmetric *-autonomous-style category (13
--     multiplicative / structural + 4 additive-product: `terminal-h`,
--     `proj₁-h`, `proj₂-h`, `pair-h`). The operadic interaction
--     primitives are *not* constructors of `Hom` — see SessionO1Action
--     below.
--   * Postulated categorical laws (21): the 17 multiplicative /
--     structural laws bounded by the `StarAutonomous` record fields,
--     plus 4 additive-product universal-property laws bounded by
--     `HasFiniteProducts`.
--   * `Sessions-Cat : StarAutonomous ℓv (ℓ-max ℓv ℓ')` defined by
--     copattern matching so projections reduce.
--   * A bundled record `SessionO1Action` packaging the operadic
--     interaction data — `gen-morph`, `plug-morph`, `shift-morph` —
--     together with the 6 operadic laws that mirror `O`'s non-trunc
--     path constructors. One value of this record is postulated as
--     `session-O1-action` and opened.
--   * `session-interp : {n : ℕ} → O n → Hom (ports Sessions-Cat end n) ⊥ₛ`
--     defined by HIT recursion on `O`, discharging every constructor
--     via the corresponding field of `session-O1-action`.
--   * Three record inhabitants: `Sessions-Cat : StarAutonomous`,
--     `Sessions-Val : Valuation Sessions-Cat`, and
--     `Sessions-Alg : OperadAlgebra Sessions-Cat`. The Valuation /
--     OperadAlgebra structural axioms (`interp-compₒ`, `interp-rot`)
--     hold by `refl`.
--
-- Architectural choice (Path 3, decision 2026-05-19). The operadic
-- primitives `gen-morph`, `plug-morph`, `shift-morph` are *not*
-- inductive constructors of `Hom`. They live as fields of the bundled
-- `SessionO1Action` record, postulated after `Sessions-Cat` is in
-- scope so their types can refer to `ports Sessions-Cat end n` —
-- the same arity family `Valuation` and `OperadAlgebra` expect. The
-- two alternatives were:
--
--   * Path 1: keep them as Hom constructors with a local `portsₛ`
--     iteration, then bridge `portsₛ end n ≡ ports Sessions-Cat end n`
--     by `subst` everywhere. Heavy transport noise; `interp-compₒ`
--     and `interp-rot` would not be `refl`.
--   * Path 2: refactor `Valuation` to take an arity-family field
--     rather than computing iteration from `_⊗_` and `Carrier`.
--     Cleaner Sessions but modifies already-shipped files.
--
-- Path 3 reading: the categorical structure is universal (inductive
-- Hom); the operadic action on it is the chosen O_1 action for this
-- instance (bundled record). They are not the same kind of thing, and
-- giving them different syntactic categories is honest. The
-- `SessionO1Action` record's eventual home is a constructive
-- derivation from richer session-categorical structure (cut /
-- evaluation / closed structure / coherent tensor rotation) — to be
-- written when `StarAutonomous` is extended past its current thin
-- signature, before serious `MO_1` work.
--
-- Step status. Per workflow/status.md "Discussion of the next step":
--   (a) constructor-list draft — done.
--   (b) SessionType + duality + dual-involutive — done.
--   (c) inductive Hom + Sessions-Cat + SessionO1Action + session-interp
--       + Sessions-Val + Sessions-Alg — done.
--   (d) boundary-swap-at-gen (the categorical / operadic R8 face) — done.
--   (e) full header guardrail + stale-comment cleanups in sibling files
--       — done.
--   (f) additive-product enrichment: `_&ₛ_` / `⊤ₛ` syntax + universal
--       property + `Sessions-HasFiniteProducts`, dual objects `_⊕ₛ_` /
--       `𝟘ₛ` for involutive duality — this pass (B2(a) descent landing).
--
-- Scope guardrail. The constraints below are load-bearing for the
-- project's actor / session separation. Violating them in this file
-- would foreclose the "conversation of conversations" structure that
-- the architecture deliberately preserves as a slot for downstream
-- work; the file is shaped so the slot stays open.
--
--   * **One level only.** This file is the typed-content / value
--     layer for *one* level of conversations: a network of unityped
--     agents exchanging typed content via the uniform `O_1`
--     interaction primitive. Multi-level structure (conversations
--     reified as atomic agents at higher levels) is deliberately not
--     reachable here.
--
--   * **No actor identity in the carrier.** Role typing, multiparty
--     session types, located session types, and any other content
--     that mixes agent locus with message content are out of scope.
--     The carrier is `end` (a single session-type point); promotion
--     of a sub-conversation to actor status is a structural move at a
--     different layer, not a refinement of content.
--
--   * **Actor / locality content lives elsewhere.** Unityped agents
--     and conversations live in the actor-causal site (R6) and the
--     sheaf valuation (R1) — separate work, separate files. They are
--     not duplicated, summarized, or sketched here.
--
--   * **"Conversation of conversations" deferred.** The picture in
--     which a consensus-reached conversation becomes itself an atomic
--     interaction primitive at a higher level is captured by `MO_1`'s
--     self-gluing (operadic side) and the actor-causal site's
--     cellular coarsening (locality side). Both are deferred. This
--     file's narrowness is what preserves the slot for them.
--
--   * **Additive *products* now in scope; coproducts only as objects.**
--     As of 2026-06-04 (the B2(a) descent enrichment), the additive
--     conjunction `_&ₛ_` and its unit `⊤ₛ` are added as syntax with a
--     genuine categorical-product universal property (postulated laws),
--     bundled as `Sessions-HasFiniteProducts : HasFiniteProducts
--     Sessions-Cat`. This is exactly the structure the event-product
--     sheaf consumes to land descent at the Sessions value category. The
--     De Morgan duals `_⊕ₛ_` / `𝟘ₛ` are added as *objects only* (to keep
--     `_^⊥ₛ` total and involutive); their coproduct universal property is
--     *not* asserted (matching `FiniteProducts.agda` D6).
--
--   * **Still not a Caires–Pfenning proof-term calculus.** Cut, cut
--     elimination, proof terms, the additive *coproduct* universal
--     property, exponentials (!, ?), and recursive session types remain
--     out of scope. The file presents the syntactic *-autonomous-style
--     category over session types (now with additive products) with
--     structural fields postulated, plus a chosen `O_1` action bundled as
--     `SessionO1Action`. A richer Caires–Pfenning-style instance is
--     post-`MO_1` work.

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
open import Concurrency.Operads.PortGluing
  using ( delete-port ; port-glue
        ; a-port-after-inner-glue ; b-port-after-inner-glue )
open import Concurrency.Operads.PortRotation
  using ( port-before-survivor )
open import Concurrency.Algebras.StarAutonomous
open import Concurrency.Algebras.Valuation
  using ( Valuation ; ports )
open import Concurrency.Algebras.OperadAlgebra
  using ( OperadAlgebra )
-- New dependency (B2(a) descent enrichment, 2026-06-04): the additive
-- finite-product interface the event-product sheaf consumes. No cycle —
-- `FiniteProducts` depends only on `StarAutonomous`.
open import Concurrency.Algebras.FiniteProducts
  using ( HasFiniteProducts )

module _ {ℓv ℓ' : Level} (Payload : Type ℓv) where

  ------------------------------------------------------------------------
  -- Session-type syntax.
  ------------------------------------------------------------------------

  data SessionType : Type ℓv where
    end  : SessionType
    send : Payload → SessionType → SessionType
    recv : Payload → SessionType → SessionType
    _⊗_  : SessionType → SessionType → SessionType
    _⅋_  : SessionType → SessionType → SessionType
    𝟙ₛ   : SessionType
    ⊥ₛ   : SessionType
    -- Additives (B2(a) descent enrichment, 2026-06-04). `&ₛ`/`⊤ₛ` are
    -- the additive product / its unit, instantiated below as the
    -- `HasFiniteProducts` structure the event-product sheaf consumes.
    -- `⊕ₛ`/`𝟘ₛ` are their De Morgan duals — present as *objects* so that
    -- `_^⊥ₛ` stays total and involutive; the additive coproduct
    -- universal property is *not* asserted (matching `FiniteProducts.agda`
    -- D6: only `&` / `⊤ₚ` are primitive).
    _&ₛ_ : SessionType → SessionType → SessionType
    _⊕ₛ_ : SessionType → SessionType → SessionType
    ⊤ₛ   : SessionType
    𝟘ₛ   : SessionType

  ------------------------------------------------------------------------
  -- Duality.
  ------------------------------------------------------------------------

  _^⊥ₛ : SessionType → SessionType
  end       ^⊥ₛ = end
  send P S  ^⊥ₛ = recv P (S ^⊥ₛ)
  recv P S  ^⊥ₛ = send P (S ^⊥ₛ)
  (S ⊗ T)   ^⊥ₛ = (S ^⊥ₛ) ⅋ (T ^⊥ₛ)
  (S ⅋ T)   ^⊥ₛ = (S ^⊥ₛ) ⊗ (T ^⊥ₛ)
  𝟙ₛ        ^⊥ₛ = ⊥ₛ
  ⊥ₛ        ^⊥ₛ = 𝟙ₛ
  (S &ₛ T)  ^⊥ₛ = (S ^⊥ₛ) ⊕ₛ (T ^⊥ₛ)
  (S ⊕ₛ T)  ^⊥ₛ = (S ^⊥ₛ) &ₛ (T ^⊥ₛ)
  ⊤ₛ        ^⊥ₛ = 𝟘ₛ
  𝟘ₛ        ^⊥ₛ = ⊤ₛ

  ------------------------------------------------------------------------
  -- Duality is involutive (the syntactic face of R8).
  ------------------------------------------------------------------------

  dual-involutive : (S : SessionType) → (S ^⊥ₛ) ^⊥ₛ ≡ S
  dual-involutive end        = refl
  dual-involutive (send P S) = cong (send P) (dual-involutive S)
  dual-involutive (recv P S) = cong (recv P) (dual-involutive S)
  dual-involutive (S ⊗ T)    = cong₂ _⊗_ (dual-involutive S) (dual-involutive T)
  dual-involutive (S ⅋ T)    = cong₂ _⅋_ (dual-involutive S) (dual-involutive T)
  dual-involutive 𝟙ₛ         = refl
  dual-involutive ⊥ₛ         = refl
  dual-involutive (S &ₛ T)   = cong₂ _&ₛ_ (dual-involutive S) (dual-involutive T)
  dual-involutive (S ⊕ₛ T)   = cong₂ _⊕ₛ_ (dual-involutive S) (dual-involutive T)
  dual-involutive ⊤ₛ         = refl
  dual-involutive 𝟘ₛ         = refl

  ------------------------------------------------------------------------
  -- Inductive Hom: 17 categorical constructors.
  --
  -- The first 13 mirror the structural fields of `StarAutonomous`; the
  -- final 4 (added 2026-06-04) are the additive-product maps bundled
  -- below as `Sessions-HasFiniteProducts`. The operadic interaction
  -- primitives are not declared here — see `SessionO1Action` below.
  ------------------------------------------------------------------------

  data Hom : SessionType → SessionType → Type (ℓ-max ℓv ℓ') where

    -- Underlying category.
    id-h  : ∀ {S} → Hom S S
    _∘-h_ : ∀ {A B C} → Hom B C → Hom A B → Hom A C

    -- Symmetric monoidal structure.
    ⊗-h               : ∀ {A B C D} → Hom A C → Hom B D
                      → Hom (A ⊗ B) (C ⊗ D)
    α-h               : ∀ {A B C} → Hom ((A ⊗ B) ⊗ C) (A ⊗ (B ⊗ C))
    α-inv-h           : ∀ {A B C} → Hom (A ⊗ (B ⊗ C)) ((A ⊗ B) ⊗ C)
    leftUnitor-h      : ∀ {A} → Hom (𝟙ₛ ⊗ A) A
    leftUnitor-inv-h  : ∀ {A} → Hom A (𝟙ₛ ⊗ A)
    rightUnitor-h     : ∀ {A} → Hom (A ⊗ 𝟙ₛ) A
    rightUnitor-inv-h : ∀ {A} → Hom A (A ⊗ 𝟙ₛ)
    braid-h           : ∀ {A B} → Hom (A ⊗ B) (B ⊗ A)

    -- Involutive duality.
    dual-h         : ∀ {A B} → Hom A B → Hom (B ^⊥ₛ) (A ^⊥ₛ)
    inv-dual-h     : ∀ {A} → Hom A ((A ^⊥ₛ) ^⊥ₛ)
    inv-dual-inv-h : ∀ {A} → Hom ((A ^⊥ₛ) ^⊥ₛ) A

    -- Additive product (terminal + binary &). These are genuine terms
    -- of the syntactic category, so they are `Hom` constructors here
    -- (not floating postulates); their universal-property laws are
    -- postulated alongside the other categorical laws below, and the
    -- bundle is exposed as `Sessions-HasFiniteProducts`. The dual
    -- additive coproduct maps are deliberately absent (see SessionType).
    terminal-h : ∀ {A} → Hom A ⊤ₛ
    proj₁-h    : ∀ {A B} → Hom (A &ₛ B) A
    proj₂-h    : ∀ {A B} → Hom (A &ₛ B) B
    pair-h     : ∀ {A B C} → Hom C A → Hom C B → Hom C (A &ₛ B)

  infixr 9 _∘-h_

  ------------------------------------------------------------------------
  -- Postulated categorical laws (21).
  --
  -- The first 17 each map to a `StarAutonomous`-record field; the final
  -- 4 (added 2026-06-04) are the additive-product universal-property
  -- laws mapping to `HasFiniteProducts` fields. Pentagon, hexagon, and
  -- triangle coherence are not unpacked here (matching
  -- `StarAutonomous.agda`'s thin signature). `Hom-is-set` doubles as
  -- the set-truncation discharge for `O`'s `trunc` constructor in
  -- `session-interp` below.
  ------------------------------------------------------------------------

  postulate
    -- Category laws.
    Hom-is-set : ∀ {A B} → isSet (Hom A B)
    id-l       : ∀ {A B} (f : Hom A B) → id-h ∘-h f ≡ f
    id-r       : ∀ {A B} (f : Hom A B) → f ∘-h id-h ≡ f
    ∘-assoc    : ∀ {A B C D} (f : Hom C D) (g : Hom B C) (h : Hom A B)
               → (f ∘-h g) ∘-h h ≡ f ∘-h (g ∘-h h)

    -- ⊗ bifunctoriality.
    ⊗-h-id-pres : ∀ {A B} → ⊗-h (id-h {A}) (id-h {B}) ≡ id-h
    ⊗-h-∘-pres  : ∀ {A B C D E F}
                  (f : Hom C E) (g : Hom A C)
                  (h : Hom D F) (k : Hom B D)
                → ⊗-h (f ∘-h g) (h ∘-h k) ≡ ⊗-h f h ∘-h ⊗-h g k

    -- Associator / unitor iso laws.
    α-iso-l           : ∀ {A B C} → α-inv-h {A} {B} {C} ∘-h α-h ≡ id-h
    α-iso-r           : ∀ {A B C} → α-h {A} {B} {C} ∘-h α-inv-h ≡ id-h
    leftUnitor-iso-l  : ∀ {A} → leftUnitor-inv-h {A} ∘-h leftUnitor-h ≡ id-h
    leftUnitor-iso-r  : ∀ {A} → leftUnitor-h {A} ∘-h leftUnitor-inv-h ≡ id-h
    rightUnitor-iso-l : ∀ {A} → rightUnitor-inv-h {A} ∘-h rightUnitor-h ≡ id-h
    rightUnitor-iso-r : ∀ {A} → rightUnitor-h {A} ∘-h rightUnitor-inv-h ≡ id-h

    -- Braid.
    braid-involutive : ∀ {A B} → braid-h {B} {A} ∘-h braid-h {A} {B} ≡ id-h

    -- Duality functoriality.
    dual-h-id-pres : ∀ {A} → dual-h (id-h {A}) ≡ id-h
    dual-h-∘-pres  : ∀ {A B C} (f : Hom B C) (g : Hom A B)
                   → dual-h (f ∘-h g) ≡ dual-h g ∘-h dual-h f

    -- Involutive-duality iso laws.
    inv-dual-iso-l : ∀ {A} → inv-dual-inv-h {A} ∘-h inv-dual-h ≡ id-h
    inv-dual-iso-r : ∀ {A} → inv-dual-h {A} ∘-h inv-dual-inv-h ≡ id-h

    -- Additive-product universal property (maps to `HasFiniteProducts`'s
    -- fields). `⊤ₛ` is terminal; `_&ₛ_` is a genuine categorical product
    -- (β on each projection, η/uniqueness of the pairing). These are the
    -- exact laws the event-product descent proof reads off (`bigβ` to
    -- recover a component, `bigη`/`bigProduct-ext` for separatedness).
    terminal-unique-h : ∀ {A} (f : Hom A ⊤ₛ) → f ≡ terminal-h
    &ₛ-β₁ : ∀ {A B C} (f : Hom C A) (g : Hom C B)
          → proj₁-h ∘-h pair-h f g ≡ f
    &ₛ-β₂ : ∀ {A B C} (f : Hom C A) (g : Hom C B)
          → proj₂-h ∘-h pair-h f g ≡ g
    &ₛ-η  : ∀ {A B C} (h : Hom C (A &ₛ B))
          → pair-h (proj₁-h ∘-h h) (proj₂-h ∘-h h) ≡ h

  ------------------------------------------------------------------------
  -- Sessions-Cat.
  --
  -- The syntactic *-autonomous-style target category. Defined by
  -- copattern matching rather than `record { ... }` so projections
  -- like `Sessions-Cat._⊗_` reduce in downstream type-checking.
  ------------------------------------------------------------------------

  Sessions-Cat : StarAutonomous ℓv (ℓ-max ℓv ℓ')
  Sessions-Cat .StarAutonomous.Ob                  = SessionType
  Sessions-Cat .StarAutonomous.Hom                 = Hom
  Sessions-Cat .StarAutonomous.Hom-set             = Hom-is-set
  Sessions-Cat .StarAutonomous.id                  = id-h
  Sessions-Cat .StarAutonomous._∘_                 = _∘-h_
  Sessions-Cat .StarAutonomous.id-l                = id-l
  Sessions-Cat .StarAutonomous.id-r                = id-r
  Sessions-Cat .StarAutonomous.∘-assoc             = ∘-assoc
  Sessions-Cat .StarAutonomous._⊗_                 = _⊗_
  Sessions-Cat .StarAutonomous.𝟙                   = 𝟙ₛ
  Sessions-Cat .StarAutonomous.⊗-hom               = ⊗-h
  Sessions-Cat .StarAutonomous.⊗-id-pres           = ⊗-h-id-pres
  Sessions-Cat .StarAutonomous.⊗-∘-pres            = ⊗-h-∘-pres
  Sessions-Cat .StarAutonomous.α                   = α-h
  Sessions-Cat .StarAutonomous.α-inv               = α-inv-h
  Sessions-Cat .StarAutonomous.α-iso-l             = α-iso-l
  Sessions-Cat .StarAutonomous.α-iso-r             = α-iso-r
  Sessions-Cat .StarAutonomous.leftUnitor          = leftUnitor-h
  Sessions-Cat .StarAutonomous.leftUnitor-inv      = leftUnitor-inv-h
  Sessions-Cat .StarAutonomous.leftUnitor-iso-l    = leftUnitor-iso-l
  Sessions-Cat .StarAutonomous.leftUnitor-iso-r    = leftUnitor-iso-r
  Sessions-Cat .StarAutonomous.rightUnitor         = rightUnitor-h
  Sessions-Cat .StarAutonomous.rightUnitor-inv     = rightUnitor-inv-h
  Sessions-Cat .StarAutonomous.rightUnitor-iso-l   = rightUnitor-iso-l
  Sessions-Cat .StarAutonomous.rightUnitor-iso-r   = rightUnitor-iso-r
  Sessions-Cat .StarAutonomous.braid               = braid-h
  Sessions-Cat .StarAutonomous.braid-involutive    = braid-involutive
  Sessions-Cat .StarAutonomous._^⊥                 = _^⊥ₛ
  Sessions-Cat .StarAutonomous.^⊥-hom              = dual-h
  Sessions-Cat .StarAutonomous.^⊥-id-pres          = dual-h-id-pres
  Sessions-Cat .StarAutonomous.^⊥-∘-pres           = dual-h-∘-pres
  Sessions-Cat .StarAutonomous.^⊥-involutive       = inv-dual-h
  Sessions-Cat .StarAutonomous.^⊥-involutive-inv   = inv-dual-inv-h
  Sessions-Cat .StarAutonomous.^⊥-involutive-iso-l = inv-dual-iso-l
  Sessions-Cat .StarAutonomous.^⊥-involutive-iso-r = inv-dual-iso-r

  ------------------------------------------------------------------------
  -- Sessions-HasFiniteProducts: the additive finite-product enrichment.
  --
  -- Bundles `⊤ₛ` and `_&ₛ_` (with their postulated universal-property
  -- laws above) into the `HasFiniteProducts` extension record over
  -- `Sessions-Cat`. This is the structure that `event-product-presheaf` /
  -- `event-product-sheaf` consume to land the B2(a) descent witness at
  -- the Sessions value category (see
  -- `Concurrency/Hybrid/SessionEventProductSheaf.agda`).
  --
  -- `HasFiniteProducts` touches only the underlying category of the
  -- target (`Ob`, `Hom`, `_∘_`, the unit/associativity laws) — it is
  -- orthogonal to the multiplicative `⊗` / `^⊥` structure, so no duality
  -- coherence is invoked here. The additive coproduct `⊕ₛ` / `𝟘ₛ`
  -- objects exist (for duality totality) but carry no universal property,
  -- exactly as `FiniteProducts.agda` documents.
  ------------------------------------------------------------------------

  Sessions-HasFiniteProducts : HasFiniteProducts Sessions-Cat
  Sessions-HasFiniteProducts .HasFiniteProducts.⊤ₚ              = ⊤ₛ
  Sessions-HasFiniteProducts .HasFiniteProducts.terminal        = terminal-h
  Sessions-HasFiniteProducts .HasFiniteProducts.terminal-unique = terminal-unique-h
  Sessions-HasFiniteProducts .HasFiniteProducts._&_             = _&ₛ_
  Sessions-HasFiniteProducts .HasFiniteProducts.π₁              = proj₁-h
  Sessions-HasFiniteProducts .HasFiniteProducts.π₂              = proj₂-h
  Sessions-HasFiniteProducts .HasFiniteProducts.⟨_,_⟩           = pair-h
  Sessions-HasFiniteProducts .HasFiniteProducts.&-β₁            = &ₛ-β₁
  Sessions-HasFiniteProducts .HasFiniteProducts.&-β₂            = &ₛ-β₂
  Sessions-HasFiniteProducts .HasFiniteProducts.&-η             = &ₛ-η

  ------------------------------------------------------------------------
  -- SessionO1Action: a chosen O_1 action on the session Hom family.
  --
  -- The three operadic primitives (`gen-morph`, `plug-morph`,
  -- `shift-morph`) and the six operadic laws (mirroring `O`'s
  -- non-trunc path constructors) live here, after `Sessions-Cat` is
  -- in scope so their types can refer to `ports Sessions-Cat end n` —
  -- the same arity family the `Valuation` and `OperadAlgebra` record
  -- fields expect.
  --
  -- Strength of the record. The six operadic laws are stated over
  -- *arbitrary* morphisms in `Hom (ports Sessions-Cat end n) ⊥ₛ`, not
  -- only those in the image of `session-interp`. This is intentional:
  -- `SessionO1Action` packages a genuine chosen O_1 action on the
  -- session Hom family at the chosen arity layer, not bare recursor
  -- data. A weaker "image-only" version would suffice to discharge
  -- `session-interp`'s HIT recursion, but it would not give the rest
  -- of the operadic structure (`plug-morph` / `shift-morph` as
  -- categorical operations on the algebra layer) the latitude
  -- downstream uses will want.
  --
  -- Convention on `⊥ₛ`. `⊥ₛ` is used directly in place of
  -- `StarAutonomous.⊥-par Sessions-Cat`; the two are definitionally
  -- equal via the copattern definition above (`Sessions-Cat.𝟙 = 𝟙ₛ`,
  -- `Sessions-Cat._^⊥ = _^⊥ₛ`, and `𝟙ₛ ^⊥ₛ ≡ ⊥ₛ` by `_^⊥ₛ`'s pattern
  -- matching).
  --
  -- Eventual home (deferred work). A constructive derivation of an
  -- inhabitant of this record from richer categorical / session
  -- structure — evaluation / closed structure / cut / coherent tensor
  -- rotation — to be written when `StarAutonomous` is extended past
  -- its current thin signature, before serious `MO_1` work.
  ------------------------------------------------------------------------

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

      -- Mirrors `rot-zero`.
      --
      -- The explicit `{n = n}` on `shift-morph` is an inference hint
      -- (per memory `feedback_flag_workarounds`): `fzero : Fin (suc _)`
      -- doesn't pin shift-morph's arity, and the alternative — the
      -- constraint `ports Sessions-Cat end _ = ports Sessions-Cat end n`
      -- from `m`'s type — is blocked because `ports` is not injective
      -- in its third argument for variable `n`. A cleaner alternative
      -- would be making `shift-morph`'s arity explicit, but that ripples
      -- through every operadic-law use site.
      shift-zero-h :
          {n : ℕ} (m : Hom (ports Sessions-Cat end n) ⊥ₛ)
        → shift-morph {n = n} fzero m ≡ m

      -- Mirrors `rot-compose`.
      shift-compose-h :
          {n : ℕ} (i j : Port n) (m : Hom (ports Sessions-Cat end n) ⊥ₛ)
        → shift-morph i (shift-morph j m) ≡ shift-morph (i +ₘ j) m

      -- Mirrors `compₒ-assoc-seq`.
      plug-assoc-seq-h :
          {l r p : ℕ}
          (i : Port (suc l)) (j : Port (suc r)) (k' : Port (suc p))
          (y : Fin (suc r))
          (fa : Hom (ports Sessions-Cat end (suc l)) ⊥ₛ)
          (fb : Hom (ports Sessions-Cat end (suc r)) ⊥ₛ)
          (fc : Hom (ports Sessions-Cat end (suc p)) ⊥ₛ)
        → PathP (λ ι → Hom (ports Sessions-Cat end (suc (sym (+-assoc l r p) ι))) ⊥ₛ)
            (plug-morph (port-glue {l} {r} (inr y)) k'
                        (plug-morph i j fa fb) fc)
            (plug-morph i (port-glue {r} {p} (inl (b-port-after-inner-glue {r} y)))
                        fa (plug-morph (delete-port j y) k' fb fc))

      -- Mirrors `compₒ-assoc-par`.
      plug-assoc-par-h :
          {l r p : ℕ}
          (i : Port (suc l)) (j : Port (suc r)) (k' : Port (suc p))
          (x : Fin (suc l))
          (fa : Hom (ports Sessions-Cat end (suc l)) ⊥ₛ)
          (fb : Hom (ports Sessions-Cat end (suc r)) ⊥ₛ)
          (fc : Hom (ports Sessions-Cat end (suc p)) ⊥ₛ)
        → PathP (λ ι → Hom (ports Sessions-Cat end (suc (parallel-arity-eq l r p ι))) ⊥ₛ)
            (plug-morph (port-glue {l} {r} (inl x)) k'
                        (plug-morph i j fa fb) fc)
            (plug-morph (port-glue {l} {p} (inl (a-port-after-inner-glue {l} x))) j
                        (plug-morph (delete-port i x) k' fa fc) fb)

      -- Mirrors `rot-compₒ-a-block`.
      rot-plug-a-block-h :
          {l r : ℕ}
          (i : Port (suc l)) (j : Port (suc r))
          (x : Fin (suc l))
          (fa : Hom (ports Sessions-Cat end (suc l)) ⊥ₛ)
          (fb : Hom (ports Sessions-Cat end (suc r)) ⊥ₛ)
        → shift-morph (port-glue {l} {r} (inl x)) (plug-morph i j fa fb)
            ≡ plug-morph (port-before-survivor i x) j fa fb

      -- Mirrors `rot-compₒ-b-block`.
      rot-plug-b-block-h :
          {l r : ℕ}
          (i : Port (suc l)) (j : Port (suc r))
          (y : Fin (suc r))
          (fa : Hom (ports Sessions-Cat end (suc l)) ⊥ₛ)
          (fb : Hom (ports Sessions-Cat end (suc r)) ⊥ₛ)
        → PathP (λ ι → Hom (ports Sessions-Cat end (suc (+-comm l r ι))) ⊥ₛ)
            (shift-morph (port-glue {l} {r} (inr y)) (plug-morph i j fa fb))
            (plug-morph (port-before-survivor j y) i fb fa)

  -- One bundled action is postulated for v1. Future work derives this
  -- from richer categorical / session structure (see header).
  postulate
    session-O1-action : SessionO1Action

  -- Open the action so its fields are accessible without qualification.
  open SessionO1Action session-O1-action public

  ------------------------------------------------------------------------
  -- session-interp.
  --
  -- HIT recursion on `O`. Point constructors map to operadic
  -- primitives; each non-trunc path constructor is discharged by
  -- exactly one operadic law (a field of `session-O1-action`);
  -- `trunc` is discharged by `Hom-is-set`.
  ------------------------------------------------------------------------

  session-interp : {n : ℕ} → O n → Hom (ports Sessions-Cat end n) ⊥ₛ
  session-interp gen =
    gen-morph
  session-interp (compₒ i j a b) =
    plug-morph i j (session-interp a) (session-interp b)
  session-interp (rot i a) =
    shift-morph i (session-interp a)
  session-interp {n} (rot-zero a ι) =
    shift-zero-h {n = n} (session-interp a) ι
  session-interp (rot-compose i j a ι) =
    shift-compose-h i j (session-interp a) ι
  session-interp (compₒ-assoc-seq i j k' y a b c ι) =
    plug-assoc-seq-h i j k' y
      (session-interp a) (session-interp b) (session-interp c) ι
  session-interp (compₒ-assoc-par i j k' x a b c ι) =
    plug-assoc-par-h i j k' x
      (session-interp a) (session-interp b) (session-interp c) ι
  session-interp (rot-compₒ-a-block i j x a b ι) =
    rot-plug-a-block-h i j x (session-interp a) (session-interp b) ι
  session-interp (rot-compₒ-b-block i j y a b ι) =
    rot-plug-b-block-h i j y (session-interp a) (session-interp b) ι
  session-interp (trunc x y p q ι ι') =
    Hom-is-set _ _
      (cong session-interp p) (cong session-interp q)
      ι ι'

  ------------------------------------------------------------------------
  -- Sessions-Val and Sessions-Alg.
  --
  -- With session-interp's type matching `Valuation.⟦_⟧`'s expected
  -- slot (both use `ports Sessions-Cat end n` and `⊥ₛ`, which
  -- definitionally equals `Sessions-Cat.⊥-par`), the record fillings
  -- are direct. `interp-compₒ` and `interp-rot` hold by `refl` —
  -- session-interp's clauses are exactly the structural axioms.
  ------------------------------------------------------------------------

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

  ------------------------------------------------------------------------
  -- boundary-swap-at-gen: the categorical / operadic R8 face for Sessions.
  --
  -- Specialization of `Sessions-Alg`'s derived `boundary-swap-structural`
  -- at the binary generator (`a = b = gen`) with minimal port choices
  -- (`l = r = 1`, `i = j = fzero`). The result is a concrete `PathP`
  -- between specific terms in `Hom` involving `plug-morph`,
  -- `shift-morph`, `gen-morph`, and `boundary-rot 1 1`.
  --
  -- This is the *categorical / operadic* face of R8 for the Sessions
  -- instance — the categorical identity that the cyclic operad's
  -- boundary-swap theorem induces on the chosen O_1 action. The
  -- *syntactic* face is `dual-involutive` (proved above): the
  -- structural involutivity of session duality `_^⊥ₛ`. The two faces
  -- are not formally connected here — the bridge between them is the
  -- project's R8 claim, deliberately deferred (see file header for the
  -- architectural reason). They both sit in this file as Agda objects;
  -- their identification will become provable when richer categorical /
  -- session structure makes the bridge expressible.
  ------------------------------------------------------------------------

  boundary-swap-at-gen =
    OperadAlgebra.boundary-swap-structural Sessions-Alg
      {l = 1} {r = 1} fzero fzero gen gen
