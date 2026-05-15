# Code connections — workflow concept ↔ Agda

For each load-bearing workflow concept, the Agda file/line where it is realised, mentioned, or constrained. Snippets are quoted verbatim with surrounding line numbers so the connection is visible.

Conventions:
- `file.agda:N` means line N in the file
- "header" means the top comment block of a file (before the `module` declaration)
- snippets are trimmed; ellipses are explicit

---

## 1. "Site is Bℤ" (semantic background)

**Workflow homes:**
- `CLAUDE.md:5-7` — Project Goal §; "The site for the ∞-topos is **Bℤ**"
- `workflow/status.md:13` — "**The site is Bℤ — the delooping of ℤ.** ... It does not appear as an Agda object"
- `workflow/motivation.md` — proto-conjecture only; site choice deferred
- `workflow/conversation.md:10` — rejects "site is S¹"
- `workflow/conversation.md:30, 34` — instigator prompts converging on Bℤ
- `workflow/memory/b_side_site_icosahedral.md` — B-side companion (A-side site is Bℤ; B-side is icosahedral S²)

**Agda anchor:** the synthetic side never names the site. Only the analytic side gives it a concrete witness.

`agda/ModalHoTT/Modalities/Cohesion.agda:4-8`
```agda
-- Semantic background: the cohesive ∞-topos is modelled by the site Bℤ
-- (delooping of ℤ ≃ S¹ as ∞-groupoids, but foregrounding the algebraic/
-- covering structure of ℤ). The site is not an Agda type; the modalities
-- are axiomatic, justified by the Bℤ semantics.
```

`agda/Analytic/ModalHoTT/Modalities/Cohesion.agda:42-50` — concretisation of Bℤ
```agda
-- DeloopingOfIntegers (Bℤ)
data DeloopingOfIntegers : Type₀ where
  base-pt          : DeloopingOfIntegers
  translation-step : base-pt ≡ base-pt
```

`agda/Analytic/ModalHoTT/Modalities/Cohesion.agda:124-125` — `Ω(Bℤ) ≃ ℤ` realised
```agda
loop-space-equiv : (base-pt ≡ base-pt) ≃ ℤ
loop-space-equiv = isoToEquiv loop-space-Iso
```

---

## 2. The three cohesion modalities (♭ / ♯ / ʃ)

**Workflow homes:**
- `naming.md` — keeps/forgets table
- `arc.md:39-44` — adjunction data (η, ε, triangles)
- `targets.md:11-22` (T1) — adjoint formulation
- `memory/feedback_precision_on_cubical.md` — what "synthetic" means in the modality definitions

**Agda anchors (synthetic = postulates):**

`Cohesion.agda:29-50` — Flat modality block: `FlatModality`, `flat-counit`, `flat-intro`, `flat-ind`, `flat-ind-β`, `flat-counit-intro`. Note `:36-38` flags the crisp-context shortcut for `flat-intro`.
```agda
-- [−] : A → ♭A  (crisp introduction; in real-cohesive HoTT this is only
-- valid when the input is in a crisp context; postulated unconditionally
-- here because Agda lacks native crisp-context support)
flat-intro : {A : Type ℓ} → A → FlatModality A
```

`Cohesion.agda:63-83` — Shape: `ShapeModality`, `shape-unit`, `shape-rec`, `shape-rec-β`
`Cohesion.agda:92-111` — Sharp: `SharpModality`, `sharp-unit`, `sharp-rec`, `sharp-rec-β`
`Cohesion.agda:53-54, :70-71, :99-100` — the three `IsXModal` predicates as `isEquiv (unit/counit)`

---

## 3. The two adjunctions (♭ ⊣ ♯, ʃ ⊣ ♭)

**Workflow homes:**
- `arc.md:23` — `Allow ⊣ Mediate ⊣ Require` (the arc-level naming)
- `targets.md:11-22` (T1) — model on cohesion's `ʃ ⊣ ♭ ⊣ ♯`
- `status.md:40` (Decisions Log) — "Adjunctions stated as hom-set equivalences (`≃`), named operations defined from them"
- `status.md:47-48` — diagnostic finding: type-level adjunction at `(Bℤ, Bℤ)` fails

**Agda anchors:**

`Adjunctions.agda:38-44` — postulates for `flat-sharp-transpose` + coherence `flat-sharp-counit-compat`
`Adjunctions.agda:69-75` — postulates for `shape-flat-transpose` + coherence `shape-flat-adj-unit-eq`
`Adjunctions.agda:100-110` — `flat-modality-idempotent` proved via `flat-ind` + `flat-counit-intro`
`Adjunctions.agda:115-121` — `sharp-modality-idempotent` and `shape-modality-idempotent` **postulated**

`Analytic/.../Adjunctions.agda` — entire 171-line file is the "why the type-level adjunction fails at Bℤ" diagnosis. Key witnesses:
- `:120-121` — ℤ instance (trivial)
- `:144-149` — `maps-to-int-const` private lemma
- `:157-162` — `maps-into-integers : (Bℤ → ℤ) ≃ ℤ`

