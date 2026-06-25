{-# OPTIONS --cubical --guardedness #-}

-- The finite-frame subsite, packaged as a library
-- `Cubical.Categories.Category.Category`.
--
-- Objects are `FiniteFrame`s (a `LocalFrame` plus a chosen event count
-- and enumeration, per `Concurrency/Sites/FiniteFrame.agda`); morphisms
-- are `FrameHom`s between the underlying frames — finiteness and the
-- enumeration are extra structure on objects, not a constraint on
-- morphisms (the rationale recorded in `FiniteFrame.agda`). This is the
-- "downstream `FrameCategory` packaging" that `ActorCausal.agda`'s
-- composition-laws comment anticipates: identity is `frame-id`,
-- composition is `_∘ᶠ_`, and the unit / associativity laws are the
-- `refl`-level `frame-id-l` / `frame-id-r` / `∘ᶠ-assoc` already proved
-- there.
--
-- `_⋆_` is diagrammatic. A library `Category` composes left-to-right
-- (`f ⋆ g` = "f then g"), whereas `_∘ᶠ_` composes applicatively
-- (`ψ ∘ᶠ φ` = "φ then ψ"). The flip lives in `_⋆_ f g = g ∘ᶠ f` and
-- nowhere else, mirroring the single convention flip in
-- `Concurrency/Algebras/StarAutonomousCategory.agda`.
--
-- The one piece of real work is `isSetHom`. `FrameHom`'s `event-map`
-- lands in `Event`, a set (`Event-set`, inherited from `CausalOrder`),
-- and its four other fields are valued in propositions (`ActorIn-isProp`,
-- `touches-isProp`, `≤-isProp`). So `FrameHom F G` is isomorphic to a
-- Σ of a function-into-a-set with a proposition, hence a set. The
-- `event-map`-controlled path lemma needed for this is exactly
-- `ActorPullback.FrameHom≡`, but that lemma lives in the *pullback*
-- module; to keep `FiniteFrameCategory` from inheriting a conceptual
-- dependency on pullbacks, the isSet argument is done locally here via
-- a Σ-isomorphism (using only `ActorBase` / `ActorCausal`). Notably the
-- proof does not use finiteness at all — `isSetFrameHom` holds for any
-- two `LocalFrame`s — so it would transplant unchanged to a full
-- (non-finite) frame category.
--
-- Scope guardrails: only `ActorBase` / `ActorCausal` / `FiniteFrame`
-- and the library `Category`. No value category, no presheaves, no
-- pullbacks, no operad / session content.

module Concurrency.Sites.FiniteFrameCategory where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.HLevels
  using ( isSetΠ ; isPropImplicitΠ ; isPropΠ ; isProp× ; isSetΣ
        ; isOfHLevelRetractFromIso )
open import Cubical.Foundations.Isomorphism
  using ( Iso ; iso )
open import Cubical.Data.Sigma using ( Σ-syntax ; _,_ )

open import Cubical.Categories.Category.Base using (Category)

open import Concurrency.Sites.ActorBase using (ActorBase)
open import Concurrency.Sites.ActorCausal
  using ( LocalFrame ; FrameHom ; frame-id ; _∘ᶠ_ ; frame-id-l ; frame-id-r )
open import Concurrency.Sites.FiniteFrame using (FiniteFrame)

module _ {ℓA : Level} (AB : ActorBase ℓA) where

  open ActorBase AB using (Actor)

  ----------------------------------------------------------------------
  -- isSet (FrameHom F G), for arbitrary local frames.
  --
  -- Via a Σ-isomorphism: a `FrameHom` is an `event-map` (a function
  -- into the set `G.Event`) bundled with four propositional fields.
  ----------------------------------------------------------------------

  module _ {ℓE₁ ℓR₁ ℓE₂ ℓR₂ : Level}
           (F : LocalFrame AB ℓE₁ ℓR₁) (G : LocalFrame AB ℓE₂ ℓR₂) where

    private
      module F = LocalFrame F
      module G = LocalFrame G

      -- The Σ-unfolding of the `FrameHom` record. `event-map` comes
      -- first so the three event-dependent props can refer to it.
      FrameHomΣ : Type (ℓ-max ℓA (ℓ-max ℓE₁ (ℓ-max ℓR₁ (ℓ-max ℓE₂ ℓR₂))))
      FrameHomΣ =
        Σ[ em ∈ (F.Event → G.Event) ]
        Σ[ _  ∈ ({a : Actor} → F.ActorIn a → G.ActorIn a) ]
        Σ[ _  ∈ ({e : F.Event} {a : Actor} → F.touches e a → G.touches (em e) a) ]
        Σ[ _  ∈ ({e e' : F.Event} → e F.≤ e' → em e G.≤ em e') ]
          ({e e' : F.Event} → em e G.≤ em e' → e F.≤ e')

      FrameHom-Iso : Iso (FrameHom AB F G) FrameHomΣ
      FrameHom-Iso = iso to from (λ _ → refl) (λ _ → refl)
        where
          to : FrameHom AB F G → FrameHomΣ
          to φ = FrameHom.event-map φ
               , FrameHom.actor-pres φ
               , FrameHom.touches-pres φ
               , FrameHom.causal-pres φ
               , FrameHom.causal-refl φ
          from : FrameHomΣ → FrameHom AB F G
          from (em , ap , tp , cp , cr) = record
            { actor-pres   = ap
            ; event-map    = em
            ; touches-pres = tp
            ; causal-pres  = cp
            ; causal-refl  = cr
            }

      isSetFrameHomΣ : isSet FrameHomΣ
      isSetFrameHomΣ =
        isSetΣ (isSetΠ (λ _ → G.Event-set))
          (λ em → isProp→isSet
            (isProp× (isPropImplicitΠ (λ a → isPropΠ (λ _ → G.ActorIn-isProp a)))
              (isProp× (isPropImplicitΠ (λ e → isPropImplicitΠ (λ a →
                          isPropΠ (λ _ → G.touches-isProp (em e) a))))
                (isProp× (isPropImplicitΠ (λ e → isPropImplicitΠ (λ e' →
                            isPropΠ (λ _ → G.≤-isProp))))
                  (isPropImplicitΠ (λ e → isPropImplicitΠ (λ e' →
                            isPropΠ (λ _ → F.≤-isProp))))))))

    isSetFrameHom : isSet (FrameHom AB F G)
    isSetFrameHom = isOfHLevelRetractFromIso 2 FrameHom-Iso isSetFrameHomΣ

  ----------------------------------------------------------------------
  -- The finite-frame category at a fixed event / relation level.
  ----------------------------------------------------------------------

  FiniteFrameCategory : (ℓE ℓR : Level)
    → Category (ℓ-suc (ℓ-max ℓA (ℓ-max ℓE ℓR))) (ℓ-max ℓA (ℓ-max ℓE ℓR))
  FiniteFrameCategory ℓE ℓR = record
    { ob       = FiniteFrame AB ℓE ℓR
    ; Hom[_,_] = λ F G → FrameHom AB (FiniteFrame.frame F) (FiniteFrame.frame G)
    ; id       = λ {F} → frame-id AB (FiniteFrame.frame F)
    ; _⋆_      = λ f g → _∘ᶠ_ AB g f
    ; ⋆IdL     = λ f → frame-id-r AB f       -- id ⋆ f = f ∘ᶠ frame-id ≡ f
    ; ⋆IdR     = λ f → frame-id-l AB f       -- f ⋆ id = frame-id ∘ᶠ f ≡ f
    ; ⋆Assoc   = λ f g h → refl              -- ∘ᶠ associative definitionally
    ; isSetHom = λ {F} {G} →
        isSetFrameHom (FiniteFrame.frame F) (FiniteFrame.frame G)
    }
