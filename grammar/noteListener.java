// Generated from C:/repo/nobody/grammar/note.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link noteParser}.
 */
public interface noteListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link noteParser#script}.
	 * @param ctx the parse tree
	 */
	void enterScript(noteParser.ScriptContext ctx);
	/**
	 * Exit a parse tree produced by {@link noteParser#script}.
	 * @param ctx the parse tree
	 */
	void exitScript(noteParser.ScriptContext ctx);
	/**
	 * Enter a parse tree produced by {@link noteParser#task}.
	 * @param ctx the parse tree
	 */
	void enterTask(noteParser.TaskContext ctx);
	/**
	 * Exit a parse tree produced by {@link noteParser#task}.
	 * @param ctx the parse tree
	 */
	void exitTask(noteParser.TaskContext ctx);
	/**
	 * Enter a parse tree produced by {@link noteParser#identifier}.
	 * @param ctx the parse tree
	 */
	void enterIdentifier(noteParser.IdentifierContext ctx);
	/**
	 * Exit a parse tree produced by {@link noteParser#identifier}.
	 * @param ctx the parse tree
	 */
	void exitIdentifier(noteParser.IdentifierContext ctx);
	/**
	 * Enter a parse tree produced by {@link noteParser#parameter}.
	 * @param ctx the parse tree
	 */
	void enterParameter(noteParser.ParameterContext ctx);
	/**
	 * Exit a parse tree produced by {@link noteParser#parameter}.
	 * @param ctx the parse tree
	 */
	void exitParameter(noteParser.ParameterContext ctx);
	/**
	 * Enter a parse tree produced by {@link noteParser#taskIdentifier}.
	 * @param ctx the parse tree
	 */
	void enterTaskIdentifier(noteParser.TaskIdentifierContext ctx);
	/**
	 * Exit a parse tree produced by {@link noteParser#taskIdentifier}.
	 * @param ctx the parse tree
	 */
	void exitTaskIdentifier(noteParser.TaskIdentifierContext ctx);
	/**
	 * Enter a parse tree produced by {@link noteParser#variableDeclaration}.
	 * @param ctx the parse tree
	 */
	void enterVariableDeclaration(noteParser.VariableDeclarationContext ctx);
	/**
	 * Exit a parse tree produced by {@link noteParser#variableDeclaration}.
	 * @param ctx the parse tree
	 */
	void exitVariableDeclaration(noteParser.VariableDeclarationContext ctx);
	/**
	 * Enter a parse tree produced by {@link noteParser#taskBody}.
	 * @param ctx the parse tree
	 */
	void enterTaskBody(noteParser.TaskBodyContext ctx);
	/**
	 * Exit a parse tree produced by {@link noteParser#taskBody}.
	 * @param ctx the parse tree
	 */
	void exitTaskBody(noteParser.TaskBodyContext ctx);
	/**
	 * Enter a parse tree produced by {@link noteParser#statement}.
	 * @param ctx the parse tree
	 */
	void enterStatement(noteParser.StatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link noteParser#statement}.
	 * @param ctx the parse tree
	 */
	void exitStatement(noteParser.StatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link noteParser#command}.
	 * @param ctx the parse tree
	 */
	void enterCommand(noteParser.CommandContext ctx);
	/**
	 * Exit a parse tree produced by {@link noteParser#command}.
	 * @param ctx the parse tree
	 */
	void exitCommand(noteParser.CommandContext ctx);
	/**
	 * Enter a parse tree produced by {@link noteParser#argument}.
	 * @param ctx the parse tree
	 */
	void enterArgument(noteParser.ArgumentContext ctx);
	/**
	 * Exit a parse tree produced by {@link noteParser#argument}.
	 * @param ctx the parse tree
	 */
	void exitArgument(noteParser.ArgumentContext ctx);
	/**
	 * Enter a parse tree produced by {@link noteParser#loopStatement}.
	 * @param ctx the parse tree
	 */
	void enterLoopStatement(noteParser.LoopStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link noteParser#loopStatement}.
	 * @param ctx the parse tree
	 */
	void exitLoopStatement(noteParser.LoopStatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link noteParser#conditionalStatement}.
	 * @param ctx the parse tree
	 */
	void enterConditionalStatement(noteParser.ConditionalStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link noteParser#conditionalStatement}.
	 * @param ctx the parse tree
	 */
	void exitConditionalStatement(noteParser.ConditionalStatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link noteParser#condition}.
	 * @param ctx the parse tree
	 */
	void enterCondition(noteParser.ConditionContext ctx);
	/**
	 * Exit a parse tree produced by {@link noteParser#condition}.
	 * @param ctx the parse tree
	 */
	void exitCondition(noteParser.ConditionContext ctx);
	/**
	 * Enter a parse tree produced by {@link noteParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterExpression(noteParser.ExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link noteParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitExpression(noteParser.ExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link noteParser#idtype}.
	 * @param ctx the parse tree
	 */
	void enterIdtype(noteParser.IdtypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link noteParser#idtype}.
	 * @param ctx the parse tree
	 */
	void exitIdtype(noteParser.IdtypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link noteParser#valuetype}.
	 * @param ctx the parse tree
	 */
	void enterValuetype(noteParser.ValuetypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link noteParser#valuetype}.
	 * @param ctx the parse tree
	 */
	void exitValuetype(noteParser.ValuetypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link noteParser#list}.
	 * @param ctx the parse tree
	 */
	void enterList(noteParser.ListContext ctx);
	/**
	 * Exit a parse tree produced by {@link noteParser#list}.
	 * @param ctx the parse tree
	 */
	void exitList(noteParser.ListContext ctx);
	/**
	 * Enter a parse tree produced by {@link noteParser#comment}.
	 * @param ctx the parse tree
	 */
	void enterComment(noteParser.CommentContext ctx);
	/**
	 * Exit a parse tree produced by {@link noteParser#comment}.
	 * @param ctx the parse tree
	 */
	void exitComment(noteParser.CommentContext ctx);
}