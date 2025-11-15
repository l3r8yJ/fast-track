use askama::Template;

#[derive(Template)]
#[template(path = "welcome_board.html")]
pub struct WelcomeTemplate;
