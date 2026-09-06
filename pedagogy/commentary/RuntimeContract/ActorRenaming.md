# ActorRenaming.agda — what the validator cannot see

## Where This File Sits

This is the first commentary written for `formal/RuntimeContract/`, and it starts in the middle. The natural first companion would be `Trace.agda`, which defines the vocabulary everything here uses. That file has no commentary yet, so this one carries a compressed on-ramp instead. When `Trace.md` gets written it belongs before this file, and some of the next two sections should move there.

The project has a long-running promise that sounds more like ethics than mathematics: *the system protects the people using it by refusing to formalize who they are.* Actors — the participants — are deliberately opaque. There is no `Human` type, no expert flag, no ranking, no origin metadata. The trusted record says what was done, never who someone is.

The trouble with a promise like that is it is stated by *omission*. "We didn't put identity in" is a design intention, and design intentions rot. Someone adds a field. Someone writes a check that peeks. Nothing goes red, because nothing was ever watching.

This file turns one piece of that promise into something a machine watches. The piece is small and precise: **the validator cannot tell actors apart by their names.** Rename every actor consistently — swap two, shift them all up by one, use any relabeling that keeps distinct actors distinct — and the validator returns exactly the same verdict it returned before.

That is worth being clear-eyed about. It is not the whole promise; it is the first rung of a ladder the project calls the *no-leak ladder*, and the rungs above it are not built. What this rung buys is not surprise — it is a tripwire. If somebody later adds a clause to the validator that reads actor identity, this file stops compiling.

> **References**
> - `workflow/targets.md`, target **T_boundary** — the full ladder, its four tiers, and what each is and is not allowed to claim.
> - `workflow/future_work.md`, "The theorem ladder" — the tier-by-tier plan and its open decision gates.

## The Vocabulary This File Borrows

Three things from `Trace.agda`, enough to read what follows.

**A raw run.** The serializable record the runtime hands to the checker. It is deliberately dull — first-order data only, no functions, no live handles. A run carries some bookkeeping (a format code, a run ID, a protocol ID) and a *trace*, which is three lists:

- `traceActors` — the actors this run declares, as numbers;
- `traceConvs` — conversations, each with its own ID, its own list of participating actors, and a session tag;
- `traceEvents` — events, each with an ID, the conversation it happened in, the actors it *touches*, and its *causal parents* (the events that had to happen before it).

Everything is a natural number. Actors are `0, 1, 2`. Conversations are `0, 1`. Events are `0, 1, 2, 3`. The names people actually use — `"a0"`, `"alice"` — live in the JSON on the wire and never reach here. The header of `Trace.agda` says why: *"IDs are dense `ℕ` coordinates, not the opaque carriers... `valid?` sees only structure over `ℕ`, never the labels — which is what makes renaming invariance hold."* This file is that sentence, made into a theorem.

**The validator, `valid?`.** A function from a raw run to a `Bool`. It is a plain computable check with eight conditions joined by `and`:

1. the format code is right;
2. sibling protocol IDs are distinct;
3. declared actors are distinct;
4. conversation IDs are distinct;
5. event IDs are distinct;
6. every conversation is OK — its actor list is duplicate-free and is a subset of the declared actors;
7. every event is OK — its conversation exists, its touched actors and its parents are duplicate-free, and the actors it touches all belong to its conversation;
8. parents point backward — every causal parent appeared earlier in the event list.

Only three of those eight look at actors at all (3, 6, 7). That is the whole reason this theorem is provable.

**Boolean equality, `eqℕ`.** Agda's numbers do not come with a built-in "are these equal" button that returns a `Bool`, so `Trace.agda` writes one by hand. It walks two numbers down to zero together and answers `true` or `false`. This matters more than it sounds: **`eqℕ` is the only way `valid?` ever touches an actor identifier.** The validator never adds actors, never orders them, never asks which is bigger. It only ever asks *are these two the same one?*

Hold onto that. It is the hinge of the entire file.

