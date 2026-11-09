-- ================================================================
-- LINGUASYNC DEMO DATA
-- Demo Batch 7 — Rate History and Project Assignments
-- ================================================================
-- RATE HISTORY:
-- Every project gets one initial rate history record
-- This represents the rate agreed when project was created
-- The fn_sync_rate_history trigger handles future changes
-- We insert initial records manually since the trigger
-- only fires on UPDATE not on INSERT
--
-- PROJECT ASSIGNMENTS:
-- Completed projects have full assignments
-- Active projects have current assignments
-- Cancelled and On Hold projects have no assignments
-- or assignments that were stopped
-- Multi-account scenarios included for demonstration
-- ================================================================


-- ================================================================
-- SECTION 1 — RATE HISTORY
-- One initial record per project
-- effective_from = project created date
-- effective_to = NULL (currently active rate)
-- changed_by_manager_id = John (Principal)
-- ================================================================

INSERT INTO rate_history
(project_id, changed_by_manager_id, agency_rate,
 collaborator_rate, effective_from, effective_to)
VALUES

-- ================================================================
-- 2023 PROJECTS — RATE HISTORY
-- ================================================================

-- Project 1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2023 Q1'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.12, 0.08, '2023-01-10', NULL
),
-- Project 2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic MTPE 2023 Q1'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.07, 0.04, '2023-01-20', NULL
),
-- Project 3
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to German Human Translation 2023 Q1'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.14, 0.09, '2023-02-01', NULL
),
-- Project 4
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech French to English Human Translation 2023 Q1'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.11, 0.07, '2023-02-10', NULL
),
-- Project 5
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Italian Human Translation 2023 Q1'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.12, 0.08, '2023-02-15', NULL
),
-- Project 6
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Spanish Acceptability 2023 Q1'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.09, 0.06, '2023-02-20', NULL
),
-- Project 7
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Chinese Simplified MTPE 2023 Q1'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.08, 0.05, '2023-02-25', NULL
),
-- Project 8
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Japanese MTPE 2023 Q1'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.07, 0.04, '2023-03-01', NULL
),
-- Project 9
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Portuguese Human Translation 2023 Q2'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.12, 0.08, '2023-03-15', NULL
),
-- Project 10
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Italian Human Translation 2023 Q2'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.13, 0.09, '2023-04-01', NULL
),
-- Project 11
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech Spanish to English Acceptability 2023 Q2'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.09, 0.06, '2023-04-10', NULL
),
-- Project 12
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Korean Human Translation 2023 Q2'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.13, 0.09, '2023-04-15', NULL
),
-- Project 13
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Russian MTPE 2023 Q2'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.07, 0.04, '2023-05-01', NULL
),
-- Project 14
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Dutch Human Translation 2023 Q2'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.13, 0.09, '2023-05-10', NULL
),
-- Project 15
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to French Acceptability 2023 Q2'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.10, 0.06, '2023-05-20', NULL
),
-- Project 16
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic Human Translation 2023 Q3'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.12, 0.08, '2023-06-15', NULL
),
-- Project 17
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld French to Arabic Human Translation 2023 Q3'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.14, 0.09, '2023-07-01', NULL
),
-- Project 18
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to Spanish Human Translation 2023 Q3'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.11, 0.07, '2023-07-10', NULL
),
-- Project 19
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Chinese Traditional MTPE 2023 Q3'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.08, 0.05, '2023-07-15', NULL
),
-- Project 20
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal Arabic to English Human Translation 2023 Q3'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.12, 0.08, '2023-07-20', NULL
),
-- Project 21
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Turkish Acceptability 2023 Q3'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.09, 0.06, '2023-08-01', NULL
),
-- Project 22
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to German MTPE 2023 Q3'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.07, 0.04, '2023-08-10', NULL
),
-- Project 23
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang Spanish to French Human Translation 2023 Q3'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.12, 0.08, '2023-08-15', NULL
),
-- Project 24
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2023 Q4'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.12, 0.08, '2023-09-10', NULL
),
-- Project 25
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Japanese Human Translation 2023 Q4'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.14, 0.09, '2023-10-01', NULL
),
-- Project 26
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to Portuguese Acceptability 2023 Q4'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.09, 0.06, '2023-10-10', NULL
),
-- Project 27
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Arabic Human Translation 2023 Q4'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.12, 0.08, '2023-10-15', NULL
),
-- Project 28
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Chinese Simplified MTPE 2023 Q4'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.07, 0.04, '2023-10-20', NULL
),
-- Project 29
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld Portuguese Brazil to English Human Translation 2023 Q4'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.13, 0.09, '2023-11-01', NULL
),
-- Project 30
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Spanish Acceptability 2023 Q4'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.10, 0.06, '2023-11-10', NULL
),


