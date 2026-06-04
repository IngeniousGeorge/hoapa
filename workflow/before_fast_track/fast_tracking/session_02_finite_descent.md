# Session 02 — Finite-Product Descent Capsule

This file intentionally contains rushed-session state that would normally be
spread across the top-level workflow files. Do not mechanically copy it into
`workflow/status.md`, `workflow/future_work.md`, `workflow/targets.md`, or
`workflow/arc.md` until the finite descent work has stabilized. The point of
this capsule is reset-safety: the project can hard-reset the experimental code
and still retain the decision trail.

## Update 2026-06-04 - M5 Review Cleanup

This is the current authoritative summary for `session_02_*`. The older planning sections and pasted transcript below are intentionally retained, but the live code state is now:

- M1-M3 landed: generic finite-site event-product descent is inhabited.
- M5 landed: the generic finite-site witness is instantiated at `Sessions-Cat Payload`.
- The Sessions instantiation is the **constant-slot** form: the product arity tracks the frame event count, while every event carries the same fixed session slot `P₀`.
- The event-dependent target, where the session assigned to a slot depends on the event itself, remains future work.

Claude final cleanup fixed two review issues:

- `Sessions.agda` no longer says the Hom syntax has 13 constructors / 17 laws; it now records 17 Hom constructors and 21 postulated laws after adding the additive-product constructors and laws.
- `SessionEventProductSheaf.agda` no longer claims "B2(a) proper" without qualification; it explicitly calls the result the constant-slot form of the B2(a) target.

Verification after that cleanup:

```sh
agda -l cubical -i agda agda/Concurrency/Hybrid/SessionEventProductSheaf.agda
```

The command exits `0`, with only the inherited `UnsupportedIndexedMatch` warnings from `FiniteProducts.agda` on `bigπ` and `bigβ`.

Current promotion guidance:

- Promote the result as "finite-site event-product descent plus constant-slot Sessions instantiation."
- Do not promote old transcript phrases such as "B2(a) proper" without the constant-slot qualification.
- Do not claim all-frame `IsSheafPresheaf` is inhabited.
- Do not claim event-dependent session content has landed.
- Do not claim additive coproduct universal properties have landed.

## Update 2026-06-04 - M1-M3 Landed

This section supersedes the older planning sections below. The older text and pasted transcript are intentionally retained as rushed-session context.

Milestones 1 through 3 have landed in Agda and typecheck under `--cubical --guardedness`.

The finite-site descent inhabitant is:

```text
event-product-sheaf :
  IsSheaf ... (event-product-presheaf AB V FP P₀)
```

This is not the all-`LocalFrame` `IsSheafPresheaf` from `Concurrency/Hybrid/Descent.agda`. It is the finite-site analogue from `Concurrency/Hybrid/FiniteDescent.agda`.

Current result:

- Descent is inhabited for the finite-frame site.
- The witness is frame-varying: `value F` has one additive-product slot per event of `F`.
- Empty covers are handled by the empty product `⊤ₚ` supplied by `HasFiniteProducts`.
- Cover overlap enumeration is carried as data for the actual pullback `frame-pullback (embed i) (embed j)`.
- The concrete Sessions instantiation is still deferred.

Files landed in this session:

- `agda/Concurrency/Algebras/FiniteProducts.agda` — `HasFiniteProducts V`, terminal `⊤ₚ`, binary additive product `_&_`, finite-arity product API, and `bigProduct-ext`.
- `agda/Concurrency/Sites/FiniteFrame.agda` — finite-frame objects: `LocalFrame` plus chosen non-truncated event enumeration.
- `agda/Concurrency/Hybrid/EventProductPresheaf.agda` — finite-site presheaf record and the event-product presheaf, with functorial restriction.
- `agda/Concurrency/Sites/FiniteCover.agda` — finite covers with finite patches and carried finite enumerations for actual patch pullbacks.
- `agda/Concurrency/Hybrid/FiniteDescent.agda` — finite-site `MatchingFamily`, `HasAmalgamation`, `IsSeparated`, and `IsSheaf`.
- `agda/Concurrency/Hybrid/EventProductSheaf.agda` — proof that the event-product presheaf is separated and amalgamating; packages `event-product-sheaf`.

Verification commands run from repo root:

```sh
agda -l cubical -i agda agda/Concurrency/Sites/FiniteCover.agda
agda -l cubical -i agda agda/Concurrency/Hybrid/FiniteDescent.agda
agda -l cubical -i agda agda/Concurrency/Hybrid/EventProductSheaf.agda
```

`FiniteCover.agda` typechecks cleanly. `FiniteDescent.agda` and `EventProductSheaf.agda` typecheck and only inherit the two documented `UnsupportedIndexedMatch` warnings from `FiniteProducts.agda` on `bigπ` and `bigβ`. Those warnings remain accepted only under the constant-slot/propositional-API discipline.

What should eventually go into top-level workflow files:

- `status.md`: record that generic finite-site descent is now inhabited by `event-product-sheaf`; do not claim all-frame descent or Sessions instantiation.
- `future_work.md`: move finite event-product descent from pending to landed; make Sessions additives the next concrete value-layer milestone.
- `targets.md`: distinguish the shipped descent statement, the shipped generic finite-site sheaf witness, and the still-pending Sessions instantiation.
- `arc.md`: record that the stronger finite event-product path landed before Reflexive/Bulk/`MO_1` work, while remaining finite-site scoped.

Do not overclaim:

- Do not say the all-frame `IsSheafPresheaf` from `Descent.agda` is inhabited.
- Do not say the Sessions target has finite products yet.
- Do not say full additive coproduct laws are derived from the current finite-product record.
- Do not say the finite witness covers arbitrary `LocalFrame`s.
- Do not hide the `UnsupportedIndexedMatch` warnings; they are accepted under a precise downstream discipline.

## Update 2026-06-04 (later) — M5 (Sessions instantiation, constant-slot B2(a)) Landed

The deferred milestone 5 — the concrete Sessions instantiation flagged at
the very end of this file — has landed and typechecks under
`--cubical --guardedness`. Note (importantly): line 62's earlier "do not
say the Sessions target has finite products yet" is now superseded — it
does.

