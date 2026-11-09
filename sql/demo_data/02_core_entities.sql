-- ================================================================
-- LINGUASYNC DEMO DATA
-- Demo Batch 2 — Core Entities
-- ================================================================


-- ================================================================
-- PROJECT TYPE
-- References BILLING_UNIT by name via subquery
-- Professional approach — no hardcoded IDs
-- ================================================================

INSERT INTO project_type
(project_type_name, unit_id)
VALUES
(
    'Human Translation',
    (SELECT unit_id FROM billing_unit
     WHERE billing_unit_name = 'Per Word')
),
(
    'Long Context Acceptability',
    (SELECT unit_id FROM billing_unit
     WHERE billing_unit_name = 'Per Hit')
),
(
    'MTPE',
    (SELECT unit_id FROM billing_unit
     WHERE billing_unit_name = 'Per Segment')
);


-- ================================================================
-- PROJECT MANAGER
-- References MANAGER_ROLE by name via subquery
-- ================================================================

INSERT INTO project_manager
(first_name, last_name, role_id, email)
VALUES
(
    'John', 'Adeyemi',
    (SELECT role_id FROM manager_role
     WHERE manager_role_name = 'Principal'),
    'john.adeyemi@linguasync.com'
),
(
    'Sarah', 'Obi',
    (SELECT role_id FROM manager_role
     WHERE manager_role_name = 'Supporting'),
    'sarah.obi@linguasync.com'
),
(
    'Michael', 'Eze',
    (SELECT role_id FROM manager_role
     WHERE manager_role_name = 'Supporting'),
    'michael.eze@linguasync.com'
);


-- ================================================================
-- COLLABORATOR
-- 15 collaborators — mix of statuses
-- Kwame Asante is blacklisted — will test eligibility trigger
-- Ahmed Hassan is inactive — soft deleted later in test batch
-- ================================================================

INSERT INTO collaborator
(first_name, last_name, email, phone_number,
 employment_status, assignment_status)
VALUES
(
    'Amara', 'Diallo',
    'amara.diallo@gmail.com',
    '+2348012345678',
    'Active', 'Available'
),
(
    'Yuki', 'Tanaka',
    'yuki.tanaka@gmail.com',
    '+81901234567',
    'Active', 'Available'
),
(
    'Carlos', 'Mendez',
    'carlos.mendez@gmail.com',
    '+34612345678',
    'Active', 'Available'
),
(
    'Fatima', 'Al-Rashid',
    'fatima.alrashid@gmail.com',
    '+966512345678',
    'Active', 'Available'
),
(
    'Pierre', 'Dubois',
    'pierre.dubois@gmail.com',
    '+33612345678',
    'Active', 'Available'
),
(
    'Mei', 'Chen',
    'mei.chen@gmail.com',
    '+8613812345678',
    'Active', 'Available'
),
(
    'Klaus', 'Weber',
    'klaus.weber@gmail.com',
    '+4915123456789',
    'Active', 'Available'
),
(
    'Lucia', 'Romano',
    'lucia.romano@gmail.com',
    '+39312345678',
    'Active', 'Available'
),
(
    'Sofia', 'Ferreira',
    'sofia.ferreira@gmail.com',
    '+351912345678',
    'Active', 'Available'
),
(
    'Ivan', 'Petrov',
    'ivan.petrov@gmail.com',
    '+79161234567',
    'Active', 'Available'
),
(
    'Yara', 'Mahmoud',
    'yara.mahmoud@gmail.com',
    '+201112345678',
    'Active', 'Available'
),
(
    'Lena', 'Fischer',
    'lena.fischer@gmail.com',
    '+4917612345678',
    'Active', 'Available'
),
(
    'Marco', 'Rossi',
    'marco.rossi@gmail.com',
    '+39412345678',
    'Active', 'Available'
),
(
    'Ahmed', 'Hassan',
    'ahmed.hassan@gmail.com',
    '+201012345678',
    'Inactive', 'Unavailable'
),
(
    'Kwame', 'Asante',
    'kwame.asante@gmail.com',
    '+233201234567',
    'Blacklisted', 'Unavailable'
);


-- ================================================================
-- AGENCY CONTACT
-- At least one primary contact per agency
-- Multiple contacts for TransGlobal to show multi-contact support
-- References AGENCY by name via subquery
-- ================================================================

INSERT INTO agency_contact
(agency_id, contact_name, contact_email,
 phone_number, upwork_profile, is_primary_contact)
VALUES
(
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    'Michael Thornton',
    'michael.thornton@transglobal.com',
    '+12125551234',
    'upwork.com/transglobal-michael',
    TRUE
),
(
    (SELECT agency_id FROM agency
     WHERE agency_name = 'TransGlobal Solutions'),
    'Rebecca Walsh',
    'rebecca.walsh@transglobal.com',
    '+12125555678',
    'upwork.com/transglobal-rebecca',
    FALSE
),
(
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    'Sarah Okonkwo',
    'sarah.okonkwo@linguaworld.com',
    '+44207123456',
    'upwork.com/linguaworld-sarah',
    TRUE
),
(
    (SELECT agency_id FROM agency
     WHERE agency_name = 'LinguaWorld Inc'),
    'David Chen',
    'david.chen@linguaworld.com',
    '+44207654321',
    'upwork.com/linguaworld-david',
    FALSE
),
(
    (SELECT agency_id FROM agency
     WHERE agency_name = 'VerboTech Agency'),
    'James Whitfield',
    'james.whitfield@verbotech.com',
    '+13105551234',
    'upwork.com/verbotech-james',
    TRUE
),
(
    (SELECT agency_id FROM agency
     WHERE agency_name = 'GlobalLang Partners'),
    'Amara Diallo',
    'amara.contact@globallang.com',
    '+33145678901',
    'upwork.com/globallang-amara',
    TRUE
);


