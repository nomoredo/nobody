use std::{
    env,
    io::{self, Read, Write},
};

pub use constants::*;
pub mod constants;
pub use progress::*;
pub mod progress;
pub use tui::*;
pub mod tui;
pub use script::*;
pub mod script;
pub use minimo::*;





use crossterm::event::{read, KeyCode, KeyEvent, KeyModifiers};
use crossterm::{cursor, event, execute, terminal, ExecutableCommand};

pub fn execution_loop() {
    handle_args();
    loop {
        let options = get_options();
        // let selection = show::menu(&options);
        let selection = selection!("what do you want to do?", &options);

        divider();
        showln!(
            yellow_bold,
            "running ",
            cyan_bold,
            selection.name,
            white,
            " ..."
        );
        selection.run();
        showln!(
            green_bold,
            "completed running ",
            cyan_bold,
            selection.name
        );
        divider();
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
                opt.run();
                continue;
            }
        }
    }
}

