use std::env;

use dotenvy::dotenv;
use sea_orm::{Database, DatabaseConnection};

pub async fn get() -> DatabaseConnection {
    dotenv().ok();
    let url = env::var("DB_URL").expect("DB_URL is required");
    Database::connect(&url)
        .await
        .expect("failed to connect to database")
}
