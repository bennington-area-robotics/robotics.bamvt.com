---
last_modified_at: 2026-10-17T14:50:57Z
layout: default
title: 2025–2026 DECODE Photos
description: Robots, students, competition, and workshop photos from Bennington Area Robotics's DECODE season, including Vermont Championship and Houston.
season: "2025-2026"
---

# 2025–2026 DECODE Photos

Part of our [2025–2026 DECODE season](/seasons/decode/).

From building and practicing in Bennington to competing in Vermont and Houston. Select a photo to enlarge it, then use the arrows or swipe to browse that collection.

[Vermont Championship](#vermont-championship) · [In the Workshop](#in-the-workshop) · [Houston](#houston)

## Vermont Championship

Robots, drive teams, and awards at the [2026 Vermont FTC State Championship](/events/state-championship-2026/). Photos courtesy of UVM.

{% assign vermont_photos = site.data.decode_photos | where: "album", "vermont" %}
{% include photo-gallery.html photos=vermont_photos label="Vermont Championship photos" %}

## In the Workshop

A closer look at our robots, practice field, and team during the DECODE season.

{% assign workshop_photos = site.data.decode_photos | where: "album", "workshop" %}
{% include photo-gallery.html photos=workshop_photos label="Workshop and team photos" %}

## Houston

Cookie Clickers at FIRST Championship, April 29–May 2, 2026, with photos from the pits, competition fields, and the trip. [Read the Houston retrospective](/blog/houston-2026/).

{% include photo-gallery.html photos=site.data.houston_photos label="Houston photos" %}
