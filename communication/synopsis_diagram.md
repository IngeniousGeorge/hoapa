# Synopsis diagram — specification

A single self-contained HTML+SVG document, A4 portrait, that presents the project's central thesis to a *non-mathematical academic audience*. This is the audience-facing companion to `construction_map.html`. The two documents share a colour register but serve different purposes: the construction map is a code-and-status map for math readers; the synopsis is a thesis statement for general academic readers (philosophers, working scientists outside mathematics, social-scientists, computer scientists, humanities-trained scholars).

This spec is to be followed *verbatim*. All body prose given below is final copy — do not rephrase. Layout, typography, colour, arrows, and section ordering are likewise final. Where this spec leaves a choice, it says so explicitly.

---

## 1. Purpose & audience

The synopsis condenses the project's main claim into one document an academic outside mathematics can absorb in a single sitting (~10 minutes). It does *not* explain the math; it *names what is at stake* and gives an intellectual-history frame for it.

**Audience assumptions.** The reader has academic training (any discipline) but not mathematical specialisation. They know the words "type theory" and "field theory" exist; they recognise names like Grothendieck and Deleuze; they do not need to be taught what an adjunction is. Where a technical term appears in the body, it carries a Wikipedia hint (see §7).

**What the synopsis is.** A *thesis statement* of the project, in story form, with five sections.

**What the synopsis is not.** It is not a tutorial, not a literature review, not a sales pitch, not a substitute for the construction map. It does not name implementation details (no Caires–Pfenning, no Markl, no Hewitt, no Agda file paths). Those live in the construction map.

---

## 2. Output format & technical constraints

- **Single HTML file** with inline CSS and inline SVG. No external dependencies.
- **A4 portrait** as the design target: 210mm × 297mm (1:1.414). Use CSS `@page { size: A4 portrait; margin: 0; }`.
- **Three A4 portrait pages**, in this exact distribution:
  - Page 1 — Section 0 (mirror sentences) + Section A (modal type theory)
  - Page 2 — Section B (concurrency, including the cascade table)
  - Page 3 — Section A↔B (cross-side bridge) + Section 4 (what it outputs) + Legend strip

  *Never* cut content to force fewer pages. If a single section would not fit its allocated page at the typography named in §5, increase the typography slack on that page rather than break the section.
- **Greyscale-survivable.** All colour is for orientation, not for distinction-of-kind. Section position, headings, and layout carry the structure.
- **Print and screen both supported.** All sizes in `mm` or `pt`. `@media print { body { -webkit-print-color-adjust: exact; print-color-adjust: exact; } }`. Wikipedia links are live (`<a href="...">`) in the HTML version; in print, they degrade to italic+underlined text with no URL leak.
- **No interactivity beyond clickable Wikipedia links.** No JavaScript.

---

## 3. Overall composition

The document spans three A4 portrait pages. Sections are *vertically stacked*, full-width within each page; no multi-column layout within a section. This keeps the synopsis readable as a single linear narrative across pages.

```
PAGE 1
+--------------------------------------------------+
|   Section 0 — Two mirror sentences with arrows   |
+--------------------------------------------------+
|   Section A — Modal type theory as perspectives  |
+--------------------------------------------------+

PAGE 2
+--------------------------------------------------+
|   Section B — Concurrency as implementable       |
|              protocol  (includes cascade table)  |
+--------------------------------------------------+

PAGE 3
+--------------------------------------------------+
|   Section A↔B — The cross-side bridge            |
+--------------------------------------------------+
|   Section 4 — What it outputs                    |
+--------------------------------------------------+
|   Legend strip                                   |
+--------------------------------------------------+
```

Page breaks fall *between* sections — not inside a section. Specifically: hard break after Section A (end of page 1); hard break after Section B (end of page 2). Implement with `page-break-after: always` (or the modern `break-after: page`) on the Section A and Section B container elements.

Outer page margins: 14mm on all sides of *every* page. Inter-section vertical gap (within a page): 4mm. Section-internal padding: 3mm on all sides inside the tinted background panel.

---

## 4. Colour palette

All values are HEX. The palette must remain legible if all colour is replaced by a single mid-grey.

