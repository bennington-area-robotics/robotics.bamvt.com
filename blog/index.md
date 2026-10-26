---
last_modified_at: 2026-10-26T13:58:20Z
layout: default
title: Blog
description: News and updates from Bennington Area Robotics teams 18650 Cookie Clickers and 32473 Bennington Bolts and Biscuits.
---

# Blog

Reports and working notes from Bennington Area Robotics. Read about the Cookie
Clickers' first trip to FIRST Championship in Houston, or see how students,
mentors, and volunteers share responsibility during summer planning. Each article
records the team's experience or plans at the time it was published.

{% for post in site.posts %}
## [{{ post.title }}]({{ post.url | relative_url }})
{: .post-list-title}

*{{ post.date | date: "%B %-d, %Y" }}*

{% if post.description %}{{ post.description }}{% endif %}
{% endfor %}
