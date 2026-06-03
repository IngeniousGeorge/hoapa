# Session Descent Review Bundle

This file is a review artifact. It records the work completed in this session and proposes workflow-documentation edits, but it does not apply those edits to `workflow/status.md`, `workflow/future_work.md`, `workflow/targets.md`, or `workflow/arc.md`.

## 1. Summary for the Instigator

### What was done

The team converged on the B-side next step: finish the Hybrid descent/gluing substrate before attempting any of the numbered complexity layers such as Reflexive Protocol Layer, Bulk Type Theory, `MO_1`, federation, or field theory. The reason is structural: those later layers all depend on the Hybrid chassis being stable enough to support sheaf-style reasoning over actor-causal covers.

Two Agda modules were written:

- `agda/Concurrency/Sites/ActorPullback.agda`
  Defines frame pullback cones for actor-causal frames. This supplies the overlap objects needed by descent. It also defines `pullback-cover` and `stability-cover-pullback`, giving a real downstream construction of cover stability.

- `agda/Concurrency/Hybrid/Descent.agda`
  States probe-form descent for frame presheaves. It defines `MatchingFamily`, `HasAmalgamation`, and `IsSheafPresheaf`, bundling separatedness with the existence half of gluing. The probe-form choice was deliberate: the current `StarAutonomous` target is thin and has no products, equalizers, or additives, so classical equalizer-form sheaf descent is not currently statable without expanding the value-category interface.

Codex reviewed the implementation direction and typechecking. The important review result is that the mathematical shape is right and no fake gluing postulates were introduced. The working invocation from repo root is:

```sh
agda -l cubical -i agda agda/Concurrency/Sites/ActorPullback.agda
agda -l cubical -i agda agda/Concurrency/Hybrid/Descent.agda
```

Claude also updated the header around `stability-cover-postulate` in `ActorCausal.agda`, marking it as superseded downstream rather than removed. That distinction matters.

### How this differs from the original plan

The original plan was a conservative two-checkpoint move: first build the overlap machinery needed by descent, then state descent itself. That plan held, but the site-side work went slightly further than the minimum.

The minimum descent prerequisite was binary overlap cones for two patches of a cover. The shipped `ActorPullback.agda` also builds pulled-back covers and proves `stability-cover-pullback`. That is useful and honest, but the workflow docs should not overstate it as removing every visible stability postulate from the project.

`ActorCausal.agda` still contains `stability-cover-postulate`, and `tiny-site` still uses it. This is not because the construction failed. It is because `ActorPullback.agda` imports `ActorCausal.agda`; importing the construction back into `ActorCausal.agda` would create a cycle. The right wording is: the stability postulate is superseded downstream by a real construction, while remaining as a legacy in-file fallback inside `ActorCausal.agda`.

The other important non-overclaim: descent is now stated, not inhabited. The new file defines what it means for a presheaf to glue; it does not yet prove that any concrete presheaf has amalgamation.

### What remains and next step

Before committing, the workflow docs should be updated so they no longer say that matching families, overlap compatibility, or descent itself are entirely future work. They should instead say:

- frame pullbacks and overlap objects are now shipped;
- cover stability has a downstream construction, but the original in-file postulate remains as a fallback in `ActorCausal.agda`;
- probe-form descent definitions are shipped;
- inhabiting descent with a concrete amalgamation witness remains pending.

The next technical step after committing the code files is to inhabit descent. That forces the empty-cover decision. There are two reasonable next paths:

- Restrict or refine the topology to inhabited covers, then prove separatedness/amalgamation for a simple witness such as a constant presheaf where the empty-cover failure is avoided.
- Build a non-constant frame-varying witness, likely using displayed-subsite or tiny-diagram machinery, so descent has a meaningful locality-sensitive example.

The first path buys a cheaper first inhabitant and clarifies the empty-cover policy. It costs a topology-side decision. The second path buys a stronger non-degeneracy witness. It costs more machinery before the first descent inhabitant exists. My recommendation is to make the inhabited-vs-empty-cover decision first, because it affects both separatedness witnesses and amalgamation witnesses.

## 2. Proposed Workflow Edits for Future Agents

### Plan

1. Apply only workflow documentation changes first. Do not touch `communication/*` or untracked parallel-task files.
2. Preserve the distinction between descent definitions and descent witnesses.
3. Preserve the distinction between downstream stability construction and the legacy in-file fallback postulate.
4. After applying the edits, run an audit such as:

```sh
rg -n "full sheaf|sheaf gluing|descent over covers|descent/gluing|Matching families|stability-cover-postulate|stability postulate|postulate gap|amalgamation witness|inhabit" workflow/status.md workflow/future_work.md workflow/targets.md workflow/arc.md
```

5. If the audit still finds stale wording, fix the wording rather than deleting useful historical decision-log entries.

### Proposed Diff

The diff below is intentionally scoped to top-level workflow files. It is a proposed edit bundle, not an already-applied patch.

~~~diff
diff --git a/workflow/status.md b/workflow/status.md
--- a/workflow/status.md
+++ b/workflow/status.md
@@
-Hybrid v1 is now shipped as the first adapter layer: `Concurrency/Hybrid/Presheaf.agda` defines a generic `FramePresheaf` over actor-local frames valued in any `StarAutonomous` target, plus zero-postulate `IsSeparatedPresheaf` as the uniqueness / auditability half of descent. `Concurrency/Hybrid/SessionPresheaf.agda` specializes this to `Sessions-Cat Payload` and provides both constant witnesses, `const-𝟙ₛ-presheaf` and `const-⊥ₛ-presheaf`, without adding any hidden morphism between the tensor unit and the dualizing object. This is Adapter 1 (restriction); full sheaf gluing remains pending.
+Hybrid v1 is now shipped as the first adapter layer: `Concurrency/Hybrid/Presheaf.agda` defines a generic `FramePresheaf` over actor-local frames valued in any `StarAutonomous` target, plus zero-postulate `IsSeparatedPresheaf` as the uniqueness / auditability half of descent. `Concurrency/Hybrid/SessionPresheaf.agda` specializes this to `Sessions-Cat Payload` and provides both constant witnesses, `const-𝟙ₛ-presheaf` and `const-⊥ₛ-presheaf`, without adding any hidden morphism between the tensor unit and the dualizing object. Adapter 2 is now stated in `Concurrency/Hybrid/Descent.agda`: probe-form matching families, overlap compatibility via `Concurrency/Sites/ActorPullback.agda`, and amalgamation as a property record. What remains is inhabiting descent with a concrete amalgamation witness.
@@
-`_Sheaf._Descent` — gluing condition for covers from `_Site._Topology`; not yet implemented.
+`_Sheaf._Descent` — shipped as `Concurrency/Hybrid/Descent.agda`: probe-form matching families over covers, overlap compatibility through frame pullbacks, and `HasAmalgamation` / `IsSheafPresheaf` as property records. No concrete amalgamation witness has landed yet.
@@
-- **R1 — Valuation.** v1 landed in `Concurrency/Hybrid/{Presheaf,SessionPresheaf}.agda`: `FramePresheaf` is the generic functorial assignment `_Site._Category^op → V`, and `SessionPresheaf` instantiates `V = Sessions-Cat Payload`. Full sheaf valuation is not complete until descent/gluing lands.
-- **R2 — Indexing.** `_Sheaf` lives over `_Site`: presheaf + descent against `_Site._Topology`. The presheaf and separatedness layers are shipped; descent is the remaining load-bearing half.
+- **R1 — Valuation.** v1 landed in `Concurrency/Hybrid/{Presheaf,SessionPresheaf}.agda`: `FramePresheaf` is the generic functorial assignment `_Site._Category^op → V`, and `SessionPresheaf` instantiates `V = Sessions-Cat Payload`. The descent statement now lands in `Concurrency/Hybrid/Descent.agda`; full sheaf valuation still waits on an inhabited amalgamation witness.
+- **R2 — Indexing.** `_Sheaf` lives over `_Site`: presheaf + descent against `_Site._Topology`. The presheaf, separatedness, frame-overlap, and descent-definition layers are shipped; proving amalgamation for a concrete presheaf is the remaining load-bearing half.
@@
-- **R6 — Parametrization (Causality).** Causality → `_Site`. Landed in `Concurrency/Sites/{ActorBase,ActorCausal}.agda`: Lamport partial-order events, actor-local frames, strict-reflecting frame embeddings, basis covers, and a Bool-based non-trivial cover witness. The remaining quality gap is `stability-cover-postulate`, not the R6 interface itself.
+- **R6 — Parametrization (Causality).** Causality → `_Site`. Landed in `Concurrency/Sites/{ActorBase,ActorCausal}.agda`: Lamport partial-order events, actor-local frames, strict-reflecting frame embeddings, basis covers, and a Bool-based non-trivial cover witness. `Concurrency/Sites/ActorPullback.agda` now supplies frame pullbacks and `stability-cover-pullback`; the original `stability-cover-postulate` remains only as a legacy in-file fallback where importing `ActorPullback` would create a cycle.
@@
-**Most load-bearing now:** Hybrid v1 has made R1 statable and inhabited; the next technical hinge is descent/gluing over covers, followed by R4 (how cartesian topos-internal logic talks to the linear/session value layer). The cross-site adjunction still waits on that sheaf/descent maturity.
+**Most load-bearing now:** Hybrid v1 has made R1/R2 statable through restriction, separatedness, frame overlaps, and the probe-form descent layer. The next technical hinge is inhabiting descent with an amalgamation witness, followed by R4 (how cartesian topos-internal logic talks to the linear/session value layer). The cross-site adjunction still waits on that sheaf/descent maturity.
@@
-Hybrid v1 currently implements the presheaf/restriction adapter and separatedness property, not full sheaf descent: session values restrict along actor subviews, and `IsSeparatedPresheaf` states the no-hidden-global-difference condition. Matching families and gluing are future work.
+Hybrid v1 implements the presheaf/restriction adapter and separatedness property, and `Concurrency/Hybrid/Descent.agda` now states the descent layer: matching families, overlap compatibility via frame pullbacks, and amalgamation. Session values restrict along actor subviews, `IsSeparatedPresheaf` states the no-hidden-global-difference condition, and `IsSheafPresheaf` bundles separatedness with amalgamation. What remains future work is inhabiting gluing by proving amalgamation for a concrete presheaf.
@@
 | 2026-05-20 | Hybrid v1 shipped as adapter layer | `Concurrency/Hybrid/Presheaf.agda` provides generic `FramePresheaf`, zero-postulate `IsSeparatedPresheaf`, and `const-presheaf`; `SessionPresheaf.agda` specializes to `Sessions-Cat Payload` and exposes both `const-𝟙ₛ-presheaf` and `const-⊥ₛ-presheaf`. This implements Adapter 1 (restriction) and names future adapter slots without faking descent or a unit/dualizing conversion |
 | 2026-05-21 | Reflexive Protocol Layer named; not implemented | Π = category of protocol versions; protocol edits = morphisms in Π. Promotion (Adapter 5) sharpened with operational role: closed meta-conversation reaching consensus → Π-morphism. Consensus framed as future colimit / coherent amalgamation in a patch-theoretic fragment category, with Pijul as primary implementation-facing candidate; precise categorical shape held open. `Concurrency/Hybrid/Reflexive.agda` reserved as future home. `MO_1` elevated to active roadmap without displacing descent / R4 as the next technical step. Layer is new formal content, compatible with and anticipated by current scaffolds but not already implicit in them |
