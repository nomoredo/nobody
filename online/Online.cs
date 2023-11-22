using Microsoft.Playwright;
using nobody.core;

namespace nobody.online;

public interface AnyPluginOnline
{
    Online visit(string url);
    Online fill(string value, string selector);
    Online fill(Func<Ctx,string> value, string selector);
    Online click(string selector);
    Online wait(Func<IPage, Task> condition);
    Online wait(int milliseconds);
    Online wait_for_navigation();
    Online wait_for_navigation(string url);
}

public class Online :Anybody, AnyPluginOnline
{
    private IBrowser? _browser;
    private IPage? _active_page;
    

    public Online(IBrowser browser)
    {

        _browser = browser;

    }


    public Online visit(string url)
    {
        Task.Run(async () =>
        {
            await visit_async(url);
        }).Wait();

        return this;
    }

    public async Task<Online> visit_async(string url)
    {
        _active_page = await _browser!.NewPageAsync();
        await _active_page.GotoAsync(url);

        // log.Information("VISITED {url}",url);
        return this;
    }

    public Online fill(string value, string selector)
    {
        Task.Run(async () =>
        {
            await fill_async(value, selector);
        }).Wait();

        return this;
    }

    public Online fill(Func<Ctx,string> value, string selector)
    {
        var val =value.Invoke(ctx);
        fill(val,selector);
        return this;
    }


    public async Task<Online> fill_async(string value, string selector)
    {
        await _active_page!.FillAsync(selector, value);
        log.Information("FILLED {value} INTO {selector}",value,selector);
        return this;
    }

    public Online click(string selector)
    {
        Task.Run(async () =>
        {
            await click_async(selector);
        }).Wait();
        return this;
    }

    public async Task<Online> click_async(string selector)
    {
        await _active_page!.ClickAsync(selector);
        log.Information("CLICKED {selector}",selector);
        return this;
    }

    public Online wait(Func<IPage, Task> condition)
    {
        Task.Run(async () =>
        {
            await wait_async(condition);
        }).Wait();
        return this;
    }

    public async Task<Online> wait_async(Func<IPage, Task> condition)
    {
        await condition(_active_page!);
        log.Information("WAITED FOR CONDITION");
        return this;
    }

    public Online wait(int milliseconds)
    {
        Task.Run(async () =>
        {
            await wait_async(milliseconds);
        }).Wait();
        return this;
    }

    public async Task<Online> wait_async(int milliseconds)
    {
        await Task.Delay(milliseconds);
        log.Information("WAITED FOR {milliseconds} MILLISECONDS",milliseconds);
        return this;
    }

    public Online wait_for_navigation()
    {
        Task.Run(async () =>
        {
            await wait_for_navigation_async();
        }).Wait();
        return this;
    }

    public async Task<Online> wait_for_navigation_async()
    {
        await _active_page!.WaitForNavigationAsync();
        log.Information("WAITED UNTIL {status}","NAVIGATION COMPLETE");
        return this;
    }

    public Online wait_for_navigation(string url)
    {
        Task.Run(async () =>
        {
            await wait_for_navigation_async(url);
        }).Wait();
        return this;
    }

    public async Task<Online> wait_for_navigation_async(string url)
    {
        await _active_page!.WaitForNavigationAsync(new() {UrlString = url});
        log.Information("WAITED UNTIL {status}","NAVIGATION COMPLETE");
        return this;
    }



}