-- ================================================================
-- LINGUASYNC DEMO DATA
-- Demo Batch 8 — Work Records and Communications
-- ================================================================
-- WORK RECORDS:
-- All 2023 completed projects have Approved or Paid records
-- 2024 completed projects (31-39) have Approved records
-- Active 2024 projects have Submitted or Reviewed records
-- On Hold project 47 has one Submitted record — paused
-- Cancelled projects have no work records
-- Quality scores on all Approved and Paid records
-- Units vary by project type:
--   HT: 2000-8000 words
--   LCA: 500-2000 hits
--   MTPE: 300-1500 segments
--
-- COMMUNICATIONS:
-- Mix of PM and collaborator messages
-- Covers assignment instructions, progress updates,
-- revision requests and approvals
-- ================================================================


-- ================================================================
-- SECTION 1 — WORK RECORDS
-- ================================================================

INSERT INTO work_record
(assignment_id, date_started, date_completed,
 units_completed, quality_score, notes, record_status)
VALUES


-- ================================================================
-- 2023 Q1 WORK RECORDS — ALL PAID
-- ================================================================

-- Project 1: TG EN→FR HT 2023 Q1
-- Assignment 1: Amara Diallo
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'TransGlobal English to French Human Translation 2023 Q1'
     AND c.email = 'amara.diallo@gmail.com'
     LIMIT 1),
    '2023-01-13', '2023-02-05',
    4500, 5,
    'Excellent quality. Client very satisfied.',
    'Paid'
),
-- Assignment 2: Pierre Dubois
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'TransGlobal English to French Human Translation 2023 Q1'
     AND c.email = 'pierre.dubois@gmail.com'
     LIMIT 1),
    '2023-01-16', '2023-02-08',
    3800, 4,
    'Good quality. Minor terminology inconsistencies noted.',
    'Paid'
),

-- Project 2: TG EN→AR MTPE 2023 Q1
-- Assignment: Fatima Al-Rashid
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'TransGlobal English to Arabic MTPE 2023 Q1'
     AND c.email = 'fatima.alrashid@gmail.com'
     LIMIT 1),
    '2023-01-23', '2023-02-20',
    1200, 4,
    'Solid post-editing work. A few segments needed extra review.',
    'Paid'
),

-- Project 3: LW EN→DE HT 2023 Q1
-- Assignment: Klaus Weber
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to German Human Translation 2023 Q1'
     AND c.email = 'klaus.weber@gmail.com'
     LIMIT 1),
    '2023-02-04', '2023-02-28',
    5200, 5,
    'Outstanding translation. LinguaWorld specifically praised accuracy.',
    'Paid'
),

-- Project 4: VT FR→EN HT 2023 Q1
-- Assignment: Carlos Mendez
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'VerboTech French to English Human Translation 2023 Q1'
     AND c.email = 'carlos.mendez@gmail.com'
     LIMIT 1),
    '2023-02-13', '2023-03-10',
    3200, 4,
    'Competent translation. Some idiomatic expressions could be improved.',
    'Paid'
),

-- Project 5: GL EN→IT HT 2023 Q1
-- Assignment: Lucia Romano
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'GlobalLang English to Italian Human Translation 2023 Q1'
     AND c.email = 'lucia.romano@gmail.com'
     LIMIT 1),
    '2023-02-18', '2023-03-15',
    4100, 5,
    'Excellent work. First project with GlobalLang — very positive.',
    'Paid'
),

-- Project 6: TG EN→ES LCA 2023 Q1
-- Assignment: Carlos Mendez
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'TransGlobal English to Spanish Acceptability 2023 Q1'
     AND c.email = 'carlos.mendez@gmail.com'
     LIMIT 1),
    '2023-02-23', '2023-03-20',
    950, 4,
    'Good acceptability judgements. Consistent across all prompts.',
    'Paid'
),

-- Project 7: LW EN→ZH MTPE 2023 Q1
-- Assignment: Mei Chen
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to Chinese Simplified MTPE 2023 Q1'
     AND c.email = 'mei.chen@gmail.com'
     LIMIT 1),
    '2023-02-28', '2023-03-25',
    800, 4,
    'Reliable MTPE output. Good handling of technical content.',
    'Paid'
),

