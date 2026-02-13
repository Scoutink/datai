# FlowsPro System Architecture

> **Document Status**: 🟡 UNDER CONSTRUCTION
> **Objective**: Comprehensive technical blueprint of the FlowsPro platform, covering database design, backend logic, frontend integration, and cross-module relationships.

## 1. Overview
FlowsPro is a enterprise document management and collaboration platform (including Kanban boards) built with **Laravel 10+** on the backend and **Angular 16+** on the frontend. It follows a modular architecture where features (Documents, Boards, Workflow) are isolated but share a core platform layer for Auth, Users, and Permissions.

## 2. Request Lifecycle & Routing
### 2.1 Entry Point
The system entry point is the standard `public/index.php`. The request flows through the Laravel HTTP Kernel (`app/Http/Kernel.php`).

### 2.2 Middleware Pipeline
- **Global**: Handles CORS (`corsMiddleware`), trust proxies, and string trimming.
- **Route Groups**: 
    - `api`: Standard group for all backend endpoints. Includes standard substitution bindings and throttling.
    - `boards`: Special group for Kanban-related features.
- **Custom Authorization**: 
    - `auth`: Standard Laravel authentication (likely leveraging JWT).
    - `hasToken`: A custom **Claim-Based Authorization** middleware. It parses the JWT payload and checks if the required claim (permission) is present in the `claims` array.
    - `boardsAuth`: Specific authentication layer for boards.

### 2.3 Routing Strategy
Routes are primarily defined in `routes/api.php`. The platform uses controller-based groups and `hasToken` middleware to enforce granular permission checks on a per-endpoint basis.

## 3. Backend Architecture (Laravel)
### 3.1 Repository Pattern Implementation
The platform strictly uses the **Repository Pattern** to abstract data access from the controllers.
- **Implementation**: Every feature has a Contract (Interface) in `app/Repositories/Contracts` and an Implementation in `app/Repositories/Implementation`.
- **Base Layer**: All implementations extend `BaseRepository`, which provides a standardized CRUD interface.
- **Manual Soft Deletes**: The base layer uses a custom `isDeleted` (boolean) column and `deletedBy` for soft deletes, rather than the native Laravel `SoftDeletes` trait.

### 3.2 Core Service Providers
- `RepositoryServiceProvider`: Responsible for binding interfaces to implementation classes, enabling dependency injection in controllers.

### 3.3 Models & Eloquent
- **Custom Primary Keys (UUIDs)**: Models implement the `Uuids` trait and manually assign `Uuid::uuid4()` during the `creating` Eloquent event. Standard Laravel auto-incrementing IDs are NOT used for core entities.
- **Global Scopes**: Soft deletion is enforced at the model level via `isDeleted` global scopes. This ensures that any query (unless `withoutGlobalScopes()` is called) automatically filters out "deleted" records.
- **Timestamp Aliasing**:
    - Legacy Laravel `created_at` / `updated_at` are often replaced by `createdDate` and `modifiedDate` via constants (`CREATED_AT`, `UPDATED_AT`).
    - Some models disable `$timestamps` entirely and handle them manually or through repository logic.
- **Naming Conventions**: 
    - **Models**: Plural naming (e.g. `Users.php`, `Documents.php`) is common, deviating from standard singular Laravel naming.
    - **Tables**: CamelCase (e.g., `boardCards`, `userNotifications`).
    - **Columns**: CamelCase (e.g., `categoryId`, `isDeleted`, `documentWorkflowId`).

## 4. Data Layer (MySQL)
### 4.1 Global Conventions
- **Engine**: InnoDB with `utf8mb4_unicode_ci` collation.
- **UUIDs**: Primary keys are `char(36)` and relationships use the same type.
- **Standard Audit Columns**: 
    - `id`: char(36) primary key.
    - `createdBy`/`modifiedBy`: char(36) foreign key to users.
    - `isDeleted`: tinyint(1) used for global soft-delete scopes.
    - `createdDate`/`modifiedDate`: datetime for record auditing.
    - `deleted_at`: timestamp (likely for compatibility with native Laravel SoftDeletes where applied).
- **Booleans**: Always `tinyint(1)` with `0`/`1` values.

