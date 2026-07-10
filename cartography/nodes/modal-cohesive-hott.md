---
id: modal-cohesive-hott
label: "the modal / cohesive homotopy-type-theory leg"
kind: concept
tags: [conjecture, implementation]
sources:
  - "Lawvere, axiomatic cohesion"
  - "Schreiber–Shulman, cohesive homotopy type theory (arXiv:1408.0054)"
  - "Corfield, Modal Homotopy Type Theory (2020)"
---

The formal-foundation side: contexts and their multiplicity of perspectives encoded
as modal homotopy type theory — specifically the internal language of a cohesive
(∞,1)-topos with its adjoint modalities (shape ⊣ flat ⊣ sharp). We follow Lawvere's
axiomatic cohesion and the cohesive-HoTT of Schreiber–Shulman, with Corfield's
*Modal Homotopy Type Theory* supplying the philosophical warrant for using it as a
"logic of contexts". In the codebase this is the ModalHoTT development (currently
paused at the de Rham named-coefficient stage). It supplies the left-hand site of
[cross-site-adjunction].
