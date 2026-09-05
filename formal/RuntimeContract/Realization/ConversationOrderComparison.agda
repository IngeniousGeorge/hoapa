{-# OPTIONS --cubical --guardedness #-}

-- Two orders on one conversation, and exactly when they agree.
--
-- `ConversationLocality.agda` gives a conversation frame the GLOBAL causal
-- order restricted to its events. The obvious alternative is to regenerate
-- the order from the conversation's OWN parent edges. This module builds
-- that rival and characterizes when it supports the same embedding, so that
-- the choice made there is a theorem about the alternative rather than a
-- preference recorded in a comment.
--
-- THE RIVAL. `StarL` is the reflexive-transitive closure of the internal
-- parent-edge relation: a possibly-empty chain EVERY vertex of which is a
-- `ConversationEvent c`. `_≤L_` is its propositional truncation.
--
-- ON THE TWO PRESENTATIONS. The global order is implemented as equality-or-
-- a-truncated-NON-empty parent chain; the internal order here is a truncated
-- POSSIBLY-empty chain, the direct reflexive-transitive-closure presentation.
-- Nothing below depends on an equivalence between those two shapes, and none
-- is proved: internal chains reach the global order only through its exported
-- interface — `≤-refl`, `parent-edge-implies-causal`, `≤-trans` — which is
-- what `≤L-least` packages. The global chain type and its rank machinery stay
-- private, and this module never needs them.
--
-- WHY THE TRUNCATED SHAPE. Every `CausalOrder` law then comes cheaply:
-- `≤-isProp` from the truncation, `≤-refl` from the empty chain, `≤-trans`
-- from concatenation, and `≤-antisym` by factoring through the global order's
-- antisymmetry. Mirroring the global `⊎` shape instead would have required
-- proving the two branches disjoint, which needs the private rank argument.
--
-- LEASTNESS. `≤L-least` says every propositional, reflexive, transitive
-- relation containing the internal parent edges contains `_≤L_`. That is the
-- universal property of the generated order, and it is what makes `StarL`
-- the genuine rival rather than a convenient variant — the inclusion into the
-- global order is one instance of it.
--
-- THE CHARACTERIZATION. `ConversationCausallySaturated c` says every global
-- relation between two events of `c` is already witnessed by a parent path
-- inside `c`. Then:
--
--   * saturation CONSTRUCTS the canonical embedding of the internal-order
--     frame into the global frame (`saturated→embed`);
--   * any embedding whose event map is pointwise `fst` YIELDS saturation
--     (`embed→saturated`).
--
-- Saturation is the exact condition, and it is weaker than "no causal chain
-- leaves `c` and returns": a run may have both an external detour and an
-- internal path, and the orders still agree.
--
-- STATED EXACTLY. `embed→saturated` is scoped to embeddings satisfying
-- `event-map φ x ≡ fst x` pointwise. Nothing here rules out an embedding with
-- some other event map, and no such claim should be read off it. Concrete
-- saturated and non-saturated instances live in
-- `RuntimeContract.Tests.ConversationOrderComparison`; this module is generic
-- over any well-formed run and any conversation present in it.
--
-- Not `--safe`: the actor-causal substrate carries the infective
-- `--guardedness` flag. This module is nonetheless postulate- and hole-free.

module RuntimeContract.Realization.ConversationOrderComparison where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Sigma using (Σ-syntax; _,_; fst; snd; Σ≡Prop)
open import Cubical.Data.Unit using (Unit; tt)
open import Cubical.HITs.PropositionalTruncation
  using (∥_∥₁; ∣_∣₁; squash₁)
  renaming (rec to ∥rec∥; rec2 to ∥rec2∥)

open import Concurrency.Sites.ActorBase using (ActorBase; CausalOrder)
open import Concurrency.Sites.ActorCausal using (LocalFrame; FrameHom)

open import RuntimeContract.Trace
open import RuntimeContract.Realization.CausalFromParents
  using (REvent; ParentEdge; parent-edge-implies-causal;
         realizeActorBase; realizeCausal; realizeFrame)
open import RuntimeContract.Realization.ConversationLocality
  using (RConversation; ConversationEvent; ConversationEvent-set; InConversation-isProp;
         conversationFrame)

module _ (r : RawRun) (w : WellFormed r) (c : RConversation r w) where

  private
    CEvent : Type
    CEvent = ConversationEvent r w c

    _≤G_ : REvent r w → REvent r w → Type
    _≤G_ = CausalOrder._≤_ (realizeCausal r w)

    AB : ActorBase ℓ-zero
    AB = realizeActorBase r w

    GF : LocalFrame AB ℓ-zero ℓ-zero
    GF = realizeFrame r w

  InternalEdge : CEvent → CEvent → Type
  InternalEdge x y = ParentEdge r w (fst x) (fst y)

  data StarL : CEvent → CEvent → Type where
    nil  : {x : CEvent} → StarL x x
    cons : {x y z : CEvent} → InternalEdge x y → StarL y z → StarL x z

  _≤L_ : CEvent → CEvent → Type
  x ≤L y = ∥ StarL x y ∥₁

  ≤L-least :
      {ℓ : Level} (R : CEvent → CEvent → Type ℓ)
    → ({x y : CEvent} → isProp (R x y))
    → ((x : CEvent) → R x x)
    → ({x y z : CEvent} → R x y → R y z → R x z)
    → ({x y : CEvent} → InternalEdge x y → R x y)
    → {x y : CEvent} → x ≤L y → R x y
  ≤L-least R R-prop R-refl R-trans R-edge = ∥rec∥ R-prop fold
    where
      fold : {u v : CEvent} → StarL u v → R u v
      fold nil        = R-refl _
      fold (cons e s) = R-trans (R-edge e) (fold s)

  -- The inclusion, as an INSTANCE of leastness rather than a second
  -- induction: the global order restricted along `fst` is reflexive,
  -- transitive, propositional, and contains the internal parent edges.
  internal-implies-global : {x y : CEvent} → x ≤L y → fst x ≤G fst y
  internal-implies-global =
    ≤L-least (λ u v → fst u ≤G fst v)
             (CausalOrder.≤-isProp  (realizeCausal r w))
             (λ u → CausalOrder.≤-refl (realizeCausal r w) (fst u))
             (CausalOrder.≤-trans   (realizeCausal r w))
             (λ e → parent-edge-implies-causal r w e)

  private
    starL-concat : {x y z : CEvent} → StarL x y → StarL y z → StarL x z
    starL-concat nil        t = t
    starL-concat (cons e s) t = cons e (starL-concat s t)

    ≤L-trans : {x y z : CEvent} → x ≤L y → y ≤L z → x ≤L z
    ≤L-trans = ∥rec2∥ squash₁ (λ s t → ∣ starL-concat s t ∣₁)

    ≤L-antisym : {x y : CEvent} → x ≤L y → y ≤L x → x ≡ y
    ≤L-antisym p q =
      Σ≡Prop (InConversation-isProp r w c)
             (CausalOrder.≤-antisym (realizeCausal r w)
                (internal-implies-global p) (internal-implies-global q))

  conversationInternalCausal : CausalOrder ℓ-zero ℓ-zero
  conversationInternalCausal = record
    { Event     = CEvent
    ; Event-set = ConversationEvent-set r w c
    ; _≤_       = _≤L_
    ; ≤-refl    = λ _ → ∣ nil ∣₁
    ; ≤-trans   = ≤L-trans
    ; ≤-antisym = ≤L-antisym
    ; ≤-isProp  = squash₁
    }

  ConversationCausallySaturated : Type
  ConversationCausallySaturated = (x y : CEvent) → fst x ≤G fst y → x ≤L y

  conversationInternalFrame : LocalFrame AB ℓ-zero ℓ-zero
  conversationInternalFrame = record
    { causal           = conversationInternalCausal
    ; ActorIn          = LocalFrame.ActorIn          CF
    ; ActorIn-isProp   = LocalFrame.ActorIn-isProp   CF
    ; touches          = LocalFrame.touches          CF
    ; touches-isProp   = LocalFrame.touches-isProp   CF
    ; touches-in-frame = λ {x} {a} p → LocalFrame.touches-in-frame CF {x} {a} p
    }
    where
      CF : LocalFrame AB ℓ-zero ℓ-zero
      CF = conversationFrame r w c

  saturated→embed :
      ConversationCausallySaturated
    → FrameHom AB conversationInternalFrame GF
  saturated→embed sat = record
    { actor-pres   = λ _ → tt
    ; event-map    = fst
    ; touches-pres = λ p → p
    ; causal-pres  = internal-implies-global
    ; causal-refl  = λ {x} {y} p → sat x y p
    }

  embed→saturated :
      (φ : FrameHom AB conversationInternalFrame GF)
    → ((x : CEvent) → FrameHom.event-map φ x ≡ fst x)
    → ConversationCausallySaturated
  embed→saturated φ canonical x y p =
    FrameHom.causal-refl φ
      (subst2 _≤G_ (sym (canonical x)) (sym (canonical y)) p)
