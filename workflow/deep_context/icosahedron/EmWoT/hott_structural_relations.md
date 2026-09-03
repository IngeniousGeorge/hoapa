# Structural Relations in Homotopy Type Theory

## Introduction

Where the partition document asked "what groups do types fall into?", this document asks "how do types relate to each other?" We seek:

- **Progressions**: linear sequences where each type leads to the next
- **Hierarchies**: partial orders with types above/below others
- **Adjunctions**: dual pairs in tension
- **Exact sequences**: types connected by maps with kernel/image relationships
- **Spectra**: infinite progressions with stabilization
- **Cycles**: closed loops of transformation

Throughout, we treat types not as static objects but as nodes in a living graph of mathematical structure.

---

## 1. The h-Level Hierarchy

The most fundamental linear progression in HoTT.

```
        (−2)           (−1)            (0)            (1)            (2)
    Contractible → Propositions →    Sets    →   Groupoids  →  2-Groupoids → ···
         │              │              │             │              │
         1           0, 1, ∥A∥₋₁      ℕ, ℤ, 2      S¹, BG         S², BG²
```

### The Progression

Each level n contains types where all identity types are level (n−1):

$$\text{is-}(n+1)\text{-type}(A) \;:=\; \prod_{x,y:A} \text{is-}n\text{-type}(x =_A y)$$

**Base case:** (−2)-types are contractible (unique point up to unique path up to...)

### Key Maps

**Downward (forgetting structure):**
Every (n)-type is automatically an (n+1)-type. This gives an inclusion:

$$n\text{-Type} \hookrightarrow (n+1)\text{-Type}$$

**Upward (truncation):**
The n-truncation ∥−∥ₙ forces any type down to level n:

$$\|{-}\|_n : \text{Type} \to n\text{-Type}$$

### The Adjunction

Truncation and inclusion form an adjunction:

$$\|{-}\|_n \;\dashv\; \text{incl} : n\text{-Type} \hookrightarrow \text{Type}$$

This means: maps from ∥A∥ₙ into an n-type B correspond to maps from A into B.

### Philosophical Note

The h-level hierarchy measures **information content**:
- Propositions: yes/no (one bit)
- Sets: which element (discrete choice)
- Groupoids: which element + which identification
- n-Groupoids: n layers of identification

Ascending = more structure. Descending via truncation = controlled forgetting.

---

## 2. The Suspension-Loop Adjunction

The fundamental engine of homotopy theory.

```
              Σ
    Type ⇄ Type•
              Ω
```

### The Operators

**Suspension Σ:** Adds dimension, creates two poles connected by paths

$$\Sigma A \;:=\; \text{Pushout}(1 \leftarrow A \rightarrow 1)$$

Two points (north, south) with an A-indexed family of paths between them.

**Loop space Ω:** Extracts the self-paths at a point

$$\Omega(A, a) \;:=\; (a =_A a)$$

### The Adjunction

$$\Sigma \;\dashv\; \Omega$$

Maps out of ΣA correspond to maps into ΩB:

$$(ΣA \to B) \;\simeq\; (A \to ΩB)$$

This is the **fundamental adjunction of homotopy theory**.

### Iteration and Spectrum

Iterating gives the sphere spectrum:

```
         Σ          Σ          Σ          Σ
    S⁰ ────→ S¹ ────→ S² ────→ S³ ────→ S⁴ ────→ ···
    2       ○        ●        ●        ●
         
         Ω          Ω          Ω          Ω
    ··· ←──── Ω⁴S⁴ ←──── Ω³S³ ←──── Ω²S² ←──── ΩS¹ ←──── S⁰
```

**Freudenthal Suspension Theorem:** These eventually stabilize:

$$\pi_k(S^n) \cong \pi_{k+1}(S^{n+1}) \quad \text{for } k < 2n - 1$$

### The Cycle

For any type, we have canonical maps:

```
        unit                    counit
    A ────────→ Ω(ΣA)      Σ(ΩA) ────────→ A
```

These measure "how far" A is from being a loop space or a suspension.

---

## 3. The Fiber-Cofiber Duality

Dual exact sequences in HoTT.

### Fiber Sequences (Pullback-based)

Given f : A → B and a point b : B:

