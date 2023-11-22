using nobody.core;
using Xunit;

//tests
namespace nobody.console;

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