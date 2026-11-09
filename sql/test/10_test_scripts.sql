-- ================================================================
-- LINGUASYNC DEMO DATA
-- Demo Batch 10 — Test Scripts
-- ================================================================
-- PURPOSE:
-- Verify every constraint, trigger, view and business rule
-- works exactly as designed
-- Run each test individually
-- Read the expected result before running
-- If result matches expected — test passes
-- If result differs — flag for investigation
-- ================================================================
-- STRUCTURE:
-- Section 1: Constraint Tests
-- Section 2: Trigger Tests
-- Section 3: Soft Delete Tests
-- Section 4: Business View Tests
-- Section 5: Data Integrity Verification Queries
-- ================================================================


-- ================================================================
-- SECTION 1 — CONSTRAINT TESTS
-- Each test should produce an ERROR
-- If no error — the constraint is not working
-- ================================================================


-- ----------------------------------------------------------------
-- TEST 1: Contact method constraint on COLLABORATOR
-- A collaborator must have at least email or phone
-- Expected: ERROR — violates check constraint chk_collaborator_contact
-- ----------------------------------------------------------------
INSERT INTO collaborator
(first_name, last_name, employment_status, assignment_status)
VALUES ('Test', 'NoContact', 'Active', 'Available');


-- ----------------------------------------------------------------
-- TEST 2: Employment status constraint
-- Only Active, Inactive, Blacklisted are valid
-- Expected: ERROR — violates check constraint chk_employment_status
-- ----------------------------------------------------------------
INSERT INTO collaborator
(first_name, last_name, email,
 employment_status, assignment_status)
VALUES ('Test', 'BadStatus', 'test.bad@gmail.com',
        'Suspended', 'Available');


-- ----------------------------------------------------------------
-- TEST 3: Assignment status constraint
-- Only Available, Assigned, Unavailable are valid
-- Expected: ERROR — violates check constraint chk_assignment_status
-- ----------------------------------------------------------------
INSERT INTO collaborator
(first_name, last_name, email,
 employment_status, assignment_status)
VALUES ('Test', 'BadAssign', 'test.assign@gmail.com',
        'Active', 'Busy');


-- ----------------------------------------------------------------
-- TEST 4: Rate constraint — agency rate must exceed collaborator rate
-- Expected: ERROR — violates check constraint chk_rates
-- ----------------------------------------------------------------
INSERT INTO translation_project
(project_name, project_type_id, agency_rate, collaborator_rate,
 project_status, agency_id, currency_id)
VALUES (
    'Test Rate Violation Project',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.05, 0.10,
    'Not Assigned',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
);


-- ----------------------------------------------------------------
-- TEST 5: Agency rate must be positive
-- Expected: ERROR — violates check constraint chk_agency_rate_positive
-- ----------------------------------------------------------------
INSERT INTO translation_project
(project_name, project_type_id, agency_rate, collaborator_rate,
 project_status, agency_id, currency_id)
VALUES (
    'Test Zero Rate Project',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.00, 0.00,
    'Not Assigned',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
);


-- ----------------------------------------------------------------
-- TEST 6: Project status constraint
-- Only valid statuses allowed
-- Expected: ERROR — violates check constraint chk_project_status
-- ----------------------------------------------------------------
INSERT INTO translation_project
(project_name, project_type_id, agency_rate, collaborator_rate,
 project_status, agency_id, currency_id)
VALUES (
    'Test Bad Status Project',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.12, 0.08,
    'In Progress',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
);


-- ----------------------------------------------------------------
-- TEST 7: Work record status constraint
-- Only Submitted, Reviewed, Approved, Paid are valid
-- Expected: ERROR — violates check constraint chk_record_status
-- ----------------------------------------------------------------
INSERT INTO work_record
(assignment_id, units_completed, record_status)
VALUES (
    (SELECT assignment_id FROM project_assignment LIMIT 1),
    1000,
    'Processing'
);


-- ----------------------------------------------------------------
-- TEST 8: Quality score constraint
-- Score must be between 1 and 5
-- Expected: ERROR — violates check constraint chk_quality_score
-- ----------------------------------------------------------------
INSERT INTO work_record
(assignment_id, units_completed, quality_score, record_status)
VALUES (
    (SELECT assignment_id FROM project_assignment LIMIT 1),
    1000,
    6,
    'Submitted'
);


-- ----------------------------------------------------------------
-- TEST 9: Invoice status constraint
-- Only valid statuses allowed
-- Expected: ERROR — violates check constraint chk_invoice_status
-- ----------------------------------------------------------------
INSERT INTO agency_invoice
(project_id, agency_id, currency_id,
 invoice_amount, invoice_status)
