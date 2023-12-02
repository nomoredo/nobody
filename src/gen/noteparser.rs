// Generated from Note.g4 by ANTLR 4.8
#![allow(dead_code)]
#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]
#![allow(nonstandard_style)]
#![allow(unused_imports)]
#![allow(unused_mut)]
#![allow(unused_braces)]
use antlr_rust::PredictionContextCache;
use antlr_rust::parser::{Parser, BaseParser, ParserRecog, ParserNodeType};
use antlr_rust::token_stream::TokenStream;
use antlr_rust::TokenSource;
use antlr_rust::parser_atn_simulator::ParserATNSimulator;
use antlr_rust::errors::*;
use antlr_rust::rule_context::{BaseRuleContext, CustomRuleContext, RuleContext};
use antlr_rust::recognizer::{Recognizer,Actions};
use antlr_rust::atn_deserializer::ATNDeserializer;
use antlr_rust::dfa::DFA;
use antlr_rust::atn::{ATN, INVALID_ALT};
use antlr_rust::error_strategy::{ErrorStrategy, DefaultErrorStrategy};
use antlr_rust::parser_rule_context::{BaseParserRuleContext, ParserRuleContext,cast,cast_mut};
use antlr_rust::tree::*;
use antlr_rust::token::{TOKEN_EOF,OwningToken,Token};
use antlr_rust::int_stream::EOF;
use antlr_rust::vocabulary::{Vocabulary,VocabularyImpl};
use antlr_rust::token_factory::{CommonTokenFactory,TokenFactory, TokenAware};
use super::notelistener::*;
use super::notevisitor::*;

use antlr_rust::lazy_static;
use antlr_rust::{TidAble,TidExt};

use std::marker::PhantomData;
use std::sync::Arc;
use std::rc::Rc;
use std::convert::TryFrom;
use std::cell::RefCell;
use std::ops::{DerefMut, Deref};
use std::borrow::{Borrow,BorrowMut};
use std::any::{Any,TypeId};

		pub const T__0:isize=1; 
		pub const T__1:isize=2; 
		pub const T__2:isize=3; 
		pub const T__3:isize=4; 
		pub const T__4:isize=5; 
		pub const COMMENT:isize=6; 
		pub const PARAM:isize=7; 
		pub const DEXP:isize=8; 
		pub const PIPE:isize=9; 
		pub const LET:isize=10; 
		pub const IN:isize=11; 
		pub const FOR:isize=12; 
		pub const IF:isize=13; 
		pub const ELSE:isize=14; 
		pub const COMMA:isize=15; 
		pub const EQUAL:isize=16; 
		pub const STRING:isize=17; 
		pub const NUMBER:isize=18; 
		pub const ID:isize=19; 
		pub const LB:isize=20; 
		pub const WS:isize=21; 
		pub const OPERATOR:isize=22; 
		pub const OPEXP:isize=23;
	pub const RULE_script:usize = 0; 
	pub const RULE_task:usize = 1; 
	pub const RULE_identifier:usize = 2; 
	pub const RULE_parameter:usize = 3; 
	pub const RULE_taskIdentifier:usize = 4; 
	pub const RULE_variableDeclaration:usize = 5; 
	pub const RULE_taskBody:usize = 6; 
	pub const RULE_statement:usize = 7; 
	pub const RULE_command:usize = 8; 
	pub const RULE_argument:usize = 9; 
	pub const RULE_loopStatement:usize = 10; 
	pub const RULE_conditionalStatement:usize = 11; 
	pub const RULE_condition:usize = 12; 
	pub const RULE_expression:usize = 13; 
	pub const RULE_idtype:usize = 14; 
	pub const RULE_valuetype:usize = 15; 
	pub const RULE_list:usize = 16; 
	pub const RULE_comment:usize = 17;
	pub const ruleNames: [&'static str; 18] =  [
		"script", "task", "identifier", "parameter", "taskIdentifier", "variableDeclaration", 
		"taskBody", "statement", "command", "argument", "loopStatement", "conditionalStatement", 
		"condition", "expression", "idtype", "valuetype", "list", "comment"
	];


	pub const _LITERAL_NAMES: [Option<&'static str>;17] = [
		None, Some("'task'"), Some("'['"), Some("']'"), Some("'{'"), Some("'}'"), 
		None, None, None, Some("'|'"), Some("'let'"), Some("'in'"), Some("'for'"), 
		Some("'if'"), Some("'else'"), Some("','"), Some("'='")
	];
	pub const _SYMBOLIC_NAMES: [Option<&'static str>;24]  = [
		None, None, None, None, None, None, Some("COMMENT"), Some("PARAM"), Some("DEXP"), 
		Some("PIPE"), Some("LET"), Some("IN"), Some("FOR"), Some("IF"), Some("ELSE"), 
		Some("COMMA"), Some("EQUAL"), Some("STRING"), Some("NUMBER"), Some("ID"), 
		Some("LB"), Some("WS"), Some("OPERATOR"), Some("OPEXP")
	];
	lazy_static!{
	    static ref _shared_context_cache: Arc<PredictionContextCache> = Arc::new(PredictionContextCache::new());
		static ref VOCABULARY: Box<dyn Vocabulary> = Box::new(VocabularyImpl::new(_LITERAL_NAMES.iter(), _SYMBOLIC_NAMES.iter(), None));
	}


type BaseParserType<'input, I> =
	BaseParser<'input,NoteParserExt<'input>, I, NoteParserContextType , dyn NoteListener<'input> + 'input >;

type TokenType<'input> = <LocalTokenFactory<'input> as TokenFactory<'input>>::Tok;
pub type LocalTokenFactory<'input> = CommonTokenFactory;

pub type NoteTreeWalker<'input,'a> =
	ParseTreeWalker<'input, 'a, NoteParserContextType , dyn NoteListener<'input> + 'a>;

/// Parser for Note grammar
pub struct NoteParser<'input,I,H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	base:BaseParserType<'input,I>,
	interpreter:Arc<ParserATNSimulator>,
	_shared_context_cache: Box<PredictionContextCache>,
    pub err_handler: H,
}

impl<'input, I, H> NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	pub fn get_serialized_atn() -> &'static str { _serializedATN }

    pub fn set_error_strategy(&mut self, strategy: H) {
        self.err_handler = strategy
    }

    pub fn with_strategy(input: I, strategy: H) -> Self {
		antlr_rust::recognizer::check_version("0","3");
		let interpreter = Arc::new(ParserATNSimulator::new(
			_ATN.clone(),
			_decision_to_DFA.clone(),
			_shared_context_cache.clone(),
		));
		Self {
			base: BaseParser::new_base_parser(
				input,
				Arc::clone(&interpreter),
				NoteParserExt{
					_pd: Default::default(),
				}
			),
			interpreter,
            _shared_context_cache: Box::new(PredictionContextCache::new()),
            err_handler: strategy,
        }
    }

}

type DynStrategy<'input,I> = Box<dyn ErrorStrategy<'input,BaseParserType<'input,I>> + 'input>;

impl<'input, I> NoteParser<'input, I, DynStrategy<'input,I>>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
{
    pub fn with_dyn_strategy(input: I) -> Self{
    	Self::with_strategy(input,Box::new(DefaultErrorStrategy::new()))
    }
}

impl<'input, I> NoteParser<'input, I, DefaultErrorStrategy<'input,NoteParserContextType>>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
{
    pub fn new(input: I) -> Self{
    	Self::with_strategy(input,DefaultErrorStrategy::new())
    }
}

/// Trait for monomorphized trait object that corresponds to the nodes of parse tree generated for NoteParser
pub trait NoteParserContext<'input>:
	for<'x> Listenable<dyn NoteListener<'input> + 'x > + 
	for<'x> Visitable<dyn NoteVisitor<'input> + 'x > + 
	ParserRuleContext<'input, TF=LocalTokenFactory<'input>, Ctx=NoteParserContextType>
{}

antlr_rust::coerce_from!{ 'input : NoteParserContext<'input> }

impl<'input, 'x, T> VisitableDyn<T> for dyn NoteParserContext<'input> + 'input
where
    T: NoteVisitor<'input> + 'x,
{
    fn accept_dyn(&self, visitor: &mut T) {
        self.accept(visitor as &mut (dyn NoteVisitor<'input> + 'x))
    }
}

impl<'input> NoteParserContext<'input> for TerminalNode<'input,NoteParserContextType> {}
impl<'input> NoteParserContext<'input> for ErrorNode<'input,NoteParserContextType> {}

antlr_rust::tid! { impl<'input> TidAble<'input> for dyn NoteParserContext<'input> + 'input }

antlr_rust::tid! { impl<'input> TidAble<'input> for dyn NoteListener<'input> + 'input }

pub struct NoteParserContextType;
antlr_rust::tid!{NoteParserContextType}

impl<'input> ParserNodeType<'input> for NoteParserContextType{
	type TF = LocalTokenFactory<'input>;
	type Type = dyn NoteParserContext<'input> + 'input;
}

impl<'input, I, H> Deref for NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
    type Target = BaseParserType<'input,I>;

    fn deref(&self) -> &Self::Target {
        &self.base
    }
}

impl<'input, I, H> DerefMut for NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
    fn deref_mut(&mut self) -> &mut Self::Target {
        &mut self.base
    }
}

pub struct NoteParserExt<'input>{
	_pd: PhantomData<&'input str>,
}

impl<'input> NoteParserExt<'input>{
}
antlr_rust::tid! { NoteParserExt<'a> }

impl<'input> TokenAware<'input> for NoteParserExt<'input>{
	type TF = LocalTokenFactory<'input>;
}

impl<'input,I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>> ParserRecog<'input, BaseParserType<'input,I>> for NoteParserExt<'input>{}

impl<'input,I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>> Actions<'input, BaseParserType<'input,I>> for NoteParserExt<'input>{
	fn get_grammar_file_name(&self) -> & str{ "Note.g4"}

   	fn get_rule_names(&self) -> &[& str] {&ruleNames}

   	fn get_vocabulary(&self) -> &dyn Vocabulary { &**VOCABULARY }
}
//------------------- script ----------------
pub type ScriptContextAll<'input> = ScriptContext<'input>;


pub type ScriptContext<'input> = BaseParserRuleContext<'input,ScriptContextExt<'input>>;

#[derive(Clone)]
pub struct ScriptContextExt<'input>{
ph:PhantomData<&'input str>
}

impl<'input> NoteParserContext<'input> for ScriptContext<'input>{}

impl<'input,'a> Listenable<dyn NoteListener<'input> + 'a> for ScriptContext<'input>{
		fn enter(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.enter_every_rule(self);
			listener.enter_script(self);
		}
		fn exit(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.exit_script(self);
			listener.exit_every_rule(self);
		}
}

impl<'input,'a> Visitable<dyn NoteVisitor<'input> + 'a> for ScriptContext<'input>{
	fn accept(&self,visitor: &mut (dyn NoteVisitor<'input> + 'a)) {
		visitor.visit_script(self);
	}
}

impl<'input> CustomRuleContext<'input> for ScriptContextExt<'input>{
	type TF = LocalTokenFactory<'input>;
	type Ctx = NoteParserContextType;
	fn get_rule_index(&self) -> usize { RULE_script }
	//fn type_rule_index() -> usize where Self: Sized { RULE_script }
}
antlr_rust::tid!{ScriptContextExt<'a>}

impl<'input> ScriptContextExt<'input>{
	fn new(parent: Option<Rc<dyn NoteParserContext<'input> + 'input > >, invoking_state: isize) -> Rc<ScriptContextAll<'input>> {
		Rc::new(
			BaseParserRuleContext::new_parser_ctx(parent, invoking_state,ScriptContextExt{
				ph:PhantomData
			}),
		)
	}
}

pub trait ScriptContextAttrs<'input>: NoteParserContext<'input> + BorrowMut<ScriptContextExt<'input>>{

/// Retrieves first TerminalNode corresponding to token EOF
/// Returns `None` if there is no child corresponding to token EOF
fn EOF(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(EOF, 0)
}
fn task_all(&self) ->  Vec<Rc<TaskContextAll<'input>>> where Self:Sized{
	self.children_of_type()
}
fn task(&self, i: usize) -> Option<Rc<TaskContextAll<'input>>> where Self:Sized{
	self.child_of_type(i)
}
fn statement_all(&self) ->  Vec<Rc<StatementContextAll<'input>>> where Self:Sized{
	self.children_of_type()
}
fn statement(&self, i: usize) -> Option<Rc<StatementContextAll<'input>>> where Self:Sized{
	self.child_of_type(i)
}
fn comment_all(&self) ->  Vec<Rc<CommentContextAll<'input>>> where Self:Sized{
	self.children_of_type()
}
fn comment(&self, i: usize) -> Option<Rc<CommentContextAll<'input>>> where Self:Sized{
	self.child_of_type(i)
}

}

