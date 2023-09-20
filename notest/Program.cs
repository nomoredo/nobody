
namespace notest;


public class Program
{
    public static async Task Main(string[] args)
    {
        mb52();
    }



    public static void me2n()
    {
        nobody.open_sap(visible: true)
        // .watch_network()
        .login("amohandas")
        .transaction("me2n")
        .clear("Purchasing Document Number")
        .sets("Plant", "2200", "22A1", "22A2")
        .execute()
        .wait_for_table()
        .listen_downloads()
        .export("me2n.xlsx");
    }

    public static void mb52()
    {
        nobody.open_sap(visible: true)
        .login("amohandas")
        .transaction("mb52")
        .set_range("Plant", "2200", "22A2")
        .execute()
         .listen_downloads()
        .export_table("mb52.xlsx");
    }

    public static void ar01()
    {
        nobody.open_sap(visible: true)
        .login("amohandas")
        .transaction("ar01")
        .set("Plant", "22a1")
        .execute()
        .export_table("ar01.xlsx", timeout: 5);
    }
}