---

## 4. `¬-IsFlatModal-delooping` (the analytic centrepiece)

**Workflow homes:**
- `status.md:21` — "The centrepiece result is `¬-IsFlatModal-delooping`"
- `status.md:46` (Decisions Log) — "key result is ¬IsFlatModal-delooping"
- `status.md:108` (Completed) — same
- `memory/analytic_strategy.md:16` — "the centrepiece result"
- `rug.md:8-9` — used to argue `flat-intro` is over-strong

**Agda anchor:** `agda/Analytic/ModalHoTT/Modalities/Cohesion.agda:234-242`
```agda
¬-IsFlatModal-delooping : isEquiv flat-counit-delooping → ⊥
¬-IsFlatModal-delooping isE =
  let fiber-contr : isContr (fiber flat-counit-delooping base-pt)
      fiber-contr = equiv-proof isE base-pt
      eq : (pos 0 , refl) ≡ (pos 1 , refl {x = base-pt})
      eq = isContr→isProp fiber-contr _ _
      path : pos 0 ≡ pos 1
      path = cong fst eq
  in subst posZero? path zero
```

---

## 5. The fracture theorem (T7 backbone)

**Workflow homes:**
- `status.md:5` — "the fracture theorem ... [is] T7"
- `status.md:112-113` (Completed) — synthetic + analytic ℤ
- `rug.md:5-20` "Regarding fracture" + Verdict — the postulate budget for fracture
- `targets.md:110-122` (T7) — claim and verification scope
- `arc.md:57-65` (§6) — the math fragment that fracture instantiates

**Agda anchors:**

`Fracture.agda:69-72` — `FracturePullback` as inline Σ Σ ≡
`Fracture.agda:84-86` — `fracture-square-commutes` (derived via `flat-counit-natural`)
`Fracture.agda:98-100` — `flat-to-pullback` (the canonical map)
`Fracture.agda:109-110` — the one new postulate
```agda
postulate
  fracture : (A : Type ℓ) → isEquiv (flat-to-pullback A)
```
`Fracture.agda:18-26` (header) — explicit cross-ref to `flat-intro` crisp-context note in Cohesion.agda; explicit cross-ref to status.md Open Questions for the ♯-lex meta-axiom that would discharge this

**Analytic mirror:** `Analytic/.../Fracture.agda:54-78`
```agda
flat-to-pullback-integers : FlatOfIntegers → FracturePullbackIntegers
flat-to-pullback-integers n = n , n , refl

private
  fracture-Iso-integers : Iso FlatOfIntegers FracturePullbackIntegers
  Iso.fun fracture-Iso-integers = flat-to-pullback-integers
  Iso.inv fracture-Iso-integers = fst
  Iso.sec fracture-Iso-integers x i =
    fst x , isContrSingl (fst x) .snd (snd x) i
  Iso.ret fracture-Iso-integers _ = refl

IsFracture-integers : isEquiv flat-to-pullback-integers
IsFracture-integers = isoToEquiv fracture-Iso-integers .snd
```

Header `Analytic/.../Fracture.agda:18-24` notes the Bℤ exclusion (♯(Bℤ) undefined).

---

## 6. The de Rham depth ladder (current arc target)

**Workflow homes:**
- `rug.md:24-42` "Beyond fracture: the differential-cohesion gap" — canonical taxonomy
- `memory/de_rham_depth_ladder.md` — names and rationale ("depth" not "content")
- `status.md:65-70` Current Task + Next step
- `status.md:135-148` Discussion of the next step
- `CLAUDE.md:5-9` Current Phase

**Agda anchor:** `agda/ModalHoTT/Cohomology/FlatCoefficients.agda:5-27` (file header)
```agda
-- The "de Rham depth" ladder names three levels of the de Rham / separation
-- arc, distinguished by what each level adds on top of the previous one:
--
--   structural        — only the existing ʃ ⊣ ♭ adjunction; no new postulates.
--                       The separation result is real but carries no geometric
--                       content beyond modal algebra. *This file.*
--
--   named-coefficient — adds a postulated cohesive type ℝ and instantiates
--                       at ♭ℝ. The statement names reals but is tautological:
--                       de Rham cohomology *is* flat-ℝ cohomology by
--                       definition. (Future file.)
--
--   differential      — adds the differential-cohesion modalities (the
--                       triple ℜ ⊣ ℑ ⊣ &) and identifies differential forms
--                       as ℑX → ♭ℝ. The de Rham theorem then becomes
--                       content-bearing: forms compute flat-ℝ cohomology.
```

---

## 7. The structural pinning result (most recent commit, `91d468e` / `57325bb`)