What shipped:

- `agda/Concurrency/Algebras/Sessions.agda` — enriched with additive
  syntax. Four new `SessionType` constructors (`_&ₛ_`, `_⊕ₛ_`, `⊤ₛ`,
  `𝟘ₛ`) with De Morgan duality clauses and `dual-involutive` cases; four
  new `Hom` constructors for the additive product (`terminal-h`,
  `proj₁-h`, `proj₂-h`, `pair-h`); four postulated universal-property
  laws (`terminal-unique-h`, `&ₛ-β₁`, `&ₛ-β₂`, `&ₛ-η`); and the bundle
  `Sessions-HasFiniteProducts : HasFiniteProducts Sessions-Cat`. New
  import: `Concurrency.Algebras.FiniteProducts` (no cycle).
- `agda/Concurrency/Hybrid/SessionEventProductSheaf.agda` (new) —
  instantiates the generic witness:
  `session-event-product-sheaf : IsSheaf AB (Sessions-Cat Payload) … (event-product-presheaf AB (Sessions-Cat Payload) (Sessions-HasFiniteProducts Payload) P₀)`,
  i.e. `event-product-sheaf` fed `V := Sessions-Cat Payload`,
  `FP := Sessions-HasFiniteProducts`, slot `P₀` left a parameter.

This is descent over actor-local frames with session-typed values whose
*arity* tracks the frame's event count — "separation of concerns = sheaf
gluing" landed at the Sessions value category. It is the **constant-slot**
form of B2(a): every event carries the same fixed slot `P₀`, so the
gluing is non-degenerate (frame-varying) but the content does not yet vary
event-by-event. The event-dependent B2(a) target (each event's session
read from that event) remains a later upgrade.

Design decisions taken (defaults, low-controversy):

- Additive *products* (`&ₛ` / `⊤ₛ`) get a full categorical universal
  property; additive *coproducts* (`⊕ₛ` / `𝟘ₛ`) are objects only, present
  solely to keep `_^⊥ₛ` total and involutive (matches `FiniteProducts.agda`
  D6). The session-syntax guardrail in `Sessions.agda`'s header was
  revised accordingly: additive products now in scope; cut, exponentials,
  recursion, and the coproduct universal property remain out.
- Product morphisms are `Hom` *constructors* (terms of the syntactic
  category), with laws postulated alongside the existing multiplicative
  laws — consistent with how `Sessions-Cat`'s multiplicative structure is
  already presented.
- A1 (`InhabitedCover`) was *not* needed: the descent here is full (empty
  frame ↦ `⊤ₛ`, terminal), exactly as M1–M4 predicted. The line in the
  closing transcript about "B(a) + A1 (if A1 is still the best option)"
  resolves to "A1 unnecessary."

Verification:

```sh
agda -l cubical -i agda agda/Concurrency/Algebras/Sessions.agda
agda -l cubical -i agda agda/Concurrency/Hybrid/SessionEventProductSheaf.agda
```

Both exit 0 with only the inherited four `UnsupportedIndexedMatch`
warnings on `bigπ`/`bigβ` from `FiniteProducts.agda` (constant-slot
regime — still inert here, since the Sessions value also uses the
constant slot `λ _ → P₀`).

Do not overclaim (still):

- The all-`LocalFrame` `IsSheafPresheaf` from `Descent.agda` remains
  un-inhabited; this witness is finite-frame-site scoped.
- The additive *coproduct* universal property is still not derived.
- The slot is constant: an event-dependent session slot (each event
  carries a different protocol) is a later upgrade, as is reflecting
  causal order / actor incidence in the value.

This is a clean point to consider promoting the finite-descent results
(M1–M5) from this capsule into the top-level workflow files
(`status.md`, `future_work.md`, `targets.md`, `arc.md`) per the lists
already drafted in this file — the finite descent work has now reached
its first typed-content landing.

## Summary

The previous session left `Concurrency/Hybrid/Descent.agda` with the probe-form
statement of descent, but no concrete inhabitant. The current session chose not
to settle for the constant-presheaf inhabited-cover witness as the main path.
Instead, it is pursuing the stronger B2(a) direction:

> build a genuinely frame-varying event-product presheaf over a finite-frame
> subsite, using finite additive products in the value category, then prove full
> descent for that finite site.

This is the more Grothendieckian path for the current B-side: values vary over
the actor-causal base, descent uses actual cover/overlap data, and the empty
network normalization is handled by a terminal object rather than by excluding
empty covers.

The key staging decision is that this is **finite**, not arbitrary indexed,
descent. Arbitrary products over `LocalFrame.Event` would demand an infinitary
additive product structure and would drift away from the finitely-presented
operadic/dessin/session character of the B-side. Finite frames are not a
compromise here; they are the intended fidelity constraint.

## Current Code State

### Landed in this rushed pass

- `agda/Concurrency/Algebras/FiniteProducts.agda`
  - Defines `HasFiniteProducts V`, a separate extension record over any
    `StarAutonomous V`.
  - Adds an additive terminal object `⊤ₚ`, terminal morphism, and uniqueness.
  - Adds binary additive product `_&_` with projections, pairing, β laws, and η.
  - Derives a finite-arity product API over `Cubical.Data.FinData.Fin`:
    `bigProduct`, `bigπ`, `bigTuple`, `bigβ`, `bigη`, and `bigProduct-ext`.
  - Leaves `StarAutonomous.agda`, `Valuation.agda`, `OperadAlgebra.agda`, and
    `Sessions.agda` untouched.

- `agda/Concurrency/Sites/FiniteFrame.agda`
  - Defines `FiniteFrame AB ℓE ℓR` as an underlying `LocalFrame AB ℓE ℓR`
    equipped with a chosen, non-truncated event enumeration:
    `event-count : ℕ` and `enum : Event frame ≃ Fin event-count`.
  - Does not define a separate finite-frame morphism record. Morphisms are still
    ordinary `FrameHom`s between underlying frames.

### Verification run

From repository root:

```sh
agda -l cubical -i agda agda/Concurrency/Algebras/FiniteProducts.agda
agda -l cubical -i agda agda/Concurrency/Sites/FiniteFrame.agda
```

`FiniteFrame.agda` typechecks cleanly. `FiniteProducts.agda` exits `0` with the
two documented `UnsupportedIndexedMatch` warnings on `bigπ` and `bigβ`.

These warnings do not mean the code is ill-typed. They mean Cubical Agda will
not compute those functions when their indexed `FinData.Fin` argument has been
transported across an equality of indices. The current plan accepts this only
under the following discipline:

- the event-product presheaf uses a constant slot `P₀`, so projection codomains
  do not depend on event-index transports;
- downstream proofs use the propositional universal-property API
  (`bigβ`, `bigη`, `bigProduct-ext`) rather than expecting transported
  projections to reduce by `refl`;
- if a later event-dependent slot is introduced, the warning must be revisited.

## Decisions Contained Here

### D1 — Product Scope

Use finite products only. The event-product witness lives over finite frames
with chosen event enumerations. Do not ask the value category for products
indexed by arbitrary event types.

### D2 — Interface Style

Use a separate extension record:

```agda
HasFiniteProducts : StarAutonomous ℓ ℓ' → Type _
```

Do not mutate `StarAutonomous` itself. This keeps the already-shipped operad and
session algebra layers stable and makes the new strength explicit.

### D3 — Generic First

Build the event-product presheaf generically over any `StarAutonomous` target
equipped with `HasFiniteProducts`. Concrete Sessions instantiation is deferred.

### D4 — Full Finite-Site Descent, Not A1 as the Main Target

Because `HasFiniteProducts` includes a genuine terminal object, the empty-frame
normalization can be represented by the empty product `⊤ₚ`. Therefore the target
is full descent for the finite-frame site, not merely inhabited-cover descent.

The earlier A1 idea (`InhabitedCover`) remains a valid fallback or staging lemma,
but it is no longer the principal target of this pass.

### D5 — Frame-Varying Value Shape

For a fixed slot object `P₀ : Ob`, define:

```text
value F = product over Event(F) of P₀
```

The arity changes with the frame, so this is genuinely frame-varying. In v1 the
slot is constant and the value sees only the finite event set. Causal order and
actor incidence are intentionally ignored by the value assignment for the first
witness; they remain locality structure used by frames, morphisms, covers, and
overlaps.

### D6 — Sessions Additives Deferred

At the abstract level, only `&` and `⊤ₚ` are primitive. The object expressions
for additive disjunction and its unit can be written by duality:

```text
A ⊕ B := (A^⊥ & B^⊥)^⊥
0     := (⊤ₚ)^⊥
```

However, only the object expressions are automatic. Coproduct universal
properties would require duality coherence/naturality that the thin
`StarAutonomous` signature does not currently include.

For the concrete `Sessions.agda` target, eventual additive syntax will require
all four constructors `&`, `⊕`, `⊤`, and `0`, because session duality is defined
by recursion on syntax. That is a later milestone.

### D7 — Finite Representation

Use chosen enumerations, not bare `isFinSet`. In Cubical,

```agda
isFinSet A = Σ[ n ∈ ℕ ] ∥ A ≃ Fin n ∥₁
```

The equivalence is truncated and cannot drive a fold. `FiniteFrame` therefore
carries explicit enumeration data.

## Important Caveats

### Full Descent Means Full Descent on the Finite Site

The current `IsSheafPresheaf` in `Concurrency/Hybrid/Descent.agda` is stated for
presheaves over all `LocalFrame`s. The event-product construction is expected to
live over a finite-frame subsite. Therefore milestone 3 should be careful about
its target:

- either define a finite-site-specific descent record, or
- generalize the presheaf/descent chassis over an explicit frame category, or
- provide a total presheaf on all frames only where the value is meaningful.

Do not claim that the finite event-product witness inhabits the current
all-`LocalFrame` sheaf record unless the code actually supplies that bridge.

### Covers and Overlaps Need Finite Data

A `FiniteCover` with finite patches is likely needed. Since matching-family
compatibility uses pullback overlaps, the finite descent layer must also decide
how overlap enumerations are supplied:

- prove pullbacks of finite frames carry chosen finite event enumeration, or
- include explicit finite-overlap data in the finite-cover/descent structure.

The second option is heavier in data but likely easier and more honest for the
rushed pass. The first option is cleaner but may require nontrivial finite-set
transport work.

### `⊕` / `0` Are Only Object-Level for Now

Workflow prose should not say the finite-product interface gives full additive
coproducts for free. It gives the dual object expressions. The universal
property is a separate future question.

### The Constant Slot Is Deliberate

The first event-product presheaf should use a constant event slot `P₀`. This
keeps the `UnsupportedIndexedMatch` warning harmless and avoids transport-heavy
dependent projection codomains. Event-dependent slots are a later upgrade.

## Intended Milestones

### Milestone 1 — Finite Products

Status: landed as `Concurrency/Algebras/FiniteProducts.agda`.

Deliverable:

- `HasFiniteProducts`.
- finite-arity product API.
- product extensionality for finite products.

Accepted warning:

- `UnsupportedIndexedMatch` on `bigπ` and `bigβ`, under the constant-slot and
  propositional-API discipline described above.

### Milestone 2 — Finite Frames / Finite Covers

Status: started as `Concurrency/Sites/FiniteFrame.agda`.

Needed next:

- decide whether to add `FiniteCover`;
- decide how finite overlap enumeration is represented;
- add concrete finite witnesses for the existing tiny frames if useful:
  `TinyFrame`, `PointFrame`, and the two-point cover.

### Milestone 3 — Event-Product Presheaf

Planned shape:

```text
value F    = bigProduct (event-count F) (λ _ → P₀)
restrict φ = tuple whose component at e in G projects from the component
             of F corresponding to event-map φ e
```

This is contravariant restriction by projection/reindexing. It is exactly the
structure that multiplicative tensor lacked and additive product supplies.

Functoriality should be proved through `bigProduct-ext`, not by definitional
normalization of folded products.

