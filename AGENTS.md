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

## Resuming Work

- Start with `git status --short --branch`, recent commits, and `git diff`. Inspect
  untracked files too: a budget page may depend on a new JSON file that is not yet
  included in the diff. Preserve existing changes before switching branches.
- Check the associated PR's current state before continuing a branch; local work
  may extend a season reorganization that has already merged. Distinguish committed
  navigation changes from later, uncommitted budget and copy updates.
- Read **Season Navigation** and **Budget Seasons** in `README.md` before changing
  season structure. Keep session transcripts and internal handoff notes in
  `../robotics`, outside this public repository.

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
  `events/<event-name>/index.md`, usually with nearby documents and image source notes.
- Shared fragments live in `_includes/`. Structured site content lives in `_data/`.
- Blog posts live in `_posts/`; `blog/index.md` lists them. Post URLs use
  `/blog/:slug/`, as configured in `_config.yml`.
- Season landing pages live under `seasons/<season-name>/index.md`, using lowercase
  game names (`biobuzz`, `decode`) rather than years in URLs. Keep year ranges in
  metadata and data filenames for sorting and association. The season index
  and `season-nav.html` include use `season_year`, `season_label`, and
  `season_summary` front matter. Shared event lists live in `_includes/season-events/`.
  `season` associates posts and pages with a season; `nav_section` highlights a
  shared Blog or Events section for its individual posts or events.
  Season overview blog links are curated manually; seasonal blog listings use
  `season-posts.html` to select posts by `season`, not publication date. Event
  lists are maintained manually in the shared includes, not generated from pages.
- `/budget/`, `/sponsors/`, and `/portfolio/` render the current season directly
  from root-level Markdown files. Permanent seasonal pages live under
  `seasons/<season-name>/<section>/index.md`; DECODE's accounts, sponsors, and
  portfolio are archived there. Keep historical links season-specific.
- Current top-level pages and their seasonal counterparts share Markdown bodies
  in `_includes/season-content/<season-name>/`. The top-level pages use `season`
  metadata, `canonical_url` pointing to the permanent seasonal page, and
  `sitemap: false`. They are rendered pages, not redirects. Only permanent budget
  pages carry `budget_season`, `budget_label`, and `budget_status`, so budget
  indexes list each season once. Do not duplicate body copy between entry points.
- When advancing the current season, update all three root pages' metadata,
  canonical URLs, and includes, plus the current navigation links. Retain prior
  season pages and their includes. Use clear placeholders when current content is
  not ready. Keep year-based legacy redirects on the corresponding seasonal pages.
  Budget data remains in `_data/budgets/YYYY-YYYY.json` when available.
- Navigation is defined in `_data/navigation.yml` and rendered by
  `_includes/navigation.html`. Keep the menu at two fixed levels, with no season
  expansion or collapse controls. Both season groups are top-level items, followed
  by Blog, Events, and program links. The mobile Menu button toggles the whole menu.
- `code-of-conduct.md` is the canonical source for the long code, the principles
  summary, and the shop-safety copy. The files under `print/` select flyer layouts;
  they do not duplicate the substantive wording.
- See **Shared Content and Data** in `README.md` for data consumers and manually
  duplicated content. `_data/donations.json` feeds `donate.md`,
  `seasons/decode/sponsors/index.md`, and `seasons/decode/budget/index.md`.
  It records the completed DECODE post-season campaign; keep new-season gifts
  separate so they cannot change those accounts. The next-event summary in
  `index.md` and full listings in `_includes/season-events/` are maintained
  separately; update both when the next event changes. Keep past events in the
  full listings, press coverage at `/news-coverage/`, and the championship video
  on its event page. The homepage prioritizes joining, meeting times, membership,
  and brief season and team summaries. Preserve its `meeting-schedule`,
  `student-membership`, and `news-coverage` anchors.
- The footer in `_layouts/default.html` repeats the meeting location from
  `index.md` and mailing address from `donate.md`. Update both copies when an
  address changes; keep meeting times on the homepage, linked from the footer.

## Season Budget Updates

- BIOBUZZ's public budget page is a placeholder marked "Budget in development".
  Its shared body is `_includes/season-content/biobuzz/budget.md`. Do not publish
  unfinished budget data or copy as part of path or navigation work.
- Keep planned income distinct from received funds when publishing a budget.
  Review related copy in `donate.md` and the season overview at the same time.
- Keep private data out of `_data/`, including ignored subdirectories: Jekyll loads
  data independently of Git ignore rules.
- When moving historical pages, check redirects and confirm completed DECODE
  figures remain unchanged.

## Conventions

- Pages and posts using `layout: default` carry an ISO 8601 `last_modified_at`.
  Run `bin/install-hooks` once per checkout; the pre-commit hook updates affected
  staged pages and shared-content consumers while preserving unstaged edits.
  Keep dependency handling and tests in `bin/last-modified` aligned with new
  content includes, data access, and generated listings. See **Page Update Dates**
  in the README for backfilling, GitHub web edits, and checks. These timestamps do
  not replace policy version dates or budget reporting dates.
- `sitemap.xml` overrides the plugin template and uses only explicit
  `last_modified_at` values for `lastmod`; do not substitute post dates, filesystem
  modification times, or build time. Keep duplicate root pages, redirects,
  printable copies, PDFs, and verification files out of the sitemap. Remove
  `sitemap: false` from placeholders only when they have substantial original
  content. See **Sitemap inclusion** in the README for current exclusions.
- Markdown uses kramdown syntax. External links normally use
  `{:target="_blank"}`; internal links do not.
- Shared styles and scripts are kept in the relevant layout rather than separate
  asset bundles. Some pages also contain styles or scripts specific to that page.
- Content headings use the shared dark blue `--heading` color without decorative
  lines or underlines; linked headings match. Banner titles remain white.
- Images live in the BAMVT Cloudflare R2 `assets` bucket at `assets.bamvt.com`.
  Site images use `robotics.bamvt.com/` followed by their former repository path;
  Houston photos and the portfolio PDF retain their existing external URLs.
  Use full HTTPS image URLs and preserve media credits and source notes in the repo.
  See **Images and Page Features** in `README.md`.
- Use one `#` page title, `##` sections, and `###` subsections. For pages with
  `banner_image`, the layout supplies the `h1`; start body sections at `##`.
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
| `sitemap.xml` | Sitemap template with explicit content modification dates |
| `_layouts/default.html` | Main site HTML, CSS, JavaScript, and navigation |
| `_layouts/flier.html` | Screen and print layout for one-page flyers |
| `index.md` | Homepage, schedule, membership, events, and team overview |
| `code-of-conduct.md` | Canonical conduct, principles, and shop-safety content |
| `print/onepager-principles.md` | Principles flyer entry point and metadata |
| `print/onepager-shop-safety.md` | Shop-safety flyer entry point and metadata |
| `seasons/` | Season archive and landing pages |
| `budget.md`, `sponsors.md`, `portfolio.md` | Current-season entry points (rendered directly) |
| `_includes/season-content/` | Shared bodies for current and permanent seasonal pages |
| `seasons/decode/{budget,sponsors,portfolio}/` | Completed DECODE content |
| `seasons/budgets/` and `seasons/biobuzz/budget/` | Budget index and BIOBUZZ budget placeholder |
| `donate.md` | Donation page and calls to action |
| `_data/` | Structured public data used by site pages and includes |
