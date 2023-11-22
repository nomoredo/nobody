using nobody.core;
using Spectre.Console;

namespace nobody.console;

public static class Ask
{

   

    public static T ask<T>(this T nobody,string key, string? question = null, Action<TextPrompt<string>>? questionAction = null) where T : Anybody
    {
        question ??= $"[yellow]PLEASE PROVIDE A VALUE FOR [/][bold cyan]{key}[/]";
        var q = new TextPrompt<string>($"{question}");
        q.PromptStyle = new Style(Color.Magenta1);
        questionAction?.Invoke(q);
        var answer = AnsiConsole.Prompt(q);
        nobody.ctx[key] = answer;
        return nobody;
    }


    public static T ask_number<T>(this T nobody, string key, string? question = null, Action<TextPrompt<int>>? questionAction = null)where T : Anybody
    {
        question ??= $"Please provide a value for [bold]{key}[/]?";
        var q = new TextPrompt<int>($"{question} ");
        q.PromptStyle = new Style(Color.Magenta1);
        questionAction?.Invoke(q);
        var answer = AnsiConsole.Prompt(q);
        nobody.ctx[key] = answer;
        return nobody;
    }

    public static T ask_bool<T>(this T nobody, string key, string? question = null, Action<ConfirmationPrompt>? questionAction = null)where T : Anybody
    {
        question ??= $"Please provide a value for [bold]{key}[/]?";
        var q = new ConfirmationPrompt($"{question} ");
        // q.PromptStyle = new Style(Color.Magenta1);
        questionAction?.Invoke(q);
        var answer = AnsiConsole.Prompt(q);
        nobody.ctx[key] = answer;
        return nobody;
    }


    public static T ask_secret<T>(this T nobody, string key, string? question = null, Action<TextPrompt<String>>? questionAction = null)where T : Anybody
    {
        question ??= $"Please provide a value for [bold]{key}[/]?";
        var q = new TextPrompt<string>($"{question} ");
        q.PromptStyle = new Style(Color.Magenta3);
        q.Mask = '*';
        q.IsSecret = true;
        questionAction?.Invoke(q);
        var answer = AnsiConsole.Prompt(q);
        nobody.ctx[key] = answer;
        return nobody;
    }

    public static T ask_choice<T>(this T nobody, string key,string[] choices,string? question = null, Action<SelectionPrompt<string>>? questionAction = null)where T : Anybody
    {
        question ??= $"Please provide a value for [bold]{key}[/]?";
        var q = new SelectionPrompt<string>();
        q.Title = question;
        q.AddChoices(choices);
        questionAction?.Invoke(q);
        var answer = AnsiConsole.Prompt(q);
        nobody.ctx[key] = answer;
        return nobody;
    }



}