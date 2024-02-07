use std::collections::HashMap;

pub use super::*;

const PATH_TO_NOBODY: &str = "C:\\repo\\nobody\\nobody";
const IMPORT_PATH: &str = "import 'package:nobody/references.dart';";

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

    fn create_work_dir(&self) -> std::io::Result<()> {
        let path = dirs::home_dir().unwrap().join(".nobody");
        let dir = path.join(self.get_name());
        std::fs::create_dir_all(dir)
    }

    fn create_pubspec_file(&self) -> std::io::Result<()> {
        let path = dirs::home_dir().unwrap().join(".nobody");
        let dir = path.join(self.get_name());
        let file = dir.join("pubspec.yaml");
        let mut file = std::fs::File::create(file)?;
        file.write_all(self.create_pubspec().as_bytes())?;
        Ok(())
    }

    fn create_pubspec(&self) -> String {
        let mut pubspec = "name: ".to_string();
        pubspec.push_str(&self.get_safe_name());
        pubspec.push_str("\ndescription: ");
        pubspec.push_str(&self.get_description());
        pubspec.push_str("\n\nenvironment:\n  sdk: '>=2.12.0 <3.0.0'\n\ndependencies:\n");
        pubspec.push_str("  nobody:\n");
        pubspec.push_str("    path: ");
        pubspec.push_str(PATH_TO_NOBODY);

        pubspec
    }

    fn get_safe_name(&self) -> String {
        let name = self.get_name();
        let mut safe_name = String::new();
        for c in name.chars() {
            if c.is_alphanumeric() {
                safe_name.push(c);
            }
        }
        safe_name
    }


    fn create_main_file(&self) -> std::io::Result<()> {
        let path = dirs::home_dir().unwrap().join(".nobody");
        let dir = path.join(self.get_name());
        let dir = dir.join("bin");
        std::fs::create_dir_all(dir.clone())?;
        let file = dir.join(format!("{}.dart", self.get_safe_name()));
        let mut file = std::fs::File::create(file)?;
        file.write_all(self.get_wrapped_code().as_bytes())?;
        Ok(())
    }

    fn get_wrapped_code(&self) -> String {
        let mut code = IMPORT_PATH.to_string();
        code.push_str("void main() async {\n await ");
        code.push_str(&self.get_code());
        code.push_str("\n}\n");
        code
    }

    pub fn create(&self) -> std::io::Result<()> {
        self.create_work_dir()?;
        self.create_pubspec_file()?;
        self.create_main_file()
    }

    pub fn run_script(&self) -> std::io::Result<()> {
        self.create()?;
        let path = dirs::home_dir().unwrap().join(".nobody");
        let dir = path.join(self.get_name());
        showln!(white, "running script: ", cyan, self.get_name());
        let std_out_pipe = std::process::Stdio::piped();
        let std_err_pipe = std::process::Stdio::piped();
        let output = std::process::Command::new("dart")
            .arg("run")
            .current_dir(dir)
            .stdout(std_out_pipe)
            .stderr(std_err_pipe)
            .output()?;


        let stdout = String::from_utf8_lossy(&output.stdout);
        let stderr = String::from_utf8_lossy(&output.stderr);
        if stdout.len() > 0 {
            showln!(green, "stdout: ", white,stdout);
        }
        if stderr.len() > 0 {
            showln!(red, "stderr: ",white, stderr);
        }
        Ok(())
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