-- Project 8: GL EN→JA MTPE 2023 Q1
-- Assignment: Yuki Tanaka
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'GlobalLang English to Japanese MTPE 2023 Q1'
     AND c.email = 'yuki.tanaka@gmail.com'
     LIMIT 1),
    '2023-03-04', '2023-03-28',
    700, 5,
    'Excellent MTPE. Very high accuracy on all segments.',
    'Paid'
),


-- ================================================================
-- 2023 Q2 WORK RECORDS — ALL PAID
-- ================================================================

-- Project 9: TG EN→PT HT 2023 Q2
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'TransGlobal English to Portuguese Human Translation 2023 Q2'
     AND c.email = 'sofia.ferreira@gmail.com'
     LIMIT 1),
    '2023-03-20', '2023-04-20',
    5500, 5,
    'Excellent Brazilian Portuguese translation.',
    'Paid'
),

-- Project 10: LW EN→IT HT 2023 Q2
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to Italian Human Translation 2023 Q2'
     AND c.email = 'lucia.romano@gmail.com'
     LIMIT 1),
    '2023-04-06', '2023-05-05',
    6200, 5,
    'Outstanding work. LinguaWorld very pleased with quality.',
    'Paid'
),

-- Project 11: VT ES→EN LCA 2023 Q2
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'VerboTech Spanish to English Acceptability 2023 Q2'
     AND c.email = 'carlos.mendez@gmail.com'
     LIMIT 1),
    '2023-04-13', '2023-05-15',
    1100, 4,
    'Good acceptability judgements overall.',
    'Paid'
),

-- Project 12: GL EN→KO HT 2023 Q2
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'GlobalLang English to Korean Human Translation 2023 Q2'
     AND c.email = 'yuki.tanaka@gmail.com'
     LIMIT 1),
    '2023-04-19', '2023-05-25',
    4800, 4,
    'Good Korean translation. Some cultural adaptation needed.',
    'Paid'
),

-- Project 13: TG EN→RU MTPE 2023 Q2
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'TransGlobal English to Russian MTPE 2023 Q2'
     AND c.email = 'ivan.petrov@gmail.com'
     LIMIT 1),
    '2023-05-04', '2023-06-05',
    900, 4,
    'Solid post-editing. Ivan is reliable on Russian projects.',
    'Paid'
),

-- Project 14: LW EN→NL HT 2023 Q2 — Ahmed Hassan
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to Dutch Human Translation 2023 Q2'
     AND c.email = 'ahmed.hassan@gmail.com'
     LIMIT 1),
    '2023-05-13', '2023-06-10',
    3500, 3,
    'Acceptable quality but below expected standard. Several errors noted.',
    'Paid'
),

-- Project 15: VT EN→FR LCA 2023 Q2
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'VerboTech English to French Acceptability 2023 Q2'
     AND c.email = 'amara.diallo@gmail.com'
     LIMIT 1),
    '2023-05-23', '2023-06-20',
    1300, 5,
    'Excellent judgements. Very consistent and well-reasoned.',
    'Paid'
),


-- ================================================================
-- 2023 Q3 WORK RECORDS — ALL PAID
-- ================================================================

-- Project 16: TG EN→AR HT 2023 Q3
-- Fatima on account A
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     JOIN platform_account pac ON pa.account_id = pac.account_id
     WHERE tp.project_name =
       'TransGlobal English to Arabic Human Translation 2023 Q3'
     AND c.email = 'fatima.alrashid@gmail.com'
     AND pac.account_email = 'ls.enar.tg.2023q3a@gmail.com'
     LIMIT 1),
    '2023-06-20', '2023-07-15',
    3800, 5,
    'Excellent Arabic translation. High accuracy throughout.',
    'Paid'
),
-- Yara on account B
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     JOIN platform_account pac ON pa.account_id = pac.account_id
     WHERE tp.project_name =
       'TransGlobal English to Arabic Human Translation 2023 Q3'
     AND c.email = 'yara.mahmoud@gmail.com'
     AND pac.account_email = 'ls.enar.tg.2023q3b@gmail.com'
     LIMIT 1),
    '2023-06-22', '2023-07-18',
    3200, 4,
    'Good quality from Yara. Improving with each project.',
    'Paid'
),

