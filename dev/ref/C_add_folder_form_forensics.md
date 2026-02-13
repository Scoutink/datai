# Forensic Analysis: "Add Folder" (Category) Form

This document provides a comprehensive breakdown of the "Add Folder" (Category) management in the FlowsPro platform.

## 1. Field-by-Field Breakdown

| Field Label (UI) | Component / Input Type | Validation Rules (FE) | Validation Rules (BE) | DB Table | DB Column |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Category Name** | `input[type="text"]` | Required | Required, Unique in Parent | `categories` | `name` |
| **Description** | `textarea` | Optional | Optional | `categories` | `description` |
| **Parent Category** | `Hidden / ID` | Inherited from context | Valid UUID (nullable) | `categories` | `parentId` |

### Persistence Logic
- **UUID**: Generated automatically on creation via `Categories` model `boot()` method.
- **Audit Fields**: `createdBy` and `modifiedBy` are automatically populated from the authenticated user context in the model's `creating` hook.
- **Soft Deletes**: Uses `isDeleted` column and Laravel's `softDeletes` trait, though a global scope `isDeleted` filter is also explicitly added.

---

## 2. Request Lifecycle Map

### High-Level Flow
`UI (Add Sub-Category)` → `ManageCategoryComponent` → `CategoryStore (Signal Store)` → `CategoryService` → `CategoryController` → `CategoryRepository` → `Database`

### Forensic Trace
1.  **UI Trigger**: `CategoryListComponent` logic opens `ManageCategoryComponent` in a dialog, passing the `parentId` if adding a sub-folder.
2.  **Frontend Store**: `CategoryStore.addCategory(category)`
    - Dispatches async action using `@ngrx/signals/rxjs-interop`.
3.  **Frontend Service**: `CategoryService.add(category)`
    - Endpoint: `POST /category`.
4.  **Backend Route**: `routes/api.php`
    - `Route::post('/category', [CategoryController::class, 'create']);`
    - Middleware: `auth`, `hasToken:DOCUMENT_CATEGORY_MANAGE_DOCUMENT_CATEGORY`.
5.  **Controller**: `CategoryController.create(request)`
    - Validates `name` and `parentId`.
    - **Duplicate Check**: Checks if a category with the same name already exists under the same `parentId`. Returns `409 Conflict` if so.
6.  **Repository**: `CategoryRepository.create(data)`
    - Uses `BaseRepository` methods to persist the record.
7.  **Model Boot**: `Categories.php`
    - `creating` hook: Sets `id` (UUID), `createdBy`, `modifiedBy`.

---

## 3. Related Migrations & Tables

| Table Name | Purpose | Migration File |
| :--- | :--- | :--- |
| **categories** | Stores hierarchical folder structure | `2022_12_08_064517_create_categories_table.php` |

### DB Constraints
- **Foreign Key**: `parentId` references `id` within the same `categories` table.
- **On Delete**: `cascade`. This ensures that deleting a parent folder deletes its sub-folders.

---

## 4. Observations & Potential Improvements (Forensic Note)
- **Hierarchy Depth**: The current implementation does not store a materialized path (e.g., `hierarchyPath`). Recursive lookups currently rely on joining or recursive queries.
- **Validation**: Frontend validation is minimal (only `required` for name).
- **Navigation Response**: When a category is saved, the `CategoryStore` resets the `loadList` flag, triggering a full reload of the category tree.
