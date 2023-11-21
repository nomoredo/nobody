// See https://aka.ms/new-console-template for more information

using nobody.core;
using nobody.console;

var nobody = new Nobody(); // find a way to avoid this


//test console logging
nobody.show("Hello","there...");
nobody.show("info","Hello","there...");
nobody.show("warning","Hello","there...");
nobody.show("error","Hello","there...");
nobody.show("this","is","a","test","of","the","emergency","broadcast","system");
//test object logging
nobody.show(new TestClass{Name="John",Age=42});

public class TestClass
{
    public string Name { get; set; }
    public int Age { get; set; }    

    public override string ToString()
    {
        return $"Name: {Name}, Age: {Age}";
    }
}

