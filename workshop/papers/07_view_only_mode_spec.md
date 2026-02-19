# Papers View-Only Mode Specification

## UX behavior
- “View” action opens paper detail content in strict read-only mode.
- No UI affordance inside view page should switch to editable canvas.
- Keep explicit **Edit** button (claim-gated) for authorized users to move to `/papers/manage/:id`.

## Permission logic
- View-only access requires papers view claim (`ALL_PAPERS_VIEW_PAPERS` path in current routing).
- Edit remains separately protected by edit claims (`ALL_PAPERS_EDIT_PAPER` / `MY_PAPERS_EDIT_PAPER`).

## Technical toggle design
- Add query flag from action menu: `viewPaper(row)` -> `/papers/:id?mode=view&tab=content`.
- Detail component computes `isViewOnlyMode` from query param (default true for safety in detail content tab).
- Pass mode down to preview/editor components; preview must render only read-only editor path.

## Data safety requirements
- In view-only mode:
  - no save API calls,
  - no autosave timers,
  - no persistence mutation endpoints.
- The component should mount read-only editor only (`readOnly=true`, `isPreview=true`) and never mount editable LIVE container.

## State storage
- View-only state is client-side only via route query params and component state.
- No DB persistence required for mode state.

## Acceptance criteria
1. View action opens read-only paper.
2. Toolbar cannot switch to editable mode.
3. Network tab shows no `POST/PUT /api/papers*` from content viewing.
4. Edit requires explicit button and navigates to manage route.
