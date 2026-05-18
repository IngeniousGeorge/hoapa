# Archived from status.md — Discussion of the next step (2026-05-18)

Archived 2026-05-18 after `O_1` operadic-syntax files shipped (Ports / RawCyclicOperad / PortGluing / CyclicAssociative). Captures: the 2026-05-18 session-start "design calls closed" snapshot, the 2026-05-17 session-end carried over, the now-superseded "Next session — two pieces of work" planning (which described the work that this session completed), the "Open design surface" questions (all closed during 2026-05-18 session), and the conventions / library-specifics / next-after notes that have been folded into the current status.md or into source-file headers.

Source-of-truth supersession:
- Decisions captured in status.md `## Decisions Log` (rows dated 2026-05-18).
- File state captured in status.md `### State at session end (2026-05-18)`.
- Conventions live in the source files themselves (RawCyclicOperad.agda header, CyclicAssociative.agda header, Ports.agda header).
- Open question on `rot-compₒ` (boundary-swap presentation vs full cyclic equivariance) folded into the new "Discussion of the next step" as the question to resolve before algebras work.

---

### State at session start (2026-05-18) — design calls closed

The open design surface from the 2026-05-17 session-end is now fully resolved (cross-checked with Codex on each call). Resolutions:

1. **Arity convention (was open as "boundary cases" Q5):** switched to positive-only `compₒ : Port (suc l) → Port (suc r) → O (suc l) → O (suc r) → O (suc (l + r))`. The hidden boundary issue — `Port (0 + 0 ∸ 1) = Fin 1` vs `Fin 0 ⊎ Fin 0 = ∅` makes the port-gluing iso non-total at `m = n = 0` — only surfaced when sketching the iso. Switching now avoids threading positivity preconditions through every law.

2. **Port-gluing iso target (Q1):** `Port (suc (l + r)) ≃ Fin (suc l) ⊎ Fin (suc r)`, with delete-and-renumber explicitly defined first. Convention: **cyclic-equivariant β** (`delete-port i k = i +ₘ fsuc k`), not linear punch-in α. Costs ~100 lines of punch lemmas written from scratch, but pays off in `rot-compₒ` cleanliness.

3. **Law shape — sum vs. two-laws (Q2):** **two separate laws**, `compₒ-assoc-seq` and `compₒ-assoc-par`. The `port-split` classification of the outer gluing port determines which applies.

4. **HIT-by-copy vs. theorems-after-the-fact (Q3):** **HIT-by-copy**. `CyclicAssociative.O` redeclares the constructors and adds three path constructors for the laws. `RawCyclicOperad.O` becomes a "without-laws" reference; downstream files import `CyclicAssociative.O`.

5. **`rot-compₒ` formulation (Q4):** **Markl–Shnider–Stasheff cyclic axiom**, unit-rotation form (`rot (fsuc fzero)` only — general `rot k` derives by `rot-compose` induction). Operand-swap shape: `rot (fsuc fzero) (compₒ i j a b) ≡ compₒ ? ? (rot ? b) (rot ? a)` with arity-PathP over `+-comm l r`. The "1=2 perspective swap" (R8) is literal here.

   *Note added at archival:* this resolution was revised during implementation. The shipped law is the **boundary-rotation operand-swap form** (`rot (boundary-rot l r) (compₒ i j a b) ≡ compₒ j i b a`), not the MSS unit-rotation form. The "derives by rot-compose induction" claim was overclaimed — `rot-compose` composes rotations of the same operation; it doesn't decompose composite-rotations into operand-rotations. See the new "Discussion of the next step" for the open question this raises.

6. **Glue API shape:** equivalence + derived functions, no record wrapper.

7. **File plan:** `Ports.agda` stays minimal. New sibling `Concurrency/Operads/PortGluing.agda` owns the full port bookkeeping (gluing iso + reindexing families used by the laws). `CyclicAssociative.agda` then writes the three laws on top.

### Implementation order (2026-05-18 session)

1. Edit `RawCyclicOperad.agda`: switch `compₒ` to positive-only signature. ✓
2. Create `PortGluing.agda`: β-convention delete-and-renumber, `port-gluing-equiv`, reindexing families. ✓
3. Create `CyclicAssociative.agda`: HIT-by-copy + three path-constructor laws. ✓
4. Type-check. ✓

### State at session end (2026-05-17)

The three pending calls from the prior session ratified and partially executed:

1. **`Ass_cyc` ratified** (Decisions Log row added; cyclic-bar and ribbon-decorated `MO_1` cascades accepted).
2. **R7 target = parameterized `*`-autonomous record** (polycategorical co-equal flagged; lands in `Concurrency/Algebras/StarAutonomous.agda`, not yet written).
3. **`O_1` Agda scaffold started.** Three-file staging adopted (Codex framing) rather than a single file. Files 1 and 2 shipped; file 3 deferred to next session.

What landed in `agda/Concurrency/Operads/`:

- **`Ports.agda`** — Port type and cyclic-group arithmetic. `Port n := Fin (suc n)`. Re-exports `_+ₘ_`, `-ₘ_`, `+ₘ-assoc`, `+ₘ-comm`, `+ₘ-lUnit`, `+ₘ-rUnit`, `+ₘ-lCancel`, `+ₘ-rCancel` from `Cubical.Data.Fin.Arithmetic`. Aliases `port-inv = -ₘ_` and `port-inv-left`/`port-inv-right` from the library's cancellation laws. Intentionally minimal: heavier port arithmetic (gluing, splitting) is deferred to next session when `CyclicAssociative.agda` needs it.
- **`RawCyclicOperad.agda`** — HIT presenting the raw cyclic operad on one binary generator. Constructors: `gen : O 2`, `compₒ : Port m → Port n → O m → O n → O (m + n ∸ 1)` (subscript `o` to avoid clashing with cubical's `comp` Kan-composition primitive; the operation here is operadic substitution, unrelated), `rot : Port n → O n → O n`, `rot-zero`, `rot-compose`, `trunc` (per-arity set truncation). Outside the data declaration: derived `rotate-equiv : Port n → O n ≃ O n` via `isoToEquiv` with `rot (port-inv i)` as inverse, discharged by `rot-compose` + `port-inv-left`/`port-inv-right` + `rot-zero`. Small private sanity-check section (generator at arity 2, three rotations of it, one self-substitution).

Both files type-check clean under `--cubical --guardedness`. Total ~70 lines (`Ports`) + ~150 lines (`RawCyclicOperad`).

### Three-file staging — current state (as of 2026-05-18 session start)

Updated 2026-05-18: scope split into four files (port bookkeeping moved out of `Ports.agda` into a new sibling).

| File | Status |
|------|--------|
| `Concurrency/Operads/Ports.agda` | Minimal version shipped. No further work — port-gluing/splitting machinery moved to sibling `PortGluing.agda` (decision 2026-05-18). |
| `Concurrency/Operads/RawCyclicOperad.agda` | Shipped, **edited 2026-05-18** to positive-only `compₒ` signature. |
| `Concurrency/Operads/PortGluing.agda` | **In progress 2026-05-18.** Owns β-convention delete-and-renumber, port-gluing iso, reindexing families used by the laws. |
| `Concurrency/Operads/CyclicAssociative.agda` | **In progress 2026-05-18.** HIT-by-copy of `RawCyclicOperad`'s constructors plus three path constructors: `compₒ-assoc-seq`, `compₒ-assoc-par`, `rot-compₒ`. |

### Next session — two pieces of work *(superseded — these are exactly what shipped on 2026-05-18)*

#### Piece 1: Extend `Ports.agda` with port arithmetic for substitution

When `compₒ i j a b : O (m + n ∸ 1)` composes an `m`-ary and an `n`-ary operation by gluing port `i` of the first to port `j` of the second, the resulting operation has `m + n` cyclic ports — the union of `a`'s ports minus port `i` and `b`'s ports minus port `j`. The combinatorial substrate that `CyclicAssociative.agda` needs is the *bijection between `Port (m + n ∸ 1)` and this disjoint union of "surviving ports"*. Concretely, the API will probably want:

- `glue : (i : Port m) (j : Port n) → ...` — the assembly direction: given a port of `a` not equal to `i`, or a port of `b` not equal to `j`, produce the corresponding port of the composite.
- `split : (i : Port m) (j : Port n) → Port (m + n ∸ 1) → ...` — the inverse direction: given a port of the composite, classify it as coming from `a` or `b` and recover its index there.
- Plus laws witnessing `glue ∘ split ≡ id` and `split ∘ glue ≡ id` (an iso of `Fin` types).

The exact shape of `...` is one of the open design questions below. The library's `Cubical.Data.Fin` and `Cubical.Data.Sum` (for the disjoint union) should provide what's needed; no new dependency.

Heuristic name: this extension will probably be called the *port-gluing iso* in the file's header.

#### Piece 2: Write `CyclicAssociative.agda` — associativity and equivariance

Three path constructors (or theorems, depending on encoding choice — see open questions) on top of the imported `RawCyclicOperad`:

**(a) `compₒ-assoc-seq` — sequential associativity.** When the third operation is substituted into the result of an inner substitution *at a port that came from the inner argument*:

```
compₒ k₁ k₂ (compₒ i j a b) c ≡ compₒ i j' a (compₒ j'' k₂ b c)
```

where `k₁` is a port of the composite that corresponds (via `split`) to a port of `b`. The reindexings `j'`, `j''` are determined by the port-arithmetic API.

**(b) `compₒ-assoc-par` — parallel associativity.** When the third operation is substituted *at a port that came from the outer argument*:

```
compₒ k₁ k₂ (compₒ i j a b) c ≡ compₒ i' j (compₒ i'' k₂ a c) b
```

with reindexings `i'`, `i''`.

**(c) `rotate-comp` — equivariance of the cyclic action with substitution.** Rotating the result of a composition matches composing the rotated arguments, with appropriate port reindexing:

```
rot k (compₒ i j a b) ≡ compₒ (reindex-i k i) (reindex-j k j) a b   -- or a variant
```

The precise statement depends on how the port-arithmetic API factors the rotation through `glue`/`split`. **This is genuinely subtle** — the rotation on `Port (m + n ∸ 1)` does not in general decompose as "rotate `a`'s ports and `b`'s ports separately"; it can move a port that came from `a` to a position that came from `b`. The equivariance law has to account for this.

### Open design surface (propose-before-implement, with Codex) *(all closed during 2026-05-18)*

These should get a round of alignment before next session writes any port-arithmetic code:

1. **Sum-of-Fins or single Fin for the port-gluing iso?** `Port (m + n ∸ 1) ≃ (Port m ─ {i}) ⊎ (Port n ─ {j})`. The right-hand side is "Fin minus a point," which can be encoded several ways: as `Σ (k : Port m) (¬ k ≡ i)`, as `Fin m` via a bijection, or as a sub-Σ-type. Each choice shapes how `split`/`glue` read.

2. **Is `compₒ-assoc-seq`/`compₒ-assoc-par` one law with `Sum`-cases or two separate laws?** Mathematically, operadic associativity is a single statement over the disjoint union of "k comes from `a`" and "k comes from `b`." A `Sum`-shaped law type is honest; two separate laws is more readable. Lean: two laws, with the `split`-classification of `k` determining which one applies. But the alternative deserves consideration before writing.

3. **HIT path constructors vs. theorems-after-the-fact.** The associativity and equivariance laws can be (a) added as path constructors of an extension of the HIT, or (b) proved as theorems about `RawCyclicOperad`'s constructors. (a) is more honest about what the *cyclic associative* operad *is* — the relations are part of the type. (b) is cleaner separation but means `O n` from `RawCyclicOperad` doesn't satisfy associativity strictly; we'd quotient. **Lean: (a).** Define a new HIT (or extend the data declaration via an Agda-mechanism for separate-file HITs, which is awkward) — most likely the cleanest is to copy `RawCyclicOperad`'s HIT into `CyclicAssociative` with the extra constructors, leaving `RawCyclicOperad` as the "without-laws" reference. **Worth confirming the actual file shape before writing.**

4. **`rotate-comp` equivariance statement.** Depends on (1) and how the port-arithmetic API exposes the gluing iso. May want to state it for the constructor `rot` only, with the derived `rotate-equiv` inheriting equivariance automatically.

5. **Boundary cases.** When `i = fzero` (rotating around the output port of `a`) or `j = fzero`, the port arithmetic has degenerate cases that may or may not need separate treatment. Should fall out of a clean `glue`/`split` definition, but worth a check.

### Mathematical references for the port arithmetic

- Getzler–Kapranov, *Modular operads*, Compositio Math. 110 (1998), 65–126 — the canonical reference for cyclic and modular operadic substitution. Associativity laws stated explicitly there.
- Markl–Shnider–Stasheff, *Operads in Algebra, Topology and Physics*, AMS 2002 — textbook treatment; the cyclic-operad associativity laws have explicit signatures.
- Note: classical references describe `Com_cyc` (symmetric). For `Ass_cyc` (planar), Kontsevich-Penner ribbon-graph literature has the right port-ordering conventions. Cyclic associativity is structurally the same as the classical statement; only the symmetry assumption changes.

### Conventions established in the 2026-05-17 session (carried forward into source-file headers)

- **Naming.** Cyclic action is `rot` (HIT constructor) / `rotate-equiv` (derived equivalence). Never `involution`. Session duality is a separate construct on the algebra side (R8).
- **`compₒ`** with subscript `o` (`U+2092 LATIN SUBSCRIPT SMALL LETTER O`) for operadic substitution. The plain name `comp` is reserved by cubical's Kan-composition primitive and unusable as a constructor.
- **Set-truncation** as a per-arity `trunc` path constructor on each HIT. The cubical idiom.
- **Equivalences derived outside the HIT.** `rot` is a function-shaped constructor; `rotate-equiv` is built afterwards via `isoToEquiv` with the cyclic inverse as the inverse. The HIT can't directly carry `_≃_` because `isEquiv` is fibrationally circular over the not-yet-defined type.
- **Library re-exports in `Ports.agda`.** Anyone downstream can `open import Concurrency.Operads.Ports` to get `Port`, `_+ₘ_`, `-ₘ_`, the cancellation laws, and `port-inv`. Keeps imports thin in `RawCyclicOperad` and (incoming) `CyclicAssociative`.

### Cubical library specifics to reuse next session *(now: actually used 2026-05-18)*

- `Cubical.Data.Fin` — `Fin`, `fzero`, `fsuc`. Note `Fin n = Σ[ m ∈ ℕ ] (m <ᵗ n)`; `<ᵗ` is propositional (defined via `Bool→Type`), so `0` literal and `fzero` are definitionally equal in `Fin (suc n)`. The cancellation laws stated with `≡ 0` work unchanged where the destination type expects `fzero`.
- `Cubical.Data.Fin.Arithmetic` — `_+ₘ_`, `-ₘ_`, `_-ₘ_` (= `x +ₘ (-ₘ y)`), `+ₘ-assoc`, `+ₘ-comm`, `+ₘ-lUnit`, `+ₘ-rUnit`, `+ₘ-lCancel`, `+ₘ-rCancel`. Definitions use `mod` from `Cubical.Data.Nat.Mod`. Already re-exported from `Ports.agda`.
- `Cubical.Data.Sum` — `_⊎_`, `inl`, `inr`; for the port-gluing iso if (1) above lands on a Sum-shape. *Used in CyclicAssociative.agda law signatures.*
- `Cubical.Foundations.Isomorphism` — `Iso`, `iso` constructor, `isoToEquiv`. The `iso` *constructor* (not the record copatterns) is what worked for `rotate-equiv` — record copatterns failed at the position in this file.
- `Cubical.Data.Fin.Properties` — likely has the `Fin (m + n)` ↔ `Fin m ⊎ Fin n` machinery; worth grepping before writing `glue`/`split` from scratch. *Confirmed: `Fin+≅Fin⊎Fin (m n : ℕ) → Iso (Fin (m + n)) (Fin m ⊎ Fin n)` at line 585; used in PortGluing.agda after an arity cast through `+-suc`.*

### After `CyclicAssociative.agda` lands

Sequence on the B side:

1. **`Concurrency/Algebras/StarAutonomous.agda`** — the parameter record for R7's target category. Header comment names polycategorical as the alternative co-equal. Encode the `*`-autonomous structure as a record (this is a parameter signature, not a gap-filling postulate, so the record form is correct — not in tension with `feedback_postulates_over_records`).
2. **`Concurrency/Algebras/OperadAlgebra.agda`** — algebras over the cyclic associative operad, parameterized over a `StarAutonomous` target.
3. **`Concurrency/Algebras/Sessions.agda`** — instantiate the target as Caires-Pfenning's session-type syntactic category; R8 (Involution-Duality) lands here — the session-type duality `S ↔ S^⊥` interacts with `rotate-equiv` from the operad layer.
4. **Hybrid integration** — the actor-causal site (R6) and the sheaf valuation (R1) follow once `_Algebras._Sessions` has the right shape. Not blocked yet; not started.

The A-side return plan (lift `Bℤ → S¹`, switch η-iteration → cyclic bar) is on hold until the B-side reaches a point where the cross-site adjunction `Allow ⊣ Require` is statable. That is downstream of `OperadAlgebra.agda` at the earliest.

### Held-loose long-horizon items (no near-term action)

- **Hybrid substrate in Agda** — Lamport partial-order `_Site._Category`, sheaf condition. Will pick up after the operadic algebra layer; known shape, well-mapped.
- **Pask-style human-implementation layer** — conversation-as-operadic-composition. Speculative until `MO_1` makes "conversation creates conversation" a literal operadic operation. Held in motivation only.
