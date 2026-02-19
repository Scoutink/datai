# Workflows Flow

## Workflow definition lifecycle
1. Angular workflow management (`WorkflowService`) calls:
   - `GET /api/workflow`
   - `POST /api/workflow`
   - `PUT /api/workflow/{id}`
   - `DELETE /api/workflow/{id}`
2. Controller validates names and delegates to `WorkflowRepositoryInterface`.
3. Steps/transitions are managed through workflow step/transition endpoints protected by workflow claims.

## Assign workflow to document
1. Document list action opens workflow dialog.
2. Angular sends `POST /api/documentWorkflow` via `DocumentWorkflowService.addDocumentWorkflow()`.
3. Backend `DocumentWorkflowController@saveDocumentWorkFlow` creates document workflow instance.

## State transition flow
1. UI requests current graph via:
   - `GET /api/documentWorkflow/{id}/visualWorkflow` (instance)
   - `GET /api/workflow/{id}/visualWorkflow` (template)
2. User performs transition from available next transitions.
3. Angular sends `POST /api/documentWorkflow/performNextTransition`.
4. Backend validates UUID inputs and applies transition in repository/service logic.

## Monitoring + cancellation
- Workflow instances list: `GET /api/documentWorkflow`.
- Workflow logs: `GET /api/workflow-logs`.
- Cancellation endpoint: `POST /api/documentWorkflow/{id}/cancel`.
