using System.Text;

namespace nobody.console
{
    public static class Pigments
    {


        /// <summary>
        ///  patch colors
        /// </summary>
        /// <param name="message"></param>
        /// eg: "[gray]Hello[/][white]there[/][cyan]...[/]"
        public static string Patch(params object[] message)
        {
            StringBuilder sb = new StringBuilder();
            var pallette = message.FirstOrDefault()?.ToString()?.ToLower() switch
            {
                "info" => Pigments.info,
                "warning" => Pigments.warning,
                "error" => Pigments.error,
                _ => Pigments.basic
            };

            message[0]= message[0]?.ToString()?.ToUpper()??"";

            for (int i = 0; i < message.Length; i++)
            {
                
                sb.Append($"[{pallette[i % pallette.Length]}]{message[i]}[/] ");
            }

            return sb.ToString();


        }

        /// <summary>
        /// basic color scheme
        /// used for common messages(no special meaning)
        /// </summary>
        public static string[] basic = new string[] {
                "gray",
                "white",
                "cyan",
                "gray",
                "magenta",
                "yellow",
              };

        /// <summary>
        /// info color scheme
        /// used for info messages
        /// </summary>
        public static string[] info = new string[] {
 "gray",
                "cyan",
                "white",
                "cyan",
                "gray",
                "yellow",
                "white",
                "cyan"
              };

        /// <summary>
        /// warning color scheme
        /// used for warning messages
        /// </summary>
        public static string[] warning = new string[] {
                "gray",
                "yellow",
                "white",
                "yellow",
                "gray",
                "yellow",
                "white",
                "yellow"
              };

        /// <summary>
        /// error color scheme
        /// used for error messages
        /// </summary>
        public static string[] error = new string[] {
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
