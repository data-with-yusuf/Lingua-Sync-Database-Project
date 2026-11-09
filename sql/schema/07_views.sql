-- ================================================================
-- BATCH 6 — VIEWS
-- Section 1: Active Views — soft delete filters
-- Section 2: Business Views — reporting and dashboard
-- ================================================================


-- ================================================================
-- SECTION 1 — ACTIVE VIEWS
-- These views filter out soft deleted records automatically
-- ALL application queries should use these views
-- Never query the underlying tables directly in application code
-- Raw table queries are for administration and audit only
-- ================================================================


CREATE VIEW active_agencies AS
SELECT * FROM agency
WHERE deleted_at IS NULL;


CREATE VIEW active_project_managers AS
SELECT * FROM project_manager
WHERE deleted_at IS NULL;


CREATE VIEW active_collaborators AS
SELECT * FROM collaborator
WHERE deleted_at IS NULL;


CREATE VIEW active_projects AS
SELECT * FROM translation_project
WHERE deleted_at IS NULL;


CREATE VIEW active_platform_accounts AS
SELECT * FROM platform_account
WHERE deleted_at IS NULL;


CREATE VIEW active_assignments AS
SELECT * FROM project_assignment
WHERE deleted_at IS NULL;


CREATE VIEW active_work_records AS
SELECT * FROM work_record
WHERE deleted_at IS NULL;


CREATE VIEW active_agency_invoices AS
SELECT * FROM agency_invoice
WHERE deleted_at IS NULL;


CREATE VIEW active_collaborator_payments AS
SELECT * FROM collaborator_payment
WHERE deleted_at IS NULL;


-- ================================================================
-- SECTION 2 — BUSINESS VIEWS
-- Answer common business questions instantly
-- Join multiple tables so application queries stay simple
-- All use active views to exclude soft deleted records
-- ================================================================


-- ----------------------------------------------------------------
-- VIEW 1: VW_PROJECT_DASHBOARD
-- Full project overview with agency, type, payment unit and rates
-- Business question: What projects do we have and what is
-- their current status, type, and agreed rates?
-- ----------------------------------------------------------------

CREATE VIEW vw_project_dashboard AS
SELECT
    p.project_id,
    p.project_name,
    a.agency_name,
    pt.project_type_name,
    bu.billing_unit_name                                AS payment_unit,
    p.agency_rate,
    p.collaborator_rate,
    ROUND(p.agency_rate - p.collaborator_rate, 2)       AS margin_per_unit,
    c.currency_code,
    p.project_status,
    p.deadline,
    CASE
        WHEN p.deadline < CURRENT_DATE
         AND p.project_status NOT IN ('Completed', 'Cancelled')
        THEN 'Overdue'
        ELSE 'On Track'
    END                                                 AS deadline_flag,
    p.created_at
FROM active_projects p
JOIN active_agencies a
    ON p.agency_id          = a.agency_id
JOIN project_type pt
    ON p.project_type_id    = pt.project_type_id
JOIN billing_unit bu
    ON pt.unit_id           = bu.unit_id
JOIN currency c
    ON p.currency_id        = c.currency_id
ORDER BY p.created_at DESC;


-- ----------------------------------------------------------------
-- VIEW 2: VW_COLLABORATOR_DIRECTORY
-- Active collaborators with language skills and current status
-- Business question: Who are our collaborators, what languages
-- do they speak, and are they available for new work?
-- ----------------------------------------------------------------

CREATE VIEW vw_collaborator_directory AS
SELECT
    c.collaborator_id,
    c.first_name || ' ' || c.last_name                 AS full_name,
    c.email,
    c.phone_number,
    c.employment_status,
    c.assignment_status,
    COUNT(cs.language_id)                               AS language_count,
    STRING_AGG(
        l.language_display_name || ' (' || cs.proficiency_level || ')',
        ', '
        ORDER BY cs.proficiency_level, l.language_display_name
    )                                                   AS languages_and_proficiency
FROM active_collaborators c
LEFT JOIN collaborator_skill cs
    ON c.collaborator_id    = cs.collaborator_id
LEFT JOIN language l
    ON cs.language_id       = l.language_id
GROUP BY
    c.collaborator_id,
    c.first_name,
    c.last_name,
    c.email,
    c.phone_number,
    c.employment_status,
    c.assignment_status
ORDER BY
    c.employment_status,
    c.assignment_status,
    c.last_name,
    c.first_name;


