use std::{
    borrow::Cow, cell::RefCell, env, io::{BufRead, BufReader, Read}, process::{Command, Stdio}, rc::Rc, sync::mpsc::{self, Receiver, Sender}, thread
};

use deno_core::{
    anyhow::Error, extension, Extension, JsRuntime, OpState, RuntimeOptions
};
use minimo::Arc;
use tokio::runtime::Runtime;

use deno_ast::MediaType;
use deno_ast::ParseParams;
use deno_ast::SourceTextInfo;
use deno_core::error::AnyError;
use deno_core::op2;
use deno_core::ModuleLoadResponse;
use deno_core::ModuleSourceCode;

const PATH_TO_NOBODY: &str = ".nobody";

pub const TEMPLATE: &str = r#"
/// name: Sample Script
/// description: This is a sample script demonstrating the capabilities of Nobody.

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
    pub content: String,
    pub description: String,
}

use nom::{
    branch::alt,
    bytes::complete::{tag, take_until},
    character::complete::{char, multispace0},
    combinator::{map, opt},
    multi::many0,
    sequence::{preceded, terminated},
    IResult,
};





impl NoScript {
    pub fn from_file(path: &std::path::Path) -> Result<Self, Error> {
        let content = std::fs::read_to_string(path)?;
        let (_, script) = parse_script(&content).unwrap();
        Ok(script)
    }


 

    pub fn get_name(&self) -> String {
        self.name.clone()
    }

    pub fn get_description(&self) -> String {
        self.description.clone()
    }

    pub fn get_description_trimmed(&self, len: usize) -> String {
        if self.description.len() > len {
            format!("{}...", &self.description[..len])
        } else {
            self.description.clone()
        }
    }


    //run the script
    pub fn run_script(&self) -> minimo::result::Result<()> {
        let mut runtime = deno_core::JsRuntime::new(RuntimeOptions {
            module_loader: Some( Rc::new(TsModuleLoader)),
            extensions: vec![runjs::init_ops_and_esm(), ],
            ..Default::default()
        });

        let content = self.content.clone();
        runtime.execute_script( "runtime.js", content)?;
        Ok(())
    
    }

}

//parse the script
// try to match `///` followed by `name` followed by `:` and then the name of the script
// similarly for `description` and then the description of the script
// everything else is considered as the script content
fn parse_script(input: &str) -> IResult<&str, NoScript> {
    let (input, name) = parse_name(input)?;
    let (input, description) = parse_description(input)?;
    let (input, content) = parse_content(input)?;
    Ok((input, NoScript { name, description, content }))
}


fn parse_name(input: &str) -> IResult<&str, String> {
    let (input, _) = tag("///")(input)?;
    let (input, _) = multispace0(input)?;
    let (input, _) = tag("name:")(input)?;
    let (input, name) = take_until("\n")(input)?;
    let (input, _) = multispace0(input)?;
    Ok((input, name.trim().to_string()))
}

fn parse_description(input: &str) -> IResult<&str, String> {
    let (input, _) = tag("///")(input)?;
    let (input, _) = multispace0(input)?;
    let (input, _) = tag("description:")(input)?;
    let (input, description) = take_until("\n")(input)?;
    let (input, _) = multispace0(input)?;
    Ok((input, description.trim().to_string()))
}

fn parse_content(input: &str) -> IResult<&str, String> {
    let (input, content) = take_until("\n")(input)?;
    Ok((input, content.trim().to_string()))
}





#[op2(async)]
#[string]
async fn op_read_file(#[string] path: String) -> Result<String, AnyError> {
    let contents = tokio::fs::read_to_string(path).await?;
    Ok(contents)
}

#[op2(async)]
#[string]
async fn op_write_file(#[string] path: String, #[string] contents: String) -> Result<(), AnyError> {
    tokio::fs::write(path, contents).await?;
    Ok(())
}

#[op2(async)]
#[string]
async fn op_fetch(#[string] url: String) -> Result<String, AnyError> {
    let body = reqwest::get(url).await?.text().await?;
    Ok(body)
}

#[op2(async)]
async fn op_set_timeout(delay: f64) -> Result<(), AnyError> {
    tokio::time::sleep(std::time::Duration::from_millis(delay as u64)).await;
    Ok(())
}

#[op2(fast)]
fn op_remove_file(#[string] path: String) -> Result<(), AnyError> {
    std::fs::remove_file(path)?;
    Ok(())
}

struct TsModuleLoader;

impl deno_core::ModuleLoader for TsModuleLoader {
    fn resolve(
        &self,
        specifier: &str,
        referrer: &str,
        _kind: deno_core::ResolutionKind,
    ) -> Result<deno_core::ModuleSpecifier, AnyError> {
        deno_core::resolve_import(specifier, referrer).map_err(|e| e.into())
    }

    fn load(
        &self,
        module_specifier: &deno_core::ModuleSpecifier,
        _maybe_referrer: Option<&reqwest::Url>,
        _is_dyn_import: bool,
        _requested_module_type: deno_core::RequestedModuleType,
    ) -> ModuleLoadResponse {
        let module_specifier = module_specifier.clone();

        let module_load = Box::pin(async move {
            let path = module_specifier.to_file_path().unwrap();

            let media_type = MediaType::from_path(&path);
            let (module_type, should_transpile) = match MediaType::from_path(&path) {
                MediaType::JavaScript | MediaType::Mjs | MediaType::Cjs => {
                    (deno_core::ModuleType::JavaScript, false)
                }
                MediaType::Jsx => (deno_core::ModuleType::JavaScript, true),
                MediaType::TypeScript
                | MediaType::Mts
                | MediaType::Cts
                | MediaType::Dts
                | MediaType::Dmts
                | MediaType::Dcts
                | MediaType::Tsx => (deno_core::ModuleType::JavaScript, true),
                MediaType::Json => (deno_core::ModuleType::Json, false),
                _ => panic!("Unknown extension {:?}", path.extension()),
            };

            let code = std::fs::read_to_string(&path)?;
            let code = if should_transpile {
                let parsed = deno_ast::parse_module(ParseParams {
                    specifier: module_specifier.clone(),
                                  media_type,
                    capture_tokens: false,
                    scope_analysis: false,
                    maybe_syntax: None,
                    text:  code.into(),
                })?;
                
                  panic!("parsed: {:?}", parsed);
            } else {
                code
            };
            let module = deno_core::ModuleSource::new(
                module_type,
                ModuleSourceCode::String(code.into()),
                &module_specifier,
                None,
            );
            Ok(module)
        });

        ModuleLoadResponse::Async(module_load)
    }
}

extension! {
    runjs,
    ops = [
        op_read_file,
        op_write_file,
        op_remove_file,
        op_fetch,
        op_set_timeout,
    ]
}

 