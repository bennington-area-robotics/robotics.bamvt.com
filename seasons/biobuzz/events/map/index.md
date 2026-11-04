---
last_modified_at: 2026-11-04T20:44:18Z
layout: default
nav_section: /events/
title: Northeast FTC Events Map, 2026–2027
season: "2026-2027"
description: Map of 2026–2027 BIOBUZZ FIRST Tech Challenge events in New England, New York, New Jersey, and Pennsylvania, with distances from Bennington, Vermont.
---
{% assign ftc = site.data.ftc_events["2026-2027"] %}

# Northeast FTC Events Map

[2026–2027 BIOBUZZ events](/seasons/biobuzz/events/)

This map shows {{ ftc.events | size }} FIRST Tech Challenge events in New England, New York, New Jersey, and Pennsylvania for the 2026–2027 BIOBUZZ season. Distances are straight-line miles from Bennington; driving distances are longer. Event details come from the [FTC event listing]({{ ftc.source }}){:target="_blank"}, retrieved {{ ftc.retrieved | date: "%B %-d, %Y" }}. Confirm dates and registration with each event before planning travel: league meets and league tournaments are generally limited to teams in that league, and qualifiers may give priority to teams from their own region.

<style>
.event-map-filters { display: flex; flex-wrap: wrap; gap: 0.75rem 1.5rem; margin: 1.25rem 0 0.75rem; font-size: 0.9rem; }
.event-map-filters fieldset { border: 1px solid var(--border); border-radius: 4px; padding: 0.4rem 0.75rem 0.55rem; margin: 0; }
.event-map-filters legend { font-weight: 600; padding: 0 0.25rem; color: var(--heading); }
.event-map-filters label { display: inline-flex; align-items: center; gap: 0.3rem; margin-right: 0.75rem; white-space: nowrap; }
.event-map-filters select { font: inherit; }
.event-swatch { display: inline-block; width: 0.8rem; height: 0.8rem; border-radius: 50%; border: 1px solid rgba(0,0,0,0.35); }
#event-map { height: 34rem; max-height: 75vh; border: 1px solid var(--border); border-radius: 4px; z-index: 0; }
.event-map-count { margin: 0.6rem 0 1.5rem; color: var(--muted); font-size: 0.9rem; }
.event-map-popup { font-size: 0.85rem; line-height: 1.35; }
.event-map-popup h4 { margin: 0 0 0.15rem; font-size: 0.9rem; color: var(--heading); }
.event-map-popup ul { margin: 0.35rem 0 0; padding-left: 1rem; }
.event-map-popup li { margin-bottom: 0.4rem; }
.event-map-list { font-size: 0.88rem; width: 100%; }
.event-map-list td.when, .event-map-list td.miles { white-space: nowrap; }
.event-map-list td.miles { text-align: right; }
.event-map-list tbody tr { cursor: pointer; }
.event-map-list .event-type { display: inline-flex; align-items: center; gap: 0.3rem; white-space: nowrap; }
.event-map-list .event-place { color: var(--muted); font-size: 0.82rem; }
</style>

<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin="">

<form class="event-map-filters" id="event-map-filters" onsubmit="return false">
  <fieldset id="filter-types"><legend>Event type</legend></fieldset>
  <fieldset id="filter-states"><legend>State</legend></fieldset>
  <fieldset><legend>Distance and dates</legend>
    <label>Within
      <select id="filter-distance">
        <option value="">any distance</option>
        <option value="50">50 miles</option>
        <option value="100">100 miles</option>
        <option value="150">150 miles</option>
        <option value="200">200 miles</option>
        <option value="300">300 miles</option>
      </select>
    </label>
    <label><input type="checkbox" id="filter-past"> Include past events</label>
  </fieldset>
</form>

<div id="event-map" role="region" aria-label="Map of northeast FTC events"></div>
<p class="event-map-count" id="event-map-count" aria-live="polite"></p>

## Event List {#event-list}

<div class="table-scroll" tabindex="0">
<table class="event-map-list">
  <thead><tr><th>Date</th><th>Event</th><th>Type</th><th>Miles</th></tr></thead>
  <tbody id="event-map-rows"></tbody>
</table>
</div>

