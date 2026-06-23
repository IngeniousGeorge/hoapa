{-# OPTIONS --cubical --guardedness #-}

-- The actor-causal site: locality leg of the Concurrency hybrid.
--
-- This file is the locality counterpart to `Concurrency.Algebras.Sessions`:
-- Sessions ships the typed-content layer over the cyclic-operad algebra
-- interface; this file ships the actor-causal Grothendieck site over the
-- `ActorBase` + `CausalOrder` primitives from `ActorBase.agda`. The two
-- legs (Actors here, Sessions there) are deliberately built to *comparable
-- maturity* before being bridged: a downstream `Concurrency/Sites/Sheaf.agda`
-- (or similar) will place session values over actor-local frames as the
-- sheaf-of-session-values picture from `deep_context/arc/02_concurrency_anchor.md`.
--
-- What this file ships, in order:
--
--   * `LocalFrame` — a frame is an actor membership predicate +
--     untyped events + an incidence relation + a causal order. The
--     base ActorBase is shared across all frames in the site.
--   * `FrameHom` — a morphism between frames preserving actor
--     membership, mapping events, preserving incidence, and *strictly
--     reflecting* causal order (sub-view discipline; see (D1) below).
--   * `FrameCategory` — identity, composition, identity laws,
--     associativity.
--   * `Cover` — a *basis* presentation of a cover family (E1): a
--     chosen indexed family of patches with chosen FrameHoms into the
--     covered frame, plus chosen coverage witnesses for actors and
--     events. Written so it can be promoted to a sieve presentation
--     (E2) without restructuring; see `sieve-of` below and the
--     future-work note in the header.
--   * `ActorCausalSite` — the final exported bundle: ActorBase + the
--     site axioms (identity cover, transitivity, stability). All
--     three axioms are *named fields* per (F1), with witnesses left
--     as postulates flagged in headers where proofs would be heavy.
--   * A small concrete instance `tiny-site` (G3): two actors, two
--     events, a non-trivial frame and FrameHom, identity cover plus
--     one non-trivial cover. This is the inhabitability witness;
--     analog of `compₒ fzero fzero gen gen : O 3` for the operad and
--     `boundary-swap-at-gen` for Sessions.
--
-- Scope guardrail (load-bearing for the actor / session separation).
--
--   * **No imports of `Sessions.agda` or any operad file.** Actors
--     are the locality leg; typed content and the interaction algebra
--     belong to separate files. The bridge that places session values
--     over frames is its own future file. If you find yourself
--     reaching for `Hom`, `_⊗_`, `gen`, `plug`, or `shift`, you are
--     in the wrong file.
--   * **No payloads, no roles, no message syntax in any record.**
--     Events are opaque occurrences with prop-valued incidence to
--     actors; that is the entire content layer at this site.
--   * **Strict causality reflection (D1) in FrameHom.** A FrameHom
--     is a sub-view: causality holds in F iff it holds between the
--     images in G. This forces *promotion* (a sub-conversation
--     collapsing into a single event in a larger frame; see arc/05
--     and the verified-protocol-kernel framing) to be a *different*
--     morphism class, not a FrameHom. Promotion is correctly a
--     quotient, not an embedding; reserving strict reflection here
--     protects that distinction. The promotion class is held in
--     prose only at v1 (H3), to be developed when the modular
--     envelope MO_1 enters scope.
--   * **Basis form covers (E1), prepared for sieve form (E2).**
--     `Cover` carries an explicit `Index` type with chosen `patch`
--     and `embed`; this is the basis presentation, concrete and easy
--     to instantiate. The derived `sieve-of` operation below
--     generates a sieve from a basis cover. Future work will
--     introduce a sieve-presentation record alongside `Cover` and
--     prove that the two presentations agree on the resulting
--     topology (see `future_work.md`).
--
-- Naming discipline:
--   * `LocalFrame` rather than `Frame` — "local" emphasizes that a
--     frame is a partial view, never global.
--   * `FrameHom` for the morphism type. `_↪_` as an infix alias is
--     introduced after the record so it doesn't appear in field
--     types; this matches the `gen-morph` / `gen` style in Sessions
--     (long name primary, short alias derived).
--   * `event-map` rather than `f` for the underlying event-level
--     function inside a FrameHom; the longer name reads better at
--     the use sites in coverage and stability lemmas.

module Concurrency.Sites.ActorCausal where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.HLevels using (isPropΠ ; isProp×)
open import Cubical.Data.Sigma  using (Σ-syntax ; _×_ ; _,_ ; fst ; snd)
open import Cubical.Data.Nat    using (ℕ ; zero ; suc)
open import Cubical.Data.Empty  using (⊥ ; rec)
open import Cubical.Data.Unit   using (Unit ; tt ; isSetUnit)
open import Cubical.Relation.Nullary using (¬_)

open import Concurrency.Sites.ActorBase
open import Concurrency.Sites.TinyActorBase using (TinyAB) public

------------------------------------------------------------------------
-- Module parameterization.
--
-- All frames, FrameHoms, covers, and the final site record live over a
-- fixed ActorBase. The convention parallels Valuation.agda /
-- OperadAlgebra.agda, which take a `StarAutonomous` as a module
-- parameter and expose its fields via `open` for the records inside.
--
-- Universe levels: `ℓA` is the actor level (from ActorBase). `ℓE` and
-- `ℓR` are the event and causal-relation levels respectively. All
-- frames in the site use the same levels; an "ActorCausalSite" at
-- (ℓA, ℓE, ℓR) is the universe of frames with actors in `Actor`,
-- events at level ℓE, and ≤ at level ℓR. The cover indexing level
-- `ℓI` is local to the Cover record.
------------------------------------------------------------------------

module _ {ℓA : Level} (AB : ActorBase ℓA) where
  open ActorBase AB

  ----------------------------------------------------------------
  -- LocalFrame.
  --
  -- A frame bundles a causal order on events with an actor-membership
  -- predicate and an incidence relation. `ActorIn` is prop-valued
  -- (`ActorIn-isProp`): an actor is either in this frame or not, not
  -- "in multiple ways." `touches` is prop-valued (`touches-isProp`)
  -- for the same reason; an event either involves an actor or doesn't.
  --
  -- The constraint `touches-in-frame` says incidence only happens
  -- among actors that are in the frame. Without it, an event could
  -- "touch" an actor outside its own frame, which makes no
  -- locality-leg sense.
  --
  -- What is *not* here: ordering between actors (actors are unityped,
  -- no actor-actor relation); typed content of events (events are
  -- opaque); messages, sessions, channels (content layer).
  ----------------------------------------------------------------

  record LocalFrame (ℓE ℓR : Level) : Type (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE ℓR))) where
    field
      causal           : CausalOrder ℓE ℓR
    open CausalOrder causal public
    field
      ActorIn          : Actor → Type ℓA
      ActorIn-isProp   : (a : Actor) → isProp (ActorIn a)
      touches          : Event → Actor → Type ℓR
      touches-isProp   : (e : Event) (a : Actor) → isProp (touches e a)
      touches-in-frame : {e : Event} {a : Actor} → touches e a → ActorIn a

  ----------------------------------------------------------------
  -- FrameHom.
  --
  -- A morphism F → G is a causal sub-view embedding. Five fields:
  --
  --   1. `actor-pres` — every actor in F is an actor in G.
  --   2. `event-map`  — every event in F has an image in G.
  --   3. `touches-pres` — incidence is preserved by the event map.
  --   4. `causal-pres` — order is preserved: e ≤_F e' ⇒
  --      event-map e ≤_G event-map e'.
  --   5. `causal-refl` — order is *reflected*: event-map e ≤_G
  --      event-map e' ⇒ e ≤_F e'.
  --
  -- (4)+(5) together are strict causality reflection (D1). The cost:
  -- a future "promotion" morphism (a sub-conversation collapsing into
  -- a single event in a bigger frame) cannot be a FrameHom — it would
  -- introduce new causality not present in the source. That's correct
  -- discipline; promotion is its own morphism class, deferred (H3).
  --
  -- Derived injectivity: event-map is injective. This is *not* a
  -- separate field; it follows from causal-refl + ≤-refl +
  -- ≤-antisym. Stated as `event-map-injective` below.
  ----------------------------------------------------------------

  record FrameHom {ℓE₁ ℓR₁ ℓE₂ ℓR₂ : Level}
                  (F : LocalFrame ℓE₁ ℓR₁)
                  (G : LocalFrame ℓE₂ ℓR₂)
                : Type (ℓ-max ℓA (ℓ-max ℓE₁ (ℓ-max ℓR₁ (ℓ-max ℓE₂ ℓR₂)))) where
    private
      module F = LocalFrame F
      module G = LocalFrame G
    field
      actor-pres   : {a : Actor} → F.ActorIn a → G.ActorIn a
      event-map    : F.Event → G.Event
      touches-pres : {e : F.Event} {a : Actor}
                   → F.touches e a → G.touches (event-map e) a
      causal-pres  : {e e' : F.Event} → e F.≤ e' → event-map e G.≤ event-map e'
      causal-refl  : {e e' : F.Event} → event-map e G.≤ event-map e' → e F.≤ e'

  -- Infix alias. Underscored as `_↪_` to read at use sites as
  -- "F embeds as a sub-view of G."
  _↪_ : {ℓE₁ ℓR₁ ℓE₂ ℓR₂ : Level}
      → LocalFrame ℓE₁ ℓR₁ → LocalFrame ℓE₂ ℓR₂
      → Type (ℓ-max ℓA (ℓ-max ℓE₁ (ℓ-max ℓR₁ (ℓ-max ℓE₂ ℓR₂))))
  F ↪ G = FrameHom F G

  infix 5 _↪_

  ----------------------------------------------------------------
  -- Derived: event-map is injective.
  --
  -- If event-map e ≡ event-map e', then (event-map e ≤ event-map e')
  -- and (event-map e' ≤ event-map e) both hold by reflexivity along
  -- the path. Reflection gives e ≤_F e' and e' ≤_F e; antisymmetry in
  -- F gives e ≡ e'.
  --
  -- This is the lemma that makes "FrameHom is a sub-view embedding"
  -- precise: the event map cannot collapse distinct events. Used in
  -- the coverage and stability arguments downstream; named here once
  -- to avoid re-deriving at each use site.
  ----------------------------------------------------------------

  module _ {ℓE₁ ℓR₁ ℓE₂ ℓR₂ : Level}
           {F : LocalFrame ℓE₁ ℓR₁} {G : LocalFrame ℓE₂ ℓR₂}
           (φ : FrameHom F G) where
    open FrameHom φ
    private
      module F = LocalFrame F
      module G = LocalFrame G

    event-map-injective :
        {e e' : F.Event}
      → event-map e ≡ event-map e'
      → e ≡ e'
    event-map-injective {e} {e'} p =
        F.≤-antisym
          (causal-refl (subst (λ x → event-map e G.≤ x) p (G.≤-refl (event-map e))))
          (causal-refl (subst (λ x → x G.≤ event-map e) p (G.≤-refl (event-map e))))

  ----------------------------------------------------------------
  -- FrameCategory: identity and composition.
  --
  -- Both follow from the field-by-field constructions. Identity is
  -- the identity on actors, identity on events, and the trivial
  -- prop-valued lifts. Composition pastes the actor maps, composes
  -- the event maps, and chains the preservation / reflection
  -- arguments.
  --
  -- Identity laws and associativity hold definitionally at the
  -- field-projection level because all operations are direct
  -- compositions. Stated below as `refl`-discharged equalities;
  -- equality at the FrameHom record level uses Cubical's record
  -- η-rule (records are products), so component-wise equality
  -- suffices.
  ----------------------------------------------------------------

  frame-id : {ℓE ℓR : Level} (F : LocalFrame ℓE ℓR) → F ↪ F
  frame-id F = record
    { actor-pres   = λ x → x
    ; event-map    = λ e → e
    ; touches-pres = λ t → t
    ; causal-pres  = λ p → p
    ; causal-refl  = λ p → p
    }

  _∘ᶠ_ : {ℓE₁ ℓR₁ ℓE₂ ℓR₂ ℓE₃ ℓR₃ : Level}
         {F : LocalFrame ℓE₁ ℓR₁}
         {G : LocalFrame ℓE₂ ℓR₂}
         {H : LocalFrame ℓE₃ ℓR₃}
       → G ↪ H → F ↪ G → F ↪ H
  _∘ᶠ_ {F = F} {G = G} {H = H} ψ φ = record
    { actor-pres   = λ x → ψ.actor-pres (φ.actor-pres x)
    ; event-map    = λ e → ψ.event-map (φ.event-map e)
    ; touches-pres = λ t → ψ.touches-pres (φ.touches-pres t)
    ; causal-pres  = λ p → ψ.causal-pres (φ.causal-pres p)
    ; causal-refl  = λ p → φ.causal-refl (ψ.causal-refl p)
    }
    where
      module φ = FrameHom φ
      module ψ = FrameHom ψ

  infixr 9 _∘ᶠ_

  ----------------------------------------------------------------
  -- Identity / associativity laws.
  --
  -- These are `refl` because the field-level composition is
  -- definitional under cubical's record η. They are stated
  -- explicitly here so a downstream `FrameCategory` packaging (when
  -- it lands — likely as a parallel to `StarAutonomous`'s underlying
  -- 1-category fields) has named lemmas to reference rather than
  -- inlining `refl`.
  ----------------------------------------------------------------

  frame-id-l : {ℓE₁ ℓR₁ ℓE₂ ℓR₂ : Level}
               {F : LocalFrame ℓE₁ ℓR₁} {G : LocalFrame ℓE₂ ℓR₂}
               (φ : F ↪ G)
             → frame-id G ∘ᶠ φ ≡ φ
  frame-id-l φ = refl

  frame-id-r : {ℓE₁ ℓR₁ ℓE₂ ℓR₂ : Level}
               {F : LocalFrame ℓE₁ ℓR₁} {G : LocalFrame ℓE₂ ℓR₂}
               (φ : F ↪ G)
             → φ ∘ᶠ frame-id F ≡ φ
  frame-id-r φ = refl

  ∘ᶠ-assoc : {ℓE₁ ℓR₁ ℓE₂ ℓR₂ ℓE₃ ℓR₃ ℓE₄ ℓR₄ : Level}
             {F : LocalFrame ℓE₁ ℓR₁}
             {G : LocalFrame ℓE₂ ℓR₂}
             {H : LocalFrame ℓE₃ ℓR₃}
             {K : LocalFrame ℓE₄ ℓR₄}
             (χ : H ↪ K) (ψ : G ↪ H) (φ : F ↪ G)
           → (χ ∘ᶠ ψ) ∘ᶠ φ ≡ χ ∘ᶠ (ψ ∘ᶠ φ)
  ∘ᶠ-assoc χ ψ φ = refl

  ----------------------------------------------------------------
  -- Cover: basis presentation of a covering family.
  --
  -- E1 form. A `Cover F` packages the *data* of a chosen covering
  -- family of F: an explicit indexing type, a chosen patch per index,
  -- a chosen FrameHom from each patch into F, and chosen witnesses
  -- that every actor and every event of F appears in some patch.
  --
  -- The coverage uses untruncated `Σ` (chosen witness) rather than
  -- truncated `∃` (mere existence). This is the basis-form choice
  -- (E1): every cover comes with chosen lifts, suitable for hands-on
  -- instantiation. The sieve-form (E2) replaces the indexed family
  -- and the chosen lifts by a property of all morphisms into F,
  -- closed upward under composition. The sieve generated by a basis
  -- cover is defined below as `sieve-of`; this is the bridge data
  -- the future E2 record will share with the present record.
  --
  -- Why coverage is split into actor and event clauses, not folded
  -- together: actor membership and event presence are independent
  -- locality data. A cover can be redundant on actors but tight on
  -- events, or vice versa; the two clauses make that explicit. A
  -- single combined clause ("every actor-event incidence is lifted")
  -- would conflate the two and obscure why the actor side needs
  -- `ActorIn`-prop and the event side needs `Event`-set.
  ----------------------------------------------------------------

  record Cover {ℓE ℓR : Level} (ℓI : Level) (F : LocalFrame ℓE ℓR)
             : Type (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE (ℓ-max ℓR ℓI)))) where
    open LocalFrame F
    field
      Index         : Type ℓI
      patch         : Index → LocalFrame ℓE ℓR
      embed         : (i : Index) → patch i ↪ F

      -- Actor coverage: every actor in F appears in some patch.
      actor-covered : {a : Actor} → ActorIn a
                    → Σ[ i ∈ Index ] LocalFrame.ActorIn (patch i) a

      -- Event coverage: every event of F is the image of some event
      -- in some patch. The chosen patch index, the chosen pre-image,
      -- and the witnessing path are all explicit data per the basis
      -- form (E1). In the sieve form (E2) this becomes a property of
      -- the sieve, not a chosen lift.
      event-covered : (e : Event)
                    → Σ[ i ∈ Index ]
                        Σ[ ẽ ∈ LocalFrame.Event (patch i) ]
                          FrameHom.event-map (embed i) ẽ ≡ e

  ----------------------------------------------------------------
  -- sieve-of: the sieve generated by a basis cover.
  --
  -- Given a basis cover `c` of F, the generated sieve is the
  -- property of frame morphisms `g : H ↪ F` that factor through some
  -- patch of `c`: there exists an index `i` and a morphism
  -- `h : H ↪ patch i` such that `g = embed i ∘ᶠ h`.
  --
  -- Two notes for the E2 transition:
  --
  --   * The factorization is untruncated `Σ` here (a chosen
  --     factorization). The proper sieve form uses `∃` (mere
  --     existence), making the sieve genuinely upward-closed under
  --     composition. Promoting `Σ` to `∃` is the principal
  --     restructuring step from E1 to E2.
  --   * Upward closure under composition: if `g` factors through
  --     `patch i`, then for any `k : K ↪ H`, `g ∘ᶠ k` factors through
  --     the same `patch i` via `h ∘ᶠ k`. Closure is automatic at the
  --     Σ-level; in E2 it becomes the defining property of the
  --     sieve.
  --
  -- This definition is the bridge artifact: the present file's E1
  -- `Cover` and the future E2 `Sieve` will agree on `sieve-of`'s
  -- image, with the future work proving the topologies they
  -- generate coincide.
  ----------------------------------------------------------------

  sieve-of :
      {ℓE ℓR ℓI : Level}
      {F : LocalFrame ℓE ℓR}
      (c : Cover ℓI F)
      {ℓEH ℓRH : Level}
      {H : LocalFrame ℓEH ℓRH}
    → (H ↪ F)
    → Type (ℓ-max ℓA (ℓ-max ℓE (ℓ-max ℓR (ℓ-max ℓEH (ℓ-max ℓRH ℓI)))))
  sieve-of {F = F} c {H = H} g =
    Σ[ i ∈ Cover.Index c ]
      Σ[ h ∈ H ↪ Cover.patch c i ]
        g ≡ Cover.embed c i ∘ᶠ h

  ----------------------------------------------------------------
  -- Canonical identity cover.
  --
  -- The trivial cover by F itself: index `Lift ℓI Unit`, single
  -- patch = F, single embedding = `frame-id F`. Coverage holds
  -- because every actor / event of F is already an actor / event of
  -- the single patch (= F itself).
  --
  -- Generic construction at any cover-index level ℓI: the lifted
  -- unit absorbs the level. This is the canonical witness for
  -- `ActorCausalSite.identity-cover` — any inhabitant of
  -- `ActorCausalSite` will use this (or an equivalent) for its
  -- identity field.
  ----------------------------------------------------------------

  identity-cover-canonical :
      {ℓE ℓR : Level} (ℓI : Level)
      (F : LocalFrame ℓE ℓR)
    → Cover ℓI F
  identity-cover-canonical ℓI F = record
    { Index         = Lift ℓI Unit
    ; patch         = λ _ → F
    ; embed         = λ _ → frame-id F
    ; actor-covered = λ {a} aF → lift tt , aF
    ; event-covered = λ e       → lift tt , e , refl
    }

  ----------------------------------------------------------------
  -- Canonical transitivity-of-covers.
  --
  -- Given:
  --   * a cover c of F with index I_c, patches `c.patch i`, embeds;
  --   * for each `i : I_c`, a cover d_i of `c.patch i` with index
  --     I_{d_i}, patches `d_i.patch j`, embeds;
  -- the composite cover of F has:
  --   * index `Σ[ i ∈ I_c ] I_{d_i}` — pairs;
  --   * patch `(i, j) ↦ d_i.patch j` — bottom-level patches;
  --   * embed `(i, j) ↦ c.embed i ∘ᶠ d_i.embed j` — pasted
  --     embeddings.
  --
  -- Coverage: actor a in F is covered by some (i, _-_) via
  -- c.actor-covered, and within that patch by some (_-_, j) via
  -- (d_i).actor-covered. Same for events.
  --
  -- Generic construction; no postulates. The downstream sheaf
  -- condition (when it lands) uses this in the proof that a sheaf
  -- on the basis extends to a sheaf on the generated sieve.
  ----------------------------------------------------------------

  transitivity-cover-canonical :
      {ℓE ℓR ℓI : Level}
      (F : LocalFrame ℓE ℓR)
      (c : Cover ℓI F)
      (d : (i : Cover.Index c) → Cover ℓI (Cover.patch c i))
    → Cover ℓI F
  transitivity-cover-canonical {ℓE} {ℓR} {ℓI} F c d = record
    { Index         = Σ[ i ∈ Cover.Index c ] Cover.Index (d i)
    ; patch         = λ { (i , j) → Cover.patch (d i) j }
    ; embed         = λ { (i , j) → Cover.embed c i ∘ᶠ Cover.embed (d i) j }
    ; actor-covered = λ {a} aF →
        let (i , a-in-ci) = Cover.actor-covered c aF
            (j , a-in-dj) = Cover.actor-covered (d i) a-in-ci
        in  (i , j) , a-in-dj
    ; event-covered = λ e →
        let (i , ẽ , p) = Cover.event-covered c e
            (j , ẽ̃ , q) = Cover.event-covered (d i) ẽ
        in  (i , j)
          , ẽ̃
          , (cong (FrameHom.event-map (Cover.embed c i)) q ∙ p)
    }

  ----------------------------------------------------------------
  -- ActorCausalSite: the final exported site bundle.
  --
  -- A site at fixed levels (ℓE, ℓR, ℓI) consists of:
  --   * `identity-cover` — every frame has a chosen identity cover.
  --   * `transitivity-cover` — covers compose.
  --   * `stability-cover` — covers pull back along FrameHoms.
  --
  -- Identity and transitivity are filled by the canonical
  -- constructions above for any instance. Stability is the only
  -- field a concrete site has to argue for (or postulate);
  -- pullback-of-covers does not have a generic categorical
  -- construction in this signature-only setting because we have
  -- not equipped FrameCategory with pullbacks.
  --
  -- The stability field's content: given `g : G ↪ F` and a cover
  -- `c` of F, produce a cover `d` of G plus per-patch lifts of
  -- `g` into `c`'s patches making the composition square commute.
  -- In a Grothendieck topology this is the pullback-stability
  -- axiom; here it is stated as data because the cover-class is
  -- presented basis-style (E1) and lacks a generic pullback.
  --
  -- Future E2 work: replace this field by the sieve-form
  -- "pullback sieve is covering" statement; prove equivalence
  -- through `sieve-of`.
  ----------------------------------------------------------------

  record ActorCausalSite (ℓE ℓR ℓI : Level)
       : Type (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE (ℓ-max ℓR ℓI)))) where
    field
      identity-cover :
          (F : LocalFrame ℓE ℓR) → Cover ℓI F

      transitivity-cover :
          (F : LocalFrame ℓE ℓR)
          (c : Cover ℓI F)
          (d : (i : Cover.Index c) → Cover ℓI (Cover.patch c i))
        → Cover ℓI F

      stability-cover :
          {F G : LocalFrame ℓE ℓR}
          (g : G ↪ F) (c : Cover ℓI F)
        → Σ[ d ∈ Cover ℓI G ]
            ((j : Cover.Index d) →
              Σ[ i ∈ Cover.Index c ]
                Σ[ h ∈ Cover.patch d j ↪ Cover.patch c i ]
                  g ∘ᶠ Cover.embed d j ≡ Cover.embed c i ∘ᶠ h)