impl<'input> ScriptContextAttrs<'input> for ScriptContext<'input>{}

impl<'input, I, H> NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	pub fn script(&mut self,)
	-> Result<Rc<ScriptContextAll<'input>>,ANTLRError> {
		let mut recog = self;
		let _parentctx = recog.ctx.take();
		let mut _localctx = ScriptContextExt::new(_parentctx.clone(), recog.base.get_state());
        recog.base.enter_rule(_localctx.clone(), 0, RULE_script);
        let mut _localctx: Rc<ScriptContextAll> = _localctx;
		let mut _la: isize = -1;
		let result: Result<(), ANTLRError> = (|| {

			//recog.base.enter_outer_alt(_localctx.clone(), 1);
			recog.base.enter_outer_alt(None, 1);
			{
			recog.base.set_state(41);
			recog.err_handler.sync(&mut recog.base)?;
			_la = recog.base.input.la(1);
			while (((_la) & !0x3f) == 0 && ((1usize << _la) & ((1usize << T__0) | (1usize << COMMENT) | (1usize << LET) | (1usize << FOR) | (1usize << IF) | (1usize << ID))) != 0) {
				{
				recog.base.set_state(39);
				recog.err_handler.sync(&mut recog.base)?;
				match recog.base.input.la(1) {
				 T__0 
					=> {
						{
						/*InvokeRule task*/
						recog.base.set_state(36);
						recog.task()?;

						}
					}

				 LET | FOR | IF | ID 
					=> {
						{
						/*InvokeRule statement*/
						recog.base.set_state(37);
						recog.statement()?;

						}
					}

				 COMMENT 
					=> {
						{
						/*InvokeRule comment*/
						recog.base.set_state(38);
						recog.comment()?;

						}
					}

					_ => Err(ANTLRError::NoAltError(NoViableAltError::new(&mut recog.base)))?
				}
				}
				recog.base.set_state(43);
				recog.err_handler.sync(&mut recog.base)?;
				_la = recog.base.input.la(1);
			}
			recog.base.set_state(44);
			recog.base.match_token(EOF,&mut recog.err_handler)?;

			}
			Ok(())
		})();
		match result {
		Ok(_)=>{},
        Err(e @ ANTLRError::FallThrough(_)) => return Err(e),
		Err(ref re) => {
				//_localctx.exception = re;
				recog.err_handler.report_error(&mut recog.base, re);
				recog.err_handler.recover(&mut recog.base, re)?;
			}
		}
		recog.base.exit_rule();

		Ok(_localctx)
	}
}
//------------------- task ----------------
pub type TaskContextAll<'input> = TaskContext<'input>;


pub type TaskContext<'input> = BaseParserRuleContext<'input,TaskContextExt<'input>>;

#[derive(Clone)]
pub struct TaskContextExt<'input>{
ph:PhantomData<&'input str>
}

impl<'input> NoteParserContext<'input> for TaskContext<'input>{}

impl<'input,'a> Listenable<dyn NoteListener<'input> + 'a> for TaskContext<'input>{
		fn enter(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.enter_every_rule(self);
			listener.enter_task(self);
		}
		fn exit(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.exit_task(self);
			listener.exit_every_rule(self);
		}
}

impl<'input,'a> Visitable<dyn NoteVisitor<'input> + 'a> for TaskContext<'input>{
	fn accept(&self,visitor: &mut (dyn NoteVisitor<'input> + 'a)) {
		visitor.visit_task(self);
	}
}

impl<'input> CustomRuleContext<'input> for TaskContextExt<'input>{
	type TF = LocalTokenFactory<'input>;
	type Ctx = NoteParserContextType;
	fn get_rule_index(&self) -> usize { RULE_task }
	//fn type_rule_index() -> usize where Self: Sized { RULE_task }
}
antlr_rust::tid!{TaskContextExt<'a>}

impl<'input> TaskContextExt<'input>{
	fn new(parent: Option<Rc<dyn NoteParserContext<'input> + 'input > >, invoking_state: isize) -> Rc<TaskContextAll<'input>> {
		Rc::new(
			BaseParserRuleContext::new_parser_ctx(parent, invoking_state,TaskContextExt{
				ph:PhantomData
			}),
		)
	}
}

pub trait TaskContextAttrs<'input>: NoteParserContext<'input> + BorrowMut<TaskContextExt<'input>>{

fn taskIdentifier(&self) -> Option<Rc<TaskIdentifierContextAll<'input>>> where Self:Sized{
	self.child_of_type(0)
}
fn taskBody(&self) -> Option<Rc<TaskBodyContextAll<'input>>> where Self:Sized{
	self.child_of_type(0)
}

}

impl<'input> TaskContextAttrs<'input> for TaskContext<'input>{}

impl<'input, I, H> NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	pub fn task(&mut self,)
	-> Result<Rc<TaskContextAll<'input>>,ANTLRError> {
		let mut recog = self;
		let _parentctx = recog.ctx.take();
		let mut _localctx = TaskContextExt::new(_parentctx.clone(), recog.base.get_state());
        recog.base.enter_rule(_localctx.clone(), 2, RULE_task);
        let mut _localctx: Rc<TaskContextAll> = _localctx;
		let result: Result<(), ANTLRError> = (|| {

			//recog.base.enter_outer_alt(_localctx.clone(), 1);
			recog.base.enter_outer_alt(None, 1);
			{
			recog.base.set_state(46);
			recog.base.match_token(T__0,&mut recog.err_handler)?;

			/*InvokeRule taskIdentifier*/
			recog.base.set_state(47);
			recog.taskIdentifier()?;

			/*InvokeRule taskBody*/
			recog.base.set_state(48);
			recog.taskBody()?;

			}
			Ok(())
		})();
		match result {
		Ok(_)=>{},
        Err(e @ ANTLRError::FallThrough(_)) => return Err(e),
		Err(ref re) => {
				//_localctx.exception = re;
				recog.err_handler.report_error(&mut recog.base, re);
				recog.err_handler.recover(&mut recog.base, re)?;
			}
		}
		recog.base.exit_rule();

		Ok(_localctx)
	}
}
//------------------- identifier ----------------
pub type IdentifierContextAll<'input> = IdentifierContext<'input>;


pub type IdentifierContext<'input> = BaseParserRuleContext<'input,IdentifierContextExt<'input>>;

#[derive(Clone)]
pub struct IdentifierContextExt<'input>{
ph:PhantomData<&'input str>
}

impl<'input> NoteParserContext<'input> for IdentifierContext<'input>{}

impl<'input,'a> Listenable<dyn NoteListener<'input> + 'a> for IdentifierContext<'input>{
		fn enter(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.enter_every_rule(self);
			listener.enter_identifier(self);
		}
		fn exit(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.exit_identifier(self);
			listener.exit_every_rule(self);
		}
}

impl<'input,'a> Visitable<dyn NoteVisitor<'input> + 'a> for IdentifierContext<'input>{
	fn accept(&self,visitor: &mut (dyn NoteVisitor<'input> + 'a)) {
		visitor.visit_identifier(self);
	}
}

impl<'input> CustomRuleContext<'input> for IdentifierContextExt<'input>{
	type TF = LocalTokenFactory<'input>;
	type Ctx = NoteParserContextType;
	fn get_rule_index(&self) -> usize { RULE_identifier }
	//fn type_rule_index() -> usize where Self: Sized { RULE_identifier }
}
antlr_rust::tid!{IdentifierContextExt<'a>}

impl<'input> IdentifierContextExt<'input>{
	fn new(parent: Option<Rc<dyn NoteParserContext<'input> + 'input > >, invoking_state: isize) -> Rc<IdentifierContextAll<'input>> {
		Rc::new(
			BaseParserRuleContext::new_parser_ctx(parent, invoking_state,IdentifierContextExt{
				ph:PhantomData
			}),
		)
	}
}

pub trait IdentifierContextAttrs<'input>: NoteParserContext<'input> + BorrowMut<IdentifierContextExt<'input>>{

/// Retrieves all `TerminalNode`s corresponding to token ID in current rule
fn ID_all(&self) -> Vec<Rc<TerminalNode<'input,NoteParserContextType>>>  where Self:Sized{
	self.children_of_type()
}
/// Retrieves 'i's TerminalNode corresponding to token ID, starting from 0.
/// Returns `None` if number of children corresponding to token ID is less or equal than `i`.
fn ID(&self, i: usize) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(ID, i)
}
/// Retrieves all `TerminalNode`s corresponding to token PIPE in current rule
fn PIPE_all(&self) -> Vec<Rc<TerminalNode<'input,NoteParserContextType>>>  where Self:Sized{
	self.children_of_type()
}
/// Retrieves 'i's TerminalNode corresponding to token PIPE, starting from 0.
/// Returns `None` if number of children corresponding to token PIPE is less or equal than `i`.
fn PIPE(&self, i: usize) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(PIPE, i)
}

}

impl<'input> IdentifierContextAttrs<'input> for IdentifierContext<'input>{}

impl<'input, I, H> NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	pub fn identifier(&mut self,)
	-> Result<Rc<IdentifierContextAll<'input>>,ANTLRError> {
		let mut recog = self;
		let _parentctx = recog.ctx.take();
		let mut _localctx = IdentifierContextExt::new(_parentctx.clone(), recog.base.get_state());
        recog.base.enter_rule(_localctx.clone(), 4, RULE_identifier);
        let mut _localctx: Rc<IdentifierContextAll> = _localctx;
		let mut _la: isize = -1;
		let result: Result<(), ANTLRError> = (|| {

			//recog.base.enter_outer_alt(_localctx.clone(), 1);
			recog.base.enter_outer_alt(None, 1);
			{
			recog.base.set_state(50);
			recog.base.match_token(ID,&mut recog.err_handler)?;

			recog.base.set_state(55);
			recog.err_handler.sync(&mut recog.base)?;
			_la = recog.base.input.la(1);
			while _la==PIPE {
				{
				{
				recog.base.set_state(51);
				recog.base.match_token(PIPE,&mut recog.err_handler)?;

				recog.base.set_state(52);
				recog.base.match_token(ID,&mut recog.err_handler)?;

				}
				}
				recog.base.set_state(57);
				recog.err_handler.sync(&mut recog.base)?;
				_la = recog.base.input.la(1);
			}
			}
			Ok(())
		})();
		match result {
		Ok(_)=>{},
        Err(e @ ANTLRError::FallThrough(_)) => return Err(e),
		Err(ref re) => {
				//_localctx.exception = re;
				recog.err_handler.report_error(&mut recog.base, re);
				recog.err_handler.recover(&mut recog.base, re)?;
			}
		}
		recog.base.exit_rule();

		Ok(_localctx)
	}
}
//------------------- parameter ----------------
pub type ParameterContextAll<'input> = ParameterContext<'input>;


pub type ParameterContext<'input> = BaseParserRuleContext<'input,ParameterContextExt<'input>>;

#[derive(Clone)]
pub struct ParameterContextExt<'input>{
ph:PhantomData<&'input str>
}

impl<'input> NoteParserContext<'input> for ParameterContext<'input>{}

impl<'input,'a> Listenable<dyn NoteListener<'input> + 'a> for ParameterContext<'input>{
		fn enter(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.enter_every_rule(self);
			listener.enter_parameter(self);
		}
		fn exit(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.exit_parameter(self);
			listener.exit_every_rule(self);
		}
}

impl<'input,'a> Visitable<dyn NoteVisitor<'input> + 'a> for ParameterContext<'input>{
	fn accept(&self,visitor: &mut (dyn NoteVisitor<'input> + 'a)) {
		visitor.visit_parameter(self);
	}
}

impl<'input> CustomRuleContext<'input> for ParameterContextExt<'input>{
	type TF = LocalTokenFactory<'input>;
	type Ctx = NoteParserContextType;
	fn get_rule_index(&self) -> usize { RULE_parameter }
	//fn type_rule_index() -> usize where Self: Sized { RULE_parameter }
}
antlr_rust::tid!{ParameterContextExt<'a>}

impl<'input> ParameterContextExt<'input>{
	fn new(parent: Option<Rc<dyn NoteParserContext<'input> + 'input > >, invoking_state: isize) -> Rc<ParameterContextAll<'input>> {
		Rc::new(
			BaseParserRuleContext::new_parser_ctx(parent, invoking_state,ParameterContextExt{
				ph:PhantomData
			}),
		)
	}
}

pub trait ParameterContextAttrs<'input>: NoteParserContext<'input> + BorrowMut<ParameterContextExt<'input>>{