-- ----------------------------------------------------------------
-- VIEW 3: VW_PENDING_PAYMENTS
-- All pending collaborator payments with bank transfer details
-- Business question: Who does John owe money to and how much?
-- What are their bank details for transfer?
-- ----------------------------------------------------------------

CREATE VIEW vw_pending_payments AS
SELECT
    c.collaborator_id,
    c.first_name || ' ' || c.last_name                 AS collaborator_name,
    p.project_id,
    p.project_name,
    cp.payment_id,
    cp.payment_amount,
    cu.currency_code,
    cp.payment_status,
    ba.bank_name,
    ba.account_number,
    ba.account_holder_name,
    cp.created_at                                       AS payment_recorded_at
FROM active_collaborator_payments cp
JOIN active_collaborators c
    ON cp.collaborator_id   = c.collaborator_id
JOIN active_projects p
    ON cp.project_id        = p.project_id
JOIN currency cu
    ON cp.currency_id       = cu.currency_id
LEFT JOIN bank_account ba
    ON c.collaborator_id    = ba.collaborator_id
    AND ba.deleted_at       IS NULL
WHERE cp.payment_status = 'Pending'
ORDER BY cp.payment_amount DESC;


-- ----------------------------------------------------------------
-- VIEW 4: VW_INVOICE_TRACKER
-- All invoices with aging — how many days waiting for payment
-- Business question: Which invoices are outstanding?
-- How long have we been waiting?
-- ----------------------------------------------------------------

CREATE VIEW vw_invoice_tracker AS
SELECT
    ai.invoice_id,
    ai.invoice_number,
    a.agency_name,
    p.project_name,
    ai.invoice_amount,
    cu.currency_code,
    ai.date_received,
    ai.invoice_status,
    CASE
        WHEN ai.invoice_status = 'Paid'         THEN 0
        WHEN ai.date_received IS NOT NULL        THEN CURRENT_DATE - ai.date_received
        ELSE NULL
    END                                                 AS days_waiting,
    ai.upwork_transaction_ref,
    ai.date_paid,
    CASE
        WHEN ai.invoice_status != 'Paid'
         AND ai.date_received IS NOT NULL
         AND CURRENT_DATE - ai.date_received > 49
        THEN 'Overdue'
        ELSE 'Within Terms'
    END                                                 AS payment_flag
FROM active_agency_invoices ai
JOIN active_agencies a
    ON ai.agency_id         = a.agency_id
JOIN active_projects p
    ON ai.project_id        = p.project_id
JOIN currency cu
    ON ai.currency_id       = cu.currency_id
ORDER BY
    ai.invoice_status,
    days_waiting DESC NULLS LAST;


-- ----------------------------------------------------------------
-- VIEW 5: VW_WORK_PROGRESS
-- Current progress of all projects by work record status
-- Business question: How far along is each project?
-- How many records are submitted, reviewed, approved, paid?
-- ----------------------------------------------------------------

CREATE VIEW vw_work_progress AS
SELECT
    p.project_id,
    p.project_name,
    a.agency_name,
    pt.project_type_name,
    bu.billing_unit_name                                AS payment_unit,
    p.project_status,
    COUNT(wr.record_id)                                 AS total_records,
    COUNT(CASE WHEN wr.record_status = 'Submitted'
               THEN 1 END)                              AS submitted,
    COUNT(CASE WHEN wr.record_status = 'Reviewed'
               THEN 1 END)                              AS reviewed,
    COUNT(CASE WHEN wr.record_status = 'Approved'
               THEN 1 END)                              AS approved,
    COUNT(CASE WHEN wr.record_status = 'Paid'
               THEN 1 END)                              AS paid,
    COALESCE(SUM(wr.units_completed), 0)                AS total_units_completed,
    ROUND(
        CASE
            WHEN COUNT(wr.record_id) > 0
            THEN COUNT(CASE WHEN wr.record_status
                            IN ('Approved', 'Paid')
                            THEN 1 END) * 100.0
                 / COUNT(wr.record_id)
            ELSE 0
        END, 2
    )                                                   AS approval_percentage
FROM active_projects p
JOIN active_agencies a
    ON p.agency_id          = a.agency_id
JOIN project_type pt
    ON p.project_type_id    = pt.project_type_id
JOIN billing_unit bu
    ON pt.unit_id           = bu.unit_id
LEFT JOIN active_assignments asn
    ON p.project_id         = asn.project_id
LEFT JOIN active_work_records wr
    ON asn.assignment_id    = wr.assignment_id
