# Partitions of Homotopy Types

## Original List
1. Universe
2. Id (Identity/Path type)
3. 1 (Unit)
4. 0 / Empty
5. Product (×)
6. Coproduct (+)
7. Function (→)
8. W-type
9. Suspension (Σ)
10. Natural numbers (ℕ)
11. Pushout
12. Interval (I)
13. Sphere (Sⁿ)
14. Torus (T²)
15. Dependent product (Π)
16. Dependent coproduct (Σ-type)
17. Quotienting (quotient types)
18. Equivalence (≃)
19. Truncation (‖-‖ₙ)
20. Booleans / 2

---

## 1. Positive / Negative / Neither

This is a fundamental distinction in type theory based on whether a type is characterized by its **constructors** (introduction rules) or its **eliminators**.

### Positive Types (defined by constructors)
- 0 / Empty
- 1 (Unit)
- Booleans / 2
- Coproduct (+)
- Dependent coproduct (Σ)
- Product (×) — *can be viewed either way, but often positive*
- W-type
- Natural numbers (ℕ)
- Suspension
- Pushout
- Interval
- Sphere
- Torus
- Truncation
- Quotienting
- Id — *positive in HoTT tradition*

### Negative Types (defined by eliminators)
- Function (→)
- Dependent product (Π)
- Product (×) — *in negative formulation*

### Neither / Special
- Universe — *not a standard inductive type; has special rules*
- Equivalence — *typically defined as a Σ-type, so positive, but conceptually special*

**Additional types not in original list:**
- **Stream types** (negative)
- **Record types** (can be positive or negative)
- **Coinductive types** generally (negative)

**Feedback:** The positive/negative distinction matters for computation and focusing in proof theory. Positive types have canonical forms; negative types are characterized by observations. In HoTT, most types are positive because higher inductive types are fundamentally about constructors (including path constructors).

---

## 2. Higher Inductive Types (HITs) / Ordinary Inductive / Neither

### Higher Inductive Types
*Have path constructors in addition to point constructors*

- Suspension
- Pushout
- Interval
- Sphere
- Torus
- Truncation
- Quotienting
- Id — *can be viewed as a HIT*
- **Circle (S¹)** — *not in list*
- **Coequalizer** — *not in list*
- **James construction** — *not in list*
- **Eilenberg-MacLane spaces K(G,n)** — *not in list*
- **Set-quotient** — *not in list*

### Ordinary Inductive Types
*Only point constructors*

- 0 / Empty
- 1 (Unit)
- Booleans / 2
- Coproduct
- Product
- Natural numbers
- W-type
- Dependent coproduct (Σ)
- **Lists** — *not in list*
- **Binary trees** — *not in list*
- **Ordinals** — *not in list*

### Neither
- Universe
- Function
- Dependent product (Π)
- Equivalence — *defined type, not inductive*

**Feedback:** HITs are the key innovation of HoTT, allowing us to define spaces with non-trivial homotopy structure directly. The distinction matters because HITs require additional computation rules (path computation) and have more complex metatheory.

---

## 3. By h-Level (Truncation Level)

### Propositions (h-level −1, "mere propositions")
*At most one element up to paths*

- 0 / Empty — *is a proposition*
- 1 (Unit) — *is a proposition (contractible)*
- Truncation ‖A‖₋₁ — *propositional truncation output*
- **Squash types** — *not in list*

### Sets (h-level 0)
*No non-trivial paths between elements*

- Booleans / 2
- Natural numbers (ℕ)
- Quotienting — *set quotients produce sets*
- Truncation ‖A‖₀ — *set truncation output*
- **Integers (ℤ)** — *not in list*
- **Rationals (ℚ)** — *not in list*
- **Finite types** — *not in list*

### 1-Types / Groupoids (h-level 1)
- Truncation ‖A‖₁
- **Groupoid quotients** — *not in list*

### Higher Types (h-level ≥ 2 or untruncated)
- Sphere Sⁿ (for n ≥ 2) — *S² is a 2-type, etc.*
- Torus — *1-type*
- Universe — *definitely not a set!*
- Id — *depends on base type*
- **Infinite-dimensional CW complexes** — *not in list*

