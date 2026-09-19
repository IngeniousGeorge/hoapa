# Continuous adjunction

## External Codex

### Q

Do we have in current mathematics a notion of "continuous adjunctions", which would track the evolution of a specific adjunction across different domains/theories/levels of complexity? (I use the word continuous but it could also be a series of points, of course)

### A

Yes. There is no single standard notion called **“continuous adjunction”** with exactly the meaning you describe, but several established categorical frameworks come very close. In fact, your phrase points toward a fairly natural synthesis of **indexed/parametrized adjunctions, fibrations, and higher-categorical coherence**.

Suppose you have adjunctions

$$
F_t:\mathcal C_t \rightleftarrows \mathcal D_t:G_t,
\qquad F_t\dashv G_t,
$$

where \(t\) represents a domain, theory, scale, or level of complexity. Your question is essentially: *can the whole family \(F_t\dashv G_t\) itself be treated as one mathematical object, so that we can study how the adjunction changes with \(t\)?* The answer is very much yes.

### 1. Indexed/fibred adjunctions are probably the closest classical notion

Let \(\mathcal B\) be a category whose objects represent your different “domains” or “levels.” Instead of one category, consider indexed categories

$$
\mathcal C,\mathcal D:\mathcal B^{op}\to\mathbf{Cat}.
$$

Thus every \(b\in\mathcal B\) gives categories

$$
\mathcal C_b,\qquad\mathcal D_b,
$$

