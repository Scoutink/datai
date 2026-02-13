# Forensic Analysis: "Add Document" Form

This document provides a comprehensive breakdown of the "Add Document" form in the FlowsPro platform, covering UI components, validation, persistence, and the complete backend lifecycle.

## 1. Field-by-Field Breakdown

| Field Label (UI) | Component / Input Type | Validation Rules (FE) | Validation Rules (BE) | DB Table | DB Column |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Document Upload** | `input[type="file"]` | Required, Allowed Extensions | Required, Valid File | `documents` | `url`, `extension`, `location` |
| **Name** | `input[type="text"]` | Required | Required, Unique in Category | `documents` | `name` |
| **Category** | `ng-select` (Tree) | Required | Required | `documents` | `categoryId` |
| **Storage** | `ng-select` | Default: `local` | Valid Storage Type | `documents` | `location` |
| **Document Status** | `ng-select` | Optional | - | `documents` | `statusId` |
| **Client** | `ng-select` | Optional | - | `documents` | `clientId` |
| **Retention Period** | `input[type="number"]` | Optional, Min: 1 | - | `documents` | `retentionPeriod` |
| **Retention Action** | `ng-select` | Optional | Valid Enum (0,1,2) | `documents` | `retentionAction` |
| **Meta Tags** | `FormArray` (Text) | Min 1 tag if touched | - | `documentMetaDatas` | `metatag` |
| **Description** | `textarea` | Optional | - | `documents` | `description` |
| **Assign Roles** | `ng-select` [multiple] | Optional | - | `documentRolePermissions` | `roleId` |
| **Assign Users** | `ng-select` [multiple] | Optional | - | `documentUserPermissions` | `userId` |

### Field Details & Persistence Logic
- **Storage**: Maps to Laravel `Storage` disks (`local` vs `s3`). Logic found in `DocumentController@saveDocument`.
- **Retention Action**: Maps to `App\Models\RetentionActionEnum`:
  - `0`: Archive
  - `1`: Permanent Delete
  - `2`: Expire
- **Permissions**: Shared roles and users are persisted in separate tables (`documentRolePermissions`, `documentUserPermissions`) with support for time-bound access (`isTimeBound`, `startDate`, `endDate`) and download restrictions (`isAllowDownload`).

---

## 2. Request Lifecycle Map

### High-Level Flow
`UI (Save Click)` → `DocumentManageComponent` → `DocumentService` → `Laravel API Route` → `DocumentController` → `DocumentRepository` → `Database (Transaction)`

### Forensic Trace
1.  **UI Trigger**: `DocumentManagePresentationComponent.SaveDocument()`
    - Validates `ReactiveForm`.
    - Builds `DocumentInfo` object.
    - Emits `onSaveDocument`.
2.  **Frontend Service**: `DocumentService.addDocument(document)`
    - Transforms data into `FormData`.
    - Endpoint: `POST /document`.
3.  **Backend Route**: `routes/api.php`
    - `Route::post('/document', [DocumentController::class, 'saveDocument']);`
    - Middleware: `auth`, `hasToken:ALL_DOCUMENTS_CREATE_DOCUMENT`.
4.  **Controller**: `DocumentController.saveDocument(request)`
    - File validation using `Validator::make`.
    - Checks for duplicate names within the same category.
    - Stores file using `Storage::disk($location)->storeAs`.
    - Hands data to Repository.
5.  **Repository**: `DocumentRepository.saveDocument(request, path, fileSize)`
    - Starts `DB::beginTransaction()`.
    - Creates `Documents` record.
    - **Side Effect 1 (Meta Tags)**: Iterates and saves to `documentMetaDatas`.
    - **Side Effect 2 (Deep Search)**: Calls `DocumentIndexer.createDocumentIndex` if file size < 3MB.
    - **Side Effect 3 (Permissions)**: Saves to `documentRolePermissions` and `documentUserPermissions`.
    - **Side Effect 4 (Audit Trail)**: Creates entry in `documentAuditTrails`.
    - **Side Effect 5 (Notifications)**: Creates entries in `userNotifications` for all shared users.
    - `DB::commit()`.

---

## 3. Related Migrations & Tables

| Table Name | Purpose | Migration File |
| :--- | :--- | :--- |
| **documents** | Core document metadata and file pointers | `2023_01_23_082532_create_documents_table.php` |
| **categories** | Hierarchical classification | `2022_12_08_064517_create_categories_table.php` |
| **documentMetaDatas** | Searchable tags for documents | `2023_01_25_091840_create_document_meta_datas_table.php` |
| **documentRolePermissions** | RBAC for document access | `2023_01_26_112250_create_document_role_permissions_table.php` |
| **documentUserPermissions** | User-level sharing/access | `2023_01_26_112318_create_document_user_permissions_table.php` |
| **documentAuditTrails** | History of creation, edits, and sharing | `2023_01_31_063051_create_document_audit_trails_table.php` |
| **user_notifications** | Alerts for users when a document is shared | `2023_02_18_073159_create_user_notifications_table.php` |
| **clients** | Ownership/Client mapping | `2025_03_11_115518_create_clients_table.php` |
| **documentStatus** | Lifecycle state (e.g., Draft, Published) | `2025_04_28_061655_create_document_status_table.php` |

---

## 4. Verification Checklist

- [ ] Inspect `documents` table: Verify `location` column exists and contains `local` or `s3`.
- [ ] Inspect `saveDocument` method in `DocumentRepository.php`: Confirm the transactional loop for meta tags and permissions.
- [ ] Verify `DocumentStatus` mapping: Check `DocumentStatusStore` in Angular corresponds to the `documentStatus` table.
- [ ] Verify permission logic: Confirm `isAllowDownload` is handled in the `downloadDocument` controller method if necessary (check `DocumentPermissionRepository` for actual gatekeeping).
