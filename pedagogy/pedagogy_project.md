---
name: pedagogy-project
description: "Instruction manual for extending pedagogy/: audience, style, folder conventions, current status, and the next ModalHoTT work."
metadata:
  node_type: memory
  type: project
---

# Pedagogy Project Manual

This file is the handoff manual for the `pedagogy/` side project. Treat it as the first thing to read when context has been cleared and the user asks you to continue the pedagogy work.

The short version: `pedagogy/` explains the Agda formalization to humans who are mathematically curious but not type theorists. It mirrors `formal/` where possible. Each source companion walks one `.agda` file chunk by chunk, with enough context that a motivated reader can understand what the formalization is doing and why the project made the choices it made.

Do not treat this as agent-facing architecture. The workflow files are for that. This file is about how to write the human-facing explanations.

## What This Project Is

The main repository develops two mathematical sides:

- `formal/ModalHoTT/`: the cohesive/modal HoTT side, currently synthetic and axiomatic.
- `formal/Concurrency/`: the concurrency side, currently actor-causal locality plus session-valued content plus an operadic interaction layer.

The `pedagogy/` folder runs beside the code. Its job is not to prove new results. Its job is to make the Agda readable to the instigator and to adjacent readers who care about the ideas but cannot parse cubical Agda directly.

Every pedagogy file should answer three questions:

1. What is this source file trying to add to the project?
2. What does each important code chunk say?
3. Where are the shortcuts, postulates, or architectural gaps?

The answer should be honest, detailed, and readable. It should not be a textbook chapter. It should not be a compressed proof assistant log. It should feel like a patient expert walking through the source with the reader, saying what matters and when to slow down.

## Audience

Write for a smart amateur.

Assume:

- high-school mathematics;
- programming as a serious enthusiast, roughly JS/Ruby level;
- maybe one introductory category theory course;
- curiosity about math and systems;
- no working knowledge of HoTT, cubical Agda, session types, operads, or sheaf theory.

Do not write for working mathematicians. Do not write for type theorists. Do not write for agents.

The goal is genuine understanding transfer. The reader should come away able to explain the shape of the file and the role of the postulates in ordinary language. They do not need to be able to reconstruct every proof term.

Practical implication: when a type-theoretic concept bites, explain it there in a small dose. Do not launch into nested prerequisites. For example:

- `≡`: "path/equality type; read as equality, but in HoTT an equality is itself data."
- implicit args `{A : Type ℓ}`: "Agda infers this from context."
- `isEquiv`: "proof that a map behaves as an equivalence, with coherent inverse data."
- `postulate`: "declared axiom; Agda trusts it, we did not build it."
- universe levels: "Agda has a tower of type universes to avoid paradoxes; these variables keep the file polymorphic."

Give just enough to read the chunk. The reader can accumulate the language over files.

## The Most Important Tone Rule

Be honest about limitations.

The user has been explicit: you cannot be pedagogical and sell the formalization for something it is not at the same time.

So when the code postulates something, say so. When a theorem is true in the intended model but not derived in Agda, say so. When an analytic check is degenerate or only sanity-checks non-emptiness, say so. When the file is a scaffold rather than a finished theory, say so.

This does not mean apologizing every paragraph. It means naming the exact status:

- "proved here";
- "postulated here, theorem in real-cohesive HoTT";
- "postulated because Agda lacks crisp contexts";
- "blocked on dependent induction for shape/sharp";
- "structural result, not the content-bearing de Rham theorem";
- "current v1 interface, not final calculus."

That precision is what makes the pedagogy trustworthy.

## Folder Conventions

Use numbered reader folders.

Current top-level pedagogy folders:

```text
pedagogy/
  pedagogy_project.md
  01_ModalHoTT/
  02_Concurrency/
```

The numbering is reader order, not Agda module order. It was introduced because readers need to know where to start.

Mirror `formal/` as much as possible inside those numbered folders:

```text
formal/ModalHoTT/Modalities/Cohesion.agda
pedagogy/01_ModalHoTT/01_Modalities/01_cohesion.md

formal/Concurrency/Operads/Ports.agda
pedagogy/02_Concurrency/01_Operads/01_ports.md
```

One source companion `.md` per `.agda` file. The companion stem is the lowercased Agda module name, prefixed by the reading number.

