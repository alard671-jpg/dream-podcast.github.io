#!/usr/bin/env bash
# deploy.sh
# Usage: ./deploy.sh
# This script clones the repo, replaces files with the updated site scaffold,
# downloads AI placeholder images, commits and force-pushes to main.
# WARNING: force-push will replace content on main branch.

set -e

REPO="https://github.com/alard671-jpg/Dream--podcast.github.io.git"
WORKDIR="$(mktemp -d)/dream-site-$$"
BRANCH="main"
COMMIT_MSG="Apply requested updates: tickers, modal, programs cards, inline Zeno, contact/socials, clock"

echo "Working dir: $WORKDIR"
git clone "$REPO" "$WORKDIR"
cd "$WORKDIR"

echo "Configuring git user if not set..."
git config user.email >/dev/null 2>&1 || git config user.email "you@example.com"
git config user.name >/dev/null 2>&1 || git config user.name "Your Name"

echo "Removing old files (keeps .git)..."
# remove all files tracked by git
git rm -r --ignore-unmatch .

# Create directories
mkdir -p css js images/ai

# Write index.html (full updated page)
cat > index.html <<'EOF'
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>دريم بودكاست</title>
  <meta name="description" content="دريم بودكاست — صوت التنمية المستدامة: تمكين النساء لمواجهة التغير المناخي وبناء السلام في اليمن" />
  <link rel="stylesheet" href="css/reset.css" />
  <link rel="stylesheet" href="css/style.css" />
  <link rel="manifest" href="manifest.json" />
</head>
<body class="ar">

<!-- Arabic ticker: enters from اليسار and moves to اليمين -->
<div class="ticker ticker-ar" aria-hidden="true">
  <div class="ticker-track">
    <span class="ticker-item">UNDP تدعم تمكين النساء • WPHF تطلق منح سلام • دريم بودكاست يبث 4 برامج • 237 مستوى نشر • 12,500 مستمع • تاريخ الإطلاق: 1 أغسطس 2025</span>
    <span class="ticker-item">UNDP تدعم تمكين النساء • WPHF تطلق منح سلام • دريم بودكاست يبث 4 برامج • 237 مستوى نشر • 12,500 مستمع • تاريخ الإطلاق: 1 أغسطس 2025</span>
  </div>
</div>

<!-- English ticker: enters from اليمين and moves to اليسار -->
<div class="ticker ticker-en" aria-hidden="true">
  <div class="ticker-track">
    <span class="ticker-item">UNDP supports women • WPHF launches peace grants • Dream Podcast: 4 weekly shows • Reach: 237 • Launch: Aug 1, 2025</span>
    <span class="ticker-item">UNDP supports women • WPHF launches peace grants • Dream Podcast: 4 weekly shows • Reach: 237 • Launch: Aug 1, 2025</span>
  </div>
</div>

<!-- Elegant Gregorian clock (English format) -->
<div id="clock-widget" aria-live="polite" title="Time & Date">
  <div id="time" class="clock-time">--:--:--</div>
  <div id="date" class="clock-date">---</div>
</div>

<header class="site-header" role="banner">
  <div class="container header-inner">
    <div class="brand">
      <img src="images/logo.png" alt="شعار دريم بودكاست" class="logo" width="120" height="120">
      <div class="brand-text">
        <h1>دريم بودكاست</h1>
        <p class="slogan-ar">معنا حلمك يتحقق</p>
        <p class="slogan-en" data-en="With us, your dream will come true">With us, your dream will come true</p>
        <p class="lead" data-en="Voice of sustainable development: empowering women to face climate change and build peace in Yemen">صوت التنمية المستدامة تمكين المرأة في مواجهة التغيرات المناخية وبناء السلام في اليمن</p>
      </div>
    </div>

    <div class="cta">
      <button id="live-btn" class="btn" aria-controls="live-player">استمع الآن</button>
    </div>
  </div>

  <!-- mini slideshow (landscape/climate) -->
  <div class="mini-screen" aria-hidden="true">
    <div class="mini-slide" style="background-image:url('images/ai/nature1.jpg')"></div>
    <div class="mini-slide" style="background-image:url('images/ai/nature2.jpg')"></div>
    <div class="mini-slide" style="background-image:url('images/ai/nature3.jpg')"></div>
  </div>
