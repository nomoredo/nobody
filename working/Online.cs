using Microsoft.Playwright;
//ignore some compiler warnings
#pragma warning disable CS8981
public class Online
{
    public IBrowser inner;
    public List<IPage> pages => inner.Contexts.First().Pages.ToList();
    public IPage page => pages.Last();

    public Online(IBrowser inner)
    {
        this.inner = inner;

    }

    public Online open(string url)
    {
        page.GotoAsync(url).Wait();
        return this;
    }

    public Online visit(string url)
    {
        if (!url.StartsWith("http"))
            url = "https://" + url;
        execute_sync(page, async (b) => await b.GotoAsync(url));
        execute_sync(page, async (b) => await b.WaitForLoadStateAsync(LoadState.NetworkIdle));
        return this;
    }

    public Online click(string selector)
    {
        execute_sync(page, async (b) => await b.ClickAsync(selector));
        return this;
    }

    public Online type(string selector, string text)
    {
        execute_sync(page, (b) => b.TypeAsync(selector, text));
        return this;
    }

    public void close()
    {
        inner.CloseAsync().Wait();
    }

    public Online wait_for(string selector)
    {
        execute_sync(page, (b) => b.WaitForSelectorAsync(selector));
        return this;
    }

    public Online wait_until_loaded()
    {
        execute_sync(page, (b) => b.WaitForLoadStateAsync(LoadState.NetworkIdle));
        return this;
    }





    public Online wait_for_navigation(string url)
    {
        execute_super(page, (b) => b.GotoAsync(url), (b) => b.WaitForLoadStateAsync(LoadState.NetworkIdle));
        return this;
    }



    public Online new_tab()
    {
        execute_sync(inner, (b) => b.NewPageAsync());
        return this;
    }



    public Online switch_to_tab(int tabIndex)
    {
        if (tabIndex < 0 || tabIndex >= pages.Count)
            throw new IndexOutOfRangeException("Invalid tab index.");
        return this;
    }

    public Online back()
    {
        page.GoBackAsync().Wait();
        return this;
    }

    public Online forward()
    {
        page.GoForwardAsync().Wait();
        return this;
    }

    public Online refresh()
    {
        page.ReloadAsync().Wait();
        return this;
    }

    public Online execute_js(string script)
    {
        page.EvaluateAsync(script).Wait();
        return this;
    }

    public Online screenshot(string path)
    {
        page.ScreenshotAsync(new PageScreenshotOptions { Path = path }).Wait();
        return this;
    }

    public async Task<T> execute<T>(T target, Func<T, Task> action)
    {
        try
        {
            await action(target);
            return target;
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
            return target;
        }
    }

    public T execute_sync<T>(T target, Func<T, Task> action)
    {
        try
        {
            action(target).Wait();
            return target;
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
            return target;
        }
    }

    public T execute_super<T>(T target, params Func<T, Task>[] actions)
    {
        try
        {
            foreach (var action in actions)
                action(target).Wait();
            return target;
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
            return target;
        }
    }


}
