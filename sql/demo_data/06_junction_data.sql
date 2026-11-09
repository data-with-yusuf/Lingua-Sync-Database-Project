-- ================================================================
-- LINGUASYNC DEMO DATA
-- Demo Batch 6 — Junction Data
-- PROJECT_PAIR, ACCOUNT_PAIR, COLLABORATOR_SKILL
-- ================================================================
-- All references use subqueries by name
-- No hardcoded IDs anywhere
-- ================================================================


-- ================================================================
-- PROJECT PAIR
-- Links each project to its language pair
-- Some projects have multiple language pairs
-- References TRANSLATION_PROJECT by name
-- References LANGUAGE_PAIR by source and target language code
-- ================================================================

INSERT INTO project_pair
(project_id, pair_id)
VALUES

-- ================================================================
-- 2023 PROJECTS
-- ================================================================

-- Project 1: TransGlobal English to French HT 2023 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2023 Q1'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'FR'))
),

-- Project 2: TransGlobal English to Arabic MTPE 2023 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic MTPE 2023 Q1'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'AR'))
),

-- Project 3: LinguaWorld English to German HT 2023 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to German Human Translation 2023 Q1'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'DE'))
),

-- Project 4: VerboTech French to English HT 2023 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech French to English Human Translation 2023 Q1'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'FR') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'EN'))
),

-- Project 5: GlobalLang English to Italian HT 2023 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Italian Human Translation 2023 Q1'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'IT'))
),

-- Project 6: TransGlobal English to Spanish LCA 2023 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Spanish Acceptability 2023 Q1'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'ES'))
),

-- Project 7: LinguaWorld English to Chinese Simplified MTPE 2023 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Chinese Simplified MTPE 2023 Q1'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'zh-Hans'))
),

-- Project 8: GlobalLang English to Japanese MTPE 2023 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Japanese MTPE 2023 Q1'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'JA'))
),

-- Project 9: TransGlobal English to Portuguese HT 2023 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Portuguese Human Translation 2023 Q2'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'pt-BR'))
),

-- Project 10: LinguaWorld English to Italian HT 2023 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Italian Human Translation 2023 Q2'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'IT'))
),

-- Project 11: VerboTech Spanish to English LCA 2023 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech Spanish to English Acceptability 2023 Q2'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'ES') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'EN'))
),

-- Project 12: GlobalLang English to Korean HT 2023 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Korean Human Translation 2023 Q2'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'KO'))
),

-- Project 13: TransGlobal English to Russian MTPE 2023 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Russian MTPE 2023 Q2'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'RU'))
),

-- Project 14: LinguaWorld English to Dutch HT 2023 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Dutch Human Translation 2023 Q2'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'NL'))
),

-- Project 15: VerboTech English to French LCA 2023 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to French Acceptability 2023 Q2'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'FR'))
),

-- Project 16: TransGlobal English to Arabic HT 2023 Q3
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic Human Translation 2023 Q3'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'AR'))
),

-- Project 17: LinguaWorld French to Arabic HT 2023 Q3
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld French to Arabic Human Translation 2023 Q3'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'FR') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'AR'))
),

-- Project 18: VerboTech English to Spanish HT 2023 Q3
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to Spanish Human Translation 2023 Q3'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'ES'))
),

-- Project 19: GlobalLang English to Chinese Traditional MTPE 2023 Q3
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Chinese Traditional MTPE 2023 Q3'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'zh-Hant'))
),

-- Project 20: TransGlobal Arabic to English HT 2023 Q3
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal Arabic to English Human Translation 2023 Q3'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'AR') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'EN'))
),

-- Project 21: LinguaWorld English to Turkish LCA 2023 Q3
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Turkish Acceptability 2023 Q3'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'TR'))
),

-- Project 22: VerboTech English to German MTPE 2023 Q3
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to German MTPE 2023 Q3'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'DE'))
),

-- Project 23: GlobalLang Spanish to French HT 2023 Q3
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang Spanish to French Human Translation 2023 Q3'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'ES') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'FR'))
),

-- Project 24: TransGlobal English to French HT 2023 Q4
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2023 Q4'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'FR'))
),

-- Project 25: LinguaWorld English to Japanese HT 2023 Q4
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Japanese Human Translation 2023 Q4'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'JA'))
),

