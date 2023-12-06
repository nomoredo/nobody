// See https://aka.ms/new-console-template for more information


using nobody.console;
using nobody.core;


var nobody = new Nobody(); // find a way to avoid this

var online =nobody.online()
    .visit("https://cbs.almansoori.biz")
    .fill("username".get_string(), "#logonuidfield")
    .fill("password", "#logonpassfield")
    .click("input[type='submit']")
    .wait_for_navigation()
    .show("Logged in");


// navigate to a sap transaction
online.visit("https://cbs.almansoori.biz/sap/bc/gui/sap/its/webgui/?sap-client=800&sap-language=en&~transaction=ME2N")
    .show("Logged in")
    ;



//test console logging
nobody.show("Hello", "there...")
    .show("info", "Hello", "there...")
    .show("warning", "Hello", "there...")
    .show("error", "Hello", "there...")
    .show("this", "is", "a", "test", "of", "the", "emergency", "broadcast", "system")
    .ask_string("name", "What is your name?")
    .ask_int("age")
    .ask_string("password", "What is your password?");
    // .ask_choice("color", new[] { "red", "green", "blue" });
    // .online_async();
//test object logging


nobody.show((ctx)=> {
    ctx["name"] = "John";
    ctx["age"] = 42;
    return "Hello" + ctx["name"] + "you are " + ctx["age"] + "years old";
});

