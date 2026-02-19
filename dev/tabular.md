# SlickGrid “Spreadsheet Kit” — OSS-Only Sandbox Build Plan (Framework-Agnostic, Integration-Ready)

> Deliverable: a **reusable** “Spreadsheet Kit” package built in a sandbox repo, with:
> - SlickGrid + plugins (selection, ranges, menus, copy/paste, grouping, state)
> - Multi-sheet workbook (tabs)
> - Formatting (styles)
> - Merge / unmerge (visual + behavioral correctness)
> - Formulas in cells + Formula Bar + toolbar functions (SUM/AVG/etc)
> - Import/Export (XLSX/CSV) within defined scope
> - Automated regression tests (unit + e2e)
> - Packaged as a library so later integration is “drop-in” (no rewrite)

---

## 0) Rules (Non-Negotiable)
- OSS-only: **MIT / Apache-2.0 / BSD-3-Clause** dependencies only.
- **Pin versions** (lock file committed). No `^` or `latest`.
- No CDN usage.
- Sandbox must be **library-first**, not app-first:
  - Build a library package (`/packages/spreadsheet-kit`)
  - Provide a demo app (`/apps/demo`) that consumes the library
- “Bug-free” strategy = deterministic architecture + full regression suite.

---

## 1) Create Sandbox Repo Layout (Monorepo)

slickgrid-spreadsheet-kit/
package.json (workspaces)
pnpm-lock.yaml (or package-lock)
packages/
spreadsheet-kit/
src/
index.ts
core/
GridFactory.ts
PluginFactory.ts
DataModel.ts
Events.ts
Types.ts
workbook/
Workbook.ts
SheetController.ts
TabsAdapter.ts
editing/
Editors.ts
Clipboard.ts
Selection.ts
formatting/
FormatSchema.ts
StyleStore.ts
StyleApplier.ts
merges/
MergeStore.ts
MergeRenderer.ts
MergeBehavior.ts
formulas/
FormulaBar.ts
FormulaEngine.ts
DependencyGraph.ts
RefParser.ts
RefShifter.ts
Builtins.ts
io/
ImportXLSX.ts
ExportXLSX.ts
ExportCSV.ts
persistence/
Snapshot.ts
Patch.ts
PatchApplier.ts
styles/
slickgrid-overrides.css
kit-theme.css
tests/
unit/
e2e/
package.json
tsconfig.json
vite.config.ts
apps/
demo/
index.html
src/main.ts
src/demo-data.ts
src/scenarios.ts
playwright.config.ts
package.json
vite.config.ts
docs/
integration.md
supported-scope.md


---

## 2) Pick One SlickGrid Base (Do Not Mix)

### Option A (recommended for ecosystem): Slickgrid-Universal (MIT)
- Repo: https://github.com/ghiscoding/slickgrid-universal
- Use its core grid + editors/filters/extensions where possible.

### Option B: 6pac SlickGrid (MIT)
- Repo: https://github.com/6pac/SlickGrid
- Use its bundled plugins and implement missing “worksheet” pieces yourself.

**Decision:** choose A or B and lock it. Do not use both.

---

## 3) Dependencies (OSS-Only)

### Core
- SlickGrid base chosen above
- TypeScript
- Vite

### Formula Functions (MIT)
- `formulajs` (Excel-like functions)
  - Repo: https://github.com/formulajs/formulajs

### Import/Export (Apache-2.0)
- `xlsx` (SheetJS CE)
  - License: https://docs.sheetjs.com/docs/miscellany/license/

### Testing
- `playwright` (e2e)
- `vitest` (unit)
- optional `@testing-library/dom` (DOM helpers)

### Optional (only if needed)
- `sortablejs` (MIT) for drag reorder in tabs or columns

---

## 4) Sandbox Delivery Targets (What “Done” Means)

### 4.1 Library API (must be stable)
Export from `packages/spreadsheet-kit/src/index.ts`:

- `createWorkbook(container, options) -> WorkbookHandle`
- `destroyWorkbook(handle)`
- `exportWorkbook(handle) -> WorkbookSnapshot`
- `importWorkbook(container, snapshot, options) -> WorkbookHandle`
- `exportXLSX(handle) -> Blob`
- `importXLSX(file) -> WorkbookSnapshot`
- `setTheme(handle, themeName)`
- Event hooks:
  - `onChange`
  - `onSelectionChange`
  - `onError`