## The Question, Sharpened

Suppose we have a function `ρ` from actor numbers to actor numbers, and we apply it everywhere an actor appears. Call that renaming the run. Does the verdict change?

The honest answer is: *it depends on `ρ`*, and finding the exact condition is the mathematical content here. Consider a broken run — one the validator should reject:

```text
traceActors = [0]                    -- the run declares one actor
a conversation with actors = [5]     -- but a conversation mentions actor 5
```

Actor 5 was never declared, so condition 6 fails and the verdict is `false`. Good. Now rename with a `ρ` that sends both `0` and `5` to `0`:

```text
traceActors = [0]
a conversation with actors = [0]     -- now 5 has become 0
```

Every actor mentioned is now declared. Condition 6 passes. A run the system was right to reject has been *laundered into acceptance* by relabeling.

So a renaming that merges two actors into one destroys the theorem. What we need is that `ρ` never merges — that distinct actors stay distinct. A function with that property is called **injective**, and in this file an injective actor map is called an **embedding**.

This is worth pausing on, because it is the shape of a lot of mathematics: we did not choose injectivity because it sounded strong, and we did not choose it to be general. We *found* it, by asking what the smallest hypothesis is that the counterexample rules out. The definition carries the work; the theorem afterwards is mostly bookkeeping.

Notice also what we did *not* need. We never asked `ρ` to be reversible. Shifting every actor up by one — `0 ↦ 1`, `1 ↦ 2`, and so on — is injective but hits no actor `0`, so nothing maps onto it. It is a perfectly good embedding, and the theorem covers it.

## Chunk 1 — the three strata

```agda
-- WHAT THIS MODULE PROVES, IN THREE STRATA. The strata differ in what
-- they assume about the relabeling, and the split is the content, not
-- bookkeeping:
--
--   1. Raw-data functoriality — arbitrary actor maps. `renameActors`
--      preserves identity and composition. No hypothesis, because the
--      raw records are functorial in the actor coordinate for *any*
--      function.
--   2. Validator naturality — actor EMBEDDINGS (injective maps). The
--      exact Boolean equality `valid? (rename φ r) ≡ valid? r`, for
--      EVERY raw run including malformed ones. Injectivity is forced:
--      a collapsing map can rescue an invalid run by merging an
--      undeclared identifier onto a declared one.
--   3. Gauge symmetry — actor PERMUTATIONS, the invertible relabelings.
--      Their invariance component is stratum 2 specialized; their own
--      content is the invertible action.
```

We may as well say the punchline up front, because the file's organizing idea is that there are three different statements here, not one, and they need three different hypotheses.

Renaming is a thing you can *do* to a run for any function whatsoever — even a terrible one that merges everybody. Doing it twice in a row is the same as doing the composite once; doing it with the identity function changes nothing. Those facts need no hypothesis at all, because they are about moving data around, not about the verdict.

The verdict is stratum 2, and that is where injectivity enters.

Stratum 3 is the one with a philosophical flavour. If a relabeling is *reversible* — a genuine shuffle of the actor names — then the collection of such shuffles forms a group acting on runs, and well-formedness is constant along the orbits. That is the sense in which "an actor's number is arbitrary": it is a coordinate choice, not a fact.

The three strata are nested, but they are not the same statement, and the file names all three rather than picking one and hiding the others.

## Chunk 2 — what the file admits it is not

```agda
-- SCOPE, STATED AT THE IMPLEMENTED STRENGTH. This module is the current
-- endomorphism instance at `ActorId = ℕ`. It is NOT the varying-name
-- functor `RawRun : DecidableNameSet → Set`, and no category is
-- constructed here: `ActorEmbedding` has category-shaped identity and
-- composition, but associativity and unit laws are not proved, so it is
-- arrow vocabulary rather than a category.
```

The project has a standing rule that a claim and its evidence should be the same size, so the header spends a paragraph saying what has *not* been built.

