# Normalisation Analysis

Based on the implemented schema (24 tables, verified). Normal forms
are judged from the primary keys, candidate keys and the business
rules the tables encode.

## Definitions used

- **Functional dependency (FD):** A -> B means each value of A has
  exactly one value of B.
- **Candidate key:** a minimal set of attributes whose closure is the
  whole table.
- **3NF:** no non-key attribute depends on another non-key attribute.
- **BCNF:** every determinant is a candidate key.

## Method

1. List the business rules as FDs.
2. Compute the closure of each determinant.
3. Check that every determinant is a candidate key.
4. If not, decompose.

## Violations found and fixed

### 1. Billing unit inside project type
Original: `project_type(project_type_id, project_type_name, payment_unit_name, unit_description)`.
The unit description depended on the unit name, not on the project
type, so `payment_unit_name -> unit_description` was a transitive
dependency.
Fix: extract `billing_unit(unit_id, billing_unit_name, unit_description)`
and keep `unit_id` as a foreign key in `project_type`.

### 2. Bank details inside collaborator
Original: bank name and account holder were stored on the
collaborator, but they are determined by the account number
(`account_number -> bank_name, account_holder_name`).
Fix: extract `bank_account`, keyed by `bank_account_id`, with
`collaborator_id` as a foreign key and `account_number` unique.

## Key analysis of the final tables

| Table | Primary key | Other candidate keys | Notes |
|---|---|---|---|
| currency | currency_id | currency_code | |
| billing_unit | unit_id | billing_unit_name | |
| manager_role | role_id | manager_role_name | |
| language | language_id | language_code | |
| agency | agency_id | none | agency_name is not unique |
| project_type | project_type_id | project_type_name | |
| project_manager | manager_id | email | |
| collaborator | collaborator_id | email (nullable) | |
| agency_contact | contact_id | none | |
| exchange_rate | rate_id | (from, to, effective_date) | |
| language_pair | pair_id | (source, target) | |
| translation_project | project_id | none | project_name is not unique |
| platform_account | account_id | (account_email, platform) | |
| bank_account | bank_account_id | account_number | |
| rate_history | history_id | none | |
| project_pair | (project_id, pair_id) | | composite key |
| account_pair | (account_id, pair_id) | | composite key |
| collaborator_skill | (collaborator_id, language_id) | | composite key |
| project_assignment | assignment_id | none, by design | |
| communication_log | log_id | none | |
| work_record | record_id | none | |
| agency_invoice | invoice_id | invoice_number, upwork_transaction_ref | both nullable |
| collaborator_payment | payment_id | transaction_reference | nullable |
| revision_log | revision_id | none | |

In every table the determinants are the primary key or another
candidate key listed above, so each table satisfies BCNF.

## Worked example: translation_project

Determinant: `project_id`.
Closure: {project_id} determines project_name, project_type_id,
agency_id, currency_id, agency_rate, collaborator_rate,
project_status, deadline and the audit columns.
It is the only determinant, and it is the key, so the table is in BCNF.

The unit of billing is not stored here. It is reached through
`project_type -> billing_unit`, which is what the first fix achieved.

## Deliberate design choices

- **Rates on the project, not the project type.** Rates vary by agency
  relationship and over time.
- **Rates also in rate_history.** Intentional audit data, kept in sync
  by a trigger. Each history row is a fact about a period.
- **project_assignment has no extra candidate key.** The same
  collaborator can work several accounts on one project, so no
  combination of columns is unique.
- **Derived values are not stored.** Margin, revenue, cost and
  approval percentage are calculated in views.
- **Surrogate keys** are used for entities and composite keys for
  pure junction tables.

## Limits of this analysis

- It rests on the declared keys and stated business rules. It is not a
  proof for every possible dependency in the data.
- `agency_name` and `project_name` are not unique in the schema. If the
  business treats them as unique, add constraints.
- Nullable candidate keys (`collaborator.email`, `invoice_number`)
  allow many nulls, so they are not strict keys.