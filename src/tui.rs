
use constants::*;
use tokio::spawn;
pub use super::*;

pub fn show_banner() {
    BANNER.vibrant().println();
    let version = env!("CARGO_PKG_VERSION");
    " NOBODY ".print_positioned(-3, 0, |x| x.style(yellowbg));
    "WORKS FOR YOU".print_positioned(-3, 1, |x| x.style(yellow));
    format!("VERSION 🚀 {} ", version).print_positioned(-3, 2, |x| x.style(gray));
    " BY AGHIL K MOHAN ".print_positioned(-3, 10, |x| x.style(gray));
    reset_line();
    STARTUP_INFO.in_gray().println();
}
use std::future::Future;
use std::pin::Pin;
use std::error::Error;
use std::sync::Arc;
use crossterm::{
    event::{self, KeyCode, KeyEvent, KeyEventKind},
    execute,
    terminal::{self, ClearType},
    cursor,
};
use std::io::{self, Write};
use minimo::{showln, show, yellow_bold, cyan_bold, white, gray_dim, white_bold, yellowbg};

pub struct AsyncChoice {
    name: String,
    description: String,
    action: Arc<dyn Fn() -> Pin<Box<dyn Future<Output = Result<(), Box<dyn Error>>>>> + Send + Sync>,
}

impl AsyncChoice {
    pub fn new<F, Fut>(name: impl Into<String>, description: impl Into<String>, action: F) -> Self
    where
        F: Fn() -> Fut + Send + Sync + 'static,
        Fut: Future<Output = Result<(), Box<dyn Error>>> + 'static,
    {
        Self {
            name: name.into(),
            description: description.into(),
            action: Arc::new(move || Box::pin(action())),
        }
    }

    pub fn get_name(&self) -> &str {
        &self.name
    }

    pub fn get_description(&self) -> &str {
        &self.description
    }

    pub async fn run(&self) -> Result<(), Box<dyn Error>> {
        (self.action)().await
    }
}

impl Clone for AsyncChoice {
    fn clone(&self) -> Self {
        Self {
            name: self.name.clone(),
            description: self.description.clone(),
            action: Arc::clone(&self.action),        }
    }
}

pub fn async_menu(message: impl Into<String>, options: &Vec<AsyncChoice>) -> Option<AsyncChoice> {
    let message = message.into();
    let mut filter = String::new();
    for _ in 0..options.len() + 2 {
        println!();
    }
    let (_, y) = cursor::position().unwrap();
    let corrected_y = y - options.len() as u16 - 2;
    terminal::enable_raw_mode().unwrap();
    let mut selected_index = 0;

    event::read().unwrap();

    loop {
        execute!(
            io::stdout(),
            cursor::MoveTo(0, corrected_y),
            terminal::Clear(ClearType::FromCursorDown)
        )
        .unwrap();

        execute!(io::stdout(), cursor::MoveTo(0, corrected_y)).unwrap();
        showln!(yellow_bold, "╭─ ", cyan_bold, message, yellow_bold, " ─");
        let filtered_options: Vec<&AsyncChoice> = options
            .iter()
            .filter(|o| {
                filter.is_empty()
                    || o.get_name().to_lowercase().contains(&filter.to_lowercase())
                    || o.get_description().to_lowercase().contains(&filter.to_lowercase())
            })
            .collect();

        for (index, option) in filtered_options.iter().enumerate() {
            if index == selected_index {
                showln!(
                    yellow_bold,
                    "│",
                    yellowbg,
                    format!(" {} ", option.get_name()),
                    white,
                    " ",
                    yellow_bold,
                    option.get_description()
                );
            } else {
                showln!(
                    yellow_bold,
                    "│",
                    white,
                    format!(" {} ", option.get_name()),
                    white,
                    " ",
                    gray_dim,
                    option.get_description()
                );
            }
        }
        show!(yellow_bold, "╰─→ ", white_bold, filter);
        io::stdout().flush().unwrap();
        match event::read().unwrap() {
            event::Event::Key(KeyEvent { code, kind, .. }) => match kind {
                KeyEventKind::Press => match code {
                    KeyCode::Up => {
                        if selected_index > 0 {
                            selected_index -= 1;
                        }
                    }
                    KeyCode::Down => {
                        if selected_index < filtered_options.len() - 1 {
                            selected_index += 1;
                        }
                    }
                    KeyCode::Enter => {
                        execute!(
                            io::stdout(),
                            cursor::MoveTo(0, corrected_y + 1),
                            terminal::Clear(ClearType::FromCursorDown)
                        )
                        .unwrap();
                        showln!(
                            yellow_bold,
                            "╰→ ",
                            white_bold,
                            filtered_options[selected_index].get_name()
                        );
                        terminal::disable_raw_mode().unwrap();
                        
                        return Some(filtered_options[selected_index].clone());
                    }
                    KeyCode::Char(c) => {
                        filter.push(c);
                        selected_index = 0; // Reset selection index on filter change
                    }
                    KeyCode::Backspace => {
                        filter.pop();
                        selected_index = 0; // Reset selection index on filter change
                    }
                    KeyCode::Esc => {
                        terminal::disable_raw_mode().unwrap();
                        return None;
                    }
                    _ => {}
                },
                _ => {}
            },
            _ => {}
        }
    }
}

pub fn get_options() -> Vec<AsyncChoice> {
    let mut opt = vec![];
    for script in get_scripts() {
        let script = Arc::new(script);
        opt.push(
            AsyncChoice::new(
                script.get_name(),
                script.get_description(),
                move || {
                    let script = Arc::clone(&script);
                    async move {
                        let result = script.run_script().await;
                        if let Err(e) = result {
                            showln!(yellow_bold, "Error: ", white, e);
                        }
                        Ok(())
                    }
                },
            )
        );
    }
    opt
}


pub fn get_scripts() -> Vec<NoScript> {
    let mut scripts = vec![];
   //recursively search for scripts that can be parserd from files
    let mut stack = vec![std::env::current_dir().unwrap()];
    while let Some(dir) = stack.pop() {
        for entry in std::fs::read_dir(dir).unwrap() {
            let entry = entry.unwrap();
            let path = entry.path();
            if path.is_dir() {
                stack.push(path);
            } else {
                if let Some(script) = NoScript::from_file(&path) {
                    scripts.push(script);
                }
            }
        }
    }
    scripts
}
