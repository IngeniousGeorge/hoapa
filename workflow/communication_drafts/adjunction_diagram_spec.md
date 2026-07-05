# Diagram specification — the `Allow ⊣ Mediate ⊣ Require` adjunction

A specification for the web-UI Claude to produce a printable A4-landscape diagram, as a single self-contained HTML file with inline SVG and CSS. The diagram presents the project's central adjunction in a plain-diagrammatic language that math-literate non-specialists can read, while leaving categorical structure recognisable to category theorists who notice the small cues.

---

## 1. Purpose & audience

The diagram is the visual centerpiece of the project's outward-facing material. It is intended to be printed on A4 landscape or embedded in a README at roughly that aspect ratio. The primary audience is a math-literate reader who is *not* a category theorist — a working scientist, an engineer, a philosophy-of-math reader, an institutional reviewer. The secondary audience is the category theorist, for whom small categorical cues (modality symbols, η / ε labels, MO_1 / Yoneda hints) are present as recognition-prompts but never centerpiece-prominent.

Math symbols that appear (ʃ, ♭, ♯, ⊗, ⅋, ⊥, η, ε, MO_1, Π, Λ, etc.) are *unexplained inside the diagram*. The non-specialist sees them as recognisable mathematical decoration; the specialist reads them as content. The diagram earns its keep through the prose and module names, not through formal mathematics.

---

## 2. Output format & technical constraints

- **Single HTML file** with inline CSS and inline SVG. No external dependencies. The file should render correctly when opened directly in a browser and when printed to PDF from the browser.
- **A4 landscape** as the design target: 297mm × 210mm (1.414:1). Use CSS `@page { size: A4 landscape; margin: 0; }` plus a top-level container sized to `297mm × 210mm` to ensure print fidelity.
- **Greyscale-survivable.** The colour palette below is meaningful but never *load-bearing*. The diagram must remain legible if printed in greyscale; weight, dashing, position, and labels must carry the structural meaning. Use colour for orientation, not for distinction-of-kind.
- **Self-contained typography.** Use a system font stack (e.g. `font-family: 'Inter', 'Helvetica Neue', system-ui, sans-serif;`) plus a serif fallback for mathematical symbols where rendering is better in serif (`font-family: 'Latin Modern', 'STIX Two Math', 'Computer Modern', Cambria, Georgia, serif;` for SVG `<text>` containing modal symbols, η / ε, etc.). No web-font loading.
- **No interactivity.** Static. No JavaScript.
- **Untitled.** No project-level heading. No "Hoapa" anywhere on the diagram. The diagram is meant to be embedded in a context that supplies the title.

---

## 3. Overall composition

The page is divided into four regions:

```
+-----------------------------------------------------------+
|                                                            |
|  MODAL SIDE      |  ADJUNCTION  |  CONCURRENCY SIDE         |
|  (narrower)      |  (narrow)    |  (widest)                 |
|                  |              |                          |
|                  |              |                          |
|                  |              |                          |
|                  |              |  ........................|
|                  |              |  TRADE-OFF CASCADE       |
|                  |              |  (six rows, compact)     |
+-----------------------------------------------------------+
```

Proportions (left to right, of the inner content area after page margins):

- Modal column: ~28% width.
- Adjunction column: ~14% width.
- Concurrency column: ~58% width.

Vertically (within the content area):

- Top ~78% of height: the three columns at their full vertical extent for modal and adjunction; for concurrency, modules occupy the top ~78% and the trade-off cascade occupies the bottom ~22% of the column.
- The modal column extends to the full vertical content height (it has no cascade) and uses its lower region for philosophy / audience-hook anchors.
- The adjunction column has its content concentrated in the upper-middle vertical zone; lower zone is empty or carries the small η / ε / Lawvere-asymmetry annotations.

Outer page margins: 12mm on all sides.

---

## 4. Colour palette

All values are HEX. The palette must remain legible if all colour is replaced by a single mid-grey.

