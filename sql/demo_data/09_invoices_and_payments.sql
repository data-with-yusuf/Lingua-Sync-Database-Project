-- ================================================================
-- LINGUASYNC DEMO DATA
-- Demo Batch 9 — Revision Log, Agency Invoices,
-- Collaborator Payments
-- ================================================================
-- REVISION LOG:
-- Two revision scenarios
-- Revision 1: Project 14 — Ahmed Hassan poor quality
--             Requested but project already completed
--             resolved_record_id points to same record
--             after resubmission
-- Revision 2: Project 21 — Yuki Turkish LCA
--             Quality was below standard (score 3)
--             PM requested revision
--             Resolved and approved
-- Revision 3: Project 41 — Yara active project
--             PM reviewed and sent back
--             Still pending resolution
-- Revision 4: Project 44 — Carlos active project
--             Submitted — PM will review
--             Still pending
--
-- AGENCY INVOICES:
-- One invoice per project
-- 2023 projects: all Paid
-- 2024 Q1 completed projects: Confirmed
-- 2024 Q2 active projects: Pending
-- Cancelled projects: Cancelled invoice status
-- On Hold projects: Pending invoice status
--
-- COLLABORATOR PAYMENTS:
-- All 2023 Paid work records have Paid payments
-- All 2024 Q1 Approved records have Pending payments
-- Active records have no payments yet
-- Ahmed Hassan payment is Paid — historical
-- ================================================================


-- ================================================================
-- SECTION 1 — REVISION LOG
-- ================================================================

INSERT INTO revision_log
(record_id, requested_by_manager_id, resolved_record_id,
 revision_reason, requested_at, resolved_at)
VALUES

-- ================================================================
-- REVISION 1 — Project 14: LW EN→NL HT 2023 Q2
-- Ahmed Hassan quality was below standard (score 3)
-- PM requested revision — Ahmed resubmitted
-- Now resolved and paid
-- ================================================================
(
    (SELECT wr.record_id
     FROM work_record wr
     JOIN project_assignment pa
         ON wr.assignment_id = pa.assignment_id
     JOIN translation_project tp
         ON pa.project_id = tp.project_id
     JOIN collaborator c
         ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to Dutch Human Translation 2023 Q2'
     AND c.email = 'ahmed.hassan@gmail.com'
     LIMIT 1),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    (SELECT wr.record_id
     FROM work_record wr
     JOIN project_assignment pa
         ON wr.assignment_id = pa.assignment_id
     JOIN translation_project tp
         ON pa.project_id = tp.project_id
     JOIN collaborator c
         ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to Dutch Human Translation 2023 Q2'
     AND c.email = 'ahmed.hassan@gmail.com'
     LIMIT 1),
    'Translation quality below acceptable standard. Multiple terminology errors and inconsistent register throughout. Please review and resubmit.',
    '2023-05-25 10:00:00',
    '2023-06-05 14:00:00'
),

-- ================================================================
-- REVISION 2 — Project 21: LW EN→TR LCA 2023 Q3
-- Yuki Turkish score was 3 — below standard
-- PM requested revision
-- Resolved and paid
-- ================================================================
(
    (SELECT wr.record_id
     FROM work_record wr
     JOIN project_assignment pa
         ON wr.assignment_id = pa.assignment_id
     JOIN translation_project tp
         ON pa.project_id = tp.project_id
     JOIN collaborator c
         ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to Turkish Acceptability 2023 Q3'
     AND c.email = 'yuki.tanaka@gmail.com'
     LIMIT 1),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    (SELECT wr.record_id
     FROM work_record wr
     JOIN project_assignment pa
         ON wr.assignment_id = pa.assignment_id
     JOIN translation_project tp
         ON pa.project_id = tp.project_id
     JOIN collaborator c
         ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to Turkish Acceptability 2023 Q3'
     AND c.email = 'yuki.tanaka@gmail.com'
     LIMIT 1),
    'Acceptability judgements inconsistent in sections 3 to 7. Turkish cultural context not sufficiently considered. Please revise affected sections.',
    '2023-08-10 09:00:00',
    '2023-08-20 11:00:00'
),

