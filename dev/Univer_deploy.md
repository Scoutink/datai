# Univer OSS Sandbox — Docs + Sheets + Slides (Flawless Standalone Smoke Tests)

> Goal: build **three separate, minimal-but-complete sandboxes** (Docs, Sheets, Slides) that run **out-of-the-box**, are **Apache-2.0 only**, and are structured so you can **lift the same bootstrap code into your platform later** without re-debugging.

---

## 0) Non-Negotiables (to prevent “endless cycles”)

### 0.1 Pin **ONE** Univer version across ALL packages
- Pick a single version (example: `0.15.5`) and pin it everywhere.
- **Do not** mix `0.15.3` + `0.15.5` etc.

### 0.2 Use HTTP server (never `file://`)
- Running `index.html` via `file://` causes asset/CORS failures (you already saw this).
- Always run via Vite dev server or any simple HTTP server.

### 0.3 Sandbox must be “integration-ready”
- We will create **plain TS modules** that expose:
  - `mountDocs(container)`
  - `mountSheets(container)`
  - `mountSlides(container)`
- Each returns `{ univer, dispose() }` so later embedding is just calling these functions.

### 0.4 No Univer Pro packages
- Do not install or import anything under `@univerjs-pro/*`.
- For XLSX import/export and certain “enterprise” features: treat as **NOT part of this sandbox** unless you later add Univer server + licensing.

---

## 1) Create the Sandbox Repo (Vite multi-page)

### 1.1 Create project
~~~bash
# Node 18+ recommended; pnpm recommended
npm create vite@latest univer-oss-sandbox -- --template vanilla-ts
cd univer-oss-sandbox
npm install
~~~

### 1.2 Add Univer packages (Docs + Sheets + Slides)
> Replace `0.15.5` below with your pinned version.

~~~bash
# Core preset helper
pnpm add @univerjs/presets@0.15.5

# Docs presets (OSS)
pnpm add @univerjs/preset-docs-core@0.15.5 @univerjs/preset-docs-drawing@0.15.5

# Sheets presets (OSS)
pnpm add @univerjs/preset-sheets-core@0.15.5 @univerjs/preset-sheets-drawing@0.15.5 @univerjs/preset-sheets-advanced@0.15.5

# Slides (plugin mode; OSS packages)
pnpm add @univerjs/core@0.15.5 @univerjs/design@0.15.5 @univerjs/ui@0.15.5
pnpm add @univerjs/docs@0.15.5 @univerjs/docs-ui@0.15.5
pnpm add @univerjs/drawing@0.15.5 @univerjs/drawing-ui@0.15.5
pnpm add @univerjs/engine-render@0.15.5 @univerjs/engine-formula@0.15.5
pnpm add @univerjs/slides@0.15.5 @univerjs/slides-ui@0.15.5

# Optional (embedding later): Web Component adapter (still OSS)
pnpm add @univerjs/ui-adapter-web-component@0.15.5
~~~

### 1.3 Pin versions hard (mandatory)
Create/modify `package.json`:
~~~json
{
  "pnpm": {
    "overrides": {
      "@univerjs/*": "0.15.5"
    }
  }
}
~~~

Then:
~~~bash
pnpm install
~~~

---

## 2) Project Structure (multi-page, clean separation)

Create these files:

~~~text
univer-oss-sandbox/
  index.html
  docs.html
  sheets.html
  slides.html
  vite.config.ts
  src/
    shared/
      univer-css.ts
      dom.ts
      locales.ts
      logger.ts
    docs/
      mount-docs.ts
      docs-main.ts
    sheets/
      mount-sheets.ts
      sheets-main.ts
      workbook-data.ts
    slides/
      mount-slides.ts
      slides-main.ts
      slides-data.ts
  styles/
    univer.css
    app.css
~~~

---

## 3) Vite Multi-Page Config

### 3.1 `vite.config.ts`
~~~ts
import { defineConfig } from 'vite';
import { resolve } from 'path';

export default defineConfig({
  build: {
    rollupOptions: {
      input: {
        hub: resolve(__dirname, 'index.html'),
        docs: resolve(__dirname, 'docs.html'),
        sheets: resolve(__dirname, 'sheets.html'),
        slides: resolve(__dirname, 'slides.html'),
      },
    },
  },
  server: {
    port: 5173,
    strictPort: true,
  },
});
~~~