Non-mirrored `00_*_intro.md` files are allowed and encouraged when they prevent repeated explanations. They are base files; source companions are stems growing from them.

The Concurrency track now has a top-level intro:

```text
pedagogy/02_Concurrency/00_concurrency_intro.md
```

The ModalHoTT track currently does not have a `00_modalhott_intro.md`. Do not create one reflexively. `01_cohesion.md` already functions as the on-ramp for the modalities folder. If repetition gets painful later, propose a `00_modalities_intro.md`, but do not reorder existing files unless the user asks.

## Current State

ModalHoTT pedagogy currently has two source companions:

```text
pedagogy/01_ModalHoTT/01_Modalities/01_cohesion.md
pedagogy/01_ModalHoTT/01_Modalities/02_adjunctions.md
```

There is also an ignored PDF artifact:

```text
pedagogy/01_ModalHoTT/01_Modalities/02_adjunctions.pdf
```

`pedagogy/**/*.pdf` is gitignored. Do not worry about PDFs unless the user asks to render them.

Concurrency pedagogy is complete for the current `formal/Concurrency/` tree:

```text
pedagogy/02_Concurrency/00_concurrency_intro.md
pedagogy/02_Concurrency/01_Operads/
pedagogy/02_Concurrency/02_Algebras/
pedagogy/02_Concurrency/03_Sites/
pedagogy/02_Concurrency/04_Hybrid/
```

Do not continue into `formal/Analytic/` or `formal/AnalyticTest/` for pedagogy unless the user explicitly changes the plan. The user has said not to cover the Analytic track in the pedagogy files for now.

## Current Modal Source Inventory

As of this handoff, current ModalHoTT source files are:

```text
formal/ModalHoTT/Modalities/Cohesion.agda
formal/ModalHoTT/Modalities/Adjunctions.agda
formal/ModalHoTT/Modalities/Discrete.agda
formal/ModalHoTT/Modalities/Properties.agda
formal/ModalHoTT/Modalities/Fracture.agda
formal/ModalHoTT/Modalities/Iteration.agda
formal/ModalHoTT/Modalities/IterationCohesion.agda
formal/ModalHoTT/Cohomology/FlatCoefficients.agda
```

Already covered:

```text
Cohesion.agda    -> 01_cohesion.md
Adjunctions.agda -> 02_adjunctions.md
```

Still uncovered:

```text
Discrete.agda
Properties.agda
Fracture.agda
Iteration.agda
IterationCohesion.agda
FlatCoefficients.agda
```

## Recommended Next Modal Order

If the user asks for "the next Modal files," start with:

```text
03_properties.md
04_fracture.md
```

Reason: `02_adjunctions.md` explicitly points forward to `Properties.agda` and `Fracture.agda`. Those are the next conceptual files in the cohesive rack story.

After that, continue:

```text
05_discrete.md
06_iteration.md
07_iterationcohesion.md
```

Then create the Cohomology folder:

```text
pedagogy/01_ModalHoTT/02_Cohomology/01_flatcoefficients.md
```

This is not the only possible order, but it is the most reader-friendly one:

1. `Properties` extends the modalities into functors and names the naturality postulate used later.
2. `Fracture` uses those properties to state the fracture pullback theorem.
3. `Discrete` is a bridge file used by iteration; it is conceptually side infrastructure, not the main fracture path.
4. `Iteration` introduces the generic T-recursion scaffold.
5. `IterationCohesion` specializes it back to `ʃ ⊣ ♭` and uses the discrete bridge.
6. `FlatCoefficients` is the cohomology/de Rham structural result.

If the user says "there are only two Modal files," interpret that as "there are only two existing Modal pedagogy files to use as models," not as "only two Modal source files exist." Check the source tree before deciding scope.

## Source Files To Read Before Writing

Before writing any new Modal companion, read:

1. the corresponding `.agda` source file;
2. every earlier source file it imports from `ModalHoTT/Modalities`;
3. the existing companions `01_cohesion.md` and `02_adjunctions.md`;
4. relevant workflow context:

```text
workflow/status_formal.md
workflow/future_work.md
workflow/targets.md
workflow/arc.md
```

