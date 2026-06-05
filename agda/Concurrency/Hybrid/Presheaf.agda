{-# OPTIONS --cubical --guardedness #-}

-- Hybrid layer (Adapter 1): generic frame-presheaf chassis.
--
-- This file is the first concrete realization of the Hybrid as an
-- *adapter layer* between the actor-causal locality leg
-- (`Concurrency/Sites/ActorCausal.agda`) and the session-content /
-- *-autonomous algebra leg (`Concurrency/Algebras/StarAutonomous.agda`,
-- specialized to `Concurrency/Algebras/Sessions.agda` in the sibling
-- file `Concurrency/Hybrid/SessionPresheaf.agda`).
--
-- Hybrid as adapter layer. Per `deep_context/arc/06_*.md` and the
-- 2026-05-20 reframe in `workflow/status.md`: the Hybrid is not "the
-- sheaf module," it is the disciplined set of adapters mediating
-- between the actor-locality language and the session-content
-- language. The v1 chassis names *one* adapter:
--
--   Adapter 1 — Restriction.  A sub-view of a frame on the actor
--               side induces a restriction of typed content on the
--               value side. Concretely: `FrameHom AB G F` maps to
--               `Hom (value F) (value G)`.
--
-- Future adapters (named here as header prose, not implemented):
--
--   Adapter 2 — Descent / Gluing.  Compatible local typed content
--               glues to global typed content. The full sheaf
--               condition. Trigger: `StarAutonomous` enriched with
--               closed structure / evaluation / cut (see
--               `future_work.md`, "Regarding Sessions and the
--               canonical O_1 action," ladder item 3). v1 ships only
--               the *uniqueness half* — separatedness — as a
--               property record.
--
--   Adapter 3 — Unit/Dualizing Bridge.  An optional named morphism
--               `Hom 𝟙 ⊥-par` (and/or its inverse) relating the
--               tensor unit to the dualizing object. Records a
--               "mix-like" structure when present. Not implemented;
--               not implied by *-autonomous structure alone.
--
--   Adapter 4 — Operadic Valuation.  Lifting `O_1`'s
--               `OperadAlgebra` / `Valuation` to presheaves valued
--               in algebras-over-O_1. Where "protocol-as-operad"
--               meets "protocol located over actor frames."
--
--   Adapter 5 — Promotion.  A completed conversation becoming an
--               actor in a higher-level conversation. Not a
--               `FrameHom` (strict causality reflection in
--               `ActorCausal.agda` rules that out). Sharpened
--               2026-05-21 by the Reflexive Protocol Layer (see
--               `deep_context/arc/07_self-modifying_protocol.md`
--               and the reservation below): when a closed
--               meta-conversation reaches consensus, Promotion
--               emits a morphism in the protocol-version category
--               Π — the operational form of "protocol edited."
--               Deferred to the `MO_1` stage at the construction
--               level; the type-shape can be named earlier.
--
--   Adapter 6 — Allow ⊣ Require.  The cross-site modal adapter
--               between the ModalHoTT cohesive presentation (A side)
--               and the actor-causal-sheaf presentation (B side).
--
--   Adapter 7 — No-Leak / Erasure.  An explicit erasure principle
--               witnessing that session payloads / roles / types do
--               not refine actor identity. Discipline currently
--               enforced by import-time guardrails (this file
--               imports neither `Concurrency/Operads/*` nor session
--               syntax); the named adapter would make it a theorem.
--
-- Reservation — Reflexive Protocol Layer (`Hybrid/Reflexive.agda`).
--
--   Named 2026-05-21. Future module slot for the *protocol-version
--   category* Π, the temporal/version structure layered above the
--   Hybrid chassis. Protocol edits are morphisms in Π. Edit
--   proposals produced by meta-conversations are intended to form
--   diagrams in a future patch-theoretic fragment formalism (Pijul is
--   the primary candidate); colimit / coherent amalgamation there
--   emits the next protocol-version morphism in Π. Promotion
--   (Adapter 5) is the bridge from
--   "closed meta-conversation reached consensus" to "Π-morphism
--   emitted." Non-retroactivity is inherited from `FrameHom`'s
--   strict causality reflection.
--
--   The layer is *new formal content*, compatible with and
--   anticipated by the current scaffolds but not already implicit
--   in them: nothing in this file or its siblings represents
--   protocol versions, edit morphisms, or version-indexing. Trigger
--   for opening `Hybrid/Reflexive.agda` v0: (a) descent / the linear–nonlinear bridge stable
--   enough that the Hybrid chassis is not moving under the new
--   layer, and (b) the fragment-category candidate honest enough to
--   state in Agda. Canonical source:
--   `deep_context/arc/07_self-modifying_protocol.md`. See also
--   `workflow/status.md` "Reflexive Protocol Layer" section and the
--   parallel entry in `workflow/future_work.md`.
--
-- v1 ships Adapter 1 plus the property record for the uniqueness
-- half of Adapter 2 (separatedness): local equality of two
-- morphisms-into-`value F` after restriction to every patch of a
-- cover implies global equality. Separatedness is a property record
-- with no postulates; individual presheaves either prove it or do
-- not.
--
-- The constant inhabitant at any target object `X : Ob` is provided
-- as `const-presheaf`. The "best-of-both-worlds" named instances —
-- `const-𝟙ₛ-presheaf` (neutral / no demanded content) and
-- `const-⊥ₛ-presheaf` (dualizing target, matching the `Valuation`
-- codomain) — land in the sibling file at the Sessions target.
--
-- Non-trivial witnesses (varying `value` over distinct frames) are
-- deferred to v1.1 alongside displayed-subsite machinery. The
-- present `LocalFrame` record does not support honest
-- frame-discrimination inside a `value` function without postulating
-- frame equality or building a separate displayed site (per Codex's
-- caveat in `arc/06`).
--
-- Scope guardrails (load-bearing for the adapter discipline).
--
--   * **No imports of `Concurrency.Operads.*`.** Operadic
--     interaction is Adapter 4, not Adapter 1.
--   * **No imports of `Concurrency.Algebras.Sessions`.** Session
--     content is specialization, handled in the sibling file
--     `SessionPresheaf.agda`. This file is generic over any
--     `StarAutonomous` target.
--   * **No `gen`, `plug`, `shift` references.** Same reason.
--   * **`value`'s codomain is `Ob` of an abstract `StarAutonomous`,
--     not `SessionType`.** Specialization is the next file's job.
--   * **No payloads on actors, no actor-discrimination, no
--     promotion.** Inherited from `ActorBase.agda`'s discipline.

module Concurrency.Hybrid.Presheaf where

open import Cubical.Foundations.Prelude

open import Concurrency.Sites.ActorBase
  using ( ActorBase )
open import Concurrency.Sites.ActorCausal
  using ( LocalFrame ; FrameHom ; frame-id ; _∘ᶠ_ ; Cover )
open import Concurrency.Algebras.StarAutonomous
  using ( StarAutonomous )

------------------------------------------------------------------------
-- Module parameterization.
--
-- A `FramePresheaf` lives over a fixed `ActorBase` (the unityped
-- carrier of actors) and is valued in a fixed `StarAutonomous`
-- target. The frame-category levels `ℓE, ℓR` and the cover-index
-- level `ℓI` (used only by `IsSeparatedPresheaf`) are local to the
-- individual records.
--
-- Convention parallels `Valuation.agda` / `OperadAlgebra.agda`:
-- target-signature parameters at the module head, finer levels at
-- the record head.
--
-- ActorBase vs ActorCausalSite. The chassis takes `ActorBase` (not
-- the bundled `ActorCausalSite`) because v1 only consumes the
-- underlying frame category and the basis-form `Cover` type — neither
-- of which uses the site axioms. Specifically the v1 API draws on:
--
--   * `LocalFrame AB`            — frame objects;
--   * `FrameHom AB`              — frame morphisms;
--   * `frame-id AB`, `_∘ᶠ_ AB`   — frame-category identity/composition;
--   * `Cover AB`                 — basis-form cover families.
--
-- The site fields `identity-cover`, `transitivity-cover`, and
-- `stability-cover` are *not* consumed at v1. When Adapter 2 (descent
-- / gluing) lands, the bundled `ActorCausalSite` should become an
-- explicit parameter — either at the module head or as a field of the
-- descent record — because the gluing condition will need
-- pullback-stability and transitivity of covers to state the
-- matching-family compatibility properly. Until then, parameterizing
-- only over `ActorBase` keeps the v1 surface honest about what it
-- depends on.
------------------------------------------------------------------------

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓV ℓH : Level} (V : StarAutonomous ℓV ℓH) where

  open StarAutonomous V

  ----------------------------------------------------------------------
  -- FramePresheaf: the restriction adapter (Adapter 1).
  --
  -- A contravariant assignment from actor-local frames to objects of
  -- the *-autonomous target `V`. Four fields:
  --
  --   * `value`         — actor-local frames carry typed content.
  --   * `restrict`      — sub-views give restriction morphisms,
  --                       *contravariantly* (a FrameHom G ↪ F yields
  --                       a Hom from value F to value G).
  --   * `restrict-id`   — identity sub-view restricts to identity
  --                       morphism (functoriality, unit).
  --   * `restrict-comp` — composition of sub-views factors through
  --                       composition of restrictions, *reversing
  --                       order*. The order-reversal is what makes
  --                       the adapter contravariant.
  ----------------------------------------------------------------------

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

  ----------------------------------------------------------------------
  -- IsSeparatedPresheaf: the auditability-adapter property (Q2b
  -- "safe form").
  --
  -- A presheaf is *separated* if local equality detects global
  -- equality: for every cover `c` of a frame `F` and every pair of
  -- morphisms `x y : Hom X (value F)` (for any probe object `X`), if
  -- `restrict (embed c i) ∘ x ≡ restrict (embed c i) ∘ y` for every
  -- patch index `i`, then `x ≡ y`.
  --
  -- Two design choices:
  --
  --   * **Arbitrary probe `X`, not `𝟙`.** The classical
  --     "global section" reading uses `Hom 𝟙 A`. In a linear /
  --     *-autonomous setting `𝟙` is the tensor unit, not the
  --     terminal object, so "global section as `𝟙 → A`" is a choice,
  --     not automatic terminal-object logic. Quantifying over
  --     arbitrary `X` records the joint-monicity of the cover at the
  --     level of Hom-into-`value F` and stays agnostic about what
  --     plays the role of "global section." This is the
  --     Codex/Instigator refinement on Q2b.
  --
  --   * **Property record, not field on `FramePresheaf`.** A
  --     presheaf either *is* separated or *is not*; the property is
  --     not part of being a presheaf. Individual presheaves discharge
  --     it (or do not); no global postulate of "every presheaf is
  --     separated."
  --
  -- A weaker `IsSeparatedOnInhabitedCovers` variant is *not* shipped
  -- at v1. The empty-cover edge case ("at most one section over a
  -- frame admitting an empty cover") is mathematically normal for
  -- sheaves but may be too strong for arbitrary session-valued
  -- presheaves. v1 defines the honest form and leaves witnesses for
  -- later work (no separatedness lemma is "cheap" at the present
  -- level of categorical structure, so none is forced).
  --
  -- This is the *uniqueness half* of descent. The existence half
  -- (matching families amalgamating to global sections) is the
  -- deferred Adapter 2 and shares its trigger with the canonical
  -- `O_1` action's categorical derivation (`future_work.md`, ladder
  -- item 3).
  ----------------------------------------------------------------------

  record IsSeparatedPresheaf
           {ℓE ℓR ℓI : Level}
           (P : FramePresheaf {ℓE} {ℓR})
       : Type (ℓ-suc (ℓ-max ℓA
                       (ℓ-max ℓE
                         (ℓ-max ℓR
                           (ℓ-max ℓI (ℓ-max ℓV ℓH)))))) where
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

  ----------------------------------------------------------------------
  -- const-presheaf: the constant inhabitant at any chosen target.
  --
  -- Every frame maps to the chosen object `X`; every FrameHom maps
  -- to the identity morphism on `X`. Functoriality discharges by:
  --
  --   * `restrict-id` = `refl` (the restrict-of-identity is `id`).
  --   * `restrict-comp` = `sym (id-l id)` (composition of two
  --     identities equals one identity by the left-unit law).
  --
  -- This is the v1 inhabitability witness. The two named instances
  -- — `const-𝟙ₛ-presheaf` and `const-⊥ₛ-presheaf` — live in the
  -- sibling file `SessionPresheaf.agda`, where the choice between
  -- tensor unit and dualizing object is meaningful at the Sessions
  -- specialization.
  --
  -- Separatedness of `const-presheaf X` is *not* proved at v1.
  -- Separatedness for an empty-index cover would require any two
  -- parallel morphisms `x y : Hom X (value F)` to be equal, because
  -- there are no patch restrictions to test. That is not generally
  -- provable for arbitrary targets / objects. Until the topology
  -- rules out empty covers (or we restrict to the inhabited variant),
  -- no general proof is available.
  ----------------------------------------------------------------------

  const-presheaf : {ℓE ℓR : Level} → Ob → FramePresheaf {ℓE} {ℓR}
  const-presheaf X = record
    { value         = λ _ → X
    ; restrict      = λ _ → id
    ; restrict-id   = refl
    ; restrict-comp = λ _ _ → sym (id-l id)
    }
