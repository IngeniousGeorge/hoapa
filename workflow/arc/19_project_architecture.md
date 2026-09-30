# Project architecture

## Conversation with external ChatGPT

### Q

How are adjunctions that mix free/forgetful and nerve/realization relations typically organized? (Is there a special sequence, interactions, etc. that make them work together particularly well?) 
On what contexts do we usually find such adjunctions?

### A

Yes. There is a very common pattern here, although it is better thought of as an **architecture of adjunctions** than as one canonical four-functor sequence.

Suppose you have an algebraic category \(\mathcal A\), an underlying category \(\mathcal C\), and a combinatorial/presheaf category \(\widehat{\mathcal D}\). One often encounters

\[
F:\mathcal C \rightleftarrows \mathcal A:U
\qquad\text{and}\qquad
|{-}|:\widehat{\mathcal D}\rightleftarrows\mathcal C:N,
\]

where \(F\dashv U\) is **free/forgetful**, while \(|{-}|\dashv N\) is **realization/nerve**.

The useful feature is that they point in complementary directions:

\[
\widehat{\mathcal D}
\;\underset{N}{\overset{|{-}|}{\rightleftarrows}}\;
\mathcal C
\;\underset{U}{\overset{F}{\rightleftarrows}}\;
\mathcal A .
\]

So automatically, by composing adjunctions,

\[
F|{-}|:\widehat{\mathcal D}
\rightleftarrows
\mathcal A:NU.
\]

This simple observation is behind a surprisingly large number of constructions.

### Why the two kinds of adjunction fit together

They usually perform two different jobs.

The **free/forgetful adjunction** controls *algebraic structure*. \(U\) strips structure away, while \(F\) freely installs it. Its associated monad

\[
T=UF
\]

encodes the operations and equations of the algebraic theory.

The **nerve/realization adjunction** controls *presentation by elementary shapes*. A nerve replaces an object by the data of all maps from certain basic test objects:

\[
N(X)(d)\simeq \operatorname{Hom}(D_d,X),
\]

while realization glues those elementary pieces back together, typically by a coend such as

\[
|X|\simeq\int^{d\in\mathcal D} X(d)\otimes D_d.
\]

So there is a conceptual division of labor:

\[
\boxed{\text{combinatorial presentation}}
\quad\leftrightarrow\quad
\boxed{\text{underlying objects}}
\quad\leftrightarrow\quad
\boxed{\text{algebraic structure}}.
\]

That is why the combination occurs so frequently.

### The particularly good case

Things become especially nice when the "shapes" defining the nerve are themselves **free objects**.

Take objects \(c_d\in\mathcal C\), form their free objects \(F(c_d)\in\mathcal A\), and define

\[
N_{\mathcal A}(A)(d)
=
\operatorname{Hom}_{\mathcal A}(F(c_d),A).
\]

The free/forgetful adjunction immediately gives

\[
\operatorname{Hom}_{\mathcal A}(F(c_d),A)
\cong
\operatorname{Hom}_{\mathcal C}(c_d,U(A)).
\]

Hence

\[
N_{\mathcal A}(A)(d)\cong N_{\mathcal C}(UA)(d),
\]

or schematically

\[
\boxed{N_{\mathcal A}\simeq N_{\mathcal C}\circ U.}
\]

This is one of the most important interactions between the two patterns. The algebraic nerve can be computed simply by **forgetting the algebraic structure and then taking an ordinary nerve**.

Dually, its left adjoint is obtained by realization followed by the free functor:

\[
\boxed{|{-}|_{\mathcal A}\simeq F\circ |{-}|_{\mathcal C}.}
\]

So one gets the clean diagram

\[
\begin{array}{ccccc}
\widehat{\mathcal D}
&\underset{N_{\mathcal C}}{\overset{|{-}|_{\mathcal C}}{\rightleftarrows}}&
\mathcal C
&\underset{U}{\overset{F}{\rightleftarrows}}&
\mathcal A
\\[3pt]
&&&&\\[-8pt]
&\underset{N_{\mathcal C}U}{\overset{F|{-}|_{\mathcal C}}{\rightleftarrows}}&
&&
\end{array}
\]

with

\[
F|{-}|_{\mathcal C}\dashv N_{\mathcal C}U.
\]

This is probably the "special sequence" you have in mind.

---

## Where does this show up?

A major source is **monadic algebra plus density**.

For instance, suppose

\[
\mathcal A\simeq \operatorname{Alg}_T(\mathcal C)
\]

for a monad \(T\) on \(\mathcal C\). Then

\[
F_T:\mathcal C\rightleftarrows\operatorname{Alg}_T(\mathcal C):U
\]

is the free/forgetful adjunction.

Now choose a small collection of elementary objects \(\mathcal D\subseteq\mathcal C\). If these form a sufficiently good dense family, they induce a nerve

\[
N:\mathcal C\to [\mathcal D^{op},\mathbf{Set}]
\]

with a realization left adjoint. Applying \(F_T\) to the elementary objects gives the corresponding "free algebraic shapes."

This appears throughout:

- **ordinary algebra:** sets \(\leftrightarrow\) groups, monoids, rings, modules, etc.;
- **categories:** graphs \(\leftrightarrow\) categories, together with categorical nerves;
- **simplicial methods:** simplicial sets/spaces and geometric realization–singular/nerve constructions;
- **operads:** collections/symmetric sequences \(\leftrightarrow\) operads, with dendroidal or related nerves;
- **higher categories:** globular sets, simplicial objects, computads, \(\Theta_n\)-sets, etc. versus \(n\)-categories;
- **higher algebra:** underlying objects \(\leftrightarrow\) \(E_n\)-algebras, monoidal categories, enriched categories, and similar structures.

There is a recurring philosophy:

\[
\text{structured object}
\xrightarrow{U}
\text{underlying object}
\xrightarrow{N}
\text{presheaf of its elementary pieces}.
\]

Going the other way,

\[
\text{presheaf}
\xrightarrow{|{-}|}
\text{object assembled from pieces}
\xrightarrow{F}
\text{freely structured object}.
\]

### An important refinement: nerves usually land in a special class of presheaves

The nerve typically does **not** say that every presheaf is an algebraic object. Instead, its image is characterized by conditions—Segal conditions, product-preservation conditions, horn conditions, completeness conditions, and so forth.

The classical category nerve is the clean example:

\[
N:\mathbf{Cat}\hookrightarrow \mathbf{sSet}.
\]

An arbitrary simplicial set need not be the nerve of a category. The nerves of categories are precisely those with the appropriate strict composition property (equivalently, the relevant Segal maps are isomorphisms).

In higher category theory, one weakens those exact equations:

\[
\text{strict identities/isomorphisms}
\quad\leadsto\quad
\text{homotopy equivalences}.
\]

That is how the same free/forgetful + nerve/realization architecture leads naturally from **algebraic structures** to **homotopy-coherent structures**.

So the broad pattern can be summarized as

\[
\boxed{
\text{generators}
\;\xrightarrow{\text{realize}}\;
\text{objects}
\;\xrightarrow{\text{free}}\;
\text{algebras}
}
\]

versus

\[
\boxed{
\text{algebras}
\;\xrightarrow{\text{forget}}\;
\text{objects}
\;\xrightarrow{\text{nerve}}\;
\text{combinatorial data}.
}
\]

The deeper common denominator is **monads + density/Kan extension**: free/forgetful adjunctions are naturally monadic, while nerve/realization adjunctions are naturally governed by dense subcategories and Kan extensions. When the dense generators are free algebras, the two mechanisms line up exceptionally well.

### Q

In that context, what is the relation between A and D^hat ?

### A

The key point is that \(\mathcal A\) is often identifiable with a **special full subcategory** of \(\widehat{\mathcal D}\), rather than with all of \(\widehat{\mathcal D}\).

Starting from

\[
\widehat{\mathcal D}
\;\underset{NU}{\overset{F|-|}{\rightleftarrows}}\;
\mathcal A,
\]

write

\[
L=F|-|,\qquad N_{\mathcal A}=NU.
\]

If \(N_{\mathcal A}\) is fully faithful—which is the important "nerve theorem" situation—then

\[
\boxed{\mathcal A \simeq \operatorname{EssIm}(N_{\mathcal A})
\subseteq \widehat{\mathcal D}.}
\]

So an object of \(\mathcal A\) can be regarded as a presheaf on \(\mathcal D\) satisfying certain additional conditions.

For example, for ordinary categories,

\[
\mathbf{Cat}
\xrightarrow{N}
\mathbf{sSet}
=
\widehat{\Delta},
\]

and \(N\) is fully faithful. Thus

\[
\mathbf{Cat}
\simeq
\{\text{simplicial sets satisfying the strict Segal conditions}\}
\subseteq\mathbf{sSet}.
\]

The ambient presheaf category contains **all possible diagrams of elementary shapes**, whereas \(\mathcal A\) consists of those diagrams whose pieces fit together according to the desired algebraic/composition laws.

There is also a useful adjunction-theoretic way of saying this. If

\[
L:\widehat{\mathcal D}\rightleftarrows\mathcal A:N_{\mathcal A}
\]

and \(N_{\mathcal A}\) is fully faithful, then the counit

\[
L N_{\mathcal A}(A)\longrightarrow A
\]

is an isomorphism (or equivalence in the \(\infty\)-categorical setting). Consequently,

\[
P\longmapsto N_{\mathcal A}L(P)
\]

acts as a **reflection/localization** of arbitrary presheaves onto the presheaves that actually come from objects of \(\mathcal A\):

