# Business Rules

## Rules enforced by CHECK constraints (25)

| Table | Rule |
|---|---|
| collaborator | Email or phone must be present |
| collaborator | employment_status: Active, Inactive, Blacklisted |
| collaborator | assignment_status: Available, Assigned, Unavailable |
| agency_contact | At least one of email, phone, Upwork profile, platform username |
| exchange_rate | conversion_rate > 0 |
| exchange_rate | From and to currency must differ |
| language_pair | Source and target language must differ |
| translation_project | agency_rate > 0 |
| translation_project | collaborator_rate >= 0 |
| translation_project | agency_rate > collaborator_rate |
| translation_project | Status must be an allowed value |
| collaborator_skill | Proficiency: Native or Professional |
| rate_history | effective_to is null or not before effective_from |
| rate_history | agency_rate > collaborator_rate, agency_rate > 0, collaborator_rate >= 0 |
| communication_log | sender_type: PM or Collaborator |
| communication_log | Sender columns must match sender_type |
| work_record | quality_score null or 1 to 5 |
| work_record | record_status: Submitted, Reviewed, Approved, Paid |
| work_record | units_completed >= 0 |
| work_record | date_completed not before date_started |
| agency_invoice | invoice_amount >= 0 |
| agency_invoice | date_paid not before date_received |
| agency_invoice | Status must be an allowed value |
| collaborator_payment | payment_amount > 0 |
| collaborator_payment | Status: Pending, Paid, Failed, Cancelled |

## Other uniqueness rules (14 UNIQUE constraints plus one index)
Currency code, billing unit name, manager role name, language code,
project type name, manager email, collaborator email, bank account
number, invoice number, Upwork transaction reference, payment
transaction reference, (account email + platform), language pair
(source + target), exchange rate (from + to + date). One open
rate per project (partial unique index).

## Rules enforced by triggers (35 triggers, 11 functions)

| Function | Triggers | Behaviour |
|---|---|---|
| fn_update_timestamp | 17 | Sets updated_at on update |
| fn_block_hard_delete | 9 | Rejects DELETE on agency, agency_invoice, collaborator, collaborator_payment, platform_account, project_assignment, project_manager, translation_project, work_record |
| fn_cascade_soft_delete_agency | 1 | Soft-deletes the agency's contacts |
| fn_cascade_soft_delete_collaborator | 1 | Soft-deletes the collaborator's bank accounts |
| fn_check_collaborator_eligibility | 1 | Rejects assignment of Inactive or Blacklisted collaborators |
| fn_set_collaborator_assigned | 1 | Sets assignment_status when an assignment is created |
| fn_enforce_work_record_status_flow | 1 | Enforces Submitted, Reviewed, Approved, Paid order; Paid is final |
| fn_auto_complete_project | 1 | Completes a project when its work records are approved |
| fn_enforce_max_language_pairs | 1 | Limits an account to 5 language pairs |
| fn_check_revision_eligibility | 1 | Allows revisions only on Submitted or Reviewed records |
| fn_sync_rate_history | 1 | Records rate changes in rate_history |

Behaviour confirmed by testing: eligibility block, status flow,
Paid being final, hard-delete block, revision block, max five pairs,
soft-delete cascade and restore, and timestamp update. The
auto-complete and rate-history triggers are described from their
design.

## Workflow rules

- Work record status moves Submitted, Reviewed, Approved, Paid.
- Invoice status: Pending, Confirmed, Paid, Disputed, Cancelled.
- Payment status: Pending, Paid, Failed, Cancelled.
- A project passes through Not Assigned, Assigned, then Completed,
  with Cancelled and On Hold as side states.