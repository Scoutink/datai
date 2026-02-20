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
<div id="diag" style="position:fixed;right:8px;bottom:8px;background:#111;color:#fff;font:12px Arial;padding:4px 8px;border-radius:6px;opacity:.75;z-index:9999">loading…</div>
<script>
(function () {
  const frame = document.getElementById('paperFrame');
  const diag = document.getElementById('diag');

  function applyCleanView(doc) {
    if (!doc || !doc.head || !doc.body) return;

    const styleId = 'workspace-sandbox-clean-style';
    if (!doc.getElementById(styleId)) {
      const style = doc.createElement('style');
      style.id = styleId;
      style.textContent = `
        /* Remove only host platform shell/chrome */
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

        /* Hide details/manage chrome around editor area */
        .content-block > .row > .col-xl-3.col-lg-4.col-md-12.col-sm-12,
        .content-block > .row > .col-6.text-right {
          display: none !important;
        }

        .header-buttons,
        mat-tab-header,
        .mat-mdc-tab-header,
        .mat-mdc-tab-label-container,
        .card > .header,
        .list-group,
        app-paper-comments,
        app-paper-versions,
        app-paper-audit-trail,
        app-paper-permissions {
          display: none !important;
        }

        /* Expand only layout shell, do not override Univer internal sizing */
        .content-block > .row > .col-xl-9.col-lg-8.col-md-12.col-sm-12 {
          flex: 0 0 100% !important;
          max-width: 100% !important;
          width: 100% !important;
          padding: 0 !important;
          margin: 0 !important;
        }

        .content, .content-block, .content-block > .row,
        .card.shadow-sm, .card.shadow-sm > .body.bg-white.p-4 {
          width: 100% !important;
          max-width: 100% !important;
          margin: 0 !important;
          box-sizing: border-box !important;
        }

        .card.shadow-sm { border: 0 !important; box-shadow: none !important; }
        .card.shadow-sm > .body.bg-white.p-4 {
          padding: 0 !important;
          min-height: 80vh !important; /* preserve app expected editor mount height */
        }

        .mat-mdc-tab-body-content,
        .mat-mdc-tab-body-active,
        app-paper-preview,
        .premium-wrapper,
        .content-container,
        .premium-native-view {
          height: 100% !important;
          min-height: 80vh !important;
        }

        html, body { background: #fff !important; }

        /* View mode: hide Univer top editing toolbars */
        .univer-workbench-container-header,
        .univer-doc-ui-toolbar,
        .univer-sheet-ui-toolbar {
          display: none !important;
        }

        /* Reclaim space after hiding header toolbars */
        .univer-workbench-container-content {
          top: 0 !important;
        }

        /* View mode: remove create/new sheet affordances */
        .univer-sheet-ui-footer .univer-icon-button[aria-label*="add" i],
        .univer-sheet-ui-footer .univer-icon-button[title*="add" i] {
          display: none !important;
        }
      `;
      doc.head.appendChild(style);
    }
  }

  function installObserver() {
    try {
      const doc = frame.contentDocument;
      if (diag) diag.textContent = `src ok | ready=${doc?.readyState || "?"}`;
      if (!doc) return;
      applyCleanView(doc);

      const observer = new MutationObserver(() => applyCleanView(doc));
      observer.observe(doc.documentElement, { childList: true, subtree: true, attributes: true });
    } catch (e) {
      document.body.innerHTML = `<div class="err">Unable to prepare clean paper viewer: ${e.message}</div>`;
    }
  }


  function installReadOnlyGuards() {
    try {
      const doc = frame.contentDocument;
      if (diag) diag.textContent = `src ok | ready=${doc?.readyState || "?"}`;
      if (!doc) return;

      const blockEdit = (event) => {
        const key = (event.key || '').toLowerCase();
        const ctrlOrMeta = event.ctrlKey || event.metaKey;
        const allowCombo = ctrlOrMeta && (key === 'c' || key === 'a');
        const allowNav = [
          'arrowup','arrowdown','arrowleft','arrowright','pageup','pagedown','home','end','tab','escape'
        ].includes(key);
        if (allowCombo || allowNav) return;
        const block = key === 'enter' || key === 'backspace' || key === 'delete' || key === ' ' || key.length === 1 ||
          (ctrlOrMeta && ['v','x','z','y','b','i','u'].includes(key));
        if (block) {
          event.preventDefault();
          event.stopPropagation();
        }
      };

      const blockMutatingInput = (event) => {
        event.preventDefault();
        event.stopPropagation();
      };

      doc.addEventListener('keydown', blockEdit, true);
      doc.addEventListener('beforeinput', blockMutatingInput, true);
      doc.addEventListener('paste', blockMutatingInput, true);
      doc.addEventListener('cut', blockMutatingInput, true);
      doc.addEventListener('drop', blockMutatingInput, true);
    } catch (e) {
      // best-effort sandbox guards only
    }
  }

  frame.addEventListener('load', () => {
    installObserver();
    installReadOnlyGuards();
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
