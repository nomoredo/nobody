using nobody.core;
using Spectre.Console;

namespace nobody.console;

public class NobodyConsole
{

    private Object ask( string key)
    {
        var question = $"[yellow]PLEASE PROVIDE A VALUE FOR [/][bold cyan]{key}[/]";
        var q = new TextPrompt<string>($"{question}");
        q.PromptStyle = new Style(Color.Magenta1);
        var answer = AnsiConsole.Prompt(q);
        return answer;
    }
}