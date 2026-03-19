---
layout: default
title: Budget
description: Season budgets for Bennington Area Robotics FTC teams — Cookie Clickers (18650) and Bolts and Biscuits (32473).
---

Bennington Area Robotics runs two FTC teams on a combined regular-season cash budget of roughly $6,900, funded by local businesses, community organizations, and foundations, plus about $2,100 in in-kind support (equipment, food, and discounts).

We are now hoping to raise an additional $23,500 for post-season advancement. Cookie Clickers won the Vermont Championship and is now advancing to "Worlds", the FIRST Championship in Houston TX from April 29-May 2. First-year team Bolts and Biscuits placed 7th overall and is advancing to the New England Premier Event from April 17-18.

Their success has created entirely new budget needs 3-4x the size of our regular season spending. Cookie Clickers alone went from a $3,100 regular season to an estimated $20,000 post-season budget. Aside from travel and lodging, post-season registration fees alone ($4,000) could easily fund a third team for next year. Event registration fees in Vermont are often waived in exchange for outreach and participation; out-of-state registration fees are not!

Thus we see that FTC Robotics in Vermont is normally quite affordable, until the teams do well enough to advance out of state, where budgets are larger, teams are more competitive, and everyone travels further to more events. Despite the cost, advancement is a good experience for the students, to see their same activity pursued at higher levels of accomplishment, and understand themselves as peers on the national and international level.

{% assign budget = site.data.budget %}

{% comment %}Compute regular season totals{% endcomment %}
{% assign rs_inc = 0 %}{% assign rs_exp = 0 %}{% assign rs_ink = 0 %}
{% for team in budget.regular_season.teams %}
  {% for i in team.income %}{% assign rs_inc = rs_inc | plus: i.amount %}{% endfor %}
  {% for e in team.expenses %}{% assign rs_exp = rs_exp | plus: e.amount %}{% endfor %}
  {% if team.in_kind %}{% for k in team.in_kind %}{% assign rs_ink = rs_ink | plus: k.value %}{% endfor %}{% endif %}
{% endfor %}
{% assign rs_net = rs_inc | minus: rs_exp %}

{% comment %}Compute post-season donation totals{% endcomment %}
{% assign ps_inc = 0 %}
{% for d in site.data.donations.donations %}
  {% assign ps_inc = ps_inc | plus: d.amount %}
{% endfor %}
{% assign ps_exp = 0 %}
{% for team in budget.post_season.teams %}
  {% if team.estimated_total %}{% assign ps_exp = ps_exp | plus: team.estimated_total %}{% endif %}
{% endfor %}
{% assign total_inc = rs_inc | plus: ps_inc %}
{% assign total_exp = rs_exp | plus: ps_exp %}

<table class="summary-table">
<thead><tr><th></th><th style="text-align:right">Regular Season</th><th style="text-align:right">Post-Season</th><th style="text-align:right">Total</th></tr></thead>
<tbody>
<tr><td>Cash Income</td><td style="text-align:right">{% include money.html amount=rs_inc %}</td><td style="text-align:right">{% include money.html amount=ps_inc %}</td><td style="text-align:right">{% include money.html amount=total_inc %}</td></tr>
<tr><td>Expenses</td><td style="text-align:right">{% include money.html amount=rs_exp %}</td><td style="text-align:right">~{% include money.html amount=ps_exp %}</td><td style="text-align:right">~{% include money.html amount=total_exp %}</td></tr>
<tr><td>In-Kind Support</td><td style="text-align:right">{% include money.html amount=rs_ink %}</td><td style="text-align:right">-</td><td style="text-align:right">{% include money.html amount=rs_ink %}</td></tr>
</tbody>
</table>

## {{ budget.post_season.label }}

{% for team in budget.post_season.teams %}
### {{ team.name }}

{% if team.description %}{{ team.description | markdownify }}{% endif %}

{% if team.donation_recipient %}
{% assign d_total = 0 %}{% assign d_individual = 0 %}{% assign d_firstinvt = 0 %}
{% for d in site.data.donations.donations %}
  {% if d.recipient == team.donation_recipient %}
    {% assign d_total = d_total | plus: d.amount %}
    {% if d.donor == "FIRSTinVT" %}{% assign d_firstinvt = d_firstinvt | plus: d.amount %}
    {% else %}{% assign d_individual = d_individual | plus: d.amount %}{% endif %}
  {% endif %}
{% endfor %}
<table>
<thead><tr><th></th><th style="text-align:right">Amount</th></tr></thead>
<tbody>
<tr><td colspan="2"><strong>Income</strong></td></tr>
{% if d_firstinvt > 0 %}<tr><td>FIRSTinVT</td><td style="text-align:right">{% include money.html amount=d_firstinvt %}</td></tr>{% endif %}
{% if d_individual > 0 %}<tr><td>Individual donations</td><td style="text-align:right">{% include money.html amount=d_individual %}</td></tr>{% endif %}
<tr><td><strong>Total Income</strong></td><td style="text-align:right"><strong>{% include money.html amount=d_total %}</strong></td></tr>
{% if team.expenses %}
<tr><td colspan="2"><strong>Expenses</strong></td></tr>
{% for e in team.expenses %}
<tr><td>{{ e.category }}</td><td style="text-align:right">{% if e.amount %}{% include money.html amount=e.amount %}{% else %}TBD{% endif %}</td></tr>
{% endfor %}
{% if team.estimated_total %}
<tr><td><strong>Estimated Total</strong></td><td style="text-align:right"><strong>~{% include money.html amount=team.estimated_total %}</strong></td></tr>
{% endif %}
{% endif %}
</tbody>
</table>
{% endif %}

{% endfor %}

<p style="text-align:center; margin-top:2rem;">
  <a href="/donate" class="btn-donate">Support Our Teams</a>
</p>

## {{ budget.regular_season.label }}

{% for team in budget.regular_season.teams %}
### {{ team.name }}

{% if team.note %}{{ team.note }}{% endif %}

{% assign inc_total = 0 %}
{% if team.income %}{% for i in team.income %}{% assign inc_total = inc_total | plus: i.amount %}{% endfor %}{% endif %}
{% assign exp_total = 0 %}
{% if team.expenses %}{% for e in team.expenses %}{% assign exp_total = exp_total | plus: e.amount %}{% endfor %}{% endif %}
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
<tr><td>{{ e.category }}</td><td style="text-align:right">{% include money.html amount=e.amount %}</td></tr>
{% endfor %}
<tr><td><strong>Total Expenses</strong></td><td style="text-align:right"><strong>{% include money.html amount=exp_total %}</strong></td></tr>
{% if net < 0 %}
<tr><td><strong>Net</strong></td><td style="text-align:right"><strong style="color:var(--accent)">{% include money.html amount=net %}</strong></td></tr>
{% else %}
<tr><td><strong>Net</strong></td><td style="text-align:right"><strong style="color:#2a9d8f">+{% include money.html amount=net %}</strong></td></tr>
{% endif %}
{% endif %}
{% if team.in_kind %}
<tr><td colspan="2"><strong>In-Kind Support</strong></td></tr>
{% assign ink_total = 0 %}
{% for k in team.in_kind %}{% assign ink_total = ink_total | plus: k.value %}
<tr><td>{{ k.source }}</td><td style="text-align:right">{% include money.html amount=k.value %}</td></tr>
{% endfor %}
<tr><td><strong>Total In-Kind</strong></td><td style="text-align:right"><strong>{% include money.html amount=ink_total %}</strong></td></tr>
{% endif %}
</tbody>
</table>

{% endfor %}
