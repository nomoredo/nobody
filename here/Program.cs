// See https://aka.ms/new-console-template for more information

using nobody.core;
using nobody.console;

var nobody = new Nobody(); // find a way to avoid this


//test console logging
nobody.show("Hello","there...")
.show("info","Hello","there...")
.show("warning","Hello","there...")
.show("error","Hello","there...")
.show("this","is","a","test","of","the","emergency","broadcast","system")
.ask("name","What is your name?")
.ask_number("age")
.ask_secret("password")
.ask_choice("color",new[]{"red","green","blue"});
//test object logging
nobody.show(new TestClass{Name="John",Age=42});

nobody.show((ctx)=> {
    ctx["name"] = "John";
    ctx["age"] = 42;
    return "Hello" + ctx["name"] + "you are " + ctx["age"] + "years old";
});

public class TestClass
{
    public string Name { get; set; }
    public int Age { get; set; }    

    public override string ToString()
    {
        return $"Name: {Name}, Age: {Age}";
    }
}

