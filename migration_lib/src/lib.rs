use std::env;

use anyhow::Result;
use refinery::Runner;
use tokio_postgres::NoTls;

pub async fn run_migrations_async(runner: Runner) -> Result<()> {
    match env::var("DB_URL") {
        Ok(url) => {
            let (mut client, connection) = tokio_postgres::connect(&url, NoTls).await?;
            tokio::spawn(async move { connection.await.unwrap() });
            runner.run_async(&mut client).await?;
            println!("database migrations applied");
            Ok(())
        }
        Err(err) => panic!("can't run migrations: {err:?}"),
    }
}
