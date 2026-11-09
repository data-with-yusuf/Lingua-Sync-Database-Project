# LinguaSync: PostgreSQL Database for Translation Project Management

A PostgreSQL database that manages the full workflow of a freelance
translation business: agencies commission projects, collaborators
complete the work, and the business invoices agencies and pays
collaborators.

> All data in this repository is fictional demo data created for
> testing and demonstration. Names, rates, invoices and payments do
> not represent real people or transactions.

---

## The Problem

Freelance translation work is often tracked in spreadsheets and email
threads. Rates change, collaborators work on several accounts, and
payments arrive weeks after the work is done. Data gets lost and
margins are hard to see.

LinguaSync gives the business one source of truth for projects,
collaborators, work quality, invoices and payments, with business
rules enforced inside the database.

## What It Manages

- **Agencies** that commission work, and their contacts
- **Projects** with rates, deadlines, status and language pairs
- **Collaborators** with language skills and bank details
- **Platform accounts** used to submit work, with registered language pairs
- **Assignments and work records** with quality scores and an approval workflow
- **Revisions and communications** per assignment
- **Invoices and payments** with status tracking
- **Rate history** recording every rate change

## Database at a Glance (verified against the live database)

| Component | Count |
|---|---|
| Tables | 24 |
| Columns | 176 |
| Foreign keys | 36 |
| CHECK constraints | 25 |
| UNIQUE constraints | 14 |
| Indexes | 66 |
| Triggers | 35 (from 11 trigger functions) |
| Views | 19 (9 active-record views, 10 reporting views) |
| Demo data rows | 687 |
| Verification tests | 53 (all passing) |

## Design Highlights

- **Normalisation:** all tables designed to BCNF. Two third-normal-form
  violations found during design were fixed by extracting `billing_unit`
  and `bank_account` into their own tables.
- **Rules inside the database:** CHECK constraints enforce valid statuses,
  positive rates and payments, date order, and agency rate above
  collaborator rate.
- **Triggers:** block inactive or blacklisted collaborators from
  assignment, enforce the work record status order
  (Submitted, Reviewed, Approved, Paid), limit accounts to 5 language
  pairs, auto-complete projects, and record rate changes.
- **Soft delete:** 11 tables carry `deleted_at`; hard deletes are blocked
  on 9 of them. Active-record views hide deleted rows.
- **Rate history:** a partial unique index guarantees one open rate per
  project.
- **Reporting views:** margin report, pending payments with bank details,
  invoice tracker, collaborator performance and more.
- **Tested:** 53 checks (constraints, triggers, soft delete, views and
  data integrity) in `sql/tests/`, with expected results and a testing
  report in `docs/testing_report.md`.

## Tech Stack

PostgreSQL 15, PL/pgSQL, pgAdmin 4, SQL.

## Quick Start

Requires PostgreSQL 15 and pgAdmin or `psql`.

```sql
CREATE DATABASE linguasync;
\c linguasync
```

## Repository Structure

```
linguasync-postgresql-database/
├── README.md
├── LICENSE
├── .gitignore
├── CHANGELOG.md
├── docs/          data dictionary, design decisions, business rules,
│                  testing report, known limitations, join guide,
│                  normalisation analysis, DBMS fundamentals
├── diagrams/      ER diagram (Chen) and relational schema (Crow's Foot)
├── sql/
│   ├── schema/    tables, triggers, indexes, views, run order
│   ├── demo_data/ fictional demo data, loading notes
│   └── tests/     constraint, trigger, view and integrity tests,
│                  expected and actual results
└── screenshots/   database and test screenshots
```

## Practice Queries

Business and analytical queries for this database (beginner and
intermediate) are kept in a companion repository:
LinguaSync SQL Queries([LINK TO QUERIES REPOSITORY]).
It requires this database to be loaded first.

## Status and Limitations

- Runs locally on PostgreSQL 15. It is not deployed to a server.
- Index performance has not yet been measured at scale, and explicit
  transaction handling is not yet implemented. Both are planned.
- See `docs/known_limitations.md`.

## Author

**OLAJIRE TIMILEHIN YUSUF**
Database and SQL Developer (PostgreSQL)

- GitHub: data-with-yusuf
- LinkedIn: ---
- Upwork: https://www.upwork.com/freelancers/~01ce435412ab906b85
- Email: olajiretimilehin5@gmail.com

## Licence

MIT. See `LICENSE`.