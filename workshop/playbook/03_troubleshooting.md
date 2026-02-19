# Troubleshooting Guide

## 401 loops after login
Check first:
- `config/auth.php` guard driver (`jwt`) and `JWT_SECRET` runtime value.
- Frontend token storage via `SecurityService` / `LicenseValidatorService`.
- `HttpRequestInterceptor` Authorization header injection.

## 403 permission denials
Check first:
- Route `hasToken:*` claim list in `routes/api.php`.
- JWT payload claims assembled in `AuthController@login/refresh`.
- Frontend route/action claim strings (`data.claimType`, `*hasClaim`).

## CORS/API URL mismatches
Check first:
- `environment.apiUrl` in Angular env files.
- global CORS middleware registration in Laravel kernel.
- reverse proxy path rules for `/api`.

## Missing/blank frontend after deploy
Check first:
- Angular files in `public/assets/angular-v4/browser`.
- `resources/views/angular.blade.php` copied from generated index.
- web server document root is Laravel `public/`.

## File open/download failures
Check first:
- Storage disk config (`config/filesystems.php`).
- `location` field for document records (`local`/`s3`).
- read permissions for `storage` and `bootstrap/cache`.

## Scheduler-dependent features not firing
Check first:
- cron entry running `php artisan schedule:run` every minute.
- commands listed in `app/Console/Kernel.php` for reminders/email/cleanup.
