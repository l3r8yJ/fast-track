create extension if not exists pgcrypto;

create table users (
    id uuid primary key default gen_random_uuid(),
    username text not null unique,
    password_hash text not null,
    fullname text,
    role text,
    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    archived_at timestamp default null
);

create table projects (
    id uuid primary key default gen_random_uuid(),
    title text not null,
    owner_id uuid not null,
    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    archived_at timestamp default null,
    constraint fk_projects_owner
        foreign key (owner_id) references users(id)
        on delete cascade
);

create table projects_to_users (
    project_id uuid not null,
    user_id uuid not null,
    primary key (project_id, user_id),
    constraint fk_ptu_project
        foreign key (project_id) references projects(id)
        on delete cascade,
    constraint fk_ptu_user
        foreign key (user_id) references users(id)
        on delete cascade
);

create table statuses (
    id uuid primary key default gen_random_uuid(),
    code text not null,
    weight integer not null,
    project_id uuid not null,
    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    archived_at timestamp default null,
    constraint fk_status_project
        foreign key (project_id) references projects(id)
        on delete cascade,
    constraint uq_status_id_project unique (id, project_id)
);

create table issues (
    id uuid primary key default gen_random_uuid(),
    title text not null,
    description text,
    status_id uuid,
    project_id uuid not null,
    assignee_id uuid,
    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    archived_at timestamp default null,
    constraint fk_issues_project
        foreign key (project_id) references projects(id)
        on delete cascade,
    constraint fk_issues_assignee
        foreign key (assignee_id) references users(id)
        on delete set null,
    constraint fk_issues_status
        foreign key (status_id, project_id)
        references statuses(id, project_id)
        on delete set null
);
