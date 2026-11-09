# LinguaSync Data Dictionary

PostgreSQL 15, schema `public`. 24 tables, 176 columns.
All data is fictional demo data.

**Conventions**
- PK = primary key, FK = foreign key, NN = NOT NULL.
- Surrogate keys are integer columns fed by sequences.
- All timestamps are `timestamp without time zone`.
- Numeric precision shown in brackets is as reported during
  inspection and is not re-verified for every column.
- `varchar` lengths are not documented here.

## Reference tables

### currency
| Column | Type | Null | Notes |
|---|---|---|---|
| currency_id | integer | NN | PK |
| currency_name | varchar | NN | |
| currency_code | varchar | NN | UNIQUE |
| currency_symbol | varchar | | |
| created_at, updated_at | timestamp | NN | default now() |

### billing_unit
| Column | Type | Null | Notes |
|---|---|---|---|
| unit_id | integer | NN | PK |
| billing_unit_name | varchar | NN | UNIQUE |
| unit_description | text | | |
| created_at, updated_at | timestamp | NN | default now() |

### manager_role
| Column | Type | Null | Notes |
|---|---|---|---|
| role_id | integer | NN | PK |
| manager_role_name | varchar | NN | UNIQUE |
| role_description | text | | |
| created_at, updated_at | timestamp | NN | default now() |

### language
| Column | Type | Null | Notes |
|---|---|---|---|
| language_id | integer | NN | PK |
| language_name | varchar | NN | |
| language_code | varchar | NN | UNIQUE |
| language_variant | varchar | | |
| language_display_name | varchar | NN | |
| created_at, updated_at | timestamp | NN | default now() |

### agency
| Column | Type | Null | Notes |
|---|---|---|---|
| agency_id | integer | NN | PK |
| agency_name | varchar | NN | |
| created_at, updated_at | timestamp | NN | default now() |
| deleted_at | timestamp | | soft delete |

## Core tables

### project_type
| Column | Type | Null | Notes |
|---|---|---|---|
| project_type_id | integer | NN | PK |
| project_type_name | varchar | NN | UNIQUE |
| unit_id | integer | NN | FK billing_unit |
| created_at, updated_at | timestamp | NN | default now() |

### project_manager
| Column | Type | Null | Notes |
|---|---|---|---|
| manager_id | integer | NN | PK |
| first_name, last_name | varchar | NN | |
| role_id | integer | NN | FK manager_role |
| email | varchar | NN | UNIQUE |
| created_at, updated_at | timestamp | NN | default now() |
| deleted_at | timestamp | | soft delete |

### collaborator
| Column | Type | Null | Notes |
|---|---|---|---|
| collaborator_id | integer | NN | PK |
| first_name, last_name | varchar | NN | |
| email | varchar | | UNIQUE |
| phone_number | varchar | | |
| employment_status | varchar | NN | default 'Active' |
| assignment_status | varchar | NN | default 'Available' |
| created_at, updated_at | timestamp | NN | default now() |
| deleted_at | timestamp | | soft delete |

### agency_contact
| Column | Type | Null | Notes |
|---|---|---|---|
| contact_id | integer | NN | PK |
| agency_id | integer | NN | FK agency |
| contact_name | varchar | NN | |
| contact_email, phone_number | varchar | | |
| upwork_profile | varchar | | |
| platform_name, platform_username | varchar | | |
| is_primary_contact | boolean | NN | default false |
| created_at, updated_at | timestamp | NN | default now() |
| deleted_at | timestamp | | soft delete |

### exchange_rate
| Column | Type | Null | Notes |
|---|---|---|---|
| rate_id | integer | NN | PK |
| from_currency_id, to_currency_id | integer | NN | FK currency |
| conversion_rate | numeric(18,6) | NN | |
| effective_date | date | NN | |
| created_at | timestamp | NN | default now() |

UNIQUE (from_currency_id, to_currency_id, effective_date).

### language_pair
| Column | Type | Null | Notes |
|---|---|---|---|
| pair_id | integer | NN | PK |
| source_language_id, target_language_id | integer | NN | FK language |
| created_at, updated_at | timestamp | NN | default now() |

UNIQUE (source_language_id, target_language_id).

