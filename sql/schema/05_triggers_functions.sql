-- ================================================================
-- BATCH 5 — TRIGGER FUNCTIONS, TRIGGERS AND INDEXES
-- ================================================================
-- Order:
-- 1. Timestamp update function and triggers
-- 2. Soft delete protection function and triggers
-- 3. Soft delete cascade triggers
-- 4. Business logic triggers
-- 5. Additional indexes
-- ================================================================


-- ================================================================
-- SECTION 1 — AUTO-UPDATE TIMESTAMPS
-- One reusable function applied to all tables with updated_at
-- Fires BEFORE every UPDATE
-- Sets updated_at to current timestamp automatically
-- No manual update needed anywhere in the application
-- ================================================================

CREATE OR REPLACE FUNCTION fn_update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Apply to every table that has updated_at column
CREATE TRIGGER trg_currency_updated_at
    BEFORE UPDATE ON currency
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();

CREATE TRIGGER trg_billing_unit_updated_at
    BEFORE UPDATE ON billing_unit
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();

CREATE TRIGGER trg_manager_role_updated_at
    BEFORE UPDATE ON manager_role
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();

CREATE TRIGGER trg_language_updated_at
    BEFORE UPDATE ON language
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();

CREATE TRIGGER trg_agency_updated_at
    BEFORE UPDATE ON agency
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();

CREATE TRIGGER trg_project_type_updated_at
    BEFORE UPDATE ON project_type
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();

CREATE TRIGGER trg_project_manager_updated_at
    BEFORE UPDATE ON project_manager
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();

CREATE TRIGGER trg_collaborator_updated_at
    BEFORE UPDATE ON collaborator
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();

CREATE TRIGGER trg_agency_contact_updated_at
    BEFORE UPDATE ON agency_contact
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();

CREATE TRIGGER trg_language_pair_updated_at
    BEFORE UPDATE ON language_pair
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();

CREATE TRIGGER trg_translation_project_updated_at
    BEFORE UPDATE ON translation_project
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();

CREATE TRIGGER trg_platform_account_updated_at
    BEFORE UPDATE ON platform_account
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();

CREATE TRIGGER trg_bank_account_updated_at
    BEFORE UPDATE ON bank_account
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();

CREATE TRIGGER trg_project_assignment_updated_at
    BEFORE UPDATE ON project_assignment
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();

CREATE TRIGGER trg_work_record_updated_at
    BEFORE UPDATE ON work_record
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();

CREATE TRIGGER trg_agency_invoice_updated_at
    BEFORE UPDATE ON agency_invoice
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();

CREATE TRIGGER trg_collaborator_payment_updated_at
    BEFORE UPDATE ON collaborator_payment
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();


-- ================================================================
-- SECTION 2 — SOFT DELETE PROTECTION
-- Blocks hard DELETE on all major business tables
-- Anyone attempting DELETE gets a clear error message
-- Correct approach: UPDATE table SET deleted_at = NOW()
-- ================================================================

CREATE OR REPLACE FUNCTION fn_block_hard_delete()
RETURNS TRIGGER AS $$
BEGIN
    RAISE EXCEPTION
        'Direct deletion is not allowed on this table. '
        'To remove this record use: '
        'UPDATE % SET deleted_at = NOW() WHERE ... ',
        TG_TABLE_NAME;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_soft_delete_agency
    BEFORE DELETE ON agency
    FOR EACH ROW
    EXECUTE FUNCTION fn_block_hard_delete();

CREATE TRIGGER trg_soft_delete_project_manager
    BEFORE DELETE ON project_manager
    FOR EACH ROW
    EXECUTE FUNCTION fn_block_hard_delete();

CREATE TRIGGER trg_soft_delete_collaborator
    BEFORE DELETE ON collaborator
    FOR EACH ROW
    EXECUTE FUNCTION fn_block_hard_delete();

CREATE TRIGGER trg_soft_delete_translation_project
    BEFORE DELETE ON translation_project
    FOR EACH ROW
    EXECUTE FUNCTION fn_block_hard_delete();

