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