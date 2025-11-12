use askama::Template;

#[derive(Template)]
#[template(path = "index.html")]
pub struct IndexTemplate<'a> {
    pub title: &'a str,
}

impl<'a> IndexTemplate<'a> {
    pub fn new(title: &'a str) -> Self {
        Self { title }
    }
}
