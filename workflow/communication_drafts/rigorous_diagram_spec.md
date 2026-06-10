# Rigorous diagram specification — formal status map for the comparison adjunction

This specification replaces the mixed-audience diagram brief for the mathematics-facing version.
It is a brief for producing a printable A4-landscape diagram as a single self-contained HTML file
with inline SVG and CSS. The output diagram is for mathematicians and mathematically trained
readers; it is not the general-public / interdisciplinary-academic version.

The guiding rule is status honesty: every prominent visual element must say whether it is an
implemented Agda object, a postulate-supported construction, a planned construction, or a
programmatic horizon.

---

## 1. Purpose and audience

The diagram presents the current formal architecture of the project and the proposed comparison
adjunction between its two developed fragments.

Primary audience: mathematicians, category theorists, type theorists, and mathematically trained
readers who expect arrows, adjunction symbols, and boxes to mean something checkable.

The diagram should answer four questions at a glance:

1. What has been formalized in Agda?
2. Which formalized pieces rely on explicit postulates or axiomatic interfaces?
3. What is the proposed comparison adjunction?
4. Which objects are planned or programmatic rather than currently established?

The diagram must not try to be a general explanatory map. It is a formal status map.

---

## 2. Language discipline

Use only three kinds of visible labels:

1. Standard mathematical language: e.g. "cohesive HoTT", "adjunction", "cyclic operad",
   "Grothendieck pretopology", "presheaf", "descent", "*-autonomous category".
2. Project-defined mathematical objects with a checkable code path: e.g. `O₁`, `FramePresheaf`,
   `SessionO1Action`, `Bℤ`.
3. Explicit status labels from the legend.

Do not use internal working phrases on the diagram. In particular, do not use:

- "modal side"
- "concurrency side"
- "Hybrid v1"
- "home cooking"
- "trade-off cascade"
- "easter egg"
- "audience hook"
- "codependency"
- "shipped"
- "world creation"
- "care" / "caregiver" / "cared-for"

Those may appear only in the appendix of this specification as source terms being translated into
formal diagram language.

Diagram-visible mathematical labels must use typographic subscripts where standard: write `O₁`
and `MO₁`, not `O_1` or `MO_1`. Keep ASCII forms only for literal Agda identifiers, filenames,
or code paths, such as `SessionO1Action`.

---

## 3. Output format and technical constraints

- Single self-contained HTML file with inline CSS and inline SVG.
- No JavaScript and no external dependencies.
- A4 landscape target: `297mm × 210mm`.
- CSS page rule: `@page { size: A4 landscape; margin: 0; }`.
- The root diagram container should be exactly `297mm × 210mm`.
- Use millimetres and points, not pixels, for layout dimensions.
- Greyscale survivable: status tags, fill, spacing, and coarse line styles must carry meaning even
  if all color is removed. No distinction may depend only on subtle line-style differences.
- Use a system sans-serif stack for ordinary text and a math-capable serif fallback for formulae.
- No project title on the diagram unless the embedding document supplies it outside the SVG.

Recommended font stacks:

```css
font-family: Inter, "Helvetica Neue", system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
font-family: "STIX Two Math", "Latin Modern Math", Cambria Math, Georgia, serif;
```

---

## 4. Status legend

The legend is mandatory and must be visible on the diagram, preferably in the upper-right corner
or as a compact strip along the bottom margin. It must use these exact status names.

| Status label | Required visual encoding | Meaning |
|---|---|---|
| `Agda definition` | solid border, white fill, visible `AGDA DEFINITION` tag | Defined in the Agda tree without being merely a future placeholder. |
| `Agda, postulate-supported` | solid border plus a 2pt left rule and visible `POSTULATE` tag | Present in Agda but relying on explicit postulates, axiomatic interfaces, or postulate-packaged structure. |
| `Planned construction` | dashed border, white fill, visible `PLANNED` tag | Intended next or medium-term construction, not yet implemented. |
| `Programmatic horizon` | pale grey fill, dashed border, visible `HORIZON` tag | Long-horizon mathematical program or interpretation, not a current construction. |

Arrow legend:

| Arrow style | Meaning |
|---|---|
| solid arrow | implemented dependency, construction, or import relation |
| solid arrow with a small `P` marker at midpoint | dependency through postulate-supported structure or an axiomatic interface |
| dashed arrow | conjectural or planned relation |
| grey dashed arrow | programmatic or interpretive relation |
| thin double-stroke line, no arrowheads | model / diagnostic comparison — **not** a construction, dependency, or import relation |

The double-stroke comparison line is reserved for the relationship between the synthetic development and its analytic diagnostics. It carries no arrowheads (an arrowhead would make it read as a weak dependency), and it must never be drawn as a plain solid arrow, because that would miscategorize a model check as a construction dependency.

The legend should also state:

> The central comparison adjunction is proposed structure. The surrounding boxes are current formal fragments and planned extensions, not a proof that the adjunction has been constructed.

---

## 5. Overall composition

Use three vertical regions plus a lower planned-extension band.

```text
+---------------------------------------------------------------------+
| fragments of 𝓜          | Proposed comparison   | fragments of 𝓟   |
| cohesive HoTT             | adjunction            | actor-causal    |
|                             |                          |                 |
|  implemented / axiomatic    |  Allow ⊣ Require       | implemented /   |
|  formal pieces              |  status: conjectural     | axiomatic pieces|
|                             |                          |                 |
+---------------------------------------------------------------------+
| Further structure not part of the current formalization              |
+---------------------------------------------------------------------+
```

Approximate widths inside the page margins:

- Left region, fragments of `𝓜`: 32%.
- Center region, proposed comparison adjunction: 20%.
- Right region, fragments of `𝓟`: 48%.

The bottom planned-extension band should occupy about 18-22% of the page height. It must be
visually separated from the main formalized-fragment regions.

Within the main upper band, use these vertical proportions:

- region headings: top 8-10% of the upper band;
- formal boxes: middle 78-82% of the upper band;
- local notes or mini-legends inside a region: bottom 8-10% only if needed.

Stack the four `𝓜` fragment boxes (cohesive modalities, fracture square, adjunction iteration, flat-coefficient cohomology) in one column. The analytic diagnostics inset is **not** a `𝓜` fragment box: render it as a small separate inset (see §7.2), visually distinct from the formal-fragment regions, connected to the `𝓜` column only by the double-stroke model-comparison line. In `𝓟`, use two internal columns: one path contains actor-causal pretopology → generic frame-indexed presheaves → session-valued presheaves; the other path contains `O₁`, the session target, and the `O₁`-algebra. The two-internal-column layout in `𝓟` is mandatory, not optional, given the box count. Do not draw a current dependency from the `O₁`-algebra into the presheaf boxes; lifting operadic valuation through presheaves is planned adapter work. The center rail diagram should occupy the upper-middle of the center region, with the conjectural status note and unit/counit box below it. The legend must not overlap the center rail diagram.

Squint test: the page should read as two formal fragments separated by a narrower, visibly conjectural comparison mechanism. The lower band should read as deferred structure, not as a fourth main region. The center should have more white space than either fragment region, so the two adjunction lanes remain unambiguous.

Do not label the left and right regions as "sides". Use the region headings below.

Left region heading:

```text
fragments of 𝓜 — cohesive HoTT
```

Right region heading:

```text
fragments of 𝓟 — actor-causal/session
```

Center region heading:

```text
proposed comparison adjunction
```

---

## 6. Center: proposed comparison adjunction

The center is the mathematical claim-shape, not an implemented module. In the current diagram, draw the load-bearing comparison as an adjoint pair:

```text
Allow ⊣ Require
```

Draw the center as a two-lane rail diagram between two faint vertical rails. The left rail is labelled `𝓜` and the right rail is labelled `𝓟`. Place the rails at roughly 15% and 85% of the center-region width so labels and arrowheads have room.

Use these exact lanes, in this vertical order:

```text
upper lane:   Allow   : 𝓜 → 𝓟     left rail  ─────▶  right rail
lower lane:   Require : 𝓟 → 𝓜     left rail  ◀─────  right rail
```

Set the lane baselines at approximately 40% and 58% of the center claim block. The two arrows should be straight or only very slightly curved; do not use large framing curves. `Allow` and `Require` are anti-parallel in this diagram.

