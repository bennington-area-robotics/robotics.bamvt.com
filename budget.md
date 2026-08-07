---
layout: default
title: Budget
description: Season budgets for Bennington Area Robotics FTC teams, 18650 Cookie Clickers and 32473 Bennington Bolts and Biscuits.
---

Bennington Area Robotics ran two FTC teams in 2025-26 on a combined regular-season cash budget of roughly $7,200, funded by local businesses, community organizations, foundations, and family co-pays, plus about $2,400 of in-kind support (equipment, food, and discounts).

Then came the post-season. Cookie Clickers won the [Vermont Championship](/events/state-championship-2026) and advanced to "Worlds", the [FIRST Championship](/events/first-championship-2026) in Houston TX, April 29-May 2. First-year team Bolts and Biscuits placed 7th overall and advanced to the New England Premier Event, April 17-18. Our community responded: nearly 50 donations totaling over $24,000 — past our $23,500 goal — arrived in the weeks before the events, and an airline donated the students' flights in-kind. Thank you. You sent them.

Advancement created entirely new budget needs 3-4x the size of our regular season spending. Cookie Clickers alone went from a $3,500 regular season to a $20,000 post-season budget — and closed the books under it, at $18,515. Aside from travel and lodging, post-season registration fees alone ($4,000) could easily fund a third team for next year. Event registration fees in Vermont are often waived in exchange for outreach and participation; out-of-state registration fees are not!

Thus we see that FTC Robotics in Vermont is normally quite affordable, until the teams do well enough to advance out of state, where budgets are larger, teams are more competitive, and everyone travels further to attend more events. Despite the cost, advancement is a good experience for the students, to see their same activity pursued at higher levels of accomplishment, and understand themselves as peers on the national and international level. The post-season surplus of roughly $3,400 covered the regular season's small deficit and carries about $3,140 into the 2026-27 season.

### About Us

Bennington Area Robotics is a program of **The Bennington Area Makers, Inc.** (BAMVT), a 501(c)(3) nonprofit organization with EIN 84-5124653. All donations are tax-deductible to the extent permitted by law. [How to donate](/donate).

{% assign budget = site.data.budget %}

{% comment %}Compute regular-season totals{% endcomment %}
{% assign rs_inc = 0 %}
{% assign rs_exp = 0 %}
{% assign rs_ink = 0 %}
{% for team in budget.regular_season.teams %}
  {% for i in team.income %}{% assign rs_inc = rs_inc | plus: i.amount %}{% endfor %}
  {% for e in team.expenses %}{% assign rs_exp = rs_exp | plus: e.amount %}{% endfor %}
  {% for k in team.in_kind %}{% assign rs_ink = rs_ink | plus: k.value %}{% endfor %}
{% endfor %}

{% comment %}Compute post-season totals{% endcomment %}
{% assign ps_inc = 0 %}
{% assign ps_ink = 0 %}
{% for d in site.data.donations.donations %}
  {% if d.method == "in-kind" %}
    {% assign ps_ink = ps_ink | plus: d.amount %}
  {% else %}
    {% assign ps_inc = ps_inc | plus: d.amount %}
  {% endif %}
{% endfor %}
{% assign ps_exp = 0 %}
{% for team in budget.post_season.teams %}
  {% for e in team.expenses %}{% if e.actual %}{% assign ps_exp = ps_exp | plus: e.actual %}{% endif %}{% endfor %}
{% endfor %}

{% assign total_inc = rs_inc | plus: ps_inc %}
{% assign total_exp = rs_exp | plus: ps_exp %}

<table class="summary-table">
<thead><tr><th></th><th style="text-align:right">Regular Season</th><th style="text-align:right">Post-Season</th><th style="text-align:right">Total</th></tr></thead>
<tbody>
<tr><td>Cash Income</td><td style="text-align:right">{% include money.html amount=rs_inc %}</td><td style="text-align:right">{% include money.html amount=ps_inc %}</td><td style="text-align:right">{% include money.html amount=total_inc %}</td></tr>
<tr><td>Expenses</td><td style="text-align:right">{% include money.html amount=rs_exp %}</td><td style="text-align:right">{% include money.html amount=ps_exp %}</td><td style="text-align:right">{% include money.html amount=total_exp %}</td></tr>
{% assign total_ink = rs_ink | plus: ps_ink %}
<tr><td>In-Kind Support</td><td style="text-align:right">{% include money.html amount=rs_ink %}</td><td style="text-align:right">{% include money.html amount=ps_ink %}</td><td style="text-align:right">{% include money.html amount=total_ink %}</td></tr>
{% assign rs_net = rs_inc | minus: rs_exp %}
{% assign ps_net = ps_inc | minus: ps_exp %}
{% assign total_net = total_inc | minus: total_exp %}
<tr><td><strong>Net (cash)</strong></td><td style="text-align:right"><strong>{% if rs_net < 0 %}<span style="color:var(--accent)">{% include money.html amount=rs_net %}</span>{% else %}+{% include money.html amount=rs_net %}{% endif %}</strong></td><td style="text-align:right"><strong>{% if ps_net < 0 %}<span style="color:var(--accent)">{% include money.html amount=ps_net %}</span>{% else %}<span style="color:#2a9d8f">+{% include money.html amount=ps_net %}</span>{% endif %}</strong></td><td style="text-align:right"><strong>{% if total_net < 0 %}<span style="color:var(--accent)">{% include money.html amount=total_net %}</span>{% else %}<span style="color:#2a9d8f">+{% include money.html amount=total_net %}</span>{% endif %}</strong></td></tr>
</tbody>
</table>

