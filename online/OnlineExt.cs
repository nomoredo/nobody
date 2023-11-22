using Microsoft.Playwright;
using nobody.core;

namespace nobody.online;
/*
//support the below
 nobody.online()
    .visit("https://cbs.almansoori.biz")
    .fill((ctx)=>ctx.get("username"), "#logonuidfield")
    .fill(get("password"), "#logonpassfield")
    .click("input[type='submit']")
    .wait_for_navigation();

 */

public static class OnlineExt
{

    public static Online online(this Nobody nobody, string url = "https://www.google.com",Action<BrowserTypeLaunchOptions>? options=null)
    {
        var playwright = Playwright.CreateAsync().Result;
        var browserType = playwright.Chromium;
        var launchOptions = new BrowserTypeLaunchOptions
        {
            Headless = false,
            ExecutablePath = @"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" // Path to Edge executable
        };
        options?.Invoke(launchOptions);
        var browser = browserType.LaunchAsync(launchOptions).Result;
        return new Online(browser);
    }

    public static async Task<Online> online_async(this nobody.core.Nobody nobody, string url = "https://www.google.com",Action<BrowserTypeLaunchOptions>? options=null)
    {
        var playwright = await Playwright.CreateAsync();
        var browserType = playwright.Chromium;
        var launchOptions = new BrowserTypeLaunchOptions
        {
            Headless = false,
            ExecutablePath = @"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" // Path to Edge executable
        };
        options?.Invoke(launchOptions);
        var browser = await browserType.LaunchAsync(launchOptions);
        return new Online(browser);
    }



}