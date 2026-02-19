# Action Menu Parity Matrix (All Documents vs Papers)

| All Documents item | Exists in Papers | Compatible with Papers | Why / notes | Papers FE mapping | Papers BE mapping | Permission check |
|---|---|---|---|---|---|---|
| View | Yes | Yes (with fix) | Must be strict read-only Univer mode, no editable fallback. | `paper-list.component.ts:viewPaper` -> detail/preview | `GET /api/papers/{id}` | route `ALL_PAPERS_VIEW_PAPERS` + AuthGuard claim |
| Edit | Yes | Yes | Routes to manage editor with save/update. | `editPaper` -> `/papers/manage/:id` | `PUT /api/papers/{id}` | `ALL_PAPERS_EDIT_PAPER` / `MY_PAPERS_EDIT_PAPER` |
| Delete | Yes | Yes | Soft-archive paper path. | `deletePaper` | `DELETE /api/papers/{id}` | `ALL_PAPERS_DELETE_PAPER` / `MY_PAPERS_DELETE_PAPER` |
| Share permissions | Yes (`Permissions` tab/action) | Yes | Paper permission tables differ from document permission tables. | `onPermission` | `/api/papers/{id}/permissions` + add/delete routes | `PAPER_PERMISSION_VIEW` / `PAPER_PERMISSION_MANAGE` |
| Get shareable link | Yes (`Shareable Link`) | Yes | Separate paper share-link model/repo. | `onShareLink` | `/api/papers/{id}/share-link` + save/delete | `PAPER_SHARE_MANAGE` |
| Version history | Yes | Yes | Uses `paperVersions` not `documentVersions`. | `onVersionHistory` | `/api/papers/{id}/versions`, restore | `PAPER_HISTORY_VIEW` / `PAPER_HISTORY_RESTORE` |
| Comment | Yes | Yes | Uses paper comments endpoints/model. | `onComment` | `/api/papers/{id}/comments` etc | currently broad paper view claims |
| Audit trail | Yes | Yes | Separate audit table. | `onAuditTrail` | `/api/papers/{id}/audit` | `PAPER_AUDIT_VIEW` |
| Send email | No | Partial/incompatible today | Document email flow expects file/document payload semantics; no paper-specific send endpoint in menu layer. | none | none paper-specific | n/a |
| Add reminder | No | Partial/incompatible today | Reminder model currently document-centric (`documentId`); no paperId reminder path in papers UI/backend routes. | none | none paper-specific | n/a |
| Upload new version file | No | No | Paper versions are snapshot-based, not file-upload based. | n/a | n/a | n/a |
| Download file token/viewer | No (except PDF export) | Partial | Papers can export/download PDF but not document-token file viewer flow. | `PaperPreviewComponent.download` | `GET /api/papers/{id}/view-as-pdf` | paper view claim path |
| Start workflow | No | No (current) | Document workflow tables/flows tied to documents; no paper workflow mapping present. | n/a | n/a | n/a |
| Signature | No | No (current) | Signature endpoints are document entity based. | n/a | n/a | n/a |
| Watermark | No | No (current) | Current watermark service targets uploaded document/PDF flow. | n/a | n/a | n/a |
| Deep search indexing actions | No | Partial | Papers indexing exists (`PaperIndexer`) but no menu action parity exposed. | n/a | repository/service only | n/a |

## Papers-only or Papers-specific actions that should remain distinct
- PDF export/download from authored content (`view-as-pdf`).
- Univer mode-specific capabilities (future): duplicate paper, explicit view-only toggle indicator, sheet-structure operations.

## Items currently wrong/missing
- View mode can enter LIVE editable state (must be view-only).
- Reminder/send-email parity intentionally absent; cannot be blindly cloned from Documents without paper-specific backend contracts.