### translation_project
| Column | Type | Null | Notes |
|---|---|---|---|
| project_id | integer | NN | PK |
| project_name | varchar | NN | |
| project_type_id | integer | NN | FK project_type |
| agency_id | integer | NN | FK agency |
| currency_id | integer | NN | FK currency |
| agency_rate | numeric(10,2) | NN | rate charged to the agency |
| collaborator_rate | numeric(10,2) | NN | default 0 |
| project_status | varchar | NN | default 'Not Assigned' |
| deadline | date | | |
| created_at, updated_at | timestamp | NN | default now() |
| deleted_at | timestamp | | soft delete |

### platform_account
| Column | Type | Null | Notes |
|---|---|---|---|
| account_id | integer | NN | PK |
| account_email | varchar | NN | |
| account_password | varchar | NN | demo values are placeholders |
| platform | varchar | NN | |
| created_at, updated_at | timestamp | NN | default now() |
| deleted_at | timestamp | | soft delete |

UNIQUE (account_email, platform).

### bank_account
| Column | Type | Null | Notes |
|---|---|---|---|
| bank_account_id | integer | NN | PK |
| collaborator_id | integer | NN | FK collaborator |
| bank_name | varchar | | |
| account_number | varchar | NN | UNIQUE |
| account_holder_name | varchar | | |
| created_at, updated_at | timestamp | NN | default now() |
| deleted_at | timestamp | | soft delete |

### rate_history
| Column | Type | Null | Notes |
|---|---|---|---|
| history_id | integer | NN | PK |
| project_id | integer | NN | FK translation_project |
| changed_by_manager_id | integer | NN | FK project_manager |
| agency_rate | numeric(10,2) | NN | |
| collaborator_rate | numeric(10,2) | NN | |
| effective_from | date | NN | |
| effective_to | date | | NULL = currently open |
| created_at | timestamp | NN | default now() |

Partial unique index `uq_active_rate_per_project` on (project_id)
WHERE effective_to IS NULL.

## Junction tables (composite primary keys)

| Table | Primary key | Other columns |
|---|---|---|
| project_pair | (project_id, pair_id) | FKs to translation_project, language_pair |
| account_pair | (account_id, pair_id) | FKs to platform_account, language_pair |
| collaborator_skill | (collaborator_id, language_id) | proficiency_level varchar NN |

## Transaction tables

### project_assignment
| Column | Type | Null | Notes |
|---|---|---|---|
| assignment_id | integer | NN | PK |
| collaborator_id | integer | NN | FK collaborator |
| project_id | integer | NN | FK translation_project |
| account_id | integer | NN | FK platform_account |
| assigned_by_manager_id | integer | NN | FK project_manager |
| assignment_date | date | NN | default CURRENT_DATE |
| created_at, updated_at | timestamp | NN | default now() |
| deleted_at | timestamp | | soft delete |

No unique constraint, by design (see design_decisions.md).

### communication_log
| Column | Type | Null | Notes |
|---|---|---|---|
| log_id | integer | NN | PK |
| assignment_id | integer | NN | FK project_assignment |
| sender_type | varchar | NN | 'PM' or 'Collaborator' |
| manager_sender_id | integer | | FK project_manager, ON DELETE SET NULL |
| collaborator_sender_id | integer | | FK collaborator, ON DELETE SET NULL |
| message_content | text | NN | |
| sent_at | timestamp | NN | default now() |
| created_at | timestamp | NN | default now() |

### work_record
| Column | Type | Null | Notes |
|---|---|---|---|
| record_id | integer | NN | PK |
| assignment_id | integer | NN | FK project_assignment |
| date_started, date_completed | date | | |
| units_completed | integer | NN | default 0 |
| quality_score | smallint | | 1 to 5 when present |
| notes | text | | |
| record_status | varchar | NN | default 'Submitted' |
| created_at, updated_at | timestamp | NN | default now() |
| deleted_at | timestamp | | soft delete |

### agency_invoice
| Column | Type | Null | Notes |
|---|---|---|---|
| invoice_id | integer | NN | PK |
| project_id | integer | NN | FK translation_project |
| agency_id | integer | NN | FK agency |
| currency_id | integer | NN | FK currency |
| invoice_number | varchar | | UNIQUE |
| invoice_amount | numeric(12,2) | NN | |
| date_received | date | | |
| invoice_status | varchar | NN | default 'Pending' |
| upwork_transaction_ref | varchar | | UNIQUE |
| date_paid | date | | |
| created_at, updated_at | timestamp | NN | default now() |
| deleted_at | timestamp | | soft delete |

