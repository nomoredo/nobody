

using System.Diagnostics;
using Spectre.Console;

namespace termo
{
    public class show
    {

        //divider
        public static void divider(string text)
        {
            Console.WriteLine("────────────────────────────────────────────────────────────");
            //in purple
            Console.WriteLine($" \x1b[1;35m{text}\x1b[0m");
            Console.WriteLine("────────────────────────────────────────────────────────────");
        }

        //divider
        public static void divider()
        {
            Console.WriteLine("────────────────────────────────────────────────────────────");
        }

         static  string[] color_sequence = new string[] { "cyan", "magenta", "yellow", "green", "blue", "red" };

        // info
        // INFO in gray , text in white, params in cyan

        public static void info(string text, params string[] parameters)
        {
         //info in gray, text in white , params in sequence of colors
            AnsiConsole.MarkupInterpolated($"[gray] INFO[/] [white]{text}[/]");
            for (int i = 0; i < parameters.Length; i++)
            {
                AnsiConsole.MarkupInterpolated($" [{color_sequence[i]}]{parameters[i]}[/]");
            }    
            AnsiConsole.WriteLine();
        }

        public static void not_found(string v, params string[] parameters)
        {
            // NOT FOUND in orange , text in white, params in cyan
          AnsiConsole.MarkupInterpolated($"[orange] NOT FOUND[/] [white]{v}[/]");
            for (int i = 0; i < parameters.Length; i++)
            {
                AnsiConsole.MarkupInterpolated($"[yellow]{parameters[i]}[/]");
            }

            AnsiConsole.WriteLine();
        }

        public static void error(string v, params string[] parameters)
        {
            // ERROR in red , text in white, params in cyan
            AnsiConsole.MarkupInterpolated($"[red] ERROR[/] [white]{v}[/]");
            for (int i = 0; i < parameters.Length; i++)
            {
                AnsiConsole.MarkupInterpolated($"[yellow]{parameters[i]}[/]");
            }
            AnsiConsole.WriteLine();

        }

        //action
        // ACTION in gray , text in white, params in cyan +1
        public static void action(string text, params string[] parameters)
        {
            AnsiConsole.MarkupInterpolated($"[gray] ACTION[/] [white]{text}[/]");
            for (int i = 0; i < parameters.Length; i++)
            {
                AnsiConsole.MarkupInterpolated($" [{color_sequence[i+1]}]{parameters[i]}[/]");
            }
            AnsiConsole.WriteLine();
        }


        public static void success(string login, params string[] parameters)
        {
            // SUCCESS in green , text in white, params in cyan
            AnsiConsole.MarkupInterpolated($"[green] SUCCESS[/] [white]{login}[/]");
            for (int i = 0; i < parameters.Length; i++)
            {
                AnsiConsole.MarkupInterpolated($" [{color_sequence[i+1]}]{parameters[i]}[/]");
            }
            AnsiConsole.WriteLine();
        }

        public static void end_success(string v, params string[] parameters)
        {
            // END SUCCESS in green , text in white, params in cyan
            AnsiConsole.MarkupInterpolated($"╰─[green] SUCCESS[/] [white]{v}[/]");
            for (int i = 0; i < parameters.Length; i++)
            {
                AnsiConsole.MarkupInterpolated($" [{color_sequence[i+1]}]{parameters[i]}[/]");
            }
            AnsiConsole.WriteLine();
        }



        internal static void request(params string[] parameters)
        {
            // print request and its properties in a
            // neat and structured way
            //╭─ REQUEST /login POST
            //│ HEADERS:
            //│ POST DATA: username=123&password=123
            //╰─ END

            AnsiConsole.MarkupLineInterpolated($"[yellow]╭─[/][gray] REQUEST[/] [green]{parameters[0]}[/]");
            for (int i = 1; i < parameters.Length; i++)
            {
                AnsiConsole.MarkupLineInterpolated($"[yellow]│[/][gray] {parameters[i]}[/]");
            }
            AnsiConsole.MarkupLineInterpolated($"[yellow]╰─[/][gray] END[/]");
        }

        public static void response(params string[] parameters)
        {
            // print response and its properties in a
            // neat and structured way
            //╭─ RESPONSE /login POST
            //│ HEADERS:
            //│ POST DATA: username=123&password=123
            //╰─ END

            AnsiConsole.MarkupLineInterpolated($"[yellow]╭─[/][gray] RESPONSE[/] [green]{parameters[0]}[/]");
            for (int i = 1; i < parameters.Length; i++)
            {
                AnsiConsole.MarkupLineInterpolated($"[yellow]│[/][gray] {parameters[i]}[/]");
            }
            AnsiConsole.MarkupLineInterpolated($"[yellow]┕─[/][gray] END[/]");
        }

        public static void start(string item, params string[] parameters)
        {
            // print start and its properties in a
            // neat and structured way
            //╭─ START /login POST


            AnsiConsole.MarkupInterpolated($"[yellow][/] [cyan]{item}[/]");
            //each parameter is a color in sequence
            for (int i = 0; i < parameters.Length; i++)
            {
                AnsiConsole.MarkupInterpolated($" [{color_sequence[i]}]{parameters[i]}[/]");
            }
            AnsiConsole.WriteLine();
        }

        public static void input(string label, bool v1, bool v2)
        {

            //│ INPUT username [RANGE] [MULTI]
            AnsiConsole.MarkupInterpolated($"[yellow]│[/] [white]INPUT[/] [white]{label}[/]");
            if (v1)
                AnsiConsole.MarkupInterpolated($" [white]RANGE[/]");
            if (v2)
                AnsiConsole.MarkupInterpolated($" [white]MULTI[/]");

        }

        public static void step(string v1, params string[] parameters)
        {
            //│ STEP LOGIN
            AnsiConsole.MarkupInterpolated($"[yellow]│[/] [white]STEP[/] [white]{v1}[/]");
            for (int i = 0; i < parameters.Length; i++)
            {
                AnsiConsole.MarkupInterpolated($"│ [{color_sequence[i]}]{parameters[i]}[/]");
            }
            AnsiConsole.WriteLine();
        }
    }
}

    
