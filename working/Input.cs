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

 
}