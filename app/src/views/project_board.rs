use askama::Template;

use crate::entities;

#[derive(Template)]
#[template(path = "project_board.html")]
pub struct ProjectBoardTemplate {
    pub project: entities::projects::Model,
    pub statuses: Vec<entities::statuses::Model>,
}