| Role | Colour | Notes |
|---|---|---|
| Background (page) | `#FFFFFF` | Clean white. |
| Modal side primary | `#2C5282` | Deep blue. Conveys foundational, abstract, mathematical. Used for column header, module box borders (shipped), main prose text colour. |
| Modal side secondary (future) | `#90B4D8` | Lighter blue. Dashed borders for not-yet-shipped modal items. |
| Concurrency side primary | `#9A3412` | Deep terracotta / burnt orange. Conveys active, operational, agent-driven. Used for column header, module box borders (shipped), main prose text colour. |
| Concurrency side secondary (future) | `#FCA974` | Lighter orange. Dashed borders for not-yet-shipped concurrency items. |
| Adjunction primary | `#1F2937` | Slate / charcoal. The mathematical centre. Used for `Allow ⊣ Mediate ⊣ Require` symbol stack, central arrows. |
| Easter-egg / categorical micro-annotations | `#6B7280` | Medium grey. Used for η, ε, triangle identity labels, MO_1, Yoneda hints, small Lawvere-asymmetry annotations. |
| Trade-off cascade background | `#F5F5F4` | Stone-100. Light background distinguishing the cascade strip. |
| Trade-off cascade text | `#1F2937` | Slate. Same as adjunction primary, for typographic unity. |
| Audience-hook chips | `#E5E7EB` background, `#374151` text | Light grey pill chips for named figures (Grothendieck, Lawvere, Hewitt, etc.). |

Linework: 1.0–1.5pt strokes for boxes and arrows; dashed strokes use `stroke-dasharray: 4 3`.

---

## 5. Typography

- **Column headers** ("Modal side", "Concurrency side"): 16pt, weight 600, in the side's primary colour, all caps with 0.05em letter-spacing.
- **Module names**: 13pt, weight 600, in the side's primary colour.
- **Module descriptions**: 10pt, weight 400, in `#1F2937`. 1.35 line height. Max 2 short lines per module.
- **Adjunction symbol** (`Allow ⊣ Mediate ⊣ Require`): 18pt, weight 500, in `#1F2937`, vertically stacked.
- **Easter-egg labels** (η, ε, MO_1, etc.): 9pt, weight 500, in `#6B7280`, in a serif fallback where supported.
- **Cascade rows**: 9pt for the trade-off and strategy text, 10pt weight-600 for the module name in the first column.
- **Cascade header row**: 9pt, weight 600, uppercase, 0.05em letter-spacing, in `#6B7280`.
- **Audience-hook chips**: 8.5pt, weight 500, in `#374151`, on `#E5E7EB` pill background with `border-radius: 9999px` and 6mm horizontal padding.

---

## 6. Region-by-region content specification

### 6.1 Modal side (left column)

**Top of column — header**

`MODAL SIDE` in 16pt weight-600 `#2C5282`. Subtitle in 10pt weight-400 `#2C5282`: *the cohesive ∞-topos in which the system is embedded — its context, its perspectival structure, its space of resolutions*.

**Middle of column — modules**

Four boxes vertically, in this order, each ~88% of column width, ~3mm vertical spacing between boxes:

1. **Cohesion** (shipped — solid border, primary blue).
   Module name: `Cohesion`.
   Symbol line (smaller, serif): `ʃ ⊣ ♭ ⊣ ♯`.
   Description: *shape ⊣ flat ⊣ sharp. The minimum modal structure that supports multi-level perspectival reasoning. The floor of the framework on this side.*

2. **Modal site `Bℤ`** (shipped — solid border, primary blue).
   Module name: `Modal site`.
   Symbol line: `Bℤ ≃ S¹` (small).
   Description: *the delooping of ℤ as a higher inductive type. Carries the group structure for the iteration scaffold; presentable as the circle S¹ for the future bar construction.*

3. **Iteration scaffold** (shipped — solid border, primary blue).
   Module name: `Iteration scaffold`.
   Symbol line: `Tⁿ, η^n, N∞`.
   Description: *modally-iterated unit, developing network as sequential colimit. The toy iteration is shipped; the cyclic bar construction at S¹ is the next step toward field-theoretic output.*

4. **Differential cohesion** (future — dashed border, secondary blue).
   Module name: `Differential cohesion`.
   Symbol line: `ℜ ⊣ ℑ ⊣ &`.
   Description: *reduction ⊣ infinitesimal shape ⊣ infinitesimal flat. The further modal floor required for the modal side to output a synthetic field theory.*

