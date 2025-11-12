create table projects(
  id uuid,
  name text not null,
  primary key(id)
);

create table statuses(
  id uuid,
  name text not null,
  primary key(id)
);

create table issues(
  id uuid,
  project_id uuid,
  status_id uuid,
  name text not null unique,
  description text,
  primary key (id),
  foreign key(project_id) references projects(id),
  foreign key(status_id) references statuses(id)
);