You do not need to bulk-read all of `workflow/deep_context/`. Use it only if a source header points there or if a term in `status_formal.md` is unclear.

Useful workflow facts:

- ModalHoTT is currently synthetic/axiomatic.
- The intended semantic background is `Bℤ`, the delooping of the integers.
- `Bℤ ≃ S¹` as ∞-groupoids, but the project foregrounds the algebraic/covering structure of ℤ.
- `flat-intro` is too strong synthetically because real-cohesive HoTT requires crisp contexts.
- Shape/sharp dependent induction is missing, so several things are postulates rather than theorems.
- The de Rham ladder has three levels: structural, named-coefficient, differential. Current `FlatCoefficients.agda` is structural.
- Differential cohesion is not implemented.
- The cross-site bridge to Concurrency is future work.

## How To Structure A Companion File

Use this shape unless there is a strong reason not to:

````markdown
# SourceFile.agda - readable title

## Where This File Sits

Several paragraphs of context.

## Chunk 1 - pragma, module, imports

```agda
...
```

Explanation.

## Chunk 2 - ...
````

The top situating section should be substantial. "Context is key" is a standing preference. Do not give the reader two sentences and then dump code.

Chunks should be led by code blocks first, then prose. This pattern is important. The reader sees the actual source chunk, then gets the explanation.

Chunk sizes should be as small as the idea allows. Do not pad. Do not split so aggressively that every field gets its own microscopic heading. The right unit is "one idea the reader can hold."

Use narrator voice "we" when it fits:

- "We now install the second cable."
- "We should not read this as a theorem."
- "We can now see why the later postulate is needed."

Do not write as an omniscient textbook voice. The existing files sound like a person walking with the reader through the source.

## Cross-References

The project prefers base intros over dense cross-reference meshes.

Within one folder, if a precise pointer helps, use:

```text
(NN_§M)
```

Example:

```text
(01_§6)
```

This points to chunk 6 of `01_cohesion.md`.

Use these sparingly. They should prevent confusion, not turn the file into a web of dependencies.

Across folders, the format is not settled. Avoid cross-folder references unless necessary. Use plain file names when possible:

```text
`FlatCoefficients.agda`
```

## Reference Style

References go after the paragraph they annotate, as blockquotes with clickable links.

Use this format:

```markdown
> **References**
> - [Title (source)](url) - short context
> - [nLab: page name](url)
```

Avoid inline parenthetical citations. They clog the prose. Avoid code blocks for references; they strip clickability.

Reliable sources:

- The HoTT Book;
- nLab pages;
- arXiv papers;
- official Cubical Agda library pages when explaining library constructs;
- the papers already cited in the existing files.

For ModalHoTT, recurring references include:

- Rijke, Shulman, Spitters, *Modalities in homotopy type theory*;
- Shulman, *Brouwer's fixed-point theorem in real-cohesive HoTT*;
- Schreiber, *Differential cohomology in a cohesive ∞-topos*;
- Lawvere, *Axiomatic cohesion*;
- The HoTT Book;
- nLab pages for modality, adjunction, cohesive ∞-topos, shape/flat/sharp.

If you need exact URLs and are not sure, browse. Do not invent citation details.

## The Console Metaphor

The existing Modal files use a specific metaphor for the three modalities: rack-mounted lab or studio equipment.

Keep it. Do not replace it with a vague "machine" or "system."

Vocabulary already established:

- type-former / operator -> declaration of the console family;
- unit / counit -> entry / exit jack;
- `IsXModal` predicate -> indicator lamp;
- recursor with precondition -> output jack with precondition;
- β-rule -> calibration LED;
- missing operation (`shape-ind`, `sharp-ind`) -> unsoldered slot;
- adjunction (`⊣`) -> patch cable between consoles;
- cohesive setting -> patched-together rack of consoles;
- semantic model (`Bℤ`) -> wiring behind the panel, deliberately not described as an Agda object.

Use the metaphor where it helps. Do not force it into every paragraph. The best use pattern from `01_cohesion.md` is:

1. seed it lightly before the big modality blocks;
2. deploy it fully when shape/sharp are introduced;
3. harvest it in the adjunction file where cables connect the consoles.

For `Properties.agda`, the metaphor can naturally become: "now we learn how each console transports maps, and which calibration laws are proved or still assumed."

