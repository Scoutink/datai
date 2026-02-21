# P2: Stability Recovery Plan (Round 2)

Fix persistent initialization and data flow issues in the Papers module.

## User Review Required
> [!IMPORTANT]
> This fix changes the initialization sequence of the UniverJS editor. While this should be more stable, it might cause a slightly longer loading delay (50-100ms) before the editor is visible.

## Proposed Changes

### [UnifiedEditor Component]
- **Robust Init (P2-002-V2):** 
    - Use a polling mechanism for container dimensions (`offsetWidth > 0`).
    - Use `setTimeout` instead of `requestAnimationFrame` for more reliable cross-browser/cross-routing layout stability.
    - REORDER plugin registration: Network -> RenderEngine -> UI (with container) -> Features.
- **EmptyError Fix (P2-004):**
    - Wrap `lastValueFrom` in `overrideImageUpload` with `defaultIfEmpty(null)` to prevent RxJS `EmptyError`.
- **Data Load Logging (P2-003):** 
    - Add console logging for `initialData` to verify what the editor is actually receiving.

### [PaperManage Component]
- **Defensive Parsing:** Ensure `editorData` is initialized with a skeletal snapshot if `contentJson` is empty, avoiding "Blank Sheet" on first save.

## Verification Plan

### Automated Tests
- N/A (UI-centric, requires browser)

### Manual Verification
1. **Init Check:** Open "Add Paper". Verify no 'go' error in console.
2. **Doc Load:** Open an existing Doc. Verify text is visible and no `EmptyError`.
3. **Sheet Save/Load:** 
    - Open "Add Paper" (Sheet). 
    - Type "DATA" in A1. 
    - Save. 
    - Navigate back and Edit. 
    - **Verify A1 still contains "DATA".**
4. **Image Upload (Simulated):** Paste an image. Verify no `EmptyError` even if upload fails (it should log a 404 or warning instead of crashing).
