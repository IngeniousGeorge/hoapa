# The Icosahedral Transfer Operator — Stage 2

## Flow-Mode Enrichment: From Undifferentiated Chirality to Directed Metabolism

---

*This document continues the construction begun in the Stage 1 specification. It assumes the reader has that document and its computational results: a 60-state transfer operator with critical exponent s* ≈ 0.976, uniform Gibbs measure, 17 chiral eigenvalue pairs, and no triangle/quartet differentiation. Stage 2 introduces directed flow-modes to test whether the undifferentiated chirality of Stage 1 organizes into the specific metabolic architecture the framework predicts.*

---

## 0. What Stage 1 Established and What Remains

Stage 1 produced three results:

1. **s* ≈ 0.976.** The icosahedron has a non-trivial critical exponent under its geodesic potential. The healthy balance between exploration and return is close to — but not exactly — full forward commitment.

2. **Uniform Gibbs measure.** At the critical point, all 60 states carry equal weight. This confirms the isotropy claim: health is the equal dignity of all aspects.

3. **17 chiral pairs.** More than half the eigenvalues are complex. The icosahedron circulates richly. But the circulation is undifferentiated — no preferred axis, no distinction between self-directed and environment-directed flow.

What Stage 1 did *not* produce: triangle decomposition, quartet clustering, or any spectral signature of the metabolic axis. These are the framework's specific structural predictions, and they require specific structural input — namely, the two directed flows and their interface.

Stage 2 adds this input and tests whether the predictions survive.

---

## 1. The Enriched State Space

### 1.1 Definition

A state is now a triple **(V, T, f)** where:
- V is a vertex (current position), V ∈ {1, ..., 12}
- T is a target at distance 2 from V, T ∈ D₂(V)
- f is a flow-mode, f ∈ {S, E} (self-mode or environment-mode)

There are 60 × 2 = **120 states**.

```python
FLOW_S = 'S'  # self-mode
FLOW_E = 'E'  # environment-mode

enriched_states = []
enriched_index = {}
for v in range(1, 13):
    for t in TARGETS[v]:
        for f in [FLOW_S, FLOW_E]:
            idx = len(enriched_states)
            enriched_states.append((v, t, f))
            enriched_index[(v, t, f)] = idx

N_enriched = len(enriched_states)
assert N_enriched == 120
```

### 1.2 What the Flow-Mode Encodes

The flow-mode is not a position or a direction. It is a **disposition** — a bias in how the system selects its next target. In self-mode, the system tends toward the self-triangle's cycle. In environment-mode, it tends toward the environment-triangle's cycle.

The biological analogy is precise: an organism in "exploitation mode" (foraging a known food source) makes different decisions than the same organism in "exploration mode" (scanning for new resources), even when it is at the same location facing the same options. The flow-mode is the internal state that contextualizes the external situation (Friston, 2010; Hills et al., 2015).

In the framework's language: the flow-mode encodes whether the current targeting is in service of the self-triangle's metabolic cycle (autonomy → freedom → complexity → design → work → energy) or the environment-triangle's receptive cycle (mystery → horizons → recursion → evolution → creativity → infinity). Both cycles operate on the same 12 vertices; they differ in *which* vertices are preferred as targets and in the *direction* of flow.

---

## 2. The Triangle Membership Asymmetry

Before defining transitions, we need a structural fact that was computed in the Stage 1 document (Section 5.2) and is now central.

For each vertex V, its 5 distance-2 targets split unevenly between the two triangles:

```python
SELF_TRIANGLE = {3, 7, 8, 9, 10, 12}
ENV_TRIANGLE = {1, 2, 4, 5, 6, 11}

def triangle_split(v):
    """How many targets of v are on Self vs Environment triangle."""
    tgts = TARGETS[v]
    n_self = len([t for t in tgts if t in SELF_TRIANGLE])
    n_env = len([t for t in tgts if t in ENV_TRIANGLE])
    return n_self, n_env

# Precompute
for v in range(1, 13):
    ns, ne = triangle_split(v)
    tri = "Self" if v in SELF_TRIANGLE else "Env"
    print(f"Vertex {v:2d} ({tri}): {ns}S, {ne}E targets")
```

The result (from Stage 1):