---

## 4) HTML Pages (Hub + 3 sandboxes)

### 4.1 `index.html`
~~~html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Univer OSS Sandbox Hub</title>
    <link rel="stylesheet" href="/styles/app.css" />
  </head>
  <body>
    <div class="hub">
      <h1>Univer OSS Sandbox</h1>
      <p>Run each module standalone for isolated debugging.</p>
      <ul>
        <li><a href="/docs.html">Docs Sandbox</a></li>
        <li><a href="/sheets.html">Sheets Sandbox</a></li>
        <li><a href="/slides.html">Slides Sandbox</a></li>
      </ul>
    </div>
  </body>
</html>
~~~

### 4.2 Common pattern for `docs.html`, `sheets.html`, `slides.html`
**IMPORTANT CSS rules**:
- The Univer container must have **real height**.
- No `transform` / `filter` / `perspective` on ancestors.
- No global CSS like `* { user-select: none; }`.

#### `docs.html`
~~~html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Docs Sandbox</title>
    <link rel="stylesheet" href="/styles/app.css" />
  </head>
  <body>
    <div class="topbar">
      <a href="/index.html">Back to Hub</a>
      <span>Docs Sandbox</span>
    </div>
    <div id="univer-root" class="univer-root"></div>
    <script type="module" src="/src/docs/docs-main.ts"></script>
  </body>
</html>
~~~

#### `sheets.html`
~~~html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sheets Sandbox</title>
    <link rel="stylesheet" href="/styles/app.css" />
  </head>
  <body>
    <div class="topbar">
      <a href="/index.html">Back to Hub</a>
      <span>Sheets Sandbox</span>
    </div>
    <div id="univer-root" class="univer-root"></div>
    <script type="module" src="/src/sheets/sheets-main.ts"></script>
  </body>
</html>
~~~

#### `slides.html`
~~~html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Slides Sandbox</title>
    <link rel="stylesheet" href="/styles/app.css" />
  </head>
  <body>
    <div class="topbar">
      <a href="/index.html">Back to Hub</a>
      <span>Slides Sandbox</span>
    </div>
    <div id="univer-root" class="univer-root"></div>
    <script type="module" src="/src/slides/slides-main.ts"></script>
  </body>
</html>
~~~

---

## 5) CSS (do not improvise)

### 5.1 `/styles/app.css`
~~~css
html, body {
  margin: 0;
  height: 100%;
  width: 100%;
  overflow: hidden;
  font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
}

.topbar {
  height: 56px;
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 0 16px;
  border-bottom: 1px solid #e5e5e5;
  background: #111;
  color: #fff;
}

