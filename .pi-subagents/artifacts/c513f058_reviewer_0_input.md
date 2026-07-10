# Task for reviewer

Review the EpiAware website PR at https://github.com/EpiAware/epiaware.github.io/pull/12 against the user specification below. The repo is at /home/seabbs/code/EpiAware/epiaware.github.io. Read all changed files, then evaluate each requirement.

## Specification (from user prompts)

### Layout
1. **No hero banner with boxes/CTAs** — use Turing-style logo header (logo + tagline)
2. **Homepage split layout** — feature bullets on LHS with SVG icons (bold heading + regular-weight description), code window on RHS. Same pattern as Turing's "what-is-turing-grid"
3. **No "A model built from parts" section on homepage** — replaced by "Multiple approaches" feature bullet linking to approaches/ pages
4. **Quickstart removed** — content split into two approaches pages
5. **Approaches dropdown in navbar** (replacing Quick start) with "Composed distributions" and "Assembled Turing model"

### Homepage feature bullets
Should be: Composable, Uncertainty-aware, Built for response, Built on Julia, Multiple approaches
- Each has an SVG icon, a bold heading, and regular-weight description
- No "Full Bayesian inference via Turing.jl's NUTS sampler" (removed)
- "Multiple approaches" links to approaches/ and its sub-pages

### Code examples
1. **composed_delays.jl** (homepage code window + approach page):
   - BDBV-inspired tree nesting Sequential, Parallel, Resolve, Compete
   - Uses `compose()` with NamedTuple → Parallel at root
   - Shows `event_tree`, `params_table`, `build_priors`, `rand`, `logpdf`
2. **renewal_model.jl** (assembled-model approach page):
   - `rt = AR(...)` inline inside `Renewal()`, not defined separately
   - Multiple observation layers: LatentDelay → Ascertainment → NegativeBinomialError

### Approaches pages
Each approach page should have:
1. **Top: what-is-turing-grid split** — feature bullets (LHS) + code (RHS), just like homepage
2. **Below: white paper section** — explains the high-level intent and technical approach:
   - **Composed approach**: composing trees of events; efficient individual-level models through marginalisation; same representation for renewal processes and differentiable equation models. Not literal function names/API docs.
   - **Assembled approach**: three roles as interchangeable parts; no model rewrites only part swaps; layered observation models; one assembly for full workflow; full Turing toolchain
3. Each should link to the other approach page
4. Documentation buttons link to the respective package docs

### White paper content requirements
- Explain *intent behind the approach* and *high-level technical approach*
- **Not** literal function/API descriptions
- Composed: "composing trees of events", "making efficient individual-level models with marginalisation", "same representation for renewal processes and for dropping into composable differentiable equation models"
- Assembled: "interchangeable parts, one interface", "no model rewrites, only part swaps", "uncertainty through the full pipeline", "same assembly simulates, infers, nowcasts, forecasts"
- Mention the package ecosystem: ComposedDistributions, ConvolvedDistributions, ModifiedDistributions, CensoredDistributions each do different things and work together; ComposableTuringIDModels is a meta-language for composing Turing models plugging into algebraic/periodic structures

### Navigation
- Navbar has "Approaches" dropdown (replacing Quick start)
- Tutorials page has a link table to the approaches pages
- Both approach sub-pages use `toc: true` with `toc-location: left` (left-hand sidebar)

### Removed
- quickstart.qmd deleted
- quickstart/ directory (gen.jl, setup.jl) deleted
- Hero banner with CTA boxes removed from homepage
- "A model built from parts" section removed from homepage
- "Get Started" CTA button removed from feature bullets
- External links to CensoredDistributions BDBV tutorial from composed-distributions page (the north-star is a source of design thinking, not a link target)

## Files to review
- /home/seabbs/code/EpiAware/epiaware.github.io/index.qmd
- /home/seabbs/code/EpiAware/epiaware.github.io/_includes/header.qmd
- /home/seabbs/code/EpiAware/epiaware.github.io/_quarto.yml
- /home/seabbs/code/EpiAware/epiaware.github.io/approaches/index.qmd
- /home/seabbs/code/EpiAware/epiaware.github.io/approaches/composed-distributions.qmd
- /home/seabbs/code/EpiAware/epiaware.github.io/approaches/assembled-model.qmd
- /home/seabbs/code/EpiAware/epiaware.github.io/styles.css
- /home/seabbs/code/EpiAware/epiaware.github.io/theme-light.scss
- /home/seabbs/code/EpiAware/epiaware.github.io/theme-dark.scss
- /home/seabbs/code/EpiAware/epiaware.github.io/tutorials.qmd

For each requirement, say: ✓ PASS, ✗ FAIL (with what's wrong), or △ PARTIAL (with what's missing). Then list concrete fixes needed.

## Acceptance Contract
Acceptance level: attested
Completion is not accepted from prose alone. End with a structured acceptance report.

Criteria:
- criterion-1: Return concrete findings with file paths and severity when applicable

Required evidence: review-findings, residual-risks

Finish with a fenced JSON block tagged `acceptance-report` in this shape:
Use empty arrays when no items apply; array fields contain strings unless object entries are shown.
```acceptance-report
{
  "criteriaSatisfied": [
    {
      "id": "criterion-1",
      "status": "satisfied",
      "evidence": "specific proof"
    }
  ],
  "changedFiles": [
    "src/file.ts"
  ],
  "testsAddedOrUpdated": [
    "test/file.test.ts"
  ],
  "commandsRun": [
    {
      "command": "command",
      "result": "passed",
      "summary": "short result"
    }
  ],
  "validationOutput": [
    "validation output or concise summary"
  ],
  "residualRisks": [
    "none"
  ],
  "noStagedFiles": true,
  "diffSummary": "short description of the diff",
  "reviewFindings": [
    "blocker: file.ts:12 - issue found, or no blockers"
  ],
  "manualNotes": "anything else the parent should know"
}
```