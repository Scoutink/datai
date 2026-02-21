# 🧪 Standard Workflow: Content Type Sandbox Testing

To ensure "10x Engineering" quality and prevent regressions, all new content types (Sheets, Whiteboards, etc.) must follow this **Sandbox-to-Platform** protocol.

## 1. Sandbox Phase (Isolation)
- **Location**: `datai/tests/sandbox/`
- **Objective**: Perfect the UI/UX, library-specific logic, and data structures in a 100% isolated HTML/JS environment.
- **Rule**: Must use the **exact** library versions defined in `package.json`.
- **Deliverable**: A single `index.html` (or folder) that demonstrates:
    - Initialization (Blank state)
    - Data rendering (Load state)
    - Event emission (Change capture)
    - Styling (Branding compliance)

## 2. Forensic Bridge (Mapping)
- Map the Sandbox logic to the Angular Component.
- Map the Sandbox data structure to the Laravel Model/Schema.
- Document any API-specific adjustments (e.g., UUID mapping).

## 3. Integration Phase (Platform)
- Move refined code to `resources/frontend/angular`.
- Move data handlers to Laravel Repositories.
- **Verification**: Run the Platform UI against the Sandbox "Gold Standard" to ensure zero visual or functional drift.

## 4. Quality Gate
- [ ] Sandbox verification pass.
- [ ] Angular build pass.
- [ ] Cross-browser styling check.
- [ ] Atomic persistence validation.