-- ================================================================
-- REVISION 3 — Project 41: TG EN→AR MTPE 2024 Q2
-- Yara submitted — PM reviewed and sent back
-- Active revision — not yet resolved
-- ================================================================
(
    (SELECT wr.record_id
     FROM work_record wr
     JOIN project_assignment pa
         ON wr.assignment_id = pa.assignment_id
     JOIN translation_project tp
         ON pa.project_id = tp.project_id
     JOIN collaborator c
         ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'TransGlobal English to Arabic MTPE 2024 Q2'
     AND c.email = 'yara.mahmoud@gmail.com'
     LIMIT 1),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    NULL,
    'Several segments show over-editing beyond MTPE scope. Please limit edits to fluency and accuracy only. Do not rewrite entire sentences.',
    '2024-03-25 10:00:00',
    NULL
),

-- ================================================================
-- REVISION 4 — Project 12: GL EN→KO HT 2023 Q2
-- Yuki Korean — some cultural adaptation needed
-- Was resolved and completed
-- ================================================================
(
    (SELECT wr.record_id
     FROM work_record wr
     JOIN project_assignment pa
         ON wr.assignment_id = pa.assignment_id
     JOIN translation_project tp
         ON pa.project_id = tp.project_id
     JOIN collaborator c
         ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'GlobalLang English to Korean Human Translation 2023 Q2'
     AND c.email = 'yuki.tanaka@gmail.com'
     LIMIT 1),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    (SELECT wr.record_id
     FROM work_record wr
     JOIN project_assignment pa
         ON wr.assignment_id = pa.assignment_id
     JOIN translation_project tp
         ON pa.project_id = tp.project_id
     JOIN collaborator c
         ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'GlobalLang English to Korean Human Translation 2023 Q2'
     AND c.email = 'yuki.tanaka@gmail.com'
     LIMIT 1),
    'Cultural references need localisation for Korean audience. Honorific language levels inconsistent. Please revise sections 4 and 8.',
    '2023-05-10 09:30:00',
    '2023-05-20 16:00:00'
);


-- ================================================================
-- SECTION 2 — AGENCY INVOICES
-- One invoice per project
-- Amount = estimated units * agency_rate for completed
-- Flat estimates for active projects
-- ================================================================

INSERT INTO agency_invoice
(project_id, agency_id, currency_id, invoice_number,
 invoice_amount, date_received, invoice_status,
 upwork_transaction_ref, date_paid)
VALUES

-- ================================================================
-- 2023 Q1 INVOICES — ALL PAID
-- ================================================================

-- Project 1: TG EN→FR HT 2023 Q1
-- 4500 + 3800 words * $0.12 = $996
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2023 Q1'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'TG-2023-001',
    996.00, '2023-02-20', 'Paid',
    'UPW-TG-2023-001', '2023-04-10'
),

-- Project 2: TG EN→AR MTPE 2023 Q1
-- 1200 segments * $0.07 = $84
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic MTPE 2023 Q1'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'TG-2023-002',
    84.00, '2023-03-05', 'Paid',
    'UPW-TG-2023-002', '2023-04-20'
),

-- Project 3: LW EN→DE HT 2023 Q1
-- 5200 words * $0.14 = $728
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to German Human Translation 2023 Q1'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'LW-2023-001',
    728.00, '2023-03-10', 'Paid',
    'UPW-LW-2023-001', '2023-04-28'
),

-- Project 4: VT FR→EN HT 2023 Q1
-- 3200 words * $0.11 = $352
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech French to English Human Translation 2023 Q1'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'VT-2023-001',
    352.00, '2023-03-15', 'Paid',
    'UPW-VT-2023-001', '2023-05-05'
),

-- Project 5: GL EN→IT HT 2023 Q1
-- 4100 words * $0.12 = $492
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Italian Human Translation 2023 Q1'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'GL-2023-001',
    492.00, '2023-03-20', 'Paid',
    'UPW-GL-2023-001', '2023-05-10'
),

-- Project 6: TG EN→ES LCA 2023 Q1
-- 950 hits * $0.09 = $85.50
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Spanish Acceptability 2023 Q1'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'TG-2023-003',
    85.50, '2023-03-25', 'Paid',
    'UPW-TG-2023-003', '2023-05-15'
),

-- Project 7: LW EN→ZH MTPE 2023 Q1
-- 800 segments * $0.08 = $64
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Chinese Simplified MTPE 2023 Q1'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'LW-2023-002',
    64.00, '2023-03-28', 'Paid',
    'UPW-LW-2023-002', '2023-05-18'
),

