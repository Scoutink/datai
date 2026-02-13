# Boards Remediation Plan (Fixes)

## Priority 0 — Stop refresh logout

### Fix option A (recommended): SPA-only boards URLs
- Remove/retire `routes/web.php` boards prefix routes for `/boards*`.
- Let Angular catch-all handle `/boards` and `/boards/:id` consistently.
- If Blade must stay, move it under a distinct path (`/boards-legacy/*`) to avoid URL collision.

### Fix option B: keep Blade boards, align auth transport
- Ensure login writes JWT to secure cookie `token` expected by `BoardsAuth`.
- Keep cookie and bearer token lifecycle synchronized.
- Still required: update stale `BoardsViewController` column + claim names.

## Priority 1 — Fix milestones 500 deterministically
1. Create official Laravel migrations for all board tables (including milestones/pivot) with constraints/indexes matching `datai_light.sql`.
2. Add startup/schema health check command for board feature prerequisites.
3. Harden milestone endpoint:
   - catch DB exceptions and return structured error,
   - include correlation id in logs.
4. Validate all target environments with:
   - `SHOW TABLES LIKE 'boardMilestones';`
   - `SHOW TABLES LIKE 'boardCardMilestones';`
   - `SHOW COLUMNS FROM boardCards LIKE 'isCompleted';`

## Priority 2 — Make Boards follow platform module standards
1. RBAC standardization
- Confirm `pages/actions/roleClaims/userClaims` seeding includes all BOARDS_* claims in seeders (not only ad-hoc SQL).

2. API contract consistency
- Board list response should include pagination headers parity with document lists (`totalCount`, `pageSize`, `skip`).

3. Audit discipline
- Add board audit trail model/table or integrate with existing audit strategy for create/update/delete/archive/move/comment/assignment operations.

4. Error handling quality
- Replace generic toastr-only errors with contextual messages and backend error payload handling.

## Priority 3 — Remove stale/incorrect board web code
- `BoardsViewController` currently uses incompatible column naming and mismatched claim codes; either:
  - fully modernize to current schema/claims, or
  - delete if SPA-only strategy is adopted.

## Recommended execution order
1. Routing decision (SPA-only vs dual-stack).
2. Migrations for board schema.
3. Milestone endpoint validation and guardrails.
4. RBAC seeder normalization.
5. Audit + pagination contract parity.
6. Cleanup stale Blade boards stack.

## Concrete verification checklist
- `GET /api/boards` works with expected headers and claims.
- `GET /api/boards/{id}` works.
- `GET /api/boards/{id}/milestones` returns 200 and counts.
- Refresh `/boards/{id}` does not redirect to login.
- Card modal can load/update milestones without console 500.