+| 2026-06-02 | Frame pullbacks and probe-form descent layer shipped | `Concurrency/Sites/ActorPullback.agda` supplies overlap cones for actor-causal frames plus pulled-back covers and `stability-cover-pullback`. `Concurrency/Hybrid/Descent.agda` states probe-form matching families, overlap compatibility, `HasAmalgamation`, and `IsSheafPresheaf` without adding products/equalizers/additives to the thin `StarAutonomous` target. Descent is stated, not yet inhabited |
@@
-Concurrency: none active. First B-side operad, algebra signatures, concrete typed-content `Sessions.agda` instance, actor-causal site v1, and Hybrid v1 presheaf/restriction adapter have shipped. Next substantive work is full descent/gluing over covers, then R4 compatibility and the eventual cross-site adjunction.
+Concurrency: none active. First B-side operad, algebra signatures, concrete typed-content `Sessions.agda` instance, actor-causal site v1, Hybrid v1 presheaf/restriction adapter, frame pullbacks, and probe-form descent statement have shipped. Next substantive work is an amalgamation witness inhabiting descent, then R4 compatibility and the eventual cross-site adjunction.
@@
-Shipped to `agda/Concurrency/Sites/` (both files typecheck under `--cubical --guardedness`):
+Shipped to `agda/Concurrency/Sites/` (current files typecheck under `--cubical --guardedness`):
 
 | File | Role | Line count |
 |------|------|-----------:|
 | `ActorBase.agda` | Opaque unityped `ActorBase` carrier plus Lamport `CausalOrder`; derives `Concurrent` and `≤-bidir-equal` | ~160 |
