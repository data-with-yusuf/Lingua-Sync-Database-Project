-- ================================================================
-- BATCH 3 — JUNCTION TABLES
-- Creation order: PROJECT_PAIR, ACCOUNT_PAIR, COLLABORATOR_SKILL
-- ================================================================


CREATE TABLE project_pair (
    project_id      INT             NOT NULL,
    pair_id         INT             NOT NULL,

    CONSTRAINT pk_project_pair
        PRIMARY KEY (project_id, pair_id),

    CONSTRAINT fk_project_pair_project
        FOREIGN KEY (project_id)
        REFERENCES translation_project(project_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_project_pair_language_pair
        FOREIGN KEY (pair_id)
        REFERENCES language_pair(pair_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


CREATE TABLE account_pair (
    account_id      INT             NOT NULL,
    pair_id         INT             NOT NULL,

    CONSTRAINT pk_account_pair
        PRIMARY KEY (account_id, pair_id),

    CONSTRAINT fk_account_pair_account
        FOREIGN KEY (account_id)
        REFERENCES platform_account(account_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_account_pair_language_pair
        FOREIGN KEY (pair_id)
        REFERENCES language_pair(pair_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


CREATE TABLE collaborator_skill (
    collaborator_id     INT             NOT NULL,
    language_id         INT             NOT NULL,
    proficiency_level   VARCHAR(20)     NOT NULL,

    CONSTRAINT pk_collaborator_skill
        PRIMARY KEY (collaborator_id, language_id),

    CONSTRAINT fk_skill_collaborator
        FOREIGN KEY (collaborator_id)
        REFERENCES collaborator(collaborator_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_skill_language
        FOREIGN KEY (language_id)
        REFERENCES language(language_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_proficiency_level
        CHECK (proficiency_level IN ('Native', 'Professional'))
);