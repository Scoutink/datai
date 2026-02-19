# Backend Authentication (JWT)

## Auth mechanism in use
- Guard: `api`.
- Driver: `jwt` (`php-open-source-saver/jwt-auth`), configured in `config/auth.php`.
- Token config in `config/jwt.php` (`JWT_SECRET`, TTL, refresh TTL, algo).

## Token issuance and refresh flow
1. `POST /api/auth/login` in `AuthController@login`.
2. Credentials validated via `Auth::attempt`.
3. Effective claims are assembled by merging:
   - role claims (`userRoles` → `roleClaims`), and
   - direct user claims (`userClaims`).
4. JWT is re-issued with custom payload claims (`claims`, `email`, `userId`, license/purchase values).
5. Response returns `authorisation.token` bearer token + user profile.

Refresh:
- `POST /api/auth/refresh` in `AuthController@refresh` recalculates claims and calls `Auth::claims(...)->refresh($token)`.

## Middleware and guards
- Protected API group uses `auth` middleware in `routes/api.php`.
- Fine-grained permission enforcement uses `hasToken:<CLAIMS...>` middleware.
- `HasToken` reads JWT payload claims and returns 403 when missing claim, 401 on token parse failure.

## Boards-specific auth
- Boards web routes use `boardsAuth` middleware.
- `BoardsAuth` accepts token from cookie or Bearer header, parses JWT, validates claims, and shares `authUser/authClaims` into Blade view context.

## No evidence of Sanctum/Passport runtime usage
- Sanctum package exists in dependencies, but active guard/middleware path is JWT-driven in current code execution path.
