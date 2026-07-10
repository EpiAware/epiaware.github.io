# Code Context — PR Review: EpiAware Website Redesign

## Overview

PR branch `turing-inspired-landing` against `main`. 1,020 insertions, 334 deletions across 15 files. The PR restructures the EpiAware organisation site from a minimal landing page into a full TuringLang-style documentation portal: a redesigned hero/feature-gate home page, two deep-dive "Approaches" articles, a gallery, a blog post, a tutorials page, Quarto config and CSS/SCSS theme files with light/dark mode.

**Removed (not in the task list but changed in PR):** `quickstart.qmd`, `quickstart/gen.jl`, `quickstart/setup.jl` — replaced by the Approaches pages and tutorials.

---

## Files Retrieved

### 1. `_quarto.yml` (lines 1-76)
Site-level Quarto config. Sets `output-dir: _site`, navbar with Approaches (with submenu for composed-distributions and assembled-model), Docs, Tutorials, News, Gallery, Guides (Using Julia, FAQ, Contributing, Developer docs), Community (Get involved, Team, Funding, epinowcast). Footer with links and GitHub icon. Format config: cosmo theme with light/dark SCSS overrides, `styles.css`, TOC depth 3, smooth-scroll, code-copy, grid layout (sidebar 250px, body 940px).

**PR diff:** +8/-2 — added "Approaches" menu and "Tutorials" navbar item, removed "Quick start" from Docs submenu.

### 2. `_includes/header.qmd` (lines 1-9)
A Quarto HTML include that renders the hero section: an SVG logo (with separate light/dark variants) and subtitle "Composable tools for infectious disease modelling in Julia."

**PR diff:** +9/-0 — new file, part of the TuringLang-style landing page hero.

### 3. `index.qmd` (lines 1-295)
The landing page. YAML header with listing for `news-listing` (3 most recent posts). Body has four sections: "What is EpiAware" (composable, uncertainty-aware, built for response, built on Julia, multiple approaches feature cards with code window example showing `composed_delays.jl`), "Core Packages" grid (ComposableTuringIDModels, CensoredDistributions, ComposedDistributions, ModifiedDistributions), "News & Updates" (auto-listing), "Built on Julia" (SciML, Turing.jl, Distributions.jl feature cards), and "Background" section describing the R→Julia transition and call for collaborators.

**PR diff:** +295/-130 — completely restructured from a minimal page to a full TuringLang-style landing page with hero include, feature grid, code window, packages grid, news listing, and background section.

### 4. `approaches/index.qmd` (lines 1-41)
Landing page for the Approaches section. Two card-style options: "Compose distributions into event trees" (describes Sequential/Parallel/Resolve/Compete from ComposedDistributions.jl) and "Assemble an infectious disease model" (describes the `as_turing_model` interface from ComposableTuringIDModels.jl), each with an "Explore →" link.

**PR diff:** +41/-0 — new file.

### 5. `approaches/composed-distributions.qmd` (lines 1-184)
Deep-dive article on the composed-distributions approach. Feature columns mirroring the home page (composing trees of events, efficient individual-level models, same representation multiple uses) with a code window showing the BDBV-inspired delay tree. Prose sections: "The approach" (event tree concept, marginalisation at the record level, single representation for the workflow, posterior readback). "Where next" links to ComposedDistributions.jl docs, CensoredDistributions.jl, and the assembled model approach.

**PR diff:** +184/-0 — new file.

### 6. `approaches/assembled-model.qmd` (lines 1-182)
Deep-dive article on the assembled Turing model approach. Feature columns (interchangeable parts/one interface, uncertainty through the full pipeline, built for the workflow) with a code window showing `renewal_model.jl` using `Renewal`, `AR`, `LatentDelay`, `Ascertainment`, `NegativeBinomialError`. Prose: "The approach" (no model rewrites/only part swaps, layered observation models, one assembly for the full workflow, full Turing toolchain). "Where next" links to ComposableTuringIDModels.jl docs and the composed-distributions approach.

**PR diff:** +182/-0 — new file.

### 7. `gallery.qmd` (lines 1-38)
Gallery page showing how people use EpiAware and related tools. Seven gallery cards with colour-coded banners: real-time outbreak analysis (EpiNow2), nowcasting (epinowcast), modelling workflow (a-workflow-for-infectious-disease-modelling), forecast evaluation (scoringutils), BDBV delay distributions, ANDV joint incubation/transmission, and 2026 DRC Bundibugyo outbreak size estimation. Includes "Add your work" section inviting PRs.

**PR diff:** +38/-0 — new file.

### 8. `news/posts/hello-epiaware.qmd` (lines 1-36)
Blog post titled "A composable ecosystem for infectious disease modelling" by Sam Abbott, dated 2026-07-10. Describes the project's aim (composable modelling for outbreak response), situates EpiAware alongside sibling packages (DDSALineLists.jl, CategoricalOutbreaks.jl from epirecipes), states it builds on the epiforecasts workflow experience, and notes current status (early-stage, CensoredDistributions.jl most developed). Call for collaborators.

