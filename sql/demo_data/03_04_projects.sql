-- ================================================================
-- LINGUASYNC DEMO DATA
-- Demo Batch 3 — Translation Projects 2023
-- 30 projects spanning all 4 quarters of 2023
-- All 2023 projects are Completed
-- Rates vary by agency and project type
-- All reference tables referenced by name via subquery
-- ================================================================


-- ================================================================
-- Q1 2023 — JANUARY TO MARCH — 8 PROJECTS
-- ================================================================

INSERT INTO translation_project
(project_name, project_type_id, agency_rate, collaborator_rate,
 project_status, deadline, agency_id, currency_id)
VALUES

-- PROJECT 1
(
    'TransGlobal English to French Human Translation 2023 Q1',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.12, 0.08, 'Completed', '2023-02-15',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 2
(
    'TransGlobal English to Arabic MTPE 2023 Q1',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'MTPE'),
    0.07, 0.04, 'Completed', '2023-02-28',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 3
(
    'LinguaWorld English to German Human Translation 2023 Q1',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.14, 0.09, 'Completed', '2023-03-10',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 4
(
    'VerboTech French to English Human Translation 2023 Q1',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.11, 0.07, 'Completed', '2023-03-20',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 5
(
    'GlobalLang English to Italian Human Translation 2023 Q1',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.12, 0.08, 'Completed', '2023-03-25',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 6
(
    'TransGlobal English to Spanish Acceptability 2023 Q1',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Long Context Acceptability'),
    0.09, 0.06, 'Completed', '2023-03-28',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 7
(
    'LinguaWorld English to Chinese Simplified MTPE 2023 Q1',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'MTPE'),
    0.08, 0.05, 'Completed', '2023-03-30',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 8
(
    'GlobalLang English to Japanese MTPE 2023 Q1',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'MTPE'),
    0.07, 0.04, 'Completed', '2023-03-31',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),


-- ================================================================
-- Q2 2023 — APRIL TO JUNE — 7 PROJECTS
-- ================================================================

-- PROJECT 9
(
    'TransGlobal English to Portuguese Human Translation 2023 Q2',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.12, 0.08, 'Completed', '2023-04-30',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 10
(
    'LinguaWorld English to Italian Human Translation 2023 Q2',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.13, 0.09, 'Completed', '2023-05-15',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 11
(
    'VerboTech Spanish to English Acceptability 2023 Q2',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Long Context Acceptability'),
    0.09, 0.06, 'Completed', '2023-05-30',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 12
(
    'GlobalLang English to Korean Human Translation 2023 Q2',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.13, 0.09, 'Completed', '2023-06-10',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 13
(
    'TransGlobal English to Russian MTPE 2023 Q2',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'MTPE'),
    0.07, 0.04, 'Completed', '2023-06-15',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 14
(
    'LinguaWorld English to Dutch Human Translation 2023 Q2',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.13, 0.09, 'Completed', '2023-06-20',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 15
(
    'VerboTech English to French Acceptability 2023 Q2',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Long Context Acceptability'),
    0.10, 0.06, 'Completed', '2023-06-28',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),


-- ================================================================
-- Q3 2023 — JULY TO SEPTEMBER — 8 PROJECTS
-- ================================================================

-- PROJECT 16
(
    'TransGlobal English to Arabic Human Translation 2023 Q3',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.12, 0.08, 'Completed', '2023-07-31',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 17
(
    'LinguaWorld French to Arabic Human Translation 2023 Q3',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.14, 0.09, 'Completed', '2023-08-15',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 18
(
    'VerboTech English to Spanish Human Translation 2023 Q3',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.11, 0.07, 'Completed', '2023-08-30',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 19
(
    'GlobalLang English to Chinese Traditional MTPE 2023 Q3',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'MTPE'),
    0.08, 0.05, 'Completed', '2023-09-10',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 20
(
    'TransGlobal Arabic to English Human Translation 2023 Q3',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.12, 0.08, 'Completed', '2023-09-15',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 21
(
    'LinguaWorld English to Turkish Acceptability 2023 Q3',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Long Context Acceptability'),
    0.09, 0.06, 'Completed', '2023-09-20',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 22
(
    'VerboTech English to German MTPE 2023 Q3',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'MTPE'),
    0.07, 0.04, 'Completed', '2023-09-25',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 23
(
    'GlobalLang Spanish to French Human Translation 2023 Q3',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.12, 0.08, 'Completed', '2023-09-30',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),


-- ================================================================
-- Q4 2023 — OCTOBER TO DECEMBER — 7 PROJECTS
-- ================================================================

-- PROJECT 24
(
    'TransGlobal English to French Human Translation 2023 Q4',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.12, 0.08, 'Completed', '2023-10-31',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 25
(
    'LinguaWorld English to Japanese Human Translation 2023 Q4',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.14, 0.09, 'Completed', '2023-11-15',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 26
(
    'VerboTech English to Portuguese Acceptability 2023 Q4',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Long Context Acceptability'),
    0.09, 0.06, 'Completed', '2023-11-30',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 27
(
    'GlobalLang English to Arabic Human Translation 2023 Q4',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.12, 0.08, 'Completed', '2023-12-01',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 28
(
    'TransGlobal English to Chinese Simplified MTPE 2023 Q4',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'MTPE'),
    0.07, 0.04, 'Completed', '2023-12-10',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 29
(
    'LinguaWorld Portuguese Brazil to English Human Translation 2023 Q4',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.13, 0.09, 'Completed', '2023-12-15',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 30
(
    'GlobalLang English to Spanish Acceptability 2023 Q4',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Long Context Acceptability'),
    0.10, 0.06, 'Completed', '2023-12-20',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
);

-- ================================================================
-- LINGUASYNC DEMO DATA
-- Demo Batch 4 — Translation Projects 2024
-- 30 projects spanning all 4 quarters of 2024
-- Mixed statuses — Completed, Assigned, Not Assigned,
-- Cancelled, On Hold
-- ================================================================


-- ================================================================
-- Q1 2024 — JANUARY TO MARCH — 9 PROJECTS
-- ================================================================

INSERT INTO translation_project
(project_name, project_type_id, agency_rate, collaborator_rate,
 project_status, deadline, agency_id, currency_id)
VALUES

-- PROJECT 31
(
    'TransGlobal English to French Human Translation 2024 Q1',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.12, 0.08, 'Completed', '2024-01-31',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 32
(
    'TransGlobal English to Arabic Acceptability 2024 Q1',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Long Context Acceptability'),
    0.09, 0.06, 'Completed', '2024-02-10',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 33
(
    'LinguaWorld English to German Human Translation 2024 Q1',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.14, 0.09, 'Completed', '2024-02-15',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 34
(
    'LinguaWorld English to Japanese MTPE 2024 Q1',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'MTPE'),
    0.08, 0.05, 'Completed', '2024-02-28',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 35
(
    'VerboTech French to English Human Translation 2024 Q1',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.11, 0.07, 'Cancelled', '2024-02-20',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 36
(
    'GlobalLang English to Italian Human Translation 2024 Q1',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.12, 0.08, 'Completed', '2024-03-10',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 37
(
    'TransGlobal English to Spanish Human Translation 2024 Q1',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.12, 0.08, 'Completed', '2024-03-15',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 38
(
    'GlobalLang English to Chinese Simplified Acceptability 2024 Q1',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Long Context Acceptability'),
    0.10, 0.07, 'Completed', '2024-03-20',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 39
(
    'LinguaWorld English to Portuguese Human Translation 2024 Q1',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.13, 0.09, 'Completed', '2024-03-28',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),


-- ================================================================
-- Q2 2024 — APRIL TO JUNE — 9 PROJECTS
-- ================================================================

-- PROJECT 40
(
    'TransGlobal English to French Human Translation 2024 Q2',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.13, 0.08, 'Assigned', '2024-05-15',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 41
(
    'TransGlobal English to Arabic MTPE 2024 Q2',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'MTPE'),
    0.07, 0.04, 'Assigned', '2024-05-30',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 42
(
    'LinguaWorld English to German Human Translation 2024 Q2',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.14, 0.09, 'Assigned', '2024-06-10',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 43
(
    'LinguaWorld English to Chinese Simplified Acceptability 2024 Q2',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Long Context Acceptability'),
    0.10, 0.07, 'Assigned', '2024-06-15',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 44
(
    'VerboTech English to Spanish Human Translation 2024 Q2',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.11, 0.07, 'Assigned', '2024-06-20',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 45
(
    'GlobalLang English to Italian Human Translation 2024 Q2',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.12, 0.08, 'Assigned', '2024-06-25',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 46
(
    'VerboTech English to German MTPE 2024 Q2',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'MTPE'),
    0.07, 0.04, 'Cancelled', '2024-05-10',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 47
(
    'GlobalLang English to Japanese Acceptability 2024 Q2',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Long Context Acceptability'),
    0.10, 0.07, 'On Hold', '2024-06-30',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 48
(
    'TransGlobal English to Russian MTPE 2024 Q2',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'MTPE'),
    0.07, 0.04, 'Assigned', '2024-06-28',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),


-- ================================================================
-- Q3 2024 — JULY TO SEPTEMBER — 7 PROJECTS
-- ================================================================

-- PROJECT 49
(
    'TransGlobal English to French Acceptability 2024 Q3',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Long Context Acceptability'),
    0.10, 0.06, 'Assigned', '2024-08-15',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 50
(
    'LinguaWorld English to Korean Human Translation 2024 Q3',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.14, 0.09, 'Assigned', '2024-08-30',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 51
(
    'VerboTech Spanish to English Human Translation 2024 Q3',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.11, 0.07, 'Assigned', '2024-09-10',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 52
(
    'GlobalLang English to Arabic Human Translation 2024 Q3',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.12, 0.08, 'Assigned', '2024-09-20',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 53
(
    'TransGlobal English to German Human Translation 2024 Q3',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.12, 0.08, 'Not Assigned', '2024-09-30',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 54
(
    'LinguaWorld English to Portuguese MTPE 2024 Q3',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'MTPE'),
    0.08, 0.05, 'Not Assigned', '2024-09-25',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 55
(
    'GlobalLang English to Chinese Traditional Acceptability 2024 Q3',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Long Context Acceptability'),
    0.10, 0.07, 'On Hold', '2024-09-15',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),


-- ================================================================
-- Q4 2024 — OCTOBER TO DECEMBER — 5 PROJECTS
-- ================================================================

-- PROJECT 56
(
    'TransGlobal English to Arabic Human Translation 2024 Q4',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.12, 0.08, 'Not Assigned', '2024-10-31',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 57
(
    'LinguaWorld English to Spanish Human Translation 2024 Q4',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.13, 0.09, 'Not Assigned', '2024-11-15',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 58
(
    'VerboTech English to French Acceptability 2024 Q4',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Long Context Acceptability'),
    0.10, 0.06, 'Cancelled', '2024-11-30',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 59
(
    'GlobalLang English to Italian MTPE 2024 Q4',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'MTPE'),
    0.07, 0.04, 'Not Assigned', '2024-12-10',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
),

-- PROJECT 60
(
    'TransGlobal English to French Human Translation 2024 Q4',
    (SELECT project_type_id FROM project_type
     WHERE project_type_name = 'Human Translation'),
    0.13, 0.08, 'On Hold', '2024-12-20',
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    (SELECT currency_id FROM currency
     WHERE currency_code = 'USD')
);