-- Project 26: VerboTech English to Portuguese LCA 2023 Q4
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to Portuguese Acceptability 2023 Q4'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'pt-PT'))
),

-- Project 27: GlobalLang English to Arabic HT 2023 Q4
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Arabic Human Translation 2023 Q4'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'AR'))
),

-- Project 28: TransGlobal English to Chinese Simplified MTPE 2023 Q4
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Chinese Simplified MTPE 2023 Q4'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'zh-Hans'))
),

-- Project 29: LinguaWorld Portuguese Brazil to English HT 2023 Q4
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld Portuguese Brazil to English Human Translation 2023 Q4'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'pt-BR') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'EN'))
),

-- Project 30: GlobalLang English to Spanish LCA 2023 Q4
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Spanish Acceptability 2023 Q4'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'ES'))
),


-- ================================================================
-- 2024 PROJECTS
-- ================================================================

-- Project 31: TransGlobal English to French HT 2024 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2024 Q1'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'FR'))
),

-- Project 32: TransGlobal English to Arabic LCA 2024 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic Acceptability 2024 Q1'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'AR'))
),

-- Project 33: LinguaWorld English to German HT 2024 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to German Human Translation 2024 Q1'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'DE'))
),

-- Project 34: LinguaWorld English to Japanese MTPE 2024 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Japanese MTPE 2024 Q1'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'JA'))
),

-- Project 35: VerboTech French to English HT 2024 Q1 — CANCELLED
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech French to English Human Translation 2024 Q1'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'FR') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'EN'))
),

-- Project 36: GlobalLang English to Italian HT 2024 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Italian Human Translation 2024 Q1'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'IT'))
),

-- Project 37: TransGlobal English to Spanish HT 2024 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Spanish Human Translation 2024 Q1'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'ES'))
),

-- Project 38: GlobalLang English to Chinese Simplified LCA 2024 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Chinese Simplified Acceptability 2024 Q1'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'zh-Hans'))
),

-- Project 39: LinguaWorld English to Portuguese HT 2024 Q1
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Portuguese Human Translation 2024 Q1'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'pt-BR'))
),

-- Project 40: TransGlobal English to French HT 2024 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2024 Q2'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'FR'))
),

-- Project 41: TransGlobal English to Arabic MTPE 2024 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic MTPE 2024 Q2'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'AR'))
),

-- Project 42: LinguaWorld English to German HT 2024 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to German Human Translation 2024 Q2'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'DE'))
),

-- Project 43: LinguaWorld English to Chinese Simplified LCA 2024 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Chinese Simplified Acceptability 2024 Q2'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'zh-Hans'))
),

-- Project 44: VerboTech English to Spanish HT 2024 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to Spanish Human Translation 2024 Q2'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'ES'))
),

-- Project 45: GlobalLang English to Italian HT 2024 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Italian Human Translation 2024 Q2'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'IT'))
),

-- Project 46: VerboTech English to German MTPE 2024 Q2 — CANCELLED
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to German MTPE 2024 Q2'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'DE'))
),

-- Project 47: GlobalLang English to Japanese LCA 2024 Q2 — ON HOLD
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Japanese Acceptability 2024 Q2'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'JA'))
),

-- Project 48: TransGlobal English to Russian MTPE 2024 Q2
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Russian MTPE 2024 Q2'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'RU'))
),

-- Project 49: TransGlobal English to French LCA 2024 Q3
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Acceptability 2024 Q3'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'FR'))
),

-- Project 50: LinguaWorld English to Korean HT 2024 Q3
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Korean Human Translation 2024 Q3'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'KO'))
),

-- Project 51: VerboTech Spanish to English HT 2024 Q3
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech Spanish to English Human Translation 2024 Q3'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'ES') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'EN'))
),

-- Project 52: GlobalLang English to Arabic HT 2024 Q3
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Arabic Human Translation 2024 Q3'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'AR'))
),

-- Project 53: TransGlobal English to German HT 2024 Q3 — NOT ASSIGNED
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to German Human Translation 2024 Q3'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'DE'))
),

-- Project 54: LinguaWorld English to Portuguese MTPE 2024 Q3 — NOT ASSIGNED
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Portuguese MTPE 2024 Q3'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'pt-PT'))
),

-- Project 55: GlobalLang English to Chinese Traditional LCA 2024 Q3 — ON HOLD
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Chinese Traditional Acceptability 2024 Q3'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'zh-Hant'))
),

