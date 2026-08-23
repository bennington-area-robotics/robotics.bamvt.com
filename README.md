# Bennington Area Robotics

Source for the [Bennington Area Robotics website](https://bennington-area-robotics.github.io).

## Editing the Site

This is a [Jekyll](https://jekyllrb.com/) site hosted on GitHub Pages. Pages are written in Markdown.

### Architecture

- **Content pages** (`*.md` in root): Markdown with YAML front matter. Each page specifies `layout: default`.
- **Layout** (`_layouts/default.html`): Single template with all HTML structure and inline CSS. Provides header with navigation, main content area, and footer.
- **Config** (`_config.yml`): Site metadata (title, description, URL) and kramdown markdown settings.

### Key Files

- `index.md` – Homepage content
- `qualifiers.md` – Qualifiers event page
- `sponsors.md` – Sponsors page
- `_config.yml` – Site configuration (title, description, URL)
- `_layouts/default.html` – Page template (HTML structure and CSS)

### To Make Changes

1. Edit the relevant `.md` file directly on GitHub or clone the repo locally
2. Commit your changes to `main`
3. GitHub Pages will automatically rebuild the site (usually within a few minutes)

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

### Adding a New Page

1. Create `pagename.md` with front matter:
   ```yaml
   ---
   layout: default
   title: Page Title
   ---
   ```
2. Add navigation link in `_layouts/default.html` within the `<nav>` element
3. Commit to `main`

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

### Local Preview (Optional)

```bash
bin/serve
```

This wraps `bundle exec jekyll serve --livereload`. Pass extra Jekyll flags through, e.g. `bin/serve --port 4001` if 4000 is in use.