/// Retrieves first TerminalNode corresponding to token PARAM
/// Returns `None` if there is no child corresponding to token PARAM
fn PARAM(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(PARAM, 0)
}
fn identifier(&self) -> Option<Rc<IdentifierContextAll<'input>>> where Self:Sized{
	self.child_of_type(0)
}
/// Retrieves first TerminalNode corresponding to token EQUAL
/// Returns `None` if there is no child corresponding to token EQUAL
fn EQUAL(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(EQUAL, 0)
}
fn valuetype(&self) -> Option<Rc<ValuetypeContextAll<'input>>> where Self:Sized{
	self.child_of_type(0)
}

}

impl<'input> ParameterContextAttrs<'input> for ParameterContext<'input>{}

impl<'input, I, H> NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	pub fn parameter(&mut self,)
	-> Result<Rc<ParameterContextAll<'input>>,ANTLRError> {
		let mut recog = self;
		let _parentctx = recog.ctx.take();
		let mut _localctx = ParameterContextExt::new(_parentctx.clone(), recog.base.get_state());
        recog.base.enter_rule(_localctx.clone(), 6, RULE_parameter);
        let mut _localctx: Rc<ParameterContextAll> = _localctx;
		let mut _la: isize = -1;
		let result: Result<(), ANTLRError> = (|| {

			//recog.base.enter_outer_alt(_localctx.clone(), 1);
			recog.base.enter_outer_alt(None, 1);
			{
			recog.base.set_state(58);
			recog.base.match_token(T__1,&mut recog.err_handler)?;

			recog.base.set_state(60);
			recog.err_handler.sync(&mut recog.base)?;
			_la = recog.base.input.la(1);
			if _la==ID {
				{
				/*InvokeRule identifier*/
				recog.base.set_state(59);
				recog.identifier()?;

				}
			}

			{
			recog.base.set_state(62);
			recog.base.match_token(PARAM,&mut recog.err_handler)?;

			}
			recog.base.set_state(65);
			recog.err_handler.sync(&mut recog.base)?;
			_la = recog.base.input.la(1);
			if _la==EQUAL {
				{
				recog.base.set_state(63);
				recog.base.match_token(EQUAL,&mut recog.err_handler)?;

				/*InvokeRule valuetype*/
				recog.base.set_state(64);
				recog.valuetype()?;

				}
			}

			recog.base.set_state(67);
			recog.base.match_token(T__2,&mut recog.err_handler)?;

			}
			Ok(())
		})();
		match result {
		Ok(_)=>{},
        Err(e @ ANTLRError::FallThrough(_)) => return Err(e),
		Err(ref re) => {
				//_localctx.exception = re;
				recog.err_handler.report_error(&mut recog.base, re);
				recog.err_handler.recover(&mut recog.base, re)?;
			}
		}
		recog.base.exit_rule();

		Ok(_localctx)
	}
}
//------------------- taskIdentifier ----------------
pub type TaskIdentifierContextAll<'input> = TaskIdentifierContext<'input>;


pub type TaskIdentifierContext<'input> = BaseParserRuleContext<'input,TaskIdentifierContextExt<'input>>;

#[derive(Clone)]
pub struct TaskIdentifierContextExt<'input>{
ph:PhantomData<&'input str>
}

impl<'input> NoteParserContext<'input> for TaskIdentifierContext<'input>{}

impl<'input,'a> Listenable<dyn NoteListener<'input> + 'a> for TaskIdentifierContext<'input>{
		fn enter(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.enter_every_rule(self);
			listener.enter_taskIdentifier(self);
		}
		fn exit(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.exit_taskIdentifier(self);
			listener.exit_every_rule(self);
		}
}

impl<'input,'a> Visitable<dyn NoteVisitor<'input> + 'a> for TaskIdentifierContext<'input>{
	fn accept(&self,visitor: &mut (dyn NoteVisitor<'input> + 'a)) {
		visitor.visit_taskIdentifier(self);
	}
}

impl<'input> CustomRuleContext<'input> for TaskIdentifierContextExt<'input>{
	type TF = LocalTokenFactory<'input>;
	type Ctx = NoteParserContextType;
	fn get_rule_index(&self) -> usize { RULE_taskIdentifier }
	//fn type_rule_index() -> usize where Self: Sized { RULE_taskIdentifier }
}
antlr_rust::tid!{TaskIdentifierContextExt<'a>}

impl<'input> TaskIdentifierContextExt<'input>{
	fn new(parent: Option<Rc<dyn NoteParserContext<'input> + 'input > >, invoking_state: isize) -> Rc<TaskIdentifierContextAll<'input>> {
		Rc::new(
			BaseParserRuleContext::new_parser_ctx(parent, invoking_state,TaskIdentifierContextExt{
				ph:PhantomData
			}),
		)
	}
}

pub trait TaskIdentifierContextAttrs<'input>: NoteParserContext<'input> + BorrowMut<TaskIdentifierContextExt<'input>>{

fn identifier_all(&self) ->  Vec<Rc<IdentifierContextAll<'input>>> where Self:Sized{
	self.children_of_type()
}
fn identifier(&self, i: usize) -> Option<Rc<IdentifierContextAll<'input>>> where Self:Sized{
	self.child_of_type(i)
}
fn parameter_all(&self) ->  Vec<Rc<ParameterContextAll<'input>>> where Self:Sized{
	self.children_of_type()
}
fn parameter(&self, i: usize) -> Option<Rc<ParameterContextAll<'input>>> where Self:Sized{
	self.child_of_type(i)
}

}

impl<'input> TaskIdentifierContextAttrs<'input> for TaskIdentifierContext<'input>{}

impl<'input, I, H> NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	pub fn taskIdentifier(&mut self,)
	-> Result<Rc<TaskIdentifierContextAll<'input>>,ANTLRError> {
		let mut recog = self;
		let _parentctx = recog.ctx.take();
		let mut _localctx = TaskIdentifierContextExt::new(_parentctx.clone(), recog.base.get_state());
        recog.base.enter_rule(_localctx.clone(), 8, RULE_taskIdentifier);
        let mut _localctx: Rc<TaskIdentifierContextAll> = _localctx;
		let mut _la: isize = -1;
		let result: Result<(), ANTLRError> = (|| {

			//recog.base.enter_outer_alt(_localctx.clone(), 1);
			recog.base.enter_outer_alt(None, 1);
			{
			/*InvokeRule identifier*/
			recog.base.set_state(69);
			recog.identifier()?;

			recog.base.set_state(74);
			recog.err_handler.sync(&mut recog.base)?;
			_la = recog.base.input.la(1);
			while _la==T__1 || _la==ID {
				{
				recog.base.set_state(72);
				recog.err_handler.sync(&mut recog.base)?;
				match recog.base.input.la(1) {
				 ID 
					=> {
						{
						/*InvokeRule identifier*/
						recog.base.set_state(70);
						recog.identifier()?;

						}
					}

				 T__1 
					=> {
						{
						/*InvokeRule parameter*/
						recog.base.set_state(71);
						recog.parameter()?;

						}
					}

					_ => Err(ANTLRError::NoAltError(NoViableAltError::new(&mut recog.base)))?
				}
				}
				recog.base.set_state(76);
				recog.err_handler.sync(&mut recog.base)?;
				_la = recog.base.input.la(1);
			}
			}
			Ok(())
		})();
		match result {
		Ok(_)=>{},
        Err(e @ ANTLRError::FallThrough(_)) => return Err(e),
		Err(ref re) => {
				//_localctx.exception = re;
				recog.err_handler.report_error(&mut recog.base, re);
				recog.err_handler.recover(&mut recog.base, re)?;
			}
		}
		recog.base.exit_rule();

		Ok(_localctx)
	}
}
//------------------- variableDeclaration ----------------
pub type VariableDeclarationContextAll<'input> = VariableDeclarationContext<'input>;


pub type VariableDeclarationContext<'input> = BaseParserRuleContext<'input,VariableDeclarationContextExt<'input>>;

#[derive(Clone)]
pub struct VariableDeclarationContextExt<'input>{
ph:PhantomData<&'input str>
}

impl<'input> NoteParserContext<'input> for VariableDeclarationContext<'input>{}

impl<'input,'a> Listenable<dyn NoteListener<'input> + 'a> for VariableDeclarationContext<'input>{
		fn enter(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.enter_every_rule(self);
			listener.enter_variableDeclaration(self);
		}
		fn exit(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.exit_variableDeclaration(self);
			listener.exit_every_rule(self);
		}
}

impl<'input,'a> Visitable<dyn NoteVisitor<'input> + 'a> for VariableDeclarationContext<'input>{
	fn accept(&self,visitor: &mut (dyn NoteVisitor<'input> + 'a)) {
		visitor.visit_variableDeclaration(self);
	}
}

impl<'input> CustomRuleContext<'input> for VariableDeclarationContextExt<'input>{
	type TF = LocalTokenFactory<'input>;
	type Ctx = NoteParserContextType;
	fn get_rule_index(&self) -> usize { RULE_variableDeclaration }
	//fn type_rule_index() -> usize where Self: Sized { RULE_variableDeclaration }
}
antlr_rust::tid!{VariableDeclarationContextExt<'a>}

impl<'input> VariableDeclarationContextExt<'input>{
	fn new(parent: Option<Rc<dyn NoteParserContext<'input> + 'input > >, invoking_state: isize) -> Rc<VariableDeclarationContextAll<'input>> {
		Rc::new(
			BaseParserRuleContext::new_parser_ctx(parent, invoking_state,VariableDeclarationContextExt{
				ph:PhantomData
			}),
		)
	}
}

pub trait VariableDeclarationContextAttrs<'input>: NoteParserContext<'input> + BorrowMut<VariableDeclarationContextExt<'input>>{

/// Retrieves first TerminalNode corresponding to token LET
/// Returns `None` if there is no child corresponding to token LET
fn LET(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(LET, 0)
}
/// Retrieves first TerminalNode corresponding to token ID
/// Returns `None` if there is no child corresponding to token ID
fn ID(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(ID, 0)
}
/// Retrieves first TerminalNode corresponding to token EQUAL
/// Returns `None` if there is no child corresponding to token EQUAL
fn EQUAL(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(EQUAL, 0)
}
fn expression(&self) -> Option<Rc<ExpressionContextAll<'input>>> where Self:Sized{
	self.child_of_type(0)
}

}

impl<'input> VariableDeclarationContextAttrs<'input> for VariableDeclarationContext<'input>{}

impl<'input, I, H> NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	pub fn variableDeclaration(&mut self,)
	-> Result<Rc<VariableDeclarationContextAll<'input>>,ANTLRError> {
		let mut recog = self;
		let _parentctx = recog.ctx.take();
		let mut _localctx = VariableDeclarationContextExt::new(_parentctx.clone(), recog.base.get_state());
        recog.base.enter_rule(_localctx.clone(), 10, RULE_variableDeclaration);
        let mut _localctx: Rc<VariableDeclarationContextAll> = _localctx;
		let result: Result<(), ANTLRError> = (|| {

			//recog.base.enter_outer_alt(_localctx.clone(), 1);
			recog.base.enter_outer_alt(None, 1);
			{
			recog.base.set_state(77);
			recog.base.match_token(LET,&mut recog.err_handler)?;

			recog.base.set_state(78);
			recog.base.match_token(ID,&mut recog.err_handler)?;

			recog.base.set_state(79);
			recog.base.match_token(EQUAL,&mut recog.err_handler)?;

			/*InvokeRule expression*/
			recog.base.set_state(80);
			recog.expression()?;

			}
			Ok(())
		})();
		match result {
		Ok(_)=>{},
        Err(e @ ANTLRError::FallThrough(_)) => return Err(e),
		Err(ref re) => {
				//_localctx.exception = re;
				recog.err_handler.report_error(&mut recog.base, re);
				recog.err_handler.recover(&mut recog.base, re)?;
			}
		}
		recog.base.exit_rule();

		Ok(_localctx)
	}
}
//------------------- taskBody ----------------
pub type TaskBodyContextAll<'input> = TaskBodyContext<'input>;


pub type TaskBodyContext<'input> = BaseParserRuleContext<'input,TaskBodyContextExt<'input>>;

#[derive(Clone)]
pub struct TaskBodyContextExt<'input>{
ph:PhantomData<&'input str>
}

impl<'input> NoteParserContext<'input> for TaskBodyContext<'input>{}

impl<'input,'a> Listenable<dyn NoteListener<'input> + 'a> for TaskBodyContext<'input>{
		fn enter(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.enter_every_rule(self);
			listener.enter_taskBody(self);
		}
		fn exit(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.exit_taskBody(self);
			listener.exit_every_rule(self);
		}
}

impl<'input,'a> Visitable<dyn NoteVisitor<'input> + 'a> for TaskBodyContext<'input>{
	fn accept(&self,visitor: &mut (dyn NoteVisitor<'input> + 'a)) {
		visitor.visit_taskBody(self);
	}
}

