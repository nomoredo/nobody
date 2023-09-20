using Microsoft.Identity.Client;

namespace office;

///# office
/// this library is used to interact with office 365 elements using
/// microsoft graph api.
/// we will be using Delegated permissions for this app to work
/// with emails, calendars, contacts, sharepoint, onedrive, etc.
/// example usage :
/// var office = new Office();
/// await office.login(); //uses oauth2 to login (displays a browser)
/// var me = await office.me(); //gets the current user
/// var emails = await office.find_emails("subject:hello"); //searches for emails
/// client secret : koO8Q~-YsRwshXcGh~qsTUM0sZGO_KJFUbl0tcZE
/// secret id : f81fda36-53e1-4bc5-8b24-ffc4b95154ae

public class Office
{
    string graphAPIEndpoint = "https://graph.microsoft.com/v1.0/me";

    //Set the scope for API call to user.read
    string[] scopes = new string[] { "user.read" };

    IPublicClientApplication app;

    string? token;

    public async Task<Office> login()
    {
        AuthenticationResult authResult = null;
         app = PublicClientApplicationBuilder.Create("f81fda36-53e1-4bc5-8b24-ffc4b95154ae")
            .WithRedirectUri("http://localhost")
            .Build();

        IAccount firstAccount;

        var accounts = await app.GetAccountsAsync();
        firstAccount = accounts.FirstOrDefault();
        try
        {
            authResult = await app.AcquireTokenSilent(scopes, firstAccount)
                .ExecuteAsync();
        }
        catch (MsalUiRequiredException ex)
        {
            // A MsalUiRequiredException happened on AcquireTokenSilent. 
            // This indicates you need to call AcquireTokenInteractive to acquire a token
            System.Diagnostics.Debug.WriteLine($"MsalUiRequiredException: {ex.Message}");

            try
            {
                authResult = await app.AcquireTokenInteractive(scopes)
                    .WithAccount(firstAccount)// optional, used to center the browser on the window
                    .WithPrompt(Prompt.SelectAccount)
                    .ExecuteAsync();
            }
            catch (MsalException msalex)
            {
                termo.show.error($"Error Acquiring Token:{System.Environment.NewLine}{msalex}");
            }
        }
        catch (Exception ex)
        {
            termo.show.error($"Error Acquiring Token Silently:{System.Environment.NewLine}{ex}");
            return this;
        }

        if (authResult != null)
        {
            var res= await GetHttpContentWithToken(graphAPIEndpoint);
            termo.show.info(res);
        }


        return this;
    }


    /// <summary>
    /// Perform an HTTP GET request to a URL using an HTTP Authorization header
    /// </summary>
    /// <param name="url">The URL</param>
    /// <param name="token">The token</param>
    /// <returns>String containing the results of the GET operation</returns>
    public async Task<string> GetHttpContentWithToken(string url)
    {
        var httpClient = new System.Net.Http.HttpClient();
        System.Net.Http.HttpResponseMessage response;
        try
        {
            var request = new System.Net.Http.HttpRequestMessage(System.Net.Http.HttpMethod.Get, url);
            //Add the token in Authorization header
            request.Headers.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            response = await httpClient.SendAsync(request);
            var content = await response.Content.ReadAsStringAsync();
            return content;
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
    }
}