VALUES (
    (SELECT project_id FROM translation_project LIMIT 1),
    (SELECT agency_id FROM agency LIMIT 1),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    500.00,
    'Processing'
);


-- ----------------------------------------------------------------
-- TEST 10: Payment status constraint
-- Only Pending, Paid, Failed, Cancelled are valid
-- Expected: ERROR — violates check constraint chk_payment_status
-- ----------------------------------------------------------------
INSERT INTO collaborator_payment
(collaborator_id, project_id, currency_id,
 payment_amount, payment_status)
VALUES (
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'amara.diallo@gmail.com'),
    (SELECT project_id FROM translation_project LIMIT 1),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    100.00,
    'Transferring'
);


-- ----------------------------------------------------------------
-- TEST 11: Language pair direction — same source and target
-- Expected: ERROR — violates check constraint chk_different_languages
-- ----------------------------------------------------------------
INSERT INTO language_pair
(source_language_id, target_language_id)
VALUES (
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    (SELECT language_id FROM language WHERE language_code = 'EN')
);


-- ----------------------------------------------------------------
-- TEST 12: Duplicate language pair
-- English to French already exists
-- Expected: ERROR — violates unique constraint uq_language_pair
-- ----------------------------------------------------------------
INSERT INTO language_pair
(source_language_id, target_language_id)
VALUES (
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    (SELECT language_id FROM language WHERE language_code = 'FR')
);


-- ----------------------------------------------------------------
-- TEST 13: Proficiency level constraint
-- Only Native and Professional are valid
-- Expected: ERROR — violates check constraint chk_proficiency_level
-- ----------------------------------------------------------------
INSERT INTO collaborator_skill
(collaborator_id, language_id, proficiency_level)
VALUES (
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'amara.diallo@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'DE'),
    'Basic'
);


-- ----------------------------------------------------------------
-- TEST 14: Conversion rate must be positive
-- Expected: ERROR — violates check constraint chk_conversion_rate_positive
-- ----------------------------------------------------------------
INSERT INTO exchange_rate
(from_currency_id, to_currency_id, conversion_rate, effective_date)
VALUES (
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    (SELECT currency_id FROM currency WHERE currency_code = 'EUR'),
    0.00,
    '2024-06-01'
);


-- ----------------------------------------------------------------
-- TEST 15: Same currency conversion
-- Expected: ERROR — violates check constraint chk_different_currencies
-- ----------------------------------------------------------------
INSERT INTO exchange_rate
(from_currency_id, to_currency_id, conversion_rate, effective_date)
VALUES (
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    1.00,
    '2024-06-01'
);


-- ----------------------------------------------------------------
-- TEST 16: Account email + platform unique constraint
-- Same email on same platform should fail
-- Expected: ERROR — violates unique constraint uq_account_email_platform
-- ----------------------------------------------------------------
INSERT INTO platform_account
(account_email, account_password, platform)
VALUES (
    'ls.enfr.tg.2023q1@gmail.com',
    'PLACEHOLDER',
    'TransGlobal Portal'
);


-- ----------------------------------------------------------------
-- TEST 17: Payment amount must be positive
-- Expected: ERROR — violates check constraint chk_payment_amount
-- ----------------------------------------------------------------
INSERT INTO collaborator_payment
(collaborator_id, project_id, currency_id,
 payment_amount, payment_status)
VALUES (
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'amara.diallo@gmail.com'),
    (SELECT project_id FROM translation_project LIMIT 1),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    0.00,
    'Pending'
);


-- ----------------------------------------------------------------
-- TEST 18: Sender identity constraint on COMMUNICATION_LOG
-- PM type but no manager_sender_id provided
-- Expected: ERROR — violates check constraint chk_sender_identity
-- ----------------------------------------------------------------
INSERT INTO communication_log
(assignment_id, sender_type,
 manager_sender_id, collaborator_sender_id, message_content)
VALUES (
    (SELECT assignment_id FROM project_assignment LIMIT 1),
    'PM',
    NULL,
    NULL,
    'This message has no identified sender'
);


-- ----------------------------------------------------------------
-- TEST 19: Rate history dates constraint
-- effective_to cannot be before effective_from
-- Expected: ERROR — violates check constraint chk_rate_history_dates
-- ----------------------------------------------------------------
INSERT INTO rate_history
(project_id, changed_by_manager_id, agency_rate,
 collaborator_rate, effective_from, effective_to)
VALUES (
    (SELECT project_id FROM translation_project LIMIT 1),
    (SELECT manager_id FROM project_manager
     WHERE email = 'john.adeyemi@linguasync.com'),
    0.12, 0.08,
    '2024-06-01',
    '2024-05-01'
);