### collaborator_payment
| Column | Type | Null | Notes |
|---|---|---|---|
| payment_id | integer | NN | PK |
| collaborator_id | integer | NN | FK collaborator |
| project_id | integer | NN | FK translation_project |
| currency_id | integer | NN | FK currency |
| payment_amount | numeric(10,2) | NN | must be greater than 0 |
| payment_date | date | | |
| payment_status | varchar | NN | default 'Pending' |
| transaction_reference | varchar | | UNIQUE |
| created_at, updated_at | timestamp | NN | default now() |
| deleted_at | timestamp | | soft delete |

### revision_log
| Column | Type | Null | Notes |
|---|---|---|---|
| revision_id | integer | NN | PK |
| record_id | integer | NN | FK work_record |
| requested_by_manager_id | integer | NN | FK project_manager |
| resolved_record_id | integer | | FK work_record, ON DELETE SET NULL |
| revision_reason | text | NN | |
| requested_at | timestamp | NN | default now() |
| resolved_at | timestamp | | |
| created_at | timestamp | NN | default now() |

## Allowed status values

| Column | Values |
|---|---|
| collaborator.employment_status | Active, Inactive, Blacklisted |
| collaborator.assignment_status | Available, Assigned, Unavailable |
| collaborator_skill.proficiency_level | Native, Professional |
| translation_project.project_status | Not Assigned, Assigned, Completed, Cancelled, On Hold |
| work_record.record_status | Submitted, Reviewed, Approved, Paid |
| agency_invoice.invoice_status | Pending, Confirmed, Paid, Disputed, Cancelled |
| collaborator_payment.payment_status | Pending, Paid, Failed, Cancelled |
| communication_log.sender_type | PM, Collaborator |

The lists for project_status and invoice_status were partly clipped
when inspected. They match the values used in the demo data.

## Views

**Active-record views (9):** active_agencies, active_agency_invoices,
active_assignments, active_collaborator_payments, active_collaborators,
active_platform_accounts, active_project_managers, active_projects,
active_work_records. Each returns its table's rows where
`deleted_at IS NULL`.

**Reporting views (10) and their columns**

| View | Columns |
|---|---|
| vw_agency_summary | agency_id, agency_name, total_projects, completed_projects, active_projects, total_invoices, total_paid, total_outstanding, currency_code |
| vw_collaborator_directory | collaborator_id, full_name, email, phone_number, employment_status, assignment_status, language_count, languages_and_proficiency |
| vw_collaborator_earnings | collaborator_id, collaborator_name, project_id, project_name, project_type_name, payment_unit, total_assignments, total_units, collaborator_rate, total_earned, currency_code |
| vw_collaborator_performance | collaborator_id, collaborator_name, employment_status, assignment_status, total_assignments, total_projects, total_submissions, total_revisions, revision_rate_percent, avg_quality_score, lowest_score, highest_score |
| vw_invoice_tracker | invoice_id, invoice_number, agency_name, project_name, invoice_amount, currency_code, date_received, invoice_status, days_aging, upwork_transaction_ref, date_paid, payment_flag |
| vw_margin_report | project_id, project_name, agency_name, project_type_name, payment_unit, agency_rate, collaborator_rate, margin_per_unit, currency_code, total_units, total_revenue, total_cost, total_margin |
| vw_pending_payments | collaborator_id, collaborator_name, project_id, project_name, payment_id, payment_amount, currency_code, payment_status, bank_name, account_number, account_holder_name, payment_recorded_at |
| vw_project_dashboard | project_id, project_name, agency_name, project_type_name, payment_unit, agency_rate, collaborator_rate, margin_per_unit, currency_code, project_status, deadline, deadline_flag, created_at |
| vw_revision_tracker | revision_id, collaborator_name, project_name, original_record_id, original_units, current_record_status, revision_requested_by, revision_reason, requested_at, resolved_at, resolution_status, resolved_record_id |
| vw_work_progress | project_id, project_name, agency_name, project_type_name, payment_unit, project_status, total_records, submitted, reviewed, approved, paid, total_units_completed, approval_percentage |

## Indexes (66)

24 primary-key indexes, 14 unique-constraint indexes, 1 standalone
unique partial index, 27 non-unique B-tree indexes. Seven are partial
indexes on `deleted_at IS NULL` (agency, agency_invoice, collaborator,
collaborator_payment, project_assignment, translation_project,
work_record). Full list:

```sql
SELECT tablename, indexname, indexdef
FROM pg_indexes WHERE schemaname = 'public'
ORDER BY tablename, indexname;
```