| Vertex | Own triangle | Targets on Self | Targets on Env |
|--------|-------------|-----------------|----------------|
| 1 (infinity) | Env | 4 | 1 |
| 2 (creativity) | Env | 2 | 3 |
| 3 (freedom) | Self | 3 | 2 |
| 4 (mystery) | Env | 2 | 3 |
| 5 (horizons) | Env | 4 | 1 |
| 6 (evolution) | Env | 4 | 1 |
| 7 (energy) | Self | 3 | 2 |
| 8 (autonomy) | Self | 1 | 4 |
| 9 (complexity) | Self | 1 | 4 |
| 10 (design) | Self | 3 | 2 |
| 11 (recursion) | Env | 2 | 3 |
| 12 (work) | Self | 1 | 4 |

The **open metabolism pattern**: vertices on the self-triangle predominantly target the environment-triangle, and vice versa. Vertices 8 (autonomy), 9 (complexity), and 12 (work) — the "active core" of the self-cycle — have 4 out of 5 targets on the environment side. Vertices 1 (infinity), 5 (horizons), 6 (evolution) — the "receptive core" of the environment-cycle — have 4 out of 5 targets on the self side.

This means **mode coherence is structurally costly**. A self-mode vertex wanting to stay in self-mode has fewer options (often only 1 out of 5 targets) than a self-mode vertex willing to cross into the environment. The coherence bonus must work against this structural asymmetry. This tension — between the flow-mode's preference and the graph's cross-wiring — is where the interesting spectral structure should emerge.

In the framework's terms: the two triangles are not self-contained loops. They are open systems that *require* engagement with the other side. The self-cycle's active vertices (work, autonomy, complexity) inherently reach outward. The environment-cycle's receptive vertices (infinity, horizons, evolution) inherently reach inward. This is autopoiesis in its precise sense (Maturana & Varela, 1980): self-production through exchange with the exterior, not through self-enclosure.

---

## 3. Transition Rules

### 3.1 The Three Weight Factors

From state (V₁, T₁, f₁), the system transitions to state (T₁, T₂, f₂). Each transition carries a weight that is the product of three factors:

**Factor 1: Directional preference (from Stage 1).**

Same as before — based on dist(T₂, anti(V₁)):

| dist(T₂, anti(V₁)) | Class | Weight |
|---------------------|-------|--------|
| 1 | Forward | e^{−s·α} |
| 2 | Partial reverse | e^{−s·β} |
| 3 | Reverse | e^{−s·γ} |

At the geodesic point: (α, β, γ) = (θ₁, θ₂, θ₃).

**Factor 2: Mode coherence.**

If the target T₂ is on the triangle that matches the current flow-mode f₁, the transition is mode-coherent. Otherwise, it is mode-incoherent.

| f₁ | T₂ on Self | T₂ on Env |
|----|-----------|-----------|
| S | coherent (weight = c) | incoherent (weight = 1) |
| E | incoherent (weight = 1) | coherent (weight = c) |

Here c ≥ 1 is the **coherence bonus** parameter. At c = 1, there is no mode preference (equivalent to Stage 1 duplicated). As c increases, the system increasingly prefers mode-coherent targets.

Note: the incoherent weight is 1, not 1/c. This is a deliberate asymmetry — coherence is rewarded, but incoherence is not punished. This reflects the framework's principle that the two triangles are not in competition; they are complementary metabolic cycles. Engaging with the "other" triangle is not wrong; it is simply not mode-aligned.

**Factor 3: Mode persistence and metabolic switching.**

The flow-mode can change only at specific vertices — the **metabolic axis** {2 (creativity), 10 (design)}. At all other vertices, the mode persists: f₂ = f₁.

| T₁ | Allowed f₂ |
|----|-----------|
| T₁ ∈ {2, 10} | f₂ ∈ {S, E} (both modes available) |
| T₁ ∉ {2, 10} | f₂ = f₁ (mode persists) |

When mode switching is available (at vertices 2 and 10), the weight of staying in the same mode versus switching is governed by a **switching cost** parameter μ ≥ 0:

- Same mode (f₂ = f₁): weight factor = 1
- Switch mode (f₂ ≠ f₁): weight factor = e^{−μ}

At μ = 0, switching is free — the metabolic axis is fully permeable. As μ increases, switching becomes costly — the two modes decouple.

### 3.2 The Complete Weight Formula

The total weight of the transition (V₁, T₁, f₁) → (T₁, T₂, f₂) is:

```
w = w_dir × w_coh × w_switch
```

