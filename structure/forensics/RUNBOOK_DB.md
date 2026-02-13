# Runbook: Database

## Import schema-only
`mysql -u <user> -p <db> < structure/database/datai_light.sql`

## Import schema + sample data
`mysql -u <user> -p <db> < structure/database/datai_with_data.sql`

## Diff schema changes
- Export current schema (`mysqldump --no-data`) and diff against `datai_light.sql`.
- Prefer review of FK/index drift explicitly.

## Migration/patch guidance
- Prefer Laravel migrations for app-evolution environments.
- For this repo’s forensic baseline, keep deterministic SQL patch files under version control when touching non-migrated legacy tables.
- Include rollback SQL where feasible.