impl<'input> CustomRuleContext<'input> for TaskBodyContextExt<'input>{
	type TF = LocalTokenFactory<'input>;
	type Ctx = NoteParserContextType;
	fn get_rule_index(&self) -> usize { RULE_taskBody }
	//fn type_rule_index() -> usize where Self: Sized { RULE_taskBody }
}
antlr_rust::tid!{TaskBodyContextExt<'a>}

impl<'input> TaskBodyContextExt<'input>{
	fn new(parent: Option<Rc<dyn NoteParserContext<'input> + 'input > >, invoking_state: isize) -> Rc<TaskBodyContextAll<'input>> {
		Rc::new(
			BaseParserRuleContext::new_parser_ctx(parent, invoking_state,TaskBodyContextExt{
				ph:PhantomData
			}),
		)
	}
}

pub trait TaskBodyContextAttrs<'input>: NoteParserContext<'input> + BorrowMut<TaskBodyContextExt<'input>>{

fn statement_all(&self) ->  Vec<Rc<StatementContextAll<'input>>> where Self:Sized{
	self.children_of_type()
}
fn statement(&self, i: usize) -> Option<Rc<StatementContextAll<'input>>> where Self:Sized{
	self.child_of_type(i)
}

}

impl<'input> TaskBodyContextAttrs<'input> for TaskBodyContext<'input>{}

impl<'input, I, H> NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	pub fn taskBody(&mut self,)
	-> Result<Rc<TaskBodyContextAll<'input>>,ANTLRError> {
		let mut recog = self;
		let _parentctx = recog.ctx.take();
		let mut _localctx = TaskBodyContextExt::new(_parentctx.clone(), recog.base.get_state());
        recog.base.enter_rule(_localctx.clone(), 12, RULE_taskBody);
        let mut _localctx: Rc<TaskBodyContextAll> = _localctx;
		let mut _la: isize = -1;
		let result: Result<(), ANTLRError> = (|| {

			//recog.base.enter_outer_alt(_localctx.clone(), 1);
			recog.base.enter_outer_alt(None, 1);
			{
			recog.base.set_state(82);
			recog.base.match_token(T__3,&mut recog.err_handler)?;

			recog.base.set_state(86);
			recog.err_handler.sync(&mut recog.base)?;
			_la = recog.base.input.la(1);
			while (((_la) & !0x3f) == 0 && ((1usize << _la) & ((1usize << LET) | (1usize << FOR) | (1usize << IF) | (1usize << ID))) != 0) {
				{
				{
				/*InvokeRule statement*/
				recog.base.set_state(83);
				recog.statement()?;

				}
				}
				recog.base.set_state(88);
				recog.err_handler.sync(&mut recog.base)?;
				_la = recog.base.input.la(1);
			}
			recog.base.set_state(89);
			recog.base.match_token(T__4,&mut recog.err_handler)?;

			}
			Ok(())
		})();
		match result {
		Ok(_)=>{},
        Err(e @ ANTLRError::FallThrough(_)) => return Err(e),
		Err(ref re) => {
				//_localctx.exception = re;
				recog.err_handler.report_error(&mut recog.base, re);
				recog.err_handler.recover(&mut recog.base, re)?;
			}
		}
		recog.base.exit_rule();

		Ok(_localctx)
	}
}
//------------------- statement ----------------
pub type StatementContextAll<'input> = StatementContext<'input>;


pub type StatementContext<'input> = BaseParserRuleContext<'input,StatementContextExt<'input>>;

#[derive(Clone)]
pub struct StatementContextExt<'input>{
ph:PhantomData<&'input str>
}

impl<'input> NoteParserContext<'input> for StatementContext<'input>{}

impl<'input,'a> Listenable<dyn NoteListener<'input> + 'a> for StatementContext<'input>{
		fn enter(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.enter_every_rule(self);
			listener.enter_statement(self);
		}
		fn exit(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.exit_statement(self);
			listener.exit_every_rule(self);
		}
}

impl<'input,'a> Visitable<dyn NoteVisitor<'input> + 'a> for StatementContext<'input>{
	fn accept(&self,visitor: &mut (dyn NoteVisitor<'input> + 'a)) {
		visitor.visit_statement(self);
	}
}

impl<'input> CustomRuleContext<'input> for StatementContextExt<'input>{
	type TF = LocalTokenFactory<'input>;
	type Ctx = NoteParserContextType;
	fn get_rule_index(&self) -> usize { RULE_statement }
	//fn type_rule_index() -> usize where Self: Sized { RULE_statement }
}
antlr_rust::tid!{StatementContextExt<'a>}

impl<'input> StatementContextExt<'input>{
	fn new(parent: Option<Rc<dyn NoteParserContext<'input> + 'input > >, invoking_state: isize) -> Rc<StatementContextAll<'input>> {
		Rc::new(
			BaseParserRuleContext::new_parser_ctx(parent, invoking_state,StatementContextExt{
				ph:PhantomData
			}),
		)
	}
}

pub trait StatementContextAttrs<'input>: NoteParserContext<'input> + BorrowMut<StatementContextExt<'input>>{

fn command(&self) -> Option<Rc<CommandContextAll<'input>>> where Self:Sized{
	self.child_of_type(0)
}
fn loopStatement(&self) -> Option<Rc<LoopStatementContextAll<'input>>> where Self:Sized{
	self.child_of_type(0)
}
fn conditionalStatement(&self) -> Option<Rc<ConditionalStatementContextAll<'input>>> where Self:Sized{
	self.child_of_type(0)
}
fn variableDeclaration(&self) -> Option<Rc<VariableDeclarationContextAll<'input>>> where Self:Sized{
	self.child_of_type(0)
}

}

impl<'input> StatementContextAttrs<'input> for StatementContext<'input>{}

impl<'input, I, H> NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	pub fn statement(&mut self,)
	-> Result<Rc<StatementContextAll<'input>>,ANTLRError> {
		let mut recog = self;
		let _parentctx = recog.ctx.take();
		let mut _localctx = StatementContextExt::new(_parentctx.clone(), recog.base.get_state());
        recog.base.enter_rule(_localctx.clone(), 14, RULE_statement);
        let mut _localctx: Rc<StatementContextAll> = _localctx;
		let result: Result<(), ANTLRError> = (|| {

			recog.base.set_state(95);
			recog.err_handler.sync(&mut recog.base)?;
			match recog.base.input.la(1) {
			 ID 
				=> {
					//recog.base.enter_outer_alt(_localctx.clone(), 1);
					recog.base.enter_outer_alt(None, 1);
					{
					/*InvokeRule command*/
					recog.base.set_state(91);
					recog.command()?;

					}
				}

			 FOR 
				=> {
					//recog.base.enter_outer_alt(_localctx.clone(), 2);
					recog.base.enter_outer_alt(None, 2);
					{
					/*InvokeRule loopStatement*/
					recog.base.set_state(92);
					recog.loopStatement()?;

					}
				}

			 IF 
				=> {
					//recog.base.enter_outer_alt(_localctx.clone(), 3);
					recog.base.enter_outer_alt(None, 3);
					{
					/*InvokeRule conditionalStatement*/
					recog.base.set_state(93);
					recog.conditionalStatement()?;

					}
				}

			 LET 
				=> {
					//recog.base.enter_outer_alt(_localctx.clone(), 4);
					recog.base.enter_outer_alt(None, 4);
					{
					/*InvokeRule variableDeclaration*/
					recog.base.set_state(94);
					recog.variableDeclaration()?;

					}
				}

				_ => Err(ANTLRError::NoAltError(NoViableAltError::new(&mut recog.base)))?
			}
			Ok(())
		})();
		match result {
		Ok(_)=>{},
        Err(e @ ANTLRError::FallThrough(_)) => return Err(e),
		Err(ref re) => {
				//_localctx.exception = re;
				recog.err_handler.report_error(&mut recog.base, re);
				recog.err_handler.recover(&mut recog.base, re)?;
			}
		}
		recog.base.exit_rule();

		Ok(_localctx)
	}
}
//------------------- command ----------------
pub type CommandContextAll<'input> = CommandContext<'input>;


pub type CommandContext<'input> = BaseParserRuleContext<'input,CommandContextExt<'input>>;

#[derive(Clone)]
pub struct CommandContextExt<'input>{
ph:PhantomData<&'input str>
}

impl<'input> NoteParserContext<'input> for CommandContext<'input>{}

impl<'input,'a> Listenable<dyn NoteListener<'input> + 'a> for CommandContext<'input>{
		fn enter(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.enter_every_rule(self);
			listener.enter_command(self);
		}
		fn exit(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.exit_command(self);
			listener.exit_every_rule(self);
		}
}

impl<'input,'a> Visitable<dyn NoteVisitor<'input> + 'a> for CommandContext<'input>{
	fn accept(&self,visitor: &mut (dyn NoteVisitor<'input> + 'a)) {
		visitor.visit_command(self);
	}
}

impl<'input> CustomRuleContext<'input> for CommandContextExt<'input>{
	type TF = LocalTokenFactory<'input>;
	type Ctx = NoteParserContextType;
	fn get_rule_index(&self) -> usize { RULE_command }
	//fn type_rule_index() -> usize where Self: Sized { RULE_command }
}
antlr_rust::tid!{CommandContextExt<'a>}

impl<'input> CommandContextExt<'input>{
	fn new(parent: Option<Rc<dyn NoteParserContext<'input> + 'input > >, invoking_state: isize) -> Rc<CommandContextAll<'input>> {
		Rc::new(
			BaseParserRuleContext::new_parser_ctx(parent, invoking_state,CommandContextExt{
				ph:PhantomData
			}),
		)
	}
}

pub trait CommandContextAttrs<'input>: NoteParserContext<'input> + BorrowMut<CommandContextExt<'input>>{

/// Retrieves first TerminalNode corresponding to token ID
/// Returns `None` if there is no child corresponding to token ID
fn ID(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(ID, 0)
}
fn argument_all(&self) ->  Vec<Rc<ArgumentContextAll<'input>>> where Self:Sized{
	self.children_of_type()
}
fn argument(&self, i: usize) -> Option<Rc<ArgumentContextAll<'input>>> where Self:Sized{
	self.child_of_type(i)
}

}

impl<'input> CommandContextAttrs<'input> for CommandContext<'input>{}

impl<'input, I, H> NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	pub fn command(&mut self,)
	-> Result<Rc<CommandContextAll<'input>>,ANTLRError> {
		let mut recog = self;
		let _parentctx = recog.ctx.take();
		let mut _localctx = CommandContextExt::new(_parentctx.clone(), recog.base.get_state());
        recog.base.enter_rule(_localctx.clone(), 16, RULE_command);
        let mut _localctx: Rc<CommandContextAll> = _localctx;
		let result: Result<(), ANTLRError> = (|| {

			let mut _alt: isize;
			//recog.base.enter_outer_alt(_localctx.clone(), 1);
			recog.base.enter_outer_alt(None, 1);
			{
			recog.base.set_state(97);
			recog.base.match_token(ID,&mut recog.err_handler)?;

			recog.base.set_state(101);
			recog.err_handler.sync(&mut recog.base)?;
			_alt = recog.interpreter.adaptive_predict(9,&mut recog.base)?;
			while { _alt!=2 && _alt!=INVALID_ALT } {
				if _alt==1 {
					{
					{
					/*InvokeRule argument*/
					recog.base.set_state(98);
					recog.argument()?;

					}
					} 
				}
				recog.base.set_state(103);
				recog.err_handler.sync(&mut recog.base)?;
				_alt = recog.interpreter.adaptive_predict(9,&mut recog.base)?;
			}
			}
			Ok(())
		})();
		match result {
		Ok(_)=>{},
        Err(e @ ANTLRError::FallThrough(_)) => return Err(e),
		Err(ref re) => {
				//_localctx.exception = re;
				recog.err_handler.report_error(&mut recog.base, re);
				recog.err_handler.recover(&mut recog.base, re)?;
			}
		}
		recog.base.exit_rule();

		Ok(_localctx)
	}
}
//------------------- argument ----------------
pub type ArgumentContextAll<'input> = ArgumentContext<'input>;


pub type ArgumentContext<'input> = BaseParserRuleContext<'input,ArgumentContextExt<'input>>;

#[derive(Clone)]
pub struct ArgumentContextExt<'input>{
ph:PhantomData<&'input str>
}

impl<'input> NoteParserContext<'input> for ArgumentContext<'input>{}

impl<'input,'a> Listenable<dyn NoteListener<'input> + 'a> for ArgumentContext<'input>{
		fn enter(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.enter_every_rule(self);
			listener.enter_argument(self);
		}
		fn exit(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.exit_argument(self);
			listener.exit_every_rule(self);
		}
}

