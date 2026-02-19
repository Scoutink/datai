# Testing Protocol

## Existing executable checks
- Backend unit/feature tests via PHPUnit (`php artisan test` or `vendor/bin/phpunit`) if dependencies installed.
- Frontend production build via Angular CLI from `resources/frontend/angular`.

## Recommended CI/local commands
1. `composer install --no-interaction`
2. `php artisan test`
3. `cd resources/frontend/angular && npm ci && npm run build`

## If test suite coverage is limited
Use a repeatable smoke checklist:
1. Login succeeds and dashboard/home loads.
2. Document list loads and can open viewer.
3. Share link generation works and public preview validates expiry/password.
4. Reminder creation and reminder list retrieval work.
5. Workflow start + transition action works for a document.
6. AI summary/generation endpoints return expected responses when API keys are configured.

## CI expectation for deployment artifact
- Build job must complete composer prod install + Angular prod build.
- Zip artifact must contain built frontend assets and Laravel runtime files required for deployment.
