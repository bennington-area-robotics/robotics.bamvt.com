---
name: update-ftc-events
description: Refresh the northeast FTC events and teams data behind /events/map/ (_data/ftc_events/YYYY-YYYY.json) from the public FTC event listing, review what changed, fix missing locations, and check related event pages. Use when asked to update, refresh, re-pull, or check the FTC events map or event data, or when starting a new season's events map.
---

# Update FTC Events Data

The map at `/events/map/` and the dot-map preview on `/events/` render
`_data/ftc_events/2026-2027.json`.
`bin/ftc-events` regenerates that file from the event data embedded in
`https://ftc-events.firstinspires.org/<season>`. Never edit the JSON by hand: fixes
belong in the script so they survive the next refresh.

## 1. Prepare

- Follow **Resuming Work** in `AGENTS.md`: check `git status --short --branch`,
  preserve existing changes, and branch off `main` before committing (for example
  `ftc-events-refresh-YYYY-MM-DD`).
- Keep a copy of the current file for comparison if it has uncommitted changes:
  `cp _data/ftc_events/2026-2027.json "$SCRATCH/ftc-events-before.json"`, using the
  session scratchpad.

## 2. Refresh

```sh
bin/ftc-events            # current season (2026 -> 2026-2027.json)
```

- To parse a saved copy instead of fetching (offline, or to reproduce a run), pass
  the season and file: `bin/ftc-events 2026 path/to/listing.html`. Save downloaded
  pages in their own scratch directory.
- If the script aborts with `window.<Name> not found`, FIRST has changed the page
  layout. Inspect the page for the embedded `window.*Events` arrays and update
  `embedded`/`groups` in the script; do not fall back to scraping rendered HTML
  without telling the user.
- Unknown `eventType` numbers appear as `Other (<n>)`. Infer the label from event
  names and add it to `TYPES`; also add it, with a color, to the `types` list in
  `events/map/index.md`, and a `.dot--<type>` color to the event styles in
  `_layouts/default.html`.

### Teams layer

Refresh the teams shown on the map with `bin/ftc-teams` (same season argument).
It reads the team tables on FIRST's region pages for the nine states and looks up
only towns that are not already in the file's `places` table (about one second
each, from OpenStreetMap). If it warns `No location found for <Town, ST>`, add
`"Town, ST": [lat, lon]` to `places` by hand and rerun. If a region warns that it
lists no teams, check whether FIRST renamed or split the region and update
`REGIONS`. Report the change in team count; FIRST adds teams throughout the season.

## 3. Review the changes

```sh
.claude/skills/update-ftc-events/scripts/diff-events _data/ftc_events/2026-2027.json
# or: .../diff-events "$SCRATCH/ftc-events-before.json" _data/ftc_events/2026-2027.json
```

This lists added, removed, and changed events by code, plus every event with an
approximate location. Look at it with these questions:

- **Removed events.** FTC may have cancelled an event or given it a new code. Check
  `https://ftc-events.firstinspires.org/<season>/<CODE>` before reporting a
  cancellation.
- **Missing coordinates.** The script warns `No coordinates for <season>/<CODE>`.
  Look up the venue (OpenStreetMap Nominatim works; send a generic User-Agent and
  at most one request per second) and add `'<season>/<CODE>' => [lat, lon]` to
  `VENUES` with a comment naming the venue. Use `FALLBACK` (city-level, flagged
  `location_approximate`) only when the venue can't be found. The script warns
  about `VENUES` and `CORRECTIONS` entries whose events have left the listing;
  remove them.
- **Organizer corrections.** When a regional organizer's site confirms a different
  venue than FIRST lists, add a `CORRECTIONS` entry with the source URL as a comment.
  Report suspected FIRST errors you can't confirm instead of correcting them.
- **Coordinates far from the city.** The source stores longitude in `lat` and
  latitude in `lon`; the script swaps them. If many points land in the wrong place,
  check whether FIRST fixed that quirk.
- **Data quirks.** Trailing commas, doubled spaces, or blank websites belong in the
  script's normalization, not in manual JSON edits.

## 4. Check pages that repeat event details

The map is generated, but some event details are maintained by hand. When an event
we host or plan to attend changes (dates, venue, or cancellation), tell the user and
update the copies when asked:

- `_data/events.yml`: our own events, which drive `/events/`, the season
  overviews, and the gold rings on the map (matched by `ftc` code). Update dates,
  venues, and codes there when FIRST changes them.
- `index.md`: next-event summary on the homepage.
- `events/<event-name>/index.md`: our own event pages, such as
  `events/southern-vermont-qualifier-2027/`.

Vermont events (`state: VT`) and the qualifiers in this list are the ones most
likely to matter.

## 5. Verify and finish

- `bundle exec jekyll build` must succeed. Spot-check the map page in the preview
  (`bin/serve`, port 4001; reuse a running preview) when the page or the event types
  changed.
- The pre-commit hook updates `last_modified_at` on the map page when the data
  changes; do not edit it by hand.
- Report to the user: counts of added, removed, and changed events; anything
  affecting Vermont events or our own events; and new approximate locations.
  Commit or open a PR only when asked.

## New season

For a new season (for example 2027–2028):

1. Run `bin/ftc-events 2027` to create `_data/ftc_events/2027-2028.json`.
2. In `events/map/index.md` and `events/index.md`, change
   `site.data.ftc_events["..."]` and the `event-dot-map.html` season to the new
   file, and update the map page's title, `season`, and description.
3. Keep the previous season's data file. Add the new season to `_data/events.yml`
   (with its FTC codes so the map can ring our events). Update the season years in
   `VENUES`/`CORRECTIONS` keys as new entries are needed, `AGENTS.md`, the
   README's **Shared Content and Data** table, and this skill's paths.