-- ================================================================
-- SECTION 2 — TRIGGER TESTS
-- ================================================================


-- ----------------------------------------------------------------
-- TEST 20: Blacklisted collaborator cannot be assigned
-- Kwame Asante is blacklisted
-- Expected: ERROR — from fn_check_collaborator_eligibility trigger
-- ----------------------------------------------------------------
INSERT INTO project_assignment
(collaborator_id, project_id, account_id,
 assigned_by_manager_id, assignment_date)
VALUES (
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'kwame.asante@gmail.com'),
    (SELECT project_id FROM translation_project
     WHERE project_name =
     'TransGlobal English to German Human Translation 2024 Q3'),
    (SELECT account_id FROM platform_account LIMIT 1),
    (SELECT manager_id FROM project_manager
     WHERE email = 'john.adeyemi@linguasync.com'),
    CURRENT_DATE
);


-- ----------------------------------------------------------------
-- TEST 21: Inactive collaborator cannot be assigned
-- Ahmed Hassan is inactive
-- Expected: ERROR — from fn_check_collaborator_eligibility trigger
-- ----------------------------------------------------------------
INSERT INTO project_assignment
(collaborator_id, project_id, account_id,
 assigned_by_manager_id, assignment_date)
VALUES (
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'ahmed.hassan@gmail.com'),
    (SELECT project_id FROM translation_project
     WHERE project_name =
     'TransGlobal English to German Human Translation 2024 Q3'),
    (SELECT account_id FROM platform_account LIMIT 1),
    (SELECT manager_id FROM project_manager
     WHERE email = 'john.adeyemi@linguasync.com'),
    CURRENT_DATE
);


-- ----------------------------------------------------------------
-- TEST 22: Work record status flow — invalid transition
-- Cannot go from Submitted directly to Approved
-- Expected: ERROR — from fn_enforce_work_record_status_flow trigger
-- ----------------------------------------------------------------
UPDATE work_record
SET record_status = 'Approved'
WHERE record_id = (
    SELECT wr.record_id
    FROM work_record wr
    WHERE wr.record_status = 'Submitted'
    LIMIT 1
);


-- ----------------------------------------------------------------
-- TEST 23: Work record status flow — Paid is final
-- Cannot change status once Paid
-- Expected: ERROR — from fn_enforce_work_record_status_flow trigger
-- ----------------------------------------------------------------
UPDATE work_record
SET record_status = 'Submitted'
WHERE record_id = (
    SELECT wr.record_id
    FROM work_record wr
    WHERE wr.record_status = 'Paid'
    LIMIT 1
);


-- ----------------------------------------------------------------
-- TEST 24: Maximum language pairs per account — 5 is the limit
-- Find an account that already has 1 pair and add 4 more
-- Then try to add a 6th — should fail
-- Step 1: Find an account with exactly 1 pair
-- Step 2: Add pairs 2 through 5
-- Step 3: Try to add pair 6 — should fail
-- Expected: ERROR on 6th insert from fn_enforce_max_language_pairs
-- ----------------------------------------------------------------

-- Step 1: Check current pair count on first account
SELECT
    pa.account_email,
    pa.platform,
    COUNT(ap.pair_id)           AS current_pair_count
FROM platform_account pa
JOIN account_pair ap
    ON pa.account_id = ap.account_id
WHERE pa.account_email = 'ls.enfr.tg.2023q1@gmail.com'
AND pa.platform = 'TransGlobal Portal'
GROUP BY pa.account_email, pa.platform;

-- Step 2: Add pairs 2 through 5 to that account
-- (Only run if current_pair_count = 1 from step above)
INSERT INTO account_pair (account_id, pair_id)
VALUES (
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enfr.tg.2023q1@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id =
     (SELECT language_id FROM language WHERE language_code = 'EN')
     AND target_language_id =
     (SELECT language_id FROM language WHERE language_code = 'DE'))
);
INSERT INTO account_pair (account_id, pair_id)
VALUES (
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enfr.tg.2023q1@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id =
     (SELECT language_id FROM language WHERE language_code = 'EN')
     AND target_language_id =
     (SELECT language_id FROM language WHERE language_code = 'ES'))
);
INSERT INTO account_pair (account_id, pair_id)
VALUES (
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enfr.tg.2023q1@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id =
     (SELECT language_id FROM language WHERE language_code = 'EN')
     AND target_language_id =
     (SELECT language_id FROM language WHERE language_code = 'AR'))
);
INSERT INTO account_pair (account_id, pair_id)
VALUES (
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enfr.tg.2023q1@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id =
     (SELECT language_id FROM language WHERE language_code = 'EN')
     AND target_language_id =
     (SELECT language_id FROM language WHERE language_code = 'JA'))
);

