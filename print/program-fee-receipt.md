---
sitemap: false
layout: null
title: Program Fee Receipt
permalink: /print/program-fee-receipt.html
---
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{{ page.title }} — Bennington Area Robotics</title>
<link rel="canonical" href="{{ page.url | absolute_url }}">
<style>
  :root {
    --primary: #6d87b8;
    --ink: #222;
    --muted: #666;
    --line: #999;
  }
  * { box-sizing: border-box; margin: 0; padding: 0; }
  html { -webkit-print-color-adjust: exact; print-color-adjust: exact; }
  body {
    font-family: "Helvetica Neue", Arial, sans-serif;
    color: var(--ink);
    background: #eef1f5;
    line-height: 1.35;
    font-size: 14px;
  }
  .page {
    width: 8.5in;
    max-width: 100%;
    margin: 24px auto;
    padding: 0.5in 0.6in;
    background: #fff;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.12);
  }
  header {
    display: flex;
    align-items: center;
    gap: 16px;
    padding-bottom: 12px;
    border-bottom: 3px solid var(--primary);
  }
  header img { width: 60px; height: 60px; border-radius: 50%; }
  .org { flex: 1; }
  .team {
    font-size: 13px;
    letter-spacing: 2px;
    text-transform: uppercase;
    color: var(--primary);
    font-weight: 700;
  }
  .address { color: var(--muted); font-size: 12px; margin-top: 2px; }
  h1 { font-size: 26px; text-align: right; }
  .fields {
    display: grid;
    grid-template-columns: max-content 1fr;
    gap: 14px 14px;
    align-items: end;
    margin: 22px 0 18px;
  }
  label { font-weight: 700; }
  input {
    font: inherit;
    color: inherit;
    border: 0;
    border-bottom: 1px solid var(--line);
    padding: 2px 4px;
    width: 100%;
    background: transparent;
  }
  input:focus { outline: none; border-bottom-color: var(--primary); }
  .note { font-size: 12px; color: var(--muted); margin-top: 8px; }
  .actions { text-align: center; margin: 0 auto 24px; }
  .actions button {
    font: inherit;
    padding: 8px 18px;
    border: 0;
    border-radius: 4px;
    background: var(--primary);
    color: #fff;
    cursor: pointer;
  }
  @media screen and (max-width: 700px) {
    .page { margin: 0; padding: 20px 16px; box-shadow: none; }
    header { flex-wrap: wrap; }
    h1 { text-align: left; width: 100%; }
    .fields { grid-template-columns: 1fr; gap: 4px; }
    input { margin-bottom: 10px; }
  }
  @page { size: letter; margin: 0; }
  @media print {
    body { background: #fff; }
    .page { margin: 0; box-shadow: none; }
    .actions { display: none; }
  }
</style>
</head>
<body>
<div class="page">
  <header>
    <img src="https://assets.bamvt.com/robotics.bamvt.com/images/chip-180x180-round.png" alt="Bennington Area Robotics">
    <div class="org">
      <div class="team">Bennington Area Robotics</div>
      <div><strong>The Bennington Area Makers, Inc.</strong></div>
      <div class="address">PO Box 4332, Bennington, VT 05201 &nbsp;·&nbsp; EIN 84-5124653</div>
    </div>
    <h1>Receipt</h1>
  </header>

  <div class="fields">
    <label for="receipt-no">Receipt no.</label><input id="receipt-no">
    <label for="date">Date</label><input id="date">
    <label for="payer">Received from</label><input id="payer">
    <label for="student">Student</label><input id="student">
    <label for="fee">2026–27 program fee</label><input id="fee" value="$">
    <label for="donation">Donation (optional)</label><input id="donation" value="$">
    <label for="method">Paid by</label><input id="method" placeholder="Check no. or cash">
    <label for="received-by">Received by</label><input id="received-by">
  </div>

  <p class="note">The program fee is payment for participation and is not a charitable contribution. No goods or services were provided in exchange for any donation listed above.</p>
</div>
<div class="actions"><button type="button" onclick="window.print()">Print</button></div>
</body>
</html>