```
    fib_f(b) ────→ A ────→ B
        │          │f      │
        ↓          ↓       ↓
        1 ────────→ B ─────→ B
              b         id
```

This extends infinitely:

```
··· → Ω²B → Ω(fib_f(b)) → ΩA → ΩB → fib_f(b) → A → B
                                         f
```

The **long exact sequence of homotopy groups**.

### Cofiber Sequences (Pushout-based)

Dually, the cofiber (mapping cone):

```
    A ────→ B ────→ cofib_f
    │       │           │
    ↓       ↓           ↓
    1 ←──── A ────→    B
```

This extends:

```
A → B → cofib_f → ΣA → ΣB → Σ(cofib_f) → Σ²A → ···
     f
```

The **cofiber sequence** (Puppe sequence).

### The Duality

| Fiber (Ω-direction) | Cofiber (Σ-direction) |
|---------------------|----------------------|
| Pullback | Pushout |
| Kernel-like | Cokernel-like |
| Measures "what maps to b" | Measures "what's added beyond A" |
| Ω extends left | Σ extends right |

### Example: The Hopf Fibration

```
    S¹ ────→ S³ ────→ S²
    
    fiber      total    base
```

The fiber sequence reveals π₃(S²) ≅ ℤ (the Hopf invariant).

---

## 4. The Universe Hierarchy

An infinite tower of containment.

```
    U₀ : U₁ : U₂ : U₃ : ··· : U_ω : ···
```

### Structure

Each universe contains all types from lower universes, closed under type formers:

$$A : U_i \;\Rightarrow\; A : U_{i+1}$$

### Typical Ambiguity

In practice, we work "level-polymorphically":

$$\Pi, \Sigma, \to, +, \times, \text{Id}, W, \text{etc.}$$

all work at any universe level.

### The Point at Infinity

Per the earlier discussion, U can be:
- **Internal**: the system reflecting on itself (introspection)
- **External**: the ambient medium the system navigates within

```
    ┌──────────────────────────────────────┐
    │             U (external)             │
    │    ┌────────────────────────────┐    │
    │    │         System             │    │
    │    │    (types, operations)     │    │
    │    └────────────────────────────┘    │
    └──────────────────────────────────────┘

              ↕ internalize/externalize ↕

    ┌──────────────────────────────────────┐
    │              System                  │
    │    ┌────────────────────────────┐    │
    │    │        U (internal)        │    │
    │    │       (reflection)         │    │
    │    └────────────────────────────┘    │
    └──────────────────────────────────────┘
```

---

## 5. The Inductive-Coinductive Duality

W-types and M-types as dual generators.

```
              initial algebra
    F-Alg ←─────────────────── W_F
              
              final coalgebra  
    F-Coalg ─────────────────→ M_F
```

### W-types (Inductive)

$$W_{(a:A)} B(a)$$

- Built **up** from constructors
- **Finite** depth (well-founded)
- Eliminated by **recursion/catamorphism**
- Examples: ℕ, List, Tree, Ord

### M-types (Coinductive)

$$M_{(a:A)} B(a)$$

- Observed **down** by destructors
- **Infinite** depth possible
- Eliminated by **corecursion/anamorphism**
- Examples: Stream, Coℕ, Process, Behavior

### The Duality Table

| W (Inductive) | M (Coinductive) |
|---------------|-----------------|
| Initial algebra | Final coalgebra |
| Constructors | Destructors |
| fold (catamorphism) | unfold (anamorphism) |
| Termination | Productivity |
| Finite paths | Infinite paths |
| Built bottom-up | Observed top-down |
| "What it's made of" | "What it does" |

### The Morphism Spectrum

Between initial and final, there's a spectrum:

```
    W_F ─────────────────────────────────→ M_F
         initial                    final
         
    unique map from initial to final (if F is suitable)
```

This map embeds finite structures into their infinite completions:
- ℕ ↪ Coℕ (finite naturals into lazy naturals)
- List(A) ↪ Stream(A) (finite lists into streams)

---

## 6. The Colimit-Limit Duality

The fundamental categorical duality instantiated in types.

### Primitive Colimits and Limits