Budgets are pooled at the organization level: BAMVT covers any one team's shortfall from shared funds, and the post-season surplus absorbed the regular season's combined deficit of about $240.

## {{ budget.post_season.label }}

*Note: All receipts are reconciled and totals are final. "Actual" shows what BAM paid; a blank Actual means no BAM funds were spent on that line — unused contingency, or costs families covered directly. Students' airfare to Houston was donated in-kind and appears under In-Kind Support, which is why the cash Flights line came in well under budget. Every gift is listed in the [donor feed](/donate).*

{% for team in budget.post_season.teams %}
### {{ team.name }}

{% if team.description %}{{ team.description | markdownify }}{% endif %}

{% if team.donation_recipient %}
{% assign d_total = 0 %}
{% assign d_family = 0 %}
{% assign d_community = 0 %}
{% assign d_alumni = 0 %}
{% assign d_orgs = "" %}
{% assign d_inkind = "" %}
{% assign d_inkind_total = 0 %}
{% for d in site.data.donations.donations %}
  {% assign d_team = d.assignment | default: d.designation %}
  {% if d_team == team.donation_recipient %}
    {% if d.method == "in-kind" %}
      {% if d_inkind != "" %}{% assign d_inkind = d_inkind | append: "|" %}{% endif %}
      {% assign ink_label = d.donor %}{% if d.memo %}{% assign ink_label = ink_label | append: " (" | append: d.memo | append: ")" %}{% endif %}
      {% assign d_inkind = d_inkind | append: ink_label | append: ":" | append: d.amount %}
      {% assign d_inkind_total = d_inkind_total | plus: d.amount %}
    {% else %}
      {% assign d_total = d_total | plus: d.amount %}
      {% if d.type == "organization" %}
        {% if d_orgs != "" %}{% assign d_orgs = d_orgs | append: "|" %}{% endif %}
        {% assign d_orgs = d_orgs | append: d.donor | append: ":" | append: d.amount %}
      {% elsif d.type == "family" %}
        {% assign d_family = d_family | plus: d.amount %}
      {% elsif d.type == "alumni" %}
        {% assign d_alumni = d_alumni | plus: d.amount %}
      {% else %}
        {% assign d_community = d_community | plus: d.amount %}
      {% endif %}
    {% endif %}
  {% endif %}
{% endfor %}
<table>
<thead><tr><th></th><th style="text-align:right">Budget</th><th style="text-align:right">Actual</th></tr></thead>
<tbody>
<tr><td colspan="3"><strong>Income</strong></td></tr>
{% if d_family > 0 %}<tr><td>Family</td><td></td><td style="text-align:right">{% include money.html amount=d_family %}</td></tr>{% endif %}
{% if d_community > 0 %}<tr><td>Community</td><td></td><td style="text-align:right">{% include money.html amount=d_community %}</td></tr>{% endif %}
{% if d_alumni > 0 %}<tr><td>Alumni</td><td></td><td style="text-align:right">{% include money.html amount=d_alumni %}</td></tr>{% endif %}
{% if d_orgs != "" %}
{% assign org_entries = d_orgs | split: "|" | reverse %}
{% for entry in org_entries %}
{% assign parts = entry | split: ":" %}
{% assign org_name = parts[0] %}{% assign org_amount = parts[1] %}
<tr><td>{{ org_name }}</td><td></td><td style="text-align:right">{% include money.html amount=org_amount %}</td></tr>
{% endfor %}
{% endif %}
<tr><td><strong>Total Income</strong></td><td></td><td style="text-align:right"><strong>{% include money.html amount=d_total %}</strong></td></tr>
{% if team.expenses %}
<tr><td colspan="3"><strong>Expenses</strong></td></tr>
{% assign ps_team_exp = 0 %}
{% assign ps_team_act = 0 %}
{% assign has_any_actual = false %}
{% for e in team.expenses %}
{% assign ps_team_exp = ps_team_exp | plus: e.amount %}
{% if e.actual %}{% assign ps_team_act = ps_team_act | plus: e.actual %}{% assign has_any_actual = true %}{% endif %}
<tr><td>{{ e.category }}</td><td style="text-align:right">{% if e.amount %}{% if e.estimated %}~{% endif %}{% include money.html amount=e.amount %}{% else %}TBD{% endif %}</td><td style="text-align:right">{% if e.actual %}{% include money.html amount=e.actual %}{% endif %}</td></tr>
{% endfor %}
{% if ps_team_exp > 0 %}
<tr><td><strong>Total Expenses</strong></td><td style="text-align:right"><strong>{% include money.html amount=ps_team_exp %}</strong></td><td style="text-align:right">{% if has_any_actual %}<strong>{% include money.html amount=ps_team_act %}</strong>{% endif %}</td></tr>
{% if has_any_actual %}
{% assign ps_team_net = d_total | minus: ps_team_act %}
<tr><td><strong>Net</strong></td><td></td><td style="text-align:right"><strong>{% if ps_team_net < 0 %}<span style="color:var(--accent)">{% include money.html amount=ps_team_net %}</span>{% else %}<span style="color:#2a9d8f">+{% include money.html amount=ps_team_net %}</span>{% endif %}</strong></td></tr>
{% endif %}
{% endif %}
{% endif %}
{% if d_inkind != "" %}
<tr><td colspan="3"><strong>In-Kind Support</strong></td></tr>
{% assign inkind_entries = d_inkind | split: "|" %}
{% for entry in inkind_entries %}
{% assign parts = entry | split: ":" %}
{% assign ink_name = parts[0] %}
{% assign ink_amount = parts[1] %}
<tr><td>{{ ink_name }}</td><td></td><td style="text-align:right">{% include money.html amount=ink_amount %}</td></tr>
{% endfor %}
<tr><td><strong>Total In-Kind</strong></td><td></td><td style="text-align:right"><strong>{% include money.html amount=d_inkind_total %}</strong></td></tr>
{% endif %}
</tbody>
</table>
{% endif %}