### Milestone 4 — Descent

Planned proof idea:

- separatedness: finite-product extensionality; equality of sections follows
  from equality of all event components;
- amalgamation: for each global event, use `event-covered` to choose a patch and
  a local preimage; define the global component from that local section;
- patch-independence: use overlap compatibility on frame pullbacks;
- empty frame / empty cover: handled by `⊤ₚ` as the empty product.

This is the first genuinely nonconstant, locality-sensitive descent witness.

### Milestone 5 — Sessions Instantiation

Deferred. Requires additive session syntax and laws:

- session constructors for `&`, `⊕`, `⊤`, `0`;
- duality clauses;
- Hom/product laws sufficient to instantiate `HasFiniteProducts` at
  `Sessions-Cat Payload`.

## Workflow Updates Eventually Needed

### `workflow/status.md`

Eventually record:

- `FiniteProducts.agda` adds optional finite additive products over
  `StarAutonomous` targets.
- The descent-inhabitation path has moved from constant presheaves over
  inhabited covers to finite event-product presheaves over a finite-frame site.
- The target is full finite-site descent because empty frames map to the
  terminal empty product.
- The current state remains experimental until event-product presheaf and
  descent proof land.

### `workflow/future_work.md`

Eventually adjust:

- Add "finite-frame event-product descent" as the active B-side milestone.
- Record that arbitrary indexed products are intentionally not planned at this
  layer.
- Record that Sessions additive syntax is a later instantiation milestone.
- Preserve the caveat that full all-frame descent is not yet supplied by the
  finite-site witness.

### `workflow/targets.md`

Eventually adjust:

- Under the operad/hybrid layer, add the finite-product value-category
  enrichment and finite-frame descent path.
- Update "full sheaf/descent over covers pending" to distinguish:
  - descent statement shipped;
  - finite-product machinery in progress;
  - finite event-product inhabitant pending.

### `workflow/arc.md`

Eventually adjust:

- `agda/Concurrency/` now contains the beginning of an additive finite-product
  enrichment for descent.
- The stronger B2(a) path is being pursued before Reflexive/Bulk/MO₁ layers.
- The finite character is a design commitment aligned with the B-side finite
  combinatorics, not a temporary limitation.

## Do Not Overclaim

- Do not say `IsSheafPresheaf` is inhabited yet.
- Do not say the Sessions target has finite products yet.
- Do not say full additive coproduct laws are derived from the current record.
- Do not say the finite witness covers arbitrary `LocalFrame`s.
- Do not hide the `UnsupportedIndexedMatch` warnings; they are accepted under a
  precise downstream discipline.


## Conversation on empty covers, and proving that some concrete presheaf actually glues — i.e. produce a value of HasAmalgamation / IsSheafPresheaf

 What is at stake

  Descent.agda shipped the statement of the sheaf condition but no inhabitant. The next step is to prove that some concrete presheaf actually glues — i.e. produce a value of HasAmalgamation /
  IsSheafPresheaf. This matters for three reasons:
  
  1. It is the load-bearing remaining half of R1/R2. Until something inhabits descent, "the Hybrid is a sheaf-theoretic separation of concerns" is a definition with no model. R4 (cartesian-vs-linear
  logic) and the cross-site adjunction all sit downstream of a stable, inhabited descent layer.
  2. It forces a permanent commitment about the topology. As shown below, no presheaf can satisfy the descent records over the empty cover. Whatever we decide here defines what "cover" means for the
  rest of the B-side. This is not a local proof detail — it propagates to every future sheaf, every separatedness witness, and the eventual MO_1 work.
  3. It sets the honesty bar. The project's discipline (no fake gluing postulates, IsSheafPresheaf is a property to inhabit) means the first inhabitant should be real, and its degeneracy — if any —
  must be stated, not hidden.

  The obstruction, concretely

  For the constant presheaf (value = const X, restrict = const id):

  - Amalgamation over an empty cover asks us to produce a global s : Hom X (value F) out of no local parts. For an arbitrary target object X there is no canonical morphism to hand back. Impossible.
  - Separatedness over an empty cover asks that any two parallel x, y : Hom X (value F) be equal because they agree on all (zero) patches. False in general.
  
  So the empty cover is the single thing standing between us and an inhabitant. Every option below is fundamentally a choice about how to deal with it.
  
  The decision has two orthogonal axes

  Axis A — where the empty cover is excluded. Axis B — which presheaf is the witness. They combine, but the genuinely consequential one is A.
  
  ---
  Axis A: how to exclude the empty cover
  
  A1 — Restrict at the descent-property level (InhabitedCover).
  Define InhabitedCover = Σ[ c ∈ Cover ] Cover.Index c (a cover packaged with one chosen patch index) in a new file, and state inhabited variants of the descent properties over it.
  - Gain: Zero change to the shipped Cover, ActorCausal, or the just-shipped Descent.agda. The general (unrestricted) IsSheafPresheaf stays on the books as the honest "full" statement; we inhabit a
  clearly-labelled weaker one. Names the empty-cover policy in one place.
  - Cost: We now carry two descent statements (full + inhabited). Slightly more surface. The "full" statement remains un-inhabited (honestly so).

  A2 — Exclude the empty cover at the site (non-emptiness field on Cover).
  Add a field like Index-inhabited : ∥ Index ∥ (or a chosen point) to the Cover record, so the topology never admits empty covers; then inhabit the unrestricted IsSheafPresheaf directly.
  - Gain: One descent statement, fully inhabited. Cleaner final story.
  - Cost: Heaviest, most committal. Mutates the shipped Cover record, so identity-cover-canonical, transitivity-cover-canonical, pullback-cover, two-point-cover, and stability-cover-pullback all must
  supply the new field — touching ActorCausal.agda and ActorPullback.agda, both recently shipped/under review. It also makes a real mathematical claim about the site (no empty covers ever), which we
  may not want to hard-commit before the sieve/E2 presentation lands. Note transitivity-cover composes covers, so the field has to be preserved under composition — extra proof obligation.

  A3 — Leave the topology alone; accept descent is only inhabited conditionally.
  Prove the per-instance amalgamation/separatedness lemmas guarded by an explicit "this cover is inhabited" hypothesis, without wrapping them in records.
  - Gain: Most minimal; no new types at all.
  - Cost: We never actually inhabit a descent record, so "descent is inhabited" stays informal. Weakest payoff against the stated goal.

  ---
  Axis B: which presheaf witnesses it
  
  B1 — Constant presheaf.
  - Gain: Cheap and immediate (the four proofs are one-liners via id-l and compatible). It is a real inhabitant of the (inhabited-cover) sheaf property — not a postulate.
  - Cost: it is degenerate, and the degeneracy is sharp.* Because value ignores the frame and restrict ignores the FrameHom, the overlap-compatibility clause collapses to part i ≡ part j regardless
  of what the pullback overlap actually is. So this witness exercises the plumbing of descent (matching families typecheck, amalgamation produces a section) but performs no locality-sensitive gluing.
  In ordinary sheaf theory the constant presheaf is the textbook example of something that is separated but only glues because the value category can't see disconnection. We would be inhabiting
  descent without yet stress-testing it.
  
  B2 — Non-constant, frame-varying presheaf.
  A presheaf whose value genuinely differs across frames, so amalgamation does real work.
  - Gain: A true non-degeneracy witness — descent gluing that actually depends on the cover. This is the version that gives evidence the descent statement is the right one.
  - Cost: Substantial machinery first. The Presheaf.agda header is explicit that honest frame-discrimination needs displayed-subsite / tiny-diagram infrastructure that doesn't exist yet (the current
  LocalFrame record can't discriminate frames in a value function without postulating frame equality). That is a multi-file build before the first inhabitant exists, and it interacts with the
  still-thin StarAutonomous target (no products/equalizers, so the value side is genuinely poor in structure to vary over).

  ---
  My recommendation (for you to accept or override)
  
  A1 + B1: a new file, InhabitedCover + inhabited-cover descent records + the constant presheaf as the first inhabitant, plus a one-line sanity check that the real two-point-cover is inhabited (so
  the witness visibly applies to the non-trivial tiny-site cover).

  Reasoning: it gets a genuine, non-postulated inhabitant now, commits nothing we'd have to walk back (the shipped site and Descent.agda are untouched, the full IsSheafPresheaf stays as the honest
  target), and it pins the empty-cover policy as a named, reviewable object rather than burying it. The degeneracy is real but stated in the header, and B2 (the non-degeneracy witness) becomes the
  clearly-scoped next step rather than a blocker today. This is exactly the "cheaper first inhabitant, clarify the empty-cover policy" path session_descent.md recommended.

  The main reason you might override me: if you want the first inhabitant to already prove something non-trivial (B2), or if you want to commit the site to inhabited-covers-globally now (A2) so
  there's only ever one descent statement. Both are defensible; they just cost more and commit earlier.

  How would you like me to proceed?

