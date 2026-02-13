# Runbook: RBAC

## Add a page/action claim
1. Insert/update `pages` + `actions` records (`actions.code` is claim string).
2. Seed `roleClaims` for role defaults.
3. Optionally insert `userClaims` for direct user overrides.
4. Protect backend route with `hasToken:CLAIM_CODE` in `routes/api.php`.
5. Add frontend route `data.claimType` and/or `*hasClaim` gating in templates.

## Seed roleClaims/userClaims
- Authoritative tables: `roleClaims`, `userClaims`, `userRoles`, `actions`, `roles`, `users`.
- Use SQL patch or seeder and verify by querying joined claims.

## Verify JWT refresh / re-login
1. Login once and inspect claims in response from `/api/auth/login`.
2. Modify role/user claims in DB.
3. Call `/api/auth/refresh` or re-login; verify updated claims appear.
4. Validate old token cannot access newly restricted endpoints.

## Test UI gating
- Navigate to route with missing claim -> `AuthGuard` should redirect.
- Check hidden action buttons via `*hasClaim`.
- Confirm backend still blocks direct API calls (403).
