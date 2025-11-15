mod entities;
pub mod env;
pub mod handlers;
pub mod routes;
pub mod services;
pub mod state;
pub mod views;

use std::net::SocketAddr;

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt::init();
    env::load();
    // TODO: add pdd
    // let (tx, _rx) = broadcast::channel::<String>(16);
    let db_connection = services::connection::get().await;
    let app_state = state::AppState::new(db_connection);

    let app = routes::create_router(app_state);

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
