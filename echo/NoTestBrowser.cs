using Microsoft.Playwright;
using PlaywrightExtraSharp;
using PlaywrightExtraSharp.Models;
using PlaywrightExtraSharp.Plugins.ExtraStealth;
using System.Threading.Tasks;

namespace nobody.echo
{
    /// <summary>
    /// Basic Test Runner
    /// </summary>
    /// Provides access to page and browser.
    /// Uses headful browser, Edge installed on machine,
    /// and persists context in between tests.
    public class NoTestBrowser
    {
        internal PlaywrightExtraSharp.PlaywrightExtra Play { get; private set; }
        internal IBrowser Browser { get; private set; }
        // internal IBrowserContext BrowserCtx { get; private set; }
        internal IPage Page { get; private set; }



        protected NoTestBrowser()
        {
            Play = new PlaywrightExtra(BrowserTypeEnum.Chromium);
            Play.Install();
            Play.Use(new StealthExtraPlugin());
            Browser = Play.LaunchPersistentAsync(new BrowserTypeLaunchPersistentContextOptions
            {
                Headless = false
            }).Result;
            Page = Browser.NewPageAsync().Result;

        }



        public virtual async Task TeardownAsync()
        {
            await Page.CloseAsync();
            await Browser.CloseAsync();
        }
    }
}