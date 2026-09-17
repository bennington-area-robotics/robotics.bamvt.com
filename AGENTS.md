# AGENTS.md

Guidance for coding agents working in this repository.

## What This Is

This is the public Jekyll site for Bennington Area Robotics
([robotics.bamvt.com](https://robotics.bamvt.com)), including FTC teams 18650
Cookie Clickers and 32473 Bennington Bolts and Biscuits. GitHub Pages builds and
deploys the site from `main`.

## Repository Boundary

Everything committed here should be suitable for publication. Private records,
internal working notes, and unfinished review material belong in the sibling
`../robotics` repository. In particular, do not move bank records, donor
contact information, or internal code-of-conduct review notes into this repository.

## Build and Preview

- Run `bin/serve` for a local preview with live reload on port **4001**.
  Port **4000 does not work in the maintainer's setup**; do not use bare
  `jekyll serve` or assume its default port is usable. Extra flags pass through,
  e.g. `bin/serve --port 4002`. See **Build and Local Preview** in `README.md`
  for setup and remote port forwarding.
- Reuse an existing preview for this repository before starting another server.
  Live reload also needs port **35729**; a second instance needs both a different
  site port and a different `--livereload-port` (see the README).
- Run `bundle exec jekyll build` to verify a change without starting a server.
- Treat a successful local build as the minimum check for content, layout, Liquid,
  or navigation changes.
- Keep this guidance and the README aligned with changes to the preview script,
  site structure, and editing conventions.

## Architecture

- `_layouts/default.html` provides the main site structure, navigation, inline CSS,
  and JavaScript.
- `_layouts/flier.html` renders the printable principles and shop-safety flyers.
- Root-level Markdown files become top-level pages. Event pages live under
  `events/<event-name>/index.md`, usually with nearby images and documents.
- Shared fragments live in `_includes/`. Structured site content lives in `_data/`.
- Blog posts live in `_posts/`; `blog/index.md` lists them. Post URLs use
  `/blog/:slug/`, as configured in `_config.yml`.
- Navigation is the comma-separated `nav_items` assignment in
  `_layouts/default.html`.
- `code-of-conduct.md` is the canonical source for the long code, the principles
  summary, and the shop-safety copy. The files under `print/` select flyer layouts;
  they do not duplicate the substantive wording.
- See **Shared Content and Data** in `README.md` for data consumers and manually
  duplicated content. In particular, donation data feeds `donate.md`, `sponsors.md`,
  and `budget.md`; event listings appear in both `index.md` and `events/index.md`.

## Conventions

- Markdown uses kramdown syntax. External links normally use
  `{:target="_blank"}`; internal links do not.
- Shared styles and scripts are kept in the relevant layout rather than separate
  asset bundles. Some pages also contain styles or scripts specific to that page.
- Local images live beside their event pages or in the root `images/` directory.
  Houston photos and the portfolio PDF use external hosting; preserve media credits
  and source notes. See **Images and Page Features** in `README.md`.
- Use `{#anchor-id}` for explicit heading anchors.
- The `jekyll-redirect-from` plugin is available for URL redirects.
- Preserve existing user changes in the working tree and keep unrelated edits out
  of a task.

## Editorial Guidance

Follow the **Editorial Style Guide** section in `README.md`. In particular:

- Write in a clear institutional voice that is warm but not intimate, parental, or
  presumptuous.
- State observable expectations directly without inferring motives or character.
- Explain standards without scolding, shaming, sarcasm, or forced familiarity.
- Treat students, families, coaches, donors, and volunteers as capable partners.
- Use team experience as evidence and make program obligations reciprocal.
- Keep safety and other consequential requirements concrete and unambiguous.
- Fundraising copy should be confident and active, but never obscure costs,
  restrictions, or how funds will be used.

Bylined essays and retrospectives may use first-person narration, personal reflection,
and a more familiar voice, as described in the README. Preserve that distinction from
institutional or policy copy.

For substantive stakeholder documents, review the result from the perspectives of
the people affected—for example students, families, coaches, volunteers, and other
teams. Prioritize specific likely misunderstandings or harms over generalized prose
preferences.

When publishing a substantive code-of-conduct or flyer revision, manually update
the affected document's version and date. The code of conduct/principles flyer and
the shop-safety flyer have independent version metadata.

## Key Files

| File | Purpose |
|------|---------|
| `_config.yml` | Site metadata, URL, Markdown settings, and plugins |
| `_layouts/default.html` | Main site HTML, CSS, JavaScript, and navigation |
| `_layouts/flier.html` | Screen and print layout for one-page flyers |
| `index.md` | Homepage, schedule, membership, events, and team overview |
| `code-of-conduct.md` | Canonical conduct, principles, and shop-safety content |
| `print/onepager-principles.md` | Principles flyer entry point and metadata |
| `print/onepager-shop-safety.md` | Shop-safety flyer entry point and metadata |
| `budget.md` | Public financial summary |
| `donate.md` | Donation page and calls to action |
| `_data/` | Structured public data used by site pages and includes |