-- Project 56: TransGlobal English to Arabic HT 2024 Q4 — NOT ASSIGNED
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to Arabic Human Translation 2024 Q4'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'AR'))
),

-- Project 57: LinguaWorld English to Spanish HT 2024 Q4 — NOT ASSIGNED
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'LinguaWorld English to Spanish Human Translation 2024 Q4'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'ES'))
),

-- Project 58: VerboTech English to French LCA 2024 Q4 — CANCELLED
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'VerboTech English to French Acceptability 2024 Q4'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'FR'))
),

-- Project 59: GlobalLang English to Italian MTPE 2024 Q4 — NOT ASSIGNED
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'GlobalLang English to Italian MTPE 2024 Q4'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'IT'))
),

-- Project 60: TransGlobal English to French HT 2024 Q4 — ON HOLD
(
    (SELECT project_id FROM translation_project WHERE project_name =
     'TransGlobal English to French Human Translation 2024 Q4'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'FR'))
);


-- ================================================================
-- ACCOUNT PAIR
-- Links platform accounts to language pairs
-- Max 5 pairs per account enforced by trigger
-- Most accounts have 1-2 pairs matching their project
-- References PLATFORM_ACCOUNT by email and platform
-- ================================================================

INSERT INTO account_pair
(account_id, pair_id)
VALUES

-- TransGlobal accounts
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enfr.tg.2023q1@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'FR'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enar.tg.2023q1@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'AR'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enes.tg.2023q1@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'ES'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enpt.tg.2023q2@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'pt-BR'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enru.tg.2023q2@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'RU'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enar.tg.2023q3a@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'AR'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enar.tg.2023q3b@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'AR'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.aren.tg.2023q3@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'AR') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'EN'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enfr.tg.2023q4@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'FR'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enzh.tg.2023q4@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'zh-Hans'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enfr.tg.2024q1@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'FR'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enes.tg.2024q1@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'ES'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enfr.tg.2024q2a@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'FR'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enfr.tg.2024q2b@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'FR'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enar.tg.2024q2@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'AR'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enru.tg.2024q2@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'RU'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enfr.tg.2024q3@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'FR'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enar.tg.2024q4@gmail.com'
     AND platform = 'TransGlobal Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'AR'))
),

-- LinguaWorld accounts
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.ende.lw.2023q1@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'DE'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enzh.lw.2023q1@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'zh-Hans'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enit.lw.2023q2@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'IT'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.ennl.lw.2023q2@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'NL'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.frar.lw.2023q3@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'FR') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'AR'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.entr.lw.2023q3@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'TR'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enja.lw.2023q4@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'JA'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.ptbren.lw.2023q4@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'pt-BR') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'EN'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.ende.lw.2024q1@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'DE'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enja.lw.2024q1@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'JA'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enpt.lw.2024q1@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'pt-BR'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.ende.lw.2024q2@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'DE'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enzh.lw.2024q2@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'zh-Hans'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enko.lw.2024q3@gmail.com'
     AND platform = 'LinguaWorld Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'KO'))
),

-- VerboTech accounts
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.fren.vt.2023q1@gmail.com'
     AND platform = 'VerboTech Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'FR') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'EN'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.esen.vt.2023q2@gmail.com'
     AND platform = 'VerboTech Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'ES') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'EN'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enfr.vt.2023q2@gmail.com'
     AND platform = 'VerboTech Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'FR'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enes.vt.2023q3@gmail.com'
     AND platform = 'VerboTech Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'ES'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.ende.vt.2023q3@gmail.com'
     AND platform = 'VerboTech Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'DE'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enpt.vt.2023q4@gmail.com'
     AND platform = 'VerboTech Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'pt-PT'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.fren.vt.2024q1@gmail.com'
     AND platform = 'VerboTech Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'FR') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'EN'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enes.vt.2024q2@gmail.com'
     AND platform = 'VerboTech Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'ES'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.esen.vt.2024q3@gmail.com'
     AND platform = 'VerboTech Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'ES') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'EN'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enfr.vt.2024q4@gmail.com'
     AND platform = 'VerboTech Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'FR'))
),