**Bottom of column — audience hooks**

A small block titled `Anchors` (10pt weight-600 `#2C5282`), followed by a wrapped row of audience-hook chips, each chip carrying one name:

- `Grothendieck`
- `Lawvere`
- `Shulman`
- `Schreiber`
- `Hersh`

Below the chips, a 9pt italic line in `#374151`: *the modal side is shaped by these traditions; for many readers it is here that the framework first reads as familiar.*

### 6.2 Adjunction column (centre)

**Top half of column** — the central symbol stack.

Centred vertically in the upper half, the three modalities stacked:

```
Allow
  ⊣
Mediate
  ⊣
Require
```

Each modality in 18pt `#1F2937` weight-500. The `⊣` between them is also 18pt, slightly larger weight, centred. Total stack vertical extent ~30mm.

To the immediate left of the stack: a curved arrow pointing **right**, labelled `Allow`, going from modal side toward concurrency side. To the immediate right of the stack: a curved arrow pointing **left**, labelled `Require`, going from concurrency side toward modal side. The two arrows visually frame the symbol stack, signalling that the adjunction is a two-way relation. A small horizontal arrow at the centre, labelled `Mediate`, passes *through* the stack.

**Middle band** — codependency note.

Below the symbol stack, a small text block, centred, max-width ~95% of column width, 9pt italic `#1F2937`:

> *Codependency, not foundation. Neither side is the substrate of the other; both rest on the adjunction. The modal context requires what the concurrent system provides, and licenses what it produces; the concurrent system requires what the modal context structures, and operates inside what it allows.*

**Lower zone** — categorical easter eggs.

Three small annotations in `#6B7280` 9pt serif-fallback, vertically stacked:

- A small dashed triangle with `η` at one vertex, labelled `unit (id → Require ∘ Allow)`.
- A small dashed triangle with `ε` at one vertex, labelled `counit (Allow ∘ Require → id)`.
- One line, 8pt italic: *Lawvere asymmetry: B fluid, A rigid; prevents the iteration from collapsing to a fixed point.*

### 6.3 Concurrency side (right column)

**Top of column — header**

`CONCURRENCY SIDE` in 16pt weight-600 `#9A3412`. Subtitle in 10pt weight-400 `#9A3412`: *the actor-causal protocol that navigates the modal context — its participants, its events, its language, its production.*

**Module region — two sub-columns**

The concurrency module area is laid out as a 2-column sub-grid (left sub-column for shipped modules, right sub-column for future layers). Each sub-column is ~48% of the concurrency column width, with ~4mm gap.

**Left sub-column: shipped (solid border, primary orange).**

1. **Actor-causal site**.
   Module name: `Actor-causal site`.
   Symbol line: `ActorBase, FrameHom, Cover`.
   Description: *opaque unityped actors, Lamport partial-order events, local frames as sub-views, basis covers. The locality leg: who participates, in what causal order, with what local visibility.*
   Audience-hook chips below: `Hewitt` `Lamport`.

2. **Cyclic operad O_1**.
   Module name: `Cyclic operad O_1`.
   Symbol line: `gen, compₒ, rot`.
   Description: *the interaction grammar: one binary generator (send/receive), three cyclic ports (sender/receiver/channel), boundary-swap derived as session duality.*
   Audience-hook chips below: `Getzler–Kapranov` `Markl`.

3. **Sessions algebra**.
   Module name: `Sessions algebra`.
   Symbol line: `⊗, ⅋, 𝟙, ⊥`.
   Description: *multiplicative session types in a `*`-autonomous category. The how-layer: typed obligations, duality `S ↔ S^⊥`, linear-logic semantics for cut-free interaction.*
   Audience-hook chips below: `Caires–Pfenning` `Girard`.

4. **Hybrid v1**.
   Module name: `Hybrid v1 (restriction adapter)`.
   Symbol line: `FramePresheaf, IsSeparated`.
   Description: *the first adapter: session values vary contravariantly over actor-local frames. Auditability is the uniqueness half of descent. The bridge that makes the two legs one mathematical object.*

**Right sub-column: future layers (dashed border, secondary orange).**

