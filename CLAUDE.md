# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Jekyll site for Bennington Area Robotics (robotics.bamvt.com) — FTC teams 18650 Cookie Clickers and 32473 Bennington Bolts and Biscuits. Hosted on GitHub Pages. This is a standalone repo within the `bennington-area-robotics` VS Code workspace.

## Build & Preview

No local build tooling required. Jekyll builds run automatically on GitHub Pages when pushed to `main`. For local preview: `bundle exec jekyll serve`.

## Architecture

- **Single layout**: `_layouts/default.html` contains all HTML structure, CSS (inline `<style>`), and JavaScript (carousel, lightbox). There is no external CSS or JS.
- **Content pages**: Markdown files with YAML front matter (`layout: default`, `title`, optional `description` and `og_image`). Root-level `.md` files become top-level pages.
- **Event pages**: Nested under `events/<event-name>/index.md` with associated `images/` directories.
- **Data-driven content**: `_data/donations.json` drives the donation progress bar and feed on `donate.md` via Liquid templating.
- **Shared include**: `_includes/carousel-slides.html` defines the photo carousel slides, reused on both `index.md` and `donate.md`.
- **Navigation**: Defined inline in `_layouts/default.html` as a comma-separated string parsed by Liquid. To add a nav link, edit the `nav_items` assignment in the layout.

## Conventions

- Markdown uses kramdown syntax. External links use `{:target="_blank"}`.
- All styling is inline in `_layouts/default.html` using CSS custom properties (e.g., `--primary`, `--accent`).
- Images live alongside their event pages in `events/<event>/images/` or in the root `images/` directory.
- The `jekyll-redirect-from` plugin is available for URL redirects via front matter.
- Pages can use `{#anchor-id}` kramdown syntax for heading anchors.
- Fundraising and call-to-action copy should use confident, active language — avoid hedging ("hoping to", "trying to", "would like to").

## Editorial & Review Process

- **Fable advisor pattern.** At key junctures in substantive writing work — a major edit, a structural decision, before finalizing a document — consult the **Fable model** (`claude-fable-5`) as an advisor, not just as a final proofread. Spawn Fable subagents (`Agent` with `model: "fable"`) to critique the current draft; Fable's perception surfaces how prose and decisions will actually land. For stakeholder-facing documents (e.g. the code of conduct), run one Fable advisor per audience lens (student, family, coach, FIRST/other teams) in parallel, ask each for concise prioritized findings rather than a rewrite, then synthesize across lenses.
- **Voice is intentionally sharp.** Do not reflexively soften direct, sharp language in the prose. Discomfort that serves the message stays; advisors should flag only where sharpness genuinely *misfires* for a reader, not wherever it stings.

## Key Files

| File | Purpose |
|------|---------|
| `_config.yml` | Site title, description, URL, plugins |
| `_layouts/default.html` | All HTML/CSS/JS for the site |
| `_includes/carousel-slides.html` | Photo carousel slide definitions |
| `_data/donations.json` | Donation records (goal, donor list) |
| `donate.md` | Donation page with Liquid-driven progress bar |
| `index.md` | Homepage with events, team info, news |