-- GlobalLang accounts
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enit.gl.2023q1@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'IT'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enja.gl.2023q1@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'JA'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enko.gl.2023q2@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'KO'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.esfr.gl.2023q3@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'ES') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'FR'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enzh.gl.2023q3@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'zh-Hant'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enar.gl.2023q4@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'AR'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enes.gl.2023q4@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'ES'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enit.gl.2024q1@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'IT'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enzh.gl.2024q1@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'zh-Hans'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enit.gl.2024q2@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'IT'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enja.gl.2024q2@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'JA'))
),
(
    (SELECT account_id FROM platform_account WHERE account_email = 'ls.enar.gl.2024q3@gmail.com'
     AND platform = 'GlobalLang Portal'),
    (SELECT pair_id FROM language_pair WHERE
     source_language_id = (SELECT language_id FROM language WHERE language_code = 'EN') AND
     target_language_id = (SELECT language_id FROM language WHERE language_code = 'AR'))
);


-- ================================================================
-- COLLABORATOR SKILL
-- Language proficiencies for all 15 collaborators
-- Only Native and Professional levels
-- Matches the languages used across all 60 projects
-- References COLLABORATOR by email
-- References LANGUAGE by code
-- ================================================================

INSERT INTO collaborator_skill
(collaborator_id, language_id, proficiency_level)
VALUES

-- AMARA DIALLO — French native, English and Arabic professional
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'amara.diallo@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'FR'),
    'Native'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'amara.diallo@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    'Professional'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'amara.diallo@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'AR'),
    'Professional'
),

-- YUKI TANAKA — Japanese native, English professional
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'yuki.tanaka@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'JA'),
    'Native'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'yuki.tanaka@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    'Professional'
),

-- CARLOS MENDEZ — Spanish native, English and French professional
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'carlos.mendez@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'ES'),
    'Native'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'carlos.mendez@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    'Professional'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'carlos.mendez@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'FR'),
    'Professional'
),

-- FATIMA AL-RASHID — Arabic native, English and French professional
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'fatima.alrashid@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'AR'),
    'Native'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'fatima.alrashid@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    'Professional'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'fatima.alrashid@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'FR'),
    'Professional'
),

-- PIERRE DUBOIS — French native, English and Spanish professional
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'pierre.dubois@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'FR'),
    'Native'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'pierre.dubois@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    'Professional'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'pierre.dubois@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'ES'),
    'Professional'
),

-- MEI CHEN — Chinese Simplified native, English professional
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'mei.chen@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'zh-Hans'),
    'Native'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'mei.chen@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    'Professional'
),

-- KLAUS WEBER — German native, English professional
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'klaus.weber@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'DE'),
    'Native'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'klaus.weber@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    'Professional'
),

-- LUCIA ROMANO — Italian native, English professional
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'lucia.romano@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'IT'),
    'Native'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'lucia.romano@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    'Professional'
),

-- SOFIA FERREIRA — Portuguese Brazil native, English and Spanish professional
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'sofia.ferreira@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'pt-BR'),
    'Native'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'sofia.ferreira@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    'Professional'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'sofia.ferreira@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'ES'),
    'Professional'
),

-- IVAN PETROV — Russian native, English professional
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'ivan.petrov@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'RU'),
    'Native'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'ivan.petrov@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    'Professional'
),

-- YARA MAHMOUD — Arabic native, English and French professional
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'yara.mahmoud@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'AR'),
    'Native'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'yara.mahmoud@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    'Professional'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'yara.mahmoud@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'FR'),
    'Professional'
),

-- LENA FISCHER — German native, English and French professional
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'lena.fischer@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'DE'),
    'Native'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'lena.fischer@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    'Professional'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'lena.fischer@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'FR'),
    'Professional'
),

-- MARCO ROSSI — Italian native, English and Spanish professional
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'marco.rossi@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'IT'),
    'Native'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'marco.rossi@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    'Professional'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'marco.rossi@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'ES'),
    'Professional'
),

-- AHMED HASSAN — Arabic native, English professional
-- Inactive — included for historical data integrity
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'ahmed.hassan@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'AR'),
    'Native'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'ahmed.hassan@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    'Professional'
),

-- KWAME ASANTE — English native, French professional
-- Blacklisted — skills recorded for historical completeness
-- Will never be assigned due to eligibility trigger
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'kwame.asante@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    'Native'
),
(
    (SELECT collaborator_id FROM collaborator WHERE email = 'kwame.asante@gmail.com'),
    (SELECT language_id FROM language WHERE language_code = 'FR'),
    'Professional'
);