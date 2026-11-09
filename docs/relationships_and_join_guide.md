# Relationships and Join Guide

How to join LinguaSync tables correctly. All 36 foreign keys are listed.

## How to read a relationship

The foreign key sits on the child table and points to the parent.
Join with `child.fk_column = parent.pk_column`.

## All 36 foreign keys

| Child table | Column | Parent table |
|---|---|---|
| project_type | unit_id | billing_unit |
| project_manager | role_id | manager_role |
| agency_contact | agency_id | agency |
| translation_project | agency_id | agency |
| translation_project | project_type_id | project_type |
| translation_project | currency_id | currency |
| agency_invoice | project_id | translation_project |
| agency_invoice | agency_id | agency |
| agency_invoice | currency_id | currency |
| collaborator_payment | collaborator_id | collaborator |
| collaborator_payment | project_id | translation_project |
| collaborator_payment | currency_id | currency |
| exchange_rate | from_currency_id | currency |
| exchange_rate | to_currency_id | currency |
| bank_account | collaborator_id | collaborator |
| collaborator_skill | collaborator_id | collaborator |
| collaborator_skill | language_id | language |
| language_pair | source_language_id | language |
| language_pair | target_language_id | language |
| project_pair | project_id | translation_project |
| project_pair | pair_id | language_pair |
| account_pair | account_id | platform_account |
| account_pair | pair_id | language_pair |
| project_assignment | collaborator_id | collaborator |
| project_assignment | project_id | translation_project |
| project_assignment | account_id | platform_account |
| project_assignment | assigned_by_manager_id | project_manager |
| rate_history | project_id | translation_project |
| rate_history | changed_by_manager_id | project_manager |
| work_record | assignment_id | project_assignment |
| communication_log | assignment_id | project_assignment |
| communication_log | manager_sender_id | project_manager |
| communication_log | collaborator_sender_id | collaborator |
| revision_log | record_id | work_record |
| revision_log | resolved_record_id | work_record |
| revision_log | requested_by_manager_id | project_manager |

## The three hubs

1. **translation_project** anchors money and language. Invoices,
   payments, rate history and language pairs all point to it.
2. **project_assignment** anchors people and work. It links a
   collaborator, a project, a platform account and the manager who
   assigned it. Work records and messages hang off it.
3. **collaborator** anchors skills, bank details and payments.

## Common join paths

| Question | Path |
|---|---|
| Which agency owns a project? | translation_project, agency |
| What unit is a project billed in? | translation_project, project_type, billing_unit |
| Who worked on which project? | collaborator, project_assignment, translation_project |
| Which account was used? | project_assignment, platform_account |
| What work was submitted? | project_assignment, work_record |
| Who requested a revision? | revision_log, project_manager |
| Languages of a project | translation_project, project_pair, language_pair, language (twice) |
| Languages of a collaborator | collaborator, collaborator_skill, language |
| Bank details for a payment | collaborator_payment, collaborator, bank_account |
| Agency to collaborator | agency, translation_project, project_assignment, collaborator |

## Example: project languages (language joined twice)

```sql
SELECT tp.project_name,
       src.language_display_name AS source_language,
       tgt.language_display_name AS target_language
FROM translation_project tp
INNER JOIN project_pair pp ON pp.project_id = tp.project_id
INNER JOIN language_pair lp ON lp.pair_id = pp.pair_id
INNER JOIN language src ON src.language_id = lp.source_language_id
INNER JOIN language tgt ON tgt.language_id = lp.target_language_id;
```

## Junction tables

`project_pair`, `account_pair` and `collaborator_skill` exist only to
connect two tables. Join through them, not to them.

## Pitfalls

**1. Do not join invoices and payments through the project in one query.**
A project with two collaborators has two payment rows, so its invoice
is counted twice. Total each side in its own CTE, then combine.

```sql
WITH rev AS (
    SELECT project_id, SUM(invoice_amount) AS revenue
    FROM agency_invoice WHERE invoice_status = 'Paid'
    GROUP BY project_id),
cost AS (
    SELECT project_id, SUM(payment_amount) AS cost
    FROM collaborator_payment WHERE payment_status = 'Paid'
    GROUP BY project_id)
SELECT SUM(rev.revenue) - SUM(cost.cost) AS margin
FROM rev INNER JOIN cost ON cost.project_id = rev.project_id;
```

**2. Payments link to a project and collaborator, not to an assignment
or work record.** There is no direct foreign key from
`collaborator_payment` to `work_record`.

**3. Two foreign keys to the same table need two aliases.**
`language_pair` points to `language` twice, `exchange_rate` to
`currency` twice, `revision_log` to `work_record` twice.

**4. Nullable foreign keys.** `communication_log` has two sender
columns and only one is filled. `revision_log.resolved_record_id` is
null until a revision is resolved. Use LEFT JOIN when you must keep
rows where the link is empty.

**5. Soft delete.** Use the `active_*` views, or add
`deleted_at IS NULL`, so deleted rows do not appear.

**6. LEFT JOIN plus WHERE.** Putting a condition on the right-hand
table in WHERE turns a LEFT JOIN into an INNER JOIN. Put it in the ON
clause instead.