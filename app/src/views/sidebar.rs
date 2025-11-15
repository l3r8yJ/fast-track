use askama::Template;

use crate::entities;

#[derive(Template)]
#[template(path = "sidebar_base.html")]
pub struct SidebarTemplate {
    pub projects: Vec<entities::projects::Model>,
}

impl SidebarTemplate {
    pub fn new(projects: Vec<entities::projects::Model>) -> Self {
        Self { projects }
    }
}
