## Pre-Flight Report: P2-002 (Fix UnifiedEditor 'go' ID Initialization)

### Current Implementation Analysis
- **File:** `src/app/shared/unified-editor/unified-editor.component.ts`
- **Method:** `initEditor` (Lines 132-263) called by `ngAfterViewInit` via `requestAnimationFrame`.
- **Logic:**
    - `const container = this.editorContainer.nativeElement;`
    - `new Univer({ ... })`
    - `univer.registerPlugin(UniverUIPlugin, { container: container, ... })`
- **Error:** `dependency item(s) for id 'go' but get 0`.
- **Cause:** This error in Univer usually means the Rendering Engine cannot find the DOM container or the context required to initialize the Canvas (often referred to internally as 'go' or related to the GoJS-like canvas engine Univer uses).
- **Subtle Race Condition:** `ngAfterViewInit` guarantees the component view is initialized, but if the `div` is hidden via `*ngIf="isLoading"`, it might not be in the DOM when Univer tries to measure it.
- **Critical Flaw:** The template has:
```html
<div *ngIf="isLoading" class="editor-loader">...</div>
<div #editorContainer class="editor-mount-point" [class.hidden]="isLoading"></div>
```
The `editorContainer` is **always present** (checked `[class.hidden]`, not `*ngIf`), so `nativeElement` should exist.
However, if `isLoading` is true, it has `display: none` (via `hidden` class).
Canvas engines often fail to initialize if the container has `width: 0` or `display: none`.

### Impact Trace
- **Direct Impacts:** `initEditor` method and Template.
- **Change:**
    - Ensure `isLoading = false` (or at least the container is visible) *before* `new Univer()`?
    - OR use `visibility: hidden` instead of `display: none` so it has dimensions?
    - OR, strictly wait for dimensions?
- **Hypothesis:** Univer tries to measure the container. If `display: none`, dimensions are 0x0.
- **Fix:** Remove `[class.hidden]="isLoading"` or change CSS to `visibility: hidden`.
- **Refinement:** The `isLoading` flag is set to `false` at the *end* of `initEditor`. So during `initEditor`, the container IS hidden (`display: none`).

### Strategy
1.  **CSS Change:** Change `.editor-mount-point.hidden` to `visibility: hidden; position: absolute;` so it takes space or at least exists in layout, OR just remove the hiding class before init.
2.  **Logic Change:** In `initEditor`, verify container has dimensions.

### Implementation Plan
```typescript
    private initEditor() {
        if (this.univer) return;

        // Force container to be visible for initialization measuring
        const container = this.editorContainer.nativeElement;
        
        // Fix: If container is hidden via display:none, Univer Render fails ('go' error).
        // We must ensure it's visible. 
        // We can manually remove the class, or change the logic.
        // Better: Don't hide the container with display:none. Use z-index to show loader on top.
    }
```
**Decision:** Modify `unified-editor.component.ts` styles to remove `display: none` from `.hidden` and use `z-index` for loader.

### Test Scenarios
1.  **Load Editor:** `new Univer` is called while Loader is visible.
2.  **Validation:** Container has `width > 0` during init. No 'go' error.

### Revised Template/Styles
```scss
        .unified-editor-container {
            position: relative; // Loader needs absolute
        }
        .editor-mount-point {
            // Always display, just cover with loader
            width: 100% !important;
            height: 100% !important;
            display: block; 
        }
        .editor-loader {
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%; // Cover everything
            background: white;
            z-index: 10; // On top of editor
        }
```
Implementation: I will remove `[class.hidden]="isLoading"` from the HTML and rely on `z-index` of the loader.

### Implementation Steps
1.  Edit `unified-editor.component.ts` template: Remove `[class.hidden]="isLoading"`.
2.  Verify `editor-loader` has background so it hides the initializing canvas.