```
    COLIMITS (Σ-like)              LIMITS (Π-like)
    "freely generated"              "universally constrained"
    
    0 (initial) ←───────────→ 1 (terminal)
    
    A + B (coproduct) ←─────→ A × B (product)
    
    Pushout ←───────────────→ Pullback
    
    Coequalizer ←───────────→ Equalizer
    
    Σ (dep. sum) ←──────────→ Π (dep. product)
    
    ∃ (truncated Σ) ←───────→ ∀ (as Π)
    
    ∥A∥ (prop. trunc.) ←────→ ??? (no simple dual)
    
    Suspension ←────────────→ Loop space
```

### Universal Properties

**Colimits:** unique map OUT

$$\text{Hom}(\text{colim } D, X) \cong \lim_i \text{Hom}(D_i, X)$$

**Limits:** unique map IN

$$\text{Hom}(X, \lim D) \cong \lim_i \text{Hom}(X, D_i)$$

### The Hexagon of Type Formers

```
                    Π
                  /   \
                 /     \
               →         Equalizer
              /             \
             /               \
           ×                  Pullback
            \                 /
             \               /
              \             /
               1 ─────── (terminal)


                    Σ
                  /   \
                 /     \
              +           Coequalizer
              /             \
             /               \
           ×?                 Pushout
            \                 /
             \               /
              \             /
               0 ─────── (initial)
```