### Variable / Depends on Input
- Product — *h-level is max of components*
- Coproduct — *h-level is max of components (if disjoint)*
- Function — *h-level of codomain (fibered)*
- Dependent product (Π) — *h-level of fibers*
- Dependent coproduct (Σ) — *at most 1 + h-level of base*
- W-type — *depends on arguments*
- Suspension — *raises h-level*
- Pushout — *depends on inputs*
- Equivalence — *proposition if between sets, otherwise higher*

### Contractible (h-level −2)
- 1 (Unit)
- Interval
- **Singleton types {a}** — *not in list*

**Feedback:** The h-level hierarchy is central to HoTT. Knowing a type's h-level tells you about its identity types. Most "mathematical" types we care about are sets (h-level 0), but HoTT allows working with genuinely higher types.

---

## 4. Type Formers vs Specific Types

### Type Formers (parametric constructors of types)
*Take types as input, produce types*

- Product (×)
- Coproduct (+)
- Function (→)
- Dependent product (Π)
- Dependent coproduct (Σ)
- Id
- W-type
- Suspension
- Pushout
- Truncation
- Quotienting
- Equivalence
- Universe — *also a type former in a sense*

### Specific/Concrete Types
*Fixed types with no type parameters*

- 1 (Unit)
- 0 / Empty
- Booleans / 2
- Natural numbers (ℕ)
- Interval
- Sphere (each Sⁿ)
- Torus
- **Circle S¹** — *not in list*
- **Real numbers ℝ** — *not in list (Cauchy or Dedekind)*
- **Integers ℤ** — *not in list*

**Feedback:** This is the fundamental distinction between "ways to build types" and "particular types." Most of the interesting structure in HoTT comes from type formers, while specific types serve as examples and building blocks.

---

## 5. Martin-Löf Type Theory (MLTT) Core vs HoTT Extensions

### Standard MLTT Types
*Present in intensional MLTT*

- Universe
- Id
- 1 (Unit)
- 0 / Empty
- Product (as Σ with constant family)
- Coproduct
- Function (as Π with constant family)
- Dependent product (Π)
- Dependent coproduct (Σ)
- Natural numbers (ℕ)
- W-type
- Booleans / 2

### HoTT Extensions / Require Axioms or HITs
- Suspension — *HIT*
- Pushout — *HIT*
- Interval — *HIT*
- Sphere — *HIT*
- Torus — *HIT*
- Truncation — *HIT*
- Quotienting — *HIT*
- Equivalence — *definable in MLTT, but univalence is an axiom*

**Additional MLTT types not in list:**
- **Finite types (Fin n)** — *derivable*
- **Lists** — *derivable*

**Additional HoTT types not in list:**
- **Localization** — *HIT*
- **Coequalizer** — *HIT*
- **Homotopy pushout/pullback** — *HIT constructions*
- **Real numbers (various)** — *require quotients/HITs*

**Feedback:** Understanding what's "built-in" to MLTT vs what requires HoTT extensions is crucial for implementation. HITs require additional computation rules and their metatheory (canonicity, normalization) is more complex.

---

## 6. By Arity (Number of Type Arguments)

### Nullary (0 type arguments)
- 0 / Empty
- 1 (Unit)
- Booleans / 2
- Natural numbers (ℕ)
- Interval
- Sphere (each Sⁿ fixed)
- Torus
- Universe (at each level)

### Unary (1 type argument)
- Suspension: A ↦ ΣA
- Truncation: A ↦ ‖A‖ₙ
- **List**: A ↦ List(A) — *not in list*
- **Maybe/Option**: A ↦ 1 + A — *not in list*

### Binary (2 type arguments)
- Product: A, B ↦ A × B
- Coproduct: A, B ↦ A + B
- Function: A, B ↦ A → B
- Equivalence: A, B ↦ A ≃ B

