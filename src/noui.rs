
use crossterm::{cursor, execute, terminal, ExecutableCommand};
use std::io::{self, Read, Write};

use std::{
    fmt::{Display, Formatter, Result},
    io::{self, Read, Write},
};

///! # noui
///! terminal ui library combining alot of things from here and there
///! and making it slightly easier to play with
///! below are the key functionalities provided by this library
/// - show! macro - print text with color and style e.g. `show!(red,"hello",green,"world")` prints "hello" in red and "world" in green
/// - showln! macro - same as show! but with a newline at the end
/// - paragraph! macro - same as showln! but automatically chops the text and wraps it in a paragraph. the width of the paragraph is 65 characters by default. when the text is longer than 65 characters, it is wrapped in a paragraph
/// - render! macro - same as showln! but automatically chops the text and wraps it in a paragraph. the width of the paragraph is 65 characters by default. when the text is longer than 65 characters, it is wrapped in a paragraph
/// - ask_for_selection - interactively ask for a selection from a list of options. user can type in a number or press up/down arrows to select and press enter to confirm. user can also type in a term to filter options by that term. press esc to break out of the loop
/// - enable_raw_mode - enable raw mode on stdin (no external dependencies)
/// - disable_raw_mode - disable raw mode on stdin (no external dependencies)
/// - get_key - get the next key from stdin
/// - Pickable - a trait that can be used to implement a pickable item
/// - Printable - supports calling `print`, `write`, `render` and `style` on any type e.g. `"hello".print(in_red)`
/// - Choice - represents a choice in a menu that the user can select. provides a name, description, execute function and a matches_if function.
/// 
/// # Example
/// ```rust
/// use noui::*;
/// 
/// fn main() {
///    show!(red,"hello",green,"world");
///   showln!(red,"hello",green,"world");
///     paragraph!(white,"this is a long text that will be wrapped in a paragraph after 65 chars",green,"this is another long text that will be appended to the first one and wrapped in a paragraph");
///    render!(white,"this is a long text that will be wrapped in a paragraph after 65 chars",green,"this is another long text that will be appended to the first one and wrapped in a paragraph");
///   let options = vec![Choice{
///       name:"hello".to_string(),
///      description:"world".to_string(),
///     execute:|args:&Vec<String>|{
///        println!("hello world");
///   },
///    matches_if:|args:&Vec<String>|{
///       args.len() > 1 && args[1] == "hello"
///  }
/// }];
/// let selection = ask_for_selection(options);
/// }
/// ```

/// # Choice
/// represents a choice in a menu that the user can select
/// provides a name, description, execute function and a matches_if function
/// the matches_if function is used to determine if the choice matches the args
/// the execute function is executed if the choice matches the args
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

pub struct CStyle<'a>(&'a str);

impl<'a> Display for CStyle<'a> {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
        f.write_str(self.0)
    }
}

impl<'a> std::ops::Add<&'a str> for CStyle<'a> {
    type Output = String;

    fn add(self, rhs: &'a str) -> Self::Output {
        format!("{}{}", self, rhs)
    }
}

pub const bold: &CStyle = &CStyle("\x1b[1m");
pub const dim: &CStyle = &CStyle("\x1b[2m");
pub const italic: &CStyle = &CStyle("\x1b[3m");
pub const underline: &CStyle = &CStyle("\x1b[4m");
pub const blink: &CStyle = &CStyle("\x1b[5m");

// Regular colors
pub const gray: &CStyle = &CStyle("\x1b[38;2;128;128;128m"); // Gray
pub const red: &CStyle = &CStyle("\x1b[38;2;255;0;0m"); // Red
pub const green: &CStyle = &CStyle("\x1b[38;2;0;255;0m"); // Green
pub const yellow: &CStyle = &CStyle("\x1b[38;2;255;255;0m"); // Yellow
pub const blue: &CStyle = &CStyle("\x1b[38;2;0;0;255m"); // Blue
pub const magenta: &CStyle = &CStyle("\x1b[38;2;255;0;255m"); // Magenta
pub const cyan: &CStyle = &CStyle("\x1b[38;2;0;255;255m"); // Cyan
pub const white: &CStyle = &CStyle("\x1b[38;2;255;255;255m"); // White
pub const orange: &CStyle = &CStyle("\x1b[38;2;255;165;0m"); // Orange
pub const pink: &CStyle = &CStyle("\x1b[38;2;255;192;203m"); // Pink
pub const purple: &CStyle = &CStyle("\x1b[38;2;255;0;255m"); // Purple

