# AI Documents Flow

## Generation flow
1. Angular AI generator sends prompt/model config to stream endpoint (`AIController@stream`).
2. Backend validates input and chooses provider by model prefix:
   - Gemini models → `streamGemini()`
   - others → `streamOpenAI()`
3. Response is Server-Sent Events stream (`text/event-stream`), chunking generated text.
4. Final generated output is persisted in `openaiDocuments` via `saveAIDocument()`.

## Template + listing flow
- Prompt templates managed through `AIPromptTemplateService` against `/api/aIPromptTemplate` CRUD endpoints.
- AI document records queried through AI document list components/datasource and backend AI controller listing endpoint.

## Linking AI output to normal docs
- `DocumentService.addDocument()` routes to `POST /api/ai/documents` when `html_content` exists.
- This path enables AI-generated content to be converted into regular document records for normal document flows.

## Summary flow
- Per-document AI summary uses `AISummaryController@summarize` (`POST /api/ai/summaries`).
- Inputs include `model` and `documentId`; service returns generated summary response.
