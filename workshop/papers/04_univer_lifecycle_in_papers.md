# Univer Lifecycle in Papers

## Lifecycle path
1. **Open**
   - List “View” routes to `/papers/:id`.
   - Resolver fetches paper record; detail component parses `contentJson` into `editorData`.
2. **Instantiate Univer**
   - `PaperPreviewComponent` renders `PaperEditorComponent`.
   - `PaperEditorComponent` hosts `app-unified-editor`.
   - `UnifiedEditorComponent` initializes Univer plugins and creates a DOC/SHEET unit with `initialData`.
3. **Load state**
   - Snapshot passed via `[initialData]` into unified editor.
   - Mode selects unit type: `UNIVER_DOC` or `UNIVER_SHEET`.
4. **Edit**
   - Manage screen (`paper-manage`) opens same editor in editable mode.
   - `savePaper()` calls `editor.save()` → `UnifiedEditorComponent.getData()` snapshot.
5. **Persist**
   - Frontend posts `{..., contentJson: JSON.stringify(snapshot)}`.
   - Backend converts/sanitizes/derives text metrics then saves via repository.
   - Update path writes version record and syncs sheet relational tables.
6. **Reopen**
   - Resolver returns persisted content; parsed JSON feeds editor again.

## DOC vs SHEET differences
- DOC uses `UniverInstanceType.UNIVER_DOC` and doc body snapshot structure.
- SHEET uses `UniverInstanceType.UNIVER_SHEET` with sheets/cellData structure and extra relational sync to `sheet*` tables.

## Failure points identified
- “View” mode is not strict: preview has PREVIEW/LIVE toggle and LIVE mounts editable editor (`readOnly=false`).
- Missing imports in `paper-preview.component.ts` create compile/runtime instability.
- Cloned actions that assume file entities (download token/file upload) do not map to paper JSON workflows.
