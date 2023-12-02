#![allow(nonstandard_style)]
// Generated from Note.g4 by ANTLR 4.8
use antlr_rust::tree::{ParseTreeVisitor,ParseTreeVisitorCompat};
use super::noteparser::*;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link NoteParser}.
 */
pub trait NoteVisitor<'input>: ParseTreeVisitor<'input,NoteParserContextType>{
	/**
	 * Visit a parse tree produced by {@link NoteParser#script}.
	 * @param ctx the parse tree
	 */
	fn visit_script(&mut self, ctx: &ScriptContext<'input>) { self.visit_children(ctx) }

	/**
	 * Visit a parse tree produced by {@link NoteParser#task}.
	 * @param ctx the parse tree
	 */
	fn visit_task(&mut self, ctx: &TaskContext<'input>) { self.visit_children(ctx) }

	/**
	 * Visit a parse tree produced by {@link NoteParser#identifier}.
	 * @param ctx the parse tree
	 */
	fn visit_identifier(&mut self, ctx: &IdentifierContext<'input>) { self.visit_children(ctx) }

	/**
	 * Visit a parse tree produced by {@link NoteParser#parameter}.
	 * @param ctx the parse tree
	 */
	fn visit_parameter(&mut self, ctx: &ParameterContext<'input>) { self.visit_children(ctx) }

	/**
	 * Visit a parse tree produced by {@link NoteParser#taskIdentifier}.
	 * @param ctx the parse tree
	 */
	fn visit_taskIdentifier(&mut self, ctx: &TaskIdentifierContext<'input>) { self.visit_children(ctx) }

	/**
	 * Visit a parse tree produced by {@link NoteParser#variableDeclaration}.
	 * @param ctx the parse tree
	 */
	fn visit_variableDeclaration(&mut self, ctx: &VariableDeclarationContext<'input>) { self.visit_children(ctx) }

	/**
	 * Visit a parse tree produced by {@link NoteParser#taskBody}.
	 * @param ctx the parse tree
	 */
	fn visit_taskBody(&mut self, ctx: &TaskBodyContext<'input>) { self.visit_children(ctx) }

	/**
	 * Visit a parse tree produced by {@link NoteParser#statement}.
	 * @param ctx the parse tree
	 */
	fn visit_statement(&mut self, ctx: &StatementContext<'input>) { self.visit_children(ctx) }

	/**
	 * Visit a parse tree produced by {@link NoteParser#command}.
	 * @param ctx the parse tree
	 */
	fn visit_command(&mut self, ctx: &CommandContext<'input>) { self.visit_children(ctx) }

	/**
	 * Visit a parse tree produced by {@link NoteParser#argument}.
	 * @param ctx the parse tree
	 */
	fn visit_argument(&mut self, ctx: &ArgumentContext<'input>) { self.visit_children(ctx) }

	/**
	 * Visit a parse tree produced by {@link NoteParser#loopStatement}.
	 * @param ctx the parse tree
	 */
	fn visit_loopStatement(&mut self, ctx: &LoopStatementContext<'input>) { self.visit_children(ctx) }

	/**
	 * Visit a parse tree produced by {@link NoteParser#conditionalStatement}.
	 * @param ctx the parse tree
	 */
	fn visit_conditionalStatement(&mut self, ctx: &ConditionalStatementContext<'input>) { self.visit_children(ctx) }

	/**
	 * Visit a parse tree produced by {@link NoteParser#condition}.
	 * @param ctx the parse tree
	 */
	fn visit_condition(&mut self, ctx: &ConditionContext<'input>) { self.visit_children(ctx) }

	/**
	 * Visit a parse tree produced by {@link NoteParser#expression}.
	 * @param ctx the parse tree
	 */
	fn visit_expression(&mut self, ctx: &ExpressionContext<'input>) { self.visit_children(ctx) }

	/**
	 * Visit a parse tree produced by {@link NoteParser#idtype}.
	 * @param ctx the parse tree
	 */
	fn visit_idtype(&mut self, ctx: &IdtypeContext<'input>) { self.visit_children(ctx) }

	/**
	 * Visit a parse tree produced by {@link NoteParser#valuetype}.
	 * @param ctx the parse tree
	 */
	fn visit_valuetype(&mut self, ctx: &ValuetypeContext<'input>) { self.visit_children(ctx) }

	/**
	 * Visit a parse tree produced by {@link NoteParser#list}.
	 * @param ctx the parse tree
	 */
	fn visit_list(&mut self, ctx: &ListContext<'input>) { self.visit_children(ctx) }

	/**
	 * Visit a parse tree produced by {@link NoteParser#comment}.
	 * @param ctx the parse tree
	 */
	fn visit_comment(&mut self, ctx: &CommentContext<'input>) { self.visit_children(ctx) }

}

pub trait NoteVisitorCompat<'input>:ParseTreeVisitorCompat<'input, Node= NoteParserContextType>{
	/**
	 * Visit a parse tree produced by {@link NoteParser#script}.
	 * @param ctx the parse tree
	 */
		fn visit_script(&mut self, ctx: &ScriptContext<'input>) -> Self::Return {
			self.visit_children(ctx)
		}

	/**
	 * Visit a parse tree produced by {@link NoteParser#task}.
	 * @param ctx the parse tree
	 */
		fn visit_task(&mut self, ctx: &TaskContext<'input>) -> Self::Return {
			self.visit_children(ctx)
		}

	/**
	 * Visit a parse tree produced by {@link NoteParser#identifier}.
	 * @param ctx the parse tree
	 */
		fn visit_identifier(&mut self, ctx: &IdentifierContext<'input>) -> Self::Return {
			self.visit_children(ctx)
		}

	/**
	 * Visit a parse tree produced by {@link NoteParser#parameter}.
	 * @param ctx the parse tree
	 */
		fn visit_parameter(&mut self, ctx: &ParameterContext<'input>) -> Self::Return {
			self.visit_children(ctx)
		}

	/**
	 * Visit a parse tree produced by {@link NoteParser#taskIdentifier}.
	 * @param ctx the parse tree
	 */
		fn visit_taskIdentifier(&mut self, ctx: &TaskIdentifierContext<'input>) -> Self::Return {
			self.visit_children(ctx)
		}

	/**
	 * Visit a parse tree produced by {@link NoteParser#variableDeclaration}.
	 * @param ctx the parse tree
	 */
		fn visit_variableDeclaration(&mut self, ctx: &VariableDeclarationContext<'input>) -> Self::Return {
			self.visit_children(ctx)
		}

	/**
	 * Visit a parse tree produced by {@link NoteParser#taskBody}.
	 * @param ctx the parse tree
	 */
		fn visit_taskBody(&mut self, ctx: &TaskBodyContext<'input>) -> Self::Return {
			self.visit_children(ctx)
		}

	/**
	 * Visit a parse tree produced by {@link NoteParser#statement}.
	 * @param ctx the parse tree
	 */
		fn visit_statement(&mut self, ctx: &StatementContext<'input>) -> Self::Return {
			self.visit_children(ctx)
		}

	/**
	 * Visit a parse tree produced by {@link NoteParser#command}.
	 * @param ctx the parse tree
	 */
		fn visit_command(&mut self, ctx: &CommandContext<'input>) -> Self::Return {
			self.visit_children(ctx)
		}

	/**
	 * Visit a parse tree produced by {@link NoteParser#argument}.
	 * @param ctx the parse tree
	 */
		fn visit_argument(&mut self, ctx: &ArgumentContext<'input>) -> Self::Return {
			self.visit_children(ctx)
		}

	/**
	 * Visit a parse tree produced by {@link NoteParser#loopStatement}.
	 * @param ctx the parse tree
	 */
		fn visit_loopStatement(&mut self, ctx: &LoopStatementContext<'input>) -> Self::Return {
			self.visit_children(ctx)
		}

	/**
	 * Visit a parse tree produced by {@link NoteParser#conditionalStatement}.
	 * @param ctx the parse tree
	 */
		fn visit_conditionalStatement(&mut self, ctx: &ConditionalStatementContext<'input>) -> Self::Return {
			self.visit_children(ctx)
		}

	/**
	 * Visit a parse tree produced by {@link NoteParser#condition}.
	 * @param ctx the parse tree
	 */
		fn visit_condition(&mut self, ctx: &ConditionContext<'input>) -> Self::Return {
			self.visit_children(ctx)
		}

	/**
	 * Visit a parse tree produced by {@link NoteParser#expression}.
	 * @param ctx the parse tree
	 */
		fn visit_expression(&mut self, ctx: &ExpressionContext<'input>) -> Self::Return {
			self.visit_children(ctx)
		}

	/**
	 * Visit a parse tree produced by {@link NoteParser#idtype}.
	 * @param ctx the parse tree
	 */
		fn visit_idtype(&mut self, ctx: &IdtypeContext<'input>) -> Self::Return {
			self.visit_children(ctx)
		}

	/**
	 * Visit a parse tree produced by {@link NoteParser#valuetype}.
	 * @param ctx the parse tree
	 */
		fn visit_valuetype(&mut self, ctx: &ValuetypeContext<'input>) -> Self::Return {
			self.visit_children(ctx)
		}

	/**
	 * Visit a parse tree produced by {@link NoteParser#list}.
	 * @param ctx the parse tree
	 */
		fn visit_list(&mut self, ctx: &ListContext<'input>) -> Self::Return {
			self.visit_children(ctx)
		}

	/**
	 * Visit a parse tree produced by {@link NoteParser#comment}.
	 * @param ctx the parse tree
	 */
		fn visit_comment(&mut self, ctx: &CommentContext<'input>) -> Self::Return {
			self.visit_children(ctx)
		}

}

impl<'input,T> NoteVisitor<'input> for T
where
	T: NoteVisitorCompat<'input>
{
	fn visit_script(&mut self, ctx: &ScriptContext<'input>){
		let result = <Self as NoteVisitorCompat>::visit_script(self, ctx);
        *<Self as ParseTreeVisitorCompat>::temp_result(self) = result;
	}

	fn visit_task(&mut self, ctx: &TaskContext<'input>){
		let result = <Self as NoteVisitorCompat>::visit_task(self, ctx);
        *<Self as ParseTreeVisitorCompat>::temp_result(self) = result;
	}

	fn visit_identifier(&mut self, ctx: &IdentifierContext<'input>){
		let result = <Self as NoteVisitorCompat>::visit_identifier(self, ctx);
        *<Self as ParseTreeVisitorCompat>::temp_result(self) = result;
	}

	fn visit_parameter(&mut self, ctx: &ParameterContext<'input>){
		let result = <Self as NoteVisitorCompat>::visit_parameter(self, ctx);
        *<Self as ParseTreeVisitorCompat>::temp_result(self) = result;
	}

	fn visit_taskIdentifier(&mut self, ctx: &TaskIdentifierContext<'input>){
		let result = <Self as NoteVisitorCompat>::visit_taskIdentifier(self, ctx);
        *<Self as ParseTreeVisitorCompat>::temp_result(self) = result;
	}

	fn visit_variableDeclaration(&mut self, ctx: &VariableDeclarationContext<'input>){
		let result = <Self as NoteVisitorCompat>::visit_variableDeclaration(self, ctx);
        *<Self as ParseTreeVisitorCompat>::temp_result(self) = result;
	}

	fn visit_taskBody(&mut self, ctx: &TaskBodyContext<'input>){
		let result = <Self as NoteVisitorCompat>::visit_taskBody(self, ctx);
        *<Self as ParseTreeVisitorCompat>::temp_result(self) = result;
	}

	fn visit_statement(&mut self, ctx: &StatementContext<'input>){
		let result = <Self as NoteVisitorCompat>::visit_statement(self, ctx);
        *<Self as ParseTreeVisitorCompat>::temp_result(self) = result;
	}

	fn visit_command(&mut self, ctx: &CommandContext<'input>){
		let result = <Self as NoteVisitorCompat>::visit_command(self, ctx);
        *<Self as ParseTreeVisitorCompat>::temp_result(self) = result;
	}

	fn visit_argument(&mut self, ctx: &ArgumentContext<'input>){
		let result = <Self as NoteVisitorCompat>::visit_argument(self, ctx);
        *<Self as ParseTreeVisitorCompat>::temp_result(self) = result;
	}

	fn visit_loopStatement(&mut self, ctx: &LoopStatementContext<'input>){
		let result = <Self as NoteVisitorCompat>::visit_loopStatement(self, ctx);
        *<Self as ParseTreeVisitorCompat>::temp_result(self) = result;
	}

	fn visit_conditionalStatement(&mut self, ctx: &ConditionalStatementContext<'input>){
		let result = <Self as NoteVisitorCompat>::visit_conditionalStatement(self, ctx);
        *<Self as ParseTreeVisitorCompat>::temp_result(self) = result;
	}

	fn visit_condition(&mut self, ctx: &ConditionContext<'input>){
		let result = <Self as NoteVisitorCompat>::visit_condition(self, ctx);
        *<Self as ParseTreeVisitorCompat>::temp_result(self) = result;
	}

	fn visit_expression(&mut self, ctx: &ExpressionContext<'input>){
		let result = <Self as NoteVisitorCompat>::visit_expression(self, ctx);
        *<Self as ParseTreeVisitorCompat>::temp_result(self) = result;
	}

	fn visit_idtype(&mut self, ctx: &IdtypeContext<'input>){
		let result = <Self as NoteVisitorCompat>::visit_idtype(self, ctx);
        *<Self as ParseTreeVisitorCompat>::temp_result(self) = result;
	}

	fn visit_valuetype(&mut self, ctx: &ValuetypeContext<'input>){
		let result = <Self as NoteVisitorCompat>::visit_valuetype(self, ctx);
        *<Self as ParseTreeVisitorCompat>::temp_result(self) = result;
	}

	fn visit_list(&mut self, ctx: &ListContext<'input>){
		let result = <Self as NoteVisitorCompat>::visit_list(self, ctx);
        *<Self as ParseTreeVisitorCompat>::temp_result(self) = result;
	}

	fn visit_comment(&mut self, ctx: &CommentContext<'input>){
		let result = <Self as NoteVisitorCompat>::visit_comment(self, ctx);
        *<Self as ParseTreeVisitorCompat>::temp_result(self) = result;
	}

}