Now I have all the data I need. Let me compile the complete review.

---

## Review

### Layout

| # | Requirement | Status | Evidence |
|---|---|---|---|
| 1 | **No hero banner with boxes/CTAs** — use Turing-style logo header (logo + tagline) | ✓ PASS | New `_includes/header.qmd` shows only logo + tagline. Old `.hero` div with `cta-row` (three CTA buttons) is gone. `index.qmd` includes `{{< include _includes/header.qmd >}}`. |
| 2 | **Homepage split layout** — feature bullets LHS with SVG icons, code window RHS | ✓ PASS | `.what-is-turing-grid` uses `grid-template-columns: 1fr 1.25fr`. LHS: `.feature-text-column` with 5 `.feature-item`s. RHS: `.code-example-column` with `composed_delays.jl` code window. Same pattern as Turing's "what-is-turing-grid". |
| 3 | **No "A model built from parts" section** — replaced by "Multiple approaches" feature bullet | ✓ PASS | `grep` confirmed zero matches for "model built from parts" in PR's `index.qmd`. The 5th feature bullet is "Multiple approaches" linking to both approach sub-pages. |
| 4 | **Quickstart removed** — content split into two approaches pages | ✓ PASS | `quickstart.qmd` deleted (D in diff). `quickstart/gen.jl` and `quickstart/setup.jl` both deleted. Content appears in `approaches/` pages. |
| 5 | **Approaches dropdown in navbar** (replacing Quick start) with "Composed distributions" and "Assembled Turing model" | ✓ PASS | `_quarto.yml` diff shows `Quick start` entry replaced by `Approaches` dropdown with two menu items: "Composed distributions" → `approaches/composed-distributions.qmd`, "Assembled Turing model" → `approaches/assembled-model.qmd`. |

### Homepage feature bullets

| Requirement | Status | Evidence |
|---|---|---|
| Composable with SVG icon, bold heading, regular-weight description | ✓ PASS | `index.qmd` line: `<span class="feature-icon icon-composable"></span>` ##### Composable — "Small, interchangeable parts..." |
| Uncertainty-aware with SVG icon, bold heading, regular-weight description | ✓ PASS | `icon-uncertainty` SVG icon. No "Full Bayesian inference via Turing.jl's NUTS sampler" text — removed as specified. |
| Built for response with SVG icon, bold heading, regular-weight description | ✓ PASS | `icon-response` SVG icon. "Designed for real-time outbreak analysis: nowcasting, forecasting..." |
| Built on Julia with SVG icon, bold heading, regular-weight description | ✓ PASS | `icon-julia` SVG icon. "Fast, autodiff-ready, and tightly integrated with Turing.jl, SciML..." |
| Multiple approaches with SVG icon, bold heading, regular-weight description | ✓ PASS | `icon-approaches` SVG icon (new in styles.css). Links to both approach sub-pages inline, CTA button links to `approaches/`. |

### Code examples

| # | Requirement | Status | Evidence |
|---|---|---|---|
| 1a | **composed_delays.jl**: BDBV-inspired tree nesting Sequential, Parallel, Resolve, Compete | ✓ PASS | Code uses `compose((clinical = sequential(...), surveillance = sequential(...)))` for Parallel at root, with `resolve` and `compete` inside. Comment: "# BDBV-inspired delay tree". |
| 1b | Uses `compose()` with NamedTuple → Parallel at root | ✓ PASS | `tree = compose((clinical = ..., surveillance = ...))` — NamedTuple syntax creates Parallel. |
| 1c | Shows `event_tree`, `params_table`, `build_priors`, `rand`, `logpdf` | ✓ PASS | All five functions are called in the code block. |
| 2a | **renewal_model.jl**: `rt = AR(...)` inline inside `Renewal()`, not defined separately | ✓ PASS | `Renewal(data; rt = AR(; ϵ_t = HierarchicalNormal(...)), ...)` — inline. |
| 2b | Multiple observation layers: LatentDelay → Ascertainment → NegativeBinomialError | ✓ PASS | `LatentDelay(Ascertainment(NegativeBinomialError(), ...), ...)` — three layers nested. |

### Approaches pages

| # | Requirement | Status | Evidence |
|---|---|---|---|
| 1 | Top: what-is-turing-grid split — feature bullets LHS + code RHS | ✓ PASS | Both `composed-distributions.qmd` and `assembled-model.qmd` use `{.what-is-turing-grid}` with `.feature-text-column` and `.code-example-column`. |
| 2 | Below: white paper section explaining high-level intent and technical approach | ✓ PASS | Both pages have `## The approach` section with multiple subsections explaining concepts (not API). |
| 3 | Each links to the other approach page | ✓ PASS | Composed-distributions: "See the [assembled model approach](assembled-model.qmd)". Assembled-model: "See the [composed distributions approach](composed-distributions.qmd)". |
| 4 | Documentation buttons link to respective package docs | ✓ PASS | Composed: "Documentation →" → `https://composeddistributions.epiaware.org/dev/`. Assembled: "Documentation →" → `https://composableturingidmodels.epiaware.org/dev/`. |

### White paper content

