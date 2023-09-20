

using Spectre.Console;

namespace termo
{
    public class show {

        //divider
        public static void divider(string text)
        {
                 Console.WriteLine("————————————————————————————————————————————————————————————");
                 //in purple
                 Console.WriteLine($" \x1b[1;35m{text}\x1b[0m");
                 Console.WriteLine("————————————————————————————————————————————————————————————");
        }

        //divider
        public static void divider()
        {
                 Console.WriteLine("————————————————————————————————————————————————————————————");
        }

        // info
        // INFO in gray , text in white, params in cyan
        
        public static void info(string text, params string[] parameters)
        {
           // INFO {text in yellow bold} {params in cyan} next params in cyan +1
            Console.Write($" \x1b[2mINFO\x1b[0m \x1b[1;33m{text}\x1b[0m");
            for (int i = 0; i < parameters.Length; i++)
            {
                Console.Write($" \x1b[1;36m{parameters[i]}\x1b[0m");
            }
            Console.WriteLine();
        }

        internal static void not_found(string v, params string[] parameters)
        {
                // NOT FOUND in orange , text in white, params in cyan
            Console.Write($" \x1b[1;33mNOT FOUND\x1b[0m \x1b[1;33m{v}\x1b[0m");
            for (int i = 0; i < parameters.Length; i++)
            {
                Console.Write($" \x1b[1;36m{parameters[i]}\x1b[0m");
            }
            Console.WriteLine();
        }

        internal static void error(string v, params string[] parameters)
        {
            // ERROR in red , text in white, params in cyan
            Console.Write($" \x1b[1;31mERROR\x1b[0m \x1b[1;33m{v}\x1b[0m");
            for (int i = 0; i < parameters.Length; i++)
            {
                Console.Write($" \x1b[1;36m{parameters[i]}\x1b[0m");
            }
            Console.WriteLine();
        }

        //action
        // ACTION in gray , text in white, params in cyan +1
        public static void action(string text, params string[] parameters)
        {
            Console.Write($" \x1b[2mACTION\x1b[0m \x1b[1;33m{text}\x1b[0m");
            for (int i = 0; i < parameters.Length; i++)
            {
                Console.Write($" \x1b[1;36m{parameters[i]}\x1b[0m");
            }
            Console.WriteLine();
        }


        public static void success(string login)
        {
           AnsiConsole.MarkupLine($"[gray]SUCCESS[/] [green]{login}[/]");
        }
    }
}