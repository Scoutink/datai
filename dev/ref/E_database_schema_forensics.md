# Forensic Analysis: Database Schema Consolidation

This document lists all tables within the Documents ecosystem and maps their relationships.

## 1. Core Document Tables

| Table Name | Description | Key Relationships |
| :--- | :--- | :--- |
| **documents** | Central document repository | Category, User (Creator), Client, Status, Workflow Instance |
| **categories** | Hierarchical folder structure | Parent Category, Documents |
| **documentMetaDatas** | Searchable tags for documents | Document |
| **documentVersions** | File versioning and history | Document |
| **documentStatus** | Lifecycle states (Draft, Published, etc) | Documents |
| **clients** | Client/Company mapping | Documents |

## 2. Permissions & Access Control

| Table Name | Description | Key Relationships |
| :--- | :--- | :--- |
| **documentRolePermissions** | Role-based document access | Document, Role |
| **documentUserPermissions** | User-specific document access | Document, User |
| **document_shareable_link** | Public links for document sharing | Document |

## 3. Engagement & Logs

| Table Name | Description | Key Relationships |
| :--- | :--- | :--- |
| **documentComments** | Threaded comments on documents | Document, User |
| **documentAuditTrails** | Operations history | Document, User, Role |
| **reminders** | Date-based alerts for documents | Document, User |
| **user_notifications** | App-level alerts for users | Document, User |

## 4. Workflow Tables (Advanced Lifecycle)

| Table Name | Description | Key Relationships |
| :--- | :--- | :--- |
| **workflows** | Workflow process definitions | User (Creator/Modifier) |
| **workflowSteps** | Individual stages (e.g., "Review") | Workflow |
| **workflowTransitions** | Paths between steps | Workflow, Step (From/To) |
| **workflowTransitionUsers** | User-specific auth for transition | Transition, User |
| **workflowTransitionRoles** | Role-specific auth for transition | Transition, Role |
| **documentWorkflow** | Active workflow instance on a document| Document, Workflow, Current Step |
| **workflowLogs** | History of workflow movements | Document Workflow, Transition, User |

---

## 5. ERD Logic (Simplified)

```mermaid
erDiagram
    CATEGORIES ||--o{ DOCUMENTS : "belongs to"
    DOCUMENTS ||--o{ DOCUMENT_METADATAS : "has tags"
    DOCUMENTS ||--o{ DOCUMENT_VERSIONS : "has history"
    DOCUMENTS ||--o{ DOCUMENT_ROLE_PERMISSIONS : "shared with roles"
    DOCUMENTS ||--o{ DOCUMENT_USER_PERMISSIONS : "shared with users"
    DOCUMENTS ||--o{ DOCUMENT_COMMENTS : "has comments"
    DOCUMENTS ||--o{ DOCUMENT_AUDIT_TRAILS : "audited"
    DOCUMENTS ||--o{ REMINDERS : "has alerts"
    DOCUMENTS ||--o{ DOCUMENT_WORKFLOW : "is in instance"
    WORKFLOWS ||--|{ WORKFLOW_STEPS : "defines stages"
    WORKFLOW_STEPS ||--o{ WORKFLOW_TRANSITIONS : "connects"
    DOCUMENT_WORKFLOW ||--o{ WORKFLOW_LOGS : "logs transitions"
    CLIENTS ||--o{ DOCUMENTS : "owns"
    DOCUMENT_STATUS ||--o{ DOCUMENTS : "defines state"
```

## 6. Migration Key Indices
- **Primary Keys**: All tables use `UUID` (`id`) as the primary key.
- **Foreign Keys**: Enforced on `categoryId`, `createdBy`, `parentId`, `documentId`, `workflowId`.
- **Performance Note**: Materialized paths (like `hierarchyPath`) are currently managed manually via SQL scripts or application logic rather than original schema triggers.