.topbar a { color: #9ae6ff; text-decoration: none; }
.topbar a:hover { text-decoration: underline; }

.univer-root {
  height: calc(100vh - 56px);
  width: 100vw;
  /* DO NOT add transform/filter/perspective here */
}

.hub { padding: 24px; }
~~~

### 5.2 `/styles/univer.css` (all Univer CSS imports in one place)
> **Order matters**. Keep this file as the single source.

~~~css
/* Univer base UI + design tokens */
@import "@univerjs/design/lib/index.css";
@import "@univerjs/ui/lib/index.css";

/* Docs (core) */
@import "@univerjs/preset-docs-core/lib/index.css";
@import "@univerjs/preset-docs-drawing/lib/index.css";

/* Sheets (core + drawing + advanced) */
@import "@univerjs/preset-sheets-core/lib/index.css";
@import "@univerjs/preset-sheets-drawing/lib/index.css";
@import "@univerjs/preset-sheets-advanced/lib/index.css";

/* Slides (plugin mode) */
@import "@univerjs/slides-ui/lib/index.css";
@import "@univerjs/drawing-ui/lib/index.css";
@import "@univerjs/docs-ui/lib/index.css";
~~~

---

## 6) Shared Utilities

### 6.1 `src/shared/univer-css.ts`
~~~ts
import '../../styles/univer.css';
~~~

### 6.2 `src/shared/dom.ts`
~~~ts
export function mustGetRoot(): HTMLElement {
  const el = document.getElementById('univer-root');
  if (!el) throw new Error('Missing #univer-root container.');
  return el;
}

export function assertContainerReady(el: HTMLElement) {
  const rect = el.getBoundingClientRect();
  if (rect.width < 50 || rect.height < 50) {
    throw new Error(
      `Container size invalid (${rect.width}x${rect.height}). ` +
      `Fix CSS so #univer-root has real size before mounting.`
    );
  }
}
~~~

### 6.3 `src/shared/logger.ts`
~~~ts
export function installGlobalErrorHooks(tag: string) {
  window.addEventListener('error', (e) => {
    console.error(`[${tag}] window.error`, e.error || e.message, e);
  });
  window.addEventListener('unhandledrejection', (e) => {
    console.error(`[${tag}] unhandledrejection`, e.reason, e);
  });
}
~~~

### 6.4 `src/shared/locales.ts`
> Keep locales minimal. Add more later.

~~~ts
import { LocaleType, mergeLocales } from '@univerjs/core';

import DesignEnUS from '@univerjs/design/locale/en-US';
import UIEnUS from '@univerjs/ui/locale/en-US';
import DocsUIEnUS from '@univerjs/docs-ui/locale/en-US';
import SheetsEnUS from '@univerjs/sheets/locale/en-US';
import SheetsUIEnUS from '@univerjs/sheets-ui/locale/en-US';
import SlidesUIEnUS from '@univerjs/slides-ui/locale/en-US';

export function getLocales() {
  return {
    locale: LocaleType.EN_US,
    locales: {
      [LocaleType.EN_US]: mergeLocales(
        DesignEnUS,
        UIEnUS,
        DocsUIEnUS,
        SheetsEnUS,
        SheetsUIEnUS,
        SlidesUIEnUS
      ),
    },
  };
}
~~~

---

## 7) DOCS Sandbox (Preset Mode, stable)

### 7.1 `src/docs/mount-docs.ts`
~~~ts
import '../shared/univer-css';
import { createUniver, UniverInstanceType } from '@univerjs/presets';
import { UniverDocsCorePreset } from '@univerjs/preset-docs-core';
import { UniverDocsDrawingPreset } from '@univerjs/preset-docs-drawing';

import { assertContainerReady } from '../shared/dom';
import { getLocales } from '../shared/locales';

export function mountDocs(container: HTMLElement) {
  assertContainerReady(container);

  const { locale, locales } = getLocales();

  const univer = createUniver({
    locale,
    locales,
    // Presets prevent missing-service issues (editor service, selection render, etc.)
    presets: [
      UniverDocsCorePreset({
        container,
      }),
      // Optional: images/drawing in docs (still OSS)
      UniverDocsDrawingPreset({}),
    ],
  });

  // Create a doc unit with minimal data
  univer.createUnit(UniverInstanceType.UNIVER_DOC, {
    id: 'doc-1',
    body: {
      dataStream: 'Hello from Univer Docs!\n\nType here.\n',
      textRuns: [],
      paragraphs: [
        { startIndex: 0 },
      ],
      sectionBreaks: [{ startIndex: 0 }],
    },
    documentStyle: {},
  });

  return {
    univer,
    dispose() {
      univer?.dispose?.();
    },
  };
}
~~~

### 7.2 `src/docs/docs-main.ts`
~~~ts
import { mustGetRoot } from '../shared/dom';
import { installGlobalErrorHooks } from '../shared/logger';
import { mountDocs } from './mount-docs';

installGlobalErrorHooks('DOCS');

const root = mustGetRoot();

// mount only after layout is ready
requestAnimationFrame(() => {
  mountDocs(root);
});
~~~

### 7.3 Docs Smoke Test Checklist
- [ ] Page loads, cursor appears, typing works
- [ ] Selection highlights text
- [ ] Toolbar/ribbon visible (UI preset)
- [ ] No redi DI errors in console

---

## 8) SHEETS Sandbox (Preset Mode + “Advanced”, stable)

> IMPORTANT: Sheets **still depends on Docs UI services** for certain editor behaviors. Preset mode avoids the “univer.editor.service missing” failure.

### 8.1 `src/sheets/workbook-data.ts`
~~~ts
export const WORKBOOK_DATA = {
  id: 'wb-1',
  name: 'Sandbox Workbook',
  sheetOrder: ['sheet-1'],
  sheets: {
    'sheet-1': {
      id: 'sheet-1',
      name: 'Sheet1',
      rowCount: 200,
      columnCount: 50,
      cellData: {
        0: {
          0: { v: 'Try formulas:' },
          1: { v: '=SUM(1,2,3)' },
          2: { v: '=A2*10' },
        },
        1: {
          0: { v: 5 },
          1: { v: 2 },
        },
      },
    },
  },
};
~~~

### 8.2 `src/sheets/mount-sheets.ts`
~~~ts
import '../shared/univer-css';

import { createUniver, UniverInstanceType } from '@univerjs/presets';
import { UniverSheetsCorePreset } from '@univerjs/preset-sheets-core';
import { UniverSheetsDrawingPreset } from '@univerjs/preset-sheets-drawing';
import { UniverSheetsAdvancedPreset } from '@univerjs/preset-sheets-advanced';

import { assertContainerReady } from '../shared/dom';
import { getLocales } from '../shared/locales';
import { WORKBOOK_DATA } from './workbook-data';

export function mountSheets(container: HTMLElement) {
  assertContainerReady(container);

  const { locale, locales } = getLocales();

  const univer = createUniver({
    locale,
    locales,
    presets: [
      UniverSheetsCorePreset({
        container,
        // keep defaults; add config only after stable
      }),
      // Drawing preset required for some advanced features and prevents runtime gaps
      UniverSheetsDrawingPreset({}),
      // Advanced preset adds more UI/features (OSS). Keep it AFTER drawing.
      UniverSheetsAdvancedPreset({
        // Do NOT enable Pro/server features here
        useWorker: true,
      }),
    ],
  });

  univer.createUnit(UniverInstanceType.UNIVER_SHEET, WORKBOOK_DATA as any);

  return {
    univer,
    dispose() {
      univer?.dispose?.();
    },
  };
}
~~~

### 8.3 `src/sheets/sheets-main.ts`
~~~ts
import { mustGetRoot } from '../shared/dom';
import { installGlobalErrorHooks } from '../shared/logger';
import { mountSheets } from './mount-sheets';

installGlobalErrorHooks('SHEETS');

const root = mustGetRoot();

requestAnimationFrame(() => {
  mountSheets(root);
});
~~~

### 8.4 Sheets Input/Caret “No Cursor” Hard Fix Checklist
If you can click/select but cannot type (caret never appears), DO ALL of the below:

1) **Confirm container has size**
- `#univer-root` must be visible and > 50x50 at mount time.