{% endfor %}

## {{ budget.regular_season.label }}

{% for team in budget.regular_season.teams %}
### {{ team.name }}

{% if team.note %}{{ team.note }}{% endif %}

{% assign inc_total = 0 %}
{% for i in team.income %}{% assign inc_total = inc_total | plus: i.amount %}{% endfor %}
{% assign exp_total = 0 %}
{% for e in team.expenses %}{% assign exp_total = exp_total | plus: e.amount %}{% endfor %}
{% assign net = inc_total | minus: exp_total %}

<table>
<thead><tr><th></th><th style="text-align:right">Amount</th></tr></thead>
<tbody>
{% if team.income %}
<tr><td colspan="2"><strong>{% if team.in_kind %}Cash {% endif %}Income</strong></td></tr>
{% for i in team.income %}
<tr><td>{{ i.source }}</td><td style="text-align:right">{% include money.html amount=i.amount %}</td></tr>
{% endfor %}
<tr><td><strong>Total{% if team.in_kind %} Cash{% endif %} Income</strong></td><td style="text-align:right"><strong>{% include money.html amount=inc_total %}</strong></td></tr>
{% endif %}
{% if team.expenses %}
<tr><td colspan="2"><strong>Expenses</strong></td></tr>
{% for e in team.expenses %}
<tr><td>{{ e.category }}</td><td style="text-align:right">{% if e.amount %}{% if e.estimated %}~{% endif %}{% include money.html amount=e.amount %}{% else %}TBD{% endif %}</td></tr>
{% endfor %}
<tr><td><strong>Total Expenses</strong></td><td style="text-align:right"><strong>{% include money.html amount=exp_total %}</strong></td></tr>
{% if net < 0 %}
<tr><td><strong>Net</strong></td><td style="text-align:right"><strong style="color:var(--accent)">{% include money.html amount=net %}</strong></td></tr>
{% else %}
<tr><td><strong>Net</strong></td><td style="text-align:right"><strong style="color:#2a9d8f">+{% include money.html amount=net %}</strong></td></tr>
{% endif %}
{% endif %}
{% if team.in_kind %}
{% assign ink_total = 0 %}
{% for k in team.in_kind %}{% assign ink_total = ink_total | plus: k.value %}{% endfor %}
<tr><td colspan="2"><strong>In-Kind Support</strong></td></tr>
{% for k in team.in_kind %}
<tr><td>{{ k.source }}</td><td style="text-align:right">{% include money.html amount=k.value %}</td></tr>
{% endfor %}
<tr><td><strong>Total In-Kind</strong></td><td style="text-align:right"><strong>{% include money.html amount=ink_total %}</strong></td></tr>
{% endif %}
</tbody>
</table>

{% endfor %}

*Note: The regular season budget above does not include family out-of-pocket costs for event travel, food, and lodging for Vermont events, before post-season advancement.*
