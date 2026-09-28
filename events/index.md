---
layout: default
title: Events
---

# Events

## 2026–2027 BIOBUZZ

{% capture current_events %}{% include season-events/2026-2027.md %}{% endcapture %}
{{ current_events | replace: '## ', '### ' }}

## 2025–2026 DECODE

{% capture past_events %}{% include season-events/2025-2026.md %}{% endcapture %}
{{ past_events | remove: '## Events and Results' }}