-- ================================================================
-- EXCHANGE RATE
-- USD as base currency against major currencies
-- Multiple dates to show rate changes over time
-- References CURRENCY by code via subquery
-- ================================================================

INSERT INTO exchange_rate
(from_currency_id, to_currency_id, conversion_rate, effective_date)
VALUES
-- 2023 rates
(
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    (SELECT currency_id FROM currency WHERE currency_code = 'EUR'),
    0.921000, '2023-01-01'
),
(
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    (SELECT currency_id FROM currency WHERE currency_code = 'GBP'),
    0.807000, '2023-01-01'
),
(
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    (SELECT currency_id FROM currency WHERE currency_code = 'NGN'),
    461.500000, '2023-01-01'
),
(
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    (SELECT currency_id FROM currency WHERE currency_code = 'JPY'),
    130.700000, '2023-01-01'
),
-- 2023 mid-year rate update
(
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    (SELECT currency_id FROM currency WHERE currency_code = 'NGN'),
    760.000000, '2023-07-01'
),
-- 2024 rates
(
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    (SELECT currency_id FROM currency WHERE currency_code = 'EUR'),
    0.918000, '2024-01-01'
),
(
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    (SELECT currency_id FROM currency WHERE currency_code = 'GBP'),
    0.786000, '2024-01-01'
),
(
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    (SELECT currency_id FROM currency WHERE currency_code = 'NGN'),
    1500.000000, '2024-01-01'
),
(
    (SELECT currency_id FROM currency WHERE currency_code = 'USD'),
    (SELECT currency_id FROM currency WHERE currency_code = 'JPY'),
    148.200000, '2024-01-01'
);


-- ================================================================
-- LANGUAGE PAIR
-- 20 most common combinations used across all 60 projects
-- References LANGUAGE by code via subquery
-- Direction matters — EN→FR and FR→EN are separate pairs
-- ================================================================

INSERT INTO language_pair
(source_language_id, target_language_id)
VALUES
-- English as source
(
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    (SELECT language_id FROM language WHERE language_code = 'FR')
),
(
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    (SELECT language_id FROM language WHERE language_code = 'ES')
),
(
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    (SELECT language_id FROM language WHERE language_code = 'AR')
),
(
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    (SELECT language_id FROM language WHERE language_code = 'DE')
),
(
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    (SELECT language_id FROM language WHERE language_code = 'pt-BR')
),
(
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    (SELECT language_id FROM language WHERE language_code = 'pt-PT')
),
(
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    (SELECT language_id FROM language WHERE language_code = 'zh-Hans')
),
(
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    (SELECT language_id FROM language WHERE language_code = 'zh-Hant')
),
(
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    (SELECT language_id FROM language WHERE language_code = 'JA')
),
(
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    (SELECT language_id FROM language WHERE language_code = 'IT')
),
(
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    (SELECT language_id FROM language WHERE language_code = 'RU')
),
(
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    (SELECT language_id FROM language WHERE language_code = 'NL')
),
(
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    (SELECT language_id FROM language WHERE language_code = 'KO')
),
(
    (SELECT language_id FROM language WHERE language_code = 'EN'),
    (SELECT language_id FROM language WHERE language_code = 'TR')
),
-- French as source
(
    (SELECT language_id FROM language WHERE language_code = 'FR'),
    (SELECT language_id FROM language WHERE language_code = 'EN')
),
(
    (SELECT language_id FROM language WHERE language_code = 'FR'),
    (SELECT language_id FROM language WHERE language_code = 'AR')
),
-- Spanish as source
(
    (SELECT language_id FROM language WHERE language_code = 'ES'),
    (SELECT language_id FROM language WHERE language_code = 'EN')
),
(
    (SELECT language_id FROM language WHERE language_code = 'ES'),
    (SELECT language_id FROM language WHERE language_code = 'FR')
),
-- Arabic as source
(
    (SELECT language_id FROM language WHERE language_code = 'AR'),
    (SELECT language_id FROM language WHERE language_code = 'EN')
),
-- Portuguese as source
(
    (SELECT language_id FROM language WHERE language_code = 'pt-BR'),
    (SELECT language_id FROM language WHERE language_code = 'EN')
),
-- German as source
(
    (SELECT language_id FROM language WHERE language_code = 'DE'),
    (SELECT language_id FROM language WHERE language_code = 'EN')
),
-- Variant pair
(
    (SELECT language_id FROM language WHERE language_code = 'pt-BR'),
    (SELECT language_id FROM language WHERE language_code = 'pt-PT')
);