GROUP BY
    p.project_id,
    p.project_name,
    a.agency_name,
    pt.project_type_name,
    bu.billing_unit_name,
    p.project_status
ORDER BY p.project_name;


-- ----------------------------------------------------------------
-- VIEW 6: VW_MARGIN_REPORT
-- Revenue, cost, and margin per completed project
-- Business question: How much did LinguaSync earn on each
-- completed project after paying collaborators?
-- ----------------------------------------------------------------

CREATE VIEW vw_margin_report AS
SELECT
    p.project_id,
    p.project_name,
    a.agency_name,
    pt.project_type_name,
    bu.billing_unit_name                                AS payment_unit,
    p.agency_rate,
    p.collaborator_rate,
    ROUND(p.agency_rate - p.collaborator_rate, 2)       AS margin_per_unit,
    cu.currency_code,
    COALESCE(SUM(wr.units_completed), 0)                AS total_units,
    ROUND(
        COALESCE(SUM(wr.units_completed), 0)
        * p.agency_rate, 2
    )                                                   AS total_revenue,
    ROUND(
        COALESCE(SUM(wr.units_completed), 0)
        * p.collaborator_rate, 2
    )                                                   AS total_cost,
    ROUND(
        COALESCE(SUM(wr.units_completed), 0)
        * (p.agency_rate - p.collaborator_rate), 2
    )                                                   AS total_margin
FROM active_projects p
JOIN active_agencies a
    ON p.agency_id          = a.agency_id
JOIN project_type pt
    ON p.project_type_id    = pt.project_type_id
JOIN billing_unit bu
    ON pt.unit_id           = bu.unit_id
JOIN currency cu
    ON p.currency_id        = cu.currency_id
LEFT JOIN active_assignments asn
    ON p.project_id         = asn.project_id
LEFT JOIN active_work_records wr
    ON asn.assignment_id    = wr.assignment_id
    AND wr.record_status    IN ('Approved', 'Paid')
WHERE p.project_status = 'Completed'
GROUP BY
    p.project_id,
    p.project_name,
    a.agency_name,
    pt.project_type_name,
    bu.billing_unit_name,
    p.agency_rate,
    p.collaborator_rate,
    cu.currency_code
ORDER BY total_margin DESC;


-- ----------------------------------------------------------------
-- VIEW 7: VW_COLLABORATOR_EARNINGS
-- Earnings per collaborator across all projects
-- Business question: How much has each collaborator earned
-- in total and per project?
-- ----------------------------------------------------------------

CREATE VIEW vw_collaborator_earnings AS
SELECT
    c.collaborator_id,
    c.first_name || ' ' || c.last_name                 AS collaborator_name,
    p.project_id,
    p.project_name,
    pt.project_type_name,
    bu.billing_unit_name                                AS payment_unit,
    COUNT(DISTINCT asn.assignment_id)                   AS total_assignments,
    COALESCE(SUM(wr.units_completed), 0)                AS total_units,
    p.collaborator_rate,
    ROUND(
        COALESCE(SUM(wr.units_completed), 0)
        * p.collaborator_rate, 2
    )                                                   AS total_earned,
    cu.currency_code
FROM active_collaborators c
JOIN active_assignments asn
    ON c.collaborator_id    = asn.collaborator_id
JOIN active_projects p
    ON asn.project_id       = p.project_id
JOIN project_type pt
    ON p.project_type_id    = pt.project_type_id
JOIN billing_unit bu
    ON pt.unit_id           = bu.unit_id
JOIN currency cu
    ON p.currency_id        = cu.currency_id
LEFT JOIN active_work_records wr
    ON asn.assignment_id    = wr.assignment_id
    AND wr.record_status    IN ('Approved', 'Paid')
GROUP BY
    c.collaborator_id,
    c.first_name,
    c.last_name,
    p.project_id,
    p.project_name,
    pt.project_type_name,
    bu.billing_unit_name,
    p.collaborator_rate,
    cu.currency_code
ORDER BY total_earned DESC;


-- ----------------------------------------------------------------
-- VIEW 8: VW_COLLABORATOR_PERFORMANCE
-- Quality and revision statistics per collaborator
-- Business question: Who are our best collaborators based on
-- quality scores and revision rates?
-- ----------------------------------------------------------------

