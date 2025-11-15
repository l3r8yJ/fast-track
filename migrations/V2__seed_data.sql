-- Insert test users
INSERT INTO users (id, username, password_hash, fullname, role, created_at, updated_at)
VALUES 
  ('550e8400-e29b-41d4-a716-446655440001'::uuid, 'alice', '$2b$12$123456789012345678901234567890', 'Alice Johnson', 'admin', now(), now()),
  ('550e8400-e29b-41d4-a716-446655440002'::uuid, 'bob', '$2b$12$123456789012345678901234567890', 'Bob Smith', 'user', now(), now()),
  ('550e8400-e29b-41d4-a716-446655440003'::uuid, 'charlie', '$2b$12$123456789012345678901234567890', 'Charlie Brown', 'user', now(), now()),
  ('550e8400-e29b-41d4-a716-446655440004'::uuid, 'diana', '$2b$12$123456789012345678901234567890', 'Diana Prince', 'user', now(), now()),
  ('550e8400-e29b-41d4-a716-446655440005'::uuid, 'evan', '$2b$12$123456789012345678901234567890', 'Evan Davis', 'user', now(), now()),
  ('550e8400-e29b-41d4-a716-446655440006'::uuid, 'fiona', '$2b$12$123456789012345678901234567890', 'Fiona Green', 'user', now(), now())
ON CONFLICT DO NOTHING;

-- Insert test projects
INSERT INTO projects (id, title, owner_id, created_at, updated_at)
VALUES
  ('650e8400-e29b-41d4-a716-446655440001'::uuid, 'Website Redesign', '550e8400-e29b-41d4-a716-446655440001'::uuid, now(), now()),
  ('650e8400-e29b-41d4-a716-446655440002'::uuid, 'Mobile App', '550e8400-e29b-41d4-a716-446655440001'::uuid, now(), now()),
  ('650e8400-e29b-41d4-a716-446655440003'::uuid, 'API Development', '550e8400-e29b-41d4-a716-446655440002'::uuid, now(), now()),
  ('650e8400-e29b-41d4-a716-446655440004'::uuid, 'Documentation', '550e8400-e29b-41d4-a716-446655440003'::uuid, now(), now()),
  ('650e8400-e29b-41d4-a716-446655440005'::uuid, 'DevOps Infrastructure', '550e8400-e29b-41d4-a716-446655440004'::uuid, now(), now())
ON CONFLICT DO NOTHING;