There is a bigger and better setting available here. Instead of fixing the actor names as "the natural numbers" once and for all, one could treat the *set of names* as a parameter, so that a run over one name set can be carried along a map into a run over another. In that setting the theorem becomes a single sentence — the validator is a *natural* transformation — and injectivity is not a hypothesis you supply but a property of the arrows in the base you chose.

That setting is not built. What is built is its shadow at one object: names are always `ℕ`, and the arrows are always maps from `ℕ` to `ℕ`. The file says so plainly rather than letting the vocabulary imply more than it delivers.

## Chunk 3 — the arrows

```agda
record ActorEmbedding {ℓA ℓB : Level} (A : Type ℓA) (B : Type ℓB)
                    : Type (ℓ-max ℓA ℓB) where
  constructor actorEmbedding
  field
    embeddingMap       : A → B
    embeddingInjective : (m n : A) → embeddingMap m ≡ embeddingMap n → m ≡ n
```

An embedding is bundled: a function, packaged together with a proof that it never merges. The proof is written out rather than imported — "if the images are equal then the inputs were equal."

Two small Agda notes for readers new to it. The `{ℓA ℓB : Level}` are *universe levels*; Agda stacks its types in a tower to avoid paradoxes, and these variables keep the definition usable at any floor. Curly braces mean Agda will figure them out from context so you rarely type them. And `≡` is the equality type: read it as equality, but remember that in this system an equality is itself a piece of data you can manipulate, not just a fact that holds.

The interesting decision is that `A` and `B` are two different types. Today every use is `ActorEmbedding ActorId ActorId` — names to names — so why not write it as a single type mapping to itself?

Because of where this is going. The next rung of the ladder compares the *realized* mathematical objects that two runs determine, and the realized actor carrier of a run is built from that run's own declared actor list. Rename the run and you get a genuinely different type. A map between those two is not a map from `ℕ` to `ℕ`, and it could not even be *written down* if the record had been fixed to one carrier. So the two-carrier form is not generality reached for in advance; it is the shape the next theorem already demands.

```agda
record ActorIsomorphism {ℓA ℓB : Level} (A : Type ℓA) (B : Type ℓB)
                      : Type (ℓ-max ℓA ℓB) where
  constructor actorIsomorphism
  field
    isomorphismTo      : A → B
    isomorphismFrom    : B → A
    isomorphismTo-from : (b : B) → isomorphismTo (isomorphismFrom b) ≡ b
    isomorphismFrom-to : (a : A) → isomorphismFrom (isomorphismTo a) ≡ a

ActorPermutation : {ℓ : Level} → Type ℓ → Type ℓ
ActorPermutation A = ActorIsomorphism A A
```

A reversible relabeling is given by two functions that undo each other in both directions. A *permutation* is then just the case where you come back to where you started.

Worth noticing what is absent: the definition never says "injective and surjective." It says "has a two-sided inverse." Those are equivalent, but they are not the same *definition*, and the file picks the one that says what it means. Injectivity is then something we can prove:

```agda
isomorphismToEmbedding π =
  actorEmbedding (isomorphismTo π)
    (λ m n p → sym (isomorphismFrom-to π m)
             ∙ cong (isomorphismFrom π) p
             ∙ isomorphismFrom-to π n)
```

Read that chain right to left as a little argument. Suppose `π` sends `m` and `n` to the same place. Apply the inverse to both sides — that is what `cong` does, "apply a function to both ends of an equality." Now the inverse of `π` applied to `π` of `m` is just `m`, and likewise for `n`. So `m` equals `n`. The `∙` is composition of equalities, and `sym` runs one backwards.

This function is small but it is structurally the point of stratum 3: *every reversible relabeling is in particular a non-merging one.* Everything the theorem proves for embeddings is therefore automatically true for permutations, and stratum 3 never has to re-prove invariance. It only has to supply what is genuinely new — the inverse.

## Chunk 4 — the action