-- Project 17: LW FR→AR HT 2023 Q3
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld French to Arabic Human Translation 2023 Q3'
     AND c.email = 'amara.diallo@gmail.com'
     LIMIT 1),
    '2023-07-04', '2023-08-05',
    5600, 5,
    'Exceptional work on a challenging language direction.',
    'Paid'
),

-- Project 18: VT EN→ES HT 2023 Q3
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'VerboTech English to Spanish Human Translation 2023 Q3'
     AND c.email = 'carlos.mendez@gmail.com'
     LIMIT 1),
    '2023-07-13', '2023-08-15',
    4200, 4,
    'Good translation. Consistent terminology throughout.',
    'Paid'
),

-- Project 19: GL EN→ZH-Hant MTPE 2023 Q3
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'GlobalLang English to Chinese Traditional MTPE 2023 Q3'
     AND c.email = 'mei.chen@gmail.com'
     LIMIT 1),
    '2023-07-18', '2023-08-20',
    850, 4,
    'Good handling of traditional Chinese conventions.',
    'Paid'
),

-- Project 20: TG AR→EN HT 2023 Q3
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'TransGlobal Arabic to English Human Translation 2023 Q3'
     AND c.email = 'fatima.alrashid@gmail.com'
     LIMIT 1),
    '2023-07-23', '2023-08-25',
    4400, 5,
    'Excellent reverse direction translation from Fatima.',
    'Paid'
),

-- Project 21: LW EN→TR LCA 2023 Q3
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to Turkish Acceptability 2023 Q3'
     AND c.email = 'yuki.tanaka@gmail.com'
     LIMIT 1),
    '2023-08-04', '2023-09-01',
    750, 3,
    'Acceptable but Turkish not Yukis strongest language.',
    'Paid'
),

-- Project 22: VT EN→DE MTPE 2023 Q3
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'VerboTech English to German MTPE 2023 Q3'
     AND c.email = 'klaus.weber@gmail.com'
     LIMIT 1),
    '2023-08-13', '2023-09-05',
    650, 5,
    'Outstanding German MTPE. Klaus is exceptional on this type.',
    'Paid'
),

-- Project 23: GL ES→FR HT 2023 Q3
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'GlobalLang Spanish to French Human Translation 2023 Q3'
     AND c.email = 'carlos.mendez@gmail.com'
     LIMIT 1),
    '2023-08-18', '2023-09-15',
    3600, 4,
    'Good work on Spanish to French direction.',
    'Paid'
),


-- ================================================================
-- 2023 Q4 WORK RECORDS — ALL PAID
-- ================================================================

-- Project 24: TG EN→FR HT 2023 Q4
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'TransGlobal English to French Human Translation 2023 Q4'
     AND c.email = 'pierre.dubois@gmail.com'
     LIMIT 1),
    '2023-09-13', '2023-10-15',
    5100, 4,
    'Consistent quality from Pierre. Good delivery.',
    'Paid'
),

-- Project 25: LW EN→JA HT 2023 Q4
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to Japanese Human Translation 2023 Q4'
     AND c.email = 'yuki.tanaka@gmail.com'
     LIMIT 1),
    '2023-10-04', '2023-11-05',
    6800, 5,
    'Yuki at his best. LinguaWorld praised the naturalness.',
    'Paid'
),

-- Project 26: VT EN→PT LCA 2023 Q4
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'VerboTech English to Portuguese Acceptability 2023 Q4'
     AND c.email = 'sofia.ferreira@gmail.com'
     LIMIT 1),
    '2023-10-13', '2023-11-10',
    1050, 4,
    'Good acceptability ratings. Sofia reliable as always.',
    'Paid'
),

