# Archived items replaced by the list of "layers of complexity" coming from \*/arc/07\* and \*/arc/08\*

## Regarding the Reflexive Protocol Layer

Named on 2026-05-21 in `workflow/status.md` and `deep_context/arc/07_self-modifying_protocol.md`. Not implemented; documented here so the trigger conditions and the relationship to current scaffolds are explicit.

**The structure.** Protocols themselves form objects of a small category Π. A protocol edit is a morphism in Π. Ordinary conversations are indexed by the active object of Π at their start. A *meta-conversation* is a conversation whose role is to inspect the current protocol and propose edits; on consensus, it emits a Π-morphism. Past events stay under the protocol active at the time of their occurrence — non-retroactivity is enforced by `FrameHom`'s strict causality reflection in `ActorCausal.agda`, which already makes retroactive rewriting structurally impossible.

**Why it is new formal content, even though current scaffolds anticipate it.** The current Agda code was designed to receive this layer — `ActorCausal` blocks promotion as `FrameHom`; `Sessions` defers conversation-of-conversations to `MO_1`; `Hybrid/Presheaf` names Promotion as Adapter 5 — but nothing in the formalisation contains protocol versions, edit morphisms, or version-indexing. The layer is compatible with the scaffolds and anticipated by them, not already implicit in them. Treating it as already-implicit would overstate what the math has done.

**Consensus.** Edit proposals from inside a meta-conversation form a diagram in a future *patch-theoretic fragment category*; consensus is intended to become colimit / existence of coherent amalgamation in that category. **Pijul is the primary implementation-facing candidate** (see "Regarding Pijul" below); the precise categorical encoding — category, double category, event structure, adhesive category, partial-commutation presentation — is held open until the candidate is examined honestly. Inconsistent proposals (a diagram without coherent amalgamation) give the framework an honest formal counterpart of "the protocol cannot be coherently edited from here," surfacing a real engineering failure mode rather than papering over it.

**Self-scanning.** "Regular-interval meta-conversations" maps naturally onto modal iteration on the A side, but the formalised iteration in `ModalHoTT/Modalities/Iteration.agda` + `IterationCohesion.agda` lands only the first-level collapse `T A ≃ T(T A)`, not the dimension-raising cyclic bar construction the cross-site recursion needs. So self-scanning is the operational interpretation of that *future* recursion, not of the currently shipped iteration scaffold.

**Trigger for opening `Concurrency/Hybrid/Reflexive.agda` v0.** Both conditions required: (a) descent / R4 stable enough that the Hybrid chassis is not moving under the new layer; (b) the fragment-category candidate honest enough to state in Agda — minimum, a chosen object class for edit proposals, a chosen morphism class, and a stated compatibility condition for which colimit-existence is meaningful.

**Roadmap impact.**

- `MO_1` / modular envelope: elevated from "held loose, long-horizon" to "active roadmap." Does *not* displace descent / R4 as the immediate next step; the elevation means `MO_1` becomes the natural next slot once the Hybrid/descent/R4 bridge is stable enough to support modular-envelope work. The cross-site adjunction `Allow ⊣ Require` and the bar-construction comparison remain downstream.
- B-side dual of T_recursion iteration (currently deferred until `ND` has non-trivial content, per the T_recursion entry above): becomes statable once the reflexive layer gives `ND` operational meaning.
- Pask-style human-implementation layer (held loose in `status.md`): becomes the operational reading of the Reflexive layer; still speculative until `MO_1` lands, but no longer floating without a formal home.

**Pieces deferred inside the Reflexive layer itself.**

- The precise definition of Π. The smallest honest version is a thin category whose objects are *protocol-versions-as-records* and whose morphisms are *primitive-edit operations*. Whether Π is a 1-category, a 2-category, or a higher structure depends on whether protocol edits compose strictly or up to coherent equivalence — and that depends on the fragment-category choice.
- The forgetful functor `Π → HybridStructure`. Each Π-object should recover a Hybrid configuration (a site + a session-target + a presheaf chassis); the functor's variance and the level of preservation it commits to are open.
- The temporal site combining the actor-causal site with version-indexing. A frame-at-a-version is the natural object; the morphisms split into intra-version `FrameHom` and inter-version protocol-edit lifts.
- The consensus mechanism's *implementation* — how a meta-conversation actually arrives at the colimit / amalgamation in practice, beyond the mathematical statement that the colimit exists.

## Regarding Pijul / patch-based protocol semantics

Pijul's patch/change model is a useful implementation-facing reference for the future conversation-of-conversations protocol, but not current Hybrid v1 scope. The relevant ideas to preserve are:

- patches / changes as first-class protocol events or document transformations;
- dependencies as causal-order data;
- commutation of independent changes as the operational face of concurrency;
- conflicts as explicit gluing obstructions;
- resolutions as typed repair events;
- partial clones as local views / restrictions.

This thread should return after the first descent interface exists, not merely after Hybrid v1's presheaf scaffold. A possible future artifact is a small `Concurrency/Hybrid/PatchProtocol.agda`-style module or implementation note explaining how an event-log / patch-log backend could realize the actor-causal site operationally. If contacting Pijul maintainers ever becomes useful, do it with a small technical note and ask for feedback on the patch-theoretic reading rather than proposing a broad collaboration upfront.