2) **Confirm no ancestor has `transform`**
- In DevTools, check computed style:
  - if any parent has `transform: translate3d(...)` or `transform: scale(...)`, remove it.
  - This can break hidden editor/textarea positioning in canvas-driven editors.

3) **Confirm `styles/univer.css` is loaded and not overridden**
- Ensure no global rule sets:
  - `caret-color: transparent;`
  - `user-select: none;`
  - `pointer-events: none;`
  - `outline: none;` (outline is fine; pointer-events is not)

4) **Confirm version pinning**
- Run:
~~~bash
pnpm why @univerjs/core
pnpm why @univerjs/docs-ui
~~~
- If multiple versions appear: fix overrides and reinstall.

5) **Confirm presets only**
- Do not mix plugin-mode registration with presets in the same page until stable.

---

## 9) SLIDES Sandbox (Plugin Mode, safest known pattern)

> Slides is the most fragile. We follow the known working plugin stack & order:
- Register **Drawing before Render**
- Register **Docs + Docs-UI** (text editing services)
- Provide **initial slide data** (prevents null `pageElements`)
- Provide a safe approach for image insert (avoid missing `core.image-io.service` crash)

### 9.1 `src/slides/slides-data.ts` (minimal valid deck)
~~~ts
export const SLIDE_DATA: any = {
  id: 'deck-1',
  title: 'Sandbox Deck',
  // Minimal structure; may evolve with Univer versions.
  pages: [
    {
      id: 'slide-1',
      pageElements: [],
      background: { color: '#ffffff' },
    },
  ],
  activePageId: 'slide-1',
};
~~~

