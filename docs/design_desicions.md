# Design Decisions

Each decision records what was chosen and why.

## 1. Rates live on the project, not the project type
Agencies pay different rates for the same kind of work, and rates change.
Storing them on `project_type` would force one rate per type.
`translation_project` holds `agency_rate` and `collaborator_rate`, and
`rate_history` records every change.

## 2. Business margin is the gap between two rates
The agency pays the business, and the business pays the collaborator.
`chk_rates` requires agency_rate > collaborator_rate, and
`rate_history` enforces the same rule.

## 3. Billing unit is its own table
Payment unit was originally text on `project_type`. That made the unit
depend on the project type rather than the key, a transitive dependency.
`billing_unit` was extracted (Per Word, Per Hit, Per Segment).

## 4. Bank details are their own table
Bank name and account holder depend on the account number, not on the
collaborator, so `bank_account` was extracted. The collaborator can
have bank details added later.

## 5. Soft delete
Financial and work history should not disappear. Eleven tables carry
`deleted_at`. Hard deletes are blocked by trigger on nine of them.
Agency soft delete cascades to its contacts, and collaborator soft
delete cascades to bank accounts. Active-record views hide deleted rows.

## 6. No unique constraint on project_assignment
The same collaborator may work several platform accounts on one project,
or the same account more than once. `assignment_id` alone identifies a
row, and the real-world cases justify the flexibility.

## 7. Junction tables use composite keys
`project_pair`, `account_pair` and `collaborator_skill` have no
surrogate id. The pair of foreign keys is the key, which also prevents
duplicates.

## 8. Proficiency has two levels
Only Native and Professional are allowed. Basic proficiency is not
acceptable for paid translation work.

## 9. Five language pairs per account
A CHECK cannot count other rows, so a trigger enforces the limit.

## 10. One open rate per project
A partial unique index on `rate_history (project_id) WHERE effective_to
IS NULL` allows many historical rows but only one current rate.

## 11. Delete behaviour
Most foreign keys use ON UPDATE CASCADE and ON DELETE RESTRICT, so
referenced data cannot be removed accidentally. Optional links
(the two sender columns in `communication_log` and
`revision_log.resolved_record_id`) use ON DELETE SET NULL.

## 12. Rules in the database, not only in an application
Statuses, rate order, positive amounts, date order and assignment
eligibility are enforced by constraints and triggers, so every client
gets the same protection.

## 13. Demo data and triggers
Historical demo data collided with two triggers
(`trg_check_collaborator_eligibility` and
`trg_check_revision_eligibility`). They were disabled for the load,
re-enabled, and verified as enabled afterwards.