where:
- w_dir = exp(−s · θ_d) with d = dist(T₂, anti(V₁)) and θ_d the corresponding angle
- w_coh = c if T₂ is mode-coherent with f₁, else 1
- w_switch = 1 if f₂ = f₁, or exp(−μ) if f₂ ≠ f₁ (only relevant when T₁ ∈ {2, 10})

### 3.3 Implementation

```python
METABOLIC_AXIS = {2, 10}

def build_enriched_matrix(s, alpha, beta, gamma, coherence, mu,
                          states_e, index_e, targets, antipodes):
    """
    Build the 120x120 transfer matrix with flow-modes.

    Parameters:
        s: float — inverse temperature / scaling exponent
        alpha, beta, gamma: float — distance-class weights
        coherence: float >= 1 — mode coherence bonus
        mu: float >= 0 — metabolic switching cost
        states_e: list of (v, t, f) triples
        index_e: dict mapping (v, t, f) -> index
        targets: dict mapping v -> list of distance-2 vertices
        antipodes: dict mapping v -> antipodal vertex
    """
    N = len(states_e)
    M = np.zeros((N, N))

    for i, (v1, t1, f1) in enumerate(states_e):
        anti_v1 = antipodes[v1]

        for t2 in targets[t1]:
            # Factor 1: Directional preference
            d = DIST[t2][anti_v1]
            if d == 1:
                w_dir = np.exp(-s * alpha)
            elif d == 2:
                w_dir = np.exp(-s * beta)
            else:
                w_dir = np.exp(-s * gamma)

            # Factor 2: Mode coherence
            t2_on_self = (t2 in SELF_TRIANGLE)
            if (f1 == FLOW_S and t2_on_self) or (f1 == FLOW_E and not t2_on_self):
                w_coh = coherence
            else:
                w_coh = 1.0

            # Factor 3: Mode switching
            if t1 in METABOLIC_AXIS:
                allowed_modes = [FLOW_S, FLOW_E]
            else:
                allowed_modes = [f1]

            for f2 in allowed_modes:
                # Switching cost
                if f2 == f1:
                    w_switch = 1.0
                else:
                    w_switch = np.exp(-mu)

                j = index_e[(t1, t2, f2)]
                M[i, j] += w_dir * w_coh * w_switch

    return M
```

### 3.4 Sanity Checks

```python
# At coherence=1, mu=0, and for each s, the enriched matrix should
# be equivalent to the base matrix duplicated (each block identical).
M_base = build_weighted_matrix(s_star, ...)  # 60x60 from Stage 1
M_enr = build_enriched_matrix(s_star, THETA_1, THETA_2, THETA_3,
                               coherence=1.0, mu=0.0, ...)  # 120x120

# The 120x120 should have a block structure:
# M_enr = [[M_base, 0], [0, M_base]] (approximately)
# ... except at metabolic vertices where cross-block transitions exist.

# At minimum: same spectral radius
rho_base = max(abs(np.linalg.eigvals(M_base)))
rho_enr = max(abs(np.linalg.eigvals(M_enr)))
print(f"Base spectral radius: {rho_base:.6f}")
print(f"Enriched spectral radius (c=1, mu=0): {rho_enr:.6f}")
# These should be very close (equal if metabolic switching is symmetric)
```

---

## 4. The Parameter Space

Stage 2 introduces two new parameters beyond Stage 1:

| Parameter | Symbol | Range | Meaning |
|-----------|--------|-------|---------|
| Inverse temperature | s | [0, ∞) | Exploration-return balance |
| Coherence bonus | c | [1, ∞) | Mode preference strength |
| Switching cost | μ | [0, ∞) | Metabolic permeability |

Plus the three distance-class weights (α, β, γ), which can be fixed at the geodesic point or explored freely.

### 4.1 Primary Exploration: The (c, μ) Plane at s = s*

The most informative first computation: fix s at the Stage 1 critical exponent s* ≈ 0.976, fix (α, β, γ) at the geodesic values, and explore the (coherence, μ) plane.