-- Step 3: Try to add a 6th pair — this should fail
-- Expected: ERROR — Account already has maximum of 5 language pairs
INSERT INTO account_pair (account_id, pair_id)
VALUES (
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enfr.tg.2023q1@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id =
     (SELECT language_id FROM language WHERE language_code = 'EN')
     AND target_language_id =
     (SELECT language_id FROM language WHERE language_code = 'IT'))
);

-- Step 4: Clean up the test pairs we added
-- Run this after confirming the 6th pair failed
DELETE FROM account_pair
WHERE account_id = (
    SELECT account_id FROM platform_account
    WHERE account_email = 'ls.enfr.tg.2023q1@gmail.com'
    AND platform = 'TransGlobal Portal'
)
AND pair_id IN (
    SELECT pair_id FROM language_pair WHERE
    source_language_id =
    (SELECT language_id FROM language WHERE language_code = 'EN')
    AND target_language_id IN (
        SELECT language_id FROM language
        WHERE language_code IN ('DE','ES','AR','JA')
    )
);


-- ----------------------------------------------------------------
-- TEST 25: Revision cannot be requested on Approved work record
-- Expected: ERROR — from fn_check_revision_eligibility trigger
-- ----------------------------------------------------------------
INSERT INTO revision_log
(record_id, requested_by_manager_id, revision_reason)
VALUES (
    (SELECT record_id FROM work_record
     WHERE record_status = 'Approved'
     LIMIT 1),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    'Testing revision on approved record — should fail'
);


-- ----------------------------------------------------------------
-- TEST 26: Revision cannot be requested on Paid work record
-- Expected: ERROR — from fn_check_revision_eligibility trigger
-- ----------------------------------------------------------------
INSERT INTO revision_log
(record_id, requested_by_manager_id, revision_reason)
VALUES (
    (SELECT record_id FROM work_record
     WHERE record_status = 'Paid'
     LIMIT 1),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    'Testing revision on paid record — should fail'
);


-- ----------------------------------------------------------------
-- TEST 27: Hard delete blocked on COLLABORATOR
-- Expected: ERROR — from fn_block_hard_delete trigger
-- ----------------------------------------------------------------
DELETE FROM collaborator
WHERE email = 'amara.diallo@gmail.com';


-- ----------------------------------------------------------------
-- TEST 28: Hard delete blocked on TRANSLATION_PROJECT
-- Expected: ERROR — from fn_block_hard_delete trigger
-- ----------------------------------------------------------------
DELETE FROM translation_project
WHERE project_name =
  'TransGlobal English to French Human Translation 2023 Q1';


-- ----------------------------------------------------------------
-- TEST 29: Hard delete blocked on AGENCY_INVOICE
-- Expected: ERROR — from fn_block_hard_delete trigger
-- ----------------------------------------------------------------
DELETE FROM agency_invoice
WHERE invoice_number = 'TG-2023-001';


-- ----------------------------------------------------------------
-- TEST 30: Auto-update timestamp trigger
-- Update any record and check updated_at changes
-- Expected: updated_at timestamp is now different from created_at
-- ----------------------------------------------------------------

-- Check before
SELECT
    collaborator_id,
    first_name,
    created_at,
    updated_at
FROM collaborator
WHERE email = 'pierre.dubois@gmail.com';

-- Make a change
UPDATE collaborator
SET phone_number = '+33612345679'
WHERE email = 'pierre.dubois@gmail.com';

-- Check after — updated_at should be newer than before
SELECT
    collaborator_id,
    first_name,
    created_at,
    updated_at
FROM collaborator
WHERE email = 'pierre.dubois@gmail.com';


-- ================================================================
-- SECTION 3 — SOFT DELETE TESTS
-- ================================================================


-- ----------------------------------------------------------------
-- TEST 31: Soft delete a collaborator
-- Ahmed Hassan should be soft deleted
-- Expected:
--   active_collaborators excludes him
--   collaborator table still has him with deleted_at set
--   bank_account also gets deleted_at set automatically
-- ----------------------------------------------------------------

-- Step 1: Soft delete Ahmed Hassan
UPDATE collaborator
SET deleted_at = NOW()
WHERE email = 'ahmed.hassan@gmail.com';

-- Step 2: Verify active view excludes him
SELECT
    collaborator_id,
    first_name,
    last_name,
    employment_status,
    deleted_at
