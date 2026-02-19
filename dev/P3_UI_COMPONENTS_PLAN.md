# P3: Action Menu & Detail Sidebar Component Plan (Round 4)

Implement and wire the missing UI components for Permissions, Version History, Audit Trails, and Sharable Links based on the "Document" golden reference.

## User Review Required
> [!IMPORTANT]
> - **Unified Sidebar:** We will integrate the "Permissions", "Audit Trail", and "Version History" as tabs within the existing `PaperDetailsComponent` to maintain a consistent UX with the platform's modular standards.
> - **External Dialogs:** Sharable Link and Permission management will use standard Material Dialogs.

## Proposed Changes

### [Paper Permissions Component]
- **Refactor:** Update `paper-permissions.component.ts/html` to match the layout and logic of `document-permission`.
- **Logic:** Ensure role-based and user-based permission lists are correctly loaded and displayed.
- **Actions:** Wire "Add User", "Add Role", and "Delete" actions correctly to `PaperService`.

### [Paper Audit Trail Component]
- **Refactor:** Update `paper-audit-trail.component.ts/html` to mirror `document-audit-trail`.
- **Columns:** Ensure columns like `createdDate`, `operationName`, `createdBy`, `permissionUser`, and `permissionRole` are correctly mapped from the API response.

### [Paper Version History Component]
- **Refactor:** Update `paper-versions.component.ts/html` based on `document-version-history`.
- **Functionality:** Wire 'View' and 'Restore' actions to the backend versioning endpoints.

### [Sharable Link Component] [NEW]
- **Create:** `paper-details/sharable-link/sharable-link.component.ts/html/scss` cloned from `document/sharable-link`.
- **Logic:** Generate and manage public/private shareable links for papers.

### [PaperDetail Component]
- **Update:** Ensure all tabs in `mat-tab-group` load their respective components correctly and pass the `paperId`.

## Verification Plan

### Automated Tests
- N/A

### Manual Verification
1. **Details View:** Open any Paper.
    - **Permissions Tab:** Verify user/role list appears. Add a new user permission. Verify it saves.
    - **Audit Trail Tab:** Verify audit logs appear with correct operation names.
    - **Version History Tab:** Verify list of versions. Test 'View' on an old version.
2. **Sharable Link:** Generate a link and verify it can be accessed (based on permissions).
