{-# OPTIONS --cubical --guardedness #-}

-- Pullbacks (intersections) of actor-local sub-view frames.
--
-- This file equips the actor-causal frame category from
-- `Concurrency/Sites/ActorCausal.agda` with the one piece it was
-- explicitly missing: pullbacks of `FrameHom`s. Per that file's header
-- (lines around `stability-cover`): "pullback-of-covers does not have a
-- generic categorical construction in this signature-only setting
-- because we have not equipped FrameCategory with pullbacks." This file
-- is that equipment.
--
-- Why now. It is the prerequisite the Hybrid descent step needs and did
-- not have. The shipped `IsSeparatedPresheaf` (uniqueness half of
-- descent) quantifies over patches of a cover; the *existence* half
-- (matching families amalgamating to a global section) needs to state
-- compatibility *on overlaps* — and an overlap of two patches `patch i`,
-- `patch j` over `F` is exactly their pullback `patch i ×_F patch j`.
-- `Concurrency/Hybrid/Descent.agda` consumes the pullback *cone*
-- (`frame-pullback`, `pb-π₁`, `pb-π₂`) produced here.
--
-- The construction. Given a cospan `f : A ↪ C`, `g : B ↪ C`, the
-- pullback frame `A ×_C B` has:
--
--   * events  = `Σ[ a ∈ A.Event ] Σ[ b ∈ B.Event ]
--                  (f.event-map a ≡ g.event-map b)` — the fibre product
--                of the two event maps (events of A and B with a common
--                image in C);
--   * order   = the `A`-side order on the first component. Because both
--                legs *reflect* causality (strict sub-view discipline,
--                D1) and the two events share an image in C, this order
--                coincides with the `B`-side order on the second
--                component, which is what makes `pb-π₂` order-preserving
--                and order-reflecting;
--   * actors  = actors present in *both* `A` and `B` (`× `);
--   * touches = incidence holding in *both* views.
--
-- The two projections `pb-π₁ : A ×_C B ↪ A`, `pb-π₂ : A ×_C B ↪ B` are
-- genuine `FrameHom`s (sub-views), and the square commutes
-- (`pb-square`).
--
-- Scope (cone vs. universal property). v1 ships the *cone* — object,
-- the two projections, and the commuting square — because that is all
-- the descent compatibility clause and the stability discharge consume.
-- The full universal property (mediating morphism + uniqueness) is *not*
-- built here; it is a clean follow-on if a later construction needs the
-- pullback to be characterized up to iso. Naming `frame-pullback`
-- (rather than `frame-overlap`) records the intent that this *is* the
-- categorical pullback; the UP is deferred, not denied.
--
-- Stability discharge. As a direct consequence, `stability-cover` (the
-- lone postulated actor-site axiom, `stability-cover-postulate` in
-- `ActorCausal.agda`) is here given a *construction*:
-- `stability-cover-pullback` pulls a cover of `F` back along
-- `g : G ↪ F` by intersecting each patch with `G`. This replaces a
-- postulate with a proof; downstream sites should prefer it.
--
-- Scope guardrails (inherited from the actor site):
--   * No imports of `Sessions.agda`, operad files, or any value /
--     content layer. This is pure locality / site machinery.
--   * No payloads, roles, or message syntax: events stay opaque.
--   * No promotion: `FrameHom`s here are still strict sub-view
--     embeddings; the pullback of sub-views is a sub-view.

module Concurrency.Sites.ActorPullback where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.HLevels
  using ( isSetΣ ; isProp× ; isPropΠ )
open import Cubical.Data.Sigma
  using ( Σ-syntax ; _×_ ; _,_ ; fst ; snd ; ΣPathP )

open import Concurrency.Sites.ActorBase
open import Concurrency.Sites.ActorCausal

------------------------------------------------------------------------
-- Local propositional helpers.
--
-- FrameHom equality is component-wise (cubical record η; see the note
-- in `ActorCausal.agda`). All fields but `event-map` are valued in
-- propositions (actor membership, incidence, and ≤ are all
-- prop-valued), so a path of `event-map`s extends to a path of
-- FrameHoms. `isPropImplicitΠ` is the implicit-argument companion of
-- `isPropΠ`, defined locally to avoid guessing the stdlib name.
------------------------------------------------------------------------

private
  isPropImplicitΠ :
    {ℓ ℓ' : Level} {A : Type ℓ} {B : A → Type ℓ'}
    → ((x : A) → isProp (B x))
    → isProp ({x : A} → B x)
  isPropImplicitΠ h f g = λ i {x} → h x (f {x}) (g {x}) i

module _ {ℓA : Level} (AB : ActorBase ℓA) where
  open ActorBase AB

  ----------------------------------------------------------------------
  -- FrameHom≡: component-wise equality of frame morphisms.
  --
  -- Two `FrameHom`s with equal underlying `event-map`s are equal. The
  -- non-`event-map` fields are PathP-transported along the event-map
  -- path; each is valued in a proposition, so `isProp→PathP` discharges
  -- it. `actor-pres` does not mention `event-map`, so its path is a
  -- constant-family PathP.
  ----------------------------------------------------------------------

  FrameHom≡ :
    {ℓE₁ ℓR₁ ℓE₂ ℓR₂ : Level}
    {F : LocalFrame AB ℓE₁ ℓR₁} {G : LocalFrame AB ℓE₂ ℓR₂}
    (φ ψ : FrameHom AB F G)
    → FrameHom.event-map φ ≡ FrameHom.event-map ψ
    → φ ≡ ψ
  FrameHom≡ {F = F} {G = G} φ ψ p = λ i → record
    { actor-pres   = ap i
    ; event-map    = p i
    ; touches-pres = tp i
    ; causal-pres  = cp i
    ; causal-refl  = cr i
    }
    where
      module MF = LocalFrame F
      module MG = LocalFrame G

      ap : PathP (λ _ → {a : Actor} → MF.ActorIn a → MG.ActorIn a)
                 (FrameHom.actor-pres φ) (FrameHom.actor-pres ψ)
      ap = isProp→PathP
             (λ _ → isPropImplicitΠ (λ a → isPropΠ (λ _ → MG.ActorIn-isProp a)))
             _ _

      tp : PathP (λ i → {e : MF.Event} {a : Actor}
                        → MF.touches e a → MG.touches (p i e) a)
                 (FrameHom.touches-pres φ) (FrameHom.touches-pres ψ)
      tp = isProp→PathP
             (λ i → isPropImplicitΠ (λ e → isPropImplicitΠ (λ a →
                       isPropΠ (λ _ → MG.touches-isProp (p i e) a))))
             _ _

      cp : PathP (λ i → {e e' : MF.Event}
                        → MF._≤_ e e' → MG._≤_ (p i e) (p i e'))
                 (FrameHom.causal-pres φ) (FrameHom.causal-pres ψ)
      cp = isProp→PathP
             (λ i → isPropImplicitΠ (λ e → isPropImplicitΠ (λ e' →
                       isPropΠ (λ _ → MG.≤-isProp))))
             _ _

      cr : PathP (λ i → {e e' : MF.Event}
                        → MG._≤_ (p i e) (p i e') → MF._≤_ e e')
                 (FrameHom.causal-refl φ) (FrameHom.causal-refl ψ)
      cr = isProp→PathP
             (λ i → isPropImplicitΠ (λ e → isPropImplicitΠ (λ e' →
                       isPropΠ (λ _ → MF.≤-isProp))))
             _ _

  ----------------------------------------------------------------------
  -- The pullback cone of a cospan f : A ↪ C, g : B ↪ C.
  ----------------------------------------------------------------------

  module _ {ℓE ℓR : Level}
           {A B C : LocalFrame AB ℓE ℓR}
           (f : FrameHom AB A C) (g : FrameHom AB B C) where

    private
      module MA = LocalFrame A
      module MB = LocalFrame B
      module MC = LocalFrame C
      module Mf = FrameHom f
      module Mg = FrameHom g

      PBEvent : Type ℓE
      PBEvent =
        Σ[ a ∈ MA.Event ] Σ[ b ∈ MB.Event ]
          (Mf.event-map a ≡ Mg.event-map b)

      PBEvent-set : isSet PBEvent
      PBEvent-set =
        isSetΣ MA.Event-set
          (λ _ → isSetΣ MB.Event-set
                   (λ _ → isProp→isSet (MC.Event-set _ _)))

      _≤PB_ : PBEvent → PBEvent → Type ℓR
      x ≤PB y = MA._≤_ (fst x) (fst y)

      ≤PB-antisym : {x y : PBEvent} → x ≤PB y → y ≤PB x → x ≡ y
      ≤PB-antisym {x} {y} x≤y y≤x =
        ΣPathP
          ( a≡a'
          , ΣPathP
              ( b≡b'
              , isProp→PathP (λ i → MC.Event-set _ _)
                  (snd (snd x)) (snd (snd y)) ) )
        where
          a≡a' : fst x ≡ fst y
          a≡a' = MA.≤-antisym x≤y y≤x

          gb≡gb' : Mg.event-map (fst (snd x)) ≡ Mg.event-map (fst (snd y))
          gb≡gb' =
            sym (snd (snd x)) ∙ cong Mf.event-map a≡a' ∙ snd (snd y)

          b≡b' : fst (snd x) ≡ fst (snd y)
          b≡b' = event-map-injective AB g gb≡gb'

    --------------------------------------------------------------------
    -- The pullback frame A ×_C B.
    --------------------------------------------------------------------

    frame-pullback : LocalFrame AB ℓE ℓR
    frame-pullback = record
      { causal = record
          { Event     = PBEvent
          ; Event-set = PBEvent-set
          ; _≤_       = _≤PB_
          ; ≤-refl    = λ x → MA.≤-refl (fst x)
          ; ≤-trans   = MA.≤-trans
          ; ≤-antisym = ≤PB-antisym
          ; ≤-isProp  = MA.≤-isProp
          }
      ; ActorIn        = λ act → MA.ActorIn act × MB.ActorIn act
      ; ActorIn-isProp = λ act → isProp× (MA.ActorIn-isProp act)
                                          (MB.ActorIn-isProp act)
      ; touches        = λ e act → MA.touches (fst e) act
                                 × MB.touches (fst (snd e)) act
      ; touches-isProp = λ e act → isProp× (MA.touches-isProp (fst e) act)
                                            (MB.touches-isProp (fst (snd e)) act)
      ; touches-in-frame = λ { (ta , tb) →
            (MA.touches-in-frame ta , MB.touches-in-frame tb) }
      }

    --------------------------------------------------------------------
    -- The two projections.
    --------------------------------------------------------------------

    pb-π₁ : FrameHom AB frame-pullback A
    pb-π₁ = record
      { actor-pres   = λ x → fst x
      ; event-map    = λ e → fst e
      ; touches-pres = λ t → fst t
      ; causal-pres  = λ p → p
      ; causal-refl  = λ p → p
      }

    pb-π₂ : FrameHom AB frame-pullback B
    pb-π₂ = record
      { actor-pres   = λ x → snd x
      ; event-map    = λ e → fst (snd e)
      ; touches-pres = λ t → snd t
      ; causal-pres  = λ {x} {y} p →
          Mg.causal-refl
            (subst (λ z → MC._≤_ (Mg.event-map (fst (snd x))) z)
                   (snd (snd y))
                   (subst (λ z → MC._≤_ z (Mf.event-map (fst y)))
                          (snd (snd x))
                          (Mf.causal-pres p)))
      ; causal-refl  = λ {x} {y} q →
          Mf.causal-refl
            (subst (λ z → MC._≤_ (Mf.event-map (fst x)) z)
                   (sym (snd (snd y)))
                   (subst (λ z → MC._≤_ z (Mg.event-map (fst (snd y))))
                          (sym (snd (snd x)))
                          (Mg.causal-pres q)))
      }

    --------------------------------------------------------------------
    -- The pullback square commutes: f ∘ pb-π₁ ≡ g ∘ pb-π₂.
    --
    -- Both sides are FrameHoms `frame-pullback ↪ C`; their event-maps
    -- agree pointwise by the third (path) component of each pullback
    -- event, and `FrameHom≡` lifts that to a FrameHom path.
    --------------------------------------------------------------------

    pb-square : _∘ᶠ_ AB f pb-π₁ ≡ _∘ᶠ_ AB g pb-π₂
    pb-square =
      FrameHom≡ (_∘ᶠ_ AB f pb-π₁) (_∘ᶠ_ AB g pb-π₂)
        (funExt (λ e → snd (snd e)))

  ----------------------------------------------------------------------
  -- Stability of covers, by pullback.
  --
  -- Discharges `stability-cover-postulate` from `ActorCausal.agda`:
  -- given `g : G ↪ F` and a cover `c` of `F`, the pulled-back cover of
  -- `G` has, for each index, the intersection of `c`'s patch with `G`,
  -- embedded into `G` by `pb-π₂`. The required factorization square is
  -- exactly the (symmetric) pullback square.
  ----------------------------------------------------------------------

  pullback-cover :
    {ℓE ℓR ℓI : Level} {F G : LocalFrame AB ℓE ℓR}
    (g : FrameHom AB G F) (c : Cover AB ℓI F)
    → Cover AB ℓI G
  pullback-cover {F = F} {G = G} g c = record
    { Index = Cover.Index c
    ; patch = λ i → frame-pullback (Cover.embed c i) g
    ; embed = λ i → pb-π₂ (Cover.embed c i) g
    ; actor-covered = λ {a} aG →
        let aF = FrameHom.actor-pres g aG
            ci = Cover.actor-covered c aF
        in fst ci , (snd ci , aG)
    ; event-covered = λ e →
        let ge = FrameHom.event-map g e
            ce = Cover.event-covered c ge
        in fst ce , (fst (snd ce) , e , snd (snd ce)) , refl
    }

  stability-cover-pullback :
    {ℓE ℓR ℓI : Level} {F G : LocalFrame AB ℓE ℓR}
    (g : FrameHom AB G F) (c : Cover AB ℓI F)
    → Σ[ d ∈ Cover AB ℓI G ]
        ((j : Cover.Index d) →
          Σ[ i ∈ Cover.Index c ]
            Σ[ h ∈ FrameHom AB (Cover.patch d j) (Cover.patch c i) ]
              _∘ᶠ_ AB g (Cover.embed d j) ≡ _∘ᶠ_ AB (Cover.embed c i) h)
  stability-cover-pullback g c =
    pullback-cover g c
    , λ j → j
          , pb-π₁ (Cover.embed c j) g
          , sym (pb-square (Cover.embed c j) g)
