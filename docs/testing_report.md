# Testing Report

53 checks were run in pgAdmin 4 against PostgreSQL 15 on the
fictional demo data. All passed after the fixes listed below.
Scripts are in `sql/tests/`. Expected and observed results are in
`sql/tests/expected_results.md` and `sql/tests/test_results.md`.

## How to read the results

- Constraint and trigger tests are designed to fail. A rejected
  statement means the rule works.
- Each failing test is run as a single statement, outside a
  transaction.
- Soft delete tests change data and then restore it.

## Summary

| Group | Tests | Script | Result |
|---|---|---|---|
| Constraint tests | 19 (Tests 1 to 19) | constraint_tests.sql | All rejected invalid data as intended |
| Trigger tests | 11 (Tests 20 to 30) | trigger_tests.sql | All behaved as intended |
| Soft delete tests | 4 (Tests 31 to 34) | soft_delete_tests.sql | Pass |
| Reporting view tests | 10 (Tests 35 to 44) | view_tests.sql | Pass |
| Integrity tests | 9 (Tests 45 to 53) | integrity_tests.sql | Pass |
| **Total** | **53** | | **All passing** |

## What was tested

**Constraints:** contact method, employment and assignment status,
rate order, positive rates, project, record, invoice and payment
statuses, quality score range, language pair rules, proficiency
levels, exchange rate rules, duplicate account and platform,
positive payment amount, sender identity and rate history dates.

**Triggers:** blacklisted and inactive collaborators blocked from
assignment, work record status order, Paid as a final status, the
five-pair limit per account, revisions blocked on Approved and Paid
records, hard deletes blocked, and updated_at refreshed on update.

**Soft delete:** a collaborator and an agency were soft deleted,
hidden from active views, history kept (1 work record and 1 payment
for the collaborator), cascades applied to bank accounts and
contacts, and everything restored.

**Views:** project dashboard, collaborator directory, agency
summary, margin report, pending payments, invoice tracker, work
progress, collaborator performance, earnings and revision tracker.

**Integrity:** one open rate per project, no orphan rows, no
completed project without work records, 2023 work records Paid,
financial reconciliation, assignment status consistency, project
rates in sync with rate history, and an end-to-end trace from agency
to payment.

## Key results

| Check | Result |
|---|---|
| Projects by status | 60 total: 38 Completed, 11 Assigned, 5 Not Assigned, 3 Cancelled, 3 On Hold |
| Active collaborators | 13 |
| Pending payments | 8, totalling 2,537.00 |
| Invoices by status | Paid 30, Pending 19, Confirmed 8, Cancelled 3 |
| Revisions | 4 (3 resolved, 1 pending) |
| Open rates | 60, none duplicated |
| Reconciliation | 12,027.40 received, 7,951.30 paid out, margin 4,076.10 |
| Test 53 | 2 rows tracing agency, work record, invoice and payment for Project 1 |

## Issues found and how they were handled

| Issue | Cause | Resolution |
|---|---|---|
| Demo data loaded before triggers | Wrong load order | Rebuilt in the correct order |
| Two triggers blocked historical rows | Collaborator eligibility and revision eligibility triggers reject records that pre-date current statuses | Disabled for the load, re-enabled, confirmed enabled (35 of 35) |
| Project status counts differed from first expectation | Expectation miscounted | Correct values are 38 Completed and 11 Assigned |
| Confirmed invoice count differed from first expectation | Expectation miscounted | Correct value is 8 |
| Agency summary test used missing columns | View has no cancelled or on-hold columns | Test uses the real columns |
| Reconciliation gave a negative margin | Invoices and payments joined through the project, multiplying rows | Replaced with separate totals |
| Zero payment rule | Zero payments rejected by `payment_amount > 0` | Documented as greater than zero |
| Session blocked with SQLSTATE 25P02 | Failing statement inside BEGIN | Run error tests outside transactions |

## Financial reconciliation

| Measure | Value |
|---|---|
| Paid invoices (agencies) | 12,027.40 |
| Paid collaborator payments | 7,951.30 |
| Margin | 4,076.10 |

The same figures come from the per-project query, the raw totals and
the monthly cash flow query.

## Rebuild test

The schema and demo data files were run in order on a blank
database. The load completed with no errors and the object counts
matched the live database.

## Not covered

Edge cases of the auto-complete and rate-history triggers,
concurrent users, performance at scale and explicit transactions.
These are listed in `docs/known_limitations.md`.