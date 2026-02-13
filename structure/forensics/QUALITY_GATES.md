# Quality Gates (Documentation + Engineering)

## Minimum acceptable evidence
- Every described flow names exact route + controller + repository/service + table(s).
- Every permissions statement references claim strings from code.
- Unknowns explicitly marked **UNVERIFIED** with follow-up action.

## Checklist
- [ ] Backend/Frontend build commands documented and reproducible.
- [ ] RBAC pathway documented (DB seed -> JWT -> middleware -> UI guard).
- [ ] Pagination contracts documented (`totalCount/pageSize/skip`).
- [ ] Document module row actions mapped.
- [ ] DB dictionary covers all tables from `datai_light.sql`.
- [ ] ERD ownership boundaries and permission patterns documented.
- [ ] Security notes include authz, file storage, and public share-link concerns.
