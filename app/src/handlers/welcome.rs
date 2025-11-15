use askama::Template;
use axum::response::{Html, IntoResponse};

use crate::views::welcome::WelcomeTemplate;

pub async fn welcome_handler() -> impl IntoResponse {
    let template = WelcomeTemplate;
    Html(template.render().unwrap())
}