-- Project 27: GL EN→AR HT 2023 Q4
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'GlobalLang English to Arabic Human Translation 2023 Q4'
     AND c.email = 'yara.mahmoud@gmail.com'
     LIMIT 1),
    '2023-10-18', '2023-11-15',
    4300, 4,
    'Yara growing in confidence. Good delivery on this project.',
    'Paid'
),

-- Project 28: TG EN→ZH MTPE 2023 Q4
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'TransGlobal English to Chinese Simplified MTPE 2023 Q4'
     AND c.email = 'mei.chen@gmail.com'
     LIMIT 1),
    '2023-10-23', '2023-11-20',
    920, 5,
    'Excellent Simplified Chinese MTPE from Mei.',
    'Paid'
),

-- Project 29: LW PT-BR→EN HT 2023 Q4
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld Portuguese Brazil to English Human Translation 2023 Q4'
     AND c.email = 'sofia.ferreira@gmail.com'
     LIMIT 1),
    '2023-11-04', '2023-12-01',
    5800, 5,
    'Outstanding reverse direction work from Sofia.',
    'Paid'
),

-- Project 30: GL EN→ES LCA 2023 Q4
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'GlobalLang English to Spanish Acceptability 2023 Q4'
     AND c.email = 'carlos.mendez@gmail.com'
     LIMIT 1),
    '2023-11-13', '2023-12-10',
    1200, 4,
    'Good LCA judgements from Carlos.',
    'Paid'
),


-- ================================================================
-- 2024 Q1 WORK RECORDS — ALL APPROVED
-- (Completed projects — paid through invoice not yet settled)
-- ================================================================

-- Project 31: TG EN→FR HT 2024 Q1
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'TransGlobal English to French Human Translation 2024 Q1'
     AND c.email = 'amara.diallo@gmail.com'
     LIMIT 1),
    '2023-12-13', '2024-01-20',
    5300, 5,
    'Another excellent delivery from Amara.',
    'Approved'
),

-- Project 32: TG EN→AR LCA 2024 Q1
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'TransGlobal English to Arabic Acceptability 2024 Q1'
     AND c.email = 'fatima.alrashid@gmail.com'
     LIMIT 1),
    '2023-12-18', '2024-01-25',
    1400, 4,
    'Solid acceptability work from Fatima.',
    'Approved'
),

-- Project 33: LW EN→DE HT 2024 Q1
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to German Human Translation 2024 Q1'
     AND c.email = 'klaus.weber@gmail.com'
     LIMIT 1),
    '2023-12-23', '2024-02-05',
    6100, 5,
    'Exceptional German HT from Klaus as always.',
    'Approved'
),

-- Project 34: LW EN→JA MTPE 2024 Q1
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to Japanese MTPE 2024 Q1'
     AND c.email = 'yuki.tanaka@gmail.com'
     LIMIT 1),
    '2024-01-08', '2024-02-15',
    1100, 5,
    'Yuki delivering consistently high quality MTPE.',
    'Approved'
),

-- Project 36: GL EN→IT HT 2024 Q1
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'GlobalLang English to Italian Human Translation 2024 Q1'
     AND c.email = 'marco.rossi@gmail.com'
     LIMIT 1),
    '2024-01-18', '2024-02-20',
    4700, 4,
    'Marco delivers solid Italian HT. Good first project for him.',
    'Approved'
),

-- Project 37: TG EN→ES HT 2024 Q1
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'TransGlobal English to Spanish Human Translation 2024 Q1'
     AND c.email = 'carlos.mendez@gmail.com'
     LIMIT 1),
    '2024-01-23', '2024-03-01',
    5900, 4,
    'Good Spanish HT from Carlos.',
    'Approved'
),

-- Project 38: GL EN→ZH LCA 2024 Q1
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'GlobalLang English to Chinese Simplified Acceptability 2024 Q1'
     AND c.email = 'mei.chen@gmail.com'
     LIMIT 1),
    '2024-02-04', '2024-03-05',
    1300, 5,
    'Excellent LCA judgements from Mei.',
    'Approved'
),

-- Project 39: LW EN→PT HT 2024 Q1
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to Portuguese Human Translation 2024 Q1'
     AND c.email = 'sofia.ferreira@gmail.com'
     LIMIT 1),
    '2024-02-13', '2024-03-20',
    5400, 5,
    'Sofia continues to deliver excellent Portuguese HT.',
    'Approved'
),


