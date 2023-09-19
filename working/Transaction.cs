using termo;

public class Transaction
{
    public SapWebUi inner;

    private Online browser => inner.inner;

    private List<Input>? _fields;
    public Transaction(SapWebUi inner)
    {
        this.inner = inner;
        print_overview();
    }



    const string input_selector = "[name='InputField'][class='lsField__input']";
    const string multi_button_selector = "div[title='Multiple selection']";
    const string execute_button_selector = "div[title='Execute (F8)'";
    public Transaction print_overview()
    {
        show.divider("TRANSACTION OVERVIEW");
        var fhandels = inner.inner.page.QuerySelectorAllAsync(input_selector).Result.ToList();
        var multi_buttons = inner.inner.page.QuerySelectorAllAsync(multi_button_selector).Result.ToList();
        // group fields by their title
        var groups = fhandels.GroupBy((field) => field.GetAttributeAsync("title").Result);
        //combine multi buttons with their fields based on their index
        _fields = new List<Input>();
        for (int i = 0; i < groups.Count(); i++)
        {
            var label = groups.ElementAt(i).Key;
            var handle = groups.ElementAt(i).First();
            var max_handle = groups.ElementAt(i).Last();
            var multi_button = multi_buttons.ElementAtOrDefault(i);
            var input = new Input(label, handle, max_handle, multi_button);
            _fields.Add(input);
            input.show();

        }

        return this;
    }

    public List<Input> fields()
    {
        if (_fields == null)
            print_overview();
        return _fields;
    }


    public Transaction set(string label, string value)
    {
        var field = _fields.Find((field) => field.label == label);
        field.handle.TypeAsync(value).Wait();
        return this;
    }

    public Transaction execute()
    {
        browser.click(execute_button_selector);
        return this;
    }

    public Transaction export(string path)
    {
        // Handle report exporting here...
        return this;
    }

    public Transaction set_range(string label, string from, string to)
    {
        var field = _fields.FindAll((field) => field.label == label);
        for (int i = 0; i < field.Count; i++)
        {
            field[i].handle.TypeAsync(from).Wait();
            field[i].max_handle.TypeAsync(to).Wait();
        }

        return this;
    }

    public Transaction clear(string label)
    {
        var field = fields().FindAll((field) => field.label == label);
        for (int i = 0; i < field.Count; i++)
        {
            field[i].handle.TypeAsync("").Wait();
        }

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


}
