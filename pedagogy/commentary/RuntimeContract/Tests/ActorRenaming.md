# Tests/ActorRenaming.agda — four relabelings and what each one is for

## Where This File Sits

`ActorRenaming.agda` proves a statement about *every* raw run and *every* embedding. This file does something narrower and, in one specific way, more important: it picks four concrete relabelings, runs them against a real fixture from the corpus, and checks what actually happens.

The reason that matters is worth stating plainly, because it is easy to shrug at a test file.

The theorem says `valid? (renameActors φ r) ≡ valid? r`. Now imagine that `renameActors` had been defined badly — suppose it quietly returned its input unchanged. The theorem would still be true. It would be true *trivially*, it would compile, and nothing anywhere would complain. A green proof assistant is not, by itself, evidence that a statement has content.

This file is the guard against that reading. It is what the project calls a **degeneracy control**: a check whose only job is to rule out the interpretation in which the theorem says nothing. And the file is careful to call it that rather than something grander — in particular, these are *not* tests that the system fails to leak identity. That would need an observer other than the validator, and no such observer exists yet.

The fixture throughout is `fixtures/valid/cross_conversation.json`, an accepted run with three actors and two conversations:

```text
actors        a0, a1, a2                    ->  0, 1, 2
conversation  c0 with actors a0, a1
conversation  c1 with actors a1, a2
events        e0 in c0 touching a0
              e1 in c1 touching a1, after e0
              e2 in c0 touching a1, after e1
              e3 in c1 touching a2, after e1
```

Actor `a1` sits in both conversations. That overlap is what makes the fixture interesting for the sharper counterexample below.

## Chunk 1 — the two relabelings that keep the run valid

```agda
sucActorEmbedding : ActorEmbedding ActorId ActorId
sucActorEmbedding = actorEmbedding suc (λ m n p → injSuc p)

swap01 : ActorId → ActorId
swap01 zero                = suc zero
swap01 (suc zero)          = zero
swap01 (suc (suc n))       = suc (suc n)

swap01Permutation : ActorPermutation ActorId
swap01Permutation =
  actorIsomorphism swap01 swap01 swap01-involutive swap01-involutive
```

Two good relabelings, deliberately of different kinds.

`suc` shifts every actor up by one: `0 ↦ 1`, `1 ↦ 2`, `2 ↦ 3`. It never merges anyone, so it is an embedding — `injSuc` is the library fact that if `suc m` and `suc n` agree then `m` and `n` did. But it is *not* reversible: nothing maps to actor `0`.

`swap01` exchanges actors `0` and `1` and leaves everyone else alone. It is its own inverse, which is why the same function appears in all four slots of the isomorphism record and the same proof serves both round-trip laws.

They are both here because they sit on different rungs of the file's stratification. The transposition exercises the reversible layer — the "gauge" layer, where relabeling is a shuffle. `suc` exercises the strictly larger layer where relabeling need not be reversible at all.

```agda
sucIsNotSurjective : (a : ActorId) → ¬ (suc a ≡ zero)
sucIsNotSurjective a = snotz
```

This one line is why `suc` is worth including. Without it, "`suc` shows the theorem reaches beyond reversible relabelings" would be a remark in a comment. With it, non-reversibility is *proved*: actor `0` has no preimage, so `suc` is definitely not a shuffle. (`¬ P` means "assuming `P` leads to absurdity"; `snotz` is the library fact that a successor is never zero.)

The distinction the project cares about is the one between a statement that is *stated* generally and a statement whose generality is *witnessed*. If every checked example had been a shuffle, nothing in the record would distinguish the general theorem from the narrower one about shuffles.

## Chunk 2 — the relabeling that breaks everything

```agda
collapseAllToZero : ActorId → ActorId
collapseAllToZero _ = zero

_ : valid? (renameActors collapseAllToZero crossConversation) ≡ false
_ = refl
```

Send every actor to `0`. The three declared actors `[0,1,2]` become `[0,0,0]`, which is not duplicate-free, and the run is rejected.

This is the counterexample from the main commentary made executable. It is a check about the *absence* of a theorem: there is no invariance result for arbitrary maps, and here is a specific arbitrary map that visibly destroys a verdict. Note that the assertion is `refl` — it holds by plain computation, not by appeal to anything proved. It has to be that way. A claim that a theorem does not extend cannot be routed through the theorem.

Reading the Agda: `_ : <statement>` followed by `_ = <proof>` is an anonymous declaration. Agda checks it and discards the name. It is how this project writes assertions — typechecking the module *is* running the test suite.

## Chunk 3 — the relabeling that breaks exactly one thing

```agda
collapseTwoToZero : ActorId → ActorId
collapseTwoToZero zero                      = zero
collapseTwoToZero (suc zero)                = suc zero
collapseTwoToZero (suc (suc zero))          = zero
collapseTwoToZero (suc (suc (suc n)))       = suc (suc (suc n))

_ : valid? (renameActors collapseTwoToZero crossConversation) ≡ false
_ = refl
```

The blunt counterexample tells us injectivity matters. This sharper one tells us *where*.

It merges only actors `2` and `0`, leaving `1` alone. Now look back at the fixture: `c0` holds `{a0, a1}` and `c1` holds `{a1, a2}`. Actors `0` and `2` never share a conversation. So merging them cannot upset any conversation's internal duplicate check, and cannot upset any event's "touches only actors of its conversation" check. The only thing that breaks is the global list of declared actors, `[0,1,2] ↦ [0,1,0]`.

