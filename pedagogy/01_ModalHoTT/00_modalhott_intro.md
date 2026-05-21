# ModalHoTT intro - perspectives as the synthetic side

The ModalHoTT side is the part of the framework that talks about perspective, approximation, and changes of viewpoint. It is written in Homotopy Type Theory, where types behave like spaces rather than like plain collections of values. A type has points, paths between points, paths between paths, and so on. That extra structure is what lets the project talk about shape, discreteness, and cohesion in a precise way.

The current ModalHoTT files are synthetic. That means they postulate the modal structure directly instead of constructing it from a concrete semantic model inside Agda. The intended background is cohesive HoTT, with the site `Bℤ` in view, but the site itself is not an Agda object in the synthetic track. The files name the operations the theory should have, state their laws, prove what the current eliminators can prove, and mark the rest as postulates.

In practical terms, this side is the language of viewpoints. A mathematical object can be read through different lenses: as a discrete object, as its homotopy shape, or as a codiscrete object where points are maximally connected. The ModalHoTT track gives those lenses names and studies how they compose.

## A Practical Run

A single run through the ModalHoTT side might look like this.

Start with a type `A`. In ordinary programming, you might ask what values of `A` are. In HoTT, you also ask what equalities and higher paths live inside `A`. The ModalHoTT side then asks how `A` looks from different perspectives.

The flat view, written `♭A`, keeps the discrete reading. It is the view where we suppress continuous or cohesive structure and retain the point-like information.

The shape view, written `ʃA`, keeps the homotopy skeleton. It remembers the path structure, but forgets the fine cohesive geometry behind it.

The sharp view, written `♯A`, is the codiscrete or maximally connected view. It is the least developed leg in the current project, but it is essential for the fracture theorem and for the longer de Rham arc.

The files then wire these views together. The adjunctions `♭ ⊣ ♯` and `ʃ ⊣ ♭` say that maps expressed from one viewpoint correspond to maps expressed from another. Once those correspondences are in place, the project can state structural facts: modalities act on functions, certain squares commute, and flat-coefficient cohomology factors through shape.

## The Separation of Concerns

The ModalHoTT side is built around one strict separation:

- synthetic modalities are axioms and postulate-relative theorems;
- analytic files are separate sanity checks, not the current pedagogy target;
- modal operations live in the `Modalities` folder;
- cohomological consequences live in the `Cohomology` folder;
- cross-site interaction with Concurrency is future work.

This is not just folder hygiene. It prevents a common modeling failure.

If the synthetic files pretend to construct the modalities, then the reader misses which claims are axioms. If analytic checks are mixed into the pedagogy at this stage, the main modal story becomes hard to follow. If the de Rham material is presented as differential geometry too early, the structural result looks stronger than it is. If the cross-site bridge is treated as already built, then the ModalHoTT and Concurrency sides collapse into a story the code does not yet support.

So the project keeps the layers apart.

Modalities answer "which viewpoint are we taking?" Adjunctions answer "how do maps in one viewpoint correspond to maps in another?" Fracture answers "how do flat, sharp, and the original type fit together as a pullback?" Flat coefficients answer "what structural cohomology statement follows from `ʃ ⊣ ♭`?"

## Types as Spaces

Homotopy Type Theory changes the basic reading of a type.

A type is not just a set of values. It behaves like a space. Its inhabitants are points. Equalities between inhabitants are paths. Equalities between equalities are higher paths. This matters because modal structure is about what parts of that space-like behavior are visible from a given perspective.

The equality symbol in the Agda files is:

```agda
_≡_
```

It can often be read as equality, but technically it is a path type. When a file proves `x ≡ y`, it constructs a path from `x` to `y`.

