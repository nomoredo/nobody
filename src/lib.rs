use std::collections::HashMap;

use antlr_rust::common_token_stream::CommonTokenStream;
use antlr_rust::input_stream::InputStream;
use antlr_rust::parser_rule_context::{ParserRuleContext, RuleContextExt};
use antlr_rust::rule_context::{BaseRuleContext, CustomRuleContext};
use antlr_rust::tree::{
    ErrorNode, Listenable, ParseTree, ParseTreeListener, ParseTreeVisitor, TerminalNode, Tree,
    VisitChildren,
};
use tokio::fs;

pub mod gen;
pub use gen::*;

pub struct EmoEngine {
    variables: HashMap<String, Value>,
    commands : HashMap<String, Cmd>,
}


#[derive(Debug, Clone)]
pub struct Cmd{
    names: Vec<String>,
    params: Vec<Param>,
    handler: CommandHandler<EmoEngine>,
}

impl Cmd{
    pub fn new() -> Self{
        Cmd{
            names: vec![],
            params: vec![],
            handler: |_, _| {},
        }
    }



    //easy way to declare a command
    pub fn declare<T>(name: impl Into<String>, params: Vec<T>, handler: CommandHandler<EmoEngine>) -> Self where T: Into<Param> {
        let mut cmd = Cmd::new();
        cmd.add_name(name);
        for param in params{
            cmd.add_param(param.into());
        }
        cmd.set_handler(handler);
        cmd
    }



    pub fn add_name(&mut self, name: impl Into<String>) -> &mut Self{
        self.names.push(name.into());
        self
    }

    pub fn add_param(&mut self, param: Param)-> &mut Self{
        self.params.push(param);
        self
    }

    pub fn set_handler(&mut self, handler: CommandHandler<EmoEngine>) -> &mut Self{
        self.handler = handler;
        self
    }

    pub fn matches(&self, name: &str) -> bool{
        for name in &self.names{
            if name == name{
                return true;
            }
        }
        false
    }

    pub fn get_handler(&self) -> CommandHandler<EmoEngine>{
        self.handler
    }

    pub fn get_names(&self) -> Vec<String>{
        self.names.clone()
    }

    pub fn get_params(&self) -> Vec<Param>{
        self.params.clone()
    }

    fn execute(&self,engine: &mut EmoEngine, args: &Vec<Argument>){
        //match arguments to parameters
        let mut params = self.get_params();
        let mut args = args.clone();
        let mut args_iter = args.iter();
        let mut params_iter = params.iter_mut();
        let mut current_param = params_iter.next();
        let mut current_arg = args_iter.next();
        while current_param.is_some() && current_arg.is_some(){
            let param = current_param.unwrap();
            let arg = current_arg.unwrap();
            if param.matches(&arg.to_value().to_string()){
                param.set_default(arg.to_value());
                current_param = params_iter.next();
                current_arg = args_iter.next();
            }else{
                break;
            }
        }

        //execute command
        termo::show::action("EXECUTE", &self.get_names().join(", "), &args.iter().map(|arg| arg.to_value().to_string()).collect::<Vec<String>>().join(", "));
        (self.get_handler())(engine, &args);

    }

    fn set_commands(&mut self, commands: Vec<Cmd>) -> &mut Self{
        for command in commands{
            for name in command.get_names(){
                self.add_name(name);
            }
        }
        self
    }
}

pub type CommandHandler<T> = fn(&mut T, &Vec<Argument>);


impl From<&mut Cmd> for Cmd{
    fn from(cmd: &mut Cmd) -> Self{
        cmd.clone()
    }
}