### Dependent / Families
- Dependent product: A, (B : A → U) ↦ Π(x:A).B(x)
- Dependent coproduct: A, (B : A → U) ↦ Σ(x:A).B(x)
- Id: A, a, b ↦ a =_A b — *ternary*
- W-type: A, (B : A → U) ↦ W(x:A).B(x)

### Ternary or Higher
- Pushout: A, B, C, f, g ↦ pushout — *really 5 arguments*
- Quotienting: A, R ↦ A/R — *binary, but R is a relation on A*

**Feedback:** Arity tells you about the "interface" of a type former. Dependent types blur this since families B : A → U are themselves rich. The pushout is notably complex, requiring a span.

---

## 7. By Connectedness

### Contractible (−1-connected, unique point up to homotopy)
- 1 (Unit)
- Interval
- **Singletons** — *not in list*
- **Path spaces in contractible types** — *not in list*

### 0-Connected (path-connected)
*Any two points can be connected by a path*

- Sphere Sⁿ (n ≥ 1)
- Torus
- Suspension of inhabited type
- 1 (Unit) — *also contractible*
- Interval — *also contractible*
- Truncation ‖A‖ₙ of inhabited A (n ≥ 0)
- Quotienting (often)
- **Circle S¹** — *not in list*
- **Real projective space** — *not in list*
- **Klein bottle** — *not in list*

### 0-Truncated Connected (path-connected sets)
- Truncation ‖A‖₀ of inhabited A

### Disconnected / Not Necessarily Connected
- 0 / Empty — *has no points*
- Booleans / 2 — *exactly 2 connected components*
- Natural numbers (ℕ) — *countably many components (as a set)*
- Coproduct — *disjoint union, so disconnected if both inhabited*
- Product — *depends on factors*

### Depends on Arguments
- Pushout — *can be used to connect things*
- Function — *depends on domain/codomain*
- Π, Σ — *depends on base and fibers*
- Id — *either empty or contractible (if over sets)*

**Feedback:** Connectedness is a homotopy-invariant property. In HoTT, we can define n-connectedness internally and prove things like "Suspension increases connectedness by 1."

---

## 8. By Role in Synthetic Homotopy Theory

### Spaces / Geometric Objects
*Things we study as spaces*

- Sphere
- Torus
- Interval
- Suspension (of a space)
- Pushout (gluing spaces)
- Quotienting
- **Circle** — *not in list*
- **Real projective spaces** — *not in list*
- **Classifying spaces BG** — *not in list*

### Structure Types / Algebraic
*Types that model algebraic structures*

- Natural numbers (ℕ)
- Booleans / 2
- **Integers ℤ** — *not in list*
- **Groups, Rings, etc.** — *not in list*

### Infrastructure / Meta-level
*Used to build and reason about types*

- Universe
- Id
- Function
- Dependent product (Π)
- Dependent coproduct (Σ)
- Equivalence
- Truncation

### Building Blocks / Primitives
*Simple types used everywhere*

- 0 / Empty
- 1 (Unit)
- Product
- Coproduct
- W-type

**Feedback:** Synthetic homotopy theory uses HoTT to prove classical theorems (π₁(S¹) = ℤ, etc.) without point-set topology. The "space" types are the subject matter; the rest is infrastructure.

---

## 9. Eliminators: Dependent / Non-dependent / Special

### Has Standard Dependent Eliminator (induction principle)
- 0 / Empty — *ex falso*
- 1 (Unit) — *trivial*
- Booleans / 2 — *case split*
- Coproduct — *case split*
- Product — *pairing*
- Dependent coproduct (Σ) — *exists-elim*
- Natural numbers — *nat-induction*
- W-type — *well-founded induction*
- Id — *path induction (J)*
- Suspension — *with path cases*
- Pushout — *with glue case*
- Interval — *trivial (contractible)*
- Truncation — *into truncated types*
- Quotienting — *respecting equivalence*

### Non-dependent / Function Eliminator Primary
- Function (→) — *application*
- Dependent product (Π) — *application*

### Special Elimination
- Universe — *no eliminator in usual sense; Tarski-style or Russell-style*
- Equivalence — *components are extractable*
- Sphere, Torus — *specific path cases via being HITs*