// Bold colors (brighter and more saturated)
pub const gray_bold: &CStyle = &CStyle("\x1b[38;2;128;128;128m\x1b[1m"); // Bold gray
pub const red_bold: &CStyle = &CStyle("\x1b[38;2;255;0;0m\x1b[1m"); // Bold red
pub const green_bold: &CStyle = &CStyle("\x1b[38;2;0;255;0m\x1b[1m"); // Bold green
pub const yellow_bold: &CStyle = &CStyle("\x1b[38;2;255;255;0m\x1b[1m"); // Bold yellow
pub const blue_bold: &CStyle = &CStyle("\x1b[38;2;0;0;255m\x1b[1m"); // Bold blue
pub const magenta_bold: &CStyle = &CStyle("\x1b[38;2;255;0;255m\x1b[1m"); // Bold magenta
pub const cyan_bold: &CStyle = &CStyle("\x1b[38;2;0;255;255m\x1b[1m"); // Bold cyan
pub const white_bold: &CStyle = &CStyle("\x1b[38;2;255;255;255m\x1b[1m"); // Bold white
pub const orange_bold: &CStyle = &CStyle("\x1b[38;2;255;165;0m\x1b[1m"); // Bold orange
pub const pink_bold: &CStyle = &CStyle("\x1b[38;2;255;192;203m\x1b[1m"); // Bold pink
pub const purple_bold: &CStyle = &CStyle("\x1b[38;2;128;0;128m\x1b[1m"); // Bold purple

// Dim colors (darker and less saturated)
pub const gray_dim: &CStyle = &CStyle("\x1b[38;2;150;150;150m"); // Dim gray
pub const red_dim: &CStyle = &CStyle("\x1b[38;2;150;0;0m"); // Dim red
pub const green_dim: &CStyle = &CStyle("\x1b[38;2;0;150;0m"); // Dim green
pub const yellow_dim: &CStyle = &CStyle("\x1b[38;2;150;150;0m"); // Dim yellow
pub const blue_dim: &CStyle = &CStyle("\x1b[38;2;0;0;150m"); // Dim blue
pub const magenta_dim: &CStyle = &CStyle("\x1b[38;2;150;0;150m"); // Dim magenta
pub const cyan_dim: &CStyle = &CStyle("\x1b[38;2;0;150;150m"); // Dim cyan
pub const white_dim: &CStyle = &CStyle("\x1b[38;2;150;150;150m"); // Dim white
pub const orange_dim: &CStyle = &CStyle("\x1b[38;2;150;65;0m"); // Dim orange
pub const pink_dim: &CStyle = &CStyle("\x1b[38;2;150;96;102m"); // Dim pink
pub const purple_dim: &CStyle = &CStyle("\x1b[38;2;50;0;50m"); // Dim purple

// Background colors
pub const graybg: &CStyle = &CStyle("\x1b[48;2;128;128;128m");
pub const redbg: &CStyle = &CStyle("\x1b[48;2;255;0;0m");
pub const greenbg: &CStyle = &CStyle("\x1b[48;2;0;255;0m");
pub const yellowbg: &CStyle = &CStyle("\x1b[48;2;255;255;0m");
pub const bluebg: &CStyle = &CStyle("\x1b[48;2;0;0;255m");
pub const magentabg: &CStyle = &CStyle("\x1b[48;2;255;0;255m");
pub const cyanbg: &CStyle = &CStyle("\x1b[48;2;0;255;255m");
pub const whitebg: &CStyle = &CStyle("\x1b[48;2;255;255;255m");
pub const orangebg: &CStyle = &CStyle("\x1b[48;2;255;165;0m");
pub const pinkbg: &CStyle = &CStyle("\x1b[48;2;255;192;203m");
pub const purplebg: &CStyle = &CStyle("\x1b[48;2;128;0;128m");

pub const nostyle: &CStyle = &CStyle("");
pub const reset: &CStyle = &CStyle("\x1b[0m");

/// CStyleSequence
/// a sequence of CStyle
/// # Examples
pub struct CStyleSequence<'a, const N: usize>(&'a [&'a CStyle<'a>; N]);

impl<'a, const N: usize> CStyleSequence<'a, N> {
    pub fn new(styles: &'a [&'a CStyle<'a>; N]) -> Self {
        CStyleSequence(styles)
    }

