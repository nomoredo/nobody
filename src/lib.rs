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
pub mod show;



pub use ctx::*;
pub mod ctx {
    use std::{collections::HashMap, sync::{Arc, Mutex, OnceLock}};
    pub use super::*;

    const CTX : OnceLock<Ctx> = OnceLock::new();

    pub fn get() -> Ctx {
        CTX.get_or_init(|| Ctx::new()).clone()
    }



    #[derive(Debug, Clone)]
    pub struct Ctx {
        pub data: Arc<Mutex<HashMap<String, Value>>>, 
    }

    impl Ctx {
        pub fn new() -> Self {
            Self {
                data: Arc::new(Mutex::new(HashMap::new())),
            }
        }

        pub fn set<T: Into<Value>>(&self, key: impl Into<String>, value: T) {
            self.data.lock().unwrap().insert(key.into(), value.into());
        }

        pub fn get<T: From<Value>>(&self, key:  impl Into<String>) -> T {
            let key = key.into();
            self.data.lock().unwrap().get(&key).map(|v| v.clone().into()).unwrap_or(T::from(Value::Null))
        }

        pub fn remove(&self, key: &str) -> Option<Value> {
            self.data.lock().unwrap().remove(key)
        }

        pub fn clear(&self) {
            self.data.lock().unwrap().clear();
        }
    }

    impl Default for Ctx {
        fn default() -> Self {
            Self::new()
        }
    }

    pub trait Task {
        fn act(&self, ctx: &Ctx);
        fn get_name(&self) -> String;
        fn get_description(&self) -> String;
        fn get_length(&self) -> usize;
        fn get_actions(&self) -> Vec<Box<dyn Task>>;
        fn enumerate_actions(&self) -> Vec<(usize, Box<dyn Task>)> {
            self.get_actions().into_iter().enumerate().collect()
        }
    }

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
            showln!(
                yellow_bold,
                "running ",
                cyan_bold,
                selected_option.name,
                white,
                " ..."
            );
            selected_option.run();
            showln!(
                green_bold,
                "completed running ",
                cyan_bold,
                selected_option.name
            );
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
                opt.run();
                continue;
            }
        }
    }
}

