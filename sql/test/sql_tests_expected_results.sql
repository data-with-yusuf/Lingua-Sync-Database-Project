# Expected Results

What a correct run looks like. Run constraint and trigger tests one
statement at a time, outside a transaction.

| Tests | Script | Expected |
|---|---|---|
| 1 to 19 | constraint_tests.sql | Every statement fails with the named constraint |
| 20 to 29 | trigger_tests.sql | Every blocking statement fails with a trigger message |
| 24 (steps 1, 2, 4) | trigger_tests.sql | Succeed: the account has 1 pair, four pairs are added, then removed. Step 3 (sixth pair) fails. |
| 30 | trigger_tests.sql | updated_at is newer after the update |
| 31 | soft_delete_tests.sql | Collaborator leaves active view, row stays in table, bank account soft-deleted by cascade |
| 32 | soft_delete_tests.sql | 1 work record and 1 payment still found |
| 33 | soft_delete_tests.sql | Collaborator back in active view after restore |
| 34 | soft_delete_tests.sql | Agency hidden from active view, contacts soft-deleted, then restored |
| 35 | view_tests.sql | 60 projects: 38 Completed, 11 Assigned, 5 Not Assigned, 3 Cancelled, 3 On Hold |
| 36 | view_tests.sql | 13 rows with employment_status Active |
| 37 | view_tests.sql | 4 agencies |
| 38 | view_tests.sql | Revenue 12,027.40, cost 7,951.30, margin 4,076.10 for paid work |
| 39 | view_tests.sql | 8 pending payments totalling 2,537.00 |
| 40 | view_tests.sql | Paid 30, Pending 19, Confirmed 8, Cancelled 3 |
| 41 | view_tests.sql | 60 projects |
| 42 to 44 | view_tests.sql | Performance, earnings and revisions return rows. Revision tracker: 4 rows, 3 resolved, 1 pending |
| 45 | integrity_tests.sql | 60 open rates |
| 46 | integrity_tests.sql | 0 rows |
| 47 | integrity_tests.sql | 0 orphans |
| 48 | integrity_tests.sql | 0 rows |
| 49 | integrity_tests.sql | All 2023 work records are Paid |
| 50 | integrity_tests.sql | Received 12,027.40, paid out 7,951.30, margin 4,076.10 |
| 51 | integrity_tests.sql | Collaborators with assignments show Assigned |
| 52 | integrity_tests.sql | 0 rows (project rates match open rate history) |
| 53 | integrity_tests.sql | 2 rows: agency-to-payment story for Project 1 (two collaborators) |