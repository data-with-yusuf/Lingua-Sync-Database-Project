-- ================================================================
-- BATCH 2 — CORE ENTITY TABLES
-- Creation order: PROJECT_TYPE, PROJECT_MANAGER, COLLABORATOR,
-- AGENCY_CONTACT, EXCHANGE_RATE, LANGUAGE_PAIR,
-- TRANSLATION_PROJECT, PLATFORM_ACCOUNT, BANK_ACCOUNT
-- ================================================================


CREATE TABLE project_type (
    project_type_id     SERIAL          PRIMARY KEY,
    project_type_name   VARCHAR(100)    NOT NULL UNIQUE,
    unit_id             INT             NOT NULL,
    created_at          TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP       NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_project_type_billing_unit
        FOREIGN KEY (unit_id)
        REFERENCES billing_unit(unit_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ================================================================

CREATE TABLE project_manager (
    manager_id      SERIAL          PRIMARY KEY,
    first_name      VARCHAR(100)    NOT NULL,
    last_name       VARCHAR(100)    NOT NULL,
    role_id         INT             NOT NULL,
    email           VARCHAR(150)    NOT NULL UNIQUE,
    created_at      TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP       NOT NULL DEFAULT NOW(),
    deleted_at      TIMESTAMP       DEFAULT NULL,

    CONSTRAINT fk_manager_role
        FOREIGN KEY (role_id)
        REFERENCES manager_role(role_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ================================================================

CREATE TABLE collaborator (
    collaborator_id     SERIAL          PRIMARY KEY,
    first_name          VARCHAR(100)    NOT NULL,
    last_name           VARCHAR(100)    NOT NULL,
    email               VARCHAR(150)    UNIQUE,
    phone_number        VARCHAR(20),
    employment_status   VARCHAR(20)     NOT NULL DEFAULT 'Active',
    assignment_status   VARCHAR(20)     NOT NULL DEFAULT 'Available',
    created_at          TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP       NOT NULL DEFAULT NOW(),
    deleted_at          TIMESTAMP       DEFAULT NULL,

    CONSTRAINT chk_collaborator_contact
        CHECK (email IS NOT NULL OR phone_number IS NOT NULL),

    CONSTRAINT chk_employment_status
        CHECK (employment_status IN ('Active', 'Inactive', 'Blacklisted')),

    CONSTRAINT chk_assignment_status
        CHECK (assignment_status IN ('Available', 'Assigned', 'Unavailable'))
);

-- ================================================================


CREATE TABLE agency_contact (
    contact_id          SERIAL          PRIMARY KEY,
    agency_id           INT             NOT NULL,
    contact_name        VARCHAR(150)    NOT NULL,
    contact_email       VARCHAR(150),
    phone_number        VARCHAR(20),
    upwork_profile      VARCHAR(200),
    platform_name       VARCHAR(100),
    platform_username   VARCHAR(200),
    is_primary_contact  BOOLEAN         NOT NULL DEFAULT FALSE,
    created_at          TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP       NOT NULL DEFAULT NOW(),
    deleted_at          TIMESTAMP       DEFAULT NULL,

    CONSTRAINT fk_contact_agency
        FOREIGN KEY (agency_id)
        REFERENCES agency(agency_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_contact_method
        CHECK (
            contact_email       IS NOT NULL OR
            phone_number        IS NOT NULL OR
            upwork_profile      IS NOT NULL OR
            platform_username   IS NOT NULL
        )
);

-- ================================================================

CREATE TABLE exchange_rate (
    rate_id             SERIAL          PRIMARY KEY,
    from_currency_id    INT             NOT NULL,
    to_currency_id      INT             NOT NULL,
    conversion_rate     NUMERIC(18,6)   NOT NULL,
    effective_date      DATE            NOT NULL,
    created_at          TIMESTAMP       NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_exchange_from_currency
        FOREIGN KEY (from_currency_id)
        REFERENCES currency(currency_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_exchange_to_currency
        FOREIGN KEY (to_currency_id)
        REFERENCES currency(currency_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_different_currencies
        CHECK (from_currency_id <> to_currency_id),

    CONSTRAINT chk_conversion_rate_positive
        CHECK (conversion_rate > 0),

    CONSTRAINT uq_rate_per_date
        UNIQUE (from_currency_id, to_currency_id, effective_date)
);

-- ================================================================

CREATE TABLE language_pair (
    pair_id             SERIAL          PRIMARY KEY,
    source_language_id  INT             NOT NULL,
    target_language_id  INT             NOT NULL,
    created_at          TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP       NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_source_language
        FOREIGN KEY (source_language_id)
        REFERENCES language(language_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_target_language
        FOREIGN KEY (target_language_id)
        REFERENCES language(language_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_different_languages
        CHECK (source_language_id <> target_language_id),

    CONSTRAINT uq_language_pair
        UNIQUE (source_language_id, target_language_id)
);

-- ================================================================


CREATE TABLE translation_project (
    project_id          SERIAL          PRIMARY KEY,
    project_name        VARCHAR(200)    NOT NULL,
    project_type_id     INT             NOT NULL,
    agency_rate         NUMERIC(10,2)   NOT NULL,
    collaborator_rate   NUMERIC(10,2)   NOT NULL DEFAULT 0,
    project_status      VARCHAR(20)     NOT NULL DEFAULT 'Not Assigned',
    deadline            DATE,
    agency_id           INT             NOT NULL,
    currency_id         INT             NOT NULL,
    created_at          TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP       NOT NULL DEFAULT NOW(),
    deleted_at          TIMESTAMP       DEFAULT NULL,

    CONSTRAINT fk_project_type
        FOREIGN KEY (project_type_id)
        REFERENCES project_type(project_type_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_project_agency
        FOREIGN KEY (agency_id)
        REFERENCES agency(agency_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_project_currency
        FOREIGN KEY (currency_id)
        REFERENCES currency(currency_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_project_status
        CHECK (project_status IN (
            'Not Assigned',
            'Assigned',
            'Completed',
            'Cancelled',
            'On Hold'
        )),

    CONSTRAINT chk_rates
        CHECK (agency_rate > collaborator_rate),

    CONSTRAINT chk_agency_rate_positive
        CHECK (agency_rate > 0),

    CONSTRAINT chk_collaborator_rate_non_negative
        CHECK (collaborator_rate >= 0)
);

-- ================================================================

CREATE TABLE platform_account (
    account_id          SERIAL          PRIMARY KEY,
    account_email       VARCHAR(150)    NOT NULL,
    account_password    VARCHAR(255)    NOT NULL,
    platform            VARCHAR(100)    NOT NULL,
    created_at          TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP       NOT NULL DEFAULT NOW(),
    deleted_at          TIMESTAMP       DEFAULT NULL,

    CONSTRAINT uq_account_email_platform
        UNIQUE (account_email, platform)
);

-- ================================================================

CREATE TABLE bank_account (
    bank_account_id     SERIAL          PRIMARY KEY,
    collaborator_id     INT             NOT NULL,
    bank_name           VARCHAR(150),
    account_number      VARCHAR(50)     NOT NULL UNIQUE,
    account_holder_name VARCHAR(150),
    created_at          TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP       NOT NULL DEFAULT NOW(),
    deleted_at          TIMESTAMP       DEFAULT NULL,

    CONSTRAINT fk_bank_collaborator
        FOREIGN KEY (collaborator_id)
        REFERENCES collaborator(collaborator_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);