✻ Churned for 48s

※ recap: Goal: inhabit the Hybrid descent layer with a first concrete sheaf. I've laid out the options and recommend a new file proving the constant presheaf glues over inhabited covers. Next action:
  get your approval on that path, then write it. (disable recaps in /config)
  
❯ It seems to me that B2 is unavoidable. It requires work but lifts the entire project to a more accomplished state. The fact that StarAutonomous is a thin partner is all the reason more to make     
  this side strong, so that work on StarAutonomous will eventually bring both sides on acceptable levels.                                                                                              
  Would B2 be the most "Grothendickian" move in our context? And does B2 imply having to do A2 and not just A1?                                                                                        

● Both good questions, and the second one has a precise technical answer that I want to get exactly right, because it changes the plan.

  Q2: Does B2 force A2? — No. And the reason is illuminating.
  
  The empty-cover obstruction is not a property of the constant presheaf. It is generic, and tracing why tells us where the real gap is.

  A cover with empty Index is only a valid Cover of a frame that itself has no events and no actors — because actor-covered/event-covered would otherwise have to produce an element of an empty index.
  So "the empty cover" is really "the empty cover of the empty frame ∅." And the descent condition over it is exactly the classical normalization condition of a sheaf:
  
  ▎ a sheaf assigns the terminal object to the empty space: value(∅) ≅ terminal.
  
  Spelled out in our records: amalgamation over the empty cover needs value(∅) to be weakly terminal (a chosen Hom X (value ∅) for every probe X); separatedness needs it subterminal (any two such are
  equal). Together: value(∅) terminal.
  
  The thin StarAutonomous has no terminal object (it has 𝟙 the tensor unit and ⊥-par, neither terminal). So no presheaf — constant or frame-varying — can satisfy descent over the empty cover. B2 hits
  the exact same wall as B1.
  
  Consequences:

  - B2 does not need A2. A1 (InhabitedCover) is presheaf-agnostic; it works for the frame-varying witness identically.
  - A1 is actually more honest than A2 here. A2 would forbid empty covers at the site, which disguises a value-category limitation as a topology axiom. A1 instead localizes the gap to its true cause:
  "the empty-frame normalization rung is blocked because V lacks a terminal object." That is precisely the kind of gap that closes for free when StarAutonomous is enriched — which is exactly the bet
  you're making by strengthening this side. So the empty cover isn't something to legislate away; it's a clean marker pointing at the next V-enrichment.
  
  So the plan becomes: A1 + B2, with the empty-cover gap documented as "normalization needs a terminal object in V, deferred to the same enrichment that R4 / canonical-O_1 work will bring."
  Descent.agda stays untouched; the inhabited-cover records are presheaf-agnostic.
  
  Q1: Is B2 the most Grothendieckian move? — Yes, with one sharp caveat.
  
  Genuinely yes, and for concrete reasons, not vibes:

  1. It is the relative point of view. The constant presheaf is the absolute object that ignores the base; Grothendieck's entire method is to work over a base and let objects vary along it. A value
  that genuinely differs across frames is the relative viewpoint made concrete — the thing B1 fails to be.
  2. It activates descent's own machinery. Descent is one of Grothendieck's signature inventions, and its content is gluing genuinely-differing local data along overlaps. We built ActorPullback
  precisely so overlap-compatibility is computed by pullback. B1 makes that machinery inert (compatibility collapses to part i ≡ part j); B2 is what makes the pullback overlaps do real work. Building
  the pullbacks and then only ever feeding them a constant presheaf would be leaving the tool unused.
  3. The "rising sea." Strengthening the B-side now, ahead of V, so both sides rise together when V matures — that is the rising-sea instinct itself.

  The caveat — and it is the real next decision. B2 is Grothendieckian only if the varying value is natural, i.e. it factors through a genuine functor LocalFrame → V, not an ad-hoc cooked-up
  assignment. A forced non-constant presheaf (e.g. postulating frame equality to discriminate frames, as Presheaf.agda's header warns against) would be anti-Grothendieckian — "doing something
  specifically cubical" instead of factoring through the right object (the regulative principle from arc/02). So committing to B2 immediately forces a sub-question that "B2" alone doesn't answer:

  What is the natural frame-varying value?

  ┌───────────────────────────────────────────┬──────────────────────────────┬───────────────────────────────────────────────────────────┬───────────────────────────────────────────────────────┐
  │                 Candidate                 │       What value F is        │                           Gain                            │                         Cost                          │
  ├───────────────────────────────────────────┼──────────────────────────────┼───────────────────────────────────────────────────────────┼───────────────────────────────────────────────────────┤
  │ (a) Session content over frames (at the   │ a session type / protocol    │ Most faithful to the hybrid's whole point ("typed content │ Specializes away from "generic over StarAutonomous";  │
  │ SessionPresheaf/Sessions target, not      │ depending on F's events      │  varies over actor-local frames"); lands the witness      │ needs a real functor from frames to session syntax —  │
  │ generic V)                                │                              │ where it's mathematically meaningful                      │ the heaviest, but the most load-bearing               │
  ├───────────────────────────────────────────┼──────────────────────────────┼───────────────────────────────────────────────────────────┼───────────────────────────────────────────────────────┤
  │ (b) Sieve / subobject-valued, internal to │ the set of sub-views (or     │ Natural and representable-flavored; reuses sieve-of;      │ Needs V to absorb a Set as an object (a               │
  │  the site                                 │ covering sieves) of F,       │ closest to the "representable presheaf" Grothendieck      │ coproduct/free structure the thin V doesn't have) —   │
  │                                           │ packaged into V              │ would reach for                                           │ pushes on V enrichment immediately                    │
  ├───────────────────────────────────────────┼──────────────────────────────┼───────────────────────────────────────────────────────────┼───────────────────────────────────────────────────────┤
  │                                           │ a small hand-built diagram   │                                                           │ Bespoke to the tiny site; less obviously "factors     │
  │ (c) Displayed-subsite / tiny-diagram      │ over the tiny-site           │ Smallest concrete B2; gives a real locality-sensitive     │ through a natural object," so weakest on the          │
  │ witness                                   │ two-point-cover              │ gluing computation we can fully check                     │ Grothendieckian test unless framed as a worked        │
  │                                           │                              │                                                           │ example                                               │
  └───────────────────────────────────────────┴──────────────────────────────┴───────────────────────────────────────────────────────────┴───────────────────────────────────────────────────────┘

  My read: (a) is the genuinely Grothendieckian target — it makes "separation of concerns = sheaf gluing" do real work on actual typed content — but it is also the largest lift and it specializes the
  witness to the Sessions value category. (c) is the honest first concrete B2 (a checkable, locality-sensitive gluing over the existing non-trivial cover) and a natural stepping-stone toward (a).
  (b) is the most "representable" but immediately demands the V-enrichment we just said the empty cover also wants — which could be a feature (it concentrates all the pressure on V in one place).

  So before I write anything: which natural frame-varying value should B2 be built from — (a) sessions, (b) sieve/subobject, or (c) tiny-diagram worked example? That choice determines whether the
  witness lives at the generic level, the Sessions specialization, or the tiny site, and how hard it leans on enriching StarAutonomous.
  
✻ Cooked for 1m 51s

❯ Do you feel capable of doing B2 (a) + A1?                                                                                                                                                            
                                                                                                                                                                                                       
  Also, does the story of A1 more or less means that "an empty session network with no actors and no events" is degenerate? Because it should be. If descent requires some complexity to obrain, then  
  all the better on the philosophical level (but does it have a cost mathematically?)                                                                                                                  

● Let me answer the capability question with full candor, because the honest answer reshapes the plan.

  Can I do B2(a) + A1?
  
  A1: yes, straightforwardly. 

  B2(a) as stated: not in the current setting — and not mainly because of my limits, but because it is mathematically out of order. Two obstructions, both real, both pointing the same way:
  
  1. Frames carry nothing to build a session from. By design, ActorBase is unityped and opaque — no payloads, no roles, no message syntax. The only data on a LocalFrame is bare combinatorics: a set
  of Events, the causal order, actor incidence. A natural functor LocalFrame → Sessions can therefore only be built from that combinatorics, e.g. "one payload session per event."
  2. Contravariant restriction in a multiplicative value category is weakening — which linear logic forbids. A sub-view G ↪ F has fewer events; restrict must map value F → value G, i.e. drop the
  content of the events not in G. In a multiplicative (⊗) setting there is no projection A ⊗ B → A — that is exactly the no-weakening discipline. So the obvious "tensor a payload over the events"
  assignment isn't even a functor.
  
  The fix tells you what's missing: a restriction-as-projection wants an additive product (&), where A & B → A does exist. The natural frame-varying value is value F = &_{e ∈ Event F} Payload, with a
  sub-view's event-injection inducing the projection &_{Event F} → &_{Event G}. But the thin StarAutonomous deliberately omits additives (decision 2026-05-17: "no additives (&, ⊕)"). So B2(a) is
  blocked on enriching V with & — which is precisely the R4 / ladder-item-3 work that future_work.md sequences before this. Building B2(a) now would mean faking that structure or postulating frame
  equality — the anti-Grothendieckian move I flagged last turn. I won't do that.

  What I can do honestly today is B2(c): a displayed/tiny witness over finite, explicit frames (the two-point-cover site), where value genuinely varies (e.g. TinyFrame and PointFrame get different
  sessions) and the morphisms are hand-picked from existing session constructors, so functoriality and gluing are fully checkable with no enrichment. That is a real non-degenerate inhabitant and the
  honest stepping-stone to (a).

  The unifying finding (this is the good part)
  
  The empty-cover normalization and B2(a) want the same structure. The empty-cover condition is value(∅) = terminal, and a terminal object is the nullary additive product (the empty &). B2(a)'s
  frame-varying value wants the set-indexed &. So:
  
  ▎ Enriching StarAutonomous with additive products & closes the empty-cover normalization rung and unlocks the natural B2(a) presheaf, simultaneously.
  
  That is exactly the rising-sea sequencing your strategy is reaching for: one enrichment of V lifts both the descent normalization and the non-degenerate witness. A1 isn't a workaround that competes
  with that — it's the honest interim that names the gap (V lacks &) instead of hiding it.
  
  Your philosophical question — and yes, you're right

  "An empty session network with no actors and no events is degenerate, and descent requiring some complexity is a feature" is correct, and it has a precise mathematical face rather than just a 
  slogan:

  - The empty cover is a valid cover only of the empty frame (no events, no actors). So "descent over the empty cover" literally is "what does the empty network glue to."
  - Its descent condition is the normalization value(∅) = terminal: the empty network has a unique, contentless global section. Our inability to satisfy it right now is exactly "V has no terminal
  object to send the empty network to" — i.e. the degeneracy is recognized and parked as a missing limit, not broken.
  - This resonates with T3 / the complexity-threshold reframing: below a complexity threshold the structure collapses; here, the empty (zero-complexity) frame is the one place descent has nothing to
  assemble. "Descent requires complexity to have content" is the sheaf-theoretic shadow of the threshold claim.

  Mathematical cost of A1: mild and honest. We get the sheaf condition on inhabited covers only; the single thing deferred is the normalization rung (the empty-frame/terminal condition). All actual
  content lives in inhabited covers, so nothing content-bearing is lost — and the deferred rung is scheduled to close for free when & lands in V. There is no hidden cost and no postulate; the gap is
  a documented pointer at the next enrichment.

  So, the decision I need from you

  Given the above, B2(a) is genuinely gated behind enriching StarAutonomous with &. Two honest ways forward:

  1. A1 + B2(c) now (no enrichment): land a real, checkable, non-degenerate descent inhabitant over the tiny displayed site today; tee up "&-enrichment of StarAutonomous → B2(a) + empty-cover
  normalization" as the next, well-scoped milestone. Lower risk, immediate progress, honest about the ceiling.
  2. Enrich StarAutonomous with & first, then A1 + B2(a): the bigger lift, but it's the lift that brings this side to the "more accomplished state" you described and unlocks both B2(a) and
  normalization together. Bigger, sequenced correctly, and squarely the rising-sea move — but it's real work on the algebra layer before any descent inhabitant lands.
  
  I'm capable of either. I'd recommend (1) as the immediate step and (2) as the very next milestone — but if you'd rather invest in the &-enrichment now so the first descent inhabitant is already
  B2(a), I can start there. Which do you want?
  
✻ Brewed for 2m 6s

❯ Let's start with 2.

> And then the rest of the session produced what is documented in this file. Next we should go back to what was discussed in this conversation: B(a) + A1 (if A1 is still the best option, to be determined).

> Final statement before clearing context:

  What shipped

  ┌──────────────────────────────────────────────┬─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┬────────┐
  │                     File                     │                                                                  Role                                                                   │ Status │
  ├──────────────────────────────────────────────┼─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼────────┤
  │ Concurrency/Algebras/FiniteProducts.agda     │ M1. HasFiniteProducts V extension record (terminal ⊤ₚ + binary & with full universal property; ⊕/0 objects derived, not added) +        │ ✅     │
  │                                              │ derived Fin n product API (bigProduct, bigπ, bigTuple, bigβ, bigη, bigProduct-ext)                                                      │        │
  ├──────────────────────────────────────────────┼─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼────────┤
  │ Concurrency/Sites/FiniteFrame.agda           │ M2a. The finite-frame subsite object: LocalFrame + event-count + chosen Event ≃ FinData.Fin event-count (non-truncated enumeration, per │ ✅     │
  │                                              │  Codex)                                                                                                                                 │        │
  ├──────────────────────────────────────────────┼─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼────────┤
  │ Concurrency/Hybrid/EventProductPresheaf.agda │ M2b. FiniteFramePresheaf record + the event-product witness: value F = P₀ ^ (event-count F), restrict = reindexing tuple of             │ ✅     │
  │                                              │ projections; restrict-id/restrict-comp proved via the product universal property (secEq/retEq + bigβ/bigη/bigProduct-ext)               │        │
  └──────────────────────────────────────────────┴─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┴────────┘
  
  This is a genuinely frame-varying presheaf (arity tracks the event count) — the relative point of view, not the constant degenerate. The projection/weakening obstruction is dodged exactly as
  planned: events are valued in the additive &, so restrict is a tuple of projections. Constant slot keeps every projection codomain at P₀, so the enumeration-transport coherences stay plain congs —
  the regime where the indexed-match warning is harmless.

  Decision needed before milestone 3

  Milestone 3 is FiniteCover + the descent proof (aiming at full finite-site descent: empty frame ↦ ⊤ₚ handles the empty cover). The one open lock is the overlap-enumeration question Codex raised:
  descent compatibility lives on pullbacks of patches, and the pullback of two finite frames is a fibre product whose finite enumeration is not automatic. Two ways:

  1. Carry overlap enumeration as data in FiniteCover (each pair of patches comes with the enumerated overlap + its projections). No commitment to decidable event-equality; more data on the cover. My
  lean — it keeps the site general.
  2. Require decidable event-equality and compute the pullback enumeration (the fibre product of two Fin-enumerated sets cut out by a decidable equality in Event F is finite). Less cover data, but
  commits the finite site to decidable events.

  ● Done. The whole chain typechecks under --cubical --guardedness (exit 0; the only warnings are the four documented UnsupportedIndexedMatch lines on the product API, benign in the constant-slot
  regime). Descent is now genuinely inhabited — by a non-degenerate, frame-varying sheaf, at the stronger full-descent level (not the A1 fallback).
     
  What landed (option 2, milestones 1–3)

  ┌──────────────────────────────────────────────┬──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
  │                     File                     │                                                                       Role                                                                       │
  ├──────────────────────────────────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Concurrency/Algebras/FiniteProducts.agda     │ HasFiniteProducts V (terminal ⊤ₚ + binary &, universal property) + derived Fin n product API (bigProduct/bigπ/bigTuple/bigβ/bigη/bigProduct-ext) │
  ├──────────────────────────────────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Concurrency/Sites/FiniteFrame.agda           │ Finite-frame subsite object: LocalFrame + chosen Event ≃ FinData.Fin event-count                                                                 │
  ├──────────────────────────────────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Concurrency/Hybrid/EventProductPresheaf.agda │ FiniteFramePresheaf record + the frame-varying event-product presheaf (value F = P₀^(event-count F); restrict = reindexing tuple of              │
  │                                              │ projections), with functoriality proved                                                                                                          │
  ├──────────────────────────────────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Concurrency/Sites/FiniteCover.agda           │ FiniteCover carrying chosen overlap enumerations (Codex option 1); derived overlap-frame i j on the actual frame-pullback                        │
  ├──────────────────────────────────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Concurrency/Hybrid/FiniteDescent.agda        │ Finite-site descent records: MatchingFamily, HasAmalgamation, IsSeparated, IsSheaf                                                               │
  ├──────────────────────────────────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Concurrency/Hybrid/EventProductSheaf.agda    │ event-product-sheaf : IsSheaf … — the event-product presheaf proved separated and amalgamating                                                   │
  └──────────────────────────────────────────────┴──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

  Why this is the result we were after

  - Real gluing. Amalgamation reconstructs the global section component-per-event: event-covered names a witnessing patch per event, compatible (projected through the carried overlap enumeration, via
  pb-π₁/pb-π₂) makes the choice well-defined. The pullback overlaps from ActorPullback finally do work.
  - Full descent, not A1. value(∅) = ⊤ₚ (terminal) discharges the empty cover uniformly — the empty-network degeneracy is handled by the value category's terminal object, exactly as we predicted: the
  gap was a missing limit in V, now supplied.
  - The unifying bet paid off. One enrichment (& + ⊤ₚ) gave both the non-degenerate witness and the empty-cover normalization, as forecast.

  The known UnsupportedIndexedMatch warnings stayed inert throughout, exactly because of the constant-slot design — confirming that decision.

  What remains (next milestone, deferred)

  B2(a) proper — the concrete Sessions instantiation. Everything above is generic over (V, HasFiniteProducts V, P₀). Landing it at the Sessions target requires adding additive constructors &, ⊕, ⊤, 0
  to SessionType with duality + product/coproduct laws (the Sessions.agda work we flagged), then instantiating event-product-sheaf with V := Sessions-Cat Payload. That's the genuine "session content
  varies over actor frames" payoff, gated only on the session-syntax additives.

  ● Done. The next step from session_02_finite_descent.md was Milestone 5 — "B2(a) proper": the concrete Sessions instantiation of the generic event-product-sheaf. It typechecks.

  What I did

  1. Enriched agda/Concurrency/Algebras/Sessions.agda with additive syntax (the gate the capsule flagged):
  - 4 new SessionType constructors: _&ₛ_, _⊕ₛ_, ⊤ₛ, 𝟘ₛ, with De Morgan duality clauses ((S &ₛ T)^⊥ₛ = S^⊥ₛ ⊕ₛ T^⊥ₛ, ⊤ₛ^⊥ₛ = 𝟘ₛ, …) and matching dual-involutive cases.
  - 4 new Hom constructors for the additive product (terminal-h, proj₁-h, proj₂-h, pair-h) plus 4 postulated universal-property laws.
  - The bundle Sessions-HasFiniteProducts : HasFiniteProducts Sessions-Cat.
  - New import Concurrency.Algebras.FiniteProducts (no cycle), and a revised header guardrail.

  2. New agda/Concurrency/Hybrid/SessionEventProductSheaf.agda — feeds the generic witness V := Sessions-Cat Payload, FP := Sessions-HasFiniteProducts, slot P₀ left a parameter, yielding
  session-event-product-sheaf : IsSheaf …. This is descent over actor-local frames whose values are session types varying over the frame's event set.

  Decisions I made (flagging per the propose-first convention)

  - The one consequence worth flagging: this revises Sessions.agda's shipped "additives out of scope" guardrail. Additive products are now in scope; cut/exponentials/recursion and the coproduct
  universal property remain out. ⊕ₛ/𝟘ₛ are objects-only (just to keep duality total/involutive), matching FiniteProducts.agda D6.
  - Product maps are Hom constructors (genuine terms of the syntactic category), consistent with how the multiplicative structure is already presented.
  - A1 was not needed — descent here is full (empty frame ↦ ⊤ₛ, terminal), as M1–M4 predicted. The transcript's "B(a) + A1 (if A1 is still the best option)" resolves to A1 unnecessary.

  Verification

  agda -l cubical -i agda agda/Concurrency/Algebras/Sessions.agda          # exit 0
  agda -l cubical -i agda agda/Concurrency/Hybrid/SessionEventProductSheaf.agda  # exit 0
  No errors; only the inherited four UnsupportedIndexedMatch warnings on bigπ/bigβ from FiniteProducts.agda (constant-slot regime — still inert, since the Sessions value also uses the constant slot λ
  _ → P₀).
  
  I recorded all of this in the live capsule (session_02_finite_descent.md) rather than the top-level workflow files, since the capsule explicitly defers those updates until stabilized. Open 
  follow-up for you: M1–M5 now look stable enough to promote into status.md/future_work.md/targets.md/arc.md per the lists already drafted in the capsule — say the word and I'll do that pass.