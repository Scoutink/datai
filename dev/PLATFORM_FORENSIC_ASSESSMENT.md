# DATAI PLATFORM FORENSIC ASSESSMENT

> **Objective**: Identify the source-of-truth standards for module integration.

## 🏗️ Architectural Standards

### 1. Database Layer (The "Truth")
The platform strictly follows a Two-Tier permission system.

| Table | Purpose | Key Columns | Audit Fields? |
| :--- | :--- | :--- | :--- |
| `pages` | Module Registry | `id`, `name`, `order` | Yes |
| `actions` | Permission Registry | `id`, `name`, `pageId`, `code` | Yes |
| `roleClaims` | Permission Mapping | `id`, `roleId`, `actionId`, `claimType` | **NO** |
| `userClaims` | Direct Permissions | `id`, `userId`, `actionId`, `claimType` | **NO** |

**Claim Mapping Rule**: The `claimType` in the claims tables MUST match the `code` in the `actions` table.

### 2. Backend Layer (Laravel)
- **Models**: Must use `App\Traits\Uuids`. `boot()` must handle `createdBy`/`modifiedBy` using `Auth::parseToken()`.
- **Repositories**: Contract-based. Must be bound in `app/Providers/RepositoryServiceProvider.php`.

### 3. Frontend Layer (Angular)
- **Routing**: Requires `claimType` in `data` object for `AuthGuard`.
- **Sidebar**: Entries in `sidebar-items.ts` must include a `claims` array matching the `action.code`.

---

## 🚨 Boards Module Remediations
1. **Schema Fix**: `roleClaims` inserts must not include audit fields.
2. **UUID fix**: Corrected `getKeyType()` to return `'string'` in `Uuids.php`.
