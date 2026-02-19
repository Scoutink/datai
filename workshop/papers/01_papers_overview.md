# Papers Overview

## What Papers is intended to do
Papers is a first-class authored-content module for creating and maintaining structured content (DOC/SHEET) directly in-app using Univer state snapshots (`contentJson`) instead of uploaded files.

## How Papers differs from All Documents
- **Papers**
  - Create/edit inside the app with Univer editor.
  - Persist state as JSON snapshot in DB (`papers.contentJson`).
  - Generate derived HTML/text/word-count for preview/indexing.
- **All Documents**
  - Upload binary files (`uploadFile`) and store file path/location.
  - Preview/download through file/token viewer endpoints.
  - Versioning tracks uploaded file revisions.

## What currently works (code evidence)
- List, create, edit, delete, detail, comments, versions, audit, permissions, share-link, and pdf export routes/components exist.
- Backend save/update creates versions and audit trail and syncs sheet relational tables from Univer JSON.
- Frontend details tabs load content/general/comment/version/audit/permission panels.

## What is currently broken / risky
- Papers “View” currently allows a switch into editable LIVE mode in preview tab, so “view” is not reliably read-only.
- `paper-preview.component.ts` has missing imports (compile-risk) while template depends on those symbols.
- Action parity with All Documents is partial; direct cloning introduces endpoint/entity mismatch (paper JSON entity vs file entity).
