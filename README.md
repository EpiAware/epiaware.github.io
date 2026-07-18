# epiaware.github.io

Source for the [EpiAware](https://github.com/EpiAware) organisation website — the
meta-site for a composable Julia ecosystem for infectious disease modelling.

The site is the ecosystem's shared front door: an inventory of every package
linking out to its own documentation, the approaches that tie them together,
and org-level material (using Julia, FAQ, contributing, developer, funding,
getting involved) alongside a gallery and team page.

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

Add a row to the table in `packages/index.qmd`: package name linking to its
documentation, a GitHub icon linking to its source, a status pill, a
`data-category` (`modelling`, `distributions`, or `infrastructure`) so it
picks up the category filter, and a one-sentence description. Open a pull
request.

## Structure

- `index.qmd` — home
- `packages/index.qmd` — the ecosystem inventory (one filterable table)
- `approaches/` — the modelling approaches (composed distributions, composable
  Turing models) and their shared overview
- `tutorials/index.qmd` — a filterable listing of runnable tutorials, each
  living in its own package's documentation
- `gallery.qmd`, `team.qmd`, `funding.qmd`, `get-involved.qmd`, `community.qmd`
- `using-julia.qmd`, `faq.qmd`, `contributing.qmd`, `developer.qmd` — org-level guides
- `news/` — blog posts
- `theme-light.scss`, `theme-dark.scss`, `styles.css` — theme
- `assets/img/logo.svg` — org logo

## Custom domain

The site is served at `https://epiaware.github.io`. To use a custom domain
(e.g. `epiaware.org`), add a `CNAME` file and update `site-url` in `_quarto.yml`.
