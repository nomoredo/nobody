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
            println!("╰─────────────────────────────────────────────────");

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
