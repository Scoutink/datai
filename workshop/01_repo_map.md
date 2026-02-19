# Repository Map (code-derived)

## Top-level functional map
- `app/`: Laravel application logic (controllers, middleware, models, repositories, services, providers).
- `routes/`: HTTP/API route entry points.
- `config/`: runtime config for auth, queue, storage, broadcasting, etc.
- `database/migrations/`: schema evolution and table definitions.
- `resources/frontend/angular/`: Angular source code, routing, services, components.
- `resources/views/`: Blade templates; Angular shell is rendered from `angular.blade.php`.
- `public/`: web root. Compiled Angular assets are served from `public/assets/angular-v4/browser`.
- `.github/workflows/`: CI/CD workflows (added in this workshop branch).
- `workshop/`: fresh architecture and operations documentation produced from code inspection.

## Backend and frontend locations
- Backend: Laravel in root-level structure (`app`, `routes`, `config`, `database`).
- Frontend: Angular app in `resources/frontend/angular`.

## Production frontend output path (current pattern)
- Angular production build outputs to `../../../public/assets/angular-v4` from Angular project root via `angular.json` production `outputPath`.
- Angular build process expects copying `public/assets/angular-v4/browser/index.html` into `resources/views/angular.blade.php` (existing `package.json` build script behavior).

## Entry route behavior
- API traffic under `/api/*` handled by `routes/api.php`.
- Non-API routes resolve to Angular shell via catch-all route in `routes/web.php`, excluding install/update/boards/test prefixes.
- Boards has separate Blade/web route group under `/boards` with dedicated middleware.
