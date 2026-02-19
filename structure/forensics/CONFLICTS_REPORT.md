# Conflicts Report (Forensics vs existing `structure/` docs)

## Conflict 1: AI summary endpoint
- Existing doc statement: Documents deep-dive stated AI summary endpoint as `GET /documentSummary/generate/{documentId}`.
- Forensic statement: actual route is `POST /ai/summarize-document` mapped to `AISummaryController@summarize`.
- Evidence: `routes/api.php` route group guarded by `hasToken:ALL_DOC_GENERATE_SUMMARY,ASSIGNED_DOC_GENERATE_SUMMARY` defines `Route::post('/ai/summarize-document', [AISummaryController::class, 'summarize']);`.
- Resolution: forensic statement is correct; updated existing files:
  - `structure/all_documents_main.md`
  - `structure/datai_documents_forensics_repository_addform_wrapup_v1.md`

## Conflict 2: Route source naming
- Existing doc statement: references a non-repo file name `routes.md` as routing source.
- Forensic statement: authoritative routing source is `routes/api.php` and `routes/web.php`.
- Evidence: actual Laravel route files present in repository tree and loaded by framework.
- Resolution: Keep this as informational drift; no mechanical break, but future edits should cite `routes/api.php`.