```agda
_ : distinctB (traceActors collapsedTrace) ≡ false
_ = refl

_ : allB (convOK (traceActors collapsedTrace)) (traceConvs collapsedTrace) ≡ true
_ = refl

_ : allB (eventOK (convIdsOf (traceConvs collapsedTrace)) (traceConvs collapsedTrace))
         (traceEvents collapsedTrace)
    ≡ true
_ = refl
```

And these three checks say exactly that, rather than leaving it as a claim in a comment. Trace-actor distinctness goes to `false`; the conversation clauses stay `true`; the event clauses stay `true`.

This is a small illustration of a standing rule in the project: if a comment asserts something specific, either check it or soften the wording. The comment originally said the map "fails exactly one conjunct." That is a stronger statement than these three checks establish on their own — it also needs the *other* five conjuncts, and those are covered differently. They involve the format code, sibling IDs, conversation IDs, event IDs and backward parents, none of which any renaming touches; the main module proves that generically, for arbitrary maps, so pinning them at this one fixture would be the weaker evidence. The comment now says what is checked here and points at where the rest lives.

## Chunk 4 — the run really does move

```agda
_ : traceActors (trace (renameActors swap01 crossConversation))
    ≡ (suc zero ∷ zero ∷ suc (suc zero) ∷ [])
_ = refl
```

The declared actor list `[0,1,2]` becomes `[1,0,2]`.

This is the plainest possible answer to "how do we know `renameActors` isn't secretly the identity function?" It is not, and here is a run where you can see it move. Three lines, and without them the whole file would be compatible with a theorem about nothing.

It is worth noticing that the identity and composition laws proved in the main module — the functoriality of Chunk 5 there — do *not* rule this out. The identity function satisfies both laws perfectly well. Structural laws constrain how an operation composes; only a witness like this one shows the operation is not trivial.

## Chunk 5 — the good relabelings, routed through the theorem

```agda
_ : valid? (renameActors (embeddingMap sucActorEmbedding) crossConversation)
    ≡ true
_ = validator-invariant-under-actor-embedding sucActorEmbedding crossConversation

_ : valid? (renameActors (isomorphismTo swap01Permutation) crossConversation)
    ≡ true
_ = validator-invariant-under-actor-embedding
      (isomorphismToEmbedding swap01Permutation) crossConversation
```

Both good relabelings leave the fixture accepted.

The detail worth dwelling on is the right-hand side. These could have been `refl` — the fixture is a concrete term, so Agda can just compute both verdicts and see they agree. Instead each one is proved by *applying the theorem*. That does two jobs at once. It checks the fixture, and it checks that the theorem actually delivers the equation it advertises on a real input rather than only in principle.

The second assertion also shows the stratification in action: `swap01Permutation` is a permutation, but the theorem being applied is the *embedding* theorem, reached by pushing the permutation through `isomorphismToEmbedding`. That is the "the core includes into the arrows" step from the main commentary, being used rather than described.

The `suc` assertion is the one that pays off Chunk 1. The renamed run has actors `[1,2,3]` — no actor `0` at all, so the numbering is no longer dense. It is still accepted, which is the executable form of the observation that dense first-appearance numbering is a convention of the generator and not a requirement of the contract.

## Chunk 6 — the transport, used

```agda
_ : WellFormed (renameActors (isomorphismTo swap01Permutation) crossConversation)
_ = wellFormed-transport-along-permutation swap01Permutation crossConversation refl
```

The last assertion has no `≡` in it. It is not an equation — it is a *statement of well-formedness* about the relabeled run, and the proof produces it from well-formedness of the original.

The `refl` at the end is that original proof: `WellFormed crossConversation` unfolds to "`valid? crossConversation` equals `true`", which holds by computation. The transport function turns it into the corresponding fact about the swapped run.

This exists because of a small API decision in the main module. The theorem naturally yields an *equation between two statements*, and an equation between statements is awkward to use — you cannot apply it to anything. So both directions are also exported as ordinary functions from proof to proof. This assertion is the check that the convenient form works on a real run, which is what the next rung of the ladder will actually reach for.

## What This File Is Not

The header of the source says it, and it is the right note to end on:

```agda
-- These are DEGENERACY CONTROLS, not leak falsifiers. They rule out the
-- reading in which `renameActors` is secretly the identity, and they
-- exercise each of the module's three hypothesis strata at a real run.
-- A gate-6 leak falsifier would need identity-sensitive content,
-- provenance, ranking, or an observation beyond `valid?`; none exists
-- yet, because `valid?` has no actor-identity-sensitive clause by
-- construction.
```

There is a question the project keeps on a list of open decisions: *what fixture would demonstrate a leak?* This file does not answer it, and the header says why it cannot. A leak is something an observer notices. The only observer here is `valid?`, and `valid?` was built with nothing that looks at who an actor is — so within its horizon there is nothing to catch. Answering that question needs a *trusted observation* beyond the validator: something about content, provenance, or ranking whose behaviour could change under relabeling. Those do not exist yet.

So the correct summary of this file is modest and exact. Four relabelings: two that a good validator must reject the run under, two that it must not, and each chosen to exercise a different part of the claim. Together they establish that the theorem in the neighbouring module is about something. They do not establish that anyone's identity is safe.

The distinction is not pedantry. It is the difference between what a reader may rely on and what they may not, and the project's habit is to keep that line visible rather than let a green test suite blur it.