> **References**
> - [The HoTT Book](https://homotopytypetheory.org/book/) - the standard reference for types as spaces and equality as paths.
> - [nLab: homotopy type theory](https://ncatlab.org/nlab/show/homotopy+type+theory) - background on the interpretation.

## The Three Modalities

The first ModalHoTT folder starts with three modalities:

```text
♭  flat
ʃ  shape
♯  sharp
```

A modality is an operation on types. It takes a type and returns a filtered version of that type. The filter is not arbitrary. It comes with entry or exit maps, eliminators, beta rules, and a predicate saying when a type is already fixed by the modality.

`Cohesion.agda` postulates the three modalities and their basic operations. It is the floor of the synthetic track. The file is honest about the largest shortcut: `flat-intro` is postulated unconditionally, while real-cohesive HoTT allows it only in a crisp context. Agda does not natively support crisp contexts, so the project records the intended operation as an axiom.

The existing companion `01_Modalities/01_cohesion.md` walks through these postulates in detail.

> **References**
> - [Rijke, Shulman, and Spitters, *Modalities in homotopy type theory*](https://arxiv.org/abs/1706.07526) - modal operators in HoTT.
> - [Shulman, *Brouwer's fixed-point theorem in real-cohesive HoTT*](https://arxiv.org/abs/1509.07584) - real-cohesive HoTT and crisp variables.
> - [nLab: cohesive homotopy type theory](https://ncatlab.org/nlab/show/cohesive+homotopy+type+theory) - the cohesive setting.

## Adjunctions and Functoriality

The three modalities are not independent. They are wired together by two adjunctions:

```text
♭ ⊣ ♯
ʃ ⊣ ♭
```

An adjunction is a structured correspondence between function types. In this track, it says that certain ways of mapping out of one modal view match certain ways of mapping into another modal view.

The file `Adjunctions.agda` installs those correspondences as postulated equivalences, then derives named operations from them. It also proves that `♭A` is always flat-modal. The matching idempotency facts for `ʃA` and `♯A` are postulated because the synthetic track does not yet include dependent induction principles for shape and sharp.

The file `Properties.agda` then asks whether the modalities act on functions. Flat is the clean case: `flat-map`, its identity law, its composition law, and naturality of `flat-counit` are proved. Shape and sharp can define map operations, but their functor laws are postulated for the same reason as before: missing dependent eliminators.

## Fracture

`Fracture.agda` states the cohesive fracture theorem.

The central square is:

```text
♭A ---------> A
 |            |
 v            v
♭(♯A) -----> ♯A
```

The file proves that this square commutes. That proof uses `flat-counit-natural` from `Properties.agda`.

The stronger claim is that `♭A` is equivalent to the pullback of the lower-right cospan. That claim is postulated as:

```agda
fracture : (A : Type ℓ) → isEquiv (flat-to-pullback A)
```

In real-cohesive HoTT, fracture follows from `♯` preserving finite limits. The project does not postulate all of that structure. It postulates the exact fracture equivalence currently needed.

This is one of the sharpest places where the synthetic track goes beyond what the analytic mirror currently checks. The interesting `Bℤ` case depends on `♯(Bℤ)`, which the analytic side has not constructed.

## Cohomology and the De Rham Ladder

The cohomology folder starts with `FlatCoefficients.agda`.

It defines:

```agda
FlatCohomology A B = ShapeModality A → B
```

Then it proves that if `B` is flat-modal, this agrees with the ordinary function type:

```agda
A → B
```

This is the structural rung of the de Rham ladder. It is important because it uses modal structure that plain HoTT cannot state. It is also limited: it does not introduce differential forms, it does not define `ℝ`, and it does not prove the classical de Rham theorem.

The ladder is:

- structural: the current `FlatCoefficients.agda`;
- named-coefficient: a future file could name a cohesive real line and instantiate at `♭ℝ`;
- differential: a future phase would add differential-cohesion modalities and actual forms.

Keeping those rungs separate is essential. The current file is real ModalHoTT progress, but it is not yet differential geometry.

## Iteration

The iteration files are infrastructure for a longer arc called `T_recursion`.

`Iteration.agda` is generic. Given operations `L` and `R`, their map actions, and a unit:

```agda
η : A → R (L A)
```

it defines:

```text
T A = R (L A)
A -> T A -> T² A -> T³ A -> ...
```

and calls the sequential colimit of this tower `ND A`.

`IterationCohesion.agda` specializes this scaffold to `ʃ ⊣ ♭`. In that A-side case, `T A` is `♭(ʃA)`, and the next step `T A -> T(T A)` is shown to be an equivalence using the bridge from `Discrete.agda`. This is a sanity check that the scaffold composes with the existing modal postulates. It is not the future cross-site recursion theorem.

## The Current Agda Layers

The current synthetic ModalHoTT tree has two folders.

`Modalities` builds the modal machinery. It introduces the three modalities, wires them by adjunctions, proves and postulates functoriality laws, states fracture, records the flat/shape discrete bridge, and sets up the generic and A-side iteration scaffold.

`Cohomology` applies the modal machinery. The current file gives the flat-coefficient structural result and pins its forward map to precomposition with `shape-unit`.

Read in this order:

1. `00_modalhott_intro.md` - this file.
2. `01_Modalities/01_cohesion.md`
3. `01_Modalities/02_adjunctions.md`
4. `01_Modalities/03_properties.md`
5. `01_Modalities/04_fracture.md`
6. `01_Modalities/05_discrete.md`
7. `01_Modalities/06_iteration.md`
8. `01_Modalities/07_iterationcohesion.md`
9. `02_Cohomology/01_flatcoefficients.md`

The source companions inside the folders then walk the Agda files chunk by chunk.

## What Is Implemented and What Is Not

Implemented now:

- synthetic postulates for `♭`, `ʃ`, and `♯`;
- `IsFlatModal`, `IsShapeModal`, and `IsSharpModal`;
- adjunction equivalences for `♭ ⊣ ♯` and `ʃ ⊣ ♭`;
- named transpose operations derived from those equivalences;
- a proof that `♭A` is flat-modal;
- postulated idempotency for `ʃA` and `♯A`;
- flat functoriality and `flat-counit` naturality;
- postulated shape and sharp functor laws;
- the fracture square and the fracture equivalence postulate;
- the flat/shape discrete bridge;
- generic iteration and the A-side `ʃ ⊣ ♭` collapse check;
- structural flat-coefficient cohomology.

Not implemented yet:

- native crisp contexts in Agda;
- dependent induction principles for shape and sharp;
- a full adjunction package with all naturality data;
- `♯` preserving finite limits as a general theorem;
- analytic pedagogy for `agda/Analytic`;
- named-coefficient and differential de Rham files;
- the cross-site bridge to Concurrency;
- the final `T_recursion` theorem for the cross-site adjunction.

These omissions are not cosmetic. They are the current frontier of the ModalHoTT side.

## Relation to the Concurrency Side

The ModalHoTT side and the Concurrency side are complementary, not duplicate.

The ModalHoTT side studies how a mathematical object changes under perspectives. It gives the formal language of flattening, shaping, sharpening, factoring through shape, and iterating viewpoint changes.

The Concurrency side studies an operational community. It has actors, events, interaction shapes, session-valued content, local views, and restriction along those local views.

The eventual bridge is expected to be cross-site. ModalHoTT supplies the language of perspectives and cohesion. Concurrency supplies the operational substrate where agents move through partial views and produce typed artifacts. Workflow notes describe the bridge as `Allow ⊣ Require`: modal structure allows the operational substrate to unfold, while a disciplined operational substrate requires a modal account to explain why local views can be organized coherently.

That bridge is not built in the current Agda. For now, the right reading is: ModalHoTT is the synthetic language of perspectives, and Concurrency is the implementation-facing language of interaction. The pedagogy track keeps them separate until the code actually gives a bridge between them.