impl<'input,'a> Visitable<dyn NoteVisitor<'input> + 'a> for ArgumentContext<'input>{
	fn accept(&self,visitor: &mut (dyn NoteVisitor<'input> + 'a)) {
		visitor.visit_argument(self);
	}
}

impl<'input> CustomRuleContext<'input> for ArgumentContextExt<'input>{
	type TF = LocalTokenFactory<'input>;
	type Ctx = NoteParserContextType;
	fn get_rule_index(&self) -> usize { RULE_argument }
	//fn type_rule_index() -> usize where Self: Sized { RULE_argument }
}
antlr_rust::tid!{ArgumentContextExt<'a>}

impl<'input> ArgumentContextExt<'input>{
	fn new(parent: Option<Rc<dyn NoteParserContext<'input> + 'input > >, invoking_state: isize) -> Rc<ArgumentContextAll<'input>> {
		Rc::new(
			BaseParserRuleContext::new_parser_ctx(parent, invoking_state,ArgumentContextExt{
				ph:PhantomData
			}),
		)
	}
}

pub trait ArgumentContextAttrs<'input>: NoteParserContext<'input> + BorrowMut<ArgumentContextExt<'input>>{

/// Retrieves first TerminalNode corresponding to token DEXP
/// Returns `None` if there is no child corresponding to token DEXP
fn DEXP(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(DEXP, 0)
}
/// Retrieves first TerminalNode corresponding to token ID
/// Returns `None` if there is no child corresponding to token ID
fn ID(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(ID, 0)
}
/// Retrieves first TerminalNode corresponding to token STRING
/// Returns `None` if there is no child corresponding to token STRING
fn STRING(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(STRING, 0)
}
/// Retrieves first TerminalNode corresponding to token NUMBER
/// Returns `None` if there is no child corresponding to token NUMBER
fn NUMBER(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(NUMBER, 0)
}

}

impl<'input> ArgumentContextAttrs<'input> for ArgumentContext<'input>{}

impl<'input, I, H> NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	pub fn argument(&mut self,)
	-> Result<Rc<ArgumentContextAll<'input>>,ANTLRError> {
		let mut recog = self;
		let _parentctx = recog.ctx.take();
		let mut _localctx = ArgumentContextExt::new(_parentctx.clone(), recog.base.get_state());
        recog.base.enter_rule(_localctx.clone(), 18, RULE_argument);
        let mut _localctx: Rc<ArgumentContextAll> = _localctx;
		let mut _la: isize = -1;
		let result: Result<(), ANTLRError> = (|| {

			//recog.base.enter_outer_alt(_localctx.clone(), 1);
			recog.base.enter_outer_alt(None, 1);
			{
			recog.base.set_state(104);
			_la = recog.base.input.la(1);
			if { !((((_la) & !0x3f) == 0 && ((1usize << _la) & ((1usize << DEXP) | (1usize << STRING) | (1usize << NUMBER) | (1usize << ID))) != 0)) } {
				recog.err_handler.recover_inline(&mut recog.base)?;

			}
			else {
				if  recog.base.input.la(1)==TOKEN_EOF { recog.base.matched_eof = true };
				recog.err_handler.report_match(&mut recog.base);
				recog.base.consume(&mut recog.err_handler);
			}
			}
			Ok(())
		})();
		match result {
		Ok(_)=>{},
        Err(e @ ANTLRError::FallThrough(_)) => return Err(e),
		Err(ref re) => {
				//_localctx.exception = re;
				recog.err_handler.report_error(&mut recog.base, re);
				recog.err_handler.recover(&mut recog.base, re)?;
			}
		}
		recog.base.exit_rule();

		Ok(_localctx)
	}
}
//------------------- loopStatement ----------------
pub type LoopStatementContextAll<'input> = LoopStatementContext<'input>;


pub type LoopStatementContext<'input> = BaseParserRuleContext<'input,LoopStatementContextExt<'input>>;

#[derive(Clone)]
pub struct LoopStatementContextExt<'input>{
ph:PhantomData<&'input str>
}

impl<'input> NoteParserContext<'input> for LoopStatementContext<'input>{}

impl<'input,'a> Listenable<dyn NoteListener<'input> + 'a> for LoopStatementContext<'input>{
		fn enter(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.enter_every_rule(self);
			listener.enter_loopStatement(self);
		}
		fn exit(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.exit_loopStatement(self);
			listener.exit_every_rule(self);
		}
}

impl<'input,'a> Visitable<dyn NoteVisitor<'input> + 'a> for LoopStatementContext<'input>{
	fn accept(&self,visitor: &mut (dyn NoteVisitor<'input> + 'a)) {
		visitor.visit_loopStatement(self);
	}
}

impl<'input> CustomRuleContext<'input> for LoopStatementContextExt<'input>{
	type TF = LocalTokenFactory<'input>;
	type Ctx = NoteParserContextType;
	fn get_rule_index(&self) -> usize { RULE_loopStatement }
	//fn type_rule_index() -> usize where Self: Sized { RULE_loopStatement }
}
antlr_rust::tid!{LoopStatementContextExt<'a>}

impl<'input> LoopStatementContextExt<'input>{
	fn new(parent: Option<Rc<dyn NoteParserContext<'input> + 'input > >, invoking_state: isize) -> Rc<LoopStatementContextAll<'input>> {
		Rc::new(
			BaseParserRuleContext::new_parser_ctx(parent, invoking_state,LoopStatementContextExt{
				ph:PhantomData
			}),
		)
	}
}

pub trait LoopStatementContextAttrs<'input>: NoteParserContext<'input> + BorrowMut<LoopStatementContextExt<'input>>{

/// Retrieves first TerminalNode corresponding to token FOR
/// Returns `None` if there is no child corresponding to token FOR
fn FOR(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(FOR, 0)
}
/// Retrieves first TerminalNode corresponding to token ID
/// Returns `None` if there is no child corresponding to token ID
fn ID(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(ID, 0)
}
/// Retrieves first TerminalNode corresponding to token IN
/// Returns `None` if there is no child corresponding to token IN
fn IN(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(IN, 0)
}
fn valuetype(&self) -> Option<Rc<ValuetypeContextAll<'input>>> where Self:Sized{
	self.child_of_type(0)
}
fn taskBody(&self) -> Option<Rc<TaskBodyContextAll<'input>>> where Self:Sized{
	self.child_of_type(0)
}

}

impl<'input> LoopStatementContextAttrs<'input> for LoopStatementContext<'input>{}

impl<'input, I, H> NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	pub fn loopStatement(&mut self,)
	-> Result<Rc<LoopStatementContextAll<'input>>,ANTLRError> {
		let mut recog = self;
		let _parentctx = recog.ctx.take();
		let mut _localctx = LoopStatementContextExt::new(_parentctx.clone(), recog.base.get_state());
        recog.base.enter_rule(_localctx.clone(), 20, RULE_loopStatement);
        let mut _localctx: Rc<LoopStatementContextAll> = _localctx;
		let result: Result<(), ANTLRError> = (|| {

			//recog.base.enter_outer_alt(_localctx.clone(), 1);
			recog.base.enter_outer_alt(None, 1);
			{
			recog.base.set_state(106);
			recog.base.match_token(FOR,&mut recog.err_handler)?;

			recog.base.set_state(107);
			recog.base.match_token(ID,&mut recog.err_handler)?;

			recog.base.set_state(108);
			recog.base.match_token(IN,&mut recog.err_handler)?;

			/*InvokeRule valuetype*/
			recog.base.set_state(109);
			recog.valuetype()?;

			/*InvokeRule taskBody*/
			recog.base.set_state(110);
			recog.taskBody()?;

			}
			Ok(())
		})();
		match result {
		Ok(_)=>{},
        Err(e @ ANTLRError::FallThrough(_)) => return Err(e),
		Err(ref re) => {
				//_localctx.exception = re;
				recog.err_handler.report_error(&mut recog.base, re);
				recog.err_handler.recover(&mut recog.base, re)?;
			}
		}
		recog.base.exit_rule();

		Ok(_localctx)
	}
}
//------------------- conditionalStatement ----------------
pub type ConditionalStatementContextAll<'input> = ConditionalStatementContext<'input>;


pub type ConditionalStatementContext<'input> = BaseParserRuleContext<'input,ConditionalStatementContextExt<'input>>;

#[derive(Clone)]
pub struct ConditionalStatementContextExt<'input>{
ph:PhantomData<&'input str>
}

impl<'input> NoteParserContext<'input> for ConditionalStatementContext<'input>{}

impl<'input,'a> Listenable<dyn NoteListener<'input> + 'a> for ConditionalStatementContext<'input>{
		fn enter(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.enter_every_rule(self);
			listener.enter_conditionalStatement(self);
		}
		fn exit(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.exit_conditionalStatement(self);
			listener.exit_every_rule(self);
		}
}

impl<'input,'a> Visitable<dyn NoteVisitor<'input> + 'a> for ConditionalStatementContext<'input>{
	fn accept(&self,visitor: &mut (dyn NoteVisitor<'input> + 'a)) {
		visitor.visit_conditionalStatement(self);
	}
}

impl<'input> CustomRuleContext<'input> for ConditionalStatementContextExt<'input>{
	type TF = LocalTokenFactory<'input>;
	type Ctx = NoteParserContextType;
	fn get_rule_index(&self) -> usize { RULE_conditionalStatement }
	//fn type_rule_index() -> usize where Self: Sized { RULE_conditionalStatement }
}
antlr_rust::tid!{ConditionalStatementContextExt<'a>}

impl<'input> ConditionalStatementContextExt<'input>{
	fn new(parent: Option<Rc<dyn NoteParserContext<'input> + 'input > >, invoking_state: isize) -> Rc<ConditionalStatementContextAll<'input>> {
		Rc::new(
			BaseParserRuleContext::new_parser_ctx(parent, invoking_state,ConditionalStatementContextExt{
				ph:PhantomData
			}),
		)
	}
}

pub trait ConditionalStatementContextAttrs<'input>: NoteParserContext<'input> + BorrowMut<ConditionalStatementContextExt<'input>>{

/// Retrieves first TerminalNode corresponding to token IF
/// Returns `None` if there is no child corresponding to token IF
fn IF(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(IF, 0)
}
fn condition(&self) -> Option<Rc<ConditionContextAll<'input>>> where Self:Sized{
	self.child_of_type(0)
}
fn taskBody_all(&self) ->  Vec<Rc<TaskBodyContextAll<'input>>> where Self:Sized{
	self.children_of_type()
}
fn taskBody(&self, i: usize) -> Option<Rc<TaskBodyContextAll<'input>>> where Self:Sized{
	self.child_of_type(i)
}
/// Retrieves first TerminalNode corresponding to token ELSE
/// Returns `None` if there is no child corresponding to token ELSE
fn ELSE(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(ELSE, 0)
}

}

impl<'input> ConditionalStatementContextAttrs<'input> for ConditionalStatementContext<'input>{}

impl<'input, I, H> NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	pub fn conditionalStatement(&mut self,)
	-> Result<Rc<ConditionalStatementContextAll<'input>>,ANTLRError> {
		let mut recog = self;
		let _parentctx = recog.ctx.take();
		let mut _localctx = ConditionalStatementContextExt::new(_parentctx.clone(), recog.base.get_state());
        recog.base.enter_rule(_localctx.clone(), 22, RULE_conditionalStatement);
        let mut _localctx: Rc<ConditionalStatementContextAll> = _localctx;
		let mut _la: isize = -1;
		let result: Result<(), ANTLRError> = (|| {

			//recog.base.enter_outer_alt(_localctx.clone(), 1);
			recog.base.enter_outer_alt(None, 1);
			{
			recog.base.set_state(112);
			recog.base.match_token(IF,&mut recog.err_handler)?;

			/*InvokeRule condition*/
			recog.base.set_state(113);
			recog.condition()?;

			/*InvokeRule taskBody*/
			recog.base.set_state(114);
			recog.taskBody()?;

			recog.base.set_state(117);
			recog.err_handler.sync(&mut recog.base)?;
			_la = recog.base.input.la(1);
			if _la==ELSE {
				{
				recog.base.set_state(115);
				recog.base.match_token(ELSE,&mut recog.err_handler)?;

				/*InvokeRule taskBody*/
				recog.base.set_state(116);
				recog.taskBody()?;

				}
			}

			}
			Ok(())
		})();
		match result {
		Ok(_)=>{},
        Err(e @ ANTLRError::FallThrough(_)) => return Err(e),
		Err(ref re) => {
				//_localctx.exception = re;
				recog.err_handler.report_error(&mut recog.base, re);
				recog.err_handler.recover(&mut recog.base, re)?;
			}
		}
		recog.base.exit_rule();

		Ok(_localctx)
	}
}
//------------------- condition ----------------
pub type ConditionContextAll<'input> = ConditionContext<'input>;


