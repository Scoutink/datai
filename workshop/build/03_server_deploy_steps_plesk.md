# Plesk Deployment Steps (ZIP artifact)

## Upload and extract
1. In Plesk File Manager, open target app directory.
2. Upload downloaded deployment ZIP.
3. Extract ZIP into release directory.
4. Point domain document root to `public/` inside extracted release.

## Required permissions
Ensure write permission for web user on:
- `storage/`
- `bootstrap/cache/`

## Minimal runtime commands (only if needed)
Run in app root:
1. `php artisan migrate --force` (only when deployment includes migrations)
2. `php artisan optimize:clear`

## Success indicators
- `/login` loads Angular app correctly.
- API calls return 200/401 as expected (not 500).
- Document list and preview open normally.
- No permission errors writing to `storage/logs`.