FROM active_collaborators
WHERE email = 'ahmed.hassan@gmail.com';
-- Expected: 0 rows

-- Step 3: Verify raw table still has him
SELECT
    collaborator_id,
    first_name,
    last_name,
    employment_status,
    deleted_at
FROM collaborator
WHERE email = 'ahmed.hassan@gmail.com';
-- Expected: 1 row with deleted_at timestamp set

-- Step 4: Verify cascade trigger soft deleted his bank account
SELECT
    ba.bank_account_id,
    ba.bank_name,
    ba.account_number,
    ba.deleted_at
FROM bank_account ba
JOIN collaborator c
    ON ba.collaborator_id = c.collaborator_id
WHERE c.email = 'ahmed.hassan@gmail.com';
-- Expected: 1 row with deleted_at timestamp set


-- ----------------------------------------------------------------
-- TEST 32: Verify historical data is preserved after soft delete
-- Ahmed's work records and payments must still exist
-- ----------------------------------------------------------------

-- Work records still traceable
SELECT
    wr.record_id,
    wr.units_completed,
    wr.record_status,
    wr.quality_score,
    tp.project_name
FROM work_record wr
JOIN project_assignment pa
    ON wr.assignment_id = pa.assignment_id
JOIN collaborator c
    ON pa.collaborator_id = c.collaborator_id
JOIN translation_project tp
    ON pa.project_id = tp.project_id
WHERE c.email = 'ahmed.hassan@gmail.com';
-- Expected: 1 row — Dutch project work record still visible

-- Payment still traceable
SELECT
    cp.payment_id,
    cp.payment_amount,
    cp.payment_status,
    cp.transaction_reference
FROM collaborator_payment cp
JOIN collaborator c
    ON cp.collaborator_id = c.collaborator_id
WHERE c.email = 'ahmed.hassan@gmail.com';
-- Expected: 1 row — payment still exists


-- ----------------------------------------------------------------
-- TEST 33: Restore Ahmed Hassan
-- Verify he reappears in active views
-- ----------------------------------------------------------------

UPDATE collaborator
SET deleted_at = NULL
WHERE email = 'ahmed.hassan@gmail.com';

-- Verify he is back in active view
SELECT
    collaborator_id,
    first_name,
    last_name,
    deleted_at
FROM active_collaborators
WHERE email = 'ahmed.hassan@gmail.com';
-- Expected: 1 row — Ahmed Hassan restored


-- ----------------------------------------------------------------
-- TEST 34: Soft delete an agency and verify contacts cascade
-- ----------------------------------------------------------------

-- Step 1: Check VerboTech contacts before delete
SELECT
    contact_id,
    contact_name,
    deleted_at
FROM agency_contact
WHERE agency_id = (
    SELECT agency_id FROM agency
    WHERE agency_name = 'VerboTech Agency'
);
-- Expected: 1 row with deleted_at = NULL

-- Step 2: Soft delete VerboTech
UPDATE agency
SET deleted_at = NOW()
WHERE agency_name = 'VerboTech Agency';

-- Step 3: Verify VerboTech gone from active agencies
SELECT agency_id, agency_name, deleted_at
FROM active_agencies
WHERE agency_name = 'VerboTech Agency';
-- Expected: 0 rows

-- Step 4: Verify cascade soft deleted the contact
SELECT
    contact_id,
    contact_name,
    deleted_at
FROM agency_contact
WHERE agency_id = (
    SELECT agency_id FROM agency
    WHERE agency_name = 'VerboTech Agency'
);
-- Expected: 1 row with deleted_at timestamp set

-- Step 5: Restore VerboTech for remaining tests
UPDATE agency
SET deleted_at = NULL
WHERE agency_name = 'VerboTech Agency';

-- Step 6: Restore VerboTech contact
UPDATE agency_contact
SET deleted_at = NULL
WHERE agency_id = (
    SELECT agency_id FROM agency
    WHERE agency_name = 'VerboTech Agency'
);


-- ================================================================
-- SECTION 4 — BUSINESS VIEW TESTS
-- ================================================================


-- ----------------------------------------------------------------
-- TEST 35: Project dashboard view
-- Expected: 60 rows — all active projects with correct details
-- ----------------------------------------------------------------
SELECT
    COUNT(*)                    AS total_projects,
    COUNT(CASE WHEN project_status = 'Completed'
               THEN 1 END)     AS completed,
    COUNT(CASE WHEN project_status = 'Assigned'
               THEN 1 END)     AS assigned,
    COUNT(CASE WHEN project_status = 'Not Assigned'
               THEN 1 END)     AS not_assigned,
    COUNT(CASE WHEN project_status = 'Cancelled'
               THEN 1 END)     AS cancelled,
    COUNT(CASE WHEN project_status = 'On Hold'
               THEN 1 END)     AS on_hold,
    COUNT(CASE WHEN deadline_flag = 'Overdue'
               THEN 1 END)     AS overdue
