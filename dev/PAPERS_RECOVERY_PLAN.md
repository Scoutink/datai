# PAPERS MODULE RECOVERY PROTOCOL
**Status:** DRAFT (Gate 1 in progress)
**Date:** 2026-02-16

This document defines the strict "5-Gate Process" tasks for recovering the Papers module.

---

## IMPLEMENTATION ORDER: STRICT SEQUENCING

### **PHASE 1: DATA INTEGRITY (THE SYNC BRIDGE)**
**Goal:** Guarantee `contentJson` (Univer) and `SheetRows` (Relational) are 1:1 synchronized on every save.
**Prerequisite:** None.

#### P1-001: Implement `SheetDataService::syncFromUniverJson`
*   **Title:** Create Synchronization Logic for Univer JSON -> Relational DB
*   **Depends On:** None
*   **Impacts:** `app/Services/Sheets/SheetDataService.php` (~100 lines)
*   **Risk Level:** **CRITICAL** (Direct Database Delete/Insert operations)
*   **Description:** Implement the missing method that parses a raw UniverJS JSON snapshot, extracts sheet data, deletes existing rows/cells for that paper, and re-inserts them to reflect the current state.

#### P1-002: Integrate Sync into `PaperRepository::updatePaper`
*   **Title:** Call Sync Service on Paper Update
*   **Depends On:** P1-001
*   **Impacts:** `app/Repositories/Implementation/PaperRepository.php` (~5 lines)
*   **Risk Level:** **CRITICAL** (Core Save Loop)
*   **Description:** Modify `updatePaper` to call `syncFromUniverJson` immediately after updating the `papers` table `contentJson`. Ensure transaction rollback if sync fails.

#### P1-003: Integrate Sync into `PaperVersions::restorePaperVersion`
*   **Title:** Call Sync Service on Version Restore
*   **Depends On:** P1-001
*   **Impacts:** `app/Repositories/Implementation/PaperVersionsRepository.php` (~5 lines)
*   **Risk Level:** **HIGH** (Data Corruption if desync persists)
*   **Description:** Modify `restorePaperVersion` to call `syncFromUniverJson` after reverting the `papers` table to the target version's JSON.

#### P1-VALIDATE: End-to-End Data Integrity Test
*   **Title:** Validation of Phase 1
*   **Depends On:** P1-001, P1-002, P1-003
*   **Impacts:** Database State
*   **Description:** Manual verification that edits to the grid (frontend) result in SQL updates to `sheet_row_cells` table.

---

### **PHASE 2: RUNTIME STABILITY**
**Goal:** Eliminate console errors and rendering crashes.
**Prerequisite:** None (Can run parallel to Phase 1).

#### P2-001: Fix `UnifiedEditor` DI Conflict
*   **Title:** Fix `IImageIoService` Duplicate Registration
*   **Depends On:** None
*   **Impacts:** `src/app/shared/unified-editor/unified-editor.component.ts` (~10 lines)
*   **Risk Level:** **HIGH** (App Crash)
*   **Description:** Add a check `injector.has(IImageIoService)` before attempting to register the custom override, or use the correct override syntax for UniverJS.

#### P2-002: Fix `UnifiedEditor` 'go' ID Initialization
*   **Title:** Fix DOM Container Initialization Timing
*   **Depends On:** None
*   **Impacts:** `src/app/shared/unified-editor/unified-editor.component.ts` (~10 lines)
*   **Risk Level:** **HIGH** (Blank Screen)
*   **Description:** Ensure the container element is strictly available in the DOM before `new Univer()` is called, utilizing `ngAfterViewInit` and `ChangeDetectorRef` correctly.

---

### **PHASE 3: MISSING UI COMPONENTS (CLONING)**
**Goal:** Create the missing "Ghost Features" structure.
**Prerequisite:** Phase 1 Complete (Do not build UI on broken data).

#### P3-001: Clone `PaperPermissionListComponent`
*   **Title:** Implement Permissions UI
*   **Depends On:** Phase 1, Existing `DocumentPermissionListComponent`
*   **Impacts:** `src/app/papers/paper-permission/*` (New Directory)
*   **Risk Level:** MEDIUM
*   **Description:** Clone `DocumentPermissionListComponent` (and HTML/SCSS) to `PaperPermissionListComponent`. Retarget usages of `DocumentService` to `PaperService`.

#### P3-002: Clone `PaperVersionHistoryComponent`
*   **Title:** Implement Version History UI
*   **Depends On:** Phase 1, P3-001 (Pattern)
*   **Impacts:** `src/app/papers/paper-version-history/*` (New Directory)
*   **Risk Level:** MEDIUM
*   **Description:** Clone `DocumentVersionHistoryComponent`. Retarget logic to `PaperService.getVersions` and `PaperService.restoreVersion`.

#### P3-003: Implement `SharableLinkComponent` for Papers
*   **Title:** Implement Share Link UI
*   **Depends On:** Phase 1
*   **Impacts:** `src/app/papers/paper-shareable-link/*` (New or Reuse)
*   **Risk Level:** LOW
*   **Description:** Adapt the generic `SharableLinkComponent` (if generic) or clone `DocumentShareableLinkComponent` to work with Papers.

---

### **PHASE 4: ACTION MENU WIRING**
**Goal:** Connect the List View to the new Components.
**Prerequisite:** Phase 3 Complete.

#### P4-001: Wire Permissions & Share
*   **Title:** Wire Permission Handlers in PaperList
*   **Depends On:** P3-001
*   **Impacts:** `src/app/papers/paper-list/paper-list.component.ts`
*   **Risk Level:** LOW
*   **Description:** Implement `onPermission` and `onShareLink` to open the dialogs created in Phase 3.

#### P4-002: Wire Version History
*   **Title:** Wire History Handler in PaperList
*   **Depends On:** P3-002
*   **Impacts:** `src/app/papers/paper-list/paper-list.component.ts`
*   **Risk Level:** LOW
*   **Description:** Implement `onVersionHistory` to open the dialog created in Phase 3.

#### P4-003: Wire Archive & Indexing
*   **Title:** Wire Archive and Index Handlers
*   **Depends On:** Phase 1
*   **Impacts:** `src/app/papers/paper-list/paper-list.component.ts`
*   **Risk Level:** MEDIUM
*   **Description:** Implement `deletePaper` (Action: Archive) and map Indexing buttons to service calls.

---

### **PHASE 5: DETAIL VIEW RESTORATION**
**Goal:** Implement the "3-View Pattern" (List -> Detail -> Edit).
**Prerequisite:** Phase 3 & 4.

#### P5-001: Create `PaperDetailsComponent`
*   **Title:** Create Tabbed Detail View
*   **Depends On:** P3-001, P3-002
*   **Impacts:** `src/app/papers/paper-details/*` (New Directory)
*   **Risk Level:** HIGH
*   **Description:** Create a read-only view with Material Tabs: "General" (Preview), "Permissions", "Versions", "Audit".

#### P5-002: Refactor Routing
*   **Title:** Split View/Edit Routes
*   **Depends On:** P5-001
*   **Impacts:** `src/app/papers/paper-routing.module.ts`
*   **Risk Level:** HIGH
*   **Description:** Change `/papers/:id` to point to `PaperDetailsComponent`. Keep `/papers/manage/:id` for `PaperManageComponent`.

---

## EXECUTION LOG & GATES

| Task ID | Gate 1 (Def) | Gate 2 (Pre) | Gate 3 (Impl) | Gate 4 (Val) | Gate 5 (Done) |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **P1-001** | [x] | [x] | [x] | [x] | [x] |
| **P1-002** | [x] | [x] | [x] | [x] | [x] |
| **P1-003** | [x] | [x] | [x] | [x] | [x] |
| **P2-001** | [x] | [x] | [x] | [x] | [x] |
| **P2-002** | [x] | [x] | [x] | [x] | [x] |
| **P2-003** | [x] | [x] | [x] | [x] | [x] |
| **P2-004** | [x] | [x] | [x] | [x] | [x] |
