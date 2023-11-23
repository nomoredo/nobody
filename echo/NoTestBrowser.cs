using Microsoft.Playwright;
using PlaywrightExtraSharp;
using PlaywrightExtraSharp.Models;
using PlaywrightExtraSharp.Plugins.ExtraStealth;

/// <summary>
/// Basic Test Runner
/// </summary>
/// provides access to page and browser
/// uses headful browser, edge installed on machine
/// and persists context in between tests
public class NoTestBrowser
{
    internal PlaywrightExtraSharp.PlaywrightExtra playwright;
    internal IBrowser browser;
    internal IBrowserContext context;
    internal IPage page;

    public NoTestBrowser()
    {
        Scaffold();
        Run();
        Teardown();
    }

    public virtual void Run()
    {
        //run tests
    }

    public virtual void Scaffold()
    {
        playwright = new PlaywrightExtra(BrowserTypeEnum.Chromium);
        //ensure playwright is installed
        // Install browser
        playwright.Install();
        // use stealth plugin
        playwright.Use(new StealthExtraPlugin());


        browser = playwright.LaunchPersistentAsync(new BrowserTypeLaunchPersistentContextOptions()
        {
            Headless = false,
        }).Result;
        context = browser.NewContextAsync(new BrowserNewContextOptions
        {
            AcceptDownloads = true,
            BypassCSP = true,
            JavaScriptEnabled = true,
            RecordVideoDir = "videos",
        }).Result;
        page = context.NewPageAsync().Result;
    }


    public virtual void Teardown()
    {
        page.CloseAsync().Wait();
        context.CloseAsync().Wait();
        browser.CloseAsync().Wait();
    }
}