CREATE TRIGGER trg_soft_delete_platform_account
    BEFORE DELETE ON platform_account
    FOR EACH ROW
    EXECUTE FUNCTION fn_block_hard_delete();

CREATE TRIGGER trg_soft_delete_project_assignment
    BEFORE DELETE ON project_assignment
    FOR EACH ROW
    EXECUTE FUNCTION fn_block_hard_delete();

CREATE TRIGGER trg_soft_delete_work_record
    BEFORE DELETE ON work_record
    FOR EACH ROW
    EXECUTE FUNCTION fn_block_hard_delete();

CREATE TRIGGER trg_soft_delete_agency_invoice
    BEFORE DELETE ON agency_invoice
    FOR EACH ROW
    EXECUTE FUNCTION fn_block_hard_delete();

CREATE TRIGGER trg_soft_delete_collaborator_payment
    BEFORE DELETE ON collaborator_payment
    FOR EACH ROW
    EXECUTE FUNCTION fn_block_hard_delete();


-- ================================================================
-- SECTION 3 — SOFT DELETE CASCADE TRIGGERS
-- When a parent record is soft deleted
-- automatically soft delete related child records
-- Handles what ON DELETE CASCADE cannot do for soft deletes
-- ================================================================


-- AGENCY soft delete cascades to AGENCY_CONTACT
-- When an agency is soft deleted all its contacts
-- are automatically soft deleted too
CREATE OR REPLACE FUNCTION fn_cascade_soft_delete_agency()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.deleted_at IS NOT NULL
       AND OLD.deleted_at IS NULL THEN

        UPDATE agency_contact
        SET deleted_at = NOW()
        WHERE agency_id = OLD.agency_id
        AND deleted_at IS NULL;

    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_cascade_soft_delete_agency
    AFTER UPDATE OF deleted_at ON agency
    FOR EACH ROW
    EXECUTE FUNCTION fn_cascade_soft_delete_agency();


-- COLLABORATOR soft delete cascades to BANK_ACCOUNT
-- When a collaborator is soft deleted all their bank
-- account records are automatically soft deleted too
CREATE OR REPLACE FUNCTION fn_cascade_soft_delete_collaborator()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.deleted_at IS NOT NULL
       AND OLD.deleted_at IS NULL THEN

        UPDATE bank_account
        SET deleted_at = NOW()
        WHERE collaborator_id = OLD.collaborator_id
        AND deleted_at IS NULL;

    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_cascade_soft_delete_collaborator
    AFTER UPDATE OF deleted_at ON collaborator
    FOR EACH ROW
    EXECUTE FUNCTION fn_cascade_soft_delete_collaborator();


-- TRANSLATION_PROJECT soft delete cascades to PROJECT_PAIR
-- When a project is soft deleted its language pair
-- assignments become irrelevant
-- We do not add deleted_at to PROJECT_PAIR
-- Instead we simply restrict operations on the project
-- This is handled by RESTRICT on the FK


-- ================================================================
-- SECTION 4 — BUSINESS LOGIC TRIGGERS
-- Enforce business rules that cannot be handled
-- by simple CHECK constraints alone
-- ================================================================


-- TRIGGER: BLOCK WORK RECORD STATUS FLOW VIOLATIONS
-- Status must follow: Submitted → Reviewed → Approved → Paid
-- Reviewed can return to Submitted if PM rejects work
-- Paid is final — cannot be changed under any circumstances
CREATE OR REPLACE FUNCTION fn_enforce_work_record_status_flow()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.record_status = 'Submitted'
       AND NEW.record_status NOT IN ('Reviewed') THEN
        RAISE EXCEPTION
            'Invalid status transition. '
            'Submitted can only move to Reviewed. '
            'Attempted: %', NEW.record_status;
    END IF;

    IF OLD.record_status = 'Reviewed'
       AND NEW.record_status NOT IN ('Approved', 'Submitted') THEN
        RAISE EXCEPTION
            'Invalid status transition. '
            'Reviewed can only move to Approved or back to Submitted. '
            'Attempted: %', NEW.record_status;
    END IF;

    IF OLD.record_status = 'Approved'
       AND NEW.record_status NOT IN ('Paid') THEN
        RAISE EXCEPTION
            'Invalid status transition. '
            'Approved can only move to Paid. '
            'Attempted: %', NEW.record_status;
    END IF;

    IF OLD.record_status = 'Paid' THEN
        RAISE EXCEPTION
            'Invalid status transition. '
            'Paid is a final status and cannot be changed.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_work_record_status_flow
    BEFORE UPDATE OF record_status ON work_record
    FOR EACH ROW
    EXECUTE FUNCTION fn_enforce_work_record_status_flow();


