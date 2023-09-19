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

    public static SapWebUi open_sap(bool visible)
    {
       return  sap(visible).Result;
    }


    public static async Task<SapWebUi> sap(bool visible)
    {
        var browser = await online(visible);
        return new SapWebUi(browser);
    }
}

