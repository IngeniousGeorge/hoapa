# Session 03 - Tiny Example

## Next step

### Codex

• Next technical step: event-dependent session slots over finite frames.

  The current result is strong but still constant-slot:

  value F = Π_{event in F} P₀

  So the arity varies with the frame, but every event carries the same session type. The next meaningful lift is:

  value F = Π_{event in F} Slot F event

  where Slot F event : SessionType Payload.

  That is the real next B2(a) move: session content depends on the event, not only on the number of events.

  I would not jump to Reflexive/Bulk/MO_1 yet. The current Hybrid/value layer just became capable of descent; the obvious pressure point is to make the value assignment genuinely content-sensitive
  before building higher layers on it.

  Decisions needed before coding:

  1. What is Slot allowed to inspect?
     Conservative v1: Slot is supplied as external displayed data over finite frames/events, not derived from actor identity or causal structure yet.
  2. How does Slot restrict along FrameHom?
     For φ : G ↪ F, we need compatibility:

     Slot G e ≡ Slot F (φ.event-map e)

     or a morphism/coercion between those session types. Equality is simpler; morphisms are more expressive.

  3. How to avoid transport blow-up?
     Constant slot avoided indexed codomain transports. Event-dependent slots bring them back. I would create a new displayed finite-frame record carrying slots already indexed by the chosen Fin
     event-count, plus explicit restriction coherence along reindex.
  4. Where should it live?
     Probably a new module, not a mutation of the current witness:

     Concurrency/Hybrid/DisplayedSessionEventSheaf.agda

     Keep SessionEventProductSheaf.agda as the clean constant-slot base case.

  Recommended implementation path:

  1. Define SessionSlotFamily over finite frames with chosen slot : Fin event-count → SessionType.
  2. Define restriction coherence for finite-frame morphisms.
  3. Build the dependent event-product presheaf using bigProduct n slot.
  4. Prove functoriality and descent, likely requiring some helper lemmas around transported bigπ.

  This is harder than M5, but it is the right next step if the goal is to keep strengthening the concurrency side rather than just stacking more layers.

### Claude

❯ Now, please give me your assessment on what should be the next step                                                                                                                                  

● Let me verify one thing before giving my assessment — whether the finite-descent stack has ever been exercised on a concrete cover, or whether it's entirely generic.

● Bash(cd /home/ig/Code/hoapa
      echo "=== concrete FiniteFrame / FiniteCover instances? (Tiny/Point/two-point in finite files) ==="…)
  ⎿  === concrete FiniteFrame / FiniteCover instances? (Tiny/Point/two-point in finite files) ===
     === any module importing FiniteCover to build an instance? ===
     agda/Concurrency/Hybrid/FiniteDescent.agda
     … +5 lines (ctrl+o to expand)

