---
layout: default
title: Donate
description: Help send Bennington's youth robotics teams to the FIRST World Championship in Houston. Tax-deductible donations support travel, registration, and meals.
og_image: /events/state-championship-2026/images/2026_FTC-228.jpg
---

## Support Youth Robotics in Southwestern Vermont

<div class="carousel" id="donate-carousel">
  <button class="carousel-btn prev" onclick="document.getElementById('donate-track').scrollBy({left: -document.getElementById('donate-track').clientWidth, behavior: 'smooth'})">&lsaquo;</button>
  <div class="carousel-track" id="donate-track">
    <div class="carousel-slide"><img src="/events/state-championship-2026/images/2026_FTC-228.jpg" alt="Bennington Area Robotics at the 2026 VT State Championship" loading="lazy"></div>
    <div class="carousel-slide"><img src="/events/state-championship-2026/images/2026_FTC-220.jpg" alt="Bennington Area Robotics at the 2026 VT State Championship" loading="lazy"></div>
  </div>
  <button class="carousel-btn next" onclick="document.getElementById('donate-track').scrollBy({left: document.getElementById('donate-track').clientWidth, behavior: 'smooth'})">&rsaquo;</button>
</div>

### Help Send Our Students to Worlds and New England!

This season, both teams are advancing to out-of-state events.

**Team 18650 Cookie Clickers** won the [Vermont Championship](/events/state-championship-2026) and is advancing to the [FIRST Championship](https://www.firstchampionship.org/){:target="_blank"} in Houston, TX — the first southwestern Vermont team to do so. Getting 6 students and 3 mentors there will cost an estimated **$20,000**, covering registration, flights, hotel, and meals.

**Team 32473 Bennington Bolts and Biscuits** is advancing to the [New England Premier Event](https://www.nefirst.org/ftc-premier){:target="_blank"} at the Big E in West Springfield, MA. Travel for 5 students and 2 mentors will cost an estimated **$3,500**, covering registration, hotel, and meals.

Cookie Clickers was formed in 2019 for middle school students, and some of those founding members are now seniors and heading to Worlds for the first time. Bolts and Biscuits was formed in 2025 and is already advancing to the regional level. Your support makes both possible.

### Donate Online

[Donate via PayPal or Venmo](https://www.paypal.com/donate/?hosted_button_id=HPQY5NA3Z59C2){:target="_blank"}
<br><small>501(c)(3): The Bennington Area Makers, Inc, EIN 84-5124653</small>

[Donate via Hack Club](https://hcb.hackclub.com/donations/start/bennington-area-robotics){:target="_blank"}
<br><small>501(c)(3): Hack Club, EIN 81-2908499</small>

### Donate by Check

Make checks payable to *The Bennington Area Makers, Inc.* and mail to:

> The Bennington Area Makers, Inc.<br>
> PO Box 4332<br>
> Bennington, VT 05201

<small>EIN 84-5124653</small>

### Post-Season Advancement Fund

{% assign total = 0 %}{% assign count = site.data.donations.donations | size %}{% for d in site.data.donations.donations %}{% assign total = total | plus: d.amount %}{% endfor %}{% assign goal = site.data.donations.goal %}{% assign pct = total | times: 100 | divided_by: goal %}
<div class="donation-progress">
  <span class="raised">${{ total | replace: '.0', '' }} raised</span>
  <span class="goal"> of ${{ goal | replace: '.0', '' }} goal &middot; {{ count }} donation{% if count != 1 %}s{% endif %}</span>
  <div class="donation-progress-bar">
    <div class="fill" style="width: {{ pct }}%"></div>
  </div>
</div>

<ul class="donation-feed">
{% for d in site.data.donations.donations %}  <li>
    <div class="donation-avatar">{{ d.donor | slice: 0 }}</div>
    <div class="donation-detail">
      <span class="donor-name">{{ d.donor }}</span> donated <span class="donation-amount">${{ d.amount }}</span> to {{ d.recipient }}
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

Your donation helps fund robot parts, competition fees, travel expenses, and educational materials for middle and high school students in the Bennington Vermont area. All donations are tax-deductible to the extent permitted by law.

Bennington Area Robotics is organized under **The Bennington Area Makers, Inc.** (BAMVT), a 501(c)(3) nonprofit with EIN 84-5124653.

### Questions?

Email us at [info@bamvt.com](mailto:info@bamvt.com?subject=Donation%20Inquiry).

---

*We're grateful to our [regular-season sponsors](/sponsors), whose support helped us get this far.*
