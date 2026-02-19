# Document List Action Menu Mapping

Primary menu source: `document-library-list.component.html` + `.ts`.

| UI Item | Angular handler/component | Backend endpoint/controller | Permission gate |
|---|---|---|---|
| Edit | `editDocument()` → `DocumentEditComponent` | `PUT /api/document/{id}` (`DocumentController@update`) | `ASSIGNED_DOCUMENTS_EDIT_DOCUMENT` |
| Share | `manageDocumentPermission()` → `DocumentPermissionListComponent` | `GET/POST /api/documentPermission/*` (`DocumentPermissionController`) | `ASSIGNED_DOCUMENTS_SHARE_DOCUMENT` |
| Get shareable link | `onCreateShareableLink()` + `SharableLinkComponent`; service `getDocumentShareableLink` | `GET/POST/DELETE /api/document-sharable-link/*` (`DocumentSharebaleLinkController`) | `ASSIGNED_DOCUMENTS_MANAGE_SHARABLE_LINK` |
| Document signature | `signDocument()` → `DocumentSignatureComponent` | `POST /api/document-signature` (`DocumentSignatureController@signDocument`) | `ASSIGN_ADD_SIGNATURE` |
| AI powered summary | `generateSummary()` → `AiDocumentSummaryComponent` | `POST /api/ai/summaries` (`AISummaryController@summarize`) | `ASSIGNED_DOC_GENERATE_SUMMARY` |
| Start workflow | `manageWorkflowInstance()` → `DocumentWorkflowDialogComponent` | `POST /api/documentWorkflow` (`DocumentWorkflowController@saveDocumentWorkFlow`) | `ASSIGNED_DOCUMENTS_START_WORKFLOW` |
| Add watermark | `watermarkDocument()` → `DocumentWatermarkComponent` | `POST /api/document-watermark` (`DocumentWatermarkController@watermarkDocument`) | `ALL_DOC_WATERMARK` |
| Details | router link to `/document-details/:id` | `GET /api/document/{id}` (`DocumentController@edit`) and related detail APIs | `ASSIGNED_DOCUMENTS_VIEW_DETAIL` |
| Upload new version file | `uploadNewVersion()` → `DocumentUploadNewVersionComponent` | `POST /api/documentversion` (`DocumentVersionController@saveDocumentVersion`) | `ASSIGNED_DOCUMENTS_UPLOAD_NEW_VERSION` |
| Version history | `onVersionHistoryClick()` | `GET /api/documentversion/{id}` | `ASSIGNED_DOCUMENTS_VIEW_VERSION_HISTORY` |
| Comment | `addComment()` → `DocumentCommentComponent` | `/api/document-comment/*` (`DocumentCommentController`) | `ASSIGNED_DOCUMENTS_MANAGE_COMMENT` |
| Add reminder | `addReminder()` → `DocumentReminderComponent` | `/api/reminder/*` (`ReminderController`) | `ASSIGNED_DOCUMENTS_ADD_REMINDER` |
| Send email | `sendEmail()` → `SendEmailComponent` | `/api/email/*` (`EmailController`) | `ASSIGNED_DOCUMENTS_SEND_EMAIL` |
| Archive | `archiveDocument()` | `DELETE /api/document/{id}/archive` (`DocumentController@archiveDocument`) | `ASSIGNED_DOCUMENTS_ARCHIVE_DOCUMENT` |
| Delete | `deleteDocument()` | `DELETE /api/document/{id}` (`DocumentController@destroy`) | `ASSIGNED_DOCUMENTS_DELETE_DOCUMENT` |

## Other visible action surfaces on this page
- Reminder list launcher in top toolbar: `onReminderList()` → `ReminderListComponent`.
- Inline workflow name click: `viewVisualWorkflow()` → visual graph dialog (`GET /api/documentWorkflow/{id}/visualWorkflow`).