### 9.2 `src/slides/mount-slides.ts`
~~~ts
import '../shared/univer-css';

import { Univer, LocaleType, mergeLocales, UniverInstanceType } from '@univerjs/core';
import DesignEnUS from '@univerjs/design/locale/en-US';
import { UniverUIPlugin } from '@univerjs/ui';
import UIEnUS from '@univerjs/ui/locale/en-US';

import { UniverDocsPlugin } from '@univerjs/docs';
import { UniverDocsUIPlugin } from '@univerjs/docs-ui';
import DocsUIEnUS from '@univerjs/docs-ui/locale/en-US';

import { UniverDrawingPlugin } from '@univerjs/drawing';
import { UniverDrawingUIPlugin } from '@univerjs/drawing-ui';

import { UniverRenderEnginePlugin } from '@univerjs/engine-render';
import { UniverFormulaEnginePlugin } from '@univerjs/engine-formula';

import { UniverSlidesPlugin } from '@univerjs/slides';
import { UniverSlidesUIPlugin } from '@univerjs/slides-ui';
import SlidesUIEnUS from '@univerjs/slides-ui/locale/en-US';

import { assertContainerReady } from '../shared/dom';
import { SLIDE_DATA } from './slides-data';

// Optional: If you later need WebComponent adaptation
// import { UniverWebComponentAdapterPlugin } from '@univerjs/ui-adapter-web-component';

export function mountSlides(container: HTMLElement) {
  assertContainerReady(container);

  const univer = new Univer({
    locale: LocaleType.EN_US,
    locales: {
      [LocaleType.EN_US]: mergeLocales(
        DesignEnUS,
        UIEnUS,
        DocsUIEnUS,
        SlidesUIEnUS
      ),
    },
  });

  // IMPORTANT ORDER:
  // Drawing must be registered BEFORE Render (known requirement in examples/issues)
  univer.registerPlugin(UniverDrawingPlugin);
  univer.registerPlugin(UniverRenderEnginePlugin);
  univer.registerPlugin(UniverFormulaEnginePlugin);

  univer.registerPlugin(UniverUIPlugin, { container });

  // Docs provides editor services used by Slides text editing
  univer.registerPlugin(UniverDocsPlugin);
  univer.registerPlugin(UniverDocsUIPlugin);

  univer.registerPlugin(UniverDrawingUIPlugin);

  univer.registerPlugin(UniverSlidesPlugin);
  univer.registerPlugin(UniverSlidesUIPlugin);

  // univer.registerPlugin(UniverWebComponentAdapterPlugin);

  // Create unit WITH data to avoid null pageElements crashes
  univer.createUnit(UniverInstanceType.UNIVER_SLIDE, SLIDE_DATA);

  return {
    univer,
    dispose() {
      univer?.dispose?.();
    },
  };
}
~~~

### 9.3 `src/slides/slides-main.ts`
~~~ts
import { mustGetRoot } from '../shared/dom';
import { installGlobalErrorHooks } from '../shared/logger';
import { mountSlides } from './mount-slides';

installGlobalErrorHooks('SLIDES');

const root = mustGetRoot();

requestAnimationFrame(() => {
  mountSlides(root);
});
~~~

### 9.4 Slides: Prevent the `core.image-io.service` crash (until backend exists)
Your current image insertion triggers:
- `Expect 1 dependency item(s) for id "core.image-io.service" but get 0`

For this sandbox phase:
- **Disable image insert UI** OR **do not click it** until you wire a proper image IO service.
- This is not “a backend problem”; it is a missing dependency/service. We keep Slides stable first.

**Hard rule for sandbox:**
- If Slides text and shape tools work, we accept stability.
- Image insert becomes Phase 2 (after Docs+Sheets are stable).

---

## 10) Run Commands (the only correct way)

### 10.1 Dev mode
~~~bash
pnpm dev
~~~
Open:
- `http://localhost:5173/`
- `http://localhost:5173/docs.html`
- `http://localhost:5173/sheets.html`
- `http://localhost:5173/slides.html`

### 10.2 Production build (simulate later platform deployment)
~~~bash
pnpm build
pnpm preview
~~~

---

## 11) Forensic Mapping: Your Reported Errors → Root Cause → Fix