/*
script             : (task | statement| comment)* EOF ;
task               : 'task' taskIdentifier taskBody ;
identifier         : ID (PIPE ID)* ;
parameter     : '[' identifier? (PARAM) (EQUAL valuetype)? ']' ;
taskIdentifier     : identifier (identifier | parameter)* ;
variableDeclaration: LET ID EQUAL expression ;
taskBody           : '{' (statement)* '}' ;
statement          : command | loopStatement | conditionalStatement | variableDeclaration ;
command            : ID (argument)* ;
argument           : DEXP | ID | STRING | NUMBER ;
loopStatement      : FOR ID IN valuetype taskBody ;
conditionalStatement : IF condition taskBody (ELSE taskBody)? ;
condition           : idtype OPERATOR valuetype ;
expression         : valuetype (OPEXP valuetype)* ;
idtype            : ID | DEXP ;
valuetype         : NUMBER | STRING | list  | ID | DEXP ;
list               : '[' (valuetype (COMMA valuetype)*)? ']' ;
comment            : COMMENT ;

// Existing lexer rules...
COMMENT: '//' .*? LB;
PARAM: ':' ID;
DEXP : '$' ID;
PIPE: '|';
LET: 'let';
IN: 'in';
FOR: 'for';
IF: 'if';
ELSE: 'else';
COMMA: ',';
EQUAL: '=';
STRING: '"' .*? '"';
NUMBER: [0-9]+;
ID: [a-zA-Z_][a-zA-Z0-9_]*;
LB: [\r\n]+ -> skip;
WS: [ \t]+ -> skip;
OPERATOR: '==' | '!=' | '<' | '>' | '<=' | '>=';
OPEXP: '+' | '-' | '*' | '/';


*/


#[derive(Debug, Clone)]
enum Value{
    String(String),
    Number(f64),
    List(Vec<Value>),
    Variable(String),
    Expression(String),
    Boolean(bool),
    None,
}

#[derive(Debug, Clone)]
enum Argument{
    String(String),
    Number(f64),
    List(Vec<Argument>),
    Variable(String),
    Expression(String),
    Boolean(bool),
    None,
}



#[derive(Debug, Clone)]
struct Param{
    prefix: Vec<String>,
    names: Vec<String>,
    default: Option<Value>,
}

/// prefix:name=value
/// or name=value
/// or name
impl<T> From<T> for Param where T: Into<String>{
    fn from(name: T) -> Self{
        Param{
            prefix: vec![],
            names: vec![name.into()],
            default: None,
        }
    }
}


impl Param{
    fn new() -> Self{
        Param{
            prefix: vec![],
            names: vec![],
            default: None,
        }
    }

    fn add_prefix(&mut self, prefix: String) -> &mut Self{
        self.prefix.push(prefix);
        self
    }

    fn add_name(&mut self, name: String) -> &mut Self{
        self.names.push(name);
        self
    }

    fn set_default(&mut self, default: Value) -> &mut Self{
        self.default = Some(default);
        self
    }

    fn matches(&self, name: &str) -> bool{
        for prefix in &self.prefix{
            if name.starts_with(prefix){
                return true;
            }
        }
        for name in &self.names{
            if name == name{
                return true;
            }
        }
        false
    }

    fn get_default(&self) -> Option<Value>{
        self.default.clone()
    }

    fn get_name(&self) -> String{
        self.names[0].clone()
    }

    fn get_names(&self) -> Vec<String>{
        self.names.clone()
    }

    fn get_prefixes(&self) -> Vec<String>{
        self.prefix.clone()
    }
}

impl Argument{
    fn to_value(&self) -> Value{
        match self {
            Argument::String(string) => Value::String(string.to_string()),
            Argument::Number(number) => Value::Number(*number),
            Argument::List(values) => {
                let mut result: Vec<Value> = vec![];
                for value in values {
                    result.push(value.to_value());
                }
                Value::List(result)
            }
            Argument::Variable(variable) => Value::Variable(variable.to_string()),
            Argument::Expression(expression) => Value::Expression(expression.to_string()),
            Argument::Boolean(boolean) => Value::Boolean(*boolean),
            Argument::None => Value::None,
        }
    }
}

impl PartialEq for Argument {
    fn eq(&self, other: &Self) -> bool {
        match self {
            Argument::String(string) => match other {
                Argument::String(other_string) => string == other_string,
                _ => false,
            },
            Argument::Number(number) => match other {
                Argument::Number(other_number) => number == other_number,
                _ => false,
            },
            Argument::List(values) => match other {
                Argument::List(other_values) => values == other_values,
                _ => false,
            },
            Argument::Variable(variable) => match other {
                Argument::Variable(other_variable) => variable == other_variable,
                _ => false,
            },
            Argument::Expression(expression) => match other {
                Argument::Expression(other_expression) => expression == other_expression,
                _ => false,
            },
            Argument::Boolean(boolean) => match other {
                Argument::Boolean(other_boolean) => boolean == other_boolean,
                _ => false,
            },
            Argument::None => match other {
                Argument::None => true,
                _ => false,
            },
        }
    }
}

impl Eq for Argument {}