-- ================================================================
-- 2024 PROJECTS — RATE HISTORY
-- ================================================================

-- Project 31
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2024 Q1'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.12, 0.08, '2023-12-10', NULL
),
-- Project 32
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic Acceptability 2024 Q1'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.09, 0.06, '2023-12-15', NULL
),
-- Project 33
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to German Human Translation 2024 Q1'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.14, 0.09, '2023-12-20', NULL
),
-- Project 34
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Japanese MTPE 2024 Q1'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.08, 0.05, '2024-01-05', NULL
),
-- Project 35 — Cancelled
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech French to English Human Translation 2024 Q1'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.11, 0.07, '2024-01-10', NULL
),
-- Project 36
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Italian Human Translation 2024 Q1'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.12, 0.08, '2024-01-15', NULL
),
-- Project 37
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Spanish Human Translation 2024 Q1'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.12, 0.08, '2024-01-20', NULL
),
-- Project 38
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Chinese Simplified Acceptability 2024 Q1'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.10, 0.07, '2024-02-01', NULL
),
-- Project 39
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Portuguese Human Translation 2024 Q1'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.13, 0.09, '2024-02-10', NULL
),
-- Project 40
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2024 Q2'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.13, 0.08, '2024-03-10', NULL
),
-- Project 41
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic MTPE 2024 Q2'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.07, 0.04, '2024-03-15', NULL
),
-- Project 42
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to German Human Translation 2024 Q2'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.14, 0.09, '2024-03-20', NULL
),
-- Project 43
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Chinese Simplified Acceptability 2024 Q2'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.10, 0.07, '2024-04-01', NULL
),
-- Project 44
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to Spanish Human Translation 2024 Q2'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.11, 0.07, '2024-04-05', NULL
),
-- Project 45
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Italian Human Translation 2024 Q2'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.12, 0.08, '2024-04-10', NULL
),
-- Project 46 — Cancelled
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to German MTPE 2024 Q2'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.07, 0.04, '2024-04-15', NULL
),
-- Project 47 — On Hold
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Japanese Acceptability 2024 Q2'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.10, 0.07, '2024-04-20', NULL
),
-- Project 48
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Russian MTPE 2024 Q2'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.07, 0.04, '2024-04-25', NULL
),
-- Project 49
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Acceptability 2024 Q3'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.10, 0.06, '2024-06-01', NULL
),
-- Project 50
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Korean Human Translation 2024 Q3'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.14, 0.09, '2024-06-10', NULL
),
-- Project 51
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech Spanish to English Human Translation 2024 Q3'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.11, 0.07, '2024-06-15', NULL
),
-- Project 52
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Arabic Human Translation 2024 Q3'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.12, 0.08, '2024-06-20', NULL
),
-- Project 53 — Not Assigned
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to German Human Translation 2024 Q3'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.12, 0.08, '2024-07-01', NULL
),
-- Project 54 — Not Assigned
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Portuguese MTPE 2024 Q3'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.08, 0.05, '2024-07-05', NULL
),
-- Project 55 — On Hold
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Chinese Traditional Acceptability 2024 Q3'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.10, 0.07, '2024-07-10', NULL
),
-- Project 56 — Not Assigned
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic Human Translation 2024 Q4'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.12, 0.08, '2024-09-01', NULL
),
-- Project 57 — Not Assigned
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Spanish Human Translation 2024 Q4'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.13, 0.09, '2024-09-10', NULL
),
-- Project 58 — Cancelled
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to French Acceptability 2024 Q4'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.10, 0.06, '2024-09-15', NULL
),
-- Project 59 — Not Assigned
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Italian MTPE 2024 Q4'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.07, 0.04, '2024-09-20', NULL
),
-- Project 60 — On Hold
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2024 Q4'),
    (SELECT manager_id FROM project_manager WHERE email =
     'john.adeyemi@linguasync.com'),
    0.13, 0.08, '2024-10-01', NULL
);