| # | Requirement | Status | Evidence |
|---|---|---|---|
| 1 | Not literal function/API descriptions | ✓ PASS | Both white papers (composed-distributions: "The central idea is that a case's event history is a tree...", assembled-model: "An epidemiological model couples three processes...") explain concepts, not API. |
| 2 | Composed: "composing trees of events" | ✓ PASS | "Composing trees of events" is the first feature headline. White paper: "a case's event history is a tree". |
| 3 | Composed: "making efficient individual-level models with marginalisation" | ✓ PASS | "### Marginalisation at the record level" subsection. "the composed distribution marginalises over the unobserved branches internally". |
| 4 | Composed: "same representation for renewal processes and for dropping into composable differentiable equation models" | ✓ PASS | "### A single representation for the workflow": "The same object that defines a delay distribution for a renewal model also drops into a Turing fit unchanged... works for differentiable-equation models." |
| 5 | Assembled: "interchangeable parts, one interface" | ✓ PASS | Feature item #1: "Interchangeable parts, one interface". White paper: "each of these is an interchangeable part... every part speaks the same `as_turing_model` interface". |
| 6 | Assembled: "no model rewrites, only part swaps" | ✓ PASS | "### No model rewrites, only part swaps" subsection. |
| 7 | Assembled: "uncertainty through the full pipeline" | ✓ PASS | Feature item #2: "Uncertainty through the full pipeline". White paper: "Uncertainty propagates from the latent process through infection dynamics, reporting delays, ascertainment, and observation noise". |
| 8 | Assembled: "same assembly simulates, infers, nowcasts, forecasts" | ✓ PASS | "### One assembly for the full workflow": "The same `IDModel`... generates prior predictives, conditions on observed data, runs NUTS inference, and produces posterior draws". |
| 9 | Mention package ecosystem: ComposedDistributions, ConvolvedDistributions, ModifiedDistributions, CensoredDistributions each do different things and work together; ComposableTuringIDModels is meta-language | △ PARTIAL | Neither white paper mentions the full ecosystem with the specified detail. Composed-distributions "Where next" lists ComposedDistributions.jl and CensoredDistributions.jl but omits **ConvolvedDistributions** and **ModifiedDistributions**. Assembled-model "Where next" mentions ComposableTuringIDModels.jl only. Neither explains how the packages "each do different things and work together" or describes ComposableTuringIDModels as "a meta-language for composing Turing models plugging into algebraic/periodic structures." |

### Navigation

| # | Requirement | Status | Evidence |
|---|---|---|---|
| 1 | Navbar has "Approaches" dropdown (replacing Quick start) | ✓ PASS | `_quarto.yml`: `Quick start` entry replaced by `Approaches` dropdown. |
| 2 | Tutorials page has a link table to the approaches pages | ✓ PASS | `tutorials.qmd` has a `## Approaches` section with a markdown table: `| [Compose distributions](approaches/composed-distributions.qmd) | ... |` and `| [Assemble an infectious disease model](approaches/assembled-model.qmd) | ... |`. |
| 3 | Both approach sub-pages use `toc: true` with `toc-location: left` | ✓ PASS | Both `composed-distributions.qmd` and `assembled-model.qmd` front matter have `toc: true` and `toc-location: left`. |

### Removed items

| # | Requirement | Status | Evidence |
|---|---|---|---|
| 1 | `quickstart.qmd` deleted | ✓ PASS | D in diff. `git show origin/turing-inspired-landing:quickstart.qmd` fails (file does not exist). |
| 2 | `quickstart/` directory (`gen.jl`, `setup.jl`) deleted | ✓ PASS | Both files shown as deleted in diff. |
| 3 | Hero banner with CTA boxes removed from homepage | ✓ PASS | Old `.hero` div with `cta-row` (three CTA buttons) replaced by `_includes/header.qmd` with just logo + tagline. |
| 4 | "A model built from parts" section removed from homepage | ✓ PASS | No match in PR's `index.qmd`. |
| 5 | "Get Started" CTA button removed from feature bullets | ✓ PASS | Replaced with "Explore approaches →" linking to `approaches/`. |
| 6 | External links to CensoredDistributions BDBV tutorial from composed-distributions page | ✓ PASS | BDBV appears only as a code comment (`# BDBV-inspired delay tree`) on composed-distributions page. No external link to the BDBV tutorial there. BDBV tutorial link only appears on `tutorials.qmd`. |

---

## Summary of issues found

### Blocker: None

No blockers — all layout, code examples, navigation, and removal requirements are met.

### Issues requiring fixes

**△ White paper — package ecosystem mention (composed-distributions.qmd)**
- The spec requires the composed white paper to mention: "ComposedDistributions, ConvolvedDistributions, ModifiedDistributions, CensoredDistributions each do different things and work together; ComposableTuringIDModels is a meta-language".
- Currently the "Where next" section on `approaches/composed-distributions.qmd` only lists ComposedDistributions.jl and CensoredDistributions.jl. ConvolvedDistributions and ModifiedDistributions are absent, and the ecosystem structure is not explained.
- **Fix**: Add a "### Package ecosystem" or similar subsection that describes each package's role and how they compose together. Include ComposedDistributions, ConvolvedDistributions, ModifiedDistributions, CensoredDistributions, and ComposableTuringIDModels as a meta-language.

**△ White paper — package ecosystem mention (assembled-model.qmd)**
- The assembled-model white paper mentions ComposableTuringIDModels.jl in "Where next" but doesn't describe the role of other packages.
- **Fix**: Add a brief note in "Where next" or the white paper body that the assembled approach builds on the same distribution packages (ComposedDistributions, etc.).

---