impl PartialEq for Value {
    fn eq(&self, other: &Self) -> bool {
        match self {
            Value::String(string) => match other {
                Value::String(other_string) => string == other_string,
                _ => false,
            },
            Value::Number(number) => match other {
                Value::Number(other_number) => number == other_number,
                _ => false,
            },
            Value::List(values) => match other {
                Value::List(other_values) => values == other_values,
                _ => false,
            },
            Value::Variable(variable) => match other {
                Value::Variable(other_variable) => variable == other_variable,
                _ => false,
            },
            Value::Expression(expression) => match other {
                Value::Expression(other_expression) => expression == other_expression,
                _ => false,
            },
            Value::Boolean(boolean) => match other {
                Value::Boolean(other_boolean) => boolean == other_boolean,
                _ => false,
            },
            Value::None => match other {
                Value::None => true,
                _ => false,
            },
        }
    }
}

impl Value{
    fn to_argument(&self) -> Argument{
        match self {
            Value::String(string) => Argument::String(string.to_string()),
            Value::Number(number) => Argument::Number(*number),
            Value::List(values) => {
                let mut result: Vec<Argument> = vec![];
                for value in values {
                    result.push(value.to_argument());
                }
                Argument::List(result)
            }
            Value::Variable(variable) => Argument::Variable(variable.to_string()),
            Value::Expression(expression) => Argument::Expression(expression.to_string()),
            Value::Boolean(boolean) => Argument::Boolean(*boolean),
            Value::None => Argument::None,
        }
    }
}

impl Eq for Value {}


impl ToString for Value {
    fn to_string(&self) -> String {
        match self {
            Value::String(string) => string.to_string(),
            Value::Number(number) => number.to_string(),
            Value::List(values) => {
                let mut result = String::new();
                for value in values {
                    result.push_str(&value.to_string());
                }
                result
            }
            Value::Variable(variable) => variable.to_string(),
            Value::Expression(expression) => expression.to_string(),
            Value::Boolean(boolean) => boolean.to_string(),
            Value::None => "".to_string(),
        }
    }
}





impl EmoEngine {
    pub fn new() -> Self {
        let mut engine = EmoEngine {
            variables: HashMap::new(),
            commands: HashMap::new(),
        };
        termo::show::action("INIT", "EmoEngine", "Initializing");
        engine.register_command( Cmd::declare("print", vec!["value"], |engine: &mut EmoEngine, args: &Vec<Argument>|{
            engine.handle_print(args);
        }).add_name("show"));
        engine.register_command( Cmd::declare("set", vec!["name" ,"value"], |engine: &mut EmoEngine, args: &Vec<Argument>|{
            engine.handle_set(args);
        }));
        engine.register_command( Cmd::declare("get", vec!["name"], |engine: &mut EmoEngine, args: &Vec<Argument>|{
            engine.handle_get(args);
        }));
        //command sequence execution handler
        engine.register_command( Cmd::declare("execute", vec!["commands"], |engine: &mut EmoEngine, args: &Vec<Argument>|{
            engine.handle_sequence(args);
        }));

        // regsiter webdriver commands
        engine.register_command( Cmd::declare("webdriver", vec!["post"] , |engine: &mut EmoEngine, args: &Vec<Argument>|{
            engine.handle_webdriver(args);
        }));

        termo::show::action("INIT", "EmoEngine", "Initialized");
        engine
    }

    fn handle_webdriver(&mut self, args: &Vec<Argument>) {
        let mut result = String::new();
        for arg in args {
            result.push_str(&arg.to_value().to_string());
        }
        termo::show::sub_action("WEBDRIVER", "", &result);
    }


    fn handle_sequence(&mut self, args: &Vec<Argument>) {
        for arg in args {
            match arg {
                Argument::List(list) => {
                    for arg in list {
                        match arg {
                            Argument::String(string) => {
                                self.handle_command(string);
                            }
                            _ => {}
                        }
                    }
                }
                Argument::String(string) => {
                    self.handle_command(string);
                }
                _ => {}
            }
        }
    }

    fn handle_command(&mut self, command: &str) {
        termo::show::action("EXECUTE", "CMD", command);
        let input = InputStream::new(command);
        let mut lexer = NoteLexer::new(input);
        let token_source = CommonTokenStream::new(lexer);
        let mut parser = NoteParser::new(token_source);
        let result = parser.command();
        match result {
            Ok(command) => {
                self.visit_command(&command);
            }
            Err(_) => {}
        }
    }

