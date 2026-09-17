# Bennington Area Robotics

Source for the [Bennington Area Robotics website](https://robotics.bamvt.com).

## Editing the Site

This is a [Jekyll](https://jekyllrb.com/) site hosted on GitHub Pages. Pages are written in Markdown.

### Architecture

- **Content pages**: Markdown with YAML front matter, usually specifying `layout: default`. Top-level pages live in the root; event pages live under `events/<event-name>/index.md` alongside their images and documents.
- **Main layout** (`_layouts/default.html`): Template with HTML structure, inline CSS, and JavaScript. Provides a sticky left sidebar on desktop, an expandable navigation menu on smaller screens, main content, and a footer that repeats navigation in a blue section on smaller screens. Page banners appear in the content column. Navigation comes from its comma-separated `nav_items` assignment (`Label:/path`).
- **Printable flyers** (`_layouts/flier.html`, `print/`): A separate layout and entry pages render the principles and shop-safety flyers from canonical content in `code-of-conduct.md`.
- **Blog** (`_posts/`, `blog/index.md`): Dated Markdown posts and the blog index. Post URLs use `/blog/:slug/`, as configured in `_config.yml`.
- **Shared content** (`_includes/`, `_data/`): Reusable Liquid fragments and structured public data.
- **Config** (`_config.yml`): Site metadata (title, description, URL) and kramdown markdown settings.

### Key Files

- `index.md` – Homepage content
- `events/index.md` – Event listing; individual events live under `events/`
- `blog/index.md` and `_posts/` – Blog listing and posts
- `sponsors.md` – Sponsors page
- `budget.md` and `donate.md` – Public financial summary and donation page
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

Some edits affect several pages. Check the consumers when changing these sources:

| Source | Used by / editing notes |
|--------|-------------------------|
| `_data/budget.json` | `budget.md`: regular-season income and expenses, plus post-season budgets and actual expenses. |
| `_data/donations.json` | `donate.md`, `sponsors.md`, and `budget.md`: the completed post-season campaign. `method: in-kind` separates donated goods/services from cash; `assignment` overrides `designation` for team budget allocation. The donor feed follows file order. |
| `_includes/money.html` | Shared dollar formatting for budget tables and individual donations. |
| `_includes/news-coverage.html` | Press links on the homepage and donation page. `news-coverage.md` redirects to the homepage's news section. |
| `_includes/carousel-slides.html` | State-championship/season photos shared by the homepage and donation page. |
| `_data/houston_photos.json` | Houston carousel via `_includes/houston-2026-slides.html`; the homepage's opening Houston photos are maintained separately in `index.md`. |
| `code-of-conduct.md` front matter | `principles`, `shop_safety`, and `flier_copy` supply the conduct page and printable flyers. Keep the long-form explanations consistent with the short copy. |

Event listings in `index.md` and `events/index.md` are maintained separately; update
both when adding an event or moving it into past events. Membership costs appear in
both `index.md` and `code-of-conduct.md`. Financial summaries in page prose are also
manual: changing JSON data does not update those sentences.

### To Make Changes

1. Edit the relevant `.md` file directly on GitHub or clone the repo locally
2. For local work, run `bundle exec jekyll build`; a successful build is the minimum check for content, layout, Liquid, or navigation changes. Preview visual changes using the instructions below.
3. Commit your changes to `main`
4. GitHub Pages will automatically rebuild the site (usually within a few minutes)

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
2. If the page belongs in the main navigation, add a `Label:/path` entry to the comma-separated `nav_items` assignment in `_layouts/default.html`.
3. Run `bundle exec jekyll build` and preview the page.
4. Commit to `main`.

For blog posts, use `_posts/YYYY-MM-DD-slug.md` with `layout`, `title`, `date`,
`author`, and `description` in front matter. The blog index lists posts automatically.
The layout displays the title, date, and author in the hero when `banner_image` is
set; without a banner, include the heading and any visible date/byline in the body.
Preserve old URLs with `redirect_from` when moving a published page or post.

### Images and Page Features

Local images live in `images/` or beside event pages. Houston photos and the portfolio
PDF are hosted at `bamvt.curlycabbage.com`; they are not stored in this repository.
Preserve media credits and source notes, including the kickoff artwork README.

Use `_includes/figure.html` for article images (`src`, `alt`, optional `caption` and
`align`) and `_includes/quote.html` for attributed quotes (`text`, `author`, optional
`role`). The main layout provides the figure lightbox, carousels, and portfolio viewer.
The portfolio's `data-pdf` and **Open PDF** link in `portfolio/index.md` should match;
its viewer loads PDF.js from a CDN.

Shared styles and scripts live in the layouts. Existing page-specific exceptions
include the RACI post's inline styles and the donation feed's inline script.

### Adding a Header Image

Any page or blog post can use the shared responsive hero by adding these front matter fields:

```yaml
banner_image: /images/example.jpg
og_image: /images/example.jpg
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