-- Project 8: GL EN→JA MTPE 2023 Q1
-- 700 segments * $0.07 = $49
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Japanese MTPE 2023 Q1'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'GL-2023-002',
    49.00, '2023-03-31', 'Paid',
    'UPW-GL-2023-002', '2023-05-20'
),


-- ================================================================
-- 2023 Q2 INVOICES — ALL PAID
-- ================================================================

-- Project 9: TG EN→PT
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Portuguese Human Translation 2023 Q2'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'TG-2023-004',
    660.00, '2023-04-25', 'Paid',
    'UPW-TG-2023-004', '2023-06-15'
),

-- Project 10: LW EN→IT
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Italian Human Translation 2023 Q2'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'LW-2023-003',
    806.00, '2023-05-10', 'Paid',
    'UPW-LW-2023-003', '2023-06-28'
),

-- Project 11: VT ES→EN LCA
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech Spanish to English Acceptability 2023 Q2'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'VT-2023-002',
    99.00, '2023-05-20', 'Paid',
    'UPW-VT-2023-002', '2023-07-08'
),

-- Project 12: GL EN→KO
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Korean Human Translation 2023 Q2'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'GL-2023-003',
    624.00, '2023-05-25', 'Paid',
    'UPW-GL-2023-003', '2023-07-12'
),

-- Project 13: TG EN→RU
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Russian MTPE 2023 Q2'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'TG-2023-005',
    63.00, '2023-06-10', 'Paid',
    'UPW-TG-2023-005', '2023-07-28'
),

-- Project 14: LW EN→NL — Disputed then resolved
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Dutch Human Translation 2023 Q2'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'LW-2023-004',
    455.00, '2023-06-15', 'Paid',
    'UPW-LW-2023-004', '2023-08-05'
),

-- Project 15: VT EN→FR LCA
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to French Acceptability 2023 Q2'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'VT-2023-003',
    130.00, '2023-06-25', 'Paid',
    'UPW-VT-2023-003', '2023-08-12'
),


-- ================================================================
-- 2023 Q3 INVOICES — ALL PAID
-- ================================================================

-- Project 16: TG EN→AR HT 2023 Q3 — two collaborators
-- (3800 + 3200) * $0.12 = $840
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic Human Translation 2023 Q3'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'TG-2023-006',
    840.00, '2023-07-25', 'Paid',
    'UPW-TG-2023-006', '2023-09-12'
),

-- Project 17: LW FR→AR
-- 5600 * $0.14 = $784
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld French to Arabic Human Translation 2023 Q3'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'LW-2023-005',
    784.00, '2023-08-10', 'Paid',
    'UPW-LW-2023-005', '2023-09-28'
),

-- Project 18: VT EN→ES
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to Spanish Human Translation 2023 Q3'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'VT-2023-004',
    462.00, '2023-08-20', 'Paid',
    'UPW-VT-2023-004', '2023-10-08'
),

-- Project 19: GL EN→ZH-Hant
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Chinese Traditional MTPE 2023 Q3'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'GL-2023-004',
    68.00, '2023-08-25', 'Paid',
    'UPW-GL-2023-004', '2023-10-12'
),

-- Project 20: TG AR→EN
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal Arabic to English Human Translation 2023 Q3'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'TG-2023-007',
    528.00, '2023-08-30', 'Paid',
    'UPW-TG-2023-007', '2023-10-18'
),

-- Project 21: LW EN→TR LCA
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Turkish Acceptability 2023 Q3'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'LW-2023-006',
    67.50, '2023-09-05', 'Paid',
    'UPW-LW-2023-006', '2023-10-22'
),

-- Project 22: VT EN→DE MTPE
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to German MTPE 2023 Q3'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'VT-2023-005',
    45.50, '2023-09-10', 'Paid',
    'UPW-VT-2023-005', '2023-10-28'
),

-- Project 23: GL ES→FR
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang Spanish to French Human Translation 2023 Q3'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'GL-2023-005',
    432.00, '2023-09-15', 'Paid',
    'UPW-GL-2023-005', '2023-11-03'
),


-- ================================================================
-- 2023 Q4 INVOICES — ALL PAID
-- ================================================================

-- Project 24: TG EN→FR Q4
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2023 Q4'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'TG-2023-008',
    612.00, '2023-10-20', 'Paid',
    'UPW-TG-2023-008', '2023-12-08'
),

-- Project 25: LW EN→JA
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Japanese Human Translation 2023 Q4'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'LW-2023-007',
    952.00, '2023-11-10', 'Paid',
    'UPW-LW-2023-007', '2023-12-28'
),

