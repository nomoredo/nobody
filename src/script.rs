use std::{
    collections::HashMap,
    io::{BufRead, BufReader},
    process::{Command, Stdio},
    sync::mpsc::{self, Receiver, Sender},
    thread,
};

use deno_core::{JsRuntime, RuntimeOptions};

pub use super::*;

const PATH_TO_NOBODY: &str = "C:\\repo\\nobody\\nobody";
const IMPORT_PATH: &str = "import 'package:nobody/references.dart';";


#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct NoScript {
    name: String,
    content: String,
}

impl NoScript {
    pub fn from_file(path: &std::path::Path) -> Result<Self, std::io::Error> {
        let name = path.file_name().unwrap().to_str().unwrap().to_string();
        let content = std::fs::read_to_string(path)?;
        Ok(Self { name, content })
    }

    pub fn get_name(&self) -> String {
        self.name.clone()
    }

    pub fn get_content(&self) -> Result<String, std::io::Error> {
        Ok(self.content.clone())
    }

    pub fn run_script(&self) -> Result<(), deno_core::error::AnyError> {
        let mut js_runtime = JsRuntime::new(RuntimeOptions::default());
        js_runtime.execute_script("<anon>", self.content.clone())?;
        Ok(())
    }
}