</header>

<main id="main-content" role="main">
  <section class="hero">
    <div class="container">
      <h2>دريم بودكاست</h2>
      <p class="hero-sub">صوت التنمية المستدامة تمكين المرأة في مواجهة التغيرات المناخية وبناء السلام في اليمن</p>
      <button id="read-more" class="btn">اقرأ المزيد</button>
    </div>
  </section>

  <!-- Programs: animated cards (AI images placeholders) -->
  <section class="programs-preview">
    <div class="container">
      <h2>خارطة البرامج</h2>
      <div class="program-cards">
        <article class="program-card">
          <img src="images/ai/program_grandma.jpg" alt="بودكاست مع جدتي">
          <h3>بودكاست مع جدتي</h3>
          <p class="meta">كوميدي ساخر يصحح الأمثال المغلوطة عن المرأة ويدان العنف في النزاعات، مع ربط بتأثير المناخ.</p>
        </article>

        <article class="program-card">
          <img src="images/ai/program_taa.jpg" alt="تاء التأنيث">
          <h3>بودكاست تاء التأنيث</h3>
          <p class="meta">تمكين اقتصادي للنساء في مواجهة الفقر الناتج عن النزاعات والمناخ.</p>
        </article>

        <article class="program-card">
          <img src="images/ai/program_saeed.jpg" alt="مع سعيد">
          <h3>بودكاست مع سعيد</h3>
          <p class="meta">مكافحة المعلومات المضللة وبناء السلام الدائم.</p>
        </article>

        <article class="program-card">
          <img src="images/ai/program_hawa.jpg" alt="عالم حواء">
          <h3>بودكاست عالم حواء</h3>
          <p class="meta">دعم الفئات المهمشة، بما في ذلك ذوي الاحتياجات الخاصة، مع قصص نجاح مناخية.</p>
        </article>
      </div>
    </div>
  </section>

  <!-- Live player: inline Zeno iframe (provided) -->
  <section id="live-player" class="live-player-hidden" aria-hidden="true">
    <div class="player-header">
      <div class="player-title">Dream FM — البث المباشر</div>
      <div class="player-contacts">
        <a href="mailto:DreamFM44@gmail.com">DreamFM44@gmail.com</a> · <a href="tel:+967771455399">+967 771 455 399</a>
      </div>
      <div class="player-socials">
        <a href="https://www.facebook.com/share/15iyBtLaT1/" target="_blank" rel="noopener">Facebook</a>
        <a href="https://www.instagram.com/dream.podcast.fm?igsh=MWkxMDF3MDFpamZo" target="_blank" rel="noopener">Instagram</a>
      </div>
    </div>

    <div class="zeno-wrapper">
      <div class="iframe-cover" aria-hidden="true"></div>
      <iframe id="zeno-iframe" src="https://zeno.fm/player/dream-podcast" width="575" height="250" frameborder="0" scrolling="no" title="Zeno FM: Dream Podcast" allow="autoplay"></iframe>
    </div>

    <div class="player-footnote">A Zeno.FM Station</div>
  </section>

  <!-- Read-more modal (internal) -->
  <div id="readmore-modal" class="modal-hidden" role="dialog" aria-modal="true" aria-labelledby="rm-title" aria-hidden="true">
    <div class="modal-content">
      <button id="modal-close" class="modal-close" aria-label="إغلاق">×</button>
      <h2 id="rm-title">الملخص النهائي</h2>
      <p>في ظل التحديات المتعددة التي يواجهها اليمن، بما في ذلك النزاعات المستمرة، التغيرات المناخية (مثل الجفاف والفيضانات التي تؤثر بنسبة 70% على النساء والأطفال حسب تقارير UNDP)، وانعدام السلام، يأتي دريم بودكاست كأداة إعلامية لتعزيز التنمية المستدامة.</p>
      <p><strong>تاريخ الإطلاق:</strong> 1 أغسطس 2025</p>
      <p><strong>الهدف:</strong> تمكين المرأة، مواجهة التغيرات المناخية، بناء السلام</p>
      <ul>
        <li>زيادة الوعي بتأثير التغيرات المناخية على المرأة (ربط بـ SDG 13).</li>
        <li>تعزيز التمكين الاقتصادي للنساء من خلال مبادرات مستدامة (ربط بـ SDG 5).</li>
        <li>مكافحة الشائعات وتعزيز الحوار المجتمعي لبناء السلام (ربط بـ SDG 16).</li>
        <li>توسيع الوصول عبر FM للوصول إلى الريف.</li>
        <li>بناء شراكات مع منظمات محلية ودولية.</li>
        <li>قياس التأثير من خلال استطلاعات.</li>
      </ul>
      <p><strong>التواصل:</strong> DreamFM44@gmail.com · +967771455399</p>
    </div>
  </div>

