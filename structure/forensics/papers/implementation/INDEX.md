# Papers Implementation Package (Server Apply)

## 1) DB Queries to run in phpMyAdmin
- `01_phpmyadmin_patch.sql`
- `02_permissions_repair.sql` (run this if Papers shows only partial permissions, e.g. no Create action)

## 2) Files to replace in server codebase
- `files/app/Http/Controllers/PaperController.php` -> `app/Http/Controllers/PaperController.php`
- `files/app/Models/Papers.php` -> `app/Models/Papers.php`
- `files/app/Models/PaperComments.php` -> `app/Models/PaperComments.php`
- `files/app/Models/PaperVersions.php` -> `app/Models/PaperVersions.php`
- `files/app/Models/PaperRolePermissions.php` -> `app/Models/PaperRolePermissions.php`
- `files/app/Models/PaperUserPermissions.php` -> `app/Models/PaperUserPermissions.php`
- `files/app/Models/PaperShareableLink.php` -> `app/Models/PaperShareableLink.php`
- `files/app/Models/PaperAuditTrails.php` -> `app/Models/PaperAuditTrails.php`
- `files/app/Models/PaperMetaDatas.php` -> `app/Models/PaperMetaDatas.php`
- `files/app/Repositories/Contracts/PaperRepositoryInterface.php` -> `app/Repositories/Contracts/PaperRepositoryInterface.php`
- `files/app/Repositories/Implementation/PaperRepository.php` -> `app/Repositories/Implementation/PaperRepository.php`
- `files/app/Providers/RepositoryServiceProvider.php` -> `app/Providers/RepositoryServiceProvider.php`
- `files/database/migrations/2026_02_13_000002_create_papers_tables.php` -> `database/migrations/2026_02_13_000002_create_papers_tables.php`
- `files/database/seeders/PermissionSeederV55.php` -> `database/seeders/PermissionSeederV55.php`
- `files/database/seeders/PermissionSeederV56.php` -> `database/seeders/PermissionSeederV56.php`
- `files/database/seeders/DatabaseSeeder.php` -> `database/seeders/DatabaseSeeder.php`
- `files/routes/api.php` -> `routes/api.php`
- `files/resources/frontend/angular/src/app/app-routing.module.ts` -> `resources/frontend/angular/src/app/app-routing.module.ts`
- `files/resources/frontend/angular/src/app/layout/sidebar/sidebar-items.ts` -> `resources/frontend/angular/src/app/layout/sidebar/sidebar-items.ts`
- `files/resources/frontend/angular/src/app/papers/papers.service.ts` -> `resources/frontend/angular/src/app/papers/papers.service.ts`
- `files/resources/frontend/angular/src/app/papers/papers-list.component.ts` -> `resources/frontend/angular/src/app/papers/papers-list.component.ts`
- `files/resources/frontend/angular/src/app/papers/papers-list.component.html` -> `resources/frontend/angular/src/app/papers/papers-list.component.html`
- `files/resources/frontend/angular/src/app/papers/assigned-papers-list.component.ts` -> `resources/frontend/angular/src/app/papers/assigned-papers-list.component.ts`
- `files/resources/frontend/angular/src/app/papers/assigned-papers-list.component.html` -> `resources/frontend/angular/src/app/papers/assigned-papers-list.component.html`
- `files/resources/frontend/angular/src/app/papers/paper-create.component.ts` -> `resources/frontend/angular/src/app/papers/paper-create.component.ts`
- `files/resources/frontend/angular/src/app/papers/paper-create.component.html` -> `resources/frontend/angular/src/app/papers/paper-create.component.html`

## 3) Apply order
1. Backup DB and code.
2. Run `01_phpmyadmin_patch.sql`.
3. If Papers permissions are incomplete (no Create), run `02_permissions_repair.sql`.
4. Replace files above.
5. Clear Laravel cache (`php artisan optimize:clear`).
6. Re-login to refresh JWT claims.