<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
<script>
(function () {
  var data = {{ ftc | jsonify }};
  var home = { name: 'Bennington, VT', lat: 42.8781, lon: -73.1968 };
  var types = [
    { name: 'Qualifier', color: '#e63946', on: true },
    { name: 'Super Qualifier', color: '#f4a261', on: true },
    { name: 'Championship', color: '#405c85', on: true },
    { name: 'Scrimmage', color: '#2a9d8f', on: true },
    { name: 'League Meet', color: '#9b72cf', on: false },
    { name: 'League Tournament', color: '#5e3c99', on: false },
    { name: 'Kickoff', color: '#999999', on: false }
  ];
  var typeColor = {}, typeRank = {};
  types.forEach(function (t, i) { typeColor[t.name] = t.color; typeRank[t.name] = i; });
  var states = ['VT', 'NH', 'ME', 'MA', 'CT', 'RI', 'NY', 'NJ', 'PA'];
  // Covered events are all in Eastern time; keep same-day events visible until local midnight there.
  var today = new Intl.DateTimeFormat('en-CA', { timeZone: 'America/New_York' }).format(new Date());
  var days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  function esc(s) {
    return String(s == null ? '' : s).replace(/[&<>"']/g, function (c) {
      return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
    });
  }
  function parse(d) { var p = d.split('-'); return new Date(+p[0], p[1] - 1, +p[2]); }
  function md(d) { return (d.getMonth() + 1) + '/' + d.getDate(); }
  function when(e) {
    var s = parse(e.start), f = parse(e.end);
    var text = days[s.getDay()] + ' ' + md(s);
    if (e.end !== e.start) text += '–' + days[f.getDay()] + ' ' + md(f);
    return text + '/' + f.getFullYear();
  }
  function miles(lat, lon) {
    var r = Math.PI / 180, a = Math.sin((lat - home.lat) * r / 2), b = Math.sin((lon - home.lon) * r / 2);
    var h = a * a + Math.cos(home.lat * r) * Math.cos(lat * r) * b * b;
    return 3958.8 * 2 * Math.asin(Math.sqrt(h));
  }
  function swatch(type) {
    return '<span class="event-swatch" style="background:' + typeColor[type] + '"></span>';
  }

  var events = data.events.filter(function (e) { return e.lat != null; });
  events.forEach(function (e) {
    e.miles = miles(e.lat, e.lon);
    e.key = e.lat.toFixed(3) + ',' + e.lon.toFixed(3);
    if (!(e.type in typeColor)) { typeColor[e.type] = '#666666'; typeRank[e.type] = 99; }
  });

  var typeBox = document.getElementById('filter-types');
  types.forEach(function (t) {
    if (!events.some(function (e) { return e.type === t.name; })) return;
    typeBox.insertAdjacentHTML('beforeend', '<label><input type="checkbox" name="type" value="' + esc(t.name) + '"' +
      (t.on ? ' checked' : '') + '> ' + swatch(t.name) + esc(t.name) + '</label>');
  });
  var stateBox = document.getElementById('filter-states');
  states.forEach(function (s) {
    if (!events.some(function (e) { return e.state === s; })) return;
    stateBox.insertAdjacentHTML('beforeend', '<label><input type="checkbox" name="state" value="' + s + '" checked> ' + s + '</label>');
  });

  var map = L.map('event-map', { scrollWheelZoom: false }).setView([42.6, -73.5], 7);
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 18,
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright" target="_blank">OpenStreetMap</a> contributors'
  }).addTo(map);
  map.on('focus', function () { map.scrollWheelZoom.enable(); });
  map.on('blur', function () { map.scrollWheelZoom.disable(); });
  L.marker([home.lat, home.lon], { title: home.name, zIndexOffset: 1000 }).addTo(map)
    .bindPopup('<div class="event-map-popup"><h4>Bennington Area Robotics</h4>Bennington, VT</div>');
  var layer = L.layerGroup().addTo(map);
  var markers = {};

  function checked(name) {
    return Array.prototype.map.call(document.querySelectorAll('input[name="' + name + '"]:checked'), function (i) { return i.value; });
  }

  function placeOf(e) {
    return esc(e.venue) + '<br>' + esc(e.address) + (e.address ? ', ' : '') + esc(e.city) + ', ' + esc(e.state) +
      (e.location_approximate ? '<br><em>Approximate location (city only)</em>' : '');
  }

  function popupItem(e, showPlace) {
    var links = '<a href="' + esc(e.ftc_events_url) + '" target="_blank">FTC event page</a>';
    if (e.website) links += ' · <a href="' + esc(e.website) + '" target="_blank">Event website</a>';
    return '<li>' + swatch(e.type) + ' <strong>' + esc(e.name) + '</strong><br>' + esc(when(e)) + ' · ' + esc(e.type) +
      (e.remote ? ' (remote)' : e.hybrid ? ' (hybrid)' : '') + (showPlace ? '<br>' + placeOf(e) : '') + '<br>' + links + '</li>';
  }

  function render(fit) {
    var showTypes = checked('type'), showStates = checked('state');
    var maxMiles = +document.getElementById('filter-distance').value || Infinity;
    var past = document.getElementById('filter-past').checked;
    var shown = events.filter(function (e) {
      return showTypes.indexOf(e.type) >= 0 && showStates.indexOf(e.state) >= 0 &&
        e.miles <= maxMiles && (past || e.end >= today);
    });

    layer.clearLayers();
    markers = {};
    var groups = {};
    shown.forEach(function (e) { (groups[e.key] = groups[e.key] || []).push(e); });
    Object.keys(groups).forEach(function (key) {
      var list = groups[key];
      var lead = list.slice().sort(function (a, b) { return typeRank[a.type] - typeRank[b.type]; })[0];
      var first = list[0];
      // Events can share coordinates but use different buildings; give each its own venue then.
      var sameVenue = list.every(function (e) { return e.venue === first.venue && e.address === first.address; });
      var m = L.circleMarker([first.lat, first.lon], {
        radius: list.length > 1 ? 9 : 7, color: '#222', weight: 1, fillColor: typeColor[lead.type], fillOpacity: 0.9
      }).bindPopup('<div class="event-map-popup"><h4>' + esc(first.city) + ', ' + esc(first.state) + ' · ' +
        Math.round(first.miles) + ' mi</h4>' + (sameVenue ? placeOf(first) : '') + '<ul>' +
        list.map(function (e) { return popupItem(e, !sameVenue); }).join('') + '</ul></div>', { maxWidth: 320 });
      m.bindTooltip(list.length > 1 ? esc(first.city) + ': ' + list.length + ' events' : esc(first.name));
      m.addTo(layer);
      markers[key] = m;
    });

    var rows = shown.map(function (e, i) {
      return '<tr data-key="' + e.key + '"><td class="when">' + esc(when(e)) + '</td><td><a href="' + esc(e.ftc_events_url) +
        '" target="_blank">' + esc(e.name) + '</a><br><span class="event-place">' + esc(e.venue) + ', ' + esc(e.city) + ', ' + esc(e.state) +
        '</span></td><td><span class="event-type">' + swatch(e.type) + esc(e.type) + '</span></td><td class="miles">' +
        Math.round(e.miles) + '</td></tr>';
    });
    document.getElementById('event-map-rows').innerHTML = rows.join('') ||
      '<tr><td colspan="4">No events match these filters.</td></tr>';
    document.getElementById('event-map-count').textContent = 'Showing ' + shown.length + ' of ' + events.length +
      ' events. Larger circles mark venues with more than one event.';

    if (fit && shown.length) {
      var bounds = L.latLngBounds(shown.map(function (e) { return [e.lat, e.lon]; })).extend([home.lat, home.lon]);
      map.fitBounds(bounds, { padding: [20, 20], maxZoom: 10 });
    }
  }

  document.getElementById('event-map-filters').addEventListener('change', function () { render(true); });
  document.getElementById('event-map-rows').addEventListener('click', function (ev) {
    if (ev.target.closest('a')) return;
    var row = ev.target.closest('tr[data-key]');
    var m = row && markers[row.getAttribute('data-key')];
    if (!m) return;
    document.getElementById('event-map').scrollIntoView({ behavior: 'smooth', block: 'center' });
    map.setView(m.getLatLng(), Math.max(map.getZoom(), 9));
    m.openPopup();
  });
  render(true);
})();
</script>
