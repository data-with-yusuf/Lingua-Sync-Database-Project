-- ================================================================
-- BATCH 4 — EXTENSION AND TRANSACTION TABLES
-- Creation order: RATE_HISTORY, PROJECT_ASSIGNMENT,
-- COMMUNICATION_LOG, WORK_RECORD,
-- AGENCY_INVOICE, COLLABORATOR_PAYMENT, REVISION_LOG
-- ================================================================


CREATE TABLE rate_history (
    history_id              SERIAL          PRIMARY KEY,
    project_id              INT             NOT NULL,
    changed_by_manager_id   INT             NOT NULL,
    agency_rate             NUMERIC(10,2)   NOT NULL,
    collaborator_rate       NUMERIC(10,2)   NOT NULL,
    effective_from          DATE            NOT NULL,
    effective_to            DATE,
    created_at              TIMESTAMP       NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_rate_history_project
        FOREIGN KEY (project_id)
        REFERENCES translation_project(project_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_rate_history_manager
        FOREIGN KEY (changed_by_manager_id)
        REFERENCES project_manager(manager_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_rate_history_dates
        CHECK (effective_to IS NULL
               OR effective_to >= effective_from),

    CONSTRAINT chk_rate_history_rates
        CHECK (
            agency_rate > collaborator_rate AND
            agency_rate > 0 AND
            collaborator_rate >= 0
        )
);

-- Partial unique index
-- Only one active rate per project at any time
-- Active = effective_to IS NULL
CREATE UNIQUE INDEX uq_active_rate_per_project
    ON rate_history (project_id)
    WHERE effective_to IS NULL;


CREATE TABLE project_assignment (
    assignment_id           SERIAL          PRIMARY KEY,
    collaborator_id         INT             NOT NULL,
    project_id              INT             NOT NULL,
    account_id              INT             NOT NULL,
    assigned_by_manager_id  INT             NOT NULL,
    assignment_date         DATE            NOT NULL DEFAULT CURRENT_DATE,
    created_at              TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMP       NOT NULL DEFAULT NOW(),
    deleted_at              TIMESTAMP       DEFAULT NULL,

    CONSTRAINT fk_assignment_collaborator
        FOREIGN KEY (collaborator_id)
        REFERENCES collaborator(collaborator_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_assignment_project
        FOREIGN KEY (project_id)
        REFERENCES translation_project(project_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_assignment_account
        FOREIGN KEY (account_id)
        REFERENCES platform_account(account_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_assignment_manager
        FOREIGN KEY (assigned_by_manager_id)
        REFERENCES project_manager(manager_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


CREATE TABLE communication_log (
    log_id                  SERIAL          PRIMARY KEY,
    assignment_id           INT             NOT NULL,
    sender_type             VARCHAR(20)     NOT NULL,
    manager_sender_id       INT,
    collaborator_sender_id  INT,
    message_content         TEXT            NOT NULL,
    sent_at                 TIMESTAMP       NOT NULL DEFAULT NOW(),
    created_at              TIMESTAMP       NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_comm_assignment
        FOREIGN KEY (assignment_id)
        REFERENCES project_assignment(assignment_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_comm_manager
        FOREIGN KEY (manager_sender_id)
        REFERENCES project_manager(manager_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT fk_comm_collaborator
        FOREIGN KEY (collaborator_sender_id)
        REFERENCES collaborator(collaborator_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT chk_sender_type
        CHECK (sender_type IN ('PM', 'Collaborator')),

    CONSTRAINT chk_sender_identity
        CHECK (
            (sender_type = 'PM'
             AND manager_sender_id IS NOT NULL
             AND collaborator_sender_id IS NULL)
            OR
            (sender_type = 'Collaborator'
             AND collaborator_sender_id IS NOT NULL
             AND manager_sender_id IS NULL)
        )
);


CREATE TABLE work_record (
    record_id           SERIAL          PRIMARY KEY,
    assignment_id       INT             NOT NULL,
    date_started        DATE,
    date_completed      DATE,
    units_completed     INT             NOT NULL DEFAULT 0,
    quality_score       SMALLINT        DEFAULT NULL,
    notes               TEXT,
    record_status       VARCHAR(20)     NOT NULL DEFAULT 'Submitted',
    created_at          TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP       NOT NULL DEFAULT NOW(),
    deleted_at          TIMESTAMP       DEFAULT NULL,

    CONSTRAINT fk_workrecord_assignment
        FOREIGN KEY (assignment_id)
        REFERENCES project_assignment(assignment_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_record_status
        CHECK (record_status IN (
            'Submitted',
            'Reviewed',
            'Approved',
            'Paid'
        )),

    CONSTRAINT chk_units_non_negative
        CHECK (units_completed >= 0),

    CONSTRAINT chk_quality_score
        CHECK (quality_score IS NULL
               OR quality_score BETWEEN 1 AND 5),

    CONSTRAINT chk_work_dates
        CHECK (
            date_completed IS NULL OR
            date_started   IS NULL OR
            date_completed >= date_started
        )
);


CREATE TABLE agency_invoice (
    invoice_id              SERIAL          PRIMARY KEY,
    project_id              INT             NOT NULL,
    agency_id               INT             NOT NULL,
    currency_id             INT             NOT NULL,
    invoice_number          VARCHAR(100)    UNIQUE,
    invoice_amount          NUMERIC(12,2)   NOT NULL,
    date_received           DATE,
    invoice_status          VARCHAR(20)     NOT NULL DEFAULT 'Pending',
    upwork_transaction_ref  VARCHAR(150)    UNIQUE,
    date_paid               DATE,
    created_at              TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMP       NOT NULL DEFAULT NOW(),
    deleted_at              TIMESTAMP       DEFAULT NULL,

    CONSTRAINT fk_invoice_project
        FOREIGN KEY (project_id)
        REFERENCES translation_project(project_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_invoice_agency
        FOREIGN KEY (agency_id)
        REFERENCES agency(agency_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_invoice_currency
        FOREIGN KEY (currency_id)
        REFERENCES currency(currency_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_invoice_status
        CHECK (invoice_status IN (
            'Pending',
            'Confirmed',
            'Paid',
            'Disputed',
            'Cancelled'
        )),

    CONSTRAINT chk_invoice_amount
        CHECK (invoice_amount >= 0),

    CONSTRAINT chk_invoice_dates
        CHECK (
            date_paid     IS NULL OR
            date_received IS NULL OR
            date_paid >= date_received
        )
);


CREATE TABLE collaborator_payment (
    payment_id              SERIAL          PRIMARY KEY,
    collaborator_id         INT             NOT NULL,
    project_id              INT             NOT NULL,
    currency_id             INT             NOT NULL,
    payment_amount          NUMERIC(10,2)   NOT NULL,
    payment_date            DATE,
    payment_status          VARCHAR(20)     NOT NULL DEFAULT 'Pending',
    transaction_reference   VARCHAR(150)    UNIQUE,
    created_at              TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMP       NOT NULL DEFAULT NOW(),
    deleted_at              TIMESTAMP       DEFAULT NULL,

    CONSTRAINT fk_payment_collaborator
        FOREIGN KEY (collaborator_id)
        REFERENCES collaborator(collaborator_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_payment_project
        FOREIGN KEY (project_id)
        REFERENCES translation_project(project_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_payment_currency
        FOREIGN KEY (currency_id)
        REFERENCES currency(currency_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_payment_status
        CHECK (payment_status IN (
            'Pending',
            'Paid',
            'Failed',
            'Cancelled'
        )),

    CONSTRAINT chk_payment_amount
        CHECK (payment_amount > 0)
);


CREATE TABLE revision_log (
    revision_id                 SERIAL          PRIMARY KEY,
    record_id                   INT             NOT NULL,
    requested_by_manager_id     INT             NOT NULL,
    resolved_record_id          INT,
    revision_reason             TEXT            NOT NULL,
    requested_at                TIMESTAMP       NOT NULL DEFAULT NOW(),
    resolved_at                 TIMESTAMP,
    created_at                  TIMESTAMP       NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_revision_work_record
        FOREIGN KEY (record_id)
        REFERENCES work_record(record_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_revision_manager
        FOREIGN KEY (requested_by_manager_id)
        REFERENCES project_manager(manager_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_revision_resolved_record
        FOREIGN KEY (resolved_record_id)
        REFERENCES work_record(record_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);