-- ================================================================
-- 2024 Q2 ACTIVE WORK RECORDS — SUBMITTED AND REVIEWED
-- ================================================================

-- Project 40: TG EN→FR HT 2024 Q2
-- Amara — Reviewed
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     JOIN platform_account pac ON pa.account_id = pac.account_id
     WHERE tp.project_name =
       'TransGlobal English to French Human Translation 2024 Q2'
     AND c.email = 'amara.diallo@gmail.com'
     AND pac.account_email = 'ls.enfr.tg.2024q2a@gmail.com'
     LIMIT 1),
    '2024-03-13', NULL,
    2800, NULL,
    NULL,
    'Reviewed'
),
-- Pierre — Submitted
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     JOIN platform_account pac ON pa.account_id = pac.account_id
     WHERE tp.project_name =
       'TransGlobal English to French Human Translation 2024 Q2'
     AND c.email = 'pierre.dubois@gmail.com'
     AND pac.account_email = 'ls.enfr.tg.2024q2b@gmail.com'
     LIMIT 1),
    '2024-03-16', NULL,
    2100, NULL,
    NULL,
    'Submitted'
),

-- Project 41: TG EN→AR MTPE 2024 Q2
-- Yara — Submitted
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'TransGlobal English to Arabic MTPE 2024 Q2'
     AND c.email = 'yara.mahmoud@gmail.com'
     LIMIT 1),
    '2024-03-18', NULL,
    600, NULL,
    NULL,
    'Submitted'
),

-- Project 42: LW EN→DE HT 2024 Q2
-- Lena — Reviewed
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to German Human Translation 2024 Q2'
     AND c.email = 'lena.fischer@gmail.com'
     LIMIT 1),
    '2024-03-23', NULL,
    3400, NULL,
    NULL,
    'Reviewed'
),

-- Project 43: LW EN→ZH LCA 2024 Q2
-- Mei — Submitted
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to Chinese Simplified Acceptability 2024 Q2'
     AND c.email = 'mei.chen@gmail.com'
     LIMIT 1),
    '2024-04-04', NULL,
    700, NULL,
    NULL,
    'Submitted'
),

-- Project 44: VT EN→ES HT 2024 Q2
-- Carlos — Submitted
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'VerboTech English to Spanish Human Translation 2024 Q2'
     AND c.email = 'carlos.mendez@gmail.com'
     LIMIT 1),
    '2024-04-08', NULL,
    2600, NULL,
    NULL,
    'Submitted'
),

-- Project 45: GL EN→IT HT 2024 Q2
-- Lucia — Reviewed
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'GlobalLang English to Italian Human Translation 2024 Q2'
     AND c.email = 'lucia.romano@gmail.com'
     LIMIT 1),
    '2024-04-13', NULL,
    3100, NULL,
    NULL,
    'Reviewed'
),

-- Project 48: TG EN→RU MTPE 2024 Q2
-- Ivan — Submitted
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'TransGlobal English to Russian MTPE 2024 Q2'
     AND c.email = 'ivan.petrov@gmail.com'
     LIMIT 1),
    '2024-04-28', NULL,
    550, NULL,
    NULL,
    'Submitted'
),


-- ================================================================
-- 2024 Q3 ACTIVE WORK RECORDS — SUBMITTED
-- ================================================================

-- Project 49: TG EN→FR LCA 2024 Q3
-- Pierre — Submitted
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'TransGlobal English to French Acceptability 2024 Q3'
     AND c.email = 'pierre.dubois@gmail.com'
     LIMIT 1),
    '2024-06-04', NULL,
    820, NULL,
    NULL,
    'Submitted'
),

-- Project 50: LW EN→KO HT 2024 Q3
-- Yuki — Submitted
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to Korean Human Translation 2024 Q3'
     AND c.email = 'yuki.tanaka@gmail.com'
     LIMIT 1),
    '2024-06-13', NULL,
    3200, NULL,
    NULL,
    'Submitted'
),