-| `ActorCausal.agda` | Actor-local frames, strict-reflecting `FrameHom`, frame category laws, basis `Cover`, `sieve-of`, generic identity / transitivity covers, `ActorCausalSite`, `stability-cover-postulate`, and Bool-based non-trivial tiny witness | ~790 |
+| `ActorCausal.agda` | Actor-local frames, strict-reflecting `FrameHom`, frame category laws, basis `Cover`, `sieve-of`, generic identity / transitivity covers, `ActorCausalSite`, legacy in-file `stability-cover-postulate`, and Bool-based non-trivial tiny witness | ~800 |
+| `ActorPullback.agda` | Frame pullback cones for actor-causal overlaps, projection embeddings, pullback squares, pulled-back covers, and downstream `stability-cover-pullback` construction | ~315 |
@@
-`Cover` is basis-form (E1), but `sieve-of` is exposed as the bridge artifact for the future sieve / Grothendieck-topology presentation (E2). The identity and transitivity cover axioms have generic constructions; `stability-cover-postulate` is the sole current actor-site postulate gap.
+`Cover` is basis-form (E1), but `sieve-of` is exposed as the bridge artifact for the future sieve / Grothendieck-topology presentation (E2). The identity and transitivity cover axioms have generic constructions. Pullback stability now has the downstream construction `stability-cover-pullback`; the original `stability-cover-postulate` remains in `ActorCausal.agda` only as a legacy fallback because the construction lives in a downstream file that imports `ActorCausal.agda`.
@@
-Shipped to `agda/Concurrency/Hybrid/` (both files typecheck under `--cubical --guardedness`):
+Shipped to `agda/Concurrency/Hybrid/` (current files typecheck under `--cubical --guardedness`):
 
 | File | Role | Line count |
 |------|------|-----------:|
 | `Presheaf.agda` | Generic Hybrid adapter chassis: `FramePresheaf` valued in any `StarAutonomous` target, zero-postulate `IsSeparatedPresheaf`, and `const-presheaf` | ~250 |
 | `SessionPresheaf.agda` | Sessions specialization: `SessionsV = Sessions-Cat Payload`, `SessionPresheaf`, `IsSeparatedSessionPresheaf`, `const-𝟙ₛ-presheaf`, and `const-⊥ₛ-presheaf` | ~135 |
+| `Descent.agda` | Adapter 2 statement: probe-form `MatchingFamily`, overlap compatibility through actor-frame pullbacks, `HasAmalgamation`, and `IsSheafPresheaf` | ~164 |
@@
-Design constraints held: no operad imports in Hybrid v1, no payloads or roles on actors, no promotion, no matching-family/gluing postulates, and no hidden `𝟙ₛ ↔ ⊥ₛ` conversion. The chassis is parameterized by `ActorBase` rather than the `ActorCausalSite` bundle because v1 uses the frame category and `Cover` basis directly; the bundled site axioms re-enter when descent uses identity/transitivity/stability of covers.
+Design constraints held: no operad imports in Hybrid v1, no payloads or roles on actors, no promotion, no fake gluing postulates, and no hidden `𝟙ₛ ↔ ⊥ₛ` conversion. The chassis is parameterized by `ActorBase` and the descent layer consumes explicit covers plus the `ActorPullback` overlap construction. `IsSheafPresheaf` is still a property to inhabit, not an automatic witness.