and every transition \(b\to b'\) tells you how to transport objects between levels.

You can then have adjunctions

$$
F_b:\mathcal C_b\rightleftarrows\mathcal D_b:G_b
$$

that are compatible with this transport. This is usually called an **indexed adjunction** or **fibred adjunction**. Fibrations were developed precisely to encode categories that vary over a base, and standard treatments explicitly develop adjunctions in that fibred setting. ([people.mpi-sws.org][1])

This already gives a precise version of your idea:

$$
\boxed{\text{one adjunction varying coherently over a space/category of contexts}}
$$

And importantly, the parameter space needn't literally be continuous.

### 2. Parametrized adjunctions make this even more explicit

Modern category theory uses the term **parametrized adjunction**. Roughly, one has something like

$$
F(b,-)\dashv G(b,-)
$$

for every parameter \(b\), with compatibility as \(b\) varies.

For example, current formalizations literally define “adjunctions with a parameter,” where a family of ordinary adjunctions is supplemented by a naturality/coherence condition in that parameter. ([Teorth][2])

There is also a developed theory of parametrized adjunctions for \(T\)-indexed \(\infty\)-categories, so the idea survives when the “domains” themselves have homotopical/higher structure. ([London Mathematical Society (LMS)][3])

So if by continuous you mean

> as I move through some organized family of theories, the two sides of an adjunction change, but the adjoint relationship persists coherently,

then **parametrized adjunction** is probably the nearest existing term.

### 3. Your “series of points” observation is especially important

Continuity isn't actually essential. Suppose levels of complexity form

$$
0\longrightarrow1\longrightarrow2\longrightarrow3\longrightarrow\cdots.
$$

At each level you have

$$
F_n\dashv G_n.
$$

You would want transition maps between

$$
(\mathcal C_n,\mathcal D_n,F_n,G_n)
\quad\text{and}\quad
(\mathcal C_{n+1},\mathcal D_{n+1},F_{n+1},G_{n+1})
$$

that preserve the adjunction appropriately.

Categorically, this suggests treating **adjunctions themselves as objects of a higher category**. There is indeed a 2-categorical viewpoint in which categories are objects and adjunctions serve as structured arrows; adjunctions also have a universal “walking adjunction” formulation in higher category theory. ([CiteSeerX][4])

Then your evolving adjunction is schematically just a diagram

$$
\mathcal B\longrightarrow\mathbf{Adj},
$$

where \(\mathbf{Adj}\) is some suitable 2-category/\(\infty\)-category of adjunctions.

That is perhaps the cleanest abstract formulation of your intuition.

### 4. There is another interpretation of your question that is more unusual

I suspect you're asking something slightly stronger than merely “a parameterized family.”

Imagine, for example,

$$
A_0\dashv B_0
\quad\rightsquigarrow\quad
A_1\dashv B_1
\quad\rightsquigarrow\quad
A_2\dashv B_2,
$$

where these aren't just unrelated adjunctions indexed by \(0,1,2\), but **successive manifestations of the same structural opposition** at increasingly sophisticated levels.

For example, one might recognize a recurring pattern such as

$$
\text{syntax}\rightleftarrows\text{semantics},
$$

then

$$
\text{theories}\rightleftarrows\text{models},
$$

then an analogous adjunction between categories of theories and categories of semantic structures, then perhaps a higher-categorical version, etc.

Now the desired structure isn't merely a family

$$
(F_i\dashv G_i)_{i\in I}.
$$

You want maps explaining **why adjunction \(i+1\) is the continuation/lift/refinement of adjunction \(i\)**.

That moves into 2-category theory. One relevant classical idea is **doctrinal adjunction**, introduced by G. M. Kelly: it studies when an adjunction in an underlying 2-category can be *lifted* through additional algebraic structure. ([Springer Nature][5])

It is not identical to your proposal, but philosophically it is close: an adjunction persists as one passes to a richer level of structure.

### 5. Fibrations may give the nicest geometric picture

There is an appealing way to formalize your word *continuous*.

Take a base \(\mathcal B\) representing domains/levels/theories, and put over each point \(b\) an adjunction

$$
F_b\dashv G_b.
$$

Then the total structure behaves like a **bundle of adjunctions over \(\mathcal B\)**:

$$
\begin{array}{ccc}
\mathcal C_b &\rightleftarrows&\mathcal D_b\\
&\downarrow&\\
&b&
\end{array}
$$

Fibrations are precisely category theory's machinery for turning this bundle metaphor into mathematics: a fibration can be viewed as categories (“fibres”) indexed by objects of a base and coherently glued together. The Grothendieck construction identifies this with the indexed-category perspective. ([Springer Nature][6])

So your “continuous adjunction” could naturally mean something like a **fibred/parametrized adjunction over a base of theories**.

And the base itself could be:

$$
\mathbb N,\quad
\text{a poset of complexity levels},\quad
\text{a category of theories},\quad
\text{a site},\quad
\text{an }\infty\text{-category},\quad
\text{even a genuine topological parameter space}.
$$

The categorical concept of continuity then becomes **coherent transport**, rather than ordinary \(\epsilon\)-\(\delta\) continuity.

---

There is therefore a nice hierarchy of interpretations:

$$
\boxed{
\begin{array}{c}
\text{family of adjunctions}\\
\downarrow\\
\text{parametrized adjunction}\\
\downarrow\\
\text{indexed/fibred adjunction}\\
\downarrow\\
\text{diagram in a 2-category of adjunctions}\\
\downarrow\\
\text{higher-categorical family of adjunctions}
\end{array}}
$$

The **third/fourth levels seem closest to what you're describing**, especially if “evolution” means not merely that the parameter changes but that the *same conceptual adjunction is transported, lifted, or refined as one changes theories*.

There is also a potentially interesting distinction hiding in your question: **variation of an adjunction** versus **iteration of an adjunction** versus **lifting an adjunction to successively richer structures**. Those three lead to rather different mathematics. If you give me one concrete example of the kind of “same adjunction across domains” you have in mind, I can try to formalize your proposed notion and locate it much more precisely in existing category theory.

[1]: https://people.mpi-sws.org/~dreyer/courses/catlogic/jacobs.pdf?utm_source=chatgpt.com "20  *Chapter 1: Introduction to fibred category theory*"
[2]: https://teorth.github.io/analysis/docs/Mathlib/CategoryTheory/Adjunction/Parametrized.html?utm_source=chatgpt.com "Mathlib.CategoryTheory.Adjunction.Parametrized"
[3]: https://londmathsoc.onlinelibrary.wiley.com/doi/10.1112/topo.70044?utm_source=chatgpt.com "Parametrized stability and the universal property of global spectra - Cnossen - 2025 - Journal of Topology - Wiley Online Library"
[4]: https://citeseerx.ist.psu.edu/document?doi=87089b44c76a8190d8b7414c3e996e6fd93e1e11&repid=rep1&type=pdf&utm_source=chatgpt.com "Categorical Foundations for K-theory"
[5]: https://link.springer.com/book/10.1007/BFb0063096?utm_source=chatgpt.com "Category Seminar: Proceedings Sydney Category Theory Seminar 1972 /1973 | Springer Nature Link"
[6]: https://link.springer.com/article/10.1007/s10485-022-09678-w?utm_source=chatgpt.com "Internal Enriched Categories | Applied Categorical Structures | Springer Nature Link"

### Q

Is any of those structures you mentioned capable of "overflowing mathematics" and in a sense "becoming" physical theories?

### A

Yes—but with an important distinction: a categorical structure does not literally turn into physics merely by becoming sufficiently elaborate. What *can* happen is that the parameter/index of a categorical construction is no longer “another mathematical theory” but a **physical context**—spacetime regions, experimental contexts, scales, boundary conditions, observers, or states. Then the categorical machinery becomes part of the mathematical architecture *of a physical theory*.

For your particular intuition, three routes are especially suggestive.

First, **functorial quantum field theory** already has something remarkably close to this. In Atiyah–Segal-style topological quantum field theory, a physical theory is represented by a symmetric monoidal functor

$$
Z:\mathbf{Bord}_n\longrightarrow \mathbf{Vect}
$$

(or some richer target). The source category consists of physical/geometric situations—spatial manifolds and spacetime cobordisms—and the functor assigns state spaces and evolution operators. So categorical structure is not merely describing relations *between mathematical theories*; its objects and morphisms are interpreted physically.

Second, **algebraic quantum field theory** takes this even further in the direction you're suggesting. Roughly, one assigns an algebra of observables to every spacetime region:

$$
O\subseteq M\quad\longmapsto\quad \mathcal A(O).
$$

In locally covariant QFT this becomes functorial:

$$
\mathbf{Loc}\longrightarrow\mathbf{Alg},
$$

where the source contains spacetimes and suitable embeddings. The categorical parameter is therefore literally a class of possible physical spacetimes.

Third—and I think closest to your “continuous adjunction” idea—is **higher category theory in extended QFT**. An extended field theory assigns data not just to whole spacetimes but successively to points, lines, surfaces, volumes, etc. Schematically,

$$
\text{point}
\rightsquigarrow
\text{1-dimensional process}
\rightsquigarrow
\text{2-dimensional process}
\rightsquigarrow\cdots
$$

with increasingly higher morphisms. Here a hierarchy of categorical levels acquires a direct physical/geometric interpretation.

But I think there is a stronger version of your question.

Suppose we had something like

$$
F_0\dashv G_0
\longrightarrow
F_1\dashv G_1
\longrightarrow
F_2\dashv G_2
\longrightarrow\cdots
$$

and initially these are purely mathematical adjunctions. Could the progression eventually cross a boundary such that the later members have an interpretation as **physical dynamics**?

Conceptually, yes. Mathematically, however, something additional has to enter.

An adjunction

$$
F\dashv G
$$

only says that

$$
\operatorname{Hom}(F X,Y)\cong\operatorname{Hom}(X,GY).
$$

Nothing in that statement says “energy,” “measurement,” “spacetime,” “particle,” or even “physical system.” Category theory deliberately forgets that information.

So an entire perfectly coherent tower

$$
\mathcal A_0\to\mathcal A_1\to\mathcal A_2\to\cdots
$$

could remain mathematics forever.

For it to “overflow” into physics, there must be an **interpretation map** somewhere—some identification of part of the categorical structure with empirically meaningful quantities.

And this produces, to my mind, the interesting mathematical question hidden inside yours.

Instead of

$$
\text{mathematics}
\quad|\quad
\text{physics},
$$

imagine a parametrized structure

$$
\mathcal T_0
\rightarrow
\mathcal T_1
\rightarrow
\mathcal T_2
\rightarrow
\cdots
\rightarrow
\mathcal T_\lambda
\rightarrow\cdots
$$

in which the *interpretation itself* varies. At early stages, objects might have only formal meanings; farther along, some become operational quantities; eventually the structure might support predictions.

Then the mathematical object we need isn't merely a parametrized adjunction. We'd want something more like

$$
\boxed{
\text{family of adjunctions}
+
\text{family of interpretations}
+
\text{compatibility between them}
}
$$

Schematically, perhaps

$$
\begin{array}{ccc}
\mathcal C_\lambda & \underset{G_\lambda}{\overset{F_\lambda}{\rightleftarrows}} &
\mathcal D_\lambda\\[4pt]
\downarrow I_\lambda &&\downarrow J_\lambda\\[4pt]
\mathsf{Physical}_\lambda &&
\mathsf{Observables}_\lambda .
\end{array}
$$

Now something quite interesting can happen: **physical meaning can itself be transported along the family**.

This starts touching several real research areas: categorical quantum mechanics, higher/extended QFT, algebraic QFT, topos approaches to physics, renormalization viewed categorically, and categorical semantics of physical theories. None of them, as far as I know, supplies a universally accepted object exactly matching your “an adjunction gradually overflowing mathematics and becoming physical” formulation.

And there is an especially intriguing candidate for what your “complexity parameter” might physically be: **scale**.

One could imagine

$$
(F_\ell\dashv G_\ell)_{\ell}
$$

indexed by observational/coarse-graining scale \(\ell\). Then changing \(\ell\) corresponds to renormalization:

$$
\text{microscopic theory}
\longrightarrow
\text{effective theory}
\longrightarrow
\text{macroscopic theory}.
$$

At one scale the objects may look like microscopic degrees of freedom; at another, fields; at another, thermodynamic variables. What persists need not be the objects themselves but some **adjoint relationship between ways of encoding and recovering information**.

That is much closer to something genuinely physical than merely indexing adjunctions by \(\mathbb N\).

So I would sharpen your original intuition slightly:

> Perhaps the interesting object isn't a “continuous adjunction,” but an **adjunction whose semantics varies over a base**, where portions of the base correspond to mathematical descriptions and portions acquire operational/physical interpretation.

That would let one ask a very nontrivial question: **which properties of an adjunction survive the passage between descriptive levels?**

If the unit/counit, universal property, or some invariant survived while the interpretation changed from mathematical to physical, then one could reasonably say that the *same structural relation* had crossed levels of description. That idea has recognizable relatives in current mathematics and mathematical physics, but it is not exhausted by any one of the standard notions I mentioned earlier.
