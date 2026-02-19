# Glossary (UI term → code mapping)

- **Document Library** → `document-library` Angular module + `Documents` model.
- **Share** → document permission dialogs + `/api/documentPermission/*` endpoints.
- **Get Shareable Link** → `documentShareableLink` model/repository + sharable-link Angular dialog.
- **Reminder** → `Reminders` model and reminder detail tables + reminder dialogs/list.
- **Workflow** → `Workflow`, `WorkflowStep`, `WorkflowTransition`, `DocumentWorkflow` entities.
- **Workflow Logs** → `workflowLogs` table + workflow logs screen/API.
- **AI Document** → `openaiDocuments` table + AI generator/list modules.
- **AI Summary** → summary UI dialog + `AISummaryController` endpoint.
- **Document Signature** → signature dialog + `document-signature` API.
- **Watermark** → watermark dialog + `document-watermark` API.
- **Claims** → permission strings stored in `roleClaims`/`userClaims`, enforced by `hasToken` middleware and Angular claim checks.