```agda
renameActorList : (ActorId → ActorId) → List ActorId → List ActorId
renameActorList ρ []       = []
renameActorList ρ (a ∷ as) = ρ a ∷ renameActorList ρ as

renameConversation : (ActorId → ActorId) → RawConversation → RawConversation
renameConversation ρ c =
  mkConv (convId c) (renameActorList ρ (convActors c)) (convSession c)

renameEvent : (ActorId → ActorId) → RawEvent → RawEvent
renameEvent ρ e =
  mkEvent (evId e) (evConv e) (renameActorList ρ (evTouches e))
          (evParents e) (evContent e) (evProv e)
```

Renaming a list applies `ρ` to each element. Renaming a conversation rebuilds it with the same ID and the same session tag, but a renamed actor list. Renaming an event rebuilds it with the same ID, the same conversation, the same parents, the same content and provenance tags — and a renamed touch list.

These definitions are where the *scope* of the theorem is actually decided, and it is worth reading them as a specification rather than as plumbing. Three fields move: `traceActors`, `convActors`, `evTouches`. Every other field is copied across untouched. Event IDs do not move. Conversation IDs do not move. Protocol IDs, content tags, provenance tokens do not move.

That is deliberate and it is a limit, stated in the file's header: this is the **actor channel only**. Whether event IDs can be renamed without changing anything is a different question with a different answer, and it is not asked here. The project's own guidance is emphatic about not quietly widening this to "all identifiers."

Note also that these take a bare function `ρ`, not an `ActorEmbedding`. You can rename by any function at all. Whether the *verdict* survives is a separate question, asked later, of a smaller class of functions. Keeping the two apart is what makes the counterexample expressible: the disastrous merging map is a perfectly legal argument to `renameActors`.

## Chunk 5 — functoriality, with no hypothesis

```agda
renameActors-id : (r : RawRun) → renameActors (λ a → a) r ≡ r

renameActors-compose :
  (ρ σ : ActorId → ActorId) (r : RawRun)
  → renameActors ρ (renameActors σ r) ≡ renameActors (λ a → ρ (σ a)) r
```

Renaming by the identity does nothing. Renaming twice is renaming once by the composite.

These two are stratum 1, and the striking thing is what is missing from their statements: no `ActorEmbedding`, no injectivity, nothing. They hold for *any* functions, including the merging one. That is not an accident or a lucky simplification — it is a real structural fact. Moving actor names around is an operation on data, and data does not care whether the move was reversible.

If you have met the word before, this is *functoriality*: renaming is not merely an operation, it respects identity and composition, which is what makes it an action rather than an arbitrary transformation. The proofs are short inductions over the lists, written in a cubical style where a proof of an equality is literally a function of a formal interval variable `i`, running from one side at `i = 0` to the other at `i = 1`:

```agda
  renameTrace-id : (t : RawTrace) → renameTrace (λ a → a) t ≡ t
  renameTrace-id t i =
    mkTrace (renameActorList-id (traceActors t) i)
            (renameConversations-id (traceConvs t) i)
            (renameEvents-id (traceEvents t) i)
```

Read it as: rebuild the trace, but let each of its three fields slide along its own already-proved equality at the same time. At `i = 0` you have the renamed trace; at `i = 1` you have the original. This is one of the places cubical Agda is genuinely pleasant — the "path" really is a path, and you can build one component-wise.

## Chunk 6 — the one real lemma

```agda
embedding-reflects-identifier-equality :
  (φ : ActorEmbedding ActorId ActorId) (m n : ActorId)
  → eqℕ (embeddingMap φ m) (embeddingMap φ n) ≡ eqℕ m n
```

Here is the hinge. Recall that the validator touches actors only through `eqℕ` — "are these two the same?" This lemma says an embedding does not disturb that question. Ask "are `m` and `n` the same?" before renaming, or ask "are their new names the same?" after; you get the identical `Bool`.