    pub fn len(&self) -> usize {
        self.0.len()
    }

    pub fn get(&self, index: usize) -> &'a CStyle<'a> {
        if self.len() == 0 {
            return reset;
        }
        self.0.get(index).unwrap_or(&self.0[self.len() - 1])
    }

    pub fn primary(&self) -> &'a CStyle<'a> {
        self.get(0)
    }

    pub fn secondary(&self) -> &'a CStyle<'a> {
        self.get(1)
    }

    pub fn tertiary(&self) -> &'a CStyle<'a> {
        self.get(2)
    }

    pub fn primary_alt(&self) -> &'a CStyle<'a> {
        self.get(3)
    }

    pub fn secondary_alt(&self) -> &'a CStyle<'a> {
        self.get(4)
    }

    pub fn tertiary_alt(&self) -> &'a CStyle<'a> {
        self.get(5)
    }

    pub fn last(&self) -> &'a CStyle<'a> {
        self.get(self.len() - 1)
    }
}

impl<'a, const N: usize> std::ops::Index<usize> for CStyleSequence<'a, N> {
    type Output = CStyle<'a>;

    fn index(&self, index: usize) -> &Self::Output {
        self.get(index)
    }
}

pub const success: CStyleSequence<6> =
    CStyleSequence(&[green_bold, green, gray_dim, gray_dim, white, white]);
pub const info: CStyleSequence<6> =
    CStyleSequence(&[cyan_bold, cyan_dim, gray_dim, gray_dim, white, gray]);
pub const warning: CStyleSequence<6> =
    CStyleSequence(&[yellow_bold, yellow, gray_dim, gray_dim, white, white]);
pub const error: CStyleSequence<6> =
    CStyleSequence(&[red_bold, red, gray_dim, gray_dim, white, white]);
pub const debug: CStyleSequence<6> =
    CStyleSequence(&[magenta_bold, magenta, gray_dim, gray_dim, white, white]);
pub const muted: CStyleSequence<6> =
    CStyleSequence(&[gray_bold, gray, gray_dim, gray_dim, white, white]);

pub fn wrap<T: Display>(style: &CStyle, text: T) -> String {
    format!("{}{}{}", style, text, reset)
}

pub fn in_bold<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(bold, text)
}

pub fn in_dim<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(dim, text)
}

pub fn in_italic<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(italic, text)
}

pub fn in_underline<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(underline, text)
}

pub fn in_blink<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(blink, text)
}

pub fn in_gray<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(gray, text)
}

pub fn in_red<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(red, text)
}

pub fn in_green<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(green, text)
}

pub fn in_yellow<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(yellow, text)
}

pub fn in_blue<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(blue, text)
}

pub fn in_magenta<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(magenta, text)
}

pub fn in_cyan<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(cyan, text)
}

pub fn in_white<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(white, text)
}

pub fn in_orange<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(orange, text)
}

pub fn in_pink<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(pink, text)
}

pub fn in_purple<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(purple, text)
}

pub fn on_gray<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(graybg, text)
}

pub fn on_red<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(redbg, text)
}

pub fn on_green<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(greenbg, text)
}

pub fn on_yellow<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(yellowbg, text)
}

pub fn on_blue<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(bluebg, text)
}

pub fn on_magenta<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(magentabg, text)
}

pub fn on_cyan<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(cyanbg, text)
}

pub fn on_white<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(whitebg, text)
}

pub fn on_orange<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(orangebg, text)
}

pub fn on_pink<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(pinkbg, text)
}

pub fn on_purple<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(purplebg, text)
}

pub fn subtle<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(gray, text)
}

pub fn as_info<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(cyan, text)
}

pub fn as_success<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(green, text)
}

pub fn as_warning<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(yellow, text)
}

pub fn as_error<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(red, &text.to_string().as_str())
}

pub fn as_debug<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(magenta, text)
}

pub fn with_nostyle<'a, T: Display + ?Sized>(text: &'a T) -> String {
    wrap(nostyle, text)
}

pub fn vibrant<'a, T: Display + ?Sized>(text: &'a T) -> String {
    let mut result = String::new();

    for c in text.to_string().chars() {
        if c == ' ' {
            result.push(c);
        } else {
            let color = rand::random::<u8>() % 216 + 16; // colors from 16 to 231 are more saturated
            result.push_str(format!("\x1b[38;5;{}m{}\x1b[0m", color, c).as_str());
        }
    }
    result
}

