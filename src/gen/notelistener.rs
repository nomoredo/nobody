#![allow(nonstandard_style)]
// Generated from Note.g4 by ANTLR 4.8
use antlr_rust::tree::ParseTreeListener;
use super::noteparser::*;

pub trait NoteListener<'input> : ParseTreeListener<'input,NoteParserContextType>{
/**
 * Enter a parse tree produced by {@link NoteParser#script}.
 * @param ctx the parse tree
 */
fn enter_script(&mut self, _ctx: &ScriptContext<'input>) { }
/**
 * Exit a parse tree produced by {@link NoteParser#script}.
 * @param ctx the parse tree
 */
fn exit_script(&mut self, _ctx: &ScriptContext<'input>) { }
/**
 * Enter a parse tree produced by {@link NoteParser#task}.
 * @param ctx the parse tree
 */
fn enter_task(&mut self, _ctx: &TaskContext<'input>) { }
/**
 * Exit a parse tree produced by {@link NoteParser#task}.
 * @param ctx the parse tree
 */
fn exit_task(&mut self, _ctx: &TaskContext<'input>) { }
/**
 * Enter a parse tree produced by {@link NoteParser#identifier}.
 * @param ctx the parse tree
 */
fn enter_identifier(&mut self, _ctx: &IdentifierContext<'input>) { }
/**
 * Exit a parse tree produced by {@link NoteParser#identifier}.
 * @param ctx the parse tree
 */
fn exit_identifier(&mut self, _ctx: &IdentifierContext<'input>) { }
/**
 * Enter a parse tree produced by {@link NoteParser#parameter}.
 * @param ctx the parse tree
 */
fn enter_parameter(&mut self, _ctx: &ParameterContext<'input>) { }
/**
 * Exit a parse tree produced by {@link NoteParser#parameter}.
 * @param ctx the parse tree
 */
fn exit_parameter(&mut self, _ctx: &ParameterContext<'input>) { }
/**
 * Enter a parse tree produced by {@link NoteParser#taskIdentifier}.
 * @param ctx the parse tree
 */
fn enter_taskIdentifier(&mut self, _ctx: &TaskIdentifierContext<'input>) { }
/**
 * Exit a parse tree produced by {@link NoteParser#taskIdentifier}.
 * @param ctx the parse tree
 */
fn exit_taskIdentifier(&mut self, _ctx: &TaskIdentifierContext<'input>) { }
/**
 * Enter a parse tree produced by {@link NoteParser#variableDeclaration}.
 * @param ctx the parse tree
 */
fn enter_variableDeclaration(&mut self, _ctx: &VariableDeclarationContext<'input>) { }
/**
 * Exit a parse tree produced by {@link NoteParser#variableDeclaration}.
 * @param ctx the parse tree
 */
fn exit_variableDeclaration(&mut self, _ctx: &VariableDeclarationContext<'input>) { }
/**
 * Enter a parse tree produced by {@link NoteParser#taskBody}.
 * @param ctx the parse tree
 */
fn enter_taskBody(&mut self, _ctx: &TaskBodyContext<'input>) { }
/**
 * Exit a parse tree produced by {@link NoteParser#taskBody}.
 * @param ctx the parse tree
 */
fn exit_taskBody(&mut self, _ctx: &TaskBodyContext<'input>) { }
/**
 * Enter a parse tree produced by {@link NoteParser#statement}.
 * @param ctx the parse tree
 */
fn enter_statement(&mut self, _ctx: &StatementContext<'input>) { }
/**
 * Exit a parse tree produced by {@link NoteParser#statement}.
 * @param ctx the parse tree
 */
fn exit_statement(&mut self, _ctx: &StatementContext<'input>) { }
/**
 * Enter a parse tree produced by {@link NoteParser#command}.
 * @param ctx the parse tree
 */
fn enter_command(&mut self, _ctx: &CommandContext<'input>) { }
/**
 * Exit a parse tree produced by {@link NoteParser#command}.
 * @param ctx the parse tree
 */
fn exit_command(&mut self, _ctx: &CommandContext<'input>) { }
/**
 * Enter a parse tree produced by {@link NoteParser#argument}.
 * @param ctx the parse tree
 */
fn enter_argument(&mut self, _ctx: &ArgumentContext<'input>) { }
/**
 * Exit a parse tree produced by {@link NoteParser#argument}.
 * @param ctx the parse tree
 */
fn exit_argument(&mut self, _ctx: &ArgumentContext<'input>) { }
/**
 * Enter a parse tree produced by {@link NoteParser#loopStatement}.
 * @param ctx the parse tree
 */
fn enter_loopStatement(&mut self, _ctx: &LoopStatementContext<'input>) { }
/**
 * Exit a parse tree produced by {@link NoteParser#loopStatement}.
 * @param ctx the parse tree
 */
fn exit_loopStatement(&mut self, _ctx: &LoopStatementContext<'input>) { }
/**
 * Enter a parse tree produced by {@link NoteParser#conditionalStatement}.
 * @param ctx the parse tree
 */
fn enter_conditionalStatement(&mut self, _ctx: &ConditionalStatementContext<'input>) { }
/**
 * Exit a parse tree produced by {@link NoteParser#conditionalStatement}.
 * @param ctx the parse tree
 */
fn exit_conditionalStatement(&mut self, _ctx: &ConditionalStatementContext<'input>) { }
/**
 * Enter a parse tree produced by {@link NoteParser#condition}.
 * @param ctx the parse tree
 */
fn enter_condition(&mut self, _ctx: &ConditionContext<'input>) { }
/**
 * Exit a parse tree produced by {@link NoteParser#condition}.
 * @param ctx the parse tree
 */
fn exit_condition(&mut self, _ctx: &ConditionContext<'input>) { }
/**
 * Enter a parse tree produced by {@link NoteParser#expression}.
 * @param ctx the parse tree
 */
fn enter_expression(&mut self, _ctx: &ExpressionContext<'input>) { }
/**
 * Exit a parse tree produced by {@link NoteParser#expression}.
 * @param ctx the parse tree
 */
fn exit_expression(&mut self, _ctx: &ExpressionContext<'input>) { }
/**
 * Enter a parse tree produced by {@link NoteParser#idtype}.
 * @param ctx the parse tree
 */
fn enter_idtype(&mut self, _ctx: &IdtypeContext<'input>) { }
/**
 * Exit a parse tree produced by {@link NoteParser#idtype}.
 * @param ctx the parse tree
 */
fn exit_idtype(&mut self, _ctx: &IdtypeContext<'input>) { }
/**
 * Enter a parse tree produced by {@link NoteParser#valuetype}.
 * @param ctx the parse tree
 */
fn enter_valuetype(&mut self, _ctx: &ValuetypeContext<'input>) { }
/**
 * Exit a parse tree produced by {@link NoteParser#valuetype}.
 * @param ctx the parse tree
 */
fn exit_valuetype(&mut self, _ctx: &ValuetypeContext<'input>) { }
/**
 * Enter a parse tree produced by {@link NoteParser#list}.
 * @param ctx the parse tree
 */
fn enter_list(&mut self, _ctx: &ListContext<'input>) { }
/**
 * Exit a parse tree produced by {@link NoteParser#list}.
 * @param ctx the parse tree
 */
fn exit_list(&mut self, _ctx: &ListContext<'input>) { }
/**
 * Enter a parse tree produced by {@link NoteParser#comment}.
 * @param ctx the parse tree
 */
fn enter_comment(&mut self, _ctx: &CommentContext<'input>) { }
/**
 * Exit a parse tree produced by {@link NoteParser#comment}.
 * @param ctx the parse tree
 */
fn exit_comment(&mut self, _ctx: &CommentContext<'input>) { }

}

antlr_rust::coerce_from!{ 'input : NoteListener<'input> }


