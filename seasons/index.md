---
layout: default
title: Seasons
description: Explore Bennington Area Robotics seasons, with events, budgets, sponsors, and engineering portfolios.
---

# Seasons

Follow our FTC teams through each season, from kickoff and robot development to competition and community support.

{% assign season_pages = site.pages | where_exp: "item", "item.season_year" | sort: "season_year" | reverse %}
{% for season in season_pages %}
## [{{ season.season_label }}]({{ season.url | relative_url }})

{{ season.season_summary }}

{% endfor %}
