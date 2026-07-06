# epiaware.github.io

Source for the [EpiAware](https://github.com/EpiAware) organisation website — the
meta-site for a composable Julia ecosystem for infectious disease modelling.

The site links out to the ecosystem's packages, wraps their documentation in a
single browser, and hosts org-level material (using Julia, FAQ, contributing,
developer, funding, getting involved) alongside a gallery and team page.

## Build

The site is built with [Quarto](https://quarto.org/).

```bash
quarto preview      # live local preview
quarto render       # build into _site/
```

Every push and pull request builds the site in CI
(`.github/workflows/publish.yml`), so a broken build is caught before merge.
Pushes to `main` deploy it to GitHub Pages.

## Adding a package

Copy `packages/_template.qmd` to `packages/<yourpackage>.qmd`, fill in the front
matter and body, and open a pull request. The card on the
[Packages](https://epiaware.github.io/packages/) page is generated from the file,
and adding the package to the docs browser is a one-line entry in the
`EPIAWARE_DOCS` list in `docs.qmd`.

## Structure

- `index.qmd` — home
- `packages/` — one page per package, plus the generated listing and a template
- `docs.qmd` — unified documentation browser
- `tutorials.qmd`, `gallery.qmd`, `team.qmd`, `funding.qmd`, `get-involved.qmd`, `community.qmd`
- `using-julia.qmd`, `faq.qmd`, `contributing.qmd`, `developer.qmd` — org-level guides
- `theme-light.scss`, `theme-dark.scss`, `styles.css` — theme
- `assets/img/logo.svg` — org logo

## Custom domain

The site is served at `https://epiaware.github.io`. To use a custom domain
(e.g. `epiaware.org`), add a `CNAME` file and update `site-url` in `_quarto.yml`.
