# Frontend Authentication (Angular)

## Core auth service and guard
- Auth/session logic: `SecurityService` (`core/security/security.service.ts`).
- Route protection: `AuthGuard` (`core/security/auth.guard.ts`) using `securityService.isLogin()` and optional route `data.claimType` checks.

## Token storage and retrieval
- Token and auth object are handled through `LicenseValidatorService` and stored in browser storage.
- `JwtModule` token getter reads `localStorage.getItem('bearerToken')`.
- On logout/reset, local storage keys are removed and user is redirected to `/login`.

## API URL and auth header behavior
- Base URL from `environment.apiUrl`:
  - prod: `/`
  - dev: `http://localhost:8000/`
- `HttpRequestInterceptor` rewrites requests to `${apiUrl}api/<path>` unless URL already contains `api`.
- Bearer token is attached from stored token for API calls.
- 401 responses trigger forced logout + redirect to login.

## Frontend refresh behavior
- `SecurityService` schedules token refresh based on `tokenExpiredTimeInMin` and last token time.
- Calls `POST auth/refresh`; on success replaces stored token/user state and re-arms refresh timer.