pub fn divider() {
    //reset to left
    print!("\x1b[0G");
    //print divider 50 chars long in gray
    println!("\x1b[90m{}\x1b[0m", "─".repeat(50));
}

pub fn reset_line() {
    //reset to left
    print!("\x1b[0G");
}


/// # Header macro
/// prints provided title and optional description in a header style with lines and colors
/// e.g. `header!(success,"hello","world","this is a description")`
/// displays: 
/// ```text
/// ┌──────────────────────────────────────────────────────────────────────────────┐
/// │                                   HELLO                                      │
/// │                                   world                                      │
/// │                            this is a description                             │
/// └──────────────────────────────────────────────────────────────────────────────┘
/// colors are based on the provided style (success, info, warning, error, debug, muted)
/// title, subtitle and description are centered and wrapped within the box width of 65 characters
#[macro_export]
macro_rules! header {
    ($style:ident,$title:expr) => {
        $crate::header!($style,$title,"","");
    };
    ($style:ident,$title:expr,$subtitle:expr) => {
        $crate::header!($style,$title,$subtitle,"");
    };
    ($style:ident,$title:expr,$subtitle:expr,$description:expr) => {
        $crate::header!($style,$title,$subtitle,$description,65);
    };
    ($style:ident,$title:expr,$subtitle:expr,$description:expr,$width:expr) => {
        let title = $title.to_string();
        let subtitle = $subtitle.to_string();
        let description = $description.to_string();
        let width = $width;
        let title_width = title.len();
        let subtitle_width = subtitle.len();
        let description_width = description.len();
        let max_width = std::cmp::max(title_width, std::cmp::max(subtitle_width, description_width));
        let left_padding = (max_width - title_width) / 2;
        let right_padding = max_width - title_width - left_padding;
        let subtitle_left_padding = (max_width - subtitle_width) / 2;
        let subtitle_right_padding = max_width - subtitle_width - subtitle_left_padding;
        let description_left_padding = (max_width - description_width) / 2;
        let description_right_padding = max_width - description_width - description_left_padding;
        let title = format!(
            "│{}{}{}│",
            " ".repeat(left_padding),
            title,
            " ".repeat(right_padding)
        );
        let subtitle = format!(
            "│{}{}{}│",
            " ".repeat(subtitle_left_padding),
            subtitle,
            " ".repeat(subtitle_right_padding)
        );
        let description = format!(
            "│{}{}{}│",
            " ".repeat(description_left_padding),
            description,
            " ".repeat(description_right_padding)
        );
        let line = format!(
            "┌{}┐",
            "─".repeat(max_width + 2)
        );
        let line2 = format!(
            "├{}┤",
            "─".repeat(max_width + 2)
        );
        let line3 = format!(
            "└{}┘",
            "─".repeat(max_width + 2)
        );
        $crate::divider();
        $crate::show!($style, line);
        $crate::show!($style, title);
        $crate::show!($style, subtitle);
        $crate::show!($style, description);
        $crate::show!($style, line2);
        $crate::show!($style, line3);
        $crate::divider();
    };
}

#[test]
fn test_header() {
    header!(success, "hello");
    header!(success, "hello", "world");
    header!(success, "hello", "world", "this is a description");
    header!(success, "hello", "world", "this is a description", 50);
}

/// # Printable
/// supports calling `print`, `write`, `render` and `style` on any type
/// e.g. `"hello".print(|s| in_red(s))`
pub trait Printable {
    /// print the text
    fn print<F>(&self, func: F)
    where
        F: Fn(&str) -> String;
    /// print the text with a newline
    fn println<F>(&self, func: F)
    where
        F: Fn(&str) -> String;

    /// write the text (same as print)
    fn write<F>(&self, func: F)
    where
        F: Fn(&str) -> String;

    /// render the text
    fn render<F>(&self, func: F) -> String
    where
        F: Fn(&str) -> String;

    /// style the text
    fn style<F>(&self, func: F) -> String
    where
        F: Fn(&str) -> String;

    fn show(&self) {
        self.print(|s| s.to_string());
    }

    fn showln(&self) {
        self.println(|s| s.to_string());
    }

    /// print_in_postion
    /// print the text in a specific position
    /// e.g. "hello".print_in_position(-3,4,|s| in_red(s))
    /// prints "hello" 3 lines up and 4 characters to the right
    fn print_positioned<F>(&self, x: i32, y: i32, func: F)
    where
        F: Fn(&str) -> String;
}

