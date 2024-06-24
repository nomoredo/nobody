use std::sync::Arc;
use constants::*;
pub use super::*;

pub fn show_banner() {
    BANNER.vibrant().println();
    let version = env!("CARGO_PKG_VERSION");
    " NOBODY ".print_positioned(-3, 0, |x|x.style(yellowbg));
    "WORKS FOR YOU".print_positioned(-3, 1, |x|x.style(yellow));
    format!("VERSION 🚀 {} ", version).print_positioned(-3, 2, |x|x.style(gray));
    " BY AGHIL K MOHAN ".print_positioned(-3, 10, |x|x.style(gray));
    reset_line();
    STARTUP_INFO.in_gray().println();
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

    opt.push(choice!("create", "create new script", || create_new(&vec![]), |args| args.contains(&String::from("create"))) );
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

use rand::random;
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
    "nobody is a simple cli application that fecilitates creation and running of nomo scripts (.nomo files)".in_white().print();
}

pub fn create_new(_args: &Vec<String>) {
    showln!(white, "CREATE NEW NOMO SCRIPT");
}

pub fn run_script(script: &NoScript)  {
    // showln!(white, "RUNNING SCRIPT");
    script.run_script().unwrap();
}