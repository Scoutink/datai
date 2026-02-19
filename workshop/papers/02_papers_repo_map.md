# Papers Repo Map

## Frontend routes/pages/components/services
- Module routes:
  - `resources/frontend/angular/src/app/papers/paper-routing.module.ts`
  - `resources/frontend/angular/src/app/papers/paper-manage/paper-manage-routing.module.ts`
- List page + action menu:
  - `.../papers/paper-list/paper-list.component.ts`
  - `.../papers/paper-list/paper-list.component.html`
- Manage (create/edit) page:
  - `.../papers/paper-manage/paper-manage.component.ts`
  - `.../papers/paper-manage/paper-manage.component.html`
- Detail page and tabs:
  - `.../papers/paper-details/paper-detail.component.ts`
  - `.../papers/paper-details/paper-detail.component.html`
- Preview + embedded editor:
  - `.../papers/paper-details/paper-preview/paper-preview.component.ts`
  - `.../papers/paper-details/paper-preview/paper-preview.component.html`
  - `.../papers/paper-editor/paper-editor.component.ts`
  - `.../shared/unified-editor/unified-editor.component.ts`
- Service layer:
  - `.../papers/paper.service.ts`
- Resolver:
  - `.../papers/paper-details.resolver.ts`

## Backend routes/controllers/services/models
- API route registration block in `routes/api.php` (papers section).
- Controller:
  - `app/Http/Controllers/PaperController.php`
- Repositories:
  - `app/Repositories/Implementation/PaperRepository.php`
  - `app/Repositories/Implementation/PaperPermissionRepository.php`
  - `app/Repositories/Implementation/PaperVersionsRepository.php`
  - `app/Repositories/Implementation/PaperCommentRepository.php`
  - `app/Repositories/Implementation/PaperShareableLinkRepository.php`
- Supporting services:
  - `app/Services/Papers/PaperContentService.php`
  - `app/Services/Sheets/SheetDataService.php`
  - `app/Services/PaperIndexer.php`
- Models:
  - `app/Models/Papers.php` and related `Paper*` + `Sheet*` models.

## Shared/parallel menu patterns vs All Documents
- All Documents menu source: `document-library-list.component.html/.ts`.
- Papers menu source: `paper-list.component.html/.ts`.
- Both use claim-gated menu buttons and route/service handlers, but data entity and endpoint families differ.