\[
\widehat{\mathcal D}
\;\xrightarrow{\;N_{\mathcal A}L\;}
\operatorname{EssIm}(N_{\mathcal A})
\simeq\mathcal A.
\]

So you can picture the situation as

\[
\boxed{
\begin{array}{ccc}
\widehat{\mathcal D}
&\supset&
\text{``algebraic/Segal presheaves''}
\\
&&\rotatebox{90}{$\simeq$}\\[-2pt]
&&\mathcal A.
\end{array}}
\]

There is one subtlety worth emphasizing: **this does not follow merely from composing the two adjunctions**. In general we only know

\[
F|-| \dashv NU.
\]

To conclude that \(\mathcal A\hookrightarrow\widehat{\mathcal D}\), we need a nerve theorem showing that \(NU\) is fully faithful. And then a second question is to characterize its essential image—typically by **Segal conditions, product-preservation, limit conditions, or locality conditions**.

In fact, this is often the whole purpose of introducing \(\widehat{\mathcal D}\): it replaces a potentially complicated category \(\mathcal A\) by a very well-behaved presheaf category plus a relatively explicit condition:

\[
\boxed{
\mathcal A
\quad\longleftrightarrow\quad
\text{presheaves on elementary/free shapes satisfying relations}.
}
\]

This is closely related to **Lawvere theories, monads with arities, Segal-type nerves, and Weber's nerve theorems**. Those frameworks make precise exactly when a free/forgetful adjunction and a choice of \(\mathcal D\) produce this description.

### Q

What is the relation between this double adjunction and Homotopy type theory?

### A

There is a real connection, but it helps to distinguish **two levels**. The double adjunction is not itself HoTT; rather, essentially the same categorical architecture appears when one constructs **semantic models of type theory and HoTT**.

In the notation we've been using,

\[
\widehat{\mathcal D}
\;\underset{N}{\overset{|-|}{\rightleftarrows}}\;
\mathcal C
\;\underset{U}{\overset{F}{\rightleftarrows}}\;
\mathcal A ,
\]

there are roughly three layers:

\[
\boxed{\text{syntax/combinatorics}}
\longleftrightarrow
\boxed{\text{homotopical objects}}
\longleftrightarrow
\boxed{\text{objects with extra structure}}.
\]

### 1. Why presheaves are important for HoTT

Presheaf categories

\[
\widehat{\mathcal D}=[\mathcal D^{op},\mathbf{Set}]
\]

and, more importantly, **simplicial presheaves** and related \(\infty\)-categorical versions, are extremely common environments for models of dependent type theory.

The reason is structural. Dependent type theory needs operations corresponding categorically to things such as

\[
\Sigma,\qquad \Pi,\qquad \mathrm{Id},
\]

together with substitution. Presheaf/topos-like categories have excellent limit, colimit, exponentiation and substitution properties, so they are natural places in which to interpret these constructions.

For HoTT, however, ordinary sets are not enough: identity types need to carry **homotopical structure**.

Thus one moves toward spaces, simplicial sets, simplicial presheaves, cubical sets, \(\infty\)-toposes, etc.

For example, the simplicial-set model lives in

\[
\mathbf{sSet}=\widehat{\Delta}.
\]

Here the fact that the semantic universe is itself a presheaf category is not incidental.

### 2. The nerve/realization side is the homotopical bridge

Consider the classical adjunction

\[
|-|:\mathbf{sSet}
\rightleftarrows
\mathbf{Top}:\mathrm{Sing}.
\]

After putting the appropriate model structures on these categories, this becomes a Quillen equivalence (under the standard hypotheses). Thus simplicial sets provide a combinatorial presentation of homotopy types.

Schematically,

\[
\boxed{
\text{combinatorial object}
\;\rightleftarrows\;
\text{homotopy type}.
}
\]

That is already very close to the fundamental semantic intuition of HoTT:

\[
\text{type}\sim\text{space/homotopy type},
\]

with terms as points and identity terms as paths.

So the nerve/realization half supplies precisely the kind of passage between **combinatorial syntax-like objects** and **homotopy-theoretic objects** that HoTT exploits.

### 3. Where does free/forgetful enter?

Now suppose the objects we want are not just spaces but **structured spaces**:

\[
F:\mathcal C\rightleftarrows\mathcal A:U.
\]

Examples include simplicial groups, simplicial categories, operadic algebras, higher categories, structured fibrations, and so on.

Then the composite

\[
F|-|:\widehat{\mathcal D}
\rightleftarrows
\mathcal A:NU
\]

says something quite useful:

> structured homotopical objects can sometimes be encoded by presheaf-like combinatorial objects satisfying appropriate coherence conditions.

That idea is ubiquitous around higher category theory and HoTT.

The important change from ordinary algebra is that strict equations often become **homotopy-coherent conditions**. Earlier we had

\[
\mathcal A
\simeq
\{\text{presheaves satisfying strict Segal/algebraic conditions}\}.
\]

In homotopical settings this tends to become

\[
\mathcal A_\infty
\simeq
\{\text{presheaves satisfying Segal/etc. conditions up to equivalence}\}.
\]

This passage

\[
\text{equation}
\quad\rightsquigarrow\quad
\text{specified path/equivalence/coherent homotopy}
\]

is deeply consonant with HoTT.

### 4. But HoTT adds another crucial adjunction-like layer

For dependent type theory, the central categorical object isn't merely an object \(X\); it is a **family over \(X\)**,

\[
p:E\to X.
\]

A dependent type

\[
x:A\vdash B(x)\;\mathrm{type}
\]

is interpreted as something like a fibration

\[
B\longrightarrow A.
\]

Substitution is pullback. And now adjunctions appear again.

Given

\[
f:X\to Y,
\]

pullback gives

\[
f^*:\mathcal C/Y\to\mathcal C/X.
\]

When suitable adjoints exist, one has

\[
\boxed{
\Sigma_f
\dashv
f^*
\dashv
\Pi_f.
}
\]

This is extremely important for type theory:

\[
\Sigma_f \leftrightarrow \text{dependent sum},
\qquad
\Pi_f \leftrightarrow \text{dependent product}.
\]

So if you're specifically trying to understand **HoTT through adjunctions**, I would put this triple at least as centrally as the free/forgetful–nerve/realization pair.

### 5. The two stories meet

You can therefore think of the overall architecture as having two axes.

The first is the one from your question:

\[
\boxed{
\widehat{\mathcal D}
\;\rightleftarrows\;
\mathcal C
\;\rightleftarrows\;
\mathcal A
}
\]

which concerns **presenting homotopical/structured objects by combinatorial generators**.

The second lives fiberwise over objects:

\[
\boxed{
\mathcal C/Y
\;\underset{\Pi_f}{\overset{f^*}{\rightleftarrows}}\;
\mathcal C/X
}
\qquad\text{and}\qquad
\Sigma_f\dashv f^*,
\]

which concerns **dependent types and substitution**.

HoTT needs these to interact well. Roughly, the combinatorial presentation has to preserve enough of the dependent/fibrational structure that \(\Sigma\)-types, \(\Pi\)-types, identity types, universes, etc. can be interpreted correctly.

And **univalence** adds the distinctive HoTT requirement: roughly, equivalences between the objects classified by a universe must themselves correspond appropriately to identities in that universe.

So there is a nice conceptual progression:

\[
\begin{array}{c}
\textbf{Free/forgetful}\\
\text{generators }\leftrightarrow\text{ algebraic structure}
\end{array}
\]

\[
\downarrow
\]

\[
\begin{array}{c}
\textbf{Nerve/realization}\\
\text{combinatorial presentation }\leftrightarrow\text{ geometric/higher object}
\end{array}
\]

\[
\downarrow
\]

\[
\begin{array}{c}
\textbf{Homotopical localization}\\
\text{strict equations }\rightsquigarrow\text{ coherent equivalences}
\end{array}
\]

\[
\downarrow
\]

\[
\begin{array}{c}
\textbf{Dependent adjunctions}\\
\Sigma_f\dashv f^*\dashv\Pi_f
\end{array}
\]

which gives much of the categorical infrastructure in which **HoTT can be modeled**.

One particularly fruitful next step would be to draw this for the **simplicial-set model of HoTT**. There, \(\widehat{\Delta}=\mathbf{sSet}\), Kan fibrations, slice categories, \(\Sigma/\Pi\), identity types, and the univalent universe all fit into essentially one picture; that makes the relationship much less abstract.

### Q

Please rate (independently) the adequacy of those choices for giving "meat" to the architecture: 
- a (higher) operad for A
- session types for the algebraic structure
- an ∞-topos for C
- dessins d'enfants for the combinatorial presentation

Also, refrain from using LaTeX, it doesn't display well on my screen. Use Unicode symbols instead.

### A

Taken independently—as candidates for giving concrete mathematical “meat” to the abstract architecture—I’d rate them quite differently. I’m rating **fit to the role you assigned**, not intrinsic mathematical interest.

| Choice | Adequacy | Main reason |
|---|---:|---|
| Higher operad for A | **9/10** | Extremely natural structured/algebraic object |
| Session types for the algebraic structure | **7/10** | Rich fit, but requires choosing the precise algebraic semantics |
| ∞-topos for C | **9/10** | Excellent homotopical/dependent semantic universe |
| Dessins d’enfants for the combinatorial presentation | **5/10** | Intriguing but substantially less canonical; needs a bridge |

### A = (higher) operads — 9/10

This is almost tailor-made for the architecture.

Operads are governed by operations, arities, substitution/composition, and coherence. There are natural forgetful/free constructions

