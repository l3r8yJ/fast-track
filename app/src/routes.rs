use axum::{Router, routing::get};
use tower_http::services::ServeDir;

use crate::handlers::{
    index::index,
    new_project::{new_project_modal_handler, create_project_handler},
    project_board::project_board_handler,
    projects::projects_handler,
    sidebar::sidebar_handler,
    status_column::status_column_handler,
    welcome::welcome_handler,
};
use crate::state::AppState;

pub fn create_router(state: AppState) -> Router {
    Router::new()
        .nest_service("/static", ServeDir::new("./app/static"))
        .route("/", get(index))
        .route("/sidebar", get(sidebar_handler))
        .route("/board", get(welcome_handler))
        .route("/projects", get(projects_handler))
        .route("/projects/new", get(new_project_modal_handler))
        .route("/projects/create", axum::routing::post(create_project_handler))
        .route("/projects/{id}/board", get(project_board_handler))
        .route("/projects/{project_id}/status/{status_id}", get(status_column_handler))
        .with_state(state)
}
