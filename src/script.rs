use std::{
    env,
    io::{ BufRead, BufReader },
    process::{ Command, Stdio },
    sync::mpsc::{ self, Receiver, Sender },
    thread,
    rc::Rc,
    cell::RefCell,
    borrow::Cow,
};

use deno_core::{ anyhow::Error, extension, Extension, JsRuntime, OpState, RuntimeOptions };
use minimo::{showln, Arc};
use tokio::runtime::Runtime;

use deno_ast::MediaType;
use deno_ast::ParseParams;
use deno_ast::SourceTextInfo;
use deno_core::error::AnyError;
use deno_core::op2;
use deno_core::ModuleLoadResponse;
use deno_core::ModuleSourceCode;

const PATH_TO_NOBODY: &str = ".nobody";

pub const TEMPLATE: &str =
    r#"
/// name: Sample Script
/// description: This is a sample script demonstrating the capabilities of Nobody.

import nobody from "nobody"; // support importing from known modules
import browser from "https://github.com/puppeteer/puppeteer/raw/main/puppeteer.ts"; // support importing from URLs


let a = 10;
let b = 20;
let c = a + b;
console.log(`The sum of ${a} and ${b} is ${c}`);

let name = await nobody.ask("What is your name?");
console.log(`Hello ${name}`);

let isAdult = await nobody.confirm("Are you an adult?");
console.log(`You are ${isAdult ? "an adult" : "not an adult"}`);

let options = [{name: "apple", color: "red"}, {name: "banana", color: "yellow"}];
let selected = await nobody.select("Select a fruit", options);
console.log(`You selected ${selected.name} which is ${selected.color}`);

let file = await files.create("test.txt");
file.content = "This is a test file";
await file.save();
"#;

#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct NoScript {
    pub name: String,
    pub description: String,
    pub path: String,
}

use nom::{
    branch::alt,
    bytes::complete::{ tag, take_until },
    character::complete::{ char, multispace0 },
    combinator::{ map, opt },
    multi::many0,
    sequence::{ preceded, terminated },
    IResult,
};

use crate::{runjs, TsModuleLoader, RUNTIME_SNAPSHOT};

impl NoScript {
    pub fn from_file(path: &std::path::Path) -> Option<Self> {
        let metadata = extract_metadata(path);
        if let Some(name) = metadata.get("name") {
            if let Some(description) = metadata.get("description") {
                Some(Self {
                    name: name.to_string(),
                    description: description.to_string(),
                    path: path.to_string_lossy().to_string(),
                })
            } else {
              Some(Self {
                  name: name.to_string(),
                  description: "".to_string(),
                  path: path.to_string_lossy().to_string(),
                })

            }
        } else {
            None
        }
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

    //run the script
    pub async fn run_script(&self) -> minimo::result::Result<()> {

        let main_module = deno_core::resolve_path(&self.path, env::current_dir()?.as_path())?;
        let mut js_runtime = deno_core::JsRuntime::new(deno_core::RuntimeOptions {
            module_loader: Some(Rc::new(TsModuleLoader::new())),
            startup_snapshot: Some(RUNTIME_SNAPSHOT),
            extensions: vec![runjs::init_ops()],
            ..Default::default()
        });

 
    
        let future = async move {
            let mod_id = js_runtime.load_main_es_module(&main_module).await?;
            let result = js_runtime.mod_evaluate(mod_id);
            js_runtime.run_event_loop(Default::default()).await?;
            result.await
          };


        future.await?;
 

        Ok(())

       
    }
}


//extract metadata from the script
//metadata is in the form of `///` ~ ` `? ~ [key]: ~ ` `? ~ [value]
fn extract_metadata(path: &std::path::Path) -> std::collections::HashMap<String, String> {
    let file = std::fs::File::open(path).unwrap();
    let mut reader = BufReader::new(file).lines();
    let mut metadata = std::collections::HashMap::new();

     while let Some(Ok(line)) = reader.next() {
        if let Some((key, value)) = extract_metadata_line(line) {
            metadata.insert(key, value);
        } else {
            break;
        }
    }


    metadata
}


fn extract_metadata_line(line: String) -> Option<(String, String)> {
 
    if line.starts_with("///") && line.contains(":") {
      let splits = line.trim_start_matches("///").split(":").collect::<Vec<_>>();
        if splits.len() == 2 {
            Some((splits[0].trim().to_string(), splits[1].trim().to_string()))
        } else {
            None
        }
    } else {
        None
    }
}


 