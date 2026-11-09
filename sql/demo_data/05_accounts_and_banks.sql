-- ================================================================
-- LINGUASYNC DEMO DATA
-- Demo Batch 5 — Platform Accounts and Bank Accounts
-- ================================================================
-- Platform accounts are created per project language direction
-- Multiple accounts per project where collaborator
-- workload requires it
-- Cancelled and On Hold projects have accounts created
-- but not actively used
-- Passwords stored as placeholder text
-- Replace with pgcrypto hashing in production
-- ================================================================


-- ================================================================
-- PLATFORM ACCOUNTS
-- 50 accounts across all 4 agency platforms
-- Named clearly to show which project they belong to
-- Same email can appear on different platforms
-- Enforced by uq_account_email_platform constraint
-- ================================================================

INSERT INTO platform_account
(account_email, account_password, platform)
VALUES

-- ================================================================
-- TRANSGLOBAL SOLUTIONS ACCOUNTS — 18 accounts
-- ================================================================

-- 2023 Projects
('ls.enfr.tg.2023q1@gmail.com',   'PLACEHOLDER', 'TransGlobal Portal'),
('ls.enar.tg.2023q1@gmail.com',   'PLACEHOLDER', 'TransGlobal Portal'),
('ls.enes.tg.2023q1@gmail.com',   'PLACEHOLDER', 'TransGlobal Portal'),
('ls.enpt.tg.2023q2@gmail.com',   'PLACEHOLDER', 'TransGlobal Portal'),
('ls.enru.tg.2023q2@gmail.com',   'PLACEHOLDER', 'TransGlobal Portal'),
('ls.enar.tg.2023q3a@gmail.com',  'PLACEHOLDER', 'TransGlobal Portal'),
('ls.enar.tg.2023q3b@gmail.com',  'PLACEHOLDER', 'TransGlobal Portal'),
('ls.aren.tg.2023q3@gmail.com',   'PLACEHOLDER', 'TransGlobal Portal'),
('ls.enfr.tg.2023q4@gmail.com',   'PLACEHOLDER', 'TransGlobal Portal'),
('ls.enzh.tg.2023q4@gmail.com',   'PLACEHOLDER', 'TransGlobal Portal'),

-- 2024 Projects
('ls.enfr.tg.2024q1@gmail.com',   'PLACEHOLDER', 'TransGlobal Portal'),
('ls.enes.tg.2024q1@gmail.com',   'PLACEHOLDER', 'TransGlobal Portal'),
('ls.enfr.tg.2024q2a@gmail.com',  'PLACEHOLDER', 'TransGlobal Portal'),
('ls.enfr.tg.2024q2b@gmail.com',  'PLACEHOLDER', 'TransGlobal Portal'),
('ls.enar.tg.2024q2@gmail.com',   'PLACEHOLDER', 'TransGlobal Portal'),
('ls.enru.tg.2024q2@gmail.com',   'PLACEHOLDER', 'TransGlobal Portal'),
('ls.enfr.tg.2024q3@gmail.com',   'PLACEHOLDER', 'TransGlobal Portal'),
('ls.enar.tg.2024q4@gmail.com',   'PLACEHOLDER', 'TransGlobal Portal'),


-- ================================================================
-- LINGUAWORLD INC ACCOUNTS — 14 accounts
-- ================================================================

-- 2023 Projects
('ls.ende.lw.2023q1@gmail.com',   'PLACEHOLDER', 'LinguaWorld Portal'),
('ls.enzh.lw.2023q1@gmail.com',   'PLACEHOLDER', 'LinguaWorld Portal'),
('ls.enit.lw.2023q2@gmail.com',   'PLACEHOLDER', 'LinguaWorld Portal'),
('ls.ennl.lw.2023q2@gmail.com',   'PLACEHOLDER', 'LinguaWorld Portal'),
('ls.frar.lw.2023q3@gmail.com',   'PLACEHOLDER', 'LinguaWorld Portal'),
('ls.entr.lw.2023q3@gmail.com',   'PLACEHOLDER', 'LinguaWorld Portal'),
('ls.enja.lw.2023q4@gmail.com',   'PLACEHOLDER', 'LinguaWorld Portal'),
('ls.ptbren.lw.2023q4@gmail.com', 'PLACEHOLDER', 'LinguaWorld Portal'),

-- 2024 Projects
('ls.ende.lw.2024q1@gmail.com',   'PLACEHOLDER', 'LinguaWorld Portal'),
('ls.enja.lw.2024q1@gmail.com',   'PLACEHOLDER', 'LinguaWorld Portal'),
('ls.enpt.lw.2024q1@gmail.com',   'PLACEHOLDER', 'LinguaWorld Portal'),
('ls.ende.lw.2024q2@gmail.com',   'PLACEHOLDER', 'LinguaWorld Portal'),
('ls.enzh.lw.2024q2@gmail.com',   'PLACEHOLDER', 'LinguaWorld Portal'),
('ls.enko.lw.2024q3@gmail.com',   'PLACEHOLDER', 'LinguaWorld Portal'),


-- ================================================================
-- VERBOTECH AGENCY ACCOUNTS — 10 accounts
-- ================================================================