● Confirmed: there are no concrete FiniteFrame or FiniteCover instances anywhere. FiniteCover is imported only by the descent records, the generic proof, and itself. The entire finite-descent stack —
  including the Sessions instantiation we just landed — is purely generic and has never been run against a concrete, non-trivial cover.

  That fact drives my recommendation.

  Assessment

  Where we are. Descent is now statable, generic-inhabited, and Sessions-instantiated. That's a real milestone. But every inhabitant is parametric: event-product-sheaf proves "for all finite frames,
  covers, matching families, …", and nothing has ever forced a concrete frame with ≥2 events through a concrete cover with a real overlap.

  The gap I'd close first: non-vacuity. The design discussion that produced this work was explicitly worried about degeneracy — the constant presheaf "inhabits descent without stress-testing it." We
  answered that argument abstractly (arity varies ⇒ gluing is non-degenerate), but we never exhibited it. Two concrete risks remain open:

  1. The records may be awkward-to-impossible to inhabit concretely. FiniteCover carries chosen overlap enumerations — for each patch pair, the enumerated pullback frame-pullback (embed i) (embed j)
  plus projections. Whether that's ergonomically suppliable for even the tiny two-point site is untested. If it's painful, that's a design signal we want now, before piling the sheaf category and R4
  on top.
  2. We have no demonstration that gluing actually computes a non-trivial global section from genuinely-differing local parts.

  My recommended next step: a concrete tiny worked example, end-to-end. Build:
  - a FiniteFrame for the existing TinyFrame/PointFrame (Bool events are already enumerable — enum : Event ≃ Fin n);
  - a FiniteCover of it from the two PointFrame patches, with the overlap pullback enumerated;
  - feed it to event-product-sheaf (generic V first, then session-event-product-sheaf), and evaluate a matching family into an amalgamated section — confirming the gluing reduces.

  This is moderate cost, high confidence, low conceptual risk, and it is exactly the sanity check the descent design discussion asked for ("the witness visibly applies to the non-trivial tiny-site
  cover"). It converts "descent is inhabited" from a generic theorem into a witnessed, computed fact — and it will surface any over-constraint in the finite-site interface cheaply.

  The strategic frontier, after that

  The roadmap's named next hinge is R4 (cartesian topos logic ↔ linear/session values), en route to the cross-site Allow ⊣ Require. But R4 is currently gated: it needs topos-side structure that
  doesn't exist — there's no Sh(site) as a category object, no Ω, no internal logic. So the honest structural sequence is:

  1. Concrete tiny example (above) — validate non-vacuity. Do this next.
  2. _Topos._SheafCategory — assemble finite-frame sheaves into a category. This is the prerequisite object for R3/R4 and ultimately the cross-site geometric morphism. Real widening, larger.
  3. R4 / cross-site adjunction — only statable once 2 exists.

  Two parallel items worth naming (not next, but on the board)

  - Event-dependent slot ("B2(a) proper"). Upgrading from the constant slot to per-event session content is the real B2(a) target. It's a deepening, not a frontier, and it's the expensive one: it
  reintroduces index-dependent codomains, making the UnsupportedIndexedMatch warning load-bearing (transport machinery, or switching off FinData.Fin). I'd defer it until the tiny example confirms the
  interface, so we're not paying transport cost on an unvalidated stack.
  - Postulate debt. 21 categorical laws + SessionO1Action + 4 product laws are postulated. The decision log already schedules deriving these "before serious MO_1 work." Don't pay it down now — but
  it's the thing that eventually makes the B-side load-bearing rather than asserted.

  Recommendation

  Do the concrete tiny worked example next. It's the cheapest move that materially raises confidence in everything just built, it's the explicitly-requested sanity check, and it de-risks the
  FiniteCover overlap-enumeration interface before that interface gets buried under the sheaf-category and R4 work. After it lands, I'd start _Topos._SheafCategory as the structural push toward R4.

  Want me to start on the tiny example? I'd begin by checking whether TinyFrame/PointFrame and the two-point cover can be lifted to FiniteFrame/FiniteCover, and flag immediately if the
  overlap-pullback enumeration turns out to be the sharp edge.

## Event-dependent slot deferral

### Claude assessment, recorded

Deferring event-dependent session slots is close to free, but only under an explicit genericity discipline.

The expensive part of event-dependent slots is intrinsic, not caused by waiting. The current constant-slot witness works because

```text
value F = P₀ ^ event-count(F)
```

so every projection out of the finite product lands in the same codomain `P₀`. Reindexing along an enumeration path is therefore a plain `cong` in a fixed `Hom` type, which is why the current `UnsupportedIndexedMatch` warnings on `bigπ` and `bigβ` remain inert.

The event-dependent target changes the value shape to

```text
value F = Π[ event in F ] Slot F event
```

or, against the chosen finite enumeration,

```text
value F = bigProduct (event-count F) (slot F)
```

Now projections have index-dependent codomains. Reindexing along frame maps and overlap enumerations therefore needs real transport machinery: either `PathP` over varying codomains, or a different finite-index representation that computes better under transport. This cost is research-grade and time-invariant. Doing it now or later does not substantially change that bill.

The soft re-acquisition cost is already mitigated. `EventProductPresheaf.agda`, `FiniteProducts.agda`, and `session_02_finite_descent.md` all record why the constant-slot discipline keeps the warning harmless and why a future non-constant slot must revisit it.

The one real cost that can grow is lock-in. If the next layers are built specifically around `event-product-presheaf`, `session-event-product-presheaf`, or proofs that rely on all projections landing in `P₀`, then upgrading to event-dependent slots later would force generalization through every layer built above them.

### Guard

Build every layer between here and R4 generically over:

```text
FiniteFramePresheaf
IsSheaf
```

not over the specific constant-slot witness.

Concretely:

- `_Topos._SheafCategory` should take arbitrary finite-frame sheaves as objects.
- R4 should be stated over the sheaf/category interface, not over `session-event-product-sheaf`.
- No structural bridge toward `Allow ⊣ Require` should assume a global fixed slot `P₀`.
- Any lemma that uses "all projections land in `P₀`" belongs inside the constant-slot witness files, not in the topos/R4 layer.

This mirrors the existing design of `FiniteDescent.agda`: descent is generic over any `FiniteFramePresheaf` plus `IsSheaf`, and the constant-slot event product is only one inhabitant.

### Why this is safe for the foundational adjunction path

R4 and the cross-site adjunction do not require event-dependent slots. The sheaf category is `Sh(site)`-shaped; its structural role is cartesian/topos logic over the B-side site, connected to the linear/session value layer. Whether a particular sheaf has constant or event-dependent slots refines the values, but it is orthogonal to stating the category and the bridge.

The remaining weakness of constant-slot Sessions is presentational, not structural: the arity varies with the frame and gluing is non-trivial, but the per-event content is not yet differentiated. That is honest and upgradable.

Doing the tiny example first also lowers the risk of the later dependent-slot work. Event-dependent slots will stress exactly the same `FiniteCover` overlap-enumeration interface, but with dependent codomains. It is better to validate and, if necessary, revise that interface on the concrete `TinyFrame` / `PointFrame` cover before adding transport-heavy dependent products.

### Future implementation note

When event-dependent slots are resumed, do not mutate `SessionEventProductSheaf.agda`; keep it as the clean constant-slot base case. Add a new module, likely:

```text
Concurrency/Hybrid/DisplayedSessionEventSheaf.agda
```

Expected shape:

1. Define a displayed slot family over finite frames, with `slot F : Fin (event-count F) -> SessionType Payload`.
2. Add restriction coherence for finite-frame morphisms, relating `slot G j` to `slot F (reindex F G φ j)`.
3. Build the dependent event-product presheaf using `bigProduct (event-count F) (slot F)`.
4. Prove functoriality and descent by reworking the projection/reindex lemmas with explicit transports.
5. Reuse `FiniteDescent.agda` unchanged: the result should be another `FiniteFramePresheaf` plus `IsSheaf` inhabitant.

Decision for this session: do the concrete tiny finite worked example now; keep subsequent topos/R4 work generic; return to event-dependent slots after the finite-cover interface has been exercised, possibly after R4 if the genericity guard has held.