F ⊣ U

from suitable collections, symmetric sequences, dendroidal data, etc., to operads. Higher operads make the connection even stronger because strict algebraic equations become coherent higher structure.

Moreover, operads have exceptionally good **nerve theories**. The dendroidal nerve is the paradigmatic example: trees play for operads approximately the role simplices play for categories.

So you naturally get something resembling

presheaves on trees ⇄ higher operads,

with Segal-type conditions identifying the presheaves that actually encode operadic objects.

That is almost exactly the architecture we discussed.

**What it gives your picture:** A acquires a very convincing interpretation as the world of “structured composition.”

---

### Session types as the algebraic structure — 7/10

This is more adventurous, but potentially very fruitful.

Session types encode **protocols of interaction**: sequencing, choice, communication, duality, recursion, concurrency. There are strong categorical and algebraic treatments involving linear logic, process calculi, monoidal categories, game semantics, propositions-as-sessions correspondences, etc.

The attraction is that an operadic A could make “composition” mean something operational:

> operations are not merely abstract n-ary operations; they describe compatible ways of connecting communicating processes.

That is substantial meat.

The reason I wouldn't give it 9/10 immediately is that “session types” do not determine a single monad/free-forgetful adjunction in the way “groups” or “operads” do. You have to decide what exactly constitutes the algebraic theory:

- protocols?
- processes implementing protocols?
- channels/interfaces?
- multiparty sessions?
- linear types?
- interaction nets?
- composition by channel plugging/cut?

Different choices lead to quite different categories.

So this ingredient is **conceptually strong but mathematically underdetermined** until you specify what F and U actually do.

There is nevertheless a particularly attractive interpretation:

> A higher operad describes allowable interaction/composition patterns, while its algebras provide implementations of those protocols.

That could raise the fit considerably.

---

### C = an ∞-topos — 9/10

Very strong choice, especially given your HoTT motivation.

An ∞-topos gives you a universe of homotopy-coherent objects with excellent categorical behavior: limits, colimits, descent, internal mapping objects, slices, and the dependent structure needed for interpreting higher/dependent mathematics.

Most importantly, over a map f : X → Y you can study the familiar dependent pattern

Σ_f ⊣ f* ⊣ Π_f,

under the appropriate hypotheses/framework.

So C is no longer merely the category where underlying objects happen to live. It becomes the **semantic universe in which objects vary over contexts**.

This gives you a striking division of labor:

**C = geometry / homotopy / dependency**

versus

**A = algebra / operations / interaction.**

That is a very productive division.

I'd reserve 10/10 because saying merely “an ∞-topos” doesn't guarantee that a particular operadic/session-type free-forgetful construction has all the properties you want. You would probably want something like operadic algebra **internal to C**.

Then your right-hand adjunction becomes something of the form

C ⇄ Alg_O(C)

rather than an unrelated A floating above C.

That would make the architecture much tighter.

---

### Dessins d’enfants as the combinatorial presentation — 5/10

This is the most interesting—and most problematic—choice.

Dessins give you extremely rich finite combinatorial objects: bipartite graphs embedded in oriented surfaces, equivalently certain permutation data, with a remarkable connection to Belyi maps and arithmetic geometry.

So as **combinatorial atoms**, they have plenty of substance.

The problem is architectural. For operads, the canonical combinatorics is already sitting there:

trees → operads.

For higher categories:

simplices / globes / Θ-objects → higher categories.

For your proposal, you need to establish why

dessins → your structured objects

should constitute a **dense family of arities/shapes** supporting a nerve theorem.

That does not come for free from the theory of dessins.

In other words, the missing statement is something like

D = category of suitable dessins

followed by

D̂ = PSh(D)

and then a nerve

A → D̂

whose essential image is characterized by explicit Segal/descent/gluing conditions.

Until you have that, dessins are more an evocative source of combinatorics than a genuine nerve category.

But there is a route that could make them much stronger.

### The route through graphs, surfaces, and modular operads

Ordinary operads naturally want **rooted trees**. Dessins naturally want **graphs embedded in surfaces**.

That suggests that your A may actually want to be richer than ordinary ∞-operads.

For example, structures in the vicinity of

cyclic operads → modular operads → properads / PROPs → higher variants

allow graph-shaped rather than merely tree-shaped composition.

Then the combinatorial progression becomes much more convincing:

trees  
↓  
graphs  
↓  
ribbon graphs / surface-embedded graphs  
↓  
dessin-like structures.

Now the dessin is no longer decorative combinatorics. Its topology can encode how interactions are wired together.

And *that* starts interacting very nicely with your session-type idea: a dessin could potentially represent a **global interaction topology**, while local algebraic data represent the communicating components.

---

### Put together, the ratings change

Although you asked for independent ratings, there's an important emergent effect here: the four ingredients are **more compelling together than the 5/10 for dessins suggests**.

Your proposed architecture wants to become something like

D̂  ⇄  C  ⇄  A  
dessins   ∞-topos   higher interaction algebra

with

A ≈ higher operadic / properadic objects internal to C,

and the algebraic interpretation of their operations being

operations ≈ typed interactions / communication protocols.

Then D̂ is trying to provide **combinatorial interaction geometries**.

The critical issue is the left-hand adjunction. If dessins are to earn their place, you need to answer:

> **What does realizing a dessin produce inside the ∞-topos?**

If a dessin δ produces some object |δ| ∈ C representing its space of interaction/configuration/execution, then you can ask whether

N(X)(δ) ≃ Map_C(|δ|, X)

provides a useful nerve.

That is the point where your unusual choice of dessins would become mathematically consequential.

And I'd investigate **modular operads / properads / graphical higher algebra** before ordinary operads here. Ordinary operads may actually be *too tree-like* for what your other three choices seem to be trying to accomplish.

### Q

Yes, the architecture would definitely avoid rooted trees and prefer options allowing graphs.

With those options, what is then the relation between A and D^hat?

### A

Yes. Once you replace rooted-tree operads by a genuinely **graphical** theory—properads, modular operads, PROPs, ∞-versions thereof—the relation between A and D̂ becomes considerably more natural.

The intended relation is:

**A is the subcategory of D̂ consisting of graphical presheaves satisfying appropriate Segal/coherence conditions.**

More precisely, let D be your category of elementary graphical shapes: graphs, ribbon graphs, dessin-like graphs, or some carefully chosen enlargement. Then

D̂ = Fun(Dᵒᵖ, Spaces)

in the ∞-categorical setting. There should be a graphical nerve

N_A : A → D̂.

An object a ∈ A is sent to the presheaf

G ↦ Map_A(FG, a),

where FG is the free structured object generated by the graph G.

The desired nerve theorem says that N_A is fully faithful. Thus

**A ≃ EssIm(N_A) ⊂ D̂.**

And the real mathematical content lies in identifying that essential image.

### What does the essential-image condition mean?

Very roughly, suppose a graph G can be decomposed into its vertices and internal edges. A graphical presheaf X assigns a space X(G) to the whole interaction graph.

If X really comes from a properadic/modular object, the information associated with G should be recoverable by composing the local operations assigned to its vertices, subject to compatibility along internal edges.

Schematically:

X(G) ≃ lim [ local vertex data + compatibility along edges ].

That is the **graphical Segal condition**.

For a tree, this recovers the familiar operadic Segal condition. For general graphs, however, you gain feedback, multiple inputs and outputs, cycles, contractions, and potentially genus/surface data.

This is exactly why abandoning rooted trees changes the character of A.

### And this makes your dessins much more plausible

Suppose D consists of some suitable category of dessins/ribbon graphs. A dessin carries more than an abstract graph: it has cyclic ordering data at vertices and hence surface information.

Then D̂ contains arbitrary assignments

dessin G ↦ X(G).

Most such assignments mean nothing compositionally. A consists of the special ones for which cutting and gluing dessins behaves correctly:

**arbitrary graphical presheaves**

D̂

⊃

**Segal / gluing / descent presheaves**

≃

A.

So I would now reinterpret your architecture as

D̂  ⇄  A

rather than thinking of D̂ merely as an unrelated combinatorial category sitting several steps away from A.

The left adjoint is then a kind of **graphical realization**:

L : D̂ → A,

while the right adjoint is the graphical nerve:

N : A → D̂.

If N is fully faithful,

L ⊣ N

is a reflective presentation of A inside graphical presheaves.

### There is a particularly important role for the free/forgetful adjunction

This reconnects directly to our original double adjunction.

Suppose

F : C ⇄ A : U

is your free/forgetful adjunction.

For each graphical shape G ∈ D, choose an underlying object |G| ∈ C. Its free structured object is

F(|G|) ∈ A.

Then define

N_A(a)(G)
= Map_A(F(|G|), a).

By free/forgetful adjunction,

Map_A(F(|G|), a)
≃ Map_C(|G|, U(a)).

But the right-hand side is precisely what a nerve of U(a) with respect to graphical probes would look like.

Hence the striking identity from our earlier discussion reappears:

**N_A ≃ N_C ∘ U.**

So the diagram becomes

```text
                 F
           C  ⇄  A
           ↑      |
           |      | N_A
 realization      ↓
           |      D̂
           ↓      ↑
           D̂ ────┘
```

More cleanly, as adjunctions:

```text
D̂  ⇄  C  ⇄  A
    |-|  N   F  U
```

and composition gives

```text
D̂  ⇄  A
  F∘|-|   N∘U
```

provided the choices line up appropriately.

### Your session-type interpretation makes this unusually concrete