**Workflow homes:**
- `status.md:51` Decisions Log — naturality-in-B is the pinning route
- `status.md:114` Completed — "Pinning has landed (`flat-coefficients-factor-pin`)"
- `status.md:137-148` rationale

**Agda anchors:**

`Properties.agda:97-100` — the load-bearing postulate
```agda
postulate
  shape-flat-natural-B : {A : Type ℓ} {B : Type ℓ'} {B' : Type ℓ''}
    (g : B → B') (h : ShapeModality A → B)
    → shape-to-flat (g ∘ h) ≡ flat-map g ∘ shape-to-flat h
```

`FlatCoefficients.agda:70-84` — `flat-coefficients-factor`
`FlatCoefficients.agda:105-112` — `flat-coefficients-factor-pin` (the result; four-step chain)
```agda
flat-coefficients-factor-pin : {A : Type ℓ} {B : Type ℓ'}
  (Bm : IsFlatModal B)
  → equivFun (flat-coefficients-factor {A = A} Bm) ≡ λ f → f ∘ shape-unit
flat-coefficients-factor-pin {A = A} {B = B} Bm = funExt λ f → funExt λ a →
    cong (λ h → flat-counit (h a)) (shape-flat-natural-B f (λ u → u))
  ∙ cong (λ h → flat-counit (flat-map f (h a))) shape-flat-adj-unit-eq
  ∙ flat-counit-natural f (flat-intro (shape-unit a))
  ∙ cong f (flat-counit-intro (shape-unit a))
```

---

## 8. The `Discrete.agda` deferral

**Workflow homes:**
- `status.md:51` Decisions Log — bridge "drafted as a deferred reserve, not load-bearing"
- `status.md:58` Open Questions — bridge entry
- `status.md:115` Completed — "drafted but **deferred — not imported anywhere**"
- `rug.md` — does not flag this specifically; covered by general ♯/ʃ idempotency note

**Agda anchor:** `agda/ModalHoTT/Modalities/Discrete.agda:3-12` (top of file)
```agda
-- Status (2026-05-14): DRAFTED, NOT YET USED.
--
-- The bridge was originally queued to support pinning the structural
-- de Rham map in Cohomology/FlatCoefficients.agda. On working through
-- the pinning derivation, naturality of `shape-flat-transpose` in B
-- turned out to be the load-bearing piece, not the bridge ...
```

Postulates `:61-68` are the two directions of `IsFlatModal A ↔ IsShapeModal A`.

---

## 9. Postulate-over-record feedback realised in Properties.agda

**Workflow home:** `memory/feedback_postulates_over_records.md`

**Agda anchor:** the four laws sit as flat postulates, not a record.

`Properties.agda:120-126`
```agda
postulate
  shape-map-id : {A : Type ℓ} (u : ShapeModality A)
    → shape-map (λ a → a) u ≡ u

  shape-map-comp : {A : Type ℓ} {B : Type ℓ'} {C : Type ℓ''}
    (f : A → B) (g : B → C) (u : ShapeModality A)
    → shape-map (g ∘ f) u ≡ shape-map g (shape-map f u)
```
`Properties.agda:142-148` — same for sharp.

---

## 10. Independent-legs-then-bridge feedback realised in folder layout

**Workflow home:** `memory/feedback_independent_legs_then_bridge.md`

**Agda anchor:** the two top-level subdirectories are physically separate. `agda/ModalHoTT/` (A) and `agda/Concurrency/` (B) share no imports. The bridge file foreseen by T1 has *not* been created.

```
agda/
  ModalHoTT/           (A — synthetic + analytic both populated)
  Concurrency/         (B — empty, see duplication_audit.md §3)
  Analytic/Concurrency/(empty mirror)
  AnalyticTest/        (deferred differential-cohesion track, README only)
```

---

## 11. Workflow conventions ↔ Agda surface

| Convention (CLAUDE.md or memory) | Surface in code |
|---|---|
| "Long names over notation" (`CLAUDE.md:31`, Decisions Log `:36`) | `DeloopingOfIntegers`, `FlatModality`, `IsFlatModal`, `flat-counit-intro` (no Unicode-only identifiers). |
| Mirror folder structure (`feedback_analytic_folder_structure.md`) | Every `ModalHoTT/Modalities/X.agda` has `Analytic/ModalHoTT/Modalities/X.agda`. No `Types/` subdirectory (the proposed `Types/DeloopingOfIntegers.agda` was rejected; HIT is folded into `Cohesion.agda`). |
| All files use `--cubical` (`CLAUDE.md:53`) | Every `.agda` opens with `{-# OPTIONS --cubical --guardedness #-}`. |
| `--safe` dropped (Decisions Log `:39`) | `postulate` blocks present (Cohesion.agda, Adjunctions.agda, Properties.agda, Fracture.agda, Discrete.agda); `--safe` would forbid them. |
| Decisions Log split Relevant / Archived | Realised in `status.md:27-51` (Relevant, 12 rows) vs `:117-133` (Archived, 9 rows). |