```python
coherence_values = np.linspace(1.0, 10.0, 50)
mu_values = np.linspace(0.0, 5.0, 50)

results = {}
for c in coherence_values:
    for mu in mu_values:
        M = build_enriched_matrix(s_star, THETA_1, THETA_2, THETA_3,
                                   c, mu, enriched_states, enriched_index,
                                   TARGETS, ANTIPODES)
        eigenvalues = np.linalg.eigvals(M)

        # Spectral radius
        rho = np.max(np.abs(eigenvalues))

        # Count complex eigenvalues
        n_complex = np.sum(np.abs(eigenvalues.imag) > 1e-10)

        # Leading eigenvector
        idx_lead = np.argmax(np.abs(eigenvalues))
        gibbs = np.abs(np.linalg.eig(M)[1][:, idx_lead])
        gibbs /= gibbs.sum()

        # Triangle projections of Gibbs measure
        self_weight = sum(gibbs[i] for i, (v, t, f) in enumerate(enriched_states)
                         if v in SELF_TRIANGLE)
        env_weight = sum(gibbs[i] for i, (v, t, f) in enumerate(enriched_states)
                         if v in ENV_TRIANGLE)

        # Mode projections of Gibbs measure
        s_mode_weight = sum(gibbs[i] for i, (v, t, f) in enumerate(enriched_states)
                           if f == FLOW_S)
        e_mode_weight = sum(gibbs[i] for i, (v, t, f) in enumerate(enriched_states)
                           if f == FLOW_E)

        results[(c, mu)] = {
            'rho': rho,
            'n_complex': n_complex,
            'self_weight': self_weight,
            'env_weight': env_weight,
            's_mode_weight': s_mode_weight,
            'e_mode_weight': e_mode_weight,
        }
```

### 4.2 What to Look For in the (c, μ) Plane

**Region 1: c ≈ 1, μ ≈ 0 (no mode structure).** The two modes are interchangeable and freely permeable. This should reproduce Stage 1 results: uniform Gibbs measure, undifferentiated chirality. The enrichment adds nothing.

**Region 2: c >> 1, μ ≈ 0 (strong coherence, free switching).** The system strongly prefers mode-coherent targets but can switch modes easily at the metabolic axis. This is where the triangle decomposition should first appear: eigenvectors concentrating on one triangle, with the metabolic axis as a coupling channel. If the Gibbs measure becomes non-uniform here, with weight concentrating on mode-coherent states, this confirms that the triangle structure emerges from the coherence preference.

**Region 3: c >> 1, μ >> 1 (strong coherence, costly switching).** The two modes are both strongly self-preferring and weakly coupled. This is the **fragmented** regime — two nearly independent subsystems, each circulating in its own triangle, barely communicating. The spectral gap between the two near-invariant subspaces should be small. In the framework's language, this is a dissociated point of view: self-processing and environment-processing are both active but not integrated.

**Region 4: c ≈ 1, μ >> 1 (no coherence preference, costly switching).** The system has no mode preference but cannot easily change mode. This is a curious regime: the modes are meaningless (no coherence advantage) but sticky (hard to switch). It should behave similarly to Stage 1.

**The critical question:** Is there a region where the Gibbs measure is both *non-uniform* (showing triangle structure) and *balanced* (neither triangle dominates)? This would be the **healthy integrated** regime — distinct self and environment processing that are equally weighted and metabolically coupled. In the framework's language, this is the difference between having two functional subsystems and being dominated by one of them.

### 4.3 The Critical Surface in (s, c, μ) Space

For a more complete picture, also compute the critical exponent s*(c, μ) — the value of s where ρ(s) = 1 — at each point in the (c, μ) plane.

```python
from scipy.optimize import brentq

def find_critical_s(c, mu, s_min=0.01, s_max=20.0):
    """Find s* where spectral radius = 1 for given (c, mu)."""
    def f(s):
        M = build_enriched_matrix(s, THETA_1, THETA_2, THETA_3,
                                   c, mu, enriched_states, enriched_index,
                                   TARGETS, ANTIPODES)
        return np.max(np.abs(np.linalg.eigvals(M))) - 1.0
    try:
        return brentq(f, s_min, s_max)
    except ValueError:
        return np.nan  # no zero in range
```

Plot s*(c, μ) as a surface or contour map. Does the critical exponent change significantly with the mode structure parameters? If s* is insensitive to c and μ, the health exponent is determined by the geometry alone and the mode structure is a refinement. If s* varies strongly, the mode structure participates in setting the fundamental balance.

---

## 5. Spectral Decomposition Analysis

### 5.1 Eigenvector Projections

For each eigenvector, compute four projections:

```python
def analyze_eigenvector(eigvec, enriched_states):
    """Compute structural projections of an eigenvector."""
    probs = np.abs(eigvec)**2
    probs /= probs.sum()

    # Triangle projection (by current vertex)
    self_proj = sum(probs[i] for i, (v, t, f) in enumerate(enriched_states)
                    if v in SELF_TRIANGLE)
    env_proj = sum(probs[i] for i, (v, t, f) in enumerate(enriched_states)
                   if v in ENV_TRIANGLE)

    # Mode projection
    s_mode_proj = sum(probs[i] for i, (v, t, f) in enumerate(enriched_states)
                      if f == FLOW_S)
    e_mode_proj = sum(probs[i] for i, (v, t, f) in enumerate(enriched_states)
                      if f == FLOW_E)

    # Quartet projections (by current vertex)
    quartet_projs = {}
    for name, qset in QUARTETS.items():
        quartet_projs[name] = sum(probs[i] for i, (v, t, f)
                                  in enumerate(enriched_states) if v in qset)

    # Metabolic axis weight (vertices 2 and 10)
    metab_proj = sum(probs[i] for i, (v, t, f) in enumerate(enriched_states)
                     if v in METABOLIC_AXIS)

    return {
        'self_triangle': self_proj,
        'env_triangle': env_proj,
        'self_mode': s_mode_proj,
        'env_mode': e_mode_proj,
        'quartets': quartet_projs,
        'metabolic_axis': metab_proj,
        'triangle_asymmetry': abs(self_proj - env_proj),
        'mode_asymmetry': abs(s_mode_proj - e_mode_proj),
    }
```

### 5.2 Chiral Pair Analysis

For each complex conjugate eigenvalue pair (λ, λ̄), the two eigenvectors encode counter-rotating modes. Analyze whether these pairs are *triangle-aligned*:

```python
def analyze_chiral_pairs(eigenvalues, eigenvectors, enriched_states):
    """Identify chiral pairs and their triangle alignment."""
    pairs = []
    used = set()

    for i in range(len(eigenvalues)):
        if i in used or np.abs(eigenvalues[i].imag) < 1e-10:
            continue
        # Find conjugate partner
        for j in range(i+1, len(eigenvalues)):
            if j in used:
                continue
            if np.abs(eigenvalues[i] - np.conj(eigenvalues[j])) < 1e-10:
                used.add(i)
                used.add(j)

                # Analyze the pair
                ev1 = eigenvectors[:, i]
                ev2 = eigenvectors[:, j]
                a1 = analyze_eigenvector(ev1, enriched_states)
                a2 = analyze_eigenvector(ev2, enriched_states)

                pairs.append({
                    'eigenvalue': eigenvalues[i],
                    'magnitude': abs(eigenvalues[i]),
                    'phase': np.angle(eigenvalues[i]),
                    'mode_asymmetry_1': a1['mode_asymmetry'],
                    'mode_asymmetry_2': a2['mode_asymmetry'],
                    'triangle_asymmetry_1': a1['triangle_asymmetry'],
                    'triangle_asymmetry_2': a2['triangle_asymmetry'],
                    'metabolic_weight_1': a1['metabolic_axis'],
                    'metabolic_weight_2': a2['metabolic_axis'],
                })
                break

    return sorted(pairs, key=lambda p: -p['magnitude'])
```

**What to look for:**

- **Triangle-aligned chiral pairs:** pairs where one eigenvector concentrates on the self-triangle and the other on the environment-triangle. These would be the direct spectral signature of the two counter-rotating metabolic cycles.

- **Mode-aligned chiral pairs:** pairs where one eigenvector concentrates in self-mode and the other in environment-mode. Since mode and triangle are correlated (self-mode prefers self-triangle targets), these may coincide with triangle-aligned pairs.

- **Phase structure:** Do the dominant chiral pairs have phases near ±2π/6 ≈ ±1.047 radians? This would correspond to the 6-fold periodicity of the triangle cycles. Phases near ±2π/5 ≈ ±1.257 would correspond to the 5-fold neighbor structure. Other phases would indicate emergent periodicities not directly matching either obvious structure.

- **Metabolic mixing modes:** eigenvectors (real or complex) that concentrate weight on the metabolic axis (vertices 2 and 10). These are the modes that couple the two triangles — the spectral signature of the creativity-design interface.

### 5.3 The Block Structure Test

The most direct test of triangle decomposition: does the 120×120 matrix have approximate block structure in a basis sorted by flow-mode?

