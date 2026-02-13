# Forensic Analysis: "All Documents" Page & Menu Actions

This document provides a comprehensive breakdown of the "All Documents" listing page, mapping every filter, column, and context menu action to its corresponding logic.

## 1. Page Architecture (Frontend)

- **Component**: `DocumentListComponent`
- **Data Source**: `DocumentDataSource` (Connects via `DocumentService.getDocuments`)
- **Table Library**: Angular Material Table (`mat-table`)
- **Route**: `domain/documents`

### Filtration Logic
| Filter Type | UI Input | Search Parameter | BE Handling |
| :--- | :--- | :--- | :--- |
| **Search** | Text Input | `name` | `DocumentRepository@getDocuments` (LIKE name OR description) |
| **Meta Tags** | Text Input | `metaTags` | `DocumentRepository@getDocuments` (whereExists in metaDatas) |
| **Category** | Tree Select | `categoryId` | Hierarchical filter (Match category OR child category) |
| **Storage** | Select | `location` | Match `local` or `s3` |
| **Created Date** | Date Picker | `createDate` | UTC Date range comparison |
| **Client** | Select | `clientId` | Match `clientId` |
| **Status** | Select | `statusId` | Match `statusId` |

---

## 2. Action Menu Breakdown (15+ Actions)

The context menu (`mat-menu`) provides a wide range of actions based on user claims.

| Action Name | FE Claim (Permission) | FE Method | Primary BE Endpoint |
| :--- | :--- | :--- | :--- |
| **View** | (Public/Default) | `onDocumentView` | `DocumentController@readTextDocument` |
| **Edit** | `ALL_DOCUMENTS_EDIT_DOCUMENT` | `editDocument` | `DocumentController@updateDocument` |
| **Share** | `ALL_DOCUMENTS_SHARE_DOCUMENT` | `manageDocumentPermission` | `DocumentPermissionController@add...` |
| **Sharable Link** | `ALL_DOCUMENTS_MANAGE_SHARABLE_LINK`| `onCreateShareableLink` | `DocumentShareableLinkController@index` |
| **Sign Doc** | `ALL_DOC_ADD_SIGNATURE` | `signDocument` | `DocumentSignatureController@signDocument` |
| **AI Summary** | `ALL_DOC_GENERATE_SUMMARY` | `generateSummary` | `AISummaryController@summarize` |
| **Start Workflow** | `ALL_DOCUMENTS_START_WORKFLOW` | `manageWorkflowInstance` | `DocumentWorkflowController@save...`|
| **Details** | `ALL_DOCUMENTS_VIEW_DETAIL` | `[routerLink]` | `DocumentController@getDocumentbyId` |
| **Download** | `ALL_DOCUMENTS_DOWNLOAD_DOCUMENT` | `downloadDocument` | `DocumentController@downloadDocument` |
| **Add Watermark** | `ALL_DOC_WATERMARK` | `watermarkDocument` | `DocumentWatermarkController@watermark...`|
| **New Version** | `ALL_DOCUMENTS_UPLOAD_NEW_VERSION` | `uploadNewVersion` | `DocumentVersionController@save...` |
| **Version History**| `ALL_DOC_VIEW_VERSION_HISTORY` | `onVersionHistoryClick` | `DocumentVersionController@index` |
| **Comment** | `ALL_DOCUMENTS_MANAGE_COMMENT` | `addComment` | `DocumentCommentController@save...` |
| **Add Reminder** | `ALL_DOCUMENTS_ADD_REMINDER` | `addReminder` | `ReminderController@addReminder` |
| **Send Email** | `ALL_DOCUMENTS_SEND_EMAIL` | `sendEmail` | `EmailController@sendEmail` |
| **Add Indexing** | `DEEP_SEARCH_ADD_INDEXING` | `addIndexing` | `DocumentController@addDOocumentToIndex`|
| **Rem. Indexing** | `DEEP_SEARCH_REMOVE_INDEXING` | `removeIndexing` | `DocumentController@removeDocumentFrom...`|
| **Archive** | `ALL_DOC_ARCHIVE_DOCUMENT` | `archiveDocument` | `DocumentController@archiveDocument` |
| **Delete** | `ALL_DOC_DELETE_DOCUMENT` | `deleteDocument` | `DocumentController@deleteDocument` |

---

## 3. Side Effects & External Systems

### Audit Logging
Nearly every action calls `addDocumentTrail(id, operation)`.
- Backend Table: `documentAuditTrails`.
- Tracked Operations: `Created`, `Edit`, `Download`, `Archived`, `Deleted`, `Add_Permission`.

### Real-time Notifications
- Shared documents trigger notifications via `UserNotificationRepository`.
- Workflow status changes trigger updates in `documentWorkflow` table.

### File Previews
- Handled by `BasePreviewComponent`.
- Requires `location` (local/s3) and `id` to fetch temporary secure links or raw streams.

---

## 4. Permission Architecture
The page uses the `*hasClaim` directive for granular UI control.
- **Bulk Actions**: Only visible when documents are selected. Supports sharing multiple documents at once via `DocumentPermissionMultipleComponent`.
- **Search Restrictions**: Repository methods (`getDocuments`) enforce `categoryId` and `clientId` filters which are often influenced by the logged-in user's roles (though the "All Documents" page typically shows everything available to that specific claim/permission).
