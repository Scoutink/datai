# Workspaces Implementation Plan (SSOT-aligned)

> Filename intentionally follows requested spelling: `workkspaces_implimentation_plan.md`.

## 0) Objective
Deliver a production-safe, complete Workspaces module matching the Workspace SSOT with:
- Node-based workspace roots (`workspace_root`) and tree nodes.
- Top navigator panel UX and same-page content rendering.
- Strict structural vs content-delete semantics.
- Real-time tree consistency for add/delete/move/reorder.
- No regressions in existing Documents/Papers behavior.

## 1) Rollout Strategy (Safety First)
1. **Phase A (Backend foundation only, no sidebar/menu changes)**
   - DB schema + APIs + integrity guards + tests.
   - Feature-gated API enablement.
   - Validate in Ubuntu/Plesk without Angular rebuild.
2. **Phase B (Frontend Workspaces page, hidden entry)**
   - Route reachable directly (e.g., `/workspaces`) but no sidebar menu item yet.
   - UI behavior + tree interactions + DnD + non-drag move.
3. **Phase C (Actions Menu wrappers + advanced behavior)**
   - Inheritance actions and deletion cascade across all workspaces.
4. **Phase D (Enable navigation + release hardening)**
   - Add sidebar entry after QA pass.

## 2) Data Model & DB Tasks
- Create tables:
  - `workspaceNodes`
  - `workspaceNodeFavorites`
  - `workspaceNodeRecents`
- Enforce:
  - `workspace_root` has `parentId = null`, `workspaceRootId = id`.
  - All descendants share the same `workspaceRootId`.
- Indexes:
  - tree traversal (`workspaceRootId`, `parentId`, `sortIndex`)
  - content lookup (`contentKind`, `contentRef`)
- SQL patch must be phpMyAdmin-safe:
  - explicit `ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci`
  - include re-run instructions and ordered drops.

## 3) Backend API Tasks
- Endpoints:
  - list/create roots
  - fetch full tree
  - add/rename/move/reorder/delete structural
  - favorites/recents
  - content reference cascade removal helper
- Integrity guards:
  - no cycles on move
  - no cross-workspace parent assignment
  - prevent structural delete of root via node delete endpoint
  - validate destination node types
- RBAC:
  - claim-gate read vs mutate actions.

## 4) Frontend Tasks (deferred menu integration)
- Build Workspaces module page with:
  - Workspace Bar (dropdown/search/toggle)
  - Top Navigator panel (collapse/expand)
  - Content area below
- Tree interactions:
  - keyboard-accessible tree semantics
  - optimistic add/delete/move/reorder with rollback on failure
  - non-drag move selection mode
- Menus:
  - Structure Menu (structure-only)
  - Actions Menu wrapper (reuse existing docs action menu without modifying shared source)

## 5) QA Matrix (must pass)
- Create workspace root appears immediately.
- Add folder/document link/paper link appears instantly.
- Delete structural removes subtree instantly.
- DnD move/reorder persists and survives reload.
- Non-drag move works.
- Content delete cascade removes links in all workspaces.
- Search expands path/selects node.
- Panel collapse expands content width.

## 6) Release Checklist
- Backend tests green.
- No 500 on `/` and `/login`.
- Feature flag defaults safe.
- SQL patch validated in phpMyAdmin test DB.
- Staging sign-off before sidebar menu enable.

## 7) Current execution status
- [x] Plan authored and saved.
- [x] Phase A backend foundation implementation in progress in this branch.
- [ ] Phase B frontend implementation (without sidebar item).
- [ ] Phase C inheritance/deletion wrappers.
- [ ] Phase D sidebar activation.
