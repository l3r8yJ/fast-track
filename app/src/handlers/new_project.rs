use askama::Template;
use axum::{
    extract::{State, Form},
    response::Html,
};
use serde::Deserialize;
use uuid::Uuid;

use crate::services::projects::create_project;
use crate::state::AppState;
use crate::views::new_project::{NewProjectModalTemplate, CreateProjectSuccessTemplate};

#[derive(Deserialize)]
pub struct CreateProjectForm {
    title: String,
}

pub async fn new_project_modal_handler() -> Html<String> {
    let template = NewProjectModalTemplate;
    Html(template.render().unwrap())
}

pub async fn create_project_handler(
    State(state): State<AppState>,
    Form(form): Form<CreateProjectForm>,
) -> Html<String> {
    // TODO: Get actual user ID from auth/session
    let owner_id = Uuid::nil();
    let _project = create_project(&state.db, form.title, owner_id).await;
    let template = CreateProjectSuccessTemplate;
    Html(template.render().unwrap())
}
