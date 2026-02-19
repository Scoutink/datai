# Papers Workshop Index

## Papers docs in this folder
1. [01_papers_overview.md](./01_papers_overview.md)
2. [02_papers_repo_map.md](./02_papers_repo_map.md)
3. [03_papers_data_model.md](./03_papers_data_model.md)
4. [04_univer_lifecycle_in_papers.md](./04_univer_lifecycle_in_papers.md)
5. [05_action_menu_parity_matrix.md](./05_action_menu_parity_matrix.md)
6. [06_root_cause_cloning_failure.md](./06_root_cause_cloning_failure.md)
7. [07_view_only_mode_spec.md](./07_view_only_mode_spec.md)
8. [08_fix_plan.md](./08_fix_plan.md)
9. [09_smoke_tests.md](./09_smoke_tests.md)

## Baseline workshop docs used as platform reference
- [../00_index.md](../00_index.md)
- [../02_runtime_architecture.md](../02_runtime_architecture.md)
- [../03_database_map.md](../03_database_map.md)
- [../flows/04_action_menu_items.md](../flows/04_action_menu_items.md)
- [../playbook/01_change_protocol.md](../playbook/01_change_protocol.md)

## How to use these docs to fix Papers safely
1. Start with `01` + `02` to map exact frontend/backend files.
2. Confirm data/storage assumptions in `03` + `04` before behavior changes.
3. Use `05` parity matrix to avoid cloning incompatible document actions.
4. Read `06` root causes before touching menu handlers.
5. Implement only the step sequence in `08`, validating with `09` after each step.
