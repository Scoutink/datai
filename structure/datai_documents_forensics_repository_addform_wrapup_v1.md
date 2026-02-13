Datai – Documents Module Forensic Analysis (Repository → Add Form → Wrap-up) v1

Scope (this document only):

/documents (All Documents page): data flow, filters, list rendering, and every action in the per-document menu.

/documents/add (Add Document form): every field, how it’s validated, how it’s serialized to the API, and how the backend saves it.

No code changes, no “Papers” planning (per your instruction). Strictly forensic mapping of existing Documents module.

Sources inspected (from project files)
Frontend (Angular)

resources-frontend-angular-src.md

app/document/document-list/* (list page TS + HTML)

app/document/document-manage* (add form container + presentation)

app/document/document.service.ts

app/document/sharable-link/*

app/document/document-permission*

app/core/services/common.service.ts (download/token/readText)

Backend (Laravel)

routes.md (API routes)

_DocumentController.php.txt (DocumentController + Signature/Watermark controllers)

_DocumentRepository.php.txt (list query, permission gating, save pipeline, indexing)

app.md (Documents model scopes, enums like DocumentOperationEnum, etc.)

1) Repository (Backend) – Listing, Filtering, Permission Gate, Deep Search
1.1 The real “list documents” endpoint used by Angular

Angular calls:

GET /api/documents (via DocumentService.getDocuments())

Backend routing (routes.md):

GET /documents → DocumentController@getDocuments
✅ This explicit GET route is what makes list work, because DocumentController (in the inspected code) does not implement index() required by apiResource.

Controller:

DocumentController@getDocuments(Request $request)

$queryString = (object)$request->all()

$count = DocumentRepository->getDocumentsCount($queryString)

$rows = DocumentRepository->getDocuments($queryString)

response JSON with headers: totalCount, pageSize, skip

1.2 Input shape: what Angular sends (query params)

From DocumentService.getDocuments(resource):

fields

orderBy (e.g. "createdDate desc")

createDateString (stringified date)

pageSize, skip

searchQuery

categoryId

name ✅ Server uses THIS for search

metaTags

id

location

clientId

statusId

⚠️ Important:

Repository filters use $attributes->name NOT $attributes->searchQuery.

So UI search must populate name for real filtering (and it does in DocumentListComponent).

1.3 DocumentRepository.getDocumentsCount() – what it counts (and what it does NOT)

getDocumentsCount($attributes):

Documents::withoutGlobalScopes(['isDeleted','isExpired'])

joins: categories, users, clients, documentStatus

filters:

categoryId (includes immediate children only)

location / clientId / statusId

metaTags via whereExists(documentMetaDatas metatag like ...)

name via documents.name OR documents.description like ...

createDateString via whereDate(createdDate)

✅ Critical discovery:
getDocumentsCount() does not apply the same document-level permission gating that getDocuments() applies.

Since Documents model scopes are only:

isDeleted

isPermanentDelete

isExpired

…and there is no permission scope, count can include documents the user cannot actually view.

➡️ This can cause paginator mismatch (extra pages that return empty results).

1.4 DocumentRepository.getDocuments() – the real list query + permission enforcement
a) Row composition (selected fields & joins)

Includes:

documents fields: id, name, description, url, location, isIndexed, createdDate, modifiedDate, retentionPeriod, retentionAction, signById, signDate, workflow ids...

joins:

category name

createdBy name

client companyName

documentStatus name + colorCode

workflow name, status, isWorkflowCompleted computed

signed user name computed

subselect counts:

commentCount

versionCount

permission metadata:

maxUserPermissionEndDate (max endDate where isTimeBound=1 for current user)

maxRolePermissionEndDate (max endDate where isTimeBound=1 for current roles)

b) Filters

Same as count (category, name, metaTags, date, client, status, location).

c) Permission gating (key for later modules)

getDocuments() adds a whereExists block allowing docs only if user has:

User permission (documentUserPermissions) OR

Role permission (documentRolePermissions)

Time-bound enforcement:

if isTimeBound == 0: always valid

if isTimeBound == 1: valid only when startDate <= now <= endDate

✅ This is the platform’s true “content-level ACL”.

1.5 Assigned Documents (important precedent for “My X” pattern)

Route:

GET /document/assignedDocuments

Repository:

assignedDocuments($attributes) + assignedDocumentsCount($attributes)

Same style as getDocuments but strictly based on permission tables:

direct user permissions OR role permissions

respects time-bound windows

✅ This is the cleanest existing precedent for how to implement “My Papers” later.

1.6 Deep Search + Indexing

Search:

GET /documents/deep-search?searchQuery=...

repository uses DocumentIndexer->search() and returns up to 10 docs

Index management:

POST /documents/deep-search/{id} → add indexing

DELETE /documents/deep-search/{id} → remove indexing

Indexability rules:

Frontend allows indexing menu only for extensions: .txt .pdf .doc .docx .xlsx .xls

Backend auto-indexing only if file size < 3MB

2) /documents – All Documents page (UI + Every Document Menu Action)
2.1 Route → component

/documents renders:

DocumentListComponent

Flow:

create default DocumentResource (pageSize=10, skip=0, orderBy='createdDate desc')

DocumentDataSource.loadDocuments(resource)

DocumentService.getDocuments(resource) (GET /documents)

reads headers totalCount/pageSize/skip for pagination

2.2 Filters/toolbar mapping

Search:

sets documentResource.name

server filters (documents.name OR description) like %name%

Category:

sets categoryId

server includes immediate children via categories.parentId = categoryId

Meta tags:

sets metaTags

server uses whereExists on documentMetaDatas.metatag like

Created date:

sets createDate → query param createDateString

server uses whereDate(createdDate)

Client/status/location:

directly maps to DB columns

Sort:

documentResource.orderBy = "<field> <dir>"

2.3 Document menu mapping (every item)

Each row menu item is displayed only if *hasClaim="..." allows it.

Below is menu item → component method → API → backend endpoint.

View

UI: routerLink /documents/view/:id

preview overlay: opens BasePreviewComponent with DocumentView

token API used by preview flows:

GET /documentToken/{documentId}/token

Edit

UI: routerLink /documents/edit/:id

Download

downloadDocument(document) → CommonService.downloadDocument()

GET /document/{id}/download/{isVersion}

then adds audit:

POST /documentAuditTrail (operationName=Download)

Share (permissions)

manageDocumentPermission() opens DocumentPermissionListComponent

APIs:

GET /DocumentRolePermission/{id}

POST /documentRolePermission

POST /documentUserPermission

DELETE /documentRolePermission/{id}

DELETE /documentUserPermission/{id}

Share Selected Documents (bulk)

opens DocumentPermissionMultipleComponent

API:

POST /documentRolePermission/multiple

Upload New Version

opens DocumentUploadNewVersionComponent

API:

POST /documentversion

versions list: GET /documentversion/{documentId}

Version History

onVersionHistoryClick():

loads versions via GET /documentversion/{id}

opens DocumentVersionHistoryComponent

restore uses POST /documentversion/{id}/restore/{versionId}

Workflow / Visual Workflow

opens DocumentWorkflowDialogComponent

visual graph uses:

GET /documentWorkflow/{documentWorkflowId}/runningVisualWorkflow

Add Comment

opens DocumentCommentComponent

comment count comes from repository subselect

Generate Summary (AI)

opens AiDocumentSummaryComponent

API:

POST /ai/summarize-document

PDF Signature

opens DocumentSignatureComponent

API:

POST /document-signature

GET /document-signature/{documentId}

Watermark

opens DocumentWatermarkComponent

API:

POST /document-watermark

Shareable Link

getDocumentShareableLink(id) → GET /document-sharable-link/{id}

create link:

POST /document-sharable-link

delete link:

DELETE /document-sharable-link/{id}

Deep Search indexing (add/remove)

add: POST /documents/deep-search/{id}

remove: DELETE /documents/deep-search/{id}

Archive

archiveDocument() → DELETE /document/{id}/archive

Delete

opens DocumentDeleteDialogComponent

confirm triggers:

DELETE /document/{id}

backend calls ArchiveDocumentRepository delete cascade:

deletes meta, comments, notifications, reminders, schedulers, versions, permissions, emails, tokens

deletes files & version files

deletes index if indexed

writes audit Deleted

3) /documents/add – Add Document form (field-by-field forensic mapping)
3.1 Route and pattern

route: /documents/add

container: DocumentManageComponent

presentation: DocumentManagePresentationComponent

Presentation builds FormGroup and emits DocumentInfo.
Container saves and writes Created audit.

3.2 Fields (exact controls + validation)
Upload

controls: url required, extension required (only set if allowed)

errors:

required file: DOCUMENT_IS_REQUIRED

invalid extension: DOCUMENT_TYPE_IS_NOT_ALLOWED

Name

name required

Category

categoryId required

Add Category button exists if claim allows: DOCUMENT_CATEGORY_MANAGE_DOCUMENT_CATEGORY

Storage

location default local

s3 option exists only if storage supports

Status / Client

statusId optional

clientId optional

Retention

retentionPeriod number (min 1)

retentionAction dropdown (enum)

Meta tags (FormArray)

documentMetaTags → array of { metatag } rows

UI supports Add and Delete rows

empty tags are filtered before submit

Permissions (roles & users)

Shown only if claim exists: ALL_DOCUMENTS_SHARE_DOCUMENT

Role assignment:

select multiple roles

optional time-bound period

allow download boolean

User assignment:

select multiple users

optional time-bound period

allow download boolean

3.3 Serialization to backend (FormData)

DocumentService.addDocument(document) builds FormData:

uploadFile

name

categoryId/categoryName

description

location

statusId

clientId

retentionPeriod

retentionAction

documentMetaDatas JSON

documentRolePermissions JSON

documentUserPermissions JSON

Endpoint:

POST /document
(or POST /ai/documents if html_content exists)

3.4 Backend save pipeline

Controller: DocumentController@saveDocument

duplicate check (name + categoryId)

validates name required

validates file is valid

checks S3 config if location=s3

stores file as UUID under documents/

calls DocumentRepository.saveDocument($request, $path, $fileSize)

Repository saveDocument:

creates documents record (retention, location, status, client…)

stores meta tags

auto-indexing if file size < 3MB

creates role permission rows + Add_Permission audit entries

creates user permission rows + Add_Permission audit entries

creates share notifications

ensures creator has at least one user permission row

✅ Created audit is NOT server-side.
It is done by frontend container:

DocumentManageComponent after successful POST:

calls POST /documentAuditTrail with operationName=Created

then navigates to /documents

4) Wrap-up (separate)
4.1 What we now know “as if we coded it”

Documents list = Angular DocumentResource + Laravel Repository query.

Real document visibility is controlled by documentUserPermissions/documentRolePermissions with time-bound enforcement.

Claims are separate: they gate UI pages/buttons, not document-level ACL.

Most features are external “subsystems” accessed via dialogs (workflow, watermark, signatures, shareable links, versions, indexing, reminders, email, comments).

4.2 Major risks found

getDocumentsCount() lacks permission whereExists, so totalCount can exceed actual visible docs → paginator mismatch possible.

Created audit depends on frontend; if audit call fails navigation may hang.

category filter includes only direct child categories.

4.3 Still missing for absolute 100% mastery

(Does not block next steps, but must be documented before building new modules flawlessly)

Full backend implementations for:

ArchiveDocumentRepository (restore/archive/permanent delete edge cases)

DocumentVersion repository logic

DocumentWorkflow transition rules

Reminder scheduling/cron wiring

DocumentToken + officeviewer integration details

DocumentIndexer implementation internals