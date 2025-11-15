use sea_orm::{DatabaseConnection, EntityTrait, Set, ColumnTrait, QueryFilter};
use uuid::Uuid;

use crate::entities;

pub async fn get_all_projects(db: &DatabaseConnection) -> Vec<entities::projects::Model> {
    entities::projects::Entity::find()
        .filter(entities::projects::Column::ArchivedAt.is_null())
        .all(db)
        .await
        .unwrap_or_default()
}

pub async fn create_project(
    db: &DatabaseConnection,
    title: String,
    owner_id: Uuid,
) -> entities::projects::Model {
    let now = chrono::Utc::now().naive_utc();
    let project = entities::projects::ActiveModel {
        id: Set(Uuid::new_v4()),
        title: Set(title),
        owner_id: Set(owner_id),
        created_at: Set(now),
        updated_at: Set(now),
        archived_at: Set(None),
    };
    entities::projects::Entity::insert(project)
        .exec_with_returning(db)
        .await
        .expect("Failed to create project")
}
