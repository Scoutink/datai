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
        /* Remove app shell/chrome */
        app-main-layout .sidebar, .sidebar, .left-sidebar, .navbar, .topbar, .block-header,
        mat-sidenav, mat-sidenav-container > mat-sidenav, app-navbar, app-sidebar, header,
        .col-xl-3, .col-lg-4, .col-md-12 .card .header, button[color="primary"], button[color="warn"] {
          display: none !important;
        }

        /* Force editor area to occupy full frame */
        body, .content, .content-block, .row, .col-xl-9, .col-lg-8, .card, .card .body,
        app-paper-manage, app-paper-editor, app-unified-editor, .unified-editor-container, .heavy-editor,
        .editor-mount-point {
          margin: 0 !important;
          padding: 0 !important;
          width: 100% !important;
          max-width: 100% !important;
          min-width: 100% !important;
          height: 100% !important;
          min-height: 100% !important;
          box-sizing: border-box !important;
          background: #fff !important;
        }

        .content-block > .row > [class*="col-"] { flex: 0 0 100% !important; max-width: 100% !important; }
        .card { border: 0 !important; box-shadow: none !important; }
        .card .body { min-height: 100% !important; }
        body { overflow: hidden !important; }
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
    let attempts = 0;
    const timer = setInterval(() => {
      attempts++;
      try {
        if (frame.contentDocument) applyCleanView(frame.contentDocument);
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