### 11.1 `vite.svg 404`
**Root cause**: leftover Vite starter reference or wrong base/assets path.
**Fix**:
- Remove `vite.svg` references from your templates OR ensure correct `base` in Vite when deploying under subfolder later.

### 11.2 `SelectionRenderService: should not receive null!`
**Root cause**: usually container dimension is zero at init time OR DOM not ready.
**Fix**:
- `assertContainerReady(container)`
- mount in `requestAnimationFrame`
- ensure `.univer-root` has real height

### 11.3 `Cannot find "univer.editor.service"...`
**Root cause**: missing Docs UI/editor service registration in the DI container (happens in plugin mode if you didn’t register Docs UI; also affected by breaking changes).
**Fix**:
- Use presets for Sheets.
- In plugin mode, register `UniverDocsPlugin` + `UniverDocsUIPlugin` BEFORE Sheets/Slides UI.

### 11.4 Sheets “can select but can’t type; caret never appears”
**Root causes (most common)**:
- mixed versions
- missing CSS
- container is in a transformed ancestor
- plugin-mode gaps (missing docs-ui editor services)
**Fix**:
- use Sheets preset mode as above
- verify no transforms on parents
- pin versions

### 11.5 Slides `Cannot read properties of null (reading 'pageElements')`
**Root cause**: slide unit created without valid initial data OR UI command called before unit fully exists.
**Fix**:
- create slide unit with minimal `SLIDE_DATA` that includes at least one page with `pageElements: []`.
- don’t trigger commands before `createUnit` completes.

---

## 12) Acceptance Criteria (must pass before ANY platform embedding)

### Docs
- [ ] typing works
- [ ] selection & caret visible
- [ ] no console DI errors

### Sheets
- [ ] click cell, caret appears, typing works
- [ ] formula engine works: `=SUM(1,2,3)` produces result
- [ ] resize rows/cols works
- [ ] no DI errors

### Slides
- [ ] slide renders on load (at least 1 page)
- [ ] insert text does not crash
- [ ] shapes do not crash
- [ ] image insert is not tested yet (Phase 2), but must not crash app by default

---

## 13) Phase 2 (only after Phase 1 passes)
- Implement image IO service for slides (and optionally docs/sheets drawing uploads)
- Decide if you want XLSX import/export (often server + licensing territory)
- Consolidate “UnifiedHub” only after each module is stable standalone

---

## 14) Start Checklist for a Junior Dev (do exactly in order)

1) Clone repo, install, run dev server.
2) Open Docs page, confirm typing.
3) Open Sheets page, confirm cell typing + formula result.
4) Open Slides page, confirm text + shapes.
5) If any page fails:
   - stop
   - fix only within that page’s `mount-*` module
   - do not touch other modules
6) Only after all pass: build/preview and re-test.

---

## 15) Deployment updates (Critical Fixes Log)

These updates record the fixes applied to resolve runtime crashes, interactivity issues, and the "Univer Pro" watermark during the initial stabilization phase.

### 15.1 Build Stability: Rollup `traceVariable` Error
- **Issue**: Standard static imports in `mount-*` files caused Rollup to fail during AST parsing due to depth/complexity parsing limits.
- **Fix**: Refactored module mount logic to use **Dynamic Imports** (`await import()`) for presets and plugins. This isolates large modules into separate chunks and ensures stable builds.

### 15.2 Fix: "createUnit is not a function" (Docs & Sheets)
- **Issue**: The `createUniver` helper in `v0.15.x` returns a wrapper object `{ univer, univerAPI }`.
- **Fix**: Destructure the return value properly: `const { univer } = createUniver({ ... })`. Calling `createUnit` on the wrapper itself causes a crash.

### 15.3 Fix: Sheets Inactivity & Missing UI Labels (`ribbon.data`)
- **Issue**: Sheets grid rendered but was frozen, and toolbar buttons showed raw keys like `sheet.numfmt.general`.
- **Fix**: 
    - Resolved the `createUniver` crash above.
    - Flattened the `locales.ts` merging logic to ensure the `LocaleService` correctly hydrates UI strings from the merged locale object.

