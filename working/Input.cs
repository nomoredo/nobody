using Microsoft.Playwright;

public class Input
{
    public string label;
    public IElementHandle handle;
    public IElementHandle? max_handle;
    public IElementHandle? multi_button;


    public Input(string label, IElementHandle handle, IElementHandle? max_handle, IElementHandle? multi_button)
    {
        this.label = label;
        this.handle = handle;
        this.max_handle = max_handle;
        this.multi_button = multi_button;
    }

    public void show()
    {
        //input in gray, label in bold yellow, max in purple, multi in pink
        Console.Write($" \x1b[2mINPUT\x1b[0m \x1b[1;33m{label}\x1b[0m");
        if (max_handle != null)
            Console.Write($" \x1b[1mRANGE\x1b[0m ");
        if (multi_button != null)
            Console.Write($" \x1b[1;35mMULTI\x1b[0m ");
        Console.WriteLine();

    }
}