diff --git a/workflow/future_work.md b/workflow/future_work.md
--- a/workflow/future_work.md
+++ b/workflow/future_work.md
@@
-2. **Done at v1 scaffold level:** Hybrid integration now has `FramePresheaf` / `SessionPresheaf`, zero-postulate separatedness, and constant `𝟙ₛ` / `⊥ₛ` witnesses. Full sheaf descent is still pending.
+2. **Done at v1 scaffold level:** Hybrid integration now has `FramePresheaf` / `SessionPresheaf`, zero-postulate separatedness, frame pullbacks for overlaps, probe-form descent definitions, and constant `𝟙ₛ` / `⊥ₛ` witnesses. Descent inhabitation is still pending.
@@
-- **Stability without postulate.** `stability-cover-postulate` is the sole actor-site postulate gap. A generic construction needs either pullbacks of `FrameHom`s in the frame category or the future sieve presentation where stability is stated by pulling back covering sieves. Worked concrete sites should replace the postulate with a proof when their topology is known.
+- **Stability adoption cleanup.** `Concurrency/Sites/ActorPullback.agda` now constructs frame pullbacks and proves `stability-cover-pullback`, so the project has a downstream proof of the stability data. `stability-cover-postulate` remains in `ActorCausal.agda` as a legacy in-file fallback because `ActorPullback.agda` imports `ActorCausal.agda` and cannot be imported back without a cycle. A future cleanup may move the tiny-site witness or create a third file importing both if a postulate-free bundled witness is worth the extra structure.
@@
-- **Richer concrete site witnesses.** The Bool tiny-site exercises non-trivial covers but still discharges site stability by the postulate. A future v2 witness should compute pullback stability explicitly against `embed-point false` and `embed-point true`, or against a slightly richer finite causal frame.
+- **Richer concrete site witnesses.** The Bool tiny-site exercises non-trivial covers but still discharges in-file site stability by the legacy postulate. A future v2 witness could live downstream of `ActorPullback.agda` and use `stability-cover-pullback` explicitly against `embed-point false` and `embed-point true`, or against a slightly richer finite causal frame.
@@
-`Concurrency/Hybrid/{Presheaf,SessionPresheaf}.agda` v1 landed the first Hybrid adapter. `Presheaf.agda` is generic over `ActorBase` and a `StarAutonomous` target, defines `FramePresheaf`, exposes `IsSeparatedPresheaf` as a zero-postulate property record over arbitrary probes `X`, and supplies `const-presheaf : Ob → FramePresheaf`. `SessionPresheaf.agda` specializes to `Sessions-Cat Payload` and provides `const-𝟙ₛ-presheaf` and `const-⊥ₛ-presheaf` without introducing a morphism between them.
+`Concurrency/Hybrid/{Presheaf,SessionPresheaf}.agda` v1 landed the first Hybrid adapter. `Presheaf.agda` is generic over `ActorBase` and a `StarAutonomous` target, defines `FramePresheaf`, exposes `IsSeparatedPresheaf` as a zero-postulate property record over arbitrary probes `X`, and supplies `const-presheaf : Ob → FramePresheaf`. `SessionPresheaf.agda` specializes to `Sessions-Cat Payload` and provides `const-𝟙ₛ-presheaf` and `const-⊥ₛ-presheaf` without introducing a morphism between them. `Concurrency/Hybrid/Descent.agda` now adds the second adapter statement: probe-form matching families, overlap compatibility, `HasAmalgamation`, and `IsSheafPresheaf`.
@@
-- **Full descent / gluing.** Matching families, overlap compatibility, and amalgamation are not yet implemented. This is the remaining sheaf half of R1/R2 and the next load-bearing Hybrid step.
-- **`ActorCausalSite` bundle in the API.** v1 only needs `LocalFrame`, `FrameHom`, `frame-id`, `_∘ᶠ_`, and `Cover`, so it is parameterized by `ActorBase`. When descent uses identity/transitivity/stability of covers, the bundled `ActorCausalSite` should become an explicit parameter of the descent layer.
+- **Descent inhabitation / gluing witness.** Matching families, overlap compatibility, and the amalgamation property are now stated, but no concrete presheaf has yet been proved to satisfy amalgamation. This is the remaining sheaf half of R1/R2 and the next load-bearing Hybrid step.
+- **`ActorCausalSite` bundle in the API.** The current descent layer uses the frame category, explicit covers, and explicit overlap pullbacks. If future proofs need identity/transitivity/stability as bundled topology laws rather than direct constructions, the `ActorCausalSite` bundle should become an explicit parameter.
@@
-- **Separatedness witnesses.** `IsSeparatedPresheaf` is defined honestly, but no examples are proved. Constant presheaves are not generally separated over empty-index covers because the empty family of local tests would force arbitrary parallel morphisms into the constant object to be equal. Future options: restrict to inhabited covers, rule out empty covers topologically, or prove separatedness for specific targets/objects.
+- **Separatedness and amalgamation witnesses.** `IsSeparatedPresheaf` and `HasAmalgamation` are defined honestly, but no examples are proved. Constant presheaves are not generally separated over empty-index covers because the empty family of local tests would force arbitrary parallel morphisms into the constant object to be equal. Future options: restrict to inhabited covers, rule out empty covers topologically, or prove separatedness and amalgamation for specific targets/objects.