Here is where I think your particular combination becomes interesting.

Let a graph G represent a **global communication topology**.

Vertices represent local agents/processes. Edges represent communication interfaces or channels. Multiple inputs/outputs naturally suggest properadic rather than operadic composition. Cycles allow feedback or recursive interaction patterns. Ribbon/dessin structure can additionally record cyclic ordering or surface embedding.

Then a ∈ A supplies the *semantics of interaction*, while its nerve asks:

> What compatible realizations of the interaction pattern G exist in a?

Thus

N_A(a)(G)

can be read as something like the **space of a-valued realizations of protocol G**.

Importantly, because we're in higher mathematics, this should generally be a **space**, not merely a set. Two implementations can be equivalent in nontrivial ways; equivalences can themselves have equivalences; and so forth.

Therefore I'd actually change our notation from the ordinary presheaf category

D̂ = Fun(Dᵒᵖ, Set)

to the higher presheaf category

**D̂∞ = Fun(Dᵒᵖ, S)**,

where S denotes ∞-groupoids/spaces.

Then the hoped-for relationship is

**A ↪ Fun(Dᵒᵖ, S)**

with image characterized by graphical Segal/descent conditions.

### And C = an ∞-topos adds another layer

If C is an ∞-topos, you don't necessarily have to use ordinary space-valued graphical presheaves at all.

You can internalize the entire construction:

**D̂_C = Fun(Dᵒᵖ, C).**

Now a graphical presheaf assigns to every dessin G not merely a space, but an **object of the ∞-topos C**.

Then one can hope for something like

**A ≃ Seg_D(C) ⊂ Fun(Dᵒᵖ, C),**

where Seg_D(C) denotes C-valued graphical presheaves satisfying your chosen Segal/gluing conditions.

This, I think, is the cleanest version of the architecture you're converging toward:

```text
              all graphical diagrams
                       │
                       │ Segal / gluing
                       ▼
D̂_C = Fun(Dᵒᵖ,C)  ⊃  A
                       │
                       │ forget structure
                       ▼
                       C
```

Or conceptually:

**D determines the shapes of interaction.**

**D̂_C permits arbitrary C-valued assignments to those shapes.**

**A selects the assignments that actually compose coherently.**

**C supplies the homotopical/dependent semantics of what is being assigned.**

And session types can supply the interpretation of that coherent composition as **typed communication**.

That also tells you where the real mathematical bottleneck of your proposed architecture lies. It is no longer A or C. There are established theories of graphical higher algebra and ∞-topos semantics. The decisive construction would be choosing the right **category D of dessin-like graphical arities** and proving an appropriate **nerve/Segal theorem**

**A ≃ Seg_D(C) ⊂ D̂_C.**

If that theorem works, the four ingredients stop being an analogy and become a single mathematical machine.

---
---
---

## Codex review

Yes: it is valuable, substantially coherent after correction, and constructible in established mathematical settings. It is also a strong fit for the direction we just recorded—but as a candidate framework, not yet as the architecture of the whole conjecture.

I read the complete conversation. Its strongest contribution is the proposed relationship between elementary interaction shapes, coherent composition, and contextual semantics. Its weakest point is that it sometimes treats distinct constructions as interchangeable, making the remaining work appear smaller than it is.

## 1. The valuable core

The final proposal in arc/19 (workflow/arc/19_project_architecture.md:1045) separates three responsibilities:

A category of shapes specifies which configurations and transformations can be expressed.
A semantic setting supplies the objects assigned to those shapes.
Composition conditions distinguish coherent systems from arbitrary diagrams.

This is genuine mathematical architecture, not merely suggestive terminology. There are established nerve theorems for modular operads, and higher properadic frameworks using Segal and completeness conditions. Hackney–Robertson–Yau, Chu–Hackney.

For Hoapa, its attraction is particularly clear:

Keep the elementary responsibilities distinct, while characterizing precisely when their arrangements constitute coherent, reusable work.

That directly serves our separation/integration direction.

However, a theorem characterizing coherent composition is not yet a theorem characterizing an adequate scientific methodology. That distinction must remain visible.

## 2. One central mathematical correction

The transcript repeatedly identifies the algebraic nerve with:

N_A ≃ N_C ∘ U

and then suggests this can yield a fully faithful description of the algebraic category.

The composite exists under the stated adjunction hypotheses. The problem is expecting it to recover algebraic structure that U has genuinely forgotten.

For example, let U forget a monoid’s multiplication. Taking a nerve of its underlying set cannot recover that multiplication: two monoid structures on the same set give the same underlying-set data.

More sharply: if N_C is fully faithful, then N_C ∘ U is fully faithful precisely when U is. An ordinary forgetful functor from monoids to sets is not full.

The established repair is especially relevant to us. Distinguish:

the category of underlying arities;
the category of free structured objects on those arities, with their algebraic maps.

The second category has additional morphisms encoding operations and substitution. The correct relationship is a restriction square, schematically:

structured objects ──algebraic nerve──▶ presheaves on the theory
        │                                      │
      forget                                restrict
        ▼                                      ▼
underlying objects ──underlying nerve──▶ presheaves on the arities

Thus the algebraic nerve becomes the underlying nerve after restriction, not before. This is explicit in Berger–Melliès–Weber’s construction and nerve theorem. Monads with arities, §2.3–2.5.

The missing information lives in how the descriptions respond to algebraic morphisms, not merely in their values on shapes. That is a constructive correction, and arguably makes the proposal more interesting.

## 3. A corrected framework is already available

The most useful further source I found is Chu–Haugseng’s algebraic patterns.

Their framework combines elementary objects, a factorization system, Segal conditions, and free/forgetful constructions. It also investigates when changes of pattern admit suitable Kan-extension operations. This is closely aligned with the architecture the transcript is reaching for. Homotopy-coherent algebra via Segal conditions.

A working organization would be:

 Component                     Responsibility
━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 Semantic setting E            Contextual objects and their variation
────────────────────────────  ────────────────────────────────────────────────────────────
 Graphical pattern             Shapes, elementary pieces, and permitted transformations
────────────────────────────  ────────────────────────────────────────────────────────────
 Elementary E-valued data      Interfaces and local data before full composition
────────────────────────────  ────────────────────────────────────────────────────────────
 Coherent graphical systems    Data equipped with the required compositional organization

There can then be two distinct, interacting adjunctions:

Free/forgetful: between elementary data and coherent systems.
Realization/nerve or Segal reflection: between graphical diagrams and coherent systems, under the relevant hypotheses.

Importantly, the underlying-data category is generally not just E. It can be a category of collections, profiles, graphs, or elementary diagrams valued in E. Chu–Haugseng’s Corollary 8.2 gives a precise free/forgetful construction of this kind.

This also resolves another ambiguity: a fixed operad, the category of operads, and the category of algebras for an operad are different choices. Arc/19 moves between them. Hoapa must decide which objects it actually needs.

## 4. Fit with this session’s direction

### The mirror gains a possible mechanism

The framework can distinguish two kinds of structural operation:

selecting or restricting to elementary pieces;
composing or substituting those pieces.

In familiar graphical instances, the inert/active distinction organizes these responsibilities. The Segal condition then relates a whole-shaped description to compatible elementary data.

That gives a plausible realization of:

Separation into accountable local responsibilities enables coherent integration; coherent integration requires additional distinctions between restriction, substitution, compatibility, and equivalence.

This is much closer to a mechanism for our “secondary separations” than a list of mirrored adjectives. It does not yet identify those mathematical operations with Hoapa’s particular responsibilities.

### It can primarily concern documentation

That is a strength, not a limitation.

The graphical structure could organize episodes, interfaces, artifacts, and their admissible compositions, while participants retain a separate unityped interface.

I would therefore qualify the transcript’s statement that vertices represent “agents/processes” (workflow/arc/19_project_architecture.md:1013). Those are not interchangeable. A vertex typed by a process or operation need not classify the person contributing to it.

This is exactly where our synthetic/analytic correction matters: typed composition of documented work must not quietly become a classification of its producers.

The existing code respects that boundary: formal/Concurrency/Sites/ActorBase.agda separates actor locality from payloads and roles; formal/Concurrency/Algebras/Sessions.agda supplies typed content but still leaves the operadic interaction action postulated. The new framework has something real to engage with, but no completed bridge.

### It supports the relative viewpoint

One could investigate variation in both the graphical pattern and the semantic setting. That provides candidates for contextual regimes and their comparisons.

But changing a pattern is not automatically evolution, and a change-of-pattern functor does not automatically preserve the required semantics. Those preservation questions would be substantive research obligations.

Likewise, an ∞-topos is a strong candidate semantic environment—not something this framework forces us to identify with M. The architecture could describe a fragment within M, or a family of operational/documentary settings related to M.

## 5. Three further qualifications matter

Graphs do not all support the same composition. Properads allow multiple inputs and outputs, but ordinary properadic compositions use directed acyclic graphs. Directed feedback needs additional structure; modular operads handle another kind of contraction. Ribbon order and dessin data add further commitments. These are choices about admissible operations, not a single ladder of increasing generality. The distinction between properads and wheeled properads is explicit in the established literature. Hackney–Robertson–Yau.

Segal composition is not automatically epistemic descent. A theorem saying compatible operations compose does not show that local accounts of reality are jointly adequate, that a conversation reaches agreement, or that publication preserves a declared future use. This is where interpretation must connect the architecture to the project’s subject matter.