-- Project 26: VT EN→PT LCA
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to Portuguese Acceptability 2023 Q4'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'VT-2023-006',
    94.50, '2023-11-15', 'Paid',
    'UPW-VT-2023-006', '2024-01-03'
),

-- Project 27: GL EN→AR Q4
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Arabic Human Translation 2023 Q4'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'GL-2023-006',
    516.00, '2023-11-20', 'Paid',
    'UPW-GL-2023-006', '2024-01-08'
),

-- Project 28: TG EN→ZH MTPE Q4
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Chinese Simplified MTPE 2023 Q4'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'TG-2023-009',
    64.40, '2023-11-25', 'Paid',
    'UPW-TG-2023-009', '2024-01-12'
),

-- Project 29: LW PT-BR→EN Q4
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld Portuguese Brazil to English Human Translation 2023 Q4'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'LW-2023-008',
    754.00, '2023-12-05', 'Paid',
    'UPW-LW-2023-008', '2024-01-22'
),

-- Project 30: GL EN→ES LCA Q4
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Spanish Acceptability 2023 Q4'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'GL-2023-007',
    120.00, '2023-12-15', 'Paid',
    'UPW-GL-2023-007', '2024-02-02'
),


-- ================================================================
-- 2024 Q1 INVOICES — CONFIRMED
-- Completed projects — invoice received not yet paid
-- ================================================================

-- Project 31: TG EN→FR 2024 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2024 Q1'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'TG-2024-001',
    636.00, '2024-01-25', 'Confirmed',
    NULL, NULL
),

-- Project 32: TG EN→AR LCA 2024 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic Acceptability 2024 Q1'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'TG-2024-002',
    126.00, '2024-02-01', 'Confirmed',
    NULL, NULL
),

-- Project 33: LW EN→DE 2024 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to German Human Translation 2024 Q1'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'LW-2024-001',
    854.00, '2024-02-10', 'Confirmed',
    NULL, NULL
),

-- Project 34: LW EN→JA MTPE 2024 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Japanese MTPE 2024 Q1'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'LW-2024-002',
    88.00, '2024-02-20', 'Confirmed',
    NULL, NULL
),

-- Project 35: VT FR→EN 2024 Q1 — CANCELLED
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech French to English Human Translation 2024 Q1'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'VT-2024-001',
    0.00, NULL, 'Cancelled',
    NULL, NULL
),

-- Project 36: GL EN→IT 2024 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Italian Human Translation 2024 Q1'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'GL-2024-001',
    564.00, '2024-02-25', 'Confirmed',
    NULL, NULL
),

-- Project 37: TG EN→ES 2024 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Spanish Human Translation 2024 Q1'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'TG-2024-003',
    708.00, '2024-03-05', 'Confirmed',
    NULL, NULL
),

-- Project 38: GL EN→ZH LCA 2024 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Chinese Simplified Acceptability 2024 Q1'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'GL-2024-002',
    130.00, '2024-03-10', 'Confirmed',
    NULL, NULL
),

-- Project 39: LW EN→PT 2024 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Portuguese Human Translation 2024 Q1'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'LW-2024-003',
    702.00, '2024-03-20', 'Confirmed',
    NULL, NULL
),


-- ================================================================
-- 2024 Q2 INVOICES — PENDING (active projects)
-- ================================================================

-- Project 40: TG EN→FR HT 2024 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2024 Q2'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    NULL,
    0.00, NULL, 'Pending',
    NULL, NULL
),

-- Project 41: TG EN→AR MTPE 2024 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic MTPE 2024 Q2'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    NULL,
    0.00, NULL, 'Pending',
    NULL, NULL
),

-- Project 42: LW EN→DE HT 2024 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to German Human Translation 2024 Q2'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    NULL,
    0.00, NULL, 'Pending',
    NULL, NULL
),

-- Project 43: LW EN→ZH LCA 2024 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Chinese Simplified Acceptability 2024 Q2'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    NULL,
    0.00, NULL, 'Pending',
    NULL, NULL
),

-- Project 44: VT EN→ES HT 2024 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to Spanish Human Translation 2024 Q2'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    NULL,
    0.00, NULL, 'Pending',
    NULL, NULL
),

-- Project 45: GL EN→IT HT 2024 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Italian Human Translation 2024 Q2'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    NULL,
    0.00, NULL, 'Pending',
    NULL, NULL
),

