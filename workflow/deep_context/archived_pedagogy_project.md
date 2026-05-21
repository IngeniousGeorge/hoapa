---
name: pedagogy-project
description: "The pedagogy/ side project — folder mirrors agda/, walks each .agda chunk by chunk for a smart-amateur audience. Audience, style, references, and the console metaphor established with Cohesion.md as template."
metadata: 
  node_type: memory
  type: project
  originSessionId: 7380606e-b952-4e1c-94a7-67be88fdbb14
---

A side project running in parallel with the main ModalHoTT-side/Concurrency-side work: a `pedagogy/` folder at project root, mirroring `agda/` structure file-for-file where possible, with each source companion `.md` walking the corresponding `.agda` chunk by chunk.

**Why:** The instigator wants substantive, non-pedantic explanations of the formalization — both for personal use (consolidating understanding, communicating with collaborators) and as accessible material for adjacent-field readers who can't follow type-theoretic Agda directly.

**Made by agents, for humans.** Not for agent consumption. This is *why* `pedagogy/` is deliberately kept outside `workflow/`'s architecture path — loading it would clog context for agents who already know HoTT/cohesion mechanics. Workflow integration in CLAUDE.md / status.md is also deliberately omitted for the same reason.

**How to apply:** When asked to extend `pedagogy/`, follow the conventions below. When working in `agda/`, remember `pedagogy/` is downstream — significant restructurings in `agda/` may require pedagogy updates. Do not propose adding pedagogy pointers to workflow/ or CLAUDE.md without specific instigator ask — the separation is intentional.

## Audience

Smart amateur. High-school math; programs JS/Ruby as enthusiast (NOT a type theorist); has followed one intro CT course (knows objects/morphisms, what CT is to math). Profile of a biologist or engineer. The point is genuine understanding transfer, not appearing rigorous.

## Folder & file conventions

- Path mirroring with numbered reader folders: `pedagogy/01_ModalHoTT/01_Modalities/01_cohesion.md` shadows `agda/ModalHoTT/Modalities/Cohesion.agda`; `pedagogy/02_Concurrency/01_Operads/01_ports.md` shadows `agda/Concurrency/Operads/Ports.agda`.
- **Numbered folders and `NN_lowercase.md` prefixes** set a reading order. Reading order = writing order. Each file assumes the audience has read earlier intro/source files in the same folder.
- One source companion `.md` per `.agda`. The stem is the Agda module name, lowercased, prefixed with `NN_`.
- Non-mirrored `00_topic_intro.md` files are allowed when recurring concepts would otherwise create a mesh of cross-references. Treat these as a base for the folder; source companions are stems growing from it.
- A future shared `pedagogy/introduction.md` will hold the genuinely-reusable preliminaries (universes, `postulate`, `≡`, `isEquiv`, implicit args, what a modality is). **Not created yet** — first file introduces these inline; later files cross-reference. Defer creating it until at least 2–3 files exist to factor from.

## Cross-reference format

- Prefer base intro files over dense cross-reference meshes. If the same explanation wants to recur several times, extract it into a `00_topic_intro.md`.
- **Within the same folder, when a precise pointer is genuinely useful:** `(NN_§M)` — file number, section sign, chunk number. Example: `(01_§6)` points at chunk 6 of `01_cohesion.md`.
- Across folders: not yet settled; revisit when the first cross-folder reference is needed.
- Use cross-refs sparingly. They should prevent confusion, not turn the pedagogy into a web of dependencies.

## Structural conventions (per-file)

- **Substantial** situating section at the top — "context is key," not two sentences.
- Chunks: code block first, then prose. Small chunks preferred. Length per chunk is led by the hardest idea in it; padding is forbidden.
- Narrator voice: "we".
- Long explanatory names in prose; math symbol in parens on first appearance per file (e.g. "the flat modality (♭)"), reintroduced when a section has been gone a while.
- Forward pointers only when they structure understanding or give purpose. Not for painting full pictures the reader can't yet see.
- HoTT/cubical concepts taught inline at the point they bite, in small increments. Avoid nested-doll explanations; get what compactly fits, accept that not everything lands at once.
- **Full honesty** about postulates and project shortcuts. Cite `workflow/future_work.md` for known-shortcut postulates. Smoothing over the limitations is forbidden — the instigator's words: "you can't be pedagogical and sell it for something it's not at the same time."
- Track independence: Concurrency pedagogy should not require reading the ModalHoTT pedagogy first. Inside a track/folder, cumulative reading is expected.