-- Project 51: VT ES→EN HT 2024 Q3
-- Carlos — Submitted
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'VerboTech Spanish to English Human Translation 2024 Q3'
     AND c.email = 'carlos.mendez@gmail.com'
     LIMIT 1),
    '2024-06-18', NULL,
    2900, NULL,
    NULL,
    'Submitted'
),

-- Project 52: GL EN→AR HT 2024 Q3
-- Fatima — Submitted
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'GlobalLang English to Arabic Human Translation 2024 Q3'
     AND c.email = 'fatima.alrashid@gmail.com'
     LIMIT 1),
    '2024-06-23', NULL,
    3500, NULL,
    NULL,
    'Submitted'
),

-- Project 47: GL EN→JA LCA 2024 Q2 — ON HOLD
-- Yuki submitted partial work before project went on hold
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'GlobalLang English to Japanese Acceptability 2024 Q2'
     AND c.email = 'yuki.tanaka@gmail.com'
     LIMIT 1),
    '2024-04-23', NULL,
    350, NULL,
    'Project paused by agency. Work stopped at 350 hits.',
    'Submitted'
);


-- ================================================================
-- SECTION 2 — COMMUNICATION LOG
-- ================================================================

INSERT INTO communication_log
(assignment_id, sender_type, manager_sender_id,
 collaborator_sender_id, message_content, sent_at)
VALUES

-- ================================================================
-- PROJECT 1: TG EN→FR HT 2023 Q1 — Amara Diallo
-- ================================================================
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'TransGlobal English to French Human Translation 2023 Q1'
     AND c.email = 'amara.diallo@gmail.com'
     LIMIT 1),
    'PM',
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    NULL,
    'Hi Amara, you have been assigned to the TransGlobal EN to FR project. Please log in and begin as soon as possible. Deadline is 15th February.',
    '2023-01-12 09:00:00'
),
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'TransGlobal English to French Human Translation 2023 Q1'
     AND c.email = 'amara.diallo@gmail.com'
     LIMIT 1),
    'Collaborator',
    NULL,
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'amara.diallo@gmail.com'),
    'Thank you. I have logged in and started. The content is clear. I will have a first batch ready by end of this week.',
    '2023-01-13 10:30:00'
),

-- ================================================================
-- PROJECT 3: LW EN→DE HT 2023 Q1 — Klaus Weber
-- ================================================================
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to German Human Translation 2023 Q1'
     AND c.email = 'klaus.weber@gmail.com'
     LIMIT 1),
    'PM',
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    NULL,
    'Klaus, please note LinguaWorld requires formal register throughout. Please check style guide on the platform before starting.',
    '2023-02-03 08:30:00'
),
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to German Human Translation 2023 Q1'
     AND c.email = 'klaus.weber@gmail.com'
     LIMIT 1),
    'Collaborator',
    NULL,
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'klaus.weber@gmail.com'),
    'Understood. I have reviewed the style guide. Formal register noted. Will deliver by 28th February.',
    '2023-02-03 11:00:00'
),

-- ================================================================
-- PROJECT 16: TG EN→AR HT 2023 Q3 — Multi-account
-- ================================================================
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     JOIN platform_account pac ON pa.account_id = pac.account_id
     WHERE tp.project_name =
       'TransGlobal English to Arabic Human Translation 2023 Q3'
     AND c.email = 'fatima.alrashid@gmail.com'
     AND pac.account_email = 'ls.enar.tg.2023q3a@gmail.com'
     LIMIT 1),
    'PM',
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    NULL,
    'Fatima, you have Account A for this project. Yara is on Account B. Please coordinate if you see any overlap in terminology.',
    '2023-06-18 09:00:00'
),
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     JOIN platform_account pac ON pa.account_id = pac.account_id
     WHERE tp.project_name =
       'TransGlobal English to Arabic Human Translation 2023 Q3'
     AND c.email = 'yara.mahmoud@gmail.com'
     AND pac.account_email = 'ls.enar.tg.2023q3b@gmail.com'
     LIMIT 1),
    'PM',
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    NULL,
    'Yara, you have Account B for this project. This is your biggest project so far. Let me know if you have any questions.',
    '2023-06-20 09:30:00'
),

