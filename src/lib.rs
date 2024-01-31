use std::{
    env,
    io::{self, Read, Write},
};



pub use constants::*;
pub mod constants;

pub use minimo::*;


pub fn show_banner() {
    BANNER.print(vibrant);
    // get virsion from cargo.toml
    let version = env!("CARGO_PKG_VERSION");
    FOOTER.print_positioned(-2, 22, in_white);
    format!("{}", version).print_positioned(-2, 28, in_gray);

//    divider();
reset_line();
    "by aghil.mohan for slickline team".print_positioned(-1, 0, in_gray);
    reset_line();
   showln!(gray,"so that you can focus on the things that matter");
   divider();

}

use crossterm::event::{read, KeyCode, KeyEvent, KeyModifiers};
use crossterm::{cursor, event, execute, terminal, ExecutableCommand};

pub fn execution_loop() {
    handle_args();
    loop {
        let options = get_options();
        // let selection = show::menu(&options);
        let selection = show::menu(&options);

        if let Some(selected_option) = selection {
            divider();
            showln!(yellow_bold,"running ",cyan_bold, selected_option.name, white, " ...");
            selected_option.execute_with_args(&vec![]);
            showln!(green_bold,"completed running ",cyan_bold, selected_option.name);
            divider();
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
        Choice {
            name: String::from("exit"),
            description: String::from("exit nomo"),
            execute: |args| {
                showln!(white, "exiting nomo...");
                std::process::exit(0);
            },
            matches_if: |args| args.contains(&String::from("exit")),
        },
    ]
}

pub fn display_help(_args: &Vec<String>) {
    showln!(yellow, "HELP");
    "nomo is a simple cli application that fecilitates creation and running of nomo scripts (.nomo files)".print(in_white);
}



pub fn create_new(_args: &Vec<String>) {
 showln!(white, "CREATE NEW NOMO SCRIPT");
}

pub fn run_script(_args: &Vec<String>) {
    showln!(white, "RUN NOMO SCRIPT");  
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
            
            //clear everything from the current cursor position till the end of the screen
     
            
    }
}
