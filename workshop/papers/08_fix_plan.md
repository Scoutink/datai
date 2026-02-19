# Papers Fix Plan (small safe increments)

## Step 1 — Stabilize view-only path in detail preview
- Change papers list view action to set explicit `mode=view` query flag.
- In detail/preview components, enforce read-only rendering only for view mode.
- Remove/disable LIVE toggle in view context.
- **Rollback:** revert touched frontend papers components only.

## Step 2 — Compile safety hardening in preview component
- Add missing imports and strict typing where needed.
- Ensure no dead references remain.
- **Rollback:** revert preview component file.

## Step 3 — Add capability-based menu adapter notes (no broad refactor yet)
- Keep current Papers menu but document capability gates per action.
- Hide/avoid unsupported cloned document actions.
- **Rollback:** revert any UI-only visibility change.

## Step 4 — Optional adapter refactor (future small PRs)
- Introduce shared action IDs + entity adapters:
  - `FileDocumentEntityAdapter`
  - `PaperUniverEntityAdapter`
- Per action capability checks determine visibility/handler mapping.
- **Rollback:** feature-flag adapter usage and fallback to current local menu.

## Risk notes
- Scope-limited to Papers frontend components in step 1/2.
- No backend/database changes required for view-only fix.
- No expected side effects outside `/papers` routes.