FROM vw_project_dashboard;
-- Expected: 60, 39, 10, 5, 3, 3, and overdue count


-- ----------------------------------------------------------------
-- TEST 36: Collaborator directory view
-- Expected: 13 rows — active collaborators only
-- Ahmed Hassan and Kwame Asante excluded
-- ----------------------------------------------------------------
SELECT
    COUNT(*)                    AS active_collaborators,
    COUNT(CASE WHEN assignment_status = 'Available'
               THEN 1 END)     AS available,
    COUNT(CASE WHEN assignment_status = 'Assigned'
               THEN 1 END)     AS assigned,
    COUNT(CASE WHEN language_count >= 3
               THEN 1 END)     AS multilingual
FROM vw_collaborator_directory;
-- Expected: 13 active, mix of available and assigned, several multilingual


-- ----------------------------------------------------------------
-- TEST 37: Agency summary view
-- Expected: 4 rows — one per agency
-- ----------------------------------------------------------------
SELECT
    agency_name,
    total_projects,
    completed_projects,
    active_projects,
    cancelled_projects,
    on_hold_projects
FROM vw_agency_summary
ORDER BY total_projects DESC;
-- Expected:
-- TransGlobal: 20 total, 10 completed, some active, some cancelled
-- LinguaWorld: 16 total, 8 completed, some active
-- GlobalLang:  13 total
-- VerboTech:   11 total, most cancelled


-- ----------------------------------------------------------------
-- TEST 38: Margin report view
-- Expected: 39 rows — all completed projects
-- All should show revenue, cost and margin
-- ----------------------------------------------------------------
SELECT
    COUNT(*)                                    AS completed_projects,
    ROUND(SUM(total_revenue), 2)                AS grand_revenue,
    ROUND(SUM(total_cost), 2)                   AS grand_cost,
    ROUND(SUM(total_margin), 2)                 AS grand_margin,
    ROUND(AVG(margin_per_unit), 4)              AS avg_margin_per_unit
FROM vw_margin_report;
-- Expected: 39 projects with revenue, cost and margin totals


-- ----------------------------------------------------------------
-- TEST 39: Pending payments view
-- Expected: 8 rows — all 2024 Q1 collaborator payments
-- ----------------------------------------------------------------
SELECT
    COUNT(*)                    AS pending_payments,
    ROUND(SUM(payment_amount), 2) AS total_pending
FROM vw_pending_payments;
-- Expected: 8 pending payments with total amount


-- ----------------------------------------------------------------
-- TEST 40: Invoice tracker view
-- Expected: 60 rows — one per project
-- ----------------------------------------------------------------
SELECT
    invoice_status,
    COUNT(*)                    AS invoice_count,
    ROUND(SUM(invoice_amount), 2) AS total_amount
FROM vw_invoice_tracker
GROUP BY invoice_status
ORDER BY invoice_count DESC;
-- Expected:
-- Pending: 21 rows at $0
-- Paid: 30 rows with amounts
-- Confirmed: 9 rows with amounts
-- Cancelled: 3 rows at $0


-- ----------------------------------------------------------------
-- TEST 41: Work progress view
-- Expected: 60 rows — all projects including those with no records
-- ----------------------------------------------------------------
SELECT
    COUNT(*)                        AS total_projects,
    COUNT(CASE WHEN total_records > 0
               THEN 1 END)          AS projects_with_records,
    COUNT(CASE WHEN total_records = 0
               THEN 1 END)          AS projects_without_records,
    ROUND(AVG(approval_percentage), 2) AS avg_approval_pct
FROM vw_work_progress;
-- Expected: 60 projects, mix with and without records


-- ----------------------------------------------------------------
-- TEST 42: Collaborator performance view
-- Expected: 13 rows — active collaborators
-- Quality scores for those with approved/paid work
-- ----------------------------------------------------------------
SELECT
    collaborator_name,
    total_submissions,
    total_revisions,
    revision_rate_percent,
    avg_quality_score
FROM vw_collaborator_performance
ORDER BY avg_quality_score DESC NULLS LAST;
-- Expected: Rankings with Amara, Klaus, Yuki near top
-- Collaborators with only active work show NULL quality score


-- ----------------------------------------------------------------
-- TEST 43: Collaborator earnings view
-- Expected: Rows per collaborator per project
-- ----------------------------------------------------------------
SELECT
    collaborator_name,
    COUNT(DISTINCT project_id)          AS projects,
    ROUND(SUM(total_earned), 2)         AS total_earned
