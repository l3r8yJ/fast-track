use askama::Template;
use axum::{extract::State, response::Html};

use crate::{services::projects::get_all_projects, state::AppState, views::projects::ProjectsTemplate};

pub async fn projects_handler(State(state): State<AppState>) -> Html<String> {
    let projects = get_all_projects(&state.db).await;
    let template = ProjectsTemplate::new(projects);
    Html(template.render().unwrap())
}