| Role | Colour | Notes |
|---|---|---|
| Background (page) | `#FFFFFF` | Clean white. |
| A-side background tint | `#EEF3FA` | Very light blue. Behind sections 0-top, A. |
| B-side background tint | `#FAF1EC` | Very light terracotta. Behind sections 0-bottom, B. |
| Bridge background tint | `#F4F5F7` | Very light slate. Behind sections A↔B, 4. |
| Text (body) | `#1F2937` | Slate. Same as construction_map for visual coherence. |
| Section headings | `#1F2937` | Same slate. |
| Mirror-arrows (vertical, "matching position") | `#6B7280` | Medium grey. |
| Mirror-arrows (cross, "dual switch") | `#2C5282` for the A-direction; `#9A3412` for the B-direction | The cross arrow takes the colour of the side it *lands on*. |
| Italic-underlined Wikipedia terms | `#1F2937`, italic + underline | Visually distinct without an extra colour. |
| Section dividers (hairlines between sections) | `#D1D5DB` | 0.4pt rule. |

The three background tints (A blue, B terracotta, bridge slate) are *very pale* — at most 6% saturation. When converted to greyscale they should all read as nearly-white with subtle distinction. Section position and headings are the primary structural cue; the tints are a secondary cue.

---

## 5. Typography

- **Body text**: 10.5pt serif. Stack: `'STIX Two Text', 'Latin Modern', 'Cambria', 'Georgia', serif`. Line-height 1.45.
- **Section headings** (S0 has no heading; A / B / A↔B / 4): 14pt sans-serif, weight 600. Stack: `'Inter', 'Helvetica Neue', system-ui, sans-serif`. Letter-spacing 0.01em.
- **Subheadings inside sections** (e.g. "Inspiration", "Operational layers", "Hypothesis"): 11pt sans-serif, weight 600.
- **Mirror sentences (Section 0)**: 12pt serif italic. Keyword position labels (a, b, c, d, a', b', c', d'): 8pt sans-serif weight 600 in `#6B7280`, positioned under the keyword. The single label **X** is rendered distinctively: 9pt sans-serif weight 700 in `#1F2937` (slate, not grey). The visual asymmetry of X is intentional — it marks the one element that has no positional counterpart across the two sentences (it *moves*, while a/a', b/b', c/c', d/d' are positionally stable pairs).
- **Translation paragraphs in Section 0**: 9.5pt serif italic, `#4B5563`. Line-height 1.4.
- **Cascade table (in Section B)**: 9pt for body cells, 9pt weight-600 for the header row. 1.3 line-height.
- **Legend strip**: 8.5pt serif. Wikipedia-hint terms italic+underlined.
- **Wikipedia-linked terms in body text**: same size as surrounding text, *italic* + underlined. In HTML, an `<a href="...">` with `text-decoration: underline; font-style: italic; color: inherit`.

---

## 6. Section-by-section content specification

### 6.0 Section 0 — Two mirror sentences with arrows

This section sits at the top of the page. It has *two background tints*: the top half (the top sentence) sits on A-side blue tint; the bottom half (the bottom sentence) sits on B-side terracotta tint. The two tints meet at the visual midline of this section. No heading.

#### Layout

The section is approximately 50mm tall. It contains:

1. **Top sentence** (10mm from section top), centred horizontally, in 12pt serif italic. Keywords are marked with small letter labels (a, b, c, d) directly underneath, 8pt sans-serif weight-600 `#6B7280`.
2. **Translation paragraph** for the top sentence, directly below it, centred, max-width 160mm, 9.5pt serif italic `#4B5563`.
3. **Bottom sentence** (in the lower half of the section, mirroring the top), centred, same typography. Keyword labels: a', b', c', d', and **X** (note the bottom sentence has *five* labelled pieces — four positionally-paired with the top, plus X which is visually distinct and marks the one element with no positional counterpart; see exact text below).
4. **Translation paragraph** for the bottom sentence, directly below it, centred, same typography as the top translation.
5. **Mirror arrows**, drawn as an SVG overlay between the two sentences. See §7 for the exact arrow geometry.

