// Generated from C:/repo/nobody/grammar/note.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link noteParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface noteVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link noteParser#script}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitScript(noteParser.ScriptContext ctx);
	/**
	 * Visit a parse tree produced by {@link noteParser#task}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTask(noteParser.TaskContext ctx);
	/**
	 * Visit a parse tree produced by {@link noteParser#identifier}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIdentifier(noteParser.IdentifierContext ctx);
	/**
	 * Visit a parse tree produced by {@link noteParser#parameter}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParameter(noteParser.ParameterContext ctx);
	/**
	 * Visit a parse tree produced by {@link noteParser#taskIdentifier}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTaskIdentifier(noteParser.TaskIdentifierContext ctx);
	/**
	 * Visit a parse tree produced by {@link noteParser#variableDeclaration}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVariableDeclaration(noteParser.VariableDeclarationContext ctx);
	/**
	 * Visit a parse tree produced by {@link noteParser#taskBody}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTaskBody(noteParser.TaskBodyContext ctx);
	/**
	 * Visit a parse tree produced by {@link noteParser#statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStatement(noteParser.StatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link noteParser#command}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCommand(noteParser.CommandContext ctx);
	/**
	 * Visit a parse tree produced by {@link noteParser#argument}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitArgument(noteParser.ArgumentContext ctx);
	/**
	 * Visit a parse tree produced by {@link noteParser#loopStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLoopStatement(noteParser.LoopStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link noteParser#conditionalStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitConditionalStatement(noteParser.ConditionalStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link noteParser#condition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCondition(noteParser.ConditionContext ctx);
	/**
	 * Visit a parse tree produced by {@link noteParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpression(noteParser.ExpressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link noteParser#idtype}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIdtype(noteParser.IdtypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link noteParser#valuetype}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitValuetype(noteParser.ValuetypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link noteParser#list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitList(noteParser.ListContext ctx);
	/**
	 * Visit a parse tree produced by {@link noteParser#comment}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitComment(noteParser.CommentContext ctx);
}