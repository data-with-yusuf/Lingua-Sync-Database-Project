-- ================================================================
-- LINGUASYNC DATABASE
-- Production SQL v1.0
-- PostgreSQL
-- ================================================================

CREATE DATABASE linguasync;
\c linguasync;

CREATE EXTENSION IF NOT EXISTS pgcrypto;


-- ================================================================
-- BATCH 1 — REFERENCE TABLES
-- Creation order: CURRENCY, BILLING_UNIT, MANAGER_ROLE, LANGUAGE, AGENCY
-- ================================================================


CREATE TABLE currency (
    currency_id         SERIAL          PRIMARY KEY,
    currency_name       VARCHAR(100)    NOT NULL,
    currency_code       VARCHAR(3)      NOT NULL UNIQUE,
    currency_symbol     VARCHAR(5),
    created_at          TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP       NOT NULL DEFAULT NOW()
);

================================================================

CREATE TABLE billing_unit (
    unit_id             SERIAL          PRIMARY KEY,
    billing_unit_name   VARCHAR(50)     NOT NULL UNIQUE,
    unit_description    TEXT,
    created_at          TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP       NOT NULL DEFAULT NOW()
);

================================================================

CREATE TABLE manager_role (
    role_id             SERIAL          PRIMARY KEY,
    manager_role_name   VARCHAR(100)    NOT NULL UNIQUE,
    role_description    TEXT,
    created_at          TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP       NOT NULL DEFAULT NOW()
);

================================================================

CREATE TABLE language (
    language_id             SERIAL          PRIMARY KEY,
    language_name           VARCHAR(100)    NOT NULL,
    language_code           VARCHAR(10)     NOT NULL UNIQUE,
    language_variant        VARCHAR(100),
    language_display_name   VARCHAR(150)    NOT NULL,
    created_at              TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMP       NOT NULL DEFAULT NOW()
);

================================================================

CREATE TABLE agency (
    agency_id       SERIAL          PRIMARY KEY,
    agency_name     VARCHAR(150)    NOT NULL,
    created_at      TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP       NOT NULL DEFAULT NOW(),
    deleted_at      TIMESTAMP       DEFAULT NULL
);
