use std::sync::Arc;

pub use super::*;

pub fn show_banner() {
    BANNER.print(vibrant);
    // get virsion from cargo.toml
    let version = env!("CARGO_PKG_VERSION");
    FOOTER.print_positioned(-2, 6, in_white);
    reset_line();
    format!("🚀 {} ", version).print_positioned(-1, 42, in_gray);
    reset_line();
    "by github.com/incredimo 😎 a@xo.rs".print_positioned(-1, 0, in_gray);
    divider();
    //    divider();
    reset_line();
    // println!()
    // "by aghil.mohan for slickline team".print_positioned(-1, 0, in_gray);
    // reset_line();
    //    showln!(gray,"so that you can focus on the things that matter");
    //    divider();
}

pub fn get_options() -> Vec<Choice> {
    let mut opt = vec![];

    if is_not_installed() {
        opt.push(choice!("install", "install nobody", || install(), |args| args.contains(&String::from("install"))));
    }

    for script in get_scripts() {
        let script = script.clone();
        let scriptname = script.get_name();
        opt.push(choice!(script.get_name(), "run script",move || run_script(&script),move |args| args.contains(&scriptname)));
    }

    opt.push(choice!("create", "create new nobody script", || create_new(&vec![]), |args| args.contains(&String::from("create"))) );
    opt.push(choice!("help", "display help", || display_help(&vec![]), |args| args.contains(&String::from("help"))) );

    opt.push(choice!("exit", "exit nobody", || std::process::exit(0), |args| args.contains(&String::from("exit"))) );

    opt
}



pub fn is_not_installed() -> bool {
    //check if no is valid path in env
    let path = std::env::var("PATH").unwrap();
    let paths: Vec<&str> = path.split(":").collect();
    for p in paths {
        if p.contains("no") {
            return false;
        }
    }
    true
}

pub fn install() {
    showln!(white, "INSTALL nobody");
}

use walkdir::WalkDir;
//recusively get all the scripts in the current directory and subdirectories
pub fn get_scripts() -> Vec<NoScript> {
    let mut scripts = vec![];
    for entry in WalkDir::new(".").into_iter().filter_map(|e| e.ok()) {
        if entry.path().extension().unwrap_or_default() == "no" {
            match NoScript::from_file(entry.path()) {
                Ok(script) => {
                    scripts.push(script);
                }
                Err(e) => {
                    showln!(red, "error reading script: ", e);
                }
            }
        }
    }
    scripts
}

pub fn display_help(_args: &Vec<String>) {
    showln!(yellow, "HELP");
    "nomo is a simple cli application that fecilitates creation and running of nomo scripts (.nomo files)".print(in_white);
}

pub fn create_new(_args: &Vec<String>) {
    showln!(white, "CREATE NEW NOMO SCRIPT");
}

pub fn run_script(script: &NoScript)  {
    showln!(white, "RUNNING SCRIPT");
    script.run_script().unwrap();
}