pub type ConditionContext<'input> = BaseParserRuleContext<'input,ConditionContextExt<'input>>;

#[derive(Clone)]
pub struct ConditionContextExt<'input>{
ph:PhantomData<&'input str>
}

impl<'input> NoteParserContext<'input> for ConditionContext<'input>{}

impl<'input,'a> Listenable<dyn NoteListener<'input> + 'a> for ConditionContext<'input>{
		fn enter(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.enter_every_rule(self);
			listener.enter_condition(self);
		}
		fn exit(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.exit_condition(self);
			listener.exit_every_rule(self);
		}
}

impl<'input,'a> Visitable<dyn NoteVisitor<'input> + 'a> for ConditionContext<'input>{
	fn accept(&self,visitor: &mut (dyn NoteVisitor<'input> + 'a)) {
		visitor.visit_condition(self);
	}
}

impl<'input> CustomRuleContext<'input> for ConditionContextExt<'input>{
	type TF = LocalTokenFactory<'input>;
	type Ctx = NoteParserContextType;
	fn get_rule_index(&self) -> usize { RULE_condition }
	//fn type_rule_index() -> usize where Self: Sized { RULE_condition }
}
antlr_rust::tid!{ConditionContextExt<'a>}

impl<'input> ConditionContextExt<'input>{
	fn new(parent: Option<Rc<dyn NoteParserContext<'input> + 'input > >, invoking_state: isize) -> Rc<ConditionContextAll<'input>> {
		Rc::new(
			BaseParserRuleContext::new_parser_ctx(parent, invoking_state,ConditionContextExt{
				ph:PhantomData
			}),
		)
	}
}

pub trait ConditionContextAttrs<'input>: NoteParserContext<'input> + BorrowMut<ConditionContextExt<'input>>{

fn idtype(&self) -> Option<Rc<IdtypeContextAll<'input>>> where Self:Sized{
	self.child_of_type(0)
}
/// Retrieves first TerminalNode corresponding to token OPERATOR
/// Returns `None` if there is no child corresponding to token OPERATOR
fn OPERATOR(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(OPERATOR, 0)
}
fn valuetype(&self) -> Option<Rc<ValuetypeContextAll<'input>>> where Self:Sized{
	self.child_of_type(0)
}

}

impl<'input> ConditionContextAttrs<'input> for ConditionContext<'input>{}

impl<'input, I, H> NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	pub fn condition(&mut self,)
	-> Result<Rc<ConditionContextAll<'input>>,ANTLRError> {
		let mut recog = self;
		let _parentctx = recog.ctx.take();
		let mut _localctx = ConditionContextExt::new(_parentctx.clone(), recog.base.get_state());
        recog.base.enter_rule(_localctx.clone(), 24, RULE_condition);
        let mut _localctx: Rc<ConditionContextAll> = _localctx;
		let result: Result<(), ANTLRError> = (|| {

			//recog.base.enter_outer_alt(_localctx.clone(), 1);
			recog.base.enter_outer_alt(None, 1);
			{
			/*InvokeRule idtype*/
			recog.base.set_state(119);
			recog.idtype()?;

			recog.base.set_state(120);
			recog.base.match_token(OPERATOR,&mut recog.err_handler)?;

			/*InvokeRule valuetype*/
			recog.base.set_state(121);
			recog.valuetype()?;

			}
			Ok(())
		})();
		match result {
		Ok(_)=>{},
        Err(e @ ANTLRError::FallThrough(_)) => return Err(e),
		Err(ref re) => {
				//_localctx.exception = re;
				recog.err_handler.report_error(&mut recog.base, re);
				recog.err_handler.recover(&mut recog.base, re)?;
			}
		}
		recog.base.exit_rule();

		Ok(_localctx)
	}
}
//------------------- expression ----------------
pub type ExpressionContextAll<'input> = ExpressionContext<'input>;


pub type ExpressionContext<'input> = BaseParserRuleContext<'input,ExpressionContextExt<'input>>;

#[derive(Clone)]
pub struct ExpressionContextExt<'input>{
ph:PhantomData<&'input str>
}

impl<'input> NoteParserContext<'input> for ExpressionContext<'input>{}

impl<'input,'a> Listenable<dyn NoteListener<'input> + 'a> for ExpressionContext<'input>{
		fn enter(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.enter_every_rule(self);
			listener.enter_expression(self);
		}
		fn exit(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.exit_expression(self);
			listener.exit_every_rule(self);
		}
}

impl<'input,'a> Visitable<dyn NoteVisitor<'input> + 'a> for ExpressionContext<'input>{
	fn accept(&self,visitor: &mut (dyn NoteVisitor<'input> + 'a)) {
		visitor.visit_expression(self);
	}
}

impl<'input> CustomRuleContext<'input> for ExpressionContextExt<'input>{
	type TF = LocalTokenFactory<'input>;
	type Ctx = NoteParserContextType;
	fn get_rule_index(&self) -> usize { RULE_expression }
	//fn type_rule_index() -> usize where Self: Sized { RULE_expression }
}
antlr_rust::tid!{ExpressionContextExt<'a>}

impl<'input> ExpressionContextExt<'input>{
	fn new(parent: Option<Rc<dyn NoteParserContext<'input> + 'input > >, invoking_state: isize) -> Rc<ExpressionContextAll<'input>> {
		Rc::new(
			BaseParserRuleContext::new_parser_ctx(parent, invoking_state,ExpressionContextExt{
				ph:PhantomData
			}),
		)
	}
}

pub trait ExpressionContextAttrs<'input>: NoteParserContext<'input> + BorrowMut<ExpressionContextExt<'input>>{

fn valuetype_all(&self) ->  Vec<Rc<ValuetypeContextAll<'input>>> where Self:Sized{
	self.children_of_type()
}
fn valuetype(&self, i: usize) -> Option<Rc<ValuetypeContextAll<'input>>> where Self:Sized{
	self.child_of_type(i)
}
/// Retrieves all `TerminalNode`s corresponding to token OPEXP in current rule
fn OPEXP_all(&self) -> Vec<Rc<TerminalNode<'input,NoteParserContextType>>>  where Self:Sized{
	self.children_of_type()
}
/// Retrieves 'i's TerminalNode corresponding to token OPEXP, starting from 0.
/// Returns `None` if number of children corresponding to token OPEXP is less or equal than `i`.
fn OPEXP(&self, i: usize) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(OPEXP, i)
}

}

impl<'input> ExpressionContextAttrs<'input> for ExpressionContext<'input>{}

impl<'input, I, H> NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	pub fn expression(&mut self,)
	-> Result<Rc<ExpressionContextAll<'input>>,ANTLRError> {
		let mut recog = self;
		let _parentctx = recog.ctx.take();
		let mut _localctx = ExpressionContextExt::new(_parentctx.clone(), recog.base.get_state());
        recog.base.enter_rule(_localctx.clone(), 26, RULE_expression);
        let mut _localctx: Rc<ExpressionContextAll> = _localctx;
		let mut _la: isize = -1;
		let result: Result<(), ANTLRError> = (|| {

			//recog.base.enter_outer_alt(_localctx.clone(), 1);
			recog.base.enter_outer_alt(None, 1);
			{
			/*InvokeRule valuetype*/
			recog.base.set_state(123);
			recog.valuetype()?;

			recog.base.set_state(128);
			recog.err_handler.sync(&mut recog.base)?;
			_la = recog.base.input.la(1);
			while _la==OPEXP {
				{
				{
				recog.base.set_state(124);
				recog.base.match_token(OPEXP,&mut recog.err_handler)?;

				/*InvokeRule valuetype*/
				recog.base.set_state(125);
				recog.valuetype()?;

				}
				}
				recog.base.set_state(130);
				recog.err_handler.sync(&mut recog.base)?;
				_la = recog.base.input.la(1);
			}
			}
			Ok(())
		})();
		match result {
		Ok(_)=>{},
        Err(e @ ANTLRError::FallThrough(_)) => return Err(e),
		Err(ref re) => {
				//_localctx.exception = re;
				recog.err_handler.report_error(&mut recog.base, re);
				recog.err_handler.recover(&mut recog.base, re)?;
			}
		}
		recog.base.exit_rule();

		Ok(_localctx)
	}
}
//------------------- idtype ----------------
pub type IdtypeContextAll<'input> = IdtypeContext<'input>;


pub type IdtypeContext<'input> = BaseParserRuleContext<'input,IdtypeContextExt<'input>>;

#[derive(Clone)]
pub struct IdtypeContextExt<'input>{
ph:PhantomData<&'input str>
}

impl<'input> NoteParserContext<'input> for IdtypeContext<'input>{}

impl<'input,'a> Listenable<dyn NoteListener<'input> + 'a> for IdtypeContext<'input>{
		fn enter(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.enter_every_rule(self);
			listener.enter_idtype(self);
		}
		fn exit(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.exit_idtype(self);
			listener.exit_every_rule(self);
		}
}

impl<'input,'a> Visitable<dyn NoteVisitor<'input> + 'a> for IdtypeContext<'input>{
	fn accept(&self,visitor: &mut (dyn NoteVisitor<'input> + 'a)) {
		visitor.visit_idtype(self);
	}
}

impl<'input> CustomRuleContext<'input> for IdtypeContextExt<'input>{
	type TF = LocalTokenFactory<'input>;
	type Ctx = NoteParserContextType;
	fn get_rule_index(&self) -> usize { RULE_idtype }
	//fn type_rule_index() -> usize where Self: Sized { RULE_idtype }
}
antlr_rust::tid!{IdtypeContextExt<'a>}

impl<'input> IdtypeContextExt<'input>{
	fn new(parent: Option<Rc<dyn NoteParserContext<'input> + 'input > >, invoking_state: isize) -> Rc<IdtypeContextAll<'input>> {
		Rc::new(
			BaseParserRuleContext::new_parser_ctx(parent, invoking_state,IdtypeContextExt{
				ph:PhantomData
			}),
		)
	}
}

pub trait IdtypeContextAttrs<'input>: NoteParserContext<'input> + BorrowMut<IdtypeContextExt<'input>>{

/// Retrieves first TerminalNode corresponding to token ID
/// Returns `None` if there is no child corresponding to token ID
fn ID(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(ID, 0)
}
/// Retrieves first TerminalNode corresponding to token DEXP
/// Returns `None` if there is no child corresponding to token DEXP
fn DEXP(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(DEXP, 0)
}

}

impl<'input> IdtypeContextAttrs<'input> for IdtypeContext<'input>{}

impl<'input, I, H> NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	pub fn idtype(&mut self,)
	-> Result<Rc<IdtypeContextAll<'input>>,ANTLRError> {
		let mut recog = self;
		let _parentctx = recog.ctx.take();
		let mut _localctx = IdtypeContextExt::new(_parentctx.clone(), recog.base.get_state());
        recog.base.enter_rule(_localctx.clone(), 28, RULE_idtype);
        let mut _localctx: Rc<IdtypeContextAll> = _localctx;
		let mut _la: isize = -1;
		let result: Result<(), ANTLRError> = (|| {

			//recog.base.enter_outer_alt(_localctx.clone(), 1);
			recog.base.enter_outer_alt(None, 1);
			{
			recog.base.set_state(131);
			_la = recog.base.input.la(1);
			if { !(_la==DEXP || _la==ID) } {
				recog.err_handler.recover_inline(&mut recog.base)?;

			}
			else {
				if  recog.base.input.la(1)==TOKEN_EOF { recog.base.matched_eof = true };
				recog.err_handler.report_match(&mut recog.base);
				recog.base.consume(&mut recog.err_handler);
			}
			}
			Ok(())
		})();
		match result {
		Ok(_)=>{},
        Err(e @ ANTLRError::FallThrough(_)) => return Err(e),
		Err(ref re) => {
				//_localctx.exception = re;
				recog.err_handler.report_error(&mut recog.base, re);
				recog.err_handler.recover(&mut recog.base, re)?;
			}
		}
		recog.base.exit_rule();

		Ok(_localctx)
	}
}
//------------------- valuetype ----------------
pub type ValuetypeContextAll<'input> = ValuetypeContext<'input>;


pub type ValuetypeContext<'input> = BaseParserRuleContext<'input,ValuetypeContextExt<'input>>;

#[derive(Clone)]
pub struct ValuetypeContextExt<'input>{
ph:PhantomData<&'input str>
}

impl<'input> NoteParserContext<'input> for ValuetypeContext<'input>{}

impl<'input,'a> Listenable<dyn NoteListener<'input> + 'a> for ValuetypeContext<'input>{
		fn enter(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.enter_every_rule(self);
			listener.enter_valuetype(self);
		}
		fn exit(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.exit_valuetype(self);
			listener.exit_every_rule(self);
		}
}