diff --git a/workflow/targets.md b/workflow/targets.md
--- a/workflow/targets.md
+++ b/workflow/targets.md
@@
-*To restate.* The original modal-partition claim (`♯/♭/ʃ ↔ unityped agents / typed data / protocol shape`) is partially answered by the hybrid construction in `deep_context/arc/02_concurrency_anchor.md`: the ActorBase/SessionValues split is **definitional** (base topology vs sheaf values, with modularity = sheaf gluing). Hybrid v1 has now made the presheaf/restriction half checkable in Agda; full sheaf gluing is still pending. The protocol-shape (`ʃ`) slot still needs work. Original archived.
+*To restate.* The original modal-partition claim (`♯/♭/ʃ ↔ unityped agents / typed data / protocol shape`) is partially answered by the hybrid construction in `deep_context/arc/02_concurrency_anchor.md`: the ActorBase/SessionValues split is **definitional** (base topology vs sheaf values, with modularity = sheaf gluing). Hybrid v1 has now made the presheaf/restriction half checkable in Agda, and `Concurrency/Hybrid/Descent.agda` now states the sheaf-gluing condition. Full gluing awaits an amalgamation witness inhabiting that property. The protocol-shape (`ʃ`) slot still needs work. Original archived.
@@
-- *Operad / hybrid layer (partial — syntax, algebra signatures, Sessions v1, actor site v1, and Hybrid v1 shipped).* The cyclic associative operad `O_1` syntax is in Agda (`Concurrency/Operads/CyclicAssociative.agda`: generator, substitution, cyclic action, sequential + parallel associativity, full cyclic equivariance via `rot-compₒ-a-block` / `rot-compₒ-b-block`, and derived `boundary-swap`; port bookkeeping split across `PortGluing.agda` and `PortRotation.agda`). The algebra interface is also in place (`Concurrency/Algebras/{StarAutonomous,Valuation,OperadAlgebra}.agda`): thin `*`-autonomous target signature, weak HIT valuation into `⊥-par`, and structural Step-2 operad algebra with `plug`, `shift`, and `boundary-swap-structural`. `Concurrency/Algebras/Sessions.agda` instantiates this interface with multiplicative session syntax, an inductive structural `Hom`, a bundled `SessionO1Action`, `session-interp`, `Sessions-Val`, and `Sessions-Alg`. `Concurrency/Sites/{ActorBase,ActorCausal}.agda` supplies the actor-causal base: opaque unityped actors, Lamport event causality, local frames, strict-reflecting `FrameHom`, basis covers, `sieve-of`, `ActorCausalSite`, and a Bool-based non-trivial cover witness. `Concurrency/Hybrid/{Presheaf,SessionPresheaf}.agda` supplies the first adapter layer: generic `FramePresheaf`, zero-postulate `IsSeparatedPresheaf`, generic `const-presheaf`, session specialization to `Sessions-Cat Payload`, and the two constants `const-𝟙ₛ-presheaf` / `const-⊥ₛ-presheaf` with no unit-dualizing conversion. R8 is present with both faces in Agda: syntactic `dual-involutive` and categorical / operadic `boundary-swap-at-gen`; the bridge between them is deliberately deferred to richer session-categorical structure. Still pending: full sheaf/descent over covers, R4 (cartesian-vs-linear interpretation), and then the cross-site adjunction `Allow ⊣ Require`, which instantiates the iteration module against this operadic/session layer.
+- *Operad / hybrid layer (partial — syntax, algebra signatures, Sessions v1, actor site v1, and Hybrid v1 shipped).* The cyclic associative operad `O_1` syntax is in Agda (`Concurrency/Operads/CyclicAssociative.agda`: generator, substitution, cyclic action, sequential + parallel associativity, full cyclic equivariance via `rot-compₒ-a-block` / `rot-compₒ-b-block`, and derived `boundary-swap`; port bookkeeping split across `PortGluing.agda` and `PortRotation.agda`). The algebra interface is also in place (`Concurrency/Algebras/{StarAutonomous,Valuation,OperadAlgebra}.agda`): thin `*`-autonomous target signature, weak HIT valuation into `⊥-par`, and structural Step-2 operad algebra with `plug`, `shift`, and `boundary-swap-structural`. `Concurrency/Algebras/Sessions.agda` instantiates this interface with multiplicative session syntax, an inductive structural `Hom`, a bundled `SessionO1Action`, `session-interp`, `Sessions-Val`, and `Sessions-Alg`. `Concurrency/Sites/{ActorBase,ActorCausal}.agda` supplies the actor-causal base: opaque unityped actors, Lamport event causality, local frames, strict-reflecting `FrameHom`, basis covers, `sieve-of`, `ActorCausalSite`, and a Bool-based non-trivial cover witness; `Concurrency/Sites/ActorPullback.agda` adds frame pullbacks, cover pullback, and downstream `stability-cover-pullback`. `Concurrency/Hybrid/{Presheaf,SessionPresheaf}.agda` supplies the first adapter layer: generic `FramePresheaf`, zero-postulate `IsSeparatedPresheaf`, generic `const-presheaf`, session specialization to `Sessions-Cat Payload`, and the two constants `const-𝟙ₛ-presheaf` / `const-⊥ₛ-presheaf` with no unit-dualizing conversion. `Concurrency/Hybrid/Descent.agda` now states probe-form descent through `MatchingFamily`, `HasAmalgamation`, and `IsSheafPresheaf`. R8 is present with both faces in Agda: syntactic `dual-involutive` and categorical / operadic `boundary-swap-at-gen`; the bridge between them is deliberately deferred to richer session-categorical structure. Still pending: inhabiting descent with an amalgamation witness, R4 (cartesian-vs-linear interpretation), and then the cross-site adjunction `Allow ⊣ Require`, which instantiates the iteration module against this operadic/session layer.
@@
-B-side operadic syntax shipped 2026-05-18 (`Concurrency/Operads/CyclicAssociative.agda`: `O_1` as a cyclic associative HIT with `compₒ-assoc-seq`, `compₒ-assoc-par`, full cyclic equivariance via `rot-compₒ-a-block` / `rot-compₒ-b-block`, and derived `boundary-swap`; `PortRotation.agda` owns rotation-side port bookkeeping). The first algebra layer shipped 2026-05-19: `StarAutonomous.agda` is a thin target signature, `Valuation.agda` names weak HIT interpretations into `⊥-par`, and `OperadAlgebra.agda` adds `plug`/`shift` structural fields plus `boundary-swap-structural`. `Sessions.agda` supplies the first concrete typed-content instance: the syntactic R8 face `dual-involutive`, the categorical / operadic R8 face `boundary-swap-at-gen`, and the explicit `SessionO1Action` assumption whose canonical derivation is deferred. The actor-causal site shipped 2026-05-20 in `Concurrency/Sites/{ActorBase,ActorCausal}.agda`: opaque unityped actors, Lamport causal orders, local frames, strict-reflecting `FrameHom`, basis covers with `sieve-of`, generic identity / transitivity covers, `stability-cover-postulate`, and the Bool-based `two-point-cover` witness. Hybrid v1 shipped the same day in `Concurrency/Hybrid/{Presheaf,SessionPresheaf}.agda`: the generic restriction adapter, safe separatedness property, Sessions specialization, and constant `𝟙ₛ` / `⊥ₛ` witnesses. The active missing bridge is no longer presheaf scaffolding but full sheaf/descent over covers, followed by R4 and the cross-site adjunction.
+B-side operadic syntax shipped 2026-05-18 (`Concurrency/Operads/CyclicAssociative.agda`: `O_1` as a cyclic associative HIT with `compₒ-assoc-seq`, `compₒ-assoc-par`, full cyclic equivariance via `rot-compₒ-a-block` / `rot-compₒ-b-block`, and derived `boundary-swap`; `PortRotation.agda` owns rotation-side port bookkeeping). The first algebra layer shipped 2026-05-19: `StarAutonomous.agda` is a thin target signature, `Valuation.agda` names weak HIT interpretations into `⊥-par`, and `OperadAlgebra.agda` adds `plug`/`shift` structural fields plus `boundary-swap-structural`. `Sessions.agda` supplies the first concrete typed-content instance: the syntactic R8 face `dual-involutive`, the categorical / operadic R8 face `boundary-swap-at-gen`, and the explicit `SessionO1Action` assumption whose canonical derivation is deferred. The actor-causal site shipped 2026-05-20 in `Concurrency/Sites/{ActorBase,ActorCausal}.agda`: opaque unityped actors, Lamport causal orders, local frames, strict-reflecting `FrameHom`, basis covers with `sieve-of`, generic identity / transitivity covers, legacy in-file `stability-cover-postulate`, and the Bool-based `two-point-cover` witness. Frame pullbacks and the descent statement shipped 2026-06-02: `Concurrency/Sites/ActorPullback.agda` supplies overlaps plus downstream `stability-cover-pullback`, and `Concurrency/Hybrid/Descent.agda` states probe-form `MatchingFamily` / `HasAmalgamation` / `IsSheafPresheaf`. The active missing bridge is no longer the descent statement but its inhabitation by an amalgamation witness, followed by R4 and the cross-site adjunction.