(The hexagon isn't perfectly symmetric — limits and colimits have different "shapes" in dependent type theory.)

---

## 7. The Truncation Tower (Postnikov)

Every type decomposes into h-level layers.

```
    A
    │
    ↓ map to truncation
    ∥A∥₀ ←── set reflection
    │
    ↓
    ∥A∥₋₁ ←── propositional reflection  
    │
    ↓
    ∥A∥₋₂ = 1 (if A inhabited)
```

### The Full Tower

For a type A, its **Postnikov tower**:

```
    A
    │
    ↓
    ··· → A₍₂₎ → A₍₁₎ → A₍₀₎ → A₍₋₁₎ → A₍₋₂₎
              ↓       ↓       ↓        ↓
           2-type  1-type   set     prop
```

Each level "forgets" higher homotopy:
- A₍₀₎ = ∥A∥₀ remembers points and equality, forgets paths between equalities
- A₍₁₎ remembers up to 2-paths, forgets 3-paths
- etc.

### The Dual: Whitehead Tower

Going the other direction, killing *lower* homotopy:

```
    ··· → A⟨2⟩ → A⟨1⟩ → A⟨0⟩ → A
              ↑       ↑       ↑
          2-conn.  1-conn.  0-conn.
```

Each A⟨n⟩ is n-connected (trivial homotopy up to level n).

### The Decomposition Principle

Any type is "caught between" its Postnikov and Whitehead towers:

```
    Whitehead                    Postnikov
    (kill low)                   (kill high)
    
    A⟨∞⟩ → ··· → A⟨1⟩ → A → A₍₁₎ → A₍₀₎ → ···
                         ↑
                    original type
```

---

## 8. The Eilenberg-MacLane Spectrum

Classifying spaces for cohomology.

### Definition

For an abelian group G:

$$K(G, n) := \text{the unique type with } \pi_n(K(G,n)) = G \text{ and } \pi_k = 0 \text{ for } k \neq n$$

### The Spectrum Structure

```
    K(G, 0) ←─Ω── K(G, 1) ←─Ω── K(G, 2) ←─Ω── K(G, 3) ←─Ω── ···
        G          BG          B²G         B³G
        
        │           │            │           │
        Σ           Σ            Σ           Σ
        ↓           ↓            ↓           ↓
```

$$\Omega K(G, n+1) \simeq K(G, n)$$

### Examples

```
    K(ℤ, 0) = ℤ       (integers as a set)
    K(ℤ, 1) = S¹      (circle!)
    K(ℤ, 2) = ℂP^∞    (infinite complex projective space)
    
    K(ℤ/2, 1) = ℝP^∞  (infinite real projective space)
```

### Cohomology

The Eilenberg-MacLane spaces **represent** cohomology:

$$H^n(X; G) \simeq \|X \to K(G, n)\|_0$$

Cohomology classes are (truncated) maps into K(G,n).

---

## 9. The Adjunction Web

Type formers connected by adjunctions.

```
                            ┌─────────────────┐
                            │                 │
                      ┌─────┤  Σ ⊣ Δ ⊣ Π     ├─────┐
                      │     │  (in slices)    │     │
                      │     └─────────────────┘     │
                      │                             │
                      ↓                             ↓
              ┌───────────────┐           ┌───────────────┐
              │  A × − ⊣ A →  │           │   − + A ⊣ ?   │
              │   (curry)     │           │   (cocurry)   │
              └───────────────┘           └───────────────┘
                      │                             │
                      │     ┌─────────────────┐     │
                      └────→│   Σ_A ⊣ Ω_A     │←────┘
                            │  (suspension)   │
                            └─────────────────┘
                                    │
                                    ↓
                            ┌─────────────────┐
                            │   ∥−∥ₙ ⊣ incl   │
                            │  (truncation)   │
                            └─────────────────┘
```

### The Master Adjunction: Σ ⊣ Δ ⊣ Π

In the slice category over B, given f : A → B:

$$\Sigma_f \;\dashv\; f^* \;\dashv\; \Pi_f$$

where:
- Σ_f : reindexing/composition (dependent sum)
- f* : pullback (substitution)  
- Π_f : dependent product along f

This is the **fundamental adjoint triple** governing dependent type theory.

---

## 10. The Identity System

The web of identity-related types.

```
                         Univalence
                             ↑
                             │
    ┌────────────────────────┼────────────────────────┐
    │                        │                        │
    │      (A ≃ B)    ≃    (A =_U B)                  │
    │         │              │                        │
    │         │              │                        │
    │    ┌────┴────┐    ┌────┴────┐                   │
    │    │  Equiv  │    │   Id    │                   │
    │    └────┬────┘    └────┬────┘                   │
    │         │              │                        │
    │    components:         │                        │
    │    f : A → B          paths                    │
    │    is-equiv(f)        in a type                │
    │         │              │                        │
    │         ↓              ↓                        │
    │    ┌─────────────────────┐                      │
    │    │     transport       │                      │
    │    │   p_* : A(x) → A(y) │                      │
    │    └─────────────────────┘                      │
    │              │                                  │
    │              ↓                                  │
    │    ┌─────────────────────┐                      │
    │    │    path induction   │                      │
    │    │    (J eliminator)   │                      │
    │    └─────────────────────┘                      │
    │                                                 │
    └─────────────────────────────────────────────────┘
```

### The Identity Hierarchy

```
    x =_A y           (paths in A)
        │
        ↓ apply ap
    p =_{x=y} q       (paths between paths = 2-paths)
        │
        ↓ apply ap
    α =_{p=q} β       (3-paths)
        │
        ↓
       ···            (n-paths, the "homotopy hypothesis")
```

### Reflexivity-Symmetry-Transitivity

The identity type comes with:

```
    refl : x = x                      (id morphism)
    sym  : x = y → y = x              (inverse)
    trans: x = y → y = z → x = z     (composition)
```

Making each type an **∞-groupoid**.

---

## 11. The Modal Progression

Modalities as structure-preserving operations.

### The Truncation Modalities

```
    id         ∥−∥₁       ∥−∥₀       ∥−∥₋₁      ∥−∥₋₂
    ──────────────────────────────────────────────────→
    keep all   keep up    keep up    keep up    collapse
               to         to         to         to
               1-types    sets       props      point
```

Each is a **modality** (idempotent monad preserving certain structure).

### The Shape-Flat-Sharp Trinity (Cohesive HoTT)

In cohesive type theory:

```
           ʃ (shape)
          / \
         /   \
    ʃ ⊣ ♭ ⊣ ♯
         \   /
          \ /
       ♭ (flat)     ♯ (sharp)
```

- **ʃA**: the "shape" (fundamental ∞-groupoid)
- **♭A**: discrete type (no cohesion)
- **♯A**: codiscrete type (maximal cohesion)

### The Nullification Modalities

For a type A, the A-nullification:

$$L_A(X) := \text{localization of } X \text{ at } A \to 1$$

L_A(X) makes maps from A trivial.

Example: ∥−∥₋₁ is S⁰-nullification (makes 2-element type trivial → identifies all points).

---

## 12. The Hexagonal Identities

Relating the six fundamental concepts (from earlier discussion).

```
                        Abstraction
                       (Coeq — Π)
                      /           \
                     /             \
                    /               \
             Identity               Iteration
            (Id — ≃)                (ℕ — Σ)
                    \               /
                     \             /
                      \           /
              Cartesian ─────── Generation
               (→ — ×)         (W — Pushout)
                      \       /
                       \     /
                        \   /
                       Bounds
                       (0 — 1)
```

### The Flows

**Generation → Iteration:**
W-types build ℕ; Pushout builds Σ (suspension)

**Iteration → Abstraction:**
ℕ-indexed families generalize to Π; Σ iterated gives quotient structure

**Abstraction → Identity:**
Quotients create equivalences; Π-types have function extensionality (≃)

**Identity → Bounds:**
All identities in 0 (vacuously); identity in 1 (trivially)

**Bounds → Cartesian:**
0, 1 are identities for +, × respectively

**Cartesian → Generation:**
× and → are used to build W-types (branching); → and + build pushouts (spans)

---

## 13. The Homotopy Groups Progression

Extracting algebraic invariants.

```
    πₙ : Type• → Group  (n ≥ 1)
    π₀ : Type → Set
```

### The Definition Cascade

```
    π₀(A) := ∥A∥₀                    (path components)
    
    π₁(A, a) := ∥Ω(A,a)∥₀            (fundamental group)
    
    πₙ(A, a) := ∥Ωⁿ(A,a)∥₀           (n-th homotopy group)
              = π₀(Ωⁿ(A,a))
              = π₁(Ωⁿ⁻¹(A,a))
              = ···
```

### The Exact Sequence

For a fibration F → E → B:

```
    ··· → π₂(B) → π₁(F) → π₁(E) → π₁(B) → π₀(F) → π₀(E) → π₀(B)
```

This long exact sequence is the primary computational tool.

### Calculating πₙ(Sᵐ)

The sphere homotopy groups, a central object of study:

```
    π₁(S¹) = ℤ         (winding number)
    π₂(S²) = ℤ         (degree)
    π₃(S²) = ℤ         (Hopf invariant — surprising!)
    π₃(S³) = ℤ         (degree)
    π₄(S³) = ℤ/2       (more surprises...)
    
    Stable range: πₙ₊ₖ(Sⁿ) stabilizes for n > k+1
```

---

## 14. The Blakers-Massey Connectivity Theorem

How pushouts interact with connectivity.

### The Setup

Given a pushout square:

```
         f
    A ────→ B
    │       │
   g│       │j
    ↓       ↓
    C ────→ D
         i
```

### The Theorem

If f is m-connected and g is n-connected, then:

$$\text{fiber}(D \to B \times_A C) \text{ is } (m+n)\text{-connected}$$

### The Consequence

Pushouts "add connectivity":

```
    Connectivity of:
    
         (m)                (n)
    A ────────→ B      A ────────→ C
          f                  g
                    
                 ↓ pushout
                 
            (m + n + 2)-connected
            comparison map
```

### Application: Spheres

The suspension of an n-connected type is (n+1)-connected.

$$\Sigma S^n \simeq S^{n+1}$$

So S^n is (n-1)-connected.

---

## 15. The Fundamental Cycle: Construction ↔ Observation

The deepest structural relation: the dance between building and using.

```
    ┌─────────────────────────────────────────────────┐
    │                                                 │
    │   CONSTRUCTION                OBSERVATION       │
    │   (introduction)              (elimination)     │
    │                                                 │
    │        ↓                           ↓            │
    │   ┌─────────┐               ┌─────────────┐     │
    │   │ Positive│←─────────────→│  Negative   │     │
    │   │  Types  │    duality    │   Types     │     │
    │   └─────────┘               └─────────────┘     │
    │        │                           │            │
    │        │    canonical forms        │            │
    │        │    ←──────────────        │            │
    │        │                           │            │
    │        │    observations     │            │
    │        │    ──────────────→        │            │
    │        ↓                           ↓            │
    │   ┌─────────┐               ┌─────────────┐     │
    │   │  Data   │←─────────────→│  Behavior   │     │
    │   │  (W)    │    encode     │    (M)      │     │
    │   └─────────┘               └─────────────┘     │
    │        │                           │            │
    │        │         refine            │            │
    │        └───────────────────────────┘            │
    │                    ↑                            │
    │                    │                            │
    │              ┌───────────┐                      │
    │              │  PRAXIS   │                      │
    │              │  (using   │                      │
    │              │   types)  │                      │
    │              └───────────┘                      │
    │                                                 │
    └─────────────────────────────────────────────────┘
```

### The Rhythm

1. **Construct** (introduce data)
2. **Observe** (eliminate to extract information)  
3. **Abstract** (quotient irrelevant differences)
4. **Generalize** (Π over variations)
5. **Iterate** (apply recursively)
6. **Return** (construct new data)

This is the fundamental cycle of mathematical and engineering activity.

---

## 16. The Complete Web

Putting it all together: types as nodes, structural relations as edges.

```
                                    Universe
                                       │
                         ┌─────────────┼─────────────┐
                         │             │             │
                         ▼             ▼             ▼
                     h-levels    type formers   ∞-groupoids
                         │             │             │
              ┌──────────┴──────────┐  │  ┌──────────┴──────────┐
              │                     │  │  │                     │
              ▼                     ▼  ▼  ▼                     ▼
          −2    −1    0    1    2      Π  Σ  W  +  ×  →      Id ≃
          │     │     │    │    │      │  │  │  │  │  │       │ │
    contractible│     │    │    │      │  │  │  │  │  │       │ │
              props  sets  │   ···     │  │  │  │  │  │       │ │
                          grpds        │  │  │  │  │  │       │ │
                                       │  │  │  │  │  │       │ │
              ┌────────────────────────┘  │  │  │  │  │       │ │
              │  ┌────────────────────────┘  │  │  │  │       │ │
              │  │  ┌────────────────────────┘  │  │  │       │ │
              ▼  ▼  ▼                           │  │  │       │ │
           function spaces                     │  │  │       │ │
           dependent types ←───────────────────┘  │  │       │ │
           inductive types ←──────────────────────┘  │       │ │
                    │                                │       │ │
                    │        ┌───────────────────────┘       │ │
                    │        │       ┌───────────────────────┘ │
                    ▼        ▼       ▼                         ▼
                   ℕ ←────→ Ord    HITs ←──────────────────→ univalence
                   │               / │ \                        │
                   │              /  │  \                       │
                   │             ▼   ▼   ▼                      │
                   │           S¹  S²  Torus                    │
                   │            │   │    │                      │
                   │            └───┼────┘                      │
                   │                ▼                           │
                   │         homotopy groups ←──────────────────┘
                   │                │
                   │                ▼
                   │         algebraic topology
                   │                │
                   └────────────────┴──────→ computation
```

---

## Summary: The Living Structure

HoTT types form not a static taxonomy but a **dynamic network**:

| Structure Type | Examples | Character |
|----------------|----------|-----------|
| **Hierarchies** | h-levels, universes, Postnikov towers | Vertical, stratified |
| **Adjunctions** | Σ⊣Ω, ∥−∥⊣incl, curry | Horizontal tension |
| **Exact sequences** | Fiber sequences, Puppe sequences | Flowing, connected |
| **Spectra** | Spheres, Eilenberg-MacLane, stable homotopy | Infinite, stabilizing |
| **Dualities** | W/M, colimit/limit, positive/negative | Mirrored, complementary |
| **Cycles** | Construction↔observation, introspection↔externalization | Rhythmic, returning |

The types of HoTT are not isolated objects but **participants in structure** — defined by their relationships as much as their definitions.

---

## Appendix: Key Relations Reference

| Relation | Source | Target | Type |
|----------|--------|--------|------|
| Suspension | Type | Pointed Type | Functor |
| Loop | Pointed Type | Type | Functor |
| Σ ⊣ Ω | — | — | Adjunction |
| Truncation ∥−∥ₙ | Type | n-Type | Modality |
| Inclusion | n-Type | Type | Embedding |
| ∥−∥ₙ ⊣ incl | — | — | Adjunction |
| Postnikov A₍ₙ₎ | Type | n-Type | Tower |
| Whitehead A⟨n⟩ | Type | n-connected | Tower |
| Fiber | Map f:A→B | Type over B | Construction |
| Cofiber | Map f:A→B | Pushout | Construction |
| πₙ | Pointed Type | Group | Functor |
| K(G,−) | ℕ | Pointed Type | Spectrum |
| W | Signature | Type | Initial algebra |
| M | Signature | Type | Final coalgebra |

