using Microsoft.Playwright;
using nobody.core;

namespace nobody.echo;

public class SimpleTest : NoTestBrowser
{

    [Runnable]
    public  async Task RunAsync()
    {
        await Page.GotoAsync("https://cbs.almansoori.biz/saml2/idp/sso?SAMLRequest=fZFLa8MwEIT%2FitHd1sMhCSI2hKQFQ1tCU3roTZY2RCBLrlbu69fXdqCkh%2FY67Mx8w25Qda6X2yGd%2FSO8DoApa%2FYVOTImxGLNTK7FkuUcAHIlWpMLU67YSplVWyqSPUNEG3xFRMFI1iAO0HhMyqdRYqLMOc9F%2BcSZ5Eu5WL%2BQbD82WK%2FS7Dqn1KOkVLdYKNcpjyFEW7T2i05cglrTU8RAstsQNcyUFTkphzC1HRSifYMf5aNzHuW8qCJD9DIotCi96gBl0vK4vb%2BTI6nsY0hBB0fqzXQtZ%2FB45f%2FfPtZCnBaQ%2BmZ32NCrjEtgLx9GU7M%2FBGf15wTfqfR3Ji%2F4rFiTn%2BZTOXjsQduTBUOyrXPhfRdBpXFqigMQWl9Kfz%2Bu%2FgY%3D&RelayState=oucqqssuyqdocswqoreeeoasbdosdtxqxadxbta&SigAlg=http%3A%2F%2Fwww.w3.org%2F2000%2F09%2Fxmldsig%23rsa-sha1&Signature=hcKxmiC5LhLZpaigy3%2FK0DoQ8D1e56fWARyuGSsFNSxvc6SS%2BNn9kDG%2BDByUfTDno2ONCGL1ivc8SRWhON1XSlntsQ%2FnvmfJ8sJLbSy1ZP7is3mJj6tzk3EnDbc93UrIkQY1LqMGBdhFUWl4Ee8H0Gu0%2FA%2BogEZaxlEDS5FwCA8%3D");

        await Page.GetByRole(AriaRole.Textbox, new() { Name = "User *" }).ClickAsync();

        await Page.GetByRole(AriaRole.Textbox, new() { Name = "User *" }).FillAsync("amohandas");

        await Page.GetByRole(AriaRole.Textbox, new() { Name = "User *" }).PressAsync("Tab");

        await Page.GetByLabel("Password *").FillAsync("D@d5m4gaav009");

        await Page.GetByRole(AriaRole.Button, new() { Name = "Log On" }).ClickAsync();
    
        await Task.Delay(2000);

        await Page.GotoAsync("https://cbs.almansoori.biz/sap/bc/gui/sap/its/webgui/?sap-client=800&sap-language=en#");

        await Page.GetByRole(AriaRole.Combobox, new() { Name = "Enter Transaction Code" }).ClickAsync();

        await Page.GetByRole(AriaRole.Combobox, new() { Name = "Enter Transaction Code" }).FillAsync("me2n");

        await Page.GetByRole(AriaRole.Combobox, new() { Name = "Enter Transaction Code" }).PressAsync("Enter");

        await Page.Locator("#u422325").GetByRole(AriaRole.Button, new() { Name = "Multiple selection" }).ClickAsync();

        await Page.GetByLabel("Multiple Selection for Plant").GetByRole(AriaRole.Textbox).ClickAsync();

        await Page.GetByLabel("Multiple Selection for Plant").GetByRole(AriaRole.Textbox).PressAsync("Control+a");

        await Page.GetByLabel("Multiple Selection for Plant").GetByRole(AriaRole.Textbox).PressAsync("ArrowRight");

        await Page.GetByLabel("Multiple Selection for Plant").GetByRole(AriaRole.Textbox).PressAsync("ArrowRight");

        await Page.GetByLabel("Multiple Selection for Plant").GetByRole(AriaRole.Textbox).FillAsync("2200");

        await Page.Locator("#tbl927-mrss-cont-none-Row-1 span").Nth(2).ClickAsync();

        await Page.Locator("#tbl927-mrss-cont-none-Row-1").GetByRole(AriaRole.Textbox).ClickAsync();

        await Page.Locator("#tbl927-mrss-cont-none-Row-1").GetByRole(AriaRole.Textbox).FillAsync("22a1");

        await Page.Locator("#tbl927-mrss-cont-none-Row-2 span").Nth(2).ClickAsync();

        await Page.Locator("#tbl927-mrss-cont-none-Row-2").GetByRole(AriaRole.Textbox).FillAsync("22a2");

        await Page.Locator("#tbl927-mrss-cont-none-Row-2").GetByRole(AriaRole.Textbox).PressAsync("Enter");

        await Page.GetByRole(AriaRole.Button, new() { Name = "Copy (F8)" }).ClickAsync();

        await Page.GetByRole(AriaRole.Button, new() { Name = "Execute Emphasized" }).ClickAsync();

    }
}