diff --git a/workflow/arc.md b/workflow/arc.md
--- a/workflow/arc.md
+++ b/workflow/arc.md
@@
-- `agda/Concurrency/`  — hybrid substrate (actor-causal + session-type values via sheaf; canonical source `deep_context/arc/02_concurrency_anchor.md`) plus the `O_1` operadic interaction layer named on top. Operadic syntax shipped 2026-05-18 in `Concurrency/Operads/{Ports,RawCyclicOperad,PortGluing,PortRotation,CyclicAssociative}.agda` (HIT-by-copy with sequential/parallel associativity and full cyclic equivariance via `rot-compₒ-a-block` / `rot-compₒ-b-block`; boundary-swap is derived). Algebra signatures shipped in `Concurrency/Algebras/{StarAutonomous,Valuation,OperadAlgebra}.agda`: thin `*`-autonomous target, weak HIT valuation, and structural Step-2 operad algebra with `plug`/`shift` and `boundary-swap-structural`. `Sessions.agda` shipped the typed-content instance; `Concurrency/Sites/{ActorBase,ActorCausal}.agda` shipped the actor-causal locality leg. Hybrid v1 shipped the first adapter layer in `Concurrency/Hybrid/{Presheaf,SessionPresheaf}.agda`: generic frame presheaves valued in any `StarAutonomous` target, safe separatedness as a property record, session specialization to `Sessions-Cat Payload`, and constant `𝟙ₛ` / `⊥ₛ` witnesses without a unit-dualizing conversion. SessionValues + ActorBase separation is now checkable at the presheaf/restriction level; full sheaf descent remains the next bridge.
+- `agda/Concurrency/`  — hybrid substrate (actor-causal + session-type values via sheaf; canonical source `deep_context/arc/02_concurrency_anchor.md`) plus the `O_1` operadic interaction layer named on top. Operadic syntax shipped 2026-05-18 in `Concurrency/Operads/{Ports,RawCyclicOperad,PortGluing,PortRotation,CyclicAssociative}.agda` (HIT-by-copy with sequential/parallel associativity and full cyclic equivariance via `rot-compₒ-a-block` / `rot-compₒ-b-block`; boundary-swap is derived). Algebra signatures shipped in `Concurrency/Algebras/{StarAutonomous,Valuation,OperadAlgebra}.agda`: thin `*`-autonomous target, weak HIT valuation, and structural Step-2 operad algebra with `plug`/`shift` and `boundary-swap-structural`. `Sessions.agda` shipped the typed-content instance; `Concurrency/Sites/{ActorBase,ActorCausal}.agda` shipped the actor-causal locality leg, with `Concurrency/Sites/ActorPullback.agda` now supplying frame overlaps and downstream cover stability. Hybrid v1 shipped the first adapter layer in `Concurrency/Hybrid/{Presheaf,SessionPresheaf}.agda`: generic frame presheaves valued in any `StarAutonomous` target, safe separatedness as a property record, session specialization to `Sessions-Cat Payload`, and constant `𝟙ₛ` / `⊥ₛ` witnesses without a unit-dualizing conversion. `Concurrency/Hybrid/Descent.agda` now states probe-form descent (`MatchingFamily`, `HasAmalgamation`, `IsSheafPresheaf`). SessionValues + ActorBase separation is checkable through restriction, separatedness, and descent definitions; a concrete amalgamation witness remains the next bridge.
~~~

### Notes for Application

- The proposed wording intentionally says `stability-cover-postulate` is superseded downstream, not deleted.
- The proposed wording intentionally says descent is stated, not proved for a concrete presheaf.
- If future code changes add an actual amalgamation witness before these docs are applied, update the proposed wording first rather than applying it mechanically.
- The untracked `workflow/deep_context/decision_actorpullback_descent.md` and `communication/*` files are outside this proposal.
