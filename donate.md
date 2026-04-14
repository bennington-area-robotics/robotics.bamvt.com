---
layout: default
title: Donate
description: Team 18650 Cookie Clickers is representing Vermont at the FIRST Championship in Houston. Help send these students to the world stage with a tax-deductible donation.
og_image: /events/state-championship-2026/images/2026_FTC-228.jpg
---

## Help Send Our Students to Worlds and New England!

Team 18650 Cookie Clickers is representing Vermont at the FIRST Championship in Houston. Your donation helps cover registration, travel, lodging, and meals. See our [full budget](/budget) for details.

<!-- <a href="https://www.paypal.com/donate/?hosted_button_id=HPQY5NA3Z59C2" target="_blank" class="btn-donate">Donate Online</a>
<br><small style="display:block; margin-bottom:1.5rem;">or <a href="#donate-by-check">by check</a> &mdash; 501(c)(3) nonprofit, EIN <span class="no-detect">84&#x2011;5124653</span></small> -->

<div class="carousel" id="donate-carousel" data-start="10">
  <button class="carousel-btn prev">&lsaquo;</button>
  <div class="carousel-track" id="donate-track">
    {% include carousel-slides.html %}
  </div>
  <button class="carousel-btn next">&rsaquo;</button>
  <button class="carousel-btn pause" title="Pause slideshow">⏸</button>
</div>

**Team 18650 Cookie Clickers** won the [FTC Vermont Championship](/events/state-championship-2026) and is representing Vermont at the [FIRST Championship](/events/first-championship-2026) in Houston, TX, becoming the first team from southwestern Vermont to reach Worlds. [Read their Engineering Portfolio](/portfolio). Sending 6 students and 3 mentors to Houston will cost an estimated **$20,000**, covering registration, flights, lodging, and meals.

**Team 32473 Bennington Bolts and Biscuits** qualified for the [New England Premier Event](https://www.nefirst.org/ftc-premier){:target="_blank"} at the Big E in West Springfield, MA. Sending 5 students and 2 mentors will cost an estimated **$3,500**, covering registration, lodging, and meals.

Cookie Clickers was formed in 2019 as a middle school team. Some of its founding members are now seniors, and this is their first trip to the World Championship. Bolts and Biscuits was formed in 2025 and qualified for the New England Premier Event in its first season. Your support makes these trips possible.

[Download our fundraising flyer (PDF)](https://drive.google.com/file/d/1XhRbnHisUfao6Agjsfpq1ygs2BoNN96o/view?usp=sharing){:target="_blank"} to share with friends, family, and local businesses.

### Donate Online

[Donate via PayPal or Venmo](https://www.paypal.com/donate/?hosted_button_id=HPQY5NA3Z59C2){:target="_blank"}
<br><small>501(c)(3): The Bennington Area Makers, Inc, EIN 84-5124653</small>

<!-- [Donate via Hack Club](https://hcb.hackclub.com/donations/start/bennington-area-robotics){:target="_blank"}
<br><small>501(c)(3): Hack Club, EIN 81-2908499</small> -->

### Donate by Check {#donate-by-check}

Make checks payable to *The Bennington Area Makers, Inc.* and mail to:

> The Bennington Area Makers, Inc.<br>
> PO Box 4332<br>
> Bennington, VT 05201

<small>EIN 84-5124653</small>

### Post-Season Advancement Fund

{% assign donations = site.data.donations.donations %}
{% assign goal = site.data.donations.goal %}
{% assign count = donations | size %}
{% assign total = 0 %}
{% for d in donations %}
  {% unless d.type == "in-kind" %}{% assign total = total | plus: d.amount %}{% endunless %}
{% endfor %}
{% assign pct = total | times: 100 | divided_by: goal %}
<div class="donation-progress">
  <span class="raised">${{ total | replace: '.0', '' }} raised</span>
  <span class="goal"> of ${{ goal | replace: '.0', '' }} goal &middot; {{ count }} donation{% if count != 1 %}s{% endif %}</span>
  <div class="donation-progress-bar">
    <div class="fill" style="width: {{ pct }}%"></div>
  </div>
</div>

<ul class="donation-feed">
{% for d in donations %}  <li>
    <div class="donation-avatar">{{ d.donor | slice: 0 }}</div>
    <div class="donation-detail">
      <span class="donor-name">{{ d.donor }}</span> donated <span class="donation-amount">${{ d.amount | replace: '.0', '' }}</span> to {{ d.recipient }}
      <div class="donation-meta">{{ d.date | date: "%b %-d" }}{% if d.memo %} &middot; {{ d.memo }}{% endif %}</div>
    </div>
  </li>
{% endfor %}</ul>

<script>
(function() {
  var items = document.querySelectorAll('.donation-feed li');
  var limit = 5;
  if (items.length > limit) {
    for (var i = limit; i < items.length; i++) items[i].style.display = 'none';
    var btn = document.createElement('button');
    btn.textContent = 'Show all ' + items.length + ' donations';
    btn.style.cssText = 'background:none;border:none;color:var(--link);cursor:pointer;padding:0.5rem 0;font-size:0.95rem;';
    btn.addEventListener('click', function() {
      for (var i = limit; i < items.length; i++) items[i].style.display = '';
      btn.remove();
    });
    document.querySelector('.donation-feed').after(btn);
  }
})();
</script>

### About Us

Your donation funds robot parts, competition fees, travel, and educational materials for middle and high school students in southwestern Vermont and neighboring New York. All donations are tax-deductible to the extent permitted by law.

Bennington Area Robotics is organized under **The Bennington Area Makers, Inc.** (BAMVT), a 501(c)(3) nonprofit with EIN 84-5124653.

### In the News

{% include news-coverage.html %}

### Questions?

Email us at [info@bamvt.com](mailto:info@bamvt.com?subject=Donation%20Inquiry).

---

*We're grateful to our [regular-season sponsors](/sponsors), whose support helped us get this far. See our [full budget](/budget).*