### 4.2 Snapshot Format (integration-ready)
Single JSON structure (no DOM state):
{
version: 1,
workbook: { name, activeSheetId, settings },
sheets: [
{
id, name, order,
columns: [ {id, key, name, type, width, hidden, pinned, options, format, formula? } ],
rows: [ {id, order, cells: { [colKey]: { value, formula?, styleKey? } } } ],
gridState: { sort, filters, grouping, columnOrder, widths, pinned, rowHeights? },
merges: [ {x1,y1,x2,y2, master: {rowId, colKey} } ],
styles: { styleKey: { ...canonicalStyle } }
}
]
}
Rule: snapshot must restore workbook exactly.

---

## 5) Build Order (Junior-Dev Steps)

### Step 1 — Bootstrap Monorepo
- Initialize workspace (pnpm recommended)
- Add `packages/spreadsheet-kit` as buildable TS library
- Add `apps/demo` as Vite app consuming the library via workspace import
- Add lint + typecheck scripts:
  - `pnpm -r build`
  - `pnpm -r test`
  - `pnpm -r typecheck`

### Step 2 — Minimal Grid (Single Sheet)
Implement:
- `GridFactory` creates grid from:
  - columns[]
  - rows[]
- Confirm features:
  - edit cell
  - selection
  - column resize
  - basic copy/paste (even if naive)

**Demo app**
- show one grid with 20 rows x 10 cols
- add “dump snapshot” button and print JSON to console

### Step 3 — Plugin Baseline (Must-Have UX)
Enable and verify:
- Cell selection model
- Range selection + visual decorator
- Header menu (column settings stub)
- Context menu (cell actions stub)
- Clipboard manager (copy/paste blocks)

**Acceptance**
- Copy/paste rectangular selection works:
  - paste into empty region
  - paste over existing values
  - paste from Excel/Google Sheets (TSV)

### Step 4 — Workbook (Multi-Sheet Tabs)
Implement:
- `Workbook` manages list of `SheetController`
- `SheetController` owns:
  - grid instance
  - sheet state (columns/rows/merges/styles/formulas)
- Tabs UI is outside library core but shipped as default adapter in demo.
Rules:
- Only **one grid mounted** at a time.
- Switching tabs:
  - flush pending changes
  - destroy grid cleanly
  - mount target sheet grid

Acceptance:
- Create sheet, rename, delete, reorder
- Data remains per sheet after switches
- Snapshot contains all sheets

### Step 5 — Formatting System (Canonical + Deterministic)
Implement:
- `FormatSchema`: define allowed style fields only:
  - bold, italic, underline
  - textColor, bgColor
  - align, valign
  - numberFormat (int, 2dp, currency, percent)
  - fontSize (optional)
- `StyleStore`: store styles by `styleKey` and reference from cells
- `StyleApplier`: apply style to selection (range)
- Grid render:
  - apply via formatter producing safe styles (no HTML injection)

Acceptance:
- Apply bold to selection, persists after tab switch and snapshot import
- Apply background color, persists
- Number formatting works visually (display only)

### Step 6 — Merge / Unmerge (Spreadsheet-Like)
SlickGrid does not provide native merges universally; implement merges at kit-level:

Implement:
- `MergeStore`: list of merge ranges; each merge has a master cell
- `MergeRenderer`:
  - render only master cell content
  - render “merged” overlay spanning cells using absolute positioning layer
- `MergeBehavior`:
  - clicking inside merged area selects the merge
  - editing writes to master cell only
  - copy/paste into merged area rules:
    - if target intersects merge: reject with clear error OR auto-unmerge then paste (choose one; implement consistently)

Toolbar actions:
- Merge selection
- Unmerge selection

Acceptance:
- Merge 2x2 area; only master shows content
- Copy/paste respects merge rules
- Snapshot restores merges perfectly

### Step 7 — Formula Engine (Cells + Formula Bar + Toolbar)
Formulas are kit-owned; grid is only a renderer/editor.

#### 7.1 Data Rules
- Cell may have:
  - `value` (literal)
  - `formula` (string starting with `=`)
- Display:
  - show computed result
  - show formula in formula bar when selected

#### 7.2 Implement Formula Core
- `RefParser`: parse A1 style refs and ranges:
  - A1, $A$1, A$1, $A1
  - sheet refs: Sheet2!A1
  - ranges: A1:B10, Sheet2!A1:Sheet2!B10
- `DependencyGraph`:
  - directed edges from cell -> referenced cells
  - topo sort for recalculation
  - detect cycles => set error `#CYCLE!`
- `FormulaEngine`:
  - tokenize formula (ignore strings)
  - resolve refs to values (from workbook state)
  - map functions to `formulajs` builtins
  - return computed value or error tokens like `#DIV/0!`, `#NAME?`

#### 7.3 Formula Reference Shifting (Mandatory)
Implement `RefShifter`:
- When copying formulas into new location:
  - shift relative refs by delta row/col
  - preserve absolute refs ($)
- Apply on:
  - paste
  - fill-down/fill-right (if implemented)

#### 7.4 Formula Bar UI (Kit ships default)
- top bar input:
  - shows formula if exists, else literal
  - Enter commits to selected cell
  - Esc cancels
- toolbar quick functions:
  - SUM selection -> writes `=SUM(A1:A10)` into active cell
  - AVG selection -> `=AVERAGE(...)`

Acceptance:
- `=SUM(A1:A3)` computes correctly
- Copy/paste formula shifts refs correctly
- Cross-sheet ref works: `=Sheet2!A1`
- Cycle detection works

### Step 8 — Resizing (Columns/Rows/Cells)
Columns:
- persist widths in sheet `gridState.widths`
Rows:
- if SlickGrid supports row height plugin in your chosen base, persist it
- else implement row height as CSS class per row and store it in state
Cells:
- do not implement per-cell size in v1 (unstable); simulate via padding/font-size only

Acceptance:
- resize column; snapshot import restores widths

### Step 9 — Import/Export (XLSX/CSV)
#### 9.1 Import XLSX -> Snapshot
Using SheetJS:
- workbook -> sheets
- first row becomes headers (unless config says otherwise)
- infer column types:
  - number/date/bool/text
- capture merges if present
- capture formulas as formula strings (no Excel calc)
- after import: run FormulaEngine recalc

#### 9.2 Export Snapshot -> XLSX
- write values (computed) and optionally formula strings into XLSX
- write merges
- styles export scope:
  - basic font bold/italic, fill color, number format (optional; document what’s supported)

Acceptance:
- Import then export preserves:
  - values
  - merges
  - formulas (as strings)
  - sheet names

---

## 6) Demo App Scenarios (Manual + Automated)
`apps/demo/src/scenarios.ts` includes buttons:
- Create workbook with sample data
- Apply formatting to selection
- Merge selection / unmerge
- Insert formula examples
- Add sheets and cross-sheet formulas
- Import XLSX
- Export XLSX
- Dump snapshot
- Reload from snapshot

---

## 7) Testing Plan (Must Be Implemented)

### 7.1 Unit Tests (Vitest)
- RefParser: parse refs/ranges/sheet refs
- RefShifter: delta shifting with absolute refs
- DependencyGraph: topo + cycle
- FormulaEngine: SUM/IF/AVERAGE + errors

### 7.2 E2E Tests (Playwright)
Create tests that open demo app and execute:
1) edit cell, snapshot, reload snapshot => equal
2) resize column, snapshot, reload => widths equal
3) format range bold+bg, snapshot, reload => equal
4) merge range, snapshot, reload => equal
5) formula compute, snapshot, reload => computed equal
6) copy/paste formula => ref shift correct
7) multi-sheet + cross-sheet formula => correct
8) import XLSX then export => non-empty XLSX and values preserved

### 7.3 Golden Snapshots
- Store `golden/*.json`
- Tests export snapshot and diff to expected

---

## 8) Versioning + Stability Process
- Create `SUPPORTED_SCOPE.md` listing exactly:
  - supported formula functions (initial set)
  - supported styles
  - supported import/export behavior
  - merge rules
- Every dependency bump requires:
  - full unit + e2e suite green
  - golden snapshots unchanged (or intentionally updated with review)

---

## 9) Integration Readiness (Do Not Skip)
Write `docs/integration.md` defining:
- required CSS imports
- required container DOM contract
- how to call `createWorkbook()`
- how to persist snapshot externally
- event hooks contract (`onChange` returns patch + snapshot delta)
- no dependency on demo app routes or build system

Acceptance:
- The demo app must be able to delete itself and the kit still builds.
- The kit must be consumable as:
  - ES module import
  - bundled artifact (single JS + CSS) for later platform integration

---

## 10) Definition of Done (Sandbox)
- ✅ `packages/spreadsheet-kit` builds and exports stable API.
- ✅ Demo app exercises all features.
- ✅ Unit tests pass.
- ✅ Playwright suite passes.
- ✅ Snapshot import/export roundtrips all supported features.
- ✅ No Pro/non-OSS dependencies.
- ✅ Ready to drop into platform later without rewrite (library-first architecture).