1. **Sheaf descent**.
   Module name: `Sheaf descent`.
   Description: *next step. Compatible local content glues into shared global content.*

2. **Reflexive layer**.
   Module name: `Reflexive Π`.
   Description: *the protocol revises itself. Meta-conversations propose edits; consensus emits a protocol-version morphism.*

3. **Bulk type theory**.
   Module name: `Bulk Λ`.
   Description: *the protocol generates its own language. Every message carries a what-tag alongside its how-tag; the language evolves through consensus.*

4. **Field-theoretic dynamics**.
   Module name: `Field-theoretic dynamics`.
   Description: *the language's evolution as RG flow on a factorization algebra over the actor-causal site. Symmetry-breaking, fluctuation, stabilization.*

5. **Federation**.
   Module name: `Federation`.
   Symbol line (small grey): `Yoneda, GT, MO_1`.
   Description: *one protocol among many. Typed translation interfaces, partial clones, conflict-as-data. The meta-topos of protocols is itself the same kind of object — at one level up.*

6. **Information cohomology**.
   Module name: `Information cohomology`.
   Description: *receiver-relative complexity. Transparency-of-language as an engineering -ility on the same footing as performance and security.*
   Audience-hook chips below: `Baudot–Bennequin` `Manin–Marcolli`.

**Bottom of column** — placeholder for cascade strip (see §6.4).

### 6.4 Trade-off cascade strip (bottom of concurrency column)

A compact table occupying the bottom ~22% of the concurrency column's vertical extent, with the cascade background colour `#F5F5F4` and a 0.5pt rule along its top edge.

Above the table, a single header line in 9pt weight-600 uppercase `#6B7280` letter-spaced 0.05em: `TRADE-OFF CASCADE`.

Six rows, in this exact order, each row aligned (visually, with light dotted vertical guides) to the corresponding module box in the section above. Three columns per row:

| Module (10pt weight-600) | Trade-off (9pt weight-400 italic) | Strategy (9pt weight-400) |
|---|---|---|
| **Hybrid** | locality vs globality | sheaf descent |
| **Reflexive Π** | stability vs adaptability | meta-conversation + consensus |
| **Bulk Λ** | expressive power vs transparency | protocol generates its own language |
| **Field dynamics** | exploration vs exploitation | RG flow with reflexive insertions |
| **Federation** | coherence vs plurality | translation interfaces, partial clones, conflict-as-data |
| **Info cohomology** | dense vs accessible encoding | receiver-relative measurement |

Below the table, a single line in 8pt italic `#374151`: *each trade-off is created by the previous resolution; the strategy applied at every step is separation of concerns.*

---

## 7. Arrows & connections

- **Modal-to-concurrency arrow** (`Allow`): a smooth curve from the right edge of the modal column at vertical-centre, arching gently across the adjunction column, landing on the left edge of the concurrency column at vertical-centre. Stroke `#1F2937`, 1.5pt, with an arrowhead at the concurrency end. Label `Allow` in 9pt weight-500 `#1F2937` placed slightly above the curve at its midpoint.
- **Concurrency-to-modal arrow** (`Require`): symmetric, in the opposite direction, slightly below the modal-to-concurrency arrow so the two are visually distinct. Stroke `#1F2937`, 1.5pt, arrowhead at the modal end. Label `Require` placed slightly below the curve.
- **Mediate**: a small horizontal line through the centre of the symbol stack, with a tiny arrowhead on each end (a small bidirectional connector). Label `Mediate` placed above this segment in 8pt italic `#6B7280`.
- **Cascade alignment guides**: optional very-light dotted vertical guides (`#E5E7EB`, 0.5pt, dasharray `1 3`) connecting each cascade row's module name to the corresponding concurrency module box above. Subtle enough to be ignored on casual inspection.

---

## 8. Category-theorist easter eggs

These items are present but not visually emphasised. A category theorist will spot them; a non-specialist will not be distracted.