-- TRIGGER: AUTO-COMPLETE PROJECT
-- When ALL active work records for a project reach Approved
-- the project status automatically changes to Completed
-- Soft deleted work records are excluded from the count
-- Only fires when a work record status changes to Approved
CREATE OR REPLACE FUNCTION fn_auto_complete_project()
RETURNS TRIGGER AS $$
DECLARE
    v_project_id        INT;
    v_total_records     INT;
    v_approved_records  INT;
BEGIN
    -- Get the project_id through the assignment chain
    SELECT pa.project_id
    INTO v_project_id
    FROM project_assignment pa
    WHERE pa.assignment_id = NEW.assignment_id;

    -- Count all active work records for this project
    SELECT COUNT(*)
    INTO v_total_records
    FROM work_record wr
    JOIN project_assignment pa
        ON wr.assignment_id = pa.assignment_id
    WHERE pa.project_id = v_project_id
    AND wr.deleted_at IS NULL;

    -- Count only approved active work records
    SELECT COUNT(*)
    INTO v_approved_records
    FROM work_record wr
    JOIN project_assignment pa
        ON wr.assignment_id = pa.assignment_id
    WHERE pa.project_id = v_project_id
    AND wr.record_status = 'Approved'
    AND wr.deleted_at IS NULL;

    -- If all records are approved update project to Completed
    IF v_total_records > 0
       AND v_total_records = v_approved_records THEN

        UPDATE translation_project
        SET project_status = 'Completed'
        WHERE project_id = v_project_id
        AND project_status = 'Assigned';

    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Only fires when record_status changes to Approved
CREATE TRIGGER trg_auto_complete_project
    AFTER UPDATE OF record_status ON work_record
    FOR EACH ROW
    WHEN (NEW.record_status = 'Approved')
    EXECUTE FUNCTION fn_auto_complete_project();


-- TRIGGER: ENFORCE MAX 5 LANGUAGE PAIRS PER ACCOUNT
-- CHECK constraint cannot count other rows in the same table
-- Trigger is the correct tool for this business rule
-- Fires BEFORE every INSERT on ACCOUNT_PAIR
CREATE OR REPLACE FUNCTION fn_enforce_max_language_pairs()
RETURNS TRIGGER AS $$
DECLARE
    v_pair_count INT;
BEGIN
    SELECT COUNT(*)
    INTO v_pair_count
    FROM account_pair
    WHERE account_id = NEW.account_id;

    IF v_pair_count >= 5 THEN
        RAISE EXCEPTION
            'Account % already has the maximum of 5 language pairs. '
            'Cannot add more.',
            NEW.account_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_max_language_pairs
    BEFORE INSERT ON account_pair
    FOR EACH ROW
    EXECUTE FUNCTION fn_enforce_max_language_pairs();


-- TRIGGER: BLOCK BLACKLISTED AND INACTIVE COLLABORATORS
-- Prevents assigning blacklisted or inactive collaborators
-- to any project regardless of who is making the assignment
-- Fires BEFORE every INSERT on PROJECT_ASSIGNMENT
CREATE OR REPLACE FUNCTION fn_check_collaborator_eligibility()
RETURNS TRIGGER AS $$
DECLARE
    v_employment_status VARCHAR(20);
BEGIN
    SELECT employment_status
    INTO v_employment_status
    FROM collaborator
    WHERE collaborator_id = NEW.collaborator_id;

    IF v_employment_status = 'Blacklisted' THEN
        RAISE EXCEPTION
            'Collaborator % is blacklisted and cannot be '
            'assigned to any project.',
            NEW.collaborator_id;
    END IF;

    IF v_employment_status = 'Inactive' THEN
        RAISE EXCEPTION
            'Collaborator % is inactive and cannot be '
            'assigned to any project.',
            NEW.collaborator_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_collaborator_eligibility
    BEFORE INSERT ON project_assignment
    FOR EACH ROW
    EXECUTE FUNCTION fn_check_collaborator_eligibility();


