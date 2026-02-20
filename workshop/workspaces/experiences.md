# Workspaces Sandbox – Lessons Learned (Living Notes)

## Context
This file captures practical lessons from implementing the backend-first Workspaces + no-build sandbox (`/workspace-sandbox`) so future iterations can move faster and avoid regressions.

## 1) DB and schema lessons
- Keep workspace tables charset/collation explicitly aligned to platform defaults (`utf8mb4_unicode_ci`) or MySQL foreign keys can fail with errno 150.
- For phpMyAdmin patches, include deterministic drop order for FK-dependent tables before recreating.
- Workspace tree integrity needs guardrails at API level:
  - forbid moving/deleting root in structural endpoints,
  - prevent cycle moves,
  - prevent cross-root moves,
  - reindex siblings after move/delete.

## 2) Platform parity lessons (documents)
- Microsoft Office embed (`view.officeapps.live.com`) works best for Office formats (docx/xlsx/pptx), **not** as a reliable path for PDFs in our authenticated/private environment.
- PDF behavior in main platform is different from Office docs:
  - Angular path uses dedicated PDF flow (`app-pdf-viewer`) that downloads bytes then renders with a PDF viewer component.
- In no-build sandbox, closest practical parity is:
  - Office docs → Office embed URL based on `/api/document/{id}/officeviewer?token=...`
  - PDFs → same-origin inline stream endpoint (`/workspace-sandbox/content/node/{id}/document-inline`) rendered via `<object>/<iframe>`.
- Token generation should reuse the existing repository flow (`DocumentTokenRepositoryInterface`) instead of inventing token logic.

## 3) Why PDFs failed previously
- Office online returned “File not found” even when diagnostics showed the source endpoint was reachable and `content-type: application/pdf`.
- Root issue: Office embed is not the right primary renderer for private PDFs here.
- Also, `/api/document/{id}/download/0` returns attachment semantics, which is not ideal for in-page PDF rendering.

## 4) Sandbox architecture lessons
- Keep all experimental UX in isolated codepaths:
  - `WorkspaceSandboxController`
  - `workspace-sandbox.blade.php`
  - `/workspace-sandbox*` web routes
- Avoid touching Angular/main menu during backend validation stage.
- Keep a lightweight diagnostics endpoint so issues can be split into:
  - token/auth issue,
  - storage/path issue,
  - external embed reachability issue.

## 5) UX lessons from testing
- Dev information (selected node + operation log) should be hidden by default; expose through a developer modal.
- Collapsible tree between workspace header and content pane improves reading focus.
- Node-action modal pattern is easier for iterative operations than many inline controls.

## 6) Security/permission lessons
- Sandbox currently queries `documents` directly for linking convenience; this may exceed strict end-user permission boundaries.
- Before production merge, replace permissive listing/lookup with permission-aware repository/service paths used by main document modules.

## 7) Integration strategy lessons
- Build confidence in layers:
  1) DB structure + safe CRUD tree operations,
  2) content linking and retrieval,
  3) viewer parity (office/pdf/paper),
  4) permission hardening,
  5) frontend integration.
- Maintain sandbox until all behaviors are stable, then migrate logic into main modules in small slices.

## 8) Current reliable viewer decision matrix
- Office documents (`doc/docx/xls/xlsx/ppt/pptx`): office embed first.
- PDFs: inline same-origin stream first (object/iframe), with download/direct links as fallback.
- Papers: app view URL embed (`/papers/{id}?tab=content&mode=view`) plus HTML/text fallback.

## 9) Regression checklist before each release
- Can create root/folder/document_link/paper_link.
- Can rename/move/delete with constraints enforced.
- Can open Office doc node in content pane.
- Can open PDF node in content pane (not only download).
- Can open paper node in content pane.
- Diagnostics endpoint returns meaningful status/content-type for document links.

## 10) Pending hardening backlog
- Add permission-aware document/paper lookup for sandbox endpoints.
- Add automated feature tests for workspace move/delete constraints.
- Add response payload contract tests for content endpoints.
- Normalize naming (`workkspaces_implimentation_plan.md` typo) when safe.

## 11) Deep-dive findings: how the Paper "Edit" flow really works

### 11.1 Route and UI flow
- In Paper Details (`/papers/:id`), the **Edit** button calls `editPaper()` and navigates to `/papers/manage/:id`.
- `/papers/manage/:id` loads `PaperManageComponent` (same component used for create and edit modes).

### 11.2 Data hydration path
- `PaperManageComponent` calls `PaperService.getPaper(id)` (`GET /api/papers/{id}`).
- API returns the paper row including `contentType` (`DOC`/`SHEET`) and `contentJson`.
- Component parses `contentJson` into `editorData` and passes it to `<app-paper-editor [data] ... [mode]>`.

