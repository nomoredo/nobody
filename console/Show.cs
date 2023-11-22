using nobody.core;
using Spectre.Console;

namespace nobody.console;

public static class AnybodyShow
{
    public static T show<T>(this T nobody, params object[] message) where T : Anybody
    {
        AnsiConsole.MarkupLine(Pigments.Patch(message));

        return nobody;
    }

    /// <summary>
    /// show with access to the context
    /// </summary>
    public static T show<T>(this T nobody, Func<Ctx,object> message) where T : Anybody
    {
        var msg = message(nobody.ctx);
        AnsiConsole.MarkupLine(Pigments.Patch(msg));

        return nobody;
    }






}