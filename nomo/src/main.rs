///! #nomo
/// a simple cli application that fecilitates creation and running 
/// of nomo scripts (.nomo files) 


use std::env;
use std::fs;
use std::io::{self, Write};
use std::path::Path;
use std::process::Command;

use termo::Printable;



fn main(){
    show_banner();
    execution_loop();

}




pub fn execution_loop(){
    loop{
        let selection = ask_for_selection();
        match selection {
            Some(selection) => {
               match selection.execute(){
                   Ok(_) => continue,
                   Err(e) => println!("Error: {}", e),
               }
            },
            None => execution_loop(),

            }
        }

    }

fn ask_for_selection() -> Option<Selection>{
    println!("What do you want to do?");
    println!("1. Create a new nomo script");
    println!("2. Run a nomo script");
    println!("3. Exit");
    print!("> ");
    io::stdout().flush().unwrap();
    let mut selection = String::new();
    io::stdin().read_line(&mut selection).unwrap();
    match selection.trim().parse::<u32>(){
        Ok(1) => Some(Selection::Create),
        Ok(2) => Some(Selection::Run),
        Ok(3) => Some(Selection::Exit),
        _ => None,
    }
}

enum Selection{
    Create,
    Run,
    Exit,
}

impl Selection{
    fn execute(&self) -> Result<(), String>{
        match self{
            Selection::Create => create_script(),
            Selection::Run => run_script(),
            Selection::Exit => std::process::exit(0),
        }
    }
}

fn create_script() -> Result<(), String>{
    print!("Enter the name of the script: ");
    io::stdout().flush().unwrap();
    let mut script_name = String::new();
    io::stdin().read_line(&mut script_name).unwrap();
    let script_name = script_name.trim();
    let script_path = format!("{}.nomo", script_name);
    if Path::new(&script_path).exists(){
        return Err(format!("Script {} already exists", script_name));
    }
    let mut script_file = fs::File::create(&script_path).unwrap();
    println!("Enter the script content. Press Ctrl+D when finished");
    io::stdout().flush().unwrap();
    io::copy(&mut io::stdin(), &mut script_file).unwrap();
    Ok(())
}

fn run_script() -> Result<(), String>{
    print!("Enter the name of the script: ");
    io::stdout().flush().unwrap();
    let mut script_name = String::new();
    io::stdin().read_line(&mut script_name).unwrap();
    let script_name = script_name.trim();
    let script_path = format!("{}.nomo", script_name);
    if !Path::new(&script_path).exists(){
        return Err(format!("Script {} does not exist", script_name));
    }
    let output = Command::new("sh")
        .arg(&script_path)
        .output()
        .expect("Failed to execute command");
    println!("{}", String::from_utf8_lossy(&output.stdout));
    Ok(())
}



fn show_banner(){
    termo::show::banner_vibrant(banner);
    termo::cursor::up(2);
    termo::cursor::right(16);
    "[white]WORKS FOR YOU 🙄 [/]".print();
    termo::cursor::down(1);
    // termo::show::div_vibrant();
    // show_banner_footer("WORKS FOR Y🌘U","1.2","incredimo");
}


// banner and footer has "works for you" in yellow
const banner :&str = r#"
                      __              __      
         ____  ____  / /_  ____  ____/ /_  __
        / __ \/ __ \/ __ \/ __ \/ __  / / / /
       / / / / /_/ / /_/ / /_/ / /_/ / /_/ / 
      /_/ /_/\____/_.___/\____/\__,_/\__, / 
————————————————————————————————————————,/———————
                                   /____/ 
                      
"#;

