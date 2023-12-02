
use std::collections::HashMap;

use antlr_rust::common_token_stream::CommonTokenStream;
use antlr_rust::input_stream::InputStream;
use antlr_rust::parser_rule_context::{ParserRuleContext, RuleContextExt};
use antlr_rust::rule_context::{BaseRuleContext, CustomRuleContext};
use antlr_rust::tree::{ErrorNode, Listenable, ParseTree, ParseTreeListener, ParseTreeVisitor, TerminalNode, Tree, VisitChildren};
use tokio::fs;

pub mod gen;
pub use gen::*;


pub struct MyInterpreter {
    variables: HashMap<String, String>,
    commands: HashMap<String, CommandHandler<Self>>,
}

type CommandHandler<T> = fn(&mut T, Vec<String>);


impl MyInterpreter {
    pub fn new() -> Self {
        let mut commands: HashMap<String, CommandHandler<Self>> = HashMap::new();
        commands.insert("show".to_string(), MyInterpreter::handle_show);
        // commands.insert("get".to_string(), MyInterpreter::handle_get);
        Self {
            variables: HashMap::new(),
            commands,
        }
    }

    fn handle_show(&mut self, args: Vec<String>) {
        let combined = args.join(" ");
        println!("{}", combined);
    }


    fn set_variable(&mut self, name: String, value: String) {
        self.variables.insert(name, value);
    }

    fn get_variable(&self, name: &str) -> Option<&String> {
        self.variables.get(name)
    }
}


impl ParseTreeVisitor<'_, NoteParserContextType> for MyInterpreter {
    fn visit_terminal(&mut self, node: &TerminalNode<'_, NoteParserContextType>) {
        // println!("Terminal: {}", node.get_text());
    }

    fn visit_error_node(&mut self, node: &ErrorNode<'_, NoteParserContextType>) {
        println!("Error node: {}", node.get_text());
    }
}

impl NoteVisitor<'_> for MyInterpreter {
    fn visit_command(&mut self, ctx: &CommandContext<'_>) {
          handle_command(&ctx, self);
    }

}



fn handle_command(ctx: &CommandContext, interpreter: &mut MyInterpreter) {
    let command_name = ctx.ID().unwrap().get_text();
    let args = ctx.get_children().map(|c| c.get_text()).collect::<Vec<_>>();

    if let Some(handler) = interpreter.commands.get(&command_name) {
        handler(interpreter, args);
    } else {
        println!("Unknown command: {}", command_name);
    }
}




const FILEPATH: &str = "test.moto";

pub async fn parse() {
    let file_content = fs::read_to_string(FILEPATH).await.unwrap();

    // Create the input stream
    let input = InputStream::new(&*file_content);
    // Create the lexer
    let mut lexer = NoteLexer::new(input);
    // Create the token stream
    let token_source = CommonTokenStream::new(lexer);
    // Create the parser
    let mut parser = NoteParser::new(token_source);

    // Add listener
    let mut visitor = MyInterpreter::new();
    visitor.visit_script(&mut parser.script().unwrap());

    // Parse and process the result
    let result = parser.script();
    // Handle the result
    match result {
        Ok(s) => {
            println!("Success: {:?}", s);
        }
        Err(e) => {
            println!("Error: {:?}", e);
        }
    }
}
