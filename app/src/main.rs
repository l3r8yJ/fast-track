pub mod db;
mod entities;
pub mod env;
pub mod pages;
pub mod templates;

use std::{net::SocketAddr, sync::Arc};

use axum::{Extension, Router, routing::get};
use tower_http::services::ServeDir;

use crate::pages::{index::index, projects::projects_handler};

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt::init();
    env::load::from_dotenv();
    // TODO: add pdd
    // let (tx, _rx) = broadcast::channel::<String>(16);
    let db_connection = Arc::new(db::connection::get().await);
    let app = Router::new()
        .nest_service("/static", ServeDir::new("./static"))
        .route("/", get(index))
        .route("/projects", get(projects_handler))
        .layer(Extension(db_connection));
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
