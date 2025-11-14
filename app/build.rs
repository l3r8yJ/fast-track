use std::{fs, process::Command};

use refinery_macros::embed_migrations;

use crate::migrations::runner;

embed_migrations!("../migrations");

#[tokio::main]
async fn main() {
    println!("cargo:rerun-if-changed=../migrations");
    dotenvy::dotenv().ok();
    let runner = runner();
    migration_lib::run_migrations_async(runner)
        .await
        .expect("failed to run migrations");
    let _ = fs::remove_dir_all("src/entities");
    let generate_entities_status = Command::new("sea-orm-cli")
        .args([
            "generate",
            "entity",
            "-u",
            &std::env::var("DB_URL").expect("DB_URL not set"),
            "-o",
            "src/entities",
            "--entity-format",
            "dense",
        ])
        .status()
        .expect("Failed to generate entities");
    assert!(generate_entities_status.success(), "SeaORM code gen failed");
}
