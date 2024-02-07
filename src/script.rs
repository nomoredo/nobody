use std::collections::HashMap;

pub use super::*;


#[derive(Clone, Debug, PartialEq, Eq)]
pub struct NoScript {
    path: String,
    meta: NoMeta,
    code: String,
}

impl NoScript {

    pub fn get_meta(&self) -> &NoMeta {
        &self.meta
    }

    pub fn get_code(&self) -> &str {
        &self.code
    }

    pub fn get_name(&self) -> String {
       match self.meta.data.get("name") {
           Some(Value::String(name)) =>  {
             if name.len() > 0 {
                name.clone()
             } else {
                get_name_from_path(&self.path)
             }
           }
           _ => {
              get_name_from_path(&self.path)
           }
       }
    }

    pub fn get_description(&self) -> String {
        match self.meta.data.get("description") {
            Some(Value::String(description)) => description.clone(),
            _ => {
                "".to_string()
            }
        }
    }

    pub fn from_file(path: &std::path::Path) -> Result<Self, std::io::Error> {
        let content = std::fs::read_to_string(path)?;
        let (rest,mut script) = parse_noscript(&content).unwrap();
        script.path = path.to_str().unwrap().to_string();
        Ok(script)
    }
}

fn get_name_from_path(path: &str) -> String {
    let parts: Vec<&str> = path.split("/").collect();
    let last = parts.last().unwrap();
    let parts: Vec<&str> = last.split(".").collect();
    parts[0].to_string()
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct NoMeta {
    data: HashMap<String, Value>,
}

#[derive(Clone, Debug )]
pub enum Value {
    Null,
    String(String),
    Number(f32),
    List(Vec<Value>),
    Map(HashMap<String, Value>),
}

impl PartialEq for Value {
    fn eq(&self, other: &Self) -> bool {
        match (self, other) {
            (Value::Null, Value::Null) => true,
            (Value::String(a), Value::String(b)) => a == b,
            (Value::Number(a), Value::Number(b)) => a == b,
            (Value::List(a), Value::List(b)) => a == b,
            (Value::Map(a), Value::Map(b)) => a == b,
            _ => false,
        }
    }
}

impl Eq for Value {}
 

 
pub use parser::*;
pub mod parser;