-- Project 46: VT EN→DE MTPE 2024 Q2 — CANCELLED
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to German MTPE 2024 Q2'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'VT-2024-002',
    0.00, NULL, 'Cancelled',
    NULL, NULL
),

-- Project 47: GL EN→JA LCA 2024 Q2 — ON HOLD
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Japanese Acceptability 2024 Q2'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    NULL,
    0.00, NULL, 'Pending',
    NULL, NULL
),

-- Project 48: TG EN→RU MTPE 2024 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Russian MTPE 2024 Q2'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    NULL,
    0.00, NULL, 'Pending',
    NULL, NULL
),


-- ================================================================
-- 2024 Q3 INVOICES — PENDING
-- ================================================================

-- Project 49: TG EN→FR LCA 2024 Q3
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Acceptability 2024 Q3'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    NULL,
    0.00, NULL, 'Pending',
    NULL, NULL
),

-- Project 50: LW EN→KO HT 2024 Q3
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Korean Human Translation 2024 Q3'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    NULL,
    0.00, NULL, 'Pending',
    NULL, NULL
),

-- Project 51: VT ES→EN HT 2024 Q3
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech Spanish to English Human Translation 2024 Q3'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    NULL,
    0.00, NULL, 'Pending',
    NULL, NULL
),

-- Project 52: GL EN→AR HT 2024 Q3
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Arabic Human Translation 2024 Q3'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    NULL,
    0.00, NULL, 'Pending',
    NULL, NULL
),

-- Project 53: TG EN→DE HT 2024 Q3 — NOT ASSIGNED
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to German Human Translation 2024 Q3'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    NULL,
    0.00, NULL, 'Pending',
    NULL, NULL
),

-- Project 54: LW EN→PT MTPE 2024 Q3 — NOT ASSIGNED
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Portuguese MTPE 2024 Q3'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    NULL,
    0.00, NULL, 'Pending',
    NULL, NULL
),

-- Project 55: GL EN→ZH-Hant LCA 2024 Q3 — ON HOLD
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Chinese Traditional Acceptability 2024 Q3'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    NULL,
    0.00, NULL, 'Pending',
    NULL, NULL
),


-- ================================================================
-- 2024 Q4 INVOICES
-- ================================================================

-- Project 56: TG EN→AR 2024 Q4 — NOT ASSIGNED
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic Human Translation 2024 Q4'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    NULL,
    0.00, NULL, 'Pending',
    NULL, NULL
),

-- Project 57: LW EN→ES 2024 Q4 — NOT ASSIGNED
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Spanish Human Translation 2024 Q4'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    NULL,
    0.00, NULL, 'Pending',
    NULL, NULL
),

-- Project 58: VT EN→FR LCA 2024 Q4 — CANCELLED
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to French Acceptability 2024 Q4'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    'VT-2024-003',
    0.00, NULL, 'Cancelled',
    NULL, NULL
),

-- Project 59: GL EN→IT MTPE 2024 Q4 — NOT ASSIGNED
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Italian MTPE 2024 Q4'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    NULL,
    0.00, NULL, 'Pending',
    NULL, NULL
),

-- Project 60: TG EN→FR HT 2024 Q4 — ON HOLD
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2024 Q4'),
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    NULL,
    0.00, NULL, 'Pending',
    NULL, NULL
);


-- ================================================================
-- SECTION 3 — COLLABORATOR PAYMENTS
-- Paid for all 2023 Paid work records
-- Pending for all 2024 Q1 Approved work records
-- No payments for active, cancelled or on hold projects
-- ================================================================

INSERT INTO collaborator_payment
(collaborator_id, project_id, currency_id,
 payment_amount, payment_date, payment_status,
 transaction_reference)
VALUES

-- ================================================================
-- 2023 Q1 PAYMENTS — ALL PAID
-- ================================================================

-- Project 1: Amara Diallo — 4500 * $0.08 = $360
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'amara.diallo@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2023 Q1'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    360.00, '2023-04-15', 'Paid',
    'PAY-2023-001'
),
-- Project 1: Pierre Dubois — 3800 * $0.08 = $304
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'pierre.dubois@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2023 Q1'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    304.00, '2023-04-15', 'Paid',
    'PAY-2023-002'
),

