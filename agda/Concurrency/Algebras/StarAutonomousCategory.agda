{-# OPTIONS --cubical --guardedness #-}

-- Adapter: the underlying 1-category of a `StarAutonomous` value
-- category, presented as a `Cubical.Categories.Category.Category`.
--
-- Why this exists. The sheaf-category program (the V-valued linear
-- sheaf category `Sh_fin(site, V)`, then later the cartesian locality
-- side and the R4 Benton bridge) is deliberately built inside the
-- cubical-library category ecosystem (`Category`, `Functor`,
-- `NaturalTransformation`, `FullSubcategory`, `Adjoint`), because the
-- forward path — R4 and then the cross-site `Allow ⊣ Require` — is
-- adjunction-heavy and should not be re-implemented outside that
-- ecosystem. This file is the first, smallest brick: it turns the
-- hand-rolled `StarAutonomous` signature (whose underlying category is
-- spelled with the *applicative* composition `_∘_`, `g ∘ f` = "f then
-- g") into a library `Category` (whose primitive is the *diagrammatic*
-- composition `_⋆_`, `f ⋆ g` = "f then g").
--
-- The convention flip lives here and nowhere else. The single equation
-- is `f ⋆ g = g ∘ f`. Every downstream file that needs the value
-- category as a library object goes through this adapter, so the
-- `_⋆_` / `_∘_` direction is converted exactly once; downstream code
-- must not re-derive it. The library `Category` also *re-derives* an
-- applicative `_∘_` (as `g ∘ f = f ⋆ g`), which by construction agrees
-- with `StarAutonomous`'s own `_∘_`.
--
-- Scope guardrails: this is the bare underlying 1-category only. The
-- monoidal / `*`-autonomous structure of `V` (⊗, ⅋, _^⊥, units) is NOT
-- transported to a library `Monoidal`/`StarAutonomous`-category here;
-- that enrichment (Fork B in the workflow discussion) is interface-
-- first and deferred. Only `Ob`, `Hom`, `id`, composition, the unit /
-- associativity laws, and `isSetHom` cross over.

module Concurrency.Algebras.StarAutonomousCategory where

open import Cubical.Foundations.Prelude
open import Cubical.Categories.Category.Base using (Category)

open import Concurrency.Algebras.StarAutonomous using (StarAutonomous)

module _ {ℓ ℓ' : Level} (V : StarAutonomous ℓ ℓ') where

  open StarAutonomous V

  -- The underlying 1-category of `V`, as a library `Category`.
  -- Diagrammatic `_⋆_` is defined by the single convention flip
  -- `f ⋆ g = g ∘ f`; the unit and associativity laws are then exactly
  -- `V`'s own laws read in the other direction.
  StarAutonomous→Category : Category ℓ ℓ'
  StarAutonomous→Category = record
    { ob       = Ob
    ; Hom[_,_] = Hom
    ; id       = id
    ; _⋆_      = λ f g → g ∘ f
    ; ⋆IdL     = λ f → id-r f          -- id ⋆ f = f ∘ id ≡ f
    ; ⋆IdR     = λ f → id-l f          -- f ⋆ id = id ∘ f ≡ f
    ; ⋆Assoc   = λ f g h → sym (∘-assoc h g f)
                                        -- (f⋆g)⋆h = h∘(g∘f) ≡ (h∘g)∘f = f⋆(g⋆h)
    ; isSetHom = Hom-set
    }
