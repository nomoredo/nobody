use std::{
    env,
    io::{BufRead, BufReader},
    path::Path,
    rc::Rc,
    collections::HashMap,
    fs::File,
};
use deno_core::{
    error::AnyError,
    ModuleSpecifier,
    JsRuntime,
    RuntimeOptions,
};
use minimo::result::Result;
use tokio::task::LocalSet;
use crate::{runjs, TsModuleLoader, RUNTIME_SNAPSHOT};

#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct NoScript {
    pub name: String,
    pub description: String,
    pub path: String,
}

impl NoScript {
    pub fn from_file(path: &Path) -> Option<Self> {
        let metadata = extract_metadata(path);
        metadata.get("name").map(|name| Self {
            name: name.to_string(),
            description: metadata.get("description").cloned().unwrap_or_default(),
            path: path.to_string_lossy().to_string(),
        })
    }

    pub fn get_name(&self) -> String {
        self.name.clone()
    }

    pub fn get_description(&self) -> String {
        self.description.clone()
    }

    pub fn get_description_truncated(&self, max_length: usize) -> String {
        if self.description.len() > max_length {
            format!("{}...", &self.description[..max_length])
        } else {
            self.description.clone()
        }
    }

    pub async fn run_script(&self) -> Result<()> {
        let main_module = deno_core::resolve_path(&self.path, env::current_dir()?.as_path())?;
        let module_loader = Rc::new(TsModuleLoader::new());

        let mut js_runtime = JsRuntime::new(RuntimeOptions {
            module_loader: Some(module_loader),
            startup_snapshot: Some(RUNTIME_SNAPSHOT),
            extensions: vec![runjs::init_ops()],
            custom_module_evaluation_cb: None,
            inspector: true,
            ..Default::default()
        });

        let mod_id = js_runtime.load_main_es_module(&main_module).await?;
        let result = js_runtime.mod_evaluate(mod_id);
        
        js_runtime.run_event_loop(Default::default()).await?;
        
        result.await?;
        Ok(())
    }
}

fn extract_metadata(path: &Path) -> HashMap<String, String> {
    File::open(path)
        .map(|file| {
            BufReader::new(file)
                .lines()
                .take_while(|line| line.as_ref().map(|l| l.starts_with("///")).unwrap_or(false))
                .filter_map(|line| line.ok().and_then(extract_metadata_line))
                .collect()
        })
        .unwrap_or_default()
}

fn extract_metadata_line(line: String) -> Option<(String, String)> {
    let line = line.trim_start_matches("///").trim();
    line.split_once(':').map(|(key, value)| (key.trim().to_string(), value.trim().to_string()))
}

pub fn get_scripts() -> std::io::Result<Vec<NoScript>> {
    let mut scripts = Vec::new();
    let mut stack = vec![env::current_dir()?];
   
    while let Some(dir) = stack.pop() {
        for entry in std::fs::read_dir(dir)? {
            let entry = entry?;
            let path = entry.path();
           
            if path.is_dir() {
                stack.push(path);
            } else if let Some(extension) = path.extension() {
                if ["js", "ts", "no"].contains(&extension.to_str().unwrap_or("")) {
                    if let Some(script) = NoScript::from_file(&path) {
                        scripts.push(script);
                    }
                }
            }
        }
    }
   
    Ok(scripts)
}