-- Project 2: Fatima Al-Rashid — 1200 * $0.04 = $48
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'fatima.alrashid@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic MTPE 2023 Q1'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    48.00, '2023-04-25', 'Paid',
    'PAY-2023-003'
),

-- Project 3: Klaus Weber — 5200 * $0.09 = $468
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'klaus.weber@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to German Human Translation 2023 Q1'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    468.00, '2023-05-05', 'Paid',
    'PAY-2023-004'
),

-- Project 4: Carlos Mendez — 3200 * $0.07 = $224
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'carlos.mendez@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech French to English Human Translation 2023 Q1'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    224.00, '2023-05-10', 'Paid',
    'PAY-2023-005'
),

-- Project 5: Lucia Romano — 4100 * $0.08 = $328
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'lucia.romano@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Italian Human Translation 2023 Q1'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    328.00, '2023-05-15', 'Paid',
    'PAY-2023-006'
),

-- Project 6: Carlos Mendez — 950 * $0.06 = $57
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'carlos.mendez@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Spanish Acceptability 2023 Q1'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    57.00, '2023-05-20', 'Paid',
    'PAY-2023-007'
),

-- Project 7: Mei Chen — 800 * $0.05 = $40
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'mei.chen@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Chinese Simplified MTPE 2023 Q1'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    40.00, '2023-05-22', 'Paid',
    'PAY-2023-008'
),

-- Project 8: Yuki Tanaka — 700 * $0.04 = $28
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yuki.tanaka@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Japanese MTPE 2023 Q1'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    28.00, '2023-05-25', 'Paid',
    'PAY-2023-009'
),


-- ================================================================
-- 2023 Q2 PAYMENTS — ALL PAID
-- ================================================================

-- Project 9: Sofia Ferreira — 5500 * $0.08 = $440
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'sofia.ferreira@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Portuguese Human Translation 2023 Q2'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    440.00, '2023-06-20', 'Paid',
    'PAY-2023-010'
),

-- Project 10: Lucia Romano — 6200 * $0.09 = $558
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'lucia.romano@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Italian Human Translation 2023 Q2'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    558.00, '2023-07-05', 'Paid',
    'PAY-2023-011'
),

-- Project 11: Carlos Mendez — 1100 * $0.06 = $66
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'carlos.mendez@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech Spanish to English Acceptability 2023 Q2'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    66.00, '2023-07-12', 'Paid',
    'PAY-2023-012'
),

-- Project 12: Yuki Tanaka — 4800 * $0.09 = $432
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yuki.tanaka@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Korean Human Translation 2023 Q2'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    432.00, '2023-07-18', 'Paid',
    'PAY-2023-013'
),

-- Project 13: Ivan Petrov — 900 * $0.04 = $36
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'ivan.petrov@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Russian MTPE 2023 Q2'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    36.00, '2023-08-01', 'Paid',
    'PAY-2023-014'
),

-- Project 14: Ahmed Hassan — 3500 * $0.09 = $315
-- Note: paid despite quality issues — contractual obligation
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'ahmed.hassan@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Dutch Human Translation 2023 Q2'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    315.00, '2023-08-10', 'Paid',
    'PAY-2023-015'
),

-- Project 15: Amara Diallo — 1300 * $0.06 = $78
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'amara.diallo@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to French Acceptability 2023 Q2'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    78.00, '2023-08-15', 'Paid',
    'PAY-2023-016'
),


-- ================================================================
-- 2023 Q3 PAYMENTS — ALL PAID
-- ================================================================

-- Project 16: Fatima — 3800 * $0.08 = $304
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'fatima.alrashid@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic Human Translation 2023 Q3'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    304.00, '2023-09-20', 'Paid',
    'PAY-2023-017'
),
-- Project 16: Yara — 3200 * $0.08 = $256
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yara.mahmoud@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic Human Translation 2023 Q3'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    256.00, '2023-09-20', 'Paid',
    'PAY-2023-018'
),

-- Project 17: Amara — 5600 * $0.09 = $504
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'amara.diallo@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld French to Arabic Human Translation 2023 Q3'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    504.00, '2023-10-05', 'Paid',
    'PAY-2023-019'
),

-- Project 18: Carlos — 4200 * $0.07 = $294
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'carlos.mendez@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to Spanish Human Translation 2023 Q3'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    294.00, '2023-10-12', 'Paid',
    'PAY-2023-020'
),

