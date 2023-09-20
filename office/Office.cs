using Azure.Identity;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web; // For HttpUtility
using Microsoft.Identity.Client;
using Azure.Core;
using office;
using Microsoft.Graph.Auth;
using Microsoft.Kiota.Abstractions;
using Microsoft.Graph.Beta.Models.Networkaccess; // For token caching
using Microsoft.Graph;
using Microsoft.Kiota.Abstractions.Authentication;
using Microsoft.Kiota.Authentication.Azure;
using Microsoft.Graph.Models;

public class Office
{
    private const string ClientId = "f787c732-7cef-47fc-902d-fd888c3be457";
    private const string TenantId = "c8cc3dc3-814b-48e7-a9b7-b0568a1b1019";
    private const string ClientSecret = "fm88Q~PHyS0ekWJir5XUnZf7i3AcA3WqTtbB6ah8";
    private const string RedirectUri = "http://localhost";

    private static readonly string[] scopes = new string[] { "user.read" };

    public static GraphServiceClient GraphClient { get; private set; }

    public static string AcquiredToken { get; private set; }

    private static IPublicClientApplication app;

    // Static GraphServiceClient
    public static GraphServiceClient? _client {  get; private set; }

    public Office()
    {
        app = PublicClientApplicationBuilder.Create(ClientId)
                  .WithRedirectUri(RedirectUri)
                  .WithAuthority(AzureCloudInstance.AzurePublic, TenantId)
                  .Build();

        // Enable token caching
        TokenCacheHelper.EnableSerialization(app.UserTokenCache);
    }

    public static GraphServiceClient get_client()
    {
        if (_client == null)
        {
            login().Wait();
        }
        return _client;
    }

   public EmailQuery emails()
    {
        return new EmailQuery(get_client());
    }

    public static async Task login()
    {
        IAccount firstAccount = (await app.GetAccountsAsync()).FirstOrDefault();

        AuthenticationResult authResult;

        try
        {
            // Try to get the token from the cache silently
            termo.show.start("SIGNING","INTO", "OFFICE 365");
            authResult = await app.AcquireTokenSilent(scopes, firstAccount).ExecuteAsync();
        }
        catch (MsalUiRequiredException)
        {
            // If silent retrieval fails, prompt the user to login
            termo.show.step("SILENT LOOGIN,","FAILED");
            termo.show.step("STARTING", "INTERACTIVE LOGIN");
            authResult = await app.AcquireTokenInteractive(scopes).ExecuteAsync();
            if (authResult != null)
            {
                termo.show.end_success("LOGGED IN", authResult.Account.Username);
            }
        }
        // Initialize GraphServiceClient using BearerTokenAuthenticationProvider
        var accessTokenProvider = new BaseBearerTokenAuthenticationProvider(new TokenProvider());
        _client = new GraphServiceClient(accessTokenProvider);

        AcquiredToken = authResult.AccessToken;
    }

    public async Task<User?> about_me()
    {
        var me = await _client?.Me.GetAsync();
        if (me != null)
        {
            termo.show.success("LOGGED IN AS", me.DisplayName.ToUpper(),  me.Mail);

        }
        return me;
    }
    

    
}

// TokenCacheHelper class to handle token caching
public static class TokenCacheHelper
{
    public static void EnableSerialization(ITokenCache tokenCache)
    {
        tokenCache.SetBeforeAccess(BeforeAccessNotification);
        tokenCache.SetAfterAccess(AfterAccessNotification);
    }

    private static void BeforeAccessNotification(TokenCacheNotificationArgs args)
    {
        // Load the cache from the persistent store
        args.TokenCache.DeserializeMsalV3(File.Exists(CacheFilePath) ? File.ReadAllBytes(CacheFilePath) : null);
    }

    private static void AfterAccessNotification(TokenCacheNotificationArgs args)
    {
        // Persist the cache to the persistent store
        if (args.HasStateChanged)
        {
            File.WriteAllBytes(CacheFilePath, args.TokenCache.SerializeMsalV3());
        }
    }

    private static readonly string CacheFilePath = System.Reflection.Assembly.GetExecutingAssembly().Location + ".msalcache.bin3";
}




public class EmailQuery
{
    private GraphServiceClient _graphClient;
    private string _subjectFilter;
    private string _sentToFilter;

    public EmailQuery(GraphServiceClient graphClient)
    {
        _graphClient = graphClient;
    }

    public EmailQuery where_subject(string subject)
    {
        _subjectFilter = subject;
        return this;
    }

    public EmailQuery sent_to(string recipient)
    {
        _sentToFilter = recipient;
        return this;
    }

    public async Task<IEnumerable<MailFolder>> find()
    {
        // Construct the OData filter based on the criteria
        var filters = new List<string>();
        if (!string.IsNullOrEmpty(_subjectFilter))
        {
            filters.Add($"contains(subject, '{_subjectFilter}')");
        }
        if (!string.IsNullOrEmpty(_sentToFilter))
        {
            filters.Add($"contains(toRecipients/emailAddress/address, '{_sentToFilter}')");
        }
        var filterQuery = string.Join(" and ", filters);

        // Execute the query
        var messages = await _graphClient.Me.MailFolders.GetAsync();
        return messages?.Value ?? new List<MailFolder>();
    }
}