use askama::Template;
use axum::{
    extract::{Path, State, Query},
    response::Html,
};
use sea_orm::{EntityTrait, ColumnTrait, QueryFilter, QueryOrder, QuerySelect};
use serde::Deserialize;
use uuid::Uuid;

use crate::entities;
use crate::state::AppState;

#[derive(Template)]
#[template(path = "status_column.html")]
pub struct StatusColumnTemplate {
    pub issues: Vec<entities::issues::Model>,
}

#[derive(Deserialize)]
pub struct PaginationQuery {
    #[serde(default = "default_limit")]
    limit: u64,
}

fn default_limit() -> u64 {
    50
}

pub async fn status_column_handler(
    State(state): State<AppState>,
    Path((project_id, status_id)): Path<(Uuid, Uuid)>,
    Query(params): Query<PaginationQuery>,
) -> Html<String> {
    // Fetch limited issues for this status and project
    let issues = entities::issues::Entity::find()
        .filter(entities::issues::Column::StatusId.eq(status_id))
        .filter(entities::issues::Column::ProjectId.eq(project_id))
        .filter(entities::issues::Column::ArchivedAt.is_null())
        .order_by_desc(entities::issues::Column::CreatedAt)
        .limit(params.limit)
        .all(&*state.db)
        .await
        .unwrap_or_default();

    let template = StatusColumnTemplate { issues };
    Html(template.render().unwrap())
}
