## Page 1

# DATAI — Module Development Guide (Definitive)
(How to add a new "module" to the platform in a way that is organic, secure, and production-grade)

## 0) What "module" means in DATAI

In this platform, a "module" is a cohesive feature area that is registered across:
1. Database (tables + relationships + seed data)
2. RBAC permissions ("claims") (DB `pages/actions/roleClaims/userClaims` + backend middleware + frontend UI gating)
3. Backend API (routes → controllers → repositories → models)
4. Angular frontend (routing, sidebar, list/add/details UI patterns, services, i18n)
5. Deployment wiring (Angular build served from `public/assets/angular/browser`, Laravel cache, cron realities)

A module is "organic" when it behaves like Documents: consistent routes, consistent claim gating, consistent list→menu actions→dialogs, and consistent DB patterns.

---

## 1) Platform mental model (must know before touching anything)

### 1.1 Application shape

*   Backend: **Laravel** serving:
    *   Angular SPA (catch-all route → Blade → loads Angular build from `public/assets/angular/browser`)
    *   JSON API under `/api/...` protected by JWT + claim middleware (`auth` + `hasToken:*`).
*   Frontend: **Angular SPA** that:
    *   attaches `Authorization: Bearer <token>` via a global HTTP interceptor and prefixes requests to `${environment.apiUrl}api/...`.

### 1.2 Permission system (non-negotiable)

DATAI has two separate security layers:

1. Claim gating (RBAC)
    *   Claims are computed at login by merging role claims + user claims into JWT payload.
    *   Backend routes require claims via `hasToken:CLAIM_A, CLAIM_B`.
    *   Frontend shows/hides UI using `*hasClaim="['CLAIM_X']"` and sidebar items have `claims: string[]`.
2. Row-level content ACL (for "My/Assigned" type listings)
    *   Documents taught us the real pattern: "assigned" content is determined by existence of permission rows in `documentUserPermissions` or `documentRolePermissions`, including time-bound rules (start/end dates).

Key rule: claims control what screens/actions you can access, while content ACL controls which records you can see (when you choose to implement "My/Assigned" behavior).

---

## 2) The official module "shape" (copy this structure)

### 2.1 Database layer

At minimum, a module usually has:
*   A primary table (e.g., `papers`, `tasks`, `assets`, etc.)
*   `createdBy`, `createdDate`, `modifiedBy`, `modifiedDate` style fields (match platform conventions)
*   UUID primary key (platform DB is UUID-heavy)

Optional but common "subsystems" (Documents uses most of these):
*   Metadata (tags / key-value pairs)
*   Permissions tables (user + role) with time-bound support
*   Audit trail table (Created/Modified/Deleted/Download/etc.)
*   Versioning table
*   Comment table
*   Workflow tables / logs
*   Shareable links / tokens
*   "Indexing" flags and indexer integration (if deep search applies)

### 2.2 RBAC "claims" layer (database-driven)

RBAC is backed by:
*   `pages`
*   `actions`
*   `roleClaims`
*   `userClaims`

&lt;watermark&gt;datai_system_architecture_v3&lt;/watermark&gt;

---


## Page 2

These produce claim strings like:

*   `MODULE_VIEW_*`
*   `MODULE_CREATE_*`
*   `MODULE_EDIT_*`
*   `MODULE_DELETE_*`
*   `MODULE_VIEW_DETAIL`
*   plus advanced action claims (e.g., `MODULE_SHARE`, `MODULE_START_WORKFLOW`, etc.)

## 2.3 Backend layer (Laravel)

Standard pattern:
*   `routes/api.php` entries protected by `auth` + `hasToken:...`
*   Controller: thin, orchestrates repository calls
*   Repository: implements list filtering, joins, pagination, permission gates (if any), and “subsystem” hooks (indexing, notifications, etc.)

## 2.4 Frontend layer (Angular)

Standard pattern:
*   An Angular feature module (e.g., `app/<module>/...`)
*   `<module>-routing.module.ts` that maps routes → components and uses `AuthGuard` plus route metadata for claims (where used)
*   A list component + datasource/service that calls `/api/...` and respects pagination headers (Documents uses `totalCount/pageSize/skip`).
*   Row action menu items are claim-gated and typically open dialogs/components that call specific endpoints.
*   Sidebar registration: edit `sidebar-items.ts` / `metadata` / component templates.
*   i18n: add translation keys in `public/assets/angular/browser/assets/i18n/*.json`.

---

## 3) The Golden Path (step-by-step) — adding a new module safely

### Step 1 — Define the permission surface (claims)

You must decide the claim set before writing endpoints, because the platform is built around claims as the contract.

Minimum recommended claim set (example naming):

*   `<MODULE>_VIEW_<MODULE>`
*   `<MODULE>_CREATE_<MODULE>`
*   `<MODULE>_EDIT_<MODULE>`
*   `<MODULE>_DELETE_<MODULE>`
*   `<MODULE>_VIEW_DETAIL`

Optional common claims (only if module needs it):