### 4.2 Module Schema Analysis
- **Security & RBAC**:
    - `users`: Core identity table.
    - `roles`: System roles (Administrator, User, etc.).
    - `userRoles`: Pivot table for multi-role assignment.
    - `actions`: Definitive list of system permissions (e.g. `BOARDS_VIEW_BOARDS`, `USER_CREATE_USER`).
    - `userClaims`: Granular permissions assigned directly to users.
- **Kanban Board**:
    - `boards`: Container for board settings.
    - `boardColumns`: Defines the swimlanes.
    - `boardCards`: The primary data entity, linked to activities, checkists, and assignees.
- **AI Integration**:
    - `aiPromptTemplates`: Managed templates for generative AI features.
    - `OpenAIDocuments`: Tracking for AI-processed document content.

## 5. Frontend Architecture (Angular)
### 5.1 Project Structure
- **Framework**: Angular 18+ with **NgRx** for state management.
- **Organization**: Feature-module based. Major modules include `BoardsModule`, `DocumentsModule`, `UserModule`.
- **Core Layer**: Contains singleton services (`common.service.ts`) and global HTTP interceptors for JWT injection.
- **Shared Layer**: Houses reusable UI components (modals, loaders, pickers) and pipes.

### 5.2 Communication with Backend
- **Authentication**: JWT is stored in local storage and managed via `@auth0/angular-jwt`.
- **Interceptors**: `HttpInterceptorModule` automatically adds the `Authorization: Bearer <token>` header to all outgoing API requests.
- **Service Pattern**: Components do not call `HttpClient` directly. They use feature services which extend or utilize `CommonService` to perform CRUD operations against the Laravel repositories.
- **State Management**: NgRx Store acts as the "Single Source of Truth" for complex UI states (e.g. active board data, user permissions).

## 6. Cross-Module Interactions
### 6.1 Document-Board Integration
- Cards in the Kanban module can be linked to platform documents via `boardCardAttachments`. 
- This relationship allows for "contextual collaboration" where project tasks are directly tied to official documentation.

### 6.2 Permission Propagation
- User permissions (claims) defined at the platform level are synced to the frontend state upon login.
- Direct integration between `UserModule` and other features ensures that UI elements (buttons, menus) are conditionally rendered based on token claims.

## 7. Security & Permissions
### 7.1 Token-Based Authorization
- **JWT Implementation**: Uses `PHPOpenSourceSaver\JWTAuth` for stateless authentication.
- **Claims System**: Permissions are stored as 'claims' within the JWT payload. 
- **Middleware Layers**:
    - `HasToken`: The primary API gatekeeper. Checks if the incoming JWT contains specific claims (e.g., `BOARDS_VIEW_BOARDS`).
    - `BoardsAuth`: A hybrid middleware for Blade components. It can read JWTs from cookies, ensuring that server-side rendered pages share the same session context as the Angular frontend.

### 7.2 RBAC Model
- **Roles**: Broad categories of users (Admin, Staff, Client).
- **Claims**: Granular actions mapped to roles or individual users.
- **Data Isolation**: Multi-tenancy is partially enforced through `clientId` fields in core tables (e.g., `documents`, `boards`), which is often filtered via repository scopes.

## 8. Infrastructure & Lifecycle
### 8.1 Installation & Updates
- **Wizard-based Lifecycle**: The platform includes `InstallController` and `UpdateController` to manage schema evolution.
- **Automated Patches**: The update logic triggers `Artisan::call('migrate')` and runs sequential versioned seeders (e.g., `PermissionSeederV53`) to ensure permission lists are kept up to date.
- **Version Tracking**: The `APP_VERSION` is tracked in the `.env` file and compared against `config/constants.php` to detect available updates.

### 8.2 Security Infrastructure
- **License Validation**: The platform includes a license-checking mechanism that communicates with `apilicense.mlglobtech.com`. Valid licenses are cached in the `companyProfile` table.
- **Encryption**: Standard Laravel hashing for passwords and native encryption for sensitive config where needed.

## 9. Conclusion
The FlowsPro platform is built on a mature, repository-first Laravel architecture that emphasizes data integrity (UUIDs and strict schema) and modularity. The fusion of a stateless API (JWT) with a powerful Angular/NgRx frontend creates a scalable environment for complex document and task management. Future development should adhere to the established CamelCase naming conventions and the "Controller -> Repository -> Model" delegation pattern to maintain architectural consistency.