CREATE VIEW vw_collaborator_performance AS
SELECT
    c.collaborator_id,
    c.first_name || ' ' || c.last_name                 AS collaborator_name,
    c.employment_status,
    c.assignment_status,
    COUNT(DISTINCT asn.assignment_id)                   AS total_assignments,
    COUNT(DISTINCT p.project_id)                        AS total_projects,
    COUNT(wr.record_id)                                 AS total_submissions,
    COUNT(rl.revision_id)                               AS total_revisions,
    CASE
        WHEN COUNT(wr.record_id) > 0
        THEN ROUND(
            COUNT(rl.revision_id) * 100.0
            / COUNT(wr.record_id), 2
        )
        ELSE 0
    END                                                 AS revision_rate_percent,
    ROUND(AVG(wr.quality_score), 2)                     AS avg_quality_score,
    MIN(wr.quality_score)                               AS lowest_score,
    MAX(wr.quality_score)                               AS highest_score
FROM active_collaborators c
LEFT JOIN active_assignments asn
    ON c.collaborator_id    = asn.collaborator_id
LEFT JOIN active_projects p
    ON asn.project_id       = p.project_id
LEFT JOIN active_work_records wr
    ON asn.assignment_id    = wr.assignment_id
LEFT JOIN revision_log rl
    ON wr.record_id         = rl.record_id
GROUP BY
    c.collaborator_id,
    c.first_name,
    c.last_name,
    c.employment_status,
    c.assignment_status
ORDER BY
    avg_quality_score DESC NULLS LAST,
    revision_rate_percent ASC;


-- ----------------------------------------------------------------
-- VIEW 9: VW_AGENCY_SUMMARY
-- Summary of activity and payments per agency
-- Business question: Which agencies give us the most work
-- and how much have they paid us?
-- ----------------------------------------------------------------

CREATE VIEW vw_agency_summary AS
SELECT
    a.agency_id,
    a.agency_name,
    COUNT(DISTINCT p.project_id)                        AS total_projects,
    COUNT(DISTINCT CASE
        WHEN p.project_status = 'Completed'
        THEN p.project_id END)                          AS completed_projects,
    COUNT(DISTINCT CASE
        WHEN p.project_status = 'Assigned'
        THEN p.project_id END)                          AS active_projects,
    COUNT(DISTINCT ai.invoice_id)                       AS total_invoices,
    COALESCE(SUM(
        CASE WHEN ai.invoice_status = 'Paid'
        THEN ai.invoice_amount END), 0
    )                                                   AS total_paid,
    COALESCE(SUM(
        CASE WHEN ai.invoice_status
             IN ('Pending', 'Confirmed')
        THEN ai.invoice_amount END), 0
    )                                                   AS total_outstanding,
    cu.currency_code
FROM active_agencies a
LEFT JOIN active_projects p
    ON a.agency_id          = p.agency_id
LEFT JOIN active_agency_invoices ai
    ON p.project_id         = ai.project_id
LEFT JOIN currency cu
    ON p.currency_id        = cu.currency_id
GROUP BY
    a.agency_id,
    a.agency_name,
    cu.currency_code
ORDER BY total_paid DESC NULLS LAST;


-- ----------------------------------------------------------------
-- VIEW 10: VW_REVISION_TRACKER
-- All revision requests with their current resolution status
-- Business question: Which work records have been sent back
-- for revision and have they been resolved?
-- ----------------------------------------------------------------

CREATE VIEW vw_revision_tracker AS
SELECT
    rl.revision_id,
    c.first_name || ' ' || c.last_name                 AS collaborator_name,
    p.project_name,
    wr.record_id                                        AS original_record_id,
    wr.units_completed                                  AS original_units,
    wr.record_status                                    AS current_record_status,
    pm.first_name || ' ' || pm.last_name               AS revision_requested_by,
    rl.revision_reason,
    rl.requested_at,
    rl.resolved_at,
    CASE
        WHEN rl.resolved_at IS NOT NULL THEN 'Resolved'
        ELSE 'Pending Resolution'
    END                                                 AS resolution_status,
    rl.resolved_record_id
FROM revision_log rl
JOIN work_record wr
    ON rl.record_id         = wr.record_id
JOIN project_assignment asn
    ON wr.assignment_id     = asn.assignment_id
JOIN active_collaborators c
    ON asn.collaborator_id  = c.collaborator_id
JOIN active_projects p
    ON asn.project_id       = p.project_id
JOIN active_project_managers pm
    ON rl.requested_by_manager_id = pm.manager_id
ORDER BY
    rl.resolved_at NULLS FIRST,
    rl.requested_at DESC;