For `Fracture.agda`, it can become: "the patched rack determines a pullback square; the square commutes by one proven cable law, but the pullback equivalence itself is a postulated structural property."

Do not let the metaphor conceal the math. It is a handle, not a substitute.

## Technical Honesty For ModalHoTT

These are the main technical statuses to preserve exactly.

### Cohesion.agda

`Cohesion.agda` postulates:

- `FlatModality`;
- `ShapeModality`;
- `SharpModality`;
- their units/counits/recursors;
- `flat-ind`;
- β/roundtrip rules.

`IsFlatModal`, `IsShapeModal`, and `IsSharpModal` are definitions using `isEquiv`, not postulates.

The major caveat is `flat-intro`. In real-cohesive HoTT, flat introduction is only valid in a crisp context. Agda has no native crisp contexts, so the project postulates it unconditionally. This is a known over-approximation. Do not smooth it over.

Shape and sharp have non-dependent recursors, not dependent induction principles. The missing `shape-ind` and `sharp-ind` are the root cause of later postulates.

### Adjunctions.agda

`Adjunctions.agda` postulates hom-set equivalences:

```agda
flat-sharp-transpose : (♭A -> B) ≃ (A -> ♯B)
shape-flat-transpose : (ʃA -> B) ≃ (A -> ♭B)
```

and coherence equations pinning those equivalences to the existing unit/counit structure.

Named operations like `flat-to-sharp`, `sharp-to-flat`, `shape-to-flat`, `flat-to-shape` are definitions extracted from the equivalences, not new postulates.

`flat-modality-idempotent` is a real theorem. It uses `flat-ind` and `flat-counit-intro`.

`sharp-modality-idempotent` and `shape-modality-idempotent` are postulated because the corresponding dependent eliminators are absent.

Naturality of the adjunction equivalences is not globally recorded here. The one piece currently needed is `shape-flat-natural-B` in `Properties.agda`.

### Properties.agda

This file extends each modality to map functions:

- `flat-map`;
- `shape-map`;
- `sharp-map`.

For flat:

- `flat-map` is defined using `flat-ind`;
- `flat-map-id` is proved;
- `flat-map-comp` is proved;
- `flat-counit-natural` is proved.

For shape and sharp:

- `shape-map` and `sharp-map` are definable using non-dependent recursion plus idempotency;
- their identity/composition laws are postulated because proofs require dependent elimination over `ʃA` or `♯A`.

This file also postulates:

```agda
shape-flat-natural-B
```

This is naturality of the `ʃ ⊣ ♭` transpose in the right-hand variable. It is load-bearing for pinning the structural de Rham equivalence in `FlatCoefficients.agda`.

Do not describe it as a random convenience postulate. It is exactly the missing naturality data for the adjunction package.

### Discrete.agda

This is a small bridge file.

It postulates the coincidence of flat-modal and shape-modal types:

```agda
flat-modal-to-shape-modal : IsFlatModal A -> IsShapeModal A
shape-modal-to-flat-modal : IsShapeModal A -> IsFlatModal A
```

The intended reading: in a cohesive ∞-topos, flat-modal and shape-modal pick out the same "discrete" types.

Both directions are postulated:

- flat-modal to shape-modal is blocked by missing dependent `ʃ` induction;
- shape-modal to flat-modal is blocked by the missing crisp η direction `flat-intro ∘ flat-counit ≡ id`.

The file is used by `IterationCohesion.agda` to prove the first-level collapse of the `ʃ ⊣ ♭` iteration. It is not part of the main fracture proof.

### Fracture.agda

This file states the fracture theorem for cohesive HoTT.

It defines:

```agda
FracturePullback A =
  Σ[ a ∈ A ] Σ[ u ∈ FlatModality (SharpModality A) ]
    sharp-unit a ≡ flat-counit u
```

It proves the square commutes using:

```agda
flat-counit-natural sharp-unit
```

Then it defines the canonical map:

```agda
flat-to-pullback : ♭A -> FracturePullback A
```

and postulates:

```agda
fracture : isEquiv (flat-to-pullback A)
```

This is the one new postulate in the file. In real-cohesive HoTT, fracture follows from sharp being lex, but the project does not postulate sharp-lex separately. It postulates the exact pullback equivalence needed.

