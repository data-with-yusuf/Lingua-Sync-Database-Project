# DBMS Fundamentals Applied in LinguaSync

Each section gives the idea in plain terms, then where it appears in
the project.

## 1. Entities, attributes and keys
An entity is something the business records, such as a collaborator
or invoice. A primary key identifies a row. A foreign key points to a
row in another table.
**In LinguaSync:** 24 tables, 24 primary keys (3 composite), 36
foreign keys.

## 2. Entity-relationship modelling (Chen notation)
Drawing entities and relationships before writing SQL forces the
business questions first: can a collaborator work two accounts on one
project? Who owns an account?
**In LinguaSync:** relationship attributes, such as proficiency
level, led to `collaborator_skill` as its own table.

## 3. Functional dependencies and keys
A -> B means A determines B. The closure of A is everything it
determines. A candidate key is a minimal set that determines the
whole row.
**In LinguaSync:** each table's determinants are listed in
`normalization_analysis.md`.

## 4. Normalisation
Normalising stores each fact once. BCNF requires every determinant to
be a candidate key.
**In LinguaSync:** two violations were found and fixed by creating
`billing_unit` and `bank_account`.

## 5. Crow's Foot notation
Each line shows cardinality (one or many) and participation
(mandatory or optional).
Rule used: a NOT NULL foreign key gives a mandatory parent side. A
nullable foreign key gives an optional one.
**In LinguaSync:** the two sender columns in `communication_log` and
`revision_log.resolved_record_id` are nullable, so those lines are
optional.

## 6. Constraints
Constraints make the database reject invalid data itself: NOT NULL,
UNIQUE, CHECK and foreign keys.
**In LinguaSync:** 25 CHECK and 14 UNIQUE constraints, each tested by
trying to break it.

## 7. Triggers
Some rules need more than a CHECK, such as limiting an account to 5
language pairs.
**In LinguaSync:** 35 triggers from 11 functions cover eligibility,
status order, soft delete and rate history.

## 8. Soft delete and views
Marking rows with `deleted_at` preserves history. Views package
common queries.
**In LinguaSync:** 11 tables have `deleted_at`, and 9 active views
hide deleted rows. Ten reporting views answer business questions.

## 9. Indexes
Indexes speed up lookups but cost write time. PostgreSQL ignores
them on tiny tables.
**In LinguaSync:** 66 indexes, including 7 partial indexes on
`deleted_at IS NULL`. Their effect has not been measured yet.

## 10. Transactions
A transaction makes several steps succeed or fail together.
**In LinguaSync:** planned for approving work and creating payments.
A real lesson: a failed statement inside `BEGIN` aborted the session
until `ROLLBACK`.

## Mistakes and corrections
- Loaded demo data before triggers, so I rebuilt in the right order.
- A first reconciliation joined invoices and payments through the
  project and gave a wrong margin. Separate totals fixed it.
- I wrote queries with columns that did not exist and now check
  `information_schema` first.
- I checked my documented counts against the live database and
  corrected them.