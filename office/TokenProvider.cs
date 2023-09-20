using Microsoft.Kiota.Abstractions.Authentication;

public class TokenProvider : IAccessTokenProvider
{
    public Task<string> GetAuthorizationTokenAsync(Uri uri, Dictionary<string, object> additionalAuthenticationContext = default,
        CancellationToken cancellationToken = default)
    {
        // Return the actual acquired token
        return Task.FromResult(Office.AcquiredToken);
    }

    public AllowedHostsValidator AllowedHostsValidator { get; }
}