### 15.4 Fix: Removing "Univer Pro" Watermark
- **Issue**: Using `UniverSheetsAdvancedPreset` pulls in several trial Pro dependencies, triggering a watermark and license notice.
- **Fix**: Purged `@univerjs/preset-sheets-advanced` and replaced it with strictly OSS individual presets from the `@univerjs/presets` package.
- **Mandatory Individual Presets**:
    - `UniverSheetsFilterPreset`
    - `UniverSheetsDataValidationPreset`
    - `UniverSheetsConditionalFormattingPreset`
    - `UniverSheetsSortPreset`
- **Precise Imports**: These MUST be imported via their specific subpaths (e.g., `import { ... } from '@univerjs/presets/preset-sheets-filter'`) to avoid `undefined` exports from the main presets index.

### 15.5 Slides: Stability & Crash Prevention
- **Issue 1**: Crash on `pageElements` during initialization.
- **Fix 1**: Adjusted `SLIDE_DATA` to use a **keyed-object (Map-style)** for the `pages` list instead of a flat array.
- **Issue 2**: Dependency Injection (DI) errors for drawing services.
- **Fix 2**: Enforced registration order: `UniverDrawingPlugin` MUST be registered **before** `UniverRenderEnginePlugin`.
- **Issue 3**: `core.image-io.service` missing.
- **Note**: This is an experimental feature requiring a backend service. For Phase 1 stabilization, image insertion is considered out-of-scope to maintain core interactivity stability.

### 15.6 Docs: Forensic Stabilization (Indices & Layout)
- **Issue**: The error `Cannot read properties of undefined (reading 'segmentId')` occurs on load.
- **Root Cause**: The DocBody skeleton is malformed. Univer Docs require specific line endings and perfectly aligned markers for the rendering engine to map the text to the body segment.
- **Fix (DocBody Skeleton)**:
    - Ensure `dataStream` ends with `\r\n`.
    - `startIndex` for paragraphs must point to the `\r` character.
    - `startIndex` for section breaks must point to the `\n` character.
    - If your stream is 23 chars + `\r\n` (length 25), paragraph index should be `23` and section break `24`.
- **Fix (Page Setup Crash)**: Always provide explicit `documentStyle` with `pageSize` (A4: 595.27 x 841.88) and margins. Defaulting to an empty object `{}` can cause `undefined` width/height crashes in the Page Setup dialog.

### 15.7 Docs: "Insert" Feature Safety & Drawing Metadata
- **Issue**: Attempting to insert an image or link causes `TypeError: Cannot read properties of undefined (reading 'layoutType')`.
- **Root Cause**: The Drawing plugin requires a initialized drawing collection in the unit data.
- **Fix**: When creating a unit, always include empty placeholders for drawings:
  ```typescript
  drawings: {},
  drawingsOrder: [],
  ```
- **Handling Pro Features (Tables)**: 
    - In v0.15.5, Doc Tables are Pro-limited and will crash the OSS build with "Table not found".
    - **UI Hiding Strategy**: To avoid user errors while keeping the build license-compliant and watermark-free, hide the Table button via CSS in `app.css`:
      ```css
      .univer-toolbar-item[title*="Table"], [data-univer-id*="table"] { display: none !important; }
      ```

# 16) Interactivity & Reactivity: Post-Integration Lessons

As we moved from "mounting" to "interactive use", we encountered high-level state and reactivity issues that are common when embedding Univer in a SPA (Single Page Application).

### 16.1 Fix: Toolbar Buttons "Do Nothing" (Unit Focus)
- **Issue**: The toolbar renders and buttons change hover state, but clicking "Bold" or "Italic" has no effect on the document.
- **Root Cause**: Univer's internal command system (especially in the UI layer) relies on an **Active Unit**. If multiple units exist or if the unit was created "statically", the toolbar may not know which document context to target.
- **Fix**: Call `instanceService.focusUnit(unitId)` immediately after `createUnit`. This connects the UI's command handlers to the specific document/sheet.

### 16.2 Fix: "Sheet" Mode selection shows nothing (Hot-Switching)
- **Issue**: Switching content type from Doc to Sheet in a live "Add" form (without a page reload) resulted in the editor remaining in Doc mode.
- **Root Cause**: The component logic was tied to `ngAfterViewInit` (initial mount). Angular components don't re-run initialization code when `@Input` values change unless explicitly told.
- **Fix**: Implement `OnChanges`. When `mode` or `initialData` changes, call `univer.dispose()` and trigger a full re-initialization. Use `requestAnimationFrame` to ensure the old DOM is cleaned before the new instance mounts.

