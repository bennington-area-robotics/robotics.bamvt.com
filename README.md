# Bennington Area Robotics

Source for the [Bennington Area Robotics website](https://robotics.bamvt.com).

## Editing the Site

This is a [Jekyll](https://jekyllrb.com/) site hosted on GitHub Pages. Pages are written in Markdown.

### Architecture

- **Content pages**: Markdown with YAML front matter, usually specifying `layout: default`. Top-level pages live in the root; event pages live under `events/<event-name>/index.md` alongside their documents and image source notes.
- **Main layout** (`_layouts/default.html`): Template with HTML structure, inline CSS, and JavaScript. Provides a desktop sidebar whose branding scrolls away while navigation links stay visible (short windows use normal page scrolling), an expandable navigation menu on smaller screens, main content, and a footer that repeats navigation in a blue section on smaller screens. Page banners appear in the content column. Blue accent bars frame the desktop sidebar and mobile header/footer; the active navigation item uses a solid pale-blue background. The footer includes contact details, social links, and a Donate button, and sits at the bottom of the content column on short desktop pages. Navigation comes from `_data/navigation.yml` and `_includes/navigation.html`, with a fixed two-level list. Navigation scrolls within tall desktop viewports so every link stays reachable.
- **Printable flyers** (`_layouts/flier.html`, `print/`): A separate layout and entry pages render the principles and shop-safety flyers from canonical content in `code-of-conduct.md`.
- **Blog** (`_posts/`, `blog/index.md`): Dated Markdown posts and the blog index. Post URLs use `/blog/:slug/`, as configured in `_config.yml`.
- **Shared content** (`_includes/`, `_data/`): Reusable Liquid fragments and structured public data.
- **Config** (`_config.yml`): Site metadata (title, description, URL) and kramdown markdown settings.

### Key Files

- `index.md` – Homepage content
- `seasons/index.md` and `seasons/<season>/index.md` – Season archive and landing pages
- `events/index.md` – Event listing; individual events live under `events/`
- `blog/index.md` and `_posts/` – Blog listing and posts
- `budget.md`, `sponsors.md`, and `portfolio.md` – Current-season pages at the stable top-level URLs
- `_includes/season-content/<season>/` – Shared Markdown bodies for current and permanent seasonal pages
- `seasons/decode/{budget,sponsors,portfolio}/index.md` – Completed DECODE accounts, sponsors, and portfolio
- `seasons/budgets/index.md` and `seasons/biobuzz/budget/index.md` – Budget index and BIOBUZZ budget placeholder
- `donate.md` – Donation page
- `code-of-conduct.md` – Canonical conduct, principles, and shop-safety content
- `print/onepager-principles.md` and `print/onepager-shop-safety.md` – Flyer entry points
- `_config.yml` – Site configuration (title, description, URL)
- `_layouts/default.html` – Page template (HTML structure and CSS)
- `_layouts/flier.html` – Screen and print layout for flyers
- `bin/serve` – Local preview launcher
- `AGENTS.md` – Coding-agent guidance; keep it aligned with this README and the implementation

### Repository Boundary

Everything committed here must be suitable for publication. Keep private records,
donor contact information, internal working notes, and unfinished review material in
the sibling `../robotics` repository.

### Shared Content and Data

Keep private data outside `_data/`, including `_data/local/`: Jekyll loads supported
data files there even when Git ignores them or they appear in Jekyll's `exclude` list.
Git ignore rules do not control site output; `_config.yml` excludes local working
directories (`scratch/` and `resources/`) and development tools (`bin/`) from builds.

Some edits affect several pages. Check the consumers when changing these sources:

| Source | Used by / editing notes |
|--------|-------------------------|
| `_data/navigation.yml` | `_includes/navigation.html` and `nav-link.html`: season groups and program links in the header and mobile footer. |
| `_includes/season-events/*.md` | All-season events page, season event pages, and season overviews. The homepage event list is maintained separately. |
| Post `season` front matter | `_includes/season-posts.html`: season-specific blog listings. Assign by subject, not publication date. |
| `_data/budgets/2025-2026.json` | `seasons/decode/budget/index.md`: regular-season income and expenses, plus post-season budgets and actual expenses. |
| `_includes/season-content/biobuzz/*.md` | Shared body copy for `/budget/`, `/sponsors/`, `/portfolio/`, and their permanent BIOBUZZ counterparts. Edit these includes rather than duplicating copy. |
| Budget page front matter | `seasons/budgets/index.md` and `_includes/budget-seasons.html`: season listings, newest first, from `budget_season`, `budget_label`, and `budget_status`. |
| `_data/donations.json` | `donate.md`, `seasons/decode/sponsors/index.md`, and `seasons/decode/budget/index.md`: the completed 2025–2026 post-season campaign; do not add new-season gifts to this file. `method: in-kind` separates donated goods/services from cash; `assignment` overrides `designation` for team budget allocation. The donor feed follows file order. |
| `_includes/money.html` | Shared dollar formatting for budget tables and individual donations. |
| `_includes/news-coverage.html` | Press links on the homepage and donation page. `news-coverage.md` redirects to the homepage's news section. |
| `_includes/carousel-slides.html` | State-championship/season photos shared by the homepage and donation page. |
| `_data/houston_photos.json` | Houston carousel via `_includes/houston-2026-slides.html`; the homepage's opening Houston photos are maintained separately in `index.md`. |
| `code-of-conduct.md` front matter | `principles`, `shop_safety`, and `flier_copy` supply the conduct page and printable flyers. Keep the long-form explanations consistent with the short copy. |

Event listings in `index.md` and `_includes/season-events/` are maintained separately;
update both when adding an event or moving it into past events. Membership costs appear in
both `index.md` and `code-of-conduct.md`. Financial summaries in page prose are also
manual: changing JSON data does not update those sentences.

The footer in `_layouts/default.html` repeats the meeting location from `index.md`
and mailing address from `donate.md`; keep those copies aligned when an address
changes. Its meeting schedule link points to the homepage so times stay in one place.

### Season Navigation

The main menu has two fixed levels: Home; BIOBUZZ and DECODE as top-level season
groups; then Blog, Events, Roles, Conduct, and Donate. Both seasons have Budget,
Portfolio, and Sponsors links. BIOBUZZ links to the current top-level pages;
DECODE links to its archives. Blog and Events link to their all-season listings.
All season links stay visible, with no expansion or collapse controls. The mobile
Menu button still shows or hides the complete navigation.

Edit `_data/navigation.yml` to change menu entries. The `seasons` list sets the
season groups and their order; `program` sets the top-level links that follow them.
Header and mobile-footer navigation share the same data and stop at two levels.

Season landing pages live at `seasons/<season-name>/index.md`, with lowercase game
names in URLs: `/seasons/biobuzz/` and `/seasons/decode/`. Use full years and game
names in visible titles. Keep these URLs when a season ends. Give each page
`season_year: "YYYY-YYYY"`, `season_label`, and `season_summary` front matter, and
include `{% include season-nav.html %}` after the heading. The season index and
in-page season navigation discover these landing pages automatically, newest first.

Set `season: "YYYY-YYYY"` on posts and other seasonal pages to identify their
season. Budget pages can use their existing `budget_season`; landing pages use
`season_year`. Set `nav_section: /blog/` on posts and seasonal blog listings. For
individual events and seasonal event listings, set `nav_section: /events/` to
highlight the shared Events section.
Exact page links use `aria-current="page"`; section links use `aria-current="location"`.

Existing top-level, event, and blog URLs remain available. `/donate/` stays the
donation page. `/budget/`, `/sponsors/`, and `/portfolio/` render the **current
season** directly, without redirects. Their permanent seasonal counterparts live
under `seasons/<season-name>/<section>/index.md`. DECODE's content is archived at
`/seasons/decode/budget/`, `/seasons/decode/sponsors/`, and
`/seasons/decode/portfolio/`. Links in historical posts, event recaps, and donation
summaries must point to those permanent pages, not the changing current pages.

Current root pages and their season-specific counterparts include the same Markdown
body from `_includes/season-content/<season-name>/`. The root pages carry `season`
metadata and a `canonical_url` pointing to the permanent season URL; the layout uses
that URL for canonical and Open Graph metadata. `sitemap: false` keeps the duplicate
root pages out of the sitemap. All six URLs still render their content directly.
Only permanent budget pages carry `budget_season`, `budget_label`, and
`budget_status`, keeping budget indexes free of duplicate entries.

When a new season starts, create its permanent pages and shared includes, then
update the three root entry points' titles, descriptions, `season`, `canonical_url`,
and include paths. Update navigation so the new current season uses the top-level
URLs and previous seasons use their permanent URLs. Keep old seasonal pages and
includes in place. If new content is not ready, publish a clearly labeled
current-season placeholder linking to the previous season.

Published year-based season paths and older `/budget/YYYY-YYYY/` paths redirect
directly to the corresponding permanent seasonal pages via `redirect_from`.
These are Jekyll HTML redirects, not HTTP 301 or 302 responses. Seasonal blog
listings select posts by their `season` metadata. Seasonal event listings and
landing pages share `_includes/season-events/YYYY-YYYY.md` with the all-season
events page. The summer 2026 planning post belongs to BIOBUZZ; the Houston
retrospective belongs to DECODE. The all-season blog, event, and budget indexes
remain accessible from the season overviews.

### Budget Seasons

The all-season budget index is `/seasons/budgets/`. DECODE's completed accounts
are at `/seasons/decode/budget/`. BIOBUZZ's budget placeholder renders at both
`/budget/` and `/seasons/biobuzz/budget/`, using the shared body in
`_includes/season-content/biobuzz/budget.md`. Historical links point to permanent
season accounts; current-budget links use `/budget/`, and all-season links use
the index.

To add a season, create `seasons/<season-name>/budget/index.md` with `layout: default`, a title
and description, and these front matter fields:

```yaml
budget_season: "2026-2027"
budget_label: 2026–2027 BIOBUZZ
budget_status: Budget in development
```

After the page heading, link to the season overview with “Part of our
[2026–2027 BIOBUZZ season](/seasons/biobuzz/).”, matching the sponsors and portfolio
pages. The all-season budget index discovers budget pages automatically and sorts
newest first. Give
financial data its own `_data/budgets/YYYY-YYYY.json` file when figures are ready.
For shared budget bodies, use `page.budget_season | default: page.season` as the
key into `site.data.budgets`, since root entry points use `season` metadata. Keep
each season's donations separate so later gifts cannot change completed accounts. The BIOBUZZ page currently
states that its budget is in development; no BIOBUZZ financial snapshot is published.

### To Make Changes

1. Edit the relevant `.md` file directly on GitHub or clone the repo locally. After cloning, run `bin/install-hooks` once to enable automatic page timestamps.
2. For local work, run `bundle exec jekyll build`; a successful build is the minimum check for content, layout, Liquid, or navigation changes. Preview visual changes using the instructions below.
3. Commit your changes to `main`
4. GitHub Pages will automatically rebuild the site (usually within a few minutes)

### Page Update Dates

Pages and posts using `layout: default` display `last_modified_at` below their
content. Store a full ISO 8601 timestamp with a timezone in front matter; readers
see the calendar date. These dates record content edits, including small corrections,
and do not imply a policy review or a new financial reporting period.

Run `bin/install-hooks` in each checkout. The pre-commit hook runs
`bin/last-modified --staged`, stamps affected pages in the index, and updates only
the timestamp in their working copies. Partially staged edits stay partially staged;
shared-content changes may stage timestamp-only updates in dependent pages.
Stage the desired changes first, then use `git commit` without file/path arguments.
The hook rejects path-limited commits (`git commit FILE` or `--only`) because Git's
temporary index would otherwise leave inconsistent timestamp changes staged.
The installer preserves existing hooks and explains how to integrate with one.
Ruby is required, as it is for the local Jekyll build.

The script follows literal content includes, `site.data.NAME` references (with
season-specific budget data), and blog/season/budget listings. It considers both
the old and new content so removals and season changes update the former consumers
too. Layouts, the main navigation, in-page season navigation, and presentation-only
includes do not advance dates. Add support in `bin/last-modified` and a regression
test when introducing dynamic includes, a different data-access syntax, or a new
kind of generated listing. Remote asset changes at the same URL are not detected.

`bin/last-modified --backfill` initializes missing timestamps from the latest Git
commit affecting each page or its content sources; it does not stage files. New
pages with no source history get the current time. Existing timestamps are
preserved. Printable flyers keep their explicit document versions
and dates; the hook never changes `document_date`, `version`, or budget reporting dates.

GitHub's **Page timestamps** workflow checks pull requests and pushes to `main`.
It flags missing/invalid timestamps and affected pages whose timestamps did not
advance compared with the change's base. It does not write commits or gate the
existing Pages deployment by itself. For GitHub web edits, update `last_modified_at`
on the page and any affected consumers in the same change. To repair missed updates
locally, stage the content and run `bin/last-modified --staged BASE`, where `BASE`
is the commit before the missed edits, then commit the generated timestamps.
Run `bin/last-modified --check BASE HEAD` to reproduce the check.

Automation regression tests run with `ruby bin/tests/last_modified_test.rb`.

### Editorial Style Guide

Write in a clear institutional voice: warm enough to be readable, but not intimate,
presumptuous, or parental. The site may describe what the program expects and provides;
it should not claim authority over students' character, families' choices, or life outside
the program.

- State observable expectations and consequences directly. Do not infer motives, predict
  who a student will become, or decide whether someone is a “real” team member.
- Explain why a standard matters without scolding, shaming, sarcasm, or forced familiarity.
  Prefer “Participation during build pulses is a core team expectation” to “You have not
  really been on the team.”
- Address families as partners in scheduling, safety, cost, and communication. Do not give
  parenting advice or prescribe conversations at home.
- Use team experience as evidence, not personal anecdote as moral authority. Name what
  happened, what the program learned, and what practice changed.
- Make obligations reciprocal. When the site states what students and families must do,
  also state what coaches and the program will do.
- Prefer concrete language over slogans and abstractions. Preserve a direct tone for safety
  rules and other requirements where ambiguity would create risk.
- Keep fundraising copy confident and active while clearly stating costs, restrictions,
  and how funds will be used.

For substantive stakeholder documents, review the result from the perspectives of the
people affected, such as students, families, coaches, volunteers, and other teams. Focus
on specific likely misunderstandings or harms.

Bylined essays and retrospectives may depart from the site's usual institutional voice when
an individual author's perspective is part of the work. First-person narration, a more
familiar tone, personal reflection, and distinctive phrasing are appropriate in that
context. The bylined [Houston retrospective](/blog/houston-2026/) is a legitimate example:
it is an account by the head coach, not a policy statement written in the organization's
collective voice. A byline should make that authorship clear; it does not require every
personal passage to sound like general site copy.

The long code of conduct is the canonical source for the principles summary and shop-safety
copy. When changing a principle or safety rule, review both its short and full versions for
meaning and tone. Document versions and dates are maintained manually: update them whenever
a substantive revision is published. The code of conduct and shop-safety flyer have separate
version/date metadata and may advance independently.
The principles flyer inherits `version` and `document_date` from `code-of-conduct.md`;
the safety flyer's metadata lives in `print/onepager-shop-safety.md`.

### Adding a New Page

1. Create `pagename.md` with front matter:
   ```yaml
   ---
   layout: default
   title: Page Title
   ---
   ```
2. If the page belongs in the main navigation, add its label and URL to the appropriate section of `_data/navigation.yml`. For seasonal pages, set `season` and, when needed, `nav_section` as described above.
3. Begin the page body with one `# Page Title`, then use `##` for sections and `###` for subsections. The site branding is not a heading. Pages with `banner_image` get their primary heading from the layout, so start their body sections at `##` instead.
4. Run `bundle exec jekyll build` and preview the page.
5. Commit to `main`.

For blog posts, use `_posts/YYYY-MM-DD-slug.md` with `layout`, `title`, `date`,
`author`, and `description` in front matter. The blog index lists posts automatically.
The layout displays the title, date, and author in the hero when `banner_image` is
set; without a banner, include the heading and any visible date/byline in the body.
Preserve old URLs with `redirect_from` when moving a published page or post.

### Images and Page Features

Images are hosted in the BAMVT Cloudflare R2 `assets` bucket at `assets.bamvt.com`,
not stored in this repository. Site images use the `robotics.bamvt.com/` prefix,
followed by their former repository path (for example,
`https://assets.bamvt.com/robotics.bamvt.com/images/chip-180x180-round.png`).
Houston photos and the portfolio PDF keep their existing `ftc-18650/` paths.

Upload new images to this bucket with the correct image content type, then use their
full HTTPS URLs in Markdown, HTML, and front matter. Verify public downloads before
publishing references or removing source files. Preserve media credits and source
notes in the repository, including the kickoff artwork README. Existing event PDFs
remain beside their pages.

Use `_includes/figure.html` for article images (`src`, `alt`, optional `caption` and
`align`) and `_includes/quote.html` for attributed quotes (`text`, `author`, optional
`role`). The main layout provides the figure lightbox, carousels, and portfolio viewer.
The portfolio's `data-pdf` and **Open PDF** link in `seasons/decode/portfolio/index.md` should match;
its viewer loads PDF.js from a CDN.

Content headings use the shared dark blue `--heading` color without decorative rules or
underlines; linked headings inherit that style. Banner titles stay white over photos.

Shared styles and scripts live in the layouts. Existing page-specific exceptions
include the RACI post's inline styles and the donation feed's inline script.

### Adding a Header Image

Any page or blog post can use the shared responsive hero by adding these front matter fields:

```yaml
banner_image: https://assets.bamvt.com/robotics.bamvt.com/images/example.jpg
og_image: https://assets.bamvt.com/robotics.bamvt.com/images/example.jpg
banner_position: 50% 40%
banner_position_mobile: 65% 50%
```

`banner_position` controls the crop's focal point on wider screens. Use
`banner_position_mobile` when the subject needs a different crop on phones. The first
percentage moves the image left/right and the second moves it up/down. Keep important
subjects away from the image edges and verify the result at phone, tablet, and desktop
widths. `og_image` is optional but recommended so the same image appears in social
previews.

### Build and Local Preview

With Ruby and Bundler installed, run `bundle install` to install the dependencies
from `Gemfile`. Run commands from the repository root.

To verify the site without starting a server:

```bash
bundle exec jekyll build
```

To preview with live reload:

```bash
bin/serve
```

Open `http://127.0.0.1:4001/` on the machine running Jekyll. For a remote development
session, forward that port to your browser's machine; also forward port 35729 if
you want automatic browser reloads.

A build checks Liquid and Markdown rendering, but does not verify browser behavior
or remote media. For affected features, check navigation, carousels/lightboxes, and
the portfolio in the browser; check flyers in print preview as well as on screen.

Port **4000 does not work in the maintainer's setup**. `bin/serve` therefore wraps
`bundle exec jekyll serve --livereload --port 4001`. Use this launcher instead of
bare `jekyll serve`, which defaults to 4000. Extra Jekyll flags pass through; for
example, `bin/serve --port 4002` overrides the default if another port is needed.

Before starting a server, check whether a preview for this repository is already
running on 4001 and reuse it. Live reload uses a separate port, **35729**, so
changing only the site port will not avoid a live-reload conflict. If you need a
second instance, choose unused ports for both, for example:

```bash
bin/serve --port 4002 --livereload-port 35730
```

### Sitemap inclusion

`jekyll-sitemap` submits substantive canonical HTML pages. Verification files,
printable copies, PDF downloads, and pages marked `sitemap: false` remain available
at their existing URLs. Static PDFs lack canonical metadata and are excluded using
front-matter defaults in `_config.yml`; the Google verification file is also excluded
through defaults so its bytes remain unchanged.

Season and budget indexes, seasonal blog listings, the BIOBUZZ events listing,
BIOBUZZ budget/sponsor/portfolio placeholders, and the 2025 state championship
page are currently excluded. Remove `sitemap: false` when these pages contain
substantial original content. Root budget/sponsor/portfolio copies and generated
legacy redirects remain excluded as before. No `noindex` directive is needed.

The root `favicon.ico` is derived from the existing 180px round chip logo and
contains 48px and 96px images. The layout retains the existing PNG and Apple icons
and declares both ICO sizes.

The local `sitemap.xml` overrides jekyll-sitemap's default template and uses only
explicit `last_modified_at` values for `lastmod`. These are maintained by the
content timestamp hook described above. Pages without a recorded content timestamp
omit `lastmod`; static files never use filesystem modification times. Do not add a
fallback to post dates, file modification times, or build time. Existing sitemap
exclusions and redirect behavior remain unchanged.
