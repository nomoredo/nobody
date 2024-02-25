import 'package:dio/dio.dart';
import 'package:nobody/references.dart';
import 'package:oauth2_manager/oauth2_manager.dart';

// const APP_SECRET = "QKr8Q~ZvViURbcgL60Tqd3MsyMXKqBPACX4K4dAt";
const APP_ID = "69f1fa1f-6d33-4dd2-b49a-823bec62ae00";
const TENANT_ID = "d6f6af94-f516-4217-a014-f61ce26f86db";
// const scope = "api://376877d4-f7ea-4c45-bdc8-1c592ac38a9d/aims";
// const scope = "https://graph.microsoft.com/.default";
const scopes = [
  'Mail.ReadWrite',
  'Mail.Send',
];

const authorization_endpoint =
    'https://login.microsoftonline.com/d6f6af94-f516-4217-a014-f61ce26f86db/oauth2/v2.0/authorize';
const auth_token_endpoint =
    'https://login.microsoftonline.com/d6f6af94-f516-4217-a014-f61ce26f86db/oauth2/v2.0/token';
const redirect_url = 'https://localhost:44368';

const String authorizationSuccessHtml = '''
<!DOCTYPE html>
<html>
<head>
  <title>Authorization Success</title>
</head>
<body>
  <h1>Authorization Successful</h1>
  <p>You have successfully authorized the application.</p>
  <!-- You can add more content or elements here as needed -->
</body>
</html>
''';

// const scope_root = "https://graph.microsoft.com/";

// String get scope => scope_root + scopes.join(",");
String get scope => 'https://graph.microsoft.com/Mail.ReadWrite';

Future<GraphServiceClient> build_graph(String username) async {
  var _token = await get_token(username);
  if (_token == null) {
    throw Exception('no token');
  }
  var _client = build_client(_token);
  return GraphServiceClient(_token, _client);
}

Dio build_client(String token) {
  final client = Dio();
  client.options.headers['Authorization'] = 'Bearer $token'; // Added 'Bearer'
  return client;
}

Future<void> launch(String url) async {
  Show.action("OPENING", "BROWSER", "FOR", "AUTHENTICATION");
  if (Platform.isWindows) {
    await Process.run("start", [url], runInShell: true);
  } else if (Platform.isMacOS) {
    await Process.run('open', [url]);
  } else if (Platform.isLinux) {
    await Process.run('xdg-open', [url]);
  }
}

Future<String?> get_token(String username, {retry_count = 0}) async {
  // use authorization code flow (native app) to get token
  //try to get token from database
  if (retry_count > 3) {
    throw Exception('too many retries');
  }
  var token_from_store = await tokenStore.get("token_$username");
  var token_validity = await dateStore.get("token_validity_$username");
  if (token_from_store != null &&
      token_validity != null &&
      DateTime.now().isBefore(token_validity)) {
    Show.success("USING TOKEN", "FROM STORE");
    return token_from_store;
  }
  try {
    final microsoftConfiguration = OAuth2Configuration(
      authorizationEndpoint: authorization_endpoint,
      tokenEndpoint: auth_token_endpoint,
      clientID: APP_ID,
      scopes: scopes,
    );
    final credentials = await OAuth2.login(
      microsoftConfiguration,
      redirect: (u) async {
        final string_url = auth_token_endpoint;
      },
      redirectPage: authorizationSuccessHtml,
    );
    var token = credentials.accessToken;
    var validity = await get_token_validity(token);
    await tokenStore.set("token_$username", token);
    await dateStore.set("token_validity_$username", validity);
    return token;
  } catch (e) {
    print(e);
    return await get_token(username, retry_count: retry_count + 1);
  }
}

Future<String> get_token_from_code(String code) async {
  var client = Dio();
  var response = await client.post(
    auth_token_endpoint,
    data: {
      'client_id': APP_ID,
      'scope': scope,
      'code': code,
      'redirect_uri': redirect_url,
      'grant_type': 'authorization_code',
      // 'client_secret': APP_SECRET,
    },
  );
  var token = response.data['access_token'];
  return token;
}

Future<DateTime> get_token_validity(String token) async {
  var client = Dio();
  var response = await client.get(
    'https://graph.microsoft.com/v1.0/me',
    options: Options(headers: {'Authorization': 'Bearer $token'}),
  );
  var validity = DateTime.now().add(Duration(seconds: 3599));
  return validity;
}