*   `<MODULE>_SHARE_<MODULE>` (permissions UI)
*   `<MODULE>_ADD_REMINDER
*   `<MODULE>_SEND_EMAIL
*   `<MODULE>_START_WORKFLOW
*   `<MODULE>_UPLOAD_NEW_VERSION
*   `<MODULE>_VIEW_VERSION_HISTORY
*   `<MODULE>_MANAGE_COMMENT
*   `<MODULE>_MANAGE_SHARABLE_LINK
*   `DEEP_SEARCH_ADD_INDEXING` / `DEEP_SEARCH_REMOVE_INDEXING` style (if reusing platform deep search behavior)

Rule: Claims are used in:

*   backend middleware `hasToken:*`
*   frontend `*hasClaim` and sidebar items `claims: []`

---

### Step 2 — Database schema (via migrations OR via phpMyAdmin SQL)

You said you’ll apply DB changes on the server via phpMyAdmin. That is fine, but you must keep it reproducible.

Required practice (non-optional for production stability):

*   Every DB change done in phpMyAdmin must be saved as a `.sql` patch file in your repo (or in your internal “patch log”), so you can re-apply it on another server later.

Schema design checklist:

*   ☐ UUID primary key
*   ☐ created/modified fields consistent with existing patterns
*   ☐ soft delete / archive strategy if needed

---


## Page 3

* ☐ indexes for list filters (status, category, createdDate, createdBy, etc.)
* ☐ if module has "My/Assigned": create `...UserPermissions` and `...RolePermissions` tables with:
    * `isTimeBound`, `startDate`, `endDate`, `isAllowDownload` (same semantics as Documents)

**Reusing existing tables (recommended when you want "organic integration"):**
If your new module should share platform-wide classification, prefer reusing:
* document categories
* document status
* clients
...instead of inventing parallel tables. (That's exactly the "organic integration" idea you want; Documents already uses these cross-cutting tables.)

---

## Step 3 — Register RBAC in DB (pages/actions/roleClaims/userClaims)
DATAI's RBAC is DB-driven: the claims exist because DB rows exist.

### What to add:
* `pages`: add a Page entry for the module (used by admin UI and to group actions)
* `actions`: add actions that map to each claim string
* `roleClaims`: attach those actions to roles that should have them by default
* `userClaims`: Only when granting special exceptions

### Verification step (critical):
After inserting actions/claims, re-login and confirm the JWT contains the new claim strings (because claims are computed at login and embedded into JWT).
dataai_system_architecture_v3

---

## Step 4 — Backend API (routes → controller → repository)
### 4.1 Routes
Add endpoints in `routes/api.php` with middleware:
* `auth` (JWT)
* `hasToken:...` (claims)

Minimum endpoints most modules need:
* `GET /<module>` list
* `GET /<module>/<id>` details
* `POST /<module>` create
* `PUT /<module>/<id>` update
* `DELETE /<module>/<id>` delete/archive

### 4.2 Repository responsibilities (what "production-grade" means here)
Documents taught the platform style:
* list endpoints support filters, ordering, pagination
* row menu actions are separate endpoints (share, versioning, workflow, indexing, etc.)
* "My/Assigned" list uses permission tables + time-bound validity logic

So your module repository should explicitly define:
* allowed sort keys
* allowed filters and how each maps to SQL
* whether list is "All" (claim-based) or "My/Assigned" (permission-based)

### 4.3 Audit trail discipline
In the existing platform behavior, some audit events are written by the frontend after success (e.g., "Created"). Don't assume server always writes audits automatically.
dataai_documents_forensics_repos...
So for new modules:
* decide where audit is written (backend vs frontend)
* standardize it (prefer backend if you want guaranteed logging)

---

## Step 5 — Angular frontend (module + routing + screens)
### 5.1 Create the Angular feature folder
Create a new feature area under `resources/frontend/angular/src/app/<module>/...` using the same structural patterns as existing modules (Documents is the best reference).

### 5.2 Routing
Add `<module>-routing.module.ts`:
* list route

---


## Page 4

*   add route
*   details route (either inside module or as standalone route like Documents does for `document-details/:id`)
Apply:
*   AuthGuard
*   route metadata claims (where the platform uses that pattern)

**5.3 Service + list data pattern**
Match the platform "list contract":
*   send query params from a Resource object
*   backend returns headers `totalCount`, `pageSize`, `skip` (Documents pattern)

**5.4 Action menu pattern**
Documents is the template:
*   per-row kebab menu
*   each menu item is claim-gated (`*hasClaim`)
*   handler usually opens a dialog component which calls a dedicated endpoint

If your module wants Documents-like richness, implement actions the same way (dialog per subsystem), rather than cramming everything into the list screen.

---

## Step 6 — Register module in the sidebar navigation

DATAI sidebar menu is defined centrally:
*   `resources/frontend/angular/src/app/layout/sidebar/sidebar-items.ts` (ROUTES array)
*   metadata + component render layer
*   gated via `*hasClaim` on each sidebar item's `claims` list

Checklist:
*   ☐ Add sidebar item with `path`, `title` (translation key), `icon`, `claims: ['<MODULE>_VIEW_<MODULE>']`
*   ☐ Add submenu items if needed (each can have its own claim list)

---

## Step 7 — i18n (languages)

Angular translations are loaded from:
`public/assets/angular/browser/assets/i18n/*.json`

Checklist:
*   ☐ Add new keys for menu title, buttons, errors, and page headings in all supported language JSON files (at least `en.json`, plus others as you maintain them).
*   ☐ Use translation keys consistently in HTML templates (match existing style).

---

## Step 8 — Theming / UI consistency

We won't guess styling frameworks beyond what's visible in the codebase, but the rule is simple:

**Do not introduce a new UI system.**

*   Reuse the platform's existing components/patterns (Documents is the model for forms, dialogs, menus, filtering toolbar, etc.).

This is how your new module will feel "native" and not bolted on.

---

## Step 9 — Deployment workflow (because you're editing live server + phpMyAdmin)

**Backend:**
*   After PHP changes, clear caches as needed (config/cache).
*   Confirm API routes are reachable and claims are enforced.

**Frontend:**
*   If you change Angular source, you must rebuild and deploy the build outputs consumed by Blade from:
    *   `public/assets/angular/browser/*`

**Database (phpMyAdmin):**
*   Apply SQL changes.
*   Save the same SQL into your patch log (repo folder or "DB patches" doc).

**Cron reality:**
Some platform capabilities depend on scheduled tasks (reminders, retention cleanup, log cleanup, etc.). You already noted cron is currently missing. Plan module features accordingly.

---


## Page 5

4) Two official listing styles you should choose from (and not mix by accident)

**Style A — “All” (admin/global list)**
* Access controlled primarily by **claims** (e.g., only roles with `<MODULE>_VIEW_<MODULE>` see the screen and can call the endpoint).
* Records returned may or may not apply row-level ACL depending on your module’s requirements.

**Style B — “My/Assigned” (permission-based list)**
* Records are returned only when there exists a user permission row OR role permission row, including time-bound validity rules (Documents pattern).
* This is the cleanest path for “My X” style pages.

5) Common production pitfalls (learned from Documents)

**5.1 Claim gating ≠ content ACL**
Even if the user can open the module screen (claim present), they may still need row-level ACL rules for “My/Assigned” experiences.

**5.2 Audit trails may be “client-written”**
Documents shows that at least some audits (e.g., Created) are written from Angular after API success. If the client call fails, audit can be missing. Treat audits explicitly in module design.

**5.3 Deep Search indexing isn’t “free”**
Documents indexing has real constraints:
* certain extensions only
* backend auto-index size threshold (~3MB)
So if your new module needs deep search, define:
* what content is indexable
* where the index is stored
* how indexing is toggled

**5.4 Cron-dependent features**
If cron isn’t configured, scheduled features won’t run reliably. Don’t ship a module that depends on cron without either (a) implementing cron now, or (b) designing a fallback.

6) Junior-dev “Definition of Done” checklist (module is truly production-ready)

**Security**
* ☐ Every API route has `auth` + correct `hasToken:*` claims
* ☐ Every UI action/menu item is gated with `*hasClaim` consistently
* ☐ If module has “My/Assigned”, row-level ACL uses time-bound permission semantics

**UX consistency**
* ☐ Sidebar entry exists with correct claim(s) and translation key
* ☐ List screen follows Resource → Service → API headers pagination pattern
* ☐ Complex actions use dialogs/subcomponents (don’t dump everything on one screen)

**DB correctness**
* ☐ Tables created with correct keys + indexes + references
* ☐ SQL patch saved (for reproducibility)
* ☐ RBAC rows inserted (pages/actions/roleClaims/userClaims) and verified via re-login claim payload

**Deployment**
* ☐ Angular build deployed to `public/assets/angular/browser/*` when source changes are made
* ☐ Laravel caches cleared as needed after route/config changes
* ☐ If module uses scheduled tasks, cron gap is addressed or documented

7) Practical “server-first” workflow (since you update code + DB on the live server)
This is the safest way to do what you described (direct server edits + phpMyAdmin):

---


## Page 6

1. **Before change**
    * export a DB structure backup (no data if you want light)
    * snapshot the code folder (zip) if possible
2. **DB change**
    * apply SQL in phpMyAdmin
    * immediately paste the same SQL into your "DB patches" log (date + purpose)
3. **Backend code change**
    * update routes/controller/repo/model
    * clear caches if needed
    * call endpoints manually to confirm claim enforcement
4. **Frontend**
    * update Angular source
    * rebuild and deploy build outputs to `public/assets/angular/browser`
    * verify sidebar visibility based on claims
5. **Role testing**
    * test at least 2 roles:
        * admin/global role
        * restricted role (should not see menu / should get 403 if forced)

---

8) **References (what to copy patterns from)**
    * Platform architecture / auth / sidebar / i18n / API interception: `datai_system_architecture_v3.md`
    * Real "content module" patterns (list, menu actions, add form, permissions/time-bound logic, indexing, audit behaviors): Documents forensics (`all_documents_main.md`, repository/addform analysis)