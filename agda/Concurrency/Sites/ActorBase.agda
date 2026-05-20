{-# OPTIONS --cubical --guardedness #-}

-- Opaque actor carrier and causal-order primitive for the actor-causal site.
--
-- This file is the locality-leg counterpart of
-- `Concurrency/Operads/Ports.agda`: a minimal substrate file containing
-- the two primitive carriers — `ActorBase` (opaque actor type) and
-- `CausalOrder` (Lamport partial-order on events) — that the site
-- structure in `Concurrency/Sites/ActorCausal.agda` consumes. Sibling
-- file, not a subdirectory, mirroring `Operads/Ports.agda` →
-- `Operads/CyclicAssociative.agda`.
--
-- Scope guardrail. The constraints below are load-bearing for the
-- actor / session separation. Violating them in this file would foreclose
-- the "conversation of conversations" structure that the architecture
-- deliberately preserves as a slot for downstream work.
--
--   * **Actor is opaque.** No constructors, no kinds, no discrimination
--     between "individual" and "promoted-conversation" actors. The
--     communication kernel must not be able to branch on actor origin.
--     This is the structural form of "unityped agents" from
--     workflow/motivation.md and arc/05's verified-kernel framing: any
--     metadata (human, LLM, completed conversation) lives outside this
--     record, in implementation adapters, not in the verified core.
--
--   * **No payloads, no roles, no message syntax.** Those belong to
--     `Concurrency/Algebras/Sessions.agda` (typed-content layer). Actors
--     produce events; events touch actors. Both are untyped at this
--     layer; what they exchange is the content layer's business.
--
--   * **No promotion mechanism.** A completed conversation becoming a
--     new actor is the modular-envelope / MO_1 move (arc/03,
--     arc/05). The current file does not host it. Strict causality
--     reflection in `FrameHom` (next file) is the discipline that
--     forces promotion to be a different morphism class rather than a
--     special-case FrameHom — see `ActorCausal.agda`'s header.
--
--   * **Lamport partial-order, not Lorentzian or event-structure.**
--     Decision 2026-05-17. The non-strict reflexive antisymmetric
--     transitive prop-valued order is the smallest commitment that
--     makes "happens-before" meaningful and matches standard
--     distributed-systems vocabulary. Petri-net / event-structure /
--     Lorentzian refinements remain held-loose for future work.
--
-- Naming discipline:
--   * `Actor` is the type, no decorations. The record name `ActorBase`
--     follows the StarAutonomous / Valuation / OperadAlgebra pattern
--     (signature-record naming) rather than the `O` operad-style.
--   * `_≤_` for the causal order is conventional for partial orders;
--     CLAUDE.md's long-names rule targets opaque single symbols like
--     `♭` / `ʃ`, not standard mathematical relations.
--   * `Event-set` and `Actor-set` rather than `isSet Event` /
--     `isSet Actor` at field declaration sites; the `-set` suffix
--     matches `Hom-set` in `StarAutonomous.agda`.

module Concurrency.Sites.ActorBase where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Sigma   using (_×_ ; _,_)
open import Cubical.Relation.Nullary using (¬_)

------------------------------------------------------------------------
-- ActorBase: the opaque actor carrier.
--
-- An `ActorBase ℓ` packages a type of actors with set-truncation. Two
-- choices are deliberate:
--
--   * No equality (decidable or otherwise). Decidable equality would
--     let the kernel branch on actor identity, breaking the
--     unityped-agents discipline. Specific instances may add it as
--     extra structure outside this record.
--   * No fresh-name generation. Allocation of new actors (the
--     downstream "promotion" operation) is an implementation-adapter
--     concern, not a kernel concern.
--
-- `Actor-set` is load-bearing: cover families, FrameHom equality, and
-- the eventual sheaf condition all need actor incidence to behave as
-- a proposition-valued relation on a set of actors.
------------------------------------------------------------------------

record ActorBase (ℓ : Level) : Type (ℓ-suc ℓ) where
  field
    Actor     : Type ℓ
    Actor-set : isSet Actor

------------------------------------------------------------------------
-- CausalOrder: Lamport-style non-strict partial order on events.
--
-- An `Event` is an untyped occurrence — something happened, somewhere,
-- touching some actors. `_≤_` records "happened-before-or-equal."
-- The four order axioms (reflexive, transitive, antisymmetric,
-- prop-valued) commit Lamport's discipline without committing to
-- richer structure (concurrency relations, conflict, choice — those
-- belong to event-structure / Petri-net refinements held-loose for
-- future work).
--
-- `Event-set` is stated explicitly. It is not derivable from
-- `≤-isProp` plus antisymmetry alone: antisymmetry only constrains
-- comparable events; two incomparable events are not forced equal.
-- Set-truncation of events is needed for cover families to behave
-- (every event in the covered frame must appear in some patch — a
-- well-typed existential over events).
--
-- `Concurrent` is the derived relation: two events that are neither
-- ≤-related in either direction. Exposed but not used in this file;
-- downstream covers may want to talk about concurrent events.
------------------------------------------------------------------------

record CausalOrder (ℓE ℓR : Level) : Type (ℓ-suc (ℓ-max ℓE ℓR)) where
  field
    Event      : Type ℓE
    Event-set  : isSet Event
    _≤_        : Event → Event → Type ℓR
    ≤-refl     : (e : Event) → e ≤ e
    ≤-trans    : {e e' e'' : Event} → e ≤ e' → e' ≤ e'' → e ≤ e''
    ≤-antisym  : {e e' : Event} → e ≤ e' → e' ≤ e → e ≡ e'
    ≤-isProp   : {e e' : Event} → isProp (e ≤ e')

  ----------------------------------------------------------------
  -- Derived: concurrency.
  --
  -- Two events are concurrent when neither precedes the other.
  -- Symmetric by construction; not equality (a single event is not
  -- concurrent with itself, since `≤-refl` provides `e ≤ e`).
  ----------------------------------------------------------------

  Concurrent : Event → Event → Type ℓR
  Concurrent e e' = (¬ (e ≤ e')) × (¬ (e' ≤ e))

  Concurrent-sym : (e e' : Event) → Concurrent e e' → Concurrent e' e
  Concurrent-sym e e' (¬ee' , ¬e'e) = ¬e'e , ¬ee'

  ----------------------------------------------------------------
  -- Derived: ≤ uniqueness.
  --
  -- If both directions hold, the events are equal (named here so
  -- FrameHom's injectivity-from-reflection lemma in the next file can
  -- reference it without re-deriving). Same content as `≤-antisym`,
  -- relabelled for the use site.
  ----------------------------------------------------------------

  ≤-bidir-equal : {e e' : Event} → e ≤ e' → e' ≤ e → e ≡ e'
  ≤-bidir-equal = ≤-antisym

------------------------------------------------------------------------
-- Sanity checks.
--
-- Type-level witnesses confirming the records compose. Not theorems;
-- the actual non-degenerate witness lives in `ActorCausal.agda`'s
-- G3-style instance (the small explicit ActorCausalSite).
------------------------------------------------------------------------

private
  -- ActorBase is a record type at its level. Inhabitable in principle;
  -- the inhabitation witness is in `ActorCausal.agda`.
  _ : (ℓ : Level) → Type (ℓ-suc ℓ)
  _ = ActorBase

  -- CausalOrder takes two levels (event level, relation level), same
  -- shape as `StarAutonomous` taking object and morphism levels.
  _ : (ℓE ℓR : Level) → Type (ℓ-suc (ℓ-max ℓE ℓR))
  _ = CausalOrder
