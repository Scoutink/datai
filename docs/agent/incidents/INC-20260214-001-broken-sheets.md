# INC-20260214-001: Failed "Gold Standard" Sheets Sandbox

## Timeline
- **2026-02-14 11:40**: Initial Sandbox (v1) deployed. Failed due to v4 scripts loading with v5 code.
- **2026-02-14 12:00**: Sandbox v2 (Power Sandbox) deployed. User reported `#ERROR` in formulas and "locked" interactive handles.
- **2026-02-14 12:45**: User feedback received. Forensic audit initiated.

## Root Causes
1. **Data Type Conflict**: Jspreadsheet v5 CE formula engine is strictly numeric. Passing strings with currency symbols caused `#ERROR`.
2. **Handle Locking (CSS Layout)**: The `grid-wrapper` container used `overflow: hidden` which clipped the JSS resizer markers (which often extend beyond the table boundary).
3. **API Drift**: I incorrectly used `getSelectedCells()` and `getColumnNameFromId()`, which are **deprecated/removed** in V5. The correct methods are `instance.getSelected()` and `jspreadsheet.helpers.getCellNameFromCoords()`.
4. **Toolbar Integration**: Specific toolbar methods like `setStyle` were passed invalid selection objects due to the API drift above.

## Contributing Factors
- **Documentation Mismatch**: Relying on mixed v4/v5 search results without strictly isolated v5 API validation.
- **Verification Gap**: Failure to verify the "frame" handles on a real browser (due to current browser tool limitations).

## Action Items
- [ ] Implement `instance.getSelected()` globally in the sandbox.
- [ ] Use `getCellNameFromCoords` for all coordinate-to-name translations.
- [ ] Expand grid container CSS to `overflow: visible` for handles.
- [ ] Implement `allowDeleteColumn: true` and verify all row/column management buttons.
