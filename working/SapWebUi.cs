public class SapWebUi
{
    public Online inner;
    public SapWebUi(Online inner)
    {
        this.inner = inner;
    }

    public SapWebUi login(string username, string password)
    {
        inner.visit("cbs.almansoori.biz")
                 .wait_for("input[id='logonuidfield']")
                 .type("input[id='logonuidfield']", username)
                 .type("input[id='logonpassfield']", password)
                  .click("input[name='uidPasswordLogon']")
                 .wait_until_loaded();
        return this;
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