```python
def check_block_structure(M, enriched_states):
    """
    Reorder the matrix so that S-mode states come first,
    then E-mode states. Check the off-diagonal block norms.
    """
    s_indices = [i for i, (v, t, f) in enumerate(enriched_states) if f == FLOW_S]
    e_indices = [i for i, (v, t, f) in enumerate(enriched_states) if f == FLOW_E]
    order = s_indices + e_indices
    M_reordered = M[np.ix_(order, order)]

    n_s = len(s_indices)  # should be 60

    # Four blocks
    SS = M_reordered[:n_s, :n_s]          # self -> self
    SE = M_reordered[:n_s, n_s:]          # self -> env
    ES = M_reordered[n_s:, :n_s]          # env -> self
    EE = M_reordered[n_s:, n_s:]          # env -> env

    # Block norms
    norm_SS = np.linalg.norm(SS, 'fro')
    norm_SE = np.linalg.norm(SE, 'fro')
    norm_ES = np.linalg.norm(ES, 'fro')
    norm_EE = np.linalg.norm(EE, 'fro')

    # Coupling ratio: off-diagonal / diagonal
    coupling = (norm_SE + norm_ES) / (norm_SS + norm_EE)

    return {
        'norm_SS': norm_SS, 'norm_SE': norm_SE,
        'norm_ES': norm_ES, 'norm_EE': norm_EE,
        'coupling_ratio': coupling,
    }
```

A coupling ratio near 0 means the two modes are decoupled (fragmented). A coupling ratio near 1 means the modes are fully mixed (no differentiation). The healthy regime should be somewhere in between — distinct but coupled.

Track the coupling ratio across the (c, μ) plane to map the transition from integrated to fragmented.

---

## 6. Visualizations

### 6.1 The Eigenvalue Spectrum in ℂ

Plot all 120 eigenvalues in the complex plane. Color-code each by mode projection (red = self-mode dominant, blue = environment-mode dominant, purple = balanced). Size each by magnitude.

```python
import matplotlib.pyplot as plt

def plot_spectrum(eigenvalues, eigenvectors, enriched_states, title=""):
    fig, ax = plt.subplots(1, 1, figsize=(10, 10))

    for i, ev in enumerate(eigenvalues):
        analysis = analyze_eigenvector(eigenvectors[:, i], enriched_states)
        s_frac = analysis['self_mode']

        # Color: red (self) to blue (env)
        color = (s_frac, 0.2, 1.0 - s_frac)
        size = 20 + 100 * abs(ev)

        ax.scatter(ev.real, ev.imag, c=[color], s=size, alpha=0.7, edgecolors='k', linewidth=0.5)

    ax.set_xlabel('Re(λ)')
    ax.set_ylabel('Im(λ)')
    ax.set_title(title)
    ax.set_aspect('equal')
    ax.axhline(y=0, color='gray', linewidth=0.5)
    ax.axvline(x=0, color='gray', linewidth=0.5)

    # Draw unit circle for reference
    theta = np.linspace(0, 2*np.pi, 100)
    ax.plot(np.cos(theta), np.sin(theta), 'k--', alpha=0.3)

    return fig
```

At c = 1 (no mode preference), the spectrum should look like Stage 1 but doubled. As c increases, the spectrum should split: red points (self-mode) and blue points (environment-mode) should separate, revealing two sub-spectra that were degenerate at c = 1.

### 6.2 The Gibbs Measure on the Icosahedron

At the critical point, project the 120-dimensional Gibbs measure onto the 12 vertices (summing over targets and modes) and display on a graph layout.

```python
def plot_gibbs_on_icosahedron(gibbs, enriched_states, G):
    """Plot the Gibbs measure projected onto the 12-vertex graph."""
    # Project onto vertices
    vertex_weight = {v: 0.0 for v in range(1, 13)}
    for i, (v, t, f) in enumerate(enriched_states):
        vertex_weight[v] += gibbs[i]

    # Normalize
    total = sum(vertex_weight.values())
    vertex_weight = {v: w/total for v, w in vertex_weight.items()}

    # Plot
    pos = nx.spring_layout(G, seed=42)
    sizes = [3000 * vertex_weight[v] for v in G.nodes]
    colors = ['#e74c3c' if v in SELF_TRIANGLE else '#3498db' for v in G.nodes]
    labels = {v: f"{LABELS[v]}\n{vertex_weight[v]:.3f}" for v in G.nodes}

    fig, ax = plt.subplots(figsize=(12, 10))
    nx.draw(G, pos, ax=ax, node_size=sizes, node_color=colors,
            labels=labels, font_size=8, edge_color='gray', width=0.5)
    ax.set_title("Gibbs measure (vertex marginal)")
    return fig
```

