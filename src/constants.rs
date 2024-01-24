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

╭── TITLE ────────────────────────────────────────────────────────────────────────╮
│
│
│
╰──


*/
// banner and footer has "works for you" in yellow
pub const BANNER :&str = r#"
                      __              __      
         ____  ____  / /_  ____  ____/ /_  __
        / __ \/ __ \/ __ \/ __ \/ __  / / / /
       / / / / /_/ / /_/ / /_/ / /_/ / /_/ / 
      /_/ /_/\____/_.___/\____/\__,_/\__, / 
————————————————————————————————————————,/———————
                                   /____/                 
"#;

pub const FOOTER :&str = r#"WORKS FOR YOU ✨"#;
pub const DESCRIPTION :&str = r#"DEVELOPED BY AGHIL MOHANDAS FOR ALMANSOORI WIRELINE SERVICES"#;
