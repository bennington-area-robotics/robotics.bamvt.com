---
last_modified_at: 2026-11-05T03:32:26Z
description: "Events Bennington Area Robotics hosts and competes in, season by season, with results, plus a map of FTC events across the northeast."
layout: default
title: Events
banner_image: https://assets.bamvt.com/robotics.bamvt.com/events/state-championship-2026/images/2026_FTC-136.jpg
banner_position: 50% 62%
banner_position_mobile: 42% 62%
og_image: https://assets.bamvt.com/robotics.bamvt.com/events/state-championship-2026/images/2026_FTC-136.jpg
---

Bennington Area Robotics competes in FIRST Tech Challenge events across Vermont and co-hosts a qualifier in Bennington each season. Event pages have schedules, team lists, results, and video.

<nav class="event-season-jump" aria-label="Seasons on this page">
{%- for s in site.data.events.seasons %}
  <a href="#{{ s.anchor }}">{{ s.label }} <strong>{{ s.game }}</strong></a>
{%- endfor %}
</nav>

<div class="event-hub-top">
{% include event-next.html %}
{%- assign ftc = site.data.ftc_events["2026-2027"] %}
<a class="event-map-callout" href="{{ '/events/map/' | relative_url }}">
  {% include event-dot-map.html season="2026-2027" %}
  <span class="event-map-callout-text">
    <strong>Northeast FTC events map</strong>
    {{ ftc.events | size }} BIOBUZZ events in New England, New York, and New Jersey, with distances from Bennington.
    <span class="event-map-callout-cta">Open the map</span>
  </span>
</a>
</div>

{% for s in site.data.events.seasons %}
<section class="event-season" aria-labelledby="{{ s.anchor }}">
<h2 id="{{ s.anchor }}">{{ s.label }} {{ s.game }}</h2>
<p class="event-season-summary">{{ s.summary }}{% if s.url %} <a href="{{ s.url | relative_url }}">Season overview</a>{% endif %}</p>
{% include event-timeline.html season=s.id %}
</section>
{% endfor %}

<p class="event-photo-credit">Banner: Bennington Bolts and Biscuits and Cookie Clickers robots on the field at the 2026 Vermont Championship. Photo courtesy of UVM. Map preview: event data from the <a href="https://ftc-events.firstinspires.org/services/API" target="_blank">FIRST Tech Challenge Events API</a>; venue locations &copy; <a href="https://www.openstreetmap.org/copyright" target="_blank">OpenStreetMap contributors</a> (ODbL).</p>
