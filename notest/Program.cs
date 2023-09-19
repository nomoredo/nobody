
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


        
    me2n();
        

    }



    public static void me2n(){
        nobody.open_sap(visible: true)
        .login("amohandas", "D@d5m4gaav009")
        .transaction("me2n")
        .clear("Purchasing Document Number")
        .sets("Plant",  "2200", "22A1","22A2")
        .execute()
        .wait_for_table()
        .export("me2n.xlsx");
    }

    public static void mb52(){
        nobody.open_sap(visible: true)
        .login("amohandas", "D@d5m4gaav009")
        .transaction("mb52")
        .set_range("Plant", "2200", "22A2")
        .execute()
        .export_table("mb52.xlsx");
    }

    public static void ar01(){
        nobody.open_sap(visible: true)
        .login("amohandas", "D@d5m4gaav009")
        .transaction("ar01")
        .set("Plant","22a1")
        .execute()
        .export_table("ar01.xlsx", timeout:5);
    }
}


