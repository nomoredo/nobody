use antlr_rust::InputStream;
use antlr_rust::common_token_stream::CommonTokenStream;
use antlr_rust::parser_rule_context::ParserRuleContext;
use antlr_rust::tree::{ErrorNode, ParseTreeListener, TerminalNode, Visitable};
use nobody::*;
// banner and footer has "works for you" in yellow
const banner: &str = r#"
                           __              __      
              ____  ____  / /_  ____  ____/ /_  __
             / __ \/ __ \/ __ \/ __ \/ __  / / / /
            / / / / /_/ / /_/ / /_/ / /_/ / /_/ / 
           /_/ /_/\____/_.___/\____/\__,_/\__, / 
_______________________________          /____/._________________
        "#;

#[tokio::main]
async fn main() {
    termo::show::banner_vibrant(banner);
    // termo::show::divider_positioned_vibrant(0, -1);
    termo::show::positioned(26, -1, "[white][italic][bold] WORKS FOR YOU[/]");
    // handle_args().await;
    nobody::parse().await;
}



