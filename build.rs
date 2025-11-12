use std::{fs, process::Command};

fn main() {
    // println!("cargo:rerun-if-changed=migrations");
    // let migrations_status = Command::new("cargo")
    //     .args(["run", "--bin", "migration_runner"])
    //     .status()
    //     .expect("failed to run migrations");
    // assert!(migrations_status.success(), "migrations failed");
    println!("cargo:rerun-if-changed=migrations");
    dotenvy::dotenv().ok();
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