An exact nerve does not itself supply evolutionary loss. A fully faithful right adjoint gives exact reconstruction of the modeled structured object. That can be excellent for faithful documentation and inheritance. Loss may instead occur at the live/public boundary, through restricted observations, or between regimes. We should not force one counit to perform all these jobs.

## 6. Constructible—and useful for specialness?

There are three different answers:

A mathematical instance of this general architecture: yes; existing theories provide substantial constructions.
A Hoapa-shaped finite or ordinary-categorical instance: plausibly constructible, with meaningful obligations already identifiable.
The full higher, session-semantic, dessin-based, evolving correspondence proving Hoapa’s special adequacy: not presently established or guaranteed.

I disagree with the transcript’s conclusion that choosing the graphical category is now the only real bottleneck. Session composition, the underlying-data interface, contextual interpretation, and the preservation of Hoapa’s separations remain substantial work.

A particularly useful test would be a small interaction pattern with two compatible components and an explicit interface. Ask whether its description determines the intended composition; then change compatibility or require renewed producer authorization for reuse. Can the semantics detect the difference for an independently stated future use?

That would test both composition and methodological adequacy, rather than merely demonstrate that a known nerve theorem applies.

My recommendation is therefore:

Treat arc/19 as a serious candidate framework for the new programme, corrected through monads with arities and algebraic patterns. Let Hoapa’s required operations determine the graphical shapes, and keep dessins as a possible earned refinement.

It offers a credible place where the conjecture could become constructible. It does not yet establish which organization is special—but it could give us a structured setting in which that question finally becomes precise.

---
---
---

## Claude's review

● Read it. Short version: question 1 is largely yes, and better than I expected; question 2 is partly no, in one specific way that needs deciding before this goes anywhere near the 
  workflow files.

  1. Valuable, coherent, constructible

  Coherent — yes, and unusually so. The load-bearing observation is N_A ≃ N_C ∘ U: when the probes are free objects on underlying objects, the algebraic nerve is just "forget, then take
  the ordinary nerve." That is a two-line consequence of the free/forgetful adjunction, not a hope. And it is precisely what makes the two adjunctions interlock rather than sit side by
  side — which dissolves the caution I gave you two turns ago that two adjunctions between the same categories are cheap unless something relates them.

  Worth noting loudly: this is monads with arities. Arities are the chosen shapes, the nerve is fully faithful on algebras, and the essential image is cut out by a Segal condition —
  Berger–Melliès–Weber. So arc/19 and the lead Codex put in future_work.md §F are the same object, arrived at by two independent routes. That convergence is the best evidence in the file
  that it is tracking something real.

  Valuable — yes, and the strongest reason is one the transcript doesn't state. It gives MO_1 a consumer. The project has carried the modular envelope as a long-horizon target since May
  with no forcing case — status_formal.md says exactly that, it and the full reflector are "gated by their own forcing cases." arc/19 supplies one: the modular/properadic envelope is what
  makes a graphical nerve possible, and the graphical nerve is what characterizes A. That is the first argument anyone has offered for why MO_1 needs to exist rather than merely being
  next.

  Two further convergences with banked material:

  - "Avoid rooted trees, go graphical" is the project's own May 2026 decision rediscovered from outside — Ass_cyc over Com_cyc, with MO_1 staged. An external interlocutor reaching the same
    conclusion from the architecture alone is mild independent support for a decision that was made on philosophical grounds.
  - The finite layer already is this shape at baby scale: FiniteFrameCategory, a Cubical Coverage, presheaves, and a descent condition is "presheaves on a category of shapes, cut down by
    gluing." And R4 is a change of value category over one site, which in arc/19's vocabulary is a statement about Fun(Dᵒᵖ, C) for two different C.

  Constructible — in three stages, with the difficulty misallocated in the transcript.

  - The ribbon/modular layer: constructible, and there is real machinery the file doesn't cite — Hackney–Robertson–Yau on ∞-properads and ∞-wheeled properads (graphical sets, graphical
    Segal conditions), Hackney–Robertson on modular operads, Raynor on Segal conditions for modular operads. Hard, existing, less mature than the dendroidal case, and with known coherence
    subtleties that trees don't have.
  - The internalization: the transcript says the bottleneck is "no longer A or C" and puts it all in D. I'd push back. A ≃ Seg_D(C) for C a general ∞-topos rather than Spaces is itself a
    research step — graphical Segal conditions internal to an arbitrary ∞-topos are not off the shelf. That's a second bottleneck, not a free move.
  - The dessin layer: not currently constructible, and I'd be sharper than the file's 5/10. A category of arities needs elementary shapes with grafting. Ribbon graphs have that — which is
    the modular operad story. But a dessin is a ribbon graph plus an arithmetic condition, and the arithmetic is exactly what does not participate in grafting. So the honest statement is
    that the graphical layer is the constructible part and "dessin" adds data the nerve theorem neither needs nor can currently use. That matches what related_structures.md now says about
    no arithmetic carrier existing in Hoapa. Take dessins off the critical path; keep them as the far-end aspiration they already are.

  2. Appropriate for the new direction

  Here I think the answer is partly no, and the first item is the one that matters.

  A. arc/19's C is not the project's M, and the file doesn't notice the fork. Two days ago AGENTS.md was rewritten to say "the world/context setting is to be discovered, not prescribed as 
  cohesive or modal HoTT," and future_work.md §C says M must not be a preselected setting. arc/19 prescribes C = an ∞-topos. So either:

  - C is M, and the architecture silently reinstates the prescription the project just spent a session removing; or
  - C is not M, and the architecture is entirely internal to K — a site of shapes, its presheaves, an algebra, and an ambient semantic universe — saying nothing about the cross-side
    relation.

  My read is the second, and it is the good reading: everything in arc/19 is K-side vocabulary — interaction topologies, agents at vertices, channels at edges, session types as the
  algebra. The ∞-topos is the ambient K's objects live in, not the world to decipher. Read that way, arc/19 serves §A of the new programme, essence extraction, which is exactly the task
  with the least material and the most need. But it has to be labelled that way explicitly, or the next session reads "C = ∞-topos" as an answer to M.

  B. It gains composability and loses the two-counits reading — and that's a trade, not an improvement. What you proposed two turns ago was free/forgetful and nerve/realization between M 
  and K, with their counits measuring genuinely different failures (structure the context didn't force; parts the probes don't reach), and Care possibly living in their comparison. arc/19
  instead puts both adjunctions in a chain, D̂ ⇄ C ⇄ A, where they compose into a single adjunction with a single counit. That solves the interaction problem cleanly and simultaneously
  throws away the thing the two-adjunction idea was for. Both configurations are legitimate; they are not the same proposal, and picking one is a decision.

  C. It contributes nothing to T_comparison, which is now the primary target. arc/19 is a presentation architecture — how to present K's objects by combinatorial generators. Adequacy,
  alternatives, specialness, comparison: none of it appears. There are no rivals, no contexts, no uses.

  One real qualification: a nerve theorem is an architectural characterization ("A is exactly the Segal presheaves"), which is the theorem shape I said the project has no template for. So
  arc/19 supplies a template of the right kind. But it characterizes A as a category, not Hoapa as a distinguished object among alternatives. Two different theorems, and the file's framing
  invites conflating them.

  D. Directedness, now the sixth occurrence. Ribbon and dessin structure is about cyclic order and surface embedding, not direction. K's causal structure is directed in four places.
  Wheeled properads have inputs and outputs, so the graphical layer can carry direction — but the surface-embedding layer is where the project's chosen vocabulary is, and nothing here says
  whether that preserves K's directedness or washes it out. That is precisely the named open question in future_work.md §D, and arc/19 walks past it.

  E. Mechanical: two-thirds of the file is LaTeX, which AGENTS.md bans on the grounds that it doesn't render. You asked mid-conversation for Unicode and got it from line ~648 onward. If
  lines 1–640 are going to be read again, they need transcribing.

  What I'd do with it

  Keep it, and relabel it: arc/19 is a candidate presentation architecture for K, feeding §A, not a candidate for the correspondence. Record the monads-with-arities convergence and the
  Hackney–Robertson–Yau machinery in future_work.md §F, where the arities lead already sits. Record the MO_1 forcing case in status_formal.md, since that is a real change to a gate that
  has been open with no consumer for months. Split the bottleneck into the three stages above with their honest difficulties. And put the C-versus-M fork and the
  composability-versus-two-counits trade in writing as decisions, because both will otherwise be settled by default the next time someone reads the file.

---

## Discussion synthesis — 2026-09-27

This section summarizes the discussion following the reading of arc/19,
including the later Claude reviews and the instigator's clarification about
making content accessible without pushing it. It is the up-to-date account of
this candidate architecture. The conversations above remain historical records;
where they conflict with this synthesis, their claims are not current conclusions.
This is exploratory 1C material, not an implemented replacement for K, a change
to the runtime contract, or a declaration that the original conjecture is proved.

### 1. What emerged from the discussion

The promising idea is to let K present two related interfaces to a world/context
setting: documentary articulation and operational organization. The first makes
work describable and accessible; the second makes operations composable. A world
participates through a contextual interface, not by being exhaustively captured
by either presentation. Adjunctions can organize these relationships, but their
existence alone does not establish adequate scientific practice.

The discussion moved through four refinements:

1. The original nerve/free-algebra connection was corrected: forgetting and then
   taking an underlying nerve gives only the restriction of an algebraic nerve.
   Additional maps between free objects carry the algebraic content.
2. The two faces of K were accepted as possible interfaces, not as an assertion
   that the existing K is simultaneously two equivalent categories.
