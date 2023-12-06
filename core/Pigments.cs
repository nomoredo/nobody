using System.Text;

namespace nobody.core
{
    public static class Pigments
    {
        /// <summary>
        ///  patch colors
        /// </summary>
        /// <param name="message"></param>
        /// eg: "[gray]Hello[/][white]there[/][cyan]...[/]"
        public static string patch(params object[] message)
        {
            StringBuilder sb = new StringBuilder();
            var pallette = message.FirstOrDefault()?.ToString()?.ToLower() switch
            {
                "info" => Pigments.info_colors,
                "warning" => Pigments.warning_colors,
                "error" => Pigments.error_colors,
                _ => Pigments.basic_colors
            };

            message[0] = message[0]?.ToString()?.ToUpper() ?? "";

            for (int i = 0; i < message.Length; i++)
            {
                sb.Append($"[{pallette[i % pallette.Length]}]{message[i]}[/] ");
            }

            return sb.ToString();
        }


        private static string[] basic_colors = new string[]
        {
            "gray",
            "white",
            "cyan",
            "gray",
            "magenta",
            "yellow",
        };

        private static string[] info_colors = new string[]
        {
            "gray",
            "cyan",
            "white",
            "cyan",
            "gray",
            "yellow",
            "white",
            "cyan"
        };


        private static string[] warning_colors = new string[]
        {
            "gray",
            "yellow",
            "white",
            "yellow",
            "gray",
            "yellow",
            "white",
            "yellow"
        };


        private static string[] error_colors = new string[]
        {
            "gray",
            "red",
            "white",
            "red",
            "gray",
            "yellow",
            "white",
            "red"
        };
    }
}