impl<'input,'a> Visitable<dyn NoteVisitor<'input> + 'a> for ValuetypeContext<'input>{
	fn accept(&self,visitor: &mut (dyn NoteVisitor<'input> + 'a)) {
		visitor.visit_valuetype(self);
	}
}

impl<'input> CustomRuleContext<'input> for ValuetypeContextExt<'input>{
	type TF = LocalTokenFactory<'input>;
	type Ctx = NoteParserContextType;
	fn get_rule_index(&self) -> usize { RULE_valuetype }
	//fn type_rule_index() -> usize where Self: Sized { RULE_valuetype }
}
antlr_rust::tid!{ValuetypeContextExt<'a>}

impl<'input> ValuetypeContextExt<'input>{
	fn new(parent: Option<Rc<dyn NoteParserContext<'input> + 'input > >, invoking_state: isize) -> Rc<ValuetypeContextAll<'input>> {
		Rc::new(
			BaseParserRuleContext::new_parser_ctx(parent, invoking_state,ValuetypeContextExt{
				ph:PhantomData
			}),
		)
	}
}

pub trait ValuetypeContextAttrs<'input>: NoteParserContext<'input> + BorrowMut<ValuetypeContextExt<'input>>{

/// Retrieves first TerminalNode corresponding to token NUMBER
/// Returns `None` if there is no child corresponding to token NUMBER
fn NUMBER(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(NUMBER, 0)
}
/// Retrieves first TerminalNode corresponding to token STRING
/// Returns `None` if there is no child corresponding to token STRING
fn STRING(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(STRING, 0)
}
fn list(&self) -> Option<Rc<ListContextAll<'input>>> where Self:Sized{
	self.child_of_type(0)
}
/// Retrieves first TerminalNode corresponding to token ID
/// Returns `None` if there is no child corresponding to token ID
fn ID(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(ID, 0)
}
/// Retrieves first TerminalNode corresponding to token DEXP
/// Returns `None` if there is no child corresponding to token DEXP
fn DEXP(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(DEXP, 0)
}

}

impl<'input> ValuetypeContextAttrs<'input> for ValuetypeContext<'input>{}

impl<'input, I, H> NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	pub fn valuetype(&mut self,)
	-> Result<Rc<ValuetypeContextAll<'input>>,ANTLRError> {
		let mut recog = self;
		let _parentctx = recog.ctx.take();
		let mut _localctx = ValuetypeContextExt::new(_parentctx.clone(), recog.base.get_state());
        recog.base.enter_rule(_localctx.clone(), 30, RULE_valuetype);
        let mut _localctx: Rc<ValuetypeContextAll> = _localctx;
		let result: Result<(), ANTLRError> = (|| {

			recog.base.set_state(138);
			recog.err_handler.sync(&mut recog.base)?;
			match recog.base.input.la(1) {
			 NUMBER 
				=> {
					//recog.base.enter_outer_alt(_localctx.clone(), 1);
					recog.base.enter_outer_alt(None, 1);
					{
					recog.base.set_state(133);
					recog.base.match_token(NUMBER,&mut recog.err_handler)?;

					}
				}

			 STRING 
				=> {
					//recog.base.enter_outer_alt(_localctx.clone(), 2);
					recog.base.enter_outer_alt(None, 2);
					{
					recog.base.set_state(134);
					recog.base.match_token(STRING,&mut recog.err_handler)?;

					}
				}

			 T__1 
				=> {
					//recog.base.enter_outer_alt(_localctx.clone(), 3);
					recog.base.enter_outer_alt(None, 3);
					{
					/*InvokeRule list*/
					recog.base.set_state(135);
					recog.list()?;

					}
				}

			 ID 
				=> {
					//recog.base.enter_outer_alt(_localctx.clone(), 4);
					recog.base.enter_outer_alt(None, 4);
					{
					recog.base.set_state(136);
					recog.base.match_token(ID,&mut recog.err_handler)?;

					}
				}

			 DEXP 
				=> {
					//recog.base.enter_outer_alt(_localctx.clone(), 5);
					recog.base.enter_outer_alt(None, 5);
					{
					recog.base.set_state(137);
					recog.base.match_token(DEXP,&mut recog.err_handler)?;

					}
				}

				_ => Err(ANTLRError::NoAltError(NoViableAltError::new(&mut recog.base)))?
			}
			Ok(())
		})();
		match result {
		Ok(_)=>{},
        Err(e @ ANTLRError::FallThrough(_)) => return Err(e),
		Err(ref re) => {
				//_localctx.exception = re;
				recog.err_handler.report_error(&mut recog.base, re);
				recog.err_handler.recover(&mut recog.base, re)?;
			}
		}
		recog.base.exit_rule();

		Ok(_localctx)
	}
}
//------------------- list ----------------
pub type ListContextAll<'input> = ListContext<'input>;


pub type ListContext<'input> = BaseParserRuleContext<'input,ListContextExt<'input>>;

#[derive(Clone)]
pub struct ListContextExt<'input>{
ph:PhantomData<&'input str>
}

impl<'input> NoteParserContext<'input> for ListContext<'input>{}

impl<'input,'a> Listenable<dyn NoteListener<'input> + 'a> for ListContext<'input>{
		fn enter(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.enter_every_rule(self);
			listener.enter_list(self);
		}
		fn exit(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.exit_list(self);
			listener.exit_every_rule(self);
		}
}

impl<'input,'a> Visitable<dyn NoteVisitor<'input> + 'a> for ListContext<'input>{
	fn accept(&self,visitor: &mut (dyn NoteVisitor<'input> + 'a)) {
		visitor.visit_list(self);
	}
}

impl<'input> CustomRuleContext<'input> for ListContextExt<'input>{
	type TF = LocalTokenFactory<'input>;
	type Ctx = NoteParserContextType;
	fn get_rule_index(&self) -> usize { RULE_list }
	//fn type_rule_index() -> usize where Self: Sized { RULE_list }
}
antlr_rust::tid!{ListContextExt<'a>}

impl<'input> ListContextExt<'input>{
	fn new(parent: Option<Rc<dyn NoteParserContext<'input> + 'input > >, invoking_state: isize) -> Rc<ListContextAll<'input>> {
		Rc::new(
			BaseParserRuleContext::new_parser_ctx(parent, invoking_state,ListContextExt{
				ph:PhantomData
			}),
		)
	}
}

pub trait ListContextAttrs<'input>: NoteParserContext<'input> + BorrowMut<ListContextExt<'input>>{

fn valuetype_all(&self) ->  Vec<Rc<ValuetypeContextAll<'input>>> where Self:Sized{
	self.children_of_type()
}
fn valuetype(&self, i: usize) -> Option<Rc<ValuetypeContextAll<'input>>> where Self:Sized{
	self.child_of_type(i)
}
/// Retrieves all `TerminalNode`s corresponding to token COMMA in current rule
fn COMMA_all(&self) -> Vec<Rc<TerminalNode<'input,NoteParserContextType>>>  where Self:Sized{
	self.children_of_type()
}
/// Retrieves 'i's TerminalNode corresponding to token COMMA, starting from 0.
/// Returns `None` if number of children corresponding to token COMMA is less or equal than `i`.
fn COMMA(&self, i: usize) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(COMMA, i)
}

}

impl<'input> ListContextAttrs<'input> for ListContext<'input>{}

impl<'input, I, H> NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	pub fn list(&mut self,)
	-> Result<Rc<ListContextAll<'input>>,ANTLRError> {
		let mut recog = self;
		let _parentctx = recog.ctx.take();
		let mut _localctx = ListContextExt::new(_parentctx.clone(), recog.base.get_state());
        recog.base.enter_rule(_localctx.clone(), 32, RULE_list);
        let mut _localctx: Rc<ListContextAll> = _localctx;
		let mut _la: isize = -1;
		let result: Result<(), ANTLRError> = (|| {

			//recog.base.enter_outer_alt(_localctx.clone(), 1);
			recog.base.enter_outer_alt(None, 1);
			{
			recog.base.set_state(140);
			recog.base.match_token(T__1,&mut recog.err_handler)?;

			recog.base.set_state(149);
			recog.err_handler.sync(&mut recog.base)?;
			_la = recog.base.input.la(1);
			if (((_la) & !0x3f) == 0 && ((1usize << _la) & ((1usize << T__1) | (1usize << DEXP) | (1usize << STRING) | (1usize << NUMBER) | (1usize << ID))) != 0) {
				{
				/*InvokeRule valuetype*/
				recog.base.set_state(141);
				recog.valuetype()?;

				recog.base.set_state(146);
				recog.err_handler.sync(&mut recog.base)?;
				_la = recog.base.input.la(1);
				while _la==COMMA {
					{
					{
					recog.base.set_state(142);
					recog.base.match_token(COMMA,&mut recog.err_handler)?;

					/*InvokeRule valuetype*/
					recog.base.set_state(143);
					recog.valuetype()?;

					}
					}
					recog.base.set_state(148);
					recog.err_handler.sync(&mut recog.base)?;
					_la = recog.base.input.la(1);
				}
				}
			}

			recog.base.set_state(151);
			recog.base.match_token(T__2,&mut recog.err_handler)?;

			}
			Ok(())
		})();
		match result {
		Ok(_)=>{},
        Err(e @ ANTLRError::FallThrough(_)) => return Err(e),
		Err(ref re) => {
				//_localctx.exception = re;
				recog.err_handler.report_error(&mut recog.base, re);
				recog.err_handler.recover(&mut recog.base, re)?;
			}
		}
		recog.base.exit_rule();

		Ok(_localctx)
	}
}
//------------------- comment ----------------
pub type CommentContextAll<'input> = CommentContext<'input>;


pub type CommentContext<'input> = BaseParserRuleContext<'input,CommentContextExt<'input>>;

#[derive(Clone)]
pub struct CommentContextExt<'input>{
ph:PhantomData<&'input str>
}

impl<'input> NoteParserContext<'input> for CommentContext<'input>{}

impl<'input,'a> Listenable<dyn NoteListener<'input> + 'a> for CommentContext<'input>{
		fn enter(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.enter_every_rule(self);
			listener.enter_comment(self);
		}
		fn exit(&self,listener: &mut (dyn NoteListener<'input> + 'a)) {
			listener.exit_comment(self);
			listener.exit_every_rule(self);
		}
}

impl<'input,'a> Visitable<dyn NoteVisitor<'input> + 'a> for CommentContext<'input>{
	fn accept(&self,visitor: &mut (dyn NoteVisitor<'input> + 'a)) {
		visitor.visit_comment(self);
	}
}

impl<'input> CustomRuleContext<'input> for CommentContextExt<'input>{
	type TF = LocalTokenFactory<'input>;
	type Ctx = NoteParserContextType;
	fn get_rule_index(&self) -> usize { RULE_comment }
	//fn type_rule_index() -> usize where Self: Sized { RULE_comment }
}
antlr_rust::tid!{CommentContextExt<'a>}

impl<'input> CommentContextExt<'input>{
	fn new(parent: Option<Rc<dyn NoteParserContext<'input> + 'input > >, invoking_state: isize) -> Rc<CommentContextAll<'input>> {
		Rc::new(
			BaseParserRuleContext::new_parser_ctx(parent, invoking_state,CommentContextExt{
				ph:PhantomData
			}),
		)
	}
}

pub trait CommentContextAttrs<'input>: NoteParserContext<'input> + BorrowMut<CommentContextExt<'input>>{

/// Retrieves first TerminalNode corresponding to token COMMENT
/// Returns `None` if there is no child corresponding to token COMMENT
fn COMMENT(&self) -> Option<Rc<TerminalNode<'input,NoteParserContextType>>> where Self:Sized{
	self.get_token(COMMENT, 0)
}

}

impl<'input> CommentContextAttrs<'input> for CommentContext<'input>{}

impl<'input, I, H> NoteParser<'input, I, H>
where
    I: TokenStream<'input, TF = LocalTokenFactory<'input> > + TidAble<'input>,
    H: ErrorStrategy<'input,BaseParserType<'input,I>>
{
	pub fn comment(&mut self,)
	-> Result<Rc<CommentContextAll<'input>>,ANTLRError> {
		let mut recog = self;
		let _parentctx = recog.ctx.take();
		let mut _localctx = CommentContextExt::new(_parentctx.clone(), recog.base.get_state());
        recog.base.enter_rule(_localctx.clone(), 34, RULE_comment);
        let mut _localctx: Rc<CommentContextAll> = _localctx;
		let result: Result<(), ANTLRError> = (|| {

			//recog.base.enter_outer_alt(_localctx.clone(), 1);
			recog.base.enter_outer_alt(None, 1);
			{
			recog.base.set_state(153);
			recog.base.match_token(COMMENT,&mut recog.err_handler)?;

			}
			Ok(())
		})();
		match result {
		Ok(_)=>{},
        Err(e @ ANTLRError::FallThrough(_)) => return Err(e),
		Err(ref re) => {
				//_localctx.exception = re;
				recog.err_handler.report_error(&mut recog.base, re);
				recog.err_handler.recover(&mut recog.base, re)?;
			}
		}
		recog.base.exit_rule();

		Ok(_localctx)
	}
}

