-- Add unique constraint on (code, project_id) to prevent duplicate status codes per project
ALTER TABLE statuses 
ADD CONSTRAINT uq_status_code_project UNIQUE (code, project_id);

-- Foreign key indexes (speed up joins and lookups)
CREATE INDEX idx_projects_owner_id ON projects(owner_id);
CREATE INDEX idx_issues_project_id ON issues(project_id);
CREATE INDEX idx_issues_status_id ON issues(status_id);
CREATE INDEX idx_issues_assignee_id ON issues(assignee_id);
CREATE INDEX idx_statuses_project_id ON statuses(project_id);

-- Indexes for soft deletes (filter by archived_at)
CREATE INDEX idx_users_archived_at ON users(archived_at);
CREATE INDEX idx_projects_archived_at ON projects(archived_at);
CREATE INDEX idx_statuses_archived_at ON statuses(archived_at);
CREATE INDEX idx_issues_archived_at ON issues(archived_at);

-- Timestamp indexes for sorting
CREATE INDEX idx_projects_created_at ON projects(created_at DESC);
CREATE INDEX idx_issues_created_at ON issues(created_at DESC);
CREATE INDEX idx_statuses_created_at ON statuses(created_at DESC);

-- Composite indexes for common query patterns
CREATE INDEX idx_issues_status_project ON issues(status_id, project_id);
CREATE INDEX idx_issues_project_status ON issues(project_id, status_id);
CREATE INDEX idx_statuses_project_code ON statuses(project_id, code);

-- Critical: covering index for status column queries
-- Filters by status_id + project_id, includes title for rendering
CREATE INDEX idx_issues_status_project_active 
ON issues(status_id, project_id, archived_at)
INCLUDE (title, description);

-- Update query statistics
ANALYZE;
