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