## References

References sit **after** the paragraph they annotate, as **blockquotes with clickable links**. NOT inline parens (clogs the prose), NOT code blocks (strips clickability). Links go to arXiv, nLab, or the HoTT Book main page — or whatever seems the most natural, reliable and informative. Format:

```
> **References**
> - [Title (source)](url) — short context
> - [nLab: page name](url)
```

## The console metaphor

For chunks where the code is doing real work across multiple lines (multi-postulate modality declarations like shape/sharp): **rack-mounted lab or studio equipment** — a panel with labeled jacks, indicator lamps, calibration LEDs, dials, unsoldered slots. The first use of "console" must specify the kind explicitly (e.g. "the front face of a piece of rack-mounted lab or studio equipment"). Vocabulary:

- type-former / operator → declaration of the console family (one console per input type)
- unit / counit → entry / exit jack (direction flags monad vs comonad)
- `IsXModal` predicate → indicator lamp ("lit" = type is already in this modality's image)
- recursor with precondition → output jack with precondition (the precondition is the whole game — without it the modality would be transparent)
- β-rule → calibration LED (entry/exit jacks compose consistently)
- missing operation (e.g. `shape-ind`) → unsoldered slot
- adjunction (`⊣`) → patch cable between two consoles
- the cohesive setting → patched-together rack of three consoles
- the semantic model (e.g. Bℤ) → wiring behind the panel; deliberately not described in the file

When a smaller chunk already reads cleanly without the metaphor, **do not rewrite** — add a small seeding paragraph that hints at the image, then deploy the metaphor fully in the larger chunk that earns it. Seed early-ish, deploy late, harvest at the close.

Generic words like "apparatus," "system," "machine" were tried and rejected as too vague — no image to latch onto. The metaphor needs a *specific* picture.

If more appropriate metaphors are possible in a given context, make suggestions to the instigator.

## What's done

- `pedagogy/01_ModalHoTT/01_Modalities/01_cohesion.md` — first file, template for subsequent ones. 12 chunks plus a substantial situating section; references in blockquote form; console metaphor seeded at chunks 4 and 9, deployed at 10/11, harvested at 12.
- `pedagogy/01_ModalHoTT/01_Modalities/02_adjunctions.md` — existing ModalHoTT source companion, moved under the numbered reader path with `01_cohesion.md`.
- `pedagogy/02_Concurrency/00_concurrency_intro.md` — top-level Concurrency intro from the implementation standpoint: actors, conversations, protocols, consensus artifacts, separation of concerns, current Agda layers, and relation to ModalHoTT.
- `pedagogy/02_Concurrency/01_Operads/` — complete for current `agda/Concurrency/Operads/`: `00_cyclic_operads_intro.md`, `01_ports.md`, `02_rawcyclicoperad.md`, `03_portgluing.md`, `04_portrotation.md`, `05_cyclicassociative.md`.
- `pedagogy/02_Concurrency/02_Algebras/` — complete for current `agda/Concurrency/Algebras/`: `00_algebras_intro.md`, `01_starautonomous.md`, `02_valuation.md`, `03_operadalgebra.md`, `04_sessions.md`.
- `pedagogy/02_Concurrency/03_Sites/` — complete for current `agda/Concurrency/Sites/`: `00_actor_sites_intro.md`, `01_actorbase.md`, `02_actorcausal.md`.
- `pedagogy/02_Concurrency/04_Hybrid/` — complete for current `agda/Concurrency/Hybrid/`: `00_hybrid_intro.md`, `01_presheaf.md`, `02_sessionpresheaf.md`.
- `pedagogy/**/*.pdf` gitignored. Rendered PDFs are local artifacts, not part of the repo.

## Open / deferred

- No `Analytic/` or `AnalyticTest/` pedagogy track for now. Concurrency is complete for the current `agda/Concurrency/` tree; remaining pedagogy work is the still-unmirrored ModalHoTT files, unless new Concurrency files are added.
- `pedagogy/introduction.md` — still not on disk. Track-local `00_topic_intro.md` files have absorbed the Concurrency repetition for now; create a shared intro only if future ModalHoTT/Concurrency work reveals genuinely common preliminaries.

## Tonal notes

- Friendly, dry, occasionally wry. Not patronizing, not effusive.
- No "imagine if..." patter, no "don't worry, it's not that hard!" reassurance.
- The instigator values honest writing about limitations.
- Short Ruby/JS analogies where they actually help (sealed class, default parameter); avoid forced ones.