#### Exact text — top sentence

> *Type-theory-shaped*ᵃ *foundations*ᵇ *whose internal* *semantics*ᶜ *is field-theory-shaped*ᵈ.

Keyword markers, in order:
- **a** under *Type-theory-shaped*
- **b** under *foundations*
- **X** under *internal*
- **c** under *semantics*
- **d** under *field-theory-shaped*

#### Exact text — top sentence translation

> *We start with type-theoretic foundations — a way of doing mathematics in which mathematical objects are defined by the relationships between them, rather than by what they are made of. When we look at how such a foundation reasons internally — what its semantics is — the structures we find behave like field theories: local data on a space, with rules for how the local pieces fit together globally.*

#### Exact text — bottom sentence

> *Field-theory-shaped*ᵃ' *dynamics*ᵇ' *whose stabilized* *output*ᶜ' *is an internal*ᵈ' *type-theory*ˣ.

Keyword markers, in order:
- **a** under *Field-theory-shaped*
- **b** under *dynamics*
- **c** under *stabilized output*
- **X** under *is an internal*
- **d** under *type-theory* 

#### Exact text — bottom sentence translation

> *We also study field-theoretic dynamics — local-to-global processes evolving over a space, with their own rules of change. When such a process stabilizes — when its long-time behaviour settles — what it leaves behind is itself a type theory: an internal language of mathematical objects and the maps between them.*

#### Mirror arrows

See §7.1 for arrow geometry. The pairing of keywords:

- **a ↔ X** (long cross arrow): the *type-theory* content. In the top sentence it appears as a compound adjective at position a (*type-theory-shaped*); in the bottom sentence it re-appears as a noun at the visually distinguished position X (*type-theory*). The arrow traces this grammatical promotion. Cross arrow because the keyword lives at *opposite ends* of the two sentences. Stroke colour `#2C5282`.
- **b ↔ b'** (short vertical arrow): *the thing itself* (foundations / dynamics). Same horizontal position in both sentences. Stroke colour `#6B7280`.
- **c ↔ c'** (short vertical arrow): *what comes out of the thing* (semantics / output). Same horizontal position. Stroke colour `#6B7280`.
- **d ↔ a'** (long cross arrow): the *field-theory* content. In the top sentence it appears at the end (position d); in the bottom sentence it appears at the start (position a'). Both are adjective forms; the swap is purely positional. Stroke colour `#9A3412`.

The label **d'** (under *is an internal*) carries no arrow — it is a position marker only. The asymmetry is content: the bottom sentence's predicate "is an internal" is grammatically split from its noun (*type-theory*, at X), whereas the top sentence's predicate "is field-theory-shaped" merges predicate and adjective at d. Leaving d' unconnected makes this asymmetry visible.

The cross arrows visually carry the "dual switch" message: each side's *content type* (type or field) appears at the start of one sentence and the end (or visually-distinguished X position) of the other. The vertical arrows carry the "matching position" message: the *thing* and its *output* are aligned. This visual reads the two-sentence statement as a single dual claim, not two unrelated assertions.

### 6.A Section A — Modal type theory as a system of perspectives

Section background: A-side blue tint `#EEF3FA`. Approximately 60-70mm tall.

#### Heading

> **A. Modal type theory as a system of perspectives**

14pt sans-serif weight-600, left-aligned, 4mm below the section's top edge.

#### Opening line

> Modal type theory adds *modalities* — operators that filter, reflect, or restate parts of a structure — to a type-theoretic foundation. The result is a foundation in which different perspectives on the same structure can be made formally precise.

10.5pt serif body text.

#### Subheading: Inspiration

> **Inspiration**

11pt sans-serif weight-600, 2mm below the opening line.

#### Inspiration body — Lawvere & Grothendieck

> Mid-twentieth-century mathematics underwent a silent revolution, led in different registers by William Lawvere (American, 1937–2023) and Alexander Grothendieck (French-German, 1928–2014). Mathematics moved from defining objects by their internal construction — *"what is this set?"* — to defining them by their relationships — *"how does this object* map *to others?"* — and from doing mathematics in one fixed logic to recognising that each context — each *topos* — carries its own internal logic. The shift was from substance to relation, and from one logic to many. Lawvere's particular contribution was *cohesion*: a context-internal distinction between continuous variation and discrete points — the basis of the project's cohesive ∞-topos framework.

