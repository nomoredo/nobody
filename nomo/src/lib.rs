

use std::{io::{self, Write, Read}, env};

pub use c::*;
pub mod c;


pub use constants::*;
pub mod constants;




pub fn show_banner(){
    BANNER.print(vibrant);
    FOOTER.print_positioned(-2,4,in_yellow);
}



pub fn execution_loop(){
    handle_args();
    loop {
        let options = get_options();
        let selection = ask_for_selection(options);
    }
}


//handle args
//get options, see if any args are passed in that match
//if so, execute that option
pub fn handle_args(){
    let args: Vec<String> = env::args().collect();
    if args.len() > 1 {
        let options = get_options();
        for opt in options {
            if opt.matches(&args) {
                opt.execute_with_args(&args);
                continue;
            }
        }
    }
}


#[derive(Debug, Clone)]
pub struct Option {
    pub name: String,
    pub description: String,
    pub execute: fn(&Vec<String>),
    pub matches_if: fn(&Vec<String>) -> bool,
}

impl Pickable for Option {
    fn get_title(&self) -> String {
        self.name.clone()
    }
    fn get_description(&self) -> String {
        self.description.clone()
    }
}


impl Option {
    pub fn matches(&self, args: &Vec<String>) -> bool {
        (self.matches_if)(args)
    }

    pub fn execute_with_args(&self, args: &Vec<String>) {
        (self.execute)(args);
    }
}

pub fn get_options() -> Vec<Option> {
    vec![
        Option {
            name: String::from("help"),
            description: String::from("show help"),
            execute: display_help,
            matches_if: |args| args.contains(&String::from("help")),
        },
        Option {
            name: String::from("version"),
            description: String::from("show version"),
            execute: display_version,
            matches_if: |args| args.contains(&String::from("version")),
        },
        Option {
            name: String::from("new"),
            description: String::from("create a new nomo script"),
            execute: create_new,
            matches_if: |args| args.contains(&String::from("new")),
        },
        Option {
            name: String::from("run"),
            description: String::from("run a nomo script"),
            execute: run_script,
            matches_if: |args| args.contains(&String::from("run")),
        },
    ]
}


pub fn display_help(_args: &Vec<String>) {
header!(info,"HELP");
"nomo is a simple cli application that fecilitates creation and running of nomo scripts (.nomo files)".print(in_white);
}

pub fn display_version(_args: &Vec<String>) {
header!(info,"VERSION");
"nomo version 0.1.0".print(in_white);
}

pub fn create_new(_args: &Vec<String>) {
header!(info,"CREATE NEW NOMO SCRIPT");
}

pub fn run_script(_args: &Vec<String>) {
header!(info,"RUN NOMO SCRIPT");
}
