use askama::Template;

#[derive(Template)]
#[template(path = "new_project_modal.html")]
pub struct NewProjectModalTemplate;

#[derive(Template)]
#[template(path = "create_project_success.html")]
pub struct CreateProjectSuccessTemplate;