impl<T: Display> Printable for T {
    fn print<F>(&self, func: F)
    where
        F: Fn(&str) -> String,
    {
        print!("{}", func(&self.to_string()));
    }

    fn println<F>(&self, func: F)
    where
        F: Fn(&str) -> String,
    {
        println!("{}", func(&self.to_string()));
    }

    fn print_positioned<F>(&self, x: i32, y: i32, func: F)
    where
        F: Fn(&str) -> String,
    {
        //if x is negative, move the cursor up
        if x < 0 {
            print!("\x1b[{}A", x.abs());
        }

        //if x is positive, move the cursor down
        if x > 0 {
            print!("\x1b[{}B", x);
        }

        //if y is negative, move the cursor left
        if y < 0 {
            print!("\x1b[{}D", y.abs());
        }

        //if y is positive, move the cursor right
        if y > 0 {
            print!("\x1b[{}C", y);
        }

        print!("{}", func(&self.to_string()));

        //undo the cursor movement
        if x < 0 {
            print!("\x1b[{}B", x.abs());
        }

        //if x is positive, move the cursor down
        if x > 0 {
            print!("\x1b[{}A", x);
        }

        //if y is negative, move the cursor left
        if y < 0 {
            print!("\x1b[{}C", y.abs());
        }

        //if y is positive, move the cursor right
        if y > 0 {
            print!("\x1b[{}D", y);
        }

        //flush stdout
        io::stdout().flush().unwrap();
    }

    fn write<F>(&self, func: F)
    where
        F: Fn(&str) -> String,
    {
        print!("{}", func(&self.to_string()));
    }

    fn render<F>(&self, func: F) -> String
    where
        F: Fn(&str) -> String,
    {
        func(&self.to_string())
    }

    fn style<F>(&self, func: F) -> String
    where
        F: Fn(&str) -> String,
    {
        func(&self.to_string())
    }
}

/// show selection picker
/// ask for selection
/// interactively ask for a selection from a list of options
/// user can type in a number or press up/down arrows to select and press enter to confirm
/// user can also type in a term to filter options by that term
/// press esc to break out of the loop
/// # Examples
/// ```
/// impl Pickable for Person {
///    fn get_title(&self) -> String {
///       self.name.to_string()
///   }
///  fn get_description(&self) -> String {
///      self.name.to_string()
/// }
/// }
/// let options = vec![Person{name:"John"},Person{name:"Jane"}];
/// let selection = ask_for_selection(options.iter().collect());
/// ```
pub fn ask_for_selection<T: Pickable + Clone>(options: Vec<T>) -> usize {
    // continue from the current line and dont clear anything before current line
    print!("\x1b[1K\x1b[0G");
    //print the options
    display_options(options.clone(), 0);
    //flush stdout
    io::stdout().flush().unwrap();
    //enable raw mode
    enable_raw_mode().unwrap();
    //get the key
    let mut key = get_key();
    //the selected index
    let mut selected = 0;
    //the search term
    let mut search_term = String::new();
    //loop until the user presses enter
    loop {
        //if the key is enter, break out of the loop
        if key == Key::Char('\n') {
            break;
        }
        //if the key is backspace, remove the last character from the search term
        if key == Key::Backspace {
            search_term.pop();
        }
        //if the key is a char, add it to the search term
        if let Key::Char(c) = key {
            search_term.push(c);
        }
        //if the key is an arrow, move the selection up or down
        if let Key::ArrowUp = key {
            if selected > 0 {
                selected -= 1;
            }
        }
        if let Key::ArrowDown = key {
            if selected < options.len() - 1 {
                selected += 1;
            }
        }
        //clear the screen
        print!("\x1b[2J\x1b[0;0H");
        //filter the options by the search term
        let filtered_options = options
            .clone()
            .into_iter()
            .filter(|o| o.get_title().contains(&search_term))
            .collect();
        //print the options
        display_options(filtered_options, selected);
        //flush stdout
        io::stdout().flush().unwrap();
        //get the next key
        key = get_key();
    }
    //disable raw mode
    disable_raw_mode().unwrap();
    //return the selected index
    selected
}