    fn handle_print(&mut self, args: &Vec<Argument>) {
        let mut result = String::new();
        for arg in args {
            result.push_str(&arg.to_value().to_string());
        }
        termo::show::sub_action("PRINT", "", &result);
    }

    fn handle_set(&mut self, args: &Vec<Argument>) {
        let name = args[0].to_value().to_string();
        let value = args[1].to_value();
        termo::show::sub_action("SETTING", &name, &value.to_string());
        self.set_variable(name, value);
    }

    fn handle_get(&mut self, args: &Vec<Argument>) {
        let name = args[0].to_value().to_string();
        let value = self.get_variable(&name);
        termo::show::sub_action("GETTING", &name, &value);
    }

    fn set_variable(&mut self, name: String, value: Value) {
        self.variables.insert(name, value);
    }

    fn get_variable(&self, name: &str) -> String {
        match self.variables.get(name) {
            Some(value) => value.to_string(),
            None => "".to_string(),
        }
    }

    fn evaluate_valuetype(&self, valuetype: &ValuetypeContext) -> Value {
        match valuetype.STRING() {
            Some(string) => Value::String(string.get_text().to_string()),
            None => match valuetype.NUMBER() {
                Some(number) => Value::Number(number.get_text().parse::<f64>().unwrap()),
                None => match valuetype.list() {
                    Some(list) => {
                        let mut values: Vec<Value> = vec![];
                        for valuetype in list.valuetype_all() {
                            values.push(self.evaluate_valuetype(&valuetype));
                        }
                        Value::List(values)
                    }
                    None => match valuetype.ID() {
                        Some(id) => Value::Variable(id.get_text().to_string()),
                        None => match valuetype.DEXP() {
                            Some(dexp) => Value::Expression(dexp.get_text().to_string()),
                            None => Value::None,
                        },
                    },
                },
            },
        }
    }
    
    fn evaluate_dynamic_expression(&self, expression: &str) -> Option<String> {
        let mut tokens: Vec<String> = vec![];
        let mut token = String::new();
        let mut in_variable = false;
        for c in expression.chars() {
            if c == '$' {
                in_variable = true;
            } else if c == ' ' {
                if in_variable {
                    tokens.push(token);
                    token = String::new();
                    in_variable = false;
                }
            } else {
                token.push(c);
            }
        }
        if in_variable {
            tokens.push(token);
        }
        let mut result = String::new();
        for token in tokens {
            result.push_str(&self.get_variable(&token));
        }
        Some(result)
    }
    

    fn evaluate_expression(&self, expression: &ExpressionContext) -> Option<Value> {
        let mut result: Option<Value> = None;
        let mut operator: Option<String> = None;
        for valuetype in expression.valuetype_all() {
            let value = self.evaluate_valuetype(&valuetype);
            match &result {
                Some(result_value) => match operator {
                    Some(operator_string) => {
                        result = Some(self.evaluate_operation(&result_value, &value, &operator_string));
                        operator = None;
                    }
                    None => {}
                },
                None => {
                    result = Some(value);
                }
            }
        }
        result
    }
      

    fn evaluate_operation(&self, left: &Value, right: &Value, operator: &str) -> Value {
        match operator {
            "+" => match left {
                Value::String(left_string) => match right {
                    Value::String(right_string) => {
                        Value::String(format!("{}{}", left_string, right_string))
                    }
                    _ => Value::None,
                },
                Value::Number(left_number) => match right {
                    Value::Number(right_number) => Value::Number(left_number + right_number),
                    _ => Value::None,
                },
                _ => Value::None,
            },
            "-" => match left {
                Value::Number(left_number) => match right {
                    Value::Number(right_number) => Value::Number(left_number - right_number),
                    _ => Value::None,
                },
                _ => Value::None,
            },
            "*" => match left {
                Value::Number(left_number) => match right {
                    Value::Number(right_number) => Value::Number(left_number * right_number),
                    _ => Value::None,
                },
                _ => Value::None,
            },
            "/" => match left {
                Value::Number(left_number) => match right {
                    Value::Number(right_number) => Value::Number(left_number / right_number),
                    _ => Value::None,
                },
                _ => Value::None,
            },
            _ => Value::None,
        }
    }

    fn evaluate_idtype(&self, idtype: &IdtypeContext) -> Value {
        match idtype.ID() {
            Some(id) => Value::Variable(id.get_text().to_string()),
            None => match idtype.DEXP() {
                Some(dexp) => match self.evaluate_dynamic_expression(&dexp.get_text()) {
                    Some(value) => Value::Expression(value),
                    None => Value::None,
                },
                None => Value::None,
            },
        }
    }

