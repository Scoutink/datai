# Forensic Analysis: "Document Details" Page & Tabs

This document provides a comprehensive breakdown of the "Document Details" view, mapping each tab and its associated data flow to the backend.

## 1. Component Architecture

- **Root Component**: `DocumentDetailsComponent`
- **Route**: `domain/document-details/:id`
- **Tabs Engine**: Angular Material Tabs (`mat-tab-group`)
- **Lazy Loading**: Tabs are initialized once visited via a `loadedTabs` boolean array.

---

## 2. Tab-by-Tab Breakdown

### Tab 1: General (Info)
- **FE Method**: `getDocumentMetaData()` and `refreshDocumentData()`
- **Key Fields**:
  - **Meta Tags**: Fetched via `documentService.getdocumentMetadataById(id)`.
  - **Retention**: Calculated using `retentionPeriod` and `retentionAction` enum.
  - **Audit Info**: Shows `updatedByName` and `modifiedDate`.
- **BE Counterpart**: `DocumentController@getDocumentbyId` and `DocumentController@getDocumentMetatags`.

### Tab 2: Permission (Security)
- **Child Component**: `app-document-permissions`
- **Purpose**: Displays and manages which roles/users can view or download the document.
- **BE Counterpart**: `DocumentPermissionController@getDocumentPermissions`.
- **Tables**: `documentRolePermissions`, `documentUserPermissions`.

### Tab 3: Version History
- **Child Component**: `app-document-versions`
- **Purpose**: Lists past versions of the document, allowing downloads and restores.
- **BE Counterpart**: `DocumentVersionController@index`.
- **Table**: `documentVersions`.

### Tab 4: Comment
- **Child Component**: `app-document-comments`
- **Purpose**: Threaded discussions related to the document.
- **BE Counterpart**: `DocumentCommentController@index`.
- **Table**: `documentComments`.

### Tab 5: Document Audit Trail
- **Child Component**: `app-document-audit-trails`
- **Purpose**: Chronological history of all operations (Create, Edit, Share, Download).
- **BE Counterpart**: `DocumentAuditTrailController@getDocumentAuditTrails`.
- **Table**: `documentAuditTrails`.

### Tab 6: Reminders
- **Child Component**: `app-document-reminders`
- **Purpose**: Managing alerts and notifications tied to the document (e.g., expiry alerts).
- **BE Counterpart**: `ReminderController@getReminders`.
- **Table**: `reminders`.

### Tab 7: Workflow Logs
- **Child Component**: `app-document-workflow-logs`
- **Purpose**: History of transitions and approvals if the document is part of a workflow.
- **BE Counterpart**: `WorkflowLogController@getWorkflowLogs`.
- **Table**: `documentWorkflowLogs`.

---

## 3. Data Persistence Context
- **Resolver**: The document data is typically pre-fetched using a route resolver (`document` data in `ActivatedRoute`).
- **Refreshing**: The `refreshDocumentData()` method in the root component allows for re-syncing the state after an edit action without a full page reload.

## 4. Permission Architecture
- **Edit Button**: Controlled by `*hasClaim="['ALL_DOCUMENTS_EDIT_DOCUMENT', 'ASSIGNED_DOCUMENTS_EDIT_DOCUMENT']"`.
- **Visibility**: Access to the detail page itself is gated by `hasToken:ALL_DOCUMENTS_VIEW_DETAIL` or `ASSIGNED_DOCUMENTS_VIEW_DETAIL`.
