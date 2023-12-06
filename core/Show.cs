using Serilog;
using Serilog.Events;
using Spectre.Console;

namespace nobody.core;

public static class Show
{
    public static T show<T>(this T nobody, params object[] message) where T : Anybody
    {
        AnsiConsole.MarkupLine(Pigments.patch(message));

        return nobody;
    }

    /// <summary>
    /// show with access to the context
    /// </summary>
    public static T show<T>(this T nobody, Func<Ctx,object> message) where T : Anybody
    {
        var msg = message(Anybody.ctx);
        AnsiConsole.MarkupLine(Pigments.patch(msg));

        return nobody;
    }






}


public class SomeLogger : ILogger
{





    public void Write(LogEvent logEvent)
    {
        switch (logEvent)
        {
            case {Level: LogEventLevel.Debug}:
                AnsiConsole.MarkupLine($"[magenta]DBG[/] {logEvent.RenderMessage()}");
                break;
            case {Level: LogEventLevel.Information}:
                AnsiConsole.MarkupLine($"[cyan]INF[/] {logEvent.RenderMessage()}");
                break;
            case {Level: LogEventLevel.Warning}:
                AnsiConsole.MarkupLine($"[yellow]WRN[/] {logEvent.RenderMessage()}");
                break;
            case {Level: LogEventLevel.Error}:
                AnsiConsole.MarkupLine($"[red]ERR[/] {logEvent.RenderMessage()}");
                break;
            case {Level: LogEventLevel.Fatal}:
                AnsiConsole.MarkupLine($"[red]FAT[/] {logEvent.RenderMessage()}");
                break;
            default:
                AnsiConsole.MarkupLine($"[gray]???[/] {logEvent.RenderMessage()}");
                break;
        }
    }
}