### 16.3 Fix: Save/Persistence Collision (`getData` Bug)
- **Issue**: Saving a Sheet would sometimes result in a blank Document JSON being stored.
- **Root Cause**: `instanceService.getCurrentUnitForType()` without explicit type check can return the "wrong" unit if the engine state has ghost instances.
- **Fix**: In the `getData()` bridge, explicitly request the snapshot by type matching the current component mode:
  ```typescript
  const unitType = this.mode === 'DOC' ? UniverInstanceType.UNIVER_DOC : UniverInstanceType.UNIVER_SHEET;
  const activeUnit = instanceService.getCurrentUnitForType(unitType);
  ```

### 16.4 High-Fidelity Read-Only Viewer
- **Requirement**: Content must be high-fidelity (not just flat HTML) but must prevent all user edits.
- **Implementation**:
    - Pass a `readOnly` boolean to the wrapper.
    - Conditionally **SKIP** registration of the `UniverUIPlugin` workbench options (toolbar: false, etc.).
    - This transforms the "Editor" into a "Viewer" while keeping the engine's high-fidelity layout engine active.

---

# 17) Integration Log: Landing Univer in DATAI (Forensic Summary)

This log documents the transition from the standalone sandbox to the native platform integration, detailing the "Golden Architecture" for future module embeddings.

### 17.1 The Golden Architecture (Native Platform Integration)
To integrate heavy JS engines like Univer into an existing Angular/Laravel platform safely, we follow this **Organic Wrapper** pattern:

1. **The Native Wrapper (`UnifiedEditorComponent`)**:
   - Encapsulates the engine lifecycle.
   - Handles `ngOnChanges` for hot-switching content types.
   - Blocks UI plugins registration in `readOnly` mode to create a clean, non-editable viewer.
2. **Explicit Dependency Orchestration**:
   - Presets are avoided for the final platform layer.
   - **Manual Plugin Registration** allows filtering out Pro-limited features and minimizing bundle size.
3. **Core API over Facade**:
   - We use `univer.createUnit` and `IUniverInstanceService` for data operations.
4. **Mode-Aware Snapshotting**:
   - Component logic ensures snapshots are taken from the unit type matching the current mode (`DOC` vs `SHEET`).

### 17.2 Integration Timeline (What We Did Right & Wrong)

| Phase | Action | Result | Lesson Learned |
| :--- | :--- | :--- | :--- |
| **Fail 1** | Iframe Bridge | 500 Errors / Security Blocks | Iframes introduce overhead and cross-origin complexity. |
| **Fail 2** | Preset Helper | `fo` dependency crash | Presets can hide missing mandatory dependencies (like Network/Formula). |
| **Fail 3** | Static Init | No Hot-Switching | Inputs must trigger full re-build of the engine instance in SPAs. |
| **Success 1** | Organic Integration | High performance / Branded UI | Native integration allows direct memory access. |
| **Success 2** | Manual Plugin Order | 100% Stability | Explicit registration (e.g., Drawing before Render) solves all layout crashes. |
| **Success 3** | Unit Focusing | Interactive Toolbar | Commands require explicit `focusUnit` after unit creation. |
| **Success 4** | Workbench Hiding | Secure Viewer | Deactivating UI plugins in `readOnly` mode is the safest way to implement high-fidelity "View" pages. |

### 17.3 Forensic Advice: Future Content Types (Slides, Whiteboard)
When expanding the platform:
1. **Type-Specific Snapshots**: Always update the `getData()` logic to recognize and prioritize the specific unit type of the new content.
2. **Skeleton Integrity**: Never pass empty objects `{}`. New types require valid unit JSON skeletons (e.g., Slides require keyed `pages` objects).
3. **Read-Only Sensitivity**: Some UI plugins (like Formula UI) must be disabled in Viewer mode to prevent "ghost" editor UI elements from appearing.
4. **CSS Isolation**: Always verify that the engine's internal portals (modals, dropdowns) are contained within the platform's layout constraints.

---