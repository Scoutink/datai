# License banner + activation redirect forensic trace

## What triggers the red banner on login

The banner text shown in production (`🔒 ACTIVATE LICENSE — Click Here to Verify License`) is emitted by the third-party package `@mlglobtech/license-validator-docphp` in the built frontend bundle.

In the built output, the banner HTML and insertion logic appears in:

- `public/assets/angular-v4/browser/chunk-F5F27R7A.js`

This chunk contains logic equivalent to:

- `showBanner()` inserts a red banner at the top of `document.body` with link to `/activate-license`.

## What triggers redirect to /activate-license after login

The same third-party package triggers redirect in its `activateLicense()` path.

From `public/assets/angular-v4/browser/chunk-F5F27R7A.js`:

- `activateLicense()` validates token/license.
- If validation fails, it calls `showBanner()` and `router.navigate(['/activate-license'])`.
- `setTokenUserValue(...)` calls `activateLicense()` before persisting auth object.

App login code calls `setTokenUserValue(...)` in `SecurityService.login(...)`, so failed license validation at that package layer causes immediate post-login redirect.

## Why the previous bypass change did not affect your production site

1. The previous change only bypassed `LicenseInitializerService.initialize()` in app startup.
2. Your redirect occurs later on login via `LicenseValidatorService.setTokenUserValue(...)`.
3. Your production build uses `environment.ts` where `licenseBypassForDevelopment` is `false`.
4. Production serves compiled files from `resources/views/angular.blade.php` -> `/assets/angular-v4/browser/` hashed bundles, so source edits are only effective after rebuild/deploy.

## Relevant first-party source touchpoints

- `resources/frontend/angular/src/app/core/security/initialize-app-factory.ts`
- `resources/frontend/angular/src/app/core/security/security.service.ts`
- `resources/views/angular.blade.php`

## Practical debugging checklist (safe)

1. Confirm deployed `main-*.js` and `chunk-*.js` hashes changed after release.
2. Confirm `/assets/angular-v4/browser/chunk-F5F27R7A.js` (or current chunk) changed on server after deploy.
3. In browser devtools, place breakpoint on `router.navigate(['/activate-license'])` inside the license package chunk.
4. Verify `companyprofile` API response values used by package verification (`licenseKey`, `purchaseCode`).
5. Verify login flow reaches `SecurityService.login(...)` and that package method `setTokenUserValue(...)` is invoked right before redirect.

