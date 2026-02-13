# Boards Forensic Report

## 1) Scope and method
Inspected all backend/frontend files with `board` in filename plus board DB tables in authoritative SQL dumps.

Primary code surfaces:
- Backend API: `routes/api.php`, `app/Http/Controllers/BoardController.php`, `app/Http/Controllers/BoardMilestoneController.php`, `app/Repositories/Implementation/BoardRepository.php`, `app/Repositories/Implementation/BoardMilestoneRepository.php`.
- Backend web fallback: `routes/web.php`, `app/Http/Middleware/BoardsAuth.php`, `app/Http/Controllers/BoardsViewController.php`, `resources/views/boards/*`.
- Frontend SPA: `resources/frontend/angular/src/app/app-routing.module.ts`, `resources/frontend/angular/src/app/boards/*.ts`.
- DB schema: `structure/database/datai_light.sql`, `structure/database/datai_with_data.sql` (board* tables).

---

## 2) Board data model snapshot (authoritative)
Board subsystem tables in schema:
- `boards`, `boardColumns`, `boardCards`
- `boardLabels`, `boardTags`
- `boardCardLabels`, `boardCardTags`, `boardCardFollowers`, `boardCardAssignees`, `boardCardAttachments`
- `boardCardActivities`, `boardCardChecklists`, `boardCardChecklistItems`
- `boardMilestones`, `boardCardMilestones`

Important detail: `boardMilestones` and `boardCardMilestones` are present in SQL dump, but there are **no Laravel migrations** for boards in `database/migrations`.

---

## 3) Reported issue #1 — `GET /api/boards/{id}/milestones` returns 500

### 3.1 Exact call path
- Angular board detail loads milestones via:
  - `resources/frontend/angular/src/app/boards/board-detail.component.ts`
  - `resources/frontend/angular/src/app/boards/card-detail-modal/card-detail-modal.component.ts`
- API route is in `routes/api.php` under `hasToken:BOARDS_MANAGE_CARDS`:
  - `GET /boards/{boardId}/milestones` -> `BoardMilestoneController@index`
- Controller delegates to repository:
  - `BoardMilestoneRepository@getBoardMilestones($boardId)`
- Repository query:
  - `BoardMilestone::where('boardId', $boardId)->withCount(['cards', 'cards as completed_cards_count' => ...])->get()`

### 3.2 Forensic failure candidates (ranked)
1. **Most likely in real environments:** DB drift/missing table or missing columns for milestone feature.
   - Why: repo has board milestone code/routes, but no migrations for boards.
   - Effect: query throws SQL exception -> 500.
2. Claim mismatch is **not** likely for this symptom.
   - Missing claim should return 403 (HasToken middleware), not 500.
3. Runtime ORM query error due schema mismatch.
   - Example: if `isCompleted` absent in `boardCards` in target env, `withCount` closure fails.

### 3.3 Confidence
- High confidence on “schema drift risk”.
- **UNVERIFIED** exact production SQL error text (no server log provided in task).

---

## 4) Reported issue #2 — refresh on Boards logs user out

### 4.1 Root cause (code-proven)
Boards has **dual routing stacks**:
1. Angular SPA routes (`/boards`, `/boards/:id`) in `app-routing.module.ts`.
2. Laravel web routes with same URL prefix in `routes/web.php`, mapped to Blade (`BoardsViewController`) and guarded by `boardsAuth` middleware.

On browser refresh at `/boards/:id`, request is handled server-side by Laravel web route (not Angular router in browser memory). Then `BoardsAuth` attempts token from cookie `token` or Authorization header:
- `BoardsAuth.php`: `$request->cookie('token') ?? $request->bearerToken()`

But Angular auth state is stored through `LicenseValidatorService` (browser storage), and normal refresh navigation does not send Authorization header; cookie token is often absent. Middleware redirects `/login`.

### 4.2 Additional blocker in fallback path
Even if token existed, `BoardsViewController` uses wrong DB column names (`is_deleted`, `created_date`, `list_order`, `card_order`) inconsistent with schema (`isDeleted`, `createdDate`, `position`) and uses wrong claim strings (`BOARDS_EDIT_BOARDS`, `BOARDS_DELETE_BOARDS` instead of singular `..._BOARD`). This indicates the Blade board path is stale/incompatible.

### 4.3 Confidence
- High confidence for refresh-logout root cause.

---

## 5) Broader integration gaps (why Boards feels non-organic)
1. **No migration coverage** for board tables -> deployment fragility.
2. **Duplicate UI implementation**: Angular boards + Blade boards for same URLs.
3. **Inconsistent contract pattern** vs Documents module:
   - board list headers only set `totalCount` (no `pageSize/skip` parity).
4. **No audit trail integration** for board mutations.
5. **No explicit runbook** for seeding board claims/page/actions in seeders.
6. **Claim consistency risk** between route middleware strings and stale Blade claim checks.

---

## 6) Immediate verification commands (ops)
1. Verify milestone tables exist in target DB.
2. Verify `boardCards.isCompleted` exists.
3. Check server log for `/api/boards/{id}/milestones` SQL exception.
4. Check whether cookie named `token` is set for board web routes.

(Exact SQL/ops commands are listed in remediation plan.)