Render the words *map* and *topos* with italic+underline (Wikipedia link treatment per §7). Render *cohesion* as plain italic emphasis only — no Wikipedia link (see §7.3 note).

#### Inspiration body — Deleuze and the lineage

> Philosophy made a structurally similar move in the same period, in a lineage Gilles Deleuze traced as his own: from Duns Scotus and Spinoza, through Leibniz and Nietzsche, to the final couple, Charles Peirce and Alfred North Whitehead. This lineage replaced the search for a single absolute truth with the recognition that reality is irreducibly multi-perspectival, each perspective carrying valid inputs of its own. Both movements — the mathematical and the philosophical — arrive at the same multiplicity. The link between them is structural, not historical: independent disciplines reaching the same place.

#### Subheading: Hypothesis

> **Hypothesis**

11pt sans-serif weight-600, 2mm below the Deleuze paragraph.

#### Hypothesis body — Manin and complexity

> The modal context must be *complex enough* to support reasoning across many levels of structure at once. Yuri Manin (Russian–German, 1937–2023), in the direct intellectual lineage of Grothendieck, gave a reading of complexity not as randomness, not as regularity, but as *generative depth* — the kind a setting has when it supports multi-level adjoint reasoning. The hypothesis on the A-side: modal cohesion meets this threshold, and so the foundation has enough depth for complexity to actually develop in it; shallower modal structures cannot host this kind of growth.

Render the word *adjoint* with italic+underline (the underlying Wikipedia term is *adjunction*; link to that).

### 6.B Section B — Concurrency as implementable protocol

Section background: B-side terracotta tint `#FAF1EC`. Approximately 90mm tall (this is the heaviest section because it contains the cascade table).

#### Heading

> **B. Concurrency as implementable protocol**

14pt sans-serif weight-600, left-aligned, 4mm below the section's top edge.

#### Opening line

> Concurrency studies systems of agents acting in parallel and communicating with each other. Two ideas anchor the modern study of such systems: the *actor model* (which describes the agents) and *session types* (which describe the structured communication between them).

Render *actor model* and *session types* with italic+underline (Wikipedia link treatment).

#### Subheading: Inspiration

> **Inspiration**

#### Inspiration body — Grothendieck on covers

> Grothendieck's other gift to mathematics was the notion of a *cover* — a collection of local views that together describe a whole, like an atlas mapping a country in patches. Each patch makes sense on its own; the way patches overlap is part of the structure. Late in his career, in *Récoltes et Semailles*, Grothendieck described the act of *covering* — of finding the right collection of local views — as the most *fertile* mathematical act: the act through which mathematical understanding actually grows.

#### Subheading: Operational layers

> **Operational layers**

#### Operational layers body

> The protocol the project builds separates communication into two layers:
>
> - **How layer.** How participants communicate — who talks to whom, in what order, with what reliability. The protocol of the conversation itself.
> - **What layer.** What they communicate about — typed content carrying meaning, structured so every receiver can decode it. The substance of the conversation.
>
> Separating these two layers is what lets a community of arbitrary participants do something together without imposing a single authority on them.

Render the bullets as actual `<ul><li>` with **How layer** and **What layer** in bold inline.

#### Subheading: Hypothesis

> **Hypothesis**

#### Hypothesis body

> The protocol must follow strict *separation of concerns*. The system's organisation is built as a *cascade*: each layer's resolution opens the next problem; separation of concerns is the recursive move that produces the whole structure.

#### Cascade table

A six-row table immediately below the Hypothesis body. Column headers in 9pt weight-600. Body cells in 9pt. Table width: 100% of section. Row height: ~5mm. Header background `#F4F5F7` (slate tint). Body cells on B-side tint.