**PR diff:** +17/-23 — reframed to present Approaches as "current starting points" rather than an exhaustive list; updated aims/steer language; added gallery context.

### 9. `tutorials.qmd` (lines 1-40)
Tutorials page with a table linking to the two Approaches and a note that in-depth tutorials are in development. Points to CensoredDistributions.jl docs (BDBV line-list analysis), Bayesian Workflow book, and a-workflow-for-infectious-disease-modelling. Invites suggestions.

**PR diff:** +40/-34 — restructured from standalone Quick start page to a tutorial index that directs users to the Approaches pages first.

### 10. `styles.css` (lines 1-252)
Comprehensive CSS for the site. Covers: button fill style (`.button--fill` with `--epi-primary` token), navbar branding, section layout helpers (`.side-space`, `.section-start-space`, `.section-end-space`, `.section-header`), hero section (`.hero-section`, `.hero-logo`, `.hero-subtitle`), "What is EpiAware" grid (`.what-is-turing-grid` two-column layout), feature icons (5 inline SVG data URIs for composable, uncertainty, response, julia, approaches), code window with macOS-style dots (`.code-window`, `.code-window-header`, `.dot.red/yellow/green`), core packages grid (4-column), responsive breakpoints at 820px and 540px, gallery grid and cards, library item rows for package listing, team member cards, status pills (experimental/maturing/stable).

**PR diff:** +252/-89 — significantly expanded from a minimal stylesheet to full TuringLang-inspired design system with new grids, feature icons, code windows, gallery cards, team cards, status pills, and responsive breakpoints.

### 11. `theme-light.scss` (lines 1-80)
Light theme SCSS. Imports Inter font. Brand tokens: deep teal primary (`#0f7c8f`), bright teal secondary (`#23a6a0`), warm amber accent (`#e8965a`). White background, near-black text. Minimal navbar styling. Hero section with radial gradient overlay. Code window header in light grey. Package, feature, and gallery cards with subtle borders and light backgrounds.

**PR diff:** +38/-0 — new file (rewritten from a minimal placeholder to full theme).

### 12. `theme-dark.scss` (lines 1-80)
Dark theme SCSS. Same Inter font. Brighter teal primary (`#35c0b8`) for readability on dark ground. Near-black background (`#0f141a`), light grey text (`#d7dee6`). Dark navbar, hero radial gradient with stronger teal presence. Code window, package cards, feature cards, gallery cards all dark-themed with `#141b22`/`#151c24` backgrounds and `#26303b` borders. Hero shows light logo hidden and dark logo shown (inverse of light theme).

**PR diff:** +38/-0 — new file (rewritten from a minimal placeholder to full theme).

---

## Architecture

```
epiaware.github.io/
├── _quarto.yml              ← Site config (navbar, theme, format)
├── _includes/
│   └── header.qmd           ← Hero section (logo + subtitle)
├── index.qmd                ← Landing page (features, packages, news, background)
├── approaches/
│   ├── index.qmd            ← Approaches landing (two cards)
│   ├── composed-distributions.qmd  ← Composed distributions deep-dive
│   └── assembled-model.qmd         ← Assembled Turing model deep-dive
├── tutorials.qmd            ← Tutorials index
├── gallery.qmd              ← Gallery of usage examples
├── news/
│   ├── index.qmd            ← News listing
│   └── posts/
│       └── hello-epiaware.qmd ← Launch announcement blog post
├── packages/
│   └── index.qmd            ← Package listing
├── styles.css               ← Shared structural CSS
├── theme-light.scss         ← Light theme colour tokens and rules
├── theme-dark.scss          ← Dark theme colour tokens and rules
└── assets/img/logo.svg      ← EpiAware logo
```

**Design patterns:**
- TuringLang-inspired: grid-based feature columns, code windows with macOS-style dots, section headers with "View more →" buttons
- Light/dark mode via Quarto theme system: both themes import cosmo, then SCSS overrides add branding and layout
- CSS custom properties bridge SCSS variables to CSS (`--epi-primary`, `--border-color`)
- Approach cards and gallery cards share a consistent card pattern (border, border-radius, hover effects)

**Data flow:**
- `index.qmd` includes `_includes/header.qmd` for the hero
- `index.qmd` and `approaches/composed-distributions.qmd` share the same feature-grid and code-window HTML structure
- `approaches/index.qmd` links to both deep-dive pages
- `tutorials.qmd` directs users to approaches pages first, then to package docs
- `gallery.qmd` links to external analysis repos

---

## Start Here

Open `_quarto.yml` first — it defines the site structure, navbar, and theme wiring that connects all the other files together.