using Microsoft.Playwright;
using nobody.core;

namespace nobody.online;

public interface AnyPluginOnline
{
    Online visit(string url);
    Online fill(string value, string selector);
    Online fill(Func<Ctx, string> value, string selector);
    Online click(string selector);
    Online wait(Func<IPage, Task> condition);
    Online wait(int milliseconds);
    Online wait_for_navigation();
    Online wait_for_navigation(string url);
}

public class Online : Anybody, AnyPluginOnline
{
    private IBrowser? _browser;
    private IPage? _activePage;


    public Online(IBrowser browser)
    {
        _browser = browser;
    }


    public Online visit(string url)
    {
        Task.Run(async () => { await visit_async(url); }).Wait();

        return this;
    }


    public async Task<Online> visit_async(string url)
    {
        if (_activePage == null)
        {
            _activePage = await _browser!.NewPageAsync();
        }
        await _activePage.GotoAsync(url);
        log.Information("VISITED {url}", url);
        return this;
    }



    public Online fill(string value, string selector)
    {
        Task.Run(async () => { await fill_async(value, selector); }).Wait();

        return this;
    }



    public Online fill(Func<Ctx, string> value, string selector)
    {
        var val = value.Invoke(ctx);
        fill(val, selector);
        return this;
    }


    public async Task<Online> fill_async(string value, string selector)
    {
        await _activePage!.FillAsync(selector, value);
        log.Information("FILLED {value} INTO {selector}", value, selector);
        return this;
    }

    public Online click(string selector)
    {
        Task.Run(async () => { await click_async(selector); }).Wait();
        return this;
    }

    public async Task<Online> click_async(string selector)
    {
        await _activePage!.ClickAsync(selector);
        // log.Information("CLICKED {selector}", selector);
        return this;
    }


    public Online wait(Func<IPage, Task> condition)
    {
        Task.Run(async () => { await wait_async(condition); }).Wait();
        return this;
    }

    public async Task<Online> wait_async(Func<IPage, Task> condition)
    {
        await condition(_activePage!);
        log.Information("WAITED FOR CONDITION");
        return this;
    }

    public Online wait(int milliseconds)
    {
        Task.Run(async () => { await wait_async(milliseconds); }).Wait();
        return this;
    }

    public async Task<Online> wait_async(int milliseconds)
    {
        await Task.Delay(milliseconds);
        log.Information("WAITED FOR {milliseconds} MILLISECONDS", milliseconds);
        return this;
    }

    public Online wait_for_navigation()
    {
        Task.Run(async () => { await wait_for_navigation_async(); }).Wait();
        return this;
    }

    public async Task<Online> wait_for_navigation_async()
    {
        await _activePage!.WaitForNavigationAsync();
        log.Information("WAITED UNTIL {status}", "NAVIGATION COMPLETE");
        return this;
    }


    public Online wait_for_navigation(string url)
    {
        Task.Run(async () => { await wait_for_navigation_async(url); }).Wait();
        return this;
    }

    public async Task<Online> wait_for_navigation_async(string url)
    {
        await _activePage!.WaitForNavigationAsync(new() { UrlString = url });
        log.Information("WAITED UNTIL {status}", "NAVIGATION COMPLETE");
        return this;
    }


    public Online pick_from_dropdown(string selector, string value)
    {
        Task.Run(async () => { await pick_from_dropdown_async(selector, value); }).Wait();
        return this;
    }

    public async Task<Online> pick_from_dropdown_async(string selector, string value)
    {
        await _activePage!.SelectOptionAsync(selector, value);
        log.Information("SELECTED {value} FROM {selector}", value, selector);
        return this;
    }

    /// run javascript
    public Online run_js(string script)
    {
        Task.Run(async () => { await run_js_async(script); }).Wait();
        return this;
    }

    public async Task<Online> run_js_async(string script)
    {
        await _activePage!.EvalOnSelectorAsync(script, "body");
        log.Information("RAN JS {script}", script);
        return this;
    }

    /// run javascript
    public Online run_js(string script, string selector)
    {
        Task.Run(async () => { await run_js_async(script, selector); }).Wait();
        return this;
    }

    public async Task<Online> run_js_async(string script, string selector)
    {
        await _activePage!.EvalOnSelectorAsync(script, selector);
        log.Information("RAN JS {script} ON {selector}", script, selector);
        return this;
    }

    /// run javascript
    public Online run_js(string script, string selector, string value)
    {
        Task.Run(async () => { await run_js_async(script, selector, value); }).Wait();
        return this;
    }

    public async Task<Online> run_js_async(string script, string selector, string value)
    {
        await _activePage!.EvalOnSelectorAsync(script, selector, value);
        log.Information("RAN JS {script} ON {selector} WITH {value}", script, selector, value);
        return this;
    }

    /// evaluate javascript
    public Online eval_js(string script)
    {
        Task.Run(async () => { await eval_js_async(script); }).Wait();
        return this;
    }

    public async Task<Online> eval_js_async(string script)
    {
        await _activePage!.EvaluateAsync(script);
        log.Information("EVALUATED JS {script}", script);
        return this;
    }

    /// evaluate javascript
    public Online eval_js(string script, string selector)
    {
        Task.Run(async () => { await eval_js_async(script, selector); }).Wait();
        return this;
    }

    public async Task<Online> eval_js_async(string script, string selector)
    {
        await _activePage!.EvalOnSelectorAsync(script, selector);
        log.Information("EVALUATED JS {script} ON {selector}", script, selector);
        return this;
    }

    /// evaluate javascript
    public Online eval_js(string script, string selector, string value)
    {
        Task.Run(async () => { await eval_js_async(script, selector, value); }).Wait();
        return this;
    }

    public async Task<Online> eval_js_async(string script, string selector, string value)
    {
        await _activePage!.EvalOnSelectorAsync(script, selector, value);
        log.Information("EVALUATED JS {script} ON {selector} WITH {value}", script, selector, value);
        return this;
    }

    /// focus on a selector
    public Online focus(string selector)
    {
        Task.Run(async () => { await focus_async(selector); }).Wait();
        return this;
    }

    public async Task<Online> focus_async(string selector)
    {
        await _activePage!.FocusAsync(selector);
        log.Information("FOCUSED ON {selector}", selector);
        return this;
    }

    /// hover on a selector
    public Online hover(string selector)
    {
        Task.Run(async () => { await hover_async(selector); }).Wait();
        return this;
    }

    public async Task<Online> hover_async(string selector)
    {
        await _activePage!.HoverAsync(selector);
        log.Information("HOVERED ON {selector}", selector);
        return this;
    }


    public Online wait_for_function(string function, object[] args = null, int timeout = 30000)
    {
        Task.Run(async () => { await _activePage!.WaitForFunctionAsync(function, args, new() { Timeout = timeout }); })
            .Wait();
        return this;
    }


    public Online smart_wait()
    {
        Task.Run(async () => { await _activePage!.WaitForLoadStateAsync(LoadState.NetworkIdle); }).Wait();
        return this;
    }


    public async Task<string> get_attribute(string selector, string attributeName)
    {
        return await _activePage!.GetAttributeAsync(selector, attributeName);
    }


    public async Task<T> execute_script<T>(string script, object[] args = null)
    {
        return await _activePage!.EvaluateAsync<T>(script, args);
    }


    public async Task<string> get_inner_text(string selector)
    {
        return await _activePage!.InnerTextAsync(selector);
    }
}