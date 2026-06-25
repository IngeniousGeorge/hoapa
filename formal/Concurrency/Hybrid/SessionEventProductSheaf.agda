{-# OPTIONS --cubical --guardedness #-}

-- The event-product sheaf at the Sessions value category
-- (constant-slot form of the B2(a) target).
--
-- This is the concrete Sessions instantiation that the generic
-- finite-site descent witness (`Concurrency/Hybrid/EventProductSheaf.agda`)
-- was built to receive. The generic `event-product-sheaf` is parametric
-- in a Cubical `Category C`, a `HasFiniteProducts C`, and a slot object
-- `P₀`; here we feed it the underlying category of the session value
-- category (`StarAutonomous→Category Sessions-Cat`) —
--
--   * `V  := Sessions-Cat Payload`            (the session value category)
--   * `FP := Sessions-HasFiniteProducts`      (its additive products)
--   * `P₀ : SessionType`                       (one fixed session type as
--                                               the per-event slot)
--
-- and obtain `session-event-product-sheaf`, a full finite-site descent
-- inhabitant whose values are session-typed and vary over actor-local
-- frames. This is the "separation of concerns = sheaf gluing" picture
-- landed at the Sessions value category rather than a generic placeholder
-- `V` — the first step of the B2(a) target.
--
-- What this is *not* (anti-overclaim). The original B2(a) candidate (a)
-- was "session content *depending on* F's events" — a genuinely
-- event-dependent value. This witness is the *constant-slot* form: the
-- product *arity* tracks the event count (so it is frame-varying and the
-- gluing is non-degenerate), but every event carries the *same* fixed
-- slot `P₀`, so the content does not yet vary event-by-event. The fully
-- event-dependent B2(a) — where each event's session is read from that
-- event — is a later upgrade (it reintroduces index-dependent codomains;
-- see `EventProductPresheaf.agda` on why the constant slot keeps the
-- product API's `UnsupportedIndexedMatch` warning inert). So "B2(a)" here
-- names the constant-slot landing, not the event-dependent target.
--
-- What was gated on, and is now unblocked. The Sessions instantiation
-- was deferred because the multiplicative `Sessions-Cat` had no additive
-- products: a contravariant restriction along a sub-view *drops* the
-- events outside the sub-frame, which is weakening — forbidden by the
-- multiplicative (`⊗`) discipline. The fix (2026-06-04) was to enrich
-- the session syntax with the additive product `_&ₛ_` / `⊤ₛ` (with
-- projections, so `value F → value G` is a tuple of projections, not a
-- tensor manipulation) and bundle it as `Sessions-HasFiniteProducts`.
-- That single enrichment supplies both the non-degenerate frame-varying
-- value *and* the empty-frame normalization (`value ∅ = ⊤ₛ`, terminal),
-- so descent here is full, not merely inhabited-cover (A1) descent.
--
-- Scope. `P₀` is left a parameter: any session type can be the per-event
-- slot (e.g. `end`, or `send p end` for a one-payload protocol). The
-- value `value F = P₀ ^ (event-count F)` is a *constant-slot* product —
-- the event set determines the arity, the slot content is the same per
-- event. An event-dependent slot (where each event carries a different
-- session) is a later upgrade, as is reflecting causal order / actor
-- incidence in the value (the v1 value reads only the event set). The
-- additive *coproduct* (`_⊕ₛ_` / `𝟘ₛ`) plays no role here — it exists in
-- the syntax only as the De Morgan dual keeping `_^⊥ₛ` involutive.

module Concurrency.Hybrid.SessionEventProductSheaf where

open import Cubical.Foundations.Prelude

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Algebras.StarAutonomous using (StarAutonomous)
open import Concurrency.Algebras.StarAutonomousCategory using (StarAutonomous→Category)
open import Concurrency.Algebras.Sessions
  using (Sessions-Cat ; Sessions-HasFiniteProducts)
open import Concurrency.Hybrid.FinitePresheaf using (FiniteFramePresheaf)
open import Concurrency.Hybrid.EventProductPresheaf using (event-product-presheaf)
open import Concurrency.Hybrid.FiniteDescent using (IsSheaf)
open import Concurrency.Hybrid.EventProductSheaf using (event-product-sheaf)

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓv ℓ' : Level} (Payload : Type ℓv)
         {ℓE ℓR : Level}
         (P₀ : StarAutonomous.Ob (Sessions-Cat {ℓv} {ℓ'} Payload)) where

  private
    -- The session value category and its additive finite products.
    V : StarAutonomous ℓv ℓv
    V = Sessions-Cat {ℓv} {ℓ'} Payload

    -- Its underlying category, where the framework records live.
    Ĉ = StarAutonomous→Category V

  ----------------------------------------------------------------------
  -- The frame-varying session-valued presheaf: value F = P₀ ^ (events F).
  ----------------------------------------------------------------------

  session-event-product-presheaf : FiniteFramePresheaf AB Ĉ {ℓE} {ℓR}
  session-event-product-presheaf =
    event-product-presheaf AB Ĉ (Sessions-HasFiniteProducts {ℓ' = ℓ'} Payload) P₀

  ----------------------------------------------------------------------
  -- The descent inhabitant at the Sessions target.
  ----------------------------------------------------------------------

  session-event-product-sheaf :
      {ℓI : Level}
    → IsSheaf AB Ĉ {ℓE} {ℓR} {ℓI} session-event-product-presheaf
  session-event-product-sheaf =
    event-product-sheaf AB Ĉ (Sessions-HasFiniteProducts {ℓ' = ℓ'} Payload) P₀