Everything else in the file is bookkeeping on top of this. And in the better setting sketched in Chunk 2, this property is not a lemma at all — it is the *definition* of the arrows in the right base category. That is a reasonable rule of thumb for whether you have found the right definition: the thing your proofs keep needing turns out to be the thing your objects should have been carrying all along.

```agda
embedding-reflects-identifier-equality φ m n = step (eqℕ m n) refl
  where
    step : (b : Bool) → eqℕ m n ≡ b
         → eqℕ (embeddingMap φ m) (embeddingMap φ n) ≡ eqℕ m n
    step true  p =
      eqℕ-complete (embeddingMap φ m) (embeddingMap φ n)
                   (cong (embeddingMap φ) (eqℕ-sound m n p))
      ∙ sym p
```

The proof splits on whether `m` and `n` really are equal, carrying the equation along as `p` so it can be used in each branch.

If they are equal, the argument runs downhill: `eqℕ-sound` converts "the Boolean said `true`" into a genuine equality `m ≡ n`; `cong` pushes it through `φ` to get `φ m ≡ φ n`; `eqℕ-complete` converts back to "the Boolean says `true`." Injectivity is not used at all in this direction. Renaming can never *break* an equality — that is just functions being functions.

```agda
    step false p = stepFalse (eqℕ (embeddingMap φ m) (embeddingMap φ n)) refl
      where
        stepFalse : (c : Bool) → eqℕ (embeddingMap φ m) (embeddingMap φ n) ≡ c
                  → eqℕ (embeddingMap φ m) (embeddingMap φ n) ≡ eqℕ m n
        stepFalse true q =
          rec (trueNotFalse
                (sym (eqℕ-complete m n
                       (embeddingInjective φ m n
                         (eqℕ-sound (embeddingMap φ m) (embeddingMap φ n) q)))
                 ∙ p))
        stepFalse false q = q ∙ sym p
```

The other direction is where injectivity earns its place, and it is the only place in the file it is used.

Suppose `m` and `n` are different, but their new names came out equal. Then `embeddingInjective` says the old names were equal after all — contradicting where we started. The `rec` is elimination from the empty type: from a contradiction, anything. A comment in the source marks the spot: *"The only place injectivity is used: a collapsing map could send distinct identifiers to equal ones, flipping this conjunct."*

So the merging map from the earlier counterexample fails exactly here, and nowhere else. One line of the file is load-bearing for the entire hypothesis.

## Chunk 7 — the clauses, sorted by what they need

The rest of the lemmas are organized by hypothesis strength, which is more informative than organizing them by the order the conjuncts appear in.

```agda
conversationIds-invariant-under-renaming :
  (ρ : ActorId → ActorId) (cs : List RawConversation)
  → convIdsOf (renameConversations ρ cs) ≡ convIdsOf cs

backwardOK-invariant-under-renaming :
  (ρ : ActorId → ActorId) (es : List RawEvent)
  → backwardOK (renameEvents ρ es) ≡ backwardOK es
```

These need only an arbitrary `ρ`. Conversation IDs and event IDs are copied across untouched, so projecting them out gives the same lists. The backward-parents check reads only event IDs and parent lists, so it too is blind to renaming. Five of the eight conjuncts are settled this cheaply.

One that looks like it should need injectivity but does not:

```agda
lookupConvActors-commutes-with-renaming :
  (ρ : ActorId → ActorId) (c : ConvId) (cs : List RawConversation)
  → lookupConvActors c (renameConversations ρ cs)
    ≡ renameActorList ρ (lookupConvActors c cs)
```

`lookupConvActors` finds a conversation by ID and returns its actor list. Renaming does not touch conversation IDs, so the search takes the same turns and finds the same conversation on both sides — only the list it hands back is relabeled. The renaming commutes past the lookup for free.

Then the ones that genuinely need an embedding:

```agda
membership-invariant-under-embedding :
  (φ : ActorEmbedding ActorId ActorId) (a : ActorId) (as : List ActorId)
  → (embeddingMap φ a ∈? renameActorList (embeddingMap φ) as) ≡ (a ∈? as)
```

