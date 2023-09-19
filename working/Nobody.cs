using Microsoft.Playwright;
using System.Linq;
using System.Threading.Tasks;





public static class nobody
{
    public static async Task<Online> online(bool visible)
    {
        var playwright = await Playwright.CreateAsync();
        var browser = await playwright.Chromium.LaunchAsync(new BrowserTypeLaunchOptions { Headless = !visible, Timeout = 10000 });
        var page = await browser.NewPageAsync();
        return new Online(browser);
    }

    /*
           var sap = await nobody.sap(visible: true);
        sap.login("amohandas", "D@d5m4gaav009")
        .transaction("me2n")
        .set("plant", "8000")
        .sets("vendor", ["100000", "100001"])
        .execute()
        .export("me2n.xlsx")
        .close();
    */
    public static async Task<SapWebUi> sap(bool visible)
    {
        var browser = await online(visible);
        return new SapWebUi(browser);
    }
}