-- Project 19: Mei — 850 * $0.05 = $42.50
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'mei.chen@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Chinese Traditional MTPE 2023 Q3'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    42.50, '2023-10-18', 'Paid',
    'PAY-2023-021'
),

-- Project 20: Fatima — 4400 * $0.08 = $352
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'fatima.alrashid@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal Arabic to English Human Translation 2023 Q3'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    352.00, '2023-10-22', 'Paid',
    'PAY-2023-022'
),

-- Project 21: Yuki — 750 * $0.06 = $45
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yuki.tanaka@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Turkish Acceptability 2023 Q3'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    45.00, '2023-10-28', 'Paid',
    'PAY-2023-023'
),

-- Project 22: Klaus — 650 * $0.04 = $26
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'klaus.weber@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to German MTPE 2023 Q3'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    26.00, '2023-11-03', 'Paid',
    'PAY-2023-024'
),

-- Project 23: Carlos — 3600 * $0.08 = $288
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'carlos.mendez@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang Spanish to French Human Translation 2023 Q3'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    288.00, '2023-11-08', 'Paid',
    'PAY-2023-025'
),


-- ================================================================
-- 2023 Q4 PAYMENTS — ALL PAID
-- ================================================================

-- Project 24: Pierre — 5100 * $0.08 = $408
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'pierre.dubois@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2023 Q4'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    408.00, '2023-12-15', 'Paid',
    'PAY-2023-026'
),

-- Project 25: Yuki — 6800 * $0.09 = $612
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yuki.tanaka@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Japanese Human Translation 2023 Q4'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    612.00, '2024-01-05', 'Paid',
    'PAY-2023-027'
),

-- Project 26: Sofia — 1050 * $0.06 = $63
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'sofia.ferreira@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to Portuguese Acceptability 2023 Q4'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    63.00, '2024-01-10', 'Paid',
    'PAY-2023-028'
),

-- Project 27: Yara — 4300 * $0.08 = $344
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yara.mahmoud@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Arabic Human Translation 2023 Q4'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    344.00, '2024-01-15', 'Paid',
    'PAY-2023-029'
),

-- Project 28: Mei — 920 * $0.04 = $36.80
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'mei.chen@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Chinese Simplified MTPE 2023 Q4'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    36.80, '2024-01-18', 'Paid',
    'PAY-2023-030'
),

-- Project 29: Sofia — 5800 * $0.09 = $522
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'sofia.ferreira@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld Portuguese Brazil to English Human Translation 2023 Q4'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    522.00, '2024-01-25', 'Paid',
    'PAY-2023-031'
),

-- Project 30: Carlos — 1200 * $0.06 = $72
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'carlos.mendez@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Spanish Acceptability 2023 Q4'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    72.00, '2024-02-05', 'Paid',
    'PAY-2023-032'
),


-- ================================================================
-- 2024 Q1 PAYMENTS — ALL PENDING
-- Work records Approved — payments awaiting transfer
-- ================================================================

-- Project 31: Amara — 5300 * $0.08 = $424
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'amara.diallo@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2024 Q1'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    424.00, NULL, 'Pending',
    NULL
),

-- Project 32: Fatima — 1400 * $0.06 = $84
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'fatima.alrashid@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic Acceptability 2024 Q1'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    84.00, NULL, 'Pending',
    NULL
),

-- Project 33: Klaus — 6100 * $0.09 = $549
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'klaus.weber@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to German Human Translation 2024 Q1'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    549.00, NULL, 'Pending',
    NULL
),

-- Project 34: Yuki — 1100 * $0.05 = $55
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yuki.tanaka@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Japanese MTPE 2024 Q1'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    55.00, NULL, 'Pending',
    NULL
),

-- Project 36: Marco — 4700 * $0.08 = $376
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'marco.rossi@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Italian Human Translation 2024 Q1'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    376.00, NULL, 'Pending',
    NULL
),

-- Project 37: Carlos — 5900 * $0.08 = $472
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'carlos.mendez@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Spanish Human Translation 2024 Q1'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    472.00, NULL, 'Pending',
    NULL
),

-- Project 38: Mei — 1300 * $0.07 = $91
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'mei.chen@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Chinese Simplified Acceptability 2024 Q1'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    91.00, NULL, 'Pending',
    NULL
),

-- Project 39: Sofia — 5400 * $0.09 = $486
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'sofia.ferreira@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Portuguese Human Translation 2024 Q1'),
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    486.00, NULL, 'Pending',
    NULL
);