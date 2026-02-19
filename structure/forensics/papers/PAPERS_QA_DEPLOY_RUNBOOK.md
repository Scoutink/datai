# Papers QA + Deploy Runbook (Zip Upload / Plesk workflow)

## 1) Build requirements before packaging
If Papers implementation changes Angular source, build outputs must be included before zip export.

Required commands (project root):
1. `cd resources/frontend/angular`
2. `npm install`
3. `npm run build -- --configuration production`

Expected output target:
- `public/assets/angular` (browser artifacts under `/assets/angular/browser/`)

If only backend/DB docs change: no frontend rebuild required.

---

## 2) DB execution order (phpMyAdmin)
1. Run core table DDL (`papers`, metadata, permission, version, comments, audit, share link).
2. Run RBAC inserts for `pages/actions/roleClaims`.
3. Optional seed for existing users/roles.
4. Validate with quick checks:
   - table exists,
   - at least one role has `ALL_PAPERS_VIEW_PAPERS`,
   - foreign keys created.

---

## 3) Server steps after extracting zip
1. Replace codebase with delivered package.
2. Ensure write permissions for Laravel runtime dirs:
   - `storage/`
   - `bootstrap/cache/`
3. Clear caches:
   - `php artisan optimize:clear`
4. Re-login with admin user (token refresh picks up claims).

---

## 4) Smoke checklist (browser)

### 4.1 RBAC
- Open menu: Papers should appear for role with view claim.
- Remove view claim and re-login: Papers menu should disappear.

### 4.2 Create flow
- Go to Papers add page.
- Add content with multiple Editor.js blocks.
- Save and confirm success toast.
- Expected: row appears in all papers list.

### 4.3 Assigned ACL
- Assign a paper to another user with date window.
- Login as that user and verify visibility in assigned list.
- Expire date window and verify removal from assigned list.

### 4.4 Details actions
- Open details.
- Add comment, share link, version snapshot, restore version.
- Expected: each action logs audit and updates related tab.

### 4.5 Share link
- Open public link in private browser.
- Test password and expiry behavior.
- Expected: valid links open, invalid/expired links blocked.

### 4.6 Export/download
- Export paper to PDF.
- Expected: downloadable file + audit entry.

---

## 5) Failure symptoms to report quickly
- 403 on expected allowed action: likely claim or row ACL mismatch.
- 500 on save: likely JSON parse/sanitization error.
- list count mismatch: count query not mirroring list filters.
- missing menu item after claim updates: user must re-login/refresh token.

---

## 6) Rollback strategy
- Code rollback: restore previous zip backup.
- DB rollback: restore pre-change DB backup (recommended).
- Minimum stabilize steps:
  1. restore code,
  2. restore DB backup,
  3. clear caches,
  4. verify documents module still healthy.
