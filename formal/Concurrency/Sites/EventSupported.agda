{-# OPTIONS --cubical --guardedness #-}

-- Event-supported (event-generated) frames.
--
-- The geometry fix behind the point-generated reflector. In a general
-- `LocalFrame`, `ActorIn` is an *independent* field, tied to events only
-- by the one-way `touches-in-frame : touches e a → ActorIn a`. That slack
-- is exactly what lets the raw pullback (`ActorPullback.frame-pullback`)
-- carry an actor in an *event-empty* overlap: its `ActorIn` is the actor
-- intersection, computed independently of events. An event-empty
-- off-diagonal point overlap can still be actor-nonempty (Codex's flag),
-- so `point-local ⟺ sheaf` is *not* automatic for the raw geometry.
--
-- The fix is to close the implication into an equivalence:
--
--   ActorIn a  ≃  EventSupport a  :=  ∥ Σ[ e ] touches e a ∥₁
--
-- ("event-generated": an actor is in the frame iff some event touches
-- it). The reverse direction `EventSupport a → ActorIn a` is *always*
-- available (`support→actorIn`, from `touches-in-frame`); so the genuine
-- content of `IsEventSupported` is just the forward map. On event-
-- supported frames an event-empty overlap is automatically actor-empty,
-- which is what makes the off-diagonal descent clauses vacuous later.
--
-- This is a *wrapper*, per the agreed contract: `LocalFrame` / `FrameHom`
-- are untouched. We add (i) the support predicate, (ii) `support-actor-
-- pres`, a helper that *derives* a morphism's `actor-pres` from its
-- `event-map` + `touches-pres` when the source is supported (so supported
-- morphisms never carry an independent `actor-pres`), and (iii) the proof
-- that the incident point frames of `EventPoint.agda` are supported.
--
-- `ChosenEventSupport` is the cover-facing, *untruncated* variant: a
-- chosen witnessing event per member actor. A `FiniteCover`-style
-- `actor-covered` must hand back an actual covering patch (an element of
-- a `Σ`, not a prop), so the point cover consumes this chosen form, while
-- the truncated `EventSupport` is what defines the event-generated
-- overlap actors.
--
-- Scope guardrails: pure site / locality machinery; no value / content /
-- operad imports.

module Concurrency.Sites.EventSupported where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv using (_≃_)
open import Cubical.Data.Nat using (ℕ)
open import Cubical.Data.FinData using (Fin)
open import Cubical.Data.Sigma using (Σ-syntax ; _,_ ; fst ; snd)
open import Cubical.Data.Unit using (Unit* ; tt*)
open import Cubical.HITs.PropositionalTruncation
  using (∥_∥₁ ; ∣_∣₁ ; isPropPropTrunc) renaming (rec to ∥rec∥)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal using (LocalFrame ; FrameHom)
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Sites.EventPoint using (point-frame)

module _ {ℓA : Level} (AB : ActorBase ℓA) where
  open ActorBase AB

  ------------------------------------------------------------------
  -- Event support.
  ------------------------------------------------------------------

  -- An actor is event-supported in `F` when some event of `F` touches it.
  EventSupport : {ℓE ℓR : Level} (F : LocalFrame AB ℓE ℓR)
               → Actor → Type (ℓ-max ℓE ℓR)
  EventSupport F a =
    ∥ Σ[ e ∈ LocalFrame.Event F ] LocalFrame.touches F e a ∥₁

  isPropEventSupport : {ℓE ℓR : Level} (F : LocalFrame AB ℓE ℓR) (a : Actor)
                     → isProp (EventSupport F a)
  isPropEventSupport F a = isPropPropTrunc

  -- The free direction: event support implies membership.
  support→actorIn : {ℓE ℓR : Level} (F : LocalFrame AB ℓE ℓR) (a : Actor)
                  → EventSupport F a → LocalFrame.ActorIn F a
  support→actorIn F a =
    ∥rec∥ (LocalFrame.ActorIn-isProp F a)
          (λ { (e , t) → LocalFrame.touches-in-frame F t })

  -- A frame is event-supported when membership also implies support
  -- (so the equivalence `ActorIn ≃ EventSupport` holds; the reverse is
  -- `support→actorIn`).
  IsEventSupported : {ℓE ℓR : Level} (F : LocalFrame AB ℓE ℓR)
                   → Type (ℓ-max ℓA (ℓ-max ℓE ℓR))
  IsEventSupported F =
    (a : Actor) → LocalFrame.ActorIn F a → EventSupport F a

  -- Cover-facing, untruncated: a *chosen* witnessing event per member.
  ChosenEventSupport : {ℓE ℓR : Level} (F : LocalFrame AB ℓE ℓR)
                     → Type (ℓ-max ℓA (ℓ-max ℓE ℓR))
  ChosenEventSupport F =
    (a : Actor) → LocalFrame.ActorIn F a
                → Σ[ e ∈ LocalFrame.Event F ] LocalFrame.touches F e a

  ------------------------------------------------------------------
  -- The support helper: derive `actor-pres` from `touches-pres`.
  --
  -- When the *source* `F` is event-supported, a morphism's `actor-pres`
  -- is not independent data — it is forced by `event-map` + `touches-
  -- pres`: a member actor is supported by some event, push that event
  -- forward and read membership off `touches-in-frame` in `G`.
  ------------------------------------------------------------------

  support-actor-pres :
      {ℓE₁ ℓR₁ ℓE₂ ℓR₂ : Level}
      {F : LocalFrame AB ℓE₁ ℓR₁} {G : LocalFrame AB ℓE₂ ℓR₂}
      (supF : IsEventSupported F)
      (em : LocalFrame.Event F → LocalFrame.Event G)
      (tp : {e : LocalFrame.Event F} {a : Actor}
            → LocalFrame.touches F e a → LocalFrame.touches G (em e) a)
      {a : Actor} → LocalFrame.ActorIn F a → LocalFrame.ActorIn G a
  support-actor-pres {G = G} supF em tp {a} fa =
    ∥rec∥ (LocalFrame.ActorIn-isProp G a)
          (λ { (e , t) → LocalFrame.touches-in-frame G (tp t) })
          (supF a fa)

  ------------------------------------------------------------------
  -- Incident point frames are event-supported.
  --
  -- `(point-frame F e).ActorIn = touches F e`, and the point's single
  -- event touches exactly those actors, so support is `∣ tt* , _ ∣₁`.
  ------------------------------------------------------------------

  point-frame-supported :
      {ℓE : Level} (F : LocalFrame AB ℓE ℓA) (e : LocalFrame.Event F)
    → IsEventSupported (point-frame AB F e)
  point-frame-supported F e a pa = ∣ tt* , pa ∣₁

  -- And the chosen form, with the unique event `tt*`.
  point-frame-chosen-support :
      {ℓE : Level} (F : LocalFrame AB ℓE ℓA) (e : LocalFrame.Event F)
    → ChosenEventSupport (point-frame AB F e)
  point-frame-chosen-support F e a pa = tt* , pa

  ------------------------------------------------------------------
  -- A finite frame bundled with a chosen event support.
  --
  -- The cover-facing object of the point-generated route: every
  -- descent statement (Brick 2) is *over* such a frame, so bundling the
  -- support here means the `PointDescent` signatures need not each thread
  -- a `ChosenEventSupport` argument (Codex's design note). The point
  -- cover is `point-cover (fin SF) (support SF)` (`PointCover.agda`).
  ------------------------------------------------------------------

  record SupportedFiniteFrame : Type (ℓ-suc ℓA) where
    field
      fin     : FiniteFrame AB ℓ-zero ℓA
      support : ChosenEventSupport (FiniteFrame.frame fin)

  ------------------------------------------------------------------
  -- The presheaf-independent point-shape API of a supported finite
  -- frame: its underlying local frame, event type, event count, and
  -- chosen enumeration. Factored out here (P-free) so the pointification
  -- reflector and its functor share *one* definition of each — otherwise
  -- Agda compares per-presheaf copies (`en … P` vs `en … Q`) and
  -- reconstructs supported frames with metavariable count / support fields.
  ------------------------------------------------------------------

  sfFrame : SupportedFiniteFrame → LocalFrame AB ℓ-zero ℓA
  sfFrame SF = FiniteFrame.frame (SupportedFiniteFrame.fin SF)

  sfEv : SupportedFiniteFrame → Type ℓ-zero
  sfEv SF = LocalFrame.Event (sfFrame SF)

  sfCount : SupportedFiniteFrame → ℕ
  sfCount SF = FiniteFrame.event-count (SupportedFiniteFrame.fin SF)

  sfEnum : (SF : SupportedFiniteFrame) → sfEv SF ≃ Fin (sfCount SF)
  sfEnum SF = FiniteFrame.enum (SupportedFiniteFrame.fin SF)