3. The world-interface and the category of underlying algebraic data were
   distinguished. An ambient semantic category and a category of collections
   valued in it are not automatically the same thing.
4. The passage from an episode to available documentation was distinguished from
   both adjoint round trips and from delivery. Its purpose is accessible reuse,
   not promotion or unsolicited distribution.

The main advance is an organization of research obligations: elementary shapes,
contextual interpretation, coherent operations, public evidence, and subsequent
use can be related without identifying them. The main outstanding work is to
construct these relationships for Hoapa while preserving its existing separations.

### 2. The categories and interfaces, with their types kept distinct

The compact diagram used in the discussion is:

```text
          Real                    Free
    D̂ ───────────▶ C ─────────────────────▶ A
       ◀──────────   ◀─────────────────────
          Nerve                  Underlying

          Real ⊣ Nerve       Free ⊣ Underlying
```

Its ingredients are not yet identified with whole sides of the conjecture:

| Ingredient | Mathematical role | Proposed project interpretation |
|---|---|---|
| D | Small category of documentary probes, with their maps | Shapes of articulation and changes of documentary perspective |
| D̂ = Fun(Dᵒᵖ, Spaces) | Space-valued presheaves on those probes | A candidate raw documentary interface of K |
| E | Candidate ambient semantic ∞-topos | Contextual possibilities, observations, resources, and their local variation as a world presents them |
| C | Underlying-data category, possibly constructed from E | Contextual material on which structured practices can operate |
| O | Algebraic pattern or appropriately specified operadic theory | Permitted elementary interfaces, substitutions, and composition laws |
| A | Category of structured systems, for example Seg_O(E) | A candidate operational interface of K |
| V | Linear/session semantic category, potentially context-indexed | Resource-sensitive content, kept distinct from cartesian locality |
| Episodes | A category still to be defined | Completed investigations, including success and failure, with appropriate comparison maps |

