use axum::{extract::Extension, response::Html};
use sea_orm::DatabaseConnection;
use std::sync::Arc;

use crate::db::projects::get_all_projects;

pub async fn projects_handler(Extension(db): Extension<Arc<DatabaseConnection>>) -> Html<String> {
    let projects = get_all_projects(&db).await;

    let html = projects
        .iter()
        .map(|p| format!("<div class='project'>{}</div>", p.name))
        .collect::<String>();

    Html(html)
}
