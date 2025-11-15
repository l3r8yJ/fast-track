use askama::Template;

use crate::entities;

#[derive(Template)]
#[template(path = "projects.html")]
pub struct ProjectsTemplate {
    pub projects: Vec<entities::projects::Model>,
}

impl ProjectsTemplate {
    pub fn new(projects: Vec<entities::projects::Model>) -> Self {
        Self { projects }
    }
}