------------------------------------------------------------------------
-- Stability of covers — constructed downstream, not postulated here.
--
-- A generic Agda construction of pullback-stability needs FrameCategory
-- equipped with pullbacks of FrameHoms, which this file's signature
-- does not provide on its own. That construction lives in
-- `Concurrency/Sites/ActorPullback.agda`: `stability-cover-pullback` is a
-- genuine *proof* of the stability data. Sites should use it for their
-- `stability-cover` field.
--
-- `ActorPullback` imports `ActorCausal`, so the bundled `tiny-site`
-- cannot use the constructed stability from within this file without a
-- cycle. It therefore lives in `Concurrency/Sites/TinyActorCausalSite.agda`,
-- a third module importing both. This file is now postulate-free:
-- identity and transitivity have generic constructions
-- (`identity-cover-canonical`, `transitivity-cover-canonical`), and
-- stability is supplied by construction downstream.
------------------------------------------------------------------------

------------------------------------------------------------------------
-- A small concrete site (G3).
--
-- The inhabitability witness for `ActorCausalSite`. Same structural
-- role as `boundary-swap-at-gen` for Sessions: a concrete checkable
-- artifact, not a generic theorem. Demonstrates that the records
-- compose without latent inconsistency *and* that the cover machinery
-- exercises a genuinely non-trivial topology — not just the identity
-- cover.
--
-- Pieces:
--   * `TinyAB`        — actor base with `Actor = Fin 2`. Two actors.
--   * `TinyCausal`    — two-event causal order on `Bool` with the one
--                       arrow `false ⊑ true` (and reflexivity at both
--                       points). Not discrete: `true ⊑ false` is `⊥`.
--   * `TinyFrame`     — both actors present, both events present, full
--                       incidence (every event touches every actor).
--   * `PointCausal`   — singleton-event causal order (Event = Unit).
--   * `PointFrame`    — a sub-frame containing both actors but only one
--                       (unspecified) event; used twice below as the
--                       past-event-only and future-event-only patches.
--   * `embed-point`   — for each `b : Bool`, a FrameHom embedding the
--                       point-frame into TinyFrame by mapping the
--                       single event to `b`. Genuinely *not* the
--                       identity FrameHom: event-map is `const b`,
--                       picking out one of the two events.
--   * `two-point-cover` — a cover of TinyFrame by the two point-frames
--                       (one per event), indexed by `Bool`. Genuinely
--                       non-trivial: distinct patches, distinct
--                       embeddings, distinct event lifts in
--                       `event-covered`.
--   * `tiny-site`     — the bundled ActorCausalSite, assembled in
--                       `Concurrency/Sites/TinyActorCausalSite.agda` from
--                       the two canonical cover constructions plus the
--                       constructed pullback stability (kept out of this
--                       file to avoid the `ActorPullback` import cycle).
--
-- Why two events with a causal arrow rather than one: with one event,
-- causality is trivial and every FrameHom is the identity on events.
-- The two-event version forces `embed-point` to be a non-trivial
-- event map (a `const`, not the identity) and forces the cover to
-- have two genuinely-distinct patches — exercising every field of
-- `Cover` (Index non-trivial, patch non-constant, embed non-identity,
-- actor-covered and event-covered each return non-default witnesses).
--
-- Pullback stability over a non-identity FrameHom into TinyFrame is
-- discharged by construction (`stability-cover-pullback`) where the
-- bundled site is assembled, in `TinyActorCausalSite.agda`.
------------------------------------------------------------------------

