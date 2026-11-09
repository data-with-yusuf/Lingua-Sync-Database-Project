-- ================================================================
-- SECTION 5 — PERFORMANCE INDEXES
-- Indexes on frequently joined and filtered columns
-- Improves query performance as data grows
-- ================================================================

-- TRANSLATION_PROJECT — frequently joined and filtered
CREATE INDEX idx_project_agency_id
    ON translation_project (agency_id);

CREATE INDEX idx_project_status
    ON translation_project (project_status);

CREATE INDEX idx_project_type_id
    ON translation_project (project_type_id);

-- PROJECT_ASSIGNMENT — most frequently joined table
CREATE INDEX idx_assignment_collaborator_id
    ON project_assignment (collaborator_id);

CREATE INDEX idx_assignment_project_id
    ON project_assignment (project_id);

CREATE INDEX idx_assignment_account_id
    ON project_assignment (account_id);

CREATE INDEX idx_assignment_manager_id
    ON project_assignment (assigned_by_manager_id);

-- WORK_RECORD — frequently filtered by status
CREATE INDEX idx_work_record_assignment_id
    ON work_record (assignment_id);

CREATE INDEX idx_work_record_status
    ON work_record (record_status);

-- AGENCY_INVOICE — frequently filtered by status
CREATE INDEX idx_invoice_project_id
    ON agency_invoice (project_id);

CREATE INDEX idx_invoice_agency_id
    ON agency_invoice (agency_id);

CREATE INDEX idx_invoice_status
    ON agency_invoice (invoice_status);

-- COLLABORATOR_PAYMENT — frequently filtered by status
CREATE INDEX idx_payment_collaborator_id
    ON collaborator_payment (collaborator_id);

CREATE INDEX idx_payment_project_id
    ON collaborator_payment (project_id);

CREATE INDEX idx_payment_status
    ON collaborator_payment (payment_status);

-- COLLABORATOR — frequently filtered by status
CREATE INDEX idx_collaborator_employment_status
    ON collaborator (employment_status);

CREATE INDEX idx_collaborator_assignment_status
    ON collaborator (assignment_status);

-- RATE_HISTORY — frequently queried by project
CREATE INDEX idx_rate_history_project_id
    ON rate_history (project_id);

-- REVISION_LOG — frequently joined to work record
CREATE INDEX idx_revision_record_id
    ON revision_log (record_id);

-- COMMUNICATION_LOG — frequently filtered by assignment
CREATE INDEX idx_comm_log_assignment_id
    ON communication_log (assignment_id);

-- Soft delete performance indexes
-- Queries filtering deleted_at IS NULL benefit from these
CREATE INDEX idx_agency_deleted_at
    ON agency (deleted_at)
    WHERE deleted_at IS NULL;

CREATE INDEX idx_collaborator_deleted_at
    ON collaborator (deleted_at)
    WHERE deleted_at IS NULL;

CREATE INDEX idx_project_deleted_at
    ON translation_project (deleted_at)
    WHERE deleted_at IS NULL;

CREATE INDEX idx_assignment_deleted_at
    ON project_assignment (deleted_at)
    WHERE deleted_at IS NULL;

CREATE INDEX idx_work_record_deleted_at
    ON work_record (deleted_at)
    WHERE deleted_at IS NULL;

CREATE INDEX idx_invoice_deleted_at
    ON agency_invoice (deleted_at)
    WHERE deleted_at IS NULL;

CREATE INDEX idx_payment_deleted_at
    ON collaborator_payment (deleted_at)
    WHERE deleted_at IS NULL;