-- ================================================================
-- SECTION 2 — PROJECT ASSIGNMENTS
-- ================================================================
-- Completed projects: all assignments done and closed
-- Active projects: current assignments in progress
-- Cancelled/On Hold: no assignments or stopped
-- Multi-account: Mei Chen on two accounts for Project 43
-- Ahmed Hassan: assigned to early 2023 projects before
--               becoming inactive
-- ================================================================

INSERT INTO project_assignment
(collaborator_id, project_id, account_id,
 assigned_by_manager_id, assignment_date)
VALUES

-- ================================================================
-- 2023 Q1 ASSIGNMENTS
-- ================================================================

-- Project 1: TG EN→FR HT 2023 Q1 — Amara Diallo
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'amara.diallo@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2023 Q1'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enfr.tg.2023q1@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-01-12'
),

-- Project 1: TG EN→FR HT 2023 Q1 — Pierre Dubois (second collaborator)
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'pierre.dubois@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2023 Q1'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enfr.tg.2023q1@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-01-15'
),

-- Project 2: TG EN→AR MTPE 2023 Q1 — Fatima Al-Rashid
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'fatima.alrashid@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic MTPE 2023 Q1'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enar.tg.2023q1@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-01-22'
),

-- Project 3: LW EN→DE HT 2023 Q1 — Klaus Weber
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'klaus.weber@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to German Human Translation 2023 Q1'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.ende.lw.2023q1@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2023-02-03'
),

-- Project 4: VT FR→EN HT 2023 Q1 — Carlos Mendez
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'carlos.mendez@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech French to English Human Translation 2023 Q1'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.fren.vt.2023q1@gmail.com'
     AND platform = 'VerboTech Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2023-02-12'
),

-- Project 5: GL EN→IT HT 2023 Q1 — Lucia Romano
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'lucia.romano@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Italian Human Translation 2023 Q1'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enit.gl.2023q1@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-02-17'
),

-- Project 6: TG EN→ES LCA 2023 Q1 — Carlos Mendez
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'carlos.mendez@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Spanish Acceptability 2023 Q1'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enes.tg.2023q1@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-02-22'
),

-- Project 7: LW EN→ZH MTPE 2023 Q1 — Mei Chen
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'mei.chen@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Chinese Simplified MTPE 2023 Q1'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enzh.lw.2023q1@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2023-02-27'
),

-- Project 8: GL EN→JA MTPE 2023 Q1 — Yuki Tanaka
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yuki.tanaka@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Japanese MTPE 2023 Q1'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enja.gl.2023q1@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2023-03-03'
),


-- ================================================================
-- 2023 Q2 ASSIGNMENTS
-- ================================================================

-- Project 9: TG EN→PT HT 2023 Q2 — Sofia Ferreira
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'sofia.ferreira@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Portuguese Human Translation 2023 Q2'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enpt.tg.2023q2@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-03-18'
),

-- Project 10: LW EN→IT HT 2023 Q2 — Lucia Romano
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'lucia.romano@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Italian Human Translation 2023 Q2'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enit.lw.2023q2@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2023-04-05'
),

-- Project 11: VT ES→EN LCA 2023 Q2 — Carlos Mendez
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'carlos.mendez@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech Spanish to English Acceptability 2023 Q2'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.esen.vt.2023q2@gmail.com'
     AND platform = 'VerboTech Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-04-12'
),

-- Project 12: GL EN→KO HT 2023 Q2 — Yuki Tanaka
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yuki.tanaka@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Korean Human Translation 2023 Q2'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enko.gl.2023q2@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2023-04-18'
),

-- Project 13: TG EN→RU MTPE 2023 Q2 — Ivan Petrov
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'ivan.petrov@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Russian MTPE 2023 Q2'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enru.tg.2023q2@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-05-03'
),

-- Project 14: LW EN→NL HT 2023 Q2 — Ahmed Hassan
-- Historical assignment before he became inactive
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'ahmed.hassan@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Dutch Human Translation 2023 Q2'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.ennl.lw.2023q2@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2023-05-12'
),

-- Project 15: VT EN→FR LCA 2023 Q2 — Amara Diallo
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'amara.diallo@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to French Acceptability 2023 Q2'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enfr.vt.2023q2@gmail.com'
     AND platform = 'VerboTech Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-05-22'
),


-- ================================================================
-- 2023 Q3 ASSIGNMENTS
-- ================================================================