/// get_key
/// get the next key from stdin
pub fn get_key() -> Key {
    let mut buffer = [0; 1];
    io::stdin().read_exact(&mut buffer).unwrap();
    match buffer[0] {
        27 => {
            //if the first byte is 27, it is an escape sequence
            //read the next two bytes to determine which key was pressed
            let mut buffer = [0; 2];
            io::stdin().read_exact(&mut buffer).unwrap();
            match buffer {
                [91, 65] => Key::ArrowUp,
                [91, 66] => Key::ArrowDown,
                [91, 67] => Key::ArrowRight,
                [91, 68] => Key::ArrowLeft,
                _ => Key::Esc,
            }
        }
        127 => Key::Backspace,
        10 => Key::Char('\n'),
        _ => Key::Char(buffer[0] as char),
    }
}

/// Key
/// a key that can be pressed
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Key {
    ArrowUp,
    ArrowDown,
    ArrowRight,
    ArrowLeft,
    Backspace,
    Char(char),
    Esc,
}

pub fn display_options<T: Pickable>(options: Vec<T>, selected: usize) {
    let mut index = 0;
    for option in options {
        if index == selected {
            option.get_title().print(in_yellow);
            " ".print(in_yellow);
            option.get_description().println(in_yellow);
        } else {
            option.get_title().print(in_white);
            " ".print(in_white);
            option.get_description().println(in_white);
        }
        index += 1;
    }
}

/// enable raw mode
/// enable raw mode on stdin (no external dependencies)
pub fn enable_raw_mode() -> std::io::Result<()> {
    io::stdout().write_all(b"\x1b[?25l")?;
    io::stdout().flush()?;
    Ok(())
}

/// disable raw mode
/// disable raw mode on stdin (no external dependencies)
pub fn disable_raw_mode() -> std::io::Result<()> {
    io::stdout().write_all(b"\x1b[?25h")?;
    io::stdout().flush()?;
    Ok(())
}

/// Pickable
/// a trait that can be used to implement a pickable item
pub trait Pickable {
    fn get_title(&self) -> String;
    fn get_description(&self) -> String;
}

#[macro_export]
macro_rules! show {
    ($arg:expr) => {
        print!("{}", $arg);
    };

    ($style:ident, $value:expr) => {
        print!("{}{}{}", $crate::$style, $value, $crate::reset);
    };

    ($style:ident, $value:expr, $($rest:tt)*) => {
        $crate::show!($style, $value);
        $crate::show!($($rest)*);
    };
}

#[macro_export]
macro_rules! showln {
    ($arg:expr) => {
        println!("{}", $arg);
    };

    ($style:ident, $value:expr) => {
        println!("{}{}{}", $crate::$style, $value, $crate::reset);
    };

    ($style:ident, $value:expr, $($rest:tt)*) => {
        $crate::show!($style, $value);
        $crate::showln!($($rest)*);
    };
}

/// paragraph! macro
/// same like showln! but automatically chops the text and
/// wraps it in a paragraph. the width of the paragraph
/// is 65 characters by default. when the text is longer than
/// 65 characters, it is wrapped in a paragraph
/// # Examples
/// ``
/// paragraph!(white,"this is a long text that will be wrapped in a paragraph after 65 chars",green,"this is another long text that will be appended to the first one and wrapped in a paragraph");
/// ``
/// output:
/// ``
/// this is a long text that will be wrapped in a paragraph after
/// 65 chars. this is another long text that will be appended to
/// the first one and wrapped in a paragraph
///
#[macro_export]
macro_rules! paragraph {
    ($($arg:tt)*) => {{
        // Use the render! macro to format the text
        let formatted = $crate::render!($($arg)*);

        // Use textwrap to wrap the text to a width of 65 characters
        // You can adjust this value if needed
        let width = 65;
        let wrapped = textwrap::fill(&formatted, width);

        // Print the wrapped text
        println!("{}", wrapped);
    }};
}


/// render! macro
/// same like showln! but automatically chops the text and
/// wraps it in a paragraph. the width of the paragraph
/// is 65 characters by default. when the text is longer than
/// 65 characters, it is wrapped in a paragraph

#[macro_export]
macro_rules! render {
    ($arg:expr) => {
        format!("{}", $arg)
    };

    ($style:ident, $value:expr) => {
        format!("{}{}{}", $crate::$style, $value, $crate::reset)
    };

    ($style:ident, $value:expr, $($rest:tt)*) => {
        format!("{}{}{}{}", $crate::$style, $value, $crate::reset, render!($($rest)*))
    };
}
