# Forensic Analysis: Architectural Golden Path

This document defines the "Golden Path" for implementing new modules in the FlowsPro platform, based on the architectural standards observed in the stabilized Documents ecosystem.

## 1. The Implementation Lifecycle

### Phase A: Database & Model (The Core)
1.  **Migration**: 
    - Always use `UUID` for primary keys.
    - Include `isDeleted` (boolean), `createdBy` (UUID), `modifiedBy` (UUID), `createdDate` (dateTime), `modifiedDate` (dateTime), and `softDeletes()`.
2.  **Model**:
    - Extend `Illuminate\Database\Eloquent\Model`.
    - Use `Uuids`, `Notifiable`, and `HasFactory` traits.
    - **Stability Guard**: Implement the `boot()` method to auto-populate `createdBy`, `modifiedBy`, and `id` (UUID) using `Auth::id()`.
    - **Global Scope**: Always add a global scope for `isDeleted = 0`.

### Phase B: Repository Pattern (The Logic)
1.  **Contract**: Define an interface in `app/Repositories/Contracts`.
2.  **Implementation**: 
    - Extend `BaseRepository`.
    - **Stability Guard**: For list queries, always implement a `Count` method (e.g., `getDocumentsCount`) that matches the filtration logic of the `List` method.
    - **Recursion**: If hierarchical, use Materialized Paths (`hierarchyPath`) + `LIKE` queries instead of recursive ORM relationships for performance 10+ levels deep.
3.  **Authentication**: Use `Auth::id()` for all user-bound queries. Avoid `Auth::parseToken()` as it is prone to intermediate failures.

### Phase C: Controller & Routing (The Gateway)
1.  **Controller**: 
    - Inject Repository Contracts via constructor.
    - Use `Validator::make` or Request Classes for all incoming data.
2.  **Routing**: 
    - Register in `routes/api.php`.
    - Wrap in `auth` middleware.
    - Apply `hasToken:CLAIM_NAME` middleware for granular permission enforcement.

### Phase D: Frontend Service & State (The Data Flow)
1.  **Domain Class**: Create a TypeScript interface in `@core/domain-classes`.
2.  **Service**: 
    - Create a dedicated Angular Service.
    - Use `catchError(this.commonHttpErrorService.handleError)` on every pipe.
3.  **State Management**: 
    - **Modern Path**: Use `signalStore` (NGRX Signals) for new modules.
    - **Classic Path**: Use `DataSource` if integrating into existing complex Material Tables.

### Phase E: UI Components (The Experience)
1.  **Container/Smart Component**: Handles data fetching, dialog opening, and store interactions.
2.  **Presentational/Dumb Component**: Handles the form/UI logic, emits events.
3.  **Permission Guard**: Wrap actions in `*hasClaim="'PERMISSION_NAME'"` or `*hasClaim="['P1', 'P2']"`.

---

## 2. Stability Guards (Avoiding Common Errors)

| Error Type | Root Cause (Forensic) | Prevention (Golden Path) |
| :--- | :--- | :--- |
| **500 Internal Server** | Unhandled nulls, collection/array mismatches in whereIn. | Always cast collection results to `toArray()` before `whereIn`. Use null-safe operators in repositories. |
| **Unexpected Logouts** | Session token parsing failures. | Use `Auth::id()` for ID retrieval. Avoid manual `parseToken` calls in Repositories/Models. |
| **Chunk Errors (FE)** | Lazy loading sync issues during deployments. | Ensure consistent build hashes. Avoid complex circular dependencies between modules. |
| **TypeErrors (FE)** | Accessing properties of undefined before data loads. | Use `toObservable` with signals to ensure reactivity. Initialize objects in `ngOnInit`. |

---

## 3. Recommended Checklist for New Modules

- [ ] Migration uses UUIDs and Audit columns.
- [ ] Model `boot()` method handles auto-auditing.
- [ ] Repository Contract exists and is bound in `RepositoryServiceProvider`.
- [ ] Controller methods return consistent JSON structures.
- [ ] Frontend Service uses `CommonHttpErrorService`.
- [ ] Claims/Permissions are added to the `claims` table and mapped in the UI.
- [ ] Documentation updated in `DEVELOPER_COOKBOOK.md`.