Be clear: the commutativity of the square is proved; the pullback equivalence is postulated.

Also be clear about synthetic/analytic asymmetry. The interesting instance at `Bℤ` cannot be analytically checked because `♯(Bℤ)` is not constructed in the analytic mirror. The analytic side only verifies trivial/degenerate cases. This is a known limitation.

### Iteration.agda

This is a generic scaffold for `T_recursion`.

It is parameterized by:

- `L`;
- `R`;
- `L-map`;
- `R-map`;
- unit `η : A -> R (L A)`.

It defines:

- `T = R ∘ L`;
- `T-map`;
- n-fold iteration `T^ n`;
- iterated unit `η^ n`;
- a sequence `A -> T A -> T² A -> ...`;
- `ND A` as the sequential colimit of that sequence.

It postulates:

```agda
η-naturality
```

because the generic interface does not bundle naturality. This is the same family of gap as `shape-flat-natural-B`.

Do not oversell `ND A`. It is a scaffold for the developing network. The cross-site adjunction is not yet in Agda, so the genuinely interesting instance is not available.

### IterationCohesion.agda

This is a sanity check.

It instantiates the generic iteration module with the A-side adjunction:

```agda
L = ShapeModality
R = FlatModality
η = flat-intro ∘ shape-unit
```

It proves:

- `T A` computes to `♭(ʃ A)`;
- `η^1` computes to the adjunction unit;
- `T A` is flat-modal by `flat-modality-idempotent`;
- `T A` is shape-modal using the `Discrete.agda` bridge;
- the first iterate step `T A -> T(T A)` is an equivalence.

It does not prove:

- full `ND A ≃ T A`;
- a concrete result at `A := Bℤ`.

The right explanation: this file checks that the iteration scaffold composes with the existing cohesion postulates and collapses in the expected trivial A-side case. It is not the final cross-site recursion theorem.

### FlatCoefficients.agda

This is in `formal/ModalHoTT/Cohomology/`, not `Modalities/`.

It defines:

```agda
FlatCohomology A B = ShapeModality A -> B
```

Then it proves the structural equivalence:

```agda
flat-coefficients-factor :
  IsFlatModal B -> FlatCohomology A B ≃ (A -> B)
```

This uses the `ʃ ⊣ ♭` adjunction and the fact that `B` is flat-modal.

The pin:

```agda
flat-coefficients-factor-pin
```

shows the forward map of the equivalence is the canonical precomposition by `shape-unit`. The pin uses `shape-flat-natural-B`, `shape-flat-adj-unit-eq`, `flat-counit-natural`, and `flat-counit-intro`.

This is the structural level of the de Rham ladder. It is not the content-bearing differential de Rham theorem. It does not define differential forms. It does not introduce `ℝ`. It does not implement differential cohesion.

## The De Rham Ladder

When explaining `Fracture.agda` or `FlatCoefficients.agda`, keep the de Rham ladder straight.

There are three levels:

1. Structural: use the existing `ʃ ⊣ ♭` adjunction. This is what `FlatCoefficients.agda` does.
2. Named-coefficient: postulate a cohesive type `ℝ` and instantiate at `♭ℝ`. This would be mostly rhetorical unless more structure is added.
3. Differential: add differential cohesion modalities (`ℜ ⊣ ℑ ⊣ &`) and define actual differential forms. This is the content-bearing de Rham theorem, but it is a separate future phase.

Do not claim the current ModalHoTT files prove the classical de Rham theorem. They prove a structural modal equivalence that has the right shape to support the de Rham arc.

## What Not To Do

Do not cover `formal/Analytic/` or `formal/AnalyticTest/` in pedagogy unless the user explicitly asks. The current instruction is to skip Analytic pedagogy.

Do not add pedagogy pointers to `workflow/`, `CLAUDE.md`, or status files unless specifically asked. `pedagogy/` is deliberately downstream and human-facing.

Do not rewrite existing Modal companions just because you would phrase them differently. They are the tuned examples. Use them as models.

Do not make each file self-sufficient. Within a track, readers are expected to read in order. If an explanation would repeat across several files, consider an intro file or a short backward pointer.

