{-# OPTIONS --cubical --guardedness #-}

-- The event-product presheaf is a sheaf on the finite-frame site.
-- Milestone 3 (the inhabitant): the first *non-degenerate*, frame-varying
-- presheaf proved to satisfy full descent — separated + amalgamating —
-- over `FiniteCover`s, including the empty cover of the empty frame.
--
-- This is what makes descent earn its name on the B-side. Unlike the
-- constant presheaf (which glues trivially because every part is forced
-- equal), the event-product presheaf's `value` varies with the frame
-- (its arity is the event count), so:
--
--   * **Amalgamation** genuinely *reconstructs* a global section
--     component-by-component: for each event of `F`, `event-covered`
--     names a patch witnessing it, and that patch's local section
--     supplies the component. Well-definedness across the choice of
--     witnessing patch is exactly `compatible`, projected through the
--     carried overlap enumeration — the pullback overlaps doing real
--     work.
--   * **Separatedness** reads each global component off the patch that
--     covers the corresponding event.
--
-- Full (not merely positive) descent. Because `value` of the empty frame
-- is the empty product `⊤ₚ` (terminal), the empty cover is handled
-- uniformly: amalgamation returns `terminal` with a vacuous restriction
-- condition, and separatedness collapses two maps into `⊤ₚ` by
-- `terminal-unique`. No inhabited-cover restriction (A1) is needed — the
-- terminal object supplied by `HasFiniteProducts` is exactly the
-- normalization datum the thin `StarAutonomous` lacked.
--
-- Proof discipline. Everything goes through the product universal
-- property (`bigβ`, `bigη`, `bigProduct-ext`) and the enumeration
-- coherences (`secEq`, `retEq`). The constant slot keeps every
-- projection's codomain at `P₀`, so rewriting an index along an
-- enumeration path is a plain `cong` in a fixed `Hom`-type — the regime
-- in which the product API's `UnsupportedIndexedMatch` warning is inert.
--
-- Scope guardrails: generic over any `StarAutonomous V` with
-- `HasFiniteProducts V` and a chosen slot `P₀`; no session syntax, no
-- operad imports. The concrete Sessions instantiation is a later
-- milestone.

module Concurrency.Hybrid.EventProductSheaf where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Equiv using (_≃_ ; equivFun ; invEq ; secEq ; retEq)
open import Cubical.Data.Nat using (ℕ)
open import Cubical.Data.FinData using (Fin)
open import Cubical.Data.Sigma using (Σ-syntax ; _,_ ; fst ; snd)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal using (LocalFrame ; FrameHom)
open import Concurrency.Sites.ActorPullback using (frame-pullback ; pb-π₁ ; pb-π₂)
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)
open import Concurrency.Sites.FiniteCover using (FiniteCover)
open import Concurrency.Algebras.StarAutonomous using (StarAutonomous)
open import Concurrency.Algebras.FiniteProducts
  using (HasFiniteProducts ; module FiniteProductAPI)
open import Concurrency.Hybrid.EventProductPresheaf
  using (FiniteFramePresheaf ; event-product-presheaf)
open import Concurrency.Hybrid.FiniteDescent

