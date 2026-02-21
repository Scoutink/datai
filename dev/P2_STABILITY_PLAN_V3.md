# P2: Stability Recovery Plan (Round 3.1)

Fix persistent initialization errors, Sheet mode dependencies, and implement a light-weight read-only view for ALL content types.

## User Review Required
> [!IMPORTANT]
> - **Light-weight View (Full):** For both Documents AND Sheets in Read-Only mode, we will now render plain HTML/Static content instead of the heavy UniverJS engine. 
>     - **Docs:** Direct HTML render from `contentHtmlSanitized`.
>     - **Sheets:** Static grid render (or static HTML if provided by backend).
> - **Sheet Dependencies:** Restoring Doc plugins for Sheet mode (EDIT mode only) to fix "Cannot find Hn" errors.

## Proposed Changes

### [UnifiedEditor Component]
- **Light-weight All-Type Viewer:**
    - If `readOnly === true`:
        - **DOC:** Render `initialData.body` (or `contentHtmlSanitized`) directly into the element.
        - **SHEET:** Render a static HTML table representation (if available) or a light-weight CSS-grid based reader.
    - Skip Univer initialization entirely for all read-only views.
- **Fixed SHEET Dependency (Edit Mode):**
    - Restore `UniverDocsPlugin` and `UniverDocsUIPlugin` when `mode === 'SHEET'` during editor initialization.
- **Robust Registration Order:**
    - Registration sequence: Network -> RenderEngine -> Logic Plugins -> Unit Creation -> UI Plugins.
- **Defensive Disposal:**
    - Add `isDestroyed` flag and `try/catch` on `dispose()`.

### [PaperDetail Component]
- Ensure both `initialData` (JSON) and `paperInfo.contentHtmlSanitized` (HTML) are passed correctly to the editor-bridge.

## Verification Plan

### Automated Tests
- N/A

### Manual Verification
1. **View Doc:** Open an existing Doc paper. Verify instant HTML load. No Univer toolbar.
2. **View Sheet:** Open an existing Sheet paper. Verify static table layout. No Univer toolbar.
3. **Edit Doc:** Click 'Edit'. Verify Univer editor loads correctly.
4. **Edit Sheet:** Click 'Edit'. Verify Univer Sheet loads with grid and **no "Cannot find Hn" error**.
5. **Nav Stress Test:** Rapidly switch between view and edit modes. Verify no `EmptyError` or `dispose` crashes.
