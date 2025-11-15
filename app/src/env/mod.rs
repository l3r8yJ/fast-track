use core::panic;
use std::{env, path::Path};

use dotenvy::dotenv;

pub fn load() {
    let _ = dotenv();
    match env::var("APP_ENV") {
        Ok(env_name) => {
            let file_name = format!(".env.{}", env_name);
            if Path::new(&file_name).exists() {
                dotenvy::from_filename(&file_name).ok();
                println!("'{}' environment loaded", file_name);
            } else {
                panic!("Can't find '{}' file", file_name);
            }
        }
        Err(err) => {
            println!("Can't load environment: {err:?}, trying to use default .env");
            if let Err(err) = dotenvy::from_filename(".env") {
                panic!("Can't load default .env {err:?}")
            }
        }
    }
}