-- 2023 Projects
('ls.fren.vt.2023q1@gmail.com',   'PLACEHOLDER', 'VerboTech Portal'),
('ls.esen.vt.2023q2@gmail.com',   'PLACEHOLDER', 'VerboTech Portal'),
('ls.enfr.vt.2023q2@gmail.com',   'PLACEHOLDER', 'VerboTech Portal'),
('ls.enes.vt.2023q3@gmail.com',   'PLACEHOLDER', 'VerboTech Portal'),
('ls.ende.vt.2023q3@gmail.com',   'PLACEHOLDER', 'VerboTech Portal'),
('ls.enpt.vt.2023q4@gmail.com',   'PLACEHOLDER', 'VerboTech Portal'),

-- 2024 Projects
('ls.fren.vt.2024q1@gmail.com',   'PLACEHOLDER', 'VerboTech Portal'),
('ls.enes.vt.2024q2@gmail.com',   'PLACEHOLDER', 'VerboTech Portal'),
('ls.esen.vt.2024q3@gmail.com',   'PLACEHOLDER', 'VerboTech Portal'),
('ls.enfr.vt.2024q4@gmail.com',   'PLACEHOLDER', 'VerboTech Portal'),


-- ================================================================
-- GLOBALLANG PARTNERS ACCOUNTS — 12 accounts
-- ================================================================

-- 2023 Projects
('ls.enit.gl.2023q1@gmail.com',   'PLACEHOLDER', 'GlobalLang Portal'),
('ls.enja.gl.2023q1@gmail.com',   'PLACEHOLDER', 'GlobalLang Portal'),
('ls.enko.gl.2023q2@gmail.com',   'PLACEHOLDER', 'GlobalLang Portal'),
('ls.esfr.gl.2023q3@gmail.com',   'PLACEHOLDER', 'GlobalLang Portal'),
('ls.enzh.gl.2023q3@gmail.com',   'PLACEHOLDER', 'GlobalLang Portal'),
('ls.enar.gl.2023q4@gmail.com',   'PLACEHOLDER', 'GlobalLang Portal'),
('ls.enes.gl.2023q4@gmail.com',   'PLACEHOLDER', 'GlobalLang Portal'),

-- 2024 Projects
('ls.enit.gl.2024q1@gmail.com',   'PLACEHOLDER', 'GlobalLang Portal'),
('ls.enzh.gl.2024q1@gmail.com',   'PLACEHOLDER', 'GlobalLang Portal'),
('ls.enit.gl.2024q2@gmail.com',   'PLACEHOLDER', 'GlobalLang Portal'),
('ls.enja.gl.2024q2@gmail.com',   'PLACEHOLDER', 'GlobalLang Portal'),
('ls.enar.gl.2024q3@gmail.com',   'PLACEHOLDER', 'GlobalLang Portal');


-- ================================================================
-- BANK ACCOUNTS
-- One per active collaborator
-- Ahmed Hassan included — historical payments exist
-- Kwame Asante excluded — blacklisted, never paid
-- References COLLABORATOR by email via subquery
-- ================================================================

INSERT INTO bank_account
(collaborator_id, bank_name, account_number, account_holder_name)
VALUES
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'amara.diallo@gmail.com'),
    'Access Bank Nigeria',
    '0123456789',
    'Amara Diallo'
),
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yuki.tanaka@gmail.com'),
    'MUFG Bank Japan',
    '1234567890',
    'Yuki Tanaka'
),
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'carlos.mendez@gmail.com'),
    'BBVA Spain',
    '2345678901',
    'Carlos Mendez'
),
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'fatima.alrashid@gmail.com'),
    'Al Rajhi Bank',
    '3456789012',
    'Fatima Al-Rashid'
),
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'pierre.dubois@gmail.com'),
    'BNP Paribas France',
    '4567890123',
    'Pierre Dubois'
),
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'mei.chen@gmail.com'),
    'Bank of China',
    '5678901234',
    'Mei Chen'
),
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'klaus.weber@gmail.com'),
    'Deutsche Bank Germany',
    '6789012345',
    'Klaus Weber'
),
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'lucia.romano@gmail.com'),
    'Intesa Sanpaolo Italy',
    '7890123456',
    'Lucia Romano'
),
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'sofia.ferreira@gmail.com'),
    'Millennium BCP Portugal',
    '8901234567',
    'Sofia Ferreira'
),
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'ivan.petrov@gmail.com'),
    'Sberbank Russia',
    '9012345678',
    'Ivan Petrov'
),
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'yara.mahmoud@gmail.com'),
    'CIB Egypt',
    '0123456780',
    'Yara Mahmoud'
),
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'lena.fischer@gmail.com'),
    'Commerzbank Germany',
    '1234567891',
    'Lena Fischer'
),
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'marco.rossi@gmail.com'),
    'UniCredit Italy',
    '2345678902',
    'Marco Rossi'
),
(
    (SELECT collaborator_id FROM collaborator
     WHERE email = 'ahmed.hassan@gmail.com'),
    'CIB Egypt',
    '3456789013',
    'Ahmed Hassan'
);