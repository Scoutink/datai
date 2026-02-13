# Papers Module Master Plan

## 1) What Papers must be in DATAI
Papers is a **created-content module** (Editor.js canonical content) that must behave like Documents operationally:
- list contracts,
- RBAC and row ACL,
- versions,
- comments,
- audit trail,
- shareable links,
- reminders,
- deep search toggles,
- exports/downloads,
- archive/restore/delete lifecycle.

This is required by product context (compliance workspaces like NIS2 where policies, procedures, and evidence text must be authored and governed in-platform).

---

## 2) Canonical parity matrix (clone from All Documents)
For each item below, Papers must implement **both backend and frontend parity**.

1. **All Papers page** (global list)
- claim-gated page access
- server pagination + headers `totalCount`, `pageSize`, `skip`
- sorting/filtering/search
- row actions menu

2. **Assigned Papers page**
- row ACL via `paperUserPermissions` + `paperRolePermissions`
- date-window checks (start/end validity)
- allow-download flags

3. **Details + action dialogs**
- permissions dialog
- version history and restore
- comments
- audit trail dialog
- shareable link management
- reminder management
- deep-search add/remove
- export/download and optional send email

4. **Lifecycle controls**
- create, edit, archive, restore, hard delete policy
- bulk share where relevant

5. **Cross-cutting quality**
- RBAC claims on routes + `*hasClaim` + route guards
- audit writes for critical operations
- validation and error consistency

---

## 3) Papers-specific architecture

## 3.1 Canonical data model
Store:
- `contentJson` (Editor.js JSON) as source of truth.
- `contentHtmlSanitized` generated server-side.
- `contentText` generated for search/index.
- metadata (wordCount, readingTime, status, category/client, creator/updater, retention fields).

Never trust frontend HTML; sanitize on backend before persistence.

## 3.2 Editor.js tool baseline (minimum production set)
- Paragraph, Header, List, Checklist, Table, Quote, Delimiter, Code, Warning, Embed, Link, Image.
- Inline tools: marker/highlight, inline code, underline (or maintained alternative).
- UX: undo + drag/drop.

## 3.3 Recommended improvements beyond current brainstorming docs
1. **Autosave draft mode** (configurable interval + dirty flag).
2. **Recovery flow** for corrupted block JSON:
   - fallback render + validation error section with block index.
3. **Paste sanitization strategy** for rich-text from Word/web pages.
4. **Template insertion** (policy templates) for reuse across workspaces.
5. **Section anchors + generated TOC** for long governance documents.
6. **Readability metadata** (word count, estimated reading time) visible in details.
7. **Strict attachment ownership** for images embedded in editor (paper-scoped storage paths).
8. **Deterministic export rendering** (same output on repeat exports when content unchanged).

---

## 4) Critical gaps identified in current papers brainstorming docs
1. Missing explicit row ACL query contract parity to Documents count/list logic.
2. Missing exact claim inventory and claim wiring path (pages/actions/roleClaims/userClaims).
3. Missing explicit rollback strategy for DB changes.
4. Missing failure-mode matrix (expired links, invalid password, missing block renderer, orphaned assets).
5. Missing production smoke tests for role permutations and token refresh behavior.

This pack closes those gaps via dedicated DB/RBAC, wiring, and QA runbook docs.

---

## 5) Mandatory claims set (proposed)
Use Documents naming style to keep platform consistency.

### All papers
- `ALL_PAPERS_VIEW_PAPERS`
- `ALL_PAPERS_CREATE_PAPER`
- `ALL_PAPERS_EDIT_PAPER`
- `ALL_PAPERS_DELETE_PAPER`
- `ALL_PAPERS_ARCHIVE_PAPER`
- `ALL_PAPERS_VIEW_DETAIL`
- `ALL_PAPERS_DOWNLOAD_PAPER`
- `ALL_PAPERS_MANAGE_COMMENT`
- `ALL_PAPERS_SHARE_PAPER`
- `ALL_PAPERS_MANAGE_SHARABLE_LINK`
- `ALL_PAPERS_UPLOAD_NEW_VERSION` (semantic for new snapshot)
- `ALL_PAPERS_VIEW_VERSION_HISTORY`
- `ALL_PAPERS_RESTORE_VERSION`
- `ALL_PAPERS_ADD_REMINDER`
- `ALL_PAPERS_SEND_EMAIL`
- `ALL_PAPERS_DEEP_SEARCH`

### Assigned papers
- `ASSIGNED_PAPERS_VIEW_PAPERS`
- `ASSIGNED_PAPERS_CREATE_PAPER`
- `ASSIGNED_PAPERS_EDIT_PAPER`
- `ASSIGNED_PAPERS_DELETE_PAPER`
- `ASSIGNED_PAPERS_ARCHIVE_PAPER`
- `ASSIGNED_PAPERS_VIEW_DETAIL`
- `ASSIGNED_PAPERS_DOWNLOAD_PAPER`
- `ASSIGNED_PAPERS_MANAGE_COMMENT`
- `ASSIGNED_PAPERS_SHARE_PAPER`
- `ASSIGNED_PAPERS_MANAGE_SHARABLE_LINK`
- `ASSIGNED_PAPERS_UPLOAD_NEW_VERSION`
- `ASSIGNED_PAPERS_VIEW_VERSION_HISTORY`
- `ASSIGNED_PAPERS_RESTORE_VERSION`
- `ASSIGNED_PAPERS_ADD_REMINDER`
- `ASSIGNED_PAPERS_SEND_EMAIL`
- `ASSIGNED_PAPERS_DEEP_SEARCH`

---

## 6) Definition of Done for Papers
- Feature parity checks pass for all menu actions from Documents baseline.
- Security checks pass (RBAC + ACL + share-link safety + sanitization).
- List/count pagination parity proven.
- Export and share link flows validated for both all/assigned contexts.
- Build/deploy/runbook steps reproduced by non-expert operator.
