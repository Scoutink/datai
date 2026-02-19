# Runtime Architecture

## High-level runtime shape
Browser UI (Angular SPA) → `api/*` HTTP requests → Laravel route middleware/controller layer → repository/service/model operations → MySQL + storage disks.

## Request lifecycle in this codebase
1. **Routing**
   - Angular shell served by `AngularController` through `routes/web.php` catch-all.
   - API endpoints registered in `routes/api.php`.
2. **Middleware**
   - Global middleware stack includes CORS middleware and core request normalizers.
   - Protected API routes use `auth` middleware (JWT guard) and claim checks via `hasToken:*` middleware.
   - Boards web routes use `boards` session middleware group + `boardsAuth` JWT/claim middleware.
3. **Controller layer**
   - Controllers are thin and delegate to repository interfaces (e.g., document, workflow, reminder, sharing).
4. **Repository + model layer**
   - Repository interfaces are bound to concrete implementations in `RepositoryServiceProvider`.
   - Repositories operate through Eloquent models and query builders.
5. **Persistence + files**
   - MySQL stores relational entities.
   - Files are read/written using Laravel Storage disks (`local`, optional `s3`).

## Authorization shape
- Auth guard defaults to `api` using JWT driver.
- Permission checks are claim-string based, enforced in backend `hasToken` middleware and mirrored in frontend route/action gating.

## Background/scheduled runtime concerns found in code
- **Scheduler present**: `app/Console/Kernel.php` registers daily + every-10-minute notification, email, and retention cleanup commands.
- **Queue config exists**: default `sync`; database/redis/sqs drivers configured but not forced.
- **Broadcast/websocket**: broadcasting driver defaults to `null` (no active websocket stack configured by default).
- **Storage**: configurable default disk via env (`FILESYSTEM_DISK`), with `local`, `public`, and `s3` definitions.

## Architectural patterns to preserve
- Controller → repository interface → repository implementation pattern.
- Claim strings as canonical authorization unit.
- Angular service endpoints use relative paths and are rewritten by HTTP interceptor with `environment.apiUrl` + `/api/` prefix.