- **η, ε on triangle identities** in the adjunction column (specified in §6.2).
- **Lawvere asymmetry** annotation in the adjunction column (specified in §6.2).
- **`MO_1`** in the Federation module's symbol line.
- **`Yoneda`** in the Federation module's symbol line.
- **`GT`** (Grothendieck–Teichmüller) in the Federation module's symbol line.
- **`Bℤ ≃ S¹`** in the modal site module — the presentation switch hint.
- **`⊥`** in the Sessions module — the dualizing object, recognisable as `*`-autonomous-category content.
- **`ʃ ⊣ ♭ ⊣ ♯`** and **`ℜ ⊣ ℑ ⊣ &`** as modal symbol lines — recognisable to anyone who knows cohesive HoTT.

No easter egg is labelled or explained; they are simply present.

---

## 9. Spacing, alignment, and visual rhythm

- **Inter-module spacing within a column:** 3mm vertical gap between module boxes.
- **Inter-sub-column spacing within the concurrency column:** 4mm horizontal gap between the shipped and future sub-columns.
- **Module box interior padding:** 3mm on all sides.
- **Audience-hook chips** below a module: 2mm vertical gap from the module's bottom edge; chips wrap if they exceed the module width, with 2mm horizontal gap between chips and 1.5mm vertical gap between wrapped chip rows.
- **Column-header to first-module spacing:** 6mm.
- **Adjunction column horizontal alignment:** the symbol stack and the codependency note are centred horizontally within the column.
- **Visual rhythm test:** when squinting, the page should show three vertical bands of roughly even visual weight (modal narrow but dense, adjunction sparse but central, concurrency wide but well-spaced) with a horizontal strip of distinct background at the bottom-right corner (the cascade).

---

## 10. Print considerations

- The HTML page should set `@page { size: A4 landscape; margin: 0; }` and the root container should be sized exactly `297mm × 210mm`.
- All sizes inside should be in `mm` or `pt`, not `px` (so the print rendering matches the screen rendering).
- A media-print rule should ensure no element is cut off at page boundaries: `@media print { body { -webkit-print-color-adjust: exact; print-color-adjust: exact; } }`. This forces colour printing for backgrounds and chips.
- Test: opening the resulting HTML in Chrome / Firefox and choosing "Print → Save as PDF → A4 landscape → margins: none" should produce a single-page PDF identical to the on-screen rendering.

---

## 11. Self-test checklist (run before declaring done)

1. The file opens in a browser and renders as a single page at A4 landscape proportions.
2. Print preview at A4 landscape, margins none, shows the entire diagram on one page without cropping.
3. In greyscale (toggle the browser to greyscale or print to a B&W printer), the modal column, adjunction column, and concurrency column remain visually distinguishable by position, weight, and dashing — not by colour alone.
4. All module names are legible; all module descriptions are 2 lines or fewer; no text overflows its box.
5. The `Allow` and `Require` arrows are visually distinct (offset vertically) and clearly bidirectional.
6. The `η`, `ε`, MO_1, Yoneda, GT, `Bℤ ≃ S¹`, modal symbol lines, and Sessions symbol line are all present, in their specified greys / colours, in their specified locations.
7. The cascade strip is at the bottom of the concurrency column, six rows, aligned to the modules above.
8. The audience-hook chips for Grothendieck, Lawvere, Shulman, Schreiber, Hersh (modal anchors), Hewitt, Lamport (actor site), Getzler–Kapranov, Markl (operad), Caires–Pfenning, Girard (sessions), Baudot–Bennequin, Manin–Marcolli (info cohomology) are present in their specified locations.
9. The codependency prose in the adjunction column is verbatim as specified.
10. No "Hoapa", no project title, no decorative chrome that wasn't specified.

---

## 12. Anti-goals (things the diagram explicitly is *not*)

- Not a commutative diagram. The diagram is *informed by* category theory but is not itself drawn in commutative-diagram conventions. Boxes-and-arrows over the columns serve a layout purpose, not a strict categorical-data purpose.
- Not a sales pitch. No marketing language. No exclamation points. No emoji.
- Not a slide. The diagram is poster-grade information density, not presentation-grade headline density.
- Not symmetric. The concurrency column is intentionally wider and more module-dense than the modal column; this asymmetry is content, not error.
- Not exhaustive. Multiple aspects of the framework (the reframings in `future_work.md`, the pedagogy track, etc.) are deliberately not on the diagram. The diagram shows the adjunction and the modules that flank it. Everything else lives in the surrounding documents.