Also plot the *conditional mode distribution*: for each vertex V, what fraction of its Gibbs weight is in self-mode vs. environment-mode?

```python
def plot_mode_balance(gibbs, enriched_states):
    """For each vertex, show the S/E mode split."""
    s_weight = {v: 0.0 for v in range(1, 13)}
    e_weight = {v: 0.0 for v in range(1, 13)}

    for i, (v, t, f) in enumerate(enriched_states):
        if f == FLOW_S:
            s_weight[v] += gibbs[i]
        else:
            e_weight[v] += gibbs[i]

    fig, ax = plt.subplots(figsize=(14, 6))
    vertices = list(range(1, 13))
    s_vals = [s_weight[v] for v in vertices]
    e_vals = [e_weight[v] for v in vertices]

    x = np.arange(12)
    ax.bar(x - 0.2, s_vals, 0.4, label='Self-mode', color='#e74c3c', alpha=0.7)
    ax.bar(x + 0.2, e_vals, 0.4, label='Env-mode', color='#3498db', alpha=0.7)
    ax.set_xticks(x)
    ax.set_xticklabels([LABELS[v] for v in vertices], rotation=45, ha='right')
    ax.legend()
    ax.set_title("Mode balance per vertex")
    return fig
```

This is the visualization that most directly tests the structural predictions. If vertices on the self-triangle carry more self-mode weight, and vertices on the environment-triangle carry more environment-mode weight, the triangle decomposition is present. If vertices 2 and 10 show the most balanced S/E split, the metabolic axis is spectrally visible.

### 6.3 The Phase Diagram

A heat map of the (c, μ) plane showing the coupling ratio (Section 5.3) or the triangle asymmetry of the Gibbs measure.

```python
def plot_phase_diagram(coherence_values, mu_values, results, quantity='coupling_ratio'):
    Z = np.zeros((len(mu_values), len(coherence_values)))
    for i, mu in enumerate(mu_values):
        for j, c in enumerate(coherence_values):
            Z[i, j] = results[(c, mu)][quantity]

    fig, ax = plt.subplots(figsize=(10, 8))
    im = ax.imshow(Z, origin='lower', aspect='auto',
                   extent=[coherence_values[0], coherence_values[-1],
                           mu_values[0], mu_values[-1]],
                   cmap='RdYlBu_r')
    ax.set_xlabel('Coherence bonus (c)')
    ax.set_ylabel('Switching cost (μ)')
    ax.set_title(f'Phase diagram: {quantity}')
    plt.colorbar(im, ax=ax)
    return fig
```

---

## 7. Specific Predictions to Test

Stage 2 carries four falsifiable predictions, ordered from most to least likely to succeed:

### Prediction A: Mode Separation

At sufficiently high coherence (c >> 1), the 120 eigenvalues should split into two groups of 60, each approximately reproducing the Stage 1 spectrum but with different eigenvector support (one on self-mode states, one on environment-mode states).

**Test:** Compare the eigenvalue spectrum at c = 5, μ = 1 with two copies of the Stage 1 spectrum. Compute the Hausdorff distance between the eigenvalue sets.

**Threshold for success:** The two sub-spectra should be identifiable as shifted or scaled copies of each other, with a measurable splitting that increases with c.

### Prediction B: Triangle-Aligned Chiral Pairs

Among the dominant chiral eigenvalue pairs, at least some should be triangle-aligned: one eigenvector concentrated on self-triangle vertices, the other on environment-triangle vertices.

**Test:** Compute triangle asymmetry for each chiral pair's eigenvectors. A pair is "triangle-aligned" if both eigenvectors have triangle asymmetry > 0.3 (i.e., one triangle carries > 65% of the weight) and they concentrate on *opposite* triangles.

**Threshold for success:** At least 3 of the top 10 chiral pairs (by magnitude) should be triangle-aligned at c = 3, μ = 0.5.

### Prediction C: Metabolic Axis Visibility