open import Cubical.Data.Bool             using (Bool ; true ; false)
open import Cubical.Data.Bool.Properties  using (isSetBool)
open import Cubical.Data.Empty.Properties using (isProp⊥)
open import Cubical.Data.Unit.Properties  using (isPropUnit)

------------------------------------------------------------------------
-- Bool order: false ⊑ true, plus reflexivity. true ⊑ false = ⊥.
--
-- Defined outside the `module _ (AB : ActorBase ℓA) where` block
-- because it doesn't depend on the actor parameter. Used only by
-- TinyCausal below.
------------------------------------------------------------------------

private
  _⊑_ : Bool → Bool → Type
  true  ⊑ false = ⊥
  _     ⊑ _     = Unit

  ⊑-refl : (e : Bool) → e ⊑ e
  ⊑-refl false = tt
  ⊑-refl true  = tt

  ⊑-trans : {e e' e'' : Bool} → e ⊑ e' → e' ⊑ e'' → e ⊑ e''
  ⊑-trans {false}              _ _ = tt
  ⊑-trans {true}  {false}      ()
  ⊑-trans {true}  {true} {false} _ ()
  ⊑-trans {true}  {true} {true}  _ _ = tt

  ⊑-antisym : {e e' : Bool} → e ⊑ e' → e' ⊑ e → e ≡ e'
  ⊑-antisym {false} {false} _ _ = refl
  ⊑-antisym {false} {true}  _ ()
  ⊑-antisym {true}  {false} ()
  ⊑-antisym {true}  {true}  _ _ = refl

  ⊑-isProp : {e e' : Bool} → isProp (e ⊑ e')
  ⊑-isProp {false} {_}     = isPropUnit
  ⊑-isProp {true}  {false} = isProp⊥
  ⊑-isProp {true}  {true}  = isPropUnit

------------------------------------------------------------------------
-- TinyAB is re-exported from `Concurrency.Sites.TinyActorBase` (imported
-- `public` above) so that the constructive two-actor base lives in a
-- postulate-free module while existing `ActorCausal.TinyAB` importers keep
-- working unchanged.
------------------------------------------------------------------------

------------------------------------------------------------------------
-- TinyCausal: Event = Bool with the order `false ⊑ true`.
------------------------------------------------------------------------

TinyCausal : CausalOrder ℓ-zero ℓ-zero
TinyCausal = record
  { Event     = Bool
  ; Event-set = isSetBool
  ; _≤_       = _⊑_
  ; ≤-refl    = ⊑-refl
  ; ≤-trans   = ⊑-trans
  ; ≤-antisym = ⊑-antisym
  ; ≤-isProp  = ⊑-isProp
  }

------------------------------------------------------------------------
-- TinyFrame: both actors, both events, full incidence.
------------------------------------------------------------------------

TinyFrame : LocalFrame TinyAB ℓ-zero ℓ-zero
TinyFrame = record
  { causal           = TinyCausal
  ; ActorIn          = λ _ → Unit
  ; ActorIn-isProp   = λ _ _ _ → refl
  ; touches          = λ _ _ → Unit
  ; touches-isProp   = λ _ _ _ _ → refl
  ; touches-in-frame = λ _ → tt
  }

------------------------------------------------------------------------
-- PointCausal and PointFrame: singleton-event sub-frame.
--
-- Used twice via `embed-point` as the past-event-only patch and the
-- future-event-only patch of the non-trivial cover below.
------------------------------------------------------------------------

PointCausal : CausalOrder ℓ-zero ℓ-zero
PointCausal = record
  { Event     = Unit
  ; Event-set = isSetUnit
  ; _≤_       = λ _ _ → Unit
  ; ≤-refl    = λ _ → tt
  ; ≤-trans   = λ _ _ → tt
  ; ≤-antisym = λ { {tt} {tt} _ _ → refl }
  ; ≤-isProp  = λ _ _ → refl
  }

PointFrame : LocalFrame TinyAB ℓ-zero ℓ-zero
PointFrame = record
  { causal           = PointCausal
  ; ActorIn          = λ _ → Unit
  ; ActorIn-isProp   = λ _ _ _ → refl
  ; touches          = λ _ _ → Unit
  ; touches-isProp   = λ _ _ _ _ → refl
  ; touches-in-frame = λ _ → tt
  }

------------------------------------------------------------------------
-- embed-point: PointFrame ↪ TinyFrame, parameterized by which event
-- of TinyFrame the single PointFrame event maps to.
--
-- Genuinely non-identity: `event-map = λ _ → b`. Causal preservation
-- and reflection are both trivial because PointFrame's order is the
-- single Unit-loop, which TinyFrame.≤'s reflexivity covers.
------------------------------------------------------------------------

embed-point : (b : Bool) → FrameHom TinyAB PointFrame TinyFrame
embed-point b = record
  { actor-pres   = λ _ → tt
  ; event-map    = λ _ → b
  ; touches-pres = λ _ → tt
  ; causal-pres  = λ _ → ⊑-refl b
  ; causal-refl  = λ _ → tt
  }

------------------------------------------------------------------------
-- two-point-cover: a Cover of TinyFrame by two distinct PointFrame
-- patches, one per event.
--
-- This is the v1 non-triviality witness. Index = Bool, both patches
-- present, `embed-point false` and `embed-point true` are distinct
-- FrameHoms (distinct `event-map`s), and `event-covered` discriminates
-- on the input event to pick the correct patch with a `refl` lift.
------------------------------------------------------------------------

two-point-cover : Cover TinyAB ℓ-zero TinyFrame
two-point-cover = record
  { Index         = Bool
  ; patch         = λ _ → PointFrame
  ; embed         = embed-point
  ; actor-covered = λ _ → false , tt
  ; event-covered = λ where
      false → false , tt , refl
      true  → true  , tt , refl
  }

------------------------------------------------------------------------
-- The bundled ActorCausalSite.
------------------------------------------------------------------------

tiny-id-cover : Cover TinyAB ℓ-zero TinyFrame
tiny-id-cover = identity-cover-canonical TinyAB ℓ-zero TinyFrame

TinyId : FrameHom TinyAB TinyFrame TinyFrame
TinyId = frame-id TinyAB TinyFrame

-- The bundled `tiny-site` is assembled in
-- `Concurrency/Sites/TinyActorCausalSite.agda` (it needs `ActorPullback`
-- for the constructed stability field, which would cycle here).

------------------------------------------------------------------------
-- Sanity checks.
--
-- Type-level witnesses confirming the records compose at concrete
-- arities. Not theorems — confirmations that the G3 instance
-- typechecks at every layer (carrier, frame, non-identity FrameHom,
-- non-identity cover, full site).
------------------------------------------------------------------------

private
  _ : ActorBase ℓ-zero
  _ = TinyAB

  _ : LocalFrame TinyAB ℓ-zero ℓ-zero
  _ = TinyFrame

  _ : LocalFrame TinyAB ℓ-zero ℓ-zero
  _ = PointFrame

  -- Identity FrameHom.
  _ : FrameHom TinyAB TinyFrame TinyFrame
  _ = TinyId

  -- Non-identity FrameHoms, one per event of TinyFrame.
  _ : FrameHom TinyAB PointFrame TinyFrame
  _ = embed-point false

  _ : FrameHom TinyAB PointFrame TinyFrame
  _ = embed-point true

  -- Identity cover and the non-trivial two-point cover.
  _ : Cover TinyAB ℓ-zero TinyFrame
  _ = tiny-id-cover

  _ : Cover TinyAB ℓ-zero TinyFrame
  _ = two-point-cover