"Is this actor in this list?" is answered by comparing with `eqℕ` down the list, so this is Chunk 6 applied at every position, held together by an induction. From membership, everything else follows: subset is membership repeated, duplicate-freeness is membership repeated, the conversation check is duplicate-freeness plus subset, and the event check is those plus one trip through the lookup.

The dependency tree is worth seeing whole, because it is unusually shallow. One lemma about `eqℕ`, one induction to lift it to lists, and the rest is assembly.

## Chunk 8 — the theorem

```agda
validator-invariant-under-actor-embedding :
  (φ : ActorEmbedding ActorId ActorId) (r : RawRun)
  → valid? (renameActors (embeddingMap φ) r) ≡ valid? r
```

Rename a run by any embedding; the verdict is unchanged.

The quantifier to notice is `(r : RawRun)` — **every** raw run, not every *valid* one. That is the half that makes this a statement about the validator rather than a statement about good runs. It says a rejected run stays rejected: relabeling cannot launder a malformed run into acceptance. That is exactly what the counterexample threatened, and it is the more interesting direction.

The proof assembles the eight conjuncts in order. There is one wrinkle worth flagging because the source flags it:

```agda
  -- The first two conjuncts read fields renaming never touches. They are
  -- pinned with an explicit `cong` rather than `cong₂ … refl`, which leaves
  -- the endpoints ambiguous inside the nested chain.
  cong (λ y → eqℕ (traceFormat r) formatCode andB y)
```

The natural way to write "this conjunct is unchanged" is a bare `refl`, but inside a deeply nested chain Agda could not work out which expressions the `refl` was supposed to connect and reported unsolved goals. Writing the conjunct out explicitly pins it. This is a tool limitation rather than mathematics, and the project's convention is to say so at the site rather than let a reader assume the awkwardness means something.

```agda
wellFormed-transport-along-embedding :
  (φ : ActorEmbedding ActorId ActorId) (r : RawRun)
  → WellFormed r → WellFormed (renameActors (embeddingMap φ) r)

wellFormed-reflect-along-embedding :
  (φ : ActorEmbedding ActorId ActorId) (r : RawRun)
  → WellFormed (renameActors (embeddingMap φ) r) → WellFormed r
```

`WellFormed r` is *defined* as "`valid? r` equals `true`", so the Boolean theorem transports it immediately. Both directions are exported by name because the next rung will want an actual proof in hand, and an equation between two statements is less convenient to use than a function that converts one proof into another.

## Chunk 9 — the gauge layer, and what it adds

```agda
renameActors-inverse-from-to :
  (π : ActorPermutation ActorId) (r : RawRun)
  → renameActors (isomorphismFrom π) (renameActors (isomorphismTo π) r) ≡ r

wellFormed-invariant-under-actor-permutation π r =
  wellFormed-invariant-under-actor-embedding (isomorphismToEmbedding π) r
```

Look at the second one: the permutation-level invariance is not proved. It is *delegated*, by pushing the permutation through `isomorphismToEmbedding` and calling the theorem we already have. Agda accepts it without any further work.

That is the argument of Chunk 3 confirmed by the machine rather than asserted in prose. Permutations add nothing to invariance. What they add is the inverse law above — undo a relabeling and you are exactly back where you started — and that is genuinely new content, because the embedding stratum has no notion of undoing anything.

This is the layer where the physics vocabulary the project sometimes uses becomes precise. The numbers assigned to actors are a *coordinate choice*: the shuffles of those numbers form a group, that group acts on runs, and well-formedness is constant on the orbits. In that limited and exact sense actor identity is "gauge" — redundant presentation data rather than content.