-- ================================================================
-- PROJECT 40: TG EN→FR HT 2024 Q2 — Active project
-- ================================================================
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     JOIN platform_account pac ON pa.account_id = pac.account_id
     WHERE tp.project_name =
       'TransGlobal English to French Human Translation 2024 Q2'
     AND c.email = 'amara.diallo@gmail.com'
     AND pac.account_email = 'ls.enfr.tg.2024q2a@gmail.com'
     LIMIT 1),
    'PM',
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    NULL,
    'Amara, new TransGlobal EN to FR project assigned to you on Account A. Pierre is on Account B. Deadline is 15th May.',
    '2024-03-12 09:00:00'
),
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     JOIN platform_account pac ON pa.account_id = pac.account_id
     WHERE tp.project_name =
       'TransGlobal English to French Human Translation 2024 Q2'
     AND c.email = 'amara.diallo@gmail.com'
     AND pac.account_email = 'ls.enfr.tg.2024q2a@gmail.com'
     LIMIT 1),
    'Collaborator',
    NULL,
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'amara.diallo@gmail.com'),
    'Got it. I have already started on Account A. Will submit my first batch by end of this week.',
    '2024-03-13 10:00:00'
),

-- ================================================================
-- PROJECT 42: LW EN→DE HT 2024 Q2 — Lena Fischer
-- ================================================================
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to German Human Translation 2024 Q2'
     AND c.email = 'lena.fischer@gmail.com'
     LIMIT 1),
    'PM',
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    NULL,
    'Lena, Klaus is unavailable for this project. You are assigned for the LinguaWorld German project. Same formal register requirements apply.',
    '2024-03-22 09:00:00'
),
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'LinguaWorld English to German Human Translation 2024 Q2'
     AND c.email = 'lena.fischer@gmail.com'
     LIMIT 1),
    'Collaborator',
    NULL,
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'lena.fischer@gmail.com'),
    'Happy to take this on. I am familiar with LinguaWorld style from previous projects. Will start immediately.',
    '2024-03-22 11:30:00'
),

-- ================================================================
-- PROJECT 47: GL EN→JA LCA 2024 Q2 — On Hold notice
-- ================================================================
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'GlobalLang English to Japanese Acceptability 2024 Q2'
     AND c.email = 'yuki.tanaka@gmail.com'
     LIMIT 1),
    'PM',
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    NULL,
    'Yuki, GlobalLang has placed this project on hold. Please stop work for now. We will notify you when it resumes. Thank you for the 350 hits already completed.',
    '2024-05-10 14:00:00'
),
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'GlobalLang English to Japanese Acceptability 2024 Q2'
     AND c.email = 'yuki.tanaka@gmail.com'
     LIMIT 1),
    'Collaborator',
    NULL,
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yuki.tanaka@gmail.com'),
    'Understood. I have stopped work. Ready to resume when you give the go ahead.',
    '2024-05-10 16:00:00'
),

-- ================================================================
-- PROJECT 52: GL EN→AR HT 2024 Q3 — Active project
-- ================================================================
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'GlobalLang English to Arabic Human Translation 2024 Q3'
     AND c.email = 'fatima.alrashid@gmail.com'
     LIMIT 1),
    'PM',
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    NULL,
    'Fatima, GlobalLang Arabic project assigned. Deadline 20th September. Please confirm receipt.',
    '2024-06-22 09:00:00'
),
(
    (SELECT assignment_id FROM project_assignment pa
     JOIN translation_project tp ON pa.project_id = tp.project_id
     JOIN collaborator c ON pa.collaborator_id = c.collaborator_id
     WHERE tp.project_name =
       'GlobalLang English to Arabic Human Translation 2024 Q3'
     AND c.email = 'fatima.alrashid@gmail.com'
     LIMIT 1),
    'Collaborator',
    NULL,
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'fatima.alrashid@gmail.com'),
    'Confirmed. I have reviewed the project scope. Will begin tomorrow and aim to submit first batch within two weeks.',
    '2024-06-22 14:00:00'
);