Place the adjunction label `Allow ⊣ Require` as a small brace or bracket label between the two lanes. Under the rail diagram, include this compact status note:

```text
Conjectural comparison adjunction.
The code currently formalizes fragments of 𝓜 and 𝓟, not the functors Allow and Require.
```

Include the unit and counit formulae below the lanes in a small grey `conjectural unit/counit` note box:

```text
η : id_𝓜 ⇒ Require ∘ Allow
ε : Allow ∘ Require ⇒ id_𝓟
```

Do not include a standalone `𝓜 ⇄ 𝓟` glyph anywhere in the center; that glyph is too easy to mistake for the adjunction itself.

Do not draw `Mediate` as a third functor lane. Instead, below the unit/counit box, include a compact **two-candidate box** headed `adjoint shape open`. Keep the visible box short — the full reasoning lives in this spec, not on the diagram. Render exactly:

```text
adjoint shape open — resolution deferred to future mathematics

drawn:     Allow ⊣ Require
           displayed η, ε; matches current arc.md data;
           same pair shape as the generic Iteration.agda scaffold

not drawn: Allow ⊣ Mediate ⊣ Require
           possible refinement; does not supply the displayed
           η : id_𝓜 ⇒ Require∘Allow without extra identifications
```

Spec notes that must inform the rendering but need not all appear in the visible box:

- The generic iteration scaffold (`Iteration.agda`) has the *same pair-adjunction shape* as candidate (a), but is **currently instantiated only at `ʃ ⊣ ♭`** — it does not currently consume the cross-site `Allow ⊣ Require`. The box must not imply otherwise; "same pair shape as the generic scaffold" is the strongest claim the code supports.
- Candidate (b) covers both readings the project has floated for the triple: the between-categories triple (where `Require ∘ Allow` does not even typecheck) and the modalities-on-an-ambient-category reading (where it typechecks but is not the displayed unit without further identifications). The box wording "does not supply the displayed η … without extra identifications" is chosen to cover both, which is why it is preferred over the narrower "yields no `Require ∘ Allow` monad."
- The two-lane rail above is drawn in the shape of candidate (a) only because (a) is the one with displayable unit/counit; this is a reporting choice, not a decision. Candidate (b) is named, never drawn as lanes.
- The two candidates are deliberately *not* presented as equally supported — (a) is the shape currently expressible in the code, (b) is an analogy not yet built — but which one is correct is left to future mathematics.

---

## 7. Left region: `fragments of 𝓜 — cohesive HoTT`

The left region contains formal material around cohesive HoTT and analytic tests. Use stacked boxes
with short labels, formula lines, status tags, and checkable code paths.

### 7.1 Cohesive modalities

Status: `Agda, postulate-supported`.

Label:

```text
Cohesive modalities
```

Formula line:

```text
ʃ ⊣ ♭ ⊣ ♯
```

Description:

```text
Synthetic axiomatization of shape, flat, and sharp. Some functor laws and idempotency
results are derived; others are postulated.
```

Code paths:

```text
agda/ModalHoTT/Modalities/Cohesion.agda
agda/ModalHoTT/Modalities/Adjunctions.agda
agda/ModalHoTT/Modalities/Properties.agda
```

### 7.2 Analytic diagnostics inset (separate from the fragment column)

This is **not** a fragment of `𝓜`, and it is not a verification of the whole synthetic stance.
It is the concrete analytic layer that confirms non-vacuity in degenerate cases *and records
where the synthetic axiomatization overshoots* what the analytic model can deliver (the Bℤ
case). It is meta to `𝓜`, not part of it — and diagnostic, not confirmatory. Render it as a small inset visually separated from the four
`𝓜` fragment boxes — for example a lighter-bordered box set apart in the lower-left of the
`𝓜` region, or in the bottom margin under the `𝓜` column — and connect it to the `𝓜` column
**only** by the double-stroke model-comparison line from the legend (§4), never by a solid
dependency arrow.

Status: `Agda definition` (the analytic objects themselves are concretely defined; the inset's
*role* is diagnostic, not construction and not full verification).

Label:

```text
Analytic diagnostics
```

Formula line:

```text
ℤ,  Bℤ,  Ω(Bℤ) ≃ ℤ
```

Description:

