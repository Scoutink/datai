# Univer Editors Integration (pattern map)

## Integration location
- Core integration is centralized in `resources/frontend/angular/src/app/shared/unified-editor/unified-editor.component.ts`.
- Shared module exports this component for reuse.

## Technical pattern
- Initializes `Univer` instance lazily after view init.
- Registers core plugins (network/render/formula/ui/docs/sheets/drawing/hyperlink plugin stack).
- Supports two modes:
  - `DOC` (`UniverInstanceType.UNIVER_DOC`)
  - `SHEET` (`UniverInstanceType.UNIVER_SHEET`)
- Uses a lighter viewer fallback path in component template for stability/read-only scenarios.

## Event/data bridge pattern
- Accepts `initialData` snapshot input.
- Produces persisted data via `getData()` method by querying current Univer unit snapshot.
- Wraps lifecycle cleanup with `disposeUniver()` to prevent stale editor instances.

## Media persistence bridge
- Overrides Univer image upload through injector-based `IImageIoService` interception.
- Upload path delegates to backend API for binary persistence and returns URLs to editor runtime.

## Scope/exclusion note
- Papers module itself is explicitly excluded from workshop behavior documentation.
- This document captures shared Univer integration patterns only (component architecture and plugin/lifecycle approach) so the same pattern can be safely reused in other working areas.
