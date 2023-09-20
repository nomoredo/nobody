using nothing;
using Spectre.Console;
namespace termo
{
    public class ask
    {
        public static string? password(string username)
        {
            //use spectere console to ask for password in a pretty way
            var password = AnsiConsole.Prompt(
                new TextPrompt<string>($"PLEASE ENTER PASSWORD FOR {username}")
                    .Secret()
                    .PromptStyle("red")
                    .Validate(password =>
                    {
                        if (password.Length < 5)
                        {
                            return ValidationResult.Error("PASSWORD MUST BE AT LEAST 5 CHARACTERS");
                        }
                        return ValidationResult.Success();
                    }));
            return password;
        }
    }
}

public class SapWebUi
{
    public Online inner;
    public SapWebUi(Online inner)
    {
        this.inner = inner;
    }

    public SapWebUi login(string username)
    {
        var password = request_password(username);


        inner.visit("cbs.almansoori.biz")
            .wait_for("input[id='logonuidfield']")
            .type("input[id='logonuidfield']", username)
            .type("input[id='logonpassfield']", password, true)
            .click("input[name='uidPasswordLogon']")
            .when(
                new check(
                    x => x.has("span", has_text: "User authentication failed"),
                    x =>
                    {
                        termo.show.error("LOGIN FAILED");
                        login(username);
                    }
                ),
                new check(
                    x => x.wait_and_return(1000, true),
                    x =>termo.show.success("LOGGED IN SUCCESSFULLY")
                )
                );


        return this;
    }



    private String request_password(string username)
    {
        var password = termo.ask.password(username);
        if (password == null)
        {
            throw new Exception("PASSWORD CANNOT BE NULL");
        }
        return password;

    }

    public Transaction transaction(string code)
    {
        inner.visit("https://cbs.almansoori.biz/sap/bc/gui/sap/its/webgui/?sap-client=800&~TRANSACTION=" + code + "#");
        return new Transaction(this);

    }



    public void close()
    {
        inner.close();
    }

}


