use askama::Template;
use sea_orm::prelude::Uuid;

#[derive(Template)]
#[template(path = "projects.html")]
pub struct ProjectTemplate<'a> {
    pub id: &'a Uuid,
    pub title: &'a str,
}

impl<'a> ProjectTemplate<'a> {
    pub fn new(id: &'a Uuid, title: &'a str) -> Self {
        Self { id, title }
    }
}