    fn evaluate_condition(&self, condition: &ConditionContext) -> bool {
        match condition.idtype() {
            Some(idtype) => {
                let left = self.evaluate_idtype(&idtype);
                match condition.valuetype() {
                    Some(valuetype) => {
                        let right = self.evaluate_valuetype(&valuetype);
                        match condition.OPERATOR() {
                            Some(operator) => {
                                let operator_string = operator.get_text();
                                match operator_string.as_str() {
                                    "==" => left == right,
                                    "!=" => left != right,
                                    "<" => match left {
                                        Value::Number(left_number) => match right {
                                            Value::Number(right_number) => {
                                                left_number < right_number
                                            }
                                            _ => false,
                                        },
                                        _ => false,
                                    },
                                    ">" => match left {
                                        Value::Number(left_number) => match right {
                                            Value::Number(right_number) => {
                                                left_number > right_number
                                            }
                                            _ => false,
                                        },
                                        _ => false,
                                    },
                                    "<=" => match left {
                                        Value::Number(left_number) => match right {
                                            Value::Number(right_number) => {
                                                left_number <= right_number
                                            }
                                            _ => false,
                                        },
                                        _ => false,
                                    },
                                    ">=" => match left {
                                        Value::Number(left_number) => match right {
                                            Value::Number(right_number) => {
                                                left_number >= right_number
                                            }
                                            _ => false,
                                        },
                                        _ => false,
                                    },
                                    _ => false,
                                }
                            }
                            None => false,
                        }
                    }
                    None => false,
                }
            }
            None => false,
        }
    }



    fn register_command(&mut self, cmd: impl Into<Cmd>){
        let c = cmd.into();
        let names = c.get_names();
        termo::show::sub_action("REGISTER", &names.join(", "), "");

        for name in c.get_names(){
            self.commands.insert(name, c.clone());
        }
    }

    fn find_command(&self, name: &str) -> Option<Cmd>{
        match self.commands.get(name){
            Some(cmd) => Some(cmd.clone()),
            None => {
                termo::show::not_found("COMMAND", name);
                None
            },
        }
    }

    pub async fn load_file(&mut self, path: &str) -> Result<(), Box<dyn std::error::Error>> {
        let file_content = fs::read_to_string(path).await.unwrap();
        let input = InputStream::new(&*file_content);
        let mut lexer = NoteLexer::new(input);
        let token_source = CommonTokenStream::new(lexer);
        let mut parser = NoteParser::new(token_source);
        self.visit_script(&mut parser.script().unwrap());
        let result = parser.script();
        match result {
            Ok(script) => {
                self.visit_script(&script);
            }
            Err(_) => {}
        }

        Ok(())
    }

    fn handle_error_node(&mut self, node: &ErrorNode<'_, NoteParserContextType>) {
        println!("Error node: {:?}", node);
    }

    fn list_commands(&self) {
        termo::show::action("LISTING","REGISTERD", "COMMANDS");
        for (name, cmd) in &self.commands {
            termo::show::action_loop(name,cmd.get_params().iter().map(|param| param.get_name()).collect::<Vec<String>>().join(", "));
        }
    }
}

impl ParseTreeVisitor<'_, NoteParserContextType> for EmoEngine {
    fn visit_terminal(&mut self, node: &TerminalNode<'_, NoteParserContextType>) {}

    fn visit_error_node(&mut self, node: &ErrorNode<'_, NoteParserContextType>) {
        self.handle_error_node(node);
    }
}