-- Assign users to projects
INSERT INTO projects_to_users (project_id, user_id)
VALUES
  ('650e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid),
  ('650e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid),
  ('650e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440003'::uuid),
  ('650e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid),
  ('650e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid),
  ('650e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440004'::uuid),
  ('650e8400-e29b-41d4-a716-446655440003'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid),
  ('650e8400-e29b-41d4-a716-446655440003'::uuid, '550e8400-e29b-41d4-a716-446655440003'::uuid),
  ('650e8400-e29b-41d4-a716-446655440003'::uuid, '550e8400-e29b-41d4-a716-446655440005'::uuid),
  ('650e8400-e29b-41d4-a716-446655440004'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid),
  ('650e8400-e29b-41d4-a716-446655440004'::uuid, '550e8400-e29b-41d4-a716-446655440006'::uuid),
  ('650e8400-e29b-41d4-a716-446655440005'::uuid, '550e8400-e29b-41d4-a716-446655440004'::uuid),
  ('650e8400-e29b-41d4-a716-446655440005'::uuid, '550e8400-e29b-41d4-a716-446655440005'::uuid)
ON CONFLICT DO NOTHING;

-- Insert statuses for projects
INSERT INTO statuses (id, code, weight, project_id, created_at, updated_at)
VALUES
  -- Website Redesign project
  ('750e8400-e29b-41d4-a716-446655440001'::uuid, 'todo', 1, '650e8400-e29b-41d4-a716-446655440001'::uuid, now(), now()),
  ('750e8400-e29b-41d4-a716-446655440002'::uuid, 'in_progress', 2, '650e8400-e29b-41d4-a716-446655440001'::uuid, now(), now()),
  ('750e8400-e29b-41d4-a716-446655440003'::uuid, 'in_review', 3, '650e8400-e29b-41d4-a716-446655440001'::uuid, now(), now()),
  ('750e8400-e29b-41d4-a716-446655440004'::uuid, 'done', 4, '650e8400-e29b-41d4-a716-446655440001'::uuid, now(), now()),
  -- Mobile App project
  ('750e8400-e29b-41d4-a716-446655440005'::uuid, 'todo', 1, '650e8400-e29b-41d4-a716-446655440002'::uuid, now(), now()),
  ('750e8400-e29b-41d4-a716-446655440006'::uuid, 'in_progress', 2, '650e8400-e29b-41d4-a716-446655440002'::uuid, now(), now()),
  ('750e8400-e29b-41d4-a716-446655440007'::uuid, 'testing', 3, '650e8400-e29b-41d4-a716-446655440002'::uuid, now(), now()),
  ('750e8400-e29b-41d4-a716-446655440008'::uuid, 'done', 4, '650e8400-e29b-41d4-a716-446655440002'::uuid, now(), now()),
  -- API Development project
  ('750e8400-e29b-41d4-a716-446655440009'::uuid, 'backlog', 0, '650e8400-e29b-41d4-a716-446655440003'::uuid, now(), now()),
  ('750e8400-e29b-41d4-a716-446655440010'::uuid, 'todo', 1, '650e8400-e29b-41d4-a716-446655440003'::uuid, now(), now()),
  ('750e8400-e29b-41d4-a716-446655440011'::uuid, 'in_progress', 2, '650e8400-e29b-41d4-a716-446655440003'::uuid, now(), now()),
  ('750e8400-e29b-41d4-a716-446655440012'::uuid, 'done', 3, '650e8400-e29b-41d4-a716-446655440003'::uuid, now(), now()),
  -- Documentation project
  ('750e8400-e29b-41d4-a716-446655440013'::uuid, 'todo', 1, '650e8400-e29b-41d4-a716-446655440004'::uuid, now(), now()),
  ('750e8400-e29b-41d4-a716-446655440014'::uuid, 'in_progress', 2, '650e8400-e29b-41d4-a716-446655440004'::uuid, now(), now()),
  ('750e8400-e29b-41d4-a716-446655440015'::uuid, 'done', 3, '650e8400-e29b-41d4-a716-446655440004'::uuid, now(), now()),
  -- DevOps Infrastructure project
  ('750e8400-e29b-41d4-a716-446655440016'::uuid, 'todo', 1, '650e8400-e29b-41d4-a716-446655440005'::uuid, now(), now()),
  ('750e8400-e29b-41d4-a716-446655440017'::uuid, 'in_progress', 2, '650e8400-e29b-41d4-a716-446655440005'::uuid, now(), now()),
  ('750e8400-e29b-41d4-a716-446655440018'::uuid, 'done', 3, '650e8400-e29b-41d4-a716-446655440005'::uuid, now(), now())
ON CONFLICT DO NOTHING;

-- Insert test issues for Website Redesign
INSERT INTO issues (id, title, description, status_id, project_id, assignee_id, created_at, updated_at)
VALUES
  ('850e8400-e29b-41d4-a716-446655440001'::uuid, 'Update homepage header', 'Make the header more responsive', '750e8400-e29b-41d4-a716-446655440002'::uuid, '650e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440002'::uuid, 'Fix footer styling', 'Footer links are not aligned properly', '750e8400-e29b-41d4-a716-446655440001'::uuid, '650e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440003'::uuid, 'Add dark mode', 'Implement dark mode toggle for all pages', '750e8400-e29b-41d4-a716-446655440003'::uuid, '650e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440004'::uuid, 'Optimize images', 'Compress all images for faster loading', '750e8400-e29b-41d4-a716-446655440002'::uuid, '650e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440003'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440005'::uuid, 'Mobile navigation menu', 'Create hamburger menu for mobile', '750e8400-e29b-41d4-a716-446655440001'::uuid, '650e8400-e29b-41d4-a716-446655440001'::uuid, NULL, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440006'::uuid, 'SEO improvements', 'Update meta tags and structured data', '750e8400-e29b-41d4-a716-446655440004'::uuid, '650e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440007'::uuid, 'Typography review', 'Review and improve font hierarchy', '750e8400-e29b-41d4-a716-446655440003'::uuid, '650e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440008'::uuid, 'Color palette finalization', 'Lock in final color scheme', '750e8400-e29b-41d4-a716-446655440001'::uuid, '650e8400-e29b-41d4-a716-446655440001'::uuid, NULL, now(), now())
ON CONFLICT DO NOTHING;

-- Insert test issues for Mobile App
INSERT INTO issues (id, title, description, status_id, project_id, assignee_id, created_at, updated_at)
VALUES
  ('850e8400-e29b-41d4-a716-446655440009'::uuid, 'Design iOS interface', 'Create wireframes for iOS app', '750e8400-e29b-41d4-a716-446655440005'::uuid, '650e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440010'::uuid, 'Implement push notifications', 'Add push notification service', '750e8400-e29b-41d4-a716-446655440006'::uuid, '650e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440003'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440011'::uuid, 'User authentication flow', 'Implement OAuth and session management', '750e8400-e29b-41d4-a716-446655440006'::uuid, '650e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440012'::uuid, 'Database schema design', 'Plan local SQLite structure', '750e8400-e29b-41d4-a716-446655440007'::uuid, '650e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440004'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440013'::uuid, 'UI component library', 'Build reusable UI components', '750e8400-e29b-41d4-a716-446655440005'::uuid, '650e8400-e29b-41d4-a716-446655440002'::uuid, NULL, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440014'::uuid, 'Testing setup', 'Configure unit and integration tests', '750e8400-e29b-41d4-a716-446655440007'::uuid, '650e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440004'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440015'::uuid, 'App icon design', 'Create app store icon assets', '750e8400-e29b-41d4-a716-446655440008'::uuid, '650e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, now(), now())
ON CONFLICT DO NOTHING;

-- Insert test issues for API Development
INSERT INTO issues (id, title, description, status_id, project_id, assignee_id, created_at, updated_at)
VALUES
  ('850e8400-e29b-41d4-a716-446655440016'::uuid, 'Design API schema', 'Define REST endpoints and data models', '750e8400-e29b-41d4-a716-446655440009'::uuid, '650e8400-e29b-41d4-a716-446655440003'::uuid, '550e8400-e29b-41d4-a716-446655440005'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440017'::uuid, 'Build REST API', 'Implement core endpoints', '750e8400-e29b-41d4-a716-446655440011'::uuid, '650e8400-e29b-41d4-a716-446655440003'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440018'::uuid, 'Authentication middleware', 'JWT validation and token refresh', '750e8400-e29b-41d4-a716-446655440010'::uuid, '650e8400-e29b-41d4-a716-446655440003'::uuid, '550e8400-e29b-41d4-a716-446655440005'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440019'::uuid, 'Database migration tool', 'Create migration system for production', '750e8400-e29b-41d4-a716-446655440010'::uuid, '650e8400-e29b-41d4-a716-446655440003'::uuid, NULL, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440020'::uuid, 'API rate limiting', 'Implement request throttling', '750e8400-e29b-41d4-a716-446655440011'::uuid, '650e8400-e29b-41d4-a716-446655440003'::uuid, '550e8400-e29b-41d4-a716-446655440003'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440021'::uuid, 'Error handling standardization', 'Consistent error response format', '750e8400-e29b-41d4-a716-446655440012'::uuid, '650e8400-e29b-41d4-a716-446655440003'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440022'::uuid, 'API versioning strategy', 'Plan v2 API structure', '750e8400-e29b-41d4-a716-446655440010'::uuid, '650e8400-e29b-41d4-a716-446655440003'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, now(), now())
ON CONFLICT DO NOTHING;

-- Insert test issues for Documentation
INSERT INTO issues (id, title, description, status_id, project_id, assignee_id, created_at, updated_at)
VALUES
  ('850e8400-e29b-41d4-a716-446655440023'::uuid, 'Getting started guide', 'Write quick start documentation', '750e8400-e29b-41d4-a716-446655440013'::uuid, '650e8400-e29b-41d4-a716-446655440004'::uuid, '550e8400-e29b-41d4-a716-446655440006'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440024'::uuid, 'API reference docs', 'Document all endpoints and parameters', '750e8400-e29b-41d4-a716-446655440014'::uuid, '650e8400-e29b-41d4-a716-446655440004'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440025'::uuid, 'Architecture diagrams', 'Create system architecture documentation', '750e8400-e29b-41d4-a716-446655440013'::uuid, '650e8400-e29b-41d4-a716-446655440004'::uuid, NULL, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440026'::uuid, 'Troubleshooting guide', 'Common issues and solutions', '750e8400-e29b-41d4-a716-446655440015'::uuid, '650e8400-e29b-41d4-a716-446655440004'::uuid, '550e8400-e29b-41d4-a716-446655440006'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440027'::uuid, 'Code examples', 'Write usage examples for common scenarios', '750e8400-e29b-41d4-a716-446655440014'::uuid, '650e8400-e29b-41d4-a716-446655440004'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, now(), now())
ON CONFLICT DO NOTHING;

-- Insert test issues for DevOps Infrastructure
INSERT INTO issues (id, title, description, status_id, project_id, assignee_id, created_at, updated_at)
VALUES
  ('850e8400-e29b-41d4-a716-446655440028'::uuid, 'Setup CI/CD pipeline', 'Configure GitHub Actions for automated testing', '750e8400-e29b-41d4-a716-446655440016'::uuid, '650e8400-e29b-41d4-a716-446655440005'::uuid, '550e8400-e29b-41d4-a716-446655440004'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440029'::uuid, 'Docker containerization', 'Create Dockerfile and docker-compose', '750e8400-e29b-41d4-a716-446655440017'::uuid, '650e8400-e29b-41d4-a716-446655440005'::uuid, '550e8400-e29b-41d4-a716-446655440005'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440030'::uuid, 'Kubernetes deployment', 'Set up K8s manifests and Helm charts', '750e8400-e29b-41d4-a716-446655440016'::uuid, '650e8400-e29b-41d4-a716-446655440005'::uuid, NULL, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440031'::uuid, 'Monitoring and logging', 'Setup Prometheus and ELK stack', '750e8400-e29b-41d4-a716-446655440017'::uuid, '650e8400-e29b-41d4-a716-446655440005'::uuid, '550e8400-e29b-41d4-a716-446655440005'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440032'::uuid, 'Database backups', 'Implement automated backup strategy', '750e8400-e29b-41d4-a716-446655440018'::uuid, '650e8400-e29b-41d4-a716-446655440005'::uuid, '550e8400-e29b-41d4-a716-446655440004'::uuid, now(), now()),
  ('850e8400-e29b-41d4-a716-446655440033'::uuid, 'SSL/TLS certificates', 'Configure HTTPS for all services', '750e8400-e29b-41d4-a716-446655440018'::uuid, '650e8400-e29b-41d4-a716-446655440005'::uuid, '550e8400-e29b-41d4-a716-446655440004'::uuid, now(), now())
ON CONFLICT DO NOTHING;