FROM vw_collaborator_earnings
GROUP BY collaborator_name
ORDER BY total_earned DESC;
-- Expected: Yuki, Lucia, Sofia near top from Japanese and IT projects


-- ----------------------------------------------------------------
-- TEST 44: Revision tracker view
-- Expected: 4 rows — all revision log entries
-- ----------------------------------------------------------------
SELECT
    collaborator_name,
    project_name,
    revision_requested_by,
    resolution_status,
    requested_at,
    resolved_at
FROM vw_revision_tracker
ORDER BY requested_at;
-- Expected: 4 rows — 3 resolved, 1 pending (Yara Arabic MTPE)


-- ================================================================
-- SECTION 5 — DATA INTEGRITY VERIFICATION
-- ================================================================


-- ----------------------------------------------------------------
-- TEST 45: Verify all 60 projects have exactly one rate history
-- record with effective_to = NULL (active rate)
-- ----------------------------------------------------------------
SELECT
    COUNT(*)                    AS projects_with_active_rate
FROM rate_history
WHERE effective_to IS NULL;
-- Expected: 60 — one per project


-- ----------------------------------------------------------------
-- TEST 46: Verify no project has two active rates
-- Should return 0 if partial unique index is working
-- ----------------------------------------------------------------
SELECT
    project_id,
    COUNT(*)                    AS active_rate_count
FROM rate_history
WHERE effective_to IS NULL
GROUP BY project_id
HAVING COUNT(*) > 1;
-- Expected: 0 rows — each project has exactly one active rate


-- ----------------------------------------------------------------
-- TEST 47: Verify all FK relationships are intact
-- No orphaned records anywhere
-- ----------------------------------------------------------------

-- Assignments with no matching project
SELECT COUNT(*) AS orphaned_assignments
FROM project_assignment pa
WHERE NOT EXISTS (
    SELECT 1 FROM translation_project tp
    WHERE tp.project_id = pa.project_id
);
-- Expected: 0

-- Work records with no matching assignment
SELECT COUNT(*) AS orphaned_work_records
FROM work_record wr
WHERE NOT EXISTS (
    SELECT 1 FROM project_assignment pa
    WHERE pa.assignment_id = wr.assignment_id
);
-- Expected: 0

-- Invoices with no matching project
SELECT COUNT(*) AS orphaned_invoices
FROM agency_invoice ai
WHERE NOT EXISTS (
    SELECT 1 FROM translation_project tp
    WHERE tp.project_id = ai.project_id
);
-- Expected: 0

-- Payments with no matching collaborator
SELECT COUNT(*) AS orphaned_payments
FROM collaborator_payment cp
WHERE NOT EXISTS (
    SELECT 1 FROM collaborator c
    WHERE c.collaborator_id = cp.collaborator_id
);
-- Expected: 0


-- ----------------------------------------------------------------
-- TEST 48: Verify all completed projects have work records
-- ----------------------------------------------------------------
SELECT
    tp.project_name,
    tp.project_status,
    COUNT(wr.record_id)         AS work_record_count
FROM translation_project tp
LEFT JOIN project_assignment pa
    ON tp.project_id = pa.project_id
LEFT JOIN work_record wr
    ON pa.assignment_id = wr.assignment_id
WHERE tp.project_status = 'Completed'
GROUP BY tp.project_id, tp.project_name, tp.project_status
HAVING COUNT(wr.record_id) = 0;
-- Expected: 0 rows — all completed projects have work records


-- ----------------------------------------------------------------
-- TEST 49: Verify all 2023 work records are Paid status
-- ----------------------------------------------------------------
SELECT
    EXTRACT(YEAR FROM tp.deadline)  AS project_year,
    wr.record_status,
    COUNT(*)                        AS record_count
FROM work_record wr
JOIN project_assignment pa
    ON wr.assignment_id = pa.assignment_id
JOIN translation_project tp
    ON pa.project_id = tp.project_id
WHERE EXTRACT(YEAR FROM tp.deadline) = 2023
GROUP BY
    EXTRACT(YEAR FROM tp.deadline),
    wr.record_status
ORDER BY record_status;
-- Expected: All 2023 records should show Paid status


