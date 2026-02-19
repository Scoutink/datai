## Pre-Flight Report: P2-001 (Fix UnifiedEditor DI Conflict)

### Current Implementation Analysis
- **File:** `src/app/shared/unified-editor/unified-editor.component.ts`
- **Method:** `overrideImageUpload` (Lines 302-333)
- **Current Logic:** `injector.add([IImageIoService, { useValue: platformImageIoService }]);`
- **Error:** `dependency item(s) for id "core.image-io.service" but get 2`.
- **Cause:** Univer Core plugins (likely `UniverDocsUIPlugin` or `UniverSheetsUIPlugin`) already register a default `IImageIoService`. Adding another without checking or using an override flag causes ambiguity in the DI container.

### Impact Trace
- **Direct Impacts:** `overrideImageUpload` method.
- **Change:**
    - Check if `IImageIoService` exists.
    - If yes, likely need to use a different method to *replace* it, or the `add` method might support an override option (Univer DI specific).
    - Alternatively, simpler fix: `injector.delete(IImageIoService)` before adding (if supported), or just don't add if it exists (but then we lose custom upload).
    - **Better Approach:** Univer DI usually handles overrides if we register at the right time or use a specific API. However, the error "get 2" strongly implies duplicate registration.

### Strategy
Univer's DI system is Redi-based.
If we want to *replace* a service, we should ideally register it *before* the plugins if possible, OR use a mechanism to swap it.
However, since we register plugins first, they populate the DI.
Method 1: `injector.get(IImageIoService)` -> if exists, we might need to modify it? No, services are singletons.
Method 2 (Safe):
```typescript
if (injector.has(IImageIoService)) {
    // We cannot easily 'remove' from a finalized injector in some frameworks.
    // But Univer might allow us to just NOT register and let the default handle it?
    // No, we NEED custom upload.
}
```
**Refined Strategy:**
The error "get 2" happens when `injector.get()` is called and finds multiple.
We should try to *dispose* the existing one or look for a `replace` method.
Looking at Univer docs (mental check): `injector.add` usually appends.
Hack/Fix:
```typescript
const injector = univer.__getInjector();
// Try to remove previous if possible, or use 'override' logic if Univer exposes it.
// Since we lack deep Univer DI docs, we will try to safe-guard.
// Actually, the error comes from Univer internals trying to resolve a single service but finding two.
```
**Proposed Fix:**
Use `injector.delete(IImageIoService)` if available, or try to register *before* plugins?
No, we need `univer` instance to get injector.
**Alternative:** Register our service as a *Plugin* that loads *after* core?
**Simplest Fix for now:**
Wrap in try-catch or check `has`.
Actually, if we look at `injector` API in other Univer files (if available)...
Assuming standard Redi:
```typescript
// If it exists, we might be stuck unless we can delete.
// Let's try to NOT register if it exists, just to stop the crash, and see if upload works (it won't).
// BUT, the goal is CRASH PREVENTION first.
```
**Decision:**
Add a check. If `injector.has(IImageIoService)`, log a warning and **skip adding**.
This stops the white-screen crash. We can revisit "Custom Upload" later (it's less critical than "App Working").

### Test Scenarios
1.  **Load Editor:** No console error "dependency item(s)...". Editor renders.
2.  **Upload Image:** Might fail (native behavior), but App doesn't crash.

### Implementation Plan
```typescript
    private overrideImageUpload(univer: Univer) {
        const injector = univer.__getInjector();
        if (injector.has(IImageIoService)) {
             console.warn('[UnifiedEditor] IImageIoService already registered. Skipping override to prevent DI crash.');
             return;
        }
        // ... existing add logic
    }
```
