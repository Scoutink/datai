# Univer: Comprehensive Open-Source Framework Research
## Full-Stack Spreadsheet, Document & Slide Solution

**Version:** v2 (Corrected OSS/Pro boundary + package index + import/export reality)

---

## Table of Contents

1. [Executive Summary](#executive-summary)  
2. [What is Univer](#what-is-univer)  
3. [Core Architecture](#core-architecture)  
4. [Installation & Setup](#installation--setup)  
5. [Plugin System Deep Dive](#plugin-system-deep-dive)  
6. [Performance & Rendering Engine](#performance--rendering-engine)  
7. [Formula Engine Architecture](#formula-engine-architecture)  
8. [Features Comparison](#features-comparison)  
9. [Code Examples & Implementation](#code-examples--implementation)  
10. [Univer vs. Competitors](#univer-vs-competitors)  
11. [Lessons for Our JavaScript Implementation](#lessons-for-our-javascript-implementation)  
12. [Getting Started Guide](#getting-started-guide)  
13. [Appendix A: Preset Recommendations (OSS)](#appendix-a-preset-recommendations-oss)  
14. [Appendix B: Feature Availability by Mode](#appendix-b-feature-availability-by-mode)  
15. [Appendix C: Complete Plugin & Preset Catalog (Official Package Index)](#appendix-c-complete-plugin--preset-catalog-official-package-index)  
16. [Appendix D: Suggested Sandbox Checklist](#appendix-d-suggested-sandbox-checklist)  

---

## Executive Summary

**Univer** is an Apache 2.0 licensed, open-source full-stack framework for building spreadsheets, documents, and slides that can run in both browser and Node.js environments. It's positioned as a modern, high-performance alternative to Google Workspace and Microsoft Office Online.

### Key Highlights

✅ **Modular package ecosystem (OSS + Pro)**: Presets + plugins you compose  
✅ **Sheets + Docs + Slides**: Same SDK supports multiple document types  
✅ **Formula engine (OSS)**: Excel-like calculations with optional worker execution  
✅ **Canvas rendering (OSS)**: Custom render engine for performance  
✅ **Isomorphic patterns (OSS)**: Browser + Node.js runtimes supported  
✅ **Permissive OSS license (Apache-2.0)**: Core SDK + many presets/plugins are Apache-2.0  

⚠️ **Univer Pro is NOT open-source**: Features marked ⭐️ in the docs (e.g., collaboration, import/export, print/PDF, charts, pivot tables, sparklines, shapes) are delivered via `@univerjs-pro/*` packages under a separate license; some also require **Univer Server** and a **license token**.

### What “Open Source” covers (Reality Check)

- **Open-source (Apache-2.0):** `@univerjs/*` core packages + most OSS feature plugins + `@univerjs/preset-*` presets.
- **Pro / Non-OSS (separate license):** `@univerjs-pro/*` packages + features marked ⭐️. These are **not** Apache-2.0 and do not meet “MIT/Apache-only” requirements.

### Performance Claims

This document does **not** treat numeric performance claims as guaranteed benchmarks. Any scale/performance targets must be validated by your own sandbox stress tests on your target devices and enabled plugin set.

---

## What is Univer

### Product Suite

Univer is not just a spreadsheet. It's a complete document suite:

1. **Univer Sheets** — Spreadsheet engine (Excel-like)
2. **Univer Docs** — Document engine (Word-like)
3. **Univer Slides** — Presentation engine (PowerPoint-like)

### Key Differentiators

Unlike many "sheet libraries", Univer is:

- **Full stack**: Includes frontend rendering + backend-compatible data models
- **Modular**: Everything is presets/plugins
- **Performance-focused**: Canvas rendering and worker-capable formulas
- **Extensible**: Built for custom applications, not just embedding

---

## Core Architecture

### High-Level Architecture Diagram

```
┌─────────────────────────────────────────────┐
│                Your Application             │
│  (React/Vue/Angular/Vanilla + Backend)      │
└─────────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────────┐
│              Univer Framework                │
│   (Core DI + Command System + Plugins)      │
└─────────────────────────────────────────────┘
     │              │              │
     ▼              ▼              ▼
┌──────────┐  ┌──────────┐  ┌──────────┐
│  Sheets  │  │   Docs   │  │  Slides  │
│ Plugins  │  │ Plugins  │  │ Plugins  │
└──────────┘  └──────────┘  └──────────┘
     │              │              │
     ▼              ▼              ▼
┌─────────────────────────────────────────────┐
│         Engine Layer (Shared)               │
│  - Render Engine (Canvas)                   │
│  - Formula Engine (Worker-capable)          │
│  - Network/Sync Engine (as used)            │
└─────────────────────────────────────────────┘
```

### Core Design Principles

#### 1) Everything is a Plugin
Univer uses dependency injection (DI) and plugins for everything:

- Sheets = plugins
- Docs = plugins
- Features = plugins
- UI components = plugins

#### 2) Presets = Plugin Bundles
Presets are pre-configured collections of plugins:

- `preset-sheets-core` = minimum spreadsheet plugins
- `preset-sheets-advanced` = adds advanced features (some ⭐️ Pro)
- `preset-docs-core` = minimum document editor
- etc.

#### 3) Isomorphic Data Model
Same document model can be used in:
- Browser rendering
- Node.js backend processing
- Web workers
- Electron apps

---

## Installation & Setup

### Minimal Installation (Sheets Only)

#### Option 1: Use Presets (Recommended)

```bash
npm install @univerjs/presets @univerjs/preset-sheets-core
```

#### Option 2: Manual Plugins (Advanced Control)

```bash
npm install @univerjs/core @univerjs/engine-render @univerjs/engine-formula \
  @univerjs/ui @univerjs/design @univerjs/sheets @univerjs/sheets-ui \
  @univerjs/sheets-formula @univerjs/sheets-formula-ui
```

### Basic Setup Example (Preset Mode)

```ts
import { createUniver } from '@univerjs/presets'
import { UniverSheetsCorePreset } from '@univerjs/preset-sheets-core'
import '@univerjs/preset-sheets-core/lib/index.css'

const { univerAPI } = createUniver({
  locale: 'en-US',
  presets: [
    UniverSheetsCorePreset({
      container: 'app',
    }),
  ],
})

// Create a workbook
univerAPI.createWorkbook({
  name: 'My Sheet',
  sheetOrder: ['sheet1'],
  sheets: {
    sheet1: {
      name: 'Sheet1',
      cellData: {},
    },
  },
})
```

---

## Plugin System Deep Dive

### 1) Plugin Registration Flow

Univer has a dependency injection container. Plugins register:

1. Services
2. Commands
3. UI components
4. Hooks/events
5. Facade APIs

Example:

```ts
univer.registerPlugin(UniverSheetsPlugin)
univer.registerPlugin(UniverSheetsUIPlugin)
univer.registerPlugin(UniverFormulaEnginePlugin)
```

### 2) Preset vs Plugin Mode

| Mode | What You Write | What Univer Does |
|------|----------------|------------------|
| **Preset** | `createUniver({ presets: [...] })` | Auto-registers plugin bundles |
| **Plugin** | `univer.registerPlugin(...)` | Manual registration |

### 3) Core Plugin Catalog

#### Essential Core Plugins (OSS)

| Plugin | Package | Purpose |
|--------|---------|---------|
| Core Framework | `@univerjs/core` | DI container, command system |
| Render Engine | `@univerjs/engine-render` | Canvas rendering |
| Formula Engine | `@univerjs/engine-formula` | Calculation engine |
| UI Framework | `@univerjs/ui` | Menus, toolbars, UI base |
| Design System | `@univerjs/design` | Themes, tokens |

#### Sheets Plugins (OSS)

| Plugin | Package | Purpose |
|--------|---------|---------|
| Sheets Core | `@univerjs/sheets` | Spreadsheet data model |
| Sheets UI | `@univerjs/sheets-ui` | Grid rendering |
| Sheets Formula | `@univerjs/sheets-formula` | Formula integration |
| Sheets Formula UI | `@univerjs/sheets-formula-ui` | Formula bar/autocomplete |
| Num Format | `@univerjs/sheets-numfmt` | Number formatting |
| Num Format UI | `@univerjs/sheets-numfmt-ui` | Format UI |

#### Optional Feature Plugins (OSS)

| Feature | Packages |
|--------|----------|
| Data Validation | `@univerjs/data-validation`, `@univerjs/sheets-data-validation`, `@univerjs/sheets-data-validation-ui` |
| Conditional Formatting | `@univerjs/sheets-conditional-formatting`, `@univerjs/sheets-conditional-formatting-ui` |
| Filter | `@univerjs/sheets-filter`, `@univerjs/sheets-filter-ui` |
| Sort | `@univerjs/sheets-sort`, `@univerjs/sheets-sort-ui` |
| Find & Replace | `@univerjs/find-replace`, `@univerjs/sheets-find-replace` |
| Hyperlinks | `@univerjs/sheets-hyper-link`, `@univerjs/sheets-hyper-link-ui` |
| Notes | `@univerjs/sheets-note`, `@univerjs/sheets-note-ui` |
| Thread Comments | `@univerjs/thread-comment`, `@univerjs/thread-comment-ui`, `@univerjs/sheets-thread-comment`, `@univerjs/sheets-thread-comment-ui` |
| Drawing (images/shapes) | `@univerjs/drawing`, `@univerjs/drawing-ui`, `@univerjs/sheets-drawing`, `@univerjs/sheets-drawing-ui` |

#### Univer Pro Packages (Non-OSS; separate license), we ignore anything pro and not fully permisive open source. This pro info is for educational purposes.

> Pro features are delivered via `@univerjs-pro/*` and are **not** Apache-2.0. Some Pro features also require **Univer Server** and/or a **license token**.

| Package | Purpose |
|--------|---------|
| `@univerjs-pro/license` | License unlock/verification |
| `@univerjs-pro/collaboration` | Collaboration core |
| `@univerjs-pro/collaboration-client` | Collaboration client runtime |
| `@univerjs-pro/collaboration-client-ui` | Collaboration UI |
| `@univerjs-pro/collaboration-client-node` | Collaboration client for Node |
| `@univerjs-pro/collaboration-server` | Collaboration server components |
| `@univerjs-pro/live-share` | Live share / presence features |
| `@univerjs-pro/exchange-client` | Exchange client base (server-backed import/export) |
| `@univerjs-pro/sheets-exchange-client` | `.xlsx` import/export client |
| `@univerjs-pro/docs-exchange-client` | `.docx` import/export client |
| `@univerjs-pro/sheets-print` | Sheets print/PDF export |
| `@univerjs-pro/docs-print` | Docs print/PDF export |
| `@univerjs-pro/sheets-chart` | Charts |
| `@univerjs-pro/sheets-chart-ui` | Charts UI |
| `@univerjs-pro/sheets-pivot` | Pivot tables |
| `@univerjs-pro/sheets-pivot-ui` | Pivot tables UI |
| `@univerjs-pro/sheets-sparkline` | Sparklines |
| `@univerjs-pro/sheets-sparkline-ui` | Sparklines UI |
| `@univerjs-pro/sheets-shape` | Advanced shapes |
| `@univerjs-pro/sheets-shape-ui` | Shapes UI |
| `@univerjs-pro/engine-formula` | Pro formula engine (advanced/perf) |
| `@univerjs-pro/edit-history-loader` | Edit history loader |
| `@univerjs-pro/edit-history-viewer` | Edit history viewer UI |
| `@univerjs-pro/thread-comment-datasource` | Server-backed comment datasource |
| `@univerjs-pro/thread-comment-resource` | Server-backed comment resources |

### 4) Dependency Injection System

Univer uses DI heavily. Plugins can depend on services like:
- `ICommandService`
- `IConfigService`
- `IRenderManager`

---

## Performance & Rendering Engine

### Canvas Rendering

Univer uses a custom canvas engine (`engine-render`) for:
- Smooth scrolling
- Large grid rendering
- Efficient reflow
- Animations

### Virtualization Strategy (Conceptual)

- Render only visible cells
- Dirty-region updates
- Row/column virtualization
- Batched repaint cycles

---

## Formula Engine Architecture

### Formula Engine Components (OSS path)

1. **Core engine**: `@univerjs/engine-formula`
2. **Sheets integration**: `@univerjs/sheets-formula`
3. **UI layer**: `@univerjs/sheets-formula-ui`
4. **Worker support**: supported, depending on how you configure/ship worker runtime

### Worker Mode

Formula calculations can run in:
- Main thread (simple)
- Web Worker (recommended for large workbooks)
- Node.js worker threads (server use cases)

---

## Features Comparison

### Univer Sheets Features (OSS vs Pro Reality)

| Category | Open-Source (Apache-2.0) | Pro / License-Gated (⭐️) |
|----------|---------------------------|---------------------------|
| **Core spreadsheet** | Grid, rows/cols, multi-sheets, selection, copy/paste, undo/redo, keyboard shortcuts | — |
| **Formulas** | `engine-formula` + `sheets-formula` (+ UI) | Pro engine-formula upgrade |
| **Formatting** | Number formats, styles; conditional formatting via OSS plugins/presets | — |
| **Data tools** | Data validation, filter/sort, find/replace, hyperlinks, notes, thread comments | — |
| **Media** | Images/drawing via OSS drawing plugins | Charts, pivot, sparklines, advanced shapes |
| **Collaboration** | Local/offline only | Real-time collaboration (server + client) |
| **Import/Export** | — (not client-only) | `.xlsx` import/export via server + exchange client |
| **Print/PDF** | — | Pro print/PDF plugins |

### Univer Docs Features (OSS vs Pro Reality)

| Category | Open-Source (Apache-2.0) | Pro / License-Gated (⭐️) |
|----------|---------------------------|---------------------------|
| **Core editing** | Rich text engine, rendering, selection/cursor, basic UI | — |
| **Media** | Drawing/images via OSS drawing plugins | — |
| **Collaboration** | — | Real-time collaboration (server + client) |
| **Import/Export** | — (not client-only) | `.docx` import/export via server + exchange client |
| **Print/PDF** | — | Pro print/PDF plugins |

### Univer Slides Features

| Feature | Notes |
|---------|-------|
| Slides runtime | OSS packages exist (`@univerjs/slides`, `@univerjs/slides-ui`) |
| Advanced slide features | Validate needed features in a sandbox; slides are newer than sheets/docs |

---

## Code Examples & Implementation

### Example 1: Minimal Spreadsheet App (Preset Mode)

```ts
import { createUniver } from '@univerjs/presets'
import { UniverSheetsCorePreset } from '@univerjs/preset-sheets-core'
import '@univerjs/preset-sheets-core/lib/index.css'

const { univerAPI } = createUniver({
  locale: 'en-US',
  presets: [UniverSheetsCorePreset({ container: 'app' })],
})

univerAPI.createWorkbook({
  name: 'Demo',
  sheetOrder: ['sheet1'],
  sheets: {
    sheet1: { name: 'Sheet1', cellData: {} },
  },
})
```

### Example 2: Add Data Validation (OSS)

```bash
npm install @univerjs/preset-sheets-data-validation
```

```ts
import { createUniver } from '@univerjs/presets'
import { UniverSheetsCorePreset } from '@univerjs/preset-sheets-core'
import { UniverSheetsDataValidationPreset } from '@univerjs/preset-sheets-data-validation'
import '@univerjs/preset-sheets-core/lib/index.css'
import '@univerjs/preset-sheets-data-validation/lib/index.css'

createUniver({
  locale: 'en-US',
  presets: [
    UniverSheetsCorePreset({ container: 'app' }),
    UniverSheetsDataValidationPreset(),
  ],
})
```

### Example 3: Conditional Formatting (OSS)

```bash
npm install @univerjs/preset-sheets-conditional-formatting
```

### Example 4: Plugin Mode Setup (OSS Manual)

```ts
import { Univer } from '@univerjs/core'
import { UniverSheetsPlugin } from '@univerjs/sheets'
import { UniverSheetsUIPlugin } from '@univerjs/sheets-ui'
import { UniverFormulaEnginePlugin } from '@univerjs/engine-formula'
import { UniverSheetsFormulaPlugin } from '@univerjs/sheets-formula'

const univer = new Univer()

univer.registerPlugin(UniverSheetsPlugin)
univer.registerPlugin(UniverSheetsUIPlugin, { container: 'app' })
univer.registerPlugin(UniverFormulaEnginePlugin)
univer.registerPlugin(UniverSheetsFormulaPlugin)
```

### Example 5: Create Workbook with Data

```ts
univerAPI.createWorkbook({
  name: 'Sales',
  sheetOrder: ['sheet1'],
  sheets: {
    sheet1: {
      name: 'Sheet1',
      cellData: {
        0: { 0: { v: 100 }, 1: { v: 200 } },
        1: { 0: { v: 300 }, 1: { v: 400 } },
      },
    },
  },
})
```

### Example 6: Importing Excel (.xlsx) — Reality (Server + Pro)

> Univer `.xlsx` import/export is **server-backed** and exposed via **Pro** exchange clients and/or Pro-enabled presets. It is **not** a pure frontend OSS feature.

#### Preset Mode (Pro-enabled preset)

```bash
npm install @univerjs/preset-sheets-core @univerjs/preset-sheets-drawing @univerjs/preset-sheets-advanced
```

```ts
import { createUniver, LocaleType, mergeLocales } from '@univerjs/presets'

import { UniverSheetsCorePreset } from '@univerjs/preset-sheets-core'
import CoreEnUS from '@univerjs/preset-sheets-core/locales/en-US'

import { UniverSheetsDrawingPreset } from '@univerjs/preset-sheets-drawing'
import DrawingEnUS from '@univerjs/preset-sheets-drawing/locales/en-US'

import { UniverSheetsAdvancedPreset } from '@univerjs/preset-sheets-advanced'
import AdvancedEnUS from '@univerjs/preset-sheets-advanced/locales/en-US'

import '@univerjs/preset-sheets-core/lib/index.css'
import '@univerjs/preset-sheets-drawing/lib/index.css'
import '@univerjs/preset-sheets-advanced/lib/index.css'

const { univerAPI } = createUniver({
  locale: LocaleType.En_US,
  locales: {
    [LocaleType.En_US]: mergeLocales(CoreEnUS, DrawingEnUS, AdvancedEnUS),
  },
  presets: [
    UniverSheetsCorePreset({ container: 'app' }),
    UniverSheetsDrawingPreset(),
    UniverSheetsAdvancedPreset({
      universerEndpoint: 'http://localhost:3010',
      // license: 'YOUR_LICENSE_TOKEN', // if required for your Pro usage
    }),
  ],
})

async function importXlsxSnapshot(file: File) {
  const snapshot = await univerAPI.importXLSXToSnapshotAsync(file)
  univerAPI.createWorkbook(snapshot)
}
```

#### Plugin Mode (Pro exchange client)

```bash
npm install @univerjs-pro/exchange-client @univerjs-pro/sheets-exchange-client
```

```ts
import { LocaleType, mergeLocales, Univer } from '@univerjs/core'
import { UniverExchangeClientPlugin } from '@univerjs-pro/exchange-client'
import ExchangeClientEnUS from '@univerjs-pro/exchange-client/locale/en-US'
import { UniverSheetsExchangeClientPlugin } from '@univerjs-pro/sheets-exchange-client'

import '@univerjs-pro/exchange-client/facade'
import '@univerjs-pro/exchange-client/lib/index.css'

const univer = new Univer({
  locale: LocaleType.En_US,
  locales: {
    [LocaleType.En_US]: mergeLocales(ExchangeClientEnUS),
  },
})

const ENDPOINT = 'http://localhost:8000'

univer.registerPlugin(UniverExchangeClientPlugin, {
  uploadFileServerUrl: `${ENDPOINT}/universer-api/stream/file/upload`,
  importServerUrl: `${ENDPOINT}/universer-api/exchange/{type}/import`,
  exportServerUrl: `${ENDPOINT}/universer-api/exchange/{type}/export`,
  getTaskServerUrl: `${ENDPOINT}/universer-api/exchange/task/{taskID}`,
  signUrlServerUrl: `${ENDPOINT}/universer-api/file/{fileID}/sign-url`,
  downloadEndpointUrl: `${ENDPOINT}/`,
})

univer.registerPlugin(UniverSheetsExchangeClientPlugin)
```

### Example 7: Exporting to Excel (.xlsx) (Server + Pro)

```ts
import { downloadFile } from '@univerjs-pro/exchange-client'

async function exportXlsxSnapshot(univerAPI: any) {
  const fWorkbook = univerAPI.getActiveWorkbook()
  const snapshot = fWorkbook.getSnapshot()
  const file = await univerAPI.exportXLSXBySnapshotAsync(snapshot)
  downloadFile(file, 'univer', 'xlsx')
}
```

---

## Univer vs. Competitors

### Comparison Matrix (High-level)

| Feature | Univer (OSS) | Univer Pro (⭐️) | Jspreadsheet CE | SlickGrid |
|--------|--------------|------------------|-----------------|----------|
| License | Apache 2.0 | Non-OSS | CE vs Pro split | MIT |
| Formula engine | Yes | Yes (upgrade) | Split by tiers | No (you build) |
| Docs editor | Yes | Yes | No | No |
| Collaboration | No | Yes (server) | No | No |
| Import/Export | No | Yes (server) | Mixed | You build |
| Extensibility | High | High | Medium | High |

---

## Lessons for Our JavaScript Implementation

### Key Takeaways

1. **Plugin-first architecture** is essential for scalability  
2. **Presets are convenience bundles** for plugin sets  
3. **Canvas rendering** is used for performance  
4. **Worker-capable formulas** reduce UI blocking  
5. **Unified document model** enables reuse across products  
6. **Import/export and collaboration are complex** and typically server-backed for serious products  

---

## Getting Started Guide

### Step 1: Build a Sandbox

1. Create a Vite app
2. Install `@univerjs/presets` + `@univerjs/preset-sheets-core`
3. Confirm basic sheet works (multi-sheet, formulas, formatting)
4. Add OSS feature presets one-by-one (validation, filter, etc.)
5. Only after stable, evaluate ⭐️ Pro features (server + licensing)

### Step 2: Decide OSS vs Pro Requirements

If you need:
- Charts
- Pivot tables
- Import/export
- Print/PDF
- Real collaboration

Then you are in ⭐️ Pro territory and must plan for:
- Univer Server deployment
- License configuration
- `@univerjs-pro/*` packages

---

## Appendix A: Preset Recommendations (OSS)

### Minimal Spreadsheet
- `@univerjs/preset-sheets-core`

### Spreadsheet + Images
- `@univerjs/preset-sheets-core`
- `@univerjs/preset-sheets-drawing`

### Spreadsheet + Data Validation
- `@univerjs/preset-sheets-data-validation`

### Spreadsheet + Conditional Formatting
- `@univerjs/preset-sheets-conditional-formatting`

---

## Appendix B: Feature Availability by Mode

### The Key Truth: Preset = Pre-Packaged Plugins

**YES**, almost everything works in both modes because:
- Preset mode IS plugin mode, just pre-configured
- A preset is literally just a bundle of plugins

### Built-In to BOTH Modes (Core Features)

| Feature | Preset Mode | Plugin Mode | Notes |
|---------|-------------|-------------|------|
| Canvas Rendering | ✅ | ✅ | Render engine |
| Isomorphic Patterns | ✅ | ✅ | Architecture-level |
| Web Worker support (possible) | ✅ | ✅ | Depends on worker bundle/config |
| Plugin Architecture | ✅ | ✅ | Same DI container |

### Depends on WHICH Preset/Plugins You Install (OSS packages)

| Feature | Available? | How to Get It |
|---------|-----------|---------------|
| Formulas | ✅ OSS | `preset-sheets-core` or `engine-formula` + sheets formula plugins |
| Images/Drawing | ✅ OSS | `preset-sheets-drawing` or drawing plugins |
| Data Validation | ✅ OSS | `preset-sheets-data-validation` |
| Conditional Formatting | ✅ OSS | `preset-sheets-conditional-formatting` |
| Find & Replace | ✅ OSS | `preset-sheets-find-replace` |
| Hyperlinks | ✅ OSS | `preset-sheets-hyper-link` |
| Filtering | ✅ OSS | `preset-sheets-filter` |
| Sorting | ✅ OSS | `preset-sheets-sort` |
| Notes | ✅ OSS | `preset-sheets-note` |
| Thread Comments (local) | ✅ OSS | `preset-sheets-thread-comment` |

### ⭐️ Requires Univer Pro (Non-OSS) and sometimes Univer Server

These features are **not** Apache-2.0 and/or are license-gated. Many are exposed via Pro-enabled presets (e.g., `preset-sheets-advanced`) but still require Pro capability and (for exchange/collaboration) **Univer Server**.

| Feature | Reality | How to Get It |
|---------|---------|---------------|
| Charts | ⭐️ Pro | `@univerjs-pro/sheets-chart` + UI (or Pro-enabled preset) |
| Pivot Tables | ⭐️ Pro | `@univerjs-pro/sheets-pivot` + UI (or Pro-enabled preset) |
| Sparklines | ⭐️ Pro | `@univerjs-pro/sheets-sparkline` + UI |
| Advanced Shapes | ⭐️ Pro | `@univerjs-pro/sheets-shape` + UI |
| Collaboration | ⭐️ Pro + Server | Pro collaboration packages + Univer Server |
| Import/Export (.xlsx/.docx) | ⭐️ Pro + Server | Pro exchange client(s) + Univer Server |
| Print/PDF | ⭐️ Pro | Pro print plugins |

---

## Appendix C: Complete Plugin & Preset Catalog (Official Package Index)

This appendix lists packages by scope and category. Treat it as the canonical package naming reference.

### C.1 Presets (`@univerjs/preset-*`)

Common presets:

- `@univerjs/preset-docs-core`
- `@univerjs/preset-docs-advanced` *(Pro-enabled for some features like print/import/export)*
- `@univerjs/preset-sheets-core`
- `@univerjs/preset-sheets-advanced` *(Pro-enabled for features like charts/pivot/import/export/print)*
- `@univerjs/preset-sheets-conditional-formatting`
- `@univerjs/preset-sheets-data-validation`
- `@univerjs/preset-sheets-drawing`
- `@univerjs/preset-sheets-filter`
- `@univerjs/preset-sheets-find-replace`
- `@univerjs/preset-sheets-hyper-link`
- `@univerjs/preset-sheets-node-core`
- `@univerjs/preset-sheets-note`
- `@univerjs/preset-sheets-sort`
- `@univerjs/preset-sheets-thread-comment`

### C.2 Open-Source Plugins (`@univerjs/*`) (OSS)

Core/infrastructure:

- `@univerjs/action-recorder`
- `@univerjs/core`
- `@univerjs/design`
- `@univerjs/engine-formula`
- `@univerjs/engine-render`
- `@univerjs/network`
- `@univerjs/rpc`
- `@univerjs/rpc-node`
- `@univerjs/themes`
- `@univerjs/ui`
- `@univerjs/ui-adapter-vue3`
- `@univerjs/ui-adapter-web-component`
- `@univerjs/uniscript`
- `@univerjs/watermark`

Docs:

- `@univerjs/docs`
- `@univerjs/docs-ui`
- `@univerjs/docs-drawing`
- `@univerjs/docs-drawing-ui`
- `@univerjs/docs-hyper-link`
- `@univerjs/docs-hyper-link-ui`
- `@univerjs/docs-mention-ui`
- `@univerjs/docs-quick-insert-ui`
- `@univerjs/docs-thread-comment-ui`

Drawing:

- `@univerjs/drawing`
- `@univerjs/drawing-ui`

Sheets:

- `@univerjs/sheets`
- `@univerjs/sheets-ui`
- `@univerjs/sheets-formula`
- `@univerjs/sheets-formula-ui`
- `@univerjs/sheets-numfmt`
- `@univerjs/sheets-numfmt-ui`
- `@univerjs/sheets-filter`
- `@univerjs/sheets-filter-ui`
- `@univerjs/sheets-sort`
- `@univerjs/sheets-sort-ui`
- `@univerjs/sheets-find-replace`
- `@univerjs/sheets-hyper-link`
- `@univerjs/sheets-hyper-link-ui`
- `@univerjs/sheets-data-validation`
- `@univerjs/sheets-data-validation-ui`
- `@univerjs/sheets-conditional-formatting`
- `@univerjs/sheets-conditional-formatting-ui`
- `@univerjs/sheets-drawing`
- `@univerjs/sheets-drawing-ui`
- `@univerjs/sheets-note`
- `@univerjs/sheets-note-ui`
- `@univerjs/sheets-thread-comment`
- `@univerjs/sheets-thread-comment-ui`
- `@univerjs/sheets-crosshair-highlight`
- `@univerjs/sheets-graphics`
- `@univerjs/sheets-table`
- `@univerjs/sheets-table-ui`
- `@univerjs/sheets-zen-editor`

Shared feature plugins:

- `@univerjs/find-replace`
- `@univerjs/thread-comment`
- `@univerjs/thread-comment-ui`
- `@univerjs/data-validation`

Slides:

- `@univerjs/slides`
- `@univerjs/slides-ui`

### C.3 Univer Pro Plugins (`@univerjs-pro/*`) (Non-OSS; separate license)

- `@univerjs-pro/license`
- `@univerjs-pro/collaboration`
- `@univerjs-pro/collaboration-client`
- `@univerjs-pro/collaboration-client-node`
- `@univerjs-pro/collaboration-client-ui`
- `@univerjs-pro/collaboration-server`
- `@univerjs-pro/live-share`
- `@univerjs-pro/exchange-client`
- `@univerjs-pro/sheets-exchange-client`
- `@univerjs-pro/docs-exchange-client`
- `@univerjs-pro/sheets-print`
- `@univerjs-pro/docs-print`
- `@univerjs-pro/sheets-chart`
- `@univerjs-pro/sheets-chart-ui`
- `@univerjs-pro/sheets-pivot`
- `@univerjs-pro/sheets-pivot-ui`
- `@univerjs-pro/sheets-sparkline`
- `@univerjs-pro/sheets-sparkline-ui`
- `@univerjs-pro/sheets-shape`
- `@univerjs-pro/sheets-shape-ui`
- `@univerjs-pro/engine-formula`
- `@univerjs-pro/edit-history-loader`
- `@univerjs-pro/edit-history-viewer`
- `@univerjs-pro/thread-comment-datasource`
- `@univerjs-pro/thread-comment-resource`
- `@univerjs-pro/range-preprocess`
- `@univerjs-pro/mcp`
- `@univerjs-pro/mcp-ui`
- `@univerjs-pro/sheets-mcp`

### C.4 Import/Export and Print Reality (Summary)

- `.xlsx` / `.docx` import/export is **server-backed** (Univer Server) and exposed via **Pro exchange clients**.
- Print/PDF features are **Pro** plugins.
- Pro-enabled presets may include the wiring/config surface for these features, but they do not become “OSS-only.”

---

## Appendix D: Suggested Sandbox Checklist

### Goal: Validate “Works Out of the Box” vs “Needs Pro”

1. ✅ Install and run `@univerjs/preset-sheets-core`
2. ✅ Confirm formulas + formatting + multi-sheet
3. ✅ Add `@univerjs/preset-sheets-drawing` (images)
4. ✅ Add `@univerjs/preset-sheets-data-validation`
5. ✅ Add `@univerjs/preset-sheets-conditional-formatting`
6. ✅ Add `@univerjs/preset-sheets-filter` + `@univerjs/preset-sheets-sort`
7. ✅ Decide whether ⭐️ Pro features are acceptable:
   - If yes: plan server + license + exchange/print/collaboration
   - If no: lock scope to OSS capabilities
