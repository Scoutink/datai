# Developer Cookbook: Category Tree & Stability Guards

This document## Stability Guards & Standards

### 1. Authentication (Backend)
- **Standard**: ALWAYS use `Auth::id()` instead of `Auth::parseToken()`.
- **Rationale**: `parseToken()` is unstable when called multiple times in a single request or when the session/token context is slightly shifted. `Auth::id()` is robust and globally available after authentication.
- **Scope**: Repositories, Models, and Controllers.

### 2. Deep Category Filtering
- **Standard**: Use `hierarchyPath LIKE 'parent/path/%'` for recursive filtering.
- **Fallback**: ALWAYS provide a fallback to `documents.categoryId` if `hierarchyPath` is null to ensure stability for legacy records or unfinished migrations.
```php
if ($categoryPath) {
    $query = $query->where('categories.hierarchyPath', 'LIKE', $categoryPath . '%');
} else {
    $query = $query->where('documents.categoryId', $categoryId);
}
```

### 3. Frontend Race Conditions
- **Standard**: Initialize Reactive Forms (`this.fb.group`) as the FIRST step in `ngOnInit`.
- **Rationale**: Subscriptions and child component inputs often rely on the form existence. Late initialization causes `TypeError: Cannot read properties of undefined (reading 'get')`.

### 4. Signal Store Reactivity
- **Standard**: Use `toObservable(store.signal)` from `@angular/core/rxjs-interop` to react to state changes.
- **Avoid**: Never use `setTimeout` or manual polling to wait for signal updates.
- **Component**: `app-category-tree-picker`.
- **Logic**: Uses `mat-tree` for recursive rendering. Supports `ControlValueAccessor` for seamless integration with Reactive Forms.

---


### Authentication Stability
> [!IMPORTANT]
> **NEVER use `Auth::parseToken()`** for internal user ID retrieval. It is unstable and prone to failure if the token payload structure slightly differs or if called in a context where only session/id is available.

**Best Practice**:
- Always use `Auth::id()` to get the current user's ID.
- Always use `Auth::user()` to get the user model if more data is needed.

### Repository Pattern
- All business logic must reside in Repositories.
- Controllers should only handle request validation and response formatting.

---

## 🛠️ Development Stream

### REC-20250616-01: Category Tree Integration
- **Objective**: Standardize 10-level hierarchy across all document modules.
- **Action**: replaced `ng-select` with `app-category-tree-picker` in 7+ components.
- **Outcome**: 🟢 DONE

### REC-20250616-02: Platform Stability Refactor
- **Objective**: Resolve 500 error and prevent recurrence.
- **Action**: Systematic replacement of `Auth::parseToken()` with `Auth::id()`.
- **Outcome**: 🟢 DONE
