<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Workspace Paper Univer</title>
  <style>
    html, body { margin:0; padding:0; width:100%; height:100%; overflow:hidden; background:#fff; }
    #paperFrame { width:100%; height:100%; border:0; display:block; }
    .err { font-family: Arial, sans-serif; color:#b91c1c; padding:12px; }
  </style>
</head>
<body>
<iframe id="paperFrame" src="{{ $manageUrl }}" title="{{ $paperName }}"></iframe>
<script>
(function () {
  const frame = document.getElementById('paperFrame');

  function applyCleanView(doc) {
    if (!doc || !doc.head || !doc.body) return;

    const styleId = 'workspace-sandbox-clean-style';
    if (!doc.getElementById(styleId)) {
      const style = doc.createElement('style');
      style.id = styleId;
      style.textContent = `
        /* Remove only platform shell/chrome (not Univer internals) */
        app-main-layout .sidebar,
        app-main-layout .navbar,
        .sidebar,
        .left-sidebar,
        .navbar,
        .topbar,
        .block-header,
        app-navbar,
        app-sidebar,
        mat-sidenav,
        mat-sidenav-container > mat-sidenav {
          display: none !important;
        }

        /* Hide Paper manage metadata side panel + action buttons */
        .content-block > .row > .col-xl-3.col-lg-4.col-md-12.col-sm-12,
        .content-block > .row > .col-6.text-right {
          display: none !important;
        }

        /* Expand editor column full width */
        .content-block > .row > .col-xl-9.col-lg-8.col-md-12.col-sm-12 {
          flex: 0 0 100% !important;
          max-width: 100% !important;
          width: 100% !important;
          padding: 0 !important;
          margin: 0 !important;
        }

        /* Keep only editor surface */
        body, .content, .content-block, .content-block > .row,
        app-paper-manage, app-paper-editor, app-unified-editor,
        .unified-editor-container, .heavy-editor, .editor-mount-point,
        .card.shadow-sm, .card.shadow-sm > .body.bg-white.p-4 {
          width: 100% !important;
          max-width: 100% !important;
          height: 100% !important;
          min-height: 100% !important;
          margin: 0 !important;
          box-sizing: border-box !important;
        }

        .card.shadow-sm { border: 0 !important; box-shadow: none !important; }
        .card.shadow-sm > .body.bg-white.p-4 { padding: 0 !important; }

        html, body { overflow: hidden !important; background: #fff !important; }
      `;
      doc.head.appendChild(style);
    }
  }

  function installObserver() {
    try {
      const doc = frame.contentDocument;
      if (!doc) return;
      applyCleanView(doc);

      const observer = new MutationObserver(() => applyCleanView(doc));
      observer.observe(doc.documentElement, { childList: true, subtree: true, attributes: true });
    } catch (e) {
      document.body.innerHTML = `<div class="err">Unable to prepare clean paper viewer: ${e.message}</div>`;
    }
  }

  frame.addEventListener('load', () => {
    installObserver();
    try { frame.contentWindow?.dispatchEvent(new Event('resize')); } catch (e) {}
    let attempts = 0;
    const timer = setInterval(() => {
      attempts++;
      try {
        if (frame.contentDocument) { applyCleanView(frame.contentDocument); frame.contentWindow?.dispatchEvent(new Event('resize')); }
      } catch (e) {
        clearInterval(timer);
      }
      if (attempts > 40) clearInterval(timer);
    }, 250);
  });
})();
</script>
</body>
</html>
