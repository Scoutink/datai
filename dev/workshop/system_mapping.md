# Document Hyperlink System Mapping

This document maps the implementation of document name hyperlinking and the subsequent "Document Details" view within the FlowsPro platform.

## 1. Hyperlink Generation ("All Documents" View)

The hyperlink on document names in the "All Documents" and "Assigned Documents" lists is the primary entry point for document management.

- **Component**: `DocumentListComponent`
- **Location**: Within the Angular Material Table (`mat-table`) row template.
- **Logic**: 
  ```html
  <!-- Reconstructed logic based on forensics -->
  <a [routerLink]="['/document-details', document.id]" class="document-name-link">
    {{ document.name }}
  </a>
  ```
- **Navigation**: Uses Angular's `[routerLink]` to navigate to the detailed view.
- **Permission Guard**: The visibility of detailed actions and the link itself is often gated by the `ALL_DOCUMENTS_VIEW_DETAIL` claim.

## 2. Document Details View (The Destination)

The destination page is a centralized hub for document lifecycle, security, and auditing.

- **Component**: `DocumentDetailsComponent`
- **Route**: `domain/document-details/:id`
- **Architecture**: A container component using `mat-tab-group` for lazy-loaded tabs.

### Tab Architecture & Backend Connectivity

| Tab | Purpose | Backend Controller/Table | Reusability |
| :--- | :--- | :--- | :--- |
| **General** | Metadata & Audit info | `DocumentController@getDocumentbyId` | High (Standardized) |
| **Permission**| Sharing & ACL | `DocumentPermissionController` | High (Modular) |
| **Versions** | History & Restore | `DocumentVersionController` | Shared across modules |
| **Comment** | Threaded discussion | `DocumentCommentController` | Generic Component |
| **Audit** | Forensic logging | `DocumentAuditTrailController` | Mandatory for Compliance |
| **Reminders** | Expiry & Workflows | `ReminderController` | Cross-cutting Service |
| **Workflow** | Approval history | `WorkflowLogController` | Optional/Contextual |

## 3. Code Reusability & Editability

### Reusability
- **Component Level**: The `DocumentDetailsComponent` is highly reusable and is utilized for both the "All Documents" (Admin/Global) and "Assigned Documents" (User/Restricted) views.
- **Logic Level**: Uses a shared `DocumentService` for all API interactions, ensuring consistent data handling and error reporting.

### Editability
- **Fields**: Basic metadata (name, description, category, client) is editable via the "General" tab.
- **Gating**: Edits are strictly gated by `ALL_DOCUMENTS_EDIT_DOCUMENT` or `ASSIGNED_DOCUMENTS_EDIT_DOCUMENT` claims.
- **Method**: Typically opens an edit dialog (`DocumentEditComponent`) or toggels inline edit states, followed by a call to `refreshDocumentData()` to re-sync the UI.

## 4. Backend Synchronization (Golden Path)

- **Primary Endpoint**: `GET /api/document/{id}`
- **Repository**: `PaperRepository` (Note: Stack traces indicate the "Papers" and "Documents" modules share the `PaperRepository` / `DocumentRepository` patterns for parity).
- **Parity Rule**: The "Papers" module is currently being implemented as a direct clone of this "Documents" system, inheriting all tab structures and action logic.
