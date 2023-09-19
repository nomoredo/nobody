using Microsoft.Playwright;
using Microsoft.VisualBasic;
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
        termo.show.divider("TRANSACTION OVERVIEW");
        var fhandelsTask = inner.inner.page.QuerySelectorAllAsync(input_selector);
        var multi_buttonsTask = inner.inner.page.QuerySelectorAllAsync(multi_button_selector);

        Task.WhenAll(fhandelsTask, multi_buttonsTask).Wait();

        var fhandels = fhandelsTask.Result.ToList();
        var multi_buttons = multi_buttonsTask.Result.ToList();

        var titleTasks = fhandels.Select(field => field.GetAttributeAsync("title")).ToList();
        Task.WhenAll(titleTasks).Wait();
        // we will combine the fields with the same title into a single input.
        // only if there are at least 2 fields with the same title we will add a multi button to the input
        var groups = titleTasks.Select((title, index) => new { Title = title.Result, Field = fhandels[index] })
            .GroupBy(field => field.Title)
            .Where(group => group.Count() > 1)
            .ToList();

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
        termo.show.divider();
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
        browser.click(execute_button_selector);
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


    public Transaction wait_for_download(string path, int timeout = 5)
    {
        browser.page.WaitForDownloadAsync(options: new PageWaitForDownloadOptions { Timeout = timeout*60*1000,Predicate=download=>download.SuggestedFilename==path}).Wait();
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


    //click on multi button
    //wait for the popup window to appear with role="dialog" and ct="PW"
    // click on role="gridcell" lsmatrixcolindex="1" and lsmatrixrowindex=index to activate the input inside popup window
    // enter text in input with  name="InputField" and class="lsField__input"
    // click on next row and scroll down one row

    public Transaction sets(string label, params string[] values)
    {
       if (_fields != null && _fields.TryGetValue(label, out var field))
        {
            
            field.multi_button.ClickAsync().Wait();
            browser.page.WaitForSelectorAsync("div[ct='PW'][role='dialog']", new PageWaitForSelectorOptions { Timeout = 5 * 60 * 1000 }).Wait();
            var popup_window = browser.page.QuerySelectorAsync("div[ct='PW'][role='dialog']").Result;
            var rows = popup_window.QuerySelectorAllAsync("td[role='gridcell'][lsmatrixcolindex='1']").Result.ToList();

            for (int i = 0; i < values.Length; i++)
            {
                var row = rows.ElementAtOrDefault(i);
                if (row != null)
                {
                    row.ClickAsync().Wait();
                    var input = row.QuerySelectorAsync("input[name='InputField'][class='lsField__input']").Result;
                    input.FillAsync(values[i]).Wait();
                    browser.page.Keyboard.PressAsync("ArrowDown").Wait();
                }
            }

            popup_window.QuerySelectorAsync("div[title='Copy (F8)']").Result.ClickAsync().Wait();
        }
        else
        {
            termo.show.not_found("FIELD", label);
        }
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

    public Transaction wait_for_table(int timeout = 5)
    {
        browser.page.WaitForSelectorAsync(table_selector, new PageWaitForSelectorOptions { Timeout = (timeout*60*1000)}).Wait();
        return this;
    }



    //sap table other format eg. mb51
    const string table_selector2 = "table[id='userarealist0'][role='region']";
    const string table_ctx_spreadsheets_selector2 = "xpath=/html/body/table/tbody/tr/td/div/div/div[1]/div[1]/span[2]/div/div[5]/table/tbody/tr[27]";
    const string popup_window_confirm_button = "xpath=/html/body/table/tbody/tr/td/div/div/div[1]/div[11]/div/div/div[4]/div/table/tbody/tr/td[3]/div/div/div/div[1]/span[2]/div";
    const string popup_window_file_name_input = "xpath=/html/body/table/tbody/tr/td/div/div/div[3]/div/div[3]/table/tbody/tr/td/div/table/tbody/tr[1]/td[2]/table/tbody/tr/td/input";

    const string popup_window_file_name_confirm_button = "xpath=/html/body/table/tbody/tr/td/div/div/div[3]/div/div[4]/div/table/tbody/tr/td[3]/table/tbody/tr/td[1]/div";

    public void export_table(string path, int timeout = 5)
    {
        browser.wait_for(table_selector2, timeout);
        browser.right_click(table_selector2);
        browser.click(table_ctx_spreadsheets_selector2);
        browser.click(popup_window_confirm_button);
        browser.type(popup_window_file_name_input, path);
        browser.click(popup_window_file_name_confirm_button);
        Task.Delay(100000).Wait();
    }
}
