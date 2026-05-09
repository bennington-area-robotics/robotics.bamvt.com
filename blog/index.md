---
layout: default
title: Blog
description: News and updates from Bennington Area Robotics teams 18650 Cookie Clickers and 32473 Bennington Bolts and Biscuits.
---

## Blog

{% for post in site.posts %}
### [{{ post.title }}]({{ post.url | relative_url }})

*{{ post.date | date: "%B %-d, %Y" }}*

{% if post.description %}{{ post.description }}{% endif %}
{% endfor %}
