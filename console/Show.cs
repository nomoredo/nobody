using nobody.console;
using nobody.core;
using Spectre.Console;
using Xunit;

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


    }
}


//tests
public class ShowTests
{
    [Fact]
    public void ShowTest()
    {
        var nobody = new Nobody();
        nobody.show("Hello","there...");
        nobody.show("info","Hello","there...");
        nobody.show("warning","Hello","there...");
        nobody.show("error","Hello","there...");
        nobody.show("this","is","a","test","of","the","emergency","broadcast","system");
        nobody.show(new TestClass{Name="John",Age=42});
    }

    public class TestClass
    {
        public string Name { get; set; }
        public int Age { get; set; }    

        public override string ToString()
        {
            return $"Name: {Name}, Age: {Age}";
        }
    }
}