</main>

<footer class="site-footer">
  <div class="container footer-inner">
    <div>
      <p>&copy; <span id="year"></span> دريم بودكاست</p>
      <p>جميع الحقوق محفوظة</p>
    </div>
    <div>
      <a href="sitemap.html">خريطة الموقع</a> · <a href="privacy.html">سياسة الخصوصية</a>
    </div>
  </div>
</footer>

<script src="js/main.js"></script>
</body>
</html>
EOF

# css/style.css
cat > css/style.css <<'EOF'
:root{
  --brand:#7b1e1e;
  --accent:#ff6b3d;
  --muted:#666;
  --bg:#f8f9fa;
  --card:#fff;
}

/* Tickers */
.ticker{ position:fixed; width:100%; overflow:hidden; z-index:1200; font-weight:700; }
.ticker-track{ display:flex; gap:60px; align-items:center; white-space:nowrap; }
.ticker-item{ display:inline-block; padding:10px 0; color:#fff; font-size:15px; }

/* Arabic moves left→right (visual: translate from -50% to 0) */
.ticker-ar{ top:0; background:#1e88e5; }
.ticker-ar .ticker-track{ animation: tickrar 35s linear infinite; }
@keyframes tickrar{ 0%{ transform:translateX(-50%);} 100%{ transform:translateX(0%);} }

/* English moves right→left */
.ticker-en{ top:44px; background:#1565c0; }
.ticker-en .ticker-track{ animation: tickren 35s linear infinite; }
@keyframes tickren{ 0%{ transform:translateX(0%);} 100%{ transform:translateX(-50%);} }

/* Clock */
#clock-widget{ position:fixed; top:100px; right:20px; background:rgba(255,255,255,0.98); padding:12px 16px; border-radius:12px; box-shadow:0 8px 30px rgba(0,0,0,0.08); z-index:999; transition:all .35s; font-weight:700; color:var(--brand); text-align:center; min-width:130px; }
#clock-widget.hidden{ opacity:0; transform:translateY(-12px); pointer-events:none; }
.clock-time{ font-size:18px; letter-spacing:1px; }
.clock-date{ font-size:12px; color:var(--muted); margin-top:4px; }

/* Header */
.site-header{ background:linear-gradient(135deg,var(--brand),#a00000); color:#fff; padding-bottom:20px; position:relative; }
.header-inner{ display:flex; align-items:center; justify-content:space-between; gap:16px; padding:28px 0; }
.brand-text h1{ font-size:28px; margin:0; }
.slogan-ar{ margin:6px 0 0; font-weight:700; }
.lead{ margin-top:8px; color:#fff; opacity:0.95; }

/* Mini-screen */
.mini-screen{ position:absolute; left:20px; bottom:-28px; width:220px; height:120px; border-radius:12px; overflow:hidden; box-shadow:0 12px 30px rgba(0,0,0,0.2); display:flex; }
.mini-slide{ min-width:100%; background-position:center; background-size:cover; animation: miniswap 9s linear infinite; }
@keyframes miniswap{ 0%{ transform:translateX(0);} 33%{ transform:translateX(-100%);} 66%{ transform:translateX(-200%);} 100%{ transform:translateX(0);} }

/* Programs */
.program-cards{ display:grid; grid-template-columns: repeat(auto-fit,minmax(220px,1fr)); gap:18px; margin-top:18px; }
.program-card{ background:var(--card); border-radius:12px; overflow:hidden; box-shadow:0 8px 20px rgba(0,0,0,0.06); text-align:center; padding-bottom:12px; transform:translateY(0); transition:transform .28s ease, box-shadow .28s; }
.program-card:hover{ transform:translateY(-8px); box-shadow:0 18px 36px rgba(0,0,0,0.12); }
.program-card img{ width:100%; height:160px; object-fit:cover; display:block; }
.program-card h3{ padding:10px 12px 0; color:var(--brand); }
.program-card .meta{ padding:8px 14px 12px; color:#333; font-size:14px; }

/* Live player */
.live-player-hidden{ display:none; }
#live-player{ padding:24px; background:#fff; border-top:1px solid #eee; }
.player-header{ display:flex; justify-content:space-between; align-items:center; gap:12px; padding:8px 0 14px; }
.player-title{ font-weight:800; color:var(--brand); }
.player-contacts a{ color:#333; text-decoration:none; margin-left:8px; }
.zeno-wrapper{ position:relative; display:flex; justify-content:center; align-items:center; }
.zeno-wrapper iframe{ width:100%; max-width:680px; height:250px; border-radius:12px; border:0; box-shadow:0 12px 30px rgba(0,0,0,0.12); }
.iframe-cover{ position:absolute; right:40px; top:8px; width:110px; height:36px; background:linear-gradient(90deg,rgba(255,255,255,0.95),rgba(255,255,255,0.6)); border-radius:8px; z-index:20; pointer-events:none; }

/* Modal */
#readmore-modal{ position:fixed; inset:0; display:flex; justify-content:center; align-items:center; background:rgba(0,0,0,0.45); z-index:2000; }
.modal-hidden{ display:none; }
.modal-content{ background:#fff; border-radius:12px; padding:22px; max-width:720px; width:92%; max-height:80vh; overflow:auto; position:relative; box-shadow:0 20px 40px rgba(0,0,0,0.2); }
.modal-close{ position:absolute; right:10px; top:6px; background:transparent; border:none; font-size:24px; cursor:pointer; }

/* Footer */
.site-footer{ background:#fff; padding:18px 0; border-top:1px solid #eee; margin-top:30px; }

/* Responsive */
@media (max-width:600px){
  .header-inner{ flex-direction:column; align-items:center; text-align:center; }
  .mini-screen{ display:none; }
  #clock-widget{ display:none; }
}
EOF

# js/main.js
cat > js/main.js <<'EOF'
// main.js - clock (Gregorian), modal, ticker handling, live player reveal
(function(){
  // Clock - English locale (Gregorian)
  const timeEl = document.getElementById('time');
  const dateEl = document.getElementById('date');
  function updateClock(){
    const now = new Date();
    if(timeEl) timeEl.textContent = now.toLocaleTimeString('en-US', { hour12:false });
    if(dateEl) dateEl.textContent = now.toLocaleDateString('en-US', { weekday:'long', year:'numeric', month:'short', day:'numeric' });
  }
  updateClock();
  setInterval(updateClock, 1000);

  // Hide clock on scroll down, show on scroll up
  const clock = document.getElementById('clock-widget');
  let lastScroll = 0;
  window.addEventListener('scroll', () => {
    const current = window.pageYOffset || document.documentElement.scrollTop;
    if (!clock) return;
    if (current > lastScroll + 60) clock.classList.add('hidden');
    else if (current < lastScroll - 60) clock.classList.remove('hidden');
    lastScroll = current;
  });

  // Modal read more
  const readBtn = document.getElementById('read-more');
  const modal = document.getElementById('readmore-modal');
  const closeBtn = document.getElementById('modal-close');
  if(readBtn && modal){
    readBtn.addEventListener('click', () => {
      modal.classList.remove('modal-hidden');
      modal.setAttribute('aria-hidden','false');
    });
  }
  if(closeBtn && modal){
    closeBtn.addEventListener('click', () => {
      modal.classList.add('modal-hidden');
      modal.setAttribute('aria-hidden','true');
    });
  }
  window.addEventListener('keydown', (e) => {
    if(e.key === 'Escape' && modal && !modal.classList.contains('modal-hidden')){
      modal.classList.add('modal-hidden');
    }
  });

  // Live player reveal (inline, no redirect)
  const liveBtn = document.getElementById('live-btn');
  const liveSection = document.getElementById('live-player');
  if(liveBtn && liveSection){
    liveBtn.addEventListener('click', () => {
      liveSection.classList.remove('live-player-hidden');
      liveSection.setAttribute('aria-hidden','false');
      setTimeout(()=> liveSection.scrollIntoView({behavior:'smooth', block:'center'}), 80);
      const ziframe = document.getElementById('zeno-iframe');
      try{ if(ziframe) ziframe.contentWindow && ziframe.focus(); } catch(e){ /* cross-origin */ }
    });
  }

  // Language switch (if exists)
  function setLanguage(lang){
    if(lang === 'en'){ document.documentElement.lang='en'; document.documentElement.dir='ltr'; document.body.classList.remove('ar'); document.body.classList.add('en'); }
    else { document.documentElement.lang='ar'; document.documentElement.dir='rtl'; document.body.classList.remove('en'); document.body.classList.add('ar'); }
    document.querySelectorAll('[data-en]').forEach(el => {
      if(lang === 'en'){ if(!el.dataset.ar) el.dataset.ar = el.innerHTML; el.innerHTML = el.dataset.en; }
      else { if(el.dataset.ar) el.innerHTML = el.dataset.ar; }
    });
    document.querySelectorAll('.lang-switch button').forEach(b => b.classList.toggle('active', b.getAttribute('data-lang') === lang));
  }
  document.querySelectorAll('.lang-switch button').forEach(btn => {
    btn.addEventListener('click', () => setLanguage(btn.getAttribute('data-lang')));
  });
  setLanguage(document.documentElement.lang || 'ar');

  // inject year
  const y = new Date().getFullYear();
  const yearEl = document.getElementById('year');
  if(yearEl) yearEl.textContent = y;

})();
EOF

# create about.html and programs.html (omitted here for brevity - similar to index content)
cat > about.html <<'EOF'
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>عن دريم بودكاست</title>
  <link rel="stylesheet" href="css/reset.css" />
  <link rel="stylesheet" href="css/style.css" />
</head>
<body class="ar">
  <main class="container" style="max-width:1000px;margin:80px auto;padding:30px;background:#fff;border-radius:12px;">
    <h1 style="color:#800000;text-align:center">دريم بودكاست — الملخص النهائي</h1>

    <p>في ظل التحديات المتعددة التي يواجهها اليمن، بما في ذلك النزاعات المستمرة، التغيرات المناخية (مثل الجفاف والفيضانات التي تؤثر بنسبة 70% على النساء والأطفال حسب تقارير UNDP)، وانعدام السلام، يأتي دريم بودكاست كأداة إعلامية لتعزيز التنمية المستدامة.</p>

    <p><strong>تاريخ الإطلاق:</strong> 1 أغسطس 2025</p>
    <p><strong>الهدف:</strong> تمكين المرأة، مواجهة التغيرات المناخية، بناء السلام</p>

    <h2>أهداف ومكونات المشروع</h2>
    <ul>
      <li>زيادة الوعي بتأثير التغيرات المناخية على المرأة (ربط بـ SDG 13).</li>
      <li>تعزيز التمكين الاقتصادي للنساء من خلال مبادرات مستدامة (ربط بـ SDG 5).</li>
      <li>مكافحة الشائعات وتعزيز الحوار المجتمعي لبناء السلام (ربط بـ SDG 16).</li>
      <li>توسيع الوصول عبر FM للوصول إلى الريف.</li>
      <li>بناء شراكات مع منظمات محلية ودولية.</li>
      <li>قياس التأثير من خلال استطلاعات.</li>
    </ul>

    <p><strong>التواصل:</strong> DreamFM44@gmail.com · +967771455399</p>

    <p style="text-align:center"><a href="index.html" class="btn">العودة</a></p>
  </main>
</body>
</html>
EOF

cat > programs.html <<'EOF'
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>خارطة البرامج - دريم بودكاست</title>
  <link rel="stylesheet" href="css/reset.css" />
  <link rel="stylesheet" href="css/style.css" />
</head>
<body class="ar">
  <main class="container" style="padding:40px;max-width:1100px;margin:80px auto;">
    <h1 style="text-align:center;color:#800000">خارطة البرامج</h1>

    <div class="programs-grid">
      <div class="program-card large">
        <img src="images/ai/program_grandma.jpg" alt="بودكاست مع جدتي">
        <div class="program-body">
          <h2>بودكاست مع جدتي</h2>
          <p>كوميدي ساخر يصحح الأمثال المغلوطة عن المرأة ويدان العنف في النزاعات، مع ربط بتأثير المناخ.</p>
        </div>
      </div>

      <div class="program-card">
        <img src="images/ai/program_taa.jpg" alt="تاء التأنيث">
        <div class="program-body">
          <h2>بودكاست تاء التأنيث</h2>
          <p>تمكين اقتصادي للنساء في مواجهة الفقر الناتج عن النزاعات والمناخ.</p>
        </div>
      </div>

      <div class="program-card">
        <img src="images/ai/program_saeed.jpg" alt="مع سعيد">
        <div class="program-body">
          <h2>بودكاست مع سعيد</h2>
          <p>مكافحة المعلومات المضللة وبناء السلام الدائم.</p>
        </div>
      </div>

      <div class="program-card">
        <img src="images/ai/program_hawa.jpg" alt="عالم حواء">
        <div class="program-body">
          <h2>بودكاست عالم حواء</h2>
          <p>دعم الفئات المهمشة، بما في ذلك ذوي الاحتياجات الخاصة، مع قصص نجاح مناخية.</p>
        </div>
      </div>
    </div>

    <p style="text-align:center"><a href="index.html" class="btn">العودة</a></p>
  </main>
</body>
</html>
EOF

# manifest, robots, README, LICENSE
cat > manifest.json <<'EOF'
{
  "name": "Dream Podcast",
  "short_name": "DreamFM",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#800000",
  "theme_color": "#ff5722",
  "icons": [
    { "src": "images/logo.png", "sizes": "192x192", "type": "image/png" }
  ],
  "description": "دريم بودكاست - راديو المجتمع والتنمية والسلام"
}
EOF

cat > robots.txt <<'EOF'
User-agent: *
Allow: /
Sitemap: https://alard671-jpg.github.io/Dream--podcast.github.io/sitemap.html
EOF

cat > README.md <<'EOF'
# Dream Podcast (Website)

Automated update: tickers, modal, programs cards, inline Zeno, contact/socials, clock.
EOF

cat > LICENSE <<'EOF'
MIT License

Copyright (c) 2025 Dream Podcast
EOF

# download placeholder AI images (from picsum.photos seeds)
echo "Downloading placeholder images..."
curl -s -o images/ai/program_grandma.jpg https://picsum.photos/seed/grandma/800/600
curl -s -o images/ai/program_taa.jpg https://picsum.photos/seed/taa/800/600
curl -s -o images/ai/program_saeed.jpg https://picsum.photos/seed/saeed/800/600
curl -s -o images/ai/program_hawa.jpg https://picsum.photos/seed/hawa/800/600
curl -s -o images/ai/nature1.jpg https://picsum.photos/seed/nature1/800/600
curl -s -o images/ai/nature2.jpg https://picsum.photos/seed/nature2/800/600
curl -s -o images/ai/nature3.jpg https://picsum.photos/seed/nature3/800/600

# create a minimal logo placeholder if not present
if [ ! -f images/logo.png ]; then
  echo "Creating placeholder logo..."
  curl -s -o images/logo.png https://picsum.photos/seed/logo/400/400
fi

git add .
git commit -m "$COMMIT_MSG"

echo "About to force-push changes to $BRANCH on origin. This will replace remote content. Are you SURE? Type 'YES' to proceed:"
read CONF
if [ "$CONF" = "YES" ]; then
  git push origin HEAD:$BRANCH --force
  echo "Push completed."
else
  echo "Push aborted. You can review changes in $WORKDIR and push manually."
fi

echo "Done."
EOF