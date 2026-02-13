# Runbook: Build & Deploy

## Backend
1. `composer install`
2. `cp .env.example .env` (if fresh)
3. `php artisan key:generate`
4. Configure DB/JWT/storage/env secrets.
5. `php artisan migrate --force` (if migrations are source of truth in env)
6. `php artisan optimize:clear`

## Frontend
1. `cd resources/frontend/angular`
2. `npm install`
3. `npm run build -- --configuration production`

## Angular build output placement
- Production output is configured to `public/assets/angular` with browser files under `/assets/angular/browser/`.

## Cache/pitfalls
- Clear after config/env changes: `php artisan optimize:clear`.
- If auth claim changes are made, force re-login or token refresh.

## Permissions
- Ensure write access for `storage/`, `bootstrap/cache/`, and runtime upload folders under storage.
- Ensure S3 env variables are complete if `location=s3` is enabled.
