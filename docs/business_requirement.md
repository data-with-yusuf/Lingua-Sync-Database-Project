# Business Requirements

LinguaSync models a freelance translation business. All data in this
repository is fictional demo data.

## 1. Purpose

Translation agencies commission projects. The business assigns
collaborators (freelance translators) to do the work, reviews it,
invoices the agency, and pays the collaborators. The business keeps the
difference between what the agency pays and what the collaborator is
paid.

Before the database, this was tracked in spreadsheets and messages.
The goal is one reliable record of projects, people, work quality,
invoices and payments, with the rules enforced by the database.

## 2. Business context

- Agencies commission projects and pay the business, with payment
  arriving some weeks after completion through Upwork.
- Collaborators are paid by bank transfer.
- Work is submitted through platform accounts on the agency portals.
- Amounts in the demo data are in USD.
- Project managers (one Principal, others Supporting) assign
  collaborators, review work and request revisions.

## 3. Project types and billing units

| Project type | Billed per |
|---|---|
| Human Translation | Word |
| Long Context Acceptability | Hit |
| Machine Translation Post-Editing | Segment |

## 4. Business requirements

**Agencies and contacts**
- R1. Record each agency and its contacts. A contact needs at least
  one way of being reached.

**Projects and rates**
- R2. Record each project with its agency, type, currency, deadline and
  status (Not Assigned, Assigned, Completed, Cancelled, On Hold).
- R3. Each project has an agency rate and a collaborator rate. The
  agency rate must be positive and higher than the collaborator rate.
- R4. Rates can change. Every change is kept in rate history, and only
  one rate per project is open at a time.
- R5. A project can cover one or more language pairs.

**Collaborators**
- R6. Record collaborators with at least an email or a phone number.
- R7. Record their language skills as Native or Professional.
- R8. Track employment status (Active, Inactive, Blacklisted) and
  assignment status (Available, Assigned, Unavailable).
- R9. Inactive and blacklisted collaborators cannot be assigned.
- R10. Record bank details for payment.

**Platform accounts**
- R11. Record the accounts used to access agency portals, with the
  language pairs registered on each. An account holds at most five
  pairs.

**Assignments and work**
- R12. Assign a collaborator to a project through a platform account,
  recording the manager who made the assignment.
- R13. The same collaborator may work several accounts on one project,
  and several collaborators may share a project.
- R14. Record work submitted: dates, units completed and a quality
  score from 1 to 5.
- R15. Work moves Submitted, Reviewed, Approved, Paid, in that order.
  Paid is final.
- R16. A project completes automatically when its work is approved.
- R17. Managers can request revisions on Submitted or Reviewed work,
  and the resolution is recorded.
- R18. Keep a message log for each assignment, sent by either a
  manager or a collaborator.

**Money**
- R19. One invoice per project from the agency, with status Pending,
  Confirmed, Paid, Disputed or Cancelled.
- R20. Collaborator payments must be greater than zero, with status
  Pending, Paid, Failed or Cancelled.
- R21. Support more than one currency, with recorded exchange rates.

**Data protection**
- R22. History must not be destroyed. Records are soft deleted, and
  hard deletes are blocked on the main tables.
- R23. Every change refreshes an updated timestamp.

## 5. Reporting needs

| Question | View |
|---|---|
| What projects exist, and are they late? | vw_project_dashboard |
| How profitable is each project? | vw_margin_report |
| Who is owed money, and where do we pay them? | vw_pending_payments |
| Which invoices are unpaid and how old? | vw_invoice_tracker |
| How far along is each project? | vw_work_progress |
| Who performs well, and who needs revisions? | vw_collaborator_performance |
| What has each collaborator earned? | vw_collaborator_earnings |
| Who can take new work, and in which languages? | vw_collaborator_directory |
| How does each agency compare? | vw_agency_summary |
| Which revisions are still open? | vw_revision_tracker |

## 6. Assumptions and out of scope

- Language eligibility for an account is decided on the agency
  platform, so the database does not check collaborator skills against
  account language pairs.
- Payments are entered, not calculated, by the database.
- No application, user roles or currency conversion in reports.
- Single business, single currency in the demo data.

## 7. Where each requirement is implemented

Constraints and triggers are listed in `business_rules.md`. Reasons
for the main choices are in `design_decisions.md`.