Vertices 2 (creativity) and 10 (design) should appear spectrally as the primary coupling channel between the two mode subspaces. Specifically: the eigenvectors that are most *mode-mixed* (closest to 50/50 self/environment mode split) should concentrate weight disproportionately on vertices 2 and 10.

**Test:** Among the top 20 eigenvectors (by eigenvalue magnitude), find the 5 most mode-balanced (lowest mode asymmetry). Compute the average metabolic axis weight for these 5 eigenvectors.

**Threshold for success:** The metabolic axis weight should be > 1/6 (the uniform expectation for 2 of 12 vertices) by at least a factor of 1.5 — i.e., metabolic axis weight > 0.25.

### Prediction D: Quartet Spectral Clustering

The three quartets (Emergence, Becoming, Encounter) should correspond to spectral features — possibly invariant subspaces at special parameter values, or clustering in the eigenvector components.

**Test:** For each eigenvector, compute the trio of quartet projections. Use k-means clustering (k=3) on the eigenvector quartet projections and check if the clusters align with the three quartets.

**Threshold for success:** This is the most speculative prediction. A positive result would be remarkable; a negative result is expected and does not invalidate the framework.

---

## 8. Interpretation Guide

### If all predictions succeed:

The icosahedron, equipped with its geodesic metric and the two directed triangle flows, produces a transfer operator whose spectral structure mirrors the framework's philosophical architecture. The self/environment decomposition, the metabolic axis, and the chiral flows are not imposed by hand but *emerge* from the interplay of geometry, directionality, and mode-coherent target selection. This would constitute strong evidence that the icosahedral structure "knows" its own dynamics — that the combinatorics determines the metabolism.

### If Predictions A and B succeed but C and D fail:

The triangle decomposition is real but the metabolic axis and quartets are not spectrally visible. The framework's broad claims (two complementary metabolic cycles) are confirmed but its fine structure (the specific role of creativity/design, the three quartets) is not. The framework would need to revise its claims about which structural features are dynamically fundamental.

### If only Prediction A succeeds:

Mode separation occurs but the modes don't align with the specific triangles. The flow-mode enrichment produces spectral differentiation, but the mapping of S/E to the specific 6-cycles is arbitrary or wrong. The framework's claim that the icosahedron has two complementary metabolic cycles would survive in principle but the specific assignment of vertices to cycles would be refuted.

### If no predictions succeed:

The flow-mode enrichment does not produce the predicted spectral structure. The framework's specific structural claims — the two triangles, the metabolic axis, the chiral flows — do not survive mathematical instantiation. This is a serious negative result. The undifferentiated chirality of Stage 1 is all the icosahedron produces. The rest is interpretation, not structure.

---

## 9. References

### Carried from Stage 1
- Bowen, R. (1975). *Equilibrium States and the Ergodic Theory of Anosov Diffeomorphisms*. Springer.
- Ruelle, D. (1978/2004). *Thermodynamic Formalism*. Cambridge.
- Lind, D. & Marcus, B. (1995). *An Introduction to Symbolic Dynamics and Coding*. Cambridge.
- Coxeter, H.S.M. (1973). *Regular Polytopes*. Dover.
- Seneta, E. (2006). *Non-negative Matrices and Markov Chains*. Springer.
- Bowlby, J. (1969). *Attachment and Loss, Vol. 1: Attachment*. Basic Books.
- Maturana, H.R. & Varela, F.J. (1980). *Autopoiesis and Cognition*. Reidel.

### New to Stage 2
- Friston, K. (2010). "The free-energy principle: a unified brain theory?" *Nature Reviews Neuroscience* 11, 127–138. — The variational framework for self-organizing systems; the mode-switching structure has analogies with Friston's active inference framework where agents switch between exploitation and exploration.
- Hills, T.T. et al. (2015). "Exploration versus exploitation in space, mind, and society." *Trends in Cognitive Sciences* 19(1), 46–54. — The explore/exploit tradeoff as a universal feature of adaptive systems, relevant to the self-mode/environment-mode distinction.
- Levin, S.A. (1992). "The problem of pattern and scale in ecology." *Ecology* 73, 1943–1967. — The multi-scale structure of ecological systems; relevant to interpreting the spectral gap between mode-coherent and mode-mixing eigenvectors as a scale separation.
- Varela, F.J. (1979). *Principles of Biological Autonomy*. North Holland. — The formal theory of organizational closure, which the two-triangle metabolic structure instantiates as a coupled pair of closure cycles.