**Feedback:** The eliminator tells you how to use a type. Dependent elimination (induction) is more powerful than recursion and is central to proving properties.

---

## 10. Computational Content: Canonical / Non-canonical

### Canonical (closed terms have normal forms of expected shape)
- 0 / Empty
- 1 (Unit)
- Booleans / 2
- Natural numbers
- Product
- Coproduct
- Dependent coproduct (Σ)
- Function
- Dependent product (Π)
- W-type

### Non-canonical / Requires Axioms
*May have stuck terms without further axioms*

- Id — *with univalence, ua(e) doesn't compute in vanilla MLTT*
- Universe — *univalence*
- Equivalence — *uses Id*
- Truncation — *propositional truncation may not compute*
- Quotienting — *quotients may not compute*

### Computes with Cubical Type Theory
*Cubical TT restores computation*

- Id — *paths compute in cubical*
- Universe — *Glue types compute*
- Truncation — *some cubical systems handle this*
- **Higher inductive types generally** — *cubical gives computation*

**Additional non-computable with axioms:**
- **Axiom of choice** — *not in list*
- **Propositional resizing** — *not in list*
- **LEM** — *not in list*

**Feedback:** Canonicity (every closed term reduces to a canonical value) is important for computation. Classical HoTT with univalence as an axiom breaks this; cubical type theory fixes it.

---

## 11. Closure Properties in a Model

### Closed Under (preserved by equivalence)
- All type formers should be closed under equivalence

### Universe-independent
*Can be defined at any universe level*

- 0, 1, 2
- Product, Coproduct, Function
- Π, Σ, Id
- Natural numbers
- W-type
- All HITs

### Universe-dependent
- Universe itself — *stratified*
- Equivalence — *lives at level of types being compared*

**Feedback:** Universe polymorphism lets us avoid size issues. Most type formers are universe-polymorphic.

---

## Summary Table

| Type | Pos/Neg | HIT? | h-level | MLTT? | Arity |
|------|---------|------|---------|-------|-------|
| Universe | Neither | No | Varies | Yes | 0 |
| Id | Pos | (Yes) | Varies | Yes | 3 |
| 1 | Pos | No | −2 | Yes | 0 |
| 0 | Pos | No | −1 | Yes | 0 |
| Product | Both | No | Varies | Yes | 2 |
| Coproduct | Pos | No | Varies | Yes | 2 |
| Function | Neg | No | Varies | Yes | 2 |
| W-type | Pos | No | Varies | Yes | Dep |
| Suspension | Pos | Yes | +1 | No | 1 |
| ℕ | Pos | No | 0 | Yes | 0 |
| Pushout | Pos | Yes | Varies | No | 5 |
| Interval | Pos | Yes | −2 | No | 0 |
| Sphere | Pos | Yes | Varies | No | 0 |
| Torus | Pos | Yes | 1 | No | 0 |
| Π | Neg | No | Varies | Yes | Dep |
| Σ | Pos | No | Varies | Yes | Dep |
| Quotient | Pos | Yes | ≤ base | No | 2 |
| Equivalence | (Pos) | No | Varies | Yes* | 2 |
| Truncation | Pos | Yes | n | No | 1 |
| Bool/2 | Pos | No | 0 | Yes | 0 |

*Equivalence is definable in MLTT, but univalence is an axiom.

---

## Additional Types Not in Original List

For completeness, here are important types from HoTT not in the original list:

**Ordinary Inductive:**
- Lists, Vectors, Trees
- Integers ℤ
- Finite types Fin(n)
- Ordinals

**HITs:**
- Circle S¹
- Coequalizer
- Localization
- Eilenberg-MacLane spaces K(G,n)
- Real numbers (Cauchy/Dedekind)
- Set-quotients, Groupoid quotients
- Homotopy coequalizers
- James construction
- Flattening constructions
- Sequential colimits

**Coinductive:**
- Streams
- Infinite trees
- Conatural numbers
- M-types (dual of W-types)

**Modalities (if considering modal HoTT):**
- Shape modality ʃ
- Flat modality ♭
- Sharp modality ♯