Do not flood the text with cross-references. The user explicitly prefers "base + stems" over a mesh.

Do not invent mathematical closure. If a bridge is missing, say it is missing.

Do not use "this is easy" reassurance. It is not helpful. Explain what is happening.

Do not write for prestige. Avoid prose that sounds like a paper abstract unless the source itself demands it.

Do not overuse programming analogies. A Ruby/JS analogy is useful for implicit parameters or sealed constructors. It is not useful for every categorical construction.

## Judgment Calls I Would Make

These are opinions, but they are informed by the current state of the files.

Do `Properties` and `Fracture` next. They are the natural continuation of the two existing Modal companions. `Discrete` is important, but it is side infrastructure for iteration; putting it before `Properties` would make the reader detour before the cohesive-rack story has paid off.

Do not create a Modal top-level intro before writing `Properties`. `01_cohesion.md` is already a strong intro. A new `00_modalities_intro.md` may become useful later, but creating it now risks re-explaining what `01_cohesion.md` already does well.

Do not follow alphabetic order. Follow dependency and reader order. Alphabetic order would put `Discrete` too early and `Properties` too late.

Keep `FlatCoefficients` modest. It is tempting to write it as the arrival of de Rham theory. Resist that. It is the structural rung: important because it is only stateable with the modalities, but not the classical theorem about differential forms.

If the user asks for a broad continuation ("finish ModalHoTT" or "do the next batch"), propose a short plan before writing unless they explicitly say to just proceed. The user cares about order and pedagogical shape. A plan with file order and rationale is useful, not bureaucracy.

If you feel repeated concepts are building up, stop and consider an intro file. The user prefers "base + stems" over a mesh of cross-references. But do not extract just to look organized; extract only when repetition is actually getting in the way.

## Practical Work Routine

When asked to continue the pedagogy:

1. Check the current source tree:

```bash
find formal/ModalHoTT -type f | sort
find pedagogy/01_ModalHoTT -maxdepth 4 -type f | sort
```

2. Read this file.

3. Read the two existing Modal companions:

```text
pedagogy/01_ModalHoTT/01_Modalities/01_cohesion.md
pedagogy/01_ModalHoTT/01_Modalities/02_adjunctions.md
```

4. Read the source file you will write about and its imports.

5. Read relevant workflow status:

```text
workflow/status_formal.md
workflow/future_work.md
workflow/targets.md
```

6. Write the companion file using `apply_patch`.

7. Review for:

- code fences balanced;
- headings readable;
- references clickable;
- no stale unnumbered paths;
- no false claims about postulates;
- no accidental Analytic-track expansion;
- numbering consistent with reader order.

8. Run simple checks:

```bash
find pedagogy -maxdepth 4 -type f | sort
wc -l pedagogy/01_ModalHoTT/01_Modalities/*.md
rg -n "AnalyticTest|formal/Analytic|pedagogy/ModalHoTT|pedagogy/Concurrency" pedagogy
git status --short pedagogy
```

The `rg` command may find legitimate mentions of "Analytic" in explanations of limitations. That is fine. What you are checking for is accidental creation of an Analytic pedagogy track or stale old paths.

## Existing Models

`01_cohesion.md` is the strongest model for:

- substantial opening context;
- teaching HoTT concepts inline;
- explaining postulates without apology or evasion;
- deploying the rack-mounted console metaphor;
- references in blockquote form;
- ending by pointing to the next file.

`02_adjunctions.md` is the strongest model for:

- cumulative writing that assumes the previous file;
- using `(01_§M)` cross references sparingly;
- explaining equivalences via their projections;
- distinguishing postulates from derived definitions;
- showing how one actual theorem uses earlier postulates.

The Concurrency files are useful for:

- folder intros;
- track-level reading order;
- not making every source companion self-contained;
- practical top-level framing (`00_concurrency_intro.md`).

But do not import Concurrency's voice wholesale into ModalHoTT. The Modal files are more technical and more metaphor-driven because the source is axiomatic HoTT.

## Suggested Shapes For The Next Two Files

### `03_properties.md`

Likely title:

```markdown
# Properties.agda - functoriality of the cohesion modalities
```

Opening context:

