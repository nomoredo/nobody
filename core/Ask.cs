using Spectre.Console;

namespace nobody.core;

public static class Ask
{
    public static Anybody prompt<T>(this Anybody anybody, string prompt, Action<TextPrompt<T>> configure)
    {
       var cprompt = new TextPrompt<T>(prompt);
       configure(cprompt);
       var presult = AnsiConsole.Prompt<T>(cprompt);
       anybody.set(prompt, presult);
       return anybody;

    }

    public static Anybody prompt<T>(this Anybody anybody, string prompt)
    {
       var cprompt = new TextPrompt<T>(prompt);
       var presult = AnsiConsole.Prompt<T>(cprompt);
       anybody.set(prompt, presult);
       return anybody;

    }

    public static Anybody ask<T>(this Anybody anybody, string prompt)
    {
         var presult = AnsiConsole.Ask<T>(prompt);
         anybody.set(prompt, presult);
         return anybody;
    }

    public static Anybody ask_string(this Anybody anybody, string prompt)
    {
         var presult = AnsiConsole.Ask<string>(prompt);
         anybody.set(prompt, presult);
         return anybody;
    }

     public static Anybody ask_string(this Anybody anybody, string prompt, string defaultValue)
     {
           var presult = AnsiConsole.Ask<string>(prompt, defaultValue);
           anybody.set(prompt, presult);
           return anybody;
     }

     public static Anybody ask_int(this Anybody anybody, string prompt)
     {
           var presult = AnsiConsole.Ask<int>(prompt);
           anybody.set(prompt, presult);
           return anybody;
     }

     public static Anybody ask_int(this Anybody anybody, string prompt, int defaultValue)
     {
           var presult = AnsiConsole.Ask<int>(prompt, defaultValue);
           anybody.set(prompt, presult);
           return anybody;
     }

     public static Anybody ask_decimal(this Anybody anybody, string prompt)
     {
           var presult = AnsiConsole.Ask<decimal>(prompt);
           anybody.set(prompt, presult);
           return anybody;
     }

     public static Anybody ask_decimal(this Anybody anybody, string prompt, decimal defaultValue)
     {
           var presult = AnsiConsole.Ask<decimal>(prompt, defaultValue);
           anybody.set(prompt, presult);
           return anybody;
     }

     public static Anybody ask_double(this Anybody anybody, string prompt)
     {
           var presult = AnsiConsole.Ask<double>(prompt);
           anybody.set(prompt, presult);
           return anybody;
     }

     public static Anybody ask_double(this Anybody anybody, string prompt, double defaultValue)
     {
           var presult = AnsiConsole.Ask<double>(prompt, defaultValue);
           anybody.set(prompt, presult);
           return anybody;
     }

     public static Anybody ask_float(this Anybody anybody, string prompt)
     {
           var presult = AnsiConsole.Ask<float>(prompt);
           anybody.set(prompt, presult);
           return anybody;
     }

     public static Anybody ask_float(this Anybody anybody, string prompt, float defaultValue)
     {
           var presult = AnsiConsole.Ask<float>(prompt, defaultValue);
           anybody.set(prompt, presult);
           return anybody;
     }

     public static Anybody ask_bool(this Anybody anybody, string prompt)
     {
           var presult = AnsiConsole.Ask<bool>(prompt);
           anybody.set(prompt, presult);
           return anybody;
     }

     public static Anybody ask_bool(this Anybody anybody, string prompt, bool defaultValue)
     {
           var presult = AnsiConsole.Ask<bool>(prompt, defaultValue);
           anybody.set(prompt, presult);
           return anybody;
     }

     

    public static Anybody ask<T>(this Anybody anybody, string prompt, T defaultValue)
    {
         var presult = AnsiConsole.Ask<T>(prompt, defaultValue);
         anybody.set(prompt, presult);
         return anybody;
    }

    public static Anybody confirm(this Anybody anybody, string prompt, bool defaultValue = true)
    {
         var presult = AnsiConsole.Confirm(prompt, defaultValue);
         anybody.set(prompt, presult);
         return anybody;
    }

    public static Anybody confirm(this Anybody anybody, string prompt)
    {
         var presult = AnsiConsole.Confirm(prompt);
         anybody.set(prompt, presult);
         return anybody;
    }

     public static Anybody confirm(this Anybody anybody, string prompt, Action<ConfirmationPrompt> configure)
     {
           var cprompt = new ConfirmationPrompt(prompt);
           configure(cprompt);
           var presult = AnsiConsole.Prompt<bool>(cprompt);
           anybody.set(prompt, presult);
           return anybody;
     }

     public static Anybody select<T>(this Anybody anybody, string prompt, IEnumerable<T> choices) where T : notnull
     {
         var presult = AnsiConsole.Prompt(new SelectionPrompt<T>().AddChoices(choices));
         anybody.set(prompt, presult);
         return anybody;
     }

     public static Anybody select<T>(this Anybody anybody, string prompt, IEnumerable<T> choices, Action<SelectionPrompt<T>> configure) where T : notnull
     {
         var cprompt = new SelectionPrompt<T>().AddChoices(choices);
         configure(cprompt);
         var presult = AnsiConsole.Prompt(cprompt);
         anybody.set(prompt, presult);
         return anybody;
     }
}





     

