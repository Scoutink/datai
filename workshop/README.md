# Workshop Completion Report

## What was mapped
- Repository layout and backend/frontend boundaries.
- Runtime request flow (Angular → API → middleware → controllers → repositories/models).
- Database entity map for documents, AI documents, workflows, permissions, sharing, reminders.
- Authentication and claim-based authorization model (backend + frontend).
- User flow maps for documents, AI documents, workflow lifecycle, sharing links, and action menu wiring.
- Safe change/testing/troubleshooting playbook for future PRs.
- Build pipeline documentation and deployment instructions for ZIP-based server updates.

## What was explicitly excluded
- All H5P/interactive modules and routes (excluded from behavior analysis).
- Papers module behavior details (excluded as requested).

## ZIP deployment usage
- Use GitHub Actions workflow **Build Deployable ZIP**.
- Download artifact `datai-deployable-zip` from Actions run.
- Upload ZIP to server, extract, ensure `storage/` and `bootstrap/cache/` write permissions, then run minimal runtime commands if required.

## Where future work should start
1. Pick one bug/feature.
2. Link change to relevant `/workshop` flow doc.
3. Make smallest isolated PR with test/build evidence and rollback plan.
