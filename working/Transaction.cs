using Microsoft.Playwright;
using termo;
using working;
public class Transaction
{
    public SapWebUi inner;
    private Online browser => inner.inner;
    private Dictionary<string, Input>? _fields;

    const string input_selector = "[name='InputField'][class='lsField__input']";
    const string multi_button_selector = "div[title='Multiple selection']";
    const string execute_button_selector = "div[title='Execute (F8)']";

    const string table_selector = "table[role='grid']";


    //class="urMnuRow lsMnuItemHeight"
    //aria-label="Spreadsheet..."
    //role="menuitem"
    const string table_ctx_spreadsheets_selector = "xpath=/html/body/table/tbody/tr/td/div/div/div[1]/div[9]/span/div/div[5]/table/tbody/tr[10]/td[3]/span";

    //class="urPWOuterBorder lsPopupWindow lsPopupWindow--dialog lsPWShadowStd lsScope--s"
    const string popup_window_selector = "div[class='urPWOuterBorder lsPopupWindow lsPopupWindow--dialog lsPWShadowStd lsScope--s']";
    //role="button" title="Continue (Enter)" class="lsButton lsButton--base urInlineMetricTop urNoUserSelect urBtnRadius lsButton--onlyImage lsButton--useintoolbar lsButton--toolbar-image lsButton--active lsButton--focusable lsButton--up lsButton--design-transparent" 
    const string popup_execute_button_selector = "xpath=/html/body/table/tbody/tr/td/div/div/div[1]/div[11]/div/div/div[4]/div/table/tbody/tr/td[3]/div/div/div/div[1]/span[2]/div";
    const string popup_file_name_input = "xpath=/html/body/table/tbody/tr/td/div/div/div[3]/div/div[3]/table/tbody/tr/td/div/table/tbody/tr[1]/td[2]/table/tbody/tr/td/input";
    const string popup_file_name_confirm_button = "xpath=/html/body/table/tbody/tr/td/div/div/div[3]/div/div[4]/div/table/tbody/tr/td[3]/table/tbody/tr/td[1]/div";


    public Transaction(SapWebUi inner)
    {
        this.inner = inner;
    }

    public void Initialize()
    {
        var fhandelsTask = inner.inner.page.QuerySelectorAllAsync(input_selector);
        var multi_buttonsTask = inner.inner.page.QuerySelectorAllAsync(multi_button_selector);

        Task.WhenAll(fhandelsTask, multi_buttonsTask).Wait();

        var fhandels = fhandelsTask.Result.ToList();
        var multi_buttons = multi_buttonsTask.Result.ToList();

        var titleTasks = fhandels.Select(field => field.GetAttributeAsync("title")).ToList();
        Task.WhenAll(titleTasks).Wait();

        var groups = fhandels.Zip(titleTasks.Select(t => t.Result), (field, title) => new { Title = title, Field = field })
                             .GroupBy(item => item.Title);

        _fields = new Dictionary<string, Input>();
        foreach (var group in groups)
        {
            var label = group.Key;
            var handle = group.First().Field;
            var max_handle = group.Last().Field;
            var multi_button = multi_buttons.ElementAtOrDefault(_fields.Count);
            var input = new Input(label, handle, max_handle, multi_button);
            _fields[label] = input;
            input.show();
        }
    }



    public Dictionary<string, Input> fields()
    {
        if (_fields == null)
        {
            Initialize();
        }
        return _fields;
    }


   public Transaction set(string label, string value)
    {
        if (_fields != null && _fields.TryGetValue(label, out var field))
        {
            termo.show.info("SETTING FIELD", label, value);
            field.handle.FillAsync(value).Wait();
        }
        else
        {
            termo.show.not_found("FIELD", label);
        }
        return this;
    }

    public Transaction execute()
    {
        browser.page.QuerySelectorAsync(execute_button_selector).Result.ClickAsync().Wait();
        return this;
    }

    public Transaction export(string path)
    {
        //get the table , right click, export to excel
        var table = browser.page.QuerySelectorAsync(table_selector).Result;
        if (table !=null ){
            table.ClickAsync(options: new ElementHandleClickOptions{Button=MouseButton.Right} ).Wait();
            //click on the context menu where the export to spreadsheet is
            browser.click(table_ctx_spreadsheets_selector);
            //wait for the popup window to appear   
            browser.wait_for(popup_window_selector);
            //click on the execute button
            browser.click(popup_execute_button_selector);
            //wait for file name input to appear
            browser.wait_for(popup_file_name_input);
            //set the file name
            browser.type(popup_file_name_input,path);
            //click on the confirm button
            browser.click(popup_file_name_confirm_button);
            //wait for the file to be downloaded
            wait_for_download(path);
        }

        return this;
    }


    public Transaction wait_for_download(string path)
    {
        browser.page.WaitForDownloadAsync(options: new PageWaitForDownloadOptions { Timeout = 50000,Predicate=download=>download.SuggestedFilename==path}).Wait();
        //get the download
        browser.page.Download += async (sender, e) =>
        {
            await e.SaveAsAsync(path);
            browser.page.CloseAsync().Wait();
        };


        return this;
    }

    public Transaction set_range(string label, string from, string to)
    {
        var field = fields()[label];
        field.handle.FillAsync(from).Wait();
        field?.max_handle?.FillAsync(to).Wait();
        return this;
    }

    public Transaction clear(string label)
    {
        var field = fields()[label];
        field.handle.TypeAsync("").Wait();
        return this;
    }

    public Transaction sets(string label, string[] values)
    {
        // var field = get_field(label);
        // field.multipleEntryButton.ClickAsync().Wait();
        // for (int i = 0; i < values.Length; i++)
        // {
        //     field.multiSelectRows[i].TypeAsync(values[i]).Wait();
        // }
        return this;
    }

    public Transaction wait(TimeSpan timeSpan)
    {
        Task.Delay(timeSpan).Wait();
        return this;
    }

    public Transaction list_tables()
    {
        var tables = browser.page.QuerySelectorAllAsync(table_selector).Result.ToList();
        foreach (var table in tables)
        {
            termo.show.info("TABLE", table.GetAttributeAsync("title").Result);
        }
        return this;
    }

    public Transaction wait_for_navigation()
    {
        browser.page.WaitForNavigationAsync().Wait();
        return this;
    }

    public Transaction wait_until_table_loaded(float? timeout = null)
    {
        browser.page.WaitForSelectorAsync(table_selector, new PageWaitForSelectorOptions { Timeout = (timeout??500000)}).Wait();
        return this;
    }
 
}