| Layer | Trade-off it navigates | Strategy |
|---|---|---|
| **Hybrid** | locality vs globality | local content glues into global by descent |
| **Reflexive** | stability vs adaptability | meta-conversations propose, consensus ratifies |
| **Bulk** | expressive power vs transparency | the protocol generates its own language |
| **Field-theoretic dynamics** | exploration vs exploitation | symmetry-breaking, fluctuation, stabilisation |
| **Federation** | coherence vs plurality | typed translation between protocols |
| **Information cohomology** | dense vs accessible encoding | receiver-relative measurement of cost |

Layer names in the first column in weight-600.

Below the table, in 9pt serif italic `#4B5563`:

> *Each row's strategy creates the next row's trade-off. The cascade is what builds the whole protocol.*

### 6.A↔B Section A↔B — The cross-side bridge

Section background: bridge slate tint `#F4F5F7`. Approximately 60mm tall.

#### Heading

> **A ↔ B. The cross-side bridge**

#### Opening line

> Between modal type theory (A) and concurrency (B), there is a two-way bridge. A and B are mutually constitutive: each makes the other possible.

#### Subheading: Allow and Require

> **Allow and Require**

#### Allow and Require body

> The bridge has two named directions:
>
> - **Allow** (A → B). The modal context, by making multi-perspective reasoning formally precise, *allows* concurrent agents to operate without a single authority over them. Without this permission, the protocol would have to collapse to a hierarchy to function.
> - **Require** (B → A). The concurrent protocol, by separating its concerns cleanly, *requires* the modal context to host its operations. Without this requirement, the modal foundation would have no praxis — no community of agents actually doing anything inside it.

#### Subheading: Mutually constitutive

> **Mutually constitutive**

#### Mutually constitutive body

> A and B are parent and child to each other — in turn, depending on the direction. A is parent to B when B's separations need a multi-perspective context to live in. B is parent to A when A's modal structure needs an actual community of agents to mean anything in practice. Together they act on their shared context like an ecosystem: each one's activity becomes the other's environment, and the environment's state is what the next round acts in.

#### Subheading: Iteration

> **Iteration**

#### Iteration body

> Once this relation is established, it can be repeated. Each round of the bridge produces a new (context, protocol) pair, in which new structures become statable that were not statable before.
>
> The two sides are not symmetric: A is settled enough that its perspectives can be re-applied; B is fluid enough that each application produces genuinely new structure. This asymmetry is what keeps the iteration alive.
>
> The sequence of stages produced this way is the *developing protocol* the implementation targets.

### 6.4 Section 4 — What it outputs

Section background: bridge slate tint `#F4F5F7` (continuous with A↔B). Approximately 30mm tall. No subheadings; a single closing paragraph.

#### Heading

> **What it outputs**

#### Closing paragraph

> The same algebraic structure that organises quantum field theories — the *cobordism hypothesis* — organises the project's session-typed protocols. The framework's output is a kind of field theory: a way of assigning local structure to local pieces of a space, with global coherence emerging from how the pieces fit together. This is why the top sentence of the synopsis holds: type-theoretic foundations, when their internal semantics is read off carefully, produce field-theoretic structure. And it is why the bottom sentence holds: field-theoretic dynamics, when stabilised, produce an internal type theory. The two halves of the project meet at this point.

Render *cobordism hypothesis* with italic+underline (Wikipedia link).

---

## 7. Arrows, connections, and Wikipedia links

### 7.1 Mirror arrows (Section 0)

Drawn as an SVG overlay on top of Section 0's two sentences. The SVG layer has no background; only the arrow strokes and arrowheads.

**Arrow geometry.**

- **a ↔ X (cross, long).** Cubic Bézier arc, starting under the letter label `a` and ending above the letter label `X`. The arc bows outward to the *left* of the section, reaching roughly 4mm beyond the left edge of the sentence text. Stroke `#2C5282`, 0.6pt, with a small arrowhead at the *X* end (single-headed; the arrow points from a to X).
- **d ↔ a' (cross, long).** Symmetric to the above, bowing outward to the *right*, reaching ~4mm beyond the right edge. Stroke `#9A3412`, 0.6pt, arrowhead at the *a'* end.
- **b ↔ b' (vertical, short).** A nearly-straight line from below label `b` to above label `b'`. Stroke `#6B7280`, 0.5pt, with a small arrowhead at the *b'* end.
- **c ↔ c' (vertical, short).** Symmetric, from below `c` to above `c'`. Stroke `#6B7280`, 0.5pt, arrowhead at the *c'* end.
- **d'** has no arrow. It is a position marker only (see §6.0 mirror arrows note above).

