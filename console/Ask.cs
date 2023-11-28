using nobody.core;
using Spectre.Console;

namespace nobody.console;

public static class Ask
{
    public static T prompt<T>(this T nobody, string key, IPrompt<T> prompt) where T : Anybody
    {
        var result = AnsiConsole.Prompt(prompt);
        return result;
    }

    public static T ask<T, U>(this T nobody, string key, TextPrompt<U> prompt, bool remember = false,bool secret = false) where T : Anybody
    {
        if (secret) prompt.IsSecret = true;
        var result = AnsiConsole.Prompt(prompt);
        if (remember) nobody.set(key, result);
        return nobody;
    }

    public static T ask<T,U>(this T nobody, string key, Action<TextPrompt<U>>? options = null, bool remember = false,bool secret = false) where T : Anybody
    {
        var prompt = new TextPrompt<U>($"[yellow]PLEASE PROVIDE A VALUE FOR [/][bold cyan]{key}[/]");
        options?.Invoke(prompt);
        return nobody.ask<T, U>(key, prompt, remember,secret);
    }

    public static T ask_string<T>(this T nobody, string key, Action<TextPrompt<string>>? options = null, bool remember = false,bool secret = false) where T : Anybody
    {
        var prompt = new TextPrompt<string>($"[yellow]PLEASE PROVIDE A VALUE FOR [/][bold cyan]{key}[/]");
        options?.Invoke(prompt);
        return nobody.ask<T, string>(key, prompt, remember,secret);
    }

    public static T ask_string<T>(this T nobody, string key, string? question = null) where T : Anybody
    {
        var prompt = new TextPrompt<string>($"[yellow]PLEASE PROVIDE A VALUE FOR [/][bold cyan]{key}[/]");
        var result = AnsiConsole.Prompt(prompt);
        nobody.set(key, result);
        return nobody;
    }

    public static T ask_int<T>(this T nobody, string key, Action<TextPrompt<int>>? options = null, bool remember = false) where T : Anybody
    {
        var prompt = new TextPrompt<int>($"[yellow]PLEASE PROVIDE A VALUE FOR [/][bold cyan]{key}[/]");
        options?.Invoke(prompt);
        var result = AnsiConsole.Prompt(prompt);
        nobody.set(key, result);
        return nobody;
    }

    public static T ask_bool<T>(this T nobody, string key, Action<ConfirmationPrompt>? options = null, bool remember = false) where T : Anybody
    {
        var prompt = new ConfirmationPrompt($"[yellow]PLEASE PROVIDE A VALUE FOR [/][bold cyan]{key}[/]");
        options?.Invoke(prompt);
        var result = AnsiConsole.Prompt(prompt);
        nobody.set(key, result);
        return nobody;
    }



    public static U get_or_ask<T, U>(this T nobody, string key, TextPrompt<U> prompt, bool remember = false) where T : Anybody
    {
        if (nobody.has(key))
        {
            return nobody.get<U>(key)!;
        }
        else
        {
            var result = AnsiConsole.Prompt(prompt);
            if (remember) nobody.set(key, result);
            return result;
        }
    }

    public static U ask_choice<T, U>(this T nobody, string key, SelectionPrompt<U> prompt, bool remember = false) where T : Anybody
    {
        var result = AnsiConsole.Prompt(prompt);
        if (remember) nobody.set(key, result);
        return result;
    }

    public static U ask_choice<T, U>(this T nobody, string key, List<U> choices, bool remember = false) where T : Anybody
    {
        var prompt = new SelectionPrompt<U>();
        prompt.AddChoices(choices);
        var result = AnsiConsole.Prompt(prompt);
        if (remember) nobody.set(key, result);
        return result;
    }


}