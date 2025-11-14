use sea_orm::{DatabaseConnection, EntityTrait};

use crate::entities;

pub async fn get_all_projects(db: &DatabaseConnection) -> Vec<entities::projects::Model> {
    entities::projects::Entity::find()
        .all(db)
        .await
        .expect("Failed to load projects")
}
