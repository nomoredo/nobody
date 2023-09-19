
namespace notest;


public class Program
{
    public static async Task Main(string[] args)
    {

        // var nb = await nobody.online(visible: true);
        // nb.visit("cbs.almansoori.biz")
        //          .wait_for("input[id='logonuidfield']")
        //          .type("input[id='logonuidfield']", "amohandas")
        //          .type("input[id='logonpassfield']", "D@d5m4gaav009")
        //           .click("input[name='uidPasswordLogon']")
        //          .wait_until_loaded()
        //          .visit("https://cbs.almansoori.biz/sap/bc/gui/sap/its/webgui/?sap-client=800&~TRANSACTION=ME2n#")
        //          .close();


        var sap = await nobody.sap(visible: true);
        sap.login("amohandas", "D@d5m4gaav009");
        var transaction = sap.transaction("me2n");


        transaction
        .clear("Purchasing Document Number")
        .set("Plant","22a1")
        // .set_range("Plant", "2200", "22A2")
        .sets("Purchasing Group", ["162", "163"])
        
        .execute()
        .wait_until_table_loaded()
        .list_tables()
        .export("me2n.xlsx");


        

    }
}