```text
Concrete model used to check the synthetic axioms. The Bℤ case records where the synthetic
axiomatization is stronger than the analytic model can deliver.
```

Code paths:

```text
agda/Analytic/ModalHoTT/Modalities/Cohesion.agda
agda/Analytic/ModalHoTT/Modalities/Adjunctions.agda
agda/Analytic/ModalHoTT/Modalities/Properties.agda
```

### 7.3 Fracture square

Status: `Agda, postulate-supported`.

Label:

```text
Fracture square
```

Formula line:

```text
♭X ≃ X ×_{♯X} ♭♯X
```

Optional square inset:

```text
♭X  ---->  X
 |          |
 v          v
♭♯X ---->  ♯X
```

Description:

```text
The displayed equivalence is the Agda fracture equivalence: the canonical map
♭X → (X ×_{♯X} ♭♯X) is postulated to be an equivalence. Soundness is imported
from the cohesive HoTT literature rather than derived from the current Agda axioms alone.
```

Code path:

```text
agda/ModalHoTT/Modalities/Fracture.agda
```

### 7.4 Adjunction iteration

Status: `Agda, postulate-supported`.

Label:

```text
Adjunction iteration
```

Formula line:

```text
T = ♭∘ʃ,  Tⁿ,  ηⁿ,  SeqColim
```

Description:

```text
Generic monad iteration for an adjunction. The cohesive instance proves the first-level
collapse for ʃ ⊣ ♭.
```

Code paths:

```text
agda/ModalHoTT/Modalities/Iteration.agda
agda/ModalHoTT/Modalities/IterationCohesion.agda
```

### 7.5 Flat-coefficient cohomology

Status: `Agda, postulate-supported`.

Label:

```text
Flat-coefficient cohomology
```

Formula line:

```text
H_flat(X; B) := ʃX → B
```

Description:

```text
Structural flat-coefficient equivalence. The pinned form uses existing naturality
postulates. This is not yet differential de Rham theory.
```

Code paths:

```text
agda/ModalHoTT/Cohomology/FlatCoefficients.agda
agda/Analytic/ModalHoTT/Cohomology/FlatCoefficients.agda
```

---

## 8. Right region: `fragments of 𝓟 — actor-causal/session`

The right region contains the actor-causal, operadic, session, and presheaf material. Use stacked
boxes or a two-column internal grid if needed. The dependency structure should distinguish
the generic presheaf chassis from the session-valued specialization:

```text
Actor-causal pretopology ──────────────> Generic frame-indexed presheaves
Generic frame-indexed presheaves ─┐
                                  ├──> Session-valued frame presheaves
*-autonomous session target ──────┘

Cyclic operad O₁ ────────────────┐
                                 ├──> O₁-algebra on session values
*-autonomous session target ─────┘
```

Do not draw a current dependency arrow from the O₁-algebra box to the presheaf boxes.

### 8.1 Actor-causal pretopology

Status: `Agda, postulate-supported`.

Label:

```text
Actor-causal pretopology
```

Formula line:

```text
LocalFrame, FrameHom, Cover
```

Description:

```text
Opaque actors, causally ordered events, local frames, frame embeddings, and basis covers.
Cover stability is presently postulated.
```

Code paths:

```text
agda/Concurrency/Sites/ActorBase.agda
agda/Concurrency/Sites/ActorCausal.agda
```

### 8.2 Cyclic operad `O₁`

Status: `Agda definition`.

Label:

```text
Cyclic operad O₁
```

Formula line:

```text
gen, compₒ, rot, boundary-swap
```

Description:

```text
One-generator cyclic interaction grammar with rotation and gluing operations.
```

Code paths:

```text
agda/Concurrency/Operads/CyclicAssociative.agda
agda/Concurrency/Operads/PortGluing.agda
agda/Concurrency/Operads/PortRotation.agda
```

### 8.3 `*`-autonomous session target

Status: `Agda, postulate-supported`.

Label:

```text
*-autonomous session target
```

Formula line:

```text
⊗, ⅋, 𝟙, ⊥, (-)^⊥
```

Description:

```text
Thin categorical interface for multiplicative session semantics. Coherence is intentionally
not yet developed in full.
```

Code paths:

```text
agda/Concurrency/Algebras/StarAutonomous.agda
agda/Concurrency/Algebras/Sessions.agda
```