lazy_static! {
    static ref _ATN: Arc<ATN> =
        Arc::new(ATNDeserializer::new(None).deserialize(_serializedATN.chars()));
    static ref _decision_to_DFA: Arc<Vec<antlr_rust::RwLock<DFA>>> = {
        let mut dfa = Vec::new();
        let size = _ATN.decision_to_state.len();
        for i in 0..size {
            dfa.push(DFA::new(
                _ATN.clone(),
                _ATN.get_decision_state(i),
                i as isize,
            ).into())
        }
        Arc::new(dfa)
    };
}



const _serializedATN:&'static str =
	"\x03\u{608b}\u{a72a}\u{8133}\u{b9ed}\u{417c}\u{3be7}\u{7786}\u{5964}\x03\
	\x19\u{9e}\x04\x02\x09\x02\x04\x03\x09\x03\x04\x04\x09\x04\x04\x05\x09\x05\
	\x04\x06\x09\x06\x04\x07\x09\x07\x04\x08\x09\x08\x04\x09\x09\x09\x04\x0a\
	\x09\x0a\x04\x0b\x09\x0b\x04\x0c\x09\x0c\x04\x0d\x09\x0d\x04\x0e\x09\x0e\
	\x04\x0f\x09\x0f\x04\x10\x09\x10\x04\x11\x09\x11\x04\x12\x09\x12\x04\x13\
	\x09\x13\x03\x02\x03\x02\x03\x02\x07\x02\x2a\x0a\x02\x0c\x02\x0e\x02\x2d\
	\x0b\x02\x03\x02\x03\x02\x03\x03\x03\x03\x03\x03\x03\x03\x03\x04\x03\x04\
	\x03\x04\x07\x04\x38\x0a\x04\x0c\x04\x0e\x04\x3b\x0b\x04\x03\x05\x03\x05\
	\x05\x05\x3f\x0a\x05\x03\x05\x03\x05\x03\x05\x05\x05\x44\x0a\x05\x03\x05\
	\x03\x05\x03\x06\x03\x06\x03\x06\x07\x06\x4b\x0a\x06\x0c\x06\x0e\x06\x4e\
	\x0b\x06\x03\x07\x03\x07\x03\x07\x03\x07\x03\x07\x03\x08\x03\x08\x07\x08\
	\x57\x0a\x08\x0c\x08\x0e\x08\x5a\x0b\x08\x03\x08\x03\x08\x03\x09\x03\x09\
	\x03\x09\x03\x09\x05\x09\x62\x0a\x09\x03\x0a\x03\x0a\x07\x0a\x66\x0a\x0a\
	\x0c\x0a\x0e\x0a\x69\x0b\x0a\x03\x0b\x03\x0b\x03\x0c\x03\x0c\x03\x0c\x03\
	\x0c\x03\x0c\x03\x0c\x03\x0d\x03\x0d\x03\x0d\x03\x0d\x03\x0d\x05\x0d\x78\
	\x0a\x0d\x03\x0e\x03\x0e\x03\x0e\x03\x0e\x03\x0f\x03\x0f\x03\x0f\x07\x0f\
	\u{81}\x0a\x0f\x0c\x0f\x0e\x0f\u{84}\x0b\x0f\x03\x10\x03\x10\x03\x11\x03\
	\x11\x03\x11\x03\x11\x03\x11\x05\x11\u{8d}\x0a\x11\x03\x12\x03\x12\x03\x12\
	\x03\x12\x07\x12\u{93}\x0a\x12\x0c\x12\x0e\x12\u{96}\x0b\x12\x05\x12\u{98}\
	\x0a\x12\x03\x12\x03\x12\x03\x13\x03\x13\x03\x13\x02\x02\x14\x02\x04\x06\
	\x08\x0a\x0c\x0e\x10\x12\x14\x16\x18\x1a\x1c\x1e\x20\x22\x24\x02\x04\x04\
	\x02\x0a\x0a\x13\x15\x04\x02\x0a\x0a\x15\x15\x02\u{a0}\x02\x2b\x03\x02\x02\
	\x02\x04\x30\x03\x02\x02\x02\x06\x34\x03\x02\x02\x02\x08\x3c\x03\x02\x02\
	\x02\x0a\x47\x03\x02\x02\x02\x0c\x4f\x03\x02\x02\x02\x0e\x54\x03\x02\x02\
	\x02\x10\x61\x03\x02\x02\x02\x12\x63\x03\x02\x02\x02\x14\x6a\x03\x02\x02\
	\x02\x16\x6c\x03\x02\x02\x02\x18\x72\x03\x02\x02\x02\x1a\x79\x03\x02\x02\
	\x02\x1c\x7d\x03\x02\x02\x02\x1e\u{85}\x03\x02\x02\x02\x20\u{8c}\x03\x02\
	\x02\x02\x22\u{8e}\x03\x02\x02\x02\x24\u{9b}\x03\x02\x02\x02\x26\x2a\x05\
	\x04\x03\x02\x27\x2a\x05\x10\x09\x02\x28\x2a\x05\x24\x13\x02\x29\x26\x03\
	\x02\x02\x02\x29\x27\x03\x02\x02\x02\x29\x28\x03\x02\x02\x02\x2a\x2d\x03\
	\x02\x02\x02\x2b\x29\x03\x02\x02\x02\x2b\x2c\x03\x02\x02\x02\x2c\x2e\x03\
	\x02\x02\x02\x2d\x2b\x03\x02\x02\x02\x2e\x2f\x07\x02\x02\x03\x2f\x03\x03\
	\x02\x02\x02\x30\x31\x07\x03\x02\x02\x31\x32\x05\x0a\x06\x02\x32\x33\x05\
	\x0e\x08\x02\x33\x05\x03\x02\x02\x02\x34\x39\x07\x15\x02\x02\x35\x36\x07\
	\x0b\x02\x02\x36\x38\x07\x15\x02\x02\x37\x35\x03\x02\x02\x02\x38\x3b\x03\
	\x02\x02\x02\x39\x37\x03\x02\x02\x02\x39\x3a\x03\x02\x02\x02\x3a\x07\x03\
	\x02\x02\x02\x3b\x39\x03\x02\x02\x02\x3c\x3e\x07\x04\x02\x02\x3d\x3f\x05\
	\x06\x04\x02\x3e\x3d\x03\x02\x02\x02\x3e\x3f\x03\x02\x02\x02\x3f\x40\x03\
	\x02\x02\x02\x40\x43\x07\x09\x02\x02\x41\x42\x07\x12\x02\x02\x42\x44\x05\
	\x20\x11\x02\x43\x41\x03\x02\x02\x02\x43\x44\x03\x02\x02\x02\x44\x45\x03\
	\x02\x02\x02\x45\x46\x07\x05\x02\x02\x46\x09\x03\x02\x02\x02\x47\x4c\x05\
	\x06\x04\x02\x48\x4b\x05\x06\x04\x02\x49\x4b\x05\x08\x05\x02\x4a\x48\x03\
	\x02\x02\x02\x4a\x49\x03\x02\x02\x02\x4b\x4e\x03\x02\x02\x02\x4c\x4a\x03\
	\x02\x02\x02\x4c\x4d\x03\x02\x02\x02\x4d\x0b\x03\x02\x02\x02\x4e\x4c\x03\
	\x02\x02\x02\x4f\x50\x07\x0c\x02\x02\x50\x51\x07\x15\x02\x02\x51\x52\x07\
	\x12\x02\x02\x52\x53\x05\x1c\x0f\x02\x53\x0d\x03\x02\x02\x02\x54\x58\x07\
	\x06\x02\x02\x55\x57\x05\x10\x09\x02\x56\x55\x03\x02\x02\x02\x57\x5a\x03\
	\x02\x02\x02\x58\x56\x03\x02\x02\x02\x58\x59\x03\x02\x02\x02\x59\x5b\x03\
	\x02\x02\x02\x5a\x58\x03\x02\x02\x02\x5b\x5c\x07\x07\x02\x02\x5c\x0f\x03\
	\x02\x02\x02\x5d\x62\x05\x12\x0a\x02\x5e\x62\x05\x16\x0c\x02\x5f\x62\x05\
	\x18\x0d\x02\x60\x62\x05\x0c\x07\x02\x61\x5d\x03\x02\x02\x02\x61\x5e\x03\
	\x02\x02\x02\x61\x5f\x03\x02\x02\x02\x61\x60\x03\x02\x02\x02\x62\x11\x03\
	\x02\x02\x02\x63\x67\x07\x15\x02\x02\x64\x66\x05\x14\x0b\x02\x65\x64\x03\
	\x02\x02\x02\x66\x69\x03\x02\x02\x02\x67\x65\x03\x02\x02\x02\x67\x68\x03\
	\x02\x02\x02\x68\x13\x03\x02\x02\x02\x69\x67\x03\x02\x02\x02\x6a\x6b\x09\
	\x02\x02\x02\x6b\x15\x03\x02\x02\x02\x6c\x6d\x07\x0e\x02\x02\x6d\x6e\x07\
	\x15\x02\x02\x6e\x6f\x07\x0d\x02\x02\x6f\x70\x05\x20\x11\x02\x70\x71\x05\
	\x0e\x08\x02\x71\x17\x03\x02\x02\x02\x72\x73\x07\x0f\x02\x02\x73\x74\x05\
	\x1a\x0e\x02\x74\x77\x05\x0e\x08\x02\x75\x76\x07\x10\x02\x02\x76\x78\x05\
	\x0e\x08\x02\x77\x75\x03\x02\x02\x02\x77\x78\x03\x02\x02\x02\x78\x19\x03\
	\x02\x02\x02\x79\x7a\x05\x1e\x10\x02\x7a\x7b\x07\x18\x02\x02\x7b\x7c\x05\
	\x20\x11\x02\x7c\x1b\x03\x02\x02\x02\x7d\u{82}\x05\x20\x11\x02\x7e\x7f\x07\
	\x19\x02\x02\x7f\u{81}\x05\x20\x11\x02\u{80}\x7e\x03\x02\x02\x02\u{81}\u{84}\
	\x03\x02\x02\x02\u{82}\u{80}\x03\x02\x02\x02\u{82}\u{83}\x03\x02\x02\x02\
	\u{83}\x1d\x03\x02\x02\x02\u{84}\u{82}\x03\x02\x02\x02\u{85}\u{86}\x09\x03\
	\x02\x02\u{86}\x1f\x03\x02\x02\x02\u{87}\u{8d}\x07\x14\x02\x02\u{88}\u{8d}\
	\x07\x13\x02\x02\u{89}\u{8d}\x05\x22\x12\x02\u{8a}\u{8d}\x07\x15\x02\x02\
	\u{8b}\u{8d}\x07\x0a\x02\x02\u{8c}\u{87}\x03\x02\x02\x02\u{8c}\u{88}\x03\
	\x02\x02\x02\u{8c}\u{89}\x03\x02\x02\x02\u{8c}\u{8a}\x03\x02\x02\x02\u{8c}\
	\u{8b}\x03\x02\x02\x02\u{8d}\x21\x03\x02\x02\x02\u{8e}\u{97}\x07\x04\x02\
	\x02\u{8f}\u{94}\x05\x20\x11\x02\u{90}\u{91}\x07\x11\x02\x02\u{91}\u{93}\
	\x05\x20\x11\x02\u{92}\u{90}\x03\x02\x02\x02\u{93}\u{96}\x03\x02\x02\x02\
	\u{94}\u{92}\x03\x02\x02\x02\u{94}\u{95}\x03\x02\x02\x02\u{95}\u{98}\x03\
	\x02\x02\x02\u{96}\u{94}\x03\x02\x02\x02\u{97}\u{8f}\x03\x02\x02\x02\u{97}\
	\u{98}\x03\x02\x02\x02\u{98}\u{99}\x03\x02\x02\x02\u{99}\u{9a}\x07\x05\x02\
	\x02\u{9a}\x23\x03\x02\x02\x02\u{9b}\u{9c}\x07\x08\x02\x02\u{9c}\x25\x03\
	\x02\x02\x02\x11\x29\x2b\x39\x3e\x43\x4a\x4c\x58\x61\x67\x77\u{82}\u{8c}\
	\u{94}\u{97}";

