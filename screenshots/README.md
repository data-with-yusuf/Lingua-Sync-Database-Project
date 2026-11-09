# Screenshots

Captures of the LinguaSync database running in pgAdmin 4 on
PostgreSQL 15. All data shown is fictional demo data.

## Database objects

| File | What it shows |
|---|---|
| `pgadmin_tables_24.png` | The 24 tables in the `public` schema |
| `pgadmin_views_19.png` | The 19 views: 9 active-record views and 10 reporting views |

## Reporting views

| File | What it shows |
|---|---|
| `vw_margin_report.png` | Project margin report: revenue, cost and margin per project |
| `vw_project_dashboard.png` | Project dashboard: agency, type, rates, status and deadline flag |

## Tests

| File | What it shows |
|---|---|
| `test_constraint_error.png` | A CHECK constraint rejecting invalid data |
| `test_five_pair_limit.png` | The trigger refusing a sixth language pair on an account |
| `test_reconciliation.png` | Financial reconciliation: 12,027.40 received, 7,951.30 paid out, margin 4,076.10 |

The full test scripts are in `sql/tests/`, with expected and observed
results in `expected_results.md` and `test_results.md`.

For the diagrams, see the `diagrams/` folder.