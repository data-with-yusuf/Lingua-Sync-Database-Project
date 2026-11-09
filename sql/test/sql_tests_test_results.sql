# Test Results

Run in pgAdmin 4 against PostgreSQL 15 on the fictional demo data.
53 tests in total.

| Script | Tests | Outcome |
|---|---|---|
| constraint_tests.sql | 1 to 19 | All 19 statements rejected by the named constraint, as intended |
| trigger_tests.sql | 20 to 30 | Blocking statements rejected by their triggers. Test 24 showed the five-pair limit (current pairs = 1, sixth pair refused) and its test rows were removed. Test 30 confirmed updated_at changes. |
| soft_delete_tests.sql | 31 to 34 | Soft deletes hidden from active views, history kept (1 work record, 1 payment), cascades applied, then restored |
| view_tests.sql | 35 to 44 | All 10 reporting views returned the expected counts and totals |
| integrity_tests.sql | 45 to 53 | 60 open rates, no duplicates, no orphans, no completed project without work, rates in sync, reconciliation 12,027.40 received, 7,951.30 paid out, margin 4,076.10. Test 53 returned 2 rows, tracing agency, work record, invoice and payment for Project 1. |

The restore steps in Tests 33 and 34 leave the database in its
original state.