module _ {ℓA : Level} (AB : ActorBase ℓA)
         {ℓV ℓH : Level} (V : StarAutonomous ℓV ℓH)
         (FP : HasFiniteProducts V)
         {ℓE ℓR : Level} (P₀ : StarAutonomous.Ob V) where

  open StarAutonomous V
  open FiniteProductAPI V FP

  private
    P : FiniteFramePresheaf AB V {ℓE} {ℓR}
    P = event-product-presheaf AB V FP P₀

  open FiniteFramePresheaf P

  private
    -- Abbreviations.
    cf : FiniteFrame AB ℓE ℓR → ℕ
    cf = FiniteFrame.event-count

    en : (F : FiniteFrame AB ℓE ℓR)
       → LocalFrame.Event (FiniteFrame.frame F) ≃ Fin (cf F)
    en = FiniteFrame.enum

    ev : {F G : LocalFrame AB ℓE ℓR}
       → FrameHom AB F G → LocalFrame.Event F → LocalFrame.Event G
    ev = FrameHom.event-map

    pr : (n : ℕ) → Fin n → Hom (bigProduct n (λ _ → P₀)) P₀
    pr n i = bigπ n (λ _ → P₀) i

    -- Projecting a restriction onto a component: the workhorse. It
    -- holds definitionally that `restrict F G φ = bigTuple … (λ k → pr …
    -- (reindex … k))`, so `bigβ` reads the j-th component back.
    proj-restrict :
        (F G : FiniteFrame AB ℓE ℓR)
        (φ : FrameHom AB (FiniteFrame.frame G) (FiniteFrame.frame F))
        (j : Fin (cf G))
      → pr (cf G) j ∘ restrict F G φ
        ≡ pr (cf F) (equivFun (en F) (ev φ (invEq (en G) j)))
    proj-restrict F G φ j =
      bigβ (cf G) (λ _ → P₀)
           (λ k → bigπ (cf F) (λ _ → P₀)
                     (equivFun (en F) (ev φ (invEq (en G) k)))) j

  ----------------------------------------------------------------------
  -- Separatedness.
  ----------------------------------------------------------------------

  event-product-separated : {ℓI : Level} → IsSeparated AB V {ℓE} {ℓR} {ℓI} P
  event-product-separated {ℓI} = record { cover-jointly-monic = sep }
    where
      sep :
        {F : FiniteFrame AB ℓE ℓR}
        (c : FiniteCover AB ℓI F)
        {X : Ob}
        (x y : Hom X (value F))
        → ((i : FiniteCover.Index c)
            → restrict F (FiniteCover.patch c i) (FiniteCover.embed c i) ∘ x
              ≡ restrict F (FiniteCover.patch c i) (FiniteCover.embed c i) ∘ y)
        → x ≡ y
      sep {F} c {X} x y hyp =
        bigProduct-ext (cf F) (λ _ → P₀) x y per-e
        where
          open FiniteCover c using (patch ; embed ; event-covered)
          per-e : (e : Fin (cf F)) → pr (cf F) e ∘ x ≡ pr (cf F) e ∘ y
          per-e e =
              cong (λ z → pr (cf F) z ∘ x) (sym path-e)
            ∙ cong (_∘ x) (sym (proj-restrict F (patch i) (embed i) eᵢ))
            ∙ ∘-assoc (pr (cf (patch i)) eᵢ) (restrict F (patch i) (embed i)) x
            ∙ cong (pr (cf (patch i)) eᵢ ∘_) (hyp i)
            ∙ sym (∘-assoc (pr (cf (patch i)) eᵢ) (restrict F (patch i) (embed i)) y)
            ∙ cong (_∘ y) (proj-restrict F (patch i) (embed i) eᵢ)
            ∙ cong (λ z → pr (cf F) z ∘ y) path-e
            where
              ec = event-covered (invEq (en F) e)
              i  = fst ec
              ẽ  = fst (snd ec)
              p  = snd (snd ec)   -- ev (embed i) ẽ ≡ invEq (en F) e
              eᵢ = equivFun (en (patch i)) ẽ
              path-e : equivFun (en F) (ev (embed i) (invEq (en (patch i)) eᵢ)) ≡ e
              path-e =
                  cong (λ w → equivFun (en F) (ev (embed i) w)) (retEq (en (patch i)) ẽ)
                ∙ cong (equivFun (en F)) p
                ∙ secEq (en F) e

  ----------------------------------------------------------------------
  -- Amalgamation.
  ----------------------------------------------------------------------

  event-product-amalgamation : {ℓI : Level} → HasAmalgamation AB V {ℓE} {ℓR} {ℓI} P
  event-product-amalgamation {ℓI} = record { amalgamate = amal }
    where
      amal :
        {F : FiniteFrame AB ℓE ℓR}
        (c : FiniteCover AB ℓI F)
        {X : Ob}
        (m : MatchingFamily AB V P c X)
        → Σ[ s ∈ Hom X (value F) ]
            ((i : FiniteCover.Index c)
              → restrict F (FiniteCover.patch c i) (FiniteCover.embed c i) ∘ s
                ≡ MatchingFamily.part m i)
      amal {F} c {X} m = s , s-restricts
        where
          open FiniteCover c
            using (Index ; patch ; embed ; event-covered ; overlap-frame)
          open MatchingFamily m using (part ; compatible)

          -- The value at an F-event, taken from a witnessing patch.
          component : (e : Fin (cf F)) → Hom X P₀
          component e = pr (cf (patch iₑ)) (equivFun (en (patch iₑ)) ẽₑ) ∘ part iₑ
            where
              ecₑ = event-covered (invEq (en F) e)
              iₑ  = fst ecₑ
              ẽₑ  = fst (snd ecₑ)

          s : Hom X (value F)
          s = bigTuple (cf F) (λ _ → P₀) component

          s-restricts :
            (i : Index)
            → restrict F (patch i) (embed i) ∘ s ≡ part i
          s-restricts i =
            bigProduct-ext (cf (patch i)) (λ _ → P₀)
              (restrict F (patch i) (embed i) ∘ s) (part i) per-j
            where
              per-j :
                (j : Fin (cf (patch i)))
                → pr (cf (patch i)) j ∘ (restrict F (patch i) (embed i) ∘ s)
                  ≡ pr (cf (patch i)) j ∘ part i
              per-j j =
                  -- LHS-goal ≡ component w
                    sym (∘-assoc (pr (cf (patch i)) j) (restrict F (patch i) (embed i)) s)
                  ∙ cong (_∘ s) (proj-restrict F (patch i) (embed i) j)
                  ∙ bigβ (cf F) (λ _ → P₀) component w
                  -- component w ≡ pr oᵢ ∘ LHS-C
                  ∙ sym B-rev
                  -- pr oᵢ ∘ LHS-C ≡ pr oᵢ ∘ RHS-C
                  ∙ cong (pr (cf (overlap-frame iw i)) oᵢ ∘_) (compatible iw i)
                  -- pr oᵢ ∘ RHS-C ≡ RHS-goal
                  ∙ C-deriv
                where
                  -- The F-event named by patch-i's event j.
                  w : Fin (cf F)
                  w = equivFun (en F) (ev (embed i) (invEq (en (patch i)) j))

                  -- A patch witnessing that F-event, from `component`'s
                  -- `event-covered` call at `invEq (en F) w`.
                  ecw = event-covered (invEq (en F) w)
                  iw  = fst ecw
                  ẽw  = fst (snd ecw)
                  pw  = snd (snd ecw)   -- ev (embed iw) ẽw ≡ invEq (en F) w

                  -- The shared overlap event (patch iw side, patch i side).
                  agree : ev (embed iw) ẽw ≡ ev (embed i) (invEq (en (patch i)) j)
                  agree = pw ∙ retEq (en F) (ev (embed i) (invEq (en (patch i)) j))

                  o : LocalFrame.Event (frame-pullback AB (embed iw) (embed i))
                  o = ẽw , invEq (en (patch i)) j , agree

                  oᵢ : Fin (cf (overlap-frame iw i))
                  oᵢ = equivFun (FiniteFrame.enum (overlap-frame iw i)) o

                  -- pr oᵢ ∘ (restrict (pb-π₁) ∘ part iw) ≡ component w
                  B-rev :
                    pr (cf (overlap-frame iw i)) oᵢ
                      ∘ (restrict (patch iw) (overlap-frame iw i)
                                  (pb-π₁ AB (embed iw) (embed i)) ∘ part iw)
                    ≡ component w
                  B-rev =
                      sym (∘-assoc (pr (cf (overlap-frame iw i)) oᵢ)
                                   (restrict (patch iw) (overlap-frame iw i)
                                             (pb-π₁ AB (embed iw) (embed i)))
                                   (part iw))
                    ∙ cong (_∘ part iw)
                           (proj-restrict (patch iw) (overlap-frame iw i)
                                          (pb-π₁ AB (embed iw) (embed i)) oᵢ)
                    ∙ cong (λ z → pr (cf (patch iw)) z ∘ part iw)
                           (cong (λ z → equivFun (en (patch iw))
                                          (ev (pb-π₁ AB (embed iw) (embed i)) z))
                                 (retEq (FiniteFrame.enum (overlap-frame iw i)) o))

                  -- pr oᵢ ∘ (restrict (pb-π₂) ∘ part i) ≡ RHS-goal
                  C-deriv :
                    pr (cf (overlap-frame iw i)) oᵢ
                      ∘ (restrict (patch i) (overlap-frame iw i)
                                  (pb-π₂ AB (embed iw) (embed i)) ∘ part i)
                    ≡ pr (cf (patch i)) j ∘ part i
                  C-deriv =
                      sym (∘-assoc (pr (cf (overlap-frame iw i)) oᵢ)
                                   (restrict (patch i) (overlap-frame iw i)
                                             (pb-π₂ AB (embed iw) (embed i)))
                                   (part i))
                    ∙ cong (_∘ part i)
                           (proj-restrict (patch i) (overlap-frame iw i)
                                          (pb-π₂ AB (embed iw) (embed i)) oᵢ)
                    ∙ cong (λ z → pr (cf (patch i)) z ∘ part i)
                           ( cong (λ z → equivFun (en (patch i))
                                          (ev (pb-π₂ AB (embed iw) (embed i)) z))
                                  (retEq (FiniteFrame.enum (overlap-frame iw i)) o)
                           ∙ secEq (en (patch i)) j )

  ----------------------------------------------------------------------
  -- The witness.
  ----------------------------------------------------------------------

  event-product-sheaf : {ℓI : Level} → IsSheaf AB V {ℓE} {ℓR} {ℓI} P
  event-product-sheaf = record
    { separated    = event-product-separated
    ; amalgamating = event-product-amalgamation
    }