All arrowheads are filled triangles, 1.2mm × 1.2mm.

The four arrows together form a visual *bowtie shape*: two long arcs on the outside, two short verticals in the middle.

### 7.2 No other arrows

Sections A, B, A↔B, and 4 contain no arrows. The narrative flow is carried by typography and section ordering, not by arrows.

### 7.3 Wikipedia link treatment

The following terms appear in the synopsis body and are to be rendered as **italic + underlined**, with an `<a href="...">` linking to Wikipedia in the HTML version. In print, they appear italic + underlined without URL leak.

| Term as it appears in body | Wikipedia URL |
|---|---|
| *map* | https://en.wikipedia.org/wiki/Map_(mathematics) |
| *topos* | https://en.wikipedia.org/wiki/Topos |
| *adjoint* | https://en.wikipedia.org/wiki/Adjoint_functors |
| *actor model* | https://en.wikipedia.org/wiki/Actor_model |
| *session types* | https://en.wikipedia.org/wiki/Session_type |
| *cobordism hypothesis* | https://en.wikipedia.org/wiki/Cobordism_hypothesis |

*Cohesion* appears in §6.A but is rendered as plain italic emphasis only — Wikipedia has no clean target for cohesion-in-the-Lawvere-sense. The surrounding paragraph supplies the meaning (the *spread-out vs. discrete* distinction); no link is added.

Each linked term takes the link only on its *first occurrence* in the body. Subsequent occurrences are normal text. The legend (§9) names the convention so the reader understands the visual cue.

The CSS for linked terms:

```css
a.wiki {
  font-style: italic;
  text-decoration: underline;
  text-decoration-thickness: 0.4pt;
  color: inherit;
}
a.wiki:hover { color: #2C5282; }
```

---

## 8. Section ordering and dividers

Sections are stacked vertically in this exact order, with a 0.4pt `#D1D5DB` hairline rule between every pair of adjacent sections:

1. Section 0 (mirror sentences)
2. Section A
3. Section B
4. Section A↔B
5. Section 4
6. Legend strip

The hairline rule sits in the 4mm inter-section gap, vertically centred in the gap. It runs the full content width (page width minus 14mm margins on each side, i.e. 182mm long).

---

## 9. Legend strip

At the very bottom of the page (after Section 4), inside the 14mm bottom margin region — *not* inside Section 4. Width: full content width (182mm). Height: ~10mm if single-line; up to 18mm if two-line.

Background: `#F9FAFB` (page-neutral, no domain tint). Border: 0.4pt `#D1D5DB`. Padding 1.5mm × 2.5mm. Border-radius 0.6mm.

Legend content (8.5pt serif `#4B5563`):

> *Italic-underlined terms* (such as *topos*, *adjoint*, *actor model*, *session types*, *cobordism hypothesis*) are searchable on Wikipedia; in the digital version they are clickable links. — The project's full implementation status, the formalised constructions, and the proposed *Allow ⊣ Require* adjunction are shown in the companion document *Hoapa: Construction map — Allow ⊣ Require*.

The italics + underlines in the legend's first sentence themselves use the same `a.wiki` style (without a link, just the visual cue) so the convention is illustrated.

---

## 10. Spacing, alignment, and visual rhythm

- **Outer page margin**: 14mm on all sides.
- **Inter-section gap**: 4mm.
- **Section internal padding**: 3mm on all sides, inside the tinted background.
- **Inter-paragraph spacing within a section**: 1.8mm.
- **Subheading-to-following-paragraph spacing**: 1.5mm.
- **Heading-to-first-paragraph spacing**: 2.5mm.
- **Cascade table row height**: 5mm; cell padding 0.8mm × 1.5mm.
- **Justification**: body text left-aligned, *not* justified. (Justification creates uneven word spacing that distracts at this typography size.)
- **Hyphenation**: enabled (`hyphens: auto`), to keep right margins reasonably even.
- **Widow/orphan control**: avoid leaving a single line of a paragraph at the top or bottom of a column/page.

