using nobody.core;
using Spectre.Console;

namespace nobody.console
{
    public static class ShowExt
    {
        public static Nobody show(this Nobody nobody, params object[] message)
        {
            //based on the number of parameters, we can pick a color scheme
            var pallette = message.FirstOrDefault() switch
            {
                "info" => Pigments.info,
                "warning" => Pigments.warning,
                "error" => Pigments.error,
                _ => Pigments.basic
            };

            AnsiConsole.MarkupLine(Pigments.Patch(message));

            return nobody;
        }

        /// <summary>
        /// show with access to the context
        /// </summary>
        public static Nobody show(this Nobody nobody, Func<Ctx,object> message)
        {
            
            var msg = message(nobody.ctx);
            AnsiConsole.MarkupLine(Pigments.Patch(msg));

            return nobody;
        }

        public static Nobody inform(this Nobody nobody, params object[] message)
        {
            //add "info" to the beginning of the message
            var msg = new object[message.Length + 1];
            msg[0] = "info";
            message.CopyTo(msg, 1);
            AnsiConsole.MarkupLine(Pigments.Patch(msg));

            return nobody;
        }



        public static Nobody warn(this Nobody nobody, params object[] message)
        {
            //add "warning" to the beginning of the message
            var msg = new object[message.Length + 1];
            msg[0] = "warning";
            message.CopyTo(msg, 1);
            AnsiConsole.MarkupLine(Pigments.Patch(msg));

            return nobody;
        }

        public static Nobody error(this Nobody nobody, params object[] message)
        {
            //add "error" to the beginning of the message
            var msg = new object[message.Length + 1];
            msg[0] = "error";
            message.CopyTo(msg, 1);
            AnsiConsole.MarkupLine(Pigments.Patch(msg));

            return nobody;
        }




    }
}


public static class AskExt
{

    public static Nobody ask(this Nobody nobody,string key, string? question = null, Action<TextPrompt<string>>? questionAction = null)
    {
        question ??= $"Please provide a value for [bold]{key}[/]?";
        var q = new TextPrompt<string>($"{question} ");
        q.PromptStyle = new Style(Color.Magenta1);
        questionAction?.Invoke(q);
        var answer = AnsiConsole.Prompt(q); 
        nobody.ctx[key] = answer;
        return nobody;
    }


    public static Nobody ask_number(this Nobody nobody, string key, string? question = null, Action<TextPrompt<int>>? questionAction = null)
    {
        question ??= $"Please provide a value for [bold]{key}[/]?";
        var q = new TextPrompt<int>($"{question} ");
        q.PromptStyle = new Style(Color.Magenta1);
        questionAction?.Invoke(q);
        var answer = AnsiConsole.Prompt(q); 
        nobody.ctx[key] = answer;
        return nobody;
    }

    public static Nobody ask_bool(this Nobody nobody, string key, string? question = null, Action<ConfirmationPrompt>? questionAction = null)
    {
        question ??= $"Please provide a value for [bold]{key}[/]?";
        var q = new ConfirmationPrompt($"{question} ");
        // q.PromptStyle = new Style(Color.Magenta1);
        questionAction?.Invoke(q);
        var answer = AnsiConsole.Prompt(q); 
        nobody.ctx[key] = answer;
        return nobody;
    }


    public static Nobody ask_secret(this Nobody nobody, string key, string? question = null, Action<TextPrompt<String>>? questionAction = null)
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

    public static Nobody ask_choice(this Nobody nobody, string key,string[] choices,string? question = null, Action<SelectionPrompt<string>>? questionAction = null)
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