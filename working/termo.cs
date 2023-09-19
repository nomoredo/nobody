

namespace termo
{
    public class show {

        //divider
        public static void divider(string text)
        {
                 Console.WriteLine("————————————————————————————————————————————————————————————");
            Console.WriteLine(text);
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
            Console.ForegroundColor = ConsoleColor.Gray;
            Console.Write("INFO: ");
            Console.ForegroundColor = ConsoleColor.White;
            Console.Write(text);
            Console.ForegroundColor = ConsoleColor.Gray;
            Console.Write(" ");
            foreach (var param in parameters)
            {
                Console.ForegroundColor = ConsoleColor.Cyan;
                Console.Write(param);
                Console.ForegroundColor = ConsoleColor.Gray;
                Console.Write(" ");
            }
            Console.WriteLine();
        }

        internal static void not_found(string v, params string[] parameters)
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.Write("NOT FOUND: ");
            Console.ForegroundColor = ConsoleColor.White;
            Console.Write(v);
            Console.ForegroundColor = ConsoleColor.Gray;
            Console.Write(" ");
            foreach (var param in parameters)
            {
                Console.ForegroundColor = ConsoleColor.Cyan;
                Console.Write(param);
                Console.ForegroundColor = ConsoleColor.Gray;
                Console.Write(" ");
            }
            Console.WriteLine();
        }

        
    }
}