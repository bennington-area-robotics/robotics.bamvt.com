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
