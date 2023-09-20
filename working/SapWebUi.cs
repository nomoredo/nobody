using nothing;
using Spectre.Console;
using working;
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
            .click("input[name='uidPasswordLogon']");
        // now chck if we are logged in
        if (inner.has("span",has_text:"User authentication failed").Result)
        {
            //delete password from env
            Nowhere.Delete<Credentials>(username);
            termo.show.error("LOGIN FAILED");
            login(username);
        }
        else {
            termo.show.success("LOGIN SUCCESSFUL");
        }
  


        return this;
    }



    private String request_password(string username)
    {
        //check if password is in env
        var pss = Nowhere.Get<Credentials>(username).Result;
        if (pss != null)
        {
            return pss.Password;
        }
        else
        {
            var password = termo.ask.password(username);
            if (password == null)
            {
                throw new Exception("PASSWORD CANNOT BE NULL");
            }
            Nowhere.Store(username, new Credentials { Password = password, Username = username });
            return password;
        }


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


