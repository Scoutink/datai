# Root Cause: Why Cloning All Documents Action Menu into Papers Failed

## 1) Entity mismatch (document file entity vs paper JSON entity)
- Documents actions assume file artifacts (`uploadFile`, tokenized download, file version upload).
- Papers persists editor snapshots in `contentJson` and derives HTML/text.
- Cloning handlers without entity adapter causes wrong payload/endpoint assumptions.

## 2) Endpoint family mismatch
- Documents use `/document*`, `/documentversion*`, `/documentPermission*`, `/document-sharable-link*`.
- Papers uses `/papers/*` + dedicated repositories/models.
- UI can render copied menu items, but handlers point to wrong services/endpoints.

## 3) Permission namespace mismatch
- Documents claims: `ASSIGNED_DOCUMENTS_*`, `ALL_DOCUMENTS_*`.
- Papers claims: `ALL_PAPERS_*`, `MY_PAPERS_*`, `PAPER_*`.
- Blind cloning breaks authorization either by over-hiding or exposing unauthorized items.

## 4) Viewer/editor mismatch
- Documents view flow uses file viewer/token endpoints.
- Papers view should render Univer snapshot read-only.
- Current Papers preview has editable LIVE toggle, so “View” is semantically incorrect.

## 5) Incomplete parity contracts for some actions
- Reminder/send-email/workflow/signature/watermark are document-bound in current code contracts.
- Papers equivalents are missing or require dedicated backend implementation.

## 6) Concrete coding hazards observed
- `paper-preview.component.ts` missing imports indicates unstable copied/partial implementation.
- Preview component mixes read-only and editable mode in detail page, conflicting with action intent.
