# Permission Model (Claims-based RBAC)

## Authority model
- Canonical permission unit: claim string (e.g., `ASSIGNED_DOCUMENTS_SHARE_DOCUMENT`).
- Claims come from two DB sources merged at login/refresh:
  - role-derived (`roleClaims` via `userRoles`),
  - user-specific (`userClaims`).

## Backend enforcement
- Most API endpoints are nested under `auth` middleware + route-specific `hasToken:*` checks.
- `hasToken` middleware permits if **any** supplied claim is present in JWT payload claim array.
- This produces OR semantics for composite claims in route declarations.

## Frontend enforcement
- Route-level checks:
  - `AuthGuard` reads `data.claimType` and denies navigation when user lacks claim.
- UI-level checks:
  - templates use structural claim directives (`*hasClaim="'CLAIM'"`) to hide unauthorized actions/buttons.

## Practical effect
- Backend remains final authority (403/401).
- Frontend pre-filters navigation/actions for UX and reduces invalid calls.

## Where to change safely
- Claims naming/assignment: pages/actions/role claim seeding and admin UIs.
- Enforcement points:
  - Backend: `routes/api.php` + `app/Http/Middleware/HasToken.php`.
  - Frontend: route data claimType + `*hasClaim` usage.
