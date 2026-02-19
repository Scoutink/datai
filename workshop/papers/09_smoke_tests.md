# Papers Smoke Tests

## Creation and persistence
1. Create new paper as DOC.
2. Enter content, save, reload list, reopen: content persists.
3. Create new paper as SHEET.
4. Edit cells, save, reload/reopen: sheet state persists.

## Action menu behavior
5. Open action menu and validate each available item routes correctly:
   - View, Edit, Delete, Permissions, Version History, Comment, Audit Trail, Shareable Link.
6. Confirm unsupported document-only items are not shown in Papers menu.

## Share/permissions (if enabled by claims)
7. Create/update share link and verify retrieval dialog.
8. Add/remove user and role permissions and verify visibility access behavior.

## View-only correctness (critical)
9. Click View from papers list.
10. Verify content opens in read-only mode only (no edit/live toggle).
11. Attempt edits in content area; changes cannot be persisted from view page.
12. Confirm no save/update API calls (`POST/PUT /api/papers*`) are triggered while viewing.
13. Use Edit button to transition intentionally to manage page and save there.