**Visual rhythm test.** When squinting at each page, the reader should see soft horizontal bands of colour distinct from their neighbours. Page 1 carries Section 0's two-tone (pale-blue over pale-terracotta) mirror band, then Section A in pale-blue. Page 2 carries Section B in pale-terracotta — one full-page band of one colour. Page 3 carries A↔B and Section 4 in slate, with the neutral legend strip at the bottom. The two sentences in Section 0 should anchor the eye on page 1; the cascade table in Section B should be the dominant visual element on page 2; the bridge prose carries page 3.

---

## 11. Print considerations

- Set `@page { size: A4 portrait; margin: 0; }` and treat each page container as `210mm × 297mm`.
- All sizes inside in `mm` or `pt`, not `px`.
- `@media print { body { -webkit-print-color-adjust: exact; print-color-adjust: exact; } a.wiki { color: inherit; text-decoration: underline; } }`.
- **Hard page breaks.** Apply `page-break-after: always` (or `break-after: page`) on the Section A container and on the Section B container. No other page breaks. Sections do not split across pages; if a section would not fit, increase its allocated page room (the page is fixed at A4 portrait, but the section can be allowed to occupy nearly the entire page minus margins). The cascade table on page 2 must sit entirely on page 2.

---

## 12. Self-test checklist (run before declaring done)

1. The file opens in a browser and renders cleanly across exactly three A4 portrait pages, with hard breaks after Section A (end of page 1) and after Section B (end of page 2).
2. Print preview at A4 portrait, margins none, shows all three pages without cropping; no content lost; no section split across pages.
3. Page 1 contains Section 0 and Section A only. Page 2 contains Section B (with its cascade table) only. Page 3 contains Section A↔B, Section 4, and the legend strip only.
4. Section 0's mirror arrows form a visible bowtie shape; the four arrows are visually distinct (two long arcs, two short verticals) and use the colours named in §4. The bottom-sentence label **X** is rendered larger/bolder than the a'/b'/c'/d' labels (per §5), making the asymmetric piece visually obvious. The label d' has no arrow.
5. All italic+underlined terms are exactly the ones listed in §7.3, and only their first occurrence carries a link. The term *cohesion* is italicised but *not* linked (per §7.3 note).
6. The cascade table in Section B has six rows in the exact order specified, with the layer names in weight-600, and sits entirely on page 2.
7. The body text matches the verbatim text in §6 exactly, character for character. (No designer rewording.)
8. In greyscale (toggle browser to greyscale), the sections remain visually distinguishable by position and heading; the italic+underline treatment of Wikipedia terms remains visible.
9. The legend strip is present at the bottom of page 3 and names the italic+underline convention.
10. No project codenames appear (no "Allow ⊣ Mediate ⊣ Require" outside the cross-reference in the legend; no Caires–Pfenning; no Markl; no Hewitt; no Lamport; no Agda paths; no module / construction / fragment labels). The synopsis is intellectual-history first, code-free.
11. The page title element is `<title>Hoapa — Synopsis</title>`.

---

## 13. Anti-goals (things the synopsis explicitly is *not*)

- Not a tutorial. No "Let me explain what a topos is." The Wikipedia hint does that work.
- Not a literature review. The biographies are *intellectual-history one-liners*, not summaries of work.
- Not the construction map. The synopsis does not show implementation status, file paths, postulate flags, or sub-modules.
- Not a sales pitch. No marketing language. No exclamation points.
- Not symmetric with the construction map. The construction map is landscape; the synopsis is portrait. The construction map foregrounds the boxes; the synopsis foregrounds the prose.
- Not interactive. The only interactivity is the Wikipedia links in HTML view.
- Not signed. No "by Jean-Charles Belouard". The synopsis is the project's voice; attribution lives elsewhere.

---

## 14. File name and page title

- File name: `synopsis_diagram.html`.
- Page title (`<title>` element): `Hoapa — Synopsis`.
- No subtitle in `<title>`. The five sections supply the rest.