- We have installed the consoles and patched them into a rack.
- Now each modality must act on maps, not just on types.
- Flat can prove its map laws because it has dependent induction.
- Shape and sharp can define maps but must postulate laws because their dependent eliminators are missing.
- This file also records the one naturality postulate currently needed downstream.

Suggested chunks:

1. pragma/module/imports;
2. file preamble;
3. `flat-map`;
4. `flat-map-id`;
5. `flat-map-comp`;
6. `flat-counit-natural`;
7. `shape-flat-natural-B`;
8. `shape-map`;
9. `shape-map-id` / `shape-map-comp` postulates;
10. `sharp-map`;
11. `sharp-map-id` / `sharp-map-comp` postulates;
12. closing: proved vs postulated inventory.

Technical emphasis:

- `flat-map f` is defined by eliminating out of `♭A`, applying `f`, then reintroducing into `♭B`.
- `flat-map-id` and `flat-map-comp` are path-valued dependent goals, hence `flat-ind` can handle them.
- `flat-counit-natural` is important because `Fracture.agda` uses it to prove square commutativity.
- `shape-flat-natural-B` is an adjunction naturality gap, not an arbitrary lemma.

### `04_fracture.md`

Likely title:

```markdown
# Fracture.agda - the cohesive pullback square
```

Opening context:

- This is the structural theorem that the cohesive rack is supposed to satisfy.
- The file proves the square commutes.
- The file postulates that the canonical map into the pullback is an equivalence.
- This is justified by real-cohesive HoTT, where fracture follows from sharp being lex.
- It is one of the sharpest places where synthetic and analytic tracks diverge.

Suggested chunks:

1. header comment and status;
2. imports;
3. `FracturePullback`;
4. `fracture-square-commutes`;
5. `flat-to-pullback`;
6. `fracture` postulate;
7. `fracture-equiv`;
8. closing: what is proved, what is postulated, why this matters for de Rham.

Technical emphasis:

- Explain nested `Σ` as dependent pairs: a point of the pullback is `a`, `u`, and a path saying their images in `♯A` agree.
- The square commutes by `flat-counit-natural sharp-unit`.
- `sym` orients the path the way the pullback type expects.
- Pinning matters: `fracture` is not just "there exists some equivalence"; it is `isEquiv` of the named map `flat-to-pullback`.

## If Asked To Finish All Current ModalHoTT

After `Properties` and `Fracture`, continue with:

### `05_discrete.md`

Treat it as a bridge file, not the main storyline. Explain "discrete" as the overlap of flat-modal and shape-modal. Be explicit that both directions are postulated and why.

### `06_iteration.md`

Treat it as generic infrastructure. Avoid letting it sound like the cross-site theorem has landed. Explain the induced monad `T = R ∘ L`, the n-fold iteration, the iterated unit, and `ND` as a sequential colimit.

### `07_iterationcohesion.md`

Treat it as a sanity check. It instantiates the generic scaffold with `ʃ ⊣ ♭` and proves first-level collapse. Emphasize what it does not prove: full colimit collapse and concrete `Bℤ` instance.

### `02_Cohomology/01_flatcoefficients.md`

Create the folder if needed. This is no longer inside `01_Modalities`.

Treat it as the structural rung of the de Rham ladder. Explain `FlatCohomology A B = ʃA -> B`, `flat-coefficients-factor`, and the pin. Do not pretend this is classical de Rham.

## Final Reminder

The task is not to make the project sound finished. The task is to make the reader understand exactly what has been formalized, what has been assumed, what is deferred, and why the current pieces are arranged this way.

If a fresh agent follows this manual, reads the two existing Modal companions, and respects the postulate status of the source files, it should be able to continue the ModalHoTT pedagogy without needing any hidden context from the chat that produced this file.

› Thanks for your amazing work! Anything you'd like to add before we clear context?

• Only this:

  The next agent should start with pedagogy/pedagogy_project.md, then read the two existing Modal companions before writing anything. The next best move is 03_properties.md, then 04_fracture.md;
  don’t let them jump to Discrete just because it is small.

  The main thing to preserve is the honesty gradient: what is proved, what is postulated, what is justified by real-cohesive HoTT, and what is only structural rather than content-bearing. That is the
  soul of the pedagogy track.

  And personally: the Concurrency intro was the right correction. It makes the whole track much more humane to enter.