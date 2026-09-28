---
layout: default
redirect_from: /budget/
title: Budgets
description: Season budgets and completed financial accounts for Bennington Area Robotics.
---

# Budgets

Season budgets for Bennington Area Robotics's FTC teams, 18650 Cookie Clickers and 32473 Bennington Bolts and Biscuits. Choose a season to see its budget status, spending plans, or completed accounts.

{% assign budget_pages = site.pages | where_exp: "item", "item.budget_season" | sort: "budget_season" | reverse %}
{% for season in budget_pages %}
## [{{ season.budget_label }}]({{ season.url | relative_url }})

{{ season.budget_status }}.

{% endfor %}

[Support our teams](/donate).
