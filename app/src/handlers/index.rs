use askama::Template;
use axum::response::{Html, IntoResponse};

use crate::views::index::IndexTemplate;

pub async fn index() -> impl IntoResponse {
    let page = IndexTemplate::new("FastTrack").render().unwrap();
    Html(page)
}