-- TRIGGER: AUTO-UPDATE COLLABORATOR ASSIGNMENT STATUS
-- When a new assignment is created
-- automatically set collaborator assignment_status to Assigned
-- Only updates if currently Available
-- Does not override Unavailable status
-- Setting back to Available is done manually by PM
-- when collaborator has finished all their work
CREATE OR REPLACE FUNCTION fn_set_collaborator_assigned()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE collaborator
    SET assignment_status = 'Assigned'
    WHERE collaborator_id = NEW.collaborator_id
    AND assignment_status = 'Available';

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_set_collaborator_assigned
    AFTER INSERT ON project_assignment
    FOR EACH ROW
    EXECUTE FUNCTION fn_set_collaborator_assigned();


-- TRIGGER: BLOCK REVISION ON APPROVED OR PAID WORK RECORDS
-- Revision requests only valid on Submitted or Reviewed records
-- Cannot request revision on Approved or Paid work
-- Fires BEFORE every INSERT on REVISION_LOG
CREATE OR REPLACE FUNCTION fn_check_revision_eligibility()
RETURNS TRIGGER AS $$
DECLARE
    v_status VARCHAR(20);
BEGIN
    SELECT record_status
    INTO v_status
    FROM work_record
    WHERE record_id = NEW.record_id;

    IF v_status IN ('Approved', 'Paid') THEN
        RAISE EXCEPTION
            'Revision cannot be requested on a work record '
            'with status %. '
            'Revisions are only allowed on Submitted or '
            'Reviewed records.',
            v_status;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_revision_eligibility
    BEFORE INSERT ON revision_log
    FOR EACH ROW
    EXECUTE FUNCTION fn_check_revision_eligibility();


-- TRIGGER: SYNC RATE HISTORY ON PROJECT RATE CHANGE
-- When agency_rate or collaborator_rate changes on a project
-- Step 1: Close the current active rate in RATE_HISTORY
--         by setting effective_to to yesterday
-- Step 2: Insert new rate as the active rate
--         with effective_from = today
-- This ensures TRANSLATION_PROJECT and RATE_HISTORY
-- are always in sync
-- Uses session variable app.current_manager_id
-- Application must SET app.current_manager_id = manager_id
-- before every rate update
CREATE OR REPLACE FUNCTION fn_sync_rate_history()
RETURNS TRIGGER AS $$
DECLARE
    v_manager_id INT;
BEGIN
    -- Only fire if rates actually changed
    IF OLD.agency_rate = NEW.agency_rate
       AND OLD.collaborator_rate = NEW.collaborator_rate THEN
        RETURN NEW;
    END IF;

    -- Get the manager making the change from session variable
    -- Application sets this before the UPDATE
    BEGIN
        v_manager_id := current_setting('app.current_manager_id')::INT;
    EXCEPTION WHEN OTHERS THEN
        -- If session variable not set use project manager 1
        -- as fallback — update in production to raise exception
        v_manager_id := 1;
    END;

    -- Close the current active rate
    UPDATE rate_history
    SET effective_to = CURRENT_DATE - INTERVAL '1 day'
    WHERE project_id = NEW.project_id
    AND effective_to IS NULL;

    -- Insert the new active rate
    INSERT INTO rate_history (
        project_id,
        changed_by_manager_id,
        agency_rate,
        collaborator_rate,
        effective_from,
        effective_to
    )
    VALUES (
        NEW.project_id,
        v_manager_id,
        NEW.agency_rate,
        NEW.collaborator_rate,
        CURRENT_DATE,
        NULL
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Only fires when agency_rate or collaborator_rate changes
CREATE TRIGGER trg_sync_rate_history
    AFTER UPDATE OF agency_rate, collaborator_rate
    ON translation_project
    FOR EACH ROW
    EXECUTE FUNCTION fn_sync_rate_history();