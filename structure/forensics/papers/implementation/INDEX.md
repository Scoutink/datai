# Papers Implementation Package (Server Apply)

## 1) DB Queries to run in phpMyAdmin
- `01_phpmyadmin_patch.sql`

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
- `files/database/seeders/DatabaseSeeder.php` -> `database/seeders/DatabaseSeeder.php`
- `files/routes/api.php` -> `routes/api.php`

## 3) Apply order
1. Backup DB and code.
2. Run `01_phpmyadmin_patch.sql`.
3. Replace files above.
4. Clear Laravel cache (`php artisan optimize:clear`).
5. Re-login to refresh JWT claims.