Two honest boundaries around that. First, the project's own anti-drift notes forbid inflating this into a claim that anything here is a gauge *field theory*: there is no connection, no curvature, and — the one that actually bites — no *local* gauge group. Real gauge symmetry is indexed by points of a base space; ours is one global relabeling for the whole run. Second, the natural next question is whether the symmetry can be made local by letting each conversation choose its own actor coordinates. It cannot be done naively, because an actor who appears in two conversations must be relabeled consistently in both — and that consistency requirement, rather than being an obstruction, is precisely the *gluing data* such a localization would have to carry. Nothing about that is proved here. It is recorded as a question.

## Chunk 10 — the load-bearing absence

```agda
-- ON DENSE COORDINATES. `Trace.agda` records that the serialization
-- generator assigns dense `ℕ` coordinates by first appearance. `valid?`
-- has NO density clause, and that absence is load-bearing here: were
-- density required, this theorem would fail even for permutations, since
-- transposing 0 and 5 sends the actor list [0,1] to [5,1].
```

This is the subtlest paragraph in the file and it deserves its own chunk.

The tool that turns wire-format JSON into these numeric records assigns actors `0, 1, 2, …` in order of first appearance. So real runs always have *dense* actor numbering, starting at zero with no gaps. It would have been very natural to make the validator insist on that — it looks like a tidy well-formedness condition.

It would also have killed this theorem. Swap actors `0` and `5` and the list `[0,1]` becomes `[5,1]`, which is not dense. A density clause would make even a straightforward shuffle change the verdict, and there would be no renaming invariance to prove at all.

So the *absence* of a density check is not an oversight the file works around; it is a precondition the file depends on. Density is a canonical way of *presenting* a run, not a fact about it. In the coordinate language of the previous chunk: choosing dense first-appearance numbering is choosing a gauge. The file's header is careful to mark that reading as an interpretation rather than a result — proving that the normalization picks exactly one representative per orbit would be a real theorem, and it has not been done.

## Chunk 11 — the honest limits

The file ends where a reader should be most careful, so this commentary should too.

**It is close to true by construction.** The validator has no actor-identity-sensitive clause, so in a sense it could hardly have come out otherwise. The project's own planning notes say as much — "modest enough that a skeptic can read it as mostly by construction." The value is not that the result is surprising. It is that an intention has become an obligation, watched by a machine, that will fail loudly if the validator ever grows a clause that looks at who someone is.

**It is one channel.** Event IDs, conversation IDs, protocol IDs, content tags, provenance tokens, run IDs: untouched, and each with its own separate question.

**It is one presentation.** Nothing here says anything about the *realized* mathematical object a run determines — the actor-causal structure the rest of the project builds. That is the next rung, and, as Chunk 3 explained, the current infrastructure cannot yet even state it: the morphisms between those objects have no slot for an actor map. Finding that gap is arguably the most useful thing this session produced, and it is recorded rather than patched.

**It is not privacy.** The theorem says the *validator* cannot distinguish actors by name. It says nothing about any other observer. If the runtime derived actor numbers from real identities in a recoverable way, the validator still would not care — and everyone else could read them straight off. Turning "the checker is blind" into "the record does not leak" needs a notion of *trusted observation* that does not exist yet, and until it does, this rung should not be described as a privacy result.

That last distinction is the one most worth carrying away, because it is the one most easily blurred, and blurring it would misrepresent what a reader can rely on.

> **References**
> - [nLab: nominal set](https://ncatlab.org/nlab/show/nominal+set) — the standard mathematical home for "names, and maps that keep distinct names distinct." Gabbay and Pitts introduced the setting for reasoning about variable binding; the shape of the problem there is close to the shape here.
> - [nLab: gauge transformation](https://ncatlab.org/nlab/show/gauge+transformation) — for readers who want to check how much of the physics vocabulary in Chunk 9 is really being claimed. The answer is: the redundancy-of-presentation part, and nothing else.
> - `workflow/bias_correction.md` — the project's own list of readings it explicitly rejects, including the gauge one. Worth reading alongside Chunk 9.

The companion for the test module, `Tests/ActorRenaming.md`, walks the concrete witnesses: the two relabelings that break the run, the two that do not, and why each one is there.
