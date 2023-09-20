using Microsoft.Playwright;
using System.Linq;
using System.Threading.Tasks;
using office;
using Microsoft.Graph;


public static class nobody
{
    private static Office _office;
    public static async Task<Online> online(bool visible)
    {
        termo.show.start("OPENING", "BROWSER");
        var playwright = await Playwright.CreateAsync();
        var browser = await playwright.Chromium.LaunchAsync(new BrowserTypeLaunchOptions { Headless = !visible, Timeout = 10000 });
        var page = await browser.NewPageAsync();
        return new Online(browser);
    }

    public static SapWebUi open_sap(bool visible)
    {
       return  sap(visible).Result;
    }



    public static async Task get_office()
    {
        if (_office == null)
        {
            _office = new Office();
        }
         await _office.login();
         await _office.about_me();
    }

    public static async Task<SapWebUi> sap(bool visible)
    {
        var browser = await online(visible);
        return new SapWebUi(browser);
    }
}