-- Project 16: TG EN→AR HT 2023 Q3
-- Fatima on first account
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'fatima.alrashid@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic Human Translation 2023 Q3'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enar.tg.2023q3a@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-06-18'
),
-- Yara on second account — multi-account same project
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yara.mahmoud@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic Human Translation 2023 Q3'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enar.tg.2023q3b@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-06-20'
),

-- Project 17: LW FR→AR HT 2023 Q3 — Amara Diallo
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'amara.diallo@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld French to Arabic Human Translation 2023 Q3'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.frar.lw.2023q3@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2023-07-03'
),

-- Project 18: VT EN→ES HT 2023 Q3 — Carlos Mendez
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'carlos.mendez@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to Spanish Human Translation 2023 Q3'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enes.vt.2023q3@gmail.com'
     AND platform = 'VerboTech Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-07-12'
),

-- Project 19: GL EN→ZH-Hant MTPE 2023 Q3 — Mei Chen
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'mei.chen@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Chinese Traditional MTPE 2023 Q3'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enzh.gl.2023q3@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2023-07-17'
),

-- Project 20: TG AR→EN HT 2023 Q3 — Fatima Al-Rashid
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'fatima.alrashid@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal Arabic to English Human Translation 2023 Q3'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.aren.tg.2023q3@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-07-22'
),

-- Project 21: LW EN→TR LCA 2023 Q3 — Yuki Tanaka
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yuki.tanaka@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Turkish Acceptability 2023 Q3'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.entr.lw.2023q3@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2023-08-03'
),

-- Project 22: VT EN→DE MTPE 2023 Q3 — Klaus Weber
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'klaus.weber@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to German MTPE 2023 Q3'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.ende.vt.2023q3@gmail.com'
     AND platform = 'VerboTech Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2023-08-12'
),

-- Project 23: GL ES→FR HT 2023 Q3 — Carlos Mendez
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'carlos.mendez@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang Spanish to French Human Translation 2023 Q3'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.esfr.gl.2023q3@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-08-17'
),


-- ================================================================
-- 2023 Q4 ASSIGNMENTS
-- ================================================================

-- Project 24: TG EN→FR HT 2023 Q4 — Pierre Dubois
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'pierre.dubois@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2023 Q4'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enfr.tg.2023q4@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-09-12'
),

-- Project 25: LW EN→JA HT 2023 Q4 — Yuki Tanaka
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yuki.tanaka@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Japanese Human Translation 2023 Q4'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enja.lw.2023q4@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2023-10-03'
),

-- Project 26: VT EN→PT LCA 2023 Q4 — Sofia Ferreira
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'sofia.ferreira@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to Portuguese Acceptability 2023 Q4'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enpt.vt.2023q4@gmail.com'
     AND platform = 'VerboTech Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-10-12'
),

-- Project 27: GL EN→AR HT 2023 Q4 — Yara Mahmoud
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yara.mahmoud@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Arabic Human Translation 2023 Q4'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enar.gl.2023q4@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2023-10-17'
),

-- Project 28: TG EN→ZH MTPE 2023 Q4 — Mei Chen
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'mei.chen@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Chinese Simplified MTPE 2023 Q4'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enzh.tg.2023q4@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-10-22'
),

-- Project 29: LW PT-BR→EN HT 2023 Q4 — Sofia Ferreira
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'sofia.ferreira@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld Portuguese Brazil to English Human Translation 2023 Q4'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.ptbren.lw.2023q4@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2023-11-03'
),

-- Project 30: GL EN→ES LCA 2023 Q4 — Carlos Mendez
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'carlos.mendez@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Spanish Acceptability 2023 Q4'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enes.gl.2023q4@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-11-12'
),


-- ================================================================
-- 2024 Q1 ASSIGNMENTS
-- ================================================================

-- Project 31: TG EN→FR HT 2024 Q1 — Amara Diallo
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'amara.diallo@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2024 Q1'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enfr.tg.2024q1@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-12-12'
),

-- Project 32: TG EN→AR LCA 2024 Q1 — Fatima Al-Rashid
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'fatima.alrashid@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic Acceptability 2024 Q1'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enar.tg.2024q2@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2023-12-17'
),

-- Project 33: LW EN→DE HT 2024 Q1 — Klaus Weber
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'klaus.weber@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to German Human Translation 2024 Q1'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.ende.lw.2024q1@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2023-12-22'
),