-- ----------------------------------------------------------------
-- TEST 50: Financial reconciliation check
-- Total invoice amounts should exceed total payments
-- John's margin is the difference
-- ----------------------------------------------------------------
SELECT
    ROUND(SUM(CASE WHEN ai.invoice_status = 'Paid'
              THEN ai.invoice_amount ELSE 0 END), 2)
                                    AS total_received_from_agencies,
    ROUND(SUM(CASE WHEN cp.payment_status = 'Paid'
              THEN cp.payment_amount ELSE 0 END), 2)
                                    AS total_paid_to_collaborators,
    ROUND(
        SUM(CASE WHEN ai.invoice_status = 'Paid'
            THEN ai.invoice_amount ELSE 0 END)
        -
        SUM(CASE WHEN cp.payment_status = 'Paid'
            THEN cp.payment_amount ELSE 0 END)
    , 2)                            AS johns_total_margin
FROM (SELECT SUM(invoice_amount) AS invoice_amount,
             invoice_status
      FROM agency_invoice
      GROUP BY invoice_status) ai,
     (SELECT SUM(payment_amount) AS payment_amount,
             payment_status
      FROM collaborator_payment
      GROUP BY payment_status) cp;
-- Expected: Received > Paid and margin is positive


-- ----------------------------------------------------------------
-- TEST 51: Verify collaborator assignment status was auto-updated
-- All collaborators with active assignments should show Assigned
-- ----------------------------------------------------------------
SELECT
    c.first_name || ' ' || c.last_name     AS collaborator_name,
    c.assignment_status,
    COUNT(pa.assignment_id)                 AS active_assignments
FROM collaborator c
LEFT JOIN project_assignment pa
    ON c.collaborator_id = pa.collaborator_id
    AND pa.deleted_at IS NULL
WHERE c.employment_status = 'Active'
GROUP BY
    c.collaborator_id,
    c.first_name,
    c.last_name,
    c.assignment_status
ORDER BY active_assignments DESC;
-- Expected: Collaborators with assignments show Assigned status


-- ----------------------------------------------------------------
-- TEST 52: Rate history sync verification
-- Rates on TRANSLATION_PROJECT must match active RATE_HISTORY
-- ----------------------------------------------------------------
SELECT
    tp.project_name,
    tp.agency_rate                          AS project_agency_rate,
    rh.agency_rate                          AS history_agency_rate,
    tp.collaborator_rate                    AS project_collab_rate,
    rh.collaborator_rate                    AS history_collab_rate,
    CASE
        WHEN tp.agency_rate = rh.agency_rate
         AND tp.collaborator_rate = rh.collaborator_rate
        THEN 'In Sync'
        ELSE 'OUT OF SYNC'
    END                                     AS sync_status
FROM translation_project tp
JOIN rate_history rh
    ON tp.project_id = rh.project_id
    AND rh.effective_to IS NULL
ORDER BY sync_status DESC;
-- Expected: All rows show In Sync
-- Any OUT OF SYNC rows indicate a data issue


-- ----------------------------------------------------------------
-- TEST 53: Complete business story verification
-- The full flow from agency to payment for one project
-- ----------------------------------------------------------------
SELECT
    a.agency_name,
    tp.project_name,
    pt.project_type_name,
    bu.billing_unit_name,
    tp.agency_rate,
    tp.collaborator_rate,
    ROUND(tp.agency_rate - tp.collaborator_rate, 2)
                                            AS margin_per_unit,
    c.first_name || ' ' || c.last_name     AS collaborator,
    wr.units_completed,
    wr.record_status,
    wr.quality_score,
    ROUND(wr.units_completed * tp.agency_rate, 2)
                                            AS revenue,
    ROUND(wr.units_completed * tp.collaborator_rate, 2)
                                            AS cost,
    ROUND(wr.units_completed
          * (tp.agency_rate - tp.collaborator_rate), 2)
                                            AS margin,
    ai.invoice_status,
    ai.invoice_amount,
    cp.payment_status,
    cp.payment_amount
FROM translation_project tp
JOIN agency a
    ON tp.agency_id             = a.agency_id
JOIN project_type pt
    ON tp.project_type_id       = pt.project_type_id
JOIN billing_unit bu
    ON pt.unit_id               = bu.unit_id
JOIN project_assignment pa
    ON tp.project_id            = pa.project_id
JOIN collaborator c
    ON pa.collaborator_id       = c.collaborator_id
JOIN work_record wr
    ON pa.assignment_id         = wr.assignment_id
JOIN agency_invoice ai
    ON tp.project_id            = ai.project_id
JOIN collaborator_payment cp
    ON tp.project_id            = cp.project_id
    AND c.collaborator_id       = cp.collaborator_id
WHERE tp.project_name =
    'TransGlobal English to French Human Translation 2023 Q1'
ORDER BY c.last_name;
-- Expected: 2 rows (Amara and Pierre)
-- Full business story from agency to payment visible in one query