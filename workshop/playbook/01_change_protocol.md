# Safe Change Protocol

## Guardrails
1. Prefer smallest possible change set.
2. Reuse existing controller/repository/component patterns.
3. Keep claim checks consistent on both backend and frontend.
4. Avoid schema changes unless bug requires it and migration is reversible.

## Before-change checklist
- Identify exact user flow and API chain.
- Confirm permission claim path for route + UI action.
- Confirm model scopes (soft delete, `isDeleted`, etc.) that may alter query behavior.
- Confirm storage path implications for file features.

## After-change checklist
- Run backend tests/build checks and frontend build.
- Re-run smoke flow for changed screen/API.
- Document: reason, changed files, risk, rollback.

## PR slicing policy
- One logical bugfix/feature per PR.
- No broad refactors in same PR as behavior change.
- If uncertain, document flow first in `/workshop` and pause code changes.
