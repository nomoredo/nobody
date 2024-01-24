use std::{
    env,
    io::{self, Read, Write},
};

pub use minimo::*;


pub use constants::*;
pub mod constants;

pub fn show_banner() {
    BANNER.print(vibrant);
    FOOTER.print_positioned(-1, 18, in_white);
    // get virsion from cargo.toml
    let version = env!("CARGO_PKG_VERSION");
    format!("{}", version).print_positioned(-2, 27, in_gray);

}

use crossterm::event::{read, KeyCode, KeyEvent, KeyModifiers};
use crossterm::{cursor, event, execute, terminal, ExecutableCommand};

pub fn execution_loop() {
    handle_args();
    loop {
        let options = get_options();
        let selection = show::menu(&options);

        if let Some(selected_option) = selection {
            selected_option.execute_with_args(&vec![]);
        }
    }
}

//handle args
//get options, see if any args are passed in that match
//if so, execute that option
pub fn handle_args() {
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
pub struct Choice {
    pub name: String,
    pub description: String,
    pub execute: fn(&Vec<String>),
    pub matches_if: fn(&Vec<String>) -> bool,
}

impl Pickable for Choice {
    fn get_title(&self) -> String {
        self.name.clone()
    }
    fn get_description(&self) -> String {
        self.description.clone()
    }
}

impl Choice {
    pub fn matches(&self, args: &Vec<String>) -> bool {
        (self.matches_if)(args)
    }

    pub fn execute_with_args(&self, args: &Vec<String>) {
        (self.execute)(args);
    }
}

pub fn get_options() -> Vec<Choice> {
    vec![
        Choice {
            name: String::from("install"),
            description: String::from("prepare this device to work as anybody"),
            execute: display_help,
            matches_if: |args| args.contains(&String::from("init")),
        },
        Choice {
            name: String::from("help"),
            description: String::from("show me what this is supposed to do"),
            execute: display_help,
            matches_if: |args| args.contains(&String::from("help")),
        },
        Choice {
            name: String::from("version"),
            description: String::from("display the version details of nothing"),
            execute: display_version,
            matches_if: |args| args.contains(&String::from("version")),
        },
        Choice {
            name: String::from("new"),
            description: String::from("create a new script in the current directory"),
            execute: create_new,
            matches_if: |args| args.contains(&String::from("new")),
        },
        Choice {
            name: String::from("run"),
            description: String::from("run a script from the current directory"),
            execute: run_script,
            matches_if: |args| args.contains(&String::from("run")),
        },
    ]
}

pub fn display_help(_args: &Vec<String>) {
    header!(info, "HELP");
    "nomo is a simple cli application that fecilitates creation and running of nomo scripts (.nomo files)".print(in_white);
}

pub fn display_version(_args: &Vec<String>) {
    header!(info, "VERSION");
    "nomo version 0.1.0".print(in_white);
}

pub fn create_new(_args: &Vec<String>) {
    header!(info, "CREATE NEW NOMO SCRIPT");
}

pub fn run_script(_args: &Vec<String>) {
    header!(info, "RUN NOMO SCRIPT");
}

pub mod show {
    use super::*;
    use crossterm::event::{read, KeyCode, KeyEvent, KeyEventKind, KeyEventState, KeyModifiers};
    use crossterm::{cursor, event, execute, terminal};


    // we will not clear  the screen. insted will draw the menu from the current cursor position
    // we will need to know the current cursor position so we can draw the menu from there
    pub fn menu(options: &[Choice]) -> Option<Choice> {
        //scroll down so that we have space to draw the menu
        for _ in 0..options.len()+2 {
            println!();
        }
         let (x, y) = cursor::position().unwrap();
         let mut corrected_y = y - options.len() as u16 - 2;
         //enable raw mode so we can read keys
            terminal::enable_raw_mode().unwrap();
            let mut selected_index = 0;
    
            loop {
                //move the cursor back to the original position and clear everything from there till the end of the screen
                execute!(
                    io::stdout(),
                    cursor::MoveTo(0, corrected_y),
                    terminal::Clear(terminal::ClearType::FromCursorDown)
                ).unwrap();

                execute!(
                    io::stdout(),
                    cursor::MoveTo(0, corrected_y),
                ).unwrap();

                   
// ╭── OPTIONS ─────────────── 
// │ 1 install 
// │ 2 help
// │ 3 version
// ╰──────────────────────────
                println!("╭── what would you like to do? ─────────────── ");
                for (index, option) in options.iter().enumerate() {
                    if index == selected_index {
                        //highlight the selected option magenta background and black text and description in white text
                        println!("│\x1b[43m\x1b[30m {} \x1b[0m \x1b[33m{}\x1b[0m", option.get_title(), option.get_description());
                    } else {
                        // normal options in white and description in dark gray
                        println!("│\x1b[37m {} \x1b[90m {}\x1b[0m", option.get_title(), option.get_description());
                    }
                    
                }
                println!("╰──────────────────────────");
    
                match read().unwrap() {
                    event::Event::Key(KeyEvent { code, modifiers, kind, state }) => match kind {
                        KeyEventKind::Press=> match code {
                            // up down keys to navigate and enter to select
                            KeyCode::Up => {
                                if selected_index > 0 {
                                    selected_index -= 1;
                                }
                            },
                            KeyCode::Down => {
                                if selected_index < options.len() - 1 {
                                    selected_index += 1;
                                }
                            },
                            KeyCode::Enter => {
                               //clear the menu and return the selected option
                                execute!(
                                    io::stdout(),
                                    cursor::MoveTo(0, corrected_y),
                                    terminal::Clear(terminal::ClearType::FromCursorDown)
                                ).unwrap();
                                terminal::disable_raw_mode().unwrap();
                                return options.get(selected_index).cloned();

                            },
                            KeyCode::Esc => {
                                terminal::disable_raw_mode().unwrap();
                                std::process::exit(0);
                            },
                            _ => {}
                        },
                        _ => {}
                    },
                    _ => {}
                }
                // corrected_y = corrected_y - 2;
            }
            

    }
}
