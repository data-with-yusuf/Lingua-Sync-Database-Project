-- ================================================================
-- LINGUASYNC DEMO DATA
-- Demo Batch 1 — Reference Tables
-- ================================================================


-- ================================================================
-- CURRENCY
-- ================================================================

INSERT INTO currency
(currency_name, currency_code, currency_symbol)
VALUES
('US Dollar',          'USD', '$'),
('Euro',               'EUR', '€'),
('British Pound',      'GBP', '£'),
('Nigerian Naira',     'NGN', '₦'),
('Japanese Yen',       'JPY', '¥');


-- ================================================================
-- BILLING UNIT
-- ================================================================

INSERT INTO billing_unit
(billing_unit_name, unit_description)
VALUES
('Per Word',
 'Payment calculated by total word count completed'),
('Per Hit',
 'Payment calculated by total hits completed'),
('Per Segment',
 'Payment calculated by total segments completed');


-- ================================================================
-- MANAGER ROLE
-- ================================================================

INSERT INTO manager_role
(manager_role_name, role_description)
VALUES
('Principal',
 'Main project manager — receives projects from agencies and oversees all operations'),
('Supporting',
 'Supporting project managers — assign collaborators and manage work records');


-- ================================================================
-- LANGUAGE
-- ================================================================

INSERT INTO language
(language_name, language_code, language_variant, language_display_name)
VALUES
-- English variants
('English',    'EN',      NULL,           'English'),
('English',    'en-US',   'American',     'English (United States)'),
('English',    'en-GB',   'British',      'English (United Kingdom)'),

-- French variants
('French',     'FR',      NULL,           'French'),
('French',     'fr-FR',   'European',     'French (France)'),
('French',     'fr-CA',   'Canadian',     'French (Canada)'),

-- Spanish variants
('Spanish',    'ES',      NULL,           'Spanish'),
('Spanish',    'es-ES',   'European',     'Spanish (Spain)'),
('Spanish',    'es-MX',   'Mexican',      'Spanish (Mexico)'),
('Spanish',    'es-AR',   'Argentinian',  'Spanish (Argentina)'),

-- Arabic variants
('Arabic',     'AR',      NULL,           'Arabic'),
('Arabic',     'ar-SA',   'Saudi',        'Arabic (Saudi Arabia)'),
('Arabic',     'ar-EG',   'Egyptian',     'Arabic (Egypt)'),

-- Portuguese variants
('Portuguese', 'pt-BR',   'Brazilian',    'Portuguese (Brazil)'),
('Portuguese', 'pt-PT',   'European',     'Portuguese (Portugal)'),

-- Chinese variants
('Chinese',    'zh-Hans', 'Simplified',   'Chinese (Simplified)'),
('Chinese',    'zh-Hant', 'Traditional',  'Chinese (Traditional)'),

-- German variants
('German',     'DE',      NULL,           'German'),
('German',     'de-DE',   'Standard',     'German (Germany)'),
('German',     'de-AT',   'Austrian',     'German (Austria)'),

-- Single variant languages
('Japanese',   'JA',      NULL,           'Japanese'),
('Italian',    'IT',      NULL,           'Italian'),
('Dutch',      'NL',      NULL,           'Dutch'),
('Russian',    'RU',      NULL,           'Russian'),
('Korean',     'KO',      NULL,           'Korean'),
('Turkish',    'TR',      NULL,           'Turkish'),
('Polish',     'PL',      NULL,           'Polish'),
('Swedish',    'SV',      NULL,           'Swedish'),
('Norwegian',  'NO',      NULL,           'Norwegian'),
('Danish',     'DA',      NULL,           'Danish'),
('Hebrew',     'HE',      NULL,           'Hebrew'),
('Hindi',      'HI',      NULL,           'Hindi'),
('Bengali',    'BN',      NULL,           'Bengali'),
('Swahili',    'SW',      NULL,           'Swahili'),
('Yoruba',     'YO',      NULL,           'Yoruba'),
('Igbo',       'IG',      NULL,           'Igbo'),
('Hausa',      'HA',      NULL,           'Hausa'),
('Indonesian', 'ID',      NULL,           'Indonesian'),
('Malay',      'MS',      NULL,           'Malay'),
('Thai',       'TH',      NULL,           'Thai'),
('Vietnamese', 'VI',      NULL,           'Vietnamese'),
('Romanian',   'RO',      NULL,           'Romanian'),
('Ukrainian',  'UK',      NULL,           'Ukrainian'),
('Catalan',    'CA',      NULL,           'Catalan'),
('Croatian',   'HR',      NULL,           'Croatian'),
('Serbian',    'SR',      NULL,           'Serbian'),
('Bulgarian',  'BG',      NULL,           'Bulgarian'),
('Tagalog',    'TL',      NULL,           'Tagalog'),
('Persian',    'FA',      NULL,           'Persian (Farsi)'),
('Tamil',      'TA',      NULL,           'Tamil'),
('Telugu',     'TE',      NULL,           'Telugu');


-- ================================================================
-- AGENCY
-- ================================================================

INSERT INTO agency
(agency_name)
VALUES
('TransGlobal Solutions'),
('LinguaWorld Inc'),
('VerboTech Agency'),
('GlobalLang Partners');