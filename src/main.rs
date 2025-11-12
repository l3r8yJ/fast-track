pub mod db;
mod entities;
pub mod env;
pub mod pages;
pub mod templates;

use std::net::SocketAddr;

use axum::{Router, routing::get};
use tower_http::services::ServeDir;

use crate::{db::migrate::run_migrations, pages::index::index};

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt::init();
    env::load::from_dotenv();
    // TODO: run migrations during the build
    // TODO: run codegen during the build
    run_migrations().await.expect("Can't apply migrations");
    // let (tx, _rx) = broadcast::channel::<String>(16);
    let app = Router::new()
        .nest_service("/static", ServeDir::new("./static"))
        .route("/", get(index));
    let listener = tokio::net::TcpListener::bind("127.0.0.1:3000")
        .await
        .unwrap();
    axum::serve(
        listener,
        app.into_make_service_with_connect_info::<SocketAddr>(),
    )
    .await
    .unwrap();
}
