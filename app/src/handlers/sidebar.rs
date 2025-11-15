use askama::Template;
use axum::{extract::State, response::Html};

use crate::{services::projects::get_all_projects, state::AppState, views::sidebar::SidebarTemplate};

pub async fn sidebar_handler(State(state): State<AppState>) -> Html<String> {
    let projects = get_all_projects(&state.db).await;
    let template = SidebarTemplate::new(projects);
    Html(template.render().unwrap())
}
