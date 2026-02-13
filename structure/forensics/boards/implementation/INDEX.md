# Boards Implementation Package (Server Apply Pack)

Use this folder to apply the boards fix directly on your running server instance.

## 1) SQL to run in phpMyAdmin
- `01_phpmyadmin_patch.sql`
  - Creates/repairs milestone tables (`boardMilestones`, `boardCardMilestones`)
  - Adds/updates Boards RBAC page/actions
  - Adds missing `BOARDS_*` claims to Admin role

## 2) Files to replace in server codebase
These are copied snapshots of the exact changed files.

- `files/app/Http/Controllers/BoardController.php`
  - target: `app/Http/Controllers/BoardController.php`
- `files/app/Http/Controllers/BoardMilestoneController.php`
  - target: `app/Http/Controllers/BoardMilestoneController.php`
- `files/app/Repositories/Implementation/BoardRepository.php`
  - target: `app/Repositories/Implementation/BoardRepository.php`
- `files/database/migrations/2026_02_13_000001_create_board_milestones_tables.php`
  - target: `database/migrations/2026_02_13_000001_create_board_milestones_tables.php`
- `files/database/seeders/DatabaseSeeder.php`
  - target: `database/seeders/DatabaseSeeder.php`
- `files/database/seeders/PermissionSeederV54.php`
  - target: `database/seeders/PermissionSeederV54.php`
- `files/routes/api.php`
  - target: `routes/api.php`
- `files/routes/web.php`
  - target: `routes/web.php`

## 3) Quick apply order on server
1. Backup DB and code.
2. Run SQL patch: `01_phpmyadmin_patch.sql`.
3. Replace files listed above in target paths.
4. Clear Laravel caches:
   - `php artisan optimize:clear`
5. Re-login and test:
   - `/boards`
   - `/boards/{id}` refresh behavior
   - milestone load in board details/card modal

## 4) Rebuild requirement
No Angular rebuild is required for this package (backend + DB only).