The qualification on C is important. A standard algebraic-pattern construction
has C = Fun(Oᵉˡ, E), where Oᵉˡ is the elementary part of the pattern, and
A = Seg_O(E). Its free/forgetful adjunction is between elementary E-valued data
and coherent systems, not in general between E itself and those systems.
Chu–Haugseng's Corollary 8.2 gives this monadic construction for a presentable
target E. This is established machinery; identifying the intended Hoapa objects
with its instances is the project obligation.
[Homotopy-Coherent Algebra via Segal Conditions](https://arxiv.org/html/1907.03977v3)

There is no contradiction between C being a collection or presheaf category and
being an ∞-topos: space-valued presheaf categories are ∞-topoi. Conversely,
Seg_O(E) is not automatically an ∞-topos merely because E is one. Nor does an
ordinary set-valued implementation automatically furnish the higher version.
[Higher Topos Theory](https://arxiv.org/abs/math/0608040)

Three distinctions must survive subsequent notation changes:

- A fixed operad, a category of operads, and a category of algebras for an operad
  are different mathematical objects. K's banked O₁ is not automatically A or O.
- Space-valued probe presheaves D̂ and E-valued graphical diagrams are different
  constructions. Their relationship needs stating, not silently identifying.
- A documentary format, a pattern of operational composition, and the theory
  category of free objects can have different maps even when they use related
  shapes. They must not all be denoted D without a comparison.

“Raw” means prior to the selected semantic or composition conditions, not prior
to all structure: a presheaf already respects identities and composition in D.
It may also include presentations that no admissible Hoapa episode produces.

### 3. What C or E would mean as a world-interface

The proposed interpretation is not “the complete universe” and not merely “the
syntax of Hoapa.” It is a resourceful contextual setting in which possibilities,
observations, constraints, and interfaces can be encountered and related. To
deserve the world-side reading, its objects and maps must have an interpretation
independent of their usefulness in explaining K. Choosing convenient semantics
alone would not establish that a world presents those semantics.

An ∞-topos is attractive because it supports local variation, descent, dependent
objects, and coherent equivalences. The relative point of view suggests working
in slices, transporting along base maps, and making constructions stable under
appropriate changes of base. Where applicable, dependent sums and products give
Σ_f ⊣ f* ⊣ Π_f. These are resources for the framework, not a proof that one fixed
topos exhausts M or that all project transitions preserve these structures.

This can express part of philosophical perspectivism: access is situated, local
presentations can differ, and comparison requires specified relations between
them. The analogy with Leibniz or Deleuze is interpretive, not an equivalence of
philosophical systems with a topos axiom list. Neither predetermined agreement
among perspectives nor one privileged global observer follows.

The earlier choice between “C is all of M” and “the architecture says nothing
about M” was too narrow. C or E could describe one contextual regime, an interface
to a world, or one member of a varying family. Varying the semantic setting,
probes, their interpretation, and the operational pattern supplies candidate
parameters for the comparison structure or for P. A category of such variations,
its maps, and its preservation laws have not yet been constructed.

### 4. The four functors, in project vocabulary

Fix a small probe functor i : D → C, and suppose C has the colimits needed for
realization. Separately suppose the intended free/forgetful construction exists.
The following names describe roles; they do not rename Allow and Require.

**Real : D̂ → C — contextual realization.** Interpret a documentary presentation
by assembling the contextual meanings of its probes, weighted by the presentation.
Equivalently, Real is the colimit-preserving extension of i along Yoneda. It gives
a documented arrangement contextual meaning; it does not certify that an external
physical world satisfies that arrangement. Empirical answerability remains a
separate requirement on the interpretation.

**Nerve : C → D̂ — contextual articulation.** Set Nerve(c)(d) = Map_C(i(d), c),
with restriction induced by maps of probes. This records how the chosen shapes
can be interpreted in a context and how those interpretations relate. The pair
(D, i), not D alone, determines the resulting mode of access. Nerve is not a
finite observed sample, an automatic public record, or a procedure that humans
can necessarily compute exhaustively.

**Free : C → A — freely organized praxis.** Equip underlying contextual data
with the operations and coherences required by the chosen organizational theory,
universally relative to that theory. This is Allow-shaped: contextual material
becomes available for structured composition. “Free” does not mean without
assumptions, without resource constraints, or socially unrestricted; the laws
and sorts of the chosen theory remain commitments.

**Underlying : A → C — contextual exposure of a practice.** Retain the selected
underlying contextual carrier while forgetting its chosen operational structure.
This is Require-shaped, but it is not automatically the transformation from a
live episode to public documentation. Its carrier must be specified before
forgetfulness can be interpreted as a particular information loss. In particular,
no-leak, provenance, and accessibility do not follow from right adjointness.

With D̂ and A read as K interfaces and C read as a contextual interface, the two
pairs have opposite adjoint polarities across the philosophical divide:

| Relation | M-interface → K-interface | K-interface → M-interface |
|---|---|---|
| Documentary | Nerve, right adjoint | Real, left adjoint |
| Operational | Free, left adjoint | Underlying, right adjoint |

This makes the existing nerve–realization polarity question concrete. It does not
force both pairs into one naming convention. The operational pair matches the
recorded Allow ⊣ Require orientation; the documentary pair would be additional,
differently oriented structure. This follows from these constructions, not merely
from drawing C between two other categories.

### 5. Units, counits, monads, and comonads

Write ηᴰ and εᶜ for the unit and counit of Real ⊣ Nerve, and ηᴬ and εᴬ for those
of Free ⊣ Underlying. Their candidate interpretations are as follows.

| Module | Type or endofunctor | Meaning and limitation |
|---|---|---|
| Documentary unit | ηᴰ_p : p → Nerve(Real(p)) | Compare initial documentation with the articulation of its contextual interpretation. It can identify distinctions as well as expose consequences; it is not automatically an inclusion. |
| Documentary counit | εᶜ_c : Real(Nerve(c)) → c | Compare reconstruction through the probes with the context. It tests this presentation system, not exhaustive access to reality. |
| Praxis unit | ηᴬ_c : c → Underlying(Free(c)) | Contextual data enter freely organized work. Borrow-shaped, but resource preservation and legitimate access remain obligations. |
| Praxis counit | εᴬ_a : Free(Underlying(a)) → a | Evaluate freely generated operations using the actual structure of a practice. This is not historical episode reconstruction. |
| Documentary monad | Tᴰ = Nerve ∘ Real on D̂ | Context-mediated rearticulation of documentation. Multiplication compares successive rounds with one round. |
| Praxis monad | Tᶜ = Underlying ∘ Free on C | Contextual data of freely generated work. Multiplication substitutes generated operations into generated operations. |
| Documentary comonad | Gᶜ = Real ∘ Nerve on C | The context as reconstructed through the probes, with coherent repeated presentation. |
| Praxis comonad | Gᴬ = Free ∘ Underlying on A | A free operational presentation of an existing practice, with coherent repeated presentations. |

Explicitly, the multiplications are Nerve εᶜ Real and Underlying εᴬ Free;
the comultiplications are Real ηᴰ Nerve and Free ηᴬ Underlying. These are
whiskered natural transformations with the indicated domains. Each adjunction
also requires its hom-space equivalence, naturality, and triangle identities;
the higher formulation needs the appropriate coherent versions.

If Nerve is fully faithful, εᶜ is an equivalence, Gᶜ is equivalent to the identity,
and Tᴰ is idempotent. This may describe exact presentation and stable inheritance.
It is not itself a mechanism for evolutionary novelty. The ordinary adjunction
facts, including the full-faithfulness criterion, are independent of their
proposed Hoapa interpretation.
[Adjoint functors, Stacks Project](https://stacks.math.columbia.edu/tag/0036)

The praxis counit deserves a specific caution. Even if a is a free algebra,
Free(Underlying(a)) → a is usually not invertible: forgetting a chosen generating
presentation and freely generating on every underlying element adds redundancy.
For a free monoid, the list of two one-letter words [x, x] and the one-element
list containing the word [xx] evaluate to the same word. The structure of this
evaluation can matter, but bare non-invertibility is not a specialness theorem.

### 6. What makes the two interfaces interact

The composite adjunction is Free ∘ Real ⊣ Nerve ∘ Underlying. It relates the two
K interfaces through contextual semantics. It has a documentary-side monad
Nerve ∘ Underlying ∘ Free ∘ Real and an operational-side comonad
Free ∘ Real ∘ Nerve ∘ Underlying. These constructions exist when the component
adjunctions do; their existence is not additional evidence for Hoapa.

The composite unit is:

```text
p → Nerve(Real(p)) → Nerve(Underlying(Free(Real(p))))
```

The composite counit is:

```text
Free(Real(Nerve(Underlying(a)))) → Free(Underlying(a)) → a
```

Thus the two component comparisons survive composition: documentary
reconstruction followed by operational evaluation. A composite adjunction does
not erase its components or turn their different failures into the same failure.
It also does not automatically give a quantitative decomposition of loss.

There is a second, more discriminating compatibility. Let Θ be the category of
free structured objects on selected underlying arities, with algebraic maps, and
let j : D → Θ send each arity to its free object. Under the relevant hypotheses,
the algebraic nerve takes values in Fun(Θᵒᵖ, Spaces), and:

**j* ∘ Nerve_A ≃ Nerve_C ∘ Underlying.**

Here j* means restriction along j. The free/forgetful hom-space equivalence gives
the objectwise identification; restriction is necessary because Θ carries maps
encoding operations and substitutions absent from D. The formula is not an
unrestricted identification of the two nerves. A fully faithful underlying nerve
cannot recover multiplication that Underlying genuinely forgot merely by being
composed with Underlying.

Monads with arities provide the ordinary-categorical theorem connecting these
data and characterizing the algebraic nerve's image under their hypotheses.
Higher algebraic-pattern results supply related higher machinery. Applying
either to Hoapa requires its hypotheses and interpretation, rather than a
postulated equivalence with the desired category.
[Monads with arities and their associated theories](https://arxiv.org/abs/1101.3064)

### 7. Making available, not advertising or pushing

The term “publication” in the preceding discussion meant a passage from a
completed episode to independently accessible documentation. The instigator
clarified the governing philosophy: everyone plays by the same rules; Hoapa
processes do not advertise or push content to prospective consumers. They make
it as accessible as possible, including pedagogical work, multiple interfaces,
and no paywalls. Consumer-initiated access is the intended direction of delivery.

Accordingly, “making available” is the appropriate interpretive phrase here.
Existing workflow uses of “publication transform” name the live/public artifact
boundary; they must not be read as a requirement for broadcasting. No extra
fundamental adjoint named Publication is selected by this discussion.

Making available and accessing are distinct responsibilities:

- An episode yields a stable, referenceable public artifact, with declared
  observations preserved and protected live information not exposed.
- Potential consumers approach that artifact through context-appropriate
  interfaces, without needing special standing or renewed producer permission.
- Pedagogical explanations, translations, and navigation can improve access
  without modifying the immutable source episode or pushing it to recipients.
  Derived presentations need their own provenance and compatibility claims.

The desired common rule is not “everyone receives the same representation.”
Identical presentations can impose very unequal burdens. The ambition is that
each admissible consumer perspective has an appropriate, low-burden route to
understanding, without privileged access. A candidate universal property could
require every independently specified admissible request to factor through the
public interface with appropriate coherent uniqueness. It would have to state
the request category and what counts as satisfying a request; those cannot be
defined merely as requests the chosen interface already happens to satisfy.

Existence of access arrows does not establish minimal effort. Effort requires
additional semantics for consumer circumstances, prerequisites, time, and other
burdens, or a distribution-free comparison over such circumstances. Equal formal
standing is not an assertion of equal numerical costs for all people. Nor does
accessibility imply that every artifact is relevant or usable for every task.
The open/no-paywall discipline is a project requirement, not a consequence of
adjunction axioms.

The no-push rule constrains allowed delivery operations. It does not prohibit
every mathematical arrow whose source is content: a map interpreting a document,
or an episode-to-record transformation, is not an unsolicited message to a person.
The model should distinguish mathematical interpretation from operational delivery.

### 8. A possible semantic comparison for available documentation

The chain already has an A → D̂ functor, Nerve ∘ Underlying. The missing ingredient
is not an arrow with that type but an interpretation of actual public evidence.
An exhaustive probe nerve need not coincide with an available public artifact.

For a bounded starting point, suppose a category Episodes and a functor
J : Episodes → A interpret completed episodes. Seek a candidate construction
Avail : Episodes → D̂ and a natural interpretation:

**α : Avail ⇒ Nerve ∘ Underlying ∘ J.**

Then Real ⊣ Nerve transposes α into:

**Real ∘ Avail ⇒ Underlying ∘ J.**

Its component is Real(Avail(e)) → Real(Nerve(Underlying(J(e)))) → Underlying(J(e)),
using Real(α_e) and εᶜ. This makes precise one possible relation between the
contextual meaning of available evidence and the context a practice exposes.
Neither Avail nor α exists merely because it has been named. The choice of episode
morphisms and the meaning of the evidence must make the proposed direction valid.

This comparison is not automatically a difference measure, inclusion, or loss
formula. If Avail is simply defined as Nerve ∘ Underlying ∘ J, the comparison
reduces to the existing counit and contributes no independent public-interface
semantics. To gain project content, specify observations and future uses that
must factor through Avail, and distinguish these from information deliberately
withheld. Public availability may preserve all declared uses while forgetting
many live distinctions; information loss and leakage remain different questions.

Avail is therefore a provisional name for a construction to investigate, not a
new adopted module of the original adjunction. Consumer-relative accessibility
would further organize the interfaces and requests through which Avail(e) is used.

### 9. Preserving K: an interface, not an erasure

K is not already one higher operad whose nerve automatically supplies everything
else. It has an operadic layer, actor-causal locality, value categories, session
syntax, descent constructions, and adapters. Its operadic organization can be an
interface to this architecture, but it does not replace the remaining layers.

| Existing concern | Preservation obligation for the candidate architecture |
|---|---|
| Unityped participants and equal standing | Typed operations and documentary concepts must not become intrinsic types or ranks of their producers. |
| Directed causality and strict-reflecting local views | Interpretation must retain the relevant causal relations; reuse must not collapse an episode into an actor through a frame morphism. |
| Cartesian locality versus linear content | Keep a resource-sensitive semantic category and an explicit adapter; copying a description must not license copying its resource. |
| Session composition and duality | Construct the particular action and laws, rather than infer them from the existence of a category of possible models. |
| Live/public distinction | State public observations and observer-relative protection, separately from raw actor relabeling invariance. |
| Success and failure closure | Both outcomes yield accountable, referenceable records; closure is not consensus. |
| Append-only inheritance and federation | Preserve stable references, pinned versions, local admission, and the absence of a compulsory global history or quotient. |
| Runtime/serialization boundary | No presentation theorem by itself changes the 2S/3R contract or authorizes implementation changes. |

The linear requirement is not optional. An ∞-topos can describe linear syntax,
but its cartesian product must not silently become the tensor governing session
resources. One candidate extension uses a linear/session category V, possibly
varying over contextual regimes, with a suitable cartesian–linear adapter. The
new interpretation must preserve the meaning of R4, which remains K-internal;
it does not turn R4 into the cross-side adjunction.

Banked R4 is scoped: the point-generated supported bridge is constructed relative
to its value-level hypotheses; the full finite-site route still has a reflector
obligation. The Sessions-to-Chu syntax realization is banked, while
`session-O1-action` remains postulated. A graphical presentation may provide a
setting in which that action can be constructed, but a nerve theorem does not
supply the particular session action or remove its postulate on its own.

### 10. Direction, graphical choices, and recorded failure

Cyclic, properadic, modular, wheeled, and ribbon structures answer different
questions. Cyclic composition removes a privileged output among boundary ports;
properadic composition supports multiple inputs and outputs with directed
acyclic composition shapes; modular structure supports contractions in its
undirected setting; wheeled variants admit directed contractions/feedback.
Ribbon structure records cyclic order. They are not interchangeable stages of
one escalation that Hoapa must complete.

In particular, cyclic boundary symmetry is not automatically loss of event
causality. The former concerns the presentation of an operation's boundary; the
latter orders occurrences in a history. Their compatibility needs a construction,
potentially carrying polarization or causal decoration. It is a real obligation,
not an already established contradiction in K.

A cyclic graphical nerve does not require the modular envelope MO₁. Existing
higher cyclic-operad theory already uses unrooted-tree shapes. An operation
requiring self-contraction would provide a reason for MO₁; ordinary later reuse
of an artifact may only require composition with a fresh occurrence. Renewal
must not be called genus-raising without identifying the actual contraction.
[Higher cyclic operads](https://arxiv.org/abs/1611.02591)

Failure also needs a distinct reading. A failed investigation can have a perfectly
coherent record: disagreement, insufficient evidence, or an unsuccessful result
does not imply that the mathematical composition laws failed. A category can
contain processes ending in recorded failure and still have a Segal nerve.
Where proposed local claims really are incompatible, retain the attempted claims
and their incompatibility evidence; do not falsely treat them as a matching
family. The model of attempts and outcomes can itself be coherent.

Thus failure of the work, incompatibility of claims, and failure of a proposed
Segal/descent axiom are different events. The new architecture must express the
first two without requiring its own defining mathematics to fail. Compatible
operadic assembly also does not imply agreement among participants, empirical
adequacy, or successful scientific understanding.

### 11. Borrow–work–return–replay and context renewal

Work is an actual operation or morphism, not one of the four functors merely
renamed. For example, w : Free(c) → a transposes to:

**w♯ = Underlying(w) ∘ ηᴬ_c : c → Underlying(a).**

This separates a general organizational capacity from a particular use of it.
The transpose gives a contextual account of the work. It does not itself prove
that an artifact is accessible, adequate for a future task, or safely reusable.
The existence of transposition is generic to adjunctions, not evidence that this
particular pair models Hoapa.

Replay needs a subsequent consumer context, an admissible request or input
interface, and an operation using what has been made available. Its mathematical
description can involve documentary realization, contextual transport, and
operational substitution together. It need not be identified with Underlying,
Real, or any one primitive functor. The no-push rule fits this reading: later
practice reaches for an available artifact rather than receiving compulsory uptake.

Returning a particular artifact and returning a rule that later users instantiate
remain different possibilities. The Σ-shaped packaging / Π-shaped abstraction
distinction is a useful candidate when dependent adjoints are actually available;
it is not a theorem that every document or reuse episode already has one of these
forms. Failure to admit the required abstraction could itself be informative.

Evolution has at least two candidate levels: work and inheritance inside a fixed
regime, and transformations of contexts, patterns, or admissible operations
between regimes. Idempotent completion inside a regime can support stable
inheritance. Novelty may require a new operation, interpretation, or regime;
repeating a monad is not automatically such a change. The forcing witness remains
an artifact used in later work while specified achievements stay usable and a
new operation becomes possible. Variation of parameters alone does not prove it.

### 12. Where the project's major concerns could live

**Anthropic loss.** Distinguish the world's passage into a modeled interface,
the reconstruction possible through chosen probes, the live-to-public passage,
and the adequacy of later reuse. The documentary counit is a candidate for the
second comparison. Non-density can involve missing relational information, not
literal unseen parts; density inside C does not establish complete access to
the world. The free/forgetful counit concerns operational evaluation, not the
same loss. No single counit, entropy, or divergence is selected as their common
measure, and loss of actual episode distinctions is not statistical
reconstruction error or leakage.

**Care.** Session duality supplies an existing symmetry-related structure, not
by itself a selection of viable continuations. Further interpretation would
need to say what borrowed resources, participants, and surrounding conditions
must remain capable of supporting subsequent work, and how those requirements
behave under composition and contextual change. The model cannot establish that
it cares simply by omitting what its processes damage. Care can remain an
interpretive anchor while such semantics are investigated; a dedicated new
categorical mechanism is not assumed here.

**Specialness and adequacy.** A nerve theorem characterizes a category of systems;
monadicity characterizes a relationship with underlying data. Neither alone
distinguishes Hoapa-like practice as especially adequate. The comparison must
include independently meaningful alternatives, contexts, requests, and future
uses. A universal property might characterize public accessibility, semantic
sufficiency, compositional preservation, or renewal under stated constraints.
Those would be relational results about an architectural class; Hoapa's membership
and implementation fidelity would then require checking separately. Numerical
scores or entropy are not prerequisites.

**Universal language.** Keep a directed documentary presentation Lᵥ and a
version-specific class Wᵥ of admitted comparisons. The localization
Lᵥ[Wᵥ⁻¹] is universal for interpretations that invert those comparisons, not
for all possible truth or all scientific language. Dependencies remain directed;
only selected comparisons are inverted. Retain (Lᵥ, Wᵥ), provenance, and admission
history rather than replacing them with the localization. Withdrawal changes a
later version's admissions; it does not un-invert a map inside the old version.
No canonical meaning-preserving transition between arbitrary versions follows.

**Further indispensable concerns.** Empirical answerability, preservation of
provenance, accountable failure, actor neutrality, protected live information,
resource sensitivity, open access, and local federation remain part of judging
the model. They cannot disappear merely because the chosen presentation theorem
does not mention them. Nor must every philosophical anchor become a separate
functor: interpretation can carry an anchor where the model retains enough
structure to make its claims answerable.

### 13. The mirror and the presuppositionlessness motivation

The two K interfaces fit the interpretation developed in arc/18. What is
decomposed is understanding of the world: participants under a common interface
give its predominantly synthetic articulation; typed concepts and documentation
give its predominantly analytic articulation. Both moments can occur in both
realms. Typed operation vertices need not type people, and the model must not
turn a person's documentary output into the basis of their formal standing.

Documentation aspires to synthetic organization when its particular accounts
become a common language or a reusable contextual presentation. The architecture
offers mechanisms to investigate this: local articulation, interpretation,
substitution, and coherent integration are distinct responsibilities with maps
between them. In an algebraic pattern, inert/active structure can organize some
of these distinctions, but it is not automatically identical to Hoapa's own
separations or to Lautman's decompositions.

This develops the mirror as separation enabling integration, with integration
requiring further distinctions. It can primarily affect documentation while
leaving the participant interface opaque and unityped. The surface between
reality and understanding both separates and connects; it is neither an identity
between them nor a hierarchy in which one is wholly derived from the other.

The instigator found K's two interfaces particularly presuppositionlessness-
friendly. The qualified agreement is important: documentary articulation and
operational organization need not be silently identified, and their relation
passes through an explicit contextual interpretation. The architecture still
chooses probes, operational laws, and semantic settings. In particular (D, i)
is a substantive commitment about what can be articulated. The advantage is
that these commitments can be exposed and varied, not that they vanish. A
stable external artifact interface need not freeze all future expressive power.

### 14. Physics siblings and the long-horizon graphical direction

The architecture gives plausible points of contact with field theories:
composition along interfaces, assignment of semantic data to geometric or
combinatorial regions, and reconstruction from compatible local data. Bordism
categories and their symmetric monoidal functors offer a precise model of one
such interface/composition relationship; factorization homology offers another
local-to-global construction once its algebraic and geometric hypotheses hold.
[On the Classification of Topological Field Theories](https://arxiv.org/abs/0905.0465),
[Factorization homology of topological manifolds](https://arxiv.org/abs/1206.5522).

These are possible siblings and sources of obligations, not an existing bridge
from K to field theory. Boundary composition is not automatically the project's
site descent, session duality is not automatically orientation reversal, and a
boundary interface does not establish a bulk/boundary equivalence or holography.
One must specify geometric data, permitted gluings, target tensor structure,
and any dualizability or reconstruction hypotheses required by the desired theorem.

Dessins remain a possible earned refinement, not the critical path. The
dessin–Belyi correspondence does not impose an extra arithmetic admissibility
filter excluding most connected bipartite cellular maps on oriented closed
surfaces. The immediate architectural issue is instead that closed dessins do
not yet provide the open ports and substitutions needed for the selected arities.
Nor has Hoapa supplied an arithmetic carrier whose Galois action would contribute
to the conjecture. Symmetry alone is not irreversible evolution.

### 15. What is constructible, and what would count as progress

Established mathematics supplies generic examples of the adjunctions, algebraic
nerve theorems, higher cyclic/graphical models, and Segal objects in presentable
semantic targets. The research burden is not concentrated solely in choosing D.
It also includes extracting K's pattern, its session interpretation, preserving
R4 and causality, interpreting world-contexts, constructing available evidence,
and relating these to actual future uses.

Potential bounded tests remain a portfolio, not a newly selected work order:

- Interpret a small cyclic operation in directed histories and test that its
  permitted boundary changes do not erase a causal distinction.
- Construct two pieces of compatible work and their composition; vary the
  compatibility or resource use and retain a negative control.
- Interpret one successful and one failed closed episode, each with a stable
  accessible record and a declared future use.
- State an observation that factors through the available artifact, a protected
  distinction that must not be exposed, and a rival interface requiring producer
  authorization for the same reuse request.
- Exhibit the difference between an underlying arity map and an algebraic theory
  map, testing that the latter's operational meaning is not lost by presentation.
- Give a versioned comparison that can be withdrawn without deleting its claim
  history or pretending to reverse a prior localization.

Each formal batch would still need its own named unmet obligation and positive/
negative controls. No Agda inhabitant or new theorem is supplied by this prose.
Existing source material is retained, and this synthesis alone neither retires
K modules nor changes 2S/3R behavior.

### Consequences for the original conjecture

The original Allow : M → K ⊣ Require : K → M is not disproved or constructed by
this architecture, but its possible organization becomes richer and more precise:
the operational interface offers an Allow/Require-shaped pair, the documentary
interface offers a differently oriented realization/nerve pair, and their
interaction could express how situated work becomes intelligible and reusable
through a context. M may consequently need to organize contextual interfaces and
their variations rather than be identified with one preselected ∞-topos; K may
enter through multiple faithful interfaces rather than one undifferentiated
category. The conjecture's central burden remains relational: characterize why
a Hoapa-like discipline is especially adequate to understanding its contexts and
enabling new ones, compared with genuine alternatives, while preserving equal
standing, resource sensitivity, accountable evidence, and consumer-initiated open
access. A nerve theorem or a monadicity theorem would be a component of that
argument, not the argument itself. This synthesis therefore records a promising
candidate refinement of the conjecture and a setting for its obligations, not a
silent replacement of its statement or a proof of methodological optimality.