impl NoteVisitor<'_> for EmoEngine {
    fn visit_command(&mut self, ctx: &CommandContext<'_>) {
        if let Some(id) = ctx.ID() {
            let name = id.get_text();
            let mut args: Vec<Argument> = vec![];
            for arg in ctx.argument_all() {
                if let Some(string) = arg.STRING() {
                    args.push(Argument::String(string.get_text().to_string()));
                } else if let Some(number) = arg.NUMBER() {
                    args.push(Argument::Number(number.get_text().parse::<f64>().unwrap()));
                } 

                else if let Some(id) = arg.ID() {
                    args.push(Argument::Variable(id.get_text().to_string()));
                } else if let Some(dexp) = arg.DEXP() {
                    args.push(Argument::Expression(dexp.get_text().to_string()));
                }
            }

            match self.find_command(&name) {
                Some(cmd) => {
                    cmd.execute(self, &args);
                }
                None => {}
            }
        }
    }

    fn visit_argument(&mut self, ctx: &ArgumentContext<'_>) {
       if let Some(string) = ctx.STRING() {
            println!("String: {}", string.get_text());
        } else if let Some(number) = ctx.NUMBER() {
            println!("Number: {}", number.get_text());
        } 
        // else if let Some(list) = ctx.list() {
        //     println!("List: {:?}", list);
        // } 
        else if let Some(id) = ctx.ID() {
            println!("ID: {}", id.get_text());
        } else if let Some(dexp) = ctx.DEXP() {
            println!("Dynamic expression: {}", dexp.get_text());
        }
    }

    fn visit_task(&mut self, ctx: &TaskContext<'_>) {
        //tasks are command definitions with parameters

        let mut cmd = Cmd::new();
        let mut steps = vec![];
        match ctx.taskIdentifier() {
            Some(taskIdentifier) => {
                for identifier in taskIdentifier.identifier_all() {
                    cmd.add_name(identifier.get_text());
                }
                for parameter in taskIdentifier.parameter_all() {
                    let mut param = Param::new();
                    for prefix in parameter.PARAM() {
                        param.add_prefix(prefix.get_text());
                    }
                    for name in parameter.PARAM() {
                        param.add_name(name.get_text());
                    }
                    match parameter.valuetype() {
                        Some(valuetype) => {
                            param.set_default(self.evaluate_valuetype(&valuetype));
                        }
                        None => {}
                    }
                    cmd.add_param(param);
                }
            }
            None => {}
        }

        match ctx.taskBody() {
            Some(taskBody) => {
                for statement in taskBody.statement_all() {
                   //add statements to command
                   match statement.command(){
                       Some(command) => {
                            if let Some(id) = command.ID(){
                                steps.push(id.get_text().to_string());
                            }
                       }
                       None => {}
                   }
                }
            }
            None => {}
        }

        //add command to engine
        cmd.set_handler(|engine: &mut EmoEngine, args: &Vec<Argument>|{
            engine.handle_sequence(args);
        });

        self.register_command(cmd);
    }

    fn visit_loopStatement(&mut self, ctx: &LoopStatementContext<'_>) {
        match ctx.ID() {
            Some(id) => {
                let name = id.get_text();
                match ctx.valuetype() {
                    Some(valuetype) => {
                        let value = self.evaluate_valuetype(&valuetype);
                        match value {
                            Value::List(values) => {
                                for value in values {
                                    self.set_variable(name.to_string(), value);
                                    match ctx.taskBody() {
                                        Some(taskBody) => {
                                            self.visit_taskBody(&taskBody);
                                        }
                                        None => {}
                                    }
                                }
                            }
                            _ => {}
                        }
                    }
                    None => {}
                }
            }
            None => {}
        }
    }

    

    fn visit_conditionalStatement(&mut self, ctx: &ConditionalStatementContext<'_>) {
        match ctx.condition() {
            Some(condition) => {
                if self.evaluate_condition(&condition) {
                    match ctx.taskBody(0) {
                        Some(taskBody) => {
                            self.visit_taskBody(&taskBody);
                        }
                        None => {}
                    }
                } else {
                    match ctx.taskBody(1) {
                        Some(taskBody) => {
                            self.visit_taskBody(&taskBody);
                        }
                        None => {}
                    }
                }
            }
            None => {}
        }
    }

    fn visit_variableDeclaration(&mut self, ctx: &VariableDeclarationContext<'_>) {
        match ctx.ID() {
            Some(id) => {
                let name = id.get_text();
                match ctx.expression() {
                    Some(expression) => {
                        if let Some(value) = self.evaluate_expression(&expression) {
                            self.set_variable(name.to_string(), value);
                        }
                    }
                    None => {}
                }
            }
            None => {}
        }
    }

    fn visit_taskBody(&mut self, ctx: &TaskBodyContext<'_>) {
        for statement in ctx.statement_all() {
            self.visit_statement(&statement);
        }
    }
}

const FILEPATH: &str = "test.moto";

pub async fn parse() {
    let mut engine = EmoEngine::new();
    engine.load_file(FILEPATH).await.unwrap();
    engine.list_commands();
    engine.handle_command(r#"visit google
    click on search
    type "hello world" in search
    "#);
}
