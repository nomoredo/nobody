// box drawing characters
// like https://en.wikipedia.org/wiki/Box-drawing_character
/*
U+250x	─	━	│	┃	┄	┅	┆	┇	┈	┉	┊	┋	┌	┍	┎	┏
U+251x	┐	┑	┒	┓	└	┕	┖	┗	┘	┙	┚	┛	├	┝	┞	┟
U+252x	┠	┡	┢	┣	┤	┥	┦	┧	┨	┩	┪	┫	┬	┭	┮	┯
U+253x	┰	┱	┲	┳	┴	┵	┶	┷	┸	┹	┺	┻	┼	┽	┾	┿
U+254x	╀	╁	╂	╃	╄	╅	╆	╇	╈	╉	╊	╋	╌	╍	╎	╏
U+255x	═	║	╒	╓	╔	╕	╖	╗	╘	╙	╚	╛	╜	╝	╞	╟
U+256x	╠	╡	╢	╣	╤	╥	╦	╧	╨	╩	╪	╫	╬	╭	╮	╯
U+257x	╰	╱	╲	╳	╴	╵	╶	╷	╸	╹	╺	╻	╼	╽	╾	╿
─────────────────────────────────────────────────────────────────
╭──
│
│
│
└──


*/
// banner and footer has "works for you" in yellow
pub const BANNER :&str = r#"
                            __              __      
               ____  ____  / /_  ____  ____/ /_  __
              / __ \/ __ \/ __ \/ __ \/ __  / / / /
             / / / / /_/ / /_/ / /_/ / /_/ / /_/ / 
            /_/ /_/\____/_.___/\____/\__,_/\__, / 
──────────────────────────────────────────────,/─────────────────
                                         /____/                
─────────────────────────────────────────────────────────────────
"#;

pub const FOOTER :&str = r#" WORKS FOR YOU "#;

pub const STARTUP_INFO :&str = r#"nobody will look for any executable scripts in the current path
and add them to the list of available scripts. you can press [up] 
and [down] to navigate, [enter] to select and [esc] to exit app.
alternatively, you can directly run any script by typing its name
eg: `no myscript` where `myscript.nomore` is the script file.
"#;


pub const TEMPLATE :&str = r#"
/// name: this is the name of the script
/// description: this is the description of the script. you can write a long description here
/// it will not be truncated. you can write as much as you want. everything with `///` will be
/// parsed by the nobody execution engine seperately and can be used to customize the execution,environemnt
/// and even extend the capabilities of the script. lines starting with `//` will be considered as
/// usual javascript comments and will be ignored by the execution engine. nobody will identify any
/// script with the `.no` | `.nomo` | `.nomore` | `.nobody` | `.tra` as a script file and will try to
/// parse `///` comments as metadata for the script. only if the script contains a `/// name:` and
/// `/// description:` will it be considered as a valid script file. others will be ignored.
/// however, you can still refer to them or run them directly by typing their name in the terminal.
/// below is a sample javascript code that will be executed when you run this script.

let a = 10;
let b = 20;
let c = a + b;
console.log(`the sum of ${a} and ${b} is ${c}`);

// you can use all core javascript functions here
// however, since we don't use nodejs, and are not running in a browser,
// functionalities provided by nodejs or browser will not be available here.
// however nobody provides a set of core functions that you can use to interact with the system
// below are some of the core functions that you can use in your script

let name = await nobody.ask("what is your name?");
console.log(`hello ${name}`);

let isAdult = await nobody.confirm("are you an adult?");
console.log(`you are ${isAdult ? "an adult" : "not an adult"}`);

let options = [{name: "apple", color: "red"}, {name: "banana", color: "yellow"}];
let selected = await nobody.select("select a fruit", options);
console.log(`you selected ${selected.name} which is ${selected.color}`);

let file = await files.create("test.txt");
file.content = "this is a test file";
await file.save();

"#;
