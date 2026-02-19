# Boards Module: Card Detail Specification (V1.1)

This document outlines the required features and functionalities for the Card Detail View within the Boards module, aiming for architectural parity with the high-end Boards implementations.

## 1. Overview
The Card Detail View is a modal-based interface that allows users to manage granular task details. It serves as the primary hub for collaboration, documentation, and tracking for each card.

## 2. Core Features & Functional Requirements

### A. Information & Content
| Feature | Requirement | Notes |
|---------|-------------|-------|
| **Rich Text Description** | Integration of Quill.js for formatted notes. | Support for bold, lists, and links. |
| **Checklist System** | Multi-checklist support with progress bars. | Tasks can be checked/unchecked. |
| **Activity & Attachment Thread** | A unified "Trello-style" feed of comments, WYSIWYG notes, links, and attachments. | **Unified Thread View**: Chronological list of all interactions. |
| **Document Integration** | Powerful connection to platform documents. | **UX Requirement**: Open documents (PDF/Office) in an overlay/drawer without leaving the board. |
| **Card Tags** | Visual tagging system (Distinct from labels/categories). | Multi-tag support for filtering. |

### B. Role-Based Assignments
Assignments are managed via dropdowns showing all platform users. Every card supports four distinct roles:
1.  **Executor 👷**: The primary person responsible for the work.
2.  **Approver ✅**: The individual who validates/approves the completion.
3.  **Follower 👁️**: Users notified of updates but not actively working.
4.  **Supervisor 📊**: Management-level oversight for reporting.

### C. Attributes & Metadata
-   **Priority**: 4-level selection (Low, Medium, High, Urgent).
-   **Dates**: Support for both **Start Date** and **Due Date** with overdue indicators.
-   **Labels**: Color-coded categorization for quick visual grouping.
-   **Milestones**: Connection to project-wide milestones for tracking progress.

### D. Advanced Connectivity
-   **Node Connections**: Binding cards to the **Dynamic List** (hierarchical tree sidebar) for advanced filtering.
-   **Backlog Linking (Next Stage)**: Prepare architecture for linking to cards in the first column (requires column-level logic updates).

## 3. UI/UX Standard
- **Assignments**: Must use dropdowns with user search/avatars.
- **Document Viewing**: Integration with platform's `PdfViewer` or `OfficeViewer` inside a non-disruptive layer (e.g., Side Sheet).
- **Activity Feed**: Comments, Note-blocks, and File-links must be interleaved in a chronological "story" of the card.

## 4. Implementation Plan (High-Level)

### 4.1 Database Updates
We will need to expand the `boardCards` and related tables to support:
-   `executorId`, `approverId`, `supervisorId` (Multiple assignees per role).
-   `html_description` for rich text.
-   `parentCardId` for backlog linking.

### 4.2 Backend API
-   Update `BoardController@showCard` to return full detail objects (assignees, labels, activity).
-   Implement specific endpoints for checklist management and assignment updates.

### 4.3 Frontend Components
-   **CardDetailModalComponent**: A new standalone component to handle the rich interface.
-   **Quill Editor Integration**: Reusable rich-text component.

---

> [!IMPORTANT]
> **Priority Item**: Role-based assignments will be implemented first as they provide the highest immediate ROI for collaboration.
