# Hybrid intro - restriction before sheaves

The Hybrid folder is the first place where the two Concurrency legs are put in contact.

The earlier folders did three separate jobs:

- Operads described interaction shape.
- Algebras interpreted that shape in typed content.
- Sites described actor-local frames and covers.

The Hybrid folder is the adapter layer between actor locality and typed session content. It is not yet "the sheaf theory of the project." The current files deliberately start with the smallest adapter that is already meaningful: restriction along sub-views of actor frames.

## The Main Picture

A local actor frame is a partial view of a distributed situation. A presheaf over those frames assigns some typed content to each view.

If a smaller frame embeds into a larger frame, typed content over the larger frame can be restricted to typed content over the smaller frame. That is the direction reversal:

```text
smaller frame G  ->  larger frame F

value F          ->  value G
```

The frame morphism goes from small to large. The content morphism goes from large to small. This is the usual contravariant behavior of a presheaf.

> **References**
> - [nLab: presheaf](https://ncatlab.org/nlab/show/presheaf) - the general categorical pattern: assign data to objects, restrict data along arrows in the opposite direction.
> - [nLab: site](https://ncatlab.org/nlab/show/site) - the setting where covers are available and sheaf conditions can later be stated.

## Adapter 1: Restriction

`Presheaf.agda` implements Adapter 1.

For every local frame `F`, a `FramePresheaf` gives:

```agda
value F
```

This is an object in some target `StarAutonomous` category. In the session specialization, that object will be a session type.

For every frame embedding `G ↪ F`, it gives:

```agda
Hom (value F) (value G)
```

Read this as: "content known on the larger view can be restricted to content known on the smaller view."

The record also says restriction respects identity and composition. Restricting along the identity view does nothing. Restricting along two nested sub-views is the same as restricting in two steps.

## Separatedness Is Not Full Gluing

The file also defines `IsSeparatedPresheaf`.

Separatedness says local equality detects global equality. Suppose `F` is covered by patches, and suppose we have two candidate pieces of content over `F`. If the two candidates become equal after restriction to every patch, then they were already equal over `F`.

That is only the uniqueness half of sheaf descent. It does not say that compatible patchwise content can be glued into global content. It only says that if a global content exists, it is determined by all of its local restrictions.

> **References**
> - [nLab: separated presheaf](https://ncatlab.org/nlab/show/separated+presheaf) - the "local equality implies global equality" half of the sheaf condition.
> - [nLab: sheaf](https://ncatlab.org/nlab/show/sheaf) - full sheaf descent also includes existence of glued global sections.

This distinction matters here. The current category signature is intentionally thin. It does not yet contain the richer cut/evaluation machinery that would make the full gluing story honest. So the Agda file records the part it can state cleanly now.

## Why The Generic File Uses `ActorBase`

`Presheaf.agda` takes an `ActorBase`, not the whole `ActorCausalSite`.

That is a precise dependency choice. Adapter 1 needs:

- local frames;
- frame morphisms;
- identity and composition of frame morphisms;
- basis covers, for the separatedness property.

It does not yet use identity covers, transitivity of covers, or stability under pullback. Those are site axioms. Full descent will need them. Restriction alone does not.

So the file keeps its inputs honest: it asks only for the actor base and imports the frame/category/cover constructions built from it.

## The Session Specialization

`SessionPresheaf.agda` specializes the generic presheaf chassis to the target category:

```agda
Sessions-Cat Payload
```

That gives the project a name for "session-valued presheaf over actor frames."

It also provides two constant examples:

- `const-𝟙ₛ-presheaf`: every frame gets the tensor unit, read as no demanded interaction;
- `const-⊥ₛ-presheaf`: every frame gets the dualizing object, matching the valuation/algebra codomain.

Both are useful. Neither is declared to be the one true constant presheaf. A star-autonomous category relates `𝟙` and `⊥` by duality, but it does not automatically give a canonical morphism between them. Any such bridge is a future adapter.

## What Is Deferred

The Hybrid header names several future adapters:

- descent / gluing;
- a unit-to-dualizing bridge;
- lifting operadic valuation to presheaves;
- promotion of a completed conversation into a new actor;
- the cross-site modal adapter;
- an explicit no-leak / erasure principle.

They are named so the architecture has a map. They are not implemented here. The two current files implement restriction and the separatedness property, then instantiate restriction for sessions.

## Reading Order

Read:

1. `00_hybrid_intro.md` - this file.
2. `01_presheaf.md` - the generic frame-presheaf adapter.
3. `02_sessionpresheaf.md` - the session-valued specialization and its two constants.

After this folder, the current Concurrency track is complete at the pedagogy level.
