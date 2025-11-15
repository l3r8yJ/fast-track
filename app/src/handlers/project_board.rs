use askama::Template;
use axum::{
    extract::{Path, State},
    response::Html,
};
use sea_orm::{EntityTrait, ColumnTrait, QueryFilter};
use uuid::Uuid;

use crate::entities;
use crate::state::AppState;
use crate::views::project_board::ProjectBoardTemplate;

pub async fn project_board_handler(
    State(state): State<AppState>,
    Path(project_id): Path<Uuid>,
) -> Html<String> {
    // Fetch project and statuses from database
    let project = entities::projects::Entity::find_by_id(project_id)
        .one(&*state.db)
        .await
        .expect("Failed to fetch project")
        .expect("Project not found");

    let statuses = entities::statuses::Entity::find()
        .filter(entities::statuses::Column::ProjectId.eq(project_id))
        .all(&*state.db)
        .await
        .expect("Failed to fetch statuses");

    let template = ProjectBoardTemplate { project, statuses };
    Html(template.render().unwrap())
}