-- Project 34: LW EN→JA MTPE 2024 Q1 — Yuki Tanaka
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yuki.tanaka@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Japanese MTPE 2024 Q1'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enja.lw.2024q1@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2024-01-07'
),

-- Project 36: GL EN→IT HT 2024 Q1 — Marco Rossi
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'marco.rossi@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Italian Human Translation 2024 Q1'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enit.gl.2024q1@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2024-01-17'
),

-- Project 37: TG EN→ES HT 2024 Q1 — Carlos Mendez
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'carlos.mendez@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Spanish Human Translation 2024 Q1'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enes.tg.2024q1@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2024-01-22'
),

-- Project 38: GL EN→ZH LCA 2024 Q1 — Mei Chen
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'mei.chen@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Chinese Simplified Acceptability 2024 Q1'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enzh.gl.2024q1@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2024-02-03'
),

-- Project 39: LW EN→PT HT 2024 Q1 — Sofia Ferreira
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'sofia.ferreira@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Portuguese Human Translation 2024 Q1'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enpt.lw.2024q1@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2024-02-12'
),


-- ================================================================
-- 2024 Q2 ASSIGNMENTS — ACTIVE PROJECTS
-- ================================================================

-- Project 40: TG EN→FR HT 2024 Q2
-- Amara on first account
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'amara.diallo@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2024 Q2'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enfr.tg.2024q2a@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2024-03-12'
),
-- Pierre on second account — multi-account demonstration
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'pierre.dubois@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2024 Q2'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enfr.tg.2024q2b@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2024-03-15'
),

-- Project 41: TG EN→AR MTPE 2024 Q2 — Yara Mahmoud
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yara.mahmoud@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic MTPE 2024 Q2'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enar.tg.2024q2@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2024-03-17'
),

-- Project 42: LW EN→DE HT 2024 Q2 — Lena Fischer
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'lena.fischer@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to German Human Translation 2024 Q2'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.ende.lw.2024q2@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2024-03-22'
),

-- Project 43: LW EN→ZH LCA 2024 Q2
-- Mei Chen on first account
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'mei.chen@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Chinese Simplified Acceptability 2024 Q2'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enzh.lw.2024q2@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2024-04-03'
),

-- Project 44: VT EN→ES HT 2024 Q2 — Carlos Mendez
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'carlos.mendez@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to Spanish Human Translation 2024 Q2'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enes.vt.2024q2@gmail.com'
     AND platform = 'VerboTech Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2024-04-07'
),

-- Project 45: GL EN→IT HT 2024 Q2 — Lucia Romano
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'lucia.romano@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Italian Human Translation 2024 Q2'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enit.gl.2024q2@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2024-04-12'
),

-- Project 48: TG EN→RU MTPE 2024 Q2 — Ivan Petrov
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'ivan.petrov@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Russian MTPE 2024 Q2'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enru.tg.2024q2@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2024-04-27'
),


-- ================================================================
-- 2024 Q3 ASSIGNMENTS — ACTIVE PROJECTS
-- ================================================================

-- Project 49: TG EN→FR LCA 2024 Q3 — Pierre Dubois
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'pierre.dubois@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Acceptability 2024 Q3'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enfr.tg.2024q3@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2024-06-03'
),

-- Project 50: LW EN→KO HT 2024 Q3 — Yuki Tanaka
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yuki.tanaka@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Korean Human Translation 2024 Q3'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enko.lw.2024q3@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2024-06-12'
),

-- Project 51: VT ES→EN HT 2024 Q3 — Carlos Mendez
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'carlos.mendez@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech Spanish to English Human Translation 2024 Q3'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.esen.vt.2024q3@gmail.com'
     AND platform = 'VerboTech Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'olajire.yusuf@linguasync.com'),
    '2024-06-17'
),

-- Project 52: GL EN→AR HT 2024 Q3 — Fatima Al-Rashid
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'fatima.alrashid@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Arabic Human Translation 2024 Q3'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enar.gl.2024q3@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2024-06-22'
),

-- Project 47: GL EN→JA LCA 2024 Q2 — ON HOLD
-- Yuki was assigned before it went on hold
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yuki.tanaka@gmail.com'),
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Japanese Acceptability 2024 Q2'),
    (SELECT account_id FROM platform_account
     WHERE account_email = 'ls.enja.gl.2024q2@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT manager_id FROM project_manager
     WHERE email = 'beauty.bella@linguasync.com'),
    '2024-04-22'
);