### 11.3 Univer construction sequence (critical)
Inside `UnifiedEditorComponent`:
1. Create `Univer` core instance.
2. Register core plugins (network/render/drawing/formula).
3. Register mode logic plugins:
   - Docs plugin always,
   - Sheets plugins when mode is `SHEET`.
4. Create unit with `initialData` (the parsed `contentJson`) so real snapshot is mounted.
5. Register UI plugins last (toolbar/header/footer on edit pages).

This is why edit mode shows proper document formatting and multi-tab sheet structures.

### 11.4 Why sandbox paper view currently looks wrong
- Sandbox currently uses `appEmbedUrl = /papers/{id}?tab=content&mode=view` in an iframe.
- That route renders the **entire Paper Details page shell** (sidebar/header/tabs/actions), not a clean Univer surface.
- Therefore sandbox viewer gets clutter and nested platform chrome.

### 11.5 Permission implications
- Edit button visibility is claim-gated in UI.
- Update API is claim-gated.
- Read API (`GET /papers/{id}`) is auth-protected and used for hydration; sandbox should reuse this path (or equivalent server-side checked path) rather than raw table reads for production parity.

## 12) Flawless implementation plan: Workspace paper content view parity (safe, isolated)

### Phase A — Non-invasive architecture setup (no behavior breakage)
1. **Keep existing paper iframe path as fallback only** (feature flag style in sandbox code path).
2. Add new sandbox endpoint for paper payload:
   - `GET /workspace-sandbox/content/paper/{paperId}/snapshot`
   - Return only fields needed by viewer: `id`, `name`, `contentType`, `contentJson`, optional `contentHtmlSanitized` fallback.
3. Ensure endpoint performs permission-aware access checks equivalent to current paper read path.
4. Do not touch main Angular module routing/components in this phase.

### Phase B — Clean sandbox viewer shell (no platform iframe)
5. In sandbox page, replace paper iframe strategy with an isolated mount container:
   - `<div id="paperUniverMount"></div>`
   - dedicated loading/error states.
6. Remove platform page embedding for papers from default rendering path.
7. Keep existing "open full paper view" link only in collapsed details panel for debugging.

### Phase C — Univer runtime integration (sandbox-only)
8. Reuse the same Univer initialization sequence discovered in deep-dive:
   - same plugin registration order,
   - unit type chosen from `contentType`,
   - unit initialized from `contentJson` snapshot.
9. Start with **edit-equivalent successful rendering first** (goal: exact fidelity for DOC/SHEET structure and formatting).
10. After rendering parity is proven, add a strict read-only guard layer:
   - disable mutation commands,
   - block keyboard edit shortcuts,
   - block paste/cut,
   - preserve navigation and copy.

### Phase D — Toolbar cleanup + view-only mode (second step after parity)
11. Introduce `paperViewMode` in sandbox renderer:
   - `fidelity` mode (debug parity, near-edit chrome),
   - `viewer` mode (clean toolbar/minimal chrome).
12. Hide non-essential Univer UI elements in viewer mode only:
   - save/format/edit actions,
   - maintain sheet tabs/scroll/zoom/navigation.
13. Ensure view-only mode cannot persist changes even if a plugin leaks an edit action.

### Phase E — Robust fallbacks
14. If `contentJson` is null/invalid:
   - DOC fallback → `contentHtmlSanitized` render block,
   - SHEET fallback → structured static grid fallback.
15. Add explicit error taxonomy in UI:
   - `permission_denied`, `missing_snapshot`, `invalid_snapshot`, `univer_init_failure`.

### Phase F — Regression safety net (must pass before merge)
16. Test matrix:
   - DOC with rich formatting (bold/color/headers/lists),
   - SHEET with multiple tabs, formulas, wide columns,
   - very large paper payload,
   - user with view-only claims,
   - user lacking paper access.
17. Verify no regressions in existing sandbox viewers:
   - Office docs unchanged,
   - PDF focus unchanged.
18. Verify no main platform behavior change:
   - `/papers/:id` and `/papers/manage/:id` untouched.

### Phase G — Rollout strategy
19. Deploy with runtime toggle (`paperRenderer=v2`) default ON in sandbox only.
20. Keep old iframe renderer callable by query param for emergency rollback.
21. Document outcomes and edge cases back into this file before any production integration.

### Definition of done (strict)
- Paper nodes in workspace sandbox open in a **clean, full-area Univer-based viewer** (not full platform iframe).
- DOC and SHEET render with high fidelity matching edit-mode content structure.
- Viewer is read-only and toolbar-clean in final mode.
- No regressions to PDF/Office viewers and no changes to main platform UX/routes.