### 8.4 `O₁`-algebra on session values

Status: `Agda, postulate-supported`.

Label:

```text
O₁-algebra on session values
```

Formula line:

```text
Valuation, OperadAlgebra, SessionO1Action
```

Description:

```text
The O₁ action is packaged as explicit structure rather than derived canonically from
the current session category.
```

Code paths:

```text
agda/Concurrency/Algebras/Valuation.agda
agda/Concurrency/Algebras/OperadAlgebra.agda
agda/Concurrency/Algebras/Sessions.agda
```

Render a small inline annotation in this box: `(operadic lift to presheaves planned)`. The box has inbound arrows (`O₁`, session target) and no outbound arrow, which honestly reflects that the operad-algebra is built but not yet lifted to the presheaf layer; the annotation preempts misreading the missing outbound arrow as an omission. The future connection is the planned-construction label `Operadic valuation over frame presheaves` in the lower band.

### 8.5 Generic frame-indexed presheaves

Status: `Agda definition`.

Label:

```text
Generic frame-indexed presheaves
```

Formula line:

```text
F : Frameᵒᵖ → 𝓥;   IsSeparated stated (no witness)
```

Description:

```text
Presheaves over actor-causal frames valued in an abstract *-autonomous target.
Separatedness is stated as a property record but unproved; descent and gluing are planned.
```

Code path:

```text
agda/Concurrency/Hybrid/Presheaf.agda
```

### 8.6 Session-valued frame presheaves

Status: `Agda, postulate-supported`.

Label:

```text
Session-valued frame presheaves
```

Formula line:

```text
SessionPresheaf = FramePresheaf(Sessions-Cat)
```

Description:

```text
Specializes the generic presheaf chassis to the session target. The dependency on
Sessions-Cat imports the postulate-supported session semantics.
```

Code path:

```text
agda/Concurrency/Hybrid/SessionPresheaf.agda
```

The visible diagram label must not be `Hybrid v1`.

Inhabitation-quality note for both presheaf boxes (§8.5 and §8.6). The status tags do not capture two distinct gaps: (i) the presheaf types `FramePresheaf` / `SessionPresheaf` are inhabited *only* by constant presheaves (`const-presheaf`, `const-𝟙ₛ-presheaf`, `const-⊥ₛ-presheaf`) — no non-trivial frame-varying presheaf has been built; (ii) `IsSeparatedPresheaf` is *defined as a property record but has no witness at all* — separatedness is not proved, not even for the constant presheaves. So an `Agda definition` tag here certifies the *type* is defined and (for the presheaf types) trivially inhabited; it does **not** certify that separatedness holds. Render a small inline annotation on each presheaf box: `(constant presheaves only; no separatedness witnesses yet)`.

---

## 9. Lower band: further structure not part of the current formalization

The lower band is for planned or programmatic material. It must be visually subordinate to the
implemented/postulate-supported main regions.

Heading:

```text
Further structure not part of the current formalization
```

Use small grouped boxes. Do not draw these as if they already participate in the central comparison adjunction.

### 9.1 Planned constructions

Status: `Planned construction`.

Recommended labels:

- `Sheaf descent over actor-causal covers`
- `Generated sieve topology`
- `Canonical O₁ action from richer session semantics`
- `Operadic valuation over frame presheaves`
- `Differential cohesion: ℜ ⊣ ℑ ⊣ &`
- `Cyclic bar construction at S¹`
- `Protocol-version category Π`
- `Content category Λ`

### 9.2 Programmatic horizons

Status: `Programmatic horizon`.

Recommended labels:

- `Factorization-algebra dynamics`
- `Protocol 2-category / meta-topos`
- `MO₁ and GT action`
- `Receiver-relative information cohomology`
- `Iterated comparison adjunction`

If space is tight, combine the programmatic horizon labels into one box:

```text
Programmatic horizons:
factorization-algebra dynamics; protocol 2-category / meta-topos;
MO₁ and GT action; receiver-relative information cohomology.
```

---

## 10. Arrows and dependency structure

### 10.1 Inside `𝓜`

Draw implemented or postulate-supported dependency arrows among the four fragment boxes:

- `Cohesive modalities` → `Fracture square`
- `Cohesive modalities` → `Flat-coefficient cohomology`
- `Cohesive modalities` → `Adjunction iteration`

The relationship between the analytic diagnostics inset (§7.2) and the `𝓜` column is **not** a dependency, construction, or import. Draw it as the double-stroke model-comparison line from the legend (§4) — no arrowheads, never a plain solid arrow — connecting the diagnostics inset to the `Cohesive modalities` box, labelled:

```text
diagnostic comparison (model check, not a dependency)
```

### 10.2 Inside `𝓟`

Draw dependency arrows:

- `Cyclic operad O₁` → `O₁-algebra on session values`
- `*-autonomous session target` → `O₁-algebra on session values`
- `Actor-causal pretopology` → `Generic frame-indexed presheaves`
- `Generic frame-indexed presheaves` → `Session-valued frame presheaves`
- `*-autonomous session target` → `Session-valued frame presheaves`

The arrows into the `O₁`-algebra box and the arrow from `*-autonomous session target` to `Session-valued frame presheaves` **must** use the solid-arrow-with-`P`-marker convention — the postulate-supported-dependency distinction is load-bearing for a status-honesty diagram and is not optional. Do not draw an arrow from `O₁-algebra on session values` to either presheaf box; that is planned operadic-valuation-over-presheaves work, not current code.

### 10.3 Between the fragments and the center

Do not draw a solid arrow from any existing Agda module to `Allow ⊣ Require`.

Instead, use two dashed vertical braces outside the two-lane rail diagram:

- one brace on the left boundary of the center region, spanning the height of the main `𝓜` fragment boxes;
- one brace on the right boundary of the center region, spanning the height of the main `𝓟` fragment boxes.

Label each brace:

```text
candidate semantic completion
```

The braces must not cross the center lanes and must not have arrowheads. They sit behind or outside the rail diagram as boundary annotations. This makes clear that `𝓜` and `𝓟` are not single current modules but the intended semantic closures of the displayed fragments, while the actual functor arrows are only the two lanes `Allow` and `Require`.

One honesty caveat must be carried as a small note attached to the `𝓟` brace (and, after the diagnostic inset is separated out, the `𝓜` brace is comparatively homogeneous and needs no such note). The displayed `𝓟` fragments are **heterogeneous ingredients**, not approximations of a single category: a Grothendieck site (the actor-causal pretopology) and presheaves over it *construct* the category, while the operad `O₁` and its algebra are *interaction-structure acting within* it. The eventual `𝓟` is a composite — session-typed values over the actor-causal site, with `O₁` interaction-structure — not yet unified into a single category, and the project has not fixed whether `Allow`/`Require` connect `𝓜` to `Sh(actor-causal site)`, to an operad-algebra category, or to a fusion of both. Attach this note to the `𝓟` brace, in the secondary-text colour:

```text
𝓟 is a composite (site-with-session-values + O₁ interaction-structure),
not yet unified into a single category; these fragments are heterogeneous
ingredients, not approximations of one object.
```

---

## 11. Typography and density

Recommended sizes for A4 landscape:

- Region headings: 14-16pt, semibold.
- Box labels: 10.5-12pt, semibold.
- Formula lines: 10-11pt, math font.
- Descriptions: 7.5-8.5pt, regular.
- Code paths: 6.5-7pt, monospace.
- Status tags: 6.5-7pt, uppercase or small caps.
- Legend text: 7-8pt.

Keep each box description to two lines. If a description cannot fit, shorten it rather than shrinking
the font below 7.5pt.

Do not use decorative chips for names of mathematicians. References belong in surrounding prose,
captions, or bibliography, not as diagram elements.

---

## 12. Color palette

Color must not carry formal meaning by itself. Use color only to help orientation.

Suggested restrained palette:

| Role | Color |
|---|---|
| Page background | `#FFFFFF` |
| Main text | `#111827` |
| Secondary text | `#4B5563` |
| Region heading text | `#111827` |
| Implemented border | `#111827` |
| Postulate left rule | `#111827` |
| Planned border | `#6B7280` |
| Programmatic horizon fill | `#F3F4F6` |
| Programmatic horizon border | `#9CA3AF` |
| Status tag background | `#F9FAFB` |
| Legend background | `#F9FAFB` |

Avoid saturated blue/orange region coding. It makes the diagram look like an expository infographic
and encourages readers to interpret color as the main structure.

---

## 13. Self-test checklist

Before declaring the generated diagram done, verify:

1. The visible legend includes all four status labels exactly.
2. The diagram does not contain the phrases "modal side", "concurrency side", or "Hybrid v1".
3. The central adjunction is drawn as the specified two-lane rail diagram, with correct functor directions: `Allow : 𝓜 → 𝓟` and
   `Require : 𝓟 → 𝓜`.
4. No standalone `𝓜 ⇄ 𝓟` glyph appears anywhere in the center region.
5. The central adjunction is explicitly marked conjectural / proposed.
6. The `candidate semantic completion` braces sit outside the rail diagram, do not cross the lanes, and have no arrowheads.
7. Every main-region box has a code path or an explicit planned/programmatic status.
8. No future layer is styled as if it were implemented.
9. The diagram remains legible in greyscale, and no status distinction depends only on fine line-style differences.
10. No audience-hook name chips are present.
11. All diagram-visible operad labels use typographic subscripts: `O₁` and `MO₁`, not `O_1` or `MO_1`.
12. The lower band is visually subordinate to the main formal fragments.
13. The diagram fits on one A4 landscape page with no clipped text.
14. The analytic diagnostics inset is rendered as a separate inset, not as one of the `𝓜` fragment boxes, and is connected to the `𝓜` column by the double-stroke model-comparison line (no arrowheads) — never by a solid dependency arrow.
15. The legend includes the fifth arrow type (model / diagnostic comparison, no arrowheads) and no solid arrow is used for the analytic-to-synthetic relationship.
16. The `𝓟` region uses two internal columns; no `𝓟` box description wraps past two lines (shorten text rather than shrink font below 7.5pt).
17. The `𝓟` brace carries the composite caveat note; the `O₁`-algebra box carries its `(operadic lift to presheaves planned)` annotation; both presheaf boxes carry the `(constant presheaves only; no separatedness witnesses yet)` annotation; and the generic presheaf formula line marks `IsSeparated` as stated-without-witness.
18. The center includes the `adjoint shape open` two-candidate box naming both the pair (a) and the triple (b), and states the resolution is deferred. The pair rail is drawn, but the box makes clear this is a reporting choice, not a decision.

---

## 14. Anti-goals

- Not a general-audience diagram.
- Not a marketing poster.
- Not a proof that `Allow ⊣ Require` has been constructed.
- Not a claim that the possible `Mediate` slot has content yet.
- Not a complete bibliography.
- Not a roadmap that gives equal visual weight to future horizons and current formalization.
- Not a commutative diagram unless the arrows being drawn have the specified mathematical status.

---

## Appendix A. Translation table from working language to diagram language

This table is for the spec and surrounding process. It should not be reproduced wholesale on the
diagram.

| Working phrase / concept | Candidate public mathematical names | Chosen diagram label | Notes |
|---|---|---|---|
| modal side | cohesive fragment; cohesive HoTT fragment; cohesive ∞-topos fragment; modal fragment | `fragments of 𝓜 — cohesive HoTT` | Avoid "side"; keep the connection to cohesive HoTT explicit and checkable. |
| concurrency side | actor-causal fragment; session-semantics fragment; protocol fragment; actor-causal/session fragment | `fragments of 𝓟 — actor-causal/session` | Names both developed ingredients without claiming a completed category of protocols. |
| `Allow ⊣ Mediate ⊣ Require` | comparison adjunction; adjoint pair; possible future adjoint triple; modalities on an ambient category | two-candidate box: pair `Allow ⊣ Require` drawn as the rail, triple `Allow ⊣ Mediate ⊣ Require` named but not drawn | Adjoint shape undecided; the pair is drawn because it is the shape currently expressible (matches `arc.md`'s unit/counit and has the same pair-adjunction shape as the generic `Iteration.agda` scaffold, currently instantiated only at `ʃ ⊣ ♭`), the triple is named as a live alternative, and the choice is deferred to future mathematics — see §6. |
| Allow | left comparison functor; left adjoint | `Allow` | In the displayed pair, `Allow : 𝓜 → 𝓟`. |
| Mediate | possible middle comparison functor; possible adjoint-triple slot; mediating functor | named in candidate (b) of the two-candidate box; not drawn | Part of the triple candidate (b), not a settled slot. The pair/triple choice is the declared open question — see §6. |
| Require | right comparison functor; right adjoint | `Require` | In the displayed pair, `Require : 𝓟 → 𝓜`. |
| Hybrid v1 | restriction adapter; generic frame-indexed presheaves; session-valued frame presheaves; presheaf adapter | `Generic frame-indexed presheaves`; `Session-valued frame presheaves` | Split the generic chassis from the session-valued specialization. |
| shipped | implemented; formalized; type-checking Agda definition | `Agda definition` | Use only as a status tag. |
| postulate gap | axiomatic dependency; postulate-supported construction; assumed structure | `Agda, postulate-supported` | Use for cohesion axioms, actor-site stability, thin categorical interfaces, and explicit action assumptions. |
| future | planned; not yet implemented; pending construction | `Planned construction` | Use for descent, generated topology, richer session category, differential cohesion, cyclic bar. |
| long horizon | research program; programmatic target; conjectural horizon | `Programmatic horizon` | Use for MO₁/GT, meta-topos, information cohomology, iterated comparison. |
| trade-off cascade | extension ladder; planned layers; successive construction stages | `Further structure not part of the current formalization` | Do not present as a cascade on the rigorous diagram. |
| audience hooks | references; precedents; bibliography; mathematical lineage | omitted from diagram | Put names in surrounding prose or bibliography, not in the diagram. |
| easter eggs | secondary notation; optional cues; mathematical references | omitted as a category | If notation is present, it must be doing formal work. |
| codependency | mutual comparison; adjoint relation; comparison structure | `proposed comparison adjunction` | Avoid metaphor in the diagram. |
| Lawvere asymmetry | non-collapse condition; asymmetry of adjunction; nontrivial iteration | omitted or prose-only | Too interpretive for the central diagram unless formalized nearby. |
| care / caregiver / cared-for | cyclic duality; involution; boundary swap; session duality | `boundary-swap` or omitted | Use only the formal operadic/session label. |
| 1=2 identity | cyclic self-duality; perspective-swap; colimit/limit comparison | omitted from main diagram | Future structure; do not place in the current formal core. |
| Bulk Λ | content category; internal language category; concept category | `Content category Λ` | Planned construction. |
| Reflexive Π | protocol-version category; category of protocol edits | `Protocol-version category Π` | Planned construction. |
| field-theoretic dynamics | factorization algebra; RG flow; field-theoretic dynamics | `Factorization-algebra dynamics` | Programmatic unless a formal module exists. |
| federation | protocol 2-category; meta-topos of protocols; category of protocols | `Protocol 2-category / meta-topos` | Programmatic horizon. |
| information cohomology | receiver-relative entropy; information cohomology; cohomological complexity | `Receiver-relative information cohomology` | Programmatic horizon. |
| MO_1 | modular envelope of `O₁`; modular operad closure | `MO₁` | Programmatic horizon until the operadic phase reaches it. |
| GT | Grothendieck-Teichmüller action; arithmetic symmetry | `GT action` | Programmatic horizon; do not put it in the current formal core. |
| Bℤ as site | delooping of ℤ; circle presentation; analytic test object | `Analytic diagnostics: ℤ, Bℤ, Ω(Bℤ) ≃ ℤ` | Render as a separate inset, not a `𝓜` fragment box; connect with the model-comparison line (no arrowheads), not a dependency arrow. Diagnostic, not full verification. |
| de Rham target | flat-coefficient cohomology; differential cohesion; de Rham theorem | `Flat-coefficient cohomology`; `Differential cohesion: ℜ ⊣ ℑ ⊣ &` | Keep structural cohomology separate from future differential cohesion. |

## Notes

`Also, please have a look at adj_diag_now.png and notice how the maine issue is with the names of files either being absent or clipped. I believe we don't need the full path but only the name the
  file, in a list in one line if several, so that in all cases we only need one line. But in many boxes we don't even get this one line to show up. Also, at the bottom, the boxes in "Further
  structure not part of the current formalization  " are clipped.`