# Frontend Forensics Map (Angular)

## App structure
- Root bootstrap: `src/main.ts`.
- Root module: `src/app/app.module.ts`.
- Root routing: `src/app/app-routing.module.ts` (lazy modules + standalone components).
- Core: `core/security`, `core/interceptor`, `shared/has-claim.directive.ts`.

## HTTP interceptor
- `core/interceptor/http-interceptor.module.ts`.
- Adds `Authorization: Bearer <token>` from `LicenseValidatorService`.
- Prefixes URLs with `environment.apiUrl + 'api/'` unless already api.
- Handles 401 -> logout/login redirect; 403 -> toast error.

## Claim-based UI gating
- Route-level: `AuthGuard` checks `route.data.claimType` using `SecurityService.hasClaim()`.
- Template-level: `*hasClaim` directive in menus/buttons.
- Claims are hydrated from auth object/JWT via `SecurityService`.

## Major module map
- Documents (all): `/documents` -> `DocumentListComponent` + `DocumentService` (`/documents`, `/document/*`, deep-search, share-link, versions, signatures, watermark).
- Documents (assigned): `/document-library` -> `DocumentLibraryListComponent` + `DocumentLibraryService` (`/document/assignedDocuments`).
- Users: `/users/*` -> user module routes + user service endpoints.
- Roles: `/roles/*`.
- Workflows: `/workflow-settings`, `/workflows`, `/current-workflow`, `/workflow-logs`.
- Boards: `/boards` and card workflows.

## Pagination/list pattern
- DataSource classes parse response headers:
  - `document-list/document-datasource.ts`
  - `document-library-list/document-library-datasource.ts`
- Expected headers: `pageSize`, `totalCount`, `skip`.
- Table/filter UX pattern: material table + paginator + sort + debounced text filters.

## Error handling
- Interceptor global handling for auth/permission/validation errors.
- Feature services use `catchError(commonHttpErrorService.handleError)`.
