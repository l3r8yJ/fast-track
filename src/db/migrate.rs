use std::env;

use anyhow::Result;
use refinery::embed_migrations;
use tokio_postgres::NoTls;

use crate::db::migrate::migrations::runner;

embed_migrations!("./migrations");

pub async fn run_migrations() -> Result<()> {
    match env::var("DB_URL") {
        Ok(url) => {
            let (mut client, connection) = tokio_postgres::connect(&url, NoTls).await?;
            tokio::spawn(async move { connection.await.unwrap() });
            runner().run_async(&mut client).await?;
            println!("Database migrations applied");
            Ok(())
        }
        Err(err) => panic!("Can't run migrations: {err:?}"),
    }
}
