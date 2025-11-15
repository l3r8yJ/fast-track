use askama::Template;
use axum::{extract::Extension, response::Html};
use sea_orm::DatabaseConnection;
use std::sync::Arc;

use crate::{db::projects::get_all_projects, entities};

#[derive(Template)]
#[template(path = "projects.html")]
struct ProjectsModel {
    projects: Vec<entities::projects::Model>,
}

impl ProjectsModel {
    fn new(projects: Vec<entities::projects::Model>) -> Self {
        Self { projects }
    }
}

pub async fn projects_handler(Extension(db): Extension<Arc<DatabaseConnection>>) -> Html<String> {
    let projects = get_all_projects(&db).await;
    let model = ProjectsModel